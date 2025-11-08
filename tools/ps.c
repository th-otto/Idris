#include <std.h>
#include <wslxa.h>
#include <stdio.h>
#include <stddef.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/res.h>
#include <sys/fio.h>
#include <sys/cpu.h>
#include <pwd.h>
#include <sys/wait.h>
#include <sys/utsname.h>

#ifndef FALSE
#define FALSE 0
#define TRUE 1
#endif

#ifdef __GNUC__
/* for compile tests only */
#define putfmt printf
#define alloc(s, l) malloc(s)
#define _remark(s1, s2) fprintf(stderr, "%s%s\n", s1, s2)
#define getpw(str, match, want) getpwuid(uid)->pw_name
#define _cpybuf(d, s, n) memcpy(d, s, n)
#define instr(s, p) strlen(s)
#endif

static BOOL aflag; /* print out all processes. */
static BOOL fflag; /* print username and free memory */
static BOOL iflag; /* print out the inode list. */
static BOOL lflag; /* give the long form printout. */
static BOOL pflag; /* print out your processes only. */
static BOOL rflag; /* print out running processes only. */
static unsigned int slp;   /* sleep # seconds between print outs. */
static BOOL tflag; /* print out shared processes only */

static const char tinode[] = "/dev/inode";
static const char tmyps[] = "/dev/myps";
static const char tps[] = "/dev/ps";


#ifndef dmajor
#define dmajor(dev) ((unsigned short) (dev) >> 8)
#define dminor(dev) ((dev) & 0xff)
#endif
#define _lsize(pi) (((unsigned long)(pi)->i_size0 << 16) | ((pi)->i_size1))

#define SIZEOF_PROC_312     68
#define SIZEOF_PROC_CURRENT 70

struct proc_has_wrong_size { unsigned int dummy: sizeof(struct proc) == SIZEOF_PROC_CURRENT ? 1 : -1; };
static size_t sizeof_proc;


static char *readfill(BYTES *psize, const char *filename, int fd)
{
	char *buf;
	BYTES size;
	long nread;

	if (filename != NULL && (fd = open(filename, O_RDONLY, 0)) < 0)
	{
		_remark("can't open: ", filename);
		return NULL;
	}
	size = 512;
	for (;;)
	{
		buf = alloc(size, NULL);
		/* BUG: no allocate check */
		if ((nread = read(fd, buf, size)) < 0)
		{
			_remark("device err ", filename);
			free(buf);
			nread = 0;
			buf = NULL;
			goto error;
		} else
		{
			lseek(fd, 0, SEEK_SET);
			if ((BYTES)nread < size)
			{
			error:
				*psize = nread;
				if (filename != NULL)
					close(fd);
				break;
			}
		}
		free(buf);
		size += 512;
	}
	return buf;
}


BOOL devname(char *s, register UCOUNT mdev, register BOOL cspec)
{
	register BYTES size;
	register unsigned int major_num;
	register unsigned int minor_num;
	const char *filename = cspec ? "/dev/cnames" : "/dev/bnames";
	char *buf;

	static BYTES cnames_size;
	static BYTES bnames_size;
	static char *cnames_buf;
	static char *bnames_buf;

	if (cspec)
	{
		buf = cnames_buf ? cnames_buf : (cnames_buf = readfill(&cnames_size, filename, 0));
		size = cnames_size;
	} else
	{
		buf = bnames_buf ? bnames_buf : (bnames_buf = readfill(&bnames_size, filename, 0));
		size = bnames_size;
	}
	*s = '\0';
	if (buf == NULL)
		return FALSE;
	major_num = 0;
	minor_num = 0;
	for (;;)
	{
		if (size == 0)
			return FALSE;
		if (dmajor(mdev) == major_num && dminor(mdev) == minor_num)
		{
			while (size != 0 && *buf != '\n' && *buf != ' ')
			{
				*s++ = *buf++;
				size--;
			}
			*s = '\0';
			return TRUE;
		} else
		{
			if (*buf == '\n')
			{
				major_num++;
				minor_num = 0;
			} else
			{
				if (*buf == ' ')
					minor_num++;
			}
			size--;
			buf++;
		}
	}
}


static const char *usernm(uid_t uid)
{
	static char buf[20];
	char *name;
	BYTES n;

	buf[decode(buf, sizeof(buf) - 1, "%i", uid)] = '\0';
	if ((name = getpw(buf, 2, 0)) != NULL)
	{
		n = instr(name, ":\n");
		if (n > sizeof(buf) - 1)
			n = n > sizeof(buf) - 1;
		_cpybuf(buf, name, n);
		buf[n] = '\0';
	}
	return buf;
}


static const char *sigstr(int sig)
{
	static char buf[20];

	switch (sig)
	{
	case SIGHUP:
		return "hangup";
	case SIGINT:
		return "interrupt";
	case SIGQUIT:
		return "quit";
	case SIGILL:
		return "illegal instruction";
	case SIGTRAP:
		return "trace trap";
	case SIGRNG:
		return "range error";
	case SIGDOM:
		return "domain error";
	case SIGFPE:
		return "floating point/ arithmetic fault";
	case SIGKILL:
		return "kill";
	case SIGBUS:
		return "bus error";
	case SIGSEGV:
		return "segmentation (bad address) error";
	case SIGSYS:
		return "bad system call";
	case SIGPIPE:
		return "broken pipe";
	case SIGALRM:
		return "alarm";
	case SIGTERM:
		return "terminate";
	case SIGSVC:
		return "system call intercept";
	case SIGUSR2:
		return "user signal";
	}
	buf[decode(buf, sizeof(buf) - 1, "signal#%i", sig)] = '\0';
	return buf;
}


static void pinode(const char *filename)
{
	struct inode *p;
	char *buf;
	BYTES size;
	short i;
	char device_name[NAME_MAX + 1];

	putfmt("inodes:\n");
	buf = readfill(&size, filename, 0);
	if (buf == NULL)
		return;
	putfmt("FLG REF LAST  DEV    INUM   MODE  LNK   SIZE ADDRS\n");
	p = (struct inode *)buf;
	while ((char *)p < &buf[size])
	{
		devname(device_name, p->i_dev, FALSE);
		if (device_name[0] == '\0')
		{
			device_name[decode(device_name, sizeof(device_name) - 1, "%3i/%3i", dmajor(p->i_dev), dminor(p->i_dev))] = '\0';
		}
		putfmt("%+03o %3i %4s %- 7p %4i", p->i_flag, p->i_refs, p->i_blast, device_name, p->i_ino);
		putfmt(" %+07o %3i %6l", p->i_mode, p->i_nlink, _lsize(p));
		for (i = 0; i < 8 && p->i_addr[i] != 0; i++)
		{
			putfmt(" %5i", p->i_addr[i]);
		}
		putfmt("\n");
		if (p->next == NULL)
			break;
		p++;
	}
	free(buf);
}


static const char *pnm(register const char *name)
{
	static char buf[MAXPN + 1];
	char *dst;

	dst = buf;
	while (dst < &buf[MAXPN])
		*dst++ = *name++;
	*dst = '\0';
	return buf;
}


static void pps(const char *filename, BOOL not_all)
{
	struct proc *p;
	register char *buf;
	register struct zlist *zombies;
	BYTES size;
	short i;
	struct proc procbuf;
	char flagbuf[8 + 1];
	char device_name[25];

	static const char *stat_names[8] = {
		"?  ",
		"doze",
		"exec",
		"run ",
		"wait",
		"shr ",
		"exit",
		"7   "  /* MOVED */
	};

	buf = readfill(&size, filename, 0);
	if (buf == NULL)
		return;
	putfmt(!lflag ? "  PID  PPID STAT NAME\n" : "  PID  PPID STAT NAME      PRI   NI  BASE WBASE  SIZE   FLAGS   CHANNEL DEV\n");
	p = (struct proc *)buf;
	while ((char *)p < &buf[size])
	{
		if (sizeof_proc == SIZEOF_PROC_312)
		{
			/*
			 * adjust for new field p_wbase in 3.14
			 */
			_cpybuf(&procbuf, p, offsetof(struct proc, p_wbase));
			_cpybuf(&procbuf.p_size, &p->p_wbase, SIZEOF_PROC_312 - offsetof(struct proc, p_size));
			procbuf.p_wbase = procbuf.p_base;
		} else
		{
			_cpybuf(&procbuf, p, sizeof(procbuf));
		}
		for (i = 0; i < 8; i++)
		{
			/*
			 * depends on flags defined in cpu.h
			 */
			flagbuf[i] = procbuf.p_flag & (0x80 >> i) ? "WIOALMFX"[i] : ' ';
		}
		flagbuf[8] = '\0';
		if (tflag && procbuf.p_stat == SHARING)
		{
			if (flagbuf[6] == 'F') /* fork -> shared text */
				flagbuf[6] = 'S';
			devname(device_name, procbuf.v.t.idev, FALSE);
			if (device_name[0] == '\0')
			{
				device_name[decode(device_name, sizeof(device_name) - 1, "%3i/%3i", dmajor(procbuf.v.t.idev), dminor(procbuf.v.t.idev))] = '\0';
			}
			putfmt(!lflag ? "%5us %5x %4p %- np\n" :
				            "%5us %5x %4p %- np %4x %4x %5u %5u %5u %- 8p %8x %p\n",
				procbuf.p_pid,
				stat_names[procbuf.p_stat & 7],
				MAXPN, pnm(procbuf.p_name),
				procbuf.p_base,
				procbuf.p_wbase,
				procbuf.p_size,
				flagbuf,
				device_name);
		} else if (!not_all && procbuf.p_stat != SHARING && (!rflag || procbuf.p_stat == RUNNING))
		{
			if (procbuf.p_typ == 0)
				strcpy(device_name, "none");
			else
				devname(device_name, procbuf.p_typ, TRUE);
			if (device_name[0] == '\0')
			{
				device_name[decode(device_name, sizeof(device_name) - 1, "%3i/%3i", dmajor(procbuf.p_typ), dminor(procbuf.p_typ))] = '\0';
			}
			/*   PID  PPID STAT NAME      PRI   NI  BASE WBASE  SIZE   FLAGS   CHANNEL DEV */
			putfmt(!lflag ? "%5us %5us %4p %- np\n" :
			                "%5us %5us %4p %- np %4c %4c %5us %5us %5us %- 8p %8h %p\n",
				procbuf.p_pid,
				procbuf.v.p.ppid,
				stat_names[procbuf.p_stat & 7],
				MAXPN, pnm(procbuf.p_name),
				procbuf.p_pri,
				procbuf.p_bias,
				procbuf.p_base,
				procbuf.p_wbase,
				procbuf.p_size,
				flagbuf,
				procbuf.p_chan,
				device_name);
			if (fflag)
			{
				putfmt("        user=%p ", usernm(procbuf.v.p.ruid));
				putfmt(" pgroup=%i", procbuf.p_pgrp);
				putfmt(" free=%i", procbuf.v.p.freeheap);
				if (procbuf.v.p.slice != 0)
					putfmt(" slice=%i", procbuf.v.p.slice);
				if (procbuf.v.p.sig != 0)
					putfmt(" sig=%p", sigstr(procbuf.v.p.sig));
				if (procbuf.v.p.alarm != 0)
					putfmt(" alarm=%i", procbuf.v.p.alarm);
				putfmt("\n");
			}
		}

		zombies = procbuf.p_stat != SHARING && procbuf.v.p.zlist ? (struct zlist *)((char *)p + sizeof_proc) : NULL;
		while (zombies != NULL)
		{
			if (!rflag && !not_all)
			{
				putfmt("        zombie %i %- np", zombies->z_pid, MAXPN, pnm(zombies->z_name));
				putfmt(" free=%i", zombies->z_freeheap);
				if (!WIFSIGNALED(zombies->z_stat))
				{
					putfmt(" exit status %i %p", WEXITSTATUS(zombies->z_stat), zombies->z_stat != 0 ? "(failure)" : "(success)");
				} else
				{
					putfmt(" signal %p%p", sigstr(WTERMSIG(zombies->z_stat)), WCOREDUMP(zombies->z_stat) ? " -- core dumped" : "");
				}
				putfmt("\n");
			}
			if (zombies->next == NULL)
				break;
			zombies++;
		}

		if (procbuf.next == NULL)
			break;
		if (zombies != NULL)
			p = (struct proc *)(zombies + 1);
		else
			p = (struct proc *)((char *)p + sizeof_proc);
	}

	free(buf);
}


static void get_procsize(void)
{
	struct utsname u;
	int release;
	char *p;

	if (uname(&u) == 0)
	{
		release = atoi(u.release);
		release *= 100;
		p = strchr(u.release, '.');
		if (p != NULL)
			release += atoi(p + 1);
		if (release < 314)
		{
			sizeof_proc = SIZEOF_PROC_312;
		} else
		{
			sizeof_proc = SIZEOF_PROC_CURRENT;
		}
	} else
	{
		sizeof_proc = sizeof(struct proc);
	}
}


int main(int argc, char **argv)
{
	getflags((unsigned int *)&argc, &argv,
		"a,f,i,l,p,r,s#,t:F",
		&aflag,
		&fflag,
		&iflag,
		&lflag,
		&pflag,
		&rflag,
		&slp,
		&tflag);

	if (!pflag && (aflag + iflag + tflag) == 0)
		pflag = TRUE;

	if (argc != 0)
		usage("-[a f i l p r s# t]\n");

	get_procsize();

	for (;;)
	{
		if (aflag || tflag)
			pps(tps, !aflag);
		if (pflag)
			pps(tmyps, FALSE);
		if (iflag)
			pinode(tinode);
		if (slp == 0)
			return 0;
		sleep(slp);
		putfmt("\n");
	}
}



#ifdef __GNUC__
/* for compile tests only */
TEXT *getflags(BYTES *pac, TEXT ***pav, const char *fmt, ...)
{
	(void)pac;
	(void)pav;
	(void)fmt;
	return 0;
}

const char *_pname = "a.out";

COUNT usage(const char *msg)
{
	fputs("usage :", stderr);
	fputs(_pname, stderr);
	fputs(" ", stderr);
	if (msg)
		fputs(msg, stderr);
	if (msg != NULL && msg[strlen(msg) - 1] == '\n')
		exit(1);
	return strlen(_pname) + 8;
}


BYTES decode(char *s, size_t n, const char *fmt, ...)
{
	va_list args;

	va_start(args, fmt);
	n = sprintf(s, fmt, args);
	va_end(args);
	return n;
}

#endif

#include <std.h>
#include <wslxa.h>
#include <stdio.h>
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

#undef IDRIS_VERSION
#define IDRIS_VERSION 314

#ifndef FALSE
#define FALSE 0
#define TRUE 1
#endif

#ifdef __GNUC__
#define putfmt printf
#define alloc(s, l) malloc(s)
#define remark(s1, s2) fprintf(stderr, "%s%s\n", s1, s2)
#define cpystr(d, s, sentinel) strcpy(d, s)
#define getpw(str, match, want) getpwuid(uid)->pw_name
#define cpybuf(d, s, n) memcpy(d, s, n)
#define instr(s, p) strlen(s)
#endif

/*
 * forward declarations
 */
static const char *sigstr(int sig);
static char *readfill(BYTES *size, const char *filename, int fd);
static void pps(const char *filename, BOOL not_all);
static void pinode(const char *filename);
static const char *usernm __((uid_t uid));


static BOOL aflag; /* print out all processes. */
static BOOL fflag; /* print username and free memory */
static BOOL iflag; /* print out the inode list. */
static BOOL lflag; /* give the long form printout. */
static BOOL pflag; /* print out your processes only. */
static BOOL rflag; /* print out running processes only. */
static unsigned int slp;   /* sleep # seconds between print outs. */
static BOOL tflag; /* print out shared processes only */


static const char *tinode = "/dev/inode";
const char *tmount = "/dev/mount"; /* no longer handled here */
static const char *tmyps = "/dev/myps";
static const char *tps = "/dev/ps";


#ifndef dmajor
#define dmajor(dev) ((unsigned short) (dev) >> 8)
#define dminor(dev) ((dev) & 0xff)
#endif
#define _lsize(pi) (((unsigned long)(pi)->i_size0 << 16) | ((pi)->i_size1))

/*	the process control structure
 */
struct proc_312 {
	/*   0 */ struct proc *next;
	/*   4 */ char *p_chan;
	/*   8 */ BLOCK p_base;
	/*  10 */ BLOCK p_size;
	/*  12 */ BLOCK p_addr;
	/*  14 */ BLOCK p_tsize;
	/*  16 */ UTINY p_flag;
	/*  17 */ UTINY p_stat;
	/*  18 */ TINY p_pri;
	/*  19 */ TINY p_bias;
	/*  20 */ TEXT p_name[MAXPN];
	/*  28 */ PID p_pid;
	/*  30 */ PID p_pgrp;
	/*  32 */ DEV p_typ;
	/*  34 */ union {
		struct {
			/*  34 */ struct proc *textp;
			/*  38 */ ZLIST *zlist;
			/*  42 */ struct proc *nextrun;
			/*  46 */ struct proc *nextwake;
			/*  50 */ BYTES alarm;
			/*  54 */ BYTES freeheap;
			/*  58 */ ULONG sigf;
			/*  62 */ PID ppid;
			/*  64 */ UID ruid;
			/*  65 */ UTINY slice;
			/*  66 */ UTINY sig;
		} p;
		struct {
			/*  34 */ DEV idev;
			/*  36 */ INUM inum;
			/*  38 */ ULONG uptime;
			/*  42 */ COUNT refs;
			/*  44 */ COUNT coreref;
			/*  46 */ ULONG rboff;
		} t;
	} v;
	/*  68 */
};

struct proc_has_wrong_size { unsigned int dummy: sizeof(struct proc) == 70 ? 1 : -1; };
struct proc_312_has_wrong_size { unsigned int dummy: sizeof(struct proc_312) == 68 ? 1 : -1; };


static BOOL devname(char *s, register UCOUNT mdev, register BOOL cspec)
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

	for (;;)
	{
		if (aflag || tflag)
			pps(tps, !aflag);
		if (pflag)
			pps(tmyps, FALSE);
		if (iflag)
			pinode(tinode);
		if (slp == 0)
			return 1; /* FIXME */
		sleep(slp);
		putfmt("\n");
	}
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
	putfmt("FLG REF LAST  DEV   INUM    MODE  LNK  SIZE ADDRS\n");
	p = (struct inode *)buf;
	while ((char *)p < &buf[size])
	{
		devname(device_name, p->i_dev, FALSE);
#if IDRIS_VERSION >= 314
		if (device_name[0] == '\0')
		{
			sprintf(device_name, "%2d/%2d", dmajor(p->i_dev), dminor(p->i_dev));
		}
#endif
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
	char *buf;
	struct zlist *zombies;
	BYTES size;
	short i;
	static char flagbuf[8 + 1];
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
#if IDRIS_VERSION >= 314
	/* BUG: header is wrong for tflag */
	putfmt(!lflag ? "  PID  PPID STAT NAME    \n" : "  PID  PPID STAT NAME      PRI   NI  BASE WBASE  SIZE   FLAGS   CHANNEL DEV\n");
#else
	if (lflag)
		putfmt("  PID STAT NAME     PRI  PPID  PGRP  BASE  SIZE  FLAGS    CHANNEL DEV\n");
#endif
	p = (struct proc *)buf;
	while ((char *)p < &buf[size])
	{
		for (i = 0; i < 8; i++)
		{
			/*
			 * depends on flags defined in cpu.h
			 */
			flagbuf[i] = p->p_flag & (0x80 >> i) ? "WIOALMFX"[i] : ' ';
		}
		if (tflag && p->p_stat == SHARING)
		{
			if (flagbuf[6] == 'F') /* fork -> shared text */
				flagbuf[6] = 'S'; 
#if IDRIS_VERSION >= 314
			devname(device_name, p->v.t.idev, FALSE);
			if (device_name[0] == '\0')
			{
				sprintf(device_name, "%2d/%2d", dmajor(p->v.t.idev), dminor(p->v.t.idev));
			}
			putfmt(!lflag ? "%5us %5x %4p %- np\n" :
				            "%5us %5x %4p %- np %4x %4x %5u %5u %5u %- 8p %8x %p\n",
				p->p_pid,
				stat_names[p->p_stat & 7],
				MAXPN, pnm(p->p_name),
				p->p_base,
				p->p_wbase,
				p->p_size,
				flagbuf,
				device_name);
#else
			putfmt(lflag ? "%5us %p %- 25p%5us %5us %8b\n" :
				           "%5us %p %p\n",
				p->p_pid,
				stat_names[p->p_stat],
				pnm(p->p_name),
				p->p_base,
				p->p_size,
				flagbuf, 8);
#endif
		} else if (!not_all && p->p_stat != SHARING && (!rflag || p->p_stat == RUNNING))
		{
			if (p->p_typ == 0)
				cpystr(device_name, "none", NULL);
			else
				devname(device_name, p->p_typ, TRUE);
#if IDRIS_VERSION >= 314
			if (device_name[0] == '\0')
			{
				sprintf(device_name, "%2d/%2d", dmajor(p->p_typ), dminor(p->p_typ));
			}
#endif
			/*   PID  PPID STAT NAME      PRI   NI  BASE WBASE  SIZE   FLAGS   CHANNEL DEV */
			putfmt(!lflag ? "%5us %5us %4p %- np\n" :
			                "%5us %5us %4p %- np %4c %4c %5us %5us %5us %- 8p %8h %p\n",
				p->p_pid,
				p->v.p.ppid,
				stat_names[p->p_stat & 7],
				MAXPN, pnm(p->p_name),
				p->p_pri,
				p->p_bias,
				p->p_base,
				p->p_wbase,
				p->p_size,
				flagbuf,
				p->p_chan,
				device_name);
			if (fflag)
			{
				putfmt("        user=%p ", usernm(p->v.p.ruid));
				putfmt(" pgroup=%i", p->p_pgrp);
				putfmt(" free=%i", p->v.p.freeheap);
				if (p->v.p.slice != 0)
					putfmt(" slice=%i", p->v.p.slice);
				if (p->v.p.sig != 0)
					putfmt(" sig=%p", sigstr(p->v.p.sig));
				if (p->v.p.alarm != 0)
					putfmt(" alarm=%i", p->v.p.alarm);
				putfmt("\n");
			}
		}

		zombies = p->p_stat != SHARING && p->v.p.zlist ? (struct zlist *)(p + 1) : NULL;
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

		if (p->next == NULL)
			break;
		if (zombies != NULL)
			p = (struct proc *)(zombies + 1);
		else
			p++;
	}
	
	free(buf);
}


static char *readfill(BYTES *psize, const char *filename, int fd)
{
	char *buf;
	BYTES size;
	long nread;
	
	if (filename != NULL && (fd = open(filename, O_RDONLY, 0)) < 0)
	{
		remark("can't open: ", filename);
		return NULL;
	}
	size = 512;
	for (;;)
	{
		buf = alloc(size, NULL);
		/* BUG: no allocate check */
		if ((nread = read(fd, buf, size)) < 0)
		{
			remark("device err ", filename);
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
		return "floating point/ aritmetic fault"; /* FIXME: typo */
	case SIGKILL:
		return "kill";
	case SIGBUS:
		return "bus error";
	case SIGSEGV:
		return "segementation (bad address) error"; /* FIXME: typo */
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
	default:
		buf[decode(buf, sizeof(buf) - 1, "signal#%i", sig)] = '\0';
		return buf;
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
		cpybuf(buf, name, n > sizeof(buf) - 1 ? sizeof(buf) - 1 : n);
		buf[n] = '\0';
	}
	return buf;
}


#ifdef __GNUC__
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

/*	LIBRARY MAINTENANCE
 *	copyright (c) 1981 by Whitesmiths, Ltd.
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include "util.h"

#define MAGICW	0xff75
#define MAGIC6	0xff6d
#define MAGIC7	0xff65
#define MAGSIZE	2
#define MZERO -1L
#define MEMPTY 65535
#define NSIZE	14
#define N6SIZE	8
#define NOSIZE	0
#define FOUND 	1						/* module found in library */
#define STRPNM	2						/* strip path from module */

#define HDR union hdr
union hdr
{
	struct
	{
		char name[NSIZE];
		unsigned char wsize[2];
	} w;
	struct
	{
		char name6[N6SIZE];
		unsigned char pad6[6];
		unsigned char v6size[2];
	} v6;
	struct
	{
		char name[NSIZE];
		unsigned char pad8[8];
		unsigned char v7size[4];
	} v7;
};

/*	flags:
	-c		create (force virgin file)
	-d		delete named files
	-i		get files from STDIN
	-p		print (extract to STDOUT)
	-r		replace named files
	-t		list files in library
	-v3		use UNIX System III format with -cr
	-v6		use UNIX v6 format with -cr
	-v7		use UNIX v7 format with -cr
	-v		be verbose about it
	-x		extract named (or all) files
 */
static BOOL cfl = FALSE;
static BOOL dfl = FALSE;
static BOOL ifl = FALSE;
static BOOL pfl = FALSE;
static BOOL rfl = FALSE;
static BOOL tfl = FALSE;
static BOOL vfl = FALSE;
static BOOL v3fl = FALSE;
static BOOL v6fl = FALSE;
static BOOL v7fl = FALSE;
static BOOL xfl = FALSE;

/*	configuration info
 */
static size_t vers = 0;
static int hsize = 16;						/* size of library header */
static int nsize = NSIZE;
static int fround = 0;						/* 1 if file sizes are rounded up */
static uint16_t magic = 0;					/* magic header number */

/*	misc
 */
static long msize = 0;						/* size of module now under consideration */
static char *pfound = NULL;
const char *_pname = "lib";


/*
 * copy [part of] a file
 */
static long copy(FILE *ffd, FILE *tfd, long size)
{
	int i, j;
	long n;
	char buf[BUFSIZ];

	i = BUFSIZ;
	for (n = 0; !size || n < size; n += j)
	{
		if (size)
			i = min(size - n, BUFSIZ);
		if ((j = fread(buf, 1, i, ffd)) == 0 && size)
			_error("unexpected EOF", NULL);
		else if (j == 0)
			break;
		else
			fwrite(buf, 1, j, tfd);
	}
	if (!size && (n & fround))
		fwrite("", 1, 1, tfd);
	return n;
}


/*
 * print error msg for files not found in the av list,
 * and free error map
 */
static BOOL erprint(size_t ac, char **av, const char *s)
{
	BOOL ok;
	char *p;

	ok = TRUE;
	for (p = pfound; ac--; ++av, ++p)
		if (!(*p & FOUND))
			ok = _remark(s, *av);
	free(pfound);
	pfound = NULL;
	return ok;
}


/*
 * (re)set version and configuration info
 */
static void setvers(void)
{
	if (!magic)
		magic = (vers == 6) ? MAGIC6 : (vers == 3 || vers == 7) ? MAGIC7 : MAGICW;
	switch (magic)
	{
	case MAGICW:
		hsize = 16;
		nsize = NSIZE;
		fround = 0;
		vers = 0;
		break;
	case MAGIC6:
		hsize = 16;
		nsize = N6SIZE;
		fround = 1;
		vers = 6;
		break;
	case MAGIC7:
		hsize = 26;
		nsize = NSIZE;
		fround = 1;
		if (vers != 3 && vers != 7)
			vers = 7;
		break;
	default:
		_error("bad library header", NULL);
		break;
	}
}


/*
 * open a library file
 */
static FILE *lopen(const char *file, BOOL mand)
{
	FILE *fp;

	if ((fp = fopen(file, "rb")) == NULL)
	{
		if (mand)
			_error("can't open library ", file);
	} else if (fread(&magic, MAGSIZE, 1, fp) != 1)
	{
		_error("can't read header for ", file);
	} else
	{
		magic = lstoi(&magic);
	}
	setvers();
	return fp;
}


/*
 * create a unique file name
 */
static char *uniqnm(void)
{
	int i, pid;
	static char name[] = "/tmp/tpppp";

	if (name[6] == 'p')
		for (pid = getpid(), i = 11; 6 <= --i; pid >>= 3)
			name[i] = (pid & 07) + '0';
	return name;
}


/*
 * create a library file
 */
static FILE *lcreate(const char *file)
{
	FILE *fp;
	uint8_t tmagic[MAGSIZE];

	itols(tmagic, magic);
	if (!file)
	{
		file = uniqnm();
	}
	if ((fp = fopen(file, "wb")) == NULL)
	{
		_error("can't create ", file);
	} else
	{
		fwrite(tmagic, MAGSIZE, 1, fp);
	}
	return fp;
}


/*
 * mark ith module in av list as found in the library
 */
static void found(int i)
{
	if (i >= 0)
		pfound[i] |= FOUND;
}


/*
 * get entry header
 */
static BOOL gthdr(FILE *fp, HDR *phdr)
{
	int i;
	uint16_t wo;

	if (fp == NULL || fread(phdr, hsize, 1, fp) != 1 || !phdr->w.name[0])
		return FALSE;
	else
	{
		switch (vers)
		{
		case 0:
			wo = lstou(phdr->w.wsize);
			msize = wo;
			break;
		case 3:
			for (i = 4, msize = 0; 0 <= --i;)
				msize = (msize << 8) + phdr->v7.v7size[i];
			break;
		case 6:
			wo = lstou(phdr->v6.v6size);
			msize = wo;
			break;
		case 7:
			msize = lstol(phdr->v7.v7size);
			break;
		}
		phdr->w.name[nsize] = '\0';
		return TRUE;
	}
}


/*
 * put header
 */
static void pthdr(FILE *fp, HDR *phdr)
{
	int i;
	long lo;
	uint16_t wo;

	for (i = 0; i < NSIZE && phdr->w.name[i]; ++i)
		;
	while (i < NSIZE + 8)
		phdr->w.name[i++] = '\0';
	switch (vers)
	{
	case 0:
		itols(phdr->w.wsize, wo = (uint16_t) msize);
		break;
	case 3:
		for (lo = msize, i = 0; i < 4; ++i)
		{
			phdr->v7.v7size[i] = lo;
			lo >>= 8;
		}
		break;
	case 6:
		itols(phdr->v6.v6size, wo = (uint16_t) msize);
		break;
	case 7:
		ltols(phdr->v7.v7size, msize);
		break;
	}
	fwrite(phdr, hsize, 1, fp);
}


/*
 * write 2 bytes of padding at EOF
 */
static void wreof(FILE *fp)
{
	fwrite("\0", 2, 1, fp);
}


/*
 * put back library file
 */
static void putback(const char *to, long *sx, long ns)
{
	FILE *lfd;
	FILE *tfd;
	HDR hdr;

	tfd = lopen(uniqnm(), TRUE);
	lfd = lcreate(to);
	while (gthdr(tfd, &hdr))
	{
		if (msize == MEMPTY)
			msize = 0L;
		else if (0 < msize)
			;
		else if (0 <= --ns)
			msize = *sx++;
		else
			_error("Panic putback!", NULL);
		pthdr(lfd, &hdr);
		if (msize)
			copy(tfd, lfd, msize + (msize & fround));
	}
	wreof(lfd);
	fclose(lfd);
	fclose(tfd);
}


static char *pathnm(char *buf, const char *n1, const char *n2)
{
	const char *end;

	end = strrchr(n1, '/');
	if (end != NULL)
		end++;
	else
		end = n1;
	return strcat(strcat(strcpy(buf, n2), "/"), end);
}


/*
 * strip a pathname prefix
 */
static char *strpath(char *buf, char *name)
{
	char *pn = buf;

	pn = pathnm(buf, name, ":");
#ifdef IDRIS
	pn += 2;
#else
	++pn;
#endif
	return pn;
}


/*
 * return position of arg in av list
 */
static int inpos(int ac, char **av, const char *name)
{
	static char buf[NSIZE];
	int i;
	BOOL strip;
	char *pn = 0;

	for (i = 0; i < ac; ++i, ++av)
	{
		if ((strip = pfound[i]) & STRPNM)
			pn = strpath(buf, *av);
		if (strcmp(strip ? pn : *av, name) == 0)
			return i;
	}
	return -1;
}


/*
 * print non-fatal report
 */
static void report(const char *s1, const char *s2)
{
	if (s1)
		fputs(s1, stdout);
	if (s2)
		fputs(s2, stdout);
	fputs("\n", stdout);
}



/*
 * skip bytes in a file
 */
static void skip(FILE *fd, long size, BOOL rnd)
{
	if (size)
		fseek(fd, size + (size & rnd), SEEK_CUR);
}


/*
 * delete files from library
 */
static BOOL del(int ac, char **av, const char *file, BOOL special)
{
	int j;
	FILE *lfd;
	FILE *tfd;
	HDR hdr;
	int ret;
	
	(void)special;
	if (!ac)
		_error("no delete files", NULL);
	lfd = lopen(file, TRUE);
	tfd = lcreate(NULL);
	while (gthdr(lfd, &hdr))
	{
		if ((j = inpos(ac, av, hdr.w.name)) < 0)
		{
			if (vfl)
				report("c ", hdr.w.name);
			if (msize == 0)
				msize = MZERO;
			pthdr(tfd, &hdr);
			if (msize != MZERO)
				copy(lfd, tfd, msize + (msize & fround));
		} else
		{
			if (vfl)
				report("d ", strpath(hdr.w.name, av[j]));
			found(j);
			if (msize != MZERO)
				skip(lfd, msize, fround);
		}
	}
	fclose(lfd);
	fclose(tfd);
	if (erprint(ac, av, "lib: can't delete "))
	{
		putback(file, NULL, 0);
		ret = TRUE;
	} else
	{
		ret = FALSE;
	}
	unlink(uniqnm());
	return ret;
}


/*
 * set up for error map
 */
static void ersetup(size_t ac)
{
	char *p;

	if (!ac)
		ac = 1;
	pfound = xmalloc(ac * sizeof(*pfound));
	for (p = pfound; ac--; ++p)
		*p = 0;
}


/*
 * test if in arg list
 */
static char *inlist(size_t ac, char **av, const char *name)
{
	int j;

	if ((j = inpos(ac, av, name)) < 0)
		return NULL;
	else
		return av[j];
}


/*
 * mark ith module in av list as having a pathname to strip
 */
static void markpth(int ac, char **av)
{
	int i;
	char *x;
	char *pn;
	char *s;

	for (i = 0; i < ac; ++i)
	{
		if (*(s = av[i]))
		{
			for (pn = s; (x = strpbrk(pn, ":]/")) != NULL; pn = x + 1)
				;
			if (pn != s)
				pfound[i] |= STRPNM;
		}
	}
}


/*
 * replace files in library
 */
static BOOL repl(int ac, char **av, const char *file, BOOL virgin)
{
	int i, j;
	char *s;
	FILE *ifd;
	FILE *lfd;
	FILE *tfd;
	HDR hdr;
	long *svec;
	long *sx;
	char *pn;
	int ret;

	if (!ac)
		_error("no replacement files", NULL);
	if (virgin)
	{
		setvers();
		lfd = NULL;
	} else
	{
		lfd = lopen(file, FALSE);
	}
	tfd = lcreate(NULL);
	svec = xmalloc(ac * sizeof(*svec));
	for (sx = svec; gthdr(lfd, &hdr);)
	{
		if ((j = inpos(ac, av, hdr.w.name)) < 0)
		{
			if (vfl)
				report("c ", hdr.w.name);
			if (msize == 0)
				msize = MZERO;
			pthdr(tfd, &hdr);
			if (msize != MZERO)
				copy(lfd, tfd, msize + (msize & fround));
		} else
		{
			fseek(lfd, msize + (msize & fround), SEEK_CUR);
			s = av[j];
			if ((ifd = fopen(s, "rb")) != NULL)
			{
				if (vfl)
					report("r ", hdr.w.name);
				found(j);
				msize = NOSIZE;
				pthdr(tfd, &hdr);
				*sx++ = copy(ifd, tfd, 0L);
				fclose(ifd);
				*s = '\0';
			}
		}
	}
	if (lfd)
		fclose(lfd);
	for (j = 0; j < ac; ++j)
	{
		if (*(s = av[j]))
		{
			if (pfound[j] & STRPNM)
			{
				pn = strpath(hdr.w.name, av[j]);
				for (i = 0; i < NSIZE && (hdr.w.name[i] = *pn); ++i, ++pn)
					;
			} else
			{
				for (i = 0; i < NSIZE && (hdr.w.name[i] = s[i]); ++i)
					;
			}
			msize = NOSIZE;
			if ((ifd = fopen(s, "rb")) != NULL)
			{
				if (vfl)
					report("a ", hdr.w.name);
				found(j);
				pthdr(tfd, &hdr);
				*sx++ = copy(ifd, tfd, 0L);
				fclose(ifd);
			}
		}
	}
	fclose(tfd);
	if (erprint(ac, av, "lib: can't replace "))
	{
		putback(file, svec, (long) (sx - svec));
		ret = TRUE;
	} else
	{
		ret = FALSE;
	}
	unlink(uniqnm());
	return ret;
}


/*
 * tabulate library contents
 */
static BOOL tab(int ac, char **av, const char *file, BOOL special)
{
	BOOL doall = (!ac);
	FILE *lfd;
	HDR hdr;
	char buf[40];

	(void)special;
	buf[0] = ':';
	buf[1] = '\t';
	lfd = lopen(file, TRUE);
	if (vfl)
	{
		printf("Library %s", file);
		switch (vers)
		{
		case 0:
			printf(" standard format.\n");
			break;
		case 3:
			printf(" Unix III format.\n");
			break;
		case 6:
			printf(" Unix V6 format.\n");
			break;
		case 7:
			printf(" Unix V7 format.\n");
			break;
		}
	}
	while (gthdr(lfd, &hdr))
	{
		if (doall || inlist(ac, av, hdr.w.name))
		{
			if (vfl)
			{
				sprintf(&buf[2], "%ld", msize);
				report(hdr.w.name, buf);
			} else
			{
				report(hdr.w.name, NULL);
			}
		}
		if (!doall)
			found(inpos(ac, av, hdr.w.name));
		skip(lfd, msize, fround);
	}
	fclose(lfd);
	return doall || erprint(ac, av, "lib: can't find ");
}


/*
 * extract files from library
 */
static BOOL xtract(int ac, char **av, const char *file, BOOL print)
{
	BOOL doall = (!ac);
	FILE *lfd;
	FILE *ofd;
	BOOL ok;
	HDR hdr;

	ok = TRUE;
	lfd = lopen(file, TRUE);
	while (gthdr(lfd, &hdr))
	{
		if (!doall && !inlist(ac, av, hdr.w.name))
		{
			skip(lfd, msize, fround);
		} else
		{
			if (vfl)
				report("x ", hdr.w.name);
			if (!doall)
				found(inpos(ac, av, hdr.w.name));
			if (!print)
			{
				if ((ofd = fopen(hdr.w.name, "wb")) == NULL)
					ok = _remark("can't create ", hdr.w.name);
			} else
			{
				ofd = stdout;
			}
			if (ofd == NULL)
			{
				skip(lfd, msize, fround);
			} else if (msize)
			{
				copy(lfd, ofd, msize);
				skip(lfd, msize & fround, FALSE);
			}
			if (!print)
				fclose(ofd);
		}
	}
	fclose(lfd);
	return (doall || erprint(ac, av, "lib: can't extract ")) && ok;
}


/*
 * do library function specified by flags
 */
int main(int ac, char **av)
{
	BOOL(*pfunc) (int ac, char **av, const char *file, BOOL special);
	BOOL special;
	char **plib;

	if (ac <= 1)
		usage("expects flags <lfile> <files>\n");
	if (av[1][0] == '-' || av[1][0] == '+')
	{
		getflags(&ac, &av, "c,d,i,p,r,t,v3,v6,v7,v,x:F <lfile> <files>",
			&cfl, &dfl, &ifl, &pfl, &rfl, &tfl, &v3fl, &v6fl, &v7fl, &vfl, &xfl);
		if (ac)
		{
			plib = av++;
			--ac;
		} else
		{
			usage("expects flags <lfile> <files>\n");
			return 1;
		}
	} else
	{
		plib = ++av;
		--ac;
		getflags(&ac, &av, "c,d,i,p,r,t,v3,v6,v7,v,x:<lfile> F <files>",
			&cfl, &dfl, &ifl, &pfl, &rfl, &tfl, &v3fl, &v6fl, &v7fl, &vfl, &xfl);
	}
	special = FALSE;
	vers = (v3fl) ? 3 : (v6fl) ? 6 : (v7fl) ? 7 : 0;
	if (1 < cfl + dfl + pfl + rfl + tfl + xfl)
	{
		usage("takes only one of -[c d p r t x]\n");
		return 1;
	} else if (xfl)
	{
		pfunc = xtract;
	} else if (rfl)
	{
		pfunc = repl;
	} else if (pfl)
	{
		pfunc = xtract;
		special = TRUE;
	} else if (dfl)
	{
		pfunc = del;
	} else if (cfl)
	{
		pfunc = repl;
		special = TRUE;
	} else
	{
		pfunc = tab;
	}
	if (ifl)
		getin(&ac, &av);
	ersetup(ac);
	markpth(ac, av);
	return (*pfunc) (ac, av, *plib, special) ? 0 : 1;
}

/*	INSPECT IDRIS OBJECT FILES
 * 	copyright (c) 1981 by Whitesmiths, Ltd.
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "util.h"

/*	symbol types
 */
#define UDEFSYMB	0
#define ABSSYMB		4
#define TXTSYMB		5
#define DATASYMB	6
#define BSSSYMB		7
#define	DEFD		0x04
#define EXTERN		0x08

/*	header sizes
 */
#define MAGSIZ		2
#define LNGLIB		26
#define SRTLIB		16
#define LNGHDR		26
#define SRTHDR		14

/*	stuff for new header
 */
#define	PSEGSZ	40
#define	LSEGNM	14

#define	DIRHDR	0177630
#define MODCODE	0200
#define LENCODE	0177

/*	flags:
	-a		sort alphabetically, by name
	-d		list defined symbols
	+dir	print details of library directories
	-g		list global symbols
	-h		output in hex (default is decimal)
	-i		print intervals in value field
	-in		input list of files from STDIN
	-o		output in octal (default is decimal)
	+seg	print segment header info for multi-segment files
	+size	print size in bytes of each module
	-s		tell sizes of text, data, bss and total
	-t		tell machine and library type data
	-u		list undefined symbols
	-v		sort by value
 */
static BOOL aflag = FALSE;
static BOOL dflag = FALSE;
static BOOL dirflag = FALSE;
static BOOL gflag = FALSE;
static BOOL hflag = FALSE;
static BOOL iflag = FALSE;
static BOOL inflag = FALSE;
static BOOL manyfls = FALSE;
static BOOL newhdr = FALSE;
static BOOL oflag = FALSE;
static BOOL sflag = FALSE;
static BOOL segflag = FALSE;
static BOOL sizflag = FALSE;
static BOOL tflag = FALSE;
static BOOL uflag = FALSE;
static BOOL vflag = FALSE;

const char *_pname = "rel";

/*	decoded header values
 */
static BOOL evenbnd = FALSE;
static BOOL longint = FALSE;
static BOOL txtrev = FALSE;
static int lenname = 0;
static unsigned int binhdr = 0;
static unsigned int sbytes = 0;
static uint32_t bsize = 0;
static uint32_t dbias = 0;
static uint32_t dsize = 0;
static uint32_t ssize = 0;
static uint32_t tbias = 0;
static uint32_t tsize = 0;

/*	decoded values from multi-segment header
 */
static int nsegs = 0;
static uint32_t seeksym = 0;
static uint32_t sizesym = 0;
static uint32_t *segend = NULL;
static uint32_t totalsize = 0;

/*	running totals
 */
static uint32_t glbsize = 0;
static uint32_t gldsize = 0;
static uint32_t glssize = 0;
static uint32_t gltsize = 0;

/*	symbol table stats
 */
static unsigned char *norder = NULL;					/* pointer to unordered symbol table */
static unsigned char **sorted = NULL;					/* pointer to array of pointers to sorted entries */
static unsigned int numsym = 0;
static int entsize = 0;
static int presize = 0;
static int valsize = 0;
static unsigned char osnum = 0;


/*	get magic number from header
 */
static unsigned int getmagic(FILE *fp)
{
	unsigned int hdr;
	unsigned char header[MAGSIZ];

	if (fread(header, MAGSIZ, 1, fp) != 1)
		_error("can't read header", NULL);
	hdr = lstou(header);
	if (header[0] == 0x99 || header[0] == 0x9d)
	{
		newhdr = header[0] == 0x9d;
		lenname = (header[1] & 07) ? ((header[1] & 07) << 1) + 1 : 0;
		longint = header[1] & 010;
		lsfmt = header[1] & 020;
		evenbnd = header[1] & 040;
		txtrev = header[1] & 0100;
		binhdr = hdr;
	}
	return hdr;
}


/*	number of bytes in a segment name
 */
#if 0									/* unused */
static int nmbytes(int i)
int i;
{
	i = 2 + 4 * ((i + 2) / 4);
	i = max(6, i);
	return i;
}
#endif


/*	skip over or walk thru a library directory
 */
static void libdir(FILE *fp)
{
	int i, j, jj;
	int ln, nmods, r;
	unsigned char c;
	unsigned char *bbuf;
	unsigned char dbuf[6];
	const char *sep;
	uint32_t dbytes;
	uint32_t dsize;

	if (dflag)
		printf("Library Directory encountered.\n");
	if (!dflag || !dirflag)
		return;
	fread(dbuf, 6, 1, fp);
	nmods = lstou(dbuf);
	dbytes = lstol(&dbuf[2]);
	(void)dbytes;
	r = 1 + nmods / 8;
	bbuf = xmalloc(max(LENCODE + 3, r));

	for (i = 0; fread(&c, 1, 1, fp) == 1 && c;)
	{
		if (c & MODCODE)
		{
			++i;
			printf("Module No.%4u:\n", i);
		}
		if (c & LENCODE)
		{
			ln = fread(bbuf, 1, (c & LENCODE), fp);
			printf("	%-.*s\n", ln, bbuf);
		}
	}
	printf("\nModule Dependencies\n\n");
	for (i = 1; i <= nmods; ++i)
	{
		printf("Module No.%4u: ", i);
		fread(bbuf, 1, r, fp);
		sep = "";
		for (j = 0; j < r; ++j)
			if (bbuf[j])
				for (jj = 0; jj < 8; ++jj)
					if (bbuf[j] & "\200\100\40\20\10\4\2\1"[jj])
					{
						printf("%s%u", sep, 8 * j + jj);
						sep = ", ";
					}
		printf("\n");
	}
	printf("\n Module Sizes\n\n");
	for (i = 1; i <= nmods; ++i)
	{
		fread(dbuf, 1, 4, fp);
		dsize = lstol(dbuf);
		printf("Module No.%4u: %lu\n", i, (unsigned long) dsize);
	}
}


/*	get next extern from entry table
 */
static int getext(unsigned char **list, int start, int total)
{
	int i;
	int findx = longint ? 4 : 2;
	unsigned char *p;

	for (i = start; i < total; ++i)
	{
		p = list[i];
		if (p[findx] & EXTERN)
			return i;
	}
	return -1;
}


/*	force symbols to contain intervals in value field
 */
static void warplst(unsigned char **list, unsigned int nsym, uint32_t totwords)
{
	unsigned char *p;
	unsigned char *q;
	int next;
	int psnum;
	int qsnum = 0;
	int top;
	int sho;
	uint32_t pvalue;
	uint32_t qvalue;

	sho = longint ? 5 : 3;
	for (top = getext(list, 0, nsym); 0 <= top; top = next)
	{
		p = list[top];
		psnum = newhdr ? *(p + sho) : 0;
		pvalue = longint ? xstol(p) : xstos(p);
		next = getext(list, top + 1, nsym);
		q = (0 <= next) ? list[next] : NULL;
		if (q)
			qsnum = newhdr ? *(q + sho) : 0;
		if (!q || (qsnum != psnum))
			qvalue = newhdr ? segend[psnum] : totwords;
		else
			qvalue = longint ? xstol(q) : xstos(q);
		if (longint)
			ltoxs(p, qvalue - pvalue);
		else
			stoxs(p, qvalue - pvalue);
	}
}


/*	get symbol table and set table stats
*/
static unsigned char *getsym(FILE *fp)
{
	unsigned int i;
	unsigned char *ps;
	unsigned char *tps;
	unsigned char *pe;

	valsize = longint ? 4 : 2;
	presize = valsize + 1 + (newhdr ? 1 : 0);
	entsize = presize + lenname;
	if (newhdr)
	{
		fseek(fp, seeksym, SEEK_SET);
		sbytes = sizesym;
	} else
	{
		fseek(fp, tsize + dsize, SEEK_CUR);
	}
	ps = xmalloc(sbytes);
	pe = ps + sbytes;
	if (fread(ps, sbytes, 1, fp) != 1)
		_error("can't read symbol table", NULL);
	if (lenname)
	{
		numsym = sbytes / entsize;
	} else
	{
		numsym = 0;
		for (tps = ps + entsize; tps < pe; tps += entsize + 1 + (tps[0] & 0xff))
			++numsym;
	}
	sorted = (unsigned char **) xmalloc(sizeof(*sorted) * numsym);
	for (tps = ps, i = 0; i < numsym; ++i)
	{
		sorted[i] = tps;
		tps += lenname ? entsize : entsize + 1 + (tps[presize] & 0xff);
	}
	return ps;
}


/*	output a symbol entry
 */
static void putsymb(unsigned char *pent)
{
	uint32_t value;
	unsigned char flags = pent[longint ? 4 : 2];
	BOOL isdef;
	BOOL isext;
	int len;
	const char *lfmt = oflag ? "0%011lo%c " : hflag ? "0x%08lx%c " : "%10lu%c ";
	char outtype;
	const char *sfmt = oflag ? "0%06o%c " : hflag ? "0x%04x%c " : "%5u%c ";
	unsigned char snum = 0;

	if (longint)
	{
		value = xstol(pent);
		pent += 5;
	} else
	{
		value = xstos(pent);
		pent += 3;
	}
	isdef = flags & DEFD;
	isext = flags & EXTERN;
	if (newhdr)
	{
		snum = *pent++;
		if (vflag && snum != osnum)
		{
			printf("\nSEGMENT NUMBER %u\n", snum);
			osnum = snum;
		}
	}
	if (lenname)
	{
		unsigned char *end = memchr(pent, '\0', lenname);
		len = end ? (int)(end - pent) : lenname;
	} else
	{
		len = *pent++;
	}
	if (iflag && !isext)
		return;
	if (uflag && !dflag && !isdef && !gflag)
	{
		printf("%-.*s\n", len, pent);
	} else if (dflag || gflag)
	{
		switch (flags & 07)
		{
		case ABSSYMB:
			outtype = 'a';
			break;
		case TXTSYMB:
			outtype = 't';
			break;
		case DATASYMB:
			outtype = 'd';
			break;
		case BSSSYMB:
			outtype = 'b';
			break;
		case UDEFSYMB:
			outtype = 'u';
			break;
		default:
			outtype = '?';
			break;
		}
		if (isext)
			outtype += 'A' - 'a';
		if ((gflag && isext) || (dflag && isdef) || (uflag && !isdef))
		{
			if (longint)
				printf(lfmt, (unsigned long) value, outtype);
			else
				printf(sfmt, (unsigned int) value, outtype);
			if (aflag && newhdr)
				printf("seg: %u %-.*s\n", snum, len, pent);
			else
				printf("%-.*s\n", len, pent);
		}
	}
}


/*	walk through a stream of relocation data and count bytes
 */
static uint32_t reldata(FILE *fp)
{
	uint32_t lsize;
	int c;

	lsize = 0;
	for (;;)
	{
		c = fgetc(fp);
		if (c == EOF)
			break;
		++lsize;
		if (c == 0)
			break;
		if (c < 32)
		{
			;
		} else if (c < 64)
		{
			c = fgetc(fp);
			++lsize;
		} else if (c < 252)
		{
			;
		} else if ((c = fgetc(fp)) != EOF && (c & 0200))
		{
			c = fgetc(fp);
			lsize += 2;
		} else
		{
			++lsize;
		}
	}
	return lsize;
}


/*	get size of module
 */
static uint32_t getlsize(FILE *fp, uint32_t loff)
{
	uint32_t hsize;
	uint32_t size;

	hsize = longint ? LNGHDR + MAGSIZ : SRTHDR + MAGSIZ;
	size = hsize + tsize + dsize + sbytes;
	fseek(fp, loff + size, SEEK_SET);
	size += reldata(fp) + reldata(fp);
	fseek(fp, loff + hsize, SEEK_SET);
	return size;
}


/*	give the ordering of two pointer list entries by name
 */
static int entorn(const void *pi, const void *pj)
{
	const unsigned char *i = *((const unsigned char **)pi);
	const unsigned char *j = *((const unsigned char **)pj);
	int u;
	const unsigned char *s;
	const unsigned char *t;
	int diff;

	s = &i[presize];
	t = &j[presize];
	u = lenname;
	if (lenname == 0)
	{
		u = min(*s, *t);
		diff = *s - *t;
		++s;
		++t;
	}
	for (; 0 < u; --u, ++s, ++t)
		if (*s != *t)
			return *s - *t;
	return lenname ? 0 : diff;
}


/*	give the ordering of two pointer list entries
 */
static int entorv(const void *pi, const void *pj)
{
	const unsigned char *i = *((const unsigned char **)pi);
	const unsigned char *j = *((const unsigned char **)pj);
	uint32_t s;
	uint32_t t;

	s = (i[longint ? 4 : 2]) & 03;
	t = (j[longint ? 4 : 2]) & 03;
	if (s != t)
		return (int) (s - t);
	if (newhdr)
	{
		s = i[longint ? 5 : 3];
		t = j[longint ? 5 : 3];
		if (s != t)
			return (int) (s - t);
	}
	s = longint ? xstol(i) : xstos(i);
	t = longint ? xstol(j) : xstos(j);
	if (s == t)
		return entorn(pi, pj);
	else if (s < t)
		return -1;
	else
		return 1;
}


/*	list symbols from the symbol table
 */
static void lstsmbls(FILE *fp)
{
	unsigned int i;

	if ((norder = getsym(fp)) == NULL)
		return;
	if (aflag || vflag)
		qsort(sorted, numsym, sizeof(*sorted), vflag ? entorv : entorn);
	if (iflag)
		warplst(sorted, numsym, tsize + dsize + bsize);
	for (i = 0; i < numsym; ++i)
		putsymb(sorted[i]);
	free(norder);
	free(sorted);
}


/*	get header information from file
 */
static void gethdr(FILE *fp)
{
	int hsize = longint ? LNGHDR : SRTHDR;
	unsigned char bhdr[LNGHDR];

	if (fread(bhdr, hsize, 1, fp) != 1)
		_error("can't read binary header", NULL);
	sbytes = xstos(&bhdr[0]);
	if (longint)
	{
		tsize = xstol(&bhdr[2]);
		dsize = xstol(&bhdr[6]);
		bsize = xstol(&bhdr[10]);
		ssize = xstol(&bhdr[14]);
		tbias = xstol(&bhdr[18]);
		dbias = xstol(&bhdr[22]);
	} else
	{
		tsize = xstos(&bhdr[2]);
		dsize = xstos(&bhdr[4]);
		bsize = xstos(&bhdr[6]);
		ssize = xstos(&bhdr[8]);
		tbias = xstos(&bhdr[10]);
		dbias = xstos(&bhdr[12]);
	}
}


/*	get header information from multi-segment file
 */
static void getnhdr(FILE *fp)
{
	int atf;
	int hsize;
	int i;
	uint32_t off;
	uint32_t sdat;
	uint32_t srel;
	uint32_t virt;
	unsigned char nhdr[PSEGSZ];
	const char *msg = "can't read new binary header";

	if (fread(nhdr, 1, 14, fp) != 14)
		_error(msg, NULL);
	hsize = xstos(&nhdr[0]);
	nsegs = xstos(&nhdr[2]);
	seeksym = xstol(&nhdr[6]);
	sizesym = xstol(&nhdr[10]);
	totalsize = hsize + sizesym;
	segend = (uint32_t *) xmalloc(sizeof(*segend) * (nsegs + 1));
	for (i = 0; i < nsegs; ++i)
	{
		if (fread(nhdr, 1, PSEGSZ, fp) != PSEGSZ)
			_error(msg, NULL);
		atf = nhdr[1] + (nhdr[0] << 8);
		virt = xstol(&nhdr[16]);
		off = xstol(&nhdr[20]);
		sdat = xstol(&nhdr[28]);
		srel = xstol(&nhdr[36]);
		segend[i + 1] = off + sdat;
		if (segflag)
		{
			printf("Segment %d:  flags = 0x%02x   %.14s\n", i + 1, (atf & 0xff), &nhdr[2]);
			printf("\tbias = 0x%08lx  offset = 0x%08lx  size = 0x%04x\n\n",
				   (unsigned long) virt, (unsigned long) off, (unsigned int) sdat);
		}
		totalsize += sdat + srel;
	}
}


/*	play with header while reacting to flags
 */
static void intrpfil(FILE *fp, uint32_t lsize, uint32_t loff)
{
	const char *szfmt = oflag ?
		"0%loT + 0%loD + 0%loB + 0%loS = 0%lo\n" : hflag ?
		"0x%lxT + 0x%lxD + 0x%lxB + 0x%lxS = 0x%lx\n" :
		"%luT + %luD + %luB + %luS = %lu\n";

	if (newhdr)
	{
		getnhdr(fp);
		sflag = FALSE;
	} else
	{
		gethdr(fp);
	}
	if (tflag)
	{
		if (newhdr)
			printf("multi-segment header.\n");
		printf("%d byte integers, data %s significant byte first.\n", longint ? 4 : 2, lsfmt ? "least" : "most");
		if (evenbnd)
			printf("even byte boundaries enforced by hardware.\n");
		if (txtrev)
			printf("text segment int byte order is reversed from data segment.\n");
		if (lenname)
			printf("%d character names max.\n", lenname);
		else
			printf("variable length names.\n");
	}
	if (sizflag)
	{
		if (lsize == 0)
			lsize = newhdr ? totalsize : getlsize(fp, loff);
		printf("%lu bytes %s", (unsigned long) lsize, sflag ? ": " : "\n");
	}
	if (sflag)
	{
		printf(szfmt, (unsigned long) tsize, (unsigned long) dsize, (unsigned long) bsize, (unsigned long) ssize,
			   (unsigned long) (tsize + dsize + bsize + ssize));
		gltsize += tsize;
		gldsize += dsize;
		glbsize += bsize;
		glssize += ssize;
	}
	if (dflag || uflag || gflag)
		lstsmbls(fp);
}


/*	do a file, object or library
 */
static BOOL dofile(FILE *fp, const char *fname, uint32_t lsize, uint32_t loff)
{
	int hsize;
	unsigned char lhdr[LNGLIB];
	unsigned int header;
	uint32_t lngsize;
	uint32_t maxloff;

	maxloff = loff + lsize;
	header = getmagic(fp);
	if (header == binhdr)
	{
		if (manyfls || loff)
		{
			fputs(fname, stdout);
			if (sflag || sizflag)
				fputs(": ", stdout);
			else
				fputs(":\n", stdout);
		}
		intrpfil(fp, lsize, loff);
	} else if (header == DIRHDR)
	{
		libdir(fp);
	} else if (header != 0177565 && header != 0177555 && header != 0177545)
	{
		return _remark("bad file format: ", fname);
	} else
	{
		printf("Library - %s:", fname);
		if (tflag)
		{
			switch (header)
			{
			case 0177565:
				printf("standard format.");
				break;
			case 0177555:
				printf("Unix V6 format.");
				break;
			case 0177545:
				printf("Unix System III format.");
				break;
			}
		}
		printf("\n");
		hsize = header == 0177545 ? LNGLIB : SRTLIB;
		for (loff += 2; (fread(lhdr, hsize, 1, fp) == 1) && lhdr[0]; fseek(fp, loff, SEEK_SET))
		{
			lngsize = header != 0177545 ? lstou(&lhdr[14]) : (lstou(&lhdr[24]) << 16) + lstou(&lhdr[22]);
			lhdr[header == 0177555 ? 8 : 14] = '\0';
			dofile(fp, (char *)lhdr, lngsize, loff + hsize);
			loff += hsize + lngsize;
			if (header != 0177565)
				loff += lngsize & 1;
			if (maxloff && maxloff <= loff)
				break;
		}
	}
	return TRUE;
}


/*	disassemble and tell unresolved references
 */
int main(int ac, char **av)
{
	BOOL success;
	FILE *fp;
	const char *tsfmt;
	static char *dfile = "xeq";

	getflags(&ac, &av, "a,+dir,d,g,h,+in,i,o,+seg,+size,s,t,u,v:F <files>",
			 &aflag, &dirflag, &dflag, &gflag, &hflag, &inflag, &iflag,
			 &oflag, &segflag, &sizflag, &sflag, &tflag, &uflag, &vflag);
	tsfmt = oflag ?
		"TOTAL: 0%loT + 0%loD + 0%loB + 0%loS + 0%lo\n" : hflag ?
		"TOTAL: 0x%lxT + 0x%lxD + 0x%lxB + 0x%lxS = 0x%lx\n" :
		"TOTAL: %luT + %luD + %luB + %luS = %lu\n";
	if ((aflag || vflag) && !gflag)
		dflag = TRUE;
	if (iflag)
		dflag = uflag = vflag = TRUE;
	if (!(dflag || gflag || uflag || dirflag || segflag || sizflag || sflag || tflag))
		dflag = uflag = TRUE;
	if (inflag)
		getin(&ac, &av);
	manyfls = ac > 1;
	success = TRUE;
	if (!ac)
	{
		ac = 1;
		av = &dfile;
	}
	for (; ac > 0; ac--, av++)
	{
		if (strcmp(*av, "-") == 0)
		{
			fp = stdin;
			success &= dofile(fp, "<stdin>", 0L, 0L);
		} else if ((fp = fopen(*av, "rb")) == NULL)
		{
			_remark("can't read ", *av);
			success = FALSE;
		} else
		{
			success &= dofile(fp, *av, 0L, 0L);
			fclose(fp);
		}
	}
	if (sflag && manyfls && !newhdr)
		printf(tsfmt, (unsigned long) gltsize, (unsigned long) gldsize, (unsigned long) glbsize,
			   (unsigned long) glssize, (unsigned long) gltsize + gldsize + glbsize + glssize);
	return success ? 0 : 1;
}

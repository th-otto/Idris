/*	CONVERT IDRIS BINARY TO HEX OR S-RECORDS
 *	copyright (c) 1981 by Whitesmiths, Ltd.
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "util.h"

/*	flags:
	+#		start with byte #
	-#		only output every # bytes
	-db##	override object module data bias with ##
	-dr		produce Digital Research 8086 records
	-h		don't put header for hex
	-m*		replace default module name with *
	-r##	raw data file, don't interpret as Whitesmiths file
	-s		produce S records, not hex
	-tb##	override object module text bias with ##
 */
static BOOL drfl = FALSE;
static BOOL hfl = FALSE;
static BOOL sfl = FALSE;
static unsigned int skew = 1;
static unsigned int soff = 0;
static long rfl = -1;
static char *mfl = NULL;
static long db = -1;
static long tb = -1;

const char *_pname = "hex";

/*	other "globals"
 */
static BOOL longint = FALSE;
static FILE *ifio = 0;
static const char *iname;
static uint32_t dbias = 0;
static uint32_t dsize = 0;
static uint32_t loc = 0;
static uint32_t tbias = 0;
static uint32_t tsize = 0;

/*
 * fill up to tot bytes in buf using skew 
 */
static int filbuf(FILE *fio, unsigned char *buf, int tot, size_t sk, uint32_t *amt)
{
	int i;
	int j;

	for (i = j = 0; *amt && j < tot; *amt -= 1)
	{
		if (i % sk == 0)
		{
			*buf++ = fgetc(fio);
			++j;
		} else
			(void) fgetc(fio);
		++i;
	}
	while (*amt && i % sk)
	{
		(void) fgetc(fio);
		++i;
		*amt -= 1;
	}
	return j;
}


/*
 *get needed things from header in a portable way
 */
static void gethdr(void)
{
	int i;
	unsigned char *p;
	int hsize = longint ? 26 : 14;
	unsigned char buf[26];

	for (i = hsize, p = buf; i; --i)
		*p++ = fgetc(ifio);
	if (longint)
	{
		tsize = xstol(&buf[2]);
		dsize = xstol(&buf[6]);
		tbias = xstol(&buf[18]);
		dbias = xstol(&buf[22]);
	} else
	{
		tsize = xstos(&buf[2]);
		dsize = xstos(&buf[4]);
		tbias = xstos(&buf[10]);
		dbias = xstos(&buf[12]);
	}
}


/*
 * get magic # at start of file
 */
static void getmagic(void)
{
	unsigned char header[2];

	header[0] = fgetc(ifio);
	header[1] = fgetc(ifio);
	if (header[0] != 0x99)
		_error("bad file format", NULL);
	longint = header[1] & 010;
	lsfmt = header[1] & 020;
}


/*
 * put two hex digits
 */
static unsigned char putx(char *s, unsigned char n)
{
	unsigned char x;

	x = (n >> 4) & 0xf;
	s[0] = x + (x < 10 ? '0' : 'A' - 10);
	x = n & 0xf;
	s[1] = x + (x < 10 ? '0' : 'A' - 10);
	return n;
}


static BOOL putlin(const char *s, int n)
{
	return fwrite(s, n, 1, stdout) == 1;
}


/*
 * build a hex record and put it out
 */
static size_t putrec(uint32_t off, unsigned char *s, int n, BOOL iscode)
{
	int i;
	int sum;
	BOOL islong = (sfl && (off >> 16));
	int m;
	char buf[80];

	m = n;
	if (sfl)
	{
		strcpy(buf, islong ? "S2" : "S1");
		sum = putx(&buf[2], n + (islong ? 4 : 3));
		i = 4;
		if (islong)
		{
			sum += putx(buf + i, (unsigned int) (off >> 16));
			i += 2;
		}
	} else
	{
		strcpy(buf, ":XXXXXX");
		sum = putx(&buf[1], n);
		i = 3;
	}
	sum += putx(buf + i, (unsigned int) (off >> 8));
	i += 2;
	sum += putx(buf + i, (unsigned int) off);
	i += 2;
	if (!sfl)
	{
		sum += putx(buf + i, !drfl ? 0 : iscode ? 0x81 : 0x82);
		i += 2;
	}
	for (; 0 < n; --n, ++s, i += 2)
		sum += putx(buf + i, *s);
	putx(buf + i, sfl ? ~sum : -sum);
	buf[i + 2] = '\n';
	if (!putlin(buf, i + 3))
		_error("can't write data records", NULL);
	return m;
}


/*
 * put start record
 */
static void putstart(void)
{
	int i;
	int sum;
	const char *s;
	char buf[80];

	if (!sfl)
	{
		if (!hfl)
		{
			strcpy(buf, "$\n");
			i = 2;
		} else
		{
			i = 0;
		}
	} else
	{
		strcpy(buf, "S0XX0000");
		sum = putx(&buf[2], strlen(iname) + 3);
		for (i = 8, s = iname; *s; i += 2, ++s)
			sum += putx(buf + i, *s);
		putx(buf + i, ~sum);
		buf[i + 2] = '\n';
		i += 3;
	}
	if (!putlin(buf, i))
		_error("can't write start record", NULL);
}


/*
 * put end record with start address
 */
static void putend(void)
{
	BOOL islong = (sfl && (tbias >> 16));
	int i;
	int sum;
	char buf[16];

	if (!sfl)
	{
		strcpy(buf, ":00XXXX01XX");
		sum = 1;
		sum += putx(&buf[3], (unsigned int) (tbias >> 8));
		sum += putx(&buf[5], (unsigned int) tbias);
		putx(&buf[9], -sum);
		buf[11] = '\n';
		i = 12;
	} else
	{
		strcpy(buf, islong ? "S8" : "S9");
		strcat(buf, "XXXXXX");
		sum = putx(&buf[2], islong ? 4 : 3);
		i = 4;
		if (islong)
		{
			sum += putx(&buf[i], (unsigned int) (tbias >> 16));
			i += 2;
		}
		sum += putx(&buf[i], (unsigned int) (tbias >> 8));
		i += 2;
		sum += putx(&buf[i], (unsigned int) tbias);
		i += 2;
		putx(&buf[i], ~sum);
		i += 2;
		buf[i] = '\n';
		++i;
	}
	if (!putlin(buf, i))
		_error("can't write end record", NULL);
}


/*
 * translate abs records to records
 */
int main(int ac, char **av)
{
	size_t i;
	long n;
	unsigned char buf[32];
	FILE *ifd;

	getflags(&ac, &av, "db##,dr,h,m*,r##,s,tb##,+#,#:F <ifile>", &db, &drfl, &hfl, &mfl, &rfl, &sfl, &tb, &soff, &skew);
	if (ac == 0)
	{
		ifd = stdin;
		iname = "<stdin>";
	} else
	{
		iname = *av;
		ifd = fopen(iname, "rb");
		if (ifd == NULL)
		{
			_error("can't read ", iname);
		}
	}
	ifio = ifd;
	if (skew <= soff)
		_error("bad starting offset", NULL);
	if (mfl)
		iname = mfl;
	if (rfl == -1)
	{
		getmagic();
		gethdr();
		for (i = 0; tsize && i < soff; ++i, --tsize)
			buf[0] = fgetc(ifio);
		if (skew == 1)
			loc = (tb != -1 ? tb : tbias) + soff;
		else
			loc = tb != -1 ? tb : 0;
		tbias = loc;
		putstart();
		while (0 < tsize)
		{
			putrec(loc, buf, i = filbuf(ifio, buf, sizeof(buf), skew, &tsize), TRUE);
			loc += i;
		}
		for (i = 0; dsize && i < soff; ++i, --dsize)
			buf[0] = fgetc(ifio);
		if (skew == 1)
			loc = (db != -1 ? db : dbias) + soff;
		else
			loc = db != -1 ? db : 0;
		while (0 < dsize)
		{
			putrec(loc, buf, i = filbuf(ifio, buf, sizeof(buf), skew, &dsize), FALSE);
			loc += i;
		}
	} else
	{
		loc = tbias = rfl;
		putstart();
		while ((n = fread(buf, 1, sizeof(buf), ifd)) > 0)
		{
			putrec(loc, buf, n, TRUE);
			loc += n;
		}
	}
	putend();
	return 0;
}

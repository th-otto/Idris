/*	INPUT AND UTILITY ROUTINES
 *	copyright (c) 1979 by Whitesmiths, Ltd.
 */
#include <stdlib.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include "int2.h"
#include "int12.h"
#include "int012.h"
#include "util.h"
#include "p2.h"

/*	type tables
 */
TINY bytype[] = { 0, 2, 2, 2, 2, 2, 4, 4, 4, 4, 8 };

TINY equtype[] = { 0, XUCHAR, XUCHAR, XUSHORT, XSFIELD, XUSHORT, XULONG, XLFIELD, XULONG, XFLOAT, XDOUBLE };

TINY regtype[] = { 0, XSHORT, XSHORT, XSHORT, XUSHORT, XUSHORT,	XLONG, XULONG, XULONG, XDOUBLE, XDOUBLE };

/*	the nameless name
 */
char noname[LENNAME];

/*	relational operator mapping tables
 */
TINY cmpops[] = { GLESS, GLEQ, GGREAT, GGEQ, GISEQ, GNOTEQ, 0 };
TINY flpops[] = { GGEQ, GGREAT, GLEQ, GLESS, GNOTEQ, GISEQ };
TINY lexops[] = { LLESS, LLEQ, LGREAT, LGEQ, LISEQ, LNOTEQ, 0 };

/*	the character pool stuff
 */
#define CHBUF struct chbuf

static struct chbuf
{
	struct chbuf *next;
	char cbuf[512];
} *chbase;


/*
 * write buffer to character pool
 */
void chwrite(const char *s, size_t n)
{
	int i;
	int nn;
	CHBUF **qb;
	CHBUF *q;

	q = 0;
	for (; 0 < n; n -= i)
	{
		for (i = choff >> 9, qb = &chbase; 0 <= i; --i)
		{
			if (!*qb)
			{
				*qb = xmalloc(sizeof(**qb));
				(*qb)->next = NULL;
				(*qb)->cbuf[511] = '\0';
			}
			q = *qb;
			qb = &(*qb)->next;
		}
		i = choff & 511;
		nn = min(511 - (unsigned int)i, n);
		memcpy(&q->cbuf[i], s, nn);
		i = nn;
#ifdef DEBUG
		putfmt("<<%ld|%.*s>>", (long)choff, i, s);
#endif
		choff += i;
		if ((choff & 511) == 511)
			++choff;
		s += i;
	}
}


/*
 * put strings to character pool
 */
void chput(const char *s1, ...)
{
	va_list args;
	const char *p;

	p = s1;
	va_start(args, s1);
	for (; p; p = va_arg(args, const char *))
		 chwrite(p, strlen(p));

	va_end(args);
}


/*
 * read from character pool
 */
char *chread(void)
{
	int i;
	CHBUF *q;
	char *s;

	for (i = choff >> 9, q = chbase; q && 0 < i; --i)
		q = q->next;
	if (q)
	{
		s = &q->cbuf[choff & 511];
		choff = (choff + 512) & ~511;
	} else
	{
		panic("CHREAD");
	}
	return s;
}


/*
 * copy address structure
 */
void cpyad(ADDR *pl, ADDR *pr)
{
	pl->ty = pr->ty;
	memcpy(pl->nm, pr->nm, LENNAME);
	pl->bias = pr->bias;
	pl->idx = pr->idx;
	pl->refs = pr->refs;
}


static int _fcan(char *d)
{
	int i;
	int exp;

#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
	if (d[0] == 0 && d[1] == 0)
		return 0;
	exp = (d[0] & 127) << 4;
	exp |= (d[1] & 0xf0) >> 4;
	d[0] &= 0x80;
	d[1] = (d[1] & 0x0f) | 0x10;
	for (i = 1; i < 7; i++)
	{
		d[i] = (d[i] << 3) | ((d[i + 1] >> 5) & 7);
	}
	d[7] = d[7] << 3;
#else
	if (d[6] == 0 && d[7] == 0)
		return 0;
	exp = (d[7] & 127) << 4;
	exp |= (d[6] & 0xf0) >> 4;
	d[7] &= 0x80;
	d[6] = (d[6] & 0x0f) | 0x10;
	for (i = 6; i > 0; i--)
	{
		d[i] = (d[i] << 3) | ((d[i - 1] >> 5) & 7);
	}
	d[0] = d[0] << 3;
#endif
	return exp - 1022;
}


/*
 * convert floating to DEC format
 */
static BOOL decflt(char *d, BOOL dble)
{
	int i;
	int t;
	int exp;

	exp = _fcan(d) + 128;
	if (!d[1])
		return FALSE;
	if (!dble)
	{
		for (i = 4; i < 8; ++i)
			d[i] = 0;
	}
	d[0] |= (exp >> 1) & 0177;
	d[1] = (exp << 7) | (d[1] & 0177);
	for (i = 0; i < 8; i += 2)
	{
		t = d[i];
		d[i] = d[i + 1];
		d[i + 1] = t;
	}
	return d[4] || d[5] || d[6] || d[7];
}


/*
 * get a function token, putting data
 */
LEX gcode(void)
{
	int i;
	int n;
	LEX c;
	int num;
	long lo;
	char name[LENNAME + 1];

	for (;;)
	{
		switch (c = getch())
		{
		case GADDR:
		case GADDR + 1:
		case GADDR + 2:
		case GADDR + 3:
		case GADDR + 4:
			gname(name);
			gint(&lo);
			num = lo;
			if (name[0] && num)
				putasm("&%p%p%o%p\n", name, "[", num, "]");
			else if (name[0])
				putasm("&%p\n", name);
			else
				putasm("&%o\n", num);
			break;
		case GDEF:
		case GREF:
			putasm("public %p\n", gname(name));
			break;
		case GDATA:
		case GNDATA:
		case GLITS:
		case GSWTAB:
			n = needch();
			if (c == GDATA)
				csect(ISDATA);
			else if (c == GNDATA)
				csect(ISNDATA);
			else
				csect(ISLITS);
			putasm("%p:\n", gname(name));
			break;
		case GINT:
			n = needch();
			gint(&lo);
			num = lo;
			if (n == 1)
				putasm("%o\n", num);
			else if (n == 2)
				putasm("&%o\n", num);
			else
				putasm("&%o,&%o\n", (int) (lo >> 16), num);
			break;
		case GFLOAT:
			n = needch();
			for (i = 0; i < 8; ++i)
				name[i] = needch();
			decflt(name, n == 8);
			putasm("&%o,&%o", lstoi((uint16_t *)&name[0]), lstoi((uint16_t *)&name[2]));
			if (4 < n)
				putasm(",&%o,&%o", lstoi((uint16_t *)&name[4]), lstoi((uint16_t *)&name[6]));
			putasm("\n");
			break;
		case GSTRING:
			n = needch();
			while (0 <= n)
			{
				putasm("%o", (n <= 0) ? 0 : needch());
				for (i = 1; 0 <= --n && i < 8; ++i)
					putasm(",%o", (n <= 0) ? 0 : needch());
				putasm("\n");
			}
			break;
		case GSPACE:
			gint(&lo);
			num = lo;
			putasm(".:=.[%o]\n", num);
			break;
		default:
			return c;
		}
	}
}


/*
 * get an expression tree
 */
EXPR *gexpr(void)
{
	int n;
	EXPR *q;
	char *s;
	long bias;
	static TINY gidx[] = { XBC, X2, X3, X4, XDE, XDE, X0, X0, 0 };
	static TINY grx[] = { INTRET, R2, R3, R4, ARGIDX, AUTIDX, FLTRET, LONGRET, 0 };

	q = xmalloc(sizeof(*q));
	q->next = exlist;
	exlist = q;
	q->got = 0;
	q->op = needch();
	if ((q->e.v.ty = needch()) == XSFIELD || q->e.v.ty == XLFIELD)
	{
		q->e.v.ty |= needch() << 4;
		q->e.v.ty |= needch() << 10;
	} else if ((q->e.v.ty & 15) == XPTRTO)
	{
		q->e.v.ty = XUSHORT;
	}
	if (q->op)
	{
		q->e.o.left = gexpr();
		if (q->op == LQUERY)
			q->e.o.mid = gexpr();
		q->e.o.right = (q->op & BINOP) ? gexpr() : &exzero;
	} else
	{
		for (n = needch(), s = q->e.v.nm; 0 < n; --n)
			*s++ = needch();
		while (s < &q->e.v.nm[LENNAME])
			*s++ = '\0';
		gint(&bias);
		q->e.v.bias = bias;
		if ((n = needch()) == ARGIDX)
			q->e.v.bias += 4;
		else if (n == AUTIDX)
			q->e.v.bias -= AUTOFF;
		q->e.v.idx = gidx[_scnstr(grx, n)];
		q->e.v.refs = needch();
		s = q->e.v.nm;
		if (q->e.v.ty == XDOUBLE && !q->e.v.refs && !q->e.v.idx)
		{
			decflt(s, TRUE);
			csect(ISLITS);
			s = ln(crs());
			putasm("%p:&%o,&%o,&%o,&%o\n", s,
				lstoi((uint16_t *)&q->e.v.nm[0]), lstoi((uint16_t *)&q->e.v.nm[2]), lstoi((uint16_t *)&q->e.v.nm[4]), lstoi((uint16_t *)&q->e.v.nm[6]));
			strcpy(q->e.v.nm, s);
			q->e.v.bias = 0;
			q->e.v.refs = 1;
		} else if (*s == '>')
		{
			*s = '#';
		}
		if ((q->e.v.ty == XLONG || q->e.v.ty == XULONG) && iscons(q))
		{
			csect(ISLITS);
			strcpy(q->e.v.nm, ln(crs()));
			putasm("%p:&%o,&%o\n", q->e.v.nm, (int) (bias >> 16), q->e.v.bias);
			q->e.v.bias = 0;
			q->e.v.refs = 1;
		}
	}
	return q;
}


/*
 *get an integer
 */
void gint(long *l)
{
	int i;
	char *s = (char *) l;

	for (i = 0; i < (int) sizeof(*l); ++i)
		*s++ = needch();
}


/*
 * get a label
 */
LABEL glabel(void)
{
	char *p;
	LABEL l;

	p = (char *) &l;
	*p++ = needch();
	*p = needch();
	return l;
}


/*
 * get a name
 */
char *gname(char *s)
{
	size_t n;
	char *q;

	q = s;
	if ((n = needch()) != 0)
	{
		if ((*q = needch()) != '>')
		{
			q[1] = q[0];
			*q++ = '$';
		} else
			*q = '#';
		++q;
		while (0 < --n)
			*q++ = needch();
	}
	*q = '\0';
	return s;
}


/*
 * classify address of fixed expression
 */
BITS gotten(EXPR *p)
{
	BITS got;
	int refs;

	refs = p->f.refs;
	switch (p->f.idx)
	{
	case 0:
		got = (refs || p->f.nm[0]) ? WMEM : WBC;
		break;
	case XDE:
	case XBC:
		got = refs ? WPBC : WBC;
		break;
	case XHL:
		got = refs ? WPHL : WHL;
		break;
	case XP0:
	case XP1:
	case XSP:
		got = refs ? WPSTK : WSTACK;
		break;
	case X0:
	case X1:
		got = refs ? WTERM : WVMEM;
		break;
	default:
		got = refs ? WTERM : WMEM;
	}
	return got;
}


/*
 * test for constant term
 */
BOOL iscons(EXPR *p)
{
	return !p->op && !p->e.v.nm[0] && !p->e.v.idx && !p->e.v.refs;
}


/*
 * make a name from label
 */
char *ln(LABEL label)
{
	char *s;
	static char name[8];

	name[0] = '#';
	for (s = name + 1; label; ++s)
	{
		*s = (label & 07) + '0';
		label >>= 3;
	}
	*s = '\0';
	return name;
}


/*
 * need a character
 */
LEX needch(void)
{
	LEX c;

	if ((c = getch()) == EOF)
	{
		panic("EOF");
		exit(1);
	}
	return c;
}


/*
 * put a panic error message
 */
void panic(const char *s)
{
	char buf[30];
	char *f;

	sprintf(buf, "%d", lineno);
	if (*funname == '$')
		f = funname + 1;
	else
		f = funname;
	fprintf(errfd, "%s: PANIC %s %s%sline %d!\n", _pname, s, f, *f ? "() " : "", lineno);
#ifdef DEBUG
	chput("/PANIC ", s, ";", NULL);
#else
	exit(1);
#endif
}


/*
 * prefer wants but look to needs
 */
BITS pref(BITS want, BITS need)
{
	return ((want &= need) ? want : need) & ~GJUNK;
}


/*
 * convert register mask to index number
 */
TINY rtox(BITS r)
{
	int i;

	if (r)
		for (i = 0; rtab[i]; ++i)
			if (rtab[i] == r)
				return xtab[i];
	return 0;
}


/*
 * set allocated address
 */
void setad(EXPR *p, BITS ty, TINY idx, TINY refs)
{
	p->got = 0;
	p->f.ty = regtype[ty & 017];
	memcpy(p->f.nm, noname, LENNAME);
	p->f.bias = 0;
	p->f.idx = idx;
	p->f.refs = refs;
}


/*
 * convert index number to register mask
 */
TINY xtor(TINY x)
{
	return !x ? 0 : rtab[_scnstr(xtab, x & 077)] & ~AUTIDX;
}


/*
 * tempify a long or double on the stack
 */
static BITS treg(EXPR *p, BITS set)
{
	if ((set & (HL | BC)) != (HL | BC))
		return 0;
	set |= xtor(p->f.idx);
	autoff -= 8;
	if (autoff < autmin)
		autmin = autoff;
	chput("hl=", NULL);
	putnb("", (size_t) autoff);
	chput("+de->bc;sp=>hl<=bc;\4\n", NULL);
	p->f.idx = XSP;
	return set;
}


/*
 * liberate a register, if possible
 */
BITS tempify(EXPR *p, BITS want, BITS set)
{
	BITS ty;

#ifdef DEBUG
	printf("/tempify 0x%x 0x%x\n", want, set);
	putterm(p, 1);
#endif
	if (!(p->got & GVOL))
		return 0;
	if (p->f.refs)
	{
		if (xtor(p->f.idx) & RS)
			return treg(p, set);
		--p->f.refs;
		ty = p->f.ty, p->f.ty = XUSHORT;
		set = force(p, WSTACK | (want & GJUNK), set, XUSHORT);
		p->f.ty = ty;
		++p->f.refs;
		return set;
	}
	return force(p, ((want & VOLSET) ? WSTACK : WPSTK) | (want & GJUNK), set, p->f.ty);
}

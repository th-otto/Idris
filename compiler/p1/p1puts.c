/*	OUTPUT FROM PASS1
 *	copyright (c) 1978 by Whitesmiths, Ltd.
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "int1.h"
#include "int01.h"
#include "int12.h"
#include "int012.h"
#include "util.h"
#include "p1.h"

/*	zero term
 */
static TERM zeterm = { NULL, NULL, { 0 }, TCHAR, 0, { { 0 } } };

/*	table of relational ops and flipped relops
 */
static TINY relops[] = { LISEQ, LNOTEQ, LLESS, LLEQ, LGREAT, LGEQ, 0 };
static TINY reflip[] = { LNOTEQ, LISEQ, LGEQ, LGREAT, LLEQ, LLESS, 0 };
static TINY jctab[] = { GISEQ, GNOTEQ, GLESS, GLEQ, GGREAT, GGEQ, 0 };

/*
 * create a label and return it
 */
LABEL crs(void)
{
	static LABEL nextsym = -1;

	return nextsym += 2;
}


/*
 * make a label number printable
 */
char *lblname(LABEL label)
{
	int i;
	static char name[LENNAME];

	name[0] = '>';
	for (i = 1; label && (i < 6); ++i)
	{
		name[i] = (label & 07) + '0';
		label = (label >> 3) & 017777;
	}
	while (i < LENNAME)
		name[i++] = '\0';
	return name;
}


/*
 * find the length of a name or double
 */
static size_t lname(const char *s)
{
	int i;

	for (i = LENNAME; 0 <= --i;)
		if (s[i])
			return i + 1;
	return 0;
}


/*
 * put a name
 */
static void ptname(const char *s)
{
	int i;

	i = lname(s);
	if (i > nlen)
		i = nlen;
	for (pcode(i); 0 <= --i; ++s)
		pcode(cflag ? TOLOWER(*s) : *s);
}


/*
 * put an address
 */
size_t paddr(char *s, long by, size_t bnd)
{
	size_t n;

	n = bytes(TPTRTO, NULL);
	if (*s)
	{
		pcode(GADDR + bnd);
		ptname(s);
		ptint(by);
	} else
	{
		pint(by, n);
	}
	return n;
}


/*
 * pass the current auto offset
 */
void pauto(long by)
{
	pcode(GAUTOFF);
	ptint(by);
}


/*
 * put case name
 */
LABEL pcase(LABEL at)
{
	pcode(GCASE);
	ptlab(at);
	ptlab(lineno);
	return at;
}


/*
 * put a character buffered
 */
static void putch(int c)
{
	if (fputc(c, outfd) < 0)
	{
		p1error("can't write!");
		exit(1);
	}
}


/*
 * put a code byte
 */
void pcode(int c)
{
	putch(c & 0xff);
}


/*
 * put data name
 */
void pdata(const char *s, size_t bnd, BOOL ndata)
{
	if (dflag && ndata)
		pcode(GNDATA);
	else
		pcode(GDATA);
	pcode(bnd);
	ptname(s);
}


/*
 * put a definition
 */
void pdef(const char *s)
{
	pcode(GDEF);
	ptname(s);
}


/*
 * end a data or function initializer
 */
void pend(void)
{
	int i;
	LITERAL *p;
	LITERAL *next;

	for (p = littab; p; p = next)
	{
		if (p->op) /* symbol->sc */
		{
			pcode(GLITS);
			pcode(0);
			ptname(p->n.an);
			i = p->e.l.a.m;
			pstr((const char *)p->e.l.next, i - 1);
		}
		free(p->e.l.next);
		next = p->next;
		free(p);
	}
	littab = NULL;
}


/*
 * put a floating constant PDP-11
 */
size_t pfloat(const double *_pd, size_t n)
{
	int i;
	const unsigned char *pd = (const unsigned char *)_pd;
	
	pcode(GFLOAT);
	pcode(n);
	for (i = sizeof(double); 0 <= --i;)
		pcode(*pd++);
	return n;
}


/*
 * put a function start
 */
void pfunc(const char *s)
{
	pcode(GFUNC);
	ptname(s);
}


/*
 * put an integer constant
 */
size_t pint(long b, size_t n)
{
	pcode(GINT);
	pcode(n);
	ptint(b);
	return n;
}


/*
 * put a jcond 
 */
static LABEL pjc(LEX rop, TERM *left, TERM *right, LABEL to)
{
	if (!to)
		to = crs();
	pcode(jctab[_scnstr(relops, rop)]);
	ptlab(to);
	ptexpr(left);
	ptexpr(right);
	return to;
}


/*
 * put a jump false
 */
LABEL pjf(TERM *q, LABEL fb, LABEL tb)
{
	TINY i;

	if (!q)
		return fb ? fb : crs();
	if (q->op == LANDAND)
	{
		fb = pjf(q->e.o.left, fb, 0);
		return pjf(q->e.o.right, fb, tb);
	} else if (q->op == LOROR)
	{
		tb = pjt(q->e.o.left, 0, tb);
		return pjf(q->e.o.right, fb, tb);
	} else if (q->op == LNOT)
	{
		return pjt(q->e.o.left, tb, fb);
	} else if (relops[i = _scnstr(relops, q->op)])
	{
		fb = pjc(reflip[i] & 0xff, q->e.o.left, q->e.o.right, fb);
	} else
	{
		fb = pjc(LISEQ, q, &zeterm, fb);
	}
	plabel(tb);
	return fb;
}


/*
 * put a jump true
 */
LABEL pjt(TERM *q, LABEL fb, LABEL tb)
{
	if (!q)
		return pjump(tb, fb);
	if (q->op == LANDAND)
	{
		fb = pjf(q->e.o.left, fb, 0);
		return pjt(q->e.o.right, fb, tb);
	} else if (q->op == LOROR)
	{
		tb = pjt(q->e.o.left, 0, tb);
		return pjt(q->e.o.right, fb, tb);
	} else if (q->op == LNOT)
	{
		return pjf(q->e.o.left, tb, fb);
	} else if (relops[_scnstr(relops, q->op)])
	{
		tb = pjc(q->op, q->e.o.left, q->e.o.right, tb);
	} else
	{
		tb = pjc(LNOTEQ, q, &zeterm, tb);
	}
	plabel(fb);
	return tb;
}


/*
 * put a jump
 */
LABEL pjump(LABEL to, LABEL at)
{
	if (!to)
		to = crs();
	pcode(GJUMP);
	ptlab(to);
	plabel(at);
	return to;
}


/*
 * put a label
 */
LABEL plabel(LABEL at)
{
	if (at)
	{
		pcode(GLABEL);
		ptlab(at);
		ptlab(lineno);
	}
	return at;
}


/*
 * put a move
 */
void pmove(TERM *left, TERM *right)
{
	static TERM mvterm;

	mvterm.op = DGETS;
	mvterm.at = NULL;
	mvterm.e.o.left = left;
	mvterm.e.o.right = right;
	pvoid(typify(&mvterm));
}


/*
 * put a reference
 */
void pref(const char *s)
{
	pcode(GREF);
	ptname(s);
}


/*
 * pass the current reg high water mark
 * NB: REGSET & 0200 => r & 02
 */
void pregs(BITS r)
{
	pcode(GREGS);
	pcode((r & 034) | ((r & ~034) >> 6));
}


/*
 * put a return
 */
void pret(void)
{
	pcode(GRET);
}


/*
 * put a space request
 */
void pspace(long by)
{
	if (0 < by)
	{
		pcode(GSPACE);
		ptint(by);
	}
}


/*
 * put out a string
 */
void pstr(const char *s, int n)
{
	for (; 256 <= n; --n, ++s)			/* HOT PATCH */
		pint((long) *s, 1);
	pcode(GSTRING);
	pcode(n);
	for (; 0 < n; --n)
		pcode(*s++);
}


/*
 * put a switch statement
 */
void pswitch(LABEL tab)
{
	pcode(GSWITCH);
	ptlab(tab);
}


/*
 * put a switch table
 */
void pswtab(CASE **ptab, LABEL def, LABEL tab)
{
	CASE *p;
	CASE *next;

	pcode(GSWTAB);
	pcode(bound(tunsign, 0));
	ptname(lblname(tab));
	for (p = *ptab; p != (CASE *)ptab; p = next)
	{
		paddr(lblname(p->clabel), 0L, 4);
		pint(p->cvalue, (size_t) intsize);
		next = p->next;
		free(p);
	}
	pint(0L, intsize);
	paddr(lblname(def), 0L, 4);
	pcode(GSWEND);
}


/*
 * put an expression
 */
void ptexpr(TERM *p)
{
	int i;
	char *s;

	static TINY xtab[] = { XCHAR, XUCHAR, XSHORT, XSFIELD, XUSHORT, XLONG, XLFIELD, XULONG, XFLOAT, XDOUBLE, XPTRTO, XUSHORT };

	pcode(p->op);
	if ((i = xtab[_scnstr(typtab, type(p->ty))]) != XPTRTO)
		pcode(i);
	else
		pcode(XPTRTO | bound(dety(p->ty), p->at) << 4);
	if (p->ty == tfield)
	{
		pcode(p->at->a.b.boff);
		pcode(p->at->a.b.bsize);
	}
	if (p->op)
	{
		ptexpr(p->e.o.left);
		if (p->op == LQUERY)
			ptexpr(p->e.o.mid);
		if (p->op & BINOP)
			ptexpr(p->e.o.right);
	} else
	{
		if (p->ty == TDOUBLE && !p->e.v.refs && !p->e.v.idx)
		{
			pcode(8);
			for (i = 8, s = p->n.an; 0 <= --i;)
				pcode(*s++);
		} else
			ptname(p->n.an);
		ptint(p->e.v.bias);
		pcode(p->e.v.idx);
		pcode(p->e.v.refs);
	}
}


/*
 * put an integer
 */
void ptint(long lo)
{
	int i;
	unsigned char *q;

	for (q = (unsigned char *)&lo, i = sizeof(lo); 0 < i; --i)
		pcode(*q++);
}


/*
 * put a label
 */
void ptlab(LABEL arglab)
{
	int i;
	unsigned char *q;
	LABEL lab = arglab;

	for (q = (unsigned char *)&lab, i = sizeof(lab); 0 < i; --i)
		pcode(*q++);
}


/*
 * put a void expression
 */
void pvoid(TERM *expr)
{
	docheck(expr);
	pcode(GVOID);
	ptexpr(expr);
}


/*
 * buy a register
 */
TINY rbuy(BITS ty, BITS *pset)
{
	BITS set;
	BITS mask;

	if (!*pset)
		return 0;
	switch (type(ty))
	{
	case TCHAR:
	case TUCHAR:
	case TSHORT:
	case TUSHORT:
	case TPTRTO:
		break;
	case TLONG:
	case TULONG:
		if (ty > tunsign)
			return 0;
		break;
	default:
		return 0;
	}
	mask = (aflag && (*pset & 034000) && type(ty) == TPTRTO) ? 034000 : -1;
	set = *pset & mask;
	set ^= set & (set - 1);
	*pset &= ~set;
	return set & 034 ? set : ((set >> 9) | 0200);
}

/*	SUBROUTINES FOR PASS 1
 *	copyright 1978 by Whitesmiths, Ltd.
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "int1.h"
#include "int01.h"
#include "int12.h"
#include "util.h"
#include "p1.h"

/*	index for boundaries and bytesizes
 */
#define ITIDX	7
size_t bndtab[] = { 0,     0,      1,      1,       1,       2,     2,       2,      2,      3,       1,     -1 };
size_t bytab[]  = { 1,     1,      2,      2,       2,       4,     4,       4,      4,      8,       2,      0 };
TINY typtab[]   = { TCHAR, TUCHAR, TSHORT, TSFIELD, TUSHORT, TLONG, TLFIELD, TULONG, TFLOAT, TDOUBLE, TPTRTO, 0 };

/*	the null name
 */
char noname[LENNAME];

/*
 * enforce bound based on type, attributes and offset
 */
long bndify(BITS ty, ATTR *at, long off)
{
	size_t b;

	b = (1 << bound(ty, at)) - 1;
	off = off + b;
	off = off & ~(long) b;
	return off;
}


/*
 * take the boundary based on type and attribute chain
 */
size_t bound(BITS ty, ATTR *at)
{
	SYMBOL *p;
	size_t i;

	if ((i = bndtab[_scnstr(typtab, type(ty))]) != (size_t)-1)
		return min(i, bndef);
	if (type(ty) == TARRAY)
		return bound(dety(ty), at->next);
	if (ty == TSTRUCT || ty == TUNION)
	{
		for (i = 0, p = at->a.stab->s.tagtab; p; p = p->next)
			i = max(i, bound(p->ty, p->at));
		return i;
	}
	return 4;
}


/*
 * buy space for an ATTR
 */
ATTR *buymat(long m, ATTR *link)
{
	ATTR *pa;

	pa = xmalloc(sizeof(*pa));
	pa->next = link;
	pa->a.m = m;
	return pa;
}


/*
 * buy space for an op and copy into it
 */
TERM *buyop(LEX op, TERM *left, TERM *right)
{
	TERM *q;

	q = xmalloc(sizeof(*q));
	q->next = exlist;
	exlist = q;
	q->ty = 0;
	q->at = NULL;
	q->op = op;
	q->e.o.left = left;
	q->e.o.right = right;
	q->e.o.mid = NULL;
	return q;
}


/*
 * buy space for a symbol ATTR
 */
ATTR *buysat(SYMBOL *stab, ATTR *link)
{
	ATTR *pa;

	pa = xmalloc(sizeof(*pa));
	pa->next = link;
	pa->a.stab = stab;
	return pa;
}


/*
 * buy space for a SYMBOL and copy into it
 */
SYMBOL *buysym(BITS ty, ATTR *at, char *name, LEX sc)
{
	SYMBOL *q;

	q = xmalloc(sizeof(*q));
	q->next = NULL;
	setty(q, ty, at);
	cpynm(q->n.an, name ? name : noname);
	q->sc = sc;
	q->s.offset = 0;
	return q;
}


/*
 * buy space for a term and copy into it
 */
TERM *buyterm(BITS ty, ATTR *at, const char *an, long bias, TINY idx, TINY refs)
{
	TERM *q;

	q = xmalloc(sizeof(*q));
	q->next = exlist;
	exlist = q;
	q->ty = ty;
	q->at = at;
	q->op = 0;
	cpynm(q->n.an, an ? an : noname);
	q->e.v.bias = bias;
	q->e.v.idx = idx;
	q->e.v.refs = refs;
	return q;
}


/*
 * take the sizeof a declarator based on type, attr
 */
long bytes(BITS ty, ATTR *at)
{
	size_t i;
	SYMBOL *p;
	long j;
	long k;

	if ((i = bytab[_scnstr(typtab, type(ty))]) != 0)
	{
		return i;
	} else
	{
		switch (type(ty))
		{
		case TARRAY:
			if (!at->a.m)
				p1error("array size unknown");
			return (at->a.m * bytes(dety(ty), at->next));
		case TSTRUCT:
			if (!(p = at->a.stab->s.tagtab))
			{
				p1error("structure size unknown");
				return 0;
			} else
			{
				while (p->next)
					p = p->next;
				return (bndify(ty, at, bytes(p->ty, p->at) + p->s.offset));
			}
		case TUNION:
			if (!(p = at->a.stab->s.tagtab))
			{
				p1error("union size unknown");
				return 0;
			} else
			{
				for (j = 0; p; p = p->next)
				{
					k = bytes(p->ty, p->at);
					j = max(j, k);
				}
				return (bndify(ty, at, j));
			}
		default:
			p1error("function size undefined");
			return 0;
		}
	}
}


/*
 * clear a symbol table entry
 */
void clrsym(SYMBOL *p)
{
	int i;

	p->next = NULL;
	p->ty = 0;
	p->at = NULL;
	for (i = 0; i < LENNAME; ++i)
		p->n.an[i] = '\0';
	p->sc = 0;
	p->s.tagtab = 0;
}


/*
 * copy name field
 */
void cpynm(char *d, const char *s)
{
	int i;

	for (i = LENNAME; 0 <= --i;)
		*d++ = *s++;
}


/*
 * copy a token structure
 */
TOKEN *cpytok(TOKEN *p, TOKEN *q)
{
	p->type = q->type;
	cpynm(p->t.an, q->t.an);
	return p;
}


/*
 * pick a type off the ty field
 */
BITS dety(BITS ty)
{
	return (ty >> 2) & 037777;
}


/*
 * test for double literal
 */
BOOL dlit(TERM *q)
{
	return q->ty == TDOUBLE && !q->op && !q->e.v.refs;
}


/*
 * is ty of type float or double
 */
BOOL dtype(BITS ty)
{
	return ty == TDOUBLE || ty == TFLOAT;
}


/*
 * compare two external symbols for name match
 */
static BOOL exmatch(SYMBOL *p, SYMBOL *q)
{
	int i;
	char *s;
	char *t;

	if (q->sc != LEXTERN && q->sc != DEXTERN && q->sc != LSTATIC && q->sc != DSTATIC)
		return FALSE;
	i = min(nlen, LENNAME);
	s = p->n.an;
	t = q->n.an;
	if (cflag)
	{
		for (; 0 <= --i; ++s, ++t)
			if (TOLOWER(*s) != TOLOWER(*t))
				break;
	} else
	{
		for (; 0 <= --i; ++s, ++t)
			if (*s != *t)
				break;
	}
	return i < 0;
}


/*
 * check for duplicate externs
 */
void exchk(SYMBOL *p)
{
	SYMBOL *q;

	if (LENNAME <= nlen && !cflag)
		return;
	for (q = p; (q = q->next) != NULL;)
	{
		if (exmatch(p, q))
		{
			nmerr("external name conflict", p->n.an);
			return;
		}
	}
}


/*
 * is a term a constant
 */
BOOL iscons(TERM *q)
{
	return !(q->op || q->n.an[0] || q->e.v.idx || q->e.v.refs || q->ty == TDOUBLE);
}


/*
 * is ty of type integer
 */
BOOL itype(BITS ty)
{
	return _scnstr(typtab, type(ty)) <= ITIDX;
}


/*
 * lookup an identifier in the symbol table
 */
SYMBOL *lookup(const char *name, SYMBOL *from, SYMBOL *to)
{
	SYMBOL *q;
	const char *s;
	const char *t;
	int i;

	for (q = from; q != to; q = q->next)
	{
		for (s = q->n.an, t = name, i = LENNAME; 0 < i; --i)
			if (*s++ != *t++)
				break;
		if (i == 0)
			return q;
	}
	return NULL;
}


/*
 * set maximum legal type
 */
BITS maxify(BITS ty)
{
	switch (ty)
	{
	case TSFIELD:
	case TLFIELD:
		return tunsign;
	case TCHAR:
	case TUCHAR:
	case TSHORT:
	case TUSHORT:
		if (ty < tint)
			return tint;
		break;
	case TFLOAT:
		return TDOUBLE;
	}
	return ty;
}


/*
 * is ty of type pointer to
 */
BOOL ptype(BITS ty)
{
	return (ty & 3) == TPTRTO;
}


/*
 * add to the type field
 */
SYMBOL *retype(SYMBOL *p, BITS nty)
{
	int i;

	if (!p)
	{
		p1error("incomplete declaration");
	} else
	{
		for (i = 0; (3 << 2 * i) & p->ty; ++i)
			;
		if (5 <= i)
			p1error("declaration too complex");
		else
			p->ty = (p->ty << 2) | nty;
	}
	return p;
}


/*
 * set address attributes
 */
void setad(TERM *p, const char *name, long bias, TINY idx, TINY refs)
{
	p->op = 0;
	cpynm(p->n.an, name ? name : noname);
	p->e.v.bias = bias;
	p->e.v.idx = idx;
	p->e.v.refs = refs;
}


/*
 * set type attributes
 */
void setty(SYMBOL *p, BITS ty, ATTR *at)
{
	p->ty = ty;
	p->at = at;
}


/*
 * is ty a scalar type ?
 */
BOOL stype(BITS ty)
{
	return typtab[_scnstr(typtab, type(ty))] != 0;
}


/*
 * return the type of the symbol
 */
BITS type(BITS ty)
{
	return (ty & 3) ? (ty & 3) : ty;
}

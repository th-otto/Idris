/*	DATA INITIALIZERS
 *	copyright (c) 1978 by Whitesmiths, Ltd.
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "int1.h"
#include "int01.h"
#include "int012.h"
#include "util.h"
#include "p1.h"

BOOL decflag = FALSE;

static long dinit(BITS ty, ATTR *at, TERM *q, BOOL list);
static long arinit(BITS ty, ATTR *at, TERM *q, BOOL list);


/*
 * initialize a structure
 */
static long stinit(SYMBOL *p, TERM *q, BOOL list)
{
	TERM *r;
	long n;
	long size;

	for (size = 0; p && (q || eat(LLCURLY) || (q = gexpr(FALSE))); p = p->next)
	{
		while (p && !p->n.an[0])
			p = p->next;
		if (!p)
			break;
		pspace(p->s.offset - size);
		if (p->ty != tfield)
			size = p->s.offset + dinit(p->ty, p->at, q, list);
		else
		{
			n = 0;
			for (r = q; r || (r = gexpr(FALSE)); p = p->next)
			{
				if (p->n.an[0])
				{
					if (!iscons(r))
						p1error("illegal field initializer");
					else
						n |= (r->e.v.bias & ((1L << p->at->a.b.bsize) - 1)) << (long) p->at->a.b.boff;
					if (list)
						eat(LCOMMA);
					r = NULL;
				}
				if (!p->next || p->next->ty != tfield || p->next->s.offset != p->s.offset)
					break;
			}
			size = p->s.offset + pint(n, (size_t) bytes(tfield, NULL));
		}
		if (!q)
			need(LRCURLY);
		if (list)
			eat(LCOMMA);
		q = NULL;
	}
	return size;
}


/*
 * parse a data initializer and return the number of bytes initialized
 */
static long dinit(BITS ty, ATTR *at, TERM *q, BOOL list)
{
	int i;
	double dnum;
	long n;
	long size;

	size = 0;
	if (type(ty) == TARRAY)
		size = arinit(dety(ty), at, q, list);
	else if (type(ty) == TSTRUCT)
		size = stinit(at->a.stab->s.tagtab, q, list);
	else if (q || (q = gexpr(FALSE)))
	{
		switch (type(ty))
		{
		case TUNION:
			if (at->a.stab->s.tagtab)
				size = dinit(at->a.stab->s.tagtab->ty, at->a.stab->s.tagtab->at, q, list);
			break;
		case TCHAR:
		case TUCHAR:
		case TSHORT:
		case TUSHORT:
		case TLONG:
		case TULONG:
			if (!iscons(q))
				p1error("illegal integer initializer");
			else
			{
				i = bytes(ty, at);
				size = pint(q->e.v.bias, i);
			}
			break;
		case TPTRTO:
			if (q->op || 1 < q->e.v.refs || q->e.v.idx)
				p1error("illegal pointer initializer");
			else
				size = paddr(q->n.an, q->e.v.bias, bound(dety(ty), at));
			break;
		case TFLOAT:
		case TDOUBLE:
			i = bytes(ty, at);
			if (dlit(q))
			{
				size = pfloat(&q->n.dn, i);
			} else if (iscons(q))
			{
				dnum = q->e.v.bias;
				size = pfloat(&dnum, i);
			} else
			{
				p1error("illegal double initializer");
			}
			break;
		default:
			p1error("cannot initialize");
			break;
		}
		if (list)
			eat(LCOMMA);
	}
	n = bytes(ty, at);
	pspace(n - size);
	return n;
}


/*
 * initialize an array
 */
static long arinit(BITS ty, ATTR *at, TERM *q, BOOL list)
{
	int i;
	LITERAL *l;
	long size;

	if ((ty == TCHAR || ty == TUCHAR) && q && (l = (LITERAL *)lookup(q->n.an, (struct symbol *)littab, NULL)))
	{
		i = l->e.l.a.m;
		pstr((char *)l->e.l.next, i - 1);
		l->op = 0; /* symbol->sc */
		if (at->a.m == 0)
			at->a.m = i;
		else if (at->a.m < i)
			p1error("string initializer too long");
		size = i;
	} else
	{
		for (size = 0, i = 0; (at->a.m == 0 || i < at->a.m) && (q || eat(LLCURLY) || (q = gexpr(FALSE))); ++i, q = NULL)
		{
			size += dinit(ty, at->next, q, list);
			if (!q)
				need(LRCURLY);
			if (list)
				eat(LCOMMA);
		}
		if (at->a.m == 0)
			at->a.m = i;
	}
	return size;
}


/*
 * initialize a data declaration
 */
void datinit(SYMBOL *p)
{
	LEX ate;
	LEX lgets;
	TERM *q;
	BOOL ndata;
	size_t bnd;

	decflag = TRUE;
	lgets = eat(LGETS);
	bnd = bound(p->ty, p->at);
	if ((q = gexpr(FALSE)) || (ate = eat(LLCURLY)) || p->sc == FSTATIC)
	{
		if (!lgets || (ate && peek(LRCURLY)))
			ndata = TRUE;
		else
			ndata = FALSE;
		if (p->sc == DEXTERN || p->sc == DSTATIC)
			nmerr("redefined", p->n.an);
		else if (p->sc == LEXTERN)
		{
			p->sc = DEXTERN;
			pdata(p->n.an, bnd, ndata);
		} else if (p->sc == LSTATIC)
		{
			p->sc = DSTATIC;
			pdata(p->n.an, bnd, ndata);
		} else if (p->sc == FSTATIC)
			pdata(lblname(p->s.label), bnd, ndata);
		dinit(p->ty, p->at, q ? q : gexpr(FALSE), !q);
		if (!q && ate && !eat(LRCURLY))
			recover("too many initializers");
		pend();
	}
	decflag = FALSE;
}

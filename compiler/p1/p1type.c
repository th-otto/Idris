/*	EXPRESSION TYPING
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

/*	the protean integer symbol
 */
static SYMBOL intsym = { NULL, NULL, { 0 }, TCHAR, 0, { 0 } };

/*	the typing tables
	0200	determine type of right operand
	0100	force scalar type for right operand
	0020	determine type of left operand
	0010	force scalar type for left operand
	0040	test left operand for lvalueness
	0004	type is max(left, right), int or double
	0002	type is max(left, right), integer
	0001	type is that of left operand
	0400	type is at least int (or double if float)
 */
static BITS tycodes[] = {
	020, 021, 0400, 030, 0430, 030, 0430,
	0431, 0431, 0431, 0771, 0771, 0400,
	0330, 0330, 0371, 0371, 0371, 0375, 0375, 0373,
	0373, 0373, 0373, 0373, 0373, 0730, 0730,
	0734, 0734, 0732, 0732, 0732, 0732, 0733, 0733,
	0730, 0730, 0730, 0730, 0730, 0730, 0730, 0730, 0151, 0
};

TINY tyops[] = {
	LSIZEOF, DADDR, DFNCALL, LPOINTS, DCAST, DINDIR, LNOT,
	LCOMP, DMINUS, DPLUS, DGPLU, DGMIN, DFNONLY,
	DELIST, LQUERY, LGETS, LGPLU, LGMIN, LGTIM, LGDIV, LGMOD,
	LGAND, LGXOR, LGOR, LGLSH, LGRSH, LPLUS, LMINUS,
	LTIMES, LDIVIDE, LMODULO, LAND, LOR, LXOR, LLSHIFT, LRSHIFT,
	LLESS, LLEQ, LGREAT, LGEQ, LISEQ, LNOTEQ, LANDAND, LOROR, DGETS, 0
};

/*
 * check whether there is a meaningful expression
 */
void docheck(TERM *q)
{
	while (q->op == DELIST)
		q = q->e.o.right;
	switch (q->op)
	{
	case DGPLU:
		q->op = LGPLU;
		break;
	case DGMIN:
		q->op = LGMIN;
		break;
	case LQUERY:
	case DFNCALL:
	case DFNONLY:
	case LGETS:
	case LGPLU:
	case LGMIN:
	case LGTIM:
	case LGDIV:
	case LGMOD:
	case LGAND:
	case LGXOR:
	case LGOR:
	case LGLSH:
	case LGRSH:
		break;
	default:
		p1error("useless expression");
	}
}


/*
 * get maximum legal type
 */
BITS maxty(BITS lty, BITS rty, BITS mty)
{
	int il;
	int ir;
	int im;

	il = _scnstr(typtab, lty);
	ir = _scnstr(typtab, rty);
	im = _scnstr(typtab, mty);
	if (im < il || im < ir)
		p1error("illegal operand type");
	else if (il < ir)
		im = ir;
	else
		im = il;
	return typtab[im];
}


/*
 * pointify q according to the type of ty,at
 */
static TERM *ptify(TERM *q, BITS ty, ATTR *at)
{
	if (tunsign < q->ty)
	{
		q = buyop(DCAST, q, NULL);
		setty((SYMBOL *)q, tunsign, NULL);
	}
	q = buyop(LTIMES, q, buyterm(tint, NULL, NULL, bytes(dety(ty), at), 0, 0));
	setty((SYMBOL *)q, tint, NULL);
	return q;
}


/*
 * make q into a scalar
 */
TERM *scalify(TERM *q)
{
	TERM *l;

	if (!q)
		return NULL;
	switch (type(q->ty))
	{
	case TARRAY:
		setty((SYMBOL *)q, (q->ty & ~3) | TPTRTO, q->at->next);
		break;
	case TFNRET:
		retype((SYMBOL *)q, TPTRTO);
		break;
	case TSTRUCT:
	case TUNION:
		p1error("illegal structure reference");
		break;
	default:
		return q;
	}
	if (!q->op)
	{
		--q->e.v.refs;
	} else
	{
		q->e.o.left = l = buyop(q->op, q->e.o.left, q->e.o.right);
		q->op = DADDR;
		l->e.o.mid = q->e.o.mid;
		l->ty = TPTRTO | (TCHAR << 2);
	}
	return q;
}


/*
 * typify a function call
 */
static void tfn(TERM *q)
{
	TERM *l;
	TERM *r;
	static ATTR fnattr;

	l = q->e.o.left;
	r = q->e.o.right;
	if (!l->op && !l->ty)
		setty((SYMBOL *)l, TFNRET | (tint << 2), &fnattr);
	else if (type(typify(l)->ty) != TFNRET)
		p1error("function required");
	else if (stype(dety(l->ty)))
		setty((SYMBOL *)q, maxify(dety(l->ty)), l->at->next);
	else
		p1error("illegal return type");
	for (; r; r = r->e.o.right)
	{
		if (r->op != DALIST)
		{
			reduce(scalify(typify(r)));
			break;
		} else
		{
			reduce(scalify(typify(r->e.o.left)));
		}
	}
}


/*
 * typify the pointsat operator
 */
static void tpoints(TERM *l, TERM *r, TERM *q)
{
	SYMBOL *p;
	SYMBOL *tab;

	tab = mostab;
	if (mflag && (l->ty == (TPTRTO | (TSTRUCT << 2)) || l->ty == (TPTRTO | (TUNION << 2))))
	{
		tab = l->at->a.stab->s.tagtab;
	} else if (mflag)
	{
		p1error("illegal member");
	} else if (itype(l->ty))
	{
		l = buyop(DCAST, l, NULL);
		setty((SYMBOL *)l, TPTRTO | (TCHAR << 2), NULL);
		q->e.o.left = l;
	} else if (!ptype(l->ty))
	{
		p1error("illegal selection");
	}
	if (!r->n.an[0])
	{
		p = &intsym;
	} else if (!(p = lookup(r->n.an, tab, NULL)))
	{
		nmerr("unknown member", r->n.an);
		p = &intsym;
	}
	q->e.o.left = buyop(LPLUS, l, r);
	setty((SYMBOL *)q->e.o.left, TPTRTO | (TCHAR << 2), NULL);
	q->op = DINDIR;
	setty((SYMBOL *)q, p->ty, p->at);
	setad(r, NULL, p->s.offset, 0, 0);
}


/*
 * determine type of ?:
 */
static void tquery(TERM *q)
{
	TERM *l;
	TERM *r;

	r = q->e.o.right;
	l = scalify(typify(q->e.o.mid));
	if (ptype(l->ty) && itype(r->ty))
		setty((SYMBOL *)q, l->ty, l->at);
	else if (itype(l->ty) && ptype(r->ty))
		setty((SYMBOL *)q, r->ty, r->at);
	else if (ptype(l->ty) && ptype(r->ty))
		setty((SYMBOL *)q, l->ty, l->at);
	else
		q->ty = maxty(l->ty, r->ty, TDOUBLE);
	q->ty = maxify(q->ty);
	if (l->ty != q->ty)
	{
		q->e.o.mid = buyop(DCAST, l, NULL);
		setty((SYMBOL *)q->e.o.mid, q->ty, q->at);
	}
	if (r->ty != q->ty)
	{
		q->e.o.right = buyop(DCAST, r, NULL);
		setty((SYMBOL *)q->e.o.right, q->ty, q->at);
	}
}


/*
 * test for reasonable unsign compare
 */
static void untest(TERM *l, TERM *r)
{
	if (iscons(r) && r->e.v.bias == 0L && (ptype(l->ty) || l->ty == TUCHAR || l->ty == TUSHORT || l->ty == TULONG))
		p1error("illegal unsigned compare");
}


/*
 * determine type of expression
 */
TERM *typify(TERM *q)
{
	TERM *l;
	TERM *r;
	int code;

	if (!q)
		return NULL;
	l = q->e.o.left;
	r = q->e.o.right;
	code = tycodes[_scnstr(tyops, q->op)];
	if (code & 0200)
		typify(r);
	if (code & 0100)
		scalify(r);
	if (code & 0020)
		typify(l);
	if (code & 0010)
		scalify(l);
	if (code & 0040)
		if (!(l->op == DINDIR || l->op == LPOINTS || (!l->op && (l->e.v.refs || (l->e.v.idx && !(l->e.v.idx & AUTIDX))))))
			p1error("lvalue required");
	if (code & 0004)
		q->ty = maxty(l->ty, r->ty, TDOUBLE);
	if (code & 0002)
		q->ty = maxty(l->ty, r->ty, TULONG);
	if (code & 0001)
		setty((SYMBOL *)q, l->ty, l->at);
	switch (q->op)
	{
	case 0:
		if (!q->ty && !decflag)
			nmerr("undeclared", q->n.an);
		break;
	case LSIZEOF:
		setad(q, NULL, bytes(l->ty, l->at), 0, 0);
		break;
	case DADDR:
		if (type(l->ty) == tfield || !(l->op == DINDIR || l->op == LPOINTS || (!l->op && l->e.v.refs)))
			p1error("illegal &");
		retype((SYMBOL *)q, TPTRTO);
		break;
	case DFNCALL:
	case DFNONLY:
		tfn(q);
		break;
	case LPOINTS:
		tpoints(l, r, q);
		break;
	case DCAST:
		if (!stype(q->ty))
		{
			p1error("illegal cast");
			setty((SYMBOL *)q, tint, NULL);
		}
		break;
	case DINDIR:
		if (type(l->ty) != TPTRTO)
			p1error("illegal indirection");
		else
			setty((SYMBOL *)q, dety(l->ty), l->at);
		break;
	case LCOMP:
		if (!itype(q->ty))
			p1error("integer type required");
		break;
	case DMINUS:
	case DPLUS:
		if (!itype(q->ty) && !dtype(q->ty))
			p1error("arithmetic type required");
		break;
	case DELIST:
		docheck(l);
		setty((SYMBOL *)q, r->ty, r->at);
		break;
	case LQUERY:
		tquery(q);
		break;
	case DGETS:
		q->op = LGETS;
		/* fall through */
	case LGETS:
		if (((ptype(l->ty) && dtype(r->ty)) || (itype(l->ty) || dtype(l->ty))) && ptype(r->ty))
			p1error("illegal assignment");
		break;
	case DGPLU:
	case DGMIN:
		if (dtype(q->ty))
			p1error("illegal postop");
		/* fall through */
	case LGPLU:
	case LGMIN:
		if (ptype(l->ty) && itype(r->ty))
			q->e.o.right = ptify(r, l->ty, l->at);
		else if (ptype(l->ty) || ptype(r->ty))
			p1error("illegal =+");
		break;
	case LPLUS:
		if (ptype(l->ty) && itype(r->ty))
		{
			q->e.o.right = ptify(r, l->ty, l->at);
			setty((SYMBOL *)q, l->ty, l->at);
		} else if (itype(l->ty) && ptype(r->ty))
		{
			q->e.o.left = ptify(l, r->ty, r->at);
			setty((SYMBOL *)q, r->ty, r->at);
		} else
		{
			q->ty = maxty(l->ty, r->ty, TDOUBLE);
		}
		break;
	case LMINUS:
		if (ptype(l->ty) && itype(r->ty))
		{
			q->e.o.right = ptify(r, l->ty, l->at);
			setty((SYMBOL *)q, l->ty, l->at);
		} else if (ptype(l->ty) && ptype(r->ty) && bytes(dety(l->ty), l->at) == bytes(dety(r->ty), r->at))
		{
			q->e.o.left = buyop(LMINUS, l, r);
			setty((SYMBOL *)q->e.o.left, tint, NULL);
			q->e.o.right = buyterm(tint, NULL, NULL, bytes(dety(l->ty), l->at), 0, 0);
			q->op = LDIVIDE;
			q->ty = tint;
		} else
		{
			q->ty = maxty(l->ty, r->ty, TDOUBLE);
		}
		break;
	case LLESS:
	case LGEQ:
	case LLEQ:
	case LGREAT:
		if (q->op == LLESS || q->op == LGEQ)
			untest(l, r);
		else
			untest(r, l);
		/* fall through */
	case LISEQ:
	case LNOTEQ:
		if ((ptype(l->ty) && itype(r->ty)) || (itype(l->ty) && ptype(r->ty)) || (ptype(l->ty) && ptype(r->ty)))
			;
		else if (ptype(l->ty) || ptype(r->ty))
			p1error("illegal comparison");
		break;
	}
	if (!q->ty)
		q->ty = tint;
	else if (code & 0400)
		q->ty = maxify(q->ty);
	return q;
}

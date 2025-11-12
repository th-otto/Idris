/*	EXPRESSION PARSER FOR PASS 1
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

/*
 * the binary operator tables
 */
static TINY binops[] = {
	LTIMES,
	LDIVIDE,
	LMODULO,
	LPLUS,
	LMINUS,
	LLSHIFT,
	LRSHIFT,
	LLESS,
	LLEQ,
	LGREAT,
	LGEQ,
	LISEQ,
	LNOTEQ,
	LAND,
	LXOR,
	LOR,
	LANDAND,
	LOROR,
	LQUERY,
	LGETS,
	LGTIM,
	LGDIV,
	LGMOD,
	LGPLU,
	LGMIN,
	LGLSH,
	LGRSH,
	LGAND,
	LGXOR,
	LGOR,
	0
};

static TINY getsops[] = {
	LGTIM, LGDIV, LGMOD, LGPLU, LGMIN, LGLSH, LGRSH,
	0, 0, 0, 0, 0, 0,
	LGAND, LGXOR, LGOR, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0
};

static TINY lpri[] = {
	14, 14, 14, 13, 13, 12, 12,
	11, 11, 11, 11, 10, 10,
	9, 8, 7, 6, 5, 3,
	1, 1, 1, 1, 1, 1, 1, 1,
	1, 1, 1
};

static TINY rpri[] = {
	14, 14, 14, 13, 13, 12, 12,
	11, 11, 11, 11, 10, 10,
	9, 8, 7, 6, 5, 4,
	2, 2, 2, 2, 2, 2, 2, 2,
	2, 2, 2
};

/*
 * the unary operator tables
 */
static TINY untoks[] = { LTIMES, LAND, LPLUS, LMINUS, LNOT, LCOMP, 0 };
static TINY unops[] = { DINDIR, DADDR, DPLUS, DMINUS, LNOT, LCOMP };


static TERM *mexpr(BOOL mand);


/*
 * build a constant and compile time evaluate
 */
long mconst(BOOL mand)
{
	TERM *q;

	if (!(q = gexpr(mand)))
		return 0;
	else if (!iscons(q))
	{
		p1error("constant required");
		return 0;
	} else
		return q->e.v.bias;
}


/*
 * make a binary operator
 */
static TERM *mbin(void)
{
	TERM *q;
	LEX gop;
	LEX op;
	TOKEN tok;

	if (!(op = alt(binops)))
		return NULL;
	if (op == LQUERY)
	{
		q = buyop(LQUERY, NULL, NULL);
		q->e.o.mid = mexpr(TRUE);
		need(LCOLON);
		return q;
	}
	if (gettok(&tok)->type != LGETS)
		baktok(&tok);
	else if ((gop = getsops[_scnstr(binops, op)]) != 0)
		op = gop & 0xff;
	else
		baktok(&tok);
	return buyop(op, NULL, NULL);
}


/*
 * make a term from an identifier
 */
static TERM *mident(char *s)
{
	SYMBOL *p;
	TERM *q;

	if (!(p = lookup(s, symtab, NULL)))
	{
		p = buysym(0, NULL, s, LEXTERN);
		p->next = symtab, symtab = p;
	}
	q = buyterm(p->ty, p->at, NULL, 0L, 0, 1);
	switch (p->sc)
	{
	case LEXTERN:
	case DEXTERN:
	case LSTATIC:
	case DSTATIC:
		cpynm(q->n.an, p->n.an);
		p->s.reg = TRUE;
		break;
	case FSTATIC:
		cpynm(q->n.an, lblname(p->s.label));
		break;
	case DARG:
		q->e.v.bias = p->s.offset;
		q->e.v.idx = ARGIDX;
		break;
	case LAUTO:
		q->e.v.bias = p->s.offset;
		q->e.v.idx = AUTIDX;
		break;
	case LREG:
		q->e.v.idx = p->s.reg;
		q->e.v.refs = 0;
		break;
	default:
		nmerr("illegal use of typedef", p->n.an);
		setty((SYMBOL *)q, tint, NULL);
		break;
	}
	return q;
}


/*
 * make an expr, expr list
 */
static TERM *melist(BOOL mand)
{
	TERM *q;

	if (!(q = mexpr(mand)))
		return NULL;
	else
	{
		while (eat(LCOMMA))
			q = buyop(DELIST, q, mexpr(TRUE));
		return q;
	}
}


/*
 * parse trailing operators of term
 */
static TERM *mtrail(TERM *q)
{
	TERM *r;
	TOKEN tok;

	for (;;)
	{
		switch (gettok(&tok)->type)
		{
		case LLPAREN:
			q = buyop(DFNCALL, q, mexpr(FALSE));
			if (q->e.o.right)
				for (r = q; eat(LCOMMA); r = r->e.o.right)
					r->e.o.right = buyop(DALIST, r->e.o.right, mexpr(TRUE));
			else
				q->op = DFNONLY;
			need(LRPAREN);
			break;
		case LLBRACK:
			q = buyop(DINDIR, buyop(LPLUS, q, melist(TRUE)), NULL);
			need(LRBRACK);
			break;
		case LPOINTS:
		case LDOT:
			q = buyop(LPOINTS, tok.type == LPOINTS ? q : buyop(DADDR, q, NULL), NULL);
			if (!ident(&tok))
			{
				p1error("missing member name");
				tok.t.an[0] = '\0';
			}
			q->e.o.right = buyterm(tint, NULL, tok.t.an, 0L, 0, 0);
			break;
		case LDECR:
		case LINCR:
			q = buyop(tok.type == LINCR ? DGPLU : DGMIN, q, buyterm(tint, NULL, NULL, 1L, 0, 0));
			break;
		default:
			baktok(&tok);
			return q;
		}
	}
}


/*
 * make a cast
 */
static TERM *mcast(void)
{
	SYMBOL *p;
	SYMBOL proto;
	TERM *t;

	if (!gscty(&proto, 0))
		return NULL;
	else
	{
		p = gdecl(&proto, TRUE);
		need(LRPAREN);
		t = (TERM *)buyop(DCAST, NULL, NULL);
		setty((SYMBOL *)t, p->ty, p->at);
		free(p);
		return t;
	}
}


/*
 * make a term
 */
static TERM *mterm(BOOL mand)
{
	TERM *q;
	LITERAL *l;
	TOKEN tok;
	static TINY lty[] = { LCNUM, LUCNUM, LSNUM, LUSNUM, LLNUM, LULNUM };
	static TINY tty[] = { TCHAR, TUCHAR, TSHORT, TUSHORT, TLONG, TULONG };

	switch (gettok(&tok)->type)
	{
	case LIDENT:
		q = mident(tok.t.an);
		break;
	case LUSNUM:
		if (TUSHORT < tint)
			tok.type = LLNUM;
		/* fall through */
	case LCNUM:
	case LUCNUM:
	case LSNUM:
	case LLNUM:
	case LULNUM:
		q = buyterm(tty[_scnstr(lty, tok.type)], NULL, NULL, tok.t.ln, 0, 0);
		break;
	case LSTRING:
		l = xmalloc(sizeof(*l));
		l->next = littab;
		littab = l;
		l->e.l.next = (ATTR *)tok.t.x.sptr;
		l->e.l.a.m = tok.t.x.slen + 1;
		setty((SYMBOL *)l, TARRAY | (tchar << 2), &l->e.l);
		l->op = FSTATIC; /* symbol->sc */
		cpynm(l->n.an, lblname(crs()));
		q = buyterm(l->ty, l->at, l->n.an, 0L, 0, 1);
		break;
	case LDNUM:
		q = buyterm(TDOUBLE, NULL, tok.t.an, 0L, 0, 0);
		break;
	case LTIMES:
	case LAND:
	case LPLUS:
	case LMINUS:
	case LNOT:
	case LCOMP:
		return buyop(unops[_scnstr(untoks, tok.type)] & 0xff, mterm(TRUE), 0);
	case LINCR:
	case LDECR:
		return buyop(tok.type == LINCR ? LGPLU : LGMIN, mterm(TRUE), buyterm(tint, NULL, NULL, 1L, 0, 0));
	case LLPAREN:
		if ((q = mcast()) != NULL)
		{
			q->e.o.left = mterm(TRUE);
		} else
		{
			q = melist(TRUE);
			need(LRPAREN);
		}
		break;
	case LSIZEOF:
		if (gettok(&tok)->type == LLPAREN && (q = mcast()))
		{
			setad(q, NULL, bytes(q->ty, q->at), 0, 0);
			setty((SYMBOL *)q, tint, NULL);
		} else
		{
			baktok(&tok);
			q = buyop(LSIZEOF, mterm(TRUE), 0);
		}
		break;
	default:
		baktok(&tok);
		if (mand)
		{
			p1error("missing expression");
			q = buyterm(tint, NULL, NULL, 0L, 0, 0);
		} else
		{
			return NULL;
		}
		break;
	}
	return mtrail(q);
}


/*
 * make an expression from binop tail
 */
static TERM *mtail(int lpr, TERM *lt, TERM **pop)
{
	TERM *rt;
	int i;
	int mpr;
	TERM *rop;

	for (rop = *pop; rop && lpr < rpri[i = _scnstr(binops, rop->op)]; *pop = rop)
	{
		mpr = lpri[i];
		rt = mterm(TRUE);
		if ((rop = mbin()) && mpr < rpri[_scnstr(binops, rop->op)])
			rt = mtail(mpr, rt, &rop);
		(*pop)->e.o.left = lt, lt = *pop;
		(*pop)->e.o.right = rt;
	}
	return lt;
}


/*
 * make an expression from tokens
 */
static TERM *mexpr(BOOL mand)
{
	TERM *q;
	TERM *r;

	if (!(q = mterm(mand)))
		return NULL;
	else if ((r = mbin()) != NULL)
		return mtail(0, q, &r);
	else
		return q;
}


/*
 * get an elist
 */
TERM *gelist(BOOL mand)
{
	exlist = frelst(exlist, NULL);
	return reduce(scalify(typify(melist(mand))));
}


/*
 * get an expression
 */
TERM *gexpr(BOOL mand)
{
	exlist = frelst(exlist, NULL);
	return reduce(scalify(typify(mexpr(mand))));
}


/*
 * get a parenthesised elist
 */
TERM *gtest(BOOL mand)
{
	TERM *q;

	need(LLPAREN);
	q = gelist(mand);
	need(LRPAREN);
	return q;
}

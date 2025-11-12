/*	FUNCTION INITIALIZING ROUTINES, PART 1
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

/*	allocation resources
 */
BITS regset = REGSET;
long autoff = 0;

/*	case tables
 */
static LABEL deflbl = 0;

/*	the return term
 */
static TERM rterm;

static TINY rettab[] = {
	INTRET, INTRET, INTRET, INTRET, INTRET, LONGRET,
	LONGRET, LONGRET, FLTRET, FLTRET, INTRET
};

static void doblock(LABEL brk, LABEL cont);


/*
 * initialize an auto
 */
static void autinit(SYMBOL *p)
{
	TERM *q;
	BOOL curly;
	TERM to;

	eat(LGETS);
	curly = eat(LLCURLY);
	if ((q = gexpr(FALSE)) != NULL)
	{
		pregs(regset);
		pauto(autoff);
		setty((SYMBOL *)&to, p->ty, p->at);
		if (p->sc == LAUTO)
			setad(&to, NULL, p->s.offset, AUTIDX, 1);
		else
			setad(&to, NULL, 0L, p->s.reg, 0);
		pmove(&to, q);
	}
	if (curly)
		need(LRCURLY);
}


/*
 * lookup an external variable
 */
static SYMBOL *lookex(const char *nm, SYMBOL *p)
{
	for (; (p = lookup(nm, p, NULL)) != NULL; p = p->next)
		if (p->sc == LEXTERN || p->sc == DEXTERN || p->sc == LSTATIC || p->sc == DSTATIC)
			return p;
	return NULL;
}


/*
 * restitch symbol table and list of attributes
 */
static void perc(SYMBOL *symsave)
{
	SYMBOL *p;
	SYMBOL *q;

	for (q = symtab, symtab = symsave; q != symsave;)
	{
		if (q->sc == LEXTERN || q->sc == LSTATIC)
		{
			p = q->next;
			q->next = symtab;
			symtab = q;
			q = p;
		} else
		{
			p = q->next;
			free(q);
			q = p;
		}
	}
}


/*
 * parse a statement
 */
static void dostat(LABEL brk, LABEL cont)
{
	CASE *r;
	SYMBOL *p;
	TERM *q;
	LABEL top;
	LABEL bot;
	LABEL mid;
	static BOOL done;					/* static to reduce recursion load */
	static LABEL inc;
	static TERM caseterm;
	static TOKEN tok;

	for (done = FALSE; !done;)
	{
		switch (gettok(&tok)->type)
		{
		case LCASE:
			casetab = listalloc(sizeof(*casetab), casetab);
			casetab->cvalue = mconst(TRUE);
			need(LCOLON);
			for (r = casetab->next; r && r != (CASE *)&casetab; r = r->next)
				if (r->cvalue == casetab->cvalue)
					break;
			if (r != (CASE *)&casetab)
				p1error("illegal case");
			casetab->clabel = pcase(crs());
			break;
		case LDFAULT:
			need(LCOLON);
			if (!casetab || deflbl)
				p1error("illegal default");
			deflbl = pcase(crs());
			break;
		default:
			if (tok.type != LIDENT || !eat(LCOLON))
				done = TRUE;
			else
			{
				if (!(p = lookup(tok.t.an, lbltab, NULL)))
				{
					p = buysym(0, NULL, tok.t.an, 0);
					p->next = lbltab, lbltab = p;
				}
				if (p->sc)
					nmerr("redefined label", p->n.an);
				p->sc = FSTATIC;
				if (!p->s.label)
					p->s.label = crs();
				plabel(p->s.label);
			}
			break;
		}
	}
	switch (tok.type)
	{
	case LLCURLY:
		doblock(brk, cont);
		break;
	case LSCOLON:
		break;
	case LIF:
		bot = pjf(gtest(FALSE), crs(), 0);
		dostat(brk, cont);
		if (eat(LELSE))
		{
			bot = pjump(0, bot);
			dostat(brk, cont);
		}
		plabel(bot);
		break;
	case LWHILE:
		top = plabel(crs());
		bot = pjf(gtest(FALSE), crs(), 0);
		dostat(bot, top);
		pjump(top, bot);
		break;
	case LDO:
		top = plabel(crs());
		dostat(bot = crs(), mid = crs());
		plabel(mid);
		need(LWHILE);
		pjt(gtest(FALSE), bot, top);
		need(LSCOLON);
		break;
	case LFOR:
		need(LLPAREN);
		if ((q = gelist(FALSE)) != NULL)
			pvoid(q);
		need(LSCOLON);
		top = plabel(crs());
		bot = pjf(gelist(FALSE), crs(), 0);
		need(LSCOLON);
		if ((q = gelist(FALSE)) != NULL)
		{
			mid = pjump(0, inc = crs());
			pvoid(q);
			pjump(top, mid);
			top = inc;
		}
		need(LRPAREN);
		dostat(bot, top);
		pjump(top, bot);
		break;
	case LBREAK:
		if (brk)
			pjump(brk, 0);
		else
			p1error("illegal break");
		need(LSCOLON);
		break;
	case LCONTIN:
		if (cont)
			pjump(cont, 0);
		else
			p1error("illegal continue");
		need(LSCOLON);
		break;
	case LRETURN:
		if ((q = gelist(FALSE)) != NULL)
			pmove(&rterm, q);
		pret();
		need(LSCOLON);
		break;
	case LGOTO:
		if (!ident(&tok))
			p1error("missing goto label");
		else if ((p = lookup(tok.t.an, lbltab, NULL)) != NULL)
			pjump(p->s.label, 0);
		else
		{
			p = buysym(0, NULL, tok.t.an, 0);
			p->next = lbltab, lbltab = p;
			p->s.label = pjump(0, 0);
		}
		need(LSCOLON);
		break;
	case LSWITCH:
		caseterm.ty = tint;
		caseterm.e.v.idx = INTRET;
		pmove(&caseterm, gtest(TRUE));
		r = casetab;
		casetab = (CASE *)&casetab; /* WTF */
		top = deflbl, deflbl = 0;
		pswitch(mid = crs());
		dostat(bot = crs(), cont);
		pswtab(&casetab, deflbl ? deflbl : bot, mid);
		pcase(bot);
		deflbl = top;
		casetab = r;
		break;
	default:
		baktok(&tok);
		if ((q = gelist(FALSE)) != NULL)
		{
			pvoid(q);
			need(LSCOLON);
		} else
		{
			recover("illegal statement");
		}
		break;
	}
}


/*
 * parse a {block}
 */
static void doblock(LABEL brk, LABEL cont)
{
	SYMBOL *p;
	SYMBOL *q;
	TINY reg;
	BOOL isfn;
	BITS regsave;
	long autsave;
	SYMBOL proto;
	SYMBOL *symsave;
	TOKEN tok;

	regsave = regset;
	autsave = autoff;
	symsave = symtab;
	while (gscty(&proto, LAUTO, LREG, LEXTERN, LSTATIC, LTYPDEF, 0))
	{
		while ((p = gdecl(&proto, FALSE)) != NULL)
		{
			isfn = type(p->ty) == TFNRET && p->sc != LTYPDEF;
			if (isfn && p->sc != LSTATIC)
				p->sc = LEXTERN;
			if ((q = lookup(p->n.an, symtab, symsave)) != NULL)
				nmerr("redeclared local", p->n.an);
			else if (!(p->sc == LEXTERN || isfn) || !(q = lookex(p->n.an, symsave)))
				p->next = symtab, symtab = p;
			else if (!q->ty)
				setty(q, p->ty, p->at);
			else if (!cmptype(p, q))
				nmerr("redeclared", p->n.an);
			if (q)
			{
				free(p);
				p = q;
			}
			if (p->sc == LTYPDEF || isfn)
				;
			else if (p->sc == LSTATIC)
			{
				p->sc = FSTATIC;
				p->s.label = crs();
				datinit(p);
			} else if (p->sc == LREG || p->sc == LAUTO)
			{
				if (p->sc == LREG && (reg = rbuy(p->ty, &regset)) != 0)
				{
					p->s.reg = reg;
					p->ty = maxify(p->ty);
				} else
				{
					p->sc = LAUTO;
					autoff -= bytes(p->ty, p->at);
					autoff &= ~((1L << bound(p->ty, p->at)) - 1L);
					p->s.offset = autoff;
				}
				autinit(p);
			}
			if (!eat(LCOMMA))
				break;
		}
		need(LSCOLON);
	}
	if (regset != regsave)
		pregs(regset);
	if (autoff != autsave)
		pauto(autoff);
	while (gettok(&tok)->type != LRCURLY)
	{
		baktok(&tok);
		if (tok.type == EOF)
		{
			p1error("unexpected EOF");
			break;
		} else
			dostat(brk, cont);
	}
	if (regset != regsave)
		pregs(regset = regsave);
	if (autoff != autsave)
	{
		autoff = autsave;
		pauto(autoff);
	}
	perc(symsave);
}


/*
 * parse function declaration
 */
BOOL fninit(SYMBOL *pd)
{
	SYMBOL *p;
	SYMBOL *q;
	BOOL defined;
	long argoff;
	SYMBOL *lcltab;
	SYMBOL proto;
	SYMBOL **qb;
	SYMBOL *symsave;
	TERM *pfn;
	TERM to;
	TINY reg;

	defined = FALSE;
	lcltab = pd->at->a.stab;
	symsave = symtab;
	while (gscty(&proto, DARG, LREG, 0))
	{
		defined = TRUE;
		for (; (p = gdecl(&proto, FALSE)); free(p))
		{
			if ((q = lookup(p->n.an, lcltab, NULL)) == NULL)
			{
				nmerr("not an argument", p->n.an);
			} else if (q->sc)
			{
				nmerr("redeclared argument", p->n.an);
			} else
			{
				setty(q, p->ty, p->at);
				q->sc = p->sc;
			}
			if (!eat(LCOMMA))
				break;
		}
		need(LSCOLON);
	}
	if (defined)
		need(LLCURLY);
	else if (eat(LLCURLY))
		defined = TRUE;
	if (!defined)
		;
	else if (pd->sc == DEXTERN || pd->sc == DSTATIC)
		nmerr("function redefined", pd->n.an);
	else
	{
		pd->sc = pd->sc == LEXTERN ? DEXTERN : DSTATIC;
		pfunc(pd->n.an);
	}
	if (defined)
	{
		setty((SYMBOL *)&rterm, maxify(dety(pd->ty)), pd->at->next);
		if (!stype(rterm.ty))
		{
			p1error("illegal return type");
			rterm.ty = tint;
		}
		rterm.e.v.idx = rettab[_scnstr(typtab, type(rterm.ty))];
		regset = iregs;
		autoff = 0;
		argoff = 0;
		for (qb = &lcltab; (q = *qb) != NULL; qb = &q->next)
		{
			if (!q->sc)
				setty(q, tint, NULL);
			else if ((q->ty & 3) == TFNRET)
				retype(q, TPTRTO);
			else if ((q->ty & 3) == TARRAY)
				setty(q, (q->ty & ~3) | TPTRTO, q->at->next);
			else
				q->ty = maxify(q->ty);
			q->s.offset = bndify(q->ty, q->at, argoff);
			argoff = q->s.offset + bytes(q->ty, q->at);
			if (q->sc == LREG && (reg = rbuy(q->ty, &regset)) != 0)
			{
				pfn = buyterm(q->ty, q->at, NULL, q->s.offset, ARGIDX, 1);
				setty((SYMBOL *)&to, q->ty, q->at);
				setad(&to, NULL, 0L, reg, 0);
				pregs(regset);
				pauto(autoff);
				pmove(&to, pfn);
				q->s.reg = reg;
			} else
			{
				q->sc = DARG;
			}
		}
		*qb = symtab;
		symtab = lcltab;
		lbltab = NULL;
		doblock(0, 0);
		pret();
		for (q = lbltab; q; q = p)
		{
			if (!q->sc)
				nmerr("missing label", q->n.an);
			p = q->next;
			free(q);
		}
		lbltab = NULL;
		perc(symsave);
		pend();
	}
	return defined;
}

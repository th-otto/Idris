/*	STARTUP CODE FOR C PASS I
 *	copyright (c) 1978 by Whitesmiths, Ltd.
 */
#include <stdlib.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>
#include "int1.h"
#include "int01.h"
#include "int12.h"
#include "int012.h"
#include "util.h"
#include "p1.h"

/*	FLAGS:
	-a	addresses and data are in different registers [yuk]
	-b#	highest enforced bound
	-c	only one case significant on externals
	-d	put non initialized data in separate class
	-e	don't put undef'd and unref'd externs
	-l	int size is 4, not 2
	-m	structure names are local
	-n#	number of significant chars in externals
	-o	output file, errors to STDOUT
	-r#	no of regs [0,7]
	-u	char strings are unsigned chars
 */
BITS iregs = REGSET;
BITS tchar = TCHAR;
BITS tfield = TSFIELD;
BITS tint = TSHORT;
BITS tunsign = TUSHORT;
BOOL aflag = FALSE;
BOOL cflag = FALSE;
BOOL dflag = FALSE;
static BOOL eflag = FALSE;
BOOL mflag = FALSE;
static BOOL uflag = FALSE;
static size_t bitswd = 16;
unsigned int bndef = 1;
unsigned int intsize = 2;
int nlen = LENNAME - 1;

const char *_pname = "p1";

/*	FILE CONTROL:
	errfd = error file
	ofile = output file
	nerrors  = the number of errors.
	infile = the current file name.
	lineno = the current line number.
 */
FILE *errfd;
static char *ofile;
int nerrors;
char *infile;
int lineno;
FILE *outfd;
FILE *infd;

/*	SYMBOL TABLES:
	casetab = the case table
	exlist = the root of the expression list
	lbltab = the label symbol table
	littab = the string and double tables
	mostab = combined structure/union table
	strtab = the structure tag table
	symend = current symbol table end
	symtab = current symbol table start
	untab = the union tag table
 */
CASE *casetab = NULL;
TERM *exlist = NULL;
SYMBOL *lbltab = NULL;
LITERAL *littab = NULL;
SYMBOL *mostab = NULL;
SYMBOL *strtab = NULL;
SYMBOL *symend = NULL;
SYMBOL *symtab = NULL;
SYMBOL *untab = NULL;


/*
 * compare the types of two symtab entries
 */
BOOL cmptype(SYMBOL *p, SYMBOL *q)
{
	ATTR *at1;
	ATTR *at2;
	BITS ty1;
	BITS ty2;

	ty1 = p->ty, ty2 = q->ty;
	at1 = p->at, at2 = q->at;
	for (; (ty1 & 3) && (ty1 & 3) == (ty2 & 3); ty1 = dety(ty1), ty2 = dety(ty2))
	{
		if ((ty1 & 3) == TPTRTO)
			;
		else if ((ty1 & 3) == TFNRET)
			at1 = at1->next, at2 = at2->next;
		else if (at1->a.m && at2->a.m && (at1->a.m != at2->a.m))
			return FALSE;
		else
			at1 = at1->next, at2 = at2->next;
	}
	if (ty1 != ty2)
		return FALSE;
	else if (ty1 != TSTRUCT && ty1 != TUNION)
		return TRUE;
	else
		return at1->a.stab == at2->a.stab;
}


/*
 * structure union parsing
 */
static ATTR *decsu(LEX lty)
{
	int boff;
	int bsize;
	SYMBOL *p;
	BOOL ffld;
	long lastoff;
	long suoff;
	SYMBOL proto;
	SYMBOL *q;
	SYMBOL **qb;
	SYMBOL *tbl;
	TOKEN tag;

	tbl = NULL;
	qb = &tbl;
	suoff = 0;
	lastoff = 0;
	boff = 0;
	ident(&tag);
	if (eat(LLCURLY))
	{
		while (!eat(LRCURLY) && gscty(&proto, 0))
		{
			while ((p = gdecl(&proto, FALSE)) || peek(LCOLON))
			{
				if (!p)
				{
					p = buysym(tint, NULL, NULL, 0);
					*qb = p;
					qb = &p->next;
				} else if (!(q = lookup(p->n.an, tbl, NULL)))
				{
					*qb = p;
					qb = &p->next;
				} else
				{
					nmerr("member redefined", p->n.an);
					free(p);
					p = q;
				}
				if (!eat(LCOLON))
				{
					boff = 0;
					ffld = TRUE;
				} else
				{
					if (lty != LSTRUCT)
						p1error("illegal field");
					bsize = mconst(TRUE);
					if (p->ty != tint && p->ty != tunsign)
						p1error("illegal bitfield");
					p->ty = tfield;
					if (bsize < 0 || (unsigned int)bsize > bitswd)
					{
						p1error("bad field width");
						bsize = bitswd;
					}
					p->at = buysat(NULL, NULL);
					p->at->a.b.bsize = bsize;
					if (bsize == 0)
					{
						boff = 0;
						ffld = FALSE;
					} else if (boff == 0 || bitswd < (unsigned int)(bsize + boff))
					{
						p->at->a.b.boff = 0;
						boff = bsize;
						ffld = TRUE;
					} else
					{
						p->at->a.b.boff = boff;
						boff += bsize;
						ffld = FALSE;
					}
				}
				if (lty == LUNION)
					p->s.offset = 0L;
				else if (!ffld)
					p->s.offset = lastoff;
				else
				{
					p->s.offset = bndify(p->ty, p->at, suoff);
					suoff = p->s.offset + bytes(p->ty, p->at);
					lastoff = p->s.offset;
				}
				if (!eat(LCOMMA))
					break;
			}
			need(LSCOLON);
		}
	}
	*qb = NULL;
	if (!mflag)
	{
		for (p = tbl; p; p = p->next)
		{
			if (!(q = lookup(p->n.an, mostab, NULL)))
			{
				q = buysym(p->ty, p->at, p->n.an, 0);
				q->s.offset = p->s.offset;
				q->next = mostab, mostab = q;
			} else if (!cmptype(p, q) || p->s.offset != q->s.offset)
			{
				nmerr("member conflict", p->n.an);
			}
		}
	}
	if (!tag.type)
	{
		p = buysym(0, NULL, NULL, 0);
		p->s.tagtab = tbl;
		if (!tbl)
			p1error("no structure definition");
	} else if (!(p = lookup(tag.t.an, lty == LSTRUCT ? strtab : untab, NULL)))
	{
		p = buysym(0, NULL, tag.t.an, 0);
		if (lty == LSTRUCT)
			p->next = strtab, strtab = p;
		else
			p->next = untab, untab = p;
		p->s.tagtab = tbl;
	} else if (tbl && !p->s.tagtab)
	{
		p->s.tagtab = tbl;
	} else if (!tbl && p->s.tagtab)
	{
		tbl = p->s.tagtab;
	} else if (tbl && p->s.tagtab)
	{
		nmerr("redefined tag", tag.t.an);
	}
	return buysat(p, NULL);
}


/*
 * parse the declaration term
 */
static SYMBOL *dterm(SYMBOL *pro, BOOL abstract)
{
	ATTR **qb;
	SYMBOL *p;
	SYMBOL *r;
	LEX lex;
	SYMBOL *table;
	TOKEN tok;
	static TINY endalt[] = { LLPAREN, LLBRACK, 0 };

	if (eat(LTIMES))
		return retype(dterm(pro, abstract), TPTRTO);
	if ((lex = eat(LLPAREN)) && (!abstract || !(lex = eat(LRPAREN))))
	{
		if (!(p = dterm(pro, abstract)))
		{
			p1error("bad (declaration)");
			p = buysym(pro->ty, pro->at, pro->n.an, pro->sc);
		}
		need(LRPAREN);
	} else if (lex == LRPAREN)
	{
		tok.type = LRPAREN;
		baktok(&tok);
		tok.type = LLPAREN;
		baktok(&tok);
		p = buysym(pro->ty, pro->at, pro->n.an, pro->sc);
	} else
	{
		ident(&tok);
		if (!tok.type && !abstract)
			return NULL;
		else
		{
			if (tok.type && abstract)
				nmerr("identifier not allowed", tok.t.an);
			p = buysym(pro->ty, pro->at, pro->n.an, pro->sc);
			cpynm(p->n.an, tok.t.an);
		}
	}
	for (qb = &p->at; *qb; qb = &(*qb)->next)
		;
	for (; (lex = alt(endalt)) != 0; qb = &(*qb)->next)
	{
		if (lex == LLPAREN)
		{
			table = NULL;
			if (ident(&tok))
				for (table = r = buysym(0, NULL, tok.t.an, 0); eat(LCOMMA);)
				{
					if (!ident(&tok))
						p1error("missing argument");
					r = r->next = buysym(0, NULL, tok.t.an, 0);
				}
			*qb = buysat(table, NULL);
			need(LRPAREN);
			retype(p, TFNRET);
		} else
		{
			*qb = buymat(mconst(FALSE), NULL);
			need(LRBRACK);
			retype(p, TARRAY);
		}
	}
	return p;
}


/*
 * parse a declaration and flip the symbol table entry
 */
SYMBOL *gdecl(SYMBOL *pro, BOOL abstract)
{
	ATTR **qb;
	int i;
	SYMBOL *p;
	ATTR *at;
	BITS nty;

	at = pro->at, pro->at = NULL;
	p = dterm(pro, abstract);
	pro->at = at;
	if (!p)
		return NULL;
	for (qb = &p->at; *qb; qb = &(*qb)->next)
		;
	*qb = at;
	for (i = 0, nty = p->ty; nty != pro->ty; ++i, nty >>= 2)
		;
	for (; 0 < i; --i, p->ty >>= 2)
		nty = (nty << 2) | (p->ty & 3);
	p->ty = nty;
	return p;
}


/*
 * get sc/ty into proto symbol
 */
BOOL gscty(SYMBOL *pro, LEX defsc, ...)
{
	LEX sc;
	LEX ty;
	LEX r;
	LEX mod;
	LEX uns;
	SYMBOL *p;
	TOKEN tok;
	va_list args;

	static BITS tutok[] = { TUCHAR, TUSHORT, TULONG, 0, 0, 0, 0, 0 };
	static BITS tytok[] = { TCHAR, TSHORT, TLONG, TFLOAT, TDOUBLE, TSTRUCT, TUNION, 0 };
	static TINY tylex[] = { LCHAR, LSHORT, LLONG, LFLOAT, LDOUBLE, LSTRUCT, LUNION, 0 };
	static TINY basalt[] = { LINT, LFLOAT, LDOUBLE, 0 };
	static TINY modalt[] = { LCHAR, LSHORT, LLONG, 0 };
	static TINY scalt[] = { LEXTERN, LSTATIC, LAUTO, LREG, LTYPDEF, 0 };
	static TINY sualt[] = { LSTRUCT, LUNION, 0 };

	clrsym(pro);
	sc = alt(scalt);
	uns = eat(LUNSIGN);
	mod = alt(modalt);
	if ((ty = alt(basalt)) != 0)
	{
		;
	} else if ((ty = alt(sualt)) != 0)
	{
		pro->at = decsu(ty);
	} else if (ident(&tok) && (p = lookup(tok.t.an, symtab, NULL)) && p->sc == LTYPDEF)
	{
		setty(pro, p->ty, p->at);
		ty = LSTRUCT;					/* innocuous, non-zero */
	} else if (tok.type)
	{
		baktok(&tok);
	}
	va_start(args, defsc);
	for (r = defsc; r && r != sc; r = va_arg(args, int))
		;
	va_end(args);
	if (r != sc)
		p1error("illegal storage class");
	pro->sc = sc ? sc : defsc;
	if (pro->ty && !mod && !uns)
		return TRUE;
	if (!ty || ty == LINT)
	{
		if (mod)
			ty = mod;
	} else if (mod == LLONG && ty == LFLOAT && !uns)
	{
		ty = LDOUBLE;
	} else if (mod || uns)
	{
		p1error("illegal type modifier");
	}
	if (!ty || ty == LINT)
		pro->ty = uns ? tunsign : tint;
	else if ((pro->ty = (uns ? tutok : tytok)[_scnstr(tylex, ty)]) == 0)
		pro->ty = tint;
	return sc || ty || uns || mod;
}


/*
 * fixup tables for long ints
 */
static void fixlint(void)
{
	size_t i = _scnstr(typtab, TPTRTO);

	bitswd = 32;
	intsize = 4;
	tfield = TLFIELD;
	tint = TLONG;
	tunsign = TULONG;
	bndtab[i] = 2;
	bytab[i] = 4;
}


/*
 * parse external declarations
 */
int main(int ac, char **av)
{
	SYMBOL *p;
	SYMBOL *q;
	BOOL prog;
	SYMBOL proto;
	static BITS ir[8] =
		/*   0  r1   r2   r3   r4/a1  r5/a2   r6/a3   r7        f(REGSET) */
	{ 0, 004, 014, 034, 04034, 014034, 034034, 034234 };
	static unsigned int nregs = 3;

	errfd = stderr;
	outfd = stdout;
	infile = buybuf("", 1);
	infd = stdin;
	getflags(&ac, &av, "a,c,d,e,l,m,n#,o*,b#,r#,u:F <file>",
		&aflag, &cflag, &dflag, &eflag, &intsize, &mflag, &nlen, &ofile, &bndef, &nregs, &uflag);
	if (intsize != 2)
		fixlint();
	bndef &= 03;
	if (uflag)
		tchar = TUCHAR;
	if (aflag)
		nregs += 3;
	iregs = ir[nregs & 7];
	if (ofile)
	{
		if ((outfd = fopen(ofile, "wb")) == NULL)
		{
			p1error("bad output file");
			return 1;
		} else
		{
			errfd = stdout;
		}
	}
	if (0 < ac)
	{
		if ((infd = fopen(av[0], "rb")) == NULL)
		{
			p1error("bad input file!");
			return 1;
		}
	}
	for (nerrors = 0; !eat(EOF);)
	{
		prog = gscty(&proto, LEXTERN, LSTATIC, LTYPDEF, 0);
		while ((p = gdecl(&proto, FALSE)) != NULL)
		{
			prog = TRUE;
			if (!(q = lookup(p->n.an, symtab, NULL)))
				p->next = symtab, symtab = p;
			else if (p->sc == LTYPDEF || q->sc == LTYPDEF)
			{
				nmerr("redeclared typedef", p->n.an);
				q = NULL;
			} else if (q->ty && !cmptype(p, q))
			{
				nmerr("redeclared external", p->n.an);
				q = NULL;
			} else if (p->sc == LSTATIC && q->sc == LEXTERN)
				q->sc = LSTATIC;
			else if (p->sc == LSTATIC && q->sc == DEXTERN)
				q->sc = DSTATIC;
			if (q)
			{
				if (!q->ty)
				{
					setty(q, p->ty, p->at);
				} else if (type(q->ty) == TARRAY)
				{
					if (!q->at->a.m)
						q->at->a.m = p->at->a.m;
				} else if (type(q->ty) == TFNRET)
				{
					q->at->a.stab = p->at->a.stab;
				}
				free(p);
				p = q;
			}
			if (p->sc == LTYPDEF)
				;
			else if (type(p->ty) != TFNRET)
				datinit(p);
			else if (fninit(p))
				break;
			if (!eat(LCOMMA))
				break;
		}
		if (!eat(LSCOLON) && !prog)
			recover("bad external syntax");
	}
	for (q = symtab; q; q = q->next)
	{
		switch (q->sc)
		{
		case LEXTERN:
			if (!eflag || q->s.reg)
				pref(q->n.an);
			exchk(q);
			break;
		case DEXTERN:
			pdef(q->n.an);
			/* fall through */
		case DSTATIC:
			exchk(q);
			break;
		case LSTATIC:
			nmerr("undefined static", q->n.an);
			break;
		}
	}
	return nerrors == 0 ? 0 : 1;
}

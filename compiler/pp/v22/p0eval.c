/*	EXPRESSION EVALUATOR FOR #IF
 *	copyright (c) 1978 by Whitesmiths, Ltd.
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <int0.h>
#include "int01.h"
#include "int012.h"
#include "util.h"
#include "pp.h"

#define ISDIGIT(c) ((c) >= '0' && (c) <= '9')


/*	escape sequences for c
 */
static char eschars[] = "btnvfrBTNVFR(!)^";	/* ASCII */

static char escodes[] = {
	010, 011, 012, 013, 014, 015, 010, 011, 012,
	013, 114, 015, 0173, 0174, 0175, 0176
};

/*	the priority tables
 */
static char ipri[] = {
	LTIMES, LDIVIDE, LMODULO, LPLUS, LMINUS, LLSHIFT, LRSHIFT,
	LLESS, LLEQ, LGREAT, LGEQ, LISEQ, LNOTEQ,
	LAND, LXOR, LOR, LANDAND, LOROR, LQUERY, 0
};

static char opri[] = {
	14, 14, 14, 13, 13, 12, 12,
	11, 11, 11, 11, 10, 10,
	9, 8, 7, 6, 5, 4
};

/*	the operator table
 */
static PRETAB optab[] = {
	{ "\1!", LNOT },
	{ "\1%", LMODULO },
	{ "\1&", LAND },
	{ "\1(", LLPAREN },
	{ "\1)", LRPAREN },
	{ "\1*", LTIMES },
	{ "\1+", LPLUS },
	{ "\1,", LCOMMA },
	{ "\1-", LMINUS },
	{ "\1.", LDOT },
	{ "\1/", LDIVIDE },
	{ "\1:", LCOLON },
	{ "\1;", LSCOLON },
	{ "\1<", LLESS },
	{ "\1=", LGETS },
	{ "\1>", LGREAT },
	{ "\1?", LQUERY },
	{ "\1[", LLBRACK },
	{ "\1]", LRBRACK },
	{ "\1^", LXOR },
	{ "\1{", LLCURLY },
	{ "\1|", LOR },
	{ "\1}", LRCURLY },
	{ "\1~", LCOMP },
	{ "\2!=", LNOTEQ },
	{ "\2&&", LANDAND },
	{ "\2(<", LLCURLY },
	{ "\2(|", LLBRACK },
	{ "\2++", LINCR },
	{ "\2--", LDECR },
	{ "\2->", LPOINTS },
	{ "\2<<", LLSHIFT },
	{ "\2<=", LLEQ },
	{ "\2=%", LGMOD },
	{ "\2=&", LGAND },
	{ "\2=*", LGTIM },
	{ "\2=+", LGPLU },
	{ "\2=-", LGMIN },
	{ "\2=/", LGDIV },
	{ "\2==", LISEQ },
	{ "\2=^", LGXOR },
	{ "\2=|", LGOR },
	{ "\2>)", LRCURLY },
	{ "\2>=", LGEQ },
	{ "\2>>", LRSHIFT },
	{ "\2\\!", LOR },
	{ "\2\\(", LLCURLY },
	{ "\2\\)", LRCURLY },
	{ "\2\\^", LCOMP },
	{ "\2|)", LRBRACK },
	{ "\2||", LOROR },
	{ "\3=<<", LGLSH },
	{ "\3=>>", LGRSH },
	{ "\3\\!!", LOROR },
};

/*	do escape character processing
 */
size_t doesc(char *buf, char *s, size_t n)
{
	char *q;
	size_t i, j;
	short sum;
	const char *p;

	q = buf;
	n = max(n, 2);
	for (i = 0; i < n; ++i)
	{
		if (*s != '\\')
		{
			*q++ = *s++;
		} else if ((p = strchr(eschars, *++s)) != NULL)
		{
			*q++ = escodes[(int)(p - eschars)];
			++s;
			++i;
		} else if (ISDIGIT(*s))
		{
			for (sum = 0, j = 0; j < 3 && ISDIGIT(*s); ++j, ++s)
				sum = (sum << 3) + (*s - '0');
			*q++ = 0xff & sum;
			i += j;
		} else if (*s == 'x' || *s == 'X')
		{
			j = _btos(++s, 3, &sum, 16);
			*q++ = 0xff & sum;
			i += j + 1;
			s += j;
		} else
		{
			*q++ = *s++;
			++i;
		}
	}
	return q - buf;					/* assert 2 <= (q - buf) */
}

/*	parse an operator
 */
LEX dopunct(TLIST **pp)
{
	int n;
	TLIST *p;
	TLIST *q;
	char buf[3];
	LEX tok;

	p = *pp;
	buf[0] = *p->text;
	for (n = 1, q = p->next; n < 3 && q->type == PPUNCT && q->nwhite == 0; ++n, q = q->next)
		buf[n] = *q->text;
	for (; 0 < n; --n)
		if ((tok = scntab(optab, sizeof(optab) / sizeof(optab[0]), buf, n)) != 0)
			break;
	if (n <= 0)
	{
		p0error("illegal character: %c", *p->text);
		*pp = p->next;
		return LPLUS;
	} else
	{
		for (; 0 < n; --n)
			p = p->next;
		*pp = p;
		return tok;
	}
}

static TLIST *expr(TLIST *p, long *plv);

/*	test for operator
 */
static LEX exop(TLIST **pp, LEX mask)
{
	LEX tok;
	TLIST *q;

	q = *pp;
	if (q->type == PPUNCT && (tok = dopunct(&q)) & mask)
	{
		*pp = q;
		return tok;
	}
	return 0;
}

/*	parse a term
 */
static TLIST *exterm(TLIST *p, long *plv)
{
	size_t n;
	char *s;
	int base;
	char sbuf[STRSIZE];
	LEX op;
	
	if (p->type == PNUM)
	{
		s = p->text;
		n = p->ntext;
		if (*s != '0')
		{
			base = 10;
		} else if (1 < n && (s[1] == 'x' || s[1] == 'X'))
		{
			base = 16;
			s += 2;
			n -= 2;
		} else
		{
			base = 8;
		}
		if (_btol(s, n, plv, base) != n)
		{
			p0error("illegal number in #if");
			*plv = 0;
		}
		return p->next;
	} else if (p->type == PCHCON)
	{
		s = &sbuf[1];
		n = doesc(sbuf, p->text, p->ntext) - 2;
		for (*plv = 0; n; ++s, --n)
			*plv = (*plv << 8) | (*s & 0xff);
		return p->next;
	} else if (punct(p, '('))
	{
		if (!(p = expr(p->next, plv)))
			return NULL;
		else if (!punct(p, ')'))
		{
			p0error("missing ) in #if");
			return NULL;
		} else
			return p->next;
	} else if (!(op = exop(&p, UNOP)))
	{
		p0error("illegal #if syntax");
		return NULL;
	} else if (!(p = exterm(p, plv)))
	{
		return NULL;
	} else
	{
		if (op == LMINUS)
			*plv = -*plv;
		else if (op == LNOT)
			*plv = (*plv == 0);
		else if (op == LCOMP)
			*plv = ~*plv;
		else if (op != LPLUS)
			p0error("illegal unary op in #if");
		return p;
	}
}


/*	compute operator priority
 */
static int expri(LEX op)
{
	char *p;
	
	if (!op || (p = strchr(ipri, op)) == NULL)
		return 0;
	return opri[(int)(p - ipri)];
}

/*	parse a DTB... tail
 */
static TLIST *extail(int lpr, long *plv, LEX *pop, TLIST *p)
{
	int mpr;
	LEX op;
	long lv;
	long mv;
	long rv;
	LEX rop;

	for (rop = *pop; lpr < (mpr = expri(rop)); *pop = rop)
	{
		if (!(p = exterm(p, &rv)))
			;
		else if (mpr < expri(rop = exop(&p, BINOP)))
			p = extail(mpr, &rv, &rop, p);
		if (!p)
			return NULL;
		op = *pop;
		lv = *plv;
		mv = lv - rv;
		switch (op)
		{
		case LPLUS:
			lv += rv;
			break;
		case LMINUS:
			lv = mv;
			break;
		case LTIMES:
			lv *= rv;
			break;
		case LDIVIDE:
			lv /= rv;
			break;
		case LMODULO:
			lv %= rv;
			break;
		case LAND:
			lv &= rv;
			break;
		case LOR:
			lv |= rv;
			break;
		case LXOR:
			lv ^= rv;
			break;
		case LLSHIFT:
			lv <<= rv;
			break;
		case LRSHIFT:
			lv >>= rv;
			break;
		case LLESS:
			lv = (mv < 0);
			break;
		case LISEQ:
			lv = (mv == 0);
			break;
		case LGREAT:
			lv = (mv > 0);
			break;
		case LLEQ:
			lv = (mv <= 0);
			break;
		case LNOTEQ:
			lv = (mv != 0);
			break;
		case LGEQ:
			lv = (mv >= 0);
			break;
		case LANDAND:
			lv = (lv && rv);
			break;
		case LOROR:
			lv = (lv || rv);
			break;
		case LQUERY:
			if (!punct(p, ':') || !(p = expr(p->next, &mv)))
			{
				p0error("illegal ? : in #if");
				return NULL;
			} else if (lv)
			{
				lv = rv;
			} else
			{
				lv = mv;
			}
			break;
		default:
			p0error("illegal operator in #if");
			return NULL;
		}
		*plv = lv;
	}
	return p;
}

/*	parse a (sub)expression
 */
static TLIST *expr(TLIST *p, long *plv)
{
	LEX op;

	if (!(p = exterm(p, plv)))
		return NULL;
	else if ((op = exop(&p, BINOP)) != 0)
		return extail(0, plv, &op, p);
	else
		return p;
}

/* evaluate an expression
 */
BOOL eval(TLIST *p)
{
	long lv;

	if (!(p = expr(p, &lv)))
		return FALSE;
	if (p->type != PEOL)
	{
		p0error("illegal #if expression");
		return FALSE;
	}
	return lv != 0;
}

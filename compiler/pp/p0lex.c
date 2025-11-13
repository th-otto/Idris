/*	LEXICAL ANALYSIS FOR C
 *	copyright (c) 1978 by Whitesmiths, Ltd.
 */
#ifdef __GNUC__
# define _GNU_SOURCE
# define _dtento(x, exp) ((x) * exp10(exp))
#endif
#include <stdlib.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include "int0.h"
#include "int01.h"
#include "int012.h"
#include "util.h"
#include "pp.h"

#ifdef __GNUC__
# define _dtento(x, exp) ((x) * exp10(exp))
#endif

/*	the keyword table
 */
#define NKEYS	27
static PRETAB keytab[NKEYS] = {
	{ "\2do", LDO },
	{ "\2if", LIF },
	{ "\3for", LFOR },
	{ "\3int", LINT },
	{ "\4auto", LAUTO },
	{ "\4case", LCASE },
	{ "\4char", LCHAR },
	{ "\4else", LELSE },
	{ "\4goto", LGOTO },
	{ "\4long", LLONG },
	{ "\5break", LBREAK },
	{ "\5float", LFLOAT },
	{ "\5short", LSHORT },
	{ "\5union", LUNION },
	{ "\5while", LWHILE },
	{ "\6double", LDOUBLE },
	{ "\6extern", LEXTERN },
	{ "\6return", LRETURN },
	{ "\6sizeof", LSIZEOF },
	{ "\6static", LSTATIC },
	{ "\6struct", LSTRUCT },
	{ "\6switch", LSWITCH },
	{ "\7default", LDFAULT },
	{ "\7typedef", LTYPDEF },
	{ "\10continue", LCONTIN },
	{ "\10register", LREG },
	{ "\10unsigned", LUNSIGN }
};


/*
 * find first non-base digit
 */
static size_t firnon(char *s, int n, int base)
{
	int dig, i;

	for (i = 0; i < n; ++i, ++s)
	{
		if (ISDIGIT(*s))
			dig = *s - '0';
		else if (ISUPPER(*s))
			dig = *s + (10 - 'A');
		else if (ISLOWER(*s))
			dig = *s + (10 - 'a');
		else
			break;
		if (base <= dig)
			break;
	}
	return i;
}


/*
 * accumulate double number
 */
static size_t flaccum(char *s, double *pd, int nd)
{
	int n;

	for (n = 0; n < nd && ISDIGIT(*s); ++n, ++s)
		*pd = *pd * 10.0 + (*s - '0');
	return n;
}


/*
 * put lexeme for '...'
 */
static TLIST *lexchars(TLIST *p)
{
	size_t i, n;
	int32_t lo;
	char sbuf[STRSIZE];
	char ty;

	n = doesc(sbuf, p->text, p->ntext) - 2;
	for (i = (n < 4) ? 1 : n - 3, lo = 0; i <= n; ++i)
		lo = (lo << 8) | (sbuf[i] & 0xff);
	switch (n)
	{
	case 0:
		ty = LCNUM;
		break;
	case 1:
		ty = 0 <= sbuf[1] ? LCNUM : LSNUM;
		break;
	case 2:
		ty = 0 <= sbuf[1] ? LSNUM : LUSNUM;
		break;
	default:
		ty = lo < 0 ? LULNUM : LLNUM;
		break;
	}
	putcode("c4", ty, &lo);
	return p->next;
}


/*
 * move to next lexeme for floating constant if necessary
 */
static char *lexfnxt(TLIST **pp, char *s)
{
	TLIST *p;

	p = *pp;
	if (p->text + p->ntext <= s)
	{
		p = p->next;
		*pp = p;
		return p->text;
	} else
		return s;
}


/*
 * put out floating constant
 */
static TLIST *lexfloat(TLIST *p)
{
	size_t n;
	char *s;
	BOOL minus;
	int exp;
	short x;
	double dnum;
	
	s = p->text;
	dnum = 0.0;
	s += flaccum(s, &dnum, p->ntext);
	s = lexfnxt(&p, s);
	if (*s == '.')
	{
		p = p->next, s = p->text;
		n = flaccum(s, &dnum, p->ntext);
		exp = -n;
		s += n;
	} else
	{
		exp = 0;
	}
	s = lexfnxt(&p, s);
	if (*s == 'e' || *s == 'E')
	{
		++s;
		s = lexfnxt(&p, s);
		minus = FALSE;
		if (*s == '+')
		{
			++s;
		} else if (*s == '-')
		{
			++s;
			minus = TRUE;
		}
		s = lexfnxt(&p, s);
		s += _btos(s, p->ntext - (s - p->text), &x, 10);
		if (minus)
			exp -= x;
		else
			exp += x;
	}
	dnum = _dtento(dnum, exp);
	putcode("c8", LDNUM, &dnum);
	if (s == p->text)
		;
	else if (p->text + p->ntext == s)
		p = p->next;
	else
	{
		p = p->next;
		p0error("illegal float constant");
	}
	return p;
}


/*
 * put lexeme for identifier or keyword
 */
static TLIST *lexident(TLIST *p)
{
	size_t n;
	LEX tok;

	n = min(p->ntext, LENNAME);
	if ((tok = scntab(keytab, NKEYS, p->text, n)) != 0)
		putcode("c", tok);
	else
		putcode("ccb", LIDENT, n, p->text, (int)n);
	return p->next;
}


/*
 * put a long or integer constant
 */
static TLIST *lexint(TLIST *p, int base, size_t nskip)
{
	BOOL issigned;
	size_t n;
	int snum;
	int unum;
	long lnum;
	int32_t inum;
	char cnum, ty;

	issigned = base == 10;

	n = p->ntext - nskip;
	if (_btol(p->text + nskip, n, &lnum, base) < n)
		p0error("illegal constant %s", p->text);
	unum = (unsigned long) lnum >> 16;
	snum = lnum;
	cnum = snum;
	if (p->text[p->ntext - 1] == 'l' || p->text[p->ntext - 1] == 'L' || (issigned && snum != lnum) || (!issigned && unum))
		ty = (issigned || 0 <= lnum) ? LLNUM : LULNUM;
	else if ((issigned && cnum != snum) || (!issigned && (snum & ~0xff)))
		ty = (issigned || 0 <= snum) ? LSNUM : LUSNUM;
	else
		ty = (issigned || 0 <= cnum) ? LCNUM : LSNUM;
	inum = lnum;
	putcode("c4", ty, &inum);
	return p->next;
}


/*
 * put lexeme for integer or float
 */
static TLIST *lexnum(TLIST *p)
{
	size_t n;

	n = firnon(p->text, p->ntext, 10);
	if (punct(p, '.') || (n < p->ntext && (p->text[n] == 'e' || p->text[n] == 'E')) || punct(p->next, '.'))
		return lexfloat(p);
	else if (p->text[0] != '0')
		return lexint(p, 10, 0);
	else if (1 < p->ntext && (p->text[1] == 'x' || p->text[1] == 'X'))
		return lexint(p, 16, 2);
	else
		return lexint(p, 8, 1);
}


/*
 * put lexeme for punctuation
 */
static TLIST *lexpunct(TLIST *p)
{
	putcode("c", dopunct(&p));
	return p;
}


/*
 * put lexeme for "..."
 */
static TLIST *lexstring(TLIST *p)
{
	int16_t n;
	char sbuf[STRSIZE];

	n = doesc(sbuf, p->text, p->ntext) - 2;
	putcode("c2b", LSTRING, &n, &sbuf[1], n);
	return p->next;
}


/*
 * put lexemes to stdout
 */
void putcode(const char *fmt, ...)
{
	const char *f;
	char *q;
	int i;
	va_list args;
	
	va_start(args, fmt);
	for (f = fmt; *f; ++f)
	{
		if (*f == 'c')
		{
			putchar(va_arg(args, int) & 0xff);
		} else
		{
			q = va_arg(args, char *);
			i = *f == 'b' ? va_arg(args, int) : *f == 'p' ? (int)strlen(q) : *f - '0';
			while (0 <= --i)
				putchar(*q++ & 0xff);
		}
	}
	va_end(args);
}


/*
 * put a line without #'s
 */
void putls(TLIST *p)
{
	TLIST *q;
	static int xlno;

	if (!xflag)
	{
		if (!v6flag)
		{
			;
		} else if (pincl->fname)
		{
			fputs("\1", stdout);
		} else
		{
			while (++xlno < pincl->nline)
				fputs("\n", stdout);
		}
		for (q = p;; q = q->next)
		{
			fwrite(q->white, q->nwhite, 1, stdout);
			if (!q->next)
				break;
			fwrite(q->text, q->ntext, 1, stdout);
		}
		fputs("\n", stdout);
	} else
	{
		if (p->type != PEOL)
		{
			if (pincl)
			{
				int16_t nline = pincl->nline;
				putcode("c2", LLINENO, &nline);
			}
			if (pflag)
			{
				pflag = FALSE;
				if (pincl)
					putcode("ccp", LIFILE, pincl->fname ? (int)strlen(pincl->fname) : 0, pincl->fname ? pincl->fname : "");
			}
		}
		for (; p->type != PEOL;)
		{
			if (p->type == PIDENT)
				p = lexident(p);
			else if (p->type == PSTRING)
				p = lexstring(p);
			else if (p->type == PCHCON)
				p = lexchars(p);
			else if (p->type == PNUM || (punct(p, '.') && p->next->type == PNUM))
				p = lexnum(p);
			else
				p = lexpunct(p);
		}
	}
}

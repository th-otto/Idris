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
static PRETAB const keytab[] = {
	{ "\2do", LDO },
	{ "\2if", LIF },
	{ "\3for", LFOR },
	{ "\3int", LINT },
	{ "\4auto", LAUTO },
	{ "\4case", LCASE },
	{ "\4char", LCHAR },
	{ "\4else", LELSE },
	{ "\4enum", LENUM },
	{ "\4goto", LGOTO },
	{ "\4long", LLONG },
	{ "\4void", LVOID },
	{ "\5break", LBREAK },
	{ "\5const", LCONST },
	{ "\5float", LFLOAT },
	{ "\5short", LSHORT },
	{ "\5union", LUNION },
	{ "\5while", LWHILE },
	{ "\6double", LDOUBLE },
	{ "\6extern", LEXTERN },
	{ "\6return", LRETURN },
	{ "\6signed", LSIGNED },
	{ "\6sizeof", LSIZEOF },
	{ "\6static", LSTATIC },
	{ "\6struct", LSTRUCT },
	{ "\6switch", LSWITCH },
	{ "\7$noside", LNOSIDE },
	{ "\7default", LDFAULT },
	{ "\7typedef", LTYPDEF },
	{ "\10continue", LCONTIN },
	{ "\10register", LREG },
	{ "\10unsigned", LUNSIGN },
	{ "\10volatile", LVOLATILE },
};


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
	char sbuf[STRSIZE + 2];

	n = dobesc(sbuf, p->text, p->ntext);
	for (i = (n < 4) ? 1 : n - 3, lo = 0; i <= n; ++i)
		lo = (lo << 8) | (sbuf[i] & 0xff);
	putcode("c4", n <= 1 ? LCNUM : LSNUM, &lo);
	return p->next;
}


static char space[] = " ";

/*
 * move to next lexeme for floating constant if necessary
 */
static char *lexfnxt(TLIST **pp, char *s)
{
	TLIST *p;

	p = *pp;
	if (p->text != space && p->text + p->ntext <= s)
	{
		p = p->next;
		*pp = p;
		return p->nwhite != 0 ? space : p->text;
	}
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
	int ty;

	s = p->text;
	dnum = 0.0;
	s += flaccum(s, &dnum, p->ntext);
	s = lexfnxt(&p, s);
	if (*s == '.')
	{
		s = lexfnxt(&p, s + 1);
		n = flaccum(s, &dnum, p->ntext);
		exp = -n;
		s += n;
		s = lexfnxt(&p, s);
	} else
	{
		exp = 0;
	}
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
		x = 0;
		while (ISDIGIT(*s))
		{
			x = x * 10 + *s - '0';
			s++;
		}
		if (minus)
			exp -= x;
		else
			exp += x;
	}
	dnum = _dtento(dnum, exp);
	s = lexfnxt(&p, s);
	if (*s == 'l' || *s == 'L')
	{
		s++;
		ty = LDLDOUBLE;
	} else if (*s == 'f' || *s == 'F')
	{
		s++;
		ty = LDFLOAT;
	} else
	{
		ty = LDDOUBLE;
	}
	putcode("c8", ty, &dnum);
	if (s == space)
	{
		;
	} else if (s == p->text)
	{
		;
	} else if (p->text + p->ntext == s)
	{
		p = p->next;
	} else
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
	if (n == escname[0] && memcmp(p->text, escname + 1, n) == 0 && p->next->type == PIDENT)
		tok = 0;
	else
		tok = scntab(keytab, sizeof(keytab) / sizeof(keytab[0]), p->text, n);
	if (tok != 0)
		putcode("c", tok);
	else
		putcode("ccb", LIDENT, (int)n, p->text, (int)n);
	return p->next;
}


/*
 * put a long or integer constant
 */
static TLIST *lexint(TLIST *p)
{
	BOOL islong;
	BOOL isunsigned;
	int32_t inum;
	char ty;

	inum = bton(p, &islong, &isunsigned);
	if (islong)
		ty = (isunsigned || inum < 0) ? LULNUM : LLNUM;
	else
		ty = isunsigned ? LUSNUM : LSNUM;
	putcode("c4", ty, &inum);
	return p->next;
}


#if 0 /* no longer used */
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
#endif


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
	char sbuf[STRSIZE + 2];

	n = dobesc(sbuf, p->text, p->ntext);
	putcode("c2b", LSTRING, &n, &sbuf[1], n);
	return p->next;
}


/*
 * put lexeme for "...", including leading whitespace
 */
static TLIST *lexxstring(TLIST *p)
{
	int16_t n;

	n = p->nwhite + p->ntext;
	putcode("c2bb", LSTRING, &n, p->white, (int)p->nwhite, p->text, (int)p->ntext);
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
			fputc(va_arg(args, int) & 0xff, outfd);
		} else
		{
			q = va_arg(args, char *);
			i = *f == 'b' ? va_arg(args, int) : *f == 'p' ? (int)strlen(q) : *f - '0';
			while (0 <= --i)
				fputc(*q++ & 0xff, outfd);
		}
	}
	va_end(args);
}


/* XXX V3.2 different */
void putfile(void)
{
	if (xflag && pincl != NULL && pflag && (!inincl || liflag) && pasline == 0)
	{
		pflag = FALSE;
		if (pincl->fname == NULL)
			putcode("cc", LIFILE, 0);
		else
			putcode("ccp", LIFILE, (int)strlen(pincl->fname), pincl->fname);
	} else
	{
#if 0
		/* new in V 3.2 */
		if (cplusflag && pincl && pflag && !xflag)
		{
			pflag = FALSE;
			if (pincl->fname != NULL)
			{
				fprintf(outfd, "# %u \"%s\"\n", pincl->nline != 0 ? pincl->nline : pincl->nline + 1, pincl->fname);
			}
			lastln = pincl->nline;
		}
#endif
	}
}


void ptline(void)
{
	if (pincl && xflag && pasline == 0 && (liflag || !inincl))
	{
		int16_t nline = pincl->nline;
		putcode("c2", LLINENO, &nline);
	}
}


static void putlin(const char *s, size_t len)
{
	fwrite(s, len, 1, outfd);
}


/*
 * find occurrence in buffer of character in set
 */
static size_t inbuf(register const char *is, register size_t n, const char *p)
{
	register const char *pscan;
	register const char *iscan;
	
	iscan = is;
	while (n != 0)
	{
		pscan = p;
		do
		{
			if (*iscan == *pscan)
				return iscan - is;
			pscan++;
		} while (*pscan != 0);
		n--;
		iscan++;
	}
	return iscan - is;
}


/*
 * put a line without #'s
 */
void putls(TLIST *p)
{
	TLIST *q;
	int pquote;
	size_t n;

	if (!xflag)
	{
		pquote = 0;
		for (q = p; q; q = q->next)
		{
			if ((pquote == 0 && q->type == PQSTRING) ||
				(pquote != 0 && q->type != PQSTRING))
			{
				pquote = !pquote;
				putlin("\"", 1);
			}
			putlin(q->white, q->nwhite);
			putlin(q->text, q->ntext);
		}
	} else
	{
		q = p;
		while (q->type == PQEOL)
			q = q->next;
		putfile();
		ptline();
		for (;;)
		{
			if (p->type == PEOL)
				break;
			switch (p->type)
			{
			case PIDENT:
				p = lexident(p);
				break;
			case PSTRING:
				p = lexstring(p);
				break;
			case PQSTRING:
				p = lexxstring(p);
				break;
			case PCHCON:
				p = lexchars(p);
				break;
			case PNUM:
                if ((p->next->nwhite == 0 && p->next->ntext == 1 && p->next->text[0] == '.' &&
                    ((p->next->next == NULL || p->next->next->nwhite != 0 ||
                      p->next->next->ntext != 1 || p->next->next->text[0] != '.'))) ||
                   (((n = inbuf(p->text, p->ntext, "eExX")) < p->ntext &&
                    ((p->text[n] == 'e' || (p->text[n] == 'E'))))))
                {
                	p = lexfloat(p);
                } else
                {
					p = lexint(p);
                }
				break;
			case PQEOL:
				p = p->next;
				break;
			default:
				if (p->ntext == 1 && p->text[0] == '.' && p->next->nwhite == 0 && p->next->type == PNUM)
				{
					p = lexfloat(p);
				} else
				{
					p = lexpunct(p);
				}
				break;
			}
		}
	}
}

/*	INPUT FOR PASS 1
 *	copyright (c) 1978 by Whitesmiths, Ltd.
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "int1.h"
#include "int01.h"
#include "util.h"
#include "p1.h"

/*	token stacking mechanism
 */
#define NTOKQ	3

static int ntoks = 0;
static TOKEN tokstk[NTOKQ];

/*
 * is the next token any of a set?
 */
LEX alt(TINY *p)
{
	LEX lex;
	TOKEN tok;

	gettok(&tok);
	if (!(lex = p[_scnstr(p, tok.type)]))
		baktok(&tok);
	return lex & 0xff;
}


/*
 * put a token back onto the input stream stack
 */
void baktok(TOKEN *t)
{
	if (ntoks < NTOKQ)
	{
		cpytok(&tokstk[ntoks++], t);
	} else
	{
		p1error("!TOKEN OVERFLOW");
		exit(1);
	}
}


/*
 * eat a token from input stream
 */
LEX eat(LEX lex)
{
	TOKEN tok;

	if (gettok(&tok)->type != lex)
	{
		baktok(&tok);
		return 0;
	} else
		return lex;
}


/*
 * get a char buffered
 */
static int getch(void)
{
	return fgetc(infd);
}


/*
 * need a character; if EOF complain and exit
 */
static int needc(void)
{
	int c;

	if ((c = getch()) == EOF)
	{
		p1error("!EOF");
		exit(1);
	}
	return c;
}


/*
 * get a series of characters
 */
static void getstr(void *_s, int n)
{
	char *s = _s;
	for (; 0 < n; --n)
		*s++ = needc();
}


/*
 * get a token from STDIN
 */
static TOKEN *gtok(TOKEN *t)
{
	int n;
	char *f;

	while ((t->type = getch()) == LLINENO || t->type == LIFILE)
	{
		if (t->type == LLINENO)
		{
			short nline;
			getstr(&nline, 2);
			lineno = nline;
		} else
		{
			n = needc();
			f = xmalloc(n + 1);
			getstr(f, n);
			f[n] = '\0';
			free(infile);
			infile = f;
		}
	}
	if (t->type == EOF || !t->type)
	{
		t->type = EOF;
	} else if ((t->type & MASK) != CONS)
	{
		;
	} else
	{
		switch (t->type)
		{
		case LDNUM:
			getstr(&t->t.dn, sizeof(t->t.dn));
			break;
		case LIDENT:
			if (LENNAME < (n = needc()))
				n = LENNAME;
			getstr(t->t.an, n);
			while (n < LENNAME)
				t->t.an[n++] = '\0';
			break;
		case LCNUM:
		case LUCNUM:
		case LSNUM:
		case LUSNUM:
		case LLNUM:
		case LULNUM:
			getstr(&t->t.ln, 4);
			break;
		case LSTRING:
			getstr(&t->t.x.slen, 2);
			t->t.x.sptr = xmalloc(t->t.x.slen);
			getstr(t->t.x.sptr, t->t.x.slen);
			break;
		default:
			p1error("!BAD CHAR");
			exit(1);
		}
	}
	return t;
}


/*
 * get a token from the stack or input
 */
TOKEN *gettok(TOKEN *t)
{
	if (0 < ntoks)
		return cpytok(t, &tokstk[--ntoks]);
	else
		return gtok(t);
}


/*
 * if the next token is an identifier return it
 */
TOKEN *ident(TOKEN *t)
{
	if (gettok(t)->type != LIDENT)
	{
		baktok(t);
		t->type = 0;
		return NULL;
	}
	return t;
}


/*
 * need a particular token
 */
LEX need(LEX lex)
{
	static TINY neelex[] = { LLPAREN, LRPAREN, LSCOLON, LCOLON, LLCURLY, LRCURLY, LWHILE, LRBRACK, 0 };
	static const char *neestr[] = { "(", ")", ";", ":", "{", "}", "while", "]", "???" };

	if (!eat(lex))
	{
		nmerr("missing", neestr[_scnstr(neelex, lex)]);
		return 0;
	}
	return lex;
}


/*
 * put error message and name
 */
void nmerr(const char *s, const char *name)
{
	fprintf(errfd, "%s%s%d: %s %s\n", infile, infile[0] ? " " : "", lineno, s, name);
	++nerrors;
}


/*
 * peek ahead in the input stream
 */
LEX peek(LEX lex)
{
	TOKEN tok;

	baktok(gettok(&tok));
	return tok.type == lex ? lex : 0;
}


/*
 * put out error message
 */
void p1error(const char *s)
{
	fprintf(errfd, "%s%s%d: %s\n", infile, infile[0] ? " " : "", lineno, s);
	++nerrors;
}


/*
 * recover to the next valid token and put out error msg
 */
void recover(const char *s)
{
	TOKEN tok;

	p1error(s);
	while (gettok(&tok)->type != EOF && tok.type != LSCOLON)
		if (tok.type == LRCURLY)
			return;
	baktok(&tok);
}

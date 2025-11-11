/*	DEFINE/INCLUDE PREPROCESSOR FOR C
 *	copyright (c) 1978 by Whitesmiths, Ltd.
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "int0.h"
#include "util.h"
#include "pp.h"

/*	DATA FLOW:
	getl(line)->
	getln(logical line)-> getin(includes)->
	getex(expanded)-> main()-> putgr(if group)->
	putns(non skipped)-> putls(less sharps)-> lex
 */
/*	FLAGS:
	-c => don't drop comments, continues.
	-d name => define name as 1.
	-i name => change prefix for < > files.
	-o name => output to name, errors to STDERR
	-px => use x instead of #.
	-sx => use x in addition to px.
	-x => put lexemes, not lines.
	-6 => put SOH, extra newlines for v6 compiler
 */
static BOOL cflag = FALSE;
static ARGS pdefs = { NDARGS, { NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL } };
static char *ofile = NULL;
BOOL xflag = FALSE;
BOOL v6flag = FALSE;
char pchar = '#';
static char schar = '@';
char *iprefix = "|";
const char *_pname = "pp";

/*	FILE CONTROL:
	argc = no of file args left
	argv => next filename
	errfd = error file
	pincl-> current I/O structure
	nerrors = no of errors seen
	pflag => name has changed
*/
char **argv = NULL;
int argc = 0;
FILE *errfd;
INCL *pincl = NULL;
int nerrors = 0;
BOOL pflag = FALSE;

/*	the table of predefined #keywords
 */
#define NPPS	18
static PRETAB pptab[] = {
	{ "\2IF", PIF },
	{ "\2if", PIF },
	{ "\4ELSE", PELSE },
	{ "\4LINE", PLINE },
	{ "\4else", PELSE },
	{ "\4line", PLINE },
	{ "\5ENDIF", PENDIF },
	{ "\5IFDEF", PIFDEF },
	{ "\5UNDEF", PUNDEF },
	{ "\5endif", PENDIF },
	{ "\5ifdef", PIFDEF },
	{ "\5undef", PUNDEF },
	{ "\6DEFINE", PDEFINE },
	{ "\6IFNDEF", PIFNDEF },
	{ "\6define", PDEFINE },
	{ "\6ifndef", PIFNDEF },
	{ "\7INCLUDE", PINCLUD },
	{ "\7include", PINCLUD }
};

/*
 * get a full line into the I/O buffer
 *		sans continuations and comments
 */
static char *getln(INCL *pi)
{
	int i;
	FILE *pf;
	char *s;
	int j, k;
	static char buf[BUFSIZ];
	char strchar;
	char *savs;

	strchar = '\0';
	s = buf;
	pf = pi->pfio;
	while (fgets(buf, BUFSIZ, pf) != NULL)
	{
		i = strlen(buf);
		if (!cflag && *s == '\\' && 1 < i && s[1] == '\n')
		{
			++pi->nline;
			if (fgets(s, BUFSIZ - (s - buf), pf) == NULL)
				i = 0;
			else
				i = (int)strlen(s);
			for (savs = s; 0 < i && *s != '\n' && ISWHITE(*s); --i)
				++s;
			if (savs != s)
			{
				memmove(savs, s, i);
				s = savs;
			}
		} else if (!cflag && *s == '\\')
		{
			s += 2;
			i -= 2;
		} else if (!cflag && !strchar && *s == '/' && 1 < i && s[1] == '*')
		{
			for (j = 2; j < i - 1; ++j)
				if (s[j] == '*' && s[j + 1] == '/')
					break;
			if (j < i - 1)
			{
				*s++ = ' ';
				i -= j + 2;
				for (k = 0; k < i; ++k)
					s[k] = s[k + j + 1];
			} else if (fgets(s + 2, BUFSIZ - (s + 2 - buf), pf) == NULL)
			{
				p0error("missing */");
				break;
			} else
			{
				++pi->nline;
				i = (int)strlen(s);
			}
		} else if (*s == '\n')
		{
			++pi->nline;
			return buf;
		} else
		{
			if (!cflag && (*s == '"' || *s == '\''))
			{
				if (strchar == *s)
					strchar = '\0';
				else if (!strchar)
					strchar = *s;
			}
			++s;
			--i;
		}
	}
	if (s == buf)
		return NULL;
	else
	{
		p0error("truncated line");
		buf[BUFSIZ - 1] = '\n';
		return buf;
	}
}


/*
 * get an included line, as a token list
 */
static TLIST *getincl(void)
{
	char *s;

	for (;;)
	{
		if (!pincl)
			pincl = nxtfile();
		if (!pincl)
			return NULL;
		if ((s = getln(pincl)) != NULL)
		{
			return stotl(s);
		} else
		{
			INCL *next;
			
			fclose(pincl->pfio);
			free(pincl->fname);
			next = pincl->next;
			free(pincl);
			pincl = next;
			pflag = TRUE;
		}
	}
}


void *frelst(void *p, void *plast)
{
	while (p != NULL && p != plast)
	{
		void *next = *((void **)p);
		free(p);
		p = next;
	}
	return p;
}


/*
 * get an expanded token list
 */
static TLIST *getex(void)
{
	TLIST *p;
	LEX tok;

	if ((p = getincl()) != NULL)
	{
		if (punct(p, pchar) || punct(p, schar))
		{
			if ((tok = scntab(pptab, sizeof(pptab) / sizeof(pptab[0]), p->next->text, p->next->ntext)) != 0)
			{
				TLIST *next;
				
				next = p->next;
				free(p);
				p = next;
				p->type = tok;
			} else
			{
				p->type = PSHARP;
			}
		}
		switch (p->type)
		{
		case PDEFINE:
		case PUNDEF:
		case PINCLUD:
		case PSHARP:
			break;
		case PIFDEF:
		case PIFNDEF:
			if (p->next->type != PIDENT)
				p0error("bad #%s", p->text);
			else if (!lookup(p->next->text, p->next->ntext))
				p->next = frelst(p->next, NULL);
			break;
		default:
			p = doexp(p);
			break;
		}
	}
	return p;
}


/*
 * put a non skipped token line
 */
static void putns(TLIST *p)
{
	char *fname;
	TLIST *q;
	FILE *fd;

	switch (p->type)
	{
	case PDEFINE:
		if (p->next->type != PIDENT)
			p0error("bad #define");
		else
		{
			for (q = p->next; q->next; q = q->next)
				;
			install(p->next->text, p->next->ntext, buybuf(p->next->next->white, q->text + q->ntext - p->next->next->white));
		}
		break;
	case PUNDEF:
		if (p->next->type != PIDENT)
			p0error("bad #undef");
		else
			undef(p->next->text, p->next->ntext);
		break;
	case PINCLUD:
		if (!(fname = getfname(p->next)))
		{
			p0error("bad #include");
		} else if ((fd = fopen(fname, "r")) == NULL)
		{
			p0error("can't #include %s", fname);
			free(fname);
		} else
		{
			INCL *incl;
			
			incl = xmalloc(sizeof(*pincl));
			incl->next = pincl;
			incl->fname = fname;
			incl->nline = 0;
			incl->pfio = fd;
			pincl = incl;
			pflag = TRUE;
		}
		break;
	case PLINE:
		if (p->next->type != PNUM)
		{
			p0error("bad #line");
		} else
		{
			int i;
			
			_btoi(p->next->text, p->next->ntext, &i, 10);
			pincl->nline = i;
			if ((fname = getfname(p->next->next)) != NULL)
			{
				pflag = TRUE;
				if (pincl->fname)
					free(pincl->fname);
				pincl->fname = fname;
			}
		}
		break;
	case PSHARP:
		if (p->next->type != PEOL)
			p0error("bad #xxx");
		break;
	default:
		putls(p);
		break;
	}
	frelst(p, NULL);
}


/*
 * put an if group
 */
static TLIST *putgr(TLIST *p, BOOL skip)
{
	BOOL doit;

	while (p && p->type != PELSE && p->type != PENDIF)
	{
		if (p->type != PIF && p->type != PIFDEF && p->type != PIFNDEF)
		{
			if (skip)
				frelst(p, NULL);
			else
				putns(p);
			p = getex();
		} else
		{
			if (p->type == PIF)
				doit = skip ? FALSE : eval(p->next);
			else if (p->type == PIFDEF)
				doit = (p->next != 0);
			else
				doit = (p->next == 0);
			frelst(p, NULL);
			p = putgr(getex(), skip || !doit);
			if (p && p->type == PELSE)
			{
				frelst(p, NULL);
				p = putgr(getex(), skip || doit);
			}
			if (p && p->type == PENDIF)
			{
				frelst(p, NULL);
				p = getex();
			} else
				p0error("missing #endif");
		}
	}
	return p;
}


/*
 * expand define/include/if, perform lexical analysis
 */
int main(int ac, char **av)
{
	TLIST *p;

	argv = av;
	argc = ac;
	errfd = stderr;
	getflags(&argc, &argv, "c,d*>i*,o*,p?,s?,x,6:F <files>",
		&cflag, &pdefs, &iprefix, &ofile, &pchar, &schar, &xflag, &v6flag);
	if ((pincl = nxtfile()) != NULL)
		predef(&pdefs);
	if (ofile)
	{
		if ((stdout = freopen(ofile, xflag ? "wb" : "w", stdout)) == NULL)
		{
			p0error("bad output file");
		} else
		{
			errfd = stdout;
		}
	}
	while ((p = putgr(getex(), FALSE)) != NULL)
	{
		p0error("misplaced #%s", p->text);
		frelst(p, NULL);
	}
	fclose(stdout);
	return nerrors == 0 ? 0 : 1;
}

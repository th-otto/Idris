/*	DEFINE/INCLUDE PREPROCESSOR FOR C
 *	copyright (c) 1978 by Whitesmiths, Ltd.
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "int0.h"
#include "int01.h"
#include "int012.h"
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
static ARGS pdefs = { NDARGS, { NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL } };
static char *ofile = NULL;
BOOL errflag = FALSE;
BOOL liflag = FALSE;
BOOL oldflag = FALSE;
BOOL pasflag = FALSE;
BOOL stdflag = FALSE;
BOOL xflag = FALSE;
static int pchar = '#';
static int schar = 0;
int inif = 0;
int inincl = 0;
unsigned char escname[] = "\4$esc";
char *iprefix = "|";
char *mapfile = NULL;
const char *_pname = "pp";
int pasline = 0;
int lastln = 0;
BOOL cplusflag = FALSE;


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
int lineno = 0;
FILE *errfd;
FILE *outfd;
INCL *pincl = NULL;
int nerrors = 0;
BOOL pflag = FALSE;

/*	the table of predefined #keywords
 */
static PRETAB const pptab[] = {
	{ "\2IF", PIF },
	{ "\2if", PIF },
	{ "\4ELIF", PELIF },
	{ "\4ELSE", PELSE },
	{ "\4LINE", PLINE },
	{ "\4elif", PELIF },
	{ "\4else", PELSE },
	{ "\4line", PLINE },
	{ "\5ENDIF", PENDIF },
	{ "\5ERROR", PERROR },
	{ "\5IFDEF", PIFDEF },
	{ "\5UNDEF", PUNDEF },
	{ "\5endif", PENDIF },
	{ "\5error", PERROR },
	{ "\5ifdef", PIFDEF },
	{ "\5undef", PUNDEF },
	{ "\6DEFINE", PDEFINE },
	{ "\6IFNDEF", PIFNDEF },
	{ "\6PRAGMA", PPRAGMA },
	{ "\6define", PDEFINE },
	{ "\6ifndef", PIFNDEF },
	{ "\6pragma", PPRAGMA },
	{ "\7INCLUDE", PINCLUD },
	{ "\7include", PINCLUD }
};

/*
 * get a full line into the I/O buffer
 *		sans continuations
 */
static size_t getln(INCL *pi, char *buf, size_t maxlen)
{
	int i;
	FILE *pf;
	char *s;
	
	s = buf;
	pf = pi->pfio;
	for (;;)
	{
		if ((size_t)(s - buf + 2) > maxlen)
		{
			p0error("line too long");
			break;
		}
		if (fgets(s, maxlen - (s - buf), pf) == NULL)
			break;
		++pi->nline;
		lineno = pi->nline;
		i = (int)strlen(s);
		s += i;
		if (i < 1 || s[-2] != '\\' || s[-1] != '\n')
			break;
		s -= 2;
	}
	*s = '\0';
	if (s == buf)
		return 0;
	if (s < &buf[maxlen])
		return s - buf;
	p0error("folded line");
	buf[maxlen] = '\n';
	buf[maxlen + 1] = '\0';
	return maxlen + 1;
}


/*
 * get an included line, as a token list
 */
#define LINEBUFSIZE 4096
static TLIST *getinl(BOOL contline)
{
	size_t n;
	static char linebuf[LINEBUFSIZE];
	static size_t bufstart;
	static BOOL in_comment;

	if (!contline)
		bufstart = 0;
	for (;;)
	{
		if (!pincl)
		{
			pincl = nxtfile();
			putfile();
		}
		if (!pincl)
			return NULL;
		if ((n = getln(pincl, linebuf + bufstart, LINEBUFSIZE - bufstart)) != 0)
		{
			bufstart += n;
			return stotl(linebuf + bufstart - n, &in_comment);
		} else if (in_comment)
		{
			p0error("unbalanced comment in file");
			in_comment = FALSE;
			return stotl("\n", NULL);
		} else
		{
			INCL *next;
			
			++pincl->nline;
			ptline();
			fclose(pincl->pfio);
			free(pincl->fname);
			next = pincl->next;
			free(pincl);
			pincl = next;
			pflag = TRUE;
			putfile();
			if (inincl != 0)
				--inincl;
		}
	}
}


/*
 * get an expanded token list
 */
TLIST *getex(BOOL flag)
{
	TLIST *p;
	LEX tok;

	if ((p = getinl(flag)) != NULL)
	{
		if (PUNCT(p, pchar) || PUNCT(p, schar))
		{
			if (flag)
			{
				p0error("#line inside macro");
			}
			if ((tok = scntab(pptab, sizeof(pptab) / sizeof(pptab[0]), p->next->text, p->next->ntext)) != 0)
			{
				p = fretlist(p, p->next);
				p->type = tok;
			} else
			{
				p->type = PSHARP;
			}
		}
		switch (p->type)
		{
		case PINCLUD:
			p = doexp(p, NULL);
			break;
		case PDEFINE:
		case PUNDEF:
		case PSHARP:
			break;
		case PIF:
		case PELIF:
			++inif;
			p = doexp(p, NULL);
			--inif;
			break;
		case PIFDEF:
		case PIFNDEF:
			if (p->next->type != PIDENT)
			{
				p0error("bad #%.*s", (int)p->ntext, p->text);
			} else if (!lookup(p->next->text, p->next->ntext, NULL))
			{
				if (scntab(bltintab, 3, p->next->text, p->next->ntext) == 0) /* excludes __LINE__ */
					p->next = fretlist(p->next, NULL);
			}
			break;
		default:
			if (!flag)
				p = doexp(p, NULL);
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
	TLIST *qend;
	FILE *fd;
	int lineno;
	int16_t len;
	char *pasname;
	char *pd;

	switch (p->type)
	{
	case PERROR:
		for (q = p; q->type != PEOL; q = q->next)
			;
		if (!xflag)
		{
			fputc('#', outfd);
			putls(p);
		} else
		{
			if (!oldflag)
			{
				/* +2 to include leading and terminating quote */
				len = q->text - p->text + 2;
				putcode("c2b", LERROR, &len, p->text - 1, len);
			}
		}
		break;
	case PDEFINE:
		if (p->next->type != PIDENT)
		{
			p0error("bad #define");
		} else
		{
			for (q = p->next; q->next; q = q->next)
				;
			len = q->text + q->ntext - p->next->next->white;
			if (!stdflag || (pd = lookup(p->next->text, p->next->ntext, NULL)) == NULL)
			{
				install(p->next->text, p->next->ntext, buybuf(p->next->next->white, len));
			} else
			{
				if (memcmp(pd, p->next->next->white, len) != 0)
					p0error("redefined %.*s", (int)p->next->ntext, p->next->text);
			}
		}
		break;
	case PUNDEF:
		if (p->next->type != PIDENT)
			p0error("bad #undef");
		else
			undef(p->next->text, p->next->ntext);
		break;
	case PINCLUD:
		fname = getfinclude(p->next);
		if ((fd = fopen(fname, "r")) == NULL)
		{
			p0error("can't #include %s", fname);
			free(fname);
		} else
		{
			INCL *incl;
			
			ptline();
			pflag = TRUE;
			lastln = 0;
			putfile();
			incl = xmalloc(sizeof(*pincl));
			incl->next = pincl;
			incl->fname = fname;
			incl->nline = 0;
			incl->pfio = fd;
			pincl = incl;
			pflag = TRUE;
			++inincl;
			putfile();
		}
		break;
	case PLINE:
		if (PUNCT(p->next, '='))
		{
			if (!xflag)
			{
				p->text--;
				p->ntext++;
				putls(p);
			} else
			{
				q = p->next->next;
				qend = q;
				while (!PUNCT(qend, ':') && qend->type != PEOL)
					qend = qend->next;
				if (qend != q)
				{
					pasline = 0;
					pasname = buybuf(q->text, qend->text - q->text + 1);
					pasname[qend->text - q->text] = '\0';
					pflag = TRUE;
					if (pincl->fname != NULL)
						free(pincl->fname);
					pincl->fname = pasname;
					putfile();
				}
				qend = qend->next;
				lineno = bton(qend, NULL, NULL);
				pincl->nline = lineno;
				pasline = 0;
				ptline();
				pasline = 1;
			}
		} else if (p->next->type != PNUM)
		{
			p0error("bad #line");
		} else
		{
			lineno = bton(p->next, NULL, NULL);
			pincl->nline = lineno;
			q = p->next->next;
			if (q->type != PEOL)
			{
				if (q->type == PSTRING)
				{
					pasname = buybuf(q->text + 1, q->ntext - 1);
					pasname[q->ntext - 2] = '\0';
					pflag = TRUE;
					if (pincl->fname)
						free(pincl->fname);
					pincl->fname = pasname;
					q = q->next;
				}
				if (q->type != PEOL)
					p0error("bad #line syntax");
				if (!xflag)
				{
					p->text -= 1;
					p->ntext += 1;
					putls(p);
				}
			}
		}
		break;
	case PPRAGMA:
		if (!xflag)
		{
			p->text -= 1;
			p->ntext += 1;
			putls(p);
		} else
		{
			putcode("c", LPRAGMA);
			putls(p->next);
			putcode("c", LPRAGMA);
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
	fretlist(p, NULL);
}


/*
 * put an if group
 */
static TLIST *putgr(TLIST *p, BOOL skip)
{
	BOOL doit;

	while (p && p->type != PELSE && p->type != PENDIF && p->type != PELIF)
	{
		if (p->type != PIF && p->type != PIFDEF && p->type != PIFNDEF)
		{
			if (skip)
				fretlist(p, NULL);
			else
				putns(p);
			p = getex(FALSE);
		} else
		{
			if (p->type == PIF)
				doit = skip ? FALSE : eval(p->next);
			else if (p->type == PIFDEF)
				doit = (p->next != 0);
			else
				doit = (p->next == 0);
			fretlist(p, NULL);
			p = putgr(getex(FALSE), skip || !doit);
			while (p && p->type == PELIF)
			{
				if (!doit)
				{
					doit = skip ? FALSE : eval(p->next);
					fretlist(p, NULL);
					p = putgr(getex(FALSE), skip || !doit);
				} else
				{
					fretlist(p, NULL);
					p = putgr(getex(FALSE), skip || doit);
				}
			}
			if (p && p->type == PELSE)
			{
				fretlist(p, NULL);
				p = putgr(getex(FALSE), skip || doit);
			}
			if (p && p->type == PENDIF)
			{
				fretlist(p, NULL);
				p = getex(FALSE);
			} else
			{
				p0error("missing #endif");
			}
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
	outfd = stdout;
	getflags(&argc, &argv, "+cplus,d*>err,i*,+lincl,+map*,+old,o*,+pas,p?,+std,s?,x:F <files>",
		&cplusflag, &pdefs, &errflag, &iprefix, &liflag, &mapfile, &oldflag, &ofile, &pasflag, &pchar, &stdflag, &schar, &xflag);
	if (ofile)
	{
		if ((outfd = fopen(ofile, xflag ? "wb" : "w")) == NULL)
		{
			p0error("can't create %s", ofile);
		} else
		{
			errfd = stdout;
		}
	}
	if (xflag && !oldflag)
	{
		putcode("c", P1MAGIC);
		putcode("ccp", LIFILE, (int)strlen(argv[argc - 1]), argv[argc - 1]);
	}
	if (argc == 0)
		pincl = inpfile(stdin, "-");
	else
		pincl = nxtfile();
	putfile();
	predef(&pdefs);
#if SUPPORT_CMAP
	if (mapfile != NULL)
	{
		FILE *fp;
		
		if ((fp = fopen(mapfile, "rb")) == NULL)
		{
			fatal("can't open map file: %s", mapfile);
		} else
		{
			if (fread(cmap, 1, 256, fp) != 256)
			{
				fatal("can't read map file: %s", mapfile);
			}
			fclose(fp);
		}
	}
#endif
	while ((p = putgr(getex(FALSE), FALSE)) != NULL)
	{
		p0error("misplaced #%.*s", (int)p->ntext, p->text);
		fretlist(p, NULL);
	}
	fclose(outfd);
	return nerrors == 0 /* || !errflag */ ? 0 : 1;
}

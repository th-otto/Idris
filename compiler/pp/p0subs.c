/*	DEFINE/INCLUDE SUBROUTINES
 *	copyright (c) 1978 by Whitesmiths, Ltd.
 */
#include <stdlib.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>
#include "int0.h"
#include "util.h"
#include "pp.h"

/*
 * the hash table definitions
 */
static DEF *htable[NHASH];

/*
 * allocate a new token for the tlist and copy a previous into it
 */
static TLIST *buytl(TLIST *p, TLIST *link)
{
	TLIST *q;

	q = xmalloc(sizeof(*q));
	q->type = p->type;
	q->white = p->white;
	q->nwhite = p->nwhite;
	q->text = p->text;
	q->ntext = p->ntext;
	q->next = link;
	return q;
}


/*
 * expand a single define line
 */
static TLIST *dodef(TLIST *pd, TLIST *qn, ALIST *args)
{
	TLIST **qb;
	TLIST *r;
	TLIST *s;
	ALIST *pa;
	int i;
	int nargs;
	TLIST *pe;
	TLIST *px;
	TLIST *qs;

	qb = &qs;
	nargs = 0;
	if (pd->nwhite || !punct(pd, '('))
	{
		r = pd;
	} else
	{
		r = pd->next;
		if (r->type == PIDENT)
		{
			nargs = 1;
			r = r->next;
		}
		while (r && !punct(r, ')'))
		{
			if (punct(r, ',') && r->next->type == PIDENT)
			{
				r = r->next->next;
				++nargs;
			} else
			{
				r = NULL;
			}
		}
		if (!r)
		{
			p0error("bad #define arguments");
			r = pd;
		} else
		{
			r = r->next;
		}
	}
	for (pe = r; r->type != PEOL;)
	{
		if (r->type == PIDENT)
		{
			for (s = pd->next, i = 0; i < nargs; ++i)
			{
				if (r->ntext == s->ntext && memcmp(r->text, s->text, s->ntext) == 0)
					break;
				s = s->next->next;
			}
		}
		if (r->type == PIDENT && i < nargs)
		{
			for (pa = args; 0 < i && pa; --i)
				pa = pa->next;
			if (pa)
			{
				for (px = pa->astart; px != pa->aend; px = px->next)
				{
					*qb = buytl(px, r->next);
					if (px == pa->astart)
					{
						(*qb)->white = r->white;
						(*qb)->nwhite = r->nwhite;
					}
					qb = &(*qb)->next;
				}
			}
			s = r->next;
			free(r);
			r = s;
		} else
		{
			*qb = r;
			qb = &(*qb)->next;
			r = r->next;
		}
	}
	while (pd != pe)
	{
		s = pd->next;
		free(pd);
		pd = s;
	}
	*qb = qn;
	return qs;
}


/*
 * get an argument list
 */
static TLIST *getargs(TLIST *ip, ALIST **ap)
{
	ALIST **qb;
	ALIST *q;
	TLIST *p;
	int npar;

	p = ip;
	for (qb = ap, p = p->next; p && !punct(p, ')'); qb = &q->next)
	{
		*qb = q = xmalloc(sizeof(**ap));
		q->next = NULL;
		q->astart = p;
		for (npar = 0; p && (0 < npar || (!punct(p, ',') && !punct(p, ')'))); p = p->next)
		{
			if (punct(p, '('))
				++npar;
			else if (punct(p, ')'))
				--npar;
		}
		if (p)
		{
			q->aend = p;
			if (punct(p, ','))
				p = p->next;
		}
	}
	if (p)
	{
		return p->next;
	} else
	{
		p0error("bad macro arguments");
		*ap = NULL;
		return ip;
	}
}


/*
 * expand #defines in a line of tokens
 */
TLIST *doexp(TLIST *qs)
{
	TLIST *pd;
	TLIST *q;
	TLIST **qb;
	ALIST *args;
	char *s;
	TLIST *qn;

	for (qb = &qs; (q = *qb) != NULL;)
	{
		if (q->type != PIDENT || !(s = lookup(q->text, q->ntext)) ||
			(*s == '(' && (q->next->nwhite || !punct(q->next, '('))))
		{
			qb = &q->next;
		} else
		{
			pd = stotl(s);
			args = NULL;
			if (*s == '(')
				qn = getargs(q->next, &args);
			else
				qn = q->next;
			*qb = dodef(pd, qn, args);
			if (*qb != qn)
			{
				(*qb)->white = q->white;
				(*qb)->nwhite = q->nwhite;
			}
			frelst(args, NULL);
			frelst(q, qn);
		}
	}
	return qs;
}


/*
 * get an included file name
 */
char *getfname(TLIST *p)
{
	char *q;
	char *s;
	size_t n;
	size_t i;
	char *pp;
	FILE *fd;

	if (p->type == PIDENT)
	{
		q = buybuf(p->text, p->ntext + 1);	/* DIRTY */
		q[p->ntext] = '\0';
	} else if (p->type == PSTRING)
	{
		q = buybuf(p->text + 1, p->ntext - 1);
		q[p->ntext - 2] = '\0';
	} else if (punct(p, '<'))
	{
		for (s = p->next->text; *s != '>' && !ISWHITE(*s); ++s)
			;
		n = s - p->next->text;
		q = xmalloc(strlen(iprefix) + n + 1);
		for (s = iprefix; *s; s += (s[i]) ? i + 1 : i)
		{
			pp = strchr(s, '|');
			if (pp == NULL)
				i = strlen(s);
			else
				i = pp - s;
			memcpy(q, s, i);
			memcpy(q + i, p->next->text, n);
			q[i + n] = '\0';
			if ((fd = fopen(q, "r")) != NULL)
			{
				fclose(fd);
				break;
			}
		}
	} else
	{
		q = NULL;
	}
	return q;
}


/*
 * hash into symbol table
 */
static DEF **hash(char *s, size_t n)
{
	int sum;

	for (sum = 0; 0 < n; --n)
		sum += *s++;
	return &htable[sum % NHASH];
}


/*
 * install definition in symbol table
 */
void install(char *s, size_t n, char *pd)
{
	DEF **qb;
	DEF *q;

	n = min(n, LENNAME);
	qb = hash(s, n);
	q = xmalloc(sizeof(*q));
	q->next = *qb;
	*qb = q;
	memcpy(q->dname, s, n);
	q->dnlen = n;
	q->defn = pd;
}


/*
 * lookup a definition in symbol table
 */
char *lookup(char *s, size_t n)
{
	DEF *q;

	n = min(n, LENNAME);
	for (q = *hash(s, n); q; q = q->next)
		if (n == q->dnlen && memcmp(s, q->dname, n) == 0)
			return q->defn;
	return NULL;
}


/*
 * get next file argument
 */
INCL *nxtfile(void)
{
	FILE *fd;
	INCL *pi;
	char *fname;

	for (;;)
	{
		if (argc == 0)
			return NULL;
		fname = *argv++;
		argc--;
		if (strcmp(fname, "-") == 0)
			fd = stdin;
		else if ((fd = fopen(fname, "r")) == NULL)
			p0error("can't open %s", fname);
	}
	pi = xmalloc(sizeof(*pi));
	pi->next = NULL;
	if (fd == stdin)
	{
		pi->fname = NULL;
	} else
	{
		pi->fname = xmalloc(strlen(fname) + 1);
		strcpy(pi->fname, fname);
	}
	pflag = TRUE;
	pi->nline = 0;
	pi->pfio = fd;
	return pi;
}


/*
 * put the argument defines into the buffer
 */
static void pargs(const char *s, int n)
{
#if 0
	FIO *p;

	p = &pincl->pfio;
	for (; 0 < n && p->_nleft < (BUFSIZ - 1); --n, ++p->_nleft)
		if ((p->_buf[p->_nleft] = *s++) == '\n')
			--pincl->nline;
	if (0 < n && p->_nleft < BUFSIZ)
	{
		p->_buf[p->_nleft++] = '\n';
		p0error("too many -d arguments");
	}
	p->_pnext = p->_buf;
#else
	(void)s;
	(void)n;
#endif
}


/*
 * put an error message with line numbers
 */
void p0error(const char *fmt, ...)
{
	va_list args;
	
	if (!pincl)
		fprintf(errfd, "EOF: ");
	else if (!pincl->fname)
		fprintf(errfd, "%d: ", pincl->nline);
	else
		fprintf(errfd, "%s %d: ", pincl->fname, pincl->nline);
	va_start(args, fmt);
	vfprintf(errfd, fmt, args);
	va_end(args);
	fputs("\n", errfd);
	++nerrors;
}


/*
 * install predefined args
 */
void predef(ARGS *p)
{
	int i;
	char *s;
	char *n;
	char pch = pchar;

	for (i = 0; (int)p->ntop < NDARGS - i; ++i)
	{
		s = p->anames[(NDARGS - 1) - i];
		pargs(&pch, 1);
		pargs("define ", 7);
		n = strchr(s, '=');
		if (n == NULL)
		{
			pargs(s, strlen(s));
			pargs(" 1", 2);
		} else
		{
			pargs(s, n - s);
			pargs(" ", 1);
			s = n + 1;
			pargs(s, strlen(s));
		}
		pargs("\n", 1);
	}
}


/*
 * is this a punctuation mark
 */
BOOL punct(TLIST *p, char c)
{
	return p->ntext == 1 && *p->text == c;
}


/*
 * scan a table of predefined strings
 */
LEX scntab(PRETAB *p, size_t hi, char *s, size_t n)
{
	size_t j;
	const char *q;
	const char *r;
	size_t i, lo;
	int x;

	for (lo = 0; lo < hi;)
	{
		i = (hi + lo) >> 1;
		r = p[i].prename;
		if (!(x = *r++ - n))
			for (j = 0, q = s; j < n; ++j)
				if ((x = *r++ - *q++) != 0)
					break;
		if (x < 0)
			lo = i + 1;
		else if (x == 0)
			return p[i].pretype;
		else
			hi = i;
	}
	return 0;
}


/*
 * convert a line to token list
 */
TLIST *stotl(char *s)
{
	TLIST *q;
	TLIST **qb;
	TLIST *qs;

	qb = &qs;
	for (;;)
	{
		q = xmalloc(sizeof(*q));
		q->next = NULL;
		q->white = s;
		while (*s != '\0' && ISWHITE(*s) && *s != '\n')
			++s;
		q->nwhite = s - q->white;
		q->text = s;
		if (*s == '\n' || *s == '\0')
		{
			++s;
			q->type = PEOL;
		} else if (ISALPHA(*s) || *s == '_' || (LENNAME != 8 && *s == '$'))
		{
			while (ISALPHA(*s) || *s == '_' || (LENNAME != 8 && *s == '$') || ISDIGIT(*s))
				++s;
			q->type = PIDENT;
		} else if (ISDIGIT(*s))
		{
			while (ISALPHA(*s) || ISDIGIT(*s))
				++s;
			q->type = PNUM;
		} else if (*s == '"' || *s == '\'')
		{
			for (; *++s != *q->text && *s != '\n';)
			{
				if (*s == '\\' && s[1] != '\n')
					++s;
				else if (*s == '\\')
					break;
			}
			if (*s == *q->text)
				++s;
			else
				p0error("unbalanced %c", *q->text);
			q->type = *q->text == '"' ? PSTRING : PCHCON;
			if (STRSIZE < s - q->text)
			{
				p0error("string too long");
				q->text = s - STRSIZE;
			}
		} else
		{
			++s;
			q->type = PPUNCT;
		}
		q->ntext = s - q->text;
		*qb = q;
		qb = &q->next;
		if (q->type == PEOL)
			return qs;
	}
}


/*
 * remove latest definiton of a symbol
 */
void undef(char *s, size_t n)
{
	DEF **qb;
	DEF *q;

	n = min(n, LENNAME);
	for (qb = hash(s, n); (q = *qb) != NULL; qb = &q->next)
		if (n == q->dnlen && memcmp(s, q->dname, n) == 0)
			break;
	if (q)
	{
		free(q->defn);
		*qb = q->next;
		free(q);
	}
}

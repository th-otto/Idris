/*	DEFINE/INCLUDE SUBROUTINES
 *	copyright (c) 1978 by Whitesmiths, Ltd.
 */
#include <stdlib.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>
#include <stddef.h>
#include <limits.h>
#include "int0.h"
#include "int012.h"
#include "util.h"
#include "pp.h"

#if SUPPORT_CMAP
unsigned char cmap[256] = {
	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
	0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
	0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
	0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f,
	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
	0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f,
	0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
	0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f,
	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57,
	0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f,
	0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
	0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f,
	0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77,
	0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f,
	0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
	0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
	0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97,
	0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f,
	0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7,
	0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf,
	0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7,
	0xb8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf,
	0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,
	0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf,
	0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7,
	0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xdf,
	0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7,
	0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef,
	0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
	0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff
};
#endif

PRETAB const bltintab[] = {
	{ "\3$if", PBIF },
	{ "\7defined", PBDEFINED },
	{ "\10__FILE__", PBFILE },
	{ "\10__LINE__", PBLINE },
};

static TLIST *free_tlist;
static TLIST tcomma = { NULL, PPUNCT, NULL, 0, ",", 1 };


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

	if (free_tlist != NULL)
	{
		q = free_tlist;
		free_tlist = q->next;
	} else
	{
		q = xmalloc(sizeof(*q));
	}
	q->next = link;
	q->type = 0;
	q->white = 0;
	q->nwhite = 0;
	q->text = 0;
	q->ntext = 0;
	if (p != NULL)
	{
		q->type = p->type;
		q->white = p->white;
		q->nwhite = p->nwhite;
		q->text = p->text;
		q->ntext = p->ntext;
	}
	return q;
}


static TLIST *doif(TLIST *pd, ALIST *args)
{
	ALIST *pa;
	TLIST *p;
	TLIST **qb;
	long value;
	TLIST *qs;

	qb = &qs;
	if (args == NULL)
	{
		p0error("$if expects arguments");
	} else if (expr(args->astart, &value) != args->aend)
	{
		p0error("bad $if(test)");
	} else if (value != 0)
	{
		for (pa = args->next; pa != NULL; pa = pa->next)
		{
			for (p = pa->astart; p != pa->aend; p = p->next)
			{
				*qb = buytl(p, pd);
				qb = &(*qb)->next;
			}
			if (pa->next != NULL)
			{
				*qb = buytl(&tcomma, pd);
				qb = &(*qb)->next;
			}
		}
	}
	*qb = pd;
	return qs;
}


/*
 * is this a punctuation mark
 */
BOOL punct(TLIST *p, char c)
{
	return p->ntext == 1 && p->text[0] == c;
}


/*
 * get an argument list
 */
static TLIST *getargs(TLIST *ip, ALIST **ap, BOOL forif)
{
	ALIST **qb;
	ALIST *q;
	TLIST *p;
	TLIST *ipstart;
	TLIST *pstart;
	int npar;

	ipstart = p = ip;
	for (qb = ap, p = p->next; p && !PUNCT(p, ')'); qb = &q->next)
	{
		*qb = q = xmalloc(sizeof(**ap));
		q->next = NULL;
		q->astart = p;
		for (pstart = ipstart, npar = 0; p && (0 < npar || (!PUNCT(p, ',') && !PUNCT(p, ')'))); p = p->next)
		{
			if (PUNCT(p, '('))
				++npar;
			else if (PUNCT(p, ')'))
				--npar;
			else if (p->type == PEOL && (p->next = getex(TRUE)) != NULL)
				p->type = PQEOL;
		}
		if (p)
		{
			q->aend = p;
			if (PUNCT(p, ','))
			{
				ipstart = p;
				p = p->next;
			}
			if (forif)
				inif++;
			q->astart = doexp(pstart, q->aend);
			if (forif)
			{
				inif--;
				forif = FALSE;
			}
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
 * expand a builtin define
 */
TLIST *builtin(TLIST **pargs, TLIST *pd);

TLIST *builtin(TLIST **pargs, TLIST *pd)
{
	LEX tok;
	ALIST *ap;
	TLIST *args;
	static char linenobuf[30];

	if ((tok = scntab(bltintab, sizeof(bltintab) / sizeof(bltintab[0]), pd->text, pd->ntext)) == 0)
		return pd;
	switch (tok)
	{
	case PBIF:
		if (pd->next->ntext == 1 && pd->next->text[0] == '(')
		{
			ap = NULL;
			args = getargs(pd->next, &ap, TRUE);
			*pargs = doif(args, ap);
			if (*pargs != args)
			{
				(*pargs)->white = pd->white;
				(*pargs)->nwhite = pd->nwhite;
			}
			frelst(ap, NULL);
			fretlist(pd, args);
		}
		break;
	
	case PBFILE:
		pd->nwhite = 0;
		pd->ntext = pincl->fname ? strlen(pincl->fname) : 0;
		pd->type = PQSTRING;
		pd->text = pincl->fname;
		break;
	
	case PBLINE:
		pd->ntext = sprintf(linenobuf, "%u", pincl->nline);
		pd->type = PNUM;
		pd->text = linenobuf;
		break;
	
	case PBDEFINED:
		if (inif != 0)
		{
			if (pd->next->type == PIDENT)
			{
				pd->ntext = 1;
				pd->type = PNUM;
				pd->text = lookup(pd->next->text, pd->next->ntext, NULL) ? "1" : "0";
				pd->next = fretlist(pd->next, pd->next->next);
			} else
			{
				if (pd->next->next == NULL ||
					pd->next->next->next == NULL ||
					pd->next->ntext != 1 ||
					pd->next->text[0] != '(' ||
					pd->next->next->type != PIDENT ||
					pd->next->next->next->ntext != 1 ||
					pd->next->next->next->text[0] != ')')
				{
					p0error("bad defined syntax");
				} else
				{
					pd->ntext = 1;
					pd->type = PNUM;
					pd->text = lookup(pd->next->next->text, pd->next->next->ntext, NULL) ? "1" : "0";
					pd->next = fretlist(pd->next, pd->next->next->next->next);
				}
			}
		}
		break;
	}
	return pd;
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
	BOOL cont;
	int i;
	int nargs;
	int poundarg;
	TLIST *pe;
	TLIST *px;
	TLIST *qs;
	TLIST *poundsubst;

	qb = &qs;
	nargs = 0;
	poundarg = 0;
	if (pd->nwhite != 0 || !PUNCT(pd, '('))
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
		while (r && !PUNCT(r, ')'))
		{
			if (!stdflag && nargs != 0 && PUNCT(r, '#'))
			{
				if (poundarg == 0)
					poundarg = nargs;
				r = r->next;
			} else if (PUNCT(r, ',') && r->next->type == PIDENT)
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
			nargs = 0;
			r = pd;
		} else
		{
			r = r->next;
		}
	}
	
	for (pa = args, i = 0; pa != NULL; pa = pa->next, i++)
		;
	if (stdflag)
	{
		if (i < (poundarg != 0 ? poundarg - 1 : nargs))
		{
			p0error("too few macro arguments");
		} else if (poundarg == 0 && nargs < i)
		{
			p0error("too many macro arguments");
		}
	}
	
	for (pe = r; r->type != PEOL;)
	{
		if (PUNCT(r, '#'))
		{
			poundsubst = r;
			r = r->next;
		} else
		{
			poundsubst = NULL;
		}
		if (r->type == PIDENT)
		{
			for (s = pd->next, i = 0; i < nargs; ++i)
			{
				if (r->ntext == s->ntext && memcmp(r->text, s->text, s->ntext) == 0)
					break;
				while (PUNCT(s->next, '#'))
					s = s->next;
				s = s->next->next;
			}
		}
		if (r->type == PIDENT && i < nargs)
		{
			cont = poundarg != 0 && nargs - 1 == i;
			for (pa = args; 0 < i && pa; --i)
				pa = pa->next;
			while (pa)
			{
				if (cont && pa != args)
				{
					*qb = buytl(&tcomma, NULL);
					if (poundsubst != NULL)
						(*qb)->type = PQSTRING;
					qb = &(*qb)->next;
				}
				for (px = pa->astart; px != pa->aend; px = px->next)
				{
					*qb = buytl(px, r->next);
					if (poundsubst != NULL)
					{
						(*qb)->type = PQSTRING;
						poundsubst->ntext = 0;
					}
					if (px == pa->astart)
					{
						(*qb)->white = r->white;
						(*qb)->nwhite = poundsubst != NULL && !cont ? 0 : r->nwhite;
					}
					qb = &(*qb)->next;
				}
				if (!cont)
					break;
				pa = pa->next;
			}
			r = fretlist(r, r->next);
		} else
		{
			*qb = r;
			qb = &(*qb)->next;
			r = r->next;
		}
	}
	if (r != NULL)
		fretlist(r, NULL);
	while (pd != pe)
	{
		pd = fretlist(pd, pd->next);
	}
	*qb = qn;
	return qs;
}


/*
 * expand #defines in a line of tokens
 */
TLIST *doexp(TLIST *qs, TLIST *qend)
{
	TLIST *pd;
	TLIST *q;
	TLIST **qb;
	ALIST *args;
	DEF *defn;
	char *s;
	TLIST *qn;

	for (qb = &qs; (q = *qb) != qend;)
	{
		if (q->type != PIDENT)
		{
			qb = &q->next;
		} else
		{
			if ((s = lookup(q->text, q->ntext, &defn)) == NULL ||
				(*s == '(' && (q->next->nwhite || !PUNCT(q->next, '('))))
			{
				q = builtin(qb, q);
				qb = &q->next;
			} else
			{
				pd = stotl(s, NULL);
				args = NULL;
				if (*s == '(')
					qn = getargs(q->next, &args, FALSE);
				else
					qn = q->next;
				defn->inexpand = TRUE;
				*qb = dodef(pd, qn, args);
				if (*qb != qn)
				{
					(*qb)->white = q->white;
					(*qb)->nwhite = q->nwhite;
				}
				frelst(args, NULL);
				fretlist(q, qn);
				*qb = doexp(*qb, qn);
				while (*qb != qn)
					qb = &(*qb)->next;
				defn->inexpand = FALSE;
			}
		}
	}
	return qs;
}


static char *findinclude(const char *name, size_t n)
{
	char *pp;
	char *q;
	FILE *fd;
	char *s;
	size_t i;

	for (s = iprefix; *s; s += (s[i]) ? i + 1 : i)
	{
		pp = strchr(s, '|');
		if (pp == NULL)
			i = strlen(s);
		else
			i = pp - s;
		q = xmalloc(i + n + 2);
		memcpy(q, s, i);
		if (i > 0 && q[i - 1] != '/')
			q[i++] = '/';
		memcpy(q + i, name, n);
		q[i + n] = '\0';
		if ((fd = fopen(q, "r")) != NULL)
		{
			fclose(fd);
			return q;
		}
		free(q);
	}
	return NULL;
}


/*
 * get an included file name
 */
char *getfinclude(TLIST *p)
{
	char *fname;
	char *end;
	TLIST *q;
	FILE *fd;
	size_t len;
	char *found;
	
	if (p->ntext == 0 || (p->text[0] != '"' && p->text[0] != '<'))
	{
		return p->ntext == 0 ? "" : p->text;
	}
	len = -p->nwhite;
	for (q = p; q->type != PEOL; q = q->next)
		len += q->nwhite + q->ntext;
	fname = xmalloc(len + 1);
	for (q = p, end = fname; q->type != PEOL; q = q->next)
	{
		if (q == p)
		{
			memcpy(end, q->text + 1, q->ntext - 1);
			end += q->ntext - 1;
		} else
		{
			memcpy(end, q->white, q->nwhite);
			end += q->nwhite;
			memcpy(end, q->text, q->ntext);
			end += q->ntext;
		}
		while (q->type == PSTRING && q->next->type == PSTRING)
		{
			q = q->next;
			memcpy(end - 1, q->text + 1, q->ntext - 1);
			end += q->ntext - 1;
		}
	}
	end--;
	
	if ((*p->text != '\"' || *end == '\"') && (*p->text != '<' || *end == '>'))
	{
		*end = '\0';
		if (*p->text == '"')
		{
			if ((fd = fopen(fname, "r")) != NULL)
			{
				fclose(fd);
				return fname;
			}
		}
		if ((found = findinclude(fname, end - fname)) != NULL)
		{
			free(fname);
			return found;
		}
	}
	*end = '\0';
	return fname;
}


/*
 * hash into symbol table
 */
static DEF **hash(const char *s, size_t n)
{
	int sum;

	for (sum = 0; 0 < n; --n)
		sum += *s++;
	return &htable[sum & (NHASH - 1)];
}


/*
 * install definition in symbol table
 */
void install(const char *s, size_t n, char *pd)
{
	DEF **qb;
	DEF *q;

	n = min(n, LENNAME);
	qb = hash(s, n);
	q = xmalloc(offsetof(DEF, dname) + n + 1);
	q->next = *qb;
	*qb = q;
	q->inexpand = FALSE;
	memcpy(q->dname, s, n);
	q->dname[n] = '\0';
	q->dnlen = n;
	q->defn = pd;
}


/*
 * lookup a definition in symbol table
 */
char *lookup(const char *s, size_t n, DEF **defn)
{
	DEF *q;

	n = min(n, LENNAME);
	for (q = *hash(s, n); q; q = q->next)
	{
		if (q->inexpand == FALSE && n == q->dnlen && memcmp(s, q->dname, n) == 0)
		{
			if (defn)
				*defn = q;
			return q->defn;
		}
	}
	return NULL;
}


INCL *inpfile(FILE *fd, const char *fname)
{
	INCL *pi;

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
 * get next file argument
 */
INCL *nxtfile(void)
{
	FILE *fd;
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
			fatal("can't open %s", fname);
		else
			break;
	}
	return inpfile(fd, fname);
}


/*
 * put an error message with line numbers
 */
void p0error(const char *fmt, ...)
{
	va_list args;
	char errbuf[PATH_MAX + 128];
	int16_t n;

	if (argc == 0)
		strcpy(errbuf, "EOF: ");
	else
		sprintf(errbuf, "#error %s:%d:\t", pincl ? pincl->fname : argv[argc - 1], pincl ? pincl->nline : lineno);
	va_start(args, fmt);
	vsprintf(errbuf + strlen(errbuf), fmt, args);
	va_end(args);
	strcat(errbuf, "\n");
	++nerrors;
	fputs(errbuf, errfd);
	if (xflag)
	{
		n = (int16_t)strlen(errbuf);
#if 0
		/* BUG in original code: copied 2 bytes from a 4-byte int */
		memcpy(errbuf, &n, 2);
		n += 2;
		putcode("cb", LERROR, errbuf, n);
#else
		putcode("c2b", LERROR, &n, errbuf, n);
#endif
	}
}


void fatal(const char *fmt, const char *str)
{
	p0error(fmt, str);
	exit(1);
}


TLIST *fretlist(TLIST *p, TLIST *list)
{
	TLIST *last;
	
	last = p;
	while (last->next != NULL && last->next != list)
		last = last->next;
	last->next = free_tlist;
	free_tlist = p;
	return list;
}


/*
 * install predefined args
 */
void predef(ARGS *p)
{
	int i;
	char *s;
	char *n;
	size_t len;
	char *defn;
	static char one[] = "1";
	
	for (i = 0; (int)p->ntop < NDARGS - i; ++i)
	{
		s = p->anames[(NDARGS - 1) - i];
		n = strchr(s, '=');
		if (n == NULL)
		{
			len = strlen(s);
			n = one;
		} else
		{
			len = n - s;
			n++;
		}
		if (lookup(s, len, NULL) != NULL)
		{
			p0error("-d %.*s redefined", (int)len, s);
		} else
		{
			defn = xmalloc(strlen(n) + 1);
			strcpy(defn, n);
			install(s, len, defn);
		}
	}
}


/*
 * scan a table of predefined strings
 */
LEX scntab(const PRETAB *p, size_t hi, char *s, size_t n)
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
		if ((x = *r++ - n) == 0)
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
TLIST *stotl(char *s, BOOL *in_comment)
{
	TLIST *q;
	TLIST **qb;
	TLIST *qs;
	BOOL comment_flag;
	
	if (in_comment == NULL)
	{
		in_comment = &comment_flag;
		comment_flag = FALSE;
	}
	qb = &qs;
	for (;;)
	{
		q = buytl(NULL, NULL);
		q->white = s;
		while (*s != '\0' && *s != '\n')
		{
			if (ISWHITE(*s))
			{
				++s;
			} else
			{
				if (*in_comment == FALSE &&
					(pasflag != FALSE || s[0] != '/' || s[1] != '*') &&
		            (pasflag == FALSE || (s[0] != '{' && (s[0] != '(' || s[1] != '*'))))
			        break;
				if (!*in_comment)
					s += *s == '{' ? 1 : 2;
				*in_comment = TRUE;
				while (*s != '\0' && *s != '\n')
				{
					if ((pasflag == 0 && s[0] =='*' && s[1] == '/') ||
				        (pasflag != 0 && (s[0] == '}' || (s[0] == '*' && s[1] == ')'))))
					{
						*in_comment = FALSE;
						s += *s == '}' ? 1 : 2;
						break;
					}
					s++;
				}
			}
		}
		/* 2 */
		q->nwhite = s - q->white;
		q->text = s;
		q->ntext = 0;
		if (*s == '\n' || *s == '\0')
		{
			++s;
			q->type = PEOL;
		} else if (ISALPHA(*s) || *s == '_' || (!stdflag && *s == '$'))
		{
			while (ISALPHA(*s) || *s == '_' || (!stdflag && *s == '$') || ISDIGIT(*s))
				++s;
			q->type = PIDENT;
		} else if (ISDIGIT(*s))
		{
			while (ISALPHA(*s) || ISDIGIT(*s) || (!stdflag && *s == '_'))
				++s;
			q->type = PNUM;
		} else if (*s == '"' || *s == '\'')
		{
			for (; *++s != *q->text && *s != '\n' && *s != '\0';)
			{
				if (*s == '\\' && s[1] != '\n')
					++s;
				else if (*s == '\\')
					break;
			}
			q->type = *q->text == '"' ? PSTRING : PCHCON;
			if (*s == *q->text)
			{
				++s;
			} else
			{
				if (xflag)
				{
					p0error("unbalanced %c", *q->text);
				} else
				{
					q->type = PPUNCT;
					s = q->text + 1;
				}
			}
#if 0
			if (STRSIZE < s - q->text)
			{
				p0error("string too long");
				q->text = s - STRSIZE;
			}
#endif
		} else
		{
			if (!xflag && s[0] == '\\' && s[0] == 'n')
			{
				s += 2;
				q->text = "\n";
				q->ntext = 1;
			} else
			{
				++s;
			}
			q->type = PPUNCT;
		}
		if (q->ntext == 0)
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

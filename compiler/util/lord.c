/*	ORDER A LIBRARY
 *	copyright (c) 1979 by Whitesmiths, Ltd.
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "util.h"

#define MAXLIN	64
#define NDEFS	10

typedef struct
{
	size_t nd;
	const char *ns[NDEFS];
} DEF;

typedef struct dlist
{
	struct dlist *next;
	char *nm;
} DLIST;

typedef struct mod
{
	struct mod *next;
	char *name;
	size_t nrefs;
	DLIST *defs;
	DLIST *refs;
} MOD;

/*	flags:
	-c*		define command name to precede output
	-d*^	define a def format
	-i		ignore funny lines
	-r*^	define a ref format
	-s		don't print defs and refs with mod names
 */
static BOOL iflag = FALSE;
static BOOL sflag = FALSE;
static DEF def = { NDEFS, {NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL} };
static DEF ref = { NDEFS, {NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL} };

char *cmd = NULL;

const char *_pname = "lord";

/*	default def values
 */
static DEF ddef = {
	4,
	{
	 NULL,
	 NULL,
	 NULL,
	 NULL,
	 "0x????????B ",
	 "0x????????D ",
	 "0x????????T ",
	 "0x????B ",
	 "0x????D ",
	 "0x????T "
	}
};

/*	default ref values
 */
static DEF dref = {
	8,
	{
	 NULL,
	 NULL,
	 NULL,
	 NULL,
	 NULL,
	 NULL,
	 NULL,
	 NULL,
	 "0x????????U ",
	 "0x????U "
	}
};

/*	look for pattern match
 */
static const char *smatch(const char *r, const char *s)
{
	for (; *r; ++r, ++s)
	{
		if (*r == '?')
		{
			if (!*s || *s == '\n')
				return NULL;
		} else if (*s != *r)
		{
			return NULL;
		}
	}
	return s;
}

/*	get a def or ref line
 */
static BOOL getdef(DEF *pd, DLIST **qd, char *buf)
{
	size_t i;
	DLIST *q;
	const char *s;

	for (i = pd->nd; i < NDEFS; ++i)
	{
		if ((s = smatch(pd->ns[i], buf)) != NULL)
		{
			q = malloc(sizeof(**qd));
			*qd = q;
			q->nm = buybuf(s, strlen(s) + 1);
			return TRUE;
		}
	}
	return FALSE;
}

/*	look for matches between lists
 */
static size_t lmatch(DLIST *p, DLIST *q)
{
	DLIST *r;
	size_t n;

	for (n = 0; p; p = p->next)
		for (r = q; r; r = r->next)
			if (strcmp(p->nm, r->nm) == 0)
				++n;
	return n;
}

/*	put a def or ref
 */
static void putdef(const char *s, DLIST *p)
{
	for (; p; p = p->next)
		fprintf(stdout, "%s%s\n", s, p->nm);
}


/*	topologically sort modules
 */
static BOOL tsort(MOD **qb)
{
	MOD *q;
	MOD *r;
	MOD **rb;
	BOOL better;
	MOD **nb;
	MOD *new;

	for (q = *qb; q; q = q->next)
		for (r = *qb; r; r = r->next)
			q->nrefs += lmatch(q->defs, r->refs);
	for (nb = &new, better = TRUE; *qb && better;)
	{
		better = FALSE;
		for (rb = qb; (r = *rb) != NULL;)
		{
			if (r->nrefs)
			{
				rb = &r->next;
			} else
			{
				*nb = r;
				nb = &r->next;
				*rb = r->next;
				better = TRUE;
				for (q = *qb; q; q = q->next)
					q->nrefs -= lmatch(q->defs, r->refs);
			}
		}
	}
	if (*qb)
	{
		better = FALSE;
		fprintf(stderr, "%s not completely sorted\n\n", (*nb)->name);
	} else
	{
		better = TRUE;
	}
	*nb = *qb;
	*qb = new;
	return better;
}


/*	read defs and refs, then order modules
 */
int main(int ac, char **av)
{
	MOD *q;
	MOD **qb;
	DEF *dpnt;
	DEF *rpnt;
	size_t n;
	MOD *mods;
	char buf[MAXLIN + 2];
	BOOL ok = TRUE;

	getflags(&ac, &av, "c*,d*>i,r*>s:F", &cmd, &def, &iflag, &ref, &sflag);
	dpnt = (def.nd == NDEFS) ? &ddef : &def;
	rpnt = (ref.nd == NDEFS) ? &dref : &ref;
	mods = NULL;
	if (cmd)
	{
		sflag = TRUE;
		fputs(cmd, stdout);
	}
	for (qb = &mods, q = NULL; 0 < (n = getlin(buf, MAXLIN));)
	{
		if (buf[n - 1] == '\n')
			buf[n - 1] = '\0';
		else
			buf[n++] = '\0';
		if (1 < n && buf[n - 2] == ':')
		{
			q = malloc(sizeof(*q));
			q->name = buybuf(buf, n);
			q->nrefs = 0;
			q->defs = NULL;
			q->refs = NULL;
			*qb = q;
			qb = &q->next;
		} else if (!q)
		{
			fputs("no module name\n", stderr);
			return 1;
		} else if (!getdef(dpnt, &q->defs, buf) && !getdef(rpnt, &q->refs, buf) && !iflag)
		{
			fprintf(stderr, "not def or ref: %s\n", buf);
			ok = FALSE;
		}
	}
	if (!tsort(&mods))
		ok = FALSE;
	for (q = mods; q; q = q->next)
	{
		if (sflag)
			q->name[strlen(q->name) - 1] = '\0';
		if (cmd)
			fprintf(stdout, " %s", q->name);
		else
			fprintf(stdout, "%s\n", q->name);
		if (!sflag)
		{
			putdef("d: ", q->defs);
			putdef("r: ", q->refs);
		}
	}
	if (cmd)
		fputs("\n", stdout);
	return ok ? 0 : 1;
}

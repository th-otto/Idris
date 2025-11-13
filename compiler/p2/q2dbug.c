/*	DEBUGGING PRINTOUT FOR EXPRESSIONS
 *	copyright (c) 1978 by Whitesmiths, Ltd.
 */
#include <stdlib.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>
#include "int2.h"
#include "int12.h"
#include "int012.h"
#include "util.h"
#include "p2.h"


static const char *tyname(TINY ty)
{
	switch (ty)
	{
		case XCHAR: return "char";
		case XUCHAR: return "uchar";
		case XSHORT: return "short";
		case XSFIELD: return "sfield";
		case XUSHORT: return "unsign";
		case XLONG: return "long";
		case XLFIELD: return "lfield";
		case XULONG: return "ulong";
		case XFLOAT: return "float";
		case XDOUBLE: return "double";
	}
	return "?!";
}


/*
 * put indented (sub)expression
 */
void putexpr(EXPR *q, int indent)
{
	BITS ty;
	int i;

	if (!pflag)
		return;
	ty = q->e.v.ty;
	for (i = 0; i < indent; ++i)
		printf("\t");
	printf("%s", tyname(ty & 017));
	if ((ty & 017) == XSFIELD || (ty & 017) == XLFIELD)
		printf("(%d, %d)", (ty >> 4) & 077, (ty >> 10) & 077);
	if (!q->op)
	{
		putfmt(": TERM (%i)%*s+%lds[%dc]\n", q->e.v.refs,
			LENNAME, q->e.v.nm, (long)q->e.v.bias, q->e.v.idx);
	} else
	{
		printf(": %d\n", q->op);
		putexpr(q->e.o.left, indent + 1);
		if (q->op == LQUERY)
			putexpr(q->e.o.mid, indent + 1);
		if (q->op & BINOP)
			putexpr(q->e.o.right, indent + 1);
	}
}


/*
 * put the address field
 */
static void putaddr(ADDR *ad)
{
	printf("%s", tyname(ad->ty & 017));
	printf(", (%d)%*s+%lds[%dc]", ad->refs, LENNAME, ad->nm, (long)ad->bias, ad->idx);
}


/*
 * put a term
 */
void putterm(EXPR *q, int indent)
{
	int i;

	if (!pflag)
		return;
	for (i = 0; i < indent; ++i)
		putfmt("\t");
	if (!q->op)
	{
		printf("f %d: ", q->got);
		putaddr(&q->f);
		printf("; v: ");
		putaddr(&q->e.v);
		printf("\n");
	} else
	{
		printf("%d %d : ", q->op, q->got);
		putaddr(&q->f);
		printf("; v: %s\n", tyname(q->e.o.ty & 017));
	}
}


void putfmt(const char *fmt, ...)
{
	va_list args;

	if (!pflag)
		return;
	va_start(args, fmt);
	vfprintf(stdout, fmt, args);
	va_end(args);
}

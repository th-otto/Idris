/*	GET AND PRINT EXPRESSIONS
 *
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "int012.h"
#include "int12.h"
#include "util.h"
#include "int2p.h"

/*	get the type and space info for expression and defs and refs
 */
static BITS gettype(size_t *space, BITS *pspace, long *pl)
{
	BITS ty;

	*pl = 0;
	*pspace = 0;
	*space = 0;
	ty = needch();
	if (ty & 0200)
		*space = glabel();
	ty &= 017;
	if (ty == XLPTRTO || ty == XPTRTO)
	{
		*pspace = glabel();
	} else if (ty == XSFIELD || ty == XLFIELD)
	{
		ty |= needch() << 4;
		ty |= needch() << 10;
	} else if (ty == XSTRUCT)
	{
		gint(pl);
	}
	return ty;
}

void printgexpr(unsigned int ind)
{
	int n;
	char *s;
	METACH reg;
	METACH refs;
	BITS ty;
	BITS pspace;
	size_t space;
	double d;
	LEX op;
	long bias;
	long stsize;

	fprintf(outfd, "%x", ind);
	op = needch();
	ty = gettype(&space, &pspace, &stsize);
	if (op)
	{
		n = 0;
	} else
	{
		s = gname(NULL);
		n = strlen(s);
	}
	(void)n;
	printop(op);
	printtype(ty & 017);
	if ((ty & 017) == XSFIELD || (ty & 017) == XLFIELD)
	{
		fprintf(outfd, "off:%d, siz:%d ", (ty >> 4) & 0x3F, (ty >> 10) & 0x3F);
	}
#if 0
	else if ((ty & 017) == XPTRTO)
	{
		fprintf(outfd, "object / %d ", 1 << (ty >> 4));
	}
#endif

	fprintf(outfd, "obj / %d ", 1 << ((ty & 017) >> 4));
	if (op == DADDR)
	{
		fputc('\n', outfd);
		printgexpr(ind + 2);
		return;
	} else if (op)
	{
		fputc('\n', outfd);
		printgexpr(ind + 2);
		if (op == LQUERY)
			printgexpr(ind + 2);
		if (op & BINOP)
			printgexpr(ind + 2);
	} else
	{
		gint(&bias);
		reg = needch();
		refs = needch();
		memcpy(&d, s, 8);
		if ((ty & 017) == XDOUBLE && !refs && !reg)
		{
			fprintf(outfd, "=D'%f';\n", d);
		} else
		{
			fprintf(outfd, "'%s'+%ld", s, bias);
			printregister(reg);
			fprintf(outfd, " refs=%d\n", refs);
		}
	}
}

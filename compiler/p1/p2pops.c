/*	PRINT OPERATORS
 *
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "int012.h"
#include "int12.h"
#include "util.h"
#include "int2p.h"

#define TABLE struct table

struct table
{
	short incode;
	const char *text;
};

static TABLE regsters[] = {
	{ ARGIDX, "ARGIDX" },
	{ AUTIDX, "AUTIDX" },
	{ INTRET, "INTRET" },
	{ LONGRET, "LONGRET" },
	{ FLTRET, "FLTRET" },
	{ R0, "R0" },
	{ R1, "R1" },
	{ R2, "FST1" },
	{ R3, "FST2" },
	{ R4, "FST3" },
	{ -1, NULL }
};

static TABLE operators[] = {
	{ LAND, "LAND" },
	{ LANDAND, "LANDAND" },
	{ LCOMP, "LCOMP" },
	{ LDECR, "LDECR" },
	{ LDIVIDE, "LDIVIDE" },
	{ LGAND, "LGAND" },
	{ LGDIV, "LGDIV" },
	{ LGETS, "LGETS" },
	{ LGLSH, "LGLSH" },
	{ LGRSH, "LGRSH" },
	{ LGMIN, "LGMIN" },
	{ LGMOD, "LGMOD" },
	{ LGOR, "LGOR" },
	{ LGPLU, "LGPLU" },
	{ LGREAT, "LGREAT" },
	{ LGEQ, "LGEQ" },
	{ LGTIM, "LGTIM" },
	{ LGXOR, "LGXOR" },
	{ LINCR, "LINCR" },
	{ LISEQ, "LISEQ" },
	{ LLESS, "LLESS" },
	{ LLEQ, "LLEQ" },
	{ LLSHIFT, "LLSHIFT" },
	{ LMINUS, "MINUS" },
	{ LMODULO, "LMODULO" },
	{ LNOT, "LNOT" },
	{ LNOTEQ, "LNOTEQ" },
	{ LOR, "LOR" },
	{ LOROR, "LOROR" },
	{ LPLUS, "LPLUS" },
	{ LQUERY, "LQUERY" },
	{ LRSHIFT, "LRSHIFT" },
	{ LTIMES, "LTIMES" },
	{ LXOR, "LXOR" },
	{ DADDR, "DADDR" },
	{ DALIST, "DALIST" },
	{ DCAST, "DCAST" },
	{ DGMIN, "DGMIN" },
	{ DELIST, "DELIST" },
	{ DFNCALL, "DFNCALL" },
	{ DFNONLY, "DFNONLY" },
	{ DGPLU, "DGPLU" },
	{ DINDIR, "DINDIR" },
	{ DMINUS, "DMINUS" },
	{ DPLUS, "DPLUS" },
	{ DCMP, "DCMP" },
	{ DGETS, "DGETS" },
	{ DLESS, "DLESS" },
	{ 0, "TERM" },
	{ -1, NULL }
};

static TABLE types[] = {
	{ XSTRUCT, "XSTRUCT" },
	{ XLPTRTO, "XLPTRTO" },
	{ XPTRTO, "XPTRTO" },
	{ XDOUBLE, "XDOUBLE" },
	{ XFLOAT, "XFLOAT" },
	{ XULONG, "XULONG" },
	{ XLFIELD, "XFIELD" },
	{ XLONG, "XLONG" },
	{ XUSHORT, "XUSHORT" },
	{ XSFIELD, "XSFIELD" },
	{ XSHORT, "XSHORT" },
	{ XUCHAR, "XUCHAR" },
	{ XCHAR, "XCHAR" },
	{ XTEST, "XTEST" },
	{ -1, NULL }
};

/*	print op's
 */
void printop(LEX op)
{
	int i;

	for (i = 0; operators[i].incode >= 0; i++)
	{
		if (op == operators[i].incode)
		{
			fprintf(outfd, "%s ", operators[i].text);
			return;
		}
	}
	fprintf(outfd, "op=%d ", op);
}

void printregister(LEX n)
{
	int i;

	for (i = 0; regsters[i].incode >= 0; i++)
	{
		if (n == regsters[i].incode)
		{
			fprintf(outfd, "[%s]", regsters[i].text);
			return;
		}
	}
	fprintf(outfd, "[%d]", n);
}

void printtype(BITS ty)
{
	int i;

	for (i = 0; types[i].incode >= 0; i++)
	{
		if (types[i].incode == ty)
		{
			fprintf(outfd, "%s ", types[i].text);
			return;
		}
	}
	fprintf(outfd, "ty=%d ", ty);
}

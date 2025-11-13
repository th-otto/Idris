/*	THIS IS THE MAIN PRINTING FUNCTION
 *
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "int012.h"
#include "int12.h"
#include "util.h"
#include "int2p.h"

/*
 * File control
 */
FILE *errfd;
FILE *outfd;
FILE *infd;

const char *_pname = "p1pr";

static char *ofile;

/*	print output of p1
 */
int main(int ac, char **av)
{
	BITS pspace;
	size_t psize;
	LEX tok;
	long lo;
	char funname[LENNAME + 2];
	unsigned char dcbyte;
	unsigned char magbyte;
	unsigned char regbyte;

	errfd = stderr;
	outfd = stdout;
	infd = stdin;
	getflags(&ac, &av, "o*:F <file>", &ofile);
	if (0 < ac)
	{
		if ((infd = fopen(av[0], "rb")) == NULL)
			panic("bad input file");
	}
	if (ofile)
	{
		if ((outfd = fopen(ofile, "w")) == NULL)
			panic("bad output file");
		else
			errfd = stdout;
	}

	/* Here we start */

	magbyte = needch();
	fprintf(outfd, "magic byte: 0x%x\n", magbyte);
	if (magbyte != P2MAGIC)
	{
		fprintf(stderr, "%s: intermediate file < release 3.0\n", av[0]);
		return 1;
	}
	dcbyte = needch();
	fprintf(outfd, "dcbyte: 0x%x\n", dcbyte);
	regbyte = needch();
	fprintf(outfd, "regbyte: 0x%x\n", regbyte);
	for (tok = printgcode(); tok != EOF && tok;)
	{
		if (tok != GFUNC)
			panic("NO GFUNC");
		gname(funname);
		pspace = glabel();
		gint(&lo);
		psize = lo;
		fprintf(outfd, "GFUNC %s pspace: 0x%x, psize: %ld\n", funname, pspace, (long) psize);
		tok = printgtbody();
	}
	return 0;
}

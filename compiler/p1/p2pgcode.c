/*	GET AND PRINT DATA
 *
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "int012.h"
#include "int12.h"
#include "util.h"
#include "int2p.h"

/*	process switch table
 */
static LEX doswtab(void)
{
	BOOL islong;
	size_t num;
	int c;
	int n;
	LABEL tab;
	LABEL def;
	LABEL lbl;
	long lower;
	long val;

	n = needch();
	(void)n;
	tab = glabel();
	(void)tab;
	def = glabel();
	(void)def;
	num = glabel();
	islong = glabel() == 4;
	(void)islong;
	for (;;)
	{
		switch (c = printgcode())
		{
		case GJMPTAB:
			printf("GJMPTAB\n");
			num = glabel();
			gint(&lower);
			for (; num; --num)
				glabel();
			break;
		case GSCNTAB:
			printf("GSCNTAB\n");
			num = glabel();
			for (; num; --num)
			{
				gint(&val);
				lbl = glabel();
				(void)lbl;
			}
			c = printgcode();
			return c;
		default:
			return c;
		}
	}
}

/*	write data until a function
 */
LEX printgcode(void)
{
	LEX c;
	LEX x;
	BITS pspace;
	size_t psize;
	int i;
	int lineno;
	int n;
	double dflt;
	long lo;
	char name[LENNAME + 2];
	char *s;
	char txtbuf[80];

	for (;;)
	{
		switch (c = getc(infd))
		{
		case LLINENO:
			lineno = glabel();
			fprintf(outfd, "LLINENO %d\n", lineno);
			break;
		case LIFILE:
			gname(txtbuf);
			fprintf(outfd, "LIFILE %s\n", txtbuf);
			break;
		case LERROR:
			for (n = glabel(), s = txtbuf; n; --n, *s++ = needch())
				;
			*s = '\0';
			fprintf(outfd, "LERROR %s\n", txtbuf);
			break;
		case GSPNAME:
			gname(name);
			fprintf(outfd, "GSPNAME %s\n", name);
			break;
		case GFADDR:
		case GFADDR1:
		case GFADDR2:
		case GFADDR3:
		case GFADDR4:
			gname(name);
			gint(&lo);
			fprintf(outfd, "GFADDR%d %s %ld\n", c - GFADDR, name, lo);
			break;
		case GADDR:
		case GADDR1:
		case GADDR2:
		case GADDR3:
		case GADDR4:
			gname(name);
			gint(&lo);
			fprintf(outfd, "GADDR%d %s %ld\n", c - GADDR, name, lo);
			break;
		case GDEF:
			gname(name);
			pspace = glabel();
			gint(&lo);
			psize = lo;
			fprintf(outfd, "GDEF %s pspace: 0x%x, psize: %ld\n", name, pspace, (long) psize);
			break;
		case GREF:
			gname(name);
			pspace = glabel();
			gint(&lo);
			psize = lo;
			fprintf(outfd, "GREF %s pspace: 0x%x, psize: %ld\n", name, pspace, (long) psize);
			break;
		case GDATA:
			n = needch();
			gname(name);
			fprintf(outfd, "GDATA bound: %d %s\n", n, name);
			break;
		case GFDATA:
			n = needch();
			pspace = glabel();
			gname(name);
			fprintf(outfd, "GFDATA bound: %d %s pspace: 0x%x\n", n, name, pspace);
			break;
		case GLITS:
			n = needch();
			pspace = glabel();
			gname(name);
			fprintf(outfd, "GLITS bound: %d %s pspace: 0x%x\n", n, name, pspace);
			break;
		case GSWTAB:
			fprintf(outfd, "GSWTAB\n");
			return doswtab();
			break;
		case GINT:
			n = needch();
			gint(&lo);
			fprintf(outfd, "GINT %d %ld\n", n, lo);
			break;
		case GFLOAT:
			n = needch();
			for (i = 0; i < 8; ++i)
				name[i] = needch();
			memcpy(&dflt, name, 8);
			fprintf(outfd, "GFLOAT %d %20.16f\n", n, dflt);
			break;
		case GSTRING:
			n = needch();
			fprintf(outfd, "GSTRING %d \"", n);
			while (0 < n)
			{
				x = needch();
				switch (x)
				{
				case '\n':
					fprintf(outfd, "\\n");
					break;
				case '\r':
					fprintf(outfd, "\\r");
					break;
				default:
					if (x < '\040')
						fprintf(outfd, "\\%o", x);
					else
						fprintf(outfd, "%c", x);
				}
				n--;
			}
			fprintf(outfd, "\"\n");
			break;
		case GDEND:
			fprintf(outfd, "GDEND\n");
			break;
		case GSPACE:
			gint(&lo);
			fprintf(outfd, "GSPACE %ld\n", lo);
			break;
		default:
			return c;
		}
	}
}

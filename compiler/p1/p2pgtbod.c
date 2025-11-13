/*	GET AND PRINT BODY OF FUNCTIONS
 *
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "int012.h"
#include "int12.h"
#include "util.h"
#include "int2p.h"

LEX printgtbody(void)
{
	LEX tok;
	int index = 0;
	long lo;
	LEX lin;
	LEX lb;
	static const char *gops[] = { "GNOTEQ", "GISEQ", "GGEQ", "GGREAT", "GLEQ", "GLESS" };

	while ((tok = printgcode()) != GFUNC && tok != GFEND && tok != EOF && tok)
	{
		switch (tok)
		{
		case GDBFUNC:
			fprintf(outfd, "GDBFUNC %d\n", glabel());
			break;
		case GDBSTAT:
			fprintf(outfd, "GDBSTAT %s\n", lbn(glabel()));
			break;
		case GAUTOFF:
			gint(&lo);
			fprintf(outfd, "GAUTOFF %ld\n", lo);
			break;
		case GREGS:
			fprintf(outfd, "GREGS 0x%x\n", needch());
			break;
		case GJUMP:
			fprintf(outfd, "GJUMP %s\n", lbn(glabel()));
			break;
		case GSWITCH:
			fprintf(outfd, "GSWITCH %s\n", lbn(glabel()));
			break;
		case GLSWITCH:
			fprintf(outfd, "GLSWITCH %s\n", lbn(glabel()));
			break;
		case GSWEND:
			fprintf(outfd, "GSWEND\n");
			break;
		case GCASE:
		case GLABEL:
			lb = glabel();
			lin = glabel();
			fprintf(outfd, "%s %s\nlineno=%d\n", (tok == GCASE) ? "GCASE" : "GLABEL", lbn(lb), lin);
			break;
		case GRET:
			fprintf(outfd, "GRET\n");
			break;
		case GVOID:
			fprintf(outfd, "GVOID\n");
			printgexpr(0);
			break;
		case GLESS:
			index++;
			/* fall through */
		case GLEQ:
			index++;
			/* fall through */
		case GGREAT:
			index++;
			/* fall through */
		case GGEQ:
			index++;
			/* fall through */
		case GISEQ:
			index++;
			/* fall through */
		case GNOTEQ:
			fprintf(outfd, "%s %s\n", gops[index], lbn(glabel()));
			printgexpr(2);
			printgexpr(2);
			index = 0;
			break;
		case GSDBDATA:
			fprintf(outfd, "GSDBDATA\n");
			break;
		case GEDBDATA:
			fprintf(outfd, "GEDBDATA\n");
			break;
		default:
			panic("BAD INPUT TO p2pgtbody");
		}
	}
	return tok;
}

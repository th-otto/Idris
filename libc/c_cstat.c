#include <std.h>
#include <stdio.h>
#include <sort.h>
#include "libc.h"

int entval;
short firstkey;
char key[198];
KEY defsort;

void _cstat(void)
{
	firstkey = 10;
	defsort.rev = FALSE;
	defsort.skipbl = FALSE;
	defsort.cmptype = 'a';
	defsort.tabchar = 0;
	defsort.begfsk = 0;
	defsort.begaddch = 0;
	defsort.endfsk = 0;
	defsort.endaddch = -1;
}

#include <stdio.h>
#include <string.h>

static char termid[] = "/dev/tty";

char *ctermid(char *s)
{
	if (s != NULL)
		memcpy(s, termid, sizeof(termid));
	return termid;
}

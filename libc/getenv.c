/*	GET ENVIRONMENT STRING
 *	copyright (c) 1985 by Whitesmiths, Ltd.
 */
#include <std.h>
#include <stdlib.h>
#include "libc.h"

char *getenv(const char *p)
{
	FAST BYTES l = _lenstr(p);
	FAST const char **pe;

	for (pe = environ; pe && *pe; ++pe)
		if (_cmpbuf(p, *pe, l) && (*pe)[l] == '=')
			return (char *)(&(*pe)[l + 1]);
	return NULL;
}

char *_getenv(const char *p)
{
	return getenv(p);
}

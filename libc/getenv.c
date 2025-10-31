/*	GET ENVIRONMENT STRING
 *	copyright (c) 1985 by Whitesmiths, Ltd.
 */
#include <std.h>
#include <stdlib.h>
#include "libc.h"

char *_getenv(const char *p)
{
	return getenv(p);
}

#include <std.h>
#include <pcdecl.h>
#include <stdio.h>
#include "libc.h"


/*
 * read formatted input from stdin
 */
COUNT getfmt(const char *fmt, ...)
{
	return _getf(getl, &_stdin, fmt, &(&fmt)[1]);
}

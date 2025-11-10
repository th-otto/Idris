#include <std.h>
#include <pcdecl.h>
#include <stdio.h>
#include "libc.h"


/*
 * put a text line to output buffer stdout
 */
BYTES putlin(const char *s, BYTES n)
{
	return putl(&_stdout, s, n);
}

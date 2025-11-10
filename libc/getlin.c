#include <std.h>
#include <pcdecl.h>
#include <stdio.h>
#include <stdarg.h>
#include "libc.h"

/*
 * get a text line from input buffer stdin
 */
size_t getlin(char *s, size_t n)
{
	return getl(&_stdin, s, n);
}


#include <std.h>
#include <pcdecl.h>
#include <stdio.h>
#include <stdarg.h>
#include "libc.h"

size_t getlin(char *s, size_t n)
{
	return getl(&_stdin, s, n);
}


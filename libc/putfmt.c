#include <std.h>
#include <pcdecl.h>
#include <stdio.h>
#include <stdarg.h>
#include "libc.h"

/*
 * output arguments formatted to stdout
 */
size_t putfmt(const char *fmt, ...)
{
	return _putf(putl, &_stdout, fmt, &(&fmt)[1]);
}

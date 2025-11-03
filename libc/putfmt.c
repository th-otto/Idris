#include <std.h>
#include <pcdecl.h>
#include <stdio.h>
#include <stdarg.h>
#include "libc.h"

size_t putfmt(const char *fmt, ...)
{
	return _putf(putl, &_stdout, fmt, &(&fmt)[1]);
}

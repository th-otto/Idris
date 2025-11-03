#include <std.h>
#include <pcdecl.h>
#include <stdio.h>
#include <stdarg.h>
#include "libc.h"

COUNT getf(FILE *pf, const char *fmt, ...)
{
	return _getf(getl, pf, fmt, &(&fmt)[1]);
}

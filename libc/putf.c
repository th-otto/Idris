#include <std.h>
#include <pcdecl.h>
#include <stdio.h>
#include "libc.h"

/*
 * output arguments formatted
 */
void putf(FILE *pf, const char *fmt, ...)
{
	_putf(putl, pf, fmt, &(&fmt)[1]);
}

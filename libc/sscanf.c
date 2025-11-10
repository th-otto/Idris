#include <stdio.h>
#include <stdarg.h>
#include "libc.h"

/*
 * input string format conversion
 */
int sscanf(const char *s, const char *format, ...)
{
	return _scan(s, TRUE, format, &(&format)[1]);
}

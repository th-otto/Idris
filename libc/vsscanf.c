#include <stdio.h>
#include <stdarg.h>
#include "libc.h"

/*
 * input string format conversion
 */
int vsscanf(const char *s, const char *format, va_list args)
{
	return _scan(s, TRUE, format, args);
}

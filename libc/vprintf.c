#include <stdio.h>
#include <stdarg.h>
#include "libc.h"


/*
 * formatted output conversion
 */
int vprintf(const char *format, va_list args)
{
	return _print(_putbuf, stdout, format, args);
}

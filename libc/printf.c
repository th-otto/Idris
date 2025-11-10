#include <stdio.h>
#include <stdarg.h>
#include "libc.h"


/*
 * formatted output conversion
 */
int printf(const char *format, ...)
{
	return _print(_putbuf, stdout, format, &(&format)[1]);
}

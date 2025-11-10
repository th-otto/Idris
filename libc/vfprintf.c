#include <stdio.h>
#include <stdarg.h>
#include <signal.h>
#include "libc.h"


/*
 * formatted output conversion
 */
int vfprintf(FILE *stream, const char *format, va_list args)
{
	if (stream == NULL)
	{
		_raise(NULL, &_filerr);
	}
	return _print(_putbuf, stream, format, args);
}

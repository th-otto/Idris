#include <stdio.h>
#include <stdarg.h>
#include <signal.h>
#include "libc.h"


/*
 * formatted output conversion
 */
int fprintf(FILE *stream, const char *format, ...)
{
	if (stream == NULL)
	{
		_raise(NULL, &_filerr);
	}
	return _print(_putbuf, stream, format, &(&format)[1]);
}

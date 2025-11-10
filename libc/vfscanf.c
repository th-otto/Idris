#include <stdio.h>
#include <stdarg.h>
#include <signal.h>
#include "libc.h"

/*
 * input FILE format conversion
 */
int vfscanf(FILE *stream, const char *format, va_list args)
{
	if (stream == NULL)
	{
		_raise(NULL, &_filerr);
	}
	return _scan(stream, FALSE, format, args);
}

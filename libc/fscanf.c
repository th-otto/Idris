#include <stdio.h>
#include <stdarg.h>
#include <signal.h>
#include "libc.h"

int fscanf(FILE *stream, const char *format, ...)
{
	if (stream == NULL)
	{
		_raise(NULL, &_filerr);
	}
	return _scan(stream, FALSE, format, &(&format)[1]);
}

#include <stdio.h>
#include <stdarg.h>
#include <signal.h>
#include "libc.h"

int vscanf(const char *format, va_list args)
{
	return _scan(stdin, FALSE, format, args);
}

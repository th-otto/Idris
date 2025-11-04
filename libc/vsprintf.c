#include <stdio.h>
#include <stdarg.h>
#include "libc.h"


int vsprintf(char *s, const char *format, va_list args)
{
	char *str = s;
	return _print(_cache, &str, format, args);
}

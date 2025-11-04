#include <stdio.h>
#include <stdarg.h>
#include "libc.h"

int scanf(const char *format, ...)
{
	return _scan(stdin, FALSE, format, &(&format)[1]);
}

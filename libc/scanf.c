#include <stdio.h>
#include <stdarg.h>
#include "libc.h"

/*
 * input FILE format conversion
 */
int scanf(const char *format, ...)
{
	return _scan(stdin, FALSE, format, &(&format)[1]);
}

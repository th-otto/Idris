#include <stdio.h>
#include <stdarg.h>
#include "libc.h"


int _cache(const void *arg, int count, void *_dst)
{
	register const char *str = arg;
	register char **dst = _dst;
	
	while (--count >= 0)
	{
		*(*dst++) = *str++;
	}
	**dst = '\0';
	return TRUE;
}


/*
 * formatted output conversion
 */
int sprintf(char *s, const char *format, ...)
{
	char *str = s;
	return _print(_cache, &str, format, &(&format)[1]);
}

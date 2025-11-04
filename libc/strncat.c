#include <string.h>

char *strncat(char *dst, register const char *src, size_t max)
{
	register char *dscan = dst;
	register long count = max;

	while (*dscan != '\0')
		++dscan;

	while (--count >= 0 && *src != '\0')
		*dscan++ = *src++;

	*dscan = '\0';

	return dst;
}

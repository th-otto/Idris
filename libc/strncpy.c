#include <string.h>

/*
 * zero a fixed-width buffer and copy a string into a character sequence with truncation and zero the rest of it
 */
char *strncpy(char *dst, register const char *src, size_t max)
{
	register char *dscan = dst;
	register long count = max;

	while (--count >= 0 && (*dscan++ = *src++) != '\0')
		;
	while (--count >= 0)
		*dscan++ = '\0';
	return dst;
}

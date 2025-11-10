#include <string.h>

/*
 * fill memory with a constant byte
 */
void *memset(void *_s, register int c, size_t len)
{
	register unsigned char *s = (unsigned char *)_s;
	register long count = len;

	while (--count >= 0)
		*s++ = c;

	return _s;
}

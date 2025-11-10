#include <string.h>

/*
 * scan memory for a character
 */
void *memchr(const void *s, register int ucharwanted, register size_t size)
{
	register const char *scan;

	scan = (const char *) s;
	for (; size > 0; size--)
	{
		if (*scan == (char) ucharwanted)
			return (void *)(scan);
		else
			scan++;
	}

	return NULL;
}


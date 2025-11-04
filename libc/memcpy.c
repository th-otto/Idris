#include <string.h>

void *memcpy(void *dest, const void *src, size_t n)
{
	register unsigned char *pd = (unsigned char *)dest;
	register const unsigned char *ps = (const unsigned char *)src;
	register long count = n;
	
	if (pd > ps)
	{
		pd += count;
		ps += count;
		while (--count >= 0)
			*--pd = *--ps;
	} else if (pd < ps)
	{
		while (--count >= 0)
			*pd++ = *ps++;
	}
	return dest;
}

#include <wslxa.h>

void *buybuf(const void *s, register BYTES n)
{
	register const char *src;
	register void *ptr;
	register char *dst;
	
	/* BUG: no malloc check here */
	ptr = _alloc(n, NULL);
	src = s;
	dst = ptr;
	while (n != 0)
	{
		*dst++ = *src++;
		n--;
	}
	return ptr;
}

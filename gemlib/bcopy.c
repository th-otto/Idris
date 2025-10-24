#include <string.h>

void bcopy(const void *_src, void *_dst, register int count)
{
	register const char *src = _src;
	register char *dst = _dst;

	if (src < dst)
	{
		src += count;
		dst += count;
		while (count-- > 0)
			*--dst = *--src;
	} else
	{
		while (count-- > 0)
			*dst++ = *src++;
	}
}

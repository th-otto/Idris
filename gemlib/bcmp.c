#include <string.h>

int bcmp(const void *_src, const void *_dst, register int count)
{
	register const char *src = _src;
	register const char *dst = _dst;
	while (count-- > 0)
	{
		if (*src++ != *dst++)
			return 1;
	}
	return 0;
}

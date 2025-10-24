#include <string.h>

void bzero(void *dst, register int count)
{
	register char *p = dst;
	while (count-- > 0)
		*p++ = 0;
}

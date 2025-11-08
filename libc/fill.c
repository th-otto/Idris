#include <std.h>
#include <pcdecl.h>
#include <string.h>

/*
 * propagate fill character throughout buffer
 */
size_t fill(void *_s, size_t n, register char c)
{
	register unsigned char *s = (unsigned char *)_s;
	register long i;
	
	for (i = n; --i >= 0; )
		*s++ = c;
	return n;
}

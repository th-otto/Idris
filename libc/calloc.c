#include <wslxa.h>
#include <stdlib.h>


/*
 * allocate dynamic memory
 */
void *calloc(size_t nelem, size_t elsize)
{
	register size_t size;
	register void *ptr;
	register char *dst;
	
	size = nelem * elsize;
	if ((ptr = _nalloc(size, NULL)) != NULL)
	{
		/* FIXME: use optimized memset here */
		dst = ptr;
		while (size != 0)
		{
			*dst++ = 0;
			size--;
		}
	}
	return ptr;
}

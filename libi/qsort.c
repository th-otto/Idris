#include <std.h>
#include <pcdecl.h>
#include <stdlib.h>

static void excf(size_t i, size_t j, register struct _sortarg **arg)
{
	register unsigned char *pi;
	register unsigned char *pj;
	register size_t size;
	register size_t n;
	register unsigned char tmp;
	
	size = (*arg)->size;
	pi = (unsigned char *)(*arg)->base + i * size;
	pj = (unsigned char *)(*arg)->base + j * size;
	for (n = 0; n < size; n++)
	{
		tmp = *pi;
		*pi++ = *pj;
		*pj++ = tmp;
	}
}


static int ordf(size_t i, size_t j, register struct _sortarg **arg)
{
	register size_t size;

	size = (*arg)->size;
	return (*arg)->compar((unsigned char *)(*arg)->base + i * size, (unsigned char *)(*arg)->base + j * size);
}


void qsort(void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *))
{
#ifdef __GNUC__
	struct _sortarg arg;
	arg.base = base;
	arg.nmemb = nmemb;
	arg.size = size;
	arg.compar = compar;
	sort(nmemb, ordf, excf, &arg);
#else
	/* relies on arguments on stack looking like struct _sortarg */
	sort(nmemb, ordf, excf, (struct _sortarg *)&base);
#endif
}

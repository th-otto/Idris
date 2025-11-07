#include <stdlib.h>

void *bsearch(const void *key, const void *base, register size_t nmemb, size_t size, int (*compar)(const void *, const void *))
{
	register int cmp;
	register size_t pivot;
	register size_t left;
	register const unsigned char *elem;
	
	left = 0;
	while (left < nmemb)
	{
		pivot = (left + nmemb) >> 1;
		elem = (const unsigned char *)base + pivot * size;
		cmp = compar(key, elem);
		if (cmp == 0)
			return (void *)elem;
		if (cmp > 0)
			left = pivot + 1;
		else
			nmemb = pivot;
	}
	return NULL;
}

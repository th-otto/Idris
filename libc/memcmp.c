#include <string.h>

/*
 * compare memory areas
 */
int memcmp(const void *s1, const void *s2, register size_t size)
{
	register const unsigned char *scan1;
	register const unsigned char *scan2;

	scan1 = (const unsigned char *) s1;
	scan2 = (const unsigned char *) s2;
	for (; size > 0; size--)
	{
		if (*scan1 != *scan2)
			return *scan1 - *scan2;
		scan1++;
		scan2++;
	}
	
	return 0;
}


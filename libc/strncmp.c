#include <string.h>

int strncmp(register const char *scan1, register const char *scan2, size_t n)
{
	register unsigned char c1, c2;
	register long count = n;

	do {
		c1 = *scan1++;
		c2 = *scan2++;
	} while (--count >= 0 && c1 && c1 == c2);

	if (count < 0)
		return 0;

	return c1 - c2;
}


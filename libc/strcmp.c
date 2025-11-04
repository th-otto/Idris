#include <string.h>

int strcmp(register const char *scan1, register const char *scan2)
{
	register unsigned char c1, c2;

	do {
		c1 = *scan1++;
		c2 = *scan2++;
	} while (c1 && c1 == c2);

	return c1 - c2;
}


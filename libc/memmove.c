#include <string.h>

/*
 * copy memory area
 */
void *memmove(void *dest, const void *src, size_t n)
{
	return memcpy(dest, src, n);
}

#include <unistd.h>
#include "libc.h"

void *inheap(void *p)
{
	return end <= (char *)p && (char *)p < (char *)sbrk(0) ? p : NULL;
}

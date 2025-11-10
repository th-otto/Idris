#include <std.h>
#include <wslxa.h>
#include <stdlib.h>

/*
 * free space on the heap
 */
void *lfree(void *addr, void *link)
{
	free(addr);
	return link;
}

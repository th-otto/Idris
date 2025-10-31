#include <std.h>
#include <wslxa.h>
#include <stdlib.h>

void *lfree(void *addr, void *link)
{
	free(addr);
	return link;
}

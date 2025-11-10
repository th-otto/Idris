#include <std.h>
#include <wslxa.h>
#include <stdlib.h>

/*
 * allocate dynamic memory
 */
void *malloc(size_t size)
{
	return _nalloc(size, NULL);
}

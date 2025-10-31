#include <std.h>
#include <wslxa.h>
#include <stdlib.h>

void *malloc(size_t size)
{
	return _nalloc(size, NULL);
}

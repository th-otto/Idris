#include <stdlib.h>
#include "libc.h"

/*
 * free dynamic memory
 */
void free(void *ptr)
{
	_free(ptr, NULL);
}

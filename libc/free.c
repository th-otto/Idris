#include <stdlib.h>
#include "libc.h"

void free(void *ptr)
{
	_free(ptr, NULL);
}

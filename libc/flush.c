#include <stdio.h>
#include "libc.h"

int _flush(int fd)
{
	UNUSED(fd);
	return TRUE;
}

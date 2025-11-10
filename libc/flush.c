#include <stdio.h>
#include "libc.h"

/*
 * low-level flush
 */
int _flush(int fd)
{
	UNUSED(fd);
	return TRUE;
}

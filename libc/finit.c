#include <stdio.h>
#include <fcntl.h>
#include "libc.h"

/*
 * initialize an FIO control buffer
 */
FILE *finit(register FILE *stream, int fd, register int type)
{
	if (type == -1)
		type = O_BUF | O_WRONLY;
	if (stream == stdin || stream == stdout || stream == stderr)
		type |= O_REUSE;
	return _finit(stream, fd, type);
}

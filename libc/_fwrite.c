#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include "libc.h"

/*
 * write and check
 */
void _fwrite(int fd, const void *buf, size_t len)
{
	if ((size_t)write(fd, buf, len) != len)
		_raise(NULL, &_wrierr);
}

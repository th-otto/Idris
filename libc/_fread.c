#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include "libc.h"


size_t _fread(int fd, void *_buf, size_t len)
{
	register unsigned char *buf = _buf;
	register size_t i;
	register long nread;
	
	for (i = 0; i < len; )
	{
		if ((nread = read(fd, buf, len - i)) == 0)
			break;
		if (nread < 0)
		{
			_raise(NULL, &_reaerr);
		}
		buf += nread;
		i += nread;
	}
	return i;
}


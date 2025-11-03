#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include "libc.h"

long _dowrite(register FILE *stream, register const void *s, size_t n, int doflush)
{
	if (stream == NULL)
	{
		_raise(NULL, &_filerr);
	}
	if (write(stream->fd, s, n) != (long)n || (doflush && !_flush(stream->fd)))
	{
		stream->flag |= _FIOERR;
		stream->nleft = 0;
		return FALSE;
	}
	return TRUE;
}

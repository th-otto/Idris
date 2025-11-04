#include <stdio.h>
#include <signal.h>
#include "libc.h"

int fgetc(register FILE *stream)
{
	unsigned char c;

	if (stream == NULL)
	{
		_raise(NULL, &_filerr);
	} else if (!(stream->flag & _FIOWASREAD) && !_chkio(stream, FALSE))
	{
		return EOF;
	}
	if (stream->flag & _FIOUNBUFFERED)
	{
		if (_doread(stream, &c, 1) == 1)
			return c;
		return EOF;
	}
	if (stream->nleft == 0)
	{
		stream->nleft = _doread(stream, stream->pnext = stream->buf, stream->bufsize);
		if (stream->nleft < 0)
			return EOF;
	}
	if (--stream->nleft < 0)
	{
		stream->nleft = -1;
		return EOF;
	}
	return *(stream->pnext++);
}

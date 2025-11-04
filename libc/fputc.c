#include <stdio.h>
#include <signal.h>
#include "libc.h"

int fputc(int c, register FILE *stream)
{
	unsigned char uc;
	
	uc = c;
	if (stream == NULL)
	{
		_raise(NULL, &_filerr);
	} else if (!(stream->flag & _FIOWASWRITTEN) && !_chkio(stream, TRUE))
	{
		return EOF;
	}
	if (stream->flag & _FIOUNBUFFERED)
	{
		return _dowrite(stream, &uc, 1, TRUE) ? uc : EOF;
	}
	if (stream->nleft < stream->bufsize)
	{
		stream->buf[stream->nleft++] = uc;
	} else
	{
		if (!_dowrite(stream, stream->buf, stream->nleft, FALSE))
			return EOF;
		stream->nleft = 1;
		stream->buf[0] = uc;
	}
	if (uc != '\n' || (stream->flag & _FIOFULLBUFFERED))
		return uc;
	if (stream->nleft <= 0)
		return uc;
	if (!_dowrite(stream, stream->buf, stream->nleft, TRUE))
		return EOF;
	stream->nleft = 0;
	return uc;
}

#include <stdio.h>
#include <signal.h>
#include "libc.h"

int setvbuf(register FILE *stream, char *buf, register int type, register size_t size)
{
	if (stream == NULL)
	{
		_raise(NULL, &_filerr);
	}
	if ((stream->flag & _FIOWASREAD) || (stream->flag & _FIOWASWRITTEN))
	{
		stream->flag |= _FIOERR;
		return 1;
	}
	if (stream->flag & _FIOBUFALLOCATED)
	{
		_free(stream->buf, NULL);
		stream->flag &= ~_FIOBUFALLOCATED;
	}
	if ((long) size >= 0)
		stream->bufsize = size;
	if (buf != NULL)
		stream->buf = (unsigned char *)buf;
	if (type == _IOFBF)
	{
		stream->flag &= ~(_FIOFULLBUFFERED | _FIOUNBUFFERED);
		stream->flag |= _FIOFULLBUFFERED;
	} else if (type == _IONBF)
	{
		stream->flag &= ~(_FIOFULLBUFFERED | _FIOUNBUFFERED);
		stream->flag |= _FIOUNBUFFERED;
	} else if (type == _IOLBF)
	{
		stream->flag &= ~(_FIOFULLBUFFERED | _FIOUNBUFFERED);
	} else
	{
		return 0;
	}
	return 1;
}

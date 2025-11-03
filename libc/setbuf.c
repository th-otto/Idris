#include <std.h>
#include <pcdecl.h>
#include <stdio.h>
#include <stdarg.h>
#include <signal.h>
#include "libc.h"

void setbuf(FILE *stream, char *buf)
{
	if (stream == NULL)
	{
		_raise(NULL, &_filerr);
	} else if ((stream->flag & _FIOX010) || (stream->flag & _FIOX020))
	{
		stream->flag |= _FIOERR;
	} else
	{
		if (stream->flag & _FIOBUFALLOCATED)
		{
			_free(stream->buf, NULL);
			stream->flag &= ~_FIOBUFALLOCATED;
		}
		if (buf == NULL)
		{
			stream->flag |= _FIOUNBUFFERED;
			stream->buf = NULL;
			stream->bufsize = 0;
		} else
		{
			stream->buf = (unsigned char *)buf;
			stream->bufsize = BUFSIZ;
		}
	}
}

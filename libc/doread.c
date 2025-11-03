#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include "libc.h"

long _doread(register FILE *stream, register unsigned char *s, size_t n)
{
	register long nread;
	
	if (stream == NULL)
	{
		_raise(NULL, &_filerr);
	}
	if (stream->flag & _FIOX400)
	{
		stream->loff = lseek(stream->fd, 0, SEEK_CUR);
	}
	if ((nread = read(stream->fd, s, n)) < 0)
	{
		stream->flag |= _FIOERR;
	} else if (nread == 0)
	{
		stream->flag |= _FIOEOF;
		stream->flag &= ~_FIOX010;
	}
	return nread;
}

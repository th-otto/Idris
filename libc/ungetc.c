#include <stdio.h>
#include <signal.h>
#include "libc.h"

int ungetc(register int c, register FILE *stream)
{
	if (stream == NULL)
	{
		_raise(NULL, &_filerr);
	}
	if (c < 0)
		return c;
	if (!(stream->flag & _FIOREAD) || !_chkio(stream, FALSE) || stream->nleft == stream->bufsize || (stream->flag & _FIOUNBUFFERED))
		return EOF;
	if (stream->nleft == 0)
		*stream->pnext = c;
	else
		*--stream->pnext = c;
	++stream->nleft;
	return (unsigned char)c;
}

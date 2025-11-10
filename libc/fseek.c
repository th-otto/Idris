#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include "libc.h"


/*
 * reposition a stream
 */
int fseek(register FILE *stream, long offset, register int whence)
{
	if (stream == NULL)
	{
		_raise(NULL, &_filerr);
	} else if ((stream->flag & _FIOX400) && offset != 0 && whence != SEEK_SET)
	{
		return 1;
	}
	if (stream->nleft > 0)
	{
		if ((stream->flag & _FIOWASWRITTEN) || whence == SEEK_CUR)
		{
			if (ftell(stream) == -1)
				return 1;
		}
	}
	if (lseek(stream->fd, offset, whence) == -1)
		return 1;
	stream->flag &= ~(_FIOWASREAD | _FIOWASWRITTEN);
	stream->nleft = 0;
	return 0;
}

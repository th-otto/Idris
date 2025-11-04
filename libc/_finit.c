#include <wslxa.h>
#include <stdio.h>
#include <signal.h>
#include <fcntl.h>
#include "libc.h"

FILE *_finit(register FILE *stream, int fd, register int type)
{
	register unsigned short allocated;
	
	if (stream == NULL)
	{
		allocated = _FIOALLOCATED;
		stream = _nalloc(sizeof(*stream), NULL);
		if (stream == NULL)
		{
			_raise(NULL, &_memerr);
		}
	} else if (type & O_REUSE)
	{
		allocated = stream->flag & _FIOALLOCATED;
	} else
	{
		allocated = 0;
	}
	stream->flist = NULL;
	stream->fd = fd;
	stream->nleft = 0;
	stream->bufsize = BUFSIZ;
	stream->pnext = NULL;
	stream->buf = NULL;
	stream->flag = allocated;
	if ((type & O_ACCMODE) != O_WRONLY)
		stream->flag |= _FIOREAD;
	if ((type & O_ACCMODE) != O_RDONLY)
		stream->flag |= _FIOWRITE;
	if ((type & O_BUF) || (type & O_BIN))
		stream->flag |= _FIOFULLBUFFERED;
	if (stream->flag & _FIOWRITE)
	{
		if ((stream->flag & _FIOFULLBUFFERED) || !(stream->flag & _FIOUNBUFFERED))
		{
			if (!_onlist(stream, &_pfile))
			{
				stream->flist = _pfile;
				_pfile = stream;
			}
		}
	}
	return stream;
}

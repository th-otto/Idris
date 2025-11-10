#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include "libc.h"


static long readback(int fd, unsigned char *buf, long pos);


/*
 * obtain the current value of the file position
 */
long ftell(register FILE *stream)
{
	register long pos;
	register long count;
	
	if (stream == NULL)
	{
		_raise(NULL, &_filerr);
	}
	pos = 0;
	if ((stream->flag & _FIOWASWRITTEN) && stream->nleft > 0)
	{
		if (!_dowrite(stream, stream->buf, stream->nleft, TRUE))
			return -1;
		stream->nleft = 0;
	} else if ((stream->flag & _FIOWASREAD) && stream->nleft > 0)
	{
		if (!(stream->flag & _FIOX400))
		{
			pos = -stream->nleft;
			stream->nleft = 0;
			stream->pnext = stream->buf;
		} else
		{
			if (lseek(stream->fd, stream->loff, SEEK_SET) == -1)
				return -1;
			count = stream->pnext - stream->buf;
			stream->nleft = 0;
			if (readback(stream->fd, stream->pnext = stream->buf, count) != count)
				return -1;
		}
	}
	return lseek(stream->fd, pos, SEEK_CUR);
}


static long readback(int fd, unsigned char *buf, register long count)
{
	register long pos;
	register long nread;
	
	for (pos = 0; pos < count; buf += nread, pos += nread)
	{
		if ((nread = read(fd, buf, count - pos)) == 0)
			break;
		if (nread < 0)
		{
			pos = nread;
			break;
		}
	}
	return pos;
}

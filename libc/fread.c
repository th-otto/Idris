#include <stdio.h>
#include <signal.h>
#include "libc.h"


int fread(void *ptr, size_t size, int nelem, register FILE *stream)
{
	register unsigned char *dst;
	register size_t n;
	register size_t toread;
	register size_t total;
	register long nread;
	
	total = size * nelem;
	if (total == 0)
		return 0;
	if (stream == NULL)
	{
		_raise(NULL, &_filerr);
	} else if (!(stream->flag & _FIOWASREAD) && !_chkio(stream, FALSE))
	{
		return 0;
	}
	dst = ptr;
	n = 0;
	if (stream->flag & _FIOUNBUFFERED)
	{
		while (n < total)
		{
			toread = n + size <= total ? size : total - n;
			nread = _doread(stream, dst, toread);
			if (nread <= 0)
				break;
			dst += nread;
			n += nread;
		}
	} else
	{
		if (stream->nleft == 0 && (size_t)stream->bufsize <= total && (total % stream->bufsize) == 0)
		{
			nread = _doread(stream, dst, total);
			if (nread <= 0)
			{
				stream->nleft = nread;
			} else
			{
				n += nread;
				dst += nread;
			}
		}
		while (n < total && stream->nleft >= 0)
		{
			if (stream->nleft == 0)
			{
				stream->nleft = _doread(stream, stream->pnext = stream->buf, stream->bufsize);
				if (stream->nleft <= 0)
					break;
			}
			while (n < total && stream->nleft > 0)
			{
				*dst++ = *stream->pnext++;
				stream->nleft--;
				n++;
			}
		}
	}
	return n / size;
}

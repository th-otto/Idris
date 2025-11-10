#include <stdio.h>
#include <signal.h>
#include "libc.h"


/*
 * binary stream output
 */
int fwrite(const void *ptr, size_t size, int nelem, register FILE *stream)
{
	register unsigned char *dst;
	register const unsigned char *src;
	register size_t n;
	register size_t towrite;
	register size_t total;
	
	total = size * nelem;
	if (total == 0)
		return 0;
	if (stream == NULL)
	{
		_raise(NULL, &_filerr);
	} else if (!(stream->flag & _FIOWASWRITTEN) && !_chkio(stream, TRUE))
	{
		return 0;
	}
	src = ptr;
	n = 0;
	if (stream->flag & _FIOUNBUFFERED)
	{
		while (n < total)
		{
			towrite = n + size <= total ? size : total - n;
			if (_dowrite(stream, src, towrite, TRUE) == 0)
				break;
			src += towrite;
			n += towrite;
		}
	} else
	{
		if (stream->nleft == 0 && (size_t)stream->bufsize <= total && (total % stream->bufsize) == 0)
		{
			if (_dowrite(stream, src, total, FALSE) != 0)
			{
				n += total;
				src += total;
			}
		}
		while (n < total && !(stream->flag & _FIOERR))
		{
			dst = stream->buf + stream->nleft;
			while (n < total && stream->nleft < stream->bufsize)
			{
				*dst++ = *src++;
				n++;
				stream->nleft++;
			}
			if (stream->bufsize <= stream->nleft)
			{
				if (_dowrite(stream, stream->buf, stream->nleft, FALSE) == 0)
					break;
				stream->nleft = 0;
			}
		}
	}
	return n / size;
}

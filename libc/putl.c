#include <std.h>
#include <pcdecl.h>
#include <stdio.h>
#include <signal.h>
#include "libc.h"


size_t putl(void *arg, register const char *s, size_t count)
{
	register FILE *fp = arg;
	register size_t n;
	register unsigned char *dst;
	
	if (fp == NULL)
	{
		_raise(NULL, &_fioerr);
	}
	if (!(fp->flag & _FIOWASWRITTEN) && !_chkio(fp, TRUE))
	{
		_raise(NULL, &_wrierr);
	}
	if (fp->flag & _FIOUNBUFFERED)
	{
		if (!_dowrite(fp, s, count, TRUE))
			_raise(NULL, &_wrierr);
		return count;
	}
	n = count;
	while (n != 0)
	{
		dst = fp->buf + fp->nleft;
		while (n != 0 && fp->nleft < fp->bufsize)
		{
			*dst++ = *s++;
			--n;
			++fp->nleft;
		}
		if (n != 0)
		{
			if (!_dowrite(fp, fp->buf, fp->bufsize, FALSE))
				_raise(NULL, &_wrierr);
			fp->nleft = 0;
		}
	}
	if (!(fp->flag & _FIOFULLBUFFERED) && fp->nleft != 0 && fp->buf[fp->nleft - 1] == '\n')
	{
		if (!_dowrite(fp, fp->buf, fp->nleft, TRUE))
			_raise(NULL, &_wrierr);
		fp->nleft = 0;
	}
	return count;
}

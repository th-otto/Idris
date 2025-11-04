#include <stdio.h>
#include <signal.h>
#include <string.h>
#include "libc.h"

int fputs(const char *s, register FILE *stream)
{
	register size_t i;
	register size_t len;
	register int ret;
	register const char *src;
	register unsigned char *dst;
	int fullbuffered;
	int doflush;
	unsigned char uc;

	fullbuffered = stream->flag & _FIOFULLBUFFERED;
	if (stream == NULL)
	{
		_raise(NULL, &_filerr);
	} else if (!(stream->flag & _FIOWASWRITTEN) && !_chkio(stream, TRUE))
	{
		return EOF; /* Note: return value in origin code was wrong */
	}
	if ((len = strlen(s)) == 0)
		return 0;
	if (stream->flag & _FIOUNBUFFERED)
	{
		return _dowrite(stream, s, len, TRUE) ? 0 : EOF;
	}
	src = s;
	for (i = len; i != 0; )
	{
		ret = stream->nleft < stream->bufsize ? 1 : 0;
		dst = &stream->buf[stream->nleft];
		uc = 0; /* was bug in original code: maybe used uninitialized */
		while (i != 0 && ret)
		{
			uc = *src++;
			*dst++ = uc;
			i--;
			stream->nleft++;
			ret = stream->nleft < stream->bufsize && (fullbuffered != 0 || uc != '\n') ? 1 : 0;
		}
		if (ret == 0)
		{
			doflush = fullbuffered == 0 && uc == '\n';
			if (!_dowrite(stream, stream->buf, stream->nleft, doflush))
				return EOF;
			stream->nleft = 0;
		}
	}
	
	return 0;
}

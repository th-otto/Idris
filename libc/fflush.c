#include <stdio.h>
#include <signal.h>
#include "libc.h"

int fflush(register FILE *stream)
{
	register int ret;
	
	if (stream == NULL)
	{
		/* FIXME: fflush(NULL) should flush all streams */
		_raise(NULL, &_filerr);
	}
	ret = 0;
	if ((stream->flag & _FIOWASWRITTEN) && stream->nleft > 0)
	{
		if (!_dowrite(stream, stream->buf, stream->nleft, TRUE))
			ret = EOF;
		else
			stream->nleft = 0;
	}
	return ret;
}

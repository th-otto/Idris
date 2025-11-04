#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include "libc.h"

int _doclose(register FILE *stream, int freeit)
{
	register FILE **pf;
	register int ret;
	
	if (stream == NULL)
	{
		_raise(NULL, &_filerr);
	}
	pf = _onlist(stream, &_pfile);
	if (pf != NULL)
		*pf = stream->flist;
	if ((stream->flag & _FIOWASWRITTEN) && stream->nleft > 0)
	{
		_dowrite(stream, stream->buf, stream->nleft, TRUE);
	}
	ret = close(stream->fd) < 0 ? -1 : 0;
	if (stream->flag & _FIOBUFALLOCATED)
		_free(stream->buf, NULL);
	if ((stream->flag & _FIOALLOCATED) && freeit)
		_free(stream, NULL);
	stream->flag = 0;
	return ret;
}

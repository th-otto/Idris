#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <wslxa.h>
#include "libc.h"


int _chkio(register FILE *stream, int forwrite)
{
	register int flag;
	
	if (stream == NULL)
	{
		_raise(NULL, &_filerr);
	}
	
	if (_fnext == 0)
	{
		_fnext = _onexit(_doflush);
	}
	flag = forwrite ? _FIOWASWRITTEN : _FIOWASREAD;
	if ((flag == _FIOWASWRITTEN && ((stream->flag & (_FIOWASREAD | _FIOWASWRITTEN)) != _FIOWASWRITTEN)) ||
		(flag == _FIOWASREAD && ((stream->flag & (_FIOWASWRITTEN | _FIOREAD)) != _FIOREAD)))
	{
		stream->flag |= _FIOERR;
		return FALSE;
	}
	if (stream->buf == NULL && !(stream->flag & _FIOUNBUFFERED))
	{
		if ((stream->buf = _alloc(stream->bufsize, NULL)) == NULL)
		{
			stream->flag |= _FIOUNBUFFERED;
			return FALSE;
		}
	}
	if ((stream->flag & (_FIOWASREAD | _FIOWASWRITTEN)) == 0)
		stream->nleft = 0;
	stream->flag = (stream->flag & ~(_FIOWASREAD | _FIOWASWRITTEN)) | flag;
	return TRUE;
}


onexit_t _doflush(void)
{
	register FILE *stream;
	register struct tmpfile *tmp;
	
	for (stream = _pfile; stream != NULL; stream = stream->flist)
	{
		if (stream->flag & _FIOWASWRITTEN)
			_dowrite(stream, stream->buf, stream->nleft, TRUE);
	}
	for (tmp = _tfile; tmp != NULL; tmp = _free(tmp, tmp->link))
	{
		_doclose(tmp->fp, TRUE);
		remove(tmp->filename);
	}
	return _fnext;
}

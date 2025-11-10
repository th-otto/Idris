#include <stdio.h>
#include <signal.h>
#include "libc.h"


/*
 * check stream status
 */
int ferror(register FILE *stream)
{
	if (stream == NULL)
	{
		_raise(NULL, &_filerr);
	}
	return (stream->flag & _FIOERR) != 0;
}

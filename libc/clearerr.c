#include <stdio.h>
#include <signal.h>
#include "libc.h"

/*
 * reset stream status
 */
void clearerr(register FILE *stream)
{
	if (stream == NULL)
	{
		_raise(NULL, &_filerr);
	} else
	{
		stream->flag &= ~(_FIOERR | _FIOEOF);
	}
}

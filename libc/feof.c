#include <stdio.h>
#include <signal.h>
#include "libc.h"


int feof(register FILE *stream)
{
	if (stream == NULL)
	{
		_raise(NULL, &_filerr);
	}
	return (stream->flag & _FIOEOF) != 0;
}

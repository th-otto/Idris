#include <stdio.h>
#include <signal.h>
#include "libc.h"

/*
 * close a file controlled by FIO buffer
 */
int fclose(FILE *stream)
{
	if (stream == NULL)
	{
		/* FIXME: fclose(NULL) means close all open stdio streams */
		_raise(NULL, &_filerr);
	}
	return _doclose(stream, TRUE);
}

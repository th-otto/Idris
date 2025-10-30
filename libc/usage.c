#include <pcdecl.h>
#include <stdlib.h>
#include "libc.h"

COUNT usage(const char *msg)
{
	_putstr(STDERR, "usage :", _pname, " ", msg, NULL);
	if (msg != NULL && msg[_lenstr(msg) - 1] == '\n')
		exit(1);
	return _lenstr(_pname) + 8;
}

#include <std.h>
#include <math.h>
#include <errno.h>
#include <signal.h>
#include <pcdecl.h>
#include "libc.h"

/*
 * report domain error
 */
void _domain(const char *str)
{
	if (_domerr != NULL)
	{
		errno = EDOM;
		_remark(str, NULL);
	} else
	{
		_domerr = str;
		_raise(NULL, &_domerr);
	}
}

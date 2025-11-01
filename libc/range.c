#include <std.h>
#include <math.h>
#include <errno.h>
#include <signal.h>
#include <pcdecl.h>
#include "libc.h"

double _range(const char *str)
{
	if (_ranerr != NULL)
	{
		errno = ERANGE;
		_remark(str, NULL);
	} else
	{
		_ranerr = str;
		_raise(0, &_ranerr);
	}
	return HUGE_VAL;
}

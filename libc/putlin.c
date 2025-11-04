#include <std.h>
#include <pcdecl.h>
#include <stdio.h>
#include "libc.h"


BYTES putlin(const char *s, BYTES n)
{
	return putl(&_stdout, s, n);
}

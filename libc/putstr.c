#include <std.h>
#include <pcdecl.h>
#include <string.h>
#include "libc.h"

void _putstr(FD fd, ...)
{
	register const char **args = ((const char **)(&fd + 1));
	
	while (*args)
	{
		_fwrite(fd, *args, _lenstr(*args));
		args++;
	}
}

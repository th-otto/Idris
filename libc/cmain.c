/* SET UP ENVIRONMENT AND CALL main()
 * Copyright (c) 1986 by Whitesmiths, Ltd.
 */
#include <std.h>
#define getenv _getenv
#include <stdlib.h>
#include "libc.h"

int _main __((long ac, char *args));
int main __((int argc, char **argv, const char **ev));

int _main(long ac, char *args)
{
	register char *p;
	register const char **ev;

	ev = (const char **)(&(&args)[ac + 1]);
	environ = ev;
	if (ac)
	{
		_pname = args;
		for (p = args; *p; ++p)
			if (*p == ':' || *p == '|')
			{
				*p++ = '\0';
				_paths = p;
				break;
			}
	}
	if ((p = getenv("PATH")) != NULL)
		_paths = p;
	return main(ac, &args, ev);
}


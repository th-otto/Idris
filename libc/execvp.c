#include <std.h>
#include <unistd.h>
#include <sys/xeq.h>
#include <stdlib.h>
#include <limits.h>
#include <errno.h>
#include "libc.h"

/*
 * execute a file
 */
int execvp(const char *file, const char *argv[])
{
	register const char *s;
	register const char *p;
	register COUNT i;
	char buf[PATH_MAX];
	
	p = getenv("PATH");
	if (p == NULL)
		p = _paths;
	for (;;)
	{
		for (s = p, i = 0; *s != '\0' && *s != '|' && *s != ':'; )
		{
			if (i < PATH_MAX)
			{
				buf[i++] = *s++;
			} else
			{
				errno = E2BIG;
				return -1;
			}
		}
		p = (s[0] != '\0' && (s[1] != '\0' || s == p)) ? &s[1] : s;
		s = file;
		for (;;)
		{
			if (i < PATH_MAX)
			{
				buf[i++] = *s;
				if (*s == '\0')
				{
					_xeq(buf, argv, environ, X_SYN | X_OVLAY);
					if (errno != ENOENT)
						return -1;
					if (*p == '\0')
						return -1;
					break;
				} else
				{
					s++;
				}
			} else
			{
				errno = E2BIG;
				return -1;
			}
		}
	}
	return -1;
}

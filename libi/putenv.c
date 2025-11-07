#include <std.h>
#include <pcdecl.h>
#include <wslxa.h>
#include <stdlib.h>
#include <unistd.h>


static const char **lastenv;

/*
 * change or add an environment variable
 */
char *putenv(char *string)
{
	size_t equal;
	int i;
	const char **ptr;
	
	equal = _scnstr(string, '=');
	/* BUG: will also find old values like "PATHS=" when setting "PATH=" */
	for (i = 0, ptr = environ; ptr != NULL && *ptr != NULL && !cmpbuf(string, *ptr, equal); ptr++, i++)
		;
	if (ptr != NULL && *ptr != NULL)
	{
		*ptr = string;
	} else
	{
		/* was bug in original code: missing link argument to _nalloc() */
		ptr = _nalloc(i * sizeof(*ptr) + 2 * sizeof(*ptr), NULL);
		if (ptr != NULL)
		{
			if (i != 0)
				_cpybuf(ptr, environ, i * sizeof(*ptr));
			ptr[i] = string;
			ptr[i + 1] = NULL;
			if (lastenv == environ)
				free(environ);
			environ = lastenv = ptr;
		}
	}
	return ptr != NULL ? (char *)ptr[i] : NULL;
}

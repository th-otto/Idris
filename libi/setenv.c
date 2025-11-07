#include <std.h>
#include <pcdecl.h>
#include <wslxa.h>
#include <stdlib.h>
#include <unistd.h>


char *setenv(const char *name, register const char *value)
{
	register const char **ptr;
	register char *newstr;
	register size_t len;
	register int i;
	
	len = _lenstr(name);
	for (i = 0, ptr = environ; ptr != NULL && *ptr != NULL; ptr++, i++)
	{
		if (cmpbuf(name, *ptr, len) && (*ptr)[len] == '=')
		{
			free(inheap((void *)*ptr));
			break;
		}
	}
	if (value != NULL)
	{
		/* was bug in original code: missing link argument to _alloc() */
		newstr = _alloc(_lenstr(value) + len + 2, NULL);
		/* BUG: no alloc check */
		_cpystr(newstr, name, "=", value, NULL);
		if (ptr != NULL && *ptr != NULL)
		{
			*ptr = newstr;
		} else
		{
			/* was bug in original code: missing link argument to _alloc() */
			ptr = _alloc(i * sizeof(*ptr) + 2 * sizeof(*ptr), NULL);
			if (ptr != NULL)
			{
				if (i != 0)
					_cpybuf(ptr, environ, i * sizeof(*ptr));
				ptr[i] = newstr;
				ptr[i + 1] = NULL;
				free(inheap(environ));
				environ = ptr;
			}
		}
	} else
	{
		if (ptr != NULL && *ptr != NULL)
		{
			while ((ptr[0] = ptr[1]) != NULL)
				ptr++;
		}
		return NULL;
	}
	return newstr + len + 1;
}


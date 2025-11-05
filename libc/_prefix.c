#include <std.h>
#include <pcdecl.h>

BOOL _prefix(register const char *s1, register const char *s2)
{
	while (*s2 != '\0')
	{
		if (*s1++ != *s2++)
			return 0;
	}
	return 1;
}

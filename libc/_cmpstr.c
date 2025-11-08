#include <std.h>
#include <pcdecl.h>

/*
 * compare two strings for equality
 */
BOOL _cmpstr(register const char *s1, register const char *s2)
{
	register char c;
	
	for (;;)
	{
		if ((c = *s2++) != *s1++)
			break;
		if (c == '\0')
			return 1;
	}
	return 0;
}

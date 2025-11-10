#include <std.h>
#include <pcdecl.h>


/*
 * scan string for character
 */
BYTES _scnstr(const char *s, register char c)
{
	register const char *str = s;
	
	for (;;)
	{
		if (*str == c)
			break;
		if (*str++ == 0)
		{
			str--;
			break;
		}
	}
	return str - s;
}

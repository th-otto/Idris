#include <std.h>
#include <pcdecl.h>
#include <string.h>
#include <ctype.h>


/*
 * convert characters in buffer to uppercase
 */
size_t upper(register char *s, register size_t n)
{
	size_t i;
	
	for (i = 0; i < n; i++)
	{
		*s = toupper(*s);
		s++;
	}
	return n;
}

#include <std.h>
#include <pcdecl.h>
#include <string.h>
#include <ctype.h>


size_t lower(register char *s, register size_t n)
{
	size_t i;
	
	for (i = 0; i < n; i++)
	{
		*s = tolower(*s);
		s++;
	}
	return n;
}

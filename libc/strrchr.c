#include <string.h>


char *strrchr(register const char *s, register int c)
{
	register char *ret = NULL;
	
	while (*s != '\0')
	{
		if (*s == (char)c)
			ret = (char *)s;
		s++;
	}
	if (*s == (char)c)
		return (char *)s;
	return ret;
}

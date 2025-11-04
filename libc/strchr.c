#include <string.h>

char *strchr(register const char *s, register int c)
{
	while (*s != '\0' && *s != (char)c)
	{
		s++;
	}
	if (*s == (char)c)
		return (char *)s;
	return NULL;
}

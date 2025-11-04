#include <string.h>

char *strcpy(register char *s1, register const char *s2)
{
	register char *dst = s1;
	
	while ((*dst++ = *s2++) != '\0')
		;
	return s1;
}

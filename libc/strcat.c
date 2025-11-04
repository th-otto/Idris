#include <string.h>

char *strcat(char *s1, register const char *s2)
{
	register char *dst = s1;
	
	while (*dst++ != '\0')
		;
	dst--;
	while ((*dst++ = *s2++) != '\0')
		;
	return s1;
}

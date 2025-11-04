#include <stdio.h>

int puts(const char *s)
{
	/* Note: return value in origin code was wrong */
	if (fputs(s, stdout) < 0 || fputc('\n', stdout) < 0)
		return EOF;
	return 0;
}

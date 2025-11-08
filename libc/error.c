#include <std.h>
#include <pcdecl.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include "libc.h"

static void errstr(register const char *str)
{
	if (str != NULL && *str != '\0')
	{
		register const char *ptr = str;
		while (*ptr != '\0')
			ptr++;
		write(STDERR, str, ptr - str);
	}
}


/*
 * print error message and exit
 */
void _error(const char *s1, const char *s2)
{
	errstr(_pname);
	errstr(": ");
	errstr(s1);
	errstr(s2);
	errstr("\n");
	exit(1);
}

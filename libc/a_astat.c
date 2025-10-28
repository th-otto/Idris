#include <std.h>
#include <stdio.h>
#include "libc.h"

FILE *stdin;
FILE *stdout;
FILE *stderr;

void _astat(void)
{
	stderr = &_stderr;
	stdin = &_stdin;
	stdout = &_stdout;
}

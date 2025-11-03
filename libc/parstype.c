#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <ctype.h>
#include "libc.h"

static unsigned short const types[2][3] = {
	{ O_RDONLY, O_WRONLY | O_CREAT | O_TRUNC, O_WRONLY | O_CREAT | O_APPEND },
	{ O_RDWR,   O_RDWR | O_CREAT | O_TRUNC,   O_RDWR | O_CREAT | O_APPEND }
};

int _parstype(register const char *mode)
{
	register int type;
	register int i;
	register int rw;
	
	for (i = 0; i < 3 && *mode != "rwa"[i]; i++)
		;
	if (i == 3)
		return -1;
	++mode;
	rw = *mode == '+';
	if (rw)
		mode++;
	type = types[rw][i];
	if (*mode == 'b')
	{
		type |= O_BIN;
		mode++;
	}
	while (isspace((unsigned char)*mode))
	{
		mode++;
	}
	if (*mode != '\0' && *mode != ',')
		return -1;
	return type;
}

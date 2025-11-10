#include <stdio.h>
#include "libc.h"


/*
 * stream open function
 */
FILE *fdopen(int fd, const char *mode)
{
	int type;
	
	if ((type = _parstype(mode)) == -1)
		return NULL;
	return _finit(NULL, fd, type);
}

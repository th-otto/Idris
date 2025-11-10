#include <stdio.h>

/*
 * obtain file descriptor of a stdio stream
 */
#undef fileno
int fileno(FILE *f)
{
	return f->fd;
}

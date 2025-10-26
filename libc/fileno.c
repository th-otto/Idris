#include <stdio.h>

#undef fileno
int fileno(FILE *f)
{
	return f->fd;
}

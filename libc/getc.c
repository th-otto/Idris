#include <stdio.h>

/*
 * get a character from input buffer
 */
int (getc)(FILE *stream)
{
	return fgetc(stream);
}

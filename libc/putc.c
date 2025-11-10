#include <stdio.h>

/*
 * put a character to output buffer
 */
int (putc)(int c, FILE *stream)
{
	return fputc(c, stream);
}

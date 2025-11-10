#include <stdio.h>

/*
 * put a character to output buffer stdout
 */
int (putchar)(int c)
{
	return putc(c, stdout);
}

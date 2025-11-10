#include <stdio.h>

/*
 * get a character from input buffer stdin
 */
int (getchar)(void)
{
	return getc(stdin);
}


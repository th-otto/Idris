#include "libi.h"

/*
 * clear standard sized buffer
 */
void clrbuf(void *buf)
{
	register unsigned char *dst = buf;
	register short i;
	
	for (i = BLOCK_SIZE; --i >= 0; )
		*dst++ = 0;
}

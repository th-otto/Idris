#include <wslxa.h>

/*
 * convert long to pdp-endian format
 */
char *ltols(register char *pl, register LONG lo)
{
	pl[2] = lo;
	lo >>= 8;
	pl[3] = lo;
	lo >>= 8;
	pl[0] = lo;
	lo >>= 8;
	pl[1] = lo;
	return pl;
}

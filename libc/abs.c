/*	ABSOLUTE VALUE
 *	copyright (c) 1980 by Whitesmiths, Ltd.
 */
#include <std.h>
#include <math.h>

#undef abs
int abs(int d)
{
	return (d < 0) ? -d : d;
}

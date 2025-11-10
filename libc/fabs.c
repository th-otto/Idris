/*	ABSOLUTE VALUE
 *	copyright (c) 1980 by Whitesmiths, Ltd.
 */
#include <std.h>
#include <math.h>

/*
 * absolute value of floating-point number
 */
double fabs(double d)
{
	return (d < 0) ? -d : d;
}

#include <std.h>
#include <pcdecl.h>
#include <math.h>

/*
 * round off a fraction string
 */
int _round(DOUBLE d)
{
	return (d < 0) ? -(int)(-d + 0.5) : (int)(d + 0.5);
}

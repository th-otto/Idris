#include <math.h>
#include "libm.h"

/*
 * cosine function
 */
double cos(double x)
{
	return _sin(x, 1);
}

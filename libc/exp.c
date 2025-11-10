#include <math.h>
#include "libm.h"

/*
 * base-e exponential function
 */
double exp(double x)
{
	return _exp(x, 0, "exp range error");
}

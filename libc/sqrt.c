#include <math.h>
#include "libm.h"

/*
 * real square root
 */
double sqrt(double x)
{
	return _sqrt(x, "sqrt domain error");
}

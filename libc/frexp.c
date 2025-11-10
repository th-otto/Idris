#include <math.h>
#include "libm.h"

/*
 * convert floating-point number to fractional and integral components
 */
double frexp(double value, int *exp)
{
	*exp = _unpack(&value);
	return value;
}

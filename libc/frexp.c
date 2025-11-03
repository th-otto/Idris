#include <math.h>
#include "libm.h"

double frexp(double value, int *exp)
{
	*exp = _unpack(&value);
	return value;
}

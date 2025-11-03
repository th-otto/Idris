#include <math.h>
#include "libm.h"

double cos(double x)
{
	return _sin(x, 1);
}

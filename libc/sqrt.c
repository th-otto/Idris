#include <math.h>
#include "libm.h"

double sqrt(double x)
{
	return _sqrt(x, "sqrt domain error");
}

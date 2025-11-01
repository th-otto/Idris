#include <math.h>
#include "libm.h"

double exp(double x)
{
	return _exp(x, 0, "exp range error");
}

#ifndef __LIMITS__
#include <limits.h>
#endif
#ifndef __STDINT__
typedef unsigned int uint32_t;
typedef unsigned short uint16_t;
#endif

#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
typedef union
{
	double value;
	struct
	{
		union {
			struct {
				uint16_t signexp;
				uint16_t msw;
			} m;
			uint32_t msw;
		} msw;
		uint32_t lsw;
	} parts;
} ieee_double_shape_type;
#else
typedef union
{
	double value;
	struct
	{
		uint32_t lsw;
		union {
			struct {
				uint16_t msw;
				uint16_t signexp;
			} m;
			uint32_t msw;
		} msw;
	} parts;
} ieee_double_shape_type;
#endif

#define IEEE754_DOUBLE_MAXEXP	0x7ff
#define IEEE754_DOUBLE_BIAS	0x3ff /* Added to exponent.  */
#define IEEE754_DOUBLE_SHIFT 20

double _atan2(double y, double x);
double _sin(double x, int sin_or_cos);
double _sqrt(double x, const char *err);
double _exp(double x, int rad, const char *err);
int _unpack(double *x);
double _addexp(double d, int n, const char *msg);
int _fcan(char *d);


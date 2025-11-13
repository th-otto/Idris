#include "libm.h"

int _fcan(register char *d)
{
	register int i;
	register int exp;

#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
	if (d[0] == 0 && d[1] == 0)
		return 0;
	exp = (d[0] & 127) << 4;
	exp |= (d[1] & 0xf0) >> 4;
	d[0] &= 0x80;
	d[1] = (d[1] & 0x0f) | 0x10;
	for (i = 1; i < 7; i++)
	{
		d[i] = (d[i] << 3) | ((d[i + 1] >> 5) & 7);
	}
	d[7] = d[7] << 3;
#else
	if (d[6] == 0 && d[7] == 0)
		return 0;
	exp = (d[7] & 127) << 4;
	exp |= (d[6] & 0xf0) >> 4;
	d[7] &= 0x80;
	d[6] = (d[6] & 0x0f) | 0x10;
	for (i = 6; i > 0; i--)
	{
		d[i] = (d[i] << 3) | ((d[i - 1] >> 5) & 7);
	}
	d[0] = d[0] << 3;
#endif
	return exp - (IEEE754_DOUBLE_BIAS - 1);
}

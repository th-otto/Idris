#include <wslxa.h>
#include "libc.h"
#include "libm.h"

double _dtento(double d, int _exp)
{
	register double *dtens;
	register int exp;
	register unsigned int uexp;
	register int i;
	register int maxtens;
	register int dexp;
	short limit;
	
	dtens = _dtens;
	exp = _exp;
	maxtens = _ntens - 1;
	if (d == 0)
		return 0;
	dexp = _unpack(&d);
	if (exp < 0)
	{
		uexp = -exp;
		i = 1;
		while (uexp != 0 && i < maxtens)
		{
			if (uexp & 1)
				d = d / dtens[i];
			uexp >>= 1;
			i++;
		}
		if (uexp != 0)
		{
			limit = -(((1UL << maxtens) * 100000UL) / 30103L);
			while (uexp != 0 && limit < dexp)
			{
				dexp += _unpack(&d);
				d = d / dtens[maxtens];
				uexp--;
			}
		}
	} else if (exp > 0)
	{
		uexp = exp;
		i = 1;
		while (uexp != 0 && i < maxtens)
		{
			if (uexp & 1)
				d = d * dtens[i];
			uexp >>= 1;
			i++;
		}
		if (uexp != 0)
		{
			limit = ((1UL << maxtens) * 100000UL) / 30103L;
			while (uexp != 0 && dexp < limit)
			{
				dexp += _unpack(&d);
				d = d * dtens[maxtens];
				uexp--;
			}
		}
	}
	return _addexp(d, dexp, "dtento range error");
}

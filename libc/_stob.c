#include <std.h>
#include <pcdecl.h>
#include <math.h>

BYTES _stob(char *is, register COUNT ln, register int base)
{
	register int _base;
	register char *dst;
	register COUNT _n;
	static char const alphabet[] = "0123456789abcdefghijklmnopqrstuvwxyz";

	if (base < -36 || base > 36)
	{
		_domain("stob base error");
		return 0;
	}
	_base = base < 0 ? -base : base;
	if (_base <= 1)
		_base = 10;
	dst = is;
	if (ln < 0)
	{
		if (base > 0)
		{
			_n = ln;
		} else
		{
			_n = -ln;
			*dst++ = '-';
		}
		if (_n >= 0)
		{
			ln = _n;
		} else
		{
			dst += _ltob(dst, (UCOUNT)_n / _base, _base);
			ln = (UCOUNT)_n % _base;
		}
	}
	if (_base <= ln)
	{
		dst += _ltob(dst, ln / _base, _base);
		ln = ln % _base;
	}
	*dst = alphabet[ln];
	return dst - is + 1;
}

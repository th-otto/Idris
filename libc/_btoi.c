#include <std.h>
#include <pcdecl.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <math.h>


#ifndef FUNCNAME
#define FUNCNAME _btoi
#define VALTYPE int
#define UVALTYPE unsigned int
#define ERRMSG "text to integer conversion error"
#endif


BYTES FUNCNAME(const char *s, register BYTES n, VALTYPE *i, register int base)
{
	register VALTYPE digit;
	register const char *ptr;
	register UVALTYPE val;
	register int overflow;
	VALTYPE result;
	int sign;
	unsigned VALTYPE maxval;
	unsigned VALTYPE lastval;
	static char const alphabet[] = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

	ptr = s;

	while (n != 0 && isspace((unsigned char)*ptr))
	{
		ptr++;
		n--;
	}
	sign = 0;
	if (n != 0)
	{
		if (*ptr == '+')
		{
			ptr++;
			n--;
		} else if (*ptr == '-')
		{
			ptr++;
			n--;
			sign = 1;
		}
	}
	if (n == 0)
	{
		base = 1;
	} else if (base <= 1)
	{
		if (*ptr != '0')
		{
			base = 10;
		} else if (n > 1 && (ptr[1] == 'x' || ptr[1] == 'X'))
		{
			ptr += 2;
			n -= 2;
			base = 16;
		} else
		{
			base = 8;
		}
	} else if (base == 16 && n >= 2 && ptr[0] == '0' && (ptr[1] == 'x' || ptr[1] == 'X'))
	{
		ptr += 2;
		n -= 2;
	}

	lastval = 0;
	val = 0;
	maxval = (unsigned VALTYPE)-1 / base;
	overflow = 0;
	while (n != 0)
	{
		if (isdigit((unsigned char)*ptr))
		{
			digit = *ptr - '0';
		} else
		{
			digit = _scnstr(alphabet, *ptr);
			if (alphabet[digit] == '\0')
				break;
			if (digit < 26)
				digit += 10;
			else
				digit += 10 - 26;
		}
		if (base <= digit)
			break;
		if (maxval < val)
			overflow = 1;
		val = val * base + digit;
		if (val < lastval)
			overflow = 1;
		lastval = val;
		n--;
		ptr++;
	}

	digit = 0;
	while (n != 0)
	{
		if (*ptr == 'l' || *ptr == 'L')
		{
			if (digit & 2)
				break;
			digit |= 2;
			ptr++;
			n--;
		} else if (*ptr == 'u' || *ptr == 'U')
		{
			if (digit & 1)
				break;
			digit |= 1;
			ptr++;
			n--;
		} else
		{
			break;
		}
	}
	if (sign)
	{
		result = -lastval;
		if (result > 0)
			overflow = 1;
	} else
	{
		result = lastval;
		if (result < 0)
			overflow = 1;
	}

	*i = result;
	if (overflow)
		_range("text to integer conversion error"); /* WTF */

	return ptr - s;
}

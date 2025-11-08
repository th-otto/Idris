#include <std.h>
#include <pcdecl.h>
#include <ctype.h>

/*
 * process character escape sequences
 */
int doesc(char **pp, const char *magic)
{
	char *p;
	BYTES pos;
	int val;
	int c;
	static char const alphabet[] = "0123456789abcdefABCDEF";
	static char const digitval[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 10, 11, 12, 13, 14, 15 };

	p = (++*pp);
	if (*p == '\0')
	{
		return **pp;
	}
	pos = _scnstr("abfnrtv", tolower(*p));
	if (pos < 6)
	{
		*pp = p;
		return "\a\b\f\n\r\t\v"[pos];
	}
	if (*p == 'x')
	{
		p++;
		val = 0;
		pos = 0;
		while (isxdigit((unsigned char)*p) && pos < 3)
		{
			c = _scnstr(alphabet, *p);
			if (alphabet[c] != '\0')
			{
				val = (val << 4) | digitval[c];
			}
			p++;
			pos++;
		}
		*pp = p - 1;
		return val;
	} else if (isdigit((unsigned char)*p))
	{
		val = 0;
		pos = 0;
		while (isdigit((unsigned char)*p) && pos < 3)
		{
			if (*p >= '8')
			{
				if (pos == 0)
					val = *p;
				break;
			}
			val = (val << 3) | (*p - '0');
			p++;
			pos++;
		}
		*pp = p - 1;
		return val;
	} else if (magic && (pos = _scnstr(magic, *p), magic[pos] != '\0'))
	{
		*pp = p;
		return -1 - pos;
	} else
	{
		*pp = p;
		return *p;
	}
}

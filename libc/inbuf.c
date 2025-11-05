#include <std.h>
#include <pcdecl.h>

BYTES inbuf(register const char *is, register BYTES n, const char *p)
{
	register const char *pscan;
	register const char *iscan;
	
	iscan = is;
	while (n != 0)
	{
		pscan = p;
		do
		{
			if (*iscan == *pscan)
				return iscan - is;
			pscan++;
		} while (*pscan != 0);
		n--;
		iscan++;
	}
	return iscan - is;
}

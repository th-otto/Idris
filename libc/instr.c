#include <std.h>
#include <pcdecl.h>


BYTES instr(register const char *is, const char *p)
{
	register const char *pscan;
	register const char *iscan;
	
	iscan = is;
	while (*iscan != '\0')
	{
		pscan = p;
		while (*pscan != '\0')
		{
			if (*iscan == *pscan)
				return iscan - is;
			pscan++;
		}
		iscan++;
	}
	return iscan - is;
}

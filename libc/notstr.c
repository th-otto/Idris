#include <std.h>
#include <pcdecl.h>
#include <string.h>

size_t notstr(const char *is, const char *p)
{
	register const char *iscan = is;
	register const char *pscan;
	register int found;
	
	while (*iscan != '\0')
	{
		found = 0;
		pscan = p;
		for (;;)
		{
			if (*iscan == '\0')
				break;
			if (*iscan == *pscan)
			{
				found = 1;
				break;
			}
			pscan++;
		}
		if (!found)
			break;
		iscan++;
	}
	return iscan - is;
}

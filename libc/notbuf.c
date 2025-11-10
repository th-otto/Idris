#include <std.h>
#include <pcdecl.h>
#include <string.h>

/*
 * find occurrence in buffer of character not in set
 */
size_t notbuf(const char *is, register BYTES n, const char *p)
{
	register const char *iscan = is;
	register const char *pscan;
	register int found;
	
	while (n != 0)
	{
		found = 0;
		pscan = p;
		for (;;)
		{
			if (*iscan == *pscan)
			{
				found = 1;
				break;
			}
			pscan++;
			if (*pscan == '\0')
				break;
		}
		if (!found)
			break;
		n--;
		iscan++;
	}
	return iscan - is;
}

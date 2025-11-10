#include <std.h>
#include <pcdecl.h>
#include <string.h>

/*
 * find occurrence of substring in buffer
 */
size_t subbuf(const void *_ps, size_t ns, const void *_pp, size_t _np)
{
	register const char *pscan;
	register const char *ssscan;
	register const char *sscan;
	register const char *pstart;
	register const char *srcstart;
	register size_t np;

	pstart = _pp;
	srcstart = _ps;
	np = _np;
	if (np == 0)
		return 0;
	sscan = srcstart;
	for (;;)
	{
		if (sscan - srcstart + np > ns)
			return ns;
		if (*pstart == *sscan)
		{
			ssscan = sscan;
			pscan = pstart;
			while ((size_t)(pscan - pstart) < np)
			{
				if (*ssscan != *pscan)
					break;
				pscan++;
				ssscan++;
			}
			if ((size_t)(pscan - pstart) <= np)
				return sscan - srcstart;
		}
		sscan++;
	}
}

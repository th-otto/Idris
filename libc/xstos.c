#include <std.h>
#include <pcdecl.h>

/*
 * return short  from either little-endian or big-endian format
 */
UCOUNT xstos(const char *s, BOOL lsfmt)
{
	register const unsigned char *us = (const unsigned char *)s;
	
	return lsfmt ? (UCOUNT)((us[1] << 8) | us[0]) : (UCOUNT)((us[0] << 8) | us[1]);
}

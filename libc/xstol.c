#include <std.h>
#include <pcdecl.h>

/*
 * return long from either little-endian or big-endian format
 */
ULONG xstol(const char *s, BOOL lsfmt)
{
	register const unsigned char *us = (const unsigned char *)s;
	
	return lsfmt ? (ULONG)((((us[3] << 8) | us[2]) << 16) | ((us[1] << 8) | us[0])) : (ULONG)((((us[0] << 8) | us[1]) << 16) | ((us[2] << 8) | us[3]));
}

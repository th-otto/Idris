#include <std.h>
#include <pcdecl.h>

/*
 * return long from pdp-endian format
 */
LONG lstol(const char *s)
{
	register const unsigned char *us = (const unsigned char *)s;
	
	return (LONG)((((us[1] << 8) | us[0]) << 16) | ((us[3] << 8) | us[2]));
}

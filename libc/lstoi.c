#include <std.h>
#include <pcdecl.h>

/*
 * return short from pdp-endian format
 */
COUNT lstoi(const char *s)
{
	register const unsigned char *us = (const unsigned char *)s;
	
	return (COUNT)((us[1] << 8) | us[0]);
}

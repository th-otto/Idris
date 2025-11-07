#include <std.h>
#include <pcdecl.h>

UCOUNT lstou(const UCOUNT *s)
{
	register const unsigned char *us = (const unsigned char *)s;
	
	return (UCOUNT)((us[1] << 8) | us[0]);
}

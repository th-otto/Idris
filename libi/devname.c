#include <std.h>
#include <pcdecl.h>

/*
 * get device name
 */
#undef devname
BOOL devname(char *s, UCOUNT mdev, BOOL cspec)
{
	return _devname(s, mdev, cspec);
}


#include <std.h>
#include <pcdecl.h>

/*
 * convert long to text in buffer
 */
#undef ltob
BYTES ltob(char *is, LONG ln, int base)
{
	return _ltob(is, ln, base);
}

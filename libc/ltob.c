#include <std.h>
#include <pcdecl.h>

#undef ltob
BYTES ltob(char *is, LONG ln, int base)
{
	return _ltob(is, ln, base);
}

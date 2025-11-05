#include <std.h>
#include <pcdecl.h>

#undef stob
BYTES stob(char *is, COUNT ln, int base)
{
	return _stob(is, ln, base);
}

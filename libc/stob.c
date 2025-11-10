#include <std.h>
#include <pcdecl.h>

/*
 * convert short to text in buffer
 */
#undef stob
BYTES stob(char *is, COUNT ln, int base)
{
	return _stob(is, ln, base);
}

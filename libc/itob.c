#include <std.h>
#include <pcdecl.h>

/*
 * convert integer to text in buffer
 */
#undef itob
BYTES itob(char *is, int ln, int base)
{
	return _itob(is, ln, base);
}

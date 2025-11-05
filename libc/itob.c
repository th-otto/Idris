#include <std.h>
#include <pcdecl.h>

#undef itob
BYTES itob(char *is, int ln, int base)
{
	return _itob(is, ln, base);
}

#include <limits.h>
#include <ctype.h>

#undef tolower
#undef toupper
#undef isupper
int tolower(int c)
{
	return isupper(c) ? _tolower(c) : c;
}

#include <limits.h>
#include <ctype.h>

/*
 * convert character to lowercase if necessary
 */
#undef tolower
#undef toupper
#undef isupper
int tolower(int c)
{
	return isupper(c) ? _tolower(c) : c;
}

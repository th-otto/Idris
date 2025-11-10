#include <limits.h>
#include <ctype.h>

/*
 * convert character to uppercase if necessary
 */
#undef tolower
#undef toupper
#undef islower
int tolower(int c)
{
	return islower(c) ? _toupper(c) : c;
}

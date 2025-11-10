#include <limits.h>
#include <ctype.h>

/*
 * convert character to uppercase if necessary
 */
int (_toupper)(int c)
{
	return islower(c) ? _toupper(c) : c;
}

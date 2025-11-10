#include <limits.h>
#include <ctype.h>

/*
 * convert character to lowercase if necessary
 */
int (_tolower)(int c)
{
	return isupper(c) ? _tolower(c) : c;
}

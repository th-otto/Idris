#include <ctype.h>

/*
 * test for upperspace character
 */
#undef isupper
int isupper(int c)
{
	return c < 0 ? 0 : ((_ctype+1)[(unsigned char)(c)] & ((_UC)));
}

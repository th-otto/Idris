#include <ctype.h>

/*
 * test for alphabetic character
 */
#undef isalpha
int isalpha(int c)
{
	return c < 0 ? 0 : ((_ctype+1)[(unsigned char)(c)] & ((_UC|_LC)));
}

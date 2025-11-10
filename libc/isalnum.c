#include <ctype.h>

/*
 * test for alphabetic or numeric character
 */
#undef isalnum
int isalnum(int c)
{
	return c < 0 ? 0 : ((_ctype+1)[(unsigned char)(c)] & ((_D|_UC|_LC)));
}

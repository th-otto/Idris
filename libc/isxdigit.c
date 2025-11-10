#include <ctype.h>

/*
 * test for hexadecimal digit
 */
#undef isxdigit
int isxdigit(int c)
{
	return c < 0 ? 0 : ((_ctype+1)[(unsigned char)(c)] & ((_D|_X)));
}

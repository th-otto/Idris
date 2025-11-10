#include <ctype.h>

/*
 * checks for any printable character which is not a space or an alphanumeric character
 */
#undef ispunct
int ispunct(int c)
{
	return c < 0 ? 0 : ((_ctype+1)[(unsigned char)(c)] & ((_P)));
}

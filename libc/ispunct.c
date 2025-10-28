#include <ctype.h>

#undef ispunct
int ispunct(int c)
{
	return c < 0 ? 0 : ((_ctype+1)[(unsigned char)(c)] & ((_P)));
}

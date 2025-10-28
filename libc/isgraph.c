#include <ctype.h>

#undef isgraph
int isgraph(int c)
{
	return c < 0 ? 0 : ((_ctype+1)[(unsigned char)(c)] & ((_P|_D|_UC|_LC)));
}

#include <ctype.h>

#undef islower
int islower(int c)
{
	return c < 0 ? 0 : ((_ctype+1)[(unsigned char)(c)] & ((_LC)));
}

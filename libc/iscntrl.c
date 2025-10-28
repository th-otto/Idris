#include <ctype.h>

#undef iscntrl
int iscntrl(int c)
{
	return c < 0 ? 0 : ((_ctype+1)[(unsigned char)(c)] & ((_C)));
}

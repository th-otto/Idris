#include <ctype.h>

#undef isprint
int isprint(int c)
{
	return c < 0 ? 0 : ((_ctype+1)[(unsigned char)(c)] & ((_SP|_P|_D|_UC|_LC)));
}

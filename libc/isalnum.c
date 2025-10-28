#include <ctype.h>

#undef isalnum
int isalnum(int c)
{
	return c < 0 ? 0 : ((_ctype+1)[(unsigned char)(c)] & ((_D|_UC|_LC)));
}

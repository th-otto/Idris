#include <ctype.h>

#undef isdigit
int isdigit(int c)
{
	return c < 0 ? 0 : ((_ctype+1)[(unsigned char)(c)] & ((_D)));
}

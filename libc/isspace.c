#include <ctype.h>

#undef isspace
int isspace(int c)
{
	return c < 0 ? 0 : ((_ctype+1)[(unsigned char)(c)] & (_S|_SP));
}

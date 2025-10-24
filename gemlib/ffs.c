#include <string.h>

int ffs(register long val)
{
	register int n;
	
	if (val == 0)
		return 0;
	n = 1;
	while (!(val & 1))
	{
		n++;
		val >>= 1;
	}
	return n;
}

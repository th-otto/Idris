#include <limits.h>
#include <ctype.h>

int (_tolower)(int c)
{
	return isupper(c) ? _tolower(c) : c;
}

#include <limits.h>
#include <ctype.h>

int (_toupper)(int c)
{
	return islower(c) ? _toupper(c) : c;
}

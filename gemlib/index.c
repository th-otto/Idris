#include <string.h>

char *index(const char *str, char c)
{
	return strchr(str, c);
}

char *rindex(const char *str, char c)
{
	return strrchr(str, c);
}

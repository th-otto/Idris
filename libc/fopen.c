#include <stdio.h>


FILE *fopen(const char *pathname, const char *mode)
{
	return freopen(pathname, mode, NULL);
}

#include <stdio.h>


/*
 * open a file and initialize a control buffer
 */
FILE *fopen(const char *pathname, const char *mode)
{
	return freopen(pathname, mode, NULL);
}

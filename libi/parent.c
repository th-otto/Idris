#include <stdlib.h>
#include <dirent.h>
#include <string.h>

/*
 * get parent name of file
 */
#undef parent
char *parent(char *buf, const char *pathname)
{
	return _parent(buf, pathname);
}

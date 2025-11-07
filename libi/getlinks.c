#include <dirent.h>
#include "libi.h"

/*
 * read and sort directory
 */
#undef getlinks
struct dirent *getlinks(const char *pathname, unsigned int *pnentries, long size)
{
	return _getlinks(pathname, pnentries, size);
}


/*	GET MODE OF A FILE
 *	copyright (c) 1981 by Whitesmiths, Ltd.
 */
#include <std.h>
#include <sys/stat.h>
#include "libc.h"

/*
 * get mode of file
 */
BITS _getmod(const char *fname)
{
	struct stat buf;

	return stat(fname, &buf) < 0 ? 0 : buf.st_mode;
}


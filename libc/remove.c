/*	REMOVE A FILE
 *	copyright (c) 1978, 1985 by Whitesmiths, Ltd.
 */
#include <std.h>
#include <sys/stat.h>
#include <stdio.h>
#include <errno.h>
#include <unistd.h>
#include "libc.h"

#undef remove
int remove(const char *f)
{
	FAST mode_t fm;

	if (!(fm = _getmod(f)))
		return (errno = ENOENT, -1);
	else if (S_ISDIR(fm))
		return (errno = EISDIR, -1);
	else
		return unlink(f);
}

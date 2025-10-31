/*	RENAME FILE from TO FILE to
 *	copyright (c) 1978, 1985 by Whitesmiths, Ltd.
 */
#include <std.h>
#include <sys/stat.h>
#include <stdio.h>
#include <errno.h>
#include <unistd.h>
#include "libc.h"
#undef rename

int rename(const char *from, const char *to)
{
	struct stat st;

	if (stat(from, &st) < 0)
		;
	else if (S_ISDIR(st.st_mode))
		errno = EISDIR;
	else if (0 <= stat(to, &st))
		errno = EEXIST;
	else if (link(from, to) < 0)
		;
	else if (unlink(from) < 0)
		unlink(to);
	else
		return (0);
	return (-1);
}

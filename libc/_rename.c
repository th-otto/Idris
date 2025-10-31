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

int _rename(const char *from, const char *to)
{
	return rename(from, to);
}

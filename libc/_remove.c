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

int _remove(const char *f)
{
	return remove(f);
}

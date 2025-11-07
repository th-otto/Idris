#include <std.h>
#include <pcdecl.h>
#include <unistd.h>
#include "libi.h"

/*
 * turn on or off messages to current terminal
 */
BOOL mesg(BOOL new)
{
	struct stat st;
	char buf[NAME_MAX + 6];
	BOOL ret;
	
	if (fstat(STDOUT, &st) < 0)
	{
		_putstr(STDERR, "no terminal\n", NULL);
		return FALSE;
	}
	if (S_ISCHR(st.st_mode))
		return TRUE;
	ret = (st.st_mode & (S_IWOTH | S_IWGRP)) != 0;
	_cpybuf(buf, "/dev/", 5);
	buf[5] = '\0';
	if (_devname(&buf[5], st.st_rdev, TRUE))
	{
		chmod(buf, new ? (S_IRUSR | S_IWUSR | S_IWOTH | S_IWGRP) : (S_IRUSR | S_IWUSR));
	}
	return ret;
}

#include <std.h>
#include <pcdecl.h>
#include <termio.h>
#include <unistd.h>
#include "libi.h"

/*
 * get user response to question
 */
BOOL asure(const char *str)
{
	char buf[32];
	
	/* FIXME: should use /dev/tty, not STDIN */
	if (ioctl(STDIN, TCFLSH, NULL) < 0)
		return TRUE;
	write(STDERR, str, _lenstr(str));
	write(STDERR, " ", 1);
	return read(STDIN, buf, sizeof(buf)) > 0 && (buf[0] == 'y' || buf[0] == 'Y');
}

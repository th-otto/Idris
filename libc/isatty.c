#include <std.h>
#include <unistd.h>
#include <termio.h>

/*
 * test whether a file descriptor refers to a terminal
 */
int isatty(int fd)
{
	struct sgtty t;
	
	if (gtty(fd, &t) >= 0)
		return 1;
	return 0;
}

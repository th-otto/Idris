#include <std.h>
#include <unistd.h>
#include <termio.h>

int isatty(int fd)
{
	struct sgtty t;
	
	if (gtty(fd, &t) >= 0)
		return 1;
	return 0;
}

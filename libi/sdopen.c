#include <std.h>
#include <unistd.h>
#include <fcntl.h>
#include <msg.h>

int sdopen(const char *filename)
{
	int fd;
	
	if ((fd = open(filename, O_RDWR, 1)) < 0)
		return fd;
	if (sdsize(fd) == 0)
	{
		close(fd);
		return -1;
	}
	return sdmap(fd);
}

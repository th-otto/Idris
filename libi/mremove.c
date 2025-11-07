#include <std.h>
#include <unistd.h>
#include <fcntl.h>
#include <msg.h>

int mremove(const char *filename)
{
	int fd;
	int ret;
	
	if ((fd = open(filename, O_RDWR, 1)) < 0)
		return -1;
	ret = _mrm(fd);
	close(fd);
	return ret;
}

#include <std.h>
#include <unistd.h>
#include <fcntl.h>
#include <msg.h>

int mcreate(const char *filename, int arg1, int arg2, int arg3)
{
	int fd;
	
	return (fd = open(filename, O_RDWR, 1)) < 0 ? fd : _mcreat(fd, arg1, arg2, arg3);
}

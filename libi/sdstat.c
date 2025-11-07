#include <std.h>
#include <unistd.h>
#include <termio.h>
#include <fcntl.h>
#include <msg.h>

int sdstat(int fd, SDSTAT *stat)
{
	return ioctl(fd, TCGETS, stat) < 0 ? -1 : fd;
}

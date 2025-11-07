#include <std.h>
#include <unistd.h>
#include <termio.h>
#include <fcntl.h>
#include <msg.h>

size_t sdstart(int fd)
{
	SDSTAT stat;

	return sdstat(fd, &stat) < 0 ? (size_t)-1 : stat.sd_start;
}

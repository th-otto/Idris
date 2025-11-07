#include <std.h>
#include <unistd.h>
#include <fcntl.h>
#include <msg.h>

size_t sdsize(int fd)
{
	SDSTAT stat;

	return sdstat(fd, &stat) < 0 ? 0 : stat.sd_size;
}

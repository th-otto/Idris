#include <std.h>
#include <unistd.h>
#include <fcntl.h>
#include <msg.h>

int mopen(const char *filename)
{
	int fd;
	
	if ((fd = open(filename, O_RDWR, 1)) < 0)
		return -1;
	if (!(mgetprm(fd, MP_MGETPRM) & MST_RDY))
	{
		close(fd);
		errno = MENOMSYS;
		return -1;
	}
	return fd;
}

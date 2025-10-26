#include <std.h>
#include <unistd.h>
#include <limits.h>
#include <fcntl.h>
#include <errno.h>


int dup2(register int oldfd, register int newfd)
{
	if (oldfd >= OPEN_MAX || newfd >= OPEN_MAX)
	{
		errno = EBADF;
		return -1;
	}
	if (newfd == oldfd)
		return newfd;
	close(newfd);
	return fcntl(oldfd, F_DUPFD, (void *)newfd);
}

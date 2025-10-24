#include <std.h>
#include <socket.h>
#include <unistd.h>

ARGINT readv(int fd, register const struct iovec *iov, register int iovcnt)
{
	while (iovcnt && iov->iov_len == 0)
	{
		--iovcnt;
		iov++;
	}
	if (iovcnt != 0)
		return read(fd, iov->iov_base, iov->iov_len);
	return 0;
}


ARGINT writev(int fd, register const struct iovec *iov, register int iovcnt)
{
	while (iovcnt && iov->iov_len == 0)
	{
		--iovcnt;
		iov++;
	}
	if (iovcnt != 0)
	{
		return write(fd, iov->iov_base, iov->iov_len < 4000 ? iov->iov_len : 4000);
	}
	return 0;
}

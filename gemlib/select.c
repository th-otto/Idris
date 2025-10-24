#include <std.h>
#include <fcntl.h>
#include <socket.h>
#include "sys/select.h"
#include <unistd.h>
#include <stdlib.h>

static char select_name[] = "/dev/select/selxx";
static int select_fd = -1;

int select(int nfds, register fd_set *readfds,
	register fd_set *writefds, register fd_set *exceptfds,
	struct timeval *timeout)
{
	register int i;
	struct sel_buf arg;
	
	if (select_fd < 0)
	{
		for (i = 0; i < 32; i++)
		{
			select_name[15] = i / 10 + '0';
			select_name[16] = i % 10 + '0';
			if ((select_fd = open(select_name, O_RDONLY)) >= 0)
				break;
		}
		if (select_fd < 0)
		{
			write(STDERR, "\r\n\007<<<unable to open select device>>>\r\n", 39);
			exit(1);
		}
	}
	arg.max = nfds;
	if (readfds != NULL)
		arg.rd_msk = readfds->fds_bits[0];
	else
		arg.rd_msk = 0;
	if (writefds != NULL)
		arg.wr_msk = writefds->fds_bits[0];
	else
		arg.wr_msk = 0;
	if (exceptfds != NULL)
		arg.ex_msk = exceptfds->fds_bits[0];
	else
		arg.ex_msk = 0;
	if (timeout != NULL)
		arg.timer = timeout->tv_sec + (timeout->tv_usec != 0 ? 1 : 0);
	else
		arg.timer = -1;
	if (ioctl(select_fd, SEL_IOCTL, &arg) < 0)
		return -1;
	if (readfds != NULL)
		readfds->fds_bits[0] = arg.rd_msk;
	if (writefds != NULL)
		writefds->fds_bits[0] = arg.wr_msk;
	if (exceptfds != NULL)
		exceptfds->fds_bits[0] = arg.ex_msk;
	return arg.max;
}

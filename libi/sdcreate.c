#include <std.h>
#include <unistd.h>
#include <fcntl.h>
#include <msg.h>
#include <errno.h>
#include <termio.h>

static void setsl(int flag);

int sdcreate(const char *filename, const char *control, size_t start, register size_t size)
{
	struct sgtty tty;
	struct {
		size_t o0;
		size_t o4;
		size_t size;
		char o12[12];
		size_t o24;
	} buf;
	register int fd2;
	register int fd;
	
	tty.t_speeds = (size + 511) >> 9;
	if (control)
	{
		if ((fd = open(control, O_RDONLY)) < 0)
			return fd;
		if (read(fd, &buf, sizeof(buf)) != sizeof(buf))
		{
			/* was bug in original code: handle leaked */
			close(fd);
			return -1;
		}
		if (size != (size_t)-1 && size < buf.size)
		{
			/* was bug in original code: handle leaked */
			close(fd);
			errno = EINVAL;
			return -1;
		}
		size = buf.size;
	} else
	{
		fd = -1; /* BUG: missing */
	}
	tty.t_speeds = (size + 511) >> 9;
	setsl(0);
	if ((fd2 = open(filename, O_RDWR)) < 0)
	{
		setsl(1);
		return fd2;
	}
	if (stty(fd2, &tty) < 0)
	{
		setsl(1);
		close(fd2);
		close(fd);
		return -1;
	}
	if (control == 0)
	{
		setsl(1);
		return fd2;
	}
	if (start == (size_t)-1)
	{
		start = buf.o24;
	}
	if (sdstart(fd2) != start || buf.o24 != start)
	{
		sdremove(filename);
		close(fd2);
		close(fd);
		setsl(1);
		errno = EINVAL;
		return -1;
	}
	if (lseek(fd, buf.o4 + sizeof(buf), SEEK_SET) == -1 ||
		read(fd, (void *)start, size) != (long)size)
	{
		sdremove(filename);
		close(fd2);
		close(fd);
		setsl(1);
		return -1;
	}
	setsl(1);
	close(fd);
	return fd2;
}


static void setsl(int flag)
{
	if (flag)
		clrsl(0, 1);
	else
		tsetsl(0, 1);
}

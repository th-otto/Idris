#include <termio.h>
#include <unistd.h>
#include "gembind.h"


int Save_Term(int fd)
{
	struct sgtty t;
	
	ioctl(fd, TCGTTY, &t);
	return t.t_mode;
}


void Restore_Term(int fd, int mode)
{
	struct sgtty t;
	
	ioctl(fd, TCGTTY, &t);
	t.t_mode = mode;
	ioctl(fd, TCSTTY, &t);
}


void Raw_On(int fd)
{
	struct sgtty t;
	
	ioctl(fd, TCGTTY, &t);
	t.t_mode |= M_RAW;
	ioctl(fd, TCSTTY, &t);
}


void Raw_Off(int fd)
{
	struct sgtty t;
	
	ioctl(fd, TCGTTY, &t);
	t.t_mode &= ~M_RAW;
	ioctl(fd, TCSTTY, &t);
}


void Echo_On(int fd)
{
	struct sgtty t;
	
	ioctl(fd, TCGTTY, &t);
	t.t_mode |= M_ECHO;
	ioctl(fd, TCSTTY, &t);
}


void Echo_Off(int fd)
{
	struct sgtty t;
	
	ioctl(fd, TCGTTY, &t);
	t.t_mode &= ~M_ECHO;
	ioctl(fd, TCSTTY, &t);
}


int Bconstat(int fd)
{
	struct sgtty t;
	
	ioctl(fd, TCGTTY, &t);
	return t.t_speeds & S_OREADY ? -1 : 0;
}


int Bconin(int fd)
{
	unsigned char c;
	
	read(fd, &c, 1);
	return c & 0xff;
}


void Bconout(int fd, int c)
{
	unsigned char b;
	
	b = c;
	write(fd, &b, 1);
}

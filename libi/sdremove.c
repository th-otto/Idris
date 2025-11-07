#include <std.h>
#include <unistd.h>
#include <fcntl.h>
#include <termio.h>
#include <msg.h>

int sdremove(const char *filename)
{
	int fd;
	struct sgtty t;
	
	t.t_speeds = 0;
	stty(fd = sdopen(filename), &t);
	return sdclose(fd);
}

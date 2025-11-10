#include <std.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>

/*
 * get username
 */
char *getlogin(void)
{
	int fd;
	
	if ((fd = open("/dev/tty", O_RDONLY)) < 0)
		return NULL;
	close(fd);
	return cuserid(NULL);
}

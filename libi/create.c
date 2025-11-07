#include <wslxa.h>
#include <unistd.h>
#include <fcntl.h>
#include "libi.h"

int create(const char *filename, int mode)
{
	const char *ptr;
	const char *uniq;
	int fd;
	
	uniq = uniqnm();
	ptr = filename;
	while (*uniq != '\0' && *ptr++ == *uniq)
		uniq++;
	if ((fd = creat(filename, *uniq != '\0' ? 0666 : 0600)) < 0 || mode == O_WRONLY)
		return fd;
	close(fd);
	return open(filename, mode);
}

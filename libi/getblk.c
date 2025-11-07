#include <unistd.h>
#include "libi.h"

/*
 * get filesystem block
 */
BOOL getblk(int fd, void *buf, BLOCK bno)
{
	lseek(fd, (off_t)bno << BLOCK_SIZE_SHIFT, SEEK_SET);
	return read(fd, buf, BLOCK_SIZE) == BLOCK_SIZE;
}

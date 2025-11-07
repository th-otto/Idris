#include <unistd.h>
#include "libi.h"

/*
 * put filesystem block
 */
BOOL putblk(int fd, const void *buf, BLOCK bno)
{
	lseek(fd, (off_t)bno << BLOCK_SIZE_SHIFT, SEEK_SET);
	return write(fd, buf, BLOCK_SIZE) == BLOCK_SIZE;
}

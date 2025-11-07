#include "libi.h"

static BYTES lastblock;
static unsigned char blkbuf[BLOCK_SIZE];


/*
 * read directory on unmounted filesystem
 */
struct idir *rdir(int fd, register FINODE *pi, register BYTES lno)
{
	if (lsize(pi) <= lno)
		return NULL;
	if (lno == 0 || (lno >> BLOCK_SIZE_SHIFT) != lastblock)
	{
		lastblock = lno >> BLOCK_SIZE_SHIFT;
		getblk(fd, blkbuf, mapblk(fd, pi, lastblock));
	}
	return (struct idir *)&blkbuf[lno & (BLOCK_SIZE - 1)];
}


/*
 * write directory to unmounted filesystem
 */
void wdir(int fd, FINODE *pi)
{
	putblk(fd, blkbuf, mapblk(fd, pi, lastblock));
}

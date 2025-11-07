#include <signal.h>
#include "libi.h"

static unsigned char blkbuf[BLOCK_SIZE];
static BLOCK lastbno;
static BOOL blkdirty;


static void readblk(int fd, BLOCK bno, INUM ino)
{
#ifdef __GNUC__
	(void)ino;
#endif
	if (getblk(fd, blkbuf, bno))
	{
		lastbno = bno;
	} else
	{
		lastbno = 0;
		_raise(NULL, &_reaerr);
	}
}


/*
 * flush out any pending inode writes
 */
void flushi(int fd)
{
	if (blkdirty)
	{
		if (!putblk(fd, blkbuf, lastbno))
		{
			_raise(NULL, &_wrierr);
		}
		blkdirty = FALSE;
	}
	lastbno = 0;
}


/*
 * get inode from filesystem
 */
FINODE *geti(int fd, FINODE *buf, INUM ino)
{
	BLOCK bno;

	bno = inblk(ino);
	if (lastbno != bno)
	{
		if (blkdirty)
			flushi(fd);
		readblk(fd, bno, ino);
	}
	return cpyi(buf, ioff(blkbuf, ino));
}


/*
 * put inode to filesystem
 */
void puti(int fd, FINODE *pi, INUM ino)
{
	BLOCK bno;

	bno = inblk(ino);
	if (lastbno != bno)
	{
		if (blkdirty)
			flushi(fd);
		readblk(fd, bno, ino);
	}
	cpyi(ioff(blkbuf, ino), pi);
	blkdirty = TRUE;
}

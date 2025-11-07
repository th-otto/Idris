#include "libi.h"

/*
 * get inode offset within block
 */
void *ioff(void *buf, INUM ino)
{
	return _ioff(buf, ino);
}

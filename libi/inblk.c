#include "libi.h"

/*
 * find home block of an inode
 */
BLOCK inblk(INUM ino)
{
	return ((unsigned int)ino - 1U) / INODES_PER_BLOCK + 2;
}

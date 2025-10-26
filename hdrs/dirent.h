/*	DIRECTORY STRUCTURE
 *	copyright (c) 1985 by Whitesmiths, Ltd.
 */

#ifndef __DIRENT__
#define __DIRENT__	1

#ifndef __LIMITS__
#include <limits.h>
#endif

/*	user directory entry structure
 */
struct dirent {
	unsigned short d_ino;
	char d_name[NAME_MAX + 1];
};

/*	Idris filesystem directory entry
 */
struct idir {
	unsigned short d_ino;
	char d_name[NAME_MAX];
};

/*	internal directory structure used by opendir(), et. al.
 */
typedef struct {
	int dir_fd;
	unsigned short dir_ino;
	char dir_name[NAME_MAX + 1];
} DIR;

DIR *opendir(const char *name);
struct dirent *readdir(DIR *dirp);
int closedir(DIR *dirp)
long telldir(DIR *dirp);
void seekdir(DIR *dirp, long loc);
void rewinddir(DIR *dirp);

#endif

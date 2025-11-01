/*	DIRECTORY STRUCTURE
 *	copyright (c) 1985 by Whitesmiths, Ltd.
 */

#ifndef __DIRENT__
#define __DIRENT__	1

#ifndef __LIMITS__
#include <limits.h>
#endif
#ifndef __TYPES__
#include <sys/types.h>
#endif

/*	user directory entry structure
 */
struct dirent {
	ino_t d_ino;
	char d_name[NAME_MAX + 1];
};

/*	Idris filesystem directory entry
 */
struct idir {
	ino_t d_ino;
	char d_name[NAME_MAX];
};

/*	internal directory structure used by opendir(), et. al.
 */
typedef struct {
	int dir_fd;
	/* must match struct dirent above */
	ino_t dir_ino;
	char dir_name[NAME_MAX + 1];
} DIR;

DIR *opendir(const char *name);
struct dirent *readdir(DIR *dirp);
int closedir(DIR *dirp);
long telldir(DIR *dirp);
void seekdir(DIR *dirp, long loc);
void rewinddir(DIR *dirp);

struct dirent *_getlinks(const char *pathname, unsigned int *nentries, long size);
char *_parent(char *buf, const char *pathname);

#endif

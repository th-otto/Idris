#include <stdlib.h>
#include <dirent.h>
#include <unistd.h>
#include <sys/stat.h>
#include <errno.h>
#include <fcntl.h>

static short const endian_word = 1;
static const char *endian_ptr = (char *)&endian_word;


/*
 * close a directory
 */
int closedir(DIR *dirp)
{
	if (close(dirp->dir_fd) < 0)
		return -1;
	free(dirp);
	return 0;
}


/*
 * open a directory
 */
DIR *opendir(const char *name)
{
	struct stat st;
	int fd;
	DIR *dir;
	
	if (stat(name, &st) < 0)
		return NULL;
	if (!S_ISDIR(st.st_mode))
	{
		errno = ENOTDIR;
		return NULL;
	}
	if ((fd = open(name, O_RDONLY)) < 0 ||
		(dir = malloc(sizeof(*dir))) == NULL)
	{
		/* BUG: leaks file handle if malloc fails */
		return NULL;
	}
	dir->dir_fd = fd;
	return dir;
}


/*
 * read a directory
 */
struct dirent *readdir(register DIR *dir)
{
	struct idir entry;
	register int i;
	register unsigned int ino;
	register char *ptr;
	register char *src;

	entry.d_ino = 0;
	while (entry.d_ino == 0)
	{
		if (read(dir->dir_fd, &entry, sizeof(entry)) != sizeof(entry))
			return NULL;
	}
	ino = entry.d_ino;
	/* FIXME: determine at compile-time */
	dir->dir_ino = *endian_ptr != 0 ? ino : ((ino >> 8) | (ino << 8));
	ptr = dir->dir_name;
	for (i = sizeof(dir->dir_name); --i >= 0; )
		*ptr++ = '\0';
	ptr = dir->dir_name;
	src = entry.d_name;
	while (src < &entry.d_name[sizeof(entry.d_name)] && *src != '\0')
		*ptr++ = *src++;
	return (struct dirent *)&dir->dir_ino;
}


/*
 * reset directory stream
 */
void rewinddir(DIR *dir)
{
	lseek(dir->dir_fd, 0, SEEK_SET);
}


/*
 * set the position of the next readdir() call in the directory stream
 */
void seekdir(DIR *dir, long loc)
{
	lseek(dir->dir_fd, loc, SEEK_SET);
}


/*
 * return current location in directory stream
 */
long telldir(DIR *dir)
{
	return lseek(dir->dir_fd, 0, SEEK_CUR);
}

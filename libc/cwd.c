#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <limits.h>
#include <errno.h>
#include <dirent.h>
#include <sys/stat.h>


static char *concat_name(char *tbuf, const char *str, int prepend)
{
	size_t len;
	char buf[PATH_MAX + 1];

	len = strlen(tbuf);
	len += strlen(str);
	if (len >= PATH_MAX)
		return NULL;
	if (prepend)
	{
		strcpy(buf, tbuf);
		strcpy(tbuf, str);
		strcat(tbuf, buf);
	} else
	{
		strcat(tbuf, str);
	}
	return tbuf;
}


static char *find_name(struct stat *st, char *dirname)
{
	register int fd;
	register int fd2;
	struct dirent dir;
	struct dirent dir2;
	struct stat dst;
	struct stat fst;
	struct stat pst;
	char parent_dir[PATH_MAX + 3];
	char fullname[PATH_MAX + 3];
	char entbuf[PATH_MAX + 3];
	char *pathend;
	static char namebuf[sizeof(dir.d_name) + 1];
	
	namebuf[0] = '/';
	if ((fd = open(dirname, O_RDONLY, S_IXOTH)) < 0)
		return NULL;
	strcpy(fullname, dirname);
	strcat(fullname, "/");
	pathend = &fullname[strlen(fullname)];
	while (read(fd, &dir, sizeof(dir) - 1) == sizeof(dir) - 1)
	{
		dir.d_name[sizeof(dir.d_name) - 1] = '\0';
		strcpy(pathend, dir.d_name);
		if (dir.d_ino == 0)
			continue;
		if (stat(fullname, &fst) < 0)
			break;
		if (fst.st_ino != st->st_ino)
			continue;
		if (st->st_ino != 1)
		{
			strcpy(dir.d_name, &namebuf[1]);
			if (fstat(fd, st) < 0)
				break;
			close(fd);
			return namebuf;
		}
		strcpy(parent_dir, "../");
		strcat(parent_dir, dirname);
		if (stat(parent_dir, &dst) < 0)
			break;
		if (strcmp(dir.d_name, ".") == 0 && st->st_dev == dst.st_dev)
		{
			close(fd);
			return namebuf;
		}
		if ((fd2 = open(parent_dir, O_RDONLY, S_IXOTH)) < 0)
			break;
		for (;;)
		{
			if (read(fd2, &dir2, sizeof(dir2) - 1) != sizeof(dir2) - 1)
			{
				/* was bug in original code: leaks fd if read fails */
				close(fd2);
				break;
			}
			strcpy(entbuf, parent_dir);
			strcat(entbuf, "/");
			dir2.d_name[sizeof(dir2.d_name) - 1] = '\0';
			strcat(entbuf, dir2.d_name);
			if (stat(entbuf, &pst) < 0)
			{
				close(fd2);
				close(fd);
				return NULL;
			}
			if (pst.st_ino == 1 && pst.st_dev == st->st_dev)
			{
				strcpy(&namebuf[1], dir2.d_name);
				close(fd2);
				close(fd);
				return namebuf;
			}
		}
	}
	close(fd);
	return NULL;
}


int _cwd(char *tbuf)
{
	register char *name;
	struct stat st;
	struct stat root;
	char pathbuf[PATH_MAX + 3];
	register dev_t last_dev;
	register ino_t last_ino;
	
	*tbuf = '\0';
	strcpy(pathbuf, "..");
	if (stat("/", &root) < 0 || stat(".", &st) < 0)
		return errno;
	last_dev = 0;
	last_ino = 0;
	do
	{
		if (st.st_ino == last_ino && st.st_dev == last_dev)
			break;
		last_dev = st.st_dev;
		last_ino = st.st_ino;
		name = find_name(&st, pathbuf);
		if (name == NULL)
			return ENOENT;
		if (concat_name(tbuf, name, 1) == NULL || concat_name(pathbuf, "/..", 0) == NULL)
		{
			return ERANGE;
		}
	} while (st.st_dev != root.st_dev || st.st_ino != root.st_ino);
	if (*tbuf == '\0')
		strcpy(tbuf, "/");
	return 0;
}

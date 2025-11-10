#include <std.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <errno.h>
#include <dirent.h>


/*
 * remove directory
 */
int rmdir(const char *pathname)
{
	unsigned int nentries;
	struct dirent *dir;
	short dotdot_entries;
	short dot_entries;
	short i;
	short file_entries;
	struct dirent *entry;
	struct stat st;
	char path[PATH_MAX + 36];

	if (stat(pathname, &st) < 0)
		return -1;
	if (!S_ISDIR(st.st_mode))
	{
		errno = ENOTDIR;
		return -1;
	}
	if (access(pathname, R_OK) < 0 || (dir = _getlinks(pathname, &nentries, st.st_size)) == NULL)
	{
		errno = EACCES;
		return -1;
	}
	entry = dir;
	for (dot_entries = dotdot_entries = file_entries = i = 0; (unsigned int)i < nentries; i++, entry++)
	{
		if (strncmp(entry->d_name, ".", NAME_MAX) == 0)
		{
			dot_entries++;
		} else if (strncmp(entry->d_name, "..", NAME_MAX) == 0)
		{
			dotdot_entries++;
		} else
		{
			file_entries++;
			break;
		}
	}
	free(dir);
	if (file_entries > 0 || dot_entries > 1 || dotdot_entries > 1)
	{
		errno = EEXIST; /* should be ENOTEMPTY */
		return -1;
	}
	if (access(_parent(path, pathname), W_OK) < 0)
		return -1;
	strcpy(path, pathname);
	strcat(path, "/.");
	if (dot_entries != 0)
	{
		if (unlink(path) < 0)
			return -1;
	}
	if (dotdot_entries != 0)
	{
		strcat(path, ".");
		if (unlink(path) < 0)
			return -1;
	}
	if (unlink(pathname) < 0)
		return -1;
	return 0;
}

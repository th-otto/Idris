#include <stdlib.h>
#include <dirent.h>
#include <string.h>


/*
 * get parent name of file
 */
char *_parent(register char *buf, register const char *pathname)
{
	register const char *pathend;
	register size_t len;
	size_t dirlen;
	short level;
	char lastc;
	char firstc;
	
	firstc = *pathname;
	level = 0;
	len = strlen(pathname);
	while (len != 0)
	{
		if (pathname[len - 1] == '/')
			len--;
		else if (len > 1 && memcmp(&pathname[len - 2], "/.", 2) == 0)
			len -= 2;
		else if (len > 2 && memcmp(&pathname[len - 3], "/..", 3) == 0)
			len -= 3, level++;
		else
			break;
	}
	dirlen = 0;
	while (len != 0 && pathname[len - 1] != '/')
	{
		dirlen++;
		len--;
	}
	pathend = &pathname[len];
	lastc = len != 0 ? pathname[--len] : 0;
	if (lastc == 0 && dirlen == 0)
	{
		strcpy(buf, firstc == '/' ? "/" : "..");
	} else if (lastc == 0)
	{
		if (dirlen == 2 && pathend[0] == '.' && pathend[1] == '.')
			level += 2;
		else if (dirlen == 1 && pathend[0] == '.')
			level += 1;
		strcpy(buf, ".");
	} else if (len == 0)
	{
		strcpy(buf, "/");
	} else
	{
		memcpy(buf, pathname, len);
		buf[len] = '\0';
	}
	if (strcmp(buf, "/..") == 0)
	{
		buf[1] = '\0';
	} else if (strcmp(buf, "/") != 0)
	{
		pathend = &buf[strlen(buf)];
		while (--level >= 0)
		{
			strcpy((char *)pathend, "/..");
			pathend += 3;
		}
	}
	pathend = buf;
	while (pathend[0] == '.' && pathend[1] == '/')
		pathend += 2;
	if (pathend != buf)
		strcpy(buf, pathend); /* FIXME: overlapping copy */
	return buf;
}

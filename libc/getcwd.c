#include <std.h>
#include <unistd.h>
#include <limits.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>


char *getcwd(char *buf, size_t size)
{
	char *s;
	static char cwdbuf[PATH_MAX];
	int err;
	
	if (size == 0)
	{
		errno = EINVAL;
		return NULL;
	}
	if (buf == NULL)
		buf = malloc(size);
	s = size < PATH_MAX ? cwdbuf : buf;
	err = -_cwd(s);
	if (size == 0)
	{
		err = EINVAL;
	} else if (err == 0 && s != buf)
	{
		if (strlen(s) > size)
		{
			errno = ERANGE;
		} else
		{
			strcpy(buf, s);
			s = buf;
		}
	}
	if (err != 0)
	{
		errno = err;
		return NULL;
	}
	return s;
}

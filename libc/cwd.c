#include <unistd.h>
#include <limits.h>

/*
 * get current working directory
 */
int _cwd(char *tbuf)
{
	if (getcwd(tbuf, PATH_MAX) == NULL)
		return -1;
	return 0;
}

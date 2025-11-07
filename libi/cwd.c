#include <std.h>
#include <pcdecl.h>
#include <unistd.h>
#include <limits.h>


/*
 * get current working directory
 */
int cwd(char *buff)
{
	return getcwd(buff, PATH_MAX) == NULL ? -1 : 0;
}

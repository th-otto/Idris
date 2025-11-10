#include <stdlib.h>

int _system(const char *string);

/*
 * execute a shell command
 */
int _system(const char *string)
{
	return system(string);
}

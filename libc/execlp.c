#include <std.h>
#include <unistd.h>
#include <sys/xeq.h>
#include "libc.h"

int execlp(const char *pathname, const char *arg, ...)
{
	return execvp(pathname, &arg);
}

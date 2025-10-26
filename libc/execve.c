#include <std.h>
#include <unistd.h>
#include <sys/xeq.h>
#include "libc.h"

int execve(const char *pathname, const char **args, const char **env)
{
	return _xeq(pathname, args, env, X_SYN | X_OVLAY);
}

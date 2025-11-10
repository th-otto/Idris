/*	EXEC PATH WITH ARG VECTOR AND DEFAULT ENVIRONMENT
 */
#include <std.h>
#include <sys/xeq.h>
#include <unistd.h>
#include "libc.h"

/*
 * execv - execute a file with argument vector
 */
int execv(const char *path, const char **args)
{
	return _xeq(path, args, environ, X_SYN | X_OVLAY, 0, 0, 0, 0, 0, 0, 0);
}


#include <std.h>
#include <unistd.h>
#include <sys/xeq.h>
#include "libc.h"

int execle(const char *pathname, const char *arg, ...)
{
	const char **env = &arg;
	
	while (*env++ != NULL)
		;
	return _xeq(pathname, &arg, env, X_SYN | X_OVLAY);
}

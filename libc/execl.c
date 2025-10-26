#include <std.h>
#include <unistd.h>
#include <sys/xeq.h>
#include "libc.h"

int execl(const char *pathname, const char *arg, ...)
{
	return _xeq(pathname, &arg, environ, X_SYN | X_OVLAY);
}

#include <std.h>
#include <signal.h>
#include <stdlib.h>

/*
 * cause abnormal process termination
 */
void abort(void)
{
	raise(SIGABRT);
	exit(1);
}

#include <signal.h>
#include <unistd.h>

/*
 * raise an exception
 */
int raise(int sig)
{
	return kill(getpid(), sig);
}

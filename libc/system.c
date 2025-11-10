/*	CALL SHELL TO PROCESS LINE
 *	copyright (c) 1982, 1985 by Whitesmiths, Ltd.
 */
#include <std.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/xeq.h>
#include <xecv.h>
#include "libc.h"

char *_shell = "/bin/sh";

/*
 * execute a shell command
 */
int system(const char *p)
{
	register int pid;
	register int n;
	register char *shell;
	void (*plastfn[3])(int sig);
	int status;
	static const char *avlst[4] = { "sh", "-c", NULL, NULL};

	if (!p)
		return 1;
	plastfn[0] = signal(SIGHUP, SIG_IGN);
	plastfn[1] = signal(SIGINT, SIG_IGN);
	plastfn[2] = signal(SIGPIPE, SIG_IGN);
	if (_cmpbuf(p, "cd ", 3))
		return chdir(&p[3]) < 0 ? -1 : 0;
	if ((shell = getenv("SHELL")) != NULL)
		_shell = shell;
	avlst[2] = (char *)p;
	pid = _xeq(_shell, avlst, environ, X_ASYN|X_SYSIG|X_EUID, STDIN, STDOUT, STDERR, 0, 0, 0, 0);
	if (pid != -1)
	{
		while ((n = wait(&status)) > 0 && n != pid)
			;
	}
	signal(SIGHUP, plastfn[0]);
	signal(SIGINT, plastfn[1]);
	signal(SIGPIPE, plastfn[2]);
	return pid < 0 ? -1 : status;
}

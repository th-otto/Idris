/*	EXECUTE A FILE WITH ARG VECTOR
 *	copyright (c) 1981 by Whitesmiths, Ltd.
 */
#include <std.h>
#include <errno.h>
#include <limits.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/xeq.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <pcdecl.h>
#include <xecv.h>
#include "../libc/libc.h"

static const char *_signam[] = {
	"unknown signal",
	"hangup",
	"interrupt",
	"quit",
	"illegal instruction",
	"trace",
	"range error",
	"domain error",
	"floating point error",
	"kill",
	"illegal memory access",
	"protected memory access",
	"system call error",
	"broken pipe",
	"alarm",
	"terminate",
	"diverted system call",
	"user defined signal",
	0
};

/*	execute command with arg vector
 */
COUNT _xecv(const char *cmd, FD sin, FD sout, COUNT flags, const char **pargs)
{
	BOOL syn;
	int status;
	const char *fname;
	const char *pp;
	char buf[PATH_MAX];
	FAST const char *s;
	FAST COUNT i;
	FAST COUNT pid = 0;
	int done;

	if ((s = getenv("SHELL")) != NULL)
		_shell = (char *)s;
	fname = *pargs;
	if ((flags & X_MODE) == X_SYN)
	{
		syn = YES;
		flags = (flags & ~X_MODE) | X_ASYN;
	}
	else
		syn = NO;
	if (sin != STDIN)
	{
		fcntl(sin, F_SETFD, STDOUT);
		flags |= X_NEWIO;
	}
	if (sout != STDOUT)
	{
		fcntl(sout, F_SETFD, STDOUT);
		flags |= X_NEWIO;
	}
	for (i = 2; fcntl(++i, F_GETFD, NULL) >= 0; )
		fcntl(i, F_SETFD, 1);
	for (pp = (cmd[_scnstr(cmd, '/')]) ? "|" : _paths, done = 0; done == 0; )
	{
		for (s = pp, i = 0; *s && *s != '|' && *s != ':'; ++s)
			if (i < (COUNT)sizeof (buf))
				buf[i++] = *s;
		pp = (*s && (*(s + 1) || pp == s)) ? s + 1 : s;
		for (s = cmd; i < (COUNT)sizeof (buf) && (buf[i] = *s++); ++i)
			;
		if ((COUNT)sizeof (buf) <= i)
		{
			buf[_scnstr(buf, ((_scnstr(buf, '|')) ? '|' : ':'))] = '\0';
			_error("exec name too long: ", buf);
		}
		/* BUG: pid (unsigned) always >= 0 */
		if (0 <= (pid = _xeq(buf, pargs, environ, flags, sin, sout, STDERR, 0, 0, 0, 0)))
		{
			break;
		} else
		{
			switch (errno)
			{
			case E2BIG:
				s = "arg list too long";
				break;
			case ENOMEM:
				s = "program too big for available memory";
				break;
			case EAGAIN:
				s = "insufficient memory";
				break;
			case ENOEXEC:
				--pargs;
				pargs[0] = pargs[1];
				pargs[1] = buf;
				if ((pid = _xeq(_shell, pargs, environ, flags, sin, sout, STDERR, 0, 0, 0, 0)) < 0 &&
					!_cmpstr(_shell, "/bin/sh") &&
					(pid = _xeq("/bin/sh", pargs, environ, flags, sin, sout, STDERR, 0, 0, 0, 0)) < 0)
				{
					s = "no shell!";
				} else
				{
					pp = NULL;
					done = 1;
				}
				break;
			default:
				s = *pp ? NULL : "not found.";
				break;
			}
		}
		if (s)
		{
			_putstr(STDERR, fname, ": ", s, "\n", NULL);
			if ((flags & X_MODE) == X_OVLAY)
				exit(1);
		}
	}
	
	if (sin != STDIN)
		close(sin);
	if (sout != STDOUT)
		close(sout);

	/* BUG: pid never set if program not found */
	if (pid == -1)
		return 0;
	if (!syn)
		return pid;
	while ((i = wait(&status)) != pid)
		if (i < 0)	/* no exit status returned */
			return (YES);
	if (WIFSIGNALED(status))
	{
		i = WTERMSIG(status);
		s = (0 <= i && i < NSIG) ? _signam[i] : _signam[0];
		if (s)
			_putstr(STDERR, *pargs, ": ", s, WCOREDUMP(status) ?
				" - core dumped\n" : "\n", NULL);
	}
	return (status == 0);
}

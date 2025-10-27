/*	EXECUTE A FILE WITH ARG VECTOR
 *	copyright (c) 1981 by Whitesmiths, Ltd.
 */
#include <std.h>
#include <errno.h>
#include <limits.h>
#include <signal.h>
#include <stdlib.h>
#include <sys/xeq.h>
#include <sys/wait.h>
#include <pcdecl.h>
#include "libc.h"

BYTES _setb = 0;

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
	if (sin != STDIN || sout != STDOUT)
		flags |= X_NEWIO;
	if (_setb)
		flags |= X_SETB;
	for (pp = (cmd[scnstr(cmd, '/')]) ? "|" : _paths; *pp; )
	{
		for (s = pp, i = 0; *s && *s != '|' && *s != ':'; ++s)
			if (i < (COUNT)sizeof (buf))
				buf[i++] = *s;
		pp = (*s && (*(s + 1) || pp == s)) ? s + 1 : s;
		for (s = cmd; i < (COUNT)sizeof (buf) && (buf[i] = *s++); ++i)
			;
		if ((COUNT)sizeof (buf) <= i)
		{
			buf[scnstr(buf, ((scnstr(buf, '|')) ? '|' : ':'))] = '\0';
			_error("exec name too long: ", buf);
		}
		/* BUG: pid (unsigned) always >= 0 */
		if (0 <= (pid = _xeq(buf, pargs, environ, flags, sin, sout, STDERR, _setb, 0, 0, 0)))
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
				if ((pid = _xeq(_shell, pargs, environ, flags, sin, sout, STDERR, _setb, 0, 0, 0)) < 0)
					s = "no shell!";
				else
					pp = "";
				break;
			default:
				s = (*pp) ? NULL : "not found.";
			}
		}
		if (s)
		{
			_pname = fname;
			_error(s, NULL);
		}
	}
	/* BUG: pid never set if program not found */
	if (!syn)
		return (pid);
	else
	{
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
}

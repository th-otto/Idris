/*	CAPTURE NON-FATAL INTERRUPTS
 *	copyright (c) 1981, 1985 by Whitesmiths, Ltd.
 */
#include <std.h>
#include <idris.h>
#include <signal.h>
#include <pcdecl.h>
#include "libc.h"

static void (*func)(int);

static void _dointr(int sig)
{
	UNUSED(sig);
	(*func)(0);
}


VOID onintr(void (*pfn)(int))
{
	register void (*ih)(int);

	if (!pfn)
		ih = SIG_IGN;
	else
	{
		ih = &_dointr;
		func = pfn;
	}
	if (_signal(SIGHUP, SIG_IGN) != SIG_IGN)
		_signal(SIGHUP, ih);
	if (_signal(SIGINT, SIG_IGN) != SIG_IGN)
		_signal(SIGINT, ih);
	if (_signal(SIGPIPE, SIG_IGN) != SIG_IGN)
		_signal(SIGPIPE, ih);
}

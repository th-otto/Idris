/*	CAPTURE NON-FATAL INTERRUPTS
 *	copyright (c) 1981, 1985 by Whitesmiths, Ltd.
 */
#include <std.h>
#include <idris.h>
#include <signal.h>
#include <pcdecl.h>
#include "libc.h"

/*
 * onintr - capture interrupts
 */
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
	if (signal(SIGHUP, SIG_IGN) != SIG_IGN)
		signal(SIGHUP, ih);
	if (signal(SIGINT, SIG_IGN) != SIG_IGN)
		signal(SIGINT, ih);
	if (signal(SIGPIPE, SIG_IGN) != SIG_IGN)
		signal(SIGPIPE, ih);
}

#include "kern.h"

static char const nmptm[] = "ptyp0 ptyp1 ptyp2 ptyp3 ptyp4 ptyp5 ptyp6 ptyp7 ptyp8 ptyp9 ptypa ptypb ptypc ptypd ptype ptypf";


static void ptmclose(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
}


static BOOL ptmopen(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static COUNT ptmread(DEV dev, short rw)
{
	register struct user *u = pu;

	(void)rw;
	switch (dminor(dev))
	{
	default:
		u->u_error = ENXIO;
		break;
	}
	return 0;
}


static COUNT ptmwrite(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static void ptmsgtty(DEV dev, void *arg)
{
	(void)dev;
	(void)arg;
}


CDEVSW const ptmcdev = {
	ptmopen,
	ptmclose,
	ptmread,
	ptmwrite,
	ptmsgtty,
	nmptm
};

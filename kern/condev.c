#include "kern.h"

static char const nmcon[] = "console midi mouse ikbd clock";


static void conclose(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
}


static BOOL conopen(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static COUNT conread(DEV dev, short rw)
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


static COUNT conwrite(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static void consgtty(DEV dev, void *arg)
{
	(void)dev;
	(void)arg;
}


CDEVSW const concdev = {
	conopen,
	conclose,
	conread,
	conwrite,
	consgtty,
	nmcon
};

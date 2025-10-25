#include "kern.h"

static char const nmser[] = "rs232";


static void serclose(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
}


static BOOL seropen(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static COUNT serread(DEV dev, short rw)
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


static COUNT serwrite(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static void sersgtty(DEV dev, void *arg)
{
	(void)dev;
	(void)arg;
}


CDEVSW const sercdev = {
	seropen,
	serclose,
	serread,
	serwrite,
	sersgtty,
	nmser
};

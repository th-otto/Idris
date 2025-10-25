#include "kern.h"

static char const nmlp[] = "parallel";


static void lpclose(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
}


static BOOL lpopen(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static COUNT lpread(DEV dev, short rw)
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


static COUNT lpwrite(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static void lpsgtty(DEV dev, void *arg)
{
	(void)dev;
	(void)arg;
}


CDEVSW const lpcdev = {
	lpopen,
	lpclose,
	lpread,
	lpwrite,
	lpsgtty,
	nmlp
};

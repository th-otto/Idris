#include "kern.h"

static char const nmpts[] = "ttyp0 ttyp1 ttyp2 ttyp3 ttyp4 ttyp5 ttyp6 ttyp7 ttyp8 ttyp9 ttypa ttypb ttypc ttypd ttype ttypf";


static void ptsclose(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
}


static BOOL ptsopen(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static COUNT ptsread(DEV dev, short rw)
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


static COUNT ptswrite(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static void ptssgtty(DEV dev, void *arg)
{
	(void)dev;
	(void)arg;
}


CDEVSW const ptscdev = {
	ptsopen,
	ptsclose,
	ptsread,
	ptswrite,
	ptssgtty,
	nmpts
};

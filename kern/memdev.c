#include "kern.h"

static char const nmmem[] = "NODEV kmem null ps myps mount inode where bnames cnames zero tty";


static void memclose(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
}


static BOOL memopen(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static COUNT memread(DEV dev, short rw)
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


static COUNT memwrite(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static void memsgtty(DEV dev, void *arg)
{
	(void)dev;
	(void)arg;
}


CDEVSW const memcdev = {
	memopen,
	memclose,
	memread,
	memwrite,
	memsgtty,
	nmmem
};

#include "kern.h"

static struct devtab mdtab = { NULL, NULL, NULL, NULL, 0, 0 };
static char const nmmd[] = "md sd0 sd1 sd2 sd3 sd4 iopage";
static char const nmrmd[] = "rmd rsd0 rsd1 rsd2 rsd3 rsd4 riopage";
struct buf rmdbuf = { NULL, NULL, NULL, NULL, 0, NODEV, 0, 0, 0, NULL, 0, 0, 0 };

static BOOL mdopen(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static void mdclose(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
}


static COUNT mdread(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static void mdstrategy(struct buf *bp)
{
	(void)bp;
}


static COUNT mdwrite(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static void mdsgtty(DEV dev, void *arg)
{
	(void)dev;
	(void)arg;
}


BDEVSW const mdbdev = {
	mdopen,
	mdclose,
	mdstrategy,
	&mdtab,
	nmmd,
};

CDEVSW const mdcdev = {
	mdopen,
	mdclose,
	mdread,
	mdwrite,
	mdsgtty,
	nmrmd
};

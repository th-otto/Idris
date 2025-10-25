#include "kern.h"

static char const nmfd[] = "fd0 fd1";
static char const nmrfd[] = "rfd0 rfd1";
static struct devtab fdtab = { NULL, NULL, NULL, NULL, 0, 0 };
char x2110c[2] = { 0, 0 };
short x2110e = 0;
const char *fd_copyright = "<flop.c - Copyright (c) 1986/87 by Computer Tools, Int. - Ver. 1.0>";


static BOOL fdopen(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static void fdclose(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
}


static COUNT fdread(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static COUNT fdwrite(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static void fdsgtty(DEV dev, void *arg)
{
	(void)dev;
	(void)arg;
}


static void fdstrategy(struct buf *bp)
{
	(void)bp;
}


BDEVSW const fdbdev = {
	fdopen,
	fdclose,
	fdstrategy,
	&fdtab,
	nmfd,
};

CDEVSW const fdcdev = {
	fdopen,
	fdclose,
	fdread,
	fdwrite,
	fdsgtty,
	nmrfd
};

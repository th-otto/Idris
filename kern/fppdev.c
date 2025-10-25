#include "kern.h"

static char const nmfpp[] = "fpp";
static char const nmrfpp[] = "rfpp";

struct devtab fpptab = { NULL, NULL, NULL, NULL, 0, 0 };

BDEVSW const fppbdev = {
	fppopen,
	fppclose,
	(void *)&nobdev, /* ??? */
	&fpptab,
	nmfpp,
};

CDEVSW const fppcdev = {
	fppopen,
	fppclose,
	fppread,
	fppwrite,
	fppsgtty,
	nmrfpp
};
char rfppbuf[46] = { 0 };
char fppnm[] = "fpp";
char *fppproc = 0;


BOOL fppopen(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


void fppclose(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
}


COUNT fppread(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


COUNT fppwrite(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


void fppsgtty(DEV dev, void *arg)
{
	(void)dev;
	(void)arg;
}

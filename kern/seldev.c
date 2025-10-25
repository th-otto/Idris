#include "kern.h"

const char *sel_copyright = "<select.c - Copyright (c) 1986/87 by Computer Tools, Int. - Ver. 1.0>";
static char const nmsel[] = "sel00 sel01 sel02 sel03 sel04 sel05 sel06 sel07 sel08 sel09 sel10 sel11 sel12 sel13 sel14 sel15 sel16 sel17 sel18 sel19 sel20 sel21 sel22 sel23 sel24 sel25 sel26 sel27 sel28 sel29 sel30 sel31";


static void selclose(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
}


static BOOL selopen(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static COUNT selread(DEV dev, short rw)
{
	UNUSED(dev);
	UNUSED(rw);
	return uerror(ENXIO);
}


static COUNT selwrite(DEV dev, short rw)
{
	UNUSED(dev);
	UNUSED(rw);
	return uerror(ENXIO);
}


static void selsgtty(DEV dev, void *arg)
{
	(void)dev;
	(void)arg;
}


CDEVSW const selcdev = {
	selopen,
	selclose,
	selread,
	selwrite,
	selsgtty,
	nmsel
};

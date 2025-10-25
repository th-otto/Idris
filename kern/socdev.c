#include "kern.h"

const char *soc_copyright = "<socket.c - Copyright (c) 1986/87 by Computer Tools, Int. - Ver. 1.0>";
static char const nmsoc[] = "sock00 sock01 sock02 sock03 sock04 sock05 sock06 sock07 sock08 sock09 sock10 sock11 sock12 sock13 sock14 sock15 sock16 sock17 sock18 sock19 sock20 sock21 sock22 sock23 sock24 sock25 sock26 sock27 sock28 sock29 sock30 sock31";


static void socclose(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
}


static BOOL socopen(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static COUNT socread(DEV dev, short rw)
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


static COUNT socwrite(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static void socsgtty(DEV dev, void *arg)
{
	(void)dev;
	(void)arg;
}


CDEVSW const soccdev = {
	socopen,
	socclose,
	socread,
	socwrite,
	socsgtty,
	nmsoc
};

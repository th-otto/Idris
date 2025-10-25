#include "kern.h"

static char const nmhd[] = "hd000 hd001 hd002 hd003 hd004 hd005 hd006 hd007 hd010 hd011 hd012 hd013 hd014 hd015 hd016 hd017 hd100 hd101 hd102 hd103 hd104 hd105 hd106 hd107 hd110 hd111 hd112 hd113 hd114 hd115 hd116 hd117 hd200 hd201 hd202 hd203 hd204 hd205 hd206 hd207 hd210 hd211 hd212 hd213 hd214 hd215 hd216 hd217 hd300 hd301 hd302 hd303 hd304 hd305 hd306 hd307 hd310 hd311 hd312 hd313 hd314 hd315 hd316 hd317";
static char const nmrhd[] = "rhd000 rhd001 rhd002 rhd003 rhd004 rhd005 rhd006 rhd007 rhd010 rhd011 rhd012 rhd013 rhd014 rhd015 rhd016 rhd017 rhd100 rhd101 rhd102 rhd103 rhd104 rhd105 rhd106 rhd107 rhd110 rhd111 rhd112 rhd113 rhd114 rhd115 rhd116 rhd117 rhd200 rhd201 rhd202 rhd203 rhd204 rhd205 rhd206 rhd207 rhd210 rhd211 rhd212 rhd213 rhd214 rhd215 rhd216 rhd217 rhd300 rhd301 rhd302 rhd303 rhd304 rhd305 rhd306 rhd307 rhd310 rhd311 rhd312 rhd313 rhd314 rhd315 rhd316 rhd317";
struct buf rhdbuf = { NULL, NULL, NULL, NULL, 0, NODEV, 0, 0, 0, NULL, 0, 0, 0 };
static struct devtab hdtab = { NULL, NULL, NULL, NULL, 0, 0 };
int x237b0 = 0;


static BOOL hdopen(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static void hdclose(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
}


static COUNT hdread(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static COUNT hdwrite(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static void hdsgtty(DEV dev, void *arg)
{
	UNUSED(dev);
	UNUSED(arg);
	nodev();
}


static void hdstrategy(struct buf *bp)
{
	(void)bp;
}


BDEVSW const hdbdev = {
	hdopen,
	hdclose,
	hdstrategy,
	&hdtab,
	nmhd,
};

CDEVSW const hdcdev = {
	hdopen,
	hdclose,
	hdread,
	hdwrite,
	hdsgtty,
	nmrhd
};

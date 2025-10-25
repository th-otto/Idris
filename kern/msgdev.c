#include "kern.h"

static char const nmmsg[] = "msg msg2 msg3 msg4";
static char const nmrmsg[] = "rmsg rmsg2 rmsg3 rmsg4";
struct buf rmsgbuf = { NULL, NULL, NULL, NULL, 0, NODEV, 0, 0, 0, NULL, 0, 0, 0 }; /* FIXME */
static struct devtab msgtab = { NULL, NULL, NULL, NULL, 0, 0 };


static void msgclose(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
}


static BOOL msgopen(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static COUNT msgread(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static COUNT msgwrite(DEV dev, short rw)
{
	(void)dev;
	(void)rw;
	return 0;
}


static void msgsgtty(DEV dev, void *arg)
{
	UNUSED(dev);
	UNUSED(arg);
	nodev();
}


BDEVSW const msgbdev = {
	msgopen,
	msgclose,
	(void (*)(struct buf *))nodev,
	&msgtab,
	nmmsg,
};

CDEVSW const msgcdev = {
	msgopen,
	msgclose,
	msgread,
	msgwrite,
	msgsgtty,
	nmrmsg
};

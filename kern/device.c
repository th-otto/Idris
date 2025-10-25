#include "kern.h"

struct buf blist = { &blist, &blist, &blist, &blist, B_CTRL, NODEV, 0, 0, 0, NULL, 0, 0, 0 };

void nodev(void)
{
	uerror(ENODEV);
}


BDEVSW const nobdev = {
	(BOOL (*)(DEV, short))nodev,
	(void (*)(DEV, short))nodev,
	(void (*)(struct buf *))nodev,
	0,
	""
};

CDEVSW const nocdev = {
	(BOOL (*)(DEV, short))nodev,
	(void (*)(DEV, short))nodev,
	(COUNT (*)(DEV, short))nodev,
	(COUNT (*)(DEV, short))nodev,
	(VOID (*)(DEV, void *))nodev,
	""
};	


const BDEVSW *const blkdevs[] = {
	&nobdev,
	&nobdev,
	&nobdev,
	&nobdev,
	&fdbdev,
	&hdbdev,
	&mdbdev,
	&msgbdev,
	&nobdev,
};
unsigned int nblkdev = sizeof(blkdevs) / sizeof(blkdevs[0]);

const CDEVSW *const chrdevs[] = {
	&memcdev,
	&concdev,
	&sercdev,
	&lpcdev,
	&fdcdev,
	&hdcdev,
	&mdcdev,
	&msgcdev,
	&fppcdev,
	&ptmcdev,
	&ptscdev,
	&soccdev,
	&selcdev,
	&nocdev,
};
unsigned int cblkdev = sizeof(chrdevs) / sizeof(chrdevs[0]);

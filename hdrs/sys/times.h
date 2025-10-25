/*  TIME ACCOUNTING BUFFER
 *	copyright (c) 1985 by Whitesmiths, Ltd.
 */

#ifndef __TIMES__
#define __TIMES__ 1

struct tms {
	unsigned long tms_utime;
	unsigned long tms_stime;
	unsigned long tms_cutime;
	unsigned long tms_cstime;
};

int _times(struct tms *t);

#endif

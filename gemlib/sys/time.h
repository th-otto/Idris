#ifndef __SYS_TIME__
#define __SYS_TIME__ 1

#ifndef __TIMEH__
#include <time.h>
#endif

/*	set up prototyping
 */
#ifndef __
#ifdef _PROTO
#define __(a)	a
#else
#define __(a)	()
#endif
#endif

struct timeval {
	time_t tv_sec;
	unsigned long tv_usec;
};

/* clashes with struct */
#undef timezone

struct timezone {
	int tz_minuteswest;
	int tz_dsttime;
};

int gettimeofday __((struct timeval *tv, struct timezone *tz));

#endif

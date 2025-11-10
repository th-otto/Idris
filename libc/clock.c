#include <std.h>
#include <time.h>
#include <sys/times.h>

/*
 * determine processor time
 */
clock_t clock(void)
{
	struct tms t;
	
	if (_times(&t) == 0)
		return t.tms_cutime + t.tms_cstime;
	return -1;
}

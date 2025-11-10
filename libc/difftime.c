#include <time.h>

/*
 * calculate time difference
 */
double difftime(time_t time1, time_t time0)
{
	double t0 = time0;
	return time1 - t0;
}

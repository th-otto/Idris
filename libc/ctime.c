#include <time.h>

/*
 * transform local time to ASCII
 */
char *ctime(const time_t *timer)
{
	return asctime(localtime(timer));
}

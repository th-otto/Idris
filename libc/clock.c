#include <std.h>
#include <signal.h>
#include <sys/res.h>
#include <sys/usr.h>
#include <time.h>

clock_t clock(void)
{
	TIMES t;
	
	if (_times(&t) == 0)
		return t.ti_cu + t.ti_cs;
	return -1;
}

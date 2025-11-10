#include <std.h>
#include <time.h>
#include <string.h>
#include <pcdecl.h>


static void twodigits(char *s, int val)
{
	s[1] = (val % 10) + '0';
	s[0] = ((val / 10) % 10) + '0';
}


/*
 * transform date and time to ASCII
 */
char *asctime(register const struct tm *timeptr)
{
#define STD_ASCTIME_BUF_SIZE	26
	static char buf[STD_ASCTIME_BUF_SIZE];
	static char const daynames[7][3] = { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" };
	static char const monthnames[12][3] = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" };

	register char *cp = buf;
	
	_cpybuf(&cp[0], daynames[timeptr->tm_wday < 0 || timeptr->tm_wday > 6 ? 0 : timeptr->tm_wday], 3);
	cp[3] = ' ';
	_cpybuf(&cp[4], monthnames[timeptr->tm_mon < 0 || timeptr->tm_mon > 11 ? 0 : timeptr->tm_mon], 3);
	cp[7] = ' ';
	twodigits(&cp[8], timeptr->tm_mday);
	cp[10] = ' ';
	twodigits(&cp[11], timeptr->tm_hour);
	cp[13] = ':';
	twodigits(&cp[14], timeptr->tm_min);
	cp[16] = ':';
	twodigits(&cp[17], timeptr->tm_sec);
	cp[19] = ' ';
	twodigits(&cp[20], timeptr->tm_year / 100 + 19);
	twodigits(&cp[22], timeptr->tm_year % 100);
	cp[24] = '\n';
	cp[25] = '\0';
	return cp;
}


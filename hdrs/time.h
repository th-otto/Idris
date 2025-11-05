/*	TIME OF DAY HEADER
 *	copyright (c) 1984, 1987 by Whitesmiths, Ltd.
 */

#ifndef __TIMEH__
#define __TIMEH__	1

/*	set up default compiler version if none given
 */
#ifndef _CVERSION
#define _CVERSION	300
#endif

#if _CVERSION < 300
#define void char
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

/*	the asctime, ctime, gmtime and localtime structure
 */
struct tm {
	int tm_sec;		/* seconds [0, 59] */
	int tm_min;		/* minutes [0, 59] */
	int tm_hour;	/* hours [0, 23] */
	int tm_mday;	/* day of month [1, 31] */  
	int tm_mon;		/* month of year [0, 11] */
	int tm_year;	/* years since 1900 A.D. */
	int tm_wday;	/* day of week, sunday = 0 [0, 6] */
	int tm_yday;	/* day of year [0, 365] */
	int tm_isdst;	/* non-zero if daylight savings time */
};

/*	type declarations
 */
typedef unsigned long clock_t;
#ifndef __TYPES__
typedef unsigned long time_t;
#endif

/*	function declarations
 */
char *asctime __((const struct tm *timeptr));
char *ctime __((const time_t *timer));
clock_t clock __((void));
double difftime __((time_t time2, time_t time1));
struct tm *gmtime __((const time_t *timer));
struct tm *localtime __((const time_t *timer));
time_t time __((time_t *timer));
int stime __((time_t t));

/*	include system dependent clock info
 */
/*	macro
 */
#define CLK_TCK		_CLKTICK

#ifdef _IDRIS
extern int _dst;
#define daylight	_dst
extern long _timezone;
#define tzname		_tzname
#endif

#if 0
void tzset __((void));
#endif

#endif

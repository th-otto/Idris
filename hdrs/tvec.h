/*	TIME OF DAY HEADER
 *	copyright (c) 1980, 1987 by Whitesmiths, Ltd.
 */

#ifndef __TVEC__
#define __TVEC__ 1

/* some notes about Daylight Savings Time...
 *
 * In 1974, DST began on the first Sunday of January.
 * In 1975, DST began on the last Sunday of February.
 * In the years between 1970 and 1986, inclusive but
 * excluding the years above, DST began on the
 * last Sunday in April.
 * For 1987 and until the next Congress, DST will begin
 * on the first Sunday of April.
 * In all cases, DST has (mercifully) ended on the last
 * Sunday of October.
 */
#define BEGDST74	6		/* January 6, 1974 */
#define BEGDST75	58		/* February 23, 1975 */
#define BEGDST86	119		/* April 24 to April 31 */
#define BEGDST		98		/* April 5, 1987 */
#define ENDDST		303		/* October 24 to October 31 */
#define SECDAY 		86400
#define SECHOUR		3600
#define THURSDAY	4

#define DATEFIL	"/adm/date"
#define ZONEFIL	"/adm/zone"

/*	the atime, ltime, and vtime structure
 */
typedef struct _tvec {
	BYTES secs;		/* seconds		[0, 60)	*/
	BYTES mins;		/* minutes		[0, 60)	*/
	BYTES hrs;		/* hours		[0, 24)	*/
	BYTES dmth;		/* day of month			[1, 31]	*/  
	BYTES mth;		/* month of year		[0, 12)	*/
	BYTES yr;		/* years since 1900		[70, 131)	*/
	BYTES dwk;		/* day of week, sunday = 0	[0, 7)	*/
	BYTES dyr;		/* day of year				[0, 365]	*/
	BOOL dstf;		/* non-zero if daylight savings time	*/
} TVEC;

#endif

/*	WHO FILES AND FORMATS
 *	copyright (c) 1980 by Whitesmiths, Ltd.
 */

#ifndef __WHO__
#define __WHO__ 1

/*	files
 */
#define WHOFILE	"/adm/who"
#define HSTFILE	"/adm/log"

/*	format
 */
typedef struct {
	TEXT w_tty[14];
	TEXT w_uname[8];
	LONG w_time;
} WHO;

#endif

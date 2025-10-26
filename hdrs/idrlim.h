/*	IDRIS SPECIFIC LIMITS
 *	copyright (c) 1986, 1987 by Whitesmiths, Ltd.
 */

#ifndef __IDRLIM__
#define __IDRLIM__	1

#ifndef _IDRIS
#define _IDRIS	1
#endif

/*	IDRIS dependent
 */
#define _CASES		2
#define _CLKTICK	60
#define _EXLEN		127
#define _MAXFILE	32
#define _SLLEN		511
#define _TMPMAX		25
#define _TMPSIZ		14

#define	ARG_MAX		10000
#define	FCHR_MAX	16777215	/* 2^25 - 1 */
#define	CHILD_MAX	32767
#define	LOCK_MAX	200
#define	LINK_MAX	255
#define	LONG_BIT	32
#define	NAME_MAX	14
#define	OPEN_MAX	_MAXFILE
#define	PASS_MAX	8
#define	PID_MAX		32767
#define	PATH_MAX	255
#define	PIPE_BUF	512
#define	PIPE_MAX	4096
#define	PROC_MAX	32767
#define	STD_BLK		512

#endif

/*	PSEUDO TYPES
 *	copyright (c) 1986 by Whitesmiths, Ltd.
 */

#ifndef __TYPES__
#define __TYPES__ 1

typedef unsigned char uid_t;
typedef unsigned char gid_t;
typedef unsigned short ino_t;
typedef unsigned short dev_t;
typedef short pid_t;
typedef long off_t;
typedef unsigned long daddr_t, ttime_t;
typedef unsigned short mode_t;


#ifndef __TIMEH__
typedef unsigned long time_t;
#endif

#endif

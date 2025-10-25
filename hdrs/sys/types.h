/*	PSEUDO TYPES
 *	copyright (c) 1986 by Whitesmiths, Ltd.
 */

#ifndef __TYPES__
#define __TYPES__ 1

typedef unsigned char uid_t;
typedef unsigned short ushort, ino_t, dev_t;
typedef long off_t;
typedef unsigned long daddr_t, ttime_t;

#ifndef __TIMEH__
typedef unsigned long time_t;
#endif

#endif

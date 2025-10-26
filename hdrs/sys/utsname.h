/*	UTSNAME DEFINE SYSTEM NAMES
 *	copyright (c) 1985, 1986 by Whitesmiths, Ltd.
 */
#ifndef __UTSNAME__
#define __UTSNAME__ 1

#ifndef SYS_NMLN
#define SYS_NMLN 8
#endif

struct utsname
{
	char sysname[SYS_NMLN];
	char nodename[SYS_NMLN];
	char release[SYS_NMLN];
	char version[SYS_NMLN];
	char machine[SYS_NMLN];
};

int uname(struct utsname *buf);

#endif

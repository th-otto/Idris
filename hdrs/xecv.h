/*	XECV/XECL FLAGS
 * copyright (c) 1985 by Whitesmiths, Ltd.
 */

#ifndef __XECV__
#define __XECV__ 1

#define X_MODE	0x03
#define X_SYN	0x00
#define X_ASYN	0x01
#define X_OVLAY	0x02
#define X_SYSIG	0x04
#define X_RUID	0x08
#define X_RID	X_RUID
#define X_EUID	0x10
#define X_EID	X_EUID

short _xecv(const char *cmd, int sin, int sout, short flags, const char **pargs);
int _xecl(const char *cmd, int sin, int sout, int flags, ...);

#endif

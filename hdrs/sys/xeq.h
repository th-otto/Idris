/*	FLAG STRUCTURE FOR XEQ SYSTEM CALL
 *	copyright (c) 1986 by Whitesmiths, Ltd.
 */

#ifndef __XEQ__
#define __XEQ__ 1

/*	xf_flag bits
 */
#ifndef __XECV__
#define __XECV__ 1

/*	set up prototyping
 */
#ifndef __
#ifdef _PROTO
#define __(a)	a
#else
#define __(a)	()
#endif
#endif

#define X_MODE	0x0003
#define 	X_SYN	0x0000
#define 	X_ASYN	0x0001
#define 	X_OVLAY	0x0002
#define	X_SYSIG 0x0004
#define X_RID	0x0008
#define X_RUID	X_RID
#define X_EID	0x0010
#define X_EUID	X_EID
#endif

#define X_NEWIO	0x0020
#define X_SETB	0x0040
#define X_PCNTL 0x0080
#define X_PGRP	0x0100

/*	xeq flags
 */
typedef struct {
	/* BITS */ BYTES xf_flag;
	/* FID */ ARGINT xf_sin, xf_sout, xf_serr;
	/* BYTES */ BYTES xf_setb;
	/* BITS */ BYTES xf_pcntl, xf_pri;
	/* DEV */ BYTES xf_tty;
} XFLAGS;

short _xecv __((const char *cmd, int sin, int sout, short flags, const char **pargs));
ERROR _xeq __((const char *path, const char **args, const char **env, BITS xf_flag, ... /* ARGINT xf_sin, ARGINT xf_sout, ARGINT xf_serr, BYTES xf_setb, BYTES xf_pcntl, BYTES xf_pri, BYTES xf_tty */));
int _xecl __((const char *cmd, int sin, int sout, int flags, ...));

#endif

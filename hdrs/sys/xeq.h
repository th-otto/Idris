/*	FLAG STRUCTURE FOR XEQ SYSTEM CALL
 *	copyright (c) 1986 by Whitesmiths, Ltd.
 */

#ifndef __XEQ__
#define __XEQ__ 1

/*	xf_flag bits
 */
#ifndef __XECV__
#define __XECV__ 1

#define X_MODE	0003
#define 	X_SYN	0000
#define 	X_ASYN	0001
#define 	X_OVLAY	0002
#define	X_SYSIG 0004
#define X_RID	0010
#define X_RUID	X_RID
#define X_EID	0020
#define X_EUID	X_EID
#endif

#define X_NEWIO	0040
#define X_SETB	0100
#define X_PCNTL	0200
#define X_PGRP	0400

/*	xeq flags
 */
typedef struct {
	/* BITS */ BYTES xf_flag;
	/* FID */ ARGINT xf_sin, xf_sout, xf_serr;
	/* BYTES */ BYTES xf_setb;
	/* BITS */ BYTES xf_pcntl, xf_pri;
	/* DEV */ BYTES xf_tty;
} XFLAGS;

#endif

/*	THE STANDARD HEADER
 *	copyright (c) 1978, 1987 by Whitesmiths, Ltd.
 *	no I/O or prototypes; use stdio.h, et. al.
 */

#ifndef	__STD__
#define	__STD__	1

/*	the pseudo storage classes
 */
#define FAST	register
#define GLOBAL	extern
#define IMPORT	extern
#define INTERN	static
#define LOCAL	static
#define RDONLY	const
#define TOUCHY	volatile

/*	the pseudo types
 */
typedef char TBOOL, TEXT;
typedef float FLOAT;
typedef double DOUBLE;
typedef int ARGINT, BOOL, ERROR, FD, INT, METACH;
typedef long LONG;
typedef short COUNT;
typedef unsigned char TBITS, UTINY;
typedef unsigned short BITS, UCOUNT;
typedef unsigned int BYTES;
typedef unsigned long LBITS, MEMAD, ULONG;
typedef struct tm TIMEVEC;

#ifndef _CVERSION
#define _CVERSION 300
#endif

#if _CVERSION < 300
typedef char TINY;
typedef char VOID;
#else
typedef signed char TINY;
typedef void VOID;
typedef VOID (*(*FNPTR)(void))(void);	/* pseudo type for onexit */
#endif

/*	system parameters
 */
#define STDIN	0
#define STDOUT	1
#define STDERR	2
#define YES		1
#define NO		0
#define SUCCESS	0
#define FAIL	1
#ifndef NULL
#define NULL	(VOID *)0
#endif
#define FOREVER	for (;;)
#define BUFSIZE	512
#define BWRITE	(-1)
#define READ	0
#define WRITE	1
#define UPDATE	2
#define BYTMASK	0377
#define CPERM	0666
#define R_RAW	1
#define R_COOKED	0
#define R_QUERY	(-1)

/*	macros
 */
#define abs(x)		((x) < 0 ? -(x) : (x))
#define bndof(ty)	((unsigned int)&(((struct{char _c;ty _x;}*)0)->_x))
#define bndup(ptr, ty)	((unsigned)(ptr) + (bndof(ty) - 1) & \
						~(bndof(ty) - 1))
#define max(x, y)	(((x) < (y)) ? (y) : (x))
#define min(x, y)	(((x) < (y)) ? (x) : (y))

#endif

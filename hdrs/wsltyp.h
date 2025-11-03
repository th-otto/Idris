/*	STANDARD DEFINITIONS FOR ANSI USERS USING WHITESMITHS TYPES
 *	copyright (c) 1985 by Whitesmiths, Ltd.
 */

#ifndef __WSLTYP__
#define __WSLTYP__	1

/*	the pseudo storage classes
 */
#define FAST	register
#define GLOBAL	extern
#define IMPORT	extern
#define INTERN	static
#define LOCAL	static

/*	the pseudo types
 */
#ifndef __STD__
typedef char TBOOL, TEXT;
typedef double DOUBLE;
typedef float FLOAT;
typedef int ARGINT, BOOL, ERROR, FD, INT, METACH;
typedef long LONG;
typedef short COUNT;
typedef unsigned char TBITS, UTINY;
typedef unsigned long LBITS, ULONG;
typedef unsigned short BITS, UCOUNT;
typedef unsigned int BYTES;

#if _CVERSION < 300
typedef char TINY;
#define void char
#define VOID char
#else
typedef signed char TINY;
typedef void VOID;
#ifndef RDONLY
#define RDONLY const
#endif
#ifndef TOUCHY
#define TOUCHY volatile
#endif
typedef VOID (*(*FNPTR)(void))(void);	/* pseudo type for onexit */
#endif

#define TIMEVEC struct tm

#endif /* __STD__ */

typedef unsigned long TIME;

#endif

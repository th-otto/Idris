/*	THE STANDARD WSL DEFINITIONS HEADER
 *	copyright (c) 1985 by Whitesmiths, Ltd.
 */

#ifndef __WSLXA__
#define __WSLXA__	1

/*	set up default compiler and library version if none given
 */
#ifndef _CVERSION
#define _CVERSION	300
#endif
#ifndef _LVERSION
#define _LVERSION	300
#endif

/*	set up prototyping
 */
#ifndef __
#ifdef _PROTO
#define __(a)	a
#else
#define __(a)	()
#endif
#endif

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
typedef unsigned long LBITS, ULONG, MEMAD;
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

#endif /* __STD__ */

/*	system parameters
 */
#define STDIN	0
#define STDOUT	1
#define STDERR	2
#define YES		1
#define NO		0
#define FAIL	1
#define SUCCESS	0
#ifndef NULL
#define NULL	((VOID *)0)
#endif
#define FOREVER	for (;;)
#define BYTMASK	0377
#define CPERM	0666
#ifndef R_QUERY
#define R_RAW		1
#define R_COOKED	0
#define R_QUERY		(-1)
#endif

/*	being phased out when WSL library is phased out
 */
#ifndef BWRITE
#define READ	0
#define WRITE	1
#define UPDATE	2
#define BWRITE	(-1)
#endif

/*	declarations for libc functions returning pointers, longs or doubles
 */
#ifndef _EXECUTIVE
struct _tvec;

COUNT (*mkord __((TEXT **keyarray, TEXT *lnordrule)))(void);
DOUBLE dtento __((DOUBLE d, int exp));
DOUBLE _dtento __((DOUBLE d, int exp));
DOUBLE sqr __((DOUBLE x));
LONG lstol __((const ULONG *s));
TEXT *atime __((struct _tvec *pv, TEXT *s));
char *cpystr __((char *dest, ...));
char *_cpystr __((char *dest, ...));
TEXT *_decrypt __((TEXT data[8], TINY ks[16][8]));
TEXT *_encrypt __((TEXT data[8], TINY ks[16][8]));
TEXT *getflags __((BYTES *pac, TEXT ***pav, const char *fmt, ...));
TEXT *itols __((TEXT *s, COUNT n));
TEXT *ltols __((TEXT *pl, LONG lo));
char *pathnm __((char *buf, const char *n1, const char *n2));
TEXT *pattern __((TEXT *pat, TEXT delim, TEXT *p));
TEXT *uniqnm __((VOID));
TINY *_bldks __((TINY ks[16][8], const char key[8]));
ULONG xstol __((const char *s, BOOL lsfmt));
VOID *_alloc __((BYTES need, VOID *link));
VOID *buybuf __((const VOID *s, BYTES n));
VOID *frelst __((VOID *p, VOID *plast));
VOID lfree __((VOID *addr));
VOID *_lfree __((VOID *addr, VOID *link));
VOID *_free __((VOID *addr, VOID *link));
VOID *_nalloc __((BYTES need, VOID *link));
VOID *sbreak __((BYTES size));
struct _tvec *ltime __((struct _tvec *pv, ULONG lt));
struct _tvec *vtime __((struct _tvec *pv, ULONG lt));
#endif	/* EXECUTIVE */

/*	optionally include all other function prototype declarations
 */
#ifdef _PROTO
#include <pcdecl.h>
#endif

/*	macros
 */
#define max(x, y)	(((x) < (y)) ? (y) : (x))
#define min(x, y)	(((x) < (y)) ? (x) : (y))

#endif

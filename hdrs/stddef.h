/*	STANDARD DEFINES HEADER
 *	copyright (c) 1985 by Whitesmiths, Ltd.
 */

#ifndef __STDEFS__
#define __STDEFS__	1

/*	types
 */
typedef long ptrdiff_t;

/*	set up type not already set up
 */
#ifndef __STDIO__
#ifndef __STDLIB__
#ifndef __STRING__
typedef unsigned int size_t;
#endif
#endif
#endif

/*	global variable references
 */
extern int errno;

/*	macros
 */
#ifndef NULL
#define NULL	(void *)0
#endif

#ifdef __GNUC__
#define offsetof(type, ident) __builtin_offsetof(type, ident)
#else
#define offsetof(type, ident) ((size_t)&(((type *)0)->ident))
#endif

#endif

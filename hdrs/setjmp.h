/*	SETJMP/LONGJMP HEADER
 *	copyright (c) 1984, 1987 by Whitesmiths, Ltd.
 */

#ifndef __SETJMP__
#define __SETJMP__	1

/*	set up default compiler version if none given
 */
#ifndef _CVERSION
#define _CVERSION	300
#endif

#if _CVERSION < 300
#define void char
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

#ifndef _EXECUTIVE
#define longjmp	_longjmp
#define setjmp	_setjmp
#endif

/*	include machine dependent information
 */
#include <sys/machine.h>

/*	type declaration
 */
typedef char *jmp_buf[_JMPSIZ];

/*	function declarations
 */
int setjmp __((jmp_buf env));
void longjmp __((jmp_buf env, int val));

#endif

/*	MEMORY TYPES HEADER
 *	copyright (c) 1987 by Whitesmiths, Ltd.
 */

#ifndef __MEMORY__
#define __MEMORY__	1

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

/*	function declarations
 */
#if 0
char *memccpy __((void *dst, const void *src, int c, size_t n));
#endif
int memcmp __((const void *s1, const void *s2, size_t n));
void *memchr __((const void *s, int c, size_t n));
void *memcpy __((void *s1, const void *s2, size_t n));
void *memset __((void *s, int c, size_t n));

#endif

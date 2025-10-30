/*	GENERAL LIBRARY FUNCTIONS HEADER
 *	copyright (c) 1984 by Whitesmiths, Ltd.
 */

#ifndef __STDLIB__
#define __STDLIB__	1

/*	set up default compiler version if none given
 */
#ifndef _CVERSION
#define _CVERSION	300
#endif

#if _CVERSION < 300
#define void char
#endif

#ifndef __STDEFS__
#include <stddef.h>
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

/*	type declarations
 */

typedef void (*(*onexit_t)(void))(void);

/*	function declarations
 */

char *getenv __((const char *name));
double atof __((const char *nptr));
double strtod __((const char *nptr, char **endptr));
int atoi __((const char *nptr));
int rand __((void));
int system __((const char *string));
long atol __((const char *nptr));
long strtol __((const char *nptr, char **endptr, int base));
onexit_t onexit __((onexit_t (*pfn)(void)));
void *calloc __((unsigned int nelem, size_t elsize));
void *malloc __((size_t size));
void *realloc __((void *ptr, size_t size));
void abort __((void));
void exit __((int status));
void free __((void *ptr));
void srand __((unsigned int seed));
void exit __((int status));
void abort __((void));

long random __((void));
void srandom __((unsigned int seed));

int rand __((void));
void srand __((unsigned int seed));

#endif



/*	VARIABLE ARGUMENT LIST HEADER (XOPEN)
 *	copyright (c) 1987 by Whitesmiths, Ltd.
 */

#ifndef __VARARGS__
#define __VARARGS__	1

/*	type and macro declarations - va_start different
 */
#include <stdarg.h>
#undef va_start
#define va_start(ap)	((ap) = (char *)&va_alist)
#define va_dcl	int va_alist;

#endif

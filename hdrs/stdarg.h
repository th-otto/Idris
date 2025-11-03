/*	VARIABLE ARGUMENT LIST HEADER
 *	copyright (c) 1984 by Whitesmiths, Ltd.
 */

#ifndef __STDARG__
#define __STDARG__	1

/*	type and macro declarations
 */
#ifdef __GNUC__
#include_next <stdarg.h>
#else
typedef char *va_list;

/*	macros
 */
#define va_start(ap, arg) ((ap) = (char *)&(arg) + (sizeof(arg) < sizeof(int) ? sizeof(int) : sizeof(arg)))
#define va_arg(ap, type)    \
    ((sizeof(type) < sizeof(int)) ? \
     (type)(((int *)(ap += sizeof(int)))[-1]) : \
     (((type *)(ap += sizeof(type)))[-1]))
#define va_end(ap)

#endif
#endif

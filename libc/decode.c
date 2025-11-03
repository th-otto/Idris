#include <std.h>
#include <stdio.h>
#include <stdarg.h>
#include <pcdecl.h>
#include "libc.h"


static BYTES eputf(void *arg, register const char *s, BYTES count)
{
	register struct _mbuf *buf = arg;
	register int n = count;
	
	while (n > 0 && buf->count < buf->maxcount)
	{
		*(buf->s++) = *s++;
		buf->count++;
		n--;
	}
	return count;
}


BYTES decode(char *s, BYTES n, const char *fmt, ...)
{
	struct _mbuf buf;
	
	buf.s = s;
	buf.maxcount = n;
	buf.count = 0;
	_putf(eputf, &buf, fmt, &(&fmt)[1]);
	return buf.count;
}

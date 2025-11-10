#include <std.h>
#include <stdarg.h>
#include <pcdecl.h>

/*
 * convert text to arguments under format control
 */
COUNT encode(char *s, BYTES n, const char *fmt, ...)
{
	return _encode(s, n, fmt, &(&fmt)[1]);
}

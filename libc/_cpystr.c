#include <wslxa.h>
#include <stdarg.h>

char *_cpystr(char *_dest, ...)
{
	va_list args;
	register char *dest = _dest;
	register const char *src;
	
	va_start(args, _dest);
	while ((src = va_arg(args, const char *)) != NULL)
	{
		while ((*dest++ = *src++) != '\0')
			;
		--dest;
	}
	va_end(args);
	return dest;
}

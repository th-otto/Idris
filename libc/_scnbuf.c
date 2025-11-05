#include <std.h>
#include <pcdecl.h>
#include <string.h>


size_t _scnbuf(const void *s, register size_t n, register char c)
{
	register const char *str = s;
	
	if (n != 0)
	{
		do
		{
			if (*str++ == c)
			{
				str--;
				break;
			}
		} while (--n != 0);
	}
	return str - (const char *)s;
}

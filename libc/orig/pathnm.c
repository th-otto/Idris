#include <wslxa.h>
#include <string.h>


/*
 * complete a pathname
 */
char *pathnm(char *buf, const char *n1, const char *_n2)
{
	register const char *end;
	register const char *slash;
	register const char *n2;
	register size_t pos;

	n2 = _n2;
	end = &n2[_lenstr(n2) - 1];
	slash = "/";
	end = n1; /* WTF? */
	while (end[pos = instr(end, "/")] != '\0')
	{
		end += pos + 1;
	}
	_cpystr(buf, n2, slash, end, NULL);
	return buf;
}

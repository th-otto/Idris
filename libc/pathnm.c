#include <wslxa.h>
#include <string.h>


/*
 * complete a pathname
 */
char *pathnm(char *buf, const char *n1, const char *n2)
{
	register const char *end;
	register size_t pos;

	end = n1;
	while (end[pos = instr(end, "/")] != '\0')
	{
		end += pos + 1;
	}
	_cpystr(buf, n2, "/", end, NULL);
	return buf;
}

#include <std.h>
#include <pcdecl.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <ctype.h>
#include <limits.h>


long strtol(register const char *nptr, char **endptr, int base)
{
	register size_t len;
	register size_t ok;
	long val;
	register int save_errno;
	
	save_errno = errno;
	errno = 0;
	len = strlen(nptr);
	while (len != 0 && isspace((unsigned char)*nptr))
	{
		nptr++;
		len--;
	}
	ok = _btol(nptr, strlen(nptr), &val, base);
	if (endptr != NULL)
		*endptr = (char *)nptr + ok;
	if (errno == ERANGE)
	{
		val = len != 0 && *nptr == '-' ? LONG_MIN : LONG_MAX;
	}
	if (errno == 0)
		errno = save_errno;
	return ok ? val : 0;
}

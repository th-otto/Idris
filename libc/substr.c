#include <std.h>
#include <pcdecl.h>
#include <string.h>

/*
 * find occurrence of substring
 */
size_t substr(const char *ps, const char *pp)
{
	return subbuf(ps, strlen(ps), pp, strlen(pp));
}

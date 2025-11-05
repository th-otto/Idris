#include <std.h>
#include <pcdecl.h>
#include <string.h>

size_t substr(const char *ps, const char *pp)
{
	return subbuf(ps, strlen(ps), pp, strlen(pp));
}

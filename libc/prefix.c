#include <std.h>
#include <pcdecl.h>

#undef prefix
BOOL prefix(const char *s1, const char *s2)
{
	return _prefix(s1, s2);
}

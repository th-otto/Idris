#include <std.h>
#include <pcdecl.h>

/*
 * test if one string is a prefix of the other
 */
#undef prefix
BOOL prefix(const char *s1, const char *s2)
{
	return _prefix(s1, s2);
}

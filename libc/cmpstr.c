#include <std.h>
#include <pcdecl.h>

#undef cmpstr
BOOL cmpstr(const char *s1, const char *s2)
{
	return _cmpstr(s1, s2);
}


#include <std.h>
#include <pcdecl.h>

#undef remark
BOOL remark(const char *s1, const char *s2)
{
	return _remark(s1, s2);
}

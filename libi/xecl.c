#include <xecv.h>

int _xecl(const char *cmd, int sin, int sout, int flags, ...)
{
	return _xecv(cmd, sin, sout, flags, (const char **)&flags + 1);
}

#include <std.h>
#include <pcdecl.h>
#include <stdlib.h>
#include <string.h>


long atol(const char *nptr)
{
	long val;
	
	return _btol(nptr, strlen(nptr), &val, 10) != 0 ? val : 0;
}

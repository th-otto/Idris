#include <std.h>
#include <pcdecl.h>
#include <stdlib.h>
#include <string.h>


int atoi(const char *nptr)
{
	int val;
	
	return _btoi(nptr, strlen(nptr), &val, 10) != 0 ? val : 0;
}

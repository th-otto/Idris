#include "kern.h"

ULONG tflip(ULONG val)
{
	char *p = (char *)&val;
	union {
		char c[4];
		ULONG l;
	} ret;
	
	ret.c[0] = p[1];
	ret.c[1] = p[0];
	ret.c[2] = p[3];
	ret.c[3] = p[2];
	return ret.l;
}

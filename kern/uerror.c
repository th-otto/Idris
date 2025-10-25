#include "kern.h"

struct user *pu;

BYTES setcount(BYTES count)
{
	pu->u_count = count;
	return pu->u_count;
}


long setseek(long offset)
{
	pu->u_offset = offset;
	return pu->u_offset;
}


int uerror(int err)
{
	if (err != 0)
	{
		pu->u_error = err;
	}
	return pu->u_error;
}

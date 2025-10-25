#include "kern.h"

struct old_times {
	ULONG ti_u;
	ULONG ti_s;
	ULONG ti_cu;
	ULONG ti_cs;
};

struct old_sytimes_args {
	struct old_times *t;
};

void _sytimes(void *args)
{
	register struct user *u = pu;
	struct old_times t;
	
	t.ti_u = u->u_times.ti_u;
	t.ti_s = u->u_times.ti_s;
	t.ti_cu = u->u_times.ti_cu;
	t.ti_cs = u->u_times.ti_cs;
	if (outbuf(&t, ((struct old_sytimes_args *)args)->t, sizeof(t)) != 0)
		u->u_error = EFAULT;
}

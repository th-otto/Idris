#include <wslxa.h>

void *frelst(register void *p, register void *plast)
{
	while (p != NULL && p != plast)
	{
		p = _free(p, *((void **)p));
	}
	return p;
}


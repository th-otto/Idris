#include <stdio.h>
#include "libc.h"

FILE **_onlist(register FILE *stream, register FILE **list)
{
	register FILE *next;
	
	while ((next = *list) != NULL)
	{
		if (next == stream)
			return list;
		list = &next->flist;
	}
	return NULL;
}

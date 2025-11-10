#include <stdio.h>
#include "libc.h"

/*
 * internal - check for stream being on list
 */
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

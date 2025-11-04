#include <stdio.h>
#include "libc.h"


void rewind(FILE *stream)
{
	if (fseek(stream, 0L, SEEK_SET) != 0)
		stream->flag &= ~(_FIOEOF | _FIOERR);
}

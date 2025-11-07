#include <stdlib.h>
#include "libi.h"

const char *logname(void)
{
	return getenv("LOGNAME");
}


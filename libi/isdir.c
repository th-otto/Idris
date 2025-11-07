#include "libi.h"

/*
 * return TRUE if mode is a directory
 */
int isdir(mode_t mode)
{
	return S_ISDIR(mode);
}

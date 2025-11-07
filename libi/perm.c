#include <unistd.h>
#include "libi.h"

BOOL perm(struct stat *st, register mode_t mask)
{
	register mode_t mode;
	register short uid;
	
	mode = st->st_mode;
	mask &= S_IROTH | S_IWOTH | S_IXOTH;
	if ((uid = getuid()) == 0)
	{
		 return !(mask & S_IXOTH) || (mode & (S_IXOTH | S_IXGRP | S_IXUSR)) != 0;
	}
	if (st->st_uid == uid)
	{
		mask <<= 6;
	} else if (getgid() == st->st_gid)
	{
		mask <<= 3;
	}
	return (mask & mode) == 0;
}

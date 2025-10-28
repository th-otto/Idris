#include <std.h>
#include <unistd.h>
#include <sys/stat.h>
#include <stdio.h>
#include <pcdecl.h>


char *ttyname(int fd)
{
	struct stat st;
	static char tname[L_ctermid];
	
	if (fstat(fd, &st) >= 0)
	{
		if (S_ISCHR(st.st_mode))
		{
			_devname(tname, st.st_rdev, 1);
			return tname;
		}
	}
	return NULL;
}

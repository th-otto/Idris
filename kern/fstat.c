#include "kern.h"


struct fstat_args {
	int fd;
	struct stat *st;
};

void syfstat(void *_args)
{
	register struct fstat_args *args = _args;
	register struct fvar *f;
	
	f = mapfd(args->fd);
	if (f != NULL)
	{
		getstat(geti(f->f_inode->i_dev, f->f_inode->i_ino), args->st);
	}
}

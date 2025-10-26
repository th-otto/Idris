#include <std.h>
#include <sys/stat.h>
#include <unistd.h>

int mkdir(const char *pathname, mode_t mode)
{
	int err;
	
	if ((err = mknod(pathname, (mode & 0xfff) | S_IFDIR, 0)) == 0)
	{
		err = chown(pathname, geteuid(), getegid());
	}
	return err;
}

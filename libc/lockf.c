#include <unistd.h>
#include <fcntl.h>

/*
 * apply, test or remove a POSIX lock on an open file
 */
int lockf(int fd, int cmd, off_t len)
{
	struct flock fl;
	
	fl.l_start = lseek(fd, 0, SEEK_CUR);
	if ((off_t)fl.l_start < 0)
		return -1;
	if (len < 0)
	{
		/* BUG: no check for underflow */
		fl.l_start += len;
		len = -len;
	}
	fl.l_type = F_WRLCK;
	fl.l_whence = SEEK_SET;
	switch (cmd)
	{
	case F_ULOCK:
		fl.l_type = F_UNLCK;
		/* fall through */
	case F_LOCK:
		cmd = F_SETLK;
		break;
	case F_TLOCK:
		cmd = F_SETLKW;
		break;
	case F_TEST:
		fcntl(fd, F_GETLK, &fl);
		if (fl.l_type == F_UNLCK)
			return 0;
		return -1;
	}
	if (fcntl(fd, cmd, &fl) < 0)
		return -1;
	return 0;
}


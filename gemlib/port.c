#include <std.h>
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <sys/time.h>

const char *sys_errlist[] = {
	"ERANGE",
	"EDOM",
	"EPIPE",
	"EMLINK",
	"EROFS",
	"ESPIPE",
	"ENOSPC",
	"EFBIG",
	"ETXTBSY",
	"ENOTTY",
	"EMFILE",
	"ENFILE",
	"EINVAL",
	"EISDIR",
	"ENOTDIR",
	"ENODEV",
	"EXDEV",
	"EEXIST",
	"EBUSY",
	"ENOTBLK",
	"EFAULT",
	"EACCES",
	"ENOMEM",
	"EAGAIN",
	"ECHILD",
	"EBADF",
	"ENOEXEC",
	"E2BIG",
	"ENXIO",
	"EIO",
	"EINTR",
	"ESRCH",
	"ENOENT",
	"EPERM",
	"?????"
};
int sys_nerr = sizeof(sys_errlist) / sizeof(sys_errlist[0]);


char *perror(const char *s)
{
	printf("\r\n<Error (%s), errno (%d)!>\r\n", s, errno);
	return 0;
}


void abort(void)
{
	printf("\007\r\n<<<abort called>>>\r\n");
	exit(1);
}


int getdtablesize(void)
{
	return OPEN_MAX;
}


int gettimeofday(struct timeval *tv, struct timezone *tz)
{
	if (tv)
	{
		tv->tv_sec = time(0);
		tv->tv_usec = 0;
	}
	if (tz)
	{
		tz->tz_minuteswest = 480;
		tz->tz_dsttime = 0;
	}
	return 0;
}

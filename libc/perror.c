#include <std.h>
#include <stdio.h>
#include <errno.h>


char *perror(const char *s)
{
	const char *str;
	int err = errno;
	static char buf[32];
	
	switch (err)
	{
	case E2BIG:
		str = "too big";
		break;
	case EACCES:
		str = "access denied";
		break;
	case EAGAIN:
		str = "try again";
		break;
	case EBADF:
		str = "bad file descriptor";
		break;
	case EBUSY:
		str = "device in use";
		break;
	case ECHILD:
		str = "child";
		break;
	case EDEADLK:
		str = "deadlock could occur";
		break;
	case EDOM:
		str ="domain error";
		break;
	case EEXIST:
		str = "already exists";
		break;
	case EFAULT:
		str = "memory fault";
		break;
	case EFBIG:
		str = "file too big";
		break;
	case EINTR:
		str = "interrupted";
		break;
	case EINVAL:
		str = "invalid request";
		break;
	case EIO:
		str = "I/O error";
		break;
	case EISDIR:
		str = "is a directory";
		break;
	case EMFILE:
		str = "too many files (m)";
		break;
	case EMLINK:
		str = "too many links";
		break;
	case ENAMETOOLONG:
		str = "name is too long";
		break;
	case ENFILE:
		str = "too many files (n)";
		break;
	case ENODEV:
		str = "not a valid device";
		break;
	case ENOENT:
		str = "no entry";
		break;
	case ENOEXEC:
		str = "not executable";
		break;
	case ENOLCK:
		str = "no locks";
		break;
	case ENOMEM:
		str = "not enough memory";
		break;
	case ENOSPC:
		str = "device full";
		break;
	case ENOSYS:
		str = "no such system call";
		break;
	case ENOTBLK:
		str = "not a block device";
		break;
	case ENOTDIR:
		str = "not a directory";
		break;
	case ENOTEMPTY:
		str = "directory is not empty";
		break;
	case ENOTTY:
		str = "not a tty";
		break;
	case ENXIO:
		str = "nonexistant I/O";
		break;
	case EPERM:
		str = "no permission";
		break;
	case EPIPE:
		str = "pipe";
		break;
	case ERANGE:
		str = "range error";
		break;
	case EROFS:
		str = "filesystem is read-only";
		break;
	case ESPIPE:
		str = "can't seek on a pipe";
		break;
	case ESRCH:
		str = "not found";
		break;
	case ETXTBSY:
		str = "text busy";
		break;
	case EXDEV:
		str = "can't link across devices";
		break;
	default:
		str = buf;
		sprintf(buf, "unknown error code %i", err);
		break;
	}
	if (s != NULL && *s != '\0')
	{
		fprintf(stderr, "%s: %s\n", s, str);
	}
	return (char *)str;
}

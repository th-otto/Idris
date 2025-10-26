#include <std.h>
#include <stdio.h>
#include <fcntl.h>
#include <string.h>
#include <socket.h>
#include <errno.h>
#include <sys/stat.h>
#include <unistd.h>
#include "gem_vdiP.h"

struct stat_has_wrong_size { unsigned int dummy: sizeof(struct stat) == 40 ? 1 : -1; };


#ifdef _IDRIS
typedef int socklen_t; /* FIXME: belongs to socket.h */
#endif

#define HOSTNAME "atarist"

static char socket_devname[] = "/dev/socket/sockxx";

int socket(int domain, int type, int protocol)
{
	register int i;
	register int fd;
	
	UNUSED(domain);
	UNUSED(type);
	UNUSED(protocol);
	for (i = 0; i < 32; i++)
	{
		socket_devname[16] = i / 10 + '0';
		socket_devname[17] = i % 10 + '0';
		if ((fd = open(socket_devname, O_RDWR)) >= 0)
			return fd;
	}
	/* FIXME: should set errno */
	return -1;
}


static int socket_ioctl(int fd, long cmd, unsigned long value)
{
	struct soc_req arg;
	
	arg.command = cmd;
	arg.value = value;
	if (ioctl(fd, SOC_IOCTL, &arg) < 0)
		return -1;
	if (arg.value != 0)
	{
		errno = ENXIO;
		return -1;
	}
	return 0;
}


/* BUG: was originally declared as unsigned */
static int create_unix_sock(register const struct sockaddr *address)
{
	struct stat st;
	register int fd;
	
	if (address->sa_family != AF_UNIX)
	{
		errno = ENXIO;
		return -1;
	}
	if (stat(((const struct sockaddr_un *)address)->sun_path, &st) < 0)
	{
		if ((fd = creat(((const struct sockaddr_un *)address)->sun_path, 0666)) < 0)
		{
			errno = ENXIO;
			return -1;
		}
		close(fd);
		if (stat(((const struct sockaddr_un *)address)->sun_path, &st) < 0)
		{
			errno = ENXIO;
			return -1;
		}
	}
	return st.st_ino;
}


int bind(int socket, const struct sockaddr *address, socklen_t address_len)
{
	int ino;
	
	UNUSED(address_len);
	if ((ino = create_unix_sock(address)) < 0)
		return -1;
	return socket_ioctl(socket, SOC_BIND, ino);
}


int listen(int socket, int backlog)
{
	return socket_ioctl(socket, SOC_LISTEN, backlog);
}


int connect(register int socket, const struct sockaddr *address, socklen_t address_len)
{
	register int ino;
	register int i;
	register int fd;
	
	UNUSED(address_len);
	if ((ino = create_unix_sock(address)) < 0)
		return -1;
	for (i = 0; i < 10; i++)
	{
		if ((fd = socket_ioctl(socket, SOC_CONNECT, ino)) >= 0)
		{
			/* BUG: socket_ioctl() only returns 0/-1 */
			return fd;
		}
		sleep(5);
	}
	return fd;
}


int accept(int sockfd, struct sockaddr *address, socklen_t *address_len)
{
	int fd;
	
	UNUSED(address_len);
	UNUSED(address); /* BUG: unused */
	/* originally did not pass any arguments to socket() */
	if ((fd = socket(AF_UNIX, SOCK_STREAM, 0)) < 0)
		return -1;
	if (socket_ioctl(sockfd, SOC_ACCEPT, fd) < 0)
	{
		int save_errno;
		
		save_errno = errno;
		close(fd);
		errno = save_errno;
		return -1;
	}
	return fd;
}


long Recv_Message(int fd, void *buf, long count)
{
	return read(fd, buf, count);
}


long Send_Message(int fd, const void *buf, long count)
{
	return write(fd, buf, count);
}


int Close_Message(int fd)
{
	return close(fd);
}


long _XFIONREAD(int fd)
{
	long size;
	
	if (ioctl(fd, FIONREAD, &size) < 0)
		return -1;
	return size;
}


int gethostname(register char *name, register size_t len)
{
	strncpy(name, HOSTNAME, len - 1);
	name[len] = '\0'; /* BUG: len includes terminating zero */
	/* BUG: originally no return value */
	return 0;
}


struct hostent *gethostbyname(const char *name)
{
	static struct hostent ent;
	static char *aliases[] = { HOSTNAME, 0 };
	static char *addr_list[] = { "0123456789", 0 };
	
	UNUSED(name);
	ent.h_name = HOSTNAME;
	ent.h_aliases = aliases;
	ent.h_addrtype = AF_UNIX;
	ent.h_length = 10; /* ??? */
	ent.h_addr_list = addr_list;

	return &ent;
}


int getpeername(int sockfd, struct sockaddr *addr, socklen_t *addrlen)
{
	UNUSED(sockfd);
	*addrlen = sizeof(*addr); /* BUG: should be sizeof(struct sockaddr_un) */
	addr->sa_family = AF_UNIX;
	return 0;
}


int setsockopt(int sockfd, int level, int optname, const void *optval, socklen_t optlen)
{
	/* DUMMY */
	UNUSED(sockfd);
	UNUSED(level);
	UNUSED(optname);
	UNUSED(optval);
	UNUSED(optlen);
	return 0;
}


#undef htons
unsigned short htons(unsigned short hostshort)
{
	return hostshort;
}


#undef htonl
unsigned long htonl(unsigned long hostlong)
{
	return hostlong;
}

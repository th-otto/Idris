#include <std.h>
#include <unistd.h>
#include <msg.h>

int sdclose(int fd)
{
	return close(fd);
}

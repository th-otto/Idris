#include <std.h>
#include <unistd.h>
#include <fcntl.h>
#include <msg.h>

int sdpalloc(const char *filename, size_t start, size_t size)
{
	return sdcreate(filename, NULL, start, size);
}

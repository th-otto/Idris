#include <std.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>


void crash_and_burn(const char *msg)
{
	write(STDOUT, "\r\n<--(", 6);
	write(STDOUT, msg, strlen(msg));
	write(STDOUT, ")-->\r\n", 6);
	sleep(5);
	exit(1);
}

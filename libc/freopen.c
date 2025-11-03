#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include "libc.h"


FILE *freopen(const char *pathname, const char *mode, register FILE *stream)
{
	register char *p;
	register int fd;
	register int xtype;
	register int type;
	
	if (stream != NULL)
		_doclose(stream, FALSE);
	if ((type = _parstype(mode)) == -1)
		return NULL;
	xtype = type;
	if ((p = strchr(mode, ',')) != NULL)
	{
		xtype |= O_XTYPE;
		p++;
	}
	if (p != NULL)
	{
		fd = open(pathname, xtype, 0666, p);
	} else
	{
		xtype &= ~O_XTYPE;
		fd = open(pathname, xtype, 0666);
	}
	if (fd < 0)
		return NULL;
	return _finit(stream, fd, xtype | (stream ? O_REUSE : 0));
}

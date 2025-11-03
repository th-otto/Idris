#include <std.h>
#include <pcdecl.h>
#include <stdio.h>
#include <stdarg.h>
#include <signal.h>
#include "libc.h"

size_t getl(void *arg, register char *s, BYTES n)
{
	register FILE *pf = arg;
	size_t count;
	unsigned char c;
	long nread;

	if (pf == NULL)
	{
		_raise(NULL, &_fioerr);
	} else if (!(pf->flag & _FIOX010) && !_chkio(pf, FALSE))
	{
		_raise(NULL, &_reaerr);
	}
	if (pf->flag & _FIOUNBUFFERED)
	{
		count = 0;
		while (count < n)
		{
			if ((nread = _doread(pf, &c, 1)) < 0)
			{
				_raise(NULL, &_reaerr);
			} else if (nread != 0)
			{
				*s++ = c;
				count++;
				if (c == '\n')
					break;
			} else
			{
				break;
			}
		}
		return count;
	}
	count = 0;
	for (;;)
	{
		if (pf->nleft == 0)
		{
			pf->nleft = _doread(pf, pf->pnext = pf->buf, pf->bufsize);
			if (pf->nleft < 0)
				_raise(NULL, &_reaerr);
		}
		if (pf->nleft <= 0)
		{
			pf->nleft = -1;
			pf->flag |= _FIOEOF;
			return 0;
		}
		while (count < n && pf->nleft > 0)
		{
			count++;
			pf->nleft--;
			*s = *(pf->pnext++);
			if (*s == '\n')
				return count;
			s++;
		}
		if (count >= n)
			return count;
	}
}

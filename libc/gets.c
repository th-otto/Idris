#include <stdio.h>
#include <signal.h>
#include "libc.h"


/*
 * get a text line from input buffer stdin
 */
char *gets(register char *s)
{
	register FILE *fp = stdin;
	register char *dst;
	register long nread;
	unsigned char c;
	
	if (fp == NULL)
	{
		_raise(NULL, &_filerr);
	} else if (!(fp->flag & _FIOWASREAD) && !_chkio(fp, FALSE))
	{
		return NULL;
	}
	if (fp->flag & _FIOUNBUFFERED)
	{
		dst = s;
		for (;;)
		{
			if ((nread = _doread(fp, &c, 1)) < 0)
				return NULL;
			if (nread == 0 || c == '\n')
			{
				if (dst == s)
					return NULL;
				break;
			}
			*dst++ = c;
		}
		*dst = '\0';
		return s;
	}
	dst = s;
	for (;;)
	{
		if (fp->nleft == 0)
		{
			fp->nleft = _doread(fp, fp->pnext = fp->buf, fp->bufsize);
			if (fp->nleft < 0)
				return NULL;
		}
		if (fp->nleft <= 0)
		{
			fp->nleft = -1;
			fp->flag |= _FIOEOF;
			if (dst == s)
				return NULL;
			*dst = '\0';
			return s;
		}
		while (fp->nleft > 0)
		{
			--fp->nleft;
			*dst = *fp->pnext++;
			if (*dst == '\n')
			{
				*dst = '\0';
				return s;
			}
			dst++;
		}
	}
}

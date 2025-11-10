#include <stdio.h>
#include <signal.h>
#include "libc.h"


/*
 * input of string
 */
char *fgets(char *s, register int n, register FILE *fp)
{
	register char *dst;
	register long nread;
	unsigned char c;
	register int i;

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
		for (i = 0; i < n - 1; )
		{
			if ((nread = _doread(fp, &c, 1)) < 0)
				return NULL;
			if (nread == 0)
				break;
			*dst++ = c;
			i++;
			if (c == '\n')
				break;
		}
		if (dst == s)
			return NULL;
		*dst = '\0';
		return s;
	}
	dst = s;
	i = 0;
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
		while (i < n - 1 && fp->nleft > 0)
		{
			++i;
			--fp->nleft;
			c = *fp->pnext++;
			*dst++ = c;
			if (c == '\n')
			{
				*dst = '\0';
				return s;
			}
		}
		if (i >= n - 1)
		{
			*dst = '\0';
			return s;
		}
	}
}

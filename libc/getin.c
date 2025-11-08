#include <std.h>
#include <pcdecl.h>
#include <wslxa.h>
#include <unistd.h>
#include "libc.h"

#undef FILENAME_MAX
#define FILENAME_MAX 64

struct arg {
	struct arg *link;
	char *str;
};

/*
 * build ac and av list from STDIN
 */
BOOL getin(unsigned int *pac, char ***pav)
{
	register char *bufptr;
	register struct arg *arg;
	register char *quote;
	register unsigned int i;
	register struct arg **prev;
	register char **newav;
	int done;
	BOOL ret;
	short nread;
	struct arg *root;
	char buf[FILENAME_MAX + 8];
	char **av;
	
	ret = TRUE;
	root = NULL;
	prev = &root;
	if (*pac != 0)
	{
		i = *pac;
		av = *pav;
		while (i != 0)
		{
			arg = _alloc(sizeof(*arg), NULL);
			*prev = arg;
			arg->str = *av;
			prev = &arg->link;
			i--;
			av++;
		}
	}
	quote = NULL;
	done = 0;
	while (done == 0)
	{
		for (i = 0, bufptr = buf; i < FILENAME_MAX && (nread = read(STDIN, bufptr, 1)) > 0; i++, bufptr++)
		{
			if (*bufptr == '"' || *bufptr == '\'')
			{
				if (quote == NULL)
				{
					quote = bufptr;
				} else if (*bufptr == *quote)
				{
					while (quote <= bufptr)
					{
						quote[0] = quote[1];
						quote++;
					}
					i -= 2;
					bufptr -= 2;
					quote = NULL;
				}
			} else if (*bufptr == '\n' || (quote == NULL && (*bufptr <= ' ' || *bufptr >= 0x7f)))
			{
				quote = NULL;
				break;
			}
		}
		done = nread <= 0;
		if (i != 0)
		{
			if (i == FILENAME_MAX)
			{
				buf[FILENAME_MAX - 1] = '\0';
				ret = _remark("argument too long: ", buf);
				bufptr = buf;
				while ((nread = read(STDIN, bufptr, 1)) > 0 && *bufptr != '\n')
				{
				}
				quote = NULL;
				done = nread <= 0;
			} else
			{
				arg = _alloc(sizeof(*arg), NULL);
				*prev = arg;
				prev = &arg->link;
				buf[i] = '\0';
				arg->str = buybuf(buf, i + 1);
				++(*pac);
			}
		}
	}
	
	newav = _alloc(*pac * sizeof(char *) + sizeof(char *), NULL);
	*pav = newav;
	arg = root;
	while (arg != NULL)
	{
		*newav++ = arg->str;
		arg = _free(arg, arg->link);
	}
	*newav = NULL;
	return ret;
}

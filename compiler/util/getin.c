#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "util.h"

#undef FILENAME_MAX
#define FILENAME_MAX 1024

struct arg {
	struct arg *next;
	char *str;
};

/*
 * build ac and av list from STDIN
 */
BOOL getin(int *pac, char ***pav)
{
	char *bufptr;
	struct arg *arg;
	char *quote;
	unsigned int i;
	struct arg **prev;
	char **newav;
	int done;
	BOOL ret;
	int c;
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
			arg = xmalloc(sizeof(*arg));
			*prev = arg;
			arg->next = NULL;
			arg->str = *av;
			prev = &arg->next;
			i--;
			av++;
		}
	}
	quote = NULL;
	done = 0;
	while (done == 0)
	{
		for (i = 0, bufptr = buf; i < FILENAME_MAX && (c = fgetc(stdin)) != EOF; i++, bufptr++)
		{
			*bufptr = c;
			if (c == '"' || c == '\'')
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
			} else if (c == '\n' || (quote == NULL && (c <= ' ' || c >= 0x7f)))
			{
				quote = NULL;
				break;
			}
		}
		done = c <= 0;
		if (i != 0)
		{
			if (i == FILENAME_MAX)
			{
				buf[FILENAME_MAX - 1] = '\0';
				ret = _remark("argument too long: ", buf);
				bufptr = buf;
				while ((c = fgetc(stdin)) != EOF && c != '\n')
				{
				}
				quote = NULL;
				done = c <= 0;
			} else
			{
				arg = xmalloc(sizeof(*arg));
				*prev = arg;
				arg->next = NULL;
				prev = &arg->next;
				buf[i] = '\0';
				arg->str = xmalloc(i + 1);
				strcpy(arg->str, buf);
				++(*pac);
			}
		}
	}
	
	newav = xmalloc(*pac * sizeof(char *) + sizeof(char *));
	*pav = newav;
	arg = root;
	while (arg != NULL)
	{
		struct arg *next;
		*newav++ = arg->str;
		next = arg->next;
		free(arg);
		arg = next;
	}
	*newav = NULL;
	return ret;
}

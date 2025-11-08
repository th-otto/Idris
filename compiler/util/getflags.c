#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>
#include "util.h"


int usage(const char *msg)
{
	fprintf(stderr, "usage: %s %s", _pname, msg ? msg : "");
	if (msg != NULL && msg[strlen(msg) - 1] == '\n')
		exit(1);
	return strlen(_pname) + 8;
}


static int charout(int c, int len)
{
	if (len > 60 && (c == ' ' || c == '\t'))
	{
		fputs("\n\t", stderr);
		return 4;
	} else
	{
		fputc(c, stderr);
		return ++len;
	}
}


static int doesc(char **pp)
{
	char *p;
	int pos;
	int val;
	int c;

	p = (++*pp);
	switch (*p)
	{
		case 0: return **pp;
		case 'a': *pp = p; return '\a';
		case 'b': *pp = p; return '\b';
		case 'f': *pp = p; return '\f';
		case 'n': *pp = p; return '\n';
		case 'r': *pp = p; return '\r';
		case 't': *pp = p; return '\t';
		case 'v': *pp = p; return '\v';
	}
	if (*p == 'x')
	{
		p++;
		val = 0;
		pos = 0;
		while (pos < 3)
		{
			if (*p >= '0' && *p <= '9')
			{
				c = *p - '0';
			} else if (*p >= 'a' && *p <= 'f')
			{
				c = *p - 'a' + 10;
			} else if (*p >= 'A' && *p <= 'F')
			{
				c = *p - 'A' + 10;
			} else
			{
				break;
			}
			val = (val << 4) | c;
			p++;
			pos++;
		}
		*pp = p - 1;
		return val;
	} else if (*p >= '0' && *p <= '7')
	{
		val = 0;
		pos = 0;
		while (*p >= '0' && *p <= '7' && pos < 3)
		{
			val = (val << 3) | (*p - '0');
			p++;
			pos++;
		}
		*pp = p - 1;
		return val;
	} else
	{
		*pp = p;
		return *p;
	}
}


static void showhelp(const char *s, const char *fmt)
{
	int len;
	
	len = usage(NULL);
	while (*s != '\0')
	{
		if (*s != 'F')
		{
			len = charout(*s, len);
		} else
		{
			fputs("+[", stderr);
			len += 2;
			while (*fmt != ':')
			{
				if (fmt[0] == ',' && fmt[1] != ':')
				{
					len = charout(' ', len);
				} else if (*fmt == '>')
				{
					fputs("^", stderr);
					len += 1;
					if (fmt[1] != ':')
						len = charout(' ', len);
				} else
				{
					fputc(*fmt, stderr);
					len += 1;
				}
				fmt++;
			}
			fputs("]", stderr);
			len += 1;
		}
		s++;
	}
	fputs("\n", stderr);
	exit(1);
}


#define TYPE_NONE 0
#define TYPE_INT  1
#define TYPE_LONG 2
#define TYPE_STR  3

struct arg {
	unsigned int ntop;
	union {
		int ival[20];
		long lval[20];
		char *sval[20];
	} u;
};


char *getflags(int *pac, char ***pav, const char *_fmt, ...)
{
	const char *fmtscan;
	char *arg;
	char *argscan;
	int found;
	char *colon;
	union {
		char *s;
		unsigned int c;
		unsigned int u;
		unsigned long l;
	} val;
	long ival;
	char *esc;
	int type;
	const char *fmt;
	char *end;

	fmt = _fmt;
	++(*pav);
	for (;; ++(*pav))
	{
		if (*pac == 0 || --(*pac) == 0)
			break;
		arg = **pav;
		if (strcmp(arg, "--") == 0)
		{
			--(*pac);
			++(*pav);
			break;
		}
		if (strcmp(arg, "-") == 0)
			break;
		if (*arg != '-' && *arg != '+')
			break;
		if (*arg == '-')
			arg++;
		if (strncmp(arg, "help", 4) == 0)
		{
			colon = strchr(fmt, ':');
			if (colon == NULL && arg[4] != ':')
				return arg;
			showhelp(colon + 1, fmt);
		}
		while (*arg != '\0')
		{
			va_list args;
			va_start(args, _fmt);

			type = TYPE_NONE;
			val.s = 0;
			argscan = arg;
			fmtscan = fmt;
			for (found = 0; found == 0; fmtscan++)
			{
				switch (*fmtscan)
				{
				case '*':
					type = TYPE_STR;
					val.s = *argscan != '\0' ? argscan : --(*pac) != 0 ? *(++*pav) : argscan;
					esc = argscan = val.s;
					while (*esc != '\0')
					{
						*argscan++ = *esc == '\\' ? doesc(&esc) : *esc;
						esc++;
					}
					*argscan = '\0';
					break;
				case '?':
					type = TYPE_INT;
					if (*argscan != '\\')
					{
						val.c = *argscan;
					} else
					{
						esc = argscan;
						val.c = doesc(&esc);
						argscan = esc;
					}
					val.c &= 0xff;
					if (*argscan != '\0')
						++argscan;
					break;
				case '#':
					if (*argscan == '\0')
						argscan = --(*pac) != 0 ? *(++*pav) : argscan;
					ival = strtol(argscan, &end, 0);
					argscan = end;
					if (*argscan != '\0')
					{
						fmtscan = strchr(fmtscan, ':') - 1;
						type = TYPE_NONE;
					} else if (fmtscan[1] == '#')
					{
						++fmtscan;
						val.l = ival;
						type = TYPE_LONG;
					} else
					{
						val.u = ival;
						type = TYPE_INT;
					}
					break;
				case '\0':
				case ',':
				case ':':
					if (type != TYPE_NONE)
					{
						switch (type)
						{
						case TYPE_INT:
							*va_arg(args, int *) = val.c;
							break;
						case TYPE_LONG:
							*va_arg(args, long *) = val.c;
							break;
						case TYPE_STR:
							*va_arg(args, char **) = val.s;
							break;
						}
						arg = argscan;
						found = 1;
					} else
					{
						if (*fmtscan == '\0')
							return arg;
						if (*fmtscan == ':')
						{
							showhelp(++fmtscan, fmt);
						} else
						{
							va_arg(args, void *);
							argscan = arg;
						}
					}
					break;
				case '>':
					if (type == TYPE_NONE)
					{
						va_arg(args, void *);
						argscan = arg;
					} else
					{
						struct arg *varg = va_arg(args, struct arg *);
						if (varg->ntop == 0)
						{
							colon = strchr(fmtscan, ':');
							if (colon != NULL)
								showhelp(colon + 1, fmt);
							else
								return arg;
						} else
						{
							switch (type)
							{
							case TYPE_INT:
								varg->u.ival[--varg->ntop] = val.u;
								break;
							case TYPE_LONG:
								varg->u.lval[--varg->ntop] = val.l;
								break;
							case TYPE_STR:
								varg->u.sval[--varg->ntop] = val.s;
								break;
							}
							arg = argscan;
							found = 1;
						}
					}
					break;
				default:
					if (*fmtscan == *argscan)
					{
						type = TYPE_INT;
						val.c = 1;
						argscan++;
					} else
					{
						type = TYPE_NONE;
						while (*fmtscan != '\0' && *fmtscan != ',' && *fmtscan != '>' && *fmtscan != ':')
							fmtscan++;
						fmtscan--;
					}
					break;
				}
			}
			va_end(args);
		}
	}
	return NULL;
}

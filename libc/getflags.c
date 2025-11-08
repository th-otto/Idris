#include <wslxa.h>
#include <stdarg.h>
#include <unistd.h>
#include <stdlib.h>


extern char _data[];

static int charout(int fd, const char *s, int len);

static void showhelp(const char *s, const char *fmt)
{
	register int len;
	
	len = usage(NULL);
	while (*s != '\0')
	{
		if (*s != 'F')
		{
			len = charout(STDERR, s, len);
		} else
		{
			len += write(STDERR, "+[", 2);
			while (*fmt != ':')
			{
				if (fmt[0] == ',' && fmt[1] != ':')
				{
					len = charout(STDERR, " ", len);
				} else if (*fmt == '>')
				{
					len += write(STDERR, "^", 1);
					if (fmt[1] != ':')
						len = charout(STDERR, " ", len);
				} else
				{
					len += write(STDERR, fmt, 1);
				}
				fmt++;
			}
			len += write(STDERR, "]", 1);
		}
		s++;
	}
	write(STDERR, "\n", 1);
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

char *getflags(unsigned int *pac, char ***pav, const char *_fmt, ...)
{
	register const char *fmtscan;
	register char *arg;
	register char *argscan;
	register void **args;
	int found;
	short colon;
	union {
		char *s;
		unsigned int c;
		unsigned int u;
		unsigned long l;
	} val;
	long ival;
	char *esc;
	register int type;
	register const char *fmt;
	
	fmt = _fmt;
	++(*pav);
	for (;; ++(*pav))
	{
		if (*pac == 0 || --(*pac) == 0)
			break;
		arg = **pav;
		if (_cmpstr(arg, "--"))
		{
			--(*pac);
			++(*pav);
			break;
		}
		if (_cmpstr(arg, "-"))
			break;
		if (*arg != '-' && *arg != '+')
			break;
		if (*arg == '-')
			arg++;
		if (_cmpbuf(arg, "help", 4))
		{
			colon = _scnstr(fmt, ':');
			if (fmt[colon] == '\0' && arg[4] != ':')
				return arg;
			/* _data points to the copyright message in the startup module */
			showhelp((arg[4] != ':' ? &fmt[colon] : _data) + 1, fmt);
		}
		while (*arg != '\0')
		{
#ifdef __GNUC__
			void *_args;
			va_start(_args, _fmt);
			args = _args;
#else
			args = (void **)&_fmt + 1;
#endif
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
						*argscan++ = *esc == '\\' ? doesc(&esc, NULL) : *esc;
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
						val.c = doesc(&esc, NULL);
						argscan = esc;
					}
					val.c &= 0xff;
					if (*argscan != '\0')
						++argscan;
					break;
				case '#':
					if (*argscan == '\0')
						argscan = --(*pac) != 0 ? *(++*pav) : argscan;
					argscan += _btol(argscan, _lenstr(argscan), &ival, 1);
					if (*argscan != '\0')
					{
						fmtscan += _scnstr(fmtscan, ':') - 1;
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
							*((int *)*args) = val.c;
							break;
						case TYPE_LONG:
							*((long *)*args) = val.c;
							break;
						case TYPE_STR:
							*((char **)*args) = val.s;
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
							args++;
							argscan = arg;
						}
					}
					break;
				case '>':
					if (type == TYPE_NONE)
					{
						args++;
						argscan = arg;
					} else
					{
						if ((((struct arg *)*args))->ntop == 0)
						{
							colon = _scnstr(fmtscan, ':');
							if (fmtscan[colon] != '\0')
								showhelp(fmtscan + colon + 1, fmt);
							else
								return arg;
						} else
						{
							switch (type)
							{
							case TYPE_INT:
								(((struct arg *)*args))->u.ival[--(((struct arg *)*args))->ntop] = val.u;
								break;
							case TYPE_LONG:
								(((struct arg *)*args))->u.lval[--(((struct arg *)*args))->ntop] = val.l;
								break;
							case TYPE_STR:
								(((struct arg *)*args))->u.sval[--(((struct arg *)*args))->ntop] = val.s;
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
		}
	}
	return NULL;
}


static int charout(int fd, const char *s, int len)
{
	if (len > 60 && (*s == ' ' || *s == '\t'))
	{
		write(fd, "\n\t", 2);
		return 4;
	} else
	{
		write(fd, s, 1);
		return ++len;
	}
}

/*	P1PR SUBROUTINES
 *
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "int012.h"
#include "int12.h"
#include "util.h"
#include "int2p.h"

/* name byte table */

static const char *nmbtab[] = { NULL, "NMDAT: ", "NMLIT: ", "NMBSS: ", "NMFUN: ", "NMFRD: ", "NMFRS: ", NULL };

/*	get an integer
 */
void gint(long *l)
{
	int i;
	char *s = (char *) l;

	for (i = 0; i < (int)sizeof(long); ++i)
		*s++ = needch();
}

/*	get a label
 */
LABEL glabel(void)
{
	char *p;
	LABEL l;

	p = (char *)&l;
	*p++ = needch();
	*p = needch();
	return l;
}

/*	get a name
 */
char *gname(char *s)
{
	size_t i;
	size_t n;
	char *ss;
	static char nm[LENNAME + 8];

	nm[0] = '\0';
	n = needch();
	if (!s)
		s = nm;
	ss = s;
	if ((i = glabel()) != 0)
	{
		for (*ss++ = '>'; i; ++ss)
		{
			*ss = (i & 07) + '0';
			i >>= 3;
		}
		*ss = '\0';
	}
	if (n)
	{
		n -= 1;
		i = needch();
		if (i & NMFAR)
			strcat(ss, "NMFAR: ");
		if (i & NMVAL)
			strcat(ss, nmbtab[i & 07]);
		ss += strlen(ss);
		*ss++ = '<';
		for (; n; --n)
		{
			*ss++ = needch();
		}
		*ss++ = '\0';
	}
	return s;
}

/*	make a name from label
 */
char *lbn(LABEL label)
{
	char *s;
	static char name[LENNAME + 1];

	name[0] = '>';
	for (s = name + 1; label; ++s)
	{
		*s = (label & 07) + '0';
		label >>= 3;
	}
	*s = '\0';
	return name;
}

/*	need a character
 */
LEX needch(void)
{
	LEX c;

	if ((c = fgetc(infd)) == EOF)
	{
		panic("EOF");
	}
	return c;
}

/*	put a panic error message
 */
void panic(const char *s)
{
	fprintf(errfd, "PANIC %s!\n", s);
	exit(1);
}

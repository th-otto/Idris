/*	RETURN UNIQUE FILENAME
 *	copyright (c) 1981, 1985 by Whitesmiths, Ltd.
 */
#include <std.h>
#include <wslxa.h>
#include <unistd.h>

/*
 * create a unique file name
 */
char *uniqnm(void)
{
	FAST COUNT i, pid;
	static char name[] = "/tmp/tpppp";

	if (name[6] == 'p')
		for (pid = getpid(), i = 11; 6 <= --i; pid >>= 3)
			name[i] = (pid & 07) + '0';
	return (name);
}

/*	ECHO ARGUMENTS TO STDOUT
 *	copyright (c) 1980, 1985 by Whitesmiths, Ltd.
 */
#include <wslxa.h>

/*	flags:
	-m		output newline between arguments
	-n		do not put newline at end of arguments
 */
BOOL mflag = NO;
BOOL nflag = NO;

const char *_pname = "echo";

/*	output args separated by space or newline
 */
int main(BYTES ac, TEXT **av)
{
	FAST COUNT n;
	FAST COUNT ns;
	FAST COUNT nw;
	const char *between;

	getflags(&ac, &av, "m,n:F <args>", &mflag, &nflag);
	if (!ac)
		return 0;
	between = mflag ? "\n" : " ";
	for (nw = 0, ns = 0; ac; --ac, ++av)
	{
		if (nw)
		{
			nw += write(STDOUT, between, 1);
			++ns;
		}
		nw += write(STDOUT, *av, n = lenstr(*av));
		ns += n;
	}
	if (!nflag)
	{
		nw += write(STDOUT, "\n", 1);
		++ns;
	}
	return nw == ns ? 0 : 1;
}

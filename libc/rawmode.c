/*	QUERY/SET FILE MODE
 *	copyright (c) 1985 by Whitesmiths, Ltd.
 */
#include <std.h>
#include <sys/stat.h>
#include <termio.h>
#include <pcdecl.h>

COUNT _rawmode(FD fd, COUNT nmode)
{
	FAST COUNT omode;
	struct stat sbuf;
	struct sgtty tbuf;

	if (fstat(fd, &sbuf) < 0)
		return (R_QUERY);
	if (!S_ISDEV(sbuf.st_mode))
		omode = R_QUERY;
	else if (gtty(fd, &tbuf) < 0)
		return (R_QUERY);
	else if ((tbuf.t_mode & M_RAW) || (tbuf.t_mode & M_RARE))
		omode = R_RAW;
	else
		omode = R_COOKED;
	if (nmode != R_QUERY && omode != R_QUERY && omode != nmode)
	{
		if (nmode == R_RAW)
		{
			tbuf.t_mode |= M_RAW;
			tbuf.t_mode &= ~M_ECHO;
		}
		else
		{
			tbuf.t_mode &= ~M_RAW;
			tbuf.t_mode |= M_ECHO;
		}
		stty(fd, &tbuf);
	}
	return (omode);
}



#include <stdio.h>
#include "estruct.h"
#include "edef.h"

typedef struct {
	unsigned short t_speeds;
	char t_erase, t_kill;
	unsigned short t_mode;
	} SGTTY;

#define S_IREADY  0x0080
#define M_ECHO      0010
#define M_RAW       0040
#define M_CRMOD     0020


SGTTY ostate;
SGTTY nstate;

ttopen()
{
	/* on all screens we are not sure of the initial position
	   of the cursor					*/
	ttrow = 999;
	ttcol = 999;
	gtty(0, &ostate);
	gtty(0, &nstate);
	nstate.t_mode |= M_RAW;
	nstate.t_mode &= ~(M_ECHO|M_CRMOD);
	stty(0,&nstate);
}

ttclose()
{
	stty(0, &ostate);
}

ttputc(c)
{
	fputc(c, stdout);
}

ttflush()
{
	fflush(stdout);
}

ttgetc()
{
	return(127 & fgetc(stdin));
}

typahead()
{
	SGTTY buf;

	return (gtty(0, &buf) == 0 && (buf.t_speeds & S_IREADY));
}

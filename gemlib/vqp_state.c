#include "gem_vdiP.h"

void vqp_state(short handle, short *port, short *lightness, short *interlace, short *planes, short *indexes, register char *film_name)
{
	register short i;
	
	V_OPCODE = 5;
	V_NPTSIN = 0;
	V_NINTIN = 2;
	V_SUBCODE = 92;
	V_HANDLE = handle;
	vdi();
	*port = intout[0];
	*lightness = intout[1];
	*interlace = intout[2];
	*planes = intout[3];
	*indexes = intout[4];
	for (i = 5; i < V_NINTOUT; i++)
		*film_name++ = intout[i];
}

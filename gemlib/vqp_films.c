#include "gem_vdiP.h"

void vqp_films(short handle, register char *film_names)
{
	register short i;

	V_OPCODE = 5;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 91;
	V_HANDLE = handle;
	vdi();
	for (i = 0; i < V_NINTOUT; i++)
		film_names[i] = intout[i];
}

#include "gem_vdiP.h"

void vsp_state(short handle, short port, short film_num, short lightness, short interlace, short planes, short *indexes)
{
	short i;

	intin[0] = port;
	intin[1] = film_num;
	intin[2] = lightness;
	intin[3] = interlace;
	intin[4] = planes;
	for (i = 5; i < 21; i++)
		intin[i] = *indexes++;
	
	V_OPCODE = 5;
	V_NPTSIN = 0;
	V_NINTIN = 21;
	V_SUBCODE = 93;
	V_HANDLE = handle;
	vdi();
}

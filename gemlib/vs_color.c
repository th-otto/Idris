#include "gem_vdiP.h"

void vs_color(short handle, short index, short *rgb_in)
{
	intin[0] = index;
	intin[1] = *rgb_in++;
	intin[2] = *rgb_in++;
	intin[3] = *rgb_in;
	V_OPCODE = 14;
	V_NPTSIN = 0;
	V_NINTIN = 4;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
}

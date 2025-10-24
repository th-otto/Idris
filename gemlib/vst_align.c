#include "gem_vdiP.h"

void vst_alignment(short handle, short hor_in, short vert_in, short *hor_out, short *vert_out)
{
	intin[0] = hor_in;
	intin[1] = vert_in;
	V_OPCODE = 39;
	V_NPTSIN = 0;
	V_NINTIN = 2;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	*hor_out = intout[0];
	*vert_out = intout[1];
}

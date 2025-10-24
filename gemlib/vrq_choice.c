#include "gem_vdiP.h"

void vrq_choice(short handle, short ch_in, short *ch_out)
{
	intin[0] = ch_in;
	V_OPCODE = 30;
	V_NPTSIN = 0;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	*ch_out = intout[0];
}

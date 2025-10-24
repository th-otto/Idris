#include "gem_vdiP.h"

void vrq_valuator(short handle, short valuator_in, short *valuator_out, short *terminator)
{
	intin[0] = valuator_in;
	V_OPCODE = 29;
	V_NPTSIN = 0;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	*valuator_out = intout[0];
	*terminator = intout[1];
}

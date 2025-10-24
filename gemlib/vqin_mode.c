#include "gem_vdiP.h"

void vqin_mode(short handle, short dev_type, short *input_mode)
{
	intin[0] = dev_type;
	V_OPCODE = 115;
	V_NPTSIN = 0;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	*input_mode = intout[0];
}

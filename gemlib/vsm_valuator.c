#include "gem_vdiP.h"

void vsm_valuator(short handle, short val_in, short *val_out, short *term, short *status)
{
	intin[0] = val_in;
	V_OPCODE = 29;
	V_NPTSIN = 0;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	*val_out = intout[0];
	*term = intout[1];
	*status = V_NINTOUT;
}

#include "gem_vdiP.h"

short vsm_height(short handle, short height)
{
	ptsin[0] = 0;
	ptsin[1] = height;
	V_OPCODE = 19;
	V_NPTSIN = 1;
	V_NINTIN = 0;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	return ptsout[1];
}

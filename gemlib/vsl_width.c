#include "gem_vdiP.h"

short vsl_width(short handle, short width)
{
	ptsin[0] = width;
	ptsin[1] = 0;
	V_OPCODE = 16;
	V_NPTSIN = 1;
	V_NINTIN = 0;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	return ptsout[0];
}

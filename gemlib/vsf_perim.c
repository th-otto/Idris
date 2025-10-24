#include "gem_vdiP.h"

short vsf_perimeter(short handle, short per_vis)
{
	intin[0] = per_vis;
	V_OPCODE = 104;
	V_NPTSIN = 0;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	return intout[0];
}

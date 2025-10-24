#include "gem_vdiP.h"

short vsm_color(short handle, short color_index)
{
	intin[0] = color_index;
	V_OPCODE = 20;
	V_NPTSIN = 0;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	return intout[0];
}

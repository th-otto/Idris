#include "gem_vdiP.h"

short vst_point(short handle, short point, short *char_width, short *char_height, short *cell_width, short *cell_height)
{
	intin[0] = point;
	V_OPCODE = 107;
	V_NPTSIN = 0;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	*char_width = ptsout[0];
	*char_height = ptsout[1];
	*cell_width = ptsout[2];
	*cell_height = ptsout[3];
	return intout[0];
}

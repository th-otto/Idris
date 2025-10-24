#include "gem_vdiP.h"

void vst_height(short handle, short height, short *char_width, short *char_height, short *cell_width, short *cell_height)
{
	ptsin[0] = 0;
	ptsin[1] = height;
	V_OPCODE = 12;
	V_NPTSIN = 1;
	V_NINTIN = 0;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	*char_width = ptsout[0];
	*char_height = ptsout[1];
	*cell_width = ptsout[2];
	*cell_height = ptsout[3];
}

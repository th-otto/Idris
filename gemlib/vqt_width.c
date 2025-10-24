#include "gem_vdiP.h"

short vqt_width(short handle, unsigned char character, short *cell_width, short *left_delta, short *right_delta)
{
	intin[0] = character;
	V_OPCODE = 117;
	V_NPTSIN = 0;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	*cell_width = ptsout[0];
	*left_delta = ptsout[2];
	*right_delta = ptsout[4];
	return intout[0];
}

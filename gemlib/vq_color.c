#include "gem_vdiP.h"

short vq_color(short handle, short color_index, short set_flag, short *rgb)
{
	intin[0] = color_index;
	intin[1] = set_flag;
	V_OPCODE = 26;
	V_NPTSIN = 0;
	V_NINTIN = 2;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	rgb[0] = intout[1];
	rgb[1] = intout[2];
	rgb[2] = intout[3];
	return intout[0];
}

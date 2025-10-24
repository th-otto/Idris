#include "gem_vdiP.h"

short vst_font(short handle, short font)
{
	intin[0] = font;
	V_OPCODE = 21;
	V_NPTSIN = 0;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	return intout[0];
}

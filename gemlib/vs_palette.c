#include "gem_vdiP.h"

short vs_palette(short handle, short palette)
{
	intin[0] = palette;
	V_OPCODE = 5;
	V_NPTSIN = 0;
	V_NINTIN = 1;
	V_SUBCODE = 60;
	V_HANDLE = handle;
	vdi();
	return intout[0];
}

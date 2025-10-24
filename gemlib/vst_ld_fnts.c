#include "gem_vdiP.h"

short vst_load_fonts(short handle, short select)
{
	intin[0] = select;
	V_OPCODE = 119;
	V_NPTSIN = 0;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	return intout[0];
}

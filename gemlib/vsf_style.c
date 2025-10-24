#include "gem_vdiP.h"

short vsf_style(short handle, short style_index)
{
	intin[0] = style_index;
	V_OPCODE = 24;
	V_NPTSIN = 0;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	return intout[0];
}

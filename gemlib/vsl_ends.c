#include "gem_vdiP.h"

void vsl_ends(short handle, short beg_style, short end_style)
{
	intin[0] = beg_style;
	intin[1] = end_style;
	V_OPCODE = 108;
	V_NPTSIN = 0;
	V_NINTIN = 2;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
}

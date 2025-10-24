#include "gem_vdiP.h"

void v_show_c(short handle, short reset)
{
	intin[0] = reset;
	V_OPCODE = 122;
	V_NPTSIN = 0;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
}

#include "gem_vdiP.h"

void v_clrwk(short handle)
{
	V_OPCODE = 3;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
}

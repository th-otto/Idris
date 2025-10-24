#include "gem_vdiP.h"

void v_clswk(short handle)
{
	V_OPCODE = 2;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
}

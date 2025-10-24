#include "gem_vdiP.h"

void vsp_save(short handle)
{
	V_OPCODE = 5;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 94;
	V_HANDLE = handle;
	vdi();
}

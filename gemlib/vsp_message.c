#include "gem_vdiP.h"

void vsp_message(short handle)
{
	V_OPCODE = 5;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 95;
	V_HANDLE = handle;
	vdi();
}

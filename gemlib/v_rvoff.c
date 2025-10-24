#include "gem_vdiP.h"

void v_rvoff(short handle)
{
	V_OPCODE = 5;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 14;
	V_HANDLE = handle;
	vdi();
}

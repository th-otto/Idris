#include "gem_vdiP.h"

void v_hardcopy(short handle)
{
	V_OPCODE = 5;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 17;
	V_HANDLE = handle;
	vdi();
}

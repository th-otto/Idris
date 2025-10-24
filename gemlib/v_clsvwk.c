#include "gem_vdiP.h"

void v_clsvwk(short handle)
{
	V_OPCODE = 101;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
}

#include "gem_vdiP.h"

void v_eeos(short handle)
{
	V_OPCODE = 5;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 9;
	V_HANDLE = handle;
	vdi();
}

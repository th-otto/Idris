#include "gem_vdiP.h"

void v_curleft(short handle)
{
	V_OPCODE = 5;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 7;
	V_HANDLE = handle;
	vdi();
}

#include "gem_vdiP.h"

void v_rmcur(short handle)
{
	V_OPCODE = 5;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 19;
	V_HANDLE = handle;
	vdi();
}

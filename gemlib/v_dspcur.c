#include "gem_vdiP.h"

void v_dspcur(short handle, short x, short y)
{
	ptsin[0] = x;
	ptsin[1] = y;
	V_OPCODE = 5;
	V_NPTSIN = 1;
	V_NINTIN = 0;
	V_SUBCODE = 18;
	V_HANDLE = handle;
	vdi();
}

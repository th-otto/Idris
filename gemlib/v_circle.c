#include "gem_vdiP.h"

void v_circle(short handle, short x, short y, short radius)
{
	ptsin[0] = x;
	ptsin[1] = y;
	ptsin[2] = 0;
	ptsin[3] = 0;
	ptsin[4] = radius;
	ptsin[5] = 0;
	V_OPCODE = 11;
	V_NPTSIN = 3;
	V_NINTIN = 0;
	V_SUBCODE = 4;
	V_HANDLE = handle;
	vdi();
}

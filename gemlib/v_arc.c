#include "gem_vdiP.h"

void v_arc(short handle, short x, short y, short radius, short begang, short endang)
{
	ptsin[0] = x;
	ptsin[1] = y;
	ptsin[2] = 0;
	ptsin[3] = 0;
	ptsin[4] = 0;
	ptsin[5] = 0;
	ptsin[6] = radius;
	ptsin[7] = 0;
	intin[0] = begang;
	intin[1] = endang;
	
	V_OPCODE = 11;
	V_NPTSIN = 4;
	V_NINTIN = 2;
	V_SUBCODE = 2;
	V_HANDLE = handle;
	vdi();
}

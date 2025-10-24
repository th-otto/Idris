#include "gem_vdiP.h"

void v_ellarc(short handle, short x, short y, short xradius, short yradius, short begang, short endang)
{
	ptsin[0] = x;
	ptsin[1] = y;
	ptsin[2] = xradius;
	ptsin[3] = yradius;
	intin[0] = begang;
	intin[1] = endang;
	
	V_OPCODE = 11;
	V_NPTSIN = 2;
	V_NINTIN = 2;
	V_SUBCODE = 6;
	V_HANDLE = handle;
	vdi();
}

#include "gem_vdiP.h"

void v_ellipse(short handle, short x, short y, short xradius, short yradius)
{
	ptsin[0] = x;
	ptsin[1] = y;
	ptsin[2] = xradius;
	ptsin[3] = yradius;
	
	V_OPCODE = 11;
	V_NPTSIN = 2;
	V_NINTIN = 0;
	V_SUBCODE = 5;
	V_HANDLE = handle;
	vdi();
}

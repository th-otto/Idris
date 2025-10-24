#include "gem_vdiP.h"

void v_rfbox(short handle, short *pxyarray)
{
	vdipb.ptsin = pxyarray;
	
	V_OPCODE = 11;
	V_NPTSIN = 2;
	V_NINTIN = 0;
	V_SUBCODE = 9;
	V_HANDLE = handle;
	vdi();
	vdipb.ptsin = ptsin;
}

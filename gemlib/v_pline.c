#include "gem_vdiP.h"

void v_pline(short handle, short count, short *pxyarray)
{
	vdipb.ptsin = pxyarray;
	V_OPCODE = 6;
	V_NPTSIN = count;
	V_NINTIN = 0;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	vdipb.ptsin = ptsin;
}

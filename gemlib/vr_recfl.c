#include "gem_vdiP.h"

void vr_recfl(short handle, short *pxyarray)
{
	vdipb.ptsin = pxyarray;
	V_OPCODE = 114;
	V_NPTSIN = 2;
	V_NINTIN = 0;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	vdipb.ptsin = ptsin;
}

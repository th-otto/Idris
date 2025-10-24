#include "gem_vdiP.h"

void v_fillarea(short handle, short count, short *pxyarray)
{
	vdipb.ptsin = pxyarray;
	V_OPCODE = 9;
	V_NPTSIN = count;
	V_NINTIN = 0;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	vdipb.ptsin = ptsin;
}

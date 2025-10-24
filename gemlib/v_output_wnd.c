#include "gem_vdiP.h"

void v_output_window(short handle, short *pxyarray)
{
	vdipb.ptsin = pxyarray;
	V_OPCODE = 5;
	V_NPTSIN = 2;
	V_NINTIN = 0;
	V_SUBCODE = 21;
	V_HANDLE = handle;
	vdi();
	vdipb.ptsin = ptsin;
}

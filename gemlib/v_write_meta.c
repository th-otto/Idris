#include "gem_vdiP.h"

void v_write_meta(short handle, short num_intin, short *a_intin, short num_ptsin, short *a_ptsin)
{
	vdipb.intin = a_intin;
	vdipb.ptsin = a_ptsin;
	V_OPCODE = 5;
	V_NPTSIN = num_ptsin;
	V_NINTIN = num_intin;
	V_SUBCODE = 99;
	V_HANDLE = handle;
	vdi();
	vdipb.intin = intin;
	vdipb.ptsin = ptsin;
}

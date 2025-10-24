#include "gem_vdiP.h"

void v_opnvwk(short *work_in, short *handle, short *work_out)
{
	vdipb.intin = work_in;
	vdipb.intout = work_out;
	vdipb.ptsout = &work_out[45];
	V_OPCODE = 100;
	V_NPTSIN = 0;
	V_NINTIN = 11;
	V_SUBCODE = 0;
	V_HANDLE = *handle;
	vdi();
	*handle = V_HANDLE;
	vdipb.intin = intin;
	vdipb.intout = intout;
	vdipb.ptsout = ptsout;
	vdipb.ptsin = ptsin;
}

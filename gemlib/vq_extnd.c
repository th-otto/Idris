#include "gem_vdiP.h"

void vq_extnd(short handle, short owflag, short *work_out)
{
	vdipb.intout = work_out;
	vdipb.ptsout = &work_out[45];
	intin[0] = owflag;
	V_OPCODE = 102;
	V_NPTSIN = 0;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	vdipb.intout = intout;
	vdipb.ptsout = ptsout;
}

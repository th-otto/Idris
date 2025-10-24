#include "gem_vdiP.h"

void vs_clip(short handle, short clip_flag, short *pxyarray)
{
	intin[0] = clip_flag;
	vdipb.ptsin = pxyarray;
	V_OPCODE = 129;
	V_NPTSIN = 2;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	vdipb.ptsin = ptsin;
}

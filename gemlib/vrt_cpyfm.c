#include "gem_vdiP.h"

void vrt_cpyfm(short handle, short vr_mode, short *pxyarray, MFDB *psrcMFDB, MFDB *pdesMFDB, short *color_index)
{
	intin[0] = vr_mode;
	intin[1] = *color_index++;
	intin[2] = *color_index;
	i_lptr1(psrcMFDB);
	i_lptr2(pdesMFDB);
	vdipb.ptsin = pxyarray;
	V_OPCODE = 121;
	V_NPTSIN = 4;
	V_NINTIN = 3;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	vdipb.ptsin = ptsin;
}

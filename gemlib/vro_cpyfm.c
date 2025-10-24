#include "gem_vdiP.h"

void vro_cpyfm(short handle, short vr_mode, short *pxyarray, MFDB *psrcMFDB, MFDB *pdesMFDB)
{
	intin[0] = vr_mode;
	i_lptr1(psrcMFDB);
	i_lptr2(pdesMFDB);
	vdipb.ptsin = pxyarray;
	V_OPCODE = 109;
	V_NPTSIN = 4;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	vdipb.ptsin = ptsin;
}

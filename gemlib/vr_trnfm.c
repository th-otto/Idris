#include "gem_vdiP.h"

void vr_trnfm(short handle, MFDB *psrcMFDB, MFDB *pdesMFDB)
{
	i_lptr1(psrcMFDB);
	i_lptr2(pdesMFDB);
	V_OPCODE = 110;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
}

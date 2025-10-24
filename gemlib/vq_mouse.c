#include "gem_vdiP.h"

void vq_mouse(short handle, short *pstatus, short *x, short *y)
{
	V_OPCODE = 124;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	*pstatus = intout[0];
	*x = ptsout[0];
	*y = ptsout[1];
}

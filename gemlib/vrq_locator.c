#include "gem_vdiP.h"

void vrq_locator(short handle, short x, short y, short *xout, short *yout, short *term)
{
	ptsin[0] = x;
	ptsin[1] = y;
	V_OPCODE = 28;
	V_NPTSIN = 1;
	V_NINTIN = 0;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	*xout = ptsout[0];
	*yout = ptsout[1];
	*term = intout[0];
}

#include "gem_vdiP.h"

void v_get_pixel(short handle, short x, short y, short *pel, short *index)
{
	ptsin[0] = x;
	ptsin[1] = y;
	V_OPCODE = 105;
	V_NPTSIN = 1;
	V_NINTIN = 0;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	*pel = intout[0];
	*index = intout[1];
}

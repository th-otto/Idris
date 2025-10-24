#include "gem_vdiP.h"

void v_meta_extents(short handle, short min_x, short min_y, short max_x, short max_y)
{
	ptsin[0] = min_x;
	ptsin[1] = min_y;
	ptsin[2] = max_x;
	ptsin[3] = max_y;
	V_OPCODE = 5;
	V_NPTSIN = 2;
	V_NINTIN = 0;
	V_SUBCODE = 98;
	V_HANDLE = handle;
	vdi();
}

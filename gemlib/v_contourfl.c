#include "gem_vdiP.h"

void v_contourfill(short handle, short x, short y, short index)
{
	intin[0] = index;
	ptsin[0] = x;
	ptsin[1] = y;
	V_OPCODE = 103;
	V_NPTSIN = 1;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
}

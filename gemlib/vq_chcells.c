#include "gem_vdiP.h"

void vq_chcells(short handle, short *rows, short *columns)
{
	V_OPCODE = 5;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 1;
	V_HANDLE = handle;
	vdi();
	*rows = intout[0];
	*columns = intout[1];
}

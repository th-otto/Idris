#include "gem_vdiP.h"

void vq_curaddress(short handle, short *row, short *column)
{
	V_OPCODE = 5;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 15;
	V_HANDLE = handle;
	vdi();
	*row = intout[0];
	*column = intout[1];
}

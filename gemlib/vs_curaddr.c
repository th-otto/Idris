#include "gem_vdiP.h"

void vs_curaddress(short handle, short row, short column)
{
	intin[0] = row;
	intin[1] = column;
	V_OPCODE = 5;
	V_NPTSIN = 0;
	V_NINTIN = 2;
	V_SUBCODE = 11;
	V_HANDLE = handle;
	vdi();
}

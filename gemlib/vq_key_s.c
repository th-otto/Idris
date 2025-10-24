#include "gem_vdiP.h"

void vq_key_s(short handle, short *pstatus)
{
	V_OPCODE = 128;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	*pstatus = intout[0];
}

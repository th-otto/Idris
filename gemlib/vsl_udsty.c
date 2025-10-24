#include "gem_vdiP.h"

void vsl_udsty(short handle, short pattern)
{
	intin[0] = pattern;
	V_OPCODE = 113;
	V_NPTSIN = 0;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
}

#include "gem_vdiP.h"

short vq_tabstatus(short handle)
{
	V_OPCODE = 5;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 16;
	V_HANDLE = handle;
	vdi();
	return intout[0];
}

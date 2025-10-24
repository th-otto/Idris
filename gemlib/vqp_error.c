#include "gem_vdiP.h"

short vqp_error(short handle)
{
	V_OPCODE = 5;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 96;
	V_HANDLE = handle;
	vdi();
	return intout[0];
}

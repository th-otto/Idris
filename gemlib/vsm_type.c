#include "gem_vdiP.h"

short vsm_type(short handle, short type)
{
	intin[0] = type;
	V_OPCODE = 18;
	V_NPTSIN = 0;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	return intout[0];
}

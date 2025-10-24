#include "gem_vdiP.h"

short vswr_mode(short handle, short mode)
{
	intin[0] = mode;
	V_OPCODE = 32;
	V_NPTSIN = 0;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	return intout[0];
}

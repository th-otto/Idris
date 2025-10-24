#include "gem_vdiP.h"

short vsin_mode(short handle, short dev_type, short mode)
{
	intin[0] = dev_type;
	intin[1] = mode;
	V_OPCODE = 33;
	V_NPTSIN = 0;
	V_NINTIN = 3;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	return intout[0];
}

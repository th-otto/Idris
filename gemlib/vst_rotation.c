#include "gem_vdiP.h"

short vst_rotation(short handle, short angle)
{
	intin[0] = angle;
	V_OPCODE = 13;
	V_NPTSIN = 0;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	return intout[0];
}

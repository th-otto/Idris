#include "gem_vdiP.h"

short vst_effects(short handle, short effect)
{
	intin[0] = effect;
	V_OPCODE = 106;
	V_NPTSIN = 0;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	return intout[0];
}

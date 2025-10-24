#include "gem_vdiP.h"

short vsl_type(short handle, short style)
{
	intin[0] = style;
	V_OPCODE = 15;
	V_NPTSIN = 0;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	return intout[0];
}

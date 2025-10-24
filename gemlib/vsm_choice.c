#include "gem_vdiP.h"

short vsm_choice(short handle, short *choice)
{
	intin[0] = *choice;
	V_OPCODE = 30;
	V_NPTSIN = 0;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	*choice = intout[0];
	return V_NINTOUT;
}

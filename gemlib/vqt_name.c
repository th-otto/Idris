#include "gem_vdiP.h"

short vqt_name(short handle, short element_num, register char *name)
{
	short i;

	intin[0] = element_num;
	V_OPCODE = 130;
	V_NPTSIN = 0;
	V_NINTIN = 1;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	for (i = 0; i < 32; i++)
		name[i] = intout[i + 1];
	return intout[0];
}

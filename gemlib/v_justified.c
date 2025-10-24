#include "gem_vdiP.h"

void v_justified(short handle, short x, short y, const char *string, short length, short word_space, short char_space)
{
	register short i;

	ptsin[0] = x;
	ptsin[1] = y;
	ptsin[2] = length;
	ptsin[3] = 0;
	intin[0] = word_space;
	intin[1] = char_space;
	i = 2;
	while ((intin[i++] = (unsigned char)*string++) != 0)
		;
	V_OPCODE = 11;
	V_NPTSIN = 2;
	V_NINTIN = --i;
	V_SUBCODE = 10;
	V_HANDLE = handle;
	vdi();
}

#include "gem_vdiP.h"

void v_gtext(short handle, short x, short y, register const char *string)
{
	register short i;

	ptsin[0] = x;
	ptsin[1] = y;
	i = 0;
	while ((intin[i++] = (unsigned char)*string++) != 0)
		;
	V_OPCODE = 8;
	V_NPTSIN = 1;
	V_NINTIN = --i;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
}

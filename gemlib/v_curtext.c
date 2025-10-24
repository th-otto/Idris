#include "gem_vdiP.h"

void v_curtext(short handle, register const char *string)
{
	short *ptr;
	
	ptr = intin;
	while ((*ptr++ = (unsigned char)*string++) != 0)
		;
	V_OPCODE = 5;
	V_NPTSIN = 0;
	V_NINTIN = ptr - intin - 1;
	V_SUBCODE = 12;
	V_HANDLE = handle;
	vdi();
}

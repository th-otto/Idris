#include "gem_vdiP.h"

void vm_filename(short handle, register const char *filename)
{
	register short i;

	i = 0;
	while ((intin[i++] = (unsigned char)*filename++) != 0)
		;	
	V_OPCODE = 5;
	V_NPTSIN = 0;
	V_NINTIN = --i;
	V_SUBCODE = 100;
	V_HANDLE = handle;
	vdi();
}

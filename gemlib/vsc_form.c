#include "gem_vdiP.h"

void vsc_form(short handle, short *pcur_form)
{
	vdipb.intin = pcur_form;
	V_OPCODE = 111;
	V_NPTSIN = 0;
	V_NINTIN = 37;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	vdipb.intin = intin;
}

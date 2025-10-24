#include "gem_vdiP.h"

void vqt_attributes(short handle, short *attrib)
{
	vdipb.intout = attrib;
	vdipb.ptsout = &attrib[6];
	V_OPCODE = 38;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	vdipb.intout = intout;
	vdipb.ptsout = ptsout;
}

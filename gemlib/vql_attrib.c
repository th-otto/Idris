#include "gem_vdiP.h"

void vql_attributes(short handle, short *attrib)
{
	vdipb.intout = attrib;
	V_OPCODE = 35;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	vdipb.intout = intout;
	attrib[3] = ptsout[0];
}

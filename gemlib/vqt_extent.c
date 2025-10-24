#include "gem_vdiP.h"

void vqt_extent(short handle, register const char *string, short *extent)
{
	short i;
	
	for (i = -1; (intin[++i] = (unsigned char)*string++) != 0; )
		;
	vdipb.ptsout = extent;
	V_OPCODE = 116;
	V_NPTSIN = 0;
	V_NINTIN = i;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	vdipb.ptsout = ptsout;
}

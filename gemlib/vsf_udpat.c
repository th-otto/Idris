#include "gem_vdiP.h"

void vsf_udpat(short handle, short *pfill_pat, short planes)
{
	vdipb.intin = pfill_pat;
	V_OPCODE = 112;
	V_NPTSIN = 0;
	V_NINTIN = planes * 16;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	vdipb.intin = intin;
}

#include "gem_vdiP.h"

void v_clear_disp_list(short handle)
{
	V_OPCODE = 5;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 22;
	V_HANDLE = handle;
	vdi();
}

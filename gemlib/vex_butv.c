#include "gem_vdiP.h"

void vex_butv(short handle, void (*pusrcode)(void), void (**psavcode)(void))
{
	i_lptr1(pusrcode);
	V_OPCODE = 125;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	m_lptr2(psavcode);
}

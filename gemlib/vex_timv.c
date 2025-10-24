#include "gem_vdiP.h"

void vex_timv(short handle, void (*tim_addr)(void), void (**otim_addr)(void), short *tim_conv)
{
	i_lptr1(tim_addr);
	V_OPCODE = 118;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	m_lptr2(otim_addr);
	*tim_conv = intout[0];
}

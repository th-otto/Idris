#include "gem_vdiP.h"

short vsm_string(short handle, short max_length, short echo_mode, short *echo_xy, char *string)
{
	short i;
	
	intin[0] = max_length;
	intin[1] = echo_mode;
	vdipb.ptsin = echo_xy;
	V_OPCODE = 31;
	V_NPTSIN = 1;
	V_NINTIN = 2;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	for (i = 0; i < V_NINTOUT; i++)
		*string++ = intout[i];
	*string = '\0';
	vdipb.ptsin = ptsin;
	return V_NINTOUT;
}

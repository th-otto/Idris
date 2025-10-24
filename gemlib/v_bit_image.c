#include "gem_vdiP.h"

#if 0 /* BUGGY */
void v_bit_image(short handle, const char *filename, short aspect, short x_scale, short y_scale, short *xyarray);
#else
void v_bit_image(short handle, const char *filename, short aspect, short x_scale, short y_scale, short h_align, short v_align, short *xyarray)
#endif
{
	short i;
	
	for (i = 0; i < 4; i++)
		ptsin[i] = xyarray[i];
	intin[0] = aspect;
	intin[1] = x_scale;
#if 0 /* original, buggy code */
	for (i = 2; (intin[i++] = (unsigned char)*filename++) != 0; )
		;
	V_OPCODE = 5;
	V_NPTSIN = y_scale;
#else
	intin[2] = y_scale;
	intin[3] = h_align;
	intin[4] = v_align;
	for (i = 5; (intin[i++] = (unsigned char)*filename++) != 0; )
		;
	V_OPCODE = 5;
	V_NPTSIN = 2;
#endif
	V_NINTIN = --i;
	V_SUBCODE = 23;
	V_HANDLE = handle;
	vdi();
}

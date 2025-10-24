#include "gem_vdiP.h"

void v_cellarray(short handle, short *pxyarray, short row_length, short el_used, short num_rows, short wrt_mode, short *colarray)
{
	vdipb.intin = colarray;
	vdipb.ptsin = pxyarray;
	V_OPCODE = 10;
	V_NPTSIN = 2;
	V_NINTIN = row_length * num_rows;
	V_HANDLE = handle;
	contrl[7] = row_length;
	contrl[8] = el_used;
	contrl[9] = num_rows;
	contrl[10] = wrt_mode;
	vdi();
	vdipb.intin = intin;
	vdipb.ptsin = ptsin;
}

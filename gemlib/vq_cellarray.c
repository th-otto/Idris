#include "gem_vdiP.h"

void vq_cellarray(short handle, short *pxyarray, short row_length, short num_rows, short *el_used, short *rows_used, short *status, short *colarray)
{
	vdipb.ptsin = pxyarray;
	vdipb.intout = colarray;
	V_OPCODE = 27;
	V_NPTSIN = 2;
	V_NINTIN = 0;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	contrl[7] = row_length;
	contrl[8] = num_rows;
	vdi();
	*el_used = contrl[9];
	*rows_used = contrl[10];
	*status = contrl[11];
	vdipb.ptsin = ptsin;
	vdipb.intout = intout;
}

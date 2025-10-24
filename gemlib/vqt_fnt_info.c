#include "gem_vdiP.h"

void vqt_fontinfo(short handle, short *minADE, short *maxADE, short *distances, short *maxwidth, short *effects)
{
	V_OPCODE = 131;
	V_NPTSIN = 0;
	V_NINTIN = 0;
	V_SUBCODE = 0;
	V_HANDLE = handle;
	vdi();
	*minADE = intout[0];
	*maxADE = intout[1];
	*maxwidth = ptsout[0];
	distances[0] = ptsout[1];
	distances[1] = ptsout[3];
	distances[2] = ptsout[5];
	distances[3] = ptsout[7];
	distances[4] = ptsout[9];
	effects[0] = ptsout[2];
	effects[1] = ptsout[4];
	effects[2] = ptsout[6];
}

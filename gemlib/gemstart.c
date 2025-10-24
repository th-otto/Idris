#include <std.h>
#include "osbind.h"
#include "gembind.h"
#include <string.h>
#include <stdlib.h>
#include <pcdecl.h>
 
static short vdi_handle = -1;
static short workin[11];
static short workout[57];
static short palette[16];

static void vdi_exit(void)
{
	Close_Handle();
	exit(0);
}


int Get_Handle(short *x_width, short *x_height, short *max_colors)
{
	int i;
	
	for (i = 0; i < 16; i++)
		palette[i] = Setcolor(i, -1);
	for (i = 0; i < 10; i++)
		workin[i] = 1;
	workin[10] = 2;
	v_opnwk(workin, &vdi_handle, workout);
	Setpalette(palette);
	*x_width = workout[0];
	*x_height = workout[1];
	*max_colors = workout[13];
	v_clrwk(vdi_handle);
	onintr(vdi_exit);
	return vdi_handle;
}


void Close_Handle(void)
{
	if (vdi_handle >= 0)
	{
		v_clrwk(vdi_handle);
		v_show_c(vdi_handle, 0);
		v_clswk(vdi_handle);
		write(1, "\033E", 2);
		vdi_handle = -1;
	}
}

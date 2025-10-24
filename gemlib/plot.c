#include <std.h>
#include <unistd.h>
#include "osbind.h"
#include "gembind.h"
#include "plot.h"

static int xscaler = 640;
static int yscaler = 200;
static struct LINE_A *apt;
static short *pt_ptsin;
static int oldy;
static int oldx;
/* static int res; */


void InitGraf(void)
{
	register int rez;
	
	rez = Getrez();
	if (rez == 0)
	{
		xscaler = 320;
		yscaler = 200;
	} else if (rez == 1)
	{
		xscaler = 640;
		yscaler = 200;
	} else
	{
		xscaler = 640;
		yscaler = 400;
	}
	apt = Ainit();
	pt_ptsin = apt->pts_in;
	apt->lstlin = -1;
	apt->lnmask = -1;
	SetIndex(255);
}


void SetIndex(register int index)
{
	apt->int_in[0] = index;
	apt->col0bit = index & 1;
	apt->col1bit = (index >> 1) & 1;
	apt->col2bit = (index >> 2) & 1;
	apt->col3bit = (index >> 3) & 1;
}


void MoveTo(int x, int y)
{
	pt_ptsin[0] = oldx = (x * xscaler) / 512;
	pt_ptsin[1] = oldy = (y * yscaler) / 480;
	Appixel();
}


void LineTo(int x, int y)
{
	apt->x1 = oldx;
	apt->y1 = oldy;
	apt->x2 = oldx = (x * xscaler) / 512;
	apt->y2 = oldy = (y * yscaler) / 480;
	Aline();
}


void ClrScreen(void)
{
	write(STDOUT, "\033E", 2);
}


#ifdef MAIN
int main(void)
{
	InitGraf();
	MoveTo(10, 10);
	LineTo(10, 100);
	LineTo(100, 100);
	LineTo(100, 10);
	LineTo(10, 10);
	sleep(10);
	return 0;
}
#endif

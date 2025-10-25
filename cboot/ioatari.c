#include <stdio.h>
#include <termio.h>
#include <fcntl.h>
#include "ioatari.h"



/* ---------- BIOS (trap13) ---------- */

long trap_13_w(short n);
long trap_13_ww(short n, short a);
long trap_13_www(short n, short a, short b);

#define Bconstat(a)                trap_13_ww(1, a)
#define Bconin(a)                  trap_13_ww(2, a)
#define Bconout(a,b)               trap_13_www(3, a, b)

/* ---------- XBIOS (trap14) ---------- */
long trap_14_wl(short n, long a);

#define Dosound(a)                 trap_14_wl(32, (long)(a))


void vidput(int c)
{
	Bconout(2, c);
}


int conin(void)
{
	return Bconin(2);
}


int constat(void)
{
	return Bconstat(2);
}


void sound_off(void)
{
	Dosound(0);
}


#define ESC 0x1b

void initscr(void)
{
	vidput(ESC); vidput('E');            /* clear screen */
	vidput(ESC); vidput('e');            /* cursor on */
	vidput(ESC); vidput('v');            /* wrap on */
	vidput(ESC); vidput('c'); vidput(0); /* background color */
	vidput(ESC); vidput('b'); vidput(3); /* foreground color */
}


void printc(register int c)
{
	if (c == '\n')
		vidput('\r');
	vidput(c);
}


int kbgetc(void)
{
	register int c;
	
	if ((constat() & 0xff) == 0)
		return 0;
	c = conin() & 0x7f;
	if (c == '\r')
		c = '\n';
	printc(c);
	return c;
}

#include <stdio.h>
#include <termio.h>
#include <fcntl.h>

/* ---------- BIOS (trap13) ---------- */

long b0__ios(short n);
long bw__ios(short n, short a);

#define Bconstat(a)                bw_ios( 1, a                         )
#define Bconin(a)                  bw_ios( 2, a                         )
#define Bconout(a,b)               bwwios( 3, a, b                      )

/* ---------- XBIOS (trap14) ---------- */
long xl__ios(short n, long a);

#define Dosound(a)                 xl__ios(32, (long)(a))


void conout(int c)
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
	conout(ESC); conout('E');            /* clear screen */
	conout(ESC); conout('e');            /* cursor on */
	conout(ESC); conout('v');            /* wrap on */
	conout(ESC); conout('c'); conout(0); /* background color */
	conout(ESC); conout('b'); conout(3); /* foreground color */
}


void printc(register int c)
{
	if (c == '\n')
		conout('\r');
	conout(c);
}


int getc(void)
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

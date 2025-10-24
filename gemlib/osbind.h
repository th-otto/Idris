/* ==================================================================== */
/*                              gembind.h                               */
/* defines for calling TOS Rom operating system functions, only XBIOS   */
/* useable from Idris, at perhaps not all of them!                      */
/* ==================================================================== */

#ifndef __OSBIND__
#define __OSBIND__ 1

#define Cursor_ON()  Cursconf(1,0)
#define Cursor_OFF() Cursconf(0,0)

long trap_13_w(short n);
long trap_13_ww(short n, short a);
long trap_13_wl(short n, long a);
long trap_13_www(short n, short a, short b);
long trap_13_wwl(short n, short a, long b);
long trap_13_wwlwww(short n, short a, long b, short c, short d, short e);

long trap_14_w(short n);
long trap_14_ww(short n, short a);
long trap_14_wl(short n, long a);
long trap_14_www(short n, short a, short b);
long trap_14_wwl(short n, short a, long b);
long trap_14_wwll(short n, short a, long b, long c);
long trap_14_wllw(short n, long a, long b, short c);
long trap_14_wlll(short n, long a, long b, long c);
long trap_14_wwwwl(short n, short a, short b, short c, long d);
long trap_14_wllww(short n, long a, long b, short c, short d);
long trap_14_wwwwwww(short n, short a, short b, short c, short d, short e, short f);
long trap_14_wllwwwww(short n, long a, long b, short c, short d, short e, short f, short g);
long trap_14_wllwwwwwlw(short n, long a, long b, short c, short d, short e, short f, short g, long h, short i);

/* ---------- BIOS (trap13) ---------- */

/* stuff between 'ifdef TOS' will break Idris */
#ifdef TOS

#define Getmpb(a)                  trap_13_wl(0, a)
#define Bconstat(a)                trap_13_ww(1, a)
#define Bconin(a)                  trap_13_ww(2, a)
#define Bconout(a,b)               trap_13_www(3, a, b)
#define Rwabs(a,b,c,d,e)           trap_13_wwlwww(4, a, b, c, d, e)
#define Setexc(a,b)                trap_13_wwl(5, a, b)
#define Tickcal()                  trap_13_w(6)
#define Getbpb(a)                  trap_13_ww(7, a)
#define Bcostat(a)                 trap_13_ww(8, a)
#define Mediach(a)                 trap_13_ww(9, a)
#define Drvmap()                   trap_13_w(10)
#define Getshift(a)                trap_13_ww(11, a)

/* ---------- XBIOS (trap14) ---------- */

#define Initmouse(type, par, vec)    trap_14_wwll(0, type, (long)(par), (long)(vec))
#define Ssbrk(count)                 trap_14_ww(1, count)
#define Floprd(a,b,c,d,e,f,g)        trap_14_wllwwwww(8, a, b, c, d, e, f, g)
#define Flopwr(a,b,c,d,e,f,g)        trap_14_wllwwwww(9, a, b, c, d, e, f, g)
#define Flopfmt(a,b,c,d,e,f,g,h,i)   trap_14_wllwwwwwlw(10, a, b, c, d, e, f, g, h, i)
#define Midiws(a,b)                  trap_14_wwl(12, a, b)
#define Mfpint(a,b)                  trap_14_wwl(13, a, b)
#define Iorec(a)                     trap_14_ww(14, a)
#define Rsconf(a,b,c,d,e,f)          trap_14_wwwwwww(15, a, b, c, d, e, f)
#define Keytbl(a,b,c)                trap_14_wlll(16, a, b, c)
#define Protobt(a,b,c,d)             trap_14_wllww(18, a, b, c, d)
#define Flopver(a,b,c,d,e,f,g)       trap_14_wllwwwww(19, a, b, c, d, e, f, g)
#define Scrdmp()                     trap_14_w(20)
#define Settime(a)                   trap_14_wl(22,a)
#define Gettime()                    trap_14_w(23)
#define Bioskeys()                   trap_14_w(24)
#define Ikbdws(a,b)                  trap_14_wwl(25, a, b)
#define Jdisint(a)                   trap_14_ww(26, a)
#define Jenabint(a)                  trap_14_ww(27, a)
#define Xbtimer(a,b,c,d)             trap_14_wwwwl(31, a, b, c, d)
#define Setprt(a)                    trap_14_ww(33, a)
#define Kbdvbase()                   trap_14_w(34)
#define Setprt(a)                    trap_14_ww(33, a)
#define Kbdvbase()                   trap_14_w(34)
#define Prtblk()                     trap_14_w(36)
#define Puntaes()                    trap_14_w(39)
#define Floprate(a,b)                trap_14_www(40, a, b))

#endif /* TOS */

/* -------------------------------------------------------------------- */
/* !!!following are only 'safe' (maybe) useable functions from idris!!! */
/* !!!many of the above can be done by using standard idris functions!! */
/* -------------------------------------------------------------------- */

/* ---------- XBIOS (trap14) ---------- */
#define Physbase()                   trap_14_w(2)
#define Logbase()                    trap_14_w(3)
#define Getrez()                     trap_14_w(4)
#define Setscreen(laddr, paddr, rez) trap_14_wllw(5, (long)(laddr), (long)(paddr), rez)
#define Setpalette(palptr)           trap_14_wl(6, (long)(palptr))
#define Setcolor(colornum, color)    trap_14_www(7, colornum, color)
#define Random()                     trap_14_w(17)
#define Cursconf(a,b)                trap_14_www(21, a, b)
#define Giaccess(a,b)                trap_14_www(28, a, b)
#define Offgibit(a)                  trap_14_ww(29, a)
#define Ongibit(a)                   trap_14_ww(30, a)
#define Dosound(a)                   trap_14_wl(32, (long)(a))
#define Kbrate(a,b)                  trap_14_www(35, a, b)
#define Vsync()                      trap_14_w(37)
#define Supexec(a)                   trap_14_wl(38, a)
#define Blitmode(a)                  trap_14_ww(64, a)

#endif /* __OSBIND__ */

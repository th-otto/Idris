/*	HEADER FILE FOR UNISCREEN (CURSES COMPATIBLE)
 *	copyright (c) 1985 by UNISOFT AB of Sweden
 */
#ifndef __CURSES__
#define __CURSES__ 1
#include <stdio.h>
#include <termio.h>

typedef short COORD;


/*	pseudo-types
 */
#define reg		register

/*	constants
 */
#define TRUE	(1)
#define FALSE	(0)
#define OK		(1)
#define ERR		(0)

/*	mode codes for settmode
 */
#define MODE_CR		1
#define MODE_ECHO	2
#define MODE_RAW	3
#define MODE_NL		4

/*	types
 */
typedef char *LINE;			/* LINE t; t points to a line of text in window */
typedef LINE *AREA;			/* AREA a; a points to an array of ptrs to t */ 
typedef struct {
	COORD	l, c;			/* cursor address in window */
	COORD	lines, cols;	/* number of */
	COORD	lstart, cstart;	/* offset on screen */
	COORD	tabstop;		/* tabstop in every multiple of */
	int	subwin: 1;		/* window is a subwindow of another window */
	int	endline: 1;		/* end-line of the window is end of the screen */
	int	fullwin: 1;		/* this window covers the whole screen */
	int	standon: 1;		/* stand out mode on */
	int	clearflag: 1;	/* window will be cleared on next refresh */
	int	leave: 1;		/* leave cursor at last update */
	int	scroll: 1;		/* window is in scroll-mode */
	AREA	room;			/* pointer to array of LINE's */
	COORD	*firstch;		/* indexes for first change of lines */
	COORD	*lastch;		/* same for last change */
	AREA	rsave;			/* the original room pointer (for free) */
} WINDOW;

/*	#define-macros for operations on stdscr.
 */
#define addbuf(b, n)			waddbuf(stdscr, b, n)
#define addch(c) 				waddch(stdscr, c)
#define addstr(s) 				waddstr(stdscr, s)
#define clear() 				wclear(stdscr)
#define clrtobot() 				wclrtobot(stdscr)
#define clrtoeol() 				wclrtoeol(stdscr)
#define delch()					wdelch(stdscr)
#define deleteln()				wdeleteln(stdscr)
#define erase() 				werase(stdscr)
#define getbuf()				wgetbuf(stdscr)
#define getch()					wgetch(stdscr)
#define getstr(s)				wgetstr(stdscr, s)
#define inch()					winch(stdscr)
#define insertln()				winsertln(stdscr)
#define insch(c)				winsch(stdscr, c)
#define move(y, x) 				wmove(stdscr, y, x)
#define refresh() 				wrefresh(stdscr)
#define standout() 				wstandout(stdscr)
#define standend() 				wstandend(stdscr)

/*	#define-macros with mv-prefix
 */
#define mvaddch(y, x, c)		mvwaddch(stdscr, y, x, c)
#define mvaddbuf(w, y, x, b, n) mvwaddbuf(stdscr, y, x, b, n)
#define mvaddstr(y, x, s)		mvwaddstr(stdscr, y, x, s)
#define mvdelch(y, x)			mvwdelch(stdscr, y, x)
#define mvgetch(y, x)			mvwgetch(stdscr, y, x)
#define mvgetstr(y, x, s)		mvwgetstr(stdscr, y, x, s)
#define mvinch(y, x)			mvwinch(stdscr, y, x)
#define mvinsch(y, x, c)		mvwinsch(stdscr, y, x, c)
#define mvwaddch(w, y, x, c)	(wmove(w, y, x) == OK ? waddch(w, c) : _err())
#define mvwaddbuf(w, y, x, b,n) (wmove(w, y, x) == OK ? waddbuf(w, b, n) : _err())
#define mvwaddstr(w, y, x, s)	(wmove(w, y, x) == OK ? waddstr(w, s) : _err())
#define mvwdelch(w, y, x)		(wmove(w, y, x) == OK ? wdelch(w) : _err())
#define mvwgetch(w, y, x)		(wmove(w, y, x) == OK ? wgetch(w) : _err())
#define mvwgetstr(w, y, x, s)	(wmove(w, y, x) == OK ? wgetstr(w, s) : _err())
#define mvwinch(w, y, x)		(wmove(w, y, x) == OK ? winch(w) : _err())
#define mvwinsch(w, y, x, c)	(wmove(w, y, x) == OK ? winsch(w, c) : _err())

/*	other simple functions
 */
#define clearok(w, f)			(w->clearflag = f)
#define leaveok(w, f)			(w->leave = f)
#define scrollok(w, f)			(w->scroll = f)
#define getyx(w, ll, cc)		(ll = w->l, cc = w->c)
#define winch(w)				(w->room[w->l][w->c])
#define _puts(s)				(tputs(s, 0, &_ttyputc))

/*	set or reset terminal modes
 */
#define crmode()				settmode(MODE_CR, TRUE);
#define echo()					settmode(MODE_ECHO, TRUE)
#define raw()					settmode(MODE_RAW, TRUE)
#define nl()					settmode(MODE_NL, TRUE)
#define nocrmode()				settmode(MODE_CR, FALSE)
#define noecho()				settmode(MODE_ECHO, FALSE)
#define noraw()					settmode(MODE_RAW, FALSE)
#define nonl()					settmode(MODE_NL, FALSE)

/*	return terminal status
 */
#define iscr()					(_ttymodes[MODE_CR-1])
#define isecho()				(_ttymodes[MODE_ECHO-1])
#define israw()					(_ttymodes[MODE_RAW-1])
#define isnl()					(_ttymodes[MODE_NL-1])

/*	standout on/off
 */
#define wstandout(w)			(w->standon = TRUE)
#define wstandend(w)			(w->standon = FALSE)

typedef char bool;

/*	internal use
 */
extern char _bools[];
extern char *_strings[];

#define AM _bools[0]
#define BS _bools[1]
#define CA _bools[2]
#define EO _bools[3]
#define HZ _bools[4]
#define IN _bools[5]
#define MI _bools[6]
#define NC _bools[7]
#define OS _bools[8]
#define PC _bools[9]
#define UL _bools[10]
#define XN _bools[11]

#define AL _strings[0]
#define BC _strings[1]
#define BT _strings[2]
#define CD _strings[3]
#define CE _strings[4]
#define CL _strings[5]
#define CM _strings[6]
#define DC _strings[7]
#define DL _strings[8]
#define DM _strings[9]
#define DO _strings[10]
#define ED _strings[11]
#define EI _strings[12]
#define HO _strings[13]
#define IC _strings[14]
#define IM _strings[15]
#define IP _strings[16]
#define LL _strings[17]
#define MA _strings[18]
#define ND _strings[19]
#define SE _strings[20]
#define SF _strings[21]
#define SO _strings[22]
#define SR _strings[23]
#define TA _strings[24]
#define TE _strings[25]
#define TI _strings[26]
#define UC _strings[27]
#define UE _strings[28]
#define UP _strings[29]
#define US _strings[30]
#define VB _strings[31]
#define VE _strings[32]
#define VS _strings[33]

/*	global variables
 */
#ifndef _DEF_
#define _DEF_
#endif

/*	externals never defined here
 */
extern char _ttymodes[];
extern void _ttyputc();

/*	variables
 */
extern WINDOW	*curscr	_DEF_;
extern WINDOW *stdscr	_DEF_;
extern short   LINES _DEF_ , COLS _DEF_;
extern int _standout _DEF_;

/*	externals
 */
extern char	*Def_term;
extern int	My_term;
extern struct sgtty _tty;
#endif

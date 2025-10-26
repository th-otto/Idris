/* TERMCAP HEADER FILE
 * copyright (c) 1986, 1987 by Whitesmiths, Ltd.
 */

#ifndef __TERMCAP__
#define __TERMCAP__ 1

/*	set up prototyping
 */
#ifndef __
#ifdef _PROTO
#define __(a)	a
#else
#define __(a)	()
#endif
#endif

extern char PC;
extern char *BC;
extern char *UP;
extern short ospeed;

extern short tgetent __((char *p, char *q));
extern short tgetnum __((char * ptr));
extern int tgetflag __((char *p));
extern char *tgetstr __((char *p, char **pp));
extern char *tgoto __((char *p, short i, int j));
extern void tputs __((char *, short i, int (*pfunc)()));

#endif

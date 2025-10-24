/* ====================================================================== */
/*                                dbm.h                                   */
/* ====================================================================== */
/* BSD function emulation - database functions include file               */
/* this file from the X11R2 tape, modified for Idris                      */
/* ====================================================================== */

#ifndef __DBM__
#define __DBM__ 1

/*	set up prototyping
 */
#ifndef __
#ifdef _PROTO
#define __(a)	a
#else
#define __(a)	()
#endif
#endif

#define PBLKSIZ  1024
#define DBLKSIZ  4096
#define BYTESIZ  8
#ifndef NULL
#define NULL   ((char *) 0)
#endif

extern long bitno;
extern long maxbno;
extern long blkno;
extern long hmask;

extern char pagbuf[PBLKSIZ];
extern char dirbuf[DBLKSIZ];

extern int dirf;
extern int pagf;
extern int dbrdonly;

typedef struct { char *dptr ; int dsize ; } datum;

int dbminit __((const char *filename));
int cbmclose __((void));
datum w_fetch __((datum key));
datum w_makdatum();
datum w_firstkey __((void));
datum w_nextkey __((datum key));
datum w_firsthash();
int store __((datum key, datum dat));
int delete __((datum key));
long calchash __((datum dat));
long hashinc __((long hash));

#endif  __DBM__

/* ====================================================================== */
/*                              Module End                                */
/* ====================================================================== */


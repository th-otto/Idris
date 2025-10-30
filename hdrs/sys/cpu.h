/*	HEADER FOR CPU MANAGEMENT
 *	copyright (c) 1979 by Whitesmiths, Ltd.
 */

#ifndef __CPU__
#define __CPU__ 1

/*	codes for p_stat
 */
#define DOZING	1
#define IDLING	2
#define RUNNING	3
#define WAITING	4
#define SHARING 5
#define DYING	6
#define MOVED	7

/*	codes for p_flag
 */
#define S_EXEC	0x01
#define S_FORK	0x02	/* for runnables */
#define S_STK	0x02	/* for text segments */
#define S_INMEM	0x04
#define S_LOCK	0x08
#define S_ABS	0x10
#define S_TXOUT	0x20
#define S_LOAD	0x40
#define S_WORK	0x80
 
/*	the process control structure
 */
#define MAXPN	8
struct proc {
	/*   0 */ struct proc *next;
	/*   4 */ TEXT *p_chan;
	/*   8 */ BLOCK p_base;
	/*  10 */ BLOCK p_wbase; /* new in 3.14 */
	/*  12 */ BLOCK p_size;
	/*  14 */ BLOCK p_addr;
	/*  16 */ BLOCK p_tsize;
	/*  18 */ UTINY p_flag;
	/*  19 */ UTINY p_stat;
	/*  20 */ TINY p_pri;
	/*  21 */ TINY p_bias;
	/*  22 */ TEXT p_name[MAXPN];
	/*  30 */ PID p_pid;
	/*  32 */ PID p_pgrp;
	/*  34 */ DEV p_typ;
	/* end of shared part */
	/*  36 */ union {
		struct {
			/*  36 */ struct proc *textp;
			/*  40 */ struct zlist *zlist;
			/*  44 */ struct proc *nextrun;
			/*  48 */ struct proc *nextwake;
			/*  52 */ BYTES alarm;
			/*  56 */ BYTES freeheap;
			/*  60 */ ULONG sigf;
			/*  64 */ PID ppid;
			/*  66 */ UID ruid;
			/*  67 */ UTINY slice;
			/*  68 */ UTINY sig;
		} p;
		struct {
			/*  36 */ DEV idev;
			/*  38 */ INUM inum;
			/*  40 */ ULONG uptime;
			/*  44 */ COUNT refs;
			/*  46 */ COUNT coreref;
			/*  48 */ ULONG rboff;
		} t;
	} v;
	/*  70 */
};

/*	the zombie control structure
 */
struct zlist {
	/*  0 */ struct zlist *next;
	/*  4 */ LONG z_cutime;
	/*  8 */ LONG z_cstime;
	/* 12 */ BYTES z_freeheap;
	/* 16 */ COUNT z_stat;
	/* 18 */ PID z_pid;
	/* 20 */ char z_name[MAXPN];
	/* 28 */
};

/*	abbreviation macros
 */
#define TXIN(p) (!(p) || ((p)->p_flag & S_INMEM))
#define ALLIN(xx) (((xx)->p_flag & S_INMEM) && (TXIN((xx)->v.p.textp)))

/*	map control
 */
#define MAP_DATA	1
#define MAP_TEXT	2
#define MAP_SDATA	4
#define MAP_STEXT	8
#define MAP_IO		16
#define MAP_CPU		32

#endif

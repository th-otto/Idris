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
#define S_EXEC	0001
#define S_FORK	0002	/* for runnables */
#define S_STK	0002	/* for text segments */
#define S_INMEM	0004
#define S_LOCK	0010
#define S_ABS	0020
#define S_TXOUT	0040
#define S_LOAD	0100
#define S_WORK	0200
 
/*	the process control structure
 */
#define MAXPN	8
struct proc {
	TEXT *next;
	TEXT *p_chan;
	BLOCK p_base;
	BLOCK p_size;
	BLOCK p_addr;
	BLOCK p_tsize;
	UTINY p_flag;
	UTINY p_stat;
	TINY p_pri;
	TINY p_bias;
	TEXT p_name[MAXPN];
	PID p_pid;
	PID p_pgrp;
	DEV p_typ;
	/* end of shared part */
	union {
		struct {
			PROC *textp;
			ZLIST *zlist;
			PROC *nextrun;
			PROC *nextwake;
			BYTES alarm;
			BYTES freeheap;
			ULONG sigf;
			PID ppid;
			UID ruid;
			UTINY slice;
			UTINY sig;
			} p;
		struct {
			DEV idev;
			INUM inum;
			ULONG uptime;
			COUNT refs;
			COUNT coreref;
			ULONG rboff;
			} t;
		} v;
	};

/*	the zombie control structure
 */
struct zlist {
	TEXT *next;
	LONG z_cutime;
	LONG z_cstime;
	BYTES z_freeheap;
	COUNT z_stat;
	PID z_pid;
	TEXT z_name[MAXPN];
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

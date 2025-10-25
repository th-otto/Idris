/*	HEADER FOR USER CONTROL AREA
 *	copyright (c) 1979 by Whitesmiths, Ltd.
 */

#ifndef __USR__
#define __USR__ 1

/*	the user vector parameters
 */
#define DIRSIZ	14
#define UFILES	32

#define DENTRY	struct dentry
struct dentry {
	INUM e_ino;
	char e_name[DIRSIZ];
	};

#define HEADER	struct header
struct header	{
	UCOUNT hd_fmt, hd_ss;
	BYTES hd_ts, hd_ds, hd_bs, hd_hs;
	BYTES hd_tb, hd_db;
	};

#define PROF	struct prof
struct prof {
	COUNT *pr_base;
	BYTES pr_size;
	BYTES pr_off;
	BYTES pr_scale;
	};

#define TIMES	struct times
struct times {
	ULONG ti_u;
	ULONG ti_s;
	ULONG ti_cu;
	ULONG ti_cs;
	};

struct user {
	/*   0 */ BYTES u_savsp;
	/*   4 */ BYTES u_senv;
	/*   8 */ BYTES u_ofp;
	/*  12 */ BYTES u_nfp;
	/*  16 */ PROC *u_proc;
	/*  20 */ BYTES u_dbrk;
	/*  24 */ BYTES u_tb;
	/*  28 */ BYTES u_ts;
	/*  32 */ BYTES u_db;
	/*  36 */ BYTES u_ds;
	/*  40 */ TINY *u_base;
	/*  44 */ BYTES u_count;
	/*  48 */ LONG u_offset;
	/*  52 */ struct inode *u_cdir;
	/*  56 */ struct inode *u_rdir;
	/*  60 */ struct inode *u_inode;
	/*  64 */ ULONG u_clex;
	/*  68 */ struct fvar *u_files[UFILES];
	/* 196 */ TINY *u_sigs[NSIG];
	/* 272 */ TIMES u_times;
	/* 288 */ PROF u_prof;
	/* 304 */ UID u_euid;
	/* 305 */ UID u_egid;
	/* 306 */ UID u_ruid;
	/* 307 */ UID u_rgid;
	/* 308 */ BOOL u_fppres;
	/* 312 */ BITS u_xseg;
	/* 314 */ BITS u_flag;
	/* 316 */ BITS u_umask;
	/* 318 */ DEV u_pdev;
	/* 320 */ INUM u_pino;
	/* 322 */ TINY u_error;
	/* 323 */ TINY u_sysio;
	/* 324 */ BYTES u_arg[4];
	/* 340 */ union {
		DENTRY u_d;
		HEADER u_h;
	} u;
	/* 368 */
};

extern struct user *pu;

int _times(TIMES *t);

#endif

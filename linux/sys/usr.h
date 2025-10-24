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
	TEXT e_name[DIRSIZ];
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
	BYTES u_savsp;
	BYTES u_senv;
	BYTES u_ofp;
	BYTES u_nfp;
	PROC *u_proc;
	BYTES u_dbrk;
	BYTES u_tb;
	BYTES u_ts;
	BYTES u_db;
	BYTES u_ds;
	TINY *u_base;
	BYTES u_count;
	LONG u_offset;
	INODE *u_cdir;
	INODE *u_rdir;
	INODE *u_inode;
	ULONG u_clex;
	FVAR *u_files[UFILES];
	TINY *u_sigs[NSIG];
	TIMES u_times;
	PROF u_prof;
	UID u_euid;
	UID u_egid;
	UID u_ruid;
	UID u_rgid;
	BOOL u_fppres;
	BITS u_xseg;
	BITS u_flag;
	BITS u_umask;
	DEV u_pdev;
	INUM u_pino;
	TINY u_error;
	TINY u_sysio;
	BYTES u_arg[4];
	union {
		DENTRY u_d;
		HEADER u_h;
		} u;
	};

USER *pu;

int _times(TIMES *t);

#endif

#include <stdio.h>
#include <stddef.h>
#ifdef _IDRIS
#define offsetof(type, ident) ((size_t)&(((type *)0)->ident))
#endif

typedef char TINY;
typedef unsigned char UTINY;
typedef unsigned short DEV;
typedef unsigned int BYTES;
typedef unsigned short BITS;
typedef short COUNT;
typedef unsigned short INUM;
typedef unsigned short UCOUNT;
typedef unsigned int ULONG;
typedef int LONG;
typedef int BOOL;
typedef unsigned char UID;

#define DIRSIZ	14
#define UFILES	32
#define NSIG    19

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

struct proc;
struct inode;

struct fvar {
	struct inode *f_inode;
	LONG f_offset;
	UTINY f_flag;
	UTINY f_refs;
	};

struct user {
	/*   0 */ BYTES u_savsp;
	/*   4 */ BYTES u_senv;
	/*   8 */ BYTES u_ofp;
	/*  12 */ BYTES u_nfp;
	/*  16 */ struct proc *u_proc;
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



int main(void)
{
#define P(x, s) printf("/* %3d */ %s\n", (int)offsetof(struct user, x), s)
	P(u_savsp, "u_savsp");
	P(u_senv, "u_senv");
	P(u_ofp, "u_ofp");
	P(u_nfp, "u_nfp");
	P(u_proc, "u_proc");
	P(u_dbrk, "u_dbrk");
	P(u_tb, "u_tb");
	P(u_ts, "u_ts");
	P(u_db, "u_db");
	P(u_ds, "u_ds");
	P(u_base, "u_base");
	P(u_count, "u_count");
	P(u_offset, "u_offset");
	P(u_cdir, "u_cdir");
	P(u_rdir, "u_rdir");
	P(u_inode, "u_inode");
	P(u_clex, "u_clex");
	P(u_files, "u_files");
	P(u_sigs, "u_sigs");
	P(u_times, "u_times");
	P(u_prof, "u_prof");
	P(u_euid, "u_euid");
	P(u_egid, "u_egid");
	P(u_ruid, "u_ruid");
	P(u_rgid, "u_rgid");
	P(u_fppres, "u_fppres");
	P(u_xseg, "u_xseg");
	P(u_flag, "u_flag");
	P(u_umask, "u_umask");
	P(u_pdev, "u_pdev");
	P(u_pino, "u_pino");
	P(u_error, "u_error");
	P(u_sysio, "u_sysio");
	P(u_arg, "u_arg");
	P(u, "u");
	printf("size %d\n", (int)sizeof(struct user));
	
	return 0;
}

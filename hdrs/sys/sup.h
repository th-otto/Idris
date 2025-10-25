/*	INODE AND SUPERBLOCK STRUCTURES
 *	copyright (c) 1979, 1985 by Whitesmiths, Ltd.
 */

#ifndef __SUP__
#define __SUP__ 1

/*	the filesystem superblock
 */
typedef struct {
	/*   0 */ BLOCK s_isize;
	/*   2 */ BLOCK s_fsize;
	/*   4 */ UCOUNT s_nfree;
	/*   6 */ BLOCK s_free[100];
	/* 206 */ UCOUNT s_ninode;
	/* 208 */ INUM s_inode[100];
	/* 408 */ ULONG s_pad0;
	/* 412 */ ULONG s_mtime;			/* end of old superblock */
	/* 416 */ ULONG s_dtime;
	/* 420 */ ULONG s_fsize1;
	/* 424 */ ULONG s_tfree;			/* returned by ustat */
	/* 428 */ UCOUNT s_tinode;		/* returned by ustat */
	/* 430 */ TEXT s_fsname[6];		/* returned by ustat */
	/* 436 */ TEXT s_pkname[6];		/* returned by ustat */
	/* 442 */ TEXT s_pad1[62];
	/* 504 */ ULONG s_magic;
	/* 508 */ ULONG s_type;
	/* 512 */ 
} FILSYS;

/*	the filesystem inode
 */
typedef struct {
	/*  0 */ BITS n_mode;
	/*  2 */ UTINY n_link;
	/*  3 */ UID n_uid;
	/*  4 */ UID n_gid;
	/*  5 */ UTINY n_size0;
	/*  6 */ UCOUNT n_size1;
	/*  8 */ BLOCK n_addr[8];
	/* 24 */ ULONG n_tmake;
	/* 28 */ ULONG n_tdump;
	/* 32 */
} FINODE;

#define n_actime n_tmake
#define n_uptime n_tdump
#define _lsize(pi) (((LONG)(pi)->n_size0 << 16) | ((pi)->n_size1))

#endif

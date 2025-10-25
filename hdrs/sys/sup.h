/*	INODE AND SUPERBLOCK STRUCTURES
 *	copyright (c) 1979, 1985 by Whitesmiths, Ltd.
 */

#ifndef __SUP__
#define __SUP__ 1

/*	the filesystem superblock
 */
typedef struct {
	BLOCK s_isize;
	BLOCK s_fsize;
	UCOUNT s_nfree;
	BLOCK s_free[100];
	UCOUNT s_ninode;
	INUM s_inode[100];
	ULONG s_pad0;
	ULONG s_mtime;			/* end of old superblock */
	ULONG s_dtime;
	ULONG s_fsize1;
	ULONG s_tfree;			/* returned by ustat */
	UCOUNT s_tinode;		/* returned by ustat */
	TEXT s_fsname[6];		/* returned by ustat */
	TEXT s_pkname[6];		/* returned by ustat */
	TEXT s_pad1[62];
	ULONG s_magic;
	ULONG s_type;
	} FILSYS;

/*	the filesystem inode
 */
typedef struct {
	BITS n_mode;
	UTINY n_link;
	UID n_uid;
	UID n_gid;
	UTINY n_size0;
	UCOUNT n_size1;
	BLOCK n_addr[8];
	ULONG n_tmake;
	ULONG n_tdump;
	} FINODE;
#define n_actime n_tmake
#define n_uptime n_tdump
#define _lsize(pi) (((LONG)(pi)->n_size0 << 16) | ((pi)->n_size1))

#endif

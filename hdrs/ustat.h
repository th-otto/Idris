/*	FILESYSTEM INFORMATION
 *	copyright (c) 1985, 1987 by Whitesmiths, Ltd.
 */

#ifndef __USTAT__
#define __USTAT__ 1

struct ustat {
	unsigned short f_isize;
	unsigned short f_fsize;
	struct {
		unsigned long tfree;
		unsigned short tinode;
		unsigned char fsname[6];
		unsigned char pkname[6];
	} f_sbi;
	struct {
		unsigned short mddev, mdino;
		unsigned short mtdev, mtino;
		unsigned short mtpdev, mtpino;
		unsigned char mdronly;
	} f_mnt;
};

#define f_fname	f_sbi.fsname
#define f_fpack	f_sbi.pkname
#define f_tfree f_sbi.tfree
#define f_tinode f_sbi.tinode
#define f_fsname f_sbi.fsname
#define f_pkname f_sbi.pkname
#define f_mddev f_mnt.mddev
#define f_mdino f_mnt.mdino
#define f_mtdev f_mnt.mtdev
#define f_mtino f_mnt.mtino
#define f_mtpdev f_mnt.mtpdev
#define f_mtpino f_mnt.mtpino
#define f_mdronly f_mnt.mdronly

#endif

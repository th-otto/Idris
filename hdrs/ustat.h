/*	FILESYSTEM INFORMATION
 *	copyright (c) 1985, 1987 by Whitesmiths, Ltd.
 */

#ifndef __USTAT__
#define __USTAT__ 1

struct ustat {
	/*  0 */ unsigned short f_isize;
	/*  2 */ unsigned short f_fsize;
	struct {
		/*  4 */ unsigned long tfree;
		/*  8 */ unsigned short tinode;
		/* 10 */ unsigned char fsname[6];
		/* 16 */ unsigned char pkname[6];
	} f_sbi;
	struct {
		/* 22 */ unsigned short mddev;
		/* 24 */ unsigned short mdino;
		/* 26 */ unsigned short mtdev;
		/* 28 */ unsigned short mtino;
		/* 30 */ unsigned short mtpdev;
		/* 32 */ unsigned short mtpino;
		/* 34 */ unsigned char mdronly;
	} f_mnt;
	/* 36 */
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

int ustat(int fd, struct ustat *st);

#endif

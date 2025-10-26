/*	STAT AND FSTAT STRUCTURE
 *	copyright (c) 1985 by Whitesmiths, Ltd.
 */

#ifndef __STAT__
#define __STAT__ 1

#ifndef __TYPES__
#include <sys/types.h>
#endif

struct stat {
	/*  0 */ unsigned short st_dev;
	/*  2 */ unsigned short st_ino;
	/*  4 */ unsigned short st_mode;
	/*  6 */ unsigned char st_nlink;
	/*  7 */ unsigned char st_uid, st_gid;
	/*  9 */ unsigned char st_size0;
	/* 10 */ unsigned short st_size1;
	union {
		/* 12 */ unsigned short _stU_addr[8];
		struct {
			unsigned short _stS_rdev;
			unsigned short _stS_c1;
			unsigned long _stS_lsize;
			unsigned long _stS_l2;
			unsigned long _stS_l3;
		} _stS;
	} _stU;
	/* 28 */ unsigned long st_tmake;
	/* 32 */ unsigned long st_tdump;
#ifndef __RES__ /* not in kernel */
	/* 36 */ unsigned long st_resrvd;
#endif
	/* 40 */
};
  
#define st_addr _stU._stU_addr
#define st_rdev _stU._stS._stS_rdev
#define st_size _stU._stS._stS_lsize
#define st_atime st_tmake
#define st_mtime st_tmake /* BUG? will report st_atime as modification time? */
#define st_ctime st_tdump

/*	codes for mode
 */
#define I_ALLOC	0100000
#define I_TYPE	0060000
#define I_REG	0000000
#define I_CHR	0020000
#define I_DIR	0040000
#define I_BLK	0060000
#define I_LARGE	0010000
#define I_SUID	0004000
#define I_SGID	0002000
#define I_STK	0001000
#define I_AUTO	0001000
#define I_FIFO	0001000

/*	common UNIX names
 */
#define S_IFBLK		I_BLK
#define S_IFCHR		I_CHR
#define S_IFDIR		I_DIR
/*
#define S_IFIFO		I_FIFO
 */
#define S_IFMT		I_TYPE
#define S_IFREG		I_REG
#define S_IREAD		S_IRUSR
#define S_IWRITE	S_IWUSR
#define S_IEXEC		S_IXUSR

/*	file type macros
 */
#define S_ISDIR(m)	(((unsigned short) (m) & I_TYPE) == I_DIR)
#define S_ISCHR(m)	(((unsigned short) (m) & I_TYPE) == I_CHR)
#define S_ISBLK(m)	(((unsigned short) (m) & I_TYPE) == I_BLK)
#define S_ISREG(m)	(((unsigned short) (m) & I_TYPE) == I_REG)
#define S_ISFIFO(m)	(((unsigned short) (m) & (I_TYPE|I_FIFO|0111)) == (I_REG|I_FIFO))
#define S_ISAUTO(m)	(((unsigned short) (m) & (I_TYPE|I_AUTO)) == (I_BLK|I_AUTO))
/* BUG? returns true also for directories */
#define S_ISDEV(m)	(((unsigned short) (m) & (I_CHR&I_BLK)))
#define S_IFIFO		(I_REG|I_FIFO|0666)
#define S_IDIR		(I_DIR|0777)

/*	access mode bits
 */
#define	S_ISUID		04000	/* set user id */
#define S_ISGID		02000	/* set group id */
#define S_ISVTX		01000	/* sticky bit */
#define S_IRWXU		00700	/* read, write, exec: owner */
#define S_IRUSR		00400	/* read: owner */
#define S_IWUSR		00200	/* write: owner */
#define S_IXUSR		00100	/* exec: owner */
#define S_IRWXG		00070	/* read, write, exec: group */
#define S_IRGRP		00040	/* read: group */
#define S_IWGRP		00020	/* write: group */
#define S_IXGRP		00010	/* exec: group */
#define S_IRWXO		00007	/* read, write, exec: other */
#define S_IROTH		00004	/* read: other */
#define S_IWOTH		00002	/* write: other */
#define S_IXOTH		00001	/* exec: other */
#define S_ENFMT	S_ISGID		/* enable lock enforcement */

int stat(const char *filename, struct stat *__st);
int fstat(int fd, struct stat *__st);
int mkdir(const char *pathname, mode_t mode);
int mknod(const char *pathname, mode_t mode, dev_t dev);
mode_t umask(mode_t mask);

#endif

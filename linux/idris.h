/*	MISCELLANEOUS IDRIS DEFINES
 *	copyright (c) 1986 by Whitesmiths, Ltd
 */
#ifndef __IDRIS__
#define __IDRIS__ 1

typedef unsigned char UID;		/* int?? */
typedef short PID;
typedef unsigned short BLOCK, DEV, INUM;
typedef unsigned long PHYS;

typedef struct dirent DIRENT;
typedef struct flock FLOCK;
typedef struct group GROUP;
typedef struct idir IDIR;
typedef struct pwd PWD;
typedef struct sgtty SGTTY;
typedef struct stat STAT;
typedef struct termio TERMIO;
typedef struct tms TMS;
typedef struct ustat USTAT;
typedef struct utimbuf UTIMBUF;
typedef struct utsname UTSNAME;

#define JMPBUF jmp_buf

#define NODEV	0
#define dminor(dev)	((dev) & 0xff)
#define dmajor(dev)	(((dev) >> 8) & 0xff)
#define device(major, minor)	((DEV) (major) << 8 | (minor))

/*	priorities
 */
#define PSWAP	(-3)
#define PIIO	(-2)
#define PBIO	(-1)
#define PITY	0
#define POTY	0
#define PNORM	5
#define PINIT	5
#define PFLOCK	5
#define	PPIPE	6
#define PSLEEP	7
#define PWAIT	8
#define PLOW	(PNORM + 20)

#endif

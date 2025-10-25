/*	HEADER FOR FILE I/O
 *	copyright (c) 1979 by Whitesmiths, Ltd.
 */

#ifndef __FIO__
#define __FIO__ 1

/*	codes for i_flag
 */
#define IDUMP	0000001
#define ILOCK	0000002
#define IMOUNT	0000004
#define IMAKE	0000010
#define IWANT	0000020
#define IXXX	0000040
#define ITRASH	0000100
#define ITRUNC	0000200
#define IFLOCK	0000400
#define IUTIME	0001000

/*	codes for i_mode
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
#define MODMASK	0007777

/*	file types
 */
#define S_ISDIR(m)	(((BITS) (m) & I_TYPE) == I_DIR)
#define S_ISCHR(m)	(((BITS) (m) & I_TYPE) == I_CHR)
#define S_ISBLK(m)	(((BITS) (m) & I_TYPE) == I_BLK)
#define S_ISREG(m)	(((BITS) (m) & I_TYPE) == I_REG)
#define S_ISFIFO(m)	(((BITS) (m) & (I_TYPE|I_FIFO|0111)) == (I_REG|I_FIFO))
#define S_ISAUTO(m)	(((BITS) (m) & (I_TYPE|I_AUTO)) == (I_BLK|I_AUTO))
#define S_ISDEV(m)	(((BITS) (m) & (I_CHR&I_BLK)))
#define S_ISLOCK(m)	(((BITS) (m) & (I_SGID|0111)) == I_SGID)
#define FCHR_MAX	0x01000000L

/*	codes for f_flag
 */
#define F_READ		0000001
#define F_WRITE		0000002
#define F_NDELAY	0000004
#define F_APPEND	0000010
#define F_PHYSIO	0000020
#define F_CHR		0000100
#define F_PIPE		0000200
#define F_NONBLOCK	F_NDELAY

/*	codes for file I/O
 */
#define F_CREAT		0000400
#define F_TRUNC		0001000
#define F_EXCL		0002000

/*	codes for fcntl
 */
#define F_DUPFD		0
#define F_GETFD 	1
#define F_SETFD 	2
#define F_GETFL 	3
#define F_SETFL 	4
#define F_GETLK		5
#define F_SETLK		6
#define F_SETLKW	7

/*	lock types
 */
#define F_UNLCK		0
#define F_RDLCK		F_READ
#define F_WRLCK		F_WRITE

/*	file lock structure
 */
struct flock {
	FLOCK	*l_next;
	PROC	*l_proc;
	ULONG	l_start;
	ULONG	l_len;
	UTINY	l_type;
	UTINY	l_whence;
	COUNT	l_pid;
	};
#define l_sysid l_next

/*	the file control structure
 */
struct fvar {
	INODE *f_inode;
	LONG f_offset;
	UTINY f_flag;
	UTINY f_refs;
	};

/*	codes for i_wait
 */
#define INO_WAIT	0
#define	FIFO_OREAD	1
#define FIFO_OWRITE	2
#define FIFO_READ	3
#define FIFO_WRITE	4

/*	the in core inode control structure
 */
struct inode {
	TEXT *next;
	FLOCK *i_flock;
	BYTES i_wait;
	BITS i_flag;
	UCOUNT i_refs;
	UCOUNT i_rdoff;
	UCOUNT i_rdrefs;
	BLOCK i_blast;
	DEV i_dev;			/* getstat returns from here */
	INUM i_ino;
	BITS i_mode;		/* same as disk copy from here */
	UTINY i_nlink;
	UID i_uid;
	UID i_gid;
	UTINY i_size0;
	UCOUNT i_size1;
	BLOCK i_addr[8];
	};

#define MAXLINK	0377

/*	the mount control structure
 */
#define MOUNT	struct mount
struct mount {
	TEXT *next;
	INODE *m_inode;
	DEV m_dev;
	DEV m_pdev;
	INUM m_pino;
	TBOOL m_ronly;
	};

#endif

/*	SHARED FILE CONTROL HEADER
 *	copyright (c) 1985 by Whitesmiths, Ltd.
 */

#ifndef __FCNTL__
#define __FCNTL__	1

/*	open flags
 */
#define O_RDONLY	00		/* read only */
#define O_WRONLY	01		/* write only */
#define O_RDWR		02		/* read/write */
#define O_NDELAY	04		/* non-blocking i/o */
#define O_NONBLOCK	O_NDELAY
#define O_APPEND	010		/* append */
#define O_PHYSIO	020
#define O_CREAT		0400	/* create */
#define O_TRUNC		01000	/* truncate */
#define O_EXCL		02000	/* exclusive open */
#define O_XTYPE		010000	/* extended type field */
#define O_BUF		020000	/* buffered write, used only by WSL i/o for 3.0 */
#define O_REUSE		040000	/* reuse FILE structure (as in freopen) */
#define O_BIN		0100000	/* open file for binary i/o */
#if 0
#define O_SYNC		xxx
#endif

/*	codes for fcntl
 */
#define F_DUPFD		0
#define F_GETFD 	1
#define F_SETFD		2
#define F_GETFL 	3
#define F_SETFL 	4
#define F_GETLK		5
#define F_SETLK		6
#define F_SETLKW	7

/* CONSTANTS FOR THE LOCKF FUNCTION
 */

#ifndef __LOCKF__
#define __LOCKF__ 1
/* constants for "access" function
 */
#define R_OK	4	/* Test for read permission */
#define W_OK	2	/* Test for write permission */
#define X_OK	1	/* Test for execute permission */
#define F_OK	0	/* Test for file exists */

/* constants for "lockf" 
 */
#define F_ULOCK	0	/* Unlock locked region */
#define F_LOCK	1	/* Lock a region for exclusive use */
#define F_TLOCK	2	/* Test and lock a region */
#define F_TEST	3	/* Test for locked region */

/*	lock types
 */
#define F_UNLCK		0
#define F_RDLCK		1
#define F_WRLCK		2

/*	file lock structure
 */
struct flock {
	unsigned int	l_sysid;
	unsigned int	l_proc; /* struct proc * */
	unsigned long	l_start;
	unsigned long	l_len;
	unsigned char	l_type;
	unsigned char	l_whence;
	short			l_pid;
};

#endif

int fcntl(int fd, int cmd, ...);

#endif

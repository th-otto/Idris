/*	HEADER FOR IDRIS SYSTEM
 *	copyright (c) 1979 by Whitesmiths, Ltd.
 */

#ifndef __RES__
#ifndef __IDRIS__
#define __IDRIS__ 1
#define __RES__ 1

#ifndef __STDEFS__
#ifndef __STDLIB__
#ifndef __STRING__
typedef unsigned int size_t;
#endif
#endif
#endif

/*	basics
 */
#define BLOCK	unsigned short
#define BUF		struct buf
#define DEV		unsigned short
#define DEVTAB	struct devtab
#define ERROR	short
#define FID		short
#define FLOCK	struct flock
#define FVAR	struct fvar
#define INODE	struct inode
#define INUM	unsigned short
#define JMPBUF	_jmp_buf
#define PID		short
#define PROC	struct proc
#define UID		unsigned char
#define USER	struct user
#define ZLIST	struct zlist

#define I_READ	000400
#define I_WRITE	000200
#define I_EXEC	000100

#define NCRE	01
#define NDEL	02
#define NSYS	04

#define NODEV	0
#define NOSIG	1
#define ROOTINO	1

/*	the I/O device designator
 */
#define dminor(dev)	((dev) & BYTMASK)
#define dmajor(dev) ((DEV) (dev) >> 8)
struct _minmaj {
	UTINY d_minor;
	UTINY d_major;
	};

/*	the block device switch table entry
 */
typedef struct {
	BOOL (*d_open)(const char *, int);
	VOID (*d_close)(int);
	VOID (*d_strat)(void);
	DEVTAB *d_tab;
	TEXT *d_bname;
	} BDEVSW;

struct sgtty;

/*	the character device switch table entry
 */
typedef struct {
	BOOL (*d_open)(const char *, int);
	VOID (*d_close)(int);
	COUNT (*d_read)(int fd, void *buff, size_t count);
	COUNT (*d_write)(int fd, void *buff, size_t count);
	VOID (*d_sgtty)(struct sgtty *);
	TEXT *d_cname;
	} CDEVSW;

/*	codes for u_error
 */
#define EPERM	1
#define ENOENT	2
#define ESRCH	3
#define EINTR	4
#define EIO		5
#define ENXIO	6
#define E2BIG	7
#define ENOEXEC	8
#define EBADF	9
#define ECHILD	10
#define EAGAIN	11
#define ENOMEM	12
#define EACCES	13
#define ENOTBLK	15
#define EBUSY	16
#define EEXIST	17
#define EXDEV	18
#define ENODEV	19
#define ENOTDIR	20
#define EISDIR	21
#define EINVAL	22
#define ENFILE	23
#define EMFILE	24
#define ENOTTY	25
#define ETXTBSY	26
#define EFBIG	27
#define ENOSPC	28
#define ESPIPE	29
#define EROFS	30
#define EMLINK	31
#define EPIPE	32
#define EDEADLK	33
#define ENOLCK	34
#define ENOSYS	100
#define EFAULT	106

/*	priorities
 */
#define PLOCK	(-20)
#define PSWAP	(-3)
#define PIIO	(-2)
#define PBIO	(-1)
#define PITY	0
#define POTY	0
#define PNORM	5
#define PINIT	5
#define PFLOCK	5
#define PPIPE	6
#define PSLEEP	7
#define PWAIT	8
#define PLOW	(PNORM+20)

/*	signals
 */
#define SIGHUP	1
#define SIGINT	2
#define SIGQIT	3
#define SIGINS	4
#ifndef SIGTRC
#define SIGTRC	5
#endif
#ifndef SIGRNG
#define SIGRNG	6	/* IOT */
#endif
#ifndef SIGDOM
#define SIGDOM	7	/* EMT */
#endif
#ifndef SIGFPT
#define SIGFPT	8
#endif
#define SIGKIL	9
#define SIGBUS	10
#ifndef SIGSEG
#define SIGSEG	11
#endif
#define SIGSYS	12
#define SIGPIPE	13
#define SIGALRM	14
#define SIGTERM	15
#ifndef SIGSVC
#define SIGSVC	16
#endif
#define SIGUSR	17
#define NSIG	18	/* must be last sig + 1 */

/*	uname system call
 */
#define SYS_NMLN	8
#define UNAMESZ		(5*SYS_NMLN)

/*	trapout control block
 */
typedef struct {
	TEXT *next;
	VOID (*on_fn)(void);
	BYTES on_a1, on_a2;
	} ONUNIT;

#endif
#endif

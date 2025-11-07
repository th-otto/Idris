#include <std.h>
#include <limits.h>
#include <sys/res.h>
#include <sys/bio.h>
#include <sys/usr.h>
#include <sys/stat.h>
#include <sys/fio.h>
#include <sys/sup.h>
#include <stddef.h>

/*	set up prototyping
 */
#ifndef __
#ifdef _PROTO
#define __(a)	a
#else
#define __(a)	()
#endif
#endif

#define BLOCK_SIZE_SHIFT 9
#define BLOCK_SIZE ((unsigned int)(1 << BLOCK_SIZE_SHIFT))

#define INODES_PER_BLOCK ((unsigned int)(BLOCK_SIZE / sizeof(FINODE)))

struct _tvec;

#ifndef FALSE
#define FALSE 0
#define TRUE  1
#endif

extern const char *_wrierr;
extern const char *_reaerr;

/*
 * control function entry counts in profiling
 */
extern TBOOL _penable;

/*
 * end profiling
 */
void (*_proend(void))(void);

/*
 * start profiling
 */
struct _prof {
	UCOUNT config;
	UCOUNT esize;
	BYTES pbuf;
	BYTES psize;
	BYTES offset;
	BYTES scale;
	BYTES tbias;
	BYTES ebias;
	const char *fname;
};
void *_profil(struct _prof *p);

/*
 * ask for password
 */
char *askpw(char kbuf[PASS_MAX], const char *key);

/*
 * get user response to question
 */
BOOL asure(const char *str);

/*
 * convert time vector to ASCII string
 */
char *atime(struct _tvec *vt, char *s);

/*
 * return code given speed text
 */
UCOUNT baudcode(const char *s);

/*
 * list of speeds supported by IDRIS drivers
 */
extern const char *baudlist[];

/*
 * return text speed given speed code
 */
const char *baudtext(UCOUNT c);

/*
 * clear standard sized buffer
 */
void clrbuf(void *buf);

/*
 * encode password
 */
char *codepw(const char *loginid, char kbuf[PASS_MAX]);

/*
 * copy an inode converting between native and filesystem
 */
FINODE *cpyi(FINODE *dest, const FINODE *src);

/*
 * flush out any pending inode writes
 */
void flushi(int fd);

/*
 * find modified or accessed time of file
 */
LONG ftime(int fd, BOOL modflg);

/*
 * get filesystem block
 */
BOOL getblk(int fd, void *buf, BLOCK bno);

/*
 * get device name
 */
int getdn(char *buf, const char *fname, BOOL mode);

/*
 * get inode from filesystem
 */
FINODE *geti(int fd, FINODE *buf, INUM ino);

/*
 * read and sort directory
 */
struct dirent *getlinks(const char *pathname, unsigned int *pnentries, long size);

/*
 * retrieve field from password file
 */
char *getpw(const char *matchstr, unsigned int matchfld, unsigned int wantfld);

/*
 * find home block of an inode
 */
BLOCK inblk(INUM ino);

/*
 * get inode offset within block
 */
#define _ioff(buf, ino) ((unsigned char *)(buf) + (((unsigned int)(ino) - 1U) & (INODES_PER_BLOCK - 1)) * sizeof(FINODE))
void *ioff(void *buf, INUM ino);

/*
 * return TRUE if mode is a directory
 */
int isdir(mode_t mode);

/*
 * get size of file
 */
ULONG lsize(FINODE *pi);

/*
 * convert inode information to readable form
 */
char *lslin(char *buf, FINODE *pnode, BOOL grp, BOOL atim);

/*
 * convert system time to local time
 */
struct _tvec *ltime __((struct _tvec *pv, ULONG lt));

/*
 * map logical block to physical
 */
BLOCK mapblk(int fd, FINODE *pi, BLOCK lbn);

/*
 * turn on or off messages to current terminal
 */
BOOL mesg(BOOL new);

/*
 * make directory
 */
int mkdir(const char *pathname, mode_t mode);

/*
 * move file
 */
ERROR mv(const char *old, const char *new);

/*
 * get parent name of file
 */
char *parent(char *buf, const char *pathname);

/*
 * test permissions of file
 */
BOOL perm(struct stat *st, mode_t mask);

/*
 * put filesystem block
 */
BOOL putblk(int fd, const void *buf, BLOCK bno);

/*
 * put inode to filesystem
 */
void puti(int fd, FINODE *pi, INUM ino);

/*
 * read directory on unmounted filesystem
 */
struct idir *rdir(int fd, FINODE *pi, BYTES lno);

/*
 * remove directory
 */
int rmdir __((const char *pathname));

/*
 * execute shell command escape
 */
int shell(const char *cmd, const char *fname, int flags);

/*
 * convert system time to Greenwich Mean Time
 */
struct _tvec *vtime __((struct _tvec *pv, ULONG lt));

/*
 * write directory to unmounted filesystem
 */
void wdir(int fd, FINODE *pi);

/*
 * read and sort who file
 */
#ifdef __WHO__
WHO *who(unsigned int *n, const char *fname);
#endif

const char *logname(void);
int create(const char *filename, int mode);


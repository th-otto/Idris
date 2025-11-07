#include <std.h>
#include <sys/res.h>
#include <sys/bio.h>
#include <sys/usr.h>
#include <sys/stat.h>
#include <sys/fio.h>
#include <sys/sup.h>
#include <stddef.h>

#define MAJOR_MEM         0
#  define MINOR_MEM_KMEM   1
#  define MINOR_MEM_NULL   2
#  define MINOR_MEM_PS     3
#  define MINOR_MEM_MYPS   4
#  define MINOR_MEM_MOUNT  5
#  define MINOR_MEM_INODE  6
#  define MINOR_MEM_WHERE  7
#  define MINOR_MEM_BNAMES 8
#  define MINOR_MEM_CNAMES 9
#  define MINOR_MEM_ZERO   10
#  define MINOR_MEM_TTY    11
#  define MINOR_MEM_STAT   12
#define MAJOR_CON         1
#  define MINOR_CON_CONSOLE 0
#  define MINOR_CON_MIDI    1
#  define MINOR_CON_MOUSE   2
#  define MINOR_CON_IKBD    3
#  define MINOR_CON_CLOCK   4
#  define MINOR_CON_IKBDX   (MINOR_CON_IKBD + 64)
#define MAJOR_SER         2
#define MAJOR_LP          3
#define MAJOR_FD          4
#define MAJOR_HD          5
#define MAJOR_MD          6
#define MAJOR_MSG         7
#define MAJOR_FPP         8
#define MAJOR_PTY_MASTER  9
#define MAJOR_PTY_SLAVE  10
#define MAJOR_SOCKET     11
#define MAJOR_SEL        12

/* MC68000 MACHINE INTERFACE
 */
typedef int _jmp_buf[9];

#ifdef __GNUC__
#define UNUSED(x) (void)(x)
#else
#define UNUSED(x)
#endif

/*
 * uerror.c
 */
int uerror(int err);
BYTES setcount(BYTES count);
long setseek(long offset);

/*
 * inode.c
 */
struct inode *geti(DEV dev, INUM ino);
void *iboff(void *buf, INUM ino);
ULONG lsize(struct inode *ino);


/*
 * device.c
 */
extern BDEVSW const nobdev;
extern CDEVSW const nocdev;
extern const BDEVSW *const blkdevs[];
extern unsigned int nblkdev;
extern const CDEVSW *const chrdevs[];
extern unsigned int cblkdev;

void nodev(void);


/*
 * fppdev.c
 */
extern struct devtab fpptab;
extern BDEVSW const fppbdev;
extern CDEVSW const fppcdev;
extern char *fppproc;

BOOL fppopen(DEV dev, short rw);
void fppclose(DEV dev, short rw);
COUNT fppread(DEV dev, short rw);
COUNT fppwrite(DEV dev, short rw);
void fppsgtty(DEV dev, void *arg);


/*
 * mddev.c
 */
extern BDEVSW const mdbdev;
extern CDEVSW const mdcdev;


/*
 * condev.c
 */
extern CDEVSW const concdev;


/*
 * memdev.c
 */
extern CDEVSW const memcdev;


/*
 * lpdev.c
 */
extern CDEVSW const lpcdev;


/*
 * serdev.c
 */
extern CDEVSW const sercdev;


/*
 * fddev.c
 */
extern BDEVSW const fdbdev;
extern CDEVSW const fdcdev;


/*
 * hddev.c
 */
extern BDEVSW const hdbdev;
extern CDEVSW const hdcdev;


/*
 * msgdev.c
 */
extern BDEVSW const msgbdev;
extern CDEVSW const msgcdev;


/*
 * ptmdev.c
 */
extern CDEVSW const ptmcdev;


/*
 * ptsdev.c
 */
extern CDEVSW const ptscdev;


/*
 * socdev.c
 */
extern CDEVSW const soccdev;


/*
 * seldev.c
 */
extern CDEVSW const selcdev;


/*
 * swap.c
 */
ULONG tflip(ULONG val);



void getstat(struct inode *ino, struct stat *st);

int outbuf(const void *src, void *dst, BYTES size);
void movbuf(const void *src, void *dst, BYTES size);

void syfstat(void *args);
void _sytimes(void *args);
void syprof(void *args);

struct fvar *mapfd(int fd);

void *ireadb(DEV dev, INUM ino);
void brelse(void *buf);
void *iboff(void *buf, INUM ino);

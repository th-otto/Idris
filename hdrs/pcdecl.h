/*	PROTOTYPE DECLARATIONS FOR LIBC FUNCTIONS
 *	copyright (c) 1985 by Whitesmiths, Ltd.
 */

#ifndef	__PCDECL__
#define	__PCDECL__	1

struct _msub;
struct _file;

/*	set up prototyping
 */
#ifndef __
#ifdef _PROTO
#define __(a)	a
#else
#define __(a)	()
#endif
#endif

ARGINT round __((DOUBLE d));
ARGINT trunc __((DOUBLE d));
BOOL cmpbuf __((TEXT *s1, TEXT *s2, BYTES n));
BOOL cmpstr __((TEXT *s1, TEXT *s2));
BOOL getin __((BYTES *pac, TEXT ***pav));
BOOL match __((TEXT *buf, BYTES n, TEXT *pat));
BOOL prefix __((TEXT *s1, TEXT *s2));
BOOL remark __((TEXT *s1, TEXT *s2));
BYTES amatch __((TEXT *buf, BYTES n, BYTES indx, TEXT *pat, struct _msub *pmsub));
BYTES btod __((TEXT *is, BYTES n, DOUBLE *pdnum));
BYTES btoi __((TEXT *s, BYTES n, BYTES *i, COUNT base));
BYTES btol __((TEXT *s, BYTES n, ULONG *l, COUNT base));
BYTES btos __((TEXT *s, BYTES n, UCOUNT *i, COUNT base));
BYTES cpybuf __((TEXT *s1, TEXT *s2, BYTES an));
BYTES decode __((TEXT *s, BYTES n, TEXT *f, ...));
BYTES dtoe __((TEXT *is, DOUBLE d, COUNT p, COUNT g));
BYTES dtof __((TEXT *is, DOUBLE d, COUNT p, COUNT g));
BYTES enter __((BYTES (*pfn)(void), BYTES arg));
BYTES fill __((TEXT *s, BYTES n, TEXT c));
BYTES getl __((struct _file *pf, TEXT *s, BYTES n));
BYTES getlin __((TEXT *s, BYTES n));
BYTES inbuf __((TEXT *is, BYTES n, TEXT *p));
BYTES instr __((TEXT *is, TEXT *p));
BYTES itob __((TEXT *is, ARGINT n, COUNT base));
BYTES lenstr __((TEXT *is));
BYTES lower __((TEXT *s, BYTES n));
BYTES ltob __((TEXT *is, LONG ln, COUNT base));
BYTES notbuf __((TEXT *is, BYTES n, TEXT *p));
BYTES notstr __((TEXT *is, TEXT *p));
BYTES putl __((struct _file *pf, TEXT *s, BYTES n));
BYTES putlin __((TEXT *s, BYTES n));
BYTES scnbuf __((TEXT *s, BYTES n, TEXT c));
BYTES scnstr __((const char *s, TEXT c));
BYTES squeeze __((TEXT *s, BYTES n, TEXT c));
BYTES stob __((TEXT *is, COUNT n, COUNT base));
BYTES subbuf __((TEXT *ps, BYTES ns, TEXT *pp, BYTES np));
BYTES substr __((TEXT *ps, TEXT *pp));
COUNT doesc __((TEXT **pp, TEXT *magic));
COUNT encode __((TEXT *s, BYTES n, TEXT *f, ...));
COUNT getf __((struct _file *pf, TEXT *fmt, ...));
COUNT getfmt __((TEXT *fmt, ...));
COUNT lstoi __((TEXT *s));
COUNT ordbuf __((TEXT *p, TEXT *q, COUNT n));
COUNT usage __((TEXT *msg));
FD getbfiles __((BYTES *pac, TEXT ***pav, FD dfd, FD efd, BYTES rsize));
FD getfiles __((BYTES *pac, TEXT ***pav, FD dfd, FD efd));
UCOUNT lstou __((TEXT *s));
UCOUNT xstos __((TEXT *s, BOOL lsfmt));
VOID errfmt __((TEXT *fmt, ...));
VOID _error __((const char *s1, const char *s2));
VOID leave __((BYTES val));
VOID mapchar __((TEXT c, TEXT *buf));
VOID prtheap __((VOID));
VOID putf __((struct _file *pf, TEXT *fmt, ...));
VOID putfmt __((TEXT *fmt, ...));
VOID _putstr __((FD fd, ...));
VOID sort __((ARGINT n, COUNT (*ordf)(void), VOID (*excf)(void), TEXT *base));
void onintr __((void (*f)(int)));
COUNT _rawmode __((FD fd, COUNT nmode));
BOOL _devname __((char *s, UCOUNT mdev, BOOL cspec));

int _btoi __((const char *s, int len, int *val, int base));

#endif

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

int _round __((DOUBLE d));
int _trunc __((DOUBLE d));
BOOL _cmpbuf __((const void *s1, const void *s2, BYTES n));
BOOL cmpbuf __((const void *s1, const void *s2, BYTES n));
BOOL _cmpstr __((const char *s1, const char *s2));
BOOL cmpstr __((const char *s1, const char *s2));
BOOL getin __((BYTES *pac, TEXT ***pav));
BOOL match __((TEXT *buf, BYTES n, TEXT *pat));
BOOL _prefix __((const char *s1, const char *s2));
BOOL prefix __((const char *s1, const char *s2));
BOOL _remark __((const char *s1, const char *s2));
BOOL remark __((const char *s1, const char *s2));
BYTES amatch __((TEXT *buf, BYTES n, BYTES indx, TEXT *pat, struct _msub *pmsub));
BYTES _btod __((TEXT *is, BYTES n, DOUBLE *pdnum));
BYTES _btoi __((const char *s, BYTES n, int *i, int base));
BYTES _btol __((const char *s, BYTES n, long *l, int base));
BYTES _btos __((const char *s, BYTES n, short *i, int base));
BYTES _cpybuf __((void *s1, const void *s2, BYTES an));
BYTES decode __((char *s, BYTES n, const char *fmt, ...));
double _dtento __((double d, int exp));
BYTES _dtoe __((char *is, double d, COUNT p, COUNT g));
BYTES _dtof __((char *is, double d, COUNT p, COUNT g));
BYTES _enter __((BYTES (*pfn)(BYTES arg), BYTES arg));
void _error __((const char *s1, const char *s2));
BYTES fill __((void *s, BYTES n, TEXT c));
BYTES getl __((void *arg, char *s, BYTES n));
BYTES getlin __((TEXT *s, BYTES n));
BYTES inbuf __((const char *is, BYTES n, const char *p));
BYTES instr __((const char *is, const char *p));
BYTES _itob __((char *is, int n, int base));
BYTES itob __((char *is, int n, int base));
char *itlos __((char *is, int val));
char *ltlos __((char *is, LONG val));
BYTES _lenstr __((const char *is));
BYTES lower __((TEXT *s, BYTES n));
BYTES _ltob __((char *is, LONG ln, int base));
BYTES ltob __((char *is, LONG ln, int base));
BYTES notbuf __((const char *is, BYTES n, const char *p));
BYTES notstr __((const char *is, const char *p));
BYTES putl __((void *arg, const char *s, BYTES count));
BYTES putlin __((const char *s, BYTES n));
BYTES _scnbuf __((const void *s, BYTES n, char c));
BYTES _scnstr __((const char *s, char c));
BYTES squeeze __((TEXT *s, BYTES n, char c));
BYTES _stob __((char *is, COUNT n, int base));
BYTES stob __((char *is, COUNT n, int base));
BYTES subbuf __((const void *ps, BYTES ns, const void *pp, BYTES np));
BYTES substr __((const char *ps, const char *pp));
int doesc __((TEXT **pp, const char *magic));
#ifdef __STDARG__
COUNT _encode __((char *s, BYTES n, const char *fmt, va_list args));
#endif
COUNT encode __((char *s, BYTES n, const char *fmt, ...));
COUNT getf __((struct _file *pf, const char *fmt, ...));
COUNT getfmt __((const char *fmt, ...));
COUNT lstoi __((const COUNT *s));
LONG lstol __((const ULONG *s));
ULONG xstol __((const char *s, BOOL lsfmt));
UCOUNT xstos __((const char *s, BOOL lsfmt));
UCOUNT lstou __((const UCOUNT *s));
COUNT ordbuf __((TEXT *p, TEXT *q, COUNT n));
COUNT usage __((const char *msg));
FD getbfiles __((BYTES *pac, TEXT ***pav, FD dfd, FD efd, BYTES rsize));
FD getfiles __((BYTES *pac, TEXT ***pav, FD dfd, FD efd));
VOID errfmt __((const char *fmt, ...));
VOID _leave __((BYTES val));
VOID mapchar __((TEXT c, TEXT *buf));
VOID prtheap __((VOID));
VOID putf __((struct _file *pf, const char *fmt, ...));
BYTES putfmt __((const char *fmt, ...));
VOID _putstr __((FD fd, ...));
void onintr __((void (*f)(int)));
COUNT _rawmode __((FD fd, COUNT nmode));
BOOL _devname __((char *s, UCOUNT mdev, BOOL cspec));
BOOL devname __((char *s, register UCOUNT mdev, register BOOL cspec));
double _sqr __((double d));

struct _ordf {
	UCOUNT len;
	unsigned char buf[1];
};
struct _sortarg {
	void *base;
	BYTES nmemb;
	BYTES size;
	int (*compar) __((const void *, const void *));
};
VOID sort __((BYTES n, int (*ordf)(BYTES i, BYTES j, struct _sortarg **arg), VOID (*excf)(BYTES i, BYTES j, struct _sortarg **arg), struct _sortarg *arg));

#endif

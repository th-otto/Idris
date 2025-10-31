#ifndef __STDEFS__
#include <stddef.h>
#endif

#ifdef __GNUC__
#define UNUSED(x) (void)(x)
#else
#define UNUSED(x)
#endif

#ifndef FALSE
#define FALSE 0
#define TRUE  1
#endif

extern const char **environ;
extern char *_paths;
extern const char *_pname;
extern char *_shell;

char *_getenv(const char *p);
BYTES _lenstr(const char *str);
int _cmpbuf(const void *p1, const void *p2, BYTES len);
BITS _getmod(const char *fname);
int _rename(const char *from, const char *to);
int _remove(const char *f);

void (*_signal (int signo, void (*pfunc)(int sig)))(int sig);

COUNT _xecv(const char *cmd, FD sin, FD sout, COUNT flags, const char **pargs);

#ifdef __STDIO__
extern FILE _stdin;
extern FILE _stdout;
extern FILE _stderr;
extern FILE *_pfile;
#endif
struct _mbuf {
	char *s;
	BYTES maxcount;
	BYTES count;
};
#ifdef __STDARG__
BYTES _putf(BYTES (*putf)(struct _mbuf *buf, const char *s, BYTES count), struct _mbuf *buf, const char *fmt, va_list args);
#endif

void _astat(void);
void _cstat(void);
void _lstat(void);

#ifdef __SORT__
extern int entval;
extern short firstkey;
extern char key[198];
extern KEY defsort;
#endif

#ifdef __TIMEH__
extern char _savtime[];
extern char _stdtime[];
extern char *_edt;
extern char *_est;
extern char _zone[];
extern int _dst;
extern int _tzinit;
extern long _timezone;
extern int _tzmins;
#endif
extern size_t _hunk;
extern size_t _hinf[];
extern size_t _hbot;
extern size_t _heap;
extern size_t _htop;
const char *_domerr;
const char *_memerr;
const char *_ranerr;
extern void *_stop;
extern int _fnext;
extern int _tfile;
extern char _rbuf[];

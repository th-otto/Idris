#ifndef __STDEFS__
#include <stddef.h>
#endif
#ifndef __TYPES__
#include <sys/types.h>
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
size_t _lenstr(const char *str);
int _cmpbuf(const void *p1, const void *p2, size_t len);
mode_t _getmod(const char *fname);
int _rename(const char *from, const char *to);
int _remove(const char *f);

void (*_signal (int signo, void (*pfunc)(int sig)))(int sig);

#ifdef __STDIO__
extern FILE _stdin;
extern FILE _stdout;
extern FILE _stderr;
extern FILE *_pfile;
#define _FIOEOF          0x0001
#define _FIOERR          0x0002
#define _FIOREAD         0x0004
#define _FIOWRITE        0x0008
#define _FIOWASREAD      0x0010
#define _FIOWASWRITTEN   0x0020
#define _FIOBUFALLOCATED 0x0040
#define _FIOALLOCATED    0x0080
#define _FIOFULLBUFFERED 0x0100
#define _FIOUNBUFFERED   0x0200
#define _FIOX400         0x0400
int _flush(int fd);
int _chkio(FILE *stream, int forwrite);
int _doclose(FILE *stream, int freeit);
long _doread(FILE *stream, unsigned char *s, size_t n);
long _dowrite(FILE *stream, const void *s, size_t n, int doflush);
#ifdef __STDLIB__
onexit_t _doflush(void);
#endif
FILE **_onlist(FILE *stream, FILE **list);
FILE *_finit(FILE *stream, int fd, int type);
FILE *finit(FILE *stream, int fd, int type);
int _parstype(const char *mode);
struct tmpfile {
	struct tmpfile *link;
	char filename[14];
	FILE *fp;
};
#endif
struct _mbuf {
	char *s;
	size_t maxcount;
	size_t count;
};
#ifdef __STDARG__
/* arg is either a FILE * or a char * */
int _scan(const void *arg, int isstring, const char *fmt, va_list args);
int _print(int (*putc)(const void *arg, int count, void *dst), void *arg, const char *format, va_list args);
int _putbuf(const void *arg, int count, void *dst);
int _cache(const void *arg, int count, void *_dst);
/* arg is either a FILE * or a struct _mbuf */
size_t _putf(size_t (*putf)(void *arg, const char *s, size_t count), void *arg, const char *fmt, va_list args);
size_t _getf(size_t (*getf)(void *rg, char *s, size_t n), void *arg, const char *fmt, va_list args);
#endif
void _fwrite(int fd, const void *buf, size_t len);
size_t _fread(int fd, void *buf, size_t len);

void _astat(void);
void _cstat(void);
void _lstat(void);

void *_free(void *ptr, void *link);

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
extern const char *_domerr;
extern const char *_memerr;
extern const char *_ranerr;
extern const char *_filerr;
extern const char *_fioerr;
extern const char *_wrierr;
extern const char *_reaerr;
extern void *_stop;
#ifdef __STDLIB__
extern onexit_t _fnext;
#endif
extern struct tmpfile *_tfile;
extern char _rbuf[];

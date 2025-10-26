#ifdef __GNUC__
#define UNUSED(x) (void)(x)
#else
#define UNUSED(x)
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

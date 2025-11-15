#define SUPPORT_CMAP 0

struct double_has_wrong_size { int dummy : sizeof(double) == 8 ? 1 : -1; };

#define ISDIGIT(c) ((c) >= '0' && (c) <= '9')
#define ISUPPER(c) ((c) >= 'A' && (c) <= 'Z')
#define ISLOWER(c) ((c) >= 'a' && (c) <= 'z')
#define ISALPHA(c) (ISUPPER(c) || ISLOWER(c))
#define ISWHITE(c) ((c) <= ' ' || (c) >= 0177)


/*
 * p0eval.c
 */
extern unsigned char const digfr[];
extern unsigned char const digto[];

size_t dobesc(char *buf, char *s, size_t n);
TLIST *expr(TLIST *p, long *plv);
LEX dopunct(TLIST **pp);
BOOL eval(TLIST *p);
long bton(TLIST *p, BOOL *islong, BOOL *isunsigned);


/*
 * p0lex.c
 */
void putcode(const char *fmt, ...);
void putls(TLIST *p);
void putfile(void);
void ptline(void);


/*
 * p0subs.c
 */
#if SUPPORT_CMAP
extern unsigned char cmap[256];
#define cmap(c) cmap[(unsigned char)(c)]
#else
#define cmap(c) c
#endif
extern PRETAB const bltintab[];

TLIST *doexp(TLIST *qs, TLIST *qend);
char *getfinclude(TLIST *p);
void install(const char *s, size_t n, char *pd);
char *lookup(const char *s, size_t n, DEF **defn);
INCL *nxtfile(void);
INCL *inpfile(FILE *fd, const char *fname);
void p0error(const char *fmt, ...) __attribute__((format(printf, 1, 2)));
void fatal(const char *fmt, const char *str) __attribute__((format(printf, 1, 0)));
void predef(ARGS *p);
BOOL punct(TLIST *p, char c);
#define PUNCT(p, c) ((p)->ntext == 1 && (p)->text[0] == c)
LEX scntab(const PRETAB *p, size_t hi, char *s, size_t n);
TLIST *stotl(char *s, BOOL *in_comment);
void undef(char *s, size_t n);
TLIST *fretlist(TLIST *p, TLIST *last);


/*
 * p0main.c
 */
extern BOOL pflag;
extern BOOL liflag;
extern BOOL oldflag;
extern BOOL pasflag;
extern int pasline;
extern BOOL stdflag;
extern BOOL xflag;
extern INCL *pincl;
extern FILE *errfd;
extern FILE *outfd;
extern int nerrors;
extern int inif;
extern int inincl;
extern unsigned char escname[];
extern char *iprefix;
extern char *mapfile;
extern int argc;
extern int lineno;
extern char **argv;


TLIST *getex(BOOL flag);
double dtento(double x, int exp);
void *xmalloc(size_t n);

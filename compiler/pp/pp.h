extern double _dtens[];

struct double_has_wrong_size { int dummy : sizeof(double) == 8 ? 1 : -1; };

#define ISDIGIT(c) ((c) >= '0' && (c) <= '9')
#define ISUPPER(c) ((c) >= 'A' && (c) <= 'Z')
#define ISLOWER(c) ((c) >= 'a' && (c) <= 'z')
#define ISALPHA(c) (ISUPPER(c) || ISLOWER(c))
#define ISWHITE(c) ((c) <= ' ' || (c) >= 0177)


/*
 * p0eval.c
 */
size_t doesc(char *buf, char *s, size_t n);
LEX dopunct(TLIST **pp);
BOOL eval(TLIST *p);


/*
 * p0lex.c
 */
void putcode(const char *fmt, ...);
void putls(TLIST *p);


/*
 * p0subs.c
 */
TLIST *doexp(TLIST *qs);
char *getfname(TLIST *p);
void install(char *s, size_t n, char *pd);
char *lookup(char *s, size_t n);
INCL *nxtfile(void);
void p0error(const char *fmt, ...);
void predef(ARGS *p);
BOOL punct(TLIST *p, char c);
LEX scntab(PRETAB *p, size_t hi, char *s, size_t n);
TLIST *stotl(char *s);
void undef(char *s, size_t n);


/*
 * p0main.c
 */
extern BOOL xflag;
extern BOOL v6flag;
extern BOOL pflag;
extern INCL *pincl;
extern FILE *errfd;
extern int nerrors;
extern char pchar;
extern char *iprefix;
extern int argc;
extern char **argv;


void *frelst(void *p, void *plast);
double dtento(double x, int exp);
void *xmalloc(size_t n);

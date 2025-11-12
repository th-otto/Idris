typedef unsigned short BITS;
typedef unsigned char TINY;

struct double_has_wrong_size { int dummy : sizeof(double) == 8 ? 1 : -1; };

#define ISUPPER(c) ((c) >= 'A' && (c) <= 'Z')
#define TOLOWER(c) (ISUPPER(c) ? (c) - 'A' + 'a' : (c))


/*
 * p1data.c
 */
extern BOOL decflag;

void datinit(SYMBOL *p);


/*
 * p1expr.c
 */
long mconst(BOOL mand);
TERM *gelist(BOOL mand);
TERM *gexpr(BOOL mand);
TERM *gtest(BOOL mand);


/*
 * p1func.c
 */
extern BITS regset;
extern long autoff;

BOOL fninit(SYMBOL *pd);


/*
 * p1gets.c
 */
LEX alt(TINY *p);
void baktok(TOKEN *t);
LEX eat(LEX lex);
TOKEN *gettok(TOKEN *t);
TOKEN *ident(TOKEN *t);
LEX need(LEX lex);
void nmerr(const char *s, const char *name);
LEX peek(LEX lex);
void p1error(const char *s);
void recover(const char *s);


/*
 * p1main.c
 */
extern BITS iregs;
extern BITS tchar;
extern BITS tint;
extern BITS tunsign;
extern BITS tfield;
extern BOOL aflag;
extern BOOL cflag;
extern BOOL dflag;
extern BOOL mflag;
extern unsigned int bndef;
extern unsigned int intsize;
extern int nlen;
extern FILE *errfd;
extern int nerrors;
extern char *infile;
extern int lineno;
extern FILE *outfd;
extern FILE *infd;
extern CASE *casetab;
extern TERM *exlist;
extern SYMBOL *lbltab;
extern LITERAL *littab;
extern SYMBOL *mostab;
extern SYMBOL *strtab;
extern SYMBOL *symend;
extern SYMBOL *symtab;
extern SYMBOL *untab;

BOOL cmptype(SYMBOL *p, SYMBOL *q);
SYMBOL *gdecl(SYMBOL *pro, BOOL abstract);
BOOL gscty(SYMBOL *pro, LEX defsc, ...);


/*
 * p1puts.c
 */
LABEL crs(void);
char *lblname(LABEL label);
size_t paddr(char *s, long by, size_t bnd);
void pauto(long by);
LABEL pcase(LABEL at);
void pcode(int c);
void pdata(const char *s, size_t bnd, BOOL ndata);
void pdef(const char *s);
void pend(void);
size_t pfloat(const double *pd, size_t n);
void pfunc(const char *s);
size_t pint(long b, size_t n);
LABEL pjf(TERM *q, LABEL fb, LABEL tb);
LABEL pjt(TERM *q, LABEL fb, LABEL tb);
LABEL pjump(LABEL to, LABEL at);
LABEL plabel(LABEL at);
void pmove(TERM *left, TERM *right);
void pref(const char *s);
void pregs(BITS r);
void pret(void);
void pspace(long by);
void pstr(const char *s, int n);
void pswitch(LABEL tab);
void pswtab(CASE **ptab, LABEL def, LABEL tab);
void ptexpr(TERM *p);
void ptint(long lo);
void ptlab(LABEL arglab);
void pvoid(TERM *expr);
TINY rbuy(BITS ty, BITS *pset);


/*
 * p1red.c
 */
TERM *reduce(TERM *q);


/*
 * p1subs.c
 */
extern size_t bndtab[];
extern size_t bytab[];
extern TINY typtab[];
extern char noname[];

long bndify(BITS ty, ATTR *at, long off);
size_t bound(BITS ty, ATTR *at);
ATTR *buymat(long m, ATTR *link);
TERM *buyop(LEX op, TERM *left, TERM *right);
ATTR *buysat(SYMBOL *stab, ATTR *link);
SYMBOL *buysym(BITS ty, ATTR *at, char *name, LEX sc);
TERM *buyterm(BITS ty, ATTR *at, const char *an, long bias, TINY idx, TINY refs);
long bytes(BITS ty, ATTR *at);
void clrsym(SYMBOL *p);
void cpynm(char *d, const char *s);
TOKEN *cpytok(TOKEN *p, TOKEN *q);
BITS dety(BITS ty);
BOOL dlit(TERM *q);
BOOL dtype(BITS ty);
void exchk(SYMBOL *p);
BOOL iscons(TERM *q);
BOOL itype(BITS ty);
SYMBOL *lookup(const char *name, SYMBOL *from, SYMBOL *to);
BITS maxify(BITS ty);
BOOL ptype(BITS ty);
SYMBOL *retype(SYMBOL *p, BITS nty);
void setad(TERM *p, const char *name, long bias, TINY idx, TINY refs);
void setty(SYMBOL *p, BITS ty, ATTR *at);
BOOL stype(BITS ty);
BITS type(BITS ty);


/*
 * p1type.c
 */
extern TINY tyops[];

void docheck(TERM *q);
BITS maxty(BITS lty, BITS rty, BITS mty);
TERM *scalify(TERM *q);
TERM *typify(TERM *q);

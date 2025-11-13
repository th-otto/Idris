#ifndef __attribute__
#ifndef __GNUC__
#define __attribute__(x)
#endif
#endif

typedef unsigned short BITS;
typedef unsigned char TINY;

#define ISDIGIT(c) ((c) >= '0' && (c) <= '9')


/*
 * p2expr.c
 */
extern size_t autmin;
extern size_t autoff;
extern BITS regset;
extern BITS regmin;
extern size_t choff;
extern EXPR exzero;

BOOL adequ(ADDR *pl, ADDR *pr);
BITS fix(EXPR *p, BITS want, BITS set, BITS ty);
BITS force(EXPR *p, BITS want, BITS set, LEX ty);
BITS move(EXPR *l, EXPR *r, BITS set);
CODE **exvoid(CODE **qb, EXPR *r);


/*
 * p2fmov.c
 */
extern const unsigned char *deref[];
extern const unsigned char *intreg[];
extern const unsigned char *ptmov[];
extern const unsigned char *reref[];
extern FTAB ftab[];

void emit(HEADER *tab, char *leave);
BITS fgen(EXPR *p, BITS reg, BITS set, const unsigned char **tab, BOOL rmatch);
const unsigned char *pick(EXPR *p, BOOL match);
BITS twant(BITS code);


/*
 * p2gen.c
 */
extern TINY ctab[];
extern BITS rtab[];
extern TINY xtab[];

BITS gen(EXPR *p, EXPR *l, EXPR *r, const unsigned char *tab, BITS set);
void putnb(const char *s, size_t off);
const char *xnm(TINY idx);


/*
 * p2jump.c
 */
extern TINY brops[];
extern const char *jtext[];
extern TINY jncops[];

BITS boolify(EXPR *p, EXPR *q, EXPR *l, EXPR *r, BITS want, BITS set);
BITS fncall(EXPR *p, BITS want, BITS set);
CODE **jcond(CODE **qb, LEX tok, HEADER *p, EXPR *l, EXPR *r);


/*
 * p2main.c
 */
extern BOOL pflag;
extern size_t xmask;
extern int lineno;
extern char funname[];
extern FILE *errfd;
extern FILE *outfd;
extern FILE *infd;
extern EXPR *exlist;

CODE *buycode(LEX inst, HEADER *hdr, size_t size);
LABEL crs(void);
HEADER *lookup(LABEL label);
const char *msp(int off);


/*
 * p2subs.c
 */
extern TINY bytype[];
extern TINY equtype[];
extern TINY regtype[];
extern char noname[];
extern TINY cmpops[];
extern TINY flpops[];
extern TINY lexops[];

void chput(const char *args, ...);
void chwrite(const char *s, size_t n);
char *chread(void);
void cpyad(ADDR *pl, ADDR *pr);
LEX gcode(void);
EXPR *gexpr(void);
void gint(long *l);
LABEL glabel(void);
char *gname(char *s);
BITS gotten(EXPR *p);
BOOL iscons(EXPR *p);
char *ln(LABEL label);
LEX needch(void);
void panic(const char *s);
BITS pref(BITS want, BITS need);
TINY rtox(BITS r);
void setad(EXPR *p, BITS ty, TINY idx, TINY refs);
BITS tempify(EXPR *p, BITS want, BITS set);
TINY xtor(TINY x);


/*
 * p2tab.c
 */
extern const unsigned char **bintab[];

void csect(int nsect);
BOOL putasm(const char *fmt, ...);
int getch(void);
void putch(int c);


/*
 * q2dbug.c
 */
void putexpr(EXPR *q, int indent);
void putterm(EXPR *q, int indent);
void putfmt(const char *fmt, ...) __attribute__((format(printf, 1, 2)));

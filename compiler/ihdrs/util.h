#ifndef FALSE
# define FALSE 0
# define TRUE  1
#endif
typedef int BOOL;

extern BOOL lsfmt;
extern const char *_pname;

typedef unsigned int uint32_t;
typedef int int32_t;
typedef unsigned short uint16_t;
typedef short int16_t;
typedef unsigned char uint8_t;
typedef signed char int8_t;

#undef max
#define max(a, b) ((a) < (b) ? (b) : (a))
#undef min
#define min(a, b) ((a) < (b) ? (a) : (b))

/* get a long in proper byte order */
uint32_t xstol(const unsigned char *s);
/* pack a long into a buffer in correct byte order*/
void ltoxs(unsigned char *b, uint32_t val);
/* get a short in proper byte order */
uint16_t xstos(const unsigned char *s);
/* pack a short into a buffer in correct byte order */
void stoxs(unsigned char *b, uint16_t val);
/* return long from pdp-endian format */
int32_t lstol(const unsigned char *s);
/* convert leading low-byte string to unsigned short */
uint16_t lstou(const unsigned char *s);
/* convert integer to leading low-byte string */
void itols(unsigned char *s, uint16_t n);
/* convert leading low-byte string to integer */
uint16_t lstoi(const uint16_t *s);
/* convert long to pdp-endian format */
void ltols(unsigned char *pl, int32_t lo);

void *buybuf(const void *s, size_t n);

size_t _btos(const char *s, size_t n, short *i, int base);
size_t _btoi(const char *s, size_t n, int *i, int base);
size_t _btol(const char *s, size_t n, long *l, int base);

int usage(const char *msg);
char *getflags(int *pac, char ***pav, const char *fmt, ...);
size_t getlin(char *s, size_t n);
FILE *getbfiles(int *pac, char ***pav, FILE *dfd, FILE *efd, int rsize);
BOOL _remark(const char *s1, const char *s2);
void _error(const char *s1, const char *s2);
void *xmalloc(size_t n);
BOOL getin(int *pac, char ***pav);

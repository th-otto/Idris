#ifndef __STRING__
#define __STRING__	1

/*	set up prototyping
 */
#ifndef __
#ifdef _PROTO
#define __(a)	a
#else
#define __(a)	()
#endif
#endif

/*	set up type not already set up
 */
#ifndef __STDEFS__
#ifndef __STDLIB__
#ifndef __STDIO__
typedef unsigned int size_t;
#endif
#endif
#endif

int bcmp(const void *src, const void *dst, int count);
void bcopy(const void *src, void *dst, int count);
void bzero(void *dst, register int count);

int ffs(long val);

char *strcat __((char *s1, const char *s2));
char *strchr(const char *str, int c);
char *strncat __((char *s1, const char *s2, size_t n));
char *strncpy __((char *s1, const char *s2, size_t n));
char *strpbrk __((const char *s1, const char *s2));
char *strrchr(const char *str, int c);
char *strtok __((char *s1, const char *s2));
int strcmp __((const char *s1, const char *s2));
int strncmp __((const char *s1, const char *s2, size_t n));
size_t strcspn __((const char *s1, const char *s2));
size_t strlen(const char *s);
size_t strspn __((const char *s1, const char *s2));

char *index(const char *str, char c);
char *rindex(const char *str, char c);

int memcmp __((const void *s1, const void *s2, size_t n));
void *memchr __((const void *s, int c, size_t n));
void *memcpy __((void *s1, const void *s2, size_t n));
void *memset __((void *s, int c, size_t n));

#endif /* __STRING__ */

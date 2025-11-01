#ifndef __CRYPT__
#define __CRYPT__ 1

/*	set up prototyping
 */
#ifndef __
#ifdef _PROTO
#define __(a)	a
#else
#define __(a)	()
#endif
#endif

char *_bldks __((char ks[16][8], const char key[8]));

char *decrypt __((char *text, const char ks[16][8]));
char *encrypt __((char *text, const char ks[16][8]));

char *crypt __((const char *phrase, const char *setting));

#endif /* __CRYPT__ */

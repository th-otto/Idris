/*	STRUCTURES FOR PASS 0
 *	copyright (c) 1978 by Whitesmiths, Ltd.
 */

#ifndef __WCONFIG__
#include "wconfig.h"
#endif

/*	the types
 */
#define PCHCON	1
#define PEOL	2
#define PIDENT	3
#define PNUM	4
#define PPUNCT	5
#define PSTRING	6

/*	the keywords
 */
#define PDEFINE	10
#define PELSE	11
#define PENDIF	12
#define PIF		13
#define PIFDEF	14
#define PIFNDEF	15
#define PINCLUD	16
#define PLINE	17
#define PSHARP	18
#define PUNDEF	19

/*	the token type
 */
#define LEX		int

/*	the linked list of included files
 */
#define INCL	struct incl

struct incl {
	struct incl *next;
	char *fname;
	int nline;
	FILE *pfio;
};

/*	the predefined keywords
 */
#define PRETAB	struct pretab

struct pretab {
	const char *prename;
	LEX pretype;
};

/*	the linked list of tokens
 */
#define TLIST	struct tlist

struct tlist {
	struct tlist *next;
	LEX type;
	char *white;
	size_t nwhite;
	char *text;
	size_t ntext;
};

/*	the argument list structure
 */
#define ALIST	struct alist

struct alist {
	struct alist *next;
	TLIST *astart;
	TLIST *aend;
};

/*	the symbol table definition entry
 */
#define DEF		struct def
#define NHASH	128
#define STRSIZE	512

struct def {
	struct def *next;
	size_t dnlen;
	char *defn;
	char dname[LENNAME];
};

/*	the argument stack
 */
#define ARGS	struct args
#define NDARGS	10

struct args {
	size_t ntop;
	char *anames[NDARGS];
};

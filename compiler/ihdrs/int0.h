/*	STRUCTURES FOR PASS 0
 *	copyright (c) 1978 by Whitesmiths, Ltd.
 */

#ifndef __WCONFIG__
#include <wconfig.h>
#endif

/*	the types
 */
#define PCHCON	 1
#define PEOL	 2
#define PIDENT	 3
#define PNUM	 4
#define PPUNCT	 5
#define PSTRING	 6
#define PQEOL    7
#define PQSTRING 8

/*	the keywords
 */
#define PDEFINE	10
#define PELIF   11
#define PELSE	12
#define PENDIF	13
#define PIF		14
#define PIFDEF	15
#define PIFNDEF	16
#define PINCLUD	17
#define PLINE	18
#define PPRAGMA 19
#define PSHARP	20
#define PUNDEF	21
#define PERROR  22

/*	the builtins
 */
#define PBIF      30
#define PBFILE    31
#define PBLINE    32
#define PBDEFINED 33

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
	char *defn;
	size_t dnlen;
	int inexpand;
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

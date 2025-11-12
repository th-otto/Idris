/*	STRUCTURES FOR PASS 1
 *	copyright (c) 1978 by Whitesmiths, Ltd.
 */

#ifndef __WCONFIG__
#include <wconfig.h>
#endif

/*	the quasi types
 */
#define LABEL	short
#define LEX		short

/*	the type bit patterns
 */
#define TFNRET	01
#define TARRAY	02
#define TPTRTO	03
#define TCHAR	004
#define TUCHAR	010
#define TSHORT	014
#define TSFIELD	020
#define TUSHORT	024
#define TLONG	030
#define TLFIELD	034
#define TULONG	040
#define TFLOAT	044
#define TDOUBLE	050
#define TSTRUCT	054
#define TUNION	060

/*	token values
 */
#define VAL		union val

union val {
	double dn;
	char an[LENNAME];
	long ln;
	struct {
		char *sptr;
		int slen;
	} x;
};

/*	the attribute list for types
 */
#define ATTR	struct attr

struct attr {
	struct attr *next;		/* SHDB ATTR * */
	union {
		long m;
		struct symbol *stab;	/* SHDB SYMBOL * */
		struct {
			unsigned char boff;
			unsigned char bsize;
		} b;
	} a;
};

/*	the case structure
 */
#define CASE	struct kase

struct kase {
	struct kase *next;
	LABEL clabel;
	long cvalue;
};

/*	the symbol table entry
 */
#define SYMBOL struct symbol

struct symbol {
	struct symbol *next;
	ATTR *at;
	VAL n;
	unsigned short ty;
	LEX sc;
	union {
		struct symbol *tagtab;	/* SHDB SYMBOL * */
		signed char reg;
		LABEL label;
		long offset;
	} s;
};

/*	expression terms
 */
#define LITERAL	struct term
#define TERM	struct term

struct term {
	struct term *next;
	ATTR *at;
	VAL n;
	unsigned short ty;
	/* ^^^ must be same as first 4 members of struct symbol */
	LEX op;
	/* ^^^ must be same type and location as sc in struct symbol */
	union {
		ATTR l;
		struct {
			struct term *left, *right, *mid;	/* SHDB TERM * */
		} o;
		struct {
			long bias;
			unsigned char idx;
			unsigned char refs;
		} v;
	} e;
};

/*	the token structure
 */
#define TOKEN	struct token

struct token {
	LEX type;
	VAL t;
};

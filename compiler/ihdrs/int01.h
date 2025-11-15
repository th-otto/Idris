/*	INTERFACE BETWEEN C PASS0 & PASS1
 *	copyright (c) 1978 by Whitesmiths, Ltd.
 */

/*	the types and mask
		cons = ((MASK & type) == CONS)
 */
#define MASK	0xf0
#define CONS	0x10

/*	the keywords
 */
#define LAUTO	  33
#define LBREAK	  34
#define LCASE	  35
#define LCHAR	  36
#define LCONTIN	  37
#define LDFAULT	  38
#define LDO		  39
#define LDOUBLE	  40
#define LELSE	  41
#define LEXTERN	  42
#define LFLOAT	  43
#define LFOR	  44
#define LGOTO	  45
#define LIF		  46
#define LINT	  47
#define LLONG	  48
#define LREG	  49
#define LRETURN	  50
#define LSHORT	  51
#define LSTATIC	  52
#define LSTRUCT	  53
#define LSWITCH	  54
#define LTYPDEF	  55
#define LUNION	  56
#define LUNSIGN	  57
#define LWHILE	  58
#define LCONST    59
#define LENUM     60
#define LSIGNED   61
#define LVOID     62
#define LVOLATILE 63

/*	pseudo keyword
 */
#define LNOSIDE 96
#define LSIZEOF	97

/*	created lexemes, can't be input
 */
#define DARG	59
#define DEXTERN	60
#define DSTATIC	61
#define FSTATIC 62

/*	the constants
 */
#define LDLDOUBLE	16
#define LDDOUBLE 17
#define LIDENT	18
/* #define LIFILE	19 now in int012.h */
/* #define LLINENO	20 now in int012.h */
#define LLNUM	21
#define LSNUM	22
#define LSTRING	23
#define LCNUM	24
#define LULNUM	25
#define LUSNUM	26
#define LUCNUM	27
#define LPRAGMA 29
#define LDFLOAT	30

/*	the punctuation
 */
#define LCOLON	1
#define LCOMMA	2
#define LDOT	3
#define LLBRACK	4
#define LLCURLY	5
#define LLPAREN	6
#define LPOINTS	7
#define LRBRACK	8
#define LRCURLY	9
#define LRPAREN	10
#define LSCOLON	11
#define LAT     12
#define LDOTS   13
#define LRANGE  14

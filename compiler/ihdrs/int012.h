/*	USED BY C PASS0 & PASS1 & PASS2
 *	copyright (c) 1978 by Whitesmiths, Ltd.
 */

/*	the types
		op = ((UNOP | BINOP) & type)
 */
#define BINOP	0x80
#define UNOP	0x40

/*	the operators
 */
#define LAND    (BINOP | UNOP | 1)
#define LANDAND (BINOP | 2)
#define LCOMP   (UNOP  | 3)
#define LDECR   (UNOP  | 4)
#define LDIVIDE (BINOP | 5)
#define LGAND   (BINOP | 6)
#define LGDIV   (BINOP | 7)
#define LGETS   (BINOP | 8)
#define LGLSH   (BINOP | 9)
#define LGRSH   (BINOP | 10)
#define LGMIN   (BINOP | 11)
#define LGMOD   (BINOP | 12)
#define LGOR    (BINOP | 13)
#define LGPLU   (BINOP | 14)
#define LGREAT  (BINOP | 15)
#define LGEQ    (BINOP | 16)
#define LGTIM   (BINOP | 17)
#define LGXOR   (BINOP | 18)
#define LINCR   (UNOP  | 19)
#define LISEQ   (BINOP | 20)
#define LLESS   (BINOP | 21)
#define LLEQ    (BINOP | 22)
#define LLSHIFT (BINOP | 23)
#define LMINUS  (BINOP | UNOP | 24)
#define LMODULO (BINOP | 25)
#define LNOT    (UNOP  | 26)
#define LNOTEQ  (BINOP | 27)
#define LOR     (BINOP | 28)
#define LOROR   (BINOP | 29)
#define LPLUS   (BINOP | UNOP | 30)
#define LQUERY  (BINOP | 31)
#define LRSHIFT (BINOP | 32)
#define LTIMES  (BINOP | UNOP | 33)
#define LXOR    (BINOP | 34)

/*  magic bytes between passes
 */
#define P1MAGIC 0xbd
#define P2MAGIC 0xbe
#define XRMAGIC 0xbf

/*  the line and error token common in all passes
 */
#define LIFILE  023
#define LLINENO 024
#define LERROR  0376
#define LLINE   0375

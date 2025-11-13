/*	STRUCTURES FOR PASS 2
 *	copyright (c) 1979 by Whitesmiths, Ltd.
 */

#ifndef __WCONFIG__
#include <wconfig.h>
#endif

/*	the quasi types
 */
#define LABEL	short
#define LEX		short
#define UNION	union

/*	the registers
 */
#define R0		0001
#define R1		0002
#define R4		0004
#define R2		0010
#define R3		0020
#define HL		0100
#define BC		0200
#define TS		01000
#define RPS		02000

#define FNSET	01303
#define RS		0037

/*	parameters
 */
#define AUTOFF	6

#define ISDATA	1
#define ISLITS	2
#define ISTEXT	4
#define ISNDATA	8	/**/

#define CODSIZE	1
#define JCSIZE	3
#define JMPSIZE	3
#define RETSIZE	3
#define SWTSIZE	6

#define ISCASE	1
#define VISITED	2
#define NAILED	4
#define TOEMIT	8

/*	created inst codes
 */
#define GCODE	0240
#define GNOP	0241
#define GHDR	0242

#define GLOW	0250
#define GHIS	0253

/*	the index codes
 */
#define XBC	1
#define XDE	2
#define XHL	3
#define XSP	4
#define X0	010
#define X1	011
#define X2	012
#define X3	013
#define X4	014
#define XP0	020
#define XP1	021

/*	the want attributes
 */
#define WNULL	01000
#define WSTACK	0400
#define WBC		0200
#define WHL		0100
#define WVMEM	040
#define WPSTK	020
#define WPBC	010
#define WPHL	004
#define WMEM	002
#define WTERM	001

#define PTRSET	0036
#define VOLSET	0740

/*	the got attributes
 */
#define GRVOL	0100000
#define GZSET	040000
#define GNSET	020000
#define GJUNK	010000
#define GVOL	004000
#define GNOCODE	002000

/*	the address descriptor
 */
#define ADDR	struct addr

struct addr {
	unsigned short ty;
	char nm[LENNAME];
	size_t bias;
	unsigned char idx;
	unsigned char refs;
};

/*	the expression element
 */
#define EXPR	struct expr

struct expr {
	struct expr *next;
	LEX op;
	unsigned short got;
	ADDR f;
	UNION {
		struct {
			unsigned short ty;
			struct expr *left, *right, *mid;	/* SHDB EXPR * */
		} o;
		ADDR v;
	} e;
};

/*	the code list element
 */
#define CODE	struct code
#define HEADER	struct header

struct code {
	struct code *next;
	LEX inst;
	union {
		size_t lbl;
		HEADER *hdr;
		size_t choff;
	} c;
	size_t size;
};

/*	the code header table element
 */
struct header {
	struct header *next;
	CODE *first;
	LABEL label;
	size_t offset;
	int nrefs;
	unsigned short flags;
	int lineno;
};

/*	the force table structure
 */
#define FTAB	struct force

struct force {
	unsigned short fwant, fset;
	int fty;
	const unsigned char **ftab;
};

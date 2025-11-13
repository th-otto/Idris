/*	OUTPUT TABLES
 *	copyright (c) 1979 by Whitesmiths, Ltd.
 */
#include <stdlib.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>
#include "int2.h"
#include "int012.h"
#include "int12.h"
#include "util.h"
#include "p2.h"

/*	CODES FOR CONTROL BYTES:
	byte 0: left operand
	byte 1:	right operand
	byte 2:	result

	for left or right operand:
	000-014	operand must be corresponding value
	015 high byte zero
	016 low byte zero
	017	any number
	020	operand on stack
	040 pointer to operand on stack
	060 pointer in hl
	100	operand in bc, de, or hl
	160	operand in hl
	200	operand at addable address
	260	pointer in bc, de, or hl
	300	operand at loadable address
	360	operand in memory
	374	operand must be -4
	375	operand must be -3
	376	operand must be -2
	377	operand must be -1

	for result:
	001 right operand is incremented if *bc or *hl
	002	right operand is mangled if *bc or *hl
	004	NC set properly
	010 left operand is incremented if *bc or *hl
	020 left operand is mangled if *bc or *hl
	040	Z set properly
	100	no result, CC only
	200 escape to routine n (byte following)

	type codes:
	001	signed character
	002	unsigned character
	003	signed integer
	004 bit field
	005	unsigned integer
	006	signed long
	007	long bit field (not used)
	010	unsigned long
	011	float
	012	double

	CODES FOR TEXT BYTES:
	X	put left address mode
	Y	put right address mode
	Wx	treat operand as word
	Dx	down address of operand by one
	Ux	up address of operand by one
	K	put call c.
	T	put created symbol
 */

static const unsigned char *andtab[] = {
	(const unsigned char *) "\302\202\144a=X&Y",
	(const unsigned char *) "\302\202\044a=X&Y->X",
	(const unsigned char *) "\302\205\044a=X&Y->X",
	(const unsigned char *) "\302\210\046a=X&UUY->X",
	(const unsigned char *) "\305\015\144a=X&Y",
	(const unsigned char *) "\305\016\155a=UX&UY",
	(const unsigned char *) "\305\015\010a=X&Y->X-a->UX",
	(const unsigned char *) "\305\016\055a-a->X=UX&UY->X",
	(const unsigned char *) "\305\205\011a=X&Y->X=UX&UY->X",
	(const unsigned char *) "\305\210\012a=X&UUY->X=UX&UY->X",
	(const unsigned char *) "\050\050\000Kland",
	0
};

static const unsigned char *cltab[] = {
	(const unsigned char *) "\302\000\104a=X|a",
	(const unsigned char *) "\000\202\104a-a::Y",
	(const unsigned char *) "\302\202\104a=X::Y",
	(const unsigned char *) "\305\000\114a=UX|a",
	(const unsigned char *) "\000\205\105a-a-Y=0-^UY",
	(const unsigned char *) "\305\205\115a=X-Y=UX-^UY",
	(const unsigned char *) "\310\000\114a=UX|a",
	(const unsigned char *) "\050\050\104Klclt",
	(const unsigned char *) "\311\000\114a=UX|a",
	(const unsigned char *) "\312\000\114a=UX|a",
	(const unsigned char *) "\052\052\104Kdcmp",
	0
};

static const unsigned char *cmptab[] = {
	(const unsigned char *) "\302\000\140a=X|a",
	(const unsigned char *) "\302\202\140a=X::Y",
	(const unsigned char *) "\205\000\140a=X|UX",
	(const unsigned char *) "\305\205\140a=X::Y jnz T=UX::UY",
	(const unsigned char *) "\210\000\140a=X|UX|UX|UX",
	(const unsigned char *) "\050\050\140Klcmp",
	(const unsigned char *) "\211\000\140a=X|UX",
	(const unsigned char *) "\212\000\140a=X|UX",
	(const unsigned char *) "\052\052\140Kdcmp",
	0
};

static const unsigned char *comtab[] = {
	(const unsigned char *)"\305\000\010a=X=!a->X=UX=!a->X",
	(const unsigned char *)"\050\000\000Klcom",
	0
};

static const unsigned char *divtab[] = {
	(const unsigned char *)"\023\023\000Kidiv",
	(const unsigned char *)"\025\025\000Kudiv",
	(const unsigned char *)"\046\046\000Kldiv",
	(const unsigned char *)"\050\050\000Kuldiv",
	(const unsigned char *)"\052\052\044Kddiv",
	0
};

static const unsigned char *gettab[] = {
	(const unsigned char *)"\062\017\000X=Y",
	(const unsigned char *)"\302\302\000a=Y->X",
	(const unsigned char *)"\302\305\000a=Y->X",
	(const unsigned char *)"\302\310\002a=UUY->X",

	(const unsigned char *)"\044\025\200\001",					/* BITS = UNSIGN */

	(const unsigned char *)"\105\017\000WX=WY",
	(const unsigned char *)"\305\000\054a-a->X->UX",
	(const unsigned char *)"\305\016\011a-a->X=UY->UX",
	(const unsigned char *)"\305\301\014a=Y->X+a-^a->UX",
	(const unsigned char *)"\305\302\014a=Y->X-a->UX",
	(const unsigned char *)"\105\103\000WX=WY",
	(const unsigned char *)"\365\163\000hl->WX",
	(const unsigned char *)"\305\303\011a=Y->X=UY->UX",
	(const unsigned char *)"\305\064\211\002",					/* UNSIGN = BITS */
	(const unsigned char *)"\105\105\000WX=WY",
	(const unsigned char *)"\365\165\000hl->WX",
	(const unsigned char *)"\305\305\011a=Y->X=UY->UX",
	(const unsigned char *)"\105\210\012X=UUY;UX=UY",
	(const unsigned char *)"\305\310\012a=UUY->X=UY->UX",
	(const unsigned char *)"\105\052\000WX<=sp=>sp=>sp;Kdtr;sp=>WX",
	(const unsigned char *)"\045\052\000Kdti",

	(const unsigned char *)"\310\000\064a-a->X->UX->UX->UX",
	(const unsigned char *)"\310\016\021a-a->X->UX->UX=UY->UX",
	(const unsigned char *)"\310\301\004a=Y->UUX+a-^a->UX->DDX->DX",
	(const unsigned char *)"\310\302\024a-a->X->UX=Y->UX-a->UX",
	(const unsigned char *)"\310\303\024a=UY+a-^a->X->UX=Y->UUX=DY->DX",
	(const unsigned char *)"\310\305\025a-a->X->UX=Y->UX=UY->UX",
	(const unsigned char *)"\310\310\022a=Y->X=UY->UX=UY->UX=UY->UX",
	(const unsigned char *)"\050\052\000Kdtl",

	(const unsigned char *)"\311\311\022a=Y->X=UY->UX=UY->UX=UY->UX",
	(const unsigned char *)"\051\052\000Kdtf",

	(const unsigned char *)"\052\023\000Kitd",
	(const unsigned char *)"\052\025\000Kutd",
	(const unsigned char *)"\052\046\000Kltd",
	(const unsigned char *)"\052\050\000Kultd",
	(const unsigned char *)"\052\051\000Kftd",
	(const unsigned char *)"\052\052\000Kdtd",
	0
};

static const unsigned char *lshtab[] = {
	(const unsigned char *)"\302\001\044a=X+a->X",
	(const unsigned char *)"\302\002\044a=X+a+a->X",
	(const unsigned char *)"\302\003\044a=X+a+a+a->X",
	(const unsigned char *)"\302\004\044a=X+a+a+a+a->X",
	(const unsigned char *)"\302\005\044a=X+a+a+a+a+a->X",
	(const unsigned char *)"\302\006\044a=X+a+a+a+a+a+a->X",
	(const unsigned char *)"\302\007\044a=X+a+a+a+a+a+a+a->X",
	(const unsigned char *)"\165\001\000WX+WX",
	(const unsigned char *)"\165\002\000WX+WX+WX",
	(const unsigned char *)"\165\003\000WX+WX+WX+WX",
	(const unsigned char *)"\165\004\000WX+WX+WX+WX+WX",
	(const unsigned char *)"\165\005\000WX+WX+WX+WX+WX+WX",
	(const unsigned char *)"\165\006\000WX+WX+WX+WX+WX+WX+WX",
	(const unsigned char *)"\165\007\000WX+WX+WX+WX+WX+WX+WX+WX",
	(const unsigned char *)"\165\010\000WX+WX+WX+WX+WX+WX+WX+WX+WX",
	(const unsigned char *)"\025\025\000Kilsh",
	(const unsigned char *)"\050\025\000Kllsh",
	(const unsigned char *)"\050\030\000sp=>af;Kllsh",
	0
};

static const unsigned char *mintab[] = {
	(const unsigned char *)"\062\001\040X-1",
	(const unsigned char *)"\302\202\044a=X-Y->X",
	(const unsigned char *)"\302\205\044a=X-Y->X",
	(const unsigned char *)"\302\210\046a=X-UUY->X",
	(const unsigned char *)"\105\001\000WX-1",
	(const unsigned char *)"\105\002\000WX-1-1",
	(const unsigned char *)"\305\016\015a=UX-UY->X",
	(const unsigned char *)"\305\205\015a=X-Y->X=UX-^UY->X",
	(const unsigned char *)"\305\210\016a=X-UUy->X=UX-^Uy->X",
	(const unsigned char *)"\050\050\000Klsub",
	(const unsigned char *)"\052\052\044Kdsub",
	0
};

static const unsigned char *modtab[] = {
	(const unsigned char *)"\023\023\000Kimod",
	(const unsigned char *)"\025\025\000Kumod",
	(const unsigned char *)"\046\046\000Klmod",
	(const unsigned char *)"\050\050\000Kulmod",
	(const unsigned char *)"\052\052\004Kdmod",
	0
};

static const unsigned char *negtab[] = {
	(const unsigned char *)"\305\000\014a=0-X->X=0-^UX->X",
	(const unsigned char *)"\050\000\000Klneg",
	(const unsigned char *)"\052\000\000Kdneg",
	0
};

static const unsigned char *iortab[] = {
	(const unsigned char *)"\302\202\044a=X|Y->X",
	(const unsigned char *)"\302\205\044a=X|Y->X",
	(const unsigned char *)"\302\210\046a=X|UUY->X",
	(const unsigned char *)"\305\015\000a=X|Y->X",
	(const unsigned char *)"\305\016\015a=UX|UY->X",
	(const unsigned char *)"\305\205\015a=X|Y->X=UX|UY->X",
	(const unsigned char *)"\305\210\016a=X|UUY->X=UX|UY->X",
	(const unsigned char *)"\050\050\000Klor",
	0
};

static const unsigned char *plutab[] = {
	(const unsigned char *)"\062\377\040X-1",
	(const unsigned char *)"\062\001\040X+1",
	(const unsigned char *)"\302\202\044a=X+Y->X",
	(const unsigned char *)"\302\205\044a=X+Y->X",
	(const unsigned char *)"\302\210\046a=X+UUY->X",
	(const unsigned char *)"\105\374\000WX-1-1-1-1",
	(const unsigned char *)"\105\375\000WX-1-1-1",
	(const unsigned char *)"\105\376\000WX-1-1",
	(const unsigned char *)"\105\377\000WX-1",
	(const unsigned char *)"\105\001\000WX+1",
	(const unsigned char *)"\105\002\000WX+1+1",
	(const unsigned char *)"\105\003\000WX+1+1+1",
	(const unsigned char *)"\105\004\000WX+1+1+1+1",
	(const unsigned char *)"\105\016\015a=UX+UY->X",
	(const unsigned char *)"\105\017\015a=X+Y->X=UX+^UY->X",
	(const unsigned char *)"\165\105\000WX+WY",
	(const unsigned char *)"\305\016\015a=UX+UY->X",
	(const unsigned char *)"\265\205\015a=X+Y->X=UX+^UY->X",
	(const unsigned char *)"\050\050\000Kladd",
	(const unsigned char *)"\052\052\044Kdadd",
	0
};

static const unsigned char *rshtab[] = {
	(const unsigned char *)"\301\001\000a=X+a=X<^>-1->X",
	(const unsigned char *)"\302\001\000a=X<->-1->X",
	(const unsigned char *)"\303\001\000a=UX+a=X<^>-1->X=DX<^>-1->X",
	(const unsigned char *)"\023\023\000Kirsh",
	(const unsigned char *)"\305\001\000a=UX<->-1->X=DX<^>-1->X",
	(const unsigned char *)"\025\025\000Kursh",
	(const unsigned char *)"\046\025\000Klrsh",
	(const unsigned char *)"\046\030\000sp=>af;Klrsh",
	(const unsigned char *)"\050\025\000Kulrsh",
	(const unsigned char *)"\050\030\000sp=>af;Kulrsh",
	0
};

static const unsigned char *timtab[] = {
	(const unsigned char *)"\302\002\044a=X+a->X",
	(const unsigned char *)"\302\003\044a=X+a+X->X",
	(const unsigned char *)"\302\004\044a=X+a+a->X",
	(const unsigned char *)"\302\005\044a=X+a+a+X->X",
	(const unsigned char *)"\302\006\044a=X+a+X+a->X",
	(const unsigned char *)"\302\007\044a=X+a+a+a-X->X",
	(const unsigned char *)"\302\010\044a=X+a+a+a->X",
	(const unsigned char *)"\302\011\044a=X+a+a+a+X->X",
	(const unsigned char *)"\302\012\044a=X+a+a+X+a->X",
	(const unsigned char *)"\302\013\044a=X+a+X+a+a-X->X",
	(const unsigned char *)"\302\014\044a=X+a+X+a+a->X",
	(const unsigned char *)"\165\002\000hl+hl",
	(const unsigned char *)"\165\003\000bc=>sp=hl;hl+hl+bc;bc<=sp",
	(const unsigned char *)"\165\004\000hl+hl+hl",
	(const unsigned char *)"\165\005\000bc=>sp=hl;hl+hl+hl+bc;bc<=sp",
	(const unsigned char *)"\165\006\000bc=>sp=hl;hl+hl+bc+hl;bc<=sp",
	(const unsigned char *)"\165\007\000bc=>sp=hl;hl+hl+bc+hl+bc;bc<=sp",
	(const unsigned char *)"\165\010\000hl+hl+hl+hl",
	(const unsigned char *)"\165\011\000bc=>sp=hl;hl+hl+hl+hl+bc;bc<=sp",
	(const unsigned char *)"\165\012\000bc=>sp=hl;hl+hl+hl+bc+hl;bc<=sp",
	(const unsigned char *)"\165\013\000bc=>sp=hl;hl+hl+hl+bc+hl+bc;bc<=sp",
	(const unsigned char *)"\165\014\000bc=>sp=hl;hl+hl+bc+hl+hl;bc<=sp",
	(const unsigned char *)"\305\002\014a=X+a->X=UX+^a->X",
	(const unsigned char *)"\305\004\014a=X+a->X=UX+^a->X=DX+a->X=UX+^a->X",
	(const unsigned char *)"\025\025\000Kimul",
	(const unsigned char *)"\050\050\000Klmul",
	(const unsigned char *)"\052\052\044Kdmul",
	0
};

static const unsigned char *xortab[] = {
	(const unsigned char *)"\302\202\044a=X^Y->X",
	(const unsigned char *)"\302\205\044a=X^Y->X",
	(const unsigned char *)"\302\210\046a=X^UUY->X",
	(const unsigned char *)"\305\015\000a=X^Y->X",
	(const unsigned char *)"\305\016\015a=UX^UY->X",
	(const unsigned char *)"\305\205\015a=X^Y->X=UX^UY->X",
	(const unsigned char *)"\305\210\016a=X^UUY->X=UX^UY->X",
	(const unsigned char *)"\050\050\000Klxor",
	0
};

/*	table selectors
 */
const unsigned char **bintab[] = {
	timtab, divtab, modtab, plutab, mintab,
	lshtab, rshtab, andtab, xortab, iortab, comtab, negtab, cmptab, cltab,
	gettab, timtab, divtab, modtab, plutab, mintab,
	lshtab, rshtab, andtab, xortab, iortab, plutab, mintab
};




/*
 * put a character buffered
 */
void putch(int c)
{
	if (putc(c, outfd) < 0)
	{
		panic("can't write!");
		exit(1);
	}
}


static void putstr(const char *s)
{
	while (*s)
		putch(*s++);
}


/*
 * switch to proper section
 */
void csect(int nsect)
{
	static int osect = 1;

	nsect = (nsect & xmask) ? 1 : 0;
	if (nsect ^ osect)
	{
		putasm(nsect ? ".:=.text\n" : ".:=.data\n");
		osect = nsect;
	}
}


/*
 * put assembler code
 */
BOOL putasm(const char *fmt, ...)
{
	const char *f;
	char buf[30];
	LABEL lbl;
	va_list args;
	
	va_start(args, fmt);
	for (f = fmt; *f; ++f)
	{
		switch (*f)
		{
		case '`':
			return FALSE;
		case '#':
			putch('L');
			break;
		case '$':
			putch('_');
			break;
		case '\1':
			putasm("call ");
			break;
		case '\2':
			putasm("call c.lcpy");
			break;
		case '\3':
			putstr("bc=^(hl+1+1)=>sp=^(hl-1-1-1)=>sp");
			break;
		case '\4':
			putstr("call c.dcpy");
			break;
		case '\5':
			lbl = crs();
			putasm("a=4\n%n:\nb=*(hl-1);c=*(hl-1);bc=>sp\na-1 jnz %n", lbl, lbl);
			break;
		case '\20':
		case '\21':
		case '\22':
		case '\23':
		case '\24':
			putasm("c.r");
			putch(*f + ('0' - '\20'));
			break;
		case '%':
			switch (*++f)
			{
			case 'i':
				sprintf(buf, "%d", va_arg(args, int));
				putstr(buf);
				break;
			case 'n':
				putasm(ln(va_arg(args, int))); /* LABEL */
				break;
			case 'o':
				sprintf(buf, "%o", va_arg(args, int));
				putstr(buf);
				break;
			case 'p':
				putasm(va_arg(args, char *));
				break;
			default:
				panic("FMT");
				break;
			}
			break;
		default:
			putch(*f);
			break;
		}
	}
	va_end(args);
	return TRUE;
}


/*
 * get a character buffered
 */
int getch(void)
{
	return getc(infd);
}

/*	FORCE TABLES
 *	copyright (c) 1979 by Whitesmiths, Ltd.
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "int2.h"
#include "int12.h"
#include "int012.h"
#include "util.h"
#include "p2.h"

/*	codes for force tables:

	0--	dest is stack
	1--	dest is hl
	2--	dest is bc
	3--	dest is mem (X)

	-0-	src is stack
	-1-	src is hl
	-2-	src is bc
	-3-	src is mem (Y or Z[W])
	-4-	src is de
	-5-	src is ptr on stack
	-6-	src is *hl
	-7-	src is *bc

	--1	clobbers hl
	--2	clobbers bc
	--4	clobbers de [not used]
 */

/*	double to mem
 */
static const unsigned char *dbmem[] = {
	(const unsigned char *)"\373bc->hl=&X;\4",
	(const unsigned char *)"\363bc=&X;\4",
/* 	(const unsigned char *)"\353hl<=sp;bc=&X;\4", */
	(const unsigned char *)"\333hl=&Y;bc=&X;\4",
	0
};

/*	double to stack
 */
static const unsigned char *dbstk[] = {
	(const unsigned char *)"\073hl=8+bc;\5",
	(const unsigned char *)"\063hl+(bc=8);\5",
/* 	(const unsigned char *)"\053hl<=sp+(bc=8);\5", */
	(const unsigned char *)"\033hl=&Y[8];\5",
	0
};

/*	force table deref
 */
const unsigned char *deref[] = {
	(const unsigned char *)"\241bc=^(hl=de)",
	(const unsigned char *)"\231bc=(hl=Y)",
	(const unsigned char *)"\221bc->hl=^hl",
	(const unsigned char *)"\211bc=^hl",
	(const unsigned char *)"\201bc=^(hl<=sp)",
	(const unsigned char *)"\140hl=de=a^hl",
	(const unsigned char *)"\130hl=Y",
	(const unsigned char *)"\120hl=bc=a^hl",
	(const unsigned char *)"\110hl=a^hl",
	(const unsigned char *)"\100hl<=sp=a^hl",
	(const unsigned char *)"\013bc=^hl=>sp",
	(const unsigned char *)"\003bc=^(hl<=sp)=>sp",
	0
};

/*	force table for int to register
 */
const unsigned char *intreg[] = {
	(const unsigned char *)"\271bc->hl=^hl",
	(const unsigned char *)"\261bc=^hl",
/* 	(const unsigned char *)"\251bc=^(hl<=sp)", */
	(const unsigned char *)"\240bc=de",
	(const unsigned char *)"\231bc=(hl=Y)",
	(const unsigned char *)"\210bc=hl",
	(const unsigned char *)"\200bc<=sp",
	(const unsigned char *)"\170hl=bc=a^hl",
	(const unsigned char *)"\160hl=a^hl",
/* 	(const unsigned char *)"\150hl<=sp=a^hl", */
	(const unsigned char *)"\140hl=de",
	(const unsigned char *)"\130hl=Y",
	(const unsigned char *)"\120hl=bc",
	(const unsigned char *)"\100hl<=sp",
	0
};

/*	force int to memory
 */
static const unsigned char *intmem[] = {
	(const unsigned char *)"\371hl=bc=a^->Y",
	(const unsigned char *)"\361hl=a^->Y",
/* 	(const unsigned char *)"\351hl<=sp=a^->Y", */
	(const unsigned char *)"\341hl=de->Y",
	(const unsigned char *)"\331hl=X->Y",
	(const unsigned char *)"\321hl=bc->Y",
	(const unsigned char *)"\310hl->Y",
	(const unsigned char *)"\301hl<=sp->Y",
	0
};

/*	force table for int to stack
 */
static const unsigned char *intstk[] = {
	(const unsigned char *)"\073bc->hl=^hl=>sp",
	(const unsigned char *)"\063bc=^hl=>sp",
/* 	(const unsigned char *)"\053bc=^(hl<=sp)=>sp", */
	(const unsigned char *)"\040sp<=de",
	(const unsigned char *)"\031hl=Y=>sp",
	(const unsigned char *)"\020sp<=bc",
	(const unsigned char *)"\010sp<=hl",
	0
};

/*	long to mem
 */
static const unsigned char *lomem[] = {
	(const unsigned char *)"\373bc->hl=&X;\2",
	(const unsigned char *)"\363bc=&X;\2",
/* 	(const unsigned char *)"\353hl<=sp;bc=&X;\2", */
	(const unsigned char *)"\333hl=&Y;bc=&X;\2",
	0
};

/*	long to stack
 */
static const unsigned char *lostk[] = {
	(const unsigned char *)"\073hl=bc;\3",
	(const unsigned char *)"\063\3",
/* 	(const unsigned char *)"\053hl<=sp;\3", */
	(const unsigned char *)"\033hl=&Y;\3",
	0
};

/*	pointer moves for force
 */
const unsigned char *ptmov[] = {
	(const unsigned char *)"\240bc=de",
	(const unsigned char *)"\230bc=&Y",
	(const unsigned char *)"\210bc=hl",
	(const unsigned char *)"\200bc<=sp",
	(const unsigned char *)"\140hl=de",
	(const unsigned char *)"\130hl=&Y",
	(const unsigned char *)"\120hl=bc",
	(const unsigned char *)"\100hl<=sp",
	(const unsigned char *)"\040sp<=de",
	(const unsigned char *)"\031hl=&Y=>sp",
	(const unsigned char *)"\020sp<=bc",
	(const unsigned char *)"\010sp<=hl",
	0
};

/*	reref moves for force
 */
const unsigned char *reref[] = {
	(const unsigned char *)"\241hl=&Z+de->bc",
	(const unsigned char *)"\231hl=W+(bc=&Z)->bc",
	(const unsigned char *)"\221hl=&Z+bc->bc",
	(const unsigned char *)"\211hl+(bc=&Z)->bc",
	(const unsigned char *)"\201hl<=sp+(bc=&Z)->bc",
	(const unsigned char *)"\140hl=&Z+de",
	(const unsigned char *)"\132hl=W+(bc=&Z)",
	(const unsigned char *)"\120hl=&Z+bc",
	(const unsigned char *)"\112hl+(bc=&Z)",
	(const unsigned char *)"\102hl<=sp+(bc=&Z)",
	0
};

/*	force strategies
 */
FTAB ftab[] = {
	{ WPHL, HL, XDOUBLE, ptmov },
	{ WPBC, BC, XDOUBLE, ptmov },
	{ WHL, HL, XUSHORT, intreg },
	{ WBC, BC, XUSHORT, intreg },
	{ WVMEM, R0 | R1, XUSHORT, intmem },
	{ WVMEM, R0 | R1, XFLOAT, lomem },
	{ WVMEM, R0 | R1, XDOUBLE, dbmem },
	{ WPSTK, RPS | TS, XDOUBLE, ptmov },
	{ WSTACK, TS, XUSHORT, intstk },
	{ WSTACK, TS, XFLOAT, lostk },
	{ WSTACK, TS, XDOUBLE, dbstk },
	{ 0, 0, 0, 0 }
};

static TINY binops[] = { LTIMES, LDIVIDE, LMODULO, LPLUS, LMINUS,
	LLSHIFT, LRSHIFT, LAND, LXOR, LOR, LCOMP, DMINUS, DCMP, DLESS,
	LGETS, LGTIM, LGDIV, LGMOD, LGPLU, LGMIN,
	LGLSH, LGRSH, LGAND, LGXOR, LGOR, DGPLU, DGMIN, 0
};

static TINY optytab[] = { 3, 0, 0, 3, 3,
	3, 0, 3, 3, 3, 3, 3, 3, 3,
	2, 3, 0, 0, 3, 3,
	3, 0, 3, 3, 3, 3, 3
};

/*	the want expansions
 */
static BITS wantab[] = { WBC, WSTACK, WPSTK, WPHL,
	WBC | WHL, 0, 0, WHL,
	WBC | WHL | WPHL, 0, 0, WPBC | WPHL,
	WBC | WHL | WVMEM | WPBC | WPHL | WMEM, 0, 0, WVMEM | WMEM
};


/*
 * emit code
 */
void emit(HEADER *tab, char *leave)
{
	CODE *q;
	HEADER *p;

	for (p = tab; p; p = p->next)
	{
		if (p->flags & TOEMIT)
		{
			if (0 < p->nrefs)
				putasm("%n: /%i\n", p->label, p->lineno);
			for (q = p->first; q; q = q->next)
			{
				switch (q->inst)
				{
				case GNOP:
					break;
				case GHDR:
					if (0 < q->c.hdr->nrefs)
						putasm("%n: / %i\n", q->c.hdr->label, q->c.hdr->lineno);
					break;
				case GCODE:
					for (choff = q->c.choff; putasm(chread());)
						;
					break;
				case GRET:
					if (q->c.hdr)
						putasm("%n:\n", q->c.hdr->label);
					putasm(leave);
					break;
				case GSWITCH:
					putasm("hl=&%n jmp c.switch\n", q->c.lbl);
					break;
				default:
					putasm("%p %n\n", jtext[_scnstr(brops, q->inst)], q->c.hdr->label);
					break;
				}
			}
		}
	}
}


/*
 * generate force code
 */
BITS fgen(EXPR *p, BITS reg, BITS set, const unsigned char **tab, BOOL rmatch)
{
	const unsigned char *q;
	BITS xreg;
	BITS uses;
	int idx;
	int lcode;
	int rcode;

#ifdef DEBUG
	putfmt("/fgen %x %x %p %d\n", reg, set, tab, rmatch);
	putterm(p, 1);
#endif
	xreg = xtor(p->f.idx);
	if (xreg & reg & (R0 | R1))
	{
		chput("sp=>af\n", NULL);
		p->f.idx = rtox(xreg);
		return set;
	}
	if ((p->got & GVOL) && !(xreg & REGSET))
		set |= xreg;
	if (reg & RPS && xreg & (R0 | R1))
	{
		reg = (p->got & GVOL) ? xreg : 0;
		idx = xreg & R0 ? XP0 : XP1;
	} else if (reg &= set)
	{
		reg &= (reg - 1) ^ reg;
		idx = rtox(reg);
	} else
	{
		return 0;
	}
	lcode = ctab[_scnstr(xtab, idx)] << 3;
	rcode = ctab[_scnstr(xtab, p->f.idx)];
	if (rmatch && p->f.refs && rcode <= 020)
		rcode += 050;
	if (p->got & GVOL || rcode)
		;
	else if (!(set & HL))
		return 0;
	else
		chput("hl<=sp=>sp=>sp\n", NULL);
	if (rcode != 050)
	{
		;
	} else if (lcode != 0100 && !(set & HL))
	{
		return 0;
	} else
	{
		rcode = 060;
		chput(p->got & GVOL ? "hl<=sp\n" : "hl<=sp=>sp\n", NULL);
	}
	set = (set & ~reg) | TS;
	uses = ((set & HL) ? 1 : 0) | ((set & BC) ? 2 : 0);
	while ((q = *tab++) != NULL)
	{
		if (lcode == (*q & 0300) && rcode == (*q & 070))
		{
			if ((*q & uses) != (*q & 3))
				return 0;
#ifdef DEBUG
			putfmt("/fgen %p\n", q + 1);
#endif
			while (*++q)
			{
				switch (*q)
				{
				case 'X':
					chput(xnm(idx), NULL);
					break;
				case 'Y':
					if (p->f.idx)
						chput(xnm(p->f.idx), NULL);
					else
					{
						if (q[-1] == '&')
							;
						else if (!p->f.refs)
							chput("&", NULL);
						else if (!p->f.nm[0])
							chput("*", NULL);
						putnb(p->f.nm, p->f.bias);
					}
					break;
				case 'Z':
					putnb(p->f.nm, p->f.bias);
					break;
				case 'W':
					chput(xnm(p->f.idx), NULL);
					break;
				default:
					chwrite((const char *)q, 1);
					break;
				}
			}
			chput("\n", NULL);
			memcpy(p->f.nm, noname, LENNAME);
			p->f.bias = 0;
			p->f.idx = idx;
			p->got |= GVOL;
			return set;
		}
	}
	panic("FGEN");
	return 0;
}


/*
 * pick table for one operand
 */
static BOOL opick(EXPR *p, BITS code, BOOL match, BITS ty)
{
	TINY by;

	code &= 0xff;
	if (code <= 014 || 0374 <= code)
		return iscons(p) && (by = code) == p->e.v.bias;
	else if (code == 015)
		return iscons(p) && !(p->e.v.bias & ~0xff);
	else if (code == 016)
		return iscons(p) && !(p->e.v.bias & 0xff);
	else if (code == 017)
		return iscons(p);
	else if ((code & 017) < ty || (match && ty < (code & 017)))
		return FALSE;
	else
		return (!match || ((gotten(p) | WPSTK) & twant(code)));
}


/*
 * pick a code table entry
 */
const unsigned char *pick(EXPR *p, BOOL match)
{
	int i;
	const unsigned char **q;
	BITS lty;
	BITS rty;
	BITS mty;
	int q00;

	i = _scnstr(binops, p->op);
	lty = p->e.o.left->e.o.ty & 017;
	if (!match && p->op != DCMP && p->op != DLESS)
		lty = regtype[lty];
	rty = p->e.o.right->e.o.ty & 017;
	mty = p->e.o.ty & 017;
	if (optytab[i] & 2)
	{
		lty = equtype[lty];
		mty = equtype[mty];
	}
	if (optytab[i] & 1)
		rty = equtype[rty];
	for (q = bintab[i]; *q; ++q)
	{
		q00 = q[0][0] & 0xff;
		if (q[0][2] & 0100 && mty)
			;
		else if (opick(p->e.o.left, q00, match, lty)
				 && opick(p->e.o.right, q[0][1], FALSE, rty) && (q00 <= 017 || opick(p, q00, FALSE, mty)))
			return q[0];
	}
	return NULL;
}


/*
 * decode wants from table control byte
 */
BITS twant(BITS code)
{
	if (0374 <= (code &= 0xff))
		return wantab[0];
	else
		return wantab[code >> 4];
}

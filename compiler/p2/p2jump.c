/*	JUMP CODE FOR EXPRESSIONS
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

/*	the branch and jump ops
 */
TINY brops[] = { GJUMP, GLESS, GLEQ, GGREAT, GGEQ, GISEQ, GNOTEQ, GLOW, GHIS, 0 };

const char *jtext[] = { "jmp", "jm", "JLEQ", "JGT", "jp", "jz", "jnz", "jc", "jnc",	"BAD JMP" };

TINY jncops[] = { 0, GGEQ, GGREAT, GLEQ, GLESS, GNOTEQ, GISEQ, GHIS, GLOW };

static LABEL jt(EXPR * p, LABEL fb, LABEL tb, BITS set);
static CODE **jc(CODE **qb, LEX tok, HEADER *p, EXPR *l, EXPR *r, BITS set);


/*
 * jump if false
 */
static LABEL jf(EXPR *p, LABEL fb, LABEL tb, BITS set)
{
	if (!fb)
		fb = crs();
	switch (p->op)
	{
	case LANDAND:
		fb = jf(p->e.o.left, fb, 0, set);
		return jf(p->e.o.right, fb, tb, set);
	case LOROR:
		tb = jt(p->e.o.left, 0, tb, set);
		return jf(p->e.o.right, fb, tb, set);
	case LNOT:
		return jt(p->e.o.left, tb, fb, set);
	case LLESS:
	case LLEQ:
	case LGREAT:
	case LGEQ:
	case LISEQ:
	case LNOTEQ:
		jc(0, flpops[_scnstr(lexops, p->op)] & 0xff, (HEADER *)(long)fb, p->e.o.left, p->e.o.right, set); /* WTF */
		break;
	default:
		jc(0, GISEQ, (HEADER *)(long)fb, p, &exzero, set); /* WTF */
		break;
	}
	if (tb)
		chput(ln(tb), ":\n", NULL);
	return fb;
}


/*
 * jump if true
 */
static LABEL jt(EXPR *p, LABEL fb, LABEL tb, BITS set)
{
	if (!tb)
		tb = crs();
	switch (p->op)
	{
	case LANDAND:
		fb = jf(p->e.o.left, fb, 0, set);
		return jt(p->e.o.right, fb, tb, set);
	case LOROR:
		tb = jt(p->e.o.left, 0, tb, set);
		return jt(p->e.o.right, fb, tb, set);
	case LNOT:
		return jf(p->e.o.left, tb, fb, set);
	case LLESS:
	case LLEQ:
	case LGREAT:
	case LGEQ:
	case LISEQ:
	case LNOTEQ:
		jc(0, cmpops[_scnstr(lexops, p->op)] & 0xff, (HEADER *)(long)tb, p->e.o.left, p->e.o.right, set); /* WTF */
		break;
	default:
		jc(0, GNOTEQ, (HEADER *)(long)tb, p, &exzero, set); /* WTF */
		break;
	}
	if (fb)
		chput(ln(fb), ":\n", NULL);
	return tb;
}


/*
 * set function return register
 */
static void setfn(EXPR *p)
{
	TINY idx;

	if ((p->e.v.ty & 017) <= XUSHORT)
		idx = XBC;
	else
		idx = X0;
	setad(p, regtype[p->e.v.ty], idx, 0);
	p->got = GVOL;
}


/*
 * compute a boolean value
 */
BITS boolify(EXPR *p, EXPR *q, EXPR *l, EXPR *r, BITS want, BITS set)
{
	EXPR ex;
	EXPR left;
	EXPR right;
	LABEL lbl1;
	LABEL lbl2;

	(void)want;
	if ((set & FNSET) != FNSET)
		return 0;
	if (!l)
	{
		l = &left;
		left.op = 0;
		cpyad(&left.e.v, &exzero.e.v);
		left.e.v.bias = 1;
	}
	if (!r)
	{
		r = &right;
		right.op = 0;
		cpyad(&right.e.v, &exzero.e.v);
	}
	lbl1 = jf(q, 0, 0, set);
	setfn(p);
	ex.got = p->got;
	cpyad(&ex.f, &p->f);
	if (!ex.f.ty)
		ex.f.ty = XSHORT;
	if (!fix(l, (p->f.idx == XBC) ? WBC : WVMEM, set, l->e.o.ty) || !move(&ex, l, set))
		panic("? X");
	lbl2 = crs();
	chput("jmp ", ln(lbl2), "\n", NULL);
	chput(ln(lbl1), ":\n", NULL);
	ex.got = p->got;
	cpyad(&ex.f, &p->f);
	if (!ex.f.ty)
		ex.f.ty = XSHORT;
	if (!fix(r, (p->f.idx == XBC) ? WBC : WVMEM, set, r->e.o.ty) || !move(&ex, r, set))
		panic(": X");
	chput(ln(lbl2), ":\n", NULL);
	return set & ~xtor(p->f.idx);
}


/*
 * setup compare operator
 */
static LEX cmpset(EXPR *p, EXPR *l, EXPR *r, LEX tok)
{
	BITS maxty;
	BOOL ok;
	int dif;
	EXPR *x;

	p->e.o.ty = 0;
	if (iscons(l) && iscons(r))
	{
		dif = l->e.v.bias - r->e.v.bias;
		switch (tok)
		{
		case GLESS:
			ok = (dif < 0);
			break;
		case GLEQ:
			ok = (dif <= 0);
			break;
		case GGREAT:
			ok = (dif > 0);
			break;
		case GGEQ:
			ok = (dif >= 0);
			break;
		case GISEQ:
			ok = (dif == 0);
			break;
		case GNOTEQ:
			ok = (dif != 0);
			break;
		default:
			ok = FALSE;
			break;
		}
		tok = ok ? GJUMP : GNOP;
		return tok;
	}
	if (tok == GLEQ || tok == GGREAT)
	{
		x = l;
		l = r;
		r = x;
		tok = (tok == GGREAT) ? GLESS : GGEQ;
	}
	maxty = l->e.o.ty & 017;
	if (maxty < (r->e.o.ty & 017))
		maxty = r->e.o.ty & 017;
	if (maxty == XUCHAR || maxty == XUSHORT || maxty == XULONG)
	{
		if (iscons(r) && r->e.v.bias == 0)
			tok = (tok == GLESS) ? GNOP : (tok == GGEQ) ? GJUMP : tok;
		else if (iscons(l) && l->e.v.bias == 0)
			tok = (tok == GLESS) ? GNOTEQ : (tok == GGEQ) ? GISEQ : tok;
		else
			tok = (tok == GLESS) ? GLOW : (tok == GGEQ) ? GHIS : tok;
	}
	if (tok == GISEQ || tok == GNOTEQ)
		p->op = DCMP;
	else
		p->op = DLESS;
	if (iscons(l) && l->e.v.bias == 0 && p->op == DCMP)
	{
		p->e.o.left = r;
		p->e.o.right = l;
	} else
	{
		p->e.o.left = l;
		p->e.o.right = r;
	}
	return tok;
}


/*
 * setup args to function
 */
static size_t fnargs(EXPR *p, BITS set)
{
	size_t size;

	if (p->op == DALIST)
	{
		size = fnargs(p->e.o.right, set);
		p = p->e.o.left;
	} else
	{
		size = 0;
	}
	if (!fix(p, WSTACK, set, regtype[p->e.o.ty & 017]))
		panic("ARG");
	size += bytype[p->f.ty & 017];
	return size;
}


/*
 * call a function
 */
BITS fncall(EXPR *p, BITS want, BITS set)
{
	size_t size;
	EXPR *l;

	(void)want;
	l = p->e.o.left;
	if ((set & FNSET) != FNSET)
		return 0;
	if (p->op == DFNCALL)
		size = fnargs(p->e.o.right, set);
	else
		size = 0;
	if (!fix(l, GJUNK | WPHL | WMEM, set, l->e.o.ty))
		panic("FNCALL");
	chput("\1", NULL);
	if (l->f.idx)
	{
		chput("c.ihl", NULL);
	} else
	{
		char *p;
		size_t i;

		p = memchr(l->f.nm, '\0', LENNAME);
		if (p == NULL)
			i = LENNAME;
		else
			i = p - l->f.nm;
		chput("$", NULL);
		chwrite(l->f.nm, i);
	}
	chput("\n", NULL);
	if (size)
		chput(msp(size), "\n", NULL);
	setfn(p);
	return set;
}


/*	jump conditional
 */
static CODE **jc(CODE **qb, LEX tok, HEADER *p, EXPR *l, EXPR *r, BITS set)
{
	/* SHDB UNION {HEADER *; LABEL; } */
	BITS ty;
	size_t savoff;
	EXPR ex;

	tok = cmpset(&ex, l, r, tok);
	l = ex.e.o.left;
	r = ex.e.o.right;
	if (tok == GNOP)
	{
		if (qb)
		{
			*qb = buycode(GNOP, NULL, 0);
			qb = &(*qb)->next;
		}
	} else if (tok == GJUMP)
	{
		if (qb)
		{
			*qb = buycode(GNOP, NULL, 0);
			(*qb)->next = buycode(GJUMP, p, JMPSIZE);
			++p->nrefs;
			qb = NULL;
		} else
		{
			chput("jmp ", ln((LABEL)(long)p), "\n", NULL); /* WTF */
		}
	} else
	{
		savoff = choff;
		ex.got = 0;
		if (iscons(r) && r->e.v.bias == 0)
		{
			ty = l->e.o.ty, l->e.o.ty = 0;
			if (!fix(l, VOLSET | PTRSET, set, 0))
				panic("X ? 0");
			if ((((l->got & GNSET) && ex.op == DLESS) || ((l->got & GZSET) && ex.op == DCMP)) && l->f.idx != XSP)
				ex.got = l->got;
			else
				choff = savoff;
			l->e.o.ty = ty;
		}
		if (!ex.got && !fix(&ex, WNULL, set, 0))
			panic("X ? Y");
		if (!(ex.got & (GZSET | GNSET)))
			panic("NO CC");
		if (qb)
		{
			chput("`", NULL);
			*qb = buycode(GCODE, (HEADER *)savoff, CODSIZE); /* WTF */
			(*qb)->next = buycode(tok, p, JCSIZE);
			++p->nrefs;
			qb = &(*qb)->next->next;
		} else
		{
			chput(jtext[_scnstr(brops, tok)], " ", ln((LABEL)(long)p), "\n", NULL); /* WTF */
		}
	}
	return qb;
}


/*
 * external jc call
 */
CODE **jcond(CODE **qb, LEX tok, HEADER *p, EXPR *l, EXPR *r)
{
#ifdef DEBUG
	putfmt("/jcond %d %d %d %d\n", tok, p->op, l->op, r->op);
	putexpr(l, 1);
	putexpr(r, 1);
#endif
	qb = jc(qb, tok, p, l, r, regset | FNSET | TS);
	exlist = frelst(exlist, NULL);
	return qb;
}

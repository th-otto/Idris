* int _unpack(double *d)
* {
* 	ieee_double_shape_type *u;
* 	int exp;
* 
* 	u = (ieee_double_shape_type *)d;
* 	exp = u->parts.msw.m.signexp;
* 	if (exp != 0)
* 	{
* 		exp = ((exp >> 4) & 0x7ff) - 0x3fe;
* 		u->parts.msw.m.signexp &= 0x800F;
* 		u->parts.msw.m.signexp |= 0x3FE0;
* 	}
* 	return exp;
* }
	.text
	.globl __unpack
__unpack:
	movea.l    4(a7),a0
	clr.l      d7
	move.w     (a0),d7
	beq.s      1f
	asr.w      #4,d7
	andi.w     #0x07FF,d7
	subi.l     #0x000003FE,d7
	andi.w     #0x800F,(a0)
	ori.w      #0x3FE0,(a0)
1:
	rts

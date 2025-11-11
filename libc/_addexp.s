* double _addexp(double d, int n, const char *msg)
* {
* 	register ieee_double_shape_type *u;
* 	register int exp;
* 	
* 	u = (ieee_double_shape_type *)&d;
* 	if ((exp = ((u->parts.msw.m.signexp >> 4) & 0x7ff)) != 0)
* 	{
* 		if ((exp += n) <= 0)
* 			return 0;
* 		if (exp >= 0x7ff)
* 		{
* 			return _range(msg);
* 		}
* 		u->parts.msw.m.signexp &= 0x800F;
* 		u->parts.msw.m.signexp |= exp << 4;
* 	}
* 	return d;
* }
	.text
	.globl __addexp
__addexp:
	move.w     4(a7),d6
	beq.s      3f
	asr.w      #4,d6
	andi.l     #0x000007FF,d6
	add.l      12(a7),d6
	bgt.s      1f
	clr.l      d6
	clr.l      d7
	rts
1:
	cmpi.l     #0x000007FF,d6
	blt.s      2f
	move.l     16(a7),-(a7)
	jsr        __range
	addq.l     #4,a7
	rts
2:
	asl.w      #4,d6
	andi.w     #0x800F,4(a7)
	or.w       d6,4(a7)
3:
	move.l     4(a7),d6
	move.l     8(a7),d7
	rts

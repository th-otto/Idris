	.text
	.globl __cpybuf
__cpybuf:
	move.l     12(a7),d7
	beq.s      __cpybuf_1
	move.l     d7,d0
	move.l     d0,d1
	swap       d0
	subq.w     #1,d1
	movea.l    4(a7),a0
	movea.l    8(a7),a2
__cpybuf_2:
	move.b     (a2)+,(a0)+
	dbf        d1,__cpybuf_2
	dbf        d0,__cpybuf_2
__cpybuf_1:
	rts

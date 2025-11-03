	.text
	.globl __cmpbuf
__cmpbuf:
	move.l     12(a7),d0
	beq.s      __cmpbuf_1
	move.l     d0,d1
	swap       d0
	subq.w     #1,d1
	movea.l    4(a7),a0
	movea.l    8(a7),a2
__cmpbuf_2:
	cmpm.b     (a0)+,(a2)+
	dbne       d1,__cmpbuf_2
	dbne       d0,__cmpbuf_2
	bne.s      __cmpbuf_3
__cmpbuf_1:
	moveq.l    #1,d7
	rts
__cmpbuf_3:
	moveq.l    #0,d7
	rts

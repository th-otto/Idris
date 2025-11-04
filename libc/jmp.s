	.text
	.globl _longjmp
_longjmp:
	.globl __longjmp
__longjmp:
	move.l     8(a7),d7
	bne.s      1f
	moveq.l    #1,d7
1:
	movea.l    4(a7),a0
	move.l     (a0)+,d5
	move.l     (a0)+,d4
	move.l     (a0)+,d3
	movea.l    (a0)+,a5
	movea.l    (a0)+,a4
	movea.l    (a0)+,a3
	movea.l    (a0)+,a6
	movea.l    (a0)+,a7
	move.l     (a0),(a7)
	rts

	.globl _setjmp
_setjmp:
	.globl __setjmp
__setjmp:
	movea.l    4(a7),a0
	move.l     d5,(a0)+
	move.l     d4,(a0)+
	move.l     d3,(a0)+
	move.l     a5,(a0)+
	move.l     a4,(a0)+
	move.l     a3,(a0)+
	move.l     a6,(a0)+
	move.l     a7,(a0)+
	move.l     (a7),(a0)
	moveq.l    #0,d7
	rts

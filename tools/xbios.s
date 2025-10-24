	.text

	.globl _trap_14_w
_trap_14_w:
	link a6,#0
	movem.l d1-d2/a0-a2,-(a7)
	move.w 10(a6),-(a7)
	trap #14
	addq.l #2,a7
	movem.l (a7)+,d1-d2/a0-a2
	move.l d0,d7
	unlk a6
	rts

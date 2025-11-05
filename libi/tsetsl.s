* lock(0)
	.globl _tsetsl
_tsetsl:
	movea.l    (a7),a0
	move.l     #0,(a7)
	moveq.l    #49,d7
	trap       #1
	tst.l      (a7)+
	jmp        (a0)

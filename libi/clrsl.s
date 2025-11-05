* lock(1)
	.globl _clrsl
_clrsl:
	movea.l    (a7),a0
	move.l     #1,(a7)
	moveq.l    #49,d7
	trap       #1
	tst.l      (a7)+
	jmp        (a0)

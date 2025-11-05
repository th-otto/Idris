* lock(2)
	.globl _getsl
_getsl:
	movea.l    (a7),a0
	move.l     #2,(a7)
	moveq.l    #49,d7
	trap       #1
	tst.l      (a7)+
	jmp        (a0)

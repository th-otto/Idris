* lock(5)
	.globl _getul
_getul:
	movea.l    (a7),a0
	move.l     #5,(a7)
	moveq.l    #49,d7
	trap       #1
	tst.l      (a7)+
	jmp        (a0)

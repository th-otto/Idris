* lock(4)
	.globl _clrul
_clrul:
	movea.l    (a7),a0
	move.l     #4,(a7)
	moveq.l    #49,d7
	trap       #1
	tst.l      (a7)+
	jmp        (a0)

* lock(3)
	.globl _tsetul
_tsetul:
	movea.l    (a7),a0
	move.l     #3,(a7)
	move.l     #49,d7
	trap       #1
	tst.l      (a7)+
	jmp        (a0)

*	setpgrp()
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	set process group

	.globl	_setpgrp
_setpgrp:
	movea.l    (a7),a0
	move.l     #1,(a7)
	moveq.l    #39,d7
	trap       #1
	tst.l      (a7)+
	jmp        (a0)

*	fork()
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	make new process and return to both

	.globl	__fork
__fork:
	.globl	_fork
_fork:
**	profiler entry count code here
	moveq.l	#2,d7
	trap	#1
	tst.l   d7
	bge.s   1f
	neg.l	d7
	move.l d7,_errno
	moveq.l #-1,d7
1:
	rts

*	open(name, mode)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	open file name for (read, write, update)

	.globl	_open
_open:
	.globl	__open
__open:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#5,d7
	trap	#1
	bcc.s	1f
	jmp		seterr
1:
	jmp	(a0)

*	creat(name, perm)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	creat and open file name for (read, write, update)

	.globl	__creat
__creat:
	.globl	_creat
_creat:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#8,d7
	trap	#1
	bcc		1f
	jmp		seterr
1:
	jmp	(a0)

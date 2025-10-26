*	kill(pid, sig)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	send sig to process pid

	.globl	_kill
_kill:
	.globl	__kill
__kill:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#37,d7
	trap	#1
	bcc		1f
	jmp		seterr
1:
	jmp	(a0)


*	link(old, new)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	make new name for old file

	.globl	_link
_link:
	.globl	__link
__link:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#9,d7
	trap	#1
	bcc		1f
	jmp		seterr
1:
	jmp	(a0)

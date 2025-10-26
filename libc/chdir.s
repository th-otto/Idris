*	chdir(name)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	change working directory

	.globl	__chdir
__chdir:
	.globl	_chdir
_chdir:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#12,d7
	trap	#1
	bcc		1f
	jmp		seterr
1:
	jmp	(a0)

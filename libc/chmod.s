*	chmod(path, mode)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	change mode of file

	.globl	_chmod
_chmod:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#15,d7
	trap	#1
	bcc		1f
	jmp		seterr
1:
	jmp	(a0)

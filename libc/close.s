*	close(fd)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	close file fd

	.globl	__close
__close:
	.globl	_close
_close:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#6,d7
	trap	#1
	bcc		1f
	jmp		seterr
1:
	jmp	(a0)

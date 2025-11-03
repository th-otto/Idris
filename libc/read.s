*	read(fd, buf, n)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	read max(n, #avail) bytes into buf from fd

	.globl	_read
_read:
	.globl	__read
__read:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#3,d7
	trap	#1
	bcc.s	1f
	jmp		seterr
1:
	jmp	(a0)


*	write(fd, buf, n)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	write max(n, #avail) bytes from buf to fd

	.globl	_write
_write:
	.globl	__write
__write:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#4,d7
	trap	#1
	bcc.s	1f
	jmp		seterr
1:
	jmp	(a0)

*	mknod(pathname, mode, dev)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	make a special inode

	.globl	_mknod
_mknod:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#14,d7
	trap	#1
	bcc.s	1f
	jmp		seterr
1:
	jmp	(a0)

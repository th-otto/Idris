*	SET FILE POINTER
*	copyright (c) 1985 by Whitesmiths, Ltd.

* LONG lseek(fd, (LONG) offset, whence)

	.globl	_lseek
_lseek:
	.globl	__lseek
__lseek:
	* save return
	move.l	(sp)+,a0
	* lseek call number
	moveq	#0x28,d7
	* call Idris
	trap	#1
	bcc		1f
	jmp		seterr
1:
	* return
	jmp		(a0)

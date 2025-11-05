*	change the nice value of a process
*	copyright (c) 1985 by Whitesmiths, Ltd.

* int nice(int incr)

	.globl	_nice
_nice:
	* save return
	move.l	(sp)+,a0
	* lseek call number
	moveq	#34,d7
	* call Idris
	trap	#1
	bcc.s	1f
	jmp		seterr
1:
	* return
	jmp		(a0)

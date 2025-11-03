*	chown(path, owner, group)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	change owner of file

	.globl	_chown
_chown:
**	profiler entry count code here
	move.l	(sp)+,a0
	move.l     8(a7),d0
	andi.l     #0xFF,d0
	asl.l      #8,d0
	move.l     4(a7),d1
	andi.l     #0xFF,d1
	or.l       d1,d0
	move.l     d0,4(a7)
	moveq.l	#16,d7
	trap	#1
	bcc.s	1f
	jmp		seterr
1:
	jmp	(a0)

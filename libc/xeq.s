*	ERROR xeq(fn, av, ev, flags, sin, sout, serr, setb, pcntl, pri, tty)
*	copyright (c) 1986, 1987 by Whitesmiths, Ltd.
*	execute a program

	.globl	__xeq
__xeq:
**	profiler entry code count here
	move.l	(sp)+,a0
	move.l	sp,a1
	* &flags
	pea		12(a1)
	* ev
	move.l	8(a1),-(sp)
	* av
	move.l	4(a1),-(sp)
	* fn
	move.l	(a1),-(sp)
	moveq.l	#0x43,d7
	trap	#1
	move.l	a1,sp
	bcc.s	1f
	jmp		seterr
1:
	jmp		(a0)

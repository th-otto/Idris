*	pipe(fds)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	setup a data pipe

	movea.l    (a7)+,a0
	moveq.l    #42,d7
	trap       #1
	bcc.s      1f
	jmp        seterr
1:
	movea.l    (a7),a1
	* pipefds[1] = fds & 0xffff
	move.l     d7,4(a1)
	clr.w      4(a1)
	* pipefds[0] = (fds >> 16) & 0xffff
	clr.w      d7
	swap       d7
	move.l     d7,(a1)
	moveq.l    #0,d7
	jmp        (a0)

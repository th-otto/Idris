 *
 *	C RUNTIME STARTUP FOR IDRIS
 *	copyright (c) 1982, 1986 by Whitesmiths, Ltd.
 *	setup arguments and environment pointer, call main, then exit
 *
	.globl	start
	.globl _exit
	.globl __exit
	.globl __terminate
	.globl _onexit
	.globl seterr
	.globl pseterr
	.globl	__data
	.globl _errno
	.globl __astat
	.globl __cstat
	.globl __lstat
	.globl _end
	.globl __main
	.globl __onexit
	.globl 	__errno
start:
	cmpi.l	#1,__stop
	bne.s	1f
	move.l	#e__bss__,__stop
1:
	jsr __lstat
	jsr __astat
	jsr __cstat
	* SIG_ERR
	pea.l      sigerr
	move.l     #-1,-(a7)
	jsr        __signal
	addq.l     #8,a7
	* call _main to set up environment and return
	jsr __main
	move.l	d7,(sp)
	jsr _exit

__terminate:
_exit:
	move.l	oncalls,d7
1:
	cmp.l	#_onexit,d7
	beq.s	1f
	tst.l	d7
	beq.s	1f
	move.l	d7,a0
	jsr	(a0)
	bra.s	1b
1:
__exit:
	* return address
	tst.l	(sp)+
	* exit system call #
	moveq.l	#1,d7
	trap	#1

__onexit:
_onexit:
	move.l	oncalls,d7
	move.l	4(sp),oncalls
	rts

sigerr:
	movem.l    d0-d7/a0-a7,-(a7)
	pea.l      72(a7)
	move.l     72(a7),-(a7)
	movea.l    72(a7),a0
	jsr        (a0)
	addq.l     #8,a7
	movem.l    (a7)+,d0-d7/a0-a6
	adda.l     #12,a7
	rte


pseterr:
	* pop trash off the stack first
	tst.l	(sp)+
seterr:
	* set errno and return -1
	neg.l	d7
	move.l	d7,_errno
	moveq.l	#-1,d7
	jmp	(a0)

.data
__data:
	.byte 0
	.ascii "IDR68K Edition 3.2: Copyright (c) 1981, 1983, 1986, 1987 by Whitesmiths, Ltd. all rights reserved"
	.byte 0
	.even
__errno:
_errno:
	.long 0
oncalls:
	* who to call on exit (stop on _onexit or NULL)
	.long _onexit

	* don't make this a global!
	.bss
_end:

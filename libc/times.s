	.text
	.globl __times
__times:
	movea.l    (a7)+,a0
	moveq.l    #57,d7
	trap       #1
	bcc        __times_1
	jmp        seterr
__times_1:
	jmp        (a0)

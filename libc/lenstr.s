	.text
	.globl __lenstr
	.globl _strlen
_strlen:
__lenstr:
	movea.l    4(a7),a0
__lenstr_1:
	tst.b      (a0)+
	bne.s      __lenstr_1
	move.l     a0,d7
	sub.l      4(a7),d7
	subq.l     #1,d7
	rts

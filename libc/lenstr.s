	.text
	.globl _strlen
	.globl _lenstr
	.globl __lenstr
_strlen:
_lenstr:
__lenstr:
	movea.l    4(a7),a0
1:
	tst.b      (a0)+
	bne.s      1b
	move.l     a0,d7
	sub.l      4(a7),d7
	subq.l     #1,d7
	rts

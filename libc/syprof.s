	.globl __syprof
__syprof:
	.globl _profil
_profil:
	movea.l    (a7)+,a0
	moveq.l    #44,d7
	trap       #1
	bcc.s      1f
	jmp        seterr
1:
	jmp        (a0)

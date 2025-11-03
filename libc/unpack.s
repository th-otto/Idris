	.text
	.globl __unpack
__unpack:
	movea.l    4(a7),a0
	clr.l      d7
	move.w     (a0),d7
	beq.s      1f
	asr.w      #4,d7
	andi.w     #0x07FF,d7
	subi.l     #0x000003FE,d7
	andi.w     #0x800F,(a0)
	ori.w      #0x3FE0,(a0)
1:
	rts

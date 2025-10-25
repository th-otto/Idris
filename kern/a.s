    .text
	.globl	_start
_start:						* first text location
	jmp     idris

	.globl	idris
idris:
	move.w  #0x2700,sr

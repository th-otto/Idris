*	C RUNTIME STARTUP PREFIX HEADER FOR THE 68020/68881
*	Copyright (c) 1986 by Whitesmiths, Ltd.
*	Initialize the 68881 and fall through to the next startup header

	.text
	* fmovem.l   #$00000010,fpcr
	.word 0xf23c,0x9000,0x0000,0x0010

; a_magic   = 0x9928
; a_text    = 0x000000a6
; a_data    = 0x0000006c
; a_bss     = 0x00000000
; a_syms    = 0x000000e7
; a_heap    = 0x00000000
; a_textoff = 0x00000000
; a_dataoff = 0x00000000
; a_relocs  = 0x00000023@0x00000215

start:
[00000000] 0cb9 0000 0001 0000 0000  cmpi.l     #$00000001,__stop
[0000000a] 660a                      bne.s      $00000016
[0000000c] 23fc 0000 0000 0000 0000  move.l     #e__bss__,__stop
[00000016] 4eb9 0000 0000            jsr        __lstat
[0000001c] 4eb9 0000 0000            jsr        __astat
[00000022] 4eb9 0000 0000            jsr        __cstat
[00000028] 4879 0000 0078            pea.l      $00000078
[0000002e] 2f3c ffff ffff            move.l     #$FFFFFFFF,-(a7)
[00000034] 4eb9 0000 0000            jsr        __signal
[0000003a] 508f                      addq.l     #8,a7
[0000003c] 4eb9 0000 0000            jsr        __main
[00000042] 2e87                      move.l     d7,(a7)
[00000044] 4eb9 0000 004a            jsr        __terminate
__terminate:
[0000004a] 2e39 0000 0068            move.l     $0000010E,d7
[00000050] 0c87 0000 0068            cmpi.l     #_onexit,d7
[00000056] 670a                      beq.s      __exit
[00000058] 4a87                      tst.l      d7
[0000005a] 6706                      beq.s      __exit
[0000005c] 2047                      movea.l    d7,a0
[0000005e] 4e90                      jsr        (a0)
[00000060] 60ee                      bra.s      $00000050
__exit:
[00000062] 4a9f                      tst.l      (a7)+
[00000064] 7e01                      moveq.l    #1,d7
[00000066] 4e41                      trap       #1
_onexit:
[00000068] 2e39 0000 0068            move.l     $0000010E,d7
[0000006e] 23ef 0004 0000 0068       move.l     4(a7),$0000010E
[00000076] 4e75                      rts
[00000078] 48e7 ffff                 movem.l    d0-d7/a0-a7,-(a7)
[0000007c] 486f 0048                 pea.l      72(a7)
[00000080] 2f2f 0048                 move.l     72(a7),-(a7)
[00000084] 206f 0048                 movea.l    72(a7),a0
[00000088] 4e90                      jsr        (a0)
[0000008a] 508f                      addq.l     #8,a7
[0000008c] 4cdf 7fff                 movem.l    (a7)+,d0-d7/a0-a6
[00000090] dffc 0000 000c            adda.l     #$0000000C,a7
[00000096] 4e73                      rte
pseterr:
[00000098] 4a9f                      tst.l      (a7)+
seterr:
[0000009a] 4487                      neg.l      d7
[0000009c] 23c7 0000 0064            move.l     d7,__errno
[000000a2] 7eff                      moveq.l    #-1,d7
[000000a4] 4ed0                      jmp        (a0)

	.data
__data:
[000000a6]                           dc.b $00
[000000a7]                           dc.b 'IDR68K Edition 3.2: Copyright (c) 1981, 1983, 1986, 1987 by Whitesmiths, Ltd. all rights reserved',0
[00000109]                           dc.b $00
__errno:
[0000010a]                           dc.b $00
[0000010b]                           dc.b $00
[0000010c]                           dc.b $00
[0000010d]                           dc.b $00
[0000010e] 00000068                  dc.l _onexit
;
         U __signal
         U e__bss__
         U __lstat
         U __main
         U __cstat
         U __astat
         U __stop
00000000 T start
0000004a T _exit
0000004a T __terminate
00000062 T __exit
00000068 T _onexit
00000068 T __onexit
00000098 T pseterr
0000009a T seterr
000000a6 D __data
0000010a D __errno
0000010a D _errno
;

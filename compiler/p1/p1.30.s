; a_magic   = 0x992d (symbol length: 11)
; a_text    = 0x0000b10e
; a_data    = 0x00001b9c
; a_bss     = 0x00000000
; a_syms    = 0x00001280
; a_heap    = 0x0000fffe
; a_textoff = 0x00000000
; a_dataoff = 0x00020000
; a_relocs  = 0x000012c0@0x0000df46


start:
[00000000] 201f                      move.l     (a7)+,d0
[00000002] 204f                      movea.l    a7,a0
[00000004] 2f08                      move.l     a0,-(a7)
[00000006] 2f08                      move.l     a0,-(a7)
[00000008] 2f00                      move.l     d0,-(a7)
[0000000a] e598                      rol.l      #2,d0
[0000000c] 5880                      addq.l     #4,d0
[0000000e] d1af 0008                 add.l      d0,8(a7)
[00000012] 23ef 0008 0002 0072       move.l     8(a7),_environ
[0000001a] 4a97                      tst.l      (a7)
[0000001c] 6726                      beq.s      start_1
[0000001e] 206f 0004                 movea.l    4(a7),a0
[00000022] 2050                      movea.l    (a0),a0
[00000024] 23c8 0002 0cc0            move.l     a0,__pname
start_3:
[0000002a] 0c10 003a                 cmpi.b     #$3A,(a0)
[0000002e] 670c                      beq.s      start_2
[00000030] 0c10 007c                 cmpi.b     #$7C,(a0)
[00000034] 6706                      beq.s      start_2
[00000036] 4a18                      tst.b      (a0)+
[00000038] 66f0                      bne.s      start_3
[0000003a] 6008                      bra.s      start_1
start_2:
[0000003c] 4218                      clr.b      (a0)+
[0000003e] 23c8 0002 007a            move.l     a0,__paths
start_1:
[00000044] 4879 0002 006c            pea.l      $0002006C "PATH"
[0000004a] 4eb9 0000 a6da            jsr        _getenv
[00000050] 4a9f                      tst.l      (a7)+
[00000052] 4a87                      tst.l      d7
[00000054] 6706                      beq.s      start_4
[00000056] 23c7 0002 007a            move.l     d7,__paths
start_4:
[0000005c] 0cb9 0000 0001 0002 1b66  cmpi.l     #$00000001,__stop
[00000066] 660a                      bne.s      start_5
[00000068] 23fc 0002 1b9c 0002 1b66  move.l     #$0002CCAA,__stop
start_5:
[00000072] 4eb9 0000 4f46            jsr        _main
[00000078] 2e87                      move.l     d7,(a7)
[0000007a] 4eb9 0000 0080            jsr        _exit

_exit:
[00000080] 2e39 0002 007e            move.l     $0002007E,d7
_exit_2:
[00000086] 0c87 0000 00aa            cmpi.l     #_onexit,d7
[0000008c] 670a                      beq.s      _exit_1
[0000008e] 4a87                      tst.l      d7
[00000090] 6706                      beq.s      _exit_1
[00000092] 2047                      movea.l    d7,a0
[00000094] 4e90                      jsr        (a0)
[00000096] 60ee                      bra.s      _exit_2
_exit_1:
[00000098] 4aaf 0004                 tst.l      4(a7)
[0000009c] 6604                      bne.s      _exit_3
[0000009e] 7e01                      moveq.l    #1,d7
[000000a0] 6002                      bra.s      _exit_4
_exit_3:
[000000a2] 4287                      clr.l      d7
_exit_4:
[000000a4] 2f07                      move.l     d7,-(a7)
[000000a6] 7e01                      moveq.l    #1,d7
[000000a8] 4e41                      trap       #1

_onexit:
[000000aa] 2e39 0002 007e            move.l     $0002007E,d7
[000000b0] 23ef 0004 0002 007e       move.l     4(a7),$0002007E
[000000b8] 4e75                      rts

seterr:
[000000ba] 4487                      neg.l      d7
[000000bc] 23c7 0002 0076            move.l     d7,_errno
[000000c2] 7eff                      moveq.l    #-1,d7
[000000c4] 4ed0                      jmp        (a0)

_alias:
[000000c6] 4e56 0000                 link       a6,#0
[000000ca] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000000ce] 2a6e 0008                 movea.l    8(a6),a5
[000000d2] 4287                      clr.l      d7
[000000d4] 1e2d 000e                 move.b     14(a5),d7
[000000d8] 0c47 003c                 cmpi.w     #$003C,d7
[000000dc] 670c                      beq.s      _alias_1
[000000de] 4287                      clr.l      d7
[000000e0] 1e2d 000e                 move.b     14(a5),d7
[000000e4] 0c47 003d                 cmpi.w     #$003D,d7
[000000e8] 6612                      bne.s      _alias_2
_alias_1:
[000000ea] 486d 0010                 pea.l      16(a5)
[000000ee] 2f3c 0002 00a8            move.l     #$000200A8,-(a7) "alias defined"
[000000f4] 4eb9 0000 3c8a            jsr        _nmerr
[000000fa] 508f                      addq.l     #8,a7
_alias_2:
[000000fc] 4878 0001                 pea.l      ($00000001).w
[00000100] 4eb9 0000 0be6            jsr        _gexpr
[00000106] 588f                      addq.l     #4,a7
[00000108] 2847                      movea.l    d7,a4
[0000010a] 2e8c                      move.l     a4,(a7)
[0000010c] 4eb9 0000 83b6            jsr        _iscons
[00000112] 4a87                      tst.l      d7
[00000114] 6706                      beq.s      _alias_3
[00000116] 4a2d 000f                 tst.b      15(a5)
[0000011a] 6712                      beq.s      _alias_4
_alias_3:
[0000011c] 486d 0010                 pea.l      16(a5)
[00000120] 2f3c 0002 009e            move.l     #$0002009E,-(a7) "bad alias"
[00000126] 4eb9 0000 3c8a            jsr        _nmerr
[0000012c] 508f                      addq.l     #8,a7
_alias_4:
[0000012e] 1b7c 003a 000e            move.b     #$3A,14(a5)
[00000134] 2b6c 0008 0008            move.l     8(a4),8(a5)
[0000013a] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[0000013e] 4e5e                      unlk       a6
[00000140] 4e75                      rts

_arinit:
[00000142] 4e56 fff8                 link       a6,#-8
[00000146] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[0000014a] 4aae 000c                 tst.l      12(a6)
[0000014e] 6614                      bne.s      _arinit_1
[00000150] 4878 0005                 pea.l      ($00000005).w
[00000154] 4eb9 0000 332e            jsr        _eat
[0000015a] 588f                      addq.l     #4,a7
[0000015c] 4a87                      tst.l      d7
[0000015e] 6704                      beq.s      _arinit_1
[00000160] 7e01                      moveq.l    #1,d7
[00000162] 6002                      bra.s      _arinit_2
_arinit_1:
[00000164] 4287                      clr.l      d7
_arinit_2:
[00000166] 2d47 fffc                 move.l     d7,-4(a6)
[0000016a] 2e2e fffc                 move.l     -4(a6),d7
[0000016e] 8fae 0010                 or.l       d7,16(a6)
[00000172] 246e 0008                 movea.l    8(a6),a2
[00000176] 588a                      addq.l     #4,a2
[00000178] 2452                      movea.l    (a2),a2
[0000017a] 508a                      addq.l     #8,a2
[0000017c] 4284                      clr.l      d4
[0000017e] 1812                      move.b     (a2),d4
[00000180] 0c84 0000 0009            cmpi.l     #$00000009,d4
[00000186] 671c                      beq.s      _arinit_3
[00000188] 4ab9 0002 0b8e            tst.l      _stdflag
[0000018e] 6600 00be                 bne        _arinit_4
[00000192] 0c84 0000 0008            cmpi.l     #$00000008,d4
[00000198] 670a                      beq.s      _arinit_3
[0000019a] 0c84 0000 000a            cmpi.l     #$0000000A,d4
[000001a0] 6600 00ac                 bne        _arinit_4
_arinit_3:
[000001a4] 4297                      clr.l      (a7)
[000001a6] 2f2e 000c                 move.l     12(a6),-(a7)
[000001aa] 4eb9 0000 085a            jsr        _ginit
[000001b0] 588f                      addq.l     #4,a7
[000001b2] 2d47 000c                 move.l     d7,12(a6)
[000001b6] 6700 0096                 beq        _arinit_4
[000001ba] 246e 000c                 movea.l    12(a6),a2
[000001be] 588a                      addq.l     #4,a2
[000001c0] 4a92                      tst.l      (a2)
[000001c2] 6700 008a                 beq        _arinit_4
[000001c6] 246e 000c                 movea.l    12(a6),a2
[000001ca] 588a                      addq.l     #4,a2
[000001cc] 2452                      movea.l    (a2),a2
[000001ce] 508a                      addq.l     #8,a2
[000001d0] 4287                      clr.l      d7
[000001d2] 1e12                      move.b     (a2),d7
[000001d4] 0c47 0040                 cmpi.w     #$0040,d7
[000001d8] 6674                      bne.s      _arinit_4
[000001da] 45f8 0015                 lea.l      ($00000015).w,a2
[000001de] d5ee 000c                 adda.l     12(a6),a2
[000001e2] 4a12                      tst.b      (a2)
[000001e4] 6668                      bne.s      _arinit_4
[000001e6] 45f8 0014                 lea.l      ($00000014).w,a2
[000001ea] d5ee 000c                 adda.l     12(a6),a2
[000001ee] 4a12                      tst.b      (a2)
[000001f0] 665c                      bne.s      _arinit_4
[000001f2] 246e 000c                 movea.l    12(a6),a2
[000001f6] 508a                      addq.l     #8,a2
[000001f8] 4a92                      tst.l      (a2)
[000001fa] 6652                      bne.s      _arinit_4
[000001fc] 45f8 0010                 lea.l      ($00000010).w,a2
[00000200] d5ee 000c                 adda.l     12(a6),a2
[00000204] 33d2 0002 00b8            move.w     (a2),$000200B8
[0000020a] 6742                      beq.s      _arinit_4
[0000020c] 4297                      clr.l      (a7)
[0000020e] 2f39 0002 0d1e            move.l     _littab,-(a7)
[00000214] 2f3c 0002 00b6            move.l     #$000200B6,-(a7)
[0000021a] 4eb9 0000 847e            jsr        _lookup
[00000220] 508f                      addq.l     #8,a7
[00000222] 2a47                      movea.l    d7,a5
[00000224] 2e0d                      move.l     a5,d7
[00000226] 6726                      beq.s      _arinit_4
[00000228] 45f8 000a                 lea.l      ($0000000A).w,a2
[0000022c] d5ed 0004                 adda.l     4(a5),a2
[00000230] 2a12                      move.l     (a2),d5
[00000232] 422d 000f                 clr.b      15(a5)
[00000236] 45f8 000a                 lea.l      ($0000000A).w,a2
[0000023a] d5ee 0008                 adda.l     8(a6),a2
[0000023e] 4a92                      tst.l      (a2)
[00000240] 663a                      bne.s      _arinit_5
[00000242] 45f8 000a                 lea.l      ($0000000A).w,a2
[00000246] d5ee 0008                 adda.l     8(a6),a2
[0000024a] 2485                      move.l     d5,(a2)
[0000024c] 6056                      bra.s      _arinit_6
_arinit_4:
[0000024e] 42ae fff8                 clr.l      -8(a6)
[00000252] 4285                      clr.l      d5
_arinit_12:
[00000254] 4297                      clr.l      (a7)
[00000256] 2f2e 000c                 move.l     12(a6),-(a7)
[0000025a] 4eb9 0000 085a            jsr        _ginit
[00000260] 588f                      addq.l     #4,a7
[00000262] 2d47 000c                 move.l     d7,12(a6)
[00000266] 6666                      bne.s      _arinit_7
[00000268] 4878 0005                 pea.l      ($00000005).w
[0000026c] 4eb9 0000 3e50            jsr        _peek
[00000272] 588f                      addq.l     #4,a7
[00000274] 4a87                      tst.l      d7
[00000276] 6700 0098                 beq        _arinit_8
[0000027a] 6052                      bra.s      _arinit_7
_arinit_5:
[0000027c] 45f8 000a                 lea.l      ($0000000A).w,a2
[00000280] d5ee 0008                 adda.l     8(a6),a2
[00000284] 2e12                      move.l     (a2),d7
[00000286] 2445                      movea.l    d5,a2
[00000288] 538a                      subq.l     #1,a2
[0000028a] be8a                      cmp.l      a2,d7
[0000028c] 6c16                      bge.s      _arinit_6
[0000028e] 2ebc 0002 00ba            move.l     #$000200BA,(a7) "string initializer too long"
[00000294] 4eb9 0000 3e84            jsr        _p1error
[0000029a] 45f8 000a                 lea.l      ($0000000A).w,a2
[0000029e] d5ee 0008                 adda.l     8(a6),a2
[000002a2] 2a12                      move.l     (a2),d5
_arinit_6:
[000002a4] 2e85                      move.l     d5,(a7)
[000002a6] 2f2d 0008                 move.l     8(a5),-(a7)
[000002aa] 5497                      addq.l     #2,(a7)
[000002ac] 4eb9 0000 61ca            jsr        _pstr
[000002b2] 588f                      addq.l     #4,a7
[000002b4] 2d45 fff8                 move.l     d5,-8(a6)
_arinit_11:
[000002b8] 4aae fffc                 tst.l      -4(a6)
[000002bc] 6700 0088                 beq        _arinit_9
[000002c0] 4878 0001                 pea.l      ($00000001).w
[000002c4] 4eb9 0000 0352            jsr        _datend
[000002ca] 588f                      addq.l     #4,a7
[000002cc] 6078                      bra.s      _arinit_9
_arinit_7:
[000002ce] 2eae 0010                 move.l     16(a6),(a7)
[000002d2] 2f2e 000c                 move.l     12(a6),-(a7)
[000002d6] 246e 0008                 movea.l    8(a6),a2
[000002da] 588a                      addq.l     #4,a2
[000002dc] 2f12                      move.l     (a2),-(a7)
[000002de] 4eb9 0000 053c            jsr        _dinit
[000002e4] 508f                      addq.l     #8,a7
[000002e6] dfae fff8                 add.l      d7,-8(a6)
[000002ea] 5285                      addq.l     #1,d5
[000002ec] 42ae 000c                 clr.l      12(a6)
[000002f0] 4aae 0010                 tst.l      16(a6)
[000002f4] 671a                      beq.s      _arinit_8
[000002f6] 45f8 000a                 lea.l      ($0000000A).w,a2
[000002fa] d5ee 0008                 adda.l     8(a6),a2
[000002fe] 4a92                      tst.l      (a2)
[00000300] 6726                      beq.s      _arinit_10
[00000302] 45f8 000a                 lea.l      ($0000000A).w,a2
[00000306] d5ee 0008                 adda.l     8(a6),a2
[0000030a] 2e12                      move.l     (a2),d7
[0000030c] be85                      cmp.l      d5,d7
[0000030e] 6e18                      bgt.s      _arinit_10
_arinit_8:
[00000310] 45f8 000a                 lea.l      ($0000000A).w,a2
[00000314] d5ee 0008                 adda.l     8(a6),a2
[00000318] 4a92                      tst.l      (a2)
[0000031a] 669c                      bne.s      _arinit_11
[0000031c] 45f8 000a                 lea.l      ($0000000A).w,a2
[00000320] d5ee 0008                 adda.l     8(a6),a2
[00000324] 2485                      move.l     d5,(a2)
[00000326] 6090                      bra.s      _arinit_11
_arinit_10:
[00000328] 4ab9 0002 009a            tst.l      $0002009A
[0000032e] 6600 ff24                 bne        _arinit_12
[00000332] 4878 0002                 pea.l      ($00000002).w
[00000336] 4eb9 0000 332e            jsr        _eat
[0000033c] 588f                      addq.l     #4,a7
[0000033e] 4a87                      tst.l      d7
[00000340] 6600 ff12                 bne        _arinit_12
[00000344] 60ca                      bra.s      _arinit_8
_arinit_9:
[00000346] 2e2e fff8                 move.l     -8(a6),d7
[0000034a] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[0000034e] 4e5e                      unlk       a6
[00000350] 4e75                      rts

_datend:
[00000352] 4e56 fffc                 link       a6,#-4
[00000356] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[0000035a] 2a2e 0008                 move.l     8(a6),d5
[0000035e] 4284                      clr.l      d4
_datend_4:
[00000360] 4a85                      tst.l      d5
[00000362] 6736                      beq.s      _datend_1
[00000364] 4878 0002                 pea.l      ($00000002).w
[00000368] 4eb9 0000 332e            jsr        _eat
[0000036e] 588f                      addq.l     #4,a7
[00000370] 4878 0001                 pea.l      ($00000001).w
[00000374] 42a7                      clr.l      -(a7)
[00000376] 4eb9 0000 085a            jsr        _ginit
[0000037c] 508f                      addq.l     #8,a7
[0000037e] 2d47 fffc                 move.l     d7,-4(a6)
[00000382] 4878 0009                 pea.l      ($00000009).w
[00000386] 4eb9 0000 332e            jsr        _eat
[0000038c] 588f                      addq.l     #4,a7
[0000038e] 4a87                      tst.l      d7
[00000390] 6714                      beq.s      _datend_2
[00000392] 4aae fffc                 tst.l      -4(a6)
[00000396] 670a                      beq.s      _datend_3
[00000398] 600c                      bra.s      _datend_2
_datend_1:
[0000039a] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[0000039e] 4e5e                      unlk       a6
[000003a0] 4e75                      rts
_datend_3:
[000003a2] 5385                      subq.l     #1,d5
[000003a4] 60ba                      bra.s      _datend_4
_datend_2:
[000003a6] 4a84                      tst.l      d4
[000003a8] 66f8                      bne.s      _datend_3
[000003aa] 2ebc 0002 00d6            move.l     #$000200D6,(a7) "too many initializers"
[000003b0] 4eb9 0000 3e84            jsr        _p1error
[000003b6] 7801                      moveq.l    #1,d4
[000003b8] 60e8                      bra.s      _datend_3

_datinit:
[000003ba] 4e56 fff8                 link       a6,#-8
[000003be] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000003c2] 2a6e 0008                 movea.l    8(a6),a5
[000003c6] 99cc                      suba.l     a4,a4
[000003c8] 4287                      clr.l      d7
[000003ca] 1e2d 000e                 move.b     14(a5),d7
[000003ce] 0c47 0034                 cmpi.w     #$0034,d7
[000003d2] 6624                      bne.s      _datinit_1
[000003d4] 4a6d 0008                 tst.w      8(a5)
[000003d8] 661e                      bne.s      _datinit_1
[000003da] 4287                      clr.l      d7
[000003dc] 3e2d 000c                 move.w     12(a5),d7
[000003e0] 0807 000d                 btst       #13,d7
[000003e4] 6704                      beq.s      _datinit_2
[000003e6] 7e04                      moveq.l    #4,d7
[000003e8] 6002                      bra.s      _datinit_3
_datinit_2:
[000003ea] 7e02                      moveq.l    #2,d7
_datinit_3:
[000003ec] 2e87                      move.l     d7,(a7)
[000003ee] 4eb9 0000 571a            jsr        _crx
[000003f4] 3b47 0008                 move.w     d7,8(a5)
_datinit_1:
[000003f8] 4aae 000c                 tst.l      12(a6)
[000003fc] 660c                      bne.s      _datinit_4
[000003fe] 2ebc 0000 0088            move.l     #$00000088,(a7)
[00000404] 4eb9 0000 332e            jsr        _eat
_datinit_4:
[0000040a] 2ead 0004                 move.l     4(a5),(a7)
[0000040e] 4eb9 0000 78b4            jsr        _bound
[00000414] 2d47 fff8                 move.l     d7,-8(a6)
[00000418] 2d79 0002 0cea fffc       move.l     _attlist,-4(a6)
[00000420] 4aae 000c                 tst.l      12(a6)
[00000424] 6626                      bne.s      _datinit_5
[00000426] 4878 0001                 pea.l      ($00000001).w
[0000042a] 42a7                      clr.l      -(a7)
[0000042c] 4eb9 0000 085a            jsr        _ginit
[00000432] 508f                      addq.l     #8,a7
[00000434] 2847                      movea.l    d7,a4
[00000436] 2e0c                      move.l     a4,d7
[00000438] 6612                      bne.s      _datinit_5
[0000043a] 4878 0005                 pea.l      ($00000005).w
[0000043e] 4eb9 0000 3e50            jsr        _peek
[00000444] 588f                      addq.l     #4,a7
[00000446] 4a87                      tst.l      d7
[00000448] 6700 00d2                 beq        _datinit_6
_datinit_5:
[0000044c] 4287                      clr.l      d7
[0000044e] 1e2d 000e                 move.b     14(a5),d7
[00000452] 0c47 003c                 cmpi.w     #$003C,d7
[00000456] 670c                      beq.s      _datinit_7
[00000458] 4287                      clr.l      d7
[0000045a] 1e2d 000e                 move.b     14(a5),d7
[0000045e] 0c47 003d                 cmpi.w     #$003D,d7
[00000462] 6630                      bne.s      _datinit_8
_datinit_7:
[00000464] 486d 0010                 pea.l      16(a5)
[00000468] 2f3c 0002 00ec            move.l     #$000200EC,-(a7) "redefined"
[0000046e] 4eb9 0000 3c8a            jsr        _nmerr
[00000474] 508f                      addq.l     #8,a7
_datinit_12:
[00000476] 4aae 000c                 tst.l      12(a6)
[0000047a] 6772                      beq.s      _datinit_9
[0000047c] 4297                      clr.l      (a7)
[0000047e] 2f3c 0002 0082            move.l     #$00020082,-(a7)
[00000484] 2f2d 0004                 move.l     4(a5),-(a7)
[00000488] 4eb9 0000 053c            jsr        _dinit
[0000048e] 508f                      addq.l     #8,a7
[00000490] 6000 0084                 bra        _datinit_10
_datinit_8:
[00000494] 4287                      clr.l      d7
[00000496] 1e2d 000e                 move.b     14(a5),d7
[0000049a] 0c47 0034                 cmpi.w     #$0034,d7
[0000049e] 662a                      bne.s      _datinit_11
[000004a0] 1b7c 003d 000e            move.b     #$3D,14(a5)
[000004a6] 4287                      clr.l      d7
[000004a8] 3e2d 000c                 move.w     12(a5),d7
[000004ac] 2e87                      move.l     d7,(a7)
[000004ae] 2f2e fff8                 move.l     -8(a6),-(a7)
[000004b2] 486d 0010                 pea.l      16(a5)
[000004b6] 3e2d 0008                 move.w     8(a5),d7
[000004ba] 48c7                      ext.l      d7
[000004bc] 2f07                      move.l     d7,-(a7)
[000004be] 4eb9 0000 5a30            jsr        _pdata
[000004c4] 4fef 000c                 lea.l      12(a7),a7
[000004c8] 60ac                      bra.s      _datinit_12
_datinit_11:
[000004ca] 1b7c 003c 000e            move.b     #$3C,14(a5)
[000004d0] 4287                      clr.l      d7
[000004d2] 3e2d 000c                 move.w     12(a5),d7
[000004d6] 2e87                      move.l     d7,(a7)
[000004d8] 2f2e fff8                 move.l     -8(a6),-(a7)
[000004dc] 486d 0010                 pea.l      16(a5)
[000004e0] 42a7                      clr.l      -(a7)
[000004e2] 4eb9 0000 5a30            jsr        _pdata
[000004e8] 4fef 000c                 lea.l      12(a7),a7
[000004ec] 6088                      bra.s      _datinit_12
_datinit_9:
[000004ee] 4297                      clr.l      (a7)
[000004f0] 2f0c                      move.l     a4,-(a7)
[000004f2] 2f2d 0004                 move.l     4(a5),-(a7)
[000004f6] 4eb9 0000 053c            jsr        _dinit
[000004fc] 508f                      addq.l     #8,a7
[000004fe] 4eb9 0000 5aa6            jsr        _pend
[00000504] 4878 0001                 pea.l      ($00000001).w
[00000508] 2f3c 0002 0082            move.l     #$00020082,-(a7)
[0000050e] 4eb9 0000 085a            jsr        _ginit
[00000514] 508f                      addq.l     #8,a7
_datinit_10:
[00000516] 4eb9 0000 5a8c            jsr        _pdend
_datinit_6:
[0000051c] 2eae fffc                 move.l     -4(a6),(a7)
[00000520] 2f39 0002 0cea            move.l     _attlist,-(a7)
[00000526] 4eb9 0000 8332            jsr        _frealst
[0000052c] 588f                      addq.l     #4,a7
[0000052e] 23c7 0002 0cea            move.l     d7,_attlist
[00000534] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00000538] 4e5e                      unlk       a6
[0000053a] 4e75                      rts

_dinit:
[0000053c] 4e56 ffe8                 link       a6,#-24
[00000540] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00000544] 2a6e 000c                 movea.l    12(a6),a5
[00000548] 42ae fff8                 clr.l      -8(a6)
[0000054c] 246e 0008                 movea.l    8(a6),a2
[00000550] 508a                      addq.l     #8,a2
[00000552] 4284                      clr.l      d4
[00000554] 1812                      move.b     (a2),d4
[00000556] 42ae ffe8                 clr.l      -24(a6)
[0000055a] 2d79 0002 0cea fffc       move.l     _attlist,-4(a6)
[00000562] 0c84 0000 0041            cmpi.l     #$00000041,d4
[00000568] 6616                      bne.s      _dinit_1
[0000056a] 2eae 0010                 move.l     16(a6),(a7)
[0000056e] 2f0d                      move.l     a5,-(a7)
[00000570] 2f2e 0008                 move.l     8(a6),-(a7)
[00000574] 4eba fbcc                 jsr        _arinit(pc)
[00000578] 508f                      addq.l     #8,a7
[0000057a] 2d47 ffe8                 move.l     d7,-24(a6)
[0000057e] 6030                      bra.s      _dinit_2
_dinit_1:
[00000580] 0c84 0000 0048            cmpi.l     #$00000048,d4
[00000586] 6660                      bne.s      _dinit_3
[00000588] bbfc 0002 0082            cmpa.l     #$00020082,a5
[0000058e] 6758                      beq.s      _dinit_3
[00000590] 2eae 0010                 move.l     16(a6),(a7)
[00000594] 2f0d                      move.l     a5,-(a7)
[00000596] 45f8 000a                 lea.l      ($0000000A).w,a2
[0000059a] d5ee 0008                 adda.l     8(a6),a2
[0000059e] 2452                      movea.l    (a2),a2
[000005a0] 508a                      addq.l     #8,a2
[000005a2] 2f12                      move.l     (a2),-(a7)
[000005a4] 4eb9 0000 094a            jsr        _stinit
[000005aa] 508f                      addq.l     #8,a7
[000005ac] 2d47 ffe8                 move.l     d7,-24(a6)
_dinit_2:
[000005b0] 4878 0001                 pea.l      ($00000001).w
[000005b4] 2f2e 0008                 move.l     8(a6),-(a7)
[000005b8] 4eb9 0000 7b74            jsr        _bytes
[000005be] 508f                      addq.l     #8,a7
[000005c0] 2d47 ffec                 move.l     d7,-20(a6)
[000005c4] 2e2e ffec                 move.l     -20(a6),d7
[000005c8] 9eae ffe8                 sub.l      -24(a6),d7
[000005cc] 2e87                      move.l     d7,(a7)
[000005ce] 4eb9 0000 6140            jsr        _pspace
[000005d4] 4aae fff8                 tst.l      -8(a6)
[000005d8] 6700 025c                 beq        _dinit_4
[000005dc] 2eae fff8                 move.l     -8(a6),(a7)
[000005e0] 4eba fd70                 jsr        _datend(pc)
[000005e4] 6000 0250                 bra        _dinit_4
_dinit_3:
[000005e8] bbfc 0002 0082            cmpa.l     #$00020082,a5
[000005ee] 6712                      beq.s      _dinit_5
[000005f0] 4297                      clr.l      (a7)
[000005f2] 2f0d                      move.l     a5,-(a7)
[000005f4] 4eb9 0000 085a            jsr        _ginit
[000005fa] 588f                      addq.l     #4,a7
[000005fc] 2a47                      movea.l    d7,a5
[000005fe] 2e0d                      move.l     a5,d7
[00000600] 6626                      bne.s      _dinit_6
_dinit_5:
[00000602] 4878 0005                 pea.l      ($00000005).w
[00000606] 4eb9 0000 3be2            jsr        _neat
[0000060c] 588f                      addq.l     #4,a7
[0000060e] 2d47 fff8                 move.l     d7,-8(a6)
[00000612] 679c                      beq.s      _dinit_2
[00000614] 4878 0001                 pea.l      ($00000001).w
[00000618] 42a7                      clr.l      -(a7)
[0000061a] 4eb9 0000 085a            jsr        _ginit
[00000620] 508f                      addq.l     #8,a7
[00000622] 2a47                      movea.l    d7,a5
[00000624] 2e0d                      move.l     a5,d7
[00000626] 6788                      beq.s      _dinit_2
_dinit_6:
[00000628] 2e04                      move.l     d4,d7
[0000062a] 41f9 0002 00f6            lea.l      $000200F6,a0
[00000630] 4ef9 0000 a7dc            jmp        a.switch
[00000636] 45f8 000a                 lea.l      ($0000000A).w,a2
[0000063a] d5ee 0008                 adda.l     8(a6),a2
[0000063e] 2452                      movea.l    (a2),a2
[00000640] 508a                      addq.l     #8,a2
[00000642] 4a92                      tst.l      (a2)
[00000644] 6700 ff6a                 beq        _dinit_2
[00000648] 2e2e 0010                 move.l     16(a6),d7
[0000064c] 8eae fff8                 or.l       -8(a6),d7
[00000650] 2e87                      move.l     d7,(a7)
[00000652] 2f0d                      move.l     a5,-(a7)
[00000654] 45f8 000a                 lea.l      ($0000000A).w,a2
[00000658] d5ee 0008                 adda.l     8(a6),a2
[0000065c] 2452                      movea.l    (a2),a2
[0000065e] 508a                      addq.l     #8,a2
[00000660] 2452                      movea.l    (a2),a2
[00000662] 588a                      addq.l     #4,a2
[00000664] 2f12                      move.l     (a2),-(a7)
[00000666] 4eba fed4                 jsr        _dinit(pc)
[0000066a] 508f                      addq.l     #8,a7
[0000066c] 2d47 ffe8                 move.l     d7,-24(a6)
[00000670] 6000 ff3e                 bra        _dinit_2
[00000674] 6000 ff3a                 bra        _dinit_2
[00000678] 2e8d                      move.l     a5,(a7)
[0000067a] 4eb9 0000 83b6            jsr        _iscons
[00000680] 4a87                      tst.l      d7
[00000682] 6712                      beq.s      _dinit_7
[00000684] 2e8d                      move.l     a5,(a7)
[00000686] 2f2e 0008                 move.l     8(a6),-(a7)
[0000068a] 4eb9 0000 86a8            jsr        _canass
[00000690] 588f                      addq.l     #4,a7
[00000692] 4a87                      tst.l      d7
[00000694] 6610                      bne.s      _dinit_8
_dinit_7:
[00000696] 2ebc 0002 01d8            move.l     #$000201D8,(a7) "illegal integer initializer"
[0000069c] 4eb9 0000 3e84            jsr        _p1error
[000006a2] 6000 ff0c                 bra        _dinit_2
_dinit_8:
[000006a6] 4878 0001                 pea.l      ($00000001).w
[000006aa] 2f2e 0008                 move.l     8(a6),-(a7)
[000006ae] 4eb9 0000 7b74            jsr        _bytes
[000006b4] 508f                      addq.l     #8,a7
[000006b6] 2a07                      move.l     d7,d5
[000006b8] 2eae 0008                 move.l     8(a6),(a7)
[000006bc] 486d 0008                 pea.l      8(a5)
[000006c0] 4eb9 0000 6dd2            jsr        _docast
[000006c6] 588f                      addq.l     #4,a7
[000006c8] 2e85                      move.l     d5,(a7)
[000006ca] 2f2d 0008                 move.l     8(a5),-(a7)
[000006ce] 4eb9 0000 5c34            jsr        _pint
[000006d4] 588f                      addq.l     #4,a7
[000006d6] 2d47 ffe8                 move.l     d7,-24(a6)
[000006da] 6000 fed4                 bra        _dinit_2
[000006de] 2e8d                      move.l     a5,(a7)
[000006e0] 2f2e 0008                 move.l     8(a6),-(a7)
[000006e4] 4eb9 0000 86a8            jsr        _canass
[000006ea] 588f                      addq.l     #4,a7
[000006ec] 4a87                      tst.l      d7
[000006ee] 660c                      bne.s      _dinit_9
[000006f0] 2ebc 0002 01b7            move.l     #$000201B7,(a7) "illegal pointer initializer type"
[000006f6] 4eb9 0000 3e84            jsr        _p1error
_dinit_9:
[000006fc] 4287                      clr.l      d7
[000006fe] 1e2d 0016                 move.b     22(a5),d7
[00000702] 0c47 0066                 cmpi.w     #$0066,d7
[00000706] 6606                      bne.s      _dinit_10
[00000708] 2a6d 0008                 movea.l    8(a5),a5
[0000070c] 60ee                      bra.s      _dinit_9
_dinit_10:
[0000070e] 4a2d 0016                 tst.b      22(a5)
[00000712] 661a                      bne.s      _dinit_11
[00000714] 0c2d 0001 0015            cmpi.b     #$01,21(a5)
[0000071a] 6e12                      bgt.s      _dinit_11
[0000071c] 4a2d 0014                 tst.b      20(a5)
[00000720] 660c                      bne.s      _dinit_11
[00000722] 2e8d                      move.l     a5,(a7)
[00000724] 4eb9 0000 7fda            jsr        _dlit
[0000072a] 4a87                      tst.l      d7
[0000072c] 6710                      beq.s      _dinit_12
_dinit_11:
[0000072e] 2ebc 0002 019b            move.l     #$0002019B,(a7) "illegal pointer initializer"
[00000734] 4eb9 0000 3e84            jsr        _p1error
[0000073a] 6000 fe74                 bra        _dinit_2
_dinit_12:
[0000073e] 4297                      clr.l      (a7)
[00000740] 45f8 000a                 lea.l      ($0000000A).w,a2
[00000744] d5ee 0008                 adda.l     8(a6),a2
[00000748] 4287                      clr.l      d7
[0000074a] 3e12                      move.w     (a2),d7
[0000074c] 0287 0000 0800            andi.l     #$00000800,d7
[00000752] 2f07                      move.l     d7,-(a7)
[00000754] 246e 0008                 movea.l    8(a6),a2
[00000758] 588a                      addq.l     #4,a2
[0000075a] 2f12                      move.l     (a2),-(a7)
[0000075c] 4eb9 0000 78b4            jsr        _bound
[00000762] 588f                      addq.l     #4,a7
[00000764] 2f07                      move.l     d7,-(a7)
[00000766] 2f2d 0008                 move.l     8(a5),-(a7)
[0000076a] 2f2d 000c                 move.l     12(a5),-(a7)
[0000076e] 3e2d 0010                 move.w     16(a5),d7
[00000772] 48c7                      ext.l      d7
[00000774] 2f07                      move.l     d7,-(a7)
[00000776] 4eb9 0000 5908            jsr        _paddr
[0000077c] 4fef 0014                 lea.l      20(a7),a7
[00000780] 2d47 ffe8                 move.l     d7,-24(a6)
[00000784] 6000 fe2a                 bra        _dinit_2
[00000788] 4878 0001                 pea.l      ($00000001).w
[0000078c] 2f2e 0008                 move.l     8(a6),-(a7)
[00000790] 4eb9 0000 7b74            jsr        _bytes
[00000796] 508f                      addq.l     #8,a7
[00000798] 2a07                      move.l     d7,d5
[0000079a] 2e8d                      move.l     a5,(a7)
[0000079c] 4eb9 0000 7fda            jsr        _dlit
[000007a2] 4a87                      tst.l      d7
[000007a4] 6718                      beq.s      _dinit_13
[000007a6] 2e85                      move.l     d5,(a7)
[000007a8] 2f2d 000c                 move.l     12(a5),-(a7)
[000007ac] 5297                      addq.l     #1,(a7)
[000007ae] 4eb9 0000 5b94            jsr        _pfloat
[000007b4] 588f                      addq.l     #4,a7
[000007b6] 2d47 ffe8                 move.l     d7,-24(a6)
[000007ba] 6000 fdf4                 bra        _dinit_2
_dinit_13:
[000007be] 2e8d                      move.l     a5,(a7)
[000007c0] 4eb9 0000 83b6            jsr        _iscons
[000007c6] 4a87                      tst.l      d7
[000007c8] 6724                      beq.s      _dinit_14
[000007ca] 246d 0004                 movea.l    4(a5),a2
[000007ce] 508a                      addq.l     #8,a2
[000007d0] 4287                      clr.l      d7
[000007d2] 1e12                      move.b     (a2),d7
[000007d4] 0c47 0021                 cmpi.w     #$0021,d7
[000007d8] 6624                      bne.s      _dinit_15
[000007da] 202d 0008                 move.l     8(a5),d0
[000007de] 4eb9 0000 a83a            jsr        a.6ultd
[000007e4] 2d46 fff0                 move.l     d6,-16(a6)
[000007e8] 2d47 fff4                 move.l     d7,-12(a6)
[000007ec] 6022                      bra.s      _dinit_16
_dinit_14:
[000007ee] 2ebc 0002 0180            move.l     #$00020180,(a7) "illegal double initializer"
[000007f4] 4eb9 0000 3e84            jsr        _p1error
[000007fa] 6000 fdb4                 bra        _dinit_2
_dinit_15:
[000007fe] 202d 0008                 move.l     8(a5),d0
[00000802] 4eb9 0000 ae18            jsr        a.6ltd
[00000808] 2d46 fff0                 move.l     d6,-16(a6)
[0000080c] 2d47 fff4                 move.l     d7,-12(a6)
_dinit_16:
[00000810] 2e85                      move.l     d5,(a7)
[00000812] 486e fff0                 pea.l      -16(a6)
[00000816] 4eb9 0000 5b94            jsr        _pfloat
[0000081c] 588f                      addq.l     #4,a7
[0000081e] 2d47 ffe8                 move.l     d7,-24(a6)
[00000822] 6000 fd8c                 bra        _dinit_2
[00000826] 2ebc 0002 016e            move.l     #$0002016E,(a7) "cannot initialize"
[0000082c] 4eb9 0000 3e84            jsr        _p1error
[00000832] 6000 fd7c                 bra        _dinit_2
_dinit_4:
[00000836] 2eae fffc                 move.l     -4(a6),(a7)
[0000083a] 2f39 0002 0cea            move.l     _attlist,-(a7)
[00000840] 4eb9 0000 8332            jsr        _frealst
[00000846] 588f                      addq.l     #4,a7
[00000848] 23c7 0002 0cea            move.l     d7,_attlist
[0000084e] 2e2e ffec                 move.l     -20(a6),d7
[00000852] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00000856] 4e5e                      unlk       a6
[00000858] 4e75                      rts

_ginit:
[0000085a] 4e56 0000                 link       a6,#0
[0000085e] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00000862] 2a6e 0008                 movea.l    8(a6),a5
[00000866] 4aae 000c                 tst.l      12(a6)
[0000086a] 6716                      beq.s      _ginit_1
[0000086c] 4ab9 0002 009a            tst.l      $0002009A
[00000872] 6716                      beq.s      _ginit_2
[00000874] 2ebc 0002 020d            move.l     #$0002020D,(a7) "excess repeated initializers"
[0000087a] 4eb9 0000 3e84            jsr        _p1error
[00000880] 6008                      bra.s      _ginit_2
_ginit_1:
[00000882] 2e0d                      move.l     a5,d7
[00000884] 670c                      beq.s      _ginit_3
[00000886] 2e0d                      move.l     a5,d7
[00000888] 606a                      bra.s      _ginit_4
_ginit_2:
[0000088a] 42b9 0002 009a            clr.l      $0002009A
[00000890] 60f0                      bra.s      _ginit_1
_ginit_3:
[00000892] 4ab9 0002 009a            tst.l      $0002009A
[00000898] 664e                      bne.s      _ginit_5
[0000089a] 7001                      moveq.l    #1,d0
[0000089c] 23c0 0002 009a            move.l     d0,$0002009A
[000008a2] 4285                      clr.l      d5
_ginit_9:
[000008a4] 4ab9 0002 0b8e            tst.l      _stdflag
[000008aa] 6650                      bne.s      _ginit_6
[000008ac] 4878 0004                 pea.l      ($00000004).w
[000008b0] 4eb9 0000 332e            jsr        _eat
[000008b6] 588f                      addq.l     #4,a7
[000008b8] 4a87                      tst.l      d7
[000008ba] 6740                      beq.s      _ginit_6
[000008bc] 4878 0001                 pea.l      ($00000001).w
[000008c0] 4eb9 0000 0be6            jsr        _gexpr
[000008c6] 588f                      addq.l     #4,a7
[000008c8] 2a47                      movea.l    d7,a5
[000008ca] 2e8d                      move.l     a5,(a7)
[000008cc] 4eb9 0000 83b6            jsr        _iscons
[000008d2] 4a87                      tst.l      d7
[000008d4] 664c                      bne.s      _ginit_7
[000008d6] 42ad 0008                 clr.l      8(a5)
[000008da] 2ebc 0002 01f8            move.l     #$000201F8,(a7) "illegal repeat count"
[000008e0] 4eb9 0000 3e84            jsr        _p1error
[000008e6] 6050                      bra.s      _ginit_8
_ginit_5:
[000008e8] 53b9 0002 009a            subq.l     #1,$0002009A
[000008ee] 2e39 0002 01f4            move.l     $000201F4,d7
_ginit_4:
[000008f4] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[000008f8] 4e5e                      unlk       a6
[000008fa] 4e75                      rts
_ginit_6:
[000008fc] 2e85                      move.l     d5,(a7)
[000008fe] 4eb9 0000 0be6            jsr        _gexpr
[00000904] 23c7 0002 01f4            move.l     d7,$000201F4
[0000090a] 4ab9 0002 009a            tst.l      $0002009A
[00000910] 6680                      bne.s      _ginit_3
[00000912] 4878 0002                 pea.l      ($00000002).w
[00000916] 4eb9 0000 332e            jsr        _eat
[0000091c] 588f                      addq.l     #4,a7
[0000091e] 6000 ff72                 bra        _ginit_3
_ginit_7:
[00000922] 2eb9 0002 009a            move.l     $0002009A,(a7)
[00000928] 2f2d 0008                 move.l     8(a5),-(a7)
[0000092c] 4eb9 0000 ade4            jsr        a.lmul
[00000932] 23d7 0002 009a            move.l     (a7),$0002009A
_ginit_8:
[00000938] 4878 0008                 pea.l      ($00000008).w
[0000093c] 4eb9 0000 3c08            jsr        _need
[00000942] 588f                      addq.l     #4,a7
[00000944] 7a01                      moveq.l    #1,d5
[00000946] 6000 ff5c                 bra        _ginit_9

_stinit:
[0000094a] 4e56 ffe8                 link       a6,#-24
[0000094e] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00000952] 2a6e 0008                 movea.l    8(a6),a5
[00000956] 286e 000c                 movea.l    12(a6),a4
[0000095a] 2e0c                      move.l     a4,d7
[0000095c] 6614                      bne.s      _stinit_1
[0000095e] 4878 0005                 pea.l      ($00000005).w
[00000962] 4eb9 0000 332e            jsr        _eat
[00000968] 588f                      addq.l     #4,a7
[0000096a] 4a87                      tst.l      d7
[0000096c] 6704                      beq.s      _stinit_1
[0000096e] 7e01                      moveq.l    #1,d7
[00000970] 6002                      bra.s      _stinit_2
_stinit_1:
[00000972] 4287                      clr.l      d7
_stinit_2:
[00000974] 2d47 fff8                 move.l     d7,-8(a6)
[00000978] 2e2e fff8                 move.l     -8(a6),d7
[0000097c] 8fae 0010                 or.l       d7,16(a6)
[00000980] 42ae fff4                 clr.l      -12(a6)
[00000984] 42ae ffe8                 clr.l      -24(a6)
_stinit_10:
[00000988] 2e8d                      move.l     a5,(a7)
[0000098a] 4eb9 0000 0b3e            jsr        _stnext
[00000990] 2a47                      movea.l    d7,a5
[00000992] 2e0d                      move.l     a5,d7
[00000994] 6720                      beq.s      _stinit_3
[00000996] 4297                      clr.l      (a7)
[00000998] 2f0c                      move.l     a4,-(a7)
[0000099a] 4eba febe                 jsr        _ginit(pc)
[0000099e] 588f                      addq.l     #4,a7
[000009a0] 2847                      movea.l    d7,a4
[000009a2] 2e0c                      move.l     a4,d7
[000009a4] 6626                      bne.s      _stinit_4
[000009a6] 4878 0005                 pea.l      ($00000005).w
[000009aa] 4eb9 0000 3e50            jsr        _peek
[000009b0] 588f                      addq.l     #4,a7
[000009b2] 4a87                      tst.l      d7
[000009b4] 6616                      bne.s      _stinit_4
_stinit_3:
[000009b6] 4aae fff8                 tst.l      -8(a6)
[000009ba] 6700 0176                 beq        _stinit_5
[000009be] 4878 0001                 pea.l      ($00000001).w
[000009c2] 4eba f98e                 jsr        _datend(pc)
[000009c6] 588f                      addq.l     #4,a7
[000009c8] 6000 0168                 bra        _stinit_5
_stinit_4:
[000009cc] 2e2d 0008                 move.l     8(a5),d7
[000009d0] 9eae ffe8                 sub.l      -24(a6),d7
[000009d4] 2e87                      move.l     d7,(a7)
[000009d6] 4eb9 0000 6140            jsr        _pspace
[000009dc] 246d 0004                 movea.l    4(a5),a2
[000009e0] 508a                      addq.l     #8,a2
[000009e2] 4287                      clr.l      d7
[000009e4] 1e12                      move.b     (a2),d7
[000009e6] 0c47 0019                 cmpi.w     #$0019,d7
[000009ea] 6722                      beq.s      _stinit_6
[000009ec] 2eae 0010                 move.l     16(a6),(a7)
[000009f0] 2f0c                      move.l     a4,-(a7)
[000009f2] 2f2d 0004                 move.l     4(a5),-(a7)
[000009f6] 4eba fb44                 jsr        _dinit(pc)
[000009fa] 508f                      addq.l     #8,a7
[000009fc] dead 0008                 add.l      8(a5),d7
[00000a00] 2d47 ffe8                 move.l     d7,-24(a6)
[00000a04] 2a55                      movea.l    (a5),a5
[00000a06] 99cc                      suba.l     a4,a4
[00000a08] 42ae fff4                 clr.l      -12(a6)
[00000a0c] 607a                      bra.s      _stinit_7
_stinit_6:
[00000a0e] 42ae fff0                 clr.l      -16(a6)
[00000a12] 2d6d 0008 ffec            move.l     8(a5),-20(a6)
[00000a18] 2d6d 0004 fffc            move.l     4(a5),-4(a6)
_stinit_13:
[00000a1e] 2e8d                      move.l     a5,(a7)
[00000a20] 4eb9 0000 0b3e            jsr        _stnext
[00000a26] 2a47                      movea.l    d7,a5
[00000a28] 2e0d                      move.l     a5,d7
[00000a2a] 6736                      beq.s      _stinit_8
[00000a2c] 246d 0004                 movea.l    4(a5),a2
[00000a30] 508a                      addq.l     #8,a2
[00000a32] 4287                      clr.l      d7
[00000a34] 1e12                      move.b     (a2),d7
[00000a36] 246e fffc                 movea.l    -4(a6),a2
[00000a3a] 508a                      addq.l     #8,a2
[00000a3c] 4286                      clr.l      d6
[00000a3e] 1c12                      move.b     (a2),d6
[00000a40] be86                      cmp.l      d6,d7
[00000a42] 661e                      bne.s      _stinit_8
[00000a44] 2e2d 0008                 move.l     8(a5),d7
[00000a48] beae ffec                 cmp.l      -20(a6),d7
[00000a4c] 6614                      bne.s      _stinit_8
[00000a4e] 4297                      clr.l      (a7)
[00000a50] 2f0c                      move.l     a4,-(a7)
[00000a52] 4eba fe06                 jsr        _ginit(pc)
[00000a56] 588f                      addq.l     #4,a7
[00000a58] 2847                      movea.l    d7,a4
[00000a5a] 2e0c                      move.l     a4,d7
[00000a5c] 6660                      bne.s      _stinit_9
[00000a5e] 42ae 0010                 clr.l      16(a6)
_stinit_8:
[00000a62] 4878 0001                 pea.l      ($00000001).w
[00000a66] 2f2e fffc                 move.l     -4(a6),-(a7)
[00000a6a] 4eb9 0000 7b74            jsr        _bytes
[00000a70] 508f                      addq.l     #8,a7
[00000a72] 2e87                      move.l     d7,(a7)
[00000a74] 2f2e fff0                 move.l     -16(a6),-(a7)
[00000a78] 4eb9 0000 5c34            jsr        _pint
[00000a7e] 588f                      addq.l     #4,a7
[00000a80] deae ffec                 add.l      -20(a6),d7
[00000a84] 2d47 ffe8                 move.l     d7,-24(a6)
_stinit_7:
[00000a88] 4aae 0010                 tst.l      16(a6)
[00000a8c] 6700 ff28                 beq        _stinit_3
[00000a90] 2e0d                      move.l     a5,d7
[00000a92] 6700 ff22                 beq        _stinit_3
[00000a96] 4ab9 0002 009a            tst.l      $0002009A
[00000a9c] 6600 feea                 bne        _stinit_10
[00000aa0] 4aae fff4                 tst.l      -12(a6)
[00000aa4] 6600 fee2                 bne        _stinit_10
[00000aa8] 4878 0002                 pea.l      ($00000002).w
[00000aac] 4eb9 0000 332e            jsr        _eat
[00000ab2] 588f                      addq.l     #4,a7
[00000ab4] 4a87                      tst.l      d7
[00000ab6] 6600 fed0                 bne        _stinit_10
[00000aba] 6000 fefa                 bra        _stinit_3
_stinit_9:
[00000abe] 2e8c                      move.l     a4,(a7)
[00000ac0] 4eb9 0000 83b6            jsr        _iscons
[00000ac6] 4a87                      tst.l      d7
[00000ac8] 660e                      bne.s      _stinit_11
[00000aca] 2ebc 0002 022a            move.l     #$0002022A,(a7) "illegal field initializer"
[00000ad0] 4eb9 0000 3e84            jsr        _p1error
[00000ad6] 602c                      bra.s      _stinit_12
_stinit_11:
[00000ad8] 7e01                      moveq.l    #1,d7
[00000ada] 45f8 000b                 lea.l      ($0000000B).w,a2
[00000ade] d5ed 0004                 adda.l     4(a5),a2
[00000ae2] 1c12                      move.b     (a2),d6
[00000ae4] 4886                      ext.w      d6
[00000ae6] 48c6                      ext.l      d6
[00000ae8] eda7                      asl.l      d6,d7
[00000aea] 5387                      subq.l     #1,d7
[00000aec] ceac 0008                 and.l      8(a4),d7
[00000af0] 45f8 000a                 lea.l      ($0000000A).w,a2
[00000af4] d5ed 0004                 adda.l     4(a5),a2
[00000af8] 1c12                      move.b     (a2),d6
[00000afa] 4886                      ext.w      d6
[00000afc] 48c6                      ext.l      d6
[00000afe] eda7                      asl.l      d6,d7
[00000b00] 8fae fff0                 or.l       d7,-16(a6)
_stinit_12:
[00000b04] 2a55                      movea.l    (a5),a5
[00000b06] 99cc                      suba.l     a4,a4
[00000b08] 4aae 0010                 tst.l      16(a6)
[00000b0c] 6700 ff54                 beq        _stinit_8
[00000b10] 4ab9 0002 009a            tst.l      $0002009A
[00000b16] 6600 ff06                 bne        _stinit_13
[00000b1a] 4878 0002                 pea.l      ($00000002).w
[00000b1e] 4eb9 0000 332e            jsr        _eat
[00000b24] 588f                      addq.l     #4,a7
[00000b26] 2d47 fff4                 move.l     d7,-12(a6)
[00000b2a] 6600 fef2                 bne        _stinit_13
[00000b2e] 6000 ff32                 bra        _stinit_8
_stinit_5:
[00000b32] 2e2e ffe8                 move.l     -24(a6),d7
[00000b36] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00000b3a] 4e5e                      unlk       a6
[00000b3c] 4e75                      rts

_stnext:
[00000b3e] 4e56 0000                 link       a6,#0
[00000b42] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000b46] 2a6e 0008                 movea.l    8(a6),a5
_stnext_2:
[00000b4a] 2e0d                      move.l     a5,d7
[00000b4c] 670a                      beq.s      _stnext_1
[00000b4e] 4a2d 0010                 tst.b      16(a5)
[00000b52] 6604                      bne.s      _stnext_1
[00000b54] 2a55                      movea.l    (a5),a5
[00000b56] 60f2                      bra.s      _stnext_2
_stnext_1:
[00000b58] 2e0d                      move.l     a5,d7
[00000b5a] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000b5e] 4e5e                      unlk       a6
[00000b60] 4e75                      rts

_cons:
[00000b62] 4e56 0000                 link       a6,#0
[00000b66] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000b6a] 2eae 0008                 move.l     8(a6),(a7)
[00000b6e] 4eb9 0000 0be6            jsr        _gexpr
[00000b74] 2a47                      movea.l    d7,a5
[00000b76] 2e0d                      move.l     a5,d7
[00000b78] 6604                      bne.s      _cons_1
[00000b7a] 4287                      clr.l      d7
[00000b7c] 601a                      bra.s      _cons_2
_cons_1:
[00000b7e] 2e8d                      move.l     a5,(a7)
[00000b80] 4eb9 0000 83b6            jsr        _iscons
[00000b86] 4a87                      tst.l      d7
[00000b88] 6616                      bne.s      _cons_3
[00000b8a] 2ebc 0002 02c2            move.l     #$000202C2,(a7) "constant required"
[00000b90] 4eb9 0000 3e84            jsr        _p1error
[00000b96] 4287                      clr.l      d7
_cons_2:
[00000b98] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000b9c] 4e5e                      unlk       a6
[00000b9e] 4e75                      rts
_cons_3:
[00000ba0] 2e2d 0008                 move.l     8(a5),d7
[00000ba4] 60f2                      bra.s      _cons_2

_gelist:
[00000ba6] 4e56 fffc                 link       a6,#-4
[00000baa] 4297                      clr.l      (a7)
[00000bac] 2f39 0002 0d32            move.l     _exlist,-(a7)
[00000bb2] 4eb9 0000 8372            jsr        _fretlst
[00000bb8] 588f                      addq.l     #4,a7
[00000bba] 23c7 0002 0d32            move.l     d7,_exlist
[00000bc0] 2eae 0008                 move.l     8(a6),(a7)
[00000bc4] 4eb9 0000 0da8            jsr        _melist
[00000bca] 2e87                      move.l     d7,(a7)
[00000bcc] 4eb9 0000 94c6            jsr        _typify
[00000bd2] 2e87                      move.l     d7,(a7)
[00000bd4] 4eb9 0000 8cb6            jsr        _scalify
[00000bda] 2e87                      move.l     d7,(a7)
[00000bdc] 4eb9 0000 6f92            jsr        _reduce
[00000be2] 4e5e                      unlk       a6
[00000be4] 4e75                      rts

_gexpr:
[00000be6] 4e56 fffc                 link       a6,#-4
[00000bea] 4297                      clr.l      (a7)
[00000bec] 2f39 0002 0d32            move.l     _exlist,-(a7)
[00000bf2] 4eb9 0000 8372            jsr        _fretlst
[00000bf8] 588f                      addq.l     #4,a7
[00000bfa] 23c7 0002 0d32            move.l     d7,_exlist
[00000c00] 2eae 0008                 move.l     8(a6),(a7)
[00000c04] 4eb9 0000 0e02            jsr        _mexpr
[00000c0a] 2e87                      move.l     d7,(a7)
[00000c0c] 4eb9 0000 94c6            jsr        _typify
[00000c12] 2e87                      move.l     d7,(a7)
[00000c14] 4eb9 0000 8cb6            jsr        _scalify
[00000c1a] 2e87                      move.l     d7,(a7)
[00000c1c] 4eb9 0000 6f92            jsr        _reduce
[00000c22] 4e5e                      unlk       a6
[00000c24] 4e75                      rts

_gtest:
[00000c26] 4e56 0000                 link       a6,#0
[00000c2a] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000c2e] 4878 0006                 pea.l      ($00000006).w
[00000c32] 4eb9 0000 3c08            jsr        _need
[00000c38] 588f                      addq.l     #4,a7
[00000c3a] 2eae 0008                 move.l     8(a6),(a7)
[00000c3e] 4eba ff66                 jsr        _gelist(pc)
[00000c42] 2a47                      movea.l    d7,a5
[00000c44] 4878 000a                 pea.l      ($0000000A).w
[00000c48] 4eb9 0000 3c08            jsr        _need
[00000c4e] 588f                      addq.l     #4,a7
[00000c50] 2e0d                      move.l     a5,d7
[00000c52] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000c56] 4e5e                      unlk       a6
[00000c58] 4e75                      rts

_mbin:
[00000c5a] 4e56 fffa                 link       a6,#-6
[00000c5e] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00000c62] 2ebc 0002 0244            move.l     #$00020244,(a7)
[00000c68] 4eb9 0000 3192            jsr        _alt
[00000c6e] 2807                      move.l     d7,d4
[00000c70] 6604                      bne.s      _mbin_1
[00000c72] 4287                      clr.l      d7
[00000c74] 603c                      bra.s      _mbin_2
_mbin_1:
[00000c76] 0c84 0000 009f            cmpi.l     #$0000009F,d4
[00000c7c] 663c                      bne.s      _mbin_3
[00000c7e] 4297                      clr.l      (a7)
[00000c80] 42a7                      clr.l      -(a7)
[00000c82] 42a7                      clr.l      -(a7)
[00000c84] 4878 009f                 pea.l      ($0000009F).w
[00000c88] 4eb9 0000 7a0e            jsr        _buyop
[00000c8e] 4fef 000c                 lea.l      12(a7),a7
[00000c92] 2a47                      movea.l    d7,a5
[00000c94] 4878 0001                 pea.l      ($00000001).w
[00000c98] 4eb9 0000 0e02            jsr        _mexpr
[00000c9e] 588f                      addq.l     #4,a7
[00000ca0] 2b47 0010                 move.l     d7,16(a5)
[00000ca4] 4878 0001                 pea.l      ($00000001).w
[00000ca8] 4eb9 0000 3c08            jsr        _need
[00000cae] 588f                      addq.l     #4,a7
[00000cb0] 2e0d                      move.l     a5,d7
_mbin_2:
[00000cb2] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00000cb6] 4e5e                      unlk       a6
[00000cb8] 4e75                      rts
_mbin_3:
[00000cba] 486e fffa                 pea.l      -6(a6)
[00000cbe] 4eb9 0000 34e6            jsr        _gettok1
[00000cc4] 588f                      addq.l     #4,a7
[00000cc6] 2447                      movea.l    d7,a2
[00000cc8] 4287                      clr.l      d7
[00000cca] 1e12                      move.b     (a2),d7
[00000ccc] 0c47 0088                 cmpi.w     #$0088,d7
[00000cd0] 670e                      beq.s      _mbin_4
[00000cd2] 486e fffa                 pea.l      -6(a6)
[00000cd6] 4eb9 0000 31e4            jsr        _baktok1
[00000cdc] 588f                      addq.l     #4,a7
[00000cde] 6038                      bra.s      _mbin_5
_mbin_4:
[00000ce0] 2e84                      move.l     d4,(a7)
[00000ce2] 2f3c 0002 0244            move.l     #$00020244,-(a7)
[00000ce8] 4eb9 0000 a7a6            jsr        _scnstr
[00000cee] 588f                      addq.l     #4,a7
[00000cf0] 2447                      movea.l    d7,a2
[00000cf2] d5fc 0002 0263            adda.l     #$00020263,a2
[00000cf8] 1a12                      move.b     (a2),d5
[00000cfa] 4885                      ext.w      d5
[00000cfc] 48c5                      ext.l      d5
[00000cfe] 670c                      beq.s      _mbin_6
[00000d00] 2e05                      move.l     d5,d7
[00000d02] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000d08] 2807                      move.l     d7,d4
[00000d0a] 600c                      bra.s      _mbin_5
_mbin_6:
[00000d0c] 486e fffa                 pea.l      -6(a6)
[00000d10] 4eb9 0000 31e4            jsr        _baktok1
[00000d16] 588f                      addq.l     #4,a7
_mbin_5:
[00000d18] 4297                      clr.l      (a7)
[00000d1a] 42a7                      clr.l      -(a7)
[00000d1c] 42a7                      clr.l      -(a7)
[00000d1e] 2f04                      move.l     d4,-(a7)
[00000d20] 4eb9 0000 7a0e            jsr        _buyop
[00000d26] 4fef 000c                 lea.l      12(a7),a7
[00000d2a] 6086                      bra.s      _mbin_2

_mcast:
[00000d2c] 4e56 ffee                 link       a6,#-18
[00000d30] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000d34] 42b9 0002 02be            clr.l      _freeexpr
[00000d3a] 4297                      clr.l      (a7)
[00000d3c] 486e ffee                 pea.l      -18(a6)
[00000d40] 4eb9 0000 4d4c            jsr        _gscty
[00000d46] 588f                      addq.l     #4,a7
[00000d48] 4a87                      tst.l      d7
[00000d4a] 660c                      bne.s      _mcast_1
[00000d4c] 7001                      moveq.l    #1,d0
[00000d4e] 23c0 0002 02be            move.l     d0,_freeexpr
[00000d54] 4287                      clr.l      d7
[00000d56] 6048                      bra.s      _mcast_2
_mcast_1:
[00000d58] 4878 0001                 pea.l      ($00000001).w
[00000d5c] 486e ffee                 pea.l      -18(a6)
[00000d60] 4eb9 0000 4b1e            jsr        _gdecl
[00000d66] 508f                      addq.l     #8,a7
[00000d68] 2a47                      movea.l    d7,a5
[00000d6a] 7001                      moveq.l    #1,d0
[00000d6c] 23c0 0002 02be            move.l     d0,_freeexpr
[00000d72] 4878 000a                 pea.l      ($0000000A).w
[00000d76] 4eb9 0000 3c08            jsr        _need
[00000d7c] 588f                      addq.l     #4,a7
[00000d7e] 2ead 0004                 move.l     4(a5),(a7)
[00000d82] 42a7                      clr.l      -(a7)
[00000d84] 42a7                      clr.l      -(a7)
[00000d86] 4878 0066                 pea.l      ($00000066).w
[00000d8a] 4eb9 0000 7a0e            jsr        _buyop
[00000d90] 4fef 000c                 lea.l      12(a7),a7
[00000d94] 2e87                      move.l     d7,(a7)
[00000d96] 2f0d                      move.l     a5,-(a7)
[00000d98] 4eb9 0000 aa76            jsr        _free
[00000d9e] 588f                      addq.l     #4,a7
_mcast_2:
[00000da0] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000da4] 4e5e                      unlk       a6
[00000da6] 4e75                      rts

_melist:
[00000da8] 4e56 0000                 link       a6,#0
[00000dac] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000db0] 2eae 0008                 move.l     8(a6),(a7)
[00000db4] 4eb9 0000 0e02            jsr        _mexpr
[00000dba] 2a47                      movea.l    d7,a5
[00000dbc] 2e0d                      move.l     a5,d7
[00000dbe] 6604                      bne.s      _melist_1
[00000dc0] 4287                      clr.l      d7
[00000dc2] 6036                      bra.s      _melist_2
_melist_1:
[00000dc4] 4878 0002                 pea.l      ($00000002).w
[00000dc8] 4eb9 0000 332e            jsr        _eat
[00000dce] 588f                      addq.l     #4,a7
[00000dd0] 4a87                      tst.l      d7
[00000dd2] 6724                      beq.s      _melist_3
[00000dd4] 4297                      clr.l      (a7)
[00000dd6] 4878 0001                 pea.l      ($00000001).w
[00000dda] 4eb9 0000 0e02            jsr        _mexpr
[00000de0] 588f                      addq.l     #4,a7
[00000de2] 2f07                      move.l     d7,-(a7)
[00000de4] 2f0d                      move.l     a5,-(a7)
[00000de6] 4878 00a8                 pea.l      ($000000A8).w
[00000dea] 4eb9 0000 7a0e            jsr        _buyop
[00000df0] 4fef 000c                 lea.l      12(a7),a7
[00000df4] 2a47                      movea.l    d7,a5
[00000df6] 60cc                      bra.s      _melist_1
_melist_3:
[00000df8] 2e0d                      move.l     a5,d7
_melist_2:
[00000dfa] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000dfe] 4e5e                      unlk       a6
[00000e00] 4e75                      rts

_mexpr:
[00000e02] 4e56 fffc                 link       a6,#-4
[00000e06] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000e0a] 2eae 0008                 move.l     8(a6),(a7)
[00000e0e] 4eb9 0000 102e            jsr        _mterm
[00000e14] 2a47                      movea.l    d7,a5
[00000e16] 2e0d                      move.l     a5,d7
[00000e18] 6604                      bne.s      _mexpr_1
[00000e1a] 4287                      clr.l      d7
[00000e1c] 601c                      bra.s      _mexpr_2
_mexpr_1:
[00000e1e] 4eba fe3a                 jsr        _mbin(pc)
[00000e22] 2d47 fffc                 move.l     d7,-4(a6)
[00000e26] 671a                      beq.s      _mexpr_3
[00000e28] 486e fffc                 pea.l      -4(a6)
[00000e2c] 2f0d                      move.l     a5,-(a7)
[00000e2e] 42a7                      clr.l      -(a7)
[00000e30] 4eb9 0000 0f44            jsr        _mtail
[00000e36] 4fef 000c                 lea.l      12(a7),a7
_mexpr_2:
[00000e3a] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000e3e] 4e5e                      unlk       a6
[00000e40] 4e75                      rts
_mexpr_3:
[00000e42] 2e0d                      move.l     a5,d7
[00000e44] 60f4                      bra.s      _mexpr_2

_mident:
[00000e46] 4e56 0000                 link       a6,#0
[00000e4a] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00000e4e] 4297                      clr.l      (a7)
[00000e50] 2f39 0002 0d2e            move.l     _symtab,-(a7)
[00000e56] 2f2e 0008                 move.l     8(a6),-(a7)
[00000e5a] 4eb9 0000 847e            jsr        _lookup
[00000e60] 508f                      addq.l     #8,a7
[00000e62] 2a47                      movea.l    d7,a5
[00000e64] 2e0d                      move.l     a5,d7
[00000e66] 6626                      bne.s      _mident_1
[00000e68] 4878 002a                 pea.l      ($0000002A).w
[00000e6c] 2f2e 0008                 move.l     8(a6),-(a7)
[00000e70] 42a7                      clr.l      -(a7)
[00000e72] 4eb9 0000 7a78            jsr        _buysym
[00000e78] 4fef 000c                 lea.l      12(a7),a7
[00000e7c] 2a47                      movea.l    d7,a5
[00000e7e] 2ebc 0002 0d2e            move.l     #_symtab,(a7)
[00000e84] 2f0d                      move.l     a5,-(a7)
[00000e86] 4eb9 0000 774e            jsr        _addsym
[00000e8c] 588f                      addq.l     #4,a7
_mident_1:
[00000e8e] 1b7c 0001 000f            move.b     #$01,15(a5)
[00000e94] 4878 0001                 pea.l      ($00000001).w
[00000e98] 42a7                      clr.l      -(a7)
[00000e9a] 42a7                      clr.l      -(a7)
[00000e9c] 42a7                      clr.l      -(a7)
[00000e9e] 2f2d 0004                 move.l     4(a5),-(a7)
[00000ea2] 4eb9 0000 7aec            jsr        _buyterm
[00000ea8] 4fef 0014                 lea.l      20(a7),a7
[00000eac] 2847                      movea.l    d7,a4
[00000eae] 396d 000c 0012            move.w     12(a5),18(a4)
[00000eb4] 4287                      clr.l      d7
[00000eb6] 1e2d 000e                 move.b     14(a5),d7
[00000eba] 41f9 0002 02d4            lea.l      $000202D4,a0
[00000ec0] 4ef9 0000 a7dc            jmp        a.switch
[00000ec6] 426c 0010                 clr.w      16(a4)
[00000eca] 45ed 0010                 lea.l      16(a5),a2
[00000ece] 294a 000c                 move.l     a2,12(a4)
[00000ed2] 2e0c                      move.l     a4,d7
[00000ed4] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00000ed8] 4e5e                      unlk       a6
[00000eda] 4e75                      rts

xedc_1:
[00000edc] 396d 0008 0010            move.w     8(a5),16(a4)
[00000ee2] 45ed 0010                 lea.l      16(a5),a2
[00000ee6] 294a 000c                 move.l     a2,12(a4)
[00000eea] 60e6                      bra.s      xedc_1
[00000eec] 296d 0008 0008            move.l     8(a5),8(a4)
[00000ef2] 197c 00a0 0014            move.b     #$A0,20(a4)
[00000ef8] 60d8                      bra.s      xedc_1
[00000efa] 296d 0008 0008            move.l     8(a5),8(a4)
[00000f00] 197c 0020 0014            move.b     #$20,20(a4)
[00000f06] 60ca                      bra.s      xedc_1
[00000f08] 196d 0008 0014            move.b     8(a5),20(a4)
[00000f0e] 422c 0015                 clr.b      21(a4)
[00000f12] 60be                      bra.s      xedc_1
[00000f14] 296d 0008 0008            move.l     8(a5),8(a4)
[00000f1a] 422c 0015                 clr.b      21(a4)
[00000f1e] 60b2                      bra.s      xedc_1
[00000f20] 296d 0008 0008            move.l     8(a5),8(a4)
[00000f26] 60aa                      bra.s      xedc_1
[00000f28] 486d 0010                 pea.l      16(a5)
[00000f2c] 2f3c 0002 032c            move.l     #$0002032C,-(a7) "illegal use of typedef"
[00000f32] 4eb9 0000 3c8a            jsr        _nmerr
[00000f38] 508f                      addq.l     #8,a7
[00000f3a] 297c 0002 0dc2 0004       move.l     #_atint,4(a4)
[00000f42] 608e                      bra.s      xedc_1

_mtail:
[00000f44] 4e56 fffc                 link       a6,#-4
[00000f48] 48e7 8c1c                 movem.l    d0/d4-d5/a3-a5,-(a7)
[00000f4c] 2a6e 000c                 movea.l    12(a6),a5
[00000f50] 246e 0010                 movea.l    16(a6),a2
[00000f54] 2d52 fffc                 move.l     (a2),-4(a6)
_mtail_3:
[00000f58] 4aae fffc                 tst.l      -4(a6)
[00000f5c] 6700 009e                 beq        _mtail_1
[00000f60] 45f8 0016                 lea.l      ($00000016).w,a2
[00000f64] d5ee fffc                 adda.l     -4(a6),a2
[00000f68] 4287                      clr.l      d7
[00000f6a] 1e12                      move.b     (a2),d7
[00000f6c] 2e87                      move.l     d7,(a7)
[00000f6e] 2f3c 0002 0244            move.l     #$00020244,-(a7)
[00000f74] 4eb9 0000 a7a6            jsr        _scnstr
[00000f7a] 588f                      addq.l     #4,a7
[00000f7c] 2a07                      move.l     d7,d5
[00000f7e] 2445                      movea.l    d5,a2
[00000f80] d5fc 0002 029f            adda.l     #$0002029F,a2
[00000f86] 1e12                      move.b     (a2),d7
[00000f88] 4887                      ext.w      d7
[00000f8a] 48c7                      ext.l      d7
[00000f8c] 2c2e 0008                 move.l     8(a6),d6
[00000f90] bc87                      cmp.l      d7,d6
[00000f92] 6c68                      bge.s      _mtail_1
[00000f94] 2445                      movea.l    d5,a2
[00000f96] d5fc 0002 0281            adda.l     #$00020281,a2
[00000f9c] 1812                      move.b     (a2),d4
[00000f9e] 4884                      ext.w      d4
[00000fa0] 48c4                      ext.l      d4
[00000fa2] 4878 0001                 pea.l      ($00000001).w
[00000fa6] 4eb9 0000 102e            jsr        _mterm
[00000fac] 588f                      addq.l     #4,a7
[00000fae] 2847                      movea.l    d7,a4
[00000fb0] 4eba fca8                 jsr        _mbin(pc)
[00000fb4] 2d47 fffc                 move.l     d7,-4(a6)
[00000fb8] 674c                      beq.s      _mtail_2
[00000fba] 45f8 0016                 lea.l      ($00000016).w,a2
[00000fbe] d5ee fffc                 adda.l     -4(a6),a2
[00000fc2] 4287                      clr.l      d7
[00000fc4] 1e12                      move.b     (a2),d7
[00000fc6] 2e87                      move.l     d7,(a7)
[00000fc8] 2f3c 0002 0244            move.l     #$00020244,-(a7)
[00000fce] 4eb9 0000 a7a6            jsr        _scnstr
[00000fd4] 588f                      addq.l     #4,a7
[00000fd6] 2447                      movea.l    d7,a2
[00000fd8] d5fc 0002 029f            adda.l     #$0002029F,a2
[00000fde] 1e12                      move.b     (a2),d7
[00000fe0] 4887                      ext.w      d7
[00000fe2] 48c7                      ext.l      d7
[00000fe4] b887                      cmp.l      d7,d4
[00000fe6] 6c1e                      bge.s      _mtail_2
[00000fe8] 486e fffc                 pea.l      -4(a6)
[00000fec] 2f0c                      move.l     a4,-(a7)
[00000fee] 2f04                      move.l     d4,-(a7)
[00000ff0] 4eba ff52                 jsr        _mtail(pc)
[00000ff4] 4fef 000c                 lea.l      12(a7),a7
[00000ff8] 2847                      movea.l    d7,a4
[00000ffa] 600a                      bra.s      _mtail_2
_mtail_1:
[00000ffc] 2e0d                      move.l     a5,d7
[00000ffe] 4cdf 3831                 movem.l    (a7)+,d0/d4-d5/a3-a5
[00001002] 4e5e                      unlk       a6
[00001004] 4e75                      rts
_mtail_2:
[00001006] 246e 0010                 movea.l    16(a6),a2
[0000100a] 2452                      movea.l    (a2),a2
[0000100c] 508a                      addq.l     #8,a2
[0000100e] 248d                      move.l     a5,(a2)
[00001010] 246e 0010                 movea.l    16(a6),a2
[00001014] 2a52                      movea.l    (a2),a5
[00001016] 45f8 000c                 lea.l      ($0000000C).w,a2
[0000101a] 266e 0010                 movea.l    16(a6),a3
[0000101e] d5d3                      adda.l     (a3),a2
[00001020] 248c                      move.l     a4,(a2)
[00001022] 246e 0010                 movea.l    16(a6),a2
[00001026] 24ae fffc                 move.l     -4(a6),(a2)
[0000102a] 6000 ff2c                 bra        _mtail_3

_mterm:
[0000102e] 4e56 fff4                 link       a6,#-12
[00001032] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00001036] 486e fff4                 pea.l      -12(a6)
[0000103a] 4eb9 0000 34e6            jsr        _gettok1
[00001040] 588f                      addq.l     #4,a7
[00001042] 2447                      movea.l    d7,a2
[00001044] 4287                      clr.l      d7
[00001046] 1e12                      move.b     (a2),d7
[00001048] 41f9 0002 0358            lea.l      $00020358,a0
[0000104e] 4ef9 0000 a7dc            jmp        a.switch
[00001054] 2eae fff6                 move.l     -10(a6),(a7)
[00001058] 4eba fdec                 jsr        _mident(pc)
[0000105c] 2a47                      movea.l    d7,a5
[0000105e] 2e8d                      move.l     a5,(a7)
[00001060] 4eb9 0000 137a            jsr        _mtrail
[00001066] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000106a] 4e5e                      unlk       a6
[0000106c] 4e75                      rts

x106e_2:
[0000106e] 4878 0004                 pea.l      ($00000004).w
[00001072] 2f2e fff6                 move.l     -10(a6),-(a7)
[00001076] 486e fffc                 pea.l      -4(a6)
[0000107a] 4eb9 0000 adac            jsr        _cpybuf
[00001080] 4fef 000c                 lea.l      12(a7),a7
[00001084] 4287                      clr.l      d7
[00001086] 1e2e fff4                 move.b     -12(a6),d7
[0000108a] 0c47 0018                 cmpi.w     #$0018,d7
[0000108e] 661a                      bne.s      x106e_1
[00001090] 4ab9 0002 0b9a            tst.l      _uflag
[00001096] 6612                      bne.s      x106e_1
[00001098] 1d6e ffff fffb            move.b     -1(a6),-5(a6)
[0000109e] 1e2e fffb                 move.b     -5(a6),d7
[000010a2] 4887                      ext.w      d7
[000010a4] 48c7                      ext.l      d7
[000010a6] 2d47 fffc                 move.l     d7,-4(a6)
x106e_1:
[000010aa] 4297                      clr.l      (a7)
[000010ac] 42a7                      clr.l      -(a7)
[000010ae] 2f2e fffc                 move.l     -4(a6),-(a7)
[000010b2] 42a7                      clr.l      -(a7)
[000010b4] 2f2e fffc                 move.l     -4(a6),-(a7)
[000010b8] 4287                      clr.l      d7
[000010ba] 1e2e fff4                 move.b     -12(a6),d7
[000010be] 2f07                      move.l     d7,-(a7)
[000010c0] 4eb9 0000 1566            jsr        _numattr
[000010c6] 508f                      addq.l     #8,a7
[000010c8] 2f07                      move.l     d7,-(a7)
[000010ca] 4eb9 0000 7aec            jsr        _buyterm
[000010d0] 4fef 0010                 lea.l      16(a7),a7
[000010d4] 2a47                      movea.l    d7,a5
[000010d6] 6086                      bra.s      x106e_2
[000010d8] 4878 0004                 pea.l      ($00000004).w
[000010dc] 4eb9 0000 571a            jsr        _crx
[000010e2] 588f                      addq.l     #4,a7
[000010e4] 33c7 0002 0346            move.w     d7,$00020346
[000010ea] 4878 0034                 pea.l      ($00000034).w
[000010ee] 2f3c 0002 0344            move.l     #$00020344,-(a7)
[000010f4] 2f3c 0002 0d7a            move.l     #_atichar,-(a7)
[000010fa] 4878 0041                 pea.l      ($00000041).w
[000010fe] 4eb9 0000 79aa            jsr        _buyattr
[00001104] 508f                      addq.l     #8,a7
[00001106] 2f07                      move.l     d7,-(a7)
[00001108] 4eb9 0000 7a78            jsr        _buysym
[0000110e] 4fef 000c                 lea.l      12(a7),a7
[00001112] 2847                      movea.l    d7,a4
[00001114] 4878 0041                 pea.l      ($00000041).w
[00001118] 4878 0034                 pea.l      ($00000034).w
[0000111c] 4eb9 0000 3252            jsr        _defspace
[00001122] 508f                      addq.l     #8,a7
[00001124] 3947 000c                 move.w     d7,12(a4)
[00001128] 2ebc 0002 0d1e            move.l     #_littab,(a7)
[0000112e] 2f0c                      move.l     a4,-(a7)
[00001130] 4eb9 0000 774e            jsr        _addsym
[00001136] 588f                      addq.l     #4,a7
[00001138] 45f8 000a                 lea.l      ($0000000A).w,a2
[0000113c] d5ec 0004                 adda.l     4(a4),a2
[00001140] 266e fff6                 movea.l    -10(a6),a3
[00001144] 4287                      clr.l      d7
[00001146] 3e13                      move.w     (a3),d7
[00001148] 2487                      move.l     d7,(a2)
[0000114a] 296e fff6 0008            move.l     -10(a6),8(a4)
[00001150] 197c 0001 000f            move.b     #$01,15(a4)
[00001156] 4878 0001                 pea.l      ($00000001).w
[0000115a] 42a7                      clr.l      -(a7)
[0000115c] 42a7                      clr.l      -(a7)
[0000115e] 42a7                      clr.l      -(a7)
[00001160] 2f2c 0004                 move.l     4(a4),-(a7)
[00001164] 4eb9 0000 7aec            jsr        _buyterm
[0000116a] 4fef 0014                 lea.l      20(a7),a7
[0000116e] 2a47                      movea.l    d7,a5
[00001170] 3b79 0002 0346 0010       move.w     $00020346,16(a5)
[00001178] 3b6c 000c 0012            move.w     12(a4),18(a5)
[0000117e] 6000 fede                 bra        x106e_2
[00001182] 4297                      clr.l      (a7)
[00001184] 42a7                      clr.l      -(a7)
[00001186] 42a7                      clr.l      -(a7)
[00001188] 246e fff6                 movea.l    -10(a6),a2
[0000118c] 4287                      clr.l      d7
[0000118e] 1e12                      move.b     (a2),d7
[00001190] 2f07                      move.l     d7,-(a7)
[00001192] 5297                      addq.l     #1,(a7)
[00001194] 2f2e fff6                 move.l     -10(a6),-(a7)
[00001198] 4eb9 0000 a4b4            jsr        _buybuf
[0000119e] 508f                      addq.l     #8,a7
[000011a0] 2f07                      move.l     d7,-(a7)
[000011a2] 4287                      clr.l      d7
[000011a4] 1e2e fff4                 move.b     -12(a6),d7
[000011a8] 0c47 0010                 cmpi.w     #$0010,d7
[000011ac] 6608                      bne.s      x106e_3
[000011ae] 2e3c 0002 0e2e            move.l     #_atldoubl,d7
[000011b4] 601a                      bra.s      x106e_4
x106e_3:
[000011b6] 4287                      clr.l      d7
[000011b8] 1e2e fff4                 move.b     -12(a6),d7
[000011bc] 0c47 0011                 cmpi.w     #$0011,d7
[000011c0] 6608                      bne.s      x106e_5
[000011c2] 2e3c 0002 0e1c            move.l     #_atdouble,d7
[000011c8] 6006                      bra.s      x106e_4
x106e_5:
[000011ca] 2e3c 0002 0e0a            move.l     #_atfloat,d7
x106e_4:
[000011d0] 2f07                      move.l     d7,-(a7)
[000011d2] 4eb9 0000 7aec            jsr        _buyterm
[000011d8] 4fef 0010                 lea.l      16(a7),a7
[000011dc] 2a47                      movea.l    d7,a5
[000011de] 6000 fe7e                 bra        x106e_2
[000011e2] 4297                      clr.l      (a7)
[000011e4] 42a7                      clr.l      -(a7)
[000011e6] 4878 0001                 pea.l      ($00000001).w
[000011ea] 4eba fe42                 jsr        _mterm(pc)
[000011ee] 588f                      addq.l     #4,a7
[000011f0] 2f07                      move.l     d7,-(a7)
[000011f2] 4287                      clr.l      d7
[000011f4] 1e2e fff4                 move.b     -12(a6),d7
[000011f8] 2f07                      move.l     d7,-(a7)
[000011fa] 2f3c 0002 0348            move.l     #$00020348,-(a7)
[00001200] 4eb9 0000 a7a6            jsr        _scnstr
[00001206] 508f                      addq.l     #8,a7
[00001208] 2447                      movea.l    d7,a2
[0000120a] d5fc 0002 0350            adda.l     #$00020350,a2
[00001210] 4287                      clr.l      d7
[00001212] 1e12                      move.b     (a2),d7
[00001214] 2f07                      move.l     d7,-(a7)
[00001216] 4eb9 0000 7a0e            jsr        _buyop
[0000121c] 4fef 000c                 lea.l      12(a7),a7
[00001220] 6050                      bra.s      x106e_6
[00001222] 4297                      clr.l      (a7)
[00001224] 42a7                      clr.l      -(a7)
[00001226] 42a7                      clr.l      -(a7)
[00001228] 4878 0001                 pea.l      ($00000001).w
[0000122c] 42a7                      clr.l      -(a7)
[0000122e] 2f3c 0002 0dc2            move.l     #_atint,-(a7)
[00001234] 4eb9 0000 7aec            jsr        _buyterm
[0000123a] 4fef 0014                 lea.l      20(a7),a7
[0000123e] 2f07                      move.l     d7,-(a7)
[00001240] 4878 0001                 pea.l      ($00000001).w
[00001244] 4eba fde8                 jsr        _mterm(pc)
[00001248] 588f                      addq.l     #4,a7
[0000124a] 2f07                      move.l     d7,-(a7)
[0000124c] 4287                      clr.l      d7
[0000124e] 1e2e fff4                 move.b     -12(a6),d7
[00001252] 0c47 0053                 cmpi.w     #$0053,d7
[00001256] 6608                      bne.s      x106e_7
[00001258] 2e3c 0000 008e            move.l     #$0000008E,d7
[0000125e] 6006                      bra.s      x106e_8
x106e_7:
[00001260] 2e3c 0000 008b            move.l     #$0000008B,d7
x106e_8:
[00001266] 2f07                      move.l     d7,-(a7)
[00001268] 4eb9 0000 7a0e            jsr        _buyop
[0000126e] 4fef 000c                 lea.l      12(a7),a7
x106e_6:
[00001272] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00001276] 4e5e                      unlk       a6
[00001278] 4e75                      rts
[0000127a] 4eba fab0                 jsr        _mcast(pc)
[0000127e] 2a47                      movea.l    d7,a5
[00001280] 2e0d                      move.l     a5,d7
[00001282] 6712                      beq.s      x106e_9
[00001284] 4878 0001                 pea.l      ($00000001).w
[00001288] 4eba fda4                 jsr        _mterm(pc)
[0000128c] 588f                      addq.l     #4,a7
[0000128e] 2b47 0008                 move.l     d7,8(a5)
[00001292] 6000 fdca                 bra        x106e_2
x106e_9:
[00001296] 4878 0001                 pea.l      ($00000001).w
[0000129a] 4eba fb0c                 jsr        _melist(pc)
[0000129e] 588f                      addq.l     #4,a7
[000012a0] 2a47                      movea.l    d7,a5
[000012a2] 4878 000a                 pea.l      ($0000000A).w
[000012a6] 4eb9 0000 3c08            jsr        _need
[000012ac] 588f                      addq.l     #4,a7
[000012ae] 6000 fdae                 bra        x106e_2
[000012b2] 486e fff4                 pea.l      -12(a6)
[000012b6] 4eb9 0000 34e6            jsr        _gettok1
[000012bc] 588f                      addq.l     #4,a7
[000012be] 2447                      movea.l    d7,a2
[000012c0] 4287                      clr.l      d7
[000012c2] 1e12                      move.b     (a2),d7
[000012c4] 0c47 0006                 cmpi.w     #$0006,d7
[000012c8] 663a                      bne.s      x106e_10
[000012ca] 4eba fa60                 jsr        _mcast(pc)
[000012ce] 2a47                      movea.l    d7,a5
[000012d0] 2e0d                      move.l     a5,d7
[000012d2] 6730                      beq.s      x106e_10
[000012d4] 4297                      clr.l      (a7)
[000012d6] 4878 0001                 pea.l      ($00000001).w
[000012da] 2f2d 0004                 move.l     4(a5),-(a7)
[000012de] 4eb9 0000 7b74            jsr        _bytes
[000012e4] 508f                      addq.l     #8,a7
[000012e6] 2f07                      move.l     d7,-(a7)
[000012e8] 42a7                      clr.l      -(a7)
[000012ea] 42a7                      clr.l      -(a7)
[000012ec] 2f0d                      move.l     a5,-(a7)
[000012ee] 4eb9 0000 85aa            jsr        _setad
[000012f4] 4fef 0010                 lea.l      16(a7),a7
[000012f8] 2b7c 0002 0dc2 0004       move.l     #_atint,4(a5)
[00001300] 6000 fd5c                 bra        x106e_2
x106e_10:
[00001304] 486e fff4                 pea.l      -12(a6)
[00001308] 4eb9 0000 31e4            jsr        _baktok1
[0000130e] 588f                      addq.l     #4,a7
[00001310] 4297                      clr.l      (a7)
[00001312] 42a7                      clr.l      -(a7)
[00001314] 4878 0001                 pea.l      ($00000001).w
[00001318] 4eba fd14                 jsr        _mterm(pc)
[0000131c] 588f                      addq.l     #4,a7
[0000131e] 2f07                      move.l     d7,-(a7)
[00001320] 4878 0061                 pea.l      ($00000061).w
[00001324] 4eb9 0000 7a0e            jsr        _buyop
[0000132a] 4fef 000c                 lea.l      12(a7),a7
[0000132e] 2a47                      movea.l    d7,a5
[00001330] 6000 fd2c                 bra        x106e_2
[00001334] 486e fff4                 pea.l      -12(a6)
[00001338] 4eb9 0000 31e4            jsr        _baktok1
[0000133e] 588f                      addq.l     #4,a7
[00001340] 4aae 0008                 tst.l      8(a6)
[00001344] 672a                      beq.s      x106e_11
[00001346] 2ebc 0002 0410            move.l     #$00020410,(a7) "missing expression"
[0000134c] 4eb9 0000 3e84            jsr        _p1error
[00001352] 4297                      clr.l      (a7)
[00001354] 42a7                      clr.l      -(a7)
[00001356] 42a7                      clr.l      -(a7)
[00001358] 42a7                      clr.l      -(a7)
[0000135a] 2f3c 0002 0dc2            move.l     #_atint,-(a7)
[00001360] 4eb9 0000 7aec            jsr        _buyterm
[00001366] 4fef 0010                 lea.l      16(a7),a7
[0000136a] 2a47                      movea.l    d7,a5
[0000136c] 6000 fcf0                 bra        x106e_2
x106e_11:
[00001370] 4287                      clr.l      d7
[00001372] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00001376] 4e5e                      unlk       a6
[00001378] 4e75                      rts

_mtrail:
[0000137a] 4e56 fffa                 link       a6,#-6
[0000137e] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00001382] 2a6e 0008                 movea.l    8(a6),a5
_mtrail_4:
[00001386] 486e fffa                 pea.l      -6(a6)
[0000138a] 4eb9 0000 34e6            jsr        _gettok1
[00001390] 588f                      addq.l     #4,a7
[00001392] 2447                      movea.l    d7,a2
[00001394] 4287                      clr.l      d7
[00001396] 1e12                      move.b     (a2),d7
[00001398] 41f9 0002 0424            lea.l      $00020424,a0
[0000139e] 4ef9 0000 a7dc            jmp        a.switch
[000013a4] 4297                      clr.l      (a7)
[000013a6] 42a7                      clr.l      -(a7)
[000013a8] 4eba fa58                 jsr        _mexpr(pc)
[000013ac] 588f                      addq.l     #4,a7
[000013ae] 2f07                      move.l     d7,-(a7)
[000013b0] 2f0d                      move.l     a5,-(a7)
[000013b2] 4878 00a9                 pea.l      ($000000A9).w
[000013b6] 4eb9 0000 7a0e            jsr        _buyop
[000013bc] 4fef 000c                 lea.l      12(a7),a7
[000013c0] 2a47                      movea.l    d7,a5
[000013c2] 4aad 000c                 tst.l      12(a5)
[000013c6] 6740                      beq.s      _mtrail_1
[000013c8] 284d                      movea.l    a5,a4
_mtrail_3:
[000013ca] 4878 0002                 pea.l      ($00000002).w
[000013ce] 4eb9 0000 332e            jsr        _eat
[000013d4] 588f                      addq.l     #4,a7
[000013d6] 4a87                      tst.l      d7
[000013d8] 6734                      beq.s      _mtrail_2
[000013da] 2ebc 0002 0e40            move.l     #_atvoid,(a7)
[000013e0] 4878 0001                 pea.l      ($00000001).w
[000013e4] 4eba fa1c                 jsr        _mexpr(pc)
[000013e8] 588f                      addq.l     #4,a7
[000013ea] 2f07                      move.l     d7,-(a7)
[000013ec] 2f2c 000c                 move.l     12(a4),-(a7)
[000013f0] 4878 00a5                 pea.l      ($000000A5).w
[000013f4] 4eb9 0000 7a0e            jsr        _buyop
[000013fa] 4fef 000c                 lea.l      12(a7),a7
[000013fe] 2947 000c                 move.l     d7,12(a4)
[00001402] 286c 000c                 movea.l    12(a4),a4
[00001406] 60c2                      bra.s      _mtrail_3
_mtrail_1:
[00001408] 1b7c 0069 0016            move.b     #$69,22(a5)
_mtrail_2:
[0000140e] 4878 000a                 pea.l      ($0000000A).w
[00001412] 4eb9 0000 3c08            jsr        _need
[00001418] 588f                      addq.l     #4,a7
[0000141a] 6000 ff6a                 bra        _mtrail_4
[0000141e] 6000 ff66                 bra        _mtrail_4
[00001422] 4297                      clr.l      (a7)
[00001424] 42a7                      clr.l      -(a7)
[00001426] 42a7                      clr.l      -(a7)
[00001428] 4878 0001                 pea.l      ($00000001).w
[0000142c] 4eba f97a                 jsr        _melist(pc)
[00001430] 588f                      addq.l     #4,a7
[00001432] 2f07                      move.l     d7,-(a7)
[00001434] 2f0d                      move.l     a5,-(a7)
[00001436] 4878 00de                 pea.l      ($000000DE).w
[0000143a] 4eb9 0000 7a0e            jsr        _buyop
[00001440] 4fef 0010                 lea.l      16(a7),a7
[00001444] 2f07                      move.l     d7,-(a7)
[00001446] 4878 006b                 pea.l      ($0000006B).w
[0000144a] 4eb9 0000 7a0e            jsr        _buyop
[00001450] 4fef 000c                 lea.l      12(a7),a7
[00001454] 2a47                      movea.l    d7,a5
[00001456] 4878 0008                 pea.l      ($00000008).w
[0000145a] 4eb9 0000 3c08            jsr        _need
[00001460] 588f                      addq.l     #4,a7
[00001462] 6000 ff22                 bra        _mtrail_4
[00001466] 4297                      clr.l      (a7)
[00001468] 42a7                      clr.l      -(a7)
[0000146a] 4287                      clr.l      d7
[0000146c] 1e2e fffa                 move.b     -6(a6),d7
[00001470] 0c47 0007                 cmpi.w     #$0007,d7
[00001474] 6604                      bne.s      _mtrail_5
[00001476] 2e0d                      move.l     a5,d7
[00001478] 6014                      bra.s      _mtrail_6
_mtrail_5:
[0000147a] 42a7                      clr.l      -(a7)
[0000147c] 42a7                      clr.l      -(a7)
[0000147e] 2f0d                      move.l     a5,-(a7)
[00001480] 4878 0064                 pea.l      ($00000064).w
[00001484] 4eb9 0000 7a0e            jsr        _buyop
[0000148a] 4fef 0010                 lea.l      16(a7),a7
_mtrail_6:
[0000148e] 2f07                      move.l     d7,-(a7)
[00001490] 4878 0007                 pea.l      ($00000007).w
[00001494] 4eb9 0000 7a0e            jsr        _buyop
[0000149a] 4fef 000c                 lea.l      12(a7),a7
[0000149e] 2a47                      movea.l    d7,a5
[000014a0] 486e fffa                 pea.l      -6(a6)
[000014a4] 4eb9 0000 3bae            jsr        _ident
[000014aa] 588f                      addq.l     #4,a7
[000014ac] 4a87                      tst.l      d7
[000014ae] 6616                      bne.s      _mtrail_7
[000014b0] 2ebc 0002 045c            move.l     #$0002045C,(a7) "missing member name"
[000014b6] 4eb9 0000 3e84            jsr        _p1error
[000014bc] 2d7c 0002 077c fffc       move.l     #_noname,-4(a6)
[000014c4] 601c                      bra.s      _mtrail_8
_mtrail_7:
[000014c6] 246e fffc                 movea.l    -4(a6),a2
[000014ca] 4287                      clr.l      d7
[000014cc] 1e12                      move.b     (a2),d7
[000014ce] 2e87                      move.l     d7,(a7)
[000014d0] 5297                      addq.l     #1,(a7)
[000014d2] 2f2e fffc                 move.l     -4(a6),-(a7)
[000014d6] 4eb9 0000 a4b4            jsr        _buybuf
[000014dc] 588f                      addq.l     #4,a7
[000014de] 2d47 fffc                 move.l     d7,-4(a6)
_mtrail_8:
[000014e2] 4297                      clr.l      (a7)
[000014e4] 42a7                      clr.l      -(a7)
[000014e6] 42a7                      clr.l      -(a7)
[000014e8] 2f2e fffc                 move.l     -4(a6),-(a7)
[000014ec] 2f3c 0002 0dc2            move.l     #_atint,-(a7)
[000014f2] 4eb9 0000 7aec            jsr        _buyterm
[000014f8] 4fef 0010                 lea.l      16(a7),a7
[000014fc] 2b47 000c                 move.l     d7,12(a5)
[00001500] 6000 fe84                 bra        _mtrail_4
[00001504] 4297                      clr.l      (a7)
[00001506] 42a7                      clr.l      -(a7)
[00001508] 42a7                      clr.l      -(a7)
[0000150a] 4878 0001                 pea.l      ($00000001).w
[0000150e] 42a7                      clr.l      -(a7)
[00001510] 2f3c 0002 0dc2            move.l     #_atint,-(a7)
[00001516] 4eb9 0000 7aec            jsr        _buyterm
[0000151c] 4fef 0014                 lea.l      20(a7),a7
[00001520] 2f07                      move.l     d7,-(a7)
[00001522] 2f0d                      move.l     a5,-(a7)
[00001524] 4287                      clr.l      d7
[00001526] 1e2e fffa                 move.b     -6(a6),d7
[0000152a] 0c47 0053                 cmpi.w     #$0053,d7
[0000152e] 6608                      bne.s      _mtrail_9
[00001530] 2e3c 0000 00aa            move.l     #$000000AA,d7
[00001536] 6006                      bra.s      _mtrail_10
_mtrail_9:
[00001538] 2e3c 0000 00a7            move.l     #$000000A7,d7
_mtrail_10:
[0000153e] 2f07                      move.l     d7,-(a7)
[00001540] 4eb9 0000 7a0e            jsr        _buyop
[00001546] 4fef 000c                 lea.l      12(a7),a7
[0000154a] 2a47                      movea.l    d7,a5
[0000154c] 6000 fe38                 bra        _mtrail_4
[00001550] 486e fffa                 pea.l      -6(a6)
[00001554] 4eb9 0000 31e4            jsr        _baktok1
[0000155a] 588f                      addq.l     #4,a7
[0000155c] 2e0d                      move.l     a5,d7
[0000155e] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00001562] 4e5e                      unlk       a6
[00001564] 4e75                      rts

_numattr:
[00001566] 4e56 0000                 link       a6,#0
[0000156a] 48e7 8400                 movem.l    d0/d5,-(a7)
[0000156e] 0cae 0000 0019 0008       cmpi.l     #$00000019,8(a6)
[00001576] 6608                      bne.s      _numattr_1
[00001578] 2e3c 0002 0df8            move.l     #_atulong,d7
[0000157e] 6010                      bra.s      _numattr_2
_numattr_1:
[00001580] 0cae 0000 0015 0008       cmpi.l     #$00000015,8(a6)
[00001588] 660e                      bne.s      _numattr_3
[0000158a] 2e3c 0002 0de6            move.l     #_atlong,d7
_numattr_2:
[00001590] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00001594] 4e5e                      unlk       a6
[00001596] 4e75                      rts
_numattr_3:
[00001598] 4aae 000c                 tst.l      12(a6)
[0000159c] 6c04                      bge.s      _numattr_4
[0000159e] 7a05                      moveq.l    #5,d5
[000015a0] 603a                      bra.s      _numattr_5
_numattr_4:
[000015a2] 0cae 0001 0000 000c       cmpi.l     #$00010000,12(a6)
[000015aa] 6d04                      blt.s      _numattr_6
[000015ac] 7a04                      moveq.l    #4,d5
[000015ae] 602c                      bra.s      _numattr_5
_numattr_6:
[000015b0] 0cae 0000 8000 000c       cmpi.l     #$00008000,12(a6)
[000015b8] 6d04                      blt.s      _numattr_7
[000015ba] 7a03                      moveq.l    #3,d5
[000015bc] 601e                      bra.s      _numattr_5
_numattr_7:
[000015be] 0cae 0000 0100 000c       cmpi.l     #$00000100,12(a6)
[000015c6] 6d04                      blt.s      _numattr_8
[000015c8] 7a02                      moveq.l    #2,d5
[000015ca] 6010                      bra.s      _numattr_5
_numattr_8:
[000015cc] 0cae 0000 0080 000c       cmpi.l     #$00000080,12(a6)
[000015d4] 6d04                      blt.s      _numattr_9
[000015d6] 7a01                      moveq.l    #1,d5
[000015d8] 6002                      bra.s      _numattr_5
_numattr_9:
[000015da] 4285                      clr.l      d5
_numattr_5:
[000015dc] 4ab9 0002 0b7e            tst.l      _lflag
[000015e2] 6710                      beq.s      _numattr_10
[000015e4] 2e05                      move.l     d5,d7
[000015e6] e587                      asl.l      #2,d7
[000015e8] 2447                      movea.l    d7,a2
[000015ea] d5fc 0002 0470            adda.l     #$00020470,a2
[000015f0] 2e12                      move.l     (a2),d7
[000015f2] 600e                      bra.s      _numattr_11
_numattr_10:
[000015f4] 2e05                      move.l     d5,d7
[000015f6] e587                      asl.l      #2,d7
[000015f8] 2447                      movea.l    d7,a2
[000015fa] d5fc 0002 0488            adda.l     #$00020488,a2
[00001600] 2e12                      move.l     (a2),d7
_numattr_11:
[00001602] 608c                      bra.s      _numattr_2

_addcase:
[00001604] 4e56 0000                 link       a6,#0
[00001608] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[0000160c] 2a6e 0008                 movea.l    8(a6),a5
[00001610] 4297                      clr.l      (a7)
[00001612] 4878 000a                 pea.l      ($0000000A).w
[00001616] 4eb9 0000 a906            jsr        _alloc
[0000161c] 588f                      addq.l     #4,a7
[0000161e] 2847                      movea.l    d7,a4
[00001620] 296e 000c 0006            move.l     12(a6),6(a4)
[00001626] 396e 0012 0004            move.w     18(a6),4(a4)
_addcase_4:
[0000162c] 4a95                      tst.l      (a5)
[0000162e] 670e                      beq.s      _addcase_1
[00001630] 2e2e 000c                 move.l     12(a6),d7
[00001634] 2455                      movea.l    (a5),a2
[00001636] 5c8a                      addq.l     #6,a2
[00001638] be92                      cmp.l      (a2),d7
[0000163a] 640e                      bcc.s      _addcase_2
[0000163c] 2895                      move.l     (a5),(a4)
_addcase_1:
[0000163e] 2a8c                      move.l     a4,(a5)
[00001640] 2e2e 0010                 move.l     16(a6),d7
[00001644] 6030                      bra.s      _addcase_3
_addcase_5:
[00001646] 2a55                      movea.l    (a5),a5
[00001648] 60e2                      bra.s      _addcase_4
_addcase_2:
[0000164a] 2455                      movea.l    (a5),a2
[0000164c] 5c8a                      addq.l     #6,a2
[0000164e] 2e12                      move.l     (a2),d7
[00001650] beae 000c                 cmp.l      12(a6),d7
[00001654] 66f0                      bne.s      _addcase_5
[00001656] 2ebc 0002 04e2            move.l     #$000204E2,(a7) "duplicate case value"
[0000165c] 4eb9 0000 3e84            jsr        _p1error
[00001662] 4297                      clr.l      (a7)
[00001664] 2f0c                      move.l     a4,-(a7)
[00001666] 4eb9 0000 aa76            jsr        _free
[0000166c] 588f                      addq.l     #4,a7
[0000166e] 2455                      movea.l    (a5),a2
[00001670] 588a                      addq.l     #4,a2
[00001672] 3e12                      move.w     (a2),d7
[00001674] 48c7                      ext.l      d7
_addcase_3:
[00001676] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[0000167a] 4e5e                      unlk       a6
[0000167c] 4e75                      rts

_autinit:
[0000167e] 4e56 ffe2                 link       a6,#-30
[00001682] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00001686] 2a6e 0008                 movea.l    8(a6),a5
[0000168a] 2ebc 0000 0088            move.l     #$00000088,(a7)
[00001690] 4eb9 0000 332e            jsr        _eat
[00001696] 4878 0005                 pea.l      ($00000005).w
[0000169a] 4eb9 0000 332e            jsr        _eat
[000016a0] 588f                      addq.l     #4,a7
[000016a2] 2d47 fffc                 move.l     d7,-4(a6)
[000016a6] 3d6d 000c ffe2            move.w     12(a5),-30(a6)
[000016ac] 08ad 0005 000c            bclr       #5,12(a5)
[000016b2] 4297                      clr.l      (a7)
[000016b4] 4eb9 0000 0be6            jsr        _gexpr
[000016ba] 2847                      movea.l    d7,a4
[000016bc] 2e0c                      move.l     a4,d7
[000016be] 6756                      beq.s      _autinit_1
[000016c0] 4287                      clr.l      d7
[000016c2] 3e39 0002 04a0            move.w     _regset,d7
[000016c8] 2e87                      move.l     d7,(a7)
[000016ca] 4eb9 0000 60fe            jsr        _pregs
[000016d0] 2eb9 0002 04a2            move.l     _autoff,(a7)
[000016d6] 4eb9 0000 59b0            jsr        _pauto
[000016dc] 2d6d 0004 ffe8            move.l     4(a5),-24(a6)
[000016e2] 4287                      clr.l      d7
[000016e4] 1e2d 000e                 move.b     14(a5),d7
[000016e8] 0c47 0021                 cmpi.w     #$0021,d7
[000016ec] 6646                      bne.s      _autinit_2
[000016ee] 4878 0020                 pea.l      ($00000020).w
[000016f2] 2f2d 0008                 move.l     8(a5),-(a7)
[000016f6] 42a7                      clr.l      -(a7)
[000016f8] 42a7                      clr.l      -(a7)
[000016fa] 486e ffe4                 pea.l      -28(a6)
[000016fe] 4eb9 0000 85aa            jsr        _setad
[00001704] 4fef 0014                 lea.l      20(a7),a7
[00001708] 1d7c 0001 fff9            move.b     #$01,-7(a6)
[0000170e] 3d6d 000c fff6            move.w     12(a5),-10(a6)
[00001714] 603c                      bra.s      _autinit_3
_autinit_1:
[00001716] 4287                      clr.l      d7
[00001718] 3e2e ffe2                 move.w     -30(a6),d7
[0000171c] 8f6d 000c                 or.w       d7,12(a5)
[00001720] 4aae fffc                 tst.l      -4(a6)
[00001724] 673c                      beq.s      _autinit_4
[00001726] 4878 0009                 pea.l      ($00000009).w
[0000172a] 4eb9 0000 3c08            jsr        _need
[00001730] 588f                      addq.l     #4,a7
[00001732] 602e                      bra.s      _autinit_4
_autinit_2:
[00001734] 1e2d 0008                 move.b     8(a5),d7
[00001738] 4887                      ext.w      d7
[0000173a] 48c7                      ext.l      d7
[0000173c] 2e87                      move.l     d7,(a7)
[0000173e] 42a7                      clr.l      -(a7)
[00001740] 42a7                      clr.l      -(a7)
[00001742] 42a7                      clr.l      -(a7)
[00001744] 486e ffe4                 pea.l      -28(a6)
[00001748] 4eb9 0000 85aa            jsr        _setad
[0000174e] 4fef 0010                 lea.l      16(a7),a7
_autinit_3:
[00001752] 2e8c                      move.l     a4,(a7)
[00001754] 486e ffe4                 pea.l      -28(a6)
[00001758] 4eb9 0000 607c            jsr        _pmove
[0000175e] 588f                      addq.l     #4,a7
[00001760] 60b4                      bra.s      _autinit_1
_autinit_4:
[00001762] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00001766] 4e5e                      unlk       a6
[00001768] 4e75                      rts

_dbfile:
[0000176a] 4e56 fffa                 link       a6,#-6
[0000176e] 4297                      clr.l      (a7)
[00001770] 42a7                      clr.l      -(a7)
[00001772] 2f39 0002 04f8            move.l     $000204F8,-(a7)
[00001778] 4878 0002                 pea.l      ($00000002).w
[0000177c] 4eb9 0000 571a            jsr        _crx
[00001782] 588f                      addq.l     #4,a7
[00001784] 3d47 fffe                 move.w     d7,-2(a6)
[00001788] 3e2e fffe                 move.w     -2(a6),d7
[0000178c] 48c7                      ext.l      d7
[0000178e] 2f07                      move.l     d7,-(a7)
[00001790] 4eb9 0000 5a30            jsr        _pdata
[00001796] 4fef 000c                 lea.l      12(a7),a7
[0000179a] 2eae 0008                 move.l     8(a6),(a7)
[0000179e] 4eb9 0000 aef4            jsr        _lenstr
[000017a4] 2e87                      move.l     d7,(a7)
[000017a6] 2f2e 0008                 move.l     8(a6),-(a7)
[000017aa] 5297                      addq.l     #1,(a7)
[000017ac] 4eb9 0000 61ca            jsr        _pstr
[000017b2] 588f                      addq.l     #4,a7
[000017b4] 4297                      clr.l      (a7)
[000017b6] 2f3c 0002 0dd4            move.l     #_atunsign,-(a7)
[000017bc] 4eb9 0000 78b4            jsr        _bound
[000017c2] 588f                      addq.l     #4,a7
[000017c4] 2f07                      move.l     d7,-(a7)
[000017c6] 2f39 0002 04f8            move.l     $000204F8,-(a7)
[000017cc] 4878 0002                 pea.l      ($00000002).w
[000017d0] 4eb9 0000 571a            jsr        _crx
[000017d6] 588f                      addq.l     #4,a7
[000017d8] 33c7 0002 04a8            move.w     d7,_dbfilab
[000017de] 3e39 0002 04a8            move.w     _dbfilab,d7
[000017e4] 48c7                      ext.l      d7
[000017e6] 2f07                      move.l     d7,-(a7)
[000017e8] 4eb9 0000 5a30            jsr        _pdata
[000017ee] 4fef 000c                 lea.l      12(a7),a7
[000017f2] 4297                      clr.l      (a7)
[000017f4] 42a7                      clr.l      -(a7)
[000017f6] 4eb9 0000 58e0            jsr        _pad
[000017fc] 588f                      addq.l     #4,a7
[000017fe] 4297                      clr.l      (a7)
[00001800] 3e2e fffe                 move.w     -2(a6),d7
[00001804] 48c7                      ext.l      d7
[00001806] 2f07                      move.l     d7,-(a7)
[00001808] 4eb9 0000 58e0            jsr        _pad
[0000180e] 588f                      addq.l     #4,a7
[00001810] 4297                      clr.l      (a7)
[00001812] 42a7                      clr.l      -(a7)
[00001814] 4eb9 0000 58e0            jsr        _pad
[0000181a] 588f                      addq.l     #4,a7
[0000181c] 4297                      clr.l      (a7)
[0000181e] 4878 0002                 pea.l      ($00000002).w
[00001822] 4eb9 0000 571a            jsr        _crx
[00001828] 588f                      addq.l     #4,a7
[0000182a] 33c7 0002 04aa            move.w     d7,_dbfulab
[00001830] 3e39 0002 04aa            move.w     _dbfulab,d7
[00001836] 48c7                      ext.l      d7
[00001838] 2f07                      move.l     d7,-(a7)
[0000183a] 4eb9 0000 58e0            jsr        _pad
[00001840] 588f                      addq.l     #4,a7
[00001842] 4e5e                      unlk       a6
[00001844] 4e75                      rts

_dbfunc:
[00001846] 4e56 fff2                 link       a6,#-14
[0000184a] 4aae 0008                 tst.l      8(a6)
[0000184e] 6610                      bne.s      _dbfunc_1
[00001850] 7001                      moveq.l    #1,d0
[00001852] 2d40 fffa                 move.l     d0,-6(a6)
[00001856] 42ae fff6                 clr.l      -10(a6)
[0000185a] 426e fffe                 clr.w      -2(a6)
[0000185e] 606e                      bra.s      _dbfunc_2
_dbfunc_1:
[00001860] 4297                      clr.l      (a7)
[00001862] 42a7                      clr.l      -(a7)
[00001864] 2f39 0002 04fe            move.l     $000204FE,-(a7)
[0000186a] 4878 0002                 pea.l      ($00000002).w
[0000186e] 4eb9 0000 571a            jsr        _crx
[00001874] 588f                      addq.l     #4,a7
[00001876] 3d47 fffe                 move.w     d7,-2(a6)
[0000187a] 3e2e fffe                 move.w     -2(a6),d7
[0000187e] 48c7                      ext.l      d7
[00001880] 2f07                      move.l     d7,-(a7)
[00001882] 4eb9 0000 5a30            jsr        _pdata
[00001888] 4fef 000c                 lea.l      12(a7),a7
[0000188c] 246e 0008                 movea.l    8(a6),a2
[00001890] 4287                      clr.l      d7
[00001892] 1e12                      move.b     (a2),d7
[00001894] 2e87                      move.l     d7,(a7)
[00001896] 2f2e 0008                 move.l     8(a6),-(a7)
[0000189a] 5297                      addq.l     #1,(a7)
[0000189c] 4eb9 0000 61ca            jsr        _pstr
[000018a2] 588f                      addq.l     #4,a7
[000018a4] 4878 0001                 pea.l      ($00000001).w
[000018a8] 2f39 0002 04fe            move.l     $000204FE,-(a7)
[000018ae] 4eb9 0000 61ca            jsr        _pstr
[000018b4] 508f                      addq.l     #8,a7
[000018b6] 3e39 0002 04a6            move.w     _dbline,d7
[000018bc] 48c7                      ext.l      d7
[000018be] 2d47 fffa                 move.l     d7,-6(a6)
[000018c2] 3e39 0002 0cd4            move.w     _lineno,d7
[000018c8] 48c7                      ext.l      d7
[000018ca] 2d47 fff6                 move.l     d7,-10(a6)
_dbfunc_2:
[000018ce] 4297                      clr.l      (a7)
[000018d0] 2f3c 0002 0dd4            move.l     #_atunsign,-(a7)
[000018d6] 4eb9 0000 78b4            jsr        _bound
[000018dc] 588f                      addq.l     #4,a7
[000018de] 2f07                      move.l     d7,-(a7)
[000018e0] 2f39 0002 04fe            move.l     $000204FE,-(a7)
[000018e6] 3e39 0002 04aa            move.w     _dbfulab,d7
[000018ec] 48c7                      ext.l      d7
[000018ee] 2f07                      move.l     d7,-(a7)
[000018f0] 4eb9 0000 5a30            jsr        _pdata
[000018f6] 4fef 000c                 lea.l      12(a7),a7
[000018fa] 4aae 0008                 tst.l      8(a6)
[000018fe] 670e                      beq.s      _dbfunc_3
[00001900] 4878 0002                 pea.l      ($00000002).w
[00001904] 4eb9 0000 571a            jsr        _crx
[0000190a] 588f                      addq.l     #4,a7
[0000190c] 6002                      bra.s      _dbfunc_4
_dbfunc_3:
[0000190e] 4287                      clr.l      d7
_dbfunc_4:
[00001910] 33c7 0002 04aa            move.w     d7,_dbfulab
[00001916] 4297                      clr.l      (a7)
[00001918] 3e39 0002 04aa            move.w     _dbfulab,d7
[0000191e] 48c7                      ext.l      d7
[00001920] 2f07                      move.l     d7,-(a7)
[00001922] 4eb9 0000 58e0            jsr        _pad
[00001928] 588f                      addq.l     #4,a7
[0000192a] 4297                      clr.l      (a7)
[0000192c] 3e39 0002 04a8            move.w     _dbfilab,d7
[00001932] 48c7                      ext.l      d7
[00001934] 2f07                      move.l     d7,-(a7)
[00001936] 4eb9 0000 58e0            jsr        _pad
[0000193c] 588f                      addq.l     #4,a7
[0000193e] 4297                      clr.l      (a7)
[00001940] 3e2e fffe                 move.w     -2(a6),d7
[00001944] 48c7                      ext.l      d7
[00001946] 2f07                      move.l     d7,-(a7)
[00001948] 4eb9 0000 58e0            jsr        _pad
[0000194e] 588f                      addq.l     #4,a7
[00001950] 2eae fffa                 move.l     -6(a6),(a7)
[00001954] 42a7                      clr.l      -(a7)
[00001956] 4eb9 0000 58e0            jsr        _pad
[0000195c] 588f                      addq.l     #4,a7
[0000195e] 2eae fff6                 move.l     -10(a6),(a7)
[00001962] 42a7                      clr.l      -(a7)
[00001964] 4eb9 0000 58e0            jsr        _pad
[0000196a] 588f                      addq.l     #4,a7
[0000196c] 4297                      clr.l      (a7)
[0000196e] 42a7                      clr.l      -(a7)
[00001970] 4eb9 0000 58e0            jsr        _pad
[00001976] 588f                      addq.l     #4,a7
[00001978] 4297                      clr.l      (a7)
[0000197a] 3e39 0002 04ac            move.w     _dbfvlab,d7
[00001980] 48c7                      ext.l      d7
[00001982] 2f07                      move.l     d7,-(a7)
[00001984] 4eb9 0000 58e0            jsr        _pad
[0000198a] 588f                      addq.l     #4,a7
[0000198c] 4a79 0002 04ac            tst.w      _dbfvlab
[00001992] 670c                      beq.s      _dbfunc_5
[00001994] 4297                      clr.l      (a7)
[00001996] 42a7                      clr.l      -(a7)
[00001998] 4eb9 0000 19d2            jsr        _dbvar
[0000199e] 588f                      addq.l     #4,a7
_dbfunc_5:
[000019a0] 4e5e                      unlk       a6
[000019a2] 4e75                      rts

_dbstat:
[000019a4] 4e56 fffc                 link       a6,#-4
[000019a8] 4ab9 0002 0b6e            tst.l      _dbflag
[000019ae] 671e                      beq.s      _dbstat_1
[000019b0] 2ebc 0000 00bc            move.l     #$000000BC,(a7)
[000019b6] 4eb9 0000 5a16            jsr        _pcode
[000019bc] 4878 0002                 pea.l      ($00000002).w
[000019c0] 2f3c 0002 0cd4            move.l     #_lineno,-(a7)
[000019c6] 4eb9 0000 695c            jsr        _putbytes
[000019cc] 508f                      addq.l     #8,a7
_dbstat_1:
[000019ce] 4e5e                      unlk       a6
[000019d0] 4e75                      rts

_dbvar:
[000019d2] 4e56 fff4                 link       a6,#-12
[000019d6] 4aae 0008                 tst.l      8(a6)
[000019da] 6764                      beq.s      _dbvar_1
[000019dc] 4a79 0002 04a8            tst.w      _dbfilab
[000019e2] 6700 014e                 beq        _dbvar_2
[000019e6] 246e 0008                 movea.l    8(a6),a2
[000019ea] 588a                      addq.l     #4,a2
[000019ec] 2452                      movea.l    (a2),a2
[000019ee] 508a                      addq.l     #8,a2
[000019f0] 4287                      clr.l      d7
[000019f2] 1e12                      move.b     (a2),d7
[000019f4] 0c47 0042                 cmpi.w     #$0042,d7
[000019f8] 6700 0138                 beq        _dbvar_2
[000019fc] 45f8 000e                 lea.l      ($0000000E).w,a2
[00001a00] d5ee 0008                 adda.l     8(a6),a2
[00001a04] 4287                      clr.l      d7
[00001a06] 1e12                      move.b     (a2),d7
[00001a08] 2e87                      move.l     d7,(a7)
[00001a0a] 2f3c 0002 0504            move.l     #$00020504,-(a7)
[00001a10] 4eb9 0000 a7a6            jsr        _scnstr
[00001a16] 588f                      addq.l     #4,a7
[00001a18] 2447                      movea.l    d7,a2
[00001a1a] d5fc 0002 0515            adda.l     #$00020515,a2
[00001a20] 4a12                      tst.b      (a2)
[00001a22] 6700 010e                 beq        _dbvar_2
[00001a26] 4a79 0002 04ac            tst.w      _dbfvlab
[00001a2c] 6600 0114                 bne        _dbvar_3
[00001a30] 4eb9 0000 5704            jsr        _crs
[00001a36] 33c7 0002 04ac            move.w     d7,_dbfvlab
[00001a3c] 6000 0104                 bra        _dbvar_3
_dbvar_1:
[00001a40] 4ab9 0002 050c            tst.l      $0002050C
[00001a46] 6700 010c                 beq        _dbvar_4
[00001a4a] 4297                      clr.l      (a7)
[00001a4c] 2f3c 0002 0dd4            move.l     #_atunsign,-(a7)
[00001a52] 4eb9 0000 78b4            jsr        _bound
[00001a58] 588f                      addq.l     #4,a7
[00001a5a] 2f07                      move.l     d7,-(a7)
[00001a5c] 2f39 0002 0510            move.l     $00020510,-(a7)
[00001a62] 3e39 0002 04ac            move.w     _dbfvlab,d7
[00001a68] 48c7                      ext.l      d7
[00001a6a] 2f07                      move.l     d7,-(a7)
[00001a6c] 4eb9 0000 5a30            jsr        _pdata
[00001a72] 4fef 000c                 lea.l      12(a7),a7
[00001a76] 4279 0002 04ac            clr.w      _dbfvlab
[00001a7c] 2d79 0002 050c 0008       move.l     $0002050C,8(a6)
_dbvar_15:
[00001a84] 4aae 0008                 tst.l      8(a6)
[00001a88] 6700 00d2                 beq        _dbvar_5
[00001a8c] 4eb9 0000 5704            jsr        _crs
[00001a92] 3d47 fffa                 move.w     d7,-6(a6)
[00001a96] 4878 0001                 pea.l      ($00000001).w
[00001a9a] 42a7                      clr.l      -(a7)
[00001a9c] 42a7                      clr.l      -(a7)
[00001a9e] 42a7                      clr.l      -(a7)
[00001aa0] 2f39 0002 0510            move.l     $00020510,-(a7)
[00001aa6] 3e2e fffa                 move.w     -6(a6),d7
[00001aaa] 48c7                      ext.l      d7
[00001aac] 2f07                      move.l     d7,-(a7)
[00001aae] 4eb9 0000 5908            jsr        _paddr
[00001ab4] 4fef 0018                 lea.l      24(a7),a7
[00001ab8] 4878 0001                 pea.l      ($00000001).w
[00001abc] 42a7                      clr.l      -(a7)
[00001abe] 42a7                      clr.l      -(a7)
[00001ac0] 42a7                      clr.l      -(a7)
[00001ac2] 2f39 0002 0510            move.l     $00020510,-(a7)
[00001ac8] 42a7                      clr.l      -(a7)
[00001aca] 4eb9 0000 5908            jsr        _paddr
[00001ad0] 4fef 0018                 lea.l      24(a7),a7
[00001ad4] 45f8 000e                 lea.l      ($0000000E).w,a2
[00001ad8] d5ee 0008                 adda.l     8(a6),a2
[00001adc] 4287                      clr.l      d7
[00001ade] 1e12                      move.b     (a2),d7
[00001ae0] 2e87                      move.l     d7,(a7)
[00001ae2] 2f3c 0002 0504            move.l     #$00020504,-(a7)
[00001ae8] 4eb9 0000 a7a6            jsr        _scnstr
[00001aee] 588f                      addq.l     #4,a7
[00001af0] 2447                      movea.l    d7,a2
[00001af2] d5fc 0002 0515            adda.l     #$00020515,a2
[00001af8] 1d52 fff8                 move.b     (a2),-8(a6)
[00001afc] 0c2e 0004 fff8            cmpi.b     #$04,-8(a6)
[00001b02] 6600 0110                 bne        _dbvar_6
[00001b06] 4878 0001                 pea.l      ($00000001).w
[00001b0a] 42a7                      clr.l      -(a7)
[00001b0c] 42a7                      clr.l      -(a7)
[00001b0e] 246e 0008                 movea.l    8(a6),a2
[00001b12] 508a                      addq.l     #8,a2
[00001b14] 1e12                      move.b     (a2),d7
[00001b16] 4887                      ext.w      d7
[00001b18] 48c7                      ext.l      d7
[00001b1a] 2f07                      move.l     d7,-(a7)
[00001b1c] 2f39 0002 0510            move.l     $00020510,-(a7)
[00001b22] 42a7                      clr.l      -(a7)
[00001b24] 4eb9 0000 5908            jsr        _paddr
[00001b2a] 4fef 0018                 lea.l      24(a7),a7
[00001b2e] 6000 0150                 bra        _dbvar_7
_dbvar_2:
[00001b32] 4297                      clr.l      (a7)
[00001b34] 2f2e 0008                 move.l     8(a6),-(a7)
[00001b38] 4eb9 0000 aa76            jsr        _free
[00001b3e] 588f                      addq.l     #4,a7
[00001b40] 6012                      bra.s      _dbvar_4
_dbvar_3:
[00001b42] 246e 0008                 movea.l    8(a6),a2
[00001b46] 24b9 0002 050c            move.l     $0002050C,(a2)
[00001b4c] 23ee 0008 0002 050c       move.l     8(a6),$0002050C
_dbvar_4:
[00001b54] 2e2e 000c                 move.l     12(a6),d7
[00001b58] 4e5e                      unlk       a6
[00001b5a] 4e75                      rts
_dbvar_5:
[00001b5c] 4878 0001                 pea.l      ($00000001).w
[00001b60] 42a7                      clr.l      -(a7)
[00001b62] 42a7                      clr.l      -(a7)
[00001b64] 42a7                      clr.l      -(a7)
[00001b66] 2f39 0002 0510            move.l     $00020510,-(a7)
[00001b6c] 42a7                      clr.l      -(a7)
[00001b6e] 4eb9 0000 5908            jsr        _paddr
[00001b74] 4fef 0018                 lea.l      24(a7),a7
[00001b78] 2d79 0002 050c 0008       move.l     $0002050C,8(a6)
_dbvar_9:
[00001b80] 4aae 0008                 tst.l      8(a6)
[00001b84] 6700 0170                 beq        _dbvar_8
[00001b88] 4297                      clr.l      (a7)
[00001b8a] 42a7                      clr.l      -(a7)
[00001b8c] 2f39 0002 0510            move.l     $00020510,-(a7)
[00001b92] 246e 0008                 movea.l    8(a6),a2
[00001b96] 508a                      addq.l     #8,a2
[00001b98] 3e12                      move.w     (a2),d7
[00001b9a] 48c7                      ext.l      d7
[00001b9c] 2f07                      move.l     d7,-(a7)
[00001b9e] 4eb9 0000 5a30            jsr        _pdata
[00001ba4] 4fef 000c                 lea.l      12(a7),a7
[00001ba8] 45f8 0010                 lea.l      ($00000010).w,a2
[00001bac] d5ee 0008                 adda.l     8(a6),a2
[00001bb0] 4287                      clr.l      d7
[00001bb2] 1e12                      move.b     (a2),d7
[00001bb4] 2e87                      move.l     d7,(a7)
[00001bb6] 7e11                      moveq.l    #17,d7
[00001bb8] deae 0008                 add.l      8(a6),d7
[00001bbc] 2f07                      move.l     d7,-(a7)
[00001bbe] 4eb9 0000 61ca            jsr        _pstr
[00001bc4] 588f                      addq.l     #4,a7
[00001bc6] 4878 0001                 pea.l      ($00000001).w
[00001bca] 2f39 0002 0510            move.l     $00020510,-(a7)
[00001bd0] 4eb9 0000 61ca            jsr        _pstr
[00001bd6] 508f                      addq.l     #8,a7
[00001bd8] 4878 0001                 pea.l      ($00000001).w
[00001bdc] 45f8 000e                 lea.l      ($0000000E).w,a2
[00001be0] d5ee 0008                 adda.l     8(a6),a2
[00001be4] 4287                      clr.l      d7
[00001be6] 1e12                      move.b     (a2),d7
[00001be8] 2f07                      move.l     d7,-(a7)
[00001bea] 2f3c 0002 0504            move.l     #$00020504,-(a7)
[00001bf0] 4eb9 0000 a7a6            jsr        _scnstr
[00001bf6] 508f                      addq.l     #8,a7
[00001bf8] 2f07                      move.l     d7,-(a7)
[00001bfa] 0697 0002 0515            addi.l     #$00020515,(a7)
[00001c00] 4eb9 0000 61ca            jsr        _pstr
[00001c06] 508f                      addq.l     #8,a7
[00001c08] 246e 0008                 movea.l    8(a6),a2
[00001c0c] 2d52 0008                 move.l     (a2),8(a6)
[00001c10] 6000 ff6e                 bra        _dbvar_9
_dbvar_6:
[00001c14] 0c2e 0001 fff8            cmpi.b     #$01,-8(a6)
[00001c1a] 662a                      bne.s      _dbvar_10
[00001c1c] 4878 0001                 pea.l      ($00000001).w
[00001c20] 42a7                      clr.l      -(a7)
[00001c22] 42a7                      clr.l      -(a7)
[00001c24] 42a7                      clr.l      -(a7)
[00001c26] 7e10                      moveq.l    #16,d7
[00001c28] deae 0008                 add.l      8(a6),d7
[00001c2c] 2f07                      move.l     d7,-(a7)
[00001c2e] 246e 0008                 movea.l    8(a6),a2
[00001c32] 508a                      addq.l     #8,a2
[00001c34] 3e12                      move.w     (a2),d7
[00001c36] 48c7                      ext.l      d7
[00001c38] 2f07                      move.l     d7,-(a7)
[00001c3a] 4eb9 0000 5908            jsr        _paddr
[00001c40] 4fef 0018                 lea.l      24(a7),a7
[00001c44] 603a                      bra.s      _dbvar_7
_dbvar_10:
[00001c46] 4878 0001                 pea.l      ($00000001).w
[00001c4a] 42a7                      clr.l      -(a7)
[00001c4c] 42a7                      clr.l      -(a7)
[00001c4e] 246e 0008                 movea.l    8(a6),a2
[00001c52] 508a                      addq.l     #8,a2
[00001c54] 4a92                      tst.l      (a2)
[00001c56] 6c0c                      bge.s      _dbvar_11
[00001c58] 246e 0008                 movea.l    8(a6),a2
[00001c5c] 508a                      addq.l     #8,a2
[00001c5e] 2e12                      move.l     (a2),d7
[00001c60] 4487                      neg.l      d7
[00001c62] 6008                      bra.s      _dbvar_12
_dbvar_11:
[00001c64] 246e 0008                 movea.l    8(a6),a2
[00001c68] 508a                      addq.l     #8,a2
[00001c6a] 2e12                      move.l     (a2),d7
_dbvar_12:
[00001c6c] 2f07                      move.l     d7,-(a7)
[00001c6e] 2f39 0002 0510            move.l     $00020510,-(a7)
[00001c74] 42a7                      clr.l      -(a7)
[00001c76] 4eb9 0000 5908            jsr        _paddr
[00001c7c] 4fef 0018                 lea.l      24(a7),a7
_dbvar_7:
[00001c80] 422e fff9                 clr.b      -7(a6)
[00001c84] 246e 0008                 movea.l    8(a6),a2
[00001c88] 588a                      addq.l     #4,a2
[00001c8a] 2d52 fffc                 move.l     (a2),-4(a6)
_dbvar_14:
[00001c8e] 246e fffc                 movea.l    -4(a6),a2
[00001c92] 508a                      addq.l     #8,a2
[00001c94] 4287                      clr.l      d7
[00001c96] 1e12                      move.b     (a2),d7
[00001c98] 0c47 0040                 cmpi.w     #$0040,d7
[00001c9c] 6610                      bne.s      _dbvar_13
[00001c9e] 522e fff9                 addq.b     #1,-7(a6)
[00001ca2] 246e fffc                 movea.l    -4(a6),a2
[00001ca6] 588a                      addq.l     #4,a2
[00001ca8] 2d52 fffc                 move.l     (a2),-4(a6)
[00001cac] 60e0                      bra.s      _dbvar_14
_dbvar_13:
[00001cae] 4878 0001                 pea.l      ($00000001).w
[00001cb2] 42a7                      clr.l      -(a7)
[00001cb4] 42a7                      clr.l      -(a7)
[00001cb6] 246e fffc                 movea.l    -4(a6),a2
[00001cba] 508a                      addq.l     #8,a2
[00001cbc] 4287                      clr.l      d7
[00001cbe] 1e12                      move.b     (a2),d7
[00001cc0] e187                      asl.l      #8,d7
[00001cc2] 1c2e fff9                 move.b     -7(a6),d6
[00001cc6] 4886                      ext.w      d6
[00001cc8] 48c6                      ext.l      d6
[00001cca] 8e86                      or.l       d6,d7
[00001ccc] 2f07                      move.l     d7,-(a7)
[00001cce] 2f39 0002 0510            move.l     $00020510,-(a7)
[00001cd4] 42a7                      clr.l      -(a7)
[00001cd6] 4eb9 0000 5908            jsr        _paddr
[00001cdc] 4fef 0018                 lea.l      24(a7),a7
[00001ce0] 246e 0008                 movea.l    8(a6),a2
[00001ce4] 508a                      addq.l     #8,a2
[00001ce6] 34ae fffa                 move.w     -6(a6),(a2)
[00001cea] 246e 0008                 movea.l    8(a6),a2
[00001cee] 2d52 0008                 move.l     (a2),8(a6)
[00001cf2] 6000 fd90                 bra        _dbvar_15
_dbvar_8:
[00001cf6] 4297                      clr.l      (a7)
[00001cf8] 2f39 0002 050c            move.l     $0002050C,-(a7)
[00001cfe] 4eb9 0000 9da6            jsr        _frelst
[00001d04] 588f                      addq.l     #4,a7
[00001d06] 23c7 0002 050c            move.l     d7,$0002050C
[00001d0c] 6000 fe46                 bra        _dbvar_4

_doblock:
[00001d10] 4e56 ffd6                 link       a6,#-42
[00001d14] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[00001d18] 3d79 0002 04a0 fffa       move.w     _regset,-6(a6)
[00001d20] 2d79 0002 04a2 fff6       move.l     _autoff,-10(a6)
[00001d28] 0cae ffff ffff 0008       cmpi.l     #$FFFFFFFF,8(a6)
[00001d30] 6616                      bne.s      _doblock_1
[00001d32] 2d79 0002 0cee fffc       move.l     _gblat,-4(a6)
[00001d3a] 2d79 0002 0d16 ffdc       move.l     _gblsym,-36(a6)
[00001d42] 42ae 0008                 clr.l      8(a6)
[00001d46] 6010                      bra.s      _doblock_2
_doblock_1:
[00001d48] 2d79 0002 0cea fffc       move.l     _attlist,-4(a6)
[00001d50] 2d79 0002 0d2e ffdc       move.l     _symtab,-36(a6)
_doblock_2:
[00001d58] 2d79 0002 0d2a fff2       move.l     _symend,-14(a6)
[00001d60] 23ee ffdc 0002 0d2a       move.l     -36(a6),_symend
_doblock_7:
[00001d68] 4297                      clr.l      (a7)
[00001d6a] 4878 0037                 pea.l      ($00000037).w
[00001d6e] 4878 0034                 pea.l      ($00000034).w
[00001d72] 4878 002a                 pea.l      ($0000002A).w
[00001d76] 4878 0031                 pea.l      ($00000031).w
[00001d7a] 4878 0021                 pea.l      ($00000021).w
[00001d7e] 486e ffe0                 pea.l      -32(a6)
[00001d82] 4eb9 0000 4d4c            jsr        _gscty
[00001d88] 4fef 0018                 lea.l      24(a7),a7
[00001d8c] 4a87                      tst.l      d7
[00001d8e] 6744                      beq.s      _doblock_3
_doblock_20:
[00001d90] 4297                      clr.l      (a7)
[00001d92] 486e ffe0                 pea.l      -32(a6)
[00001d96] 4eb9 0000 4b1e            jsr        _gdecl
[00001d9c] 588f                      addq.l     #4,a7
[00001d9e] 2a47                      movea.l    d7,a5
[00001da0] 2e0d                      move.l     a5,d7
[00001da2] 6758                      beq.s      _doblock_4
[00001da4] 246d 0004                 movea.l    4(a5),a2
[00001da8] 508a                      addq.l     #8,a2
[00001daa] 4287                      clr.l      d7
[00001dac] 1e12                      move.b     (a2),d7
[00001dae] 0c47 0042                 cmpi.w     #$0042,d7
[00001db2] 6658                      bne.s      _doblock_5
[00001db4] 4287                      clr.l      d7
[00001db6] 1e2d 000e                 move.b     14(a5),d7
[00001dba] 0c47 0037                 cmpi.w     #$0037,d7
[00001dbe] 674c                      beq.s      _doblock_5
[00001dc0] 4287                      clr.l      d7
[00001dc2] 1e2d 000e                 move.b     14(a5),d7
[00001dc6] 0c47 0034                 cmpi.w     #$0034,d7
[00001dca] 6740                      beq.s      _doblock_5
[00001dcc] 1b7c 002a 000e            move.b     #$2A,14(a5)
[00001dd2] 6038                      bra.s      _doblock_5
_doblock_3:
[00001dd4] 4287                      clr.l      d7
[00001dd6] 3e39 0002 04a0            move.w     _regset,d7
[00001ddc] 4286                      clr.l      d6
[00001dde] 3c2e fffa                 move.w     -6(a6),d6
[00001de2] be86                      cmp.l      d6,d7
[00001de4] 6700 037a                 beq        _doblock_6
[00001de8] 4287                      clr.l      d7
[00001dea] 3e39 0002 04a0            move.w     _regset,d7
[00001df0] 2e87                      move.l     d7,(a7)
[00001df2] 4eb9 0000 60fe            jsr        _pregs
[00001df8] 6000 0366                 bra        _doblock_6
_doblock_4:
[00001dfc] 4878 000b                 pea.l      ($0000000B).w
[00001e00] 4eb9 0000 3c08            jsr        _need
[00001e06] 588f                      addq.l     #4,a7
[00001e08] 6000 ff5e                 bra        _doblock_7
_doblock_5:
[00001e0c] 2eae ffdc                 move.l     -36(a6),(a7)
[00001e10] 2f39 0002 0d2e            move.l     _symtab,-(a7)
[00001e16] 486d 0010                 pea.l      16(a5)
[00001e1a] 4eb9 0000 847e            jsr        _lookup
[00001e20] 508f                      addq.l     #8,a7
[00001e22] 4a87                      tst.l      d7
[00001e24] 6712                      beq.s      _doblock_8
[00001e26] 486d 0010                 pea.l      16(a5)
[00001e2a] 2f3c 0002 0545            move.l     #$00020545,-(a7) "redeclared local"
[00001e30] 4eb9 0000 3c8a            jsr        _nmerr
[00001e36] 508f                      addq.l     #8,a7
_doblock_8:
[00001e38] 2ebc 0002 0d2e            move.l     #_symtab,(a7)
[00001e3e] 2f0d                      move.l     a5,-(a7)
[00001e40] 4eb9 0000 774e            jsr        _addsym
[00001e46] 588f                      addq.l     #4,a7
[00001e48] 4878 000c                 pea.l      ($0000000C).w
[00001e4c] 4eb9 0000 332e            jsr        _eat
[00001e52] 588f                      addq.l     #4,a7
[00001e54] 4a87                      tst.l      d7
[00001e56] 670c                      beq.s      _doblock_9
[00001e58] 2e8d                      move.l     a5,(a7)
[00001e5a] 4eb9 0000 00c6            jsr        _alias
[00001e60] 6000 01e0                 bra        _doblock_10
_doblock_9:
[00001e64] 4287                      clr.l      d7
[00001e66] 1e2d 000e                 move.b     14(a5),d7
[00001e6a] 0c47 0034                 cmpi.w     #$0034,d7
[00001e6e] 663c                      bne.s      _doblock_11
[00001e70] 246d 0004                 movea.l    4(a5),a2
[00001e74] 508a                      addq.l     #8,a2
[00001e76] 4287                      clr.l      d7
[00001e78] 1e12                      move.b     (a2),d7
[00001e7a] 0c47 0042                 cmpi.w     #$0042,d7
[00001e7e] 672c                      beq.s      _doblock_11
[00001e80] 4297                      clr.l      (a7)
[00001e82] 2f0d                      move.l     a5,-(a7)
[00001e84] 4eb9 0000 03ba            jsr        _datinit
[00001e8a] 588f                      addq.l     #4,a7
[00001e8c] 4287                      clr.l      d7
[00001e8e] 1e2d 000e                 move.b     14(a5),d7
[00001e92] 0c47 0034                 cmpi.w     #$0034,d7
[00001e96] 6600 01aa                 bne        _doblock_10
[00001e9a] 4878 0001                 pea.l      ($00000001).w
[00001e9e] 2f0d                      move.l     a5,-(a7)
[00001ea0] 4eb9 0000 03ba            jsr        _datinit
[00001ea6] 508f                      addq.l     #8,a7
[00001ea8] 6000 0198                 bra        _doblock_10
_doblock_11:
[00001eac] 4287                      clr.l      d7
[00001eae] 1e2d 000e                 move.b     14(a5),d7
[00001eb2] 0c47 002a                 cmpi.w     #$002A,d7
[00001eb6] 6710                      beq.s      _doblock_12
[00001eb8] 246d 0004                 movea.l    4(a5),a2
[00001ebc] 508a                      addq.l     #8,a2
[00001ebe] 4287                      clr.l      d7
[00001ec0] 1e12                      move.b     (a2),d7
[00001ec2] 0c47 0042                 cmpi.w     #$0042,d7
[00001ec6] 6660                      bne.s      _doblock_13
_doblock_12:
[00001ec8] 4297                      clr.l      (a7)
[00001eca] 2f39 0002 0d16            move.l     _gblsym,-(a7)
[00001ed0] 486d 0010                 pea.l      16(a5)
[00001ed4] 4eb9 0000 847e            jsr        _lookup
[00001eda] 508f                      addq.l     #8,a7
[00001edc] 2847                      movea.l    d7,a4
[00001ede] 2e0c                      move.l     a4,d7
[00001ee0] 6666                      bne.s      _doblock_14
[00001ee2] 4287                      clr.l      d7
[00001ee4] 1e2d 000e                 move.b     14(a5),d7
[00001ee8] 2e87                      move.l     d7,(a7)
[00001eea] 486d 0010                 pea.l      16(a5)
[00001eee] 42a7                      clr.l      -(a7)
[00001ef0] 4eb9 0000 7a78            jsr        _buysym
[00001ef6] 508f                      addq.l     #8,a7
[00001ef8] 2847                      movea.l    d7,a4
[00001efa] 4287                      clr.l      d7
[00001efc] 1e2d 000e                 move.b     14(a5),d7
[00001f00] 0c47 0034                 cmpi.w     #$0034,d7
[00001f04] 6600 00bc                 bne        _doblock_15
[00001f08] 246d 0004                 movea.l    4(a5),a2
[00001f0c] 508a                      addq.l     #8,a2
[00001f0e] 4287                      clr.l      d7
[00001f10] 1e12                      move.b     (a2),d7
[00001f12] 0c47 0042                 cmpi.w     #$0042,d7
[00001f16] 6600 00aa                 bne        _doblock_15
[00001f1a] 4eb9 0000 5704            jsr        _crs
[00001f20] 3b47 0008                 move.w     d7,8(a5)
[00001f24] 6000 009c                 bra        _doblock_15
_doblock_13:
[00001f28] 4287                      clr.l      d7
[00001f2a] 1e2d 000e                 move.b     14(a5),d7
[00001f2e] 0c47 0031                 cmpi.w     #$0031,d7
[00001f32] 6700 01ae                 beq        _doblock_16
[00001f36] 4287                      clr.l      d7
[00001f38] 1e2d 000e                 move.b     14(a5),d7
[00001f3c] 0c47 0021                 cmpi.w     #$0021,d7
[00001f40] 6600 0100                 bne        _doblock_10
[00001f44] 6000 019c                 bra        _doblock_16
_doblock_14:
[00001f48] 4ab9 0002 0b8e            tst.l      _stdflag
[00001f4e] 6600 00a4                 bne        _doblock_17
[00001f52] 246c 0004                 movea.l    4(a4),a2
[00001f56] 508a                      addq.l     #8,a2
[00001f58] 4287                      clr.l      d7
[00001f5a] 1e12                      move.b     (a2),d7
[00001f5c] 0c47 0042                 cmpi.w     #$0042,d7
[00001f60] 6600 0092                 bne        _doblock_17
[00001f64] 246d 0004                 movea.l    4(a5),a2
[00001f68] 508a                      addq.l     #8,a2
[00001f6a] 4287                      clr.l      d7
[00001f6c] 1e12                      move.b     (a2),d7
[00001f6e] 0c47 0042                 cmpi.w     #$0042,d7
[00001f72] 6600 0080                 bne        _doblock_17 ; possibly optimized to short
[00001f76] 45f8 000a                 lea.l      ($0000000A).w,a2
[00001f7a] d5ec 0004                 adda.l     4(a4),a2
[00001f7e] 2e12                      move.l     (a2),d7
[00001f80] 0c87 0002 0d04            cmpi.l     #_tentsym,d7
[00001f86] 666c                      bne.s      _doblock_17
[00001f88] 4287                      clr.l      d7
[00001f8a] 1e2d 000e                 move.b     14(a5),d7
[00001f8e] 0c47 002a                 cmpi.w     #$002A,d7
[00001f92] 6660                      bne.s      _doblock_17
[00001f94] 296d 0004 0004            move.l     4(a5),4(a4)
[00001f9a] 4297                      clr.l      (a7)
[00001f9c] 486c 0004                 pea.l      4(a4)
[00001fa0] 4eb9 0000 7e8c            jsr        _cpyats
[00001fa6] 588f                      addq.l     #4,a7
[00001fa8] 2b6c 0004 0004            move.l     4(a4),4(a5)
[00001fae] 4287                      clr.l      d7
[00001fb0] 3e2d 000c                 move.w     12(a5),d7
[00001fb4] 8f6c 000c                 or.w       d7,12(a4)
[00001fb8] 3b6c 000c 000c            move.w     12(a4),12(a5)
[00001fbe] 6000 0082                 bra        _doblock_10
_doblock_15:
[00001fc2] 296d 0004 0004            move.l     4(a5),4(a4)
[00001fc8] 396d 000c 000c            move.w     12(a5),12(a4)
[00001fce] 396d 0008 0008            move.w     8(a5),8(a4)
[00001fd4] 4297                      clr.l      (a7)
[00001fd6] 486c 0004                 pea.l      4(a4)
[00001fda] 4eb9 0000 7e8c            jsr        _cpyats
[00001fe0] 588f                      addq.l     #4,a7
[00001fe2] 2eb9 0002 0d16            move.l     _gblsym,(a7)
[00001fe8] 2f0c                      move.l     a4,-(a7)
[00001fea] 4eb9 0000 774e            jsr        _addsym
[00001ff0] 588f                      addq.l     #4,a7
[00001ff2] 604e                      bra.s      _doblock_10
_doblock_17:
[00001ff4] 4287                      clr.l      d7
[00001ff6] 1e2c 000e                 move.b     14(a4),d7
[00001ffa] 2e87                      move.l     d7,(a7)
[00001ffc] 2f3c 0002 051c            move.l     #$0002051C,-(a7)
[00002002] 4eb9 0000 a7a6            jsr        _scnstr
[00002008] 588f                      addq.l     #4,a7
[0000200a] 2447                      movea.l    d7,a2
[0000200c] d5fc 0002 051c            adda.l     #$0002051C,a2
[00002012] 4a12                      tst.b      (a2)
[00002014] 671a                      beq.s      _doblock_18
[00002016] 4878 0001                 pea.l      ($00000001).w
[0000201a] 2f2c 0004                 move.l     4(a4),-(a7)
[0000201e] 2f2d 0004                 move.l     4(a5),-(a7)
[00002022] 4eb9 0000 7d40            jsr        _cmptype
[00002028] 4fef 000c                 lea.l      12(a7),a7
[0000202c] 4a87                      tst.l      d7
[0000202e] 6628                      bne.s      _doblock_19
_doblock_18:
[00002030] 486d 0010                 pea.l      16(a5)
[00002034] 2f3c 0002 0532            move.l     #$00020532,-(a7) "redefined external"
[0000203a] 4eb9 0000 3c8a            jsr        _nmerr
[00002040] 508f                      addq.l     #8,a7
_doblock_10:
[00002042] 4878 0002                 pea.l      ($00000002).w
[00002046] 4eb9 0000 332e            jsr        _eat
[0000204c] 588f                      addq.l     #4,a7
[0000204e] 4a87                      tst.l      d7
[00002050] 6600 fd3e                 bne        _doblock_20
[00002054] 6000 fda6                 bra        _doblock_4
_doblock_19:
[00002058] 2ead 0004                 move.l     4(a5),(a7)
[0000205c] 2f2c 0004                 move.l     4(a4),-(a7)
[00002060] 4eb9 0000 8534            jsr        _mergatt
[00002066] 588f                      addq.l     #4,a7
[00002068] 2947 0004                 move.l     d7,4(a4)
[0000206c] 2b6c 0004 0004            move.l     4(a4),4(a5)
[00002072] 4287                      clr.l      d7
[00002074] 3e2d 000c                 move.w     12(a5),d7
[00002078] 8f6c 000c                 or.w       d7,12(a4)
[0000207c] 3b6c 000c 000c            move.w     12(a4),12(a5)
[00002082] 4287                      clr.l      d7
[00002084] 1e2d 0010                 move.b     16(a5),d7
[00002088] 2447                      movea.l    d7,a2
[0000208a] 47ed 0011                 lea.l      17(a5),a3
[0000208e] d5cb                      adda.l     a3,a2
[00002090] 4287                      clr.l      d7
[00002092] 1e2c 0010                 move.b     16(a4),d7
[00002096] 2647                      movea.l    d7,a3
[00002098] 486c 0011                 pea.l      17(a4)
[0000209c] d7df                      adda.l     (a7)+,a3
[0000209e] 1493                      move.b     (a3),(a2)
[000020a0] 4287                      clr.l      d7
[000020a2] 1e2c 000e                 move.b     14(a4),d7
[000020a6] 0c47 0034                 cmpi.w     #$0034,d7
[000020aa] 670c                      beq.s      _doblock_21
[000020ac] 4287                      clr.l      d7
[000020ae] 1e2c 000e                 move.b     14(a4),d7
[000020b2] 0c47 003d                 cmpi.w     #$003D,d7
[000020b6] 660c                      bne.s      _doblock_22
_doblock_21:
[000020b8] 1b7c 0034 000e            move.b     #$34,14(a5)
[000020be] 3b6c 0008 0008            move.w     8(a4),8(a5)
_doblock_22:
[000020c4] 4287                      clr.l      d7
[000020c6] 1e2c 000e                 move.b     14(a4),d7
[000020ca] 0c47 003a                 cmpi.w     #$003A,d7
[000020ce] 6600 ff72                 bne        _doblock_10
[000020d2] 1b7c 003a 000e            move.b     #$3A,14(a5)
[000020d8] 2b6c 0008 0008            move.l     8(a4),8(a5)
[000020de] 6000 ff62                 bra        _doblock_10
_doblock_16:
[000020e2] 4287                      clr.l      d7
[000020e4] 1e2d 000e                 move.b     14(a5),d7
[000020e8] 0c47 0031                 cmpi.w     #$0031,d7
[000020ec] 662a                      bne.s      _doblock_23
[000020ee] 2ebc 0002 04a0            move.l     #_regset,(a7)
[000020f4] 2f2d 0004                 move.l     4(a5),-(a7)
[000020f8] 4eb9 0000 69ae            jsr        _rbuy
[000020fe] 588f                      addq.l     #4,a7
[00002100] 2a07                      move.l     d7,d5
[00002102] 6714                      beq.s      _doblock_23
[00002104] 1b45 0008                 move.b     d5,8(a5)
[00002108] 2ead 0004                 move.l     4(a5),(a7)
[0000210c] 4eb9 0000 84da            jsr        _maxify
[00002112] 2b47 0004                 move.l     d7,4(a5)
[00002116] 603e                      bra.s      _doblock_24
_doblock_23:
[00002118] 1b7c 0021 000e            move.b     #$21,14(a5)
[0000211e] 4878 0001                 pea.l      ($00000001).w
[00002122] 2f2d 0004                 move.l     4(a5),-(a7)
[00002126] 4eb9 0000 7b74            jsr        _bytes
[0000212c] 508f                      addq.l     #8,a7
[0000212e] 9fb9 0002 04a2            sub.l      d7,_autoff
[00002134] 2ead 0004                 move.l     4(a5),(a7)
[00002138] 4eb9 0000 78b4            jsr        _bound
[0000213e] 7c01                      moveq.l    #1,d6
[00002140] efa6                      asl.l      d7,d6
[00002142] 2e06                      move.l     d6,d7
[00002144] 5387                      subq.l     #1,d7
[00002146] 4687                      not.l      d7
[00002148] cfb9 0002 04a2            and.l      d7,_autoff
[0000214e] 2b79 0002 04a2 0008       move.l     _autoff,8(a5)
_doblock_24:
[00002156] 2e8d                      move.l     a5,(a7)
[00002158] 4eba f524                 jsr        _autinit(pc)
[0000215c] 6000 fee4                 bra        _doblock_10
_doblock_6:
[00002160] 2e39 0002 04a2            move.l     _autoff,d7
[00002166] beae fff6                 cmp.l      -10(a6),d7
[0000216a] 670c                      beq.s      _doblock_25
[0000216c] 2eb9 0002 04a2            move.l     _autoff,(a7)
[00002172] 4eb9 0000 59b0            jsr        _pauto
_doblock_25:
[00002178] 486e ffd6                 pea.l      -42(a6)
[0000217c] 4eb9 0000 34e6            jsr        _gettok1
[00002182] 588f                      addq.l     #4,a7
[00002184] 2447                      movea.l    d7,a2
[00002186] 4287                      clr.l      d7
[00002188] 1e12                      move.b     (a2),d7
[0000218a] 0c47 0009                 cmpi.w     #$0009,d7
[0000218e] 6724                      beq.s      _doblock_26
[00002190] 486e ffd6                 pea.l      -42(a6)
[00002194] 4eb9 0000 31e4            jsr        _baktok1
[0000219a] 588f                      addq.l     #4,a7
[0000219c] 4287                      clr.l      d7
[0000219e] 1e2e ffd6                 move.b     -42(a6),d7
[000021a2] 0c47 00ff                 cmpi.w     #$00FF,d7
[000021a6] 6638                      bne.s      _doblock_27
[000021a8] 2ebc 0002 0523            move.l     #$00020523,(a7) "unexpected EOF"
[000021ae] 4eb9 0000 3e84            jsr        _p1error
_doblock_26:
[000021b4] 4287                      clr.l      d7
[000021b6] 3e39 0002 04a0            move.w     _regset,d7
[000021bc] 4286                      clr.l      d6
[000021be] 3c2e fffa                 move.w     -6(a6),d6
[000021c2] be86                      cmp.l      d6,d7
[000021c4] 672c                      beq.s      _doblock_28
[000021c6] 33ee fffa 0002 04a0       move.w     -6(a6),_regset
[000021ce] 4287                      clr.l      d7
[000021d0] 3e39 0002 04a0            move.w     _regset,d7
[000021d6] 2e87                      move.l     d7,(a7)
[000021d8] 4eb9 0000 60fe            jsr        _pregs
[000021de] 6012                      bra.s      _doblock_28
_doblock_27:
[000021e0] 2eae 000c                 move.l     12(a6),(a7)
[000021e4] 2f2e 0008                 move.l     8(a6),-(a7)
[000021e8] 4eb9 0000 224e            jsr        _dostat
[000021ee] 588f                      addq.l     #4,a7
[000021f0] 6086                      bra.s      _doblock_25
_doblock_28:
[000021f2] 2e39 0002 04a2            move.l     _autoff,d7
[000021f8] beae fff6                 cmp.l      -10(a6),d7
[000021fc] 6714                      beq.s      _doblock_29
[000021fe] 23ee fff6 0002 04a2       move.l     -10(a6),_autoff
[00002206] 2eb9 0002 04a2            move.l     _autoff,(a7)
[0000220c] 4eb9 0000 59b0            jsr        _pauto
_doblock_29:
[00002212] 23ee fff2 0002 0d2a       move.l     -14(a6),_symend
[0000221a] 2eae ffdc                 move.l     -36(a6),(a7)
[0000221e] 4eb9 0000 30de            jsr        _perc
[00002224] 23f9 0002 0d2e 0002 0d2a  move.l     _symtab,_symend
[0000222e] 2eae fffc                 move.l     -4(a6),(a7)
[00002232] 2f39 0002 0cea            move.l     _attlist,-(a7)
[00002238] 4eb9 0000 8332            jsr        _frealst
[0000223e] 588f                      addq.l     #4,a7
[00002240] 23c7 0002 0cea            move.l     d7,_attlist
[00002246] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[0000224a] 4e5e                      unlk       a6
[0000224c] 4e75                      rts

_dostat:
[0000224e] 4e56 fff6                 link       a6,#-10
[00002252] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00002256] 2d79 0002 0cea fff6       move.l     _attlist,-10(a6)
[0000225e] 42b9 0002 055a            clr.l      $0002055A
_dostat_5:
[00002264] 4ab9 0002 055a            tst.l      $0002055A
[0000226a] 661e                      bne.s      _dostat_1
[0000226c] 2ebc 0002 0566            move.l     #$00020566,(a7)
[00002272] 4eb9 0000 34e6            jsr        _gettok1
[00002278] 2447                      movea.l    d7,a2
[0000227a] 4287                      clr.l      d7
[0000227c] 1e12                      move.b     (a2),d7
[0000227e] 41f9 0002 0574            lea.l      $00020574,a0
[00002284] 4ef9 0000 a7dc            jmp        a.switch
_dostat_1:
[0000228a] 4287                      clr.l      d7
[0000228c] 1e39 0002 0566            move.b     $00020566,d7
[00002292] 41f9 0002 058c            lea.l      $0002058C,a0
[00002298] 4ef9 0000 a7dc            jmp        a.switch
[0000229e] 4eba f704                 jsr        _dbstat(pc)
[000022a2] 4878 0001                 pea.l      ($00000001).w
[000022a6] 4eb9 0000 0b62            jsr        _cons
[000022ac] 588f                      addq.l     #4,a7
[000022ae] 23c7 0002 056c            move.l     d7,$0002056C
[000022b4] 2eb9 0002 0556            move.l     $00020556,(a7)
[000022ba] 2f3c 0002 056c            move.l     #$0002056C,-(a7)
[000022c0] 4eb9 0000 6dd2            jsr        _docast
[000022c6] 588f                      addq.l     #4,a7
[000022c8] 4878 000e                 pea.l      ($0000000E).w
[000022cc] 4eb9 0000 332e            jsr        _eat
[000022d2] 588f                      addq.l     #4,a7
[000022d4] 4a87                      tst.l      d7
[000022d6] 660c                      bne.s      _dostat_2
[000022d8] 23f9 0002 056c 0002 0570  move.l     $0002056C,$00020570
[000022e2] 6026                      bra.s      _dostat_3
_dostat_2:
[000022e4] 4878 0001                 pea.l      ($00000001).w
[000022e8] 4eb9 0000 0b62            jsr        _cons
[000022ee] 588f                      addq.l     #4,a7
[000022f0] 23c7 0002 0570            move.l     d7,$00020570
[000022f6] 2eb9 0002 0556            move.l     $00020556,(a7)
[000022fc] 2f3c 0002 0570            move.l     #$00020570,-(a7)
[00002302] 4eb9 0000 6dd2            jsr        _docast
[00002308] 588f                      addq.l     #4,a7
_dostat_3:
[0000230a] 4eb9 0000 5704            jsr        _crs
[00002310] 3d47 fffc                 move.w     d7,-4(a6)
[00002314] 4878 0001                 pea.l      ($00000001).w
[00002318] 4eb9 0000 3c08            jsr        _need
[0000231e] 588f                      addq.l     #4,a7
[00002320] 4ab9 0002 0556            tst.l      $00020556
[00002326] 6610                      bne.s      _dostat_4
[00002328] 2ebc 0002 068d            move.l     #$0002068D,(a7) "illegal case"
[0000232e] 4eb9 0000 3e84            jsr        _p1error
[00002334] 6000 ff2e                 bra        _dostat_5
_dostat_4:
[00002338] 2e39 0002 056c            move.l     $0002056C,d7
[0000233e] 9fb9 0002 0570            sub.l      d7,$00020570
[00002344] 0cb9 0000 0200 0002 0570  cmpi.l     #$00000200,$00020570
[0000234e] 6522                      bcs.s      _dostat_6
[00002350] 2ebc 0002 067e            move.l     #$0002067E,(a7) "bad case range"
[00002356] 4eb9 0000 3e84            jsr        _p1error
[0000235c] 42b9 0002 0570            clr.l      $00020570
[00002362] 23f9 0002 0570 0002 056c  move.l     $00020570,$0002056C
[0000236c] 6004                      bra.s      _dostat_6
[0000236e] 6000 fef4                 bra        _dostat_5
_dostat_6:
[00002372] 52b9 0002 0570            addq.l     #1,$00020570
_dostat_7:
[00002378] 4ab9 0002 0570            tst.l      $00020570
[0000237e] 6700 fee4                 beq        _dostat_5
[00002382] 3e2e fffc                 move.w     -4(a6),d7
[00002386] 48c7                      ext.l      d7
[00002388] 2e87                      move.l     d7,(a7)
[0000238a] 2f39 0002 056c            move.l     $0002056C,-(a7)
[00002390] 2f3c 0002 055e            move.l     #$0002055E,-(a7)
[00002396] 4eba f26c                 jsr        _addcase(pc)
[0000239a] 508f                      addq.l     #8,a7
[0000239c] 2e87                      move.l     d7,(a7)
[0000239e] 4eb9 0000 59d4            jsr        _pcase
[000023a4] 52b9 0002 056c            addq.l     #1,$0002056C
[000023aa] 2eb9 0002 0556            move.l     $00020556,(a7)
[000023b0] 2f3c 0002 056c            move.l     #$0002056C,-(a7)
[000023b6] 4eb9 0000 6dd2            jsr        _docast
[000023bc] 588f                      addq.l     #4,a7
[000023be] 53b9 0002 0570            subq.l     #1,$00020570
[000023c4] 60b2                      bra.s      _dostat_7
[000023c6] 4eba f5dc                 jsr        _dbstat(pc)
[000023ca] 4878 0001                 pea.l      ($00000001).w
[000023ce] 4eb9 0000 3c08            jsr        _need
[000023d4] 588f                      addq.l     #4,a7
[000023d6] 4ab9 0002 0556            tst.l      $00020556
[000023dc] 6708                      beq.s      _dostat_8
[000023de] 4a79 0002 0562            tst.w      $00020562
[000023e4] 670c                      beq.s      _dostat_9
_dostat_8:
[000023e6] 2ebc 0002 066e            move.l     #$0002066E,(a7) "illegal default"
[000023ec] 4eb9 0000 3e84            jsr        _p1error
_dostat_9:
[000023f2] 4eb9 0000 5704            jsr        _crs
[000023f8] 2e87                      move.l     d7,(a7)
[000023fa] 4eb9 0000 59d4            jsr        _pcase
[00002400] 33c7 0002 0562            move.w     d7,$00020562
[00002406] 6000 fe5c                 bra        _dostat_5
[0000240a] 4287                      clr.l      d7
[0000240c] 1e39 0002 0566            move.b     $00020566,d7
[00002412] 0c47 0012                 cmpi.w     #$0012,d7
[00002416] 6610                      bne.s      _dostat_10
[00002418] 4878 0001                 pea.l      ($00000001).w
[0000241c] 4eb9 0000 332e            jsr        _eat
[00002422] 588f                      addq.l     #4,a7
[00002424] 4a87                      tst.l      d7
[00002426] 660c                      bne.s      _dostat_11
_dostat_10:
[00002428] 7001                      moveq.l    #1,d0
[0000242a] 23c0 0002 055a            move.l     d0,$0002055A
[00002430] 6000 fe32                 bra        _dostat_5
_dostat_11:
[00002434] 4eba f56e                 jsr        _dbstat(pc)
[00002438] 4297                      clr.l      (a7)
[0000243a] 2f39 0002 0d1a            move.l     _lbltab,-(a7)
[00002440] 2f39 0002 0568            move.l     $00020568,-(a7)
[00002446] 4eb9 0000 847e            jsr        _lookup
[0000244c] 508f                      addq.l     #8,a7
[0000244e] 2847                      movea.l    d7,a4
[00002450] 2e0c                      move.l     a4,d7
[00002452] 6624                      bne.s      _dostat_12
[00002454] 4297                      clr.l      (a7)
[00002456] 2f39 0002 0568            move.l     $00020568,-(a7)
[0000245c] 42a7                      clr.l      -(a7)
[0000245e] 4eb9 0000 7a78            jsr        _buysym
[00002464] 508f                      addq.l     #8,a7
[00002466] 2847                      movea.l    d7,a4
[00002468] 2ebc 0002 0d1a            move.l     #_lbltab,(a7)
[0000246e] 2f0c                      move.l     a4,-(a7)
[00002470] 4eb9 0000 774e            jsr        _addsym
[00002476] 588f                      addq.l     #4,a7
_dostat_12:
[00002478] 4a2c 000e                 tst.b      14(a4)
[0000247c] 6712                      beq.s      _dostat_13
[0000247e] 486c 0010                 pea.l      16(a4)
[00002482] 2f3c 0002 065e            move.l     #$0002065E,-(a7) "redefined label"
[00002488] 4eb9 0000 3c8a            jsr        _nmerr
[0000248e] 508f                      addq.l     #8,a7
_dostat_13:
[00002490] 197c 0001 000e            move.b     #$01,14(a4)
[00002496] 4a6c 0008                 tst.w      8(a4)
[0000249a] 660a                      bne.s      _dostat_14
[0000249c] 4eb9 0000 5704            jsr        _crs
[000024a2] 3947 0008                 move.w     d7,8(a4)
_dostat_14:
[000024a6] 3e2c 0008                 move.w     8(a4),d7
[000024aa] 48c7                      ext.l      d7
[000024ac] 2e87                      move.l     d7,(a7)
[000024ae] 4eb9 0000 6036            jsr        _plabel
[000024b4] 6000 fdae                 bra        _dostat_5
[000024b8] 2eae 000c                 move.l     12(a6),(a7)
[000024bc] 2f2e 0008                 move.l     8(a6),-(a7)
[000024c0] 4eba f84e                 jsr        _doblock(pc)
[000024c4] 588f                      addq.l     #4,a7
[000024c6] 2eae fff6                 move.l     -10(a6),(a7)
[000024ca] 2f39 0002 0cea            move.l     _attlist,-(a7)
[000024d0] 4eb9 0000 8332            jsr        _frealst
[000024d6] 588f                      addq.l     #4,a7
[000024d8] 23c7 0002 0cea            move.l     d7,_attlist
[000024de] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000024e2] 4e5e                      unlk       a6
[000024e4] 4e75                      rts

x24e6_1:
[000024e6] 4eba f4bc                 jsr        _dbstat(pc)
[000024ea] 60da                      bra.s      x24e6_1
[000024ec] 4eba f4b6                 jsr        _dbstat(pc)
[000024f0] 4297                      clr.l      (a7)
[000024f2] 4eb9 0000 5704            jsr        _crs
[000024f8] 2f07                      move.l     d7,-(a7)
[000024fa] 4878 0001                 pea.l      ($00000001).w
[000024fe] 4eb9 0000 0c26            jsr        _gtest
[00002504] 588f                      addq.l     #4,a7
[00002506] 2f07                      move.l     d7,-(a7)
[00002508] 4eb9 0000 5cea            jsr        _pjf
[0000250e] 508f                      addq.l     #8,a7
[00002510] 3d47 fffc                 move.w     d7,-4(a6)
[00002514] 2eae 000c                 move.l     12(a6),(a7)
[00002518] 2f2e 0008                 move.l     8(a6),-(a7)
[0000251c] 4eba fd30                 jsr        _dostat(pc)
[00002520] 588f                      addq.l     #4,a7
[00002522] 4878 0029                 pea.l      ($00000029).w
[00002526] 4eb9 0000 332e            jsr        _eat
[0000252c] 588f                      addq.l     #4,a7
[0000252e] 4a87                      tst.l      d7
[00002530] 6728                      beq.s      x24e6_2
[00002532] 3e2e fffc                 move.w     -4(a6),d7
[00002536] 48c7                      ext.l      d7
[00002538] 2e87                      move.l     d7,(a7)
[0000253a] 42a7                      clr.l      -(a7)
[0000253c] 4eb9 0000 5ede            jsr        _pjump
[00002542] 588f                      addq.l     #4,a7
[00002544] 3d47 fffc                 move.w     d7,-4(a6)
[00002548] 4eba f45a                 jsr        _dbstat(pc)
[0000254c] 2eae 000c                 move.l     12(a6),(a7)
[00002550] 2f2e 0008                 move.l     8(a6),-(a7)
[00002554] 4eba fcf8                 jsr        _dostat(pc)
[00002558] 588f                      addq.l     #4,a7
x24e6_2:
[0000255a] 3e2e fffc                 move.w     -4(a6),d7
[0000255e] 48c7                      ext.l      d7
[00002560] 2e87                      move.l     d7,(a7)
[00002562] 4eb9 0000 6036            jsr        _plabel
[00002568] 6000 ff5c                 bra        x24e6_1
[0000256c] 4eb9 0000 5704            jsr        _crs
[00002572] 2e87                      move.l     d7,(a7)
[00002574] 4eb9 0000 6036            jsr        _plabel
[0000257a] 3d47 fffe                 move.w     d7,-2(a6)
[0000257e] 4eba f424                 jsr        _dbstat(pc)
[00002582] 4297                      clr.l      (a7)
[00002584] 4eb9 0000 5704            jsr        _crs
[0000258a] 2f07                      move.l     d7,-(a7)
[0000258c] 4878 0001                 pea.l      ($00000001).w
[00002590] 4eb9 0000 0c26            jsr        _gtest
[00002596] 588f                      addq.l     #4,a7
[00002598] 2f07                      move.l     d7,-(a7)
[0000259a] 4eb9 0000 5cea            jsr        _pjf
[000025a0] 508f                      addq.l     #8,a7
[000025a2] 3d47 fffc                 move.w     d7,-4(a6)
[000025a6] 3e2e fffe                 move.w     -2(a6),d7
[000025aa] 48c7                      ext.l      d7
[000025ac] 2e87                      move.l     d7,(a7)
[000025ae] 3e2e fffc                 move.w     -4(a6),d7
[000025b2] 48c7                      ext.l      d7
[000025b4] 2f07                      move.l     d7,-(a7)
[000025b6] 4eba fc96                 jsr        _dostat(pc)
[000025ba] 588f                      addq.l     #4,a7
[000025bc] 3e2e fffc                 move.w     -4(a6),d7
[000025c0] 48c7                      ext.l      d7
[000025c2] 2e87                      move.l     d7,(a7)
[000025c4] 3e2e fffe                 move.w     -2(a6),d7
[000025c8] 48c7                      ext.l      d7
[000025ca] 2f07                      move.l     d7,-(a7)
[000025cc] 4eb9 0000 5ede            jsr        _pjump
[000025d2] 588f                      addq.l     #4,a7
[000025d4] 6000 fef0                 bra        x24e6_1
[000025d8] 4eb9 0000 5704            jsr        _crs
[000025de] 2e87                      move.l     d7,(a7)
[000025e0] 4eb9 0000 6036            jsr        _plabel
[000025e6] 3d47 fffe                 move.w     d7,-2(a6)
[000025ea] 4eba f3b8                 jsr        _dbstat(pc)
[000025ee] 4eb9 0000 5704            jsr        _crs
[000025f4] 3d47 fffa                 move.w     d7,-6(a6)
[000025f8] 3e2e fffa                 move.w     -6(a6),d7
[000025fc] 48c7                      ext.l      d7
[000025fe] 2e87                      move.l     d7,(a7)
[00002600] 4eb9 0000 5704            jsr        _crs
[00002606] 3d47 fffc                 move.w     d7,-4(a6)
[0000260a] 3e2e fffc                 move.w     -4(a6),d7
[0000260e] 48c7                      ext.l      d7
[00002610] 2f07                      move.l     d7,-(a7)
[00002612] 4eba fc3a                 jsr        _dostat(pc)
[00002616] 588f                      addq.l     #4,a7
[00002618] 3e2e fffa                 move.w     -6(a6),d7
[0000261c] 48c7                      ext.l      d7
[0000261e] 2e87                      move.l     d7,(a7)
[00002620] 4eb9 0000 6036            jsr        _plabel
[00002626] 4878 003a                 pea.l      ($0000003A).w
[0000262a] 4eb9 0000 3c08            jsr        _need
[00002630] 588f                      addq.l     #4,a7
[00002632] 4eba f370                 jsr        _dbstat(pc)
[00002636] 3e2e fffe                 move.w     -2(a6),d7
[0000263a] 48c7                      ext.l      d7
[0000263c] 2e87                      move.l     d7,(a7)
[0000263e] 3e2e fffc                 move.w     -4(a6),d7
[00002642] 48c7                      ext.l      d7
[00002644] 2f07                      move.l     d7,-(a7)
[00002646] 4878 0001                 pea.l      ($00000001).w
[0000264a] 4eb9 0000 0c26            jsr        _gtest
[00002650] 588f                      addq.l     #4,a7
[00002652] 2f07                      move.l     d7,-(a7)
[00002654] 4eb9 0000 5f2e            jsr        _pjt
[0000265a] 508f                      addq.l     #8,a7
[0000265c] 4878 000b                 pea.l      ($0000000B).w
[00002660] 4eb9 0000 3c08            jsr        _need
[00002666] 588f                      addq.l     #4,a7
[00002668] 6000 fe5c                 bra        x24e6_1
[0000266c] 4eba f336                 jsr        _dbstat(pc)
[00002670] 4878 0006                 pea.l      ($00000006).w
[00002674] 4eb9 0000 3c08            jsr        _need
[0000267a] 588f                      addq.l     #4,a7
[0000267c] 4297                      clr.l      (a7)
[0000267e] 4eb9 0000 0ba6            jsr        _gelist
[00002684] 2647                      movea.l    d7,a3
[00002686] 2e0b                      move.l     a3,d7
[00002688] 6708                      beq.s      x24e6_3
[0000268a] 2e8b                      move.l     a3,(a7)
[0000268c] 4eb9 0000 6988            jsr        _pvoid
x24e6_3:
[00002692] 4878 000b                 pea.l      ($0000000B).w
[00002696] 4eb9 0000 3c08            jsr        _need
[0000269c] 588f                      addq.l     #4,a7
[0000269e] 4eb9 0000 5704            jsr        _crs
[000026a4] 2e87                      move.l     d7,(a7)
[000026a6] 4eb9 0000 6036            jsr        _plabel
[000026ac] 3d47 fffe                 move.w     d7,-2(a6)
[000026b0] 4eba f2f2                 jsr        _dbstat(pc)
[000026b4] 4297                      clr.l      (a7)
[000026b6] 4eb9 0000 5704            jsr        _crs
[000026bc] 2f07                      move.l     d7,-(a7)
[000026be] 42a7                      clr.l      -(a7)
[000026c0] 4eb9 0000 0ba6            jsr        _gelist
[000026c6] 588f                      addq.l     #4,a7
[000026c8] 2f07                      move.l     d7,-(a7)
[000026ca] 4eb9 0000 5cea            jsr        _pjf
[000026d0] 508f                      addq.l     #8,a7
[000026d2] 3d47 fffc                 move.w     d7,-4(a6)
[000026d6] 4878 000b                 pea.l      ($0000000B).w
[000026da] 4eb9 0000 3c08            jsr        _need
[000026e0] 588f                      addq.l     #4,a7
[000026e2] 4eba f2c0                 jsr        _dbstat(pc)
[000026e6] 4297                      clr.l      (a7)
[000026e8] 4eb9 0000 0ba6            jsr        _gelist
[000026ee] 2647                      movea.l    d7,a3
[000026f0] 2e0b                      move.l     a3,d7
[000026f2] 674c                      beq.s      x24e6_4
[000026f4] 4eb9 0000 5704            jsr        _crs
[000026fa] 33c7 0002 0564            move.w     d7,$00020564
[00002700] 3e39 0002 0564            move.w     $00020564,d7
[00002706] 48c7                      ext.l      d7
[00002708] 2e87                      move.l     d7,(a7)
[0000270a] 42a7                      clr.l      -(a7)
[0000270c] 4eb9 0000 5ede            jsr        _pjump
[00002712] 588f                      addq.l     #4,a7
[00002714] 3d47 fffa                 move.w     d7,-6(a6)
[00002718] 2e8b                      move.l     a3,(a7)
[0000271a] 4eb9 0000 6988            jsr        _pvoid
[00002720] 3e2e fffa                 move.w     -6(a6),d7
[00002724] 48c7                      ext.l      d7
[00002726] 2e87                      move.l     d7,(a7)
[00002728] 3e2e fffe                 move.w     -2(a6),d7
[0000272c] 48c7                      ext.l      d7
[0000272e] 2f07                      move.l     d7,-(a7)
[00002730] 4eb9 0000 5ede            jsr        _pjump
[00002736] 588f                      addq.l     #4,a7
[00002738] 3d79 0002 0564 fffe       move.w     $00020564,-2(a6)
x24e6_4:
[00002740] 4878 000a                 pea.l      ($0000000A).w
[00002744] 4eb9 0000 3c08            jsr        _need
[0000274a] 588f                      addq.l     #4,a7
[0000274c] 3e2e fffe                 move.w     -2(a6),d7
[00002750] 48c7                      ext.l      d7
[00002752] 2e87                      move.l     d7,(a7)
[00002754] 3e2e fffc                 move.w     -4(a6),d7
[00002758] 48c7                      ext.l      d7
[0000275a] 2f07                      move.l     d7,-(a7)
[0000275c] 4eba faf0                 jsr        _dostat(pc)
[00002760] 588f                      addq.l     #4,a7
[00002762] 3e2e fffc                 move.w     -4(a6),d7
[00002766] 48c7                      ext.l      d7
[00002768] 2e87                      move.l     d7,(a7)
[0000276a] 3e2e fffe                 move.w     -2(a6),d7
[0000276e] 48c7                      ext.l      d7
[00002770] 2f07                      move.l     d7,-(a7)
[00002772] 4eb9 0000 5ede            jsr        _pjump
[00002778] 588f                      addq.l     #4,a7
[0000277a] 6000 fd4a                 bra        x24e6_1
[0000277e] 4eba f224                 jsr        _dbstat(pc)
[00002782] 4aae 0008                 tst.l      8(a6)
[00002786] 6710                      beq.s      x24e6_5
[00002788] 4297                      clr.l      (a7)
[0000278a] 2f2e 0008                 move.l     8(a6),-(a7)
[0000278e] 4eb9 0000 5ede            jsr        _pjump
[00002794] 588f                      addq.l     #4,a7
[00002796] 600c                      bra.s      x24e6_6
x24e6_5:
[00002798] 2ebc 0002 0650            move.l     #$00020650,(a7) "illegal break"
[0000279e] 4eb9 0000 3e84            jsr        _p1error
x24e6_6:
[000027a4] 4878 000b                 pea.l      ($0000000B).w
[000027a8] 4eb9 0000 3c08            jsr        _need
[000027ae] 588f                      addq.l     #4,a7
[000027b0] 6000 fd14                 bra        x24e6_1
[000027b4] 4eba f1ee                 jsr        _dbstat(pc)
[000027b8] 4aae 000c                 tst.l      12(a6)
[000027bc] 6710                      beq.s      x24e6_7
[000027be] 4297                      clr.l      (a7)
[000027c0] 2f2e 000c                 move.l     12(a6),-(a7)
[000027c4] 4eb9 0000 5ede            jsr        _pjump
[000027ca] 588f                      addq.l     #4,a7
[000027cc] 600c                      bra.s      x24e6_8
x24e6_7:
[000027ce] 2ebc 0002 063f            move.l     #$0002063F,(a7) "illegal continue"
[000027d4] 4eb9 0000 3e84            jsr        _p1error
x24e6_8:
[000027da] 4878 000b                 pea.l      ($0000000B).w
[000027de] 4eb9 0000 3c08            jsr        _need
[000027e4] 588f                      addq.l     #4,a7
[000027e6] 6000 fcde                 bra        x24e6_1
[000027ea] 4eba f1b8                 jsr        _dbstat(pc)
[000027ee] 4297                      clr.l      (a7)
[000027f0] 4eb9 0000 0ba6            jsr        _gelist
[000027f6] 2647                      movea.l    d7,a3
[000027f8] 2e0b                      move.l     a3,d7
[000027fa] 6722                      beq.s      x24e6_9
[000027fc] 2e8b                      move.l     a3,(a7)
[000027fe] 2f39 0002 04ce            move.l     $000204CE,-(a7)
[00002804] 4eb9 0000 86a8            jsr        _canass
[0000280a] 588f                      addq.l     #4,a7
[0000280c] 4a87                      tst.l      d7
[0000280e] 6624                      bne.s      x24e6_10
[00002810] 2ebc 0002 062b            move.l     #$0002062B,(a7) "illegal return type"
[00002816] 4eb9 0000 3e84            jsr        _p1error
[0000281c] 603e                      bra.s      x24e6_11
x24e6_9:
[0000281e] 4eb9 0000 612e            jsr        _pret
[00002824] 4878 000b                 pea.l      ($0000000B).w
[00002828] 4eb9 0000 3c08            jsr        _need
[0000282e] 588f                      addq.l     #4,a7
[00002830] 6000 fc94                 bra        x24e6_1
x24e6_10:
[00002834] 2e39 0002 04ae            move.l     _rat,d7
[0000283a] beb9 0002 04ce            cmp.l      $000204CE,d7
[00002840] 671a                      beq.s      x24e6_11
[00002842] 2eb9 0002 04ce            move.l     $000204CE,(a7)
[00002848] 42a7                      clr.l      -(a7)
[0000284a] 2f0b                      move.l     a3,-(a7)
[0000284c] 4878 0066                 pea.l      ($00000066).w
[00002850] 4eb9 0000 7a0e            jsr        _buyop
[00002856] 4fef 000c                 lea.l      12(a7),a7
[0000285a] 2647                      movea.l    d7,a3
x24e6_11:
[0000285c] 2e8b                      move.l     a3,(a7)
[0000285e] 2f3c 0002 04ca            move.l     #_rterm,-(a7)
[00002864] 4eb9 0000 607c            jsr        _pmove
[0000286a] 588f                      addq.l     #4,a7
[0000286c] 60b0                      bra.s      x24e6_9
[0000286e] 4eba f134                 jsr        _dbstat(pc)
[00002872] 2ebc 0002 0566            move.l     #$00020566,(a7)
[00002878] 4eb9 0000 3bae            jsr        _ident
[0000287e] 4a87                      tst.l      d7
[00002880] 660e                      bne.s      x24e6_12
[00002882] 2ebc 0002 0618            move.l     #$00020618,(a7) "missing goto label"
[00002888] 4eb9 0000 3e84            jsr        _p1error
[0000288e] 6064                      bra.s      x24e6_13
x24e6_12:
[00002890] 4297                      clr.l      (a7)
[00002892] 2f39 0002 0d1a            move.l     _lbltab,-(a7)
[00002898] 2f39 0002 0568            move.l     $00020568,-(a7)
[0000289e] 4eb9 0000 847e            jsr        _lookup
[000028a4] 508f                      addq.l     #8,a7
[000028a6] 2847                      movea.l    d7,a4
[000028a8] 2e0c                      move.l     a4,d7
[000028aa] 6714                      beq.s      x24e6_14
[000028ac] 4297                      clr.l      (a7)
[000028ae] 3e2c 0008                 move.w     8(a4),d7
[000028b2] 48c7                      ext.l      d7
[000028b4] 2f07                      move.l     d7,-(a7)
[000028b6] 4eb9 0000 5ede            jsr        _pjump
[000028bc] 588f                      addq.l     #4,a7
[000028be] 6034                      bra.s      x24e6_13
x24e6_14:
[000028c0] 4297                      clr.l      (a7)
[000028c2] 2f39 0002 0568            move.l     $00020568,-(a7)
[000028c8] 42a7                      clr.l      -(a7)
[000028ca] 4eb9 0000 7a78            jsr        _buysym
[000028d0] 508f                      addq.l     #8,a7
[000028d2] 2847                      movea.l    d7,a4
[000028d4] 2ebc 0002 0d1a            move.l     #_lbltab,(a7)
[000028da] 2f0c                      move.l     a4,-(a7)
[000028dc] 4eb9 0000 774e            jsr        _addsym
[000028e2] 588f                      addq.l     #4,a7
[000028e4] 4297                      clr.l      (a7)
[000028e6] 42a7                      clr.l      -(a7)
[000028e8] 4eb9 0000 5ede            jsr        _pjump
[000028ee] 588f                      addq.l     #4,a7
[000028f0] 3947 0008                 move.w     d7,8(a4)
x24e6_13:
[000028f4] 4878 000b                 pea.l      ($0000000B).w
[000028f8] 4eb9 0000 3c08            jsr        _need
[000028fe] 588f                      addq.l     #4,a7
[00002900] 6000 fbc4                 bra        x24e6_1
[00002904] 4eba f09e                 jsr        _dbstat(pc)
[00002908] 2a79 0002 055e            movea.l    $0002055E,a5
[0000290e] 42b9 0002 055e            clr.l      $0002055E
[00002914] 3d79 0002 0562 fffe       move.w     $00020562,-2(a6)
[0000291c] 4279 0002 0562            clr.w      $00020562
[00002922] 2879 0002 0556            movea.l    $00020556,a4
[00002928] 4878 0001                 pea.l      ($00000001).w
[0000292c] 4eb9 0000 0c26            jsr        _gtest
[00002932] 588f                      addq.l     #4,a7
[00002934] 2647                      movea.l    d7,a3
[00002936] 2eab 0004                 move.l     4(a3),(a7)
[0000293a] 4eb9 0000 84da            jsr        _maxify
[00002940] 23c7 0002 04b6            move.l     d7,$000204B6
[00002946] 4878 0001                 pea.l      ($00000001).w
[0000294a] 42a7                      clr.l      -(a7)
[0000294c] 42a7                      clr.l      -(a7)
[0000294e] 42a7                      clr.l      -(a7)
[00002950] 2f3c 0002 04b2            move.l     #_caseterm,-(a7)
[00002956] 4eb9 0000 85aa            jsr        _setad
[0000295c] 4fef 0014                 lea.l      20(a7),a7
[00002960] 2eab 0004                 move.l     4(a3),(a7)
[00002964] 4eb9 0000 844a            jsr        _itype
[0000296a] 4a87                      tst.l      d7
[0000296c] 6618                      bne.s      x24e6_15
[0000296e] 23fc 0002 0dc2 0002 04b6  move.l     #_atint,$000204B6
[00002978] 2ebc 0002 05fe            move.l     #$000205FE,(a7) "illegal switch expression"
[0000297e] 4eb9 0000 3e84            jsr        _p1error
[00002984] 6030                      bra.s      x24e6_16
x24e6_15:
[00002986] 4ab9 0002 0b7e            tst.l      _lflag
[0000298c] 6628                      bne.s      x24e6_16
[0000298e] 2479 0002 04b6            movea.l    $000204B6,a2
[00002994] 508a                      addq.l     #8,a2
[00002996] 4287                      clr.l      d7
[00002998] 1e12                      move.b     (a2),d7
[0000299a] 0c47 0020                 cmpi.w     #$0020,d7
[0000299e] 6700 00e6                 beq        x24e6_17
[000029a2] 2479 0002 04b6            movea.l    $000204B6,a2
[000029a8] 508a                      addq.l     #8,a2
[000029aa] 4287                      clr.l      d7
[000029ac] 1e12                      move.b     (a2),d7
[000029ae] 0c47 0021                 cmpi.w     #$0021,d7
[000029b2] 6700 00d2                 beq        x24e6_17
x24e6_16:
[000029b6] 23f9 0002 04b6 0002 0556  move.l     $000204B6,$00020556
[000029c0] 2e8b                      move.l     a3,(a7)
[000029c2] 2f3c 0002 04b2            move.l     #_caseterm,-(a7)
[000029c8] 4eb9 0000 607c            jsr        _pmove
[000029ce] 588f                      addq.l     #4,a7
[000029d0] 4878 0001                 pea.l      ($00000001).w
[000029d4] 2f39 0002 0556            move.l     $00020556,-(a7)
[000029da] 4eb9 0000 7b74            jsr        _bytes
[000029e0] 508f                      addq.l     #8,a7
[000029e2] 2e87                      move.l     d7,(a7)
[000029e4] 4eb9 0000 5704            jsr        _crs
[000029ea] 3d47 fffa                 move.w     d7,-6(a6)
[000029ee] 3e2e fffa                 move.w     -6(a6),d7
[000029f2] 48c7                      ext.l      d7
[000029f4] 2f07                      move.l     d7,-(a7)
[000029f6] 4eb9 0000 624a            jsr        _pswitch
[000029fc] 588f                      addq.l     #4,a7
[000029fe] 2eae 000c                 move.l     12(a6),(a7)
[00002a02] 4eb9 0000 5704            jsr        _crs
[00002a08] 3d47 fffc                 move.w     d7,-4(a6)
[00002a0c] 3e2e fffc                 move.w     -4(a6),d7
[00002a10] 48c7                      ext.l      d7
[00002a12] 2f07                      move.l     d7,-(a7)
[00002a14] 4eba f838                 jsr        _dostat(pc)
[00002a18] 588f                      addq.l     #4,a7
[00002a1a] 3e2e fffa                 move.w     -6(a6),d7
[00002a1e] 48c7                      ext.l      d7
[00002a20] 2e87                      move.l     d7,(a7)
[00002a22] 4a79 0002 0562            tst.w      $00020562
[00002a28] 670a                      beq.s      x24e6_18
[00002a2a] 3e39 0002 0562            move.w     $00020562,d7
[00002a30] 48c7                      ext.l      d7
[00002a32] 6006                      bra.s      x24e6_19
x24e6_18:
[00002a34] 3e2e fffc                 move.w     -4(a6),d7
[00002a38] 48c7                      ext.l      d7
x24e6_19:
[00002a3a] 2f07                      move.l     d7,-(a7)
[00002a3c] 4878 0001                 pea.l      ($00000001).w
[00002a40] 2f39 0002 0556            move.l     $00020556,-(a7)
[00002a46] 4eb9 0000 7b74            jsr        _bytes
[00002a4c] 508f                      addq.l     #8,a7
[00002a4e] 2f07                      move.l     d7,-(a7)
[00002a50] 2f39 0002 055e            move.l     $0002055E,-(a7)
[00002a56] 4eb9 0000 6294            jsr        _pswtab
[00002a5c] 4fef 000c                 lea.l      12(a7),a7
[00002a60] 3e2e fffc                 move.w     -4(a6),d7
[00002a64] 48c7                      ext.l      d7
[00002a66] 2e87                      move.l     d7,(a7)
[00002a68] 4eb9 0000 59d4            jsr        _pcase
[00002a6e] 23cc 0002 0556            move.l     a4,$00020556
[00002a74] 33ee fffe 0002 0562       move.w     -2(a6),$00020562
[00002a7c] 23cd 0002 055e            move.l     a5,$0002055E
[00002a82] 6000 fa42                 bra        x24e6_1
x24e6_17:
[00002a86] 13fc 0003 0002 04c6       move.b     #$03,$000204C6
[00002a8e] 6000 ff26                 bra        x24e6_16
[00002a92] 2ebc 0002 0566            move.l     #$00020566,(a7)
[00002a98] 4eb9 0000 31e4            jsr        _baktok1
[00002a9e] 4eba ef04                 jsr        _dbstat(pc)
[00002aa2] 4297                      clr.l      (a7)
[00002aa4] 4eb9 0000 0ba6            jsr        _gelist
[00002aaa] 2647                      movea.l    d7,a3
[00002aac] 2e0b                      move.l     a3,d7
[00002aae] 6718                      beq.s      x24e6_20
[00002ab0] 2e8b                      move.l     a3,(a7)
[00002ab2] 4eb9 0000 6988            jsr        _pvoid
[00002ab8] 4878 000b                 pea.l      ($0000000B).w
[00002abc] 4eb9 0000 3c08            jsr        _need
[00002ac2] 588f                      addq.l     #4,a7
[00002ac4] 6000 fa00                 bra        x24e6_1
x24e6_20:
[00002ac8] 4878 0009                 pea.l      ($00000009).w
[00002acc] 2f3c 0002 05ec            move.l     #$000205EC,-(a7)
[00002ad2] 4eb9 0000 3f28            jsr        _recover
[00002ad8] 508f                      addq.l     #8,a7
[00002ada] 6000 f9ea                 bra        x24e6_1

_fninit:
[00002ade] 4e56 ffb8                 link       a6,#-72
[00002ae2] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00002ae6] 2a6e 0008                 movea.l    8(a6),a5
[00002aea] 4287                      clr.l      d7
[00002aec] 1e2d 000e                 move.b     14(a5),d7
[00002af0] 0c47 0034                 cmpi.w     #$0034,d7
[00002af4] 6610                      bne.s      _fninit_1
[00002af6] 4a6d 0008                 tst.w      8(a5)
[00002afa] 660a                      bne.s      _fninit_1
[00002afc] 4eb9 0000 5704            jsr        _crs
[00002b02] 3b47 0008                 move.w     d7,8(a5)
_fninit_1:
[00002b06] 42ae fffc                 clr.l      -4(a6)
[00002b0a] 45f8 000a                 lea.l      ($0000000A).w,a2
[00002b0e] d5ed 0004                 adda.l     4(a5),a2
[00002b12] 2d52 fff0                 move.l     (a2),-16(a6)
[00002b16] 23f9 0002 0d2e 0002 0d16  move.l     _symtab,_gblsym
[00002b20] 23f9 0002 0d2e 0002 0d2a  move.l     _symtab,_symend
[00002b2a] 23f9 0002 0cea 0002 0cee  move.l     _attlist,_gblat
[00002b34] 4aae fff0                 tst.l      -16(a6)
[00002b38] 6762                      beq.s      _fninit_2
[00002b3a] 7001                      moveq.l    #1,d0
[00002b3c] 2d40 fffc                 move.l     d0,-4(a6)
_fninit_8:
[00002b40] 4297                      clr.l      (a7)
[00002b42] 4878 0031                 pea.l      ($00000031).w
[00002b46] 4878 003b                 pea.l      ($0000003B).w
[00002b4a] 486e ffda                 pea.l      -38(a6)
[00002b4e] 4eb9 0000 4d4c            jsr        _gscty
[00002b54] 4fef 000c                 lea.l      12(a7),a7
[00002b58] 4a87                      tst.l      d7
[00002b5a] 6740                      beq.s      _fninit_2
_fninit_9:
[00002b5c] 4297                      clr.l      (a7)
[00002b5e] 486e ffda                 pea.l      -38(a6)
[00002b62] 4eb9 0000 4b1e            jsr        _gdecl
[00002b68] 588f                      addq.l     #4,a7
[00002b6a] 2847                      movea.l    d7,a4
[00002b6c] 2e0c                      move.l     a4,d7
[00002b6e] 6740                      beq.s      _fninit_3
[00002b70] 4297                      clr.l      (a7)
[00002b72] 2f2e fff0                 move.l     -16(a6),-(a7)
[00002b76] 486c 0010                 pea.l      16(a4)
[00002b7a] 4eb9 0000 847e            jsr        _lookup
[00002b80] 508f                      addq.l     #8,a7
[00002b82] 2647                      movea.l    d7,a3
[00002b84] 2e0b                      move.l     a3,d7
[00002b86] 6644                      bne.s      _fninit_4
[00002b88] 486c 0010                 pea.l      16(a4)
[00002b8c] 2f3c 0002 0757            move.l     #$00020757,-(a7) "not an argument"
[00002b92] 4eb9 0000 3c8a            jsr        _nmerr
[00002b98] 508f                      addq.l     #8,a7
[00002b9a] 605c                      bra.s      _fninit_5
_fninit_2:
[00002b9c] 4aae fffc                 tst.l      -4(a6)
[00002ba0] 6768                      beq.s      _fninit_6
[00002ba2] 4878 0005                 pea.l      ($00000005).w
[00002ba6] 4eb9 0000 3c08            jsr        _need
[00002bac] 588f                      addq.l     #4,a7
[00002bae] 6070                      bra.s      _fninit_7
_fninit_3:
[00002bb0] 4878 000b                 pea.l      ($0000000B).w
[00002bb4] 4eb9 0000 3c08            jsr        _need
[00002bba] 588f                      addq.l     #4,a7
[00002bbc] 6082                      bra.s      _fninit_8
_fninit_11:
[00002bbe] 4297                      clr.l      (a7)
[00002bc0] 2f0c                      move.l     a4,-(a7)
[00002bc2] 4eb9 0000 aa76            jsr        _free
[00002bc8] 588f                      addq.l     #4,a7
[00002bca] 6090                      bra.s      _fninit_9
_fninit_4:
[00002bcc] 4a2b 000e                 tst.b      14(a3)
[00002bd0] 6714                      beq.s      _fninit_10
[00002bd2] 486c 0010                 pea.l      16(a4)
[00002bd6] 2f3c 0002 0743            move.l     #$00020743,-(a7) "redeclared argument"
[00002bdc] 4eb9 0000 3c8a            jsr        _nmerr
[00002be2] 508f                      addq.l     #8,a7
[00002be4] 6012                      bra.s      _fninit_5
_fninit_10:
[00002be6] 176c 000e 000e            move.b     14(a4),14(a3)
[00002bec] 276c 0004 0004            move.l     4(a4),4(a3)
[00002bf2] 376c 000c 000c            move.w     12(a4),12(a3)
_fninit_5:
[00002bf8] 4878 0002                 pea.l      ($00000002).w
[00002bfc] 4eb9 0000 332e            jsr        _eat
[00002c02] 588f                      addq.l     #4,a7
[00002c04] 4a87                      tst.l      d7
[00002c06] 66b6                      bne.s      _fninit_11
[00002c08] 60a6                      bra.s      _fninit_3
_fninit_6:
[00002c0a] 4878 0005                 pea.l      ($00000005).w
[00002c0e] 4eb9 0000 332e            jsr        _eat
[00002c14] 588f                      addq.l     #4,a7
[00002c16] 4a87                      tst.l      d7
[00002c18] 6706                      beq.s      _fninit_7
[00002c1a] 7001                      moveq.l    #1,d0
[00002c1c] 2d40 fffc                 move.l     d0,-4(a6)
_fninit_7:
[00002c20] 4aae fffc                 tst.l      -4(a6)
[00002c24] 675c                      beq.s      _fninit_12
[00002c26] 4aae fff0                 tst.l      -16(a6)
[00002c2a] 6656                      bne.s      _fninit_12
[00002c2c] 45f8 000e                 lea.l      ($0000000E).w,a2
[00002c30] d5ed 0004                 adda.l     4(a5),a2
[00002c34] 2d52 ffec                 move.l     (a2),-20(a6)
[00002c38] 6748                      beq.s      _fninit_12
[00002c3a] 246e ffec                 movea.l    -20(a6),a2
[00002c3e] 588a                      addq.l     #4,a2
[00002c40] 2452                      movea.l    (a2),a2
[00002c42] 508a                      addq.l     #8,a2
[00002c44] 4287                      clr.l      d7
[00002c46] 1e12                      move.b     (a2),d7
[00002c48] 0c47 0050                 cmpi.w     #$0050,d7
[00002c4c] 6734                      beq.s      _fninit_12
[00002c4e] 45ee fff0                 lea.l      -16(a6),a2
[00002c52] 2d4a ffd6                 move.l     a2,-42(a6)
_fninit_16:
[00002c56] 4aae ffec                 tst.l      -20(a6)
[00002c5a] 6726                      beq.s      _fninit_12
[00002c5c] 2e2e ffec                 move.l     -20(a6),d7
[00002c60] 0c87 0002 0cf2            cmpi.l     #_badsym,d7
[00002c66] 671a                      beq.s      _fninit_12
[00002c68] 45f8 0010                 lea.l      ($00000010).w,a2
[00002c6c] d5ee ffec                 adda.l     -20(a6),a2
[00002c70] 4a12                      tst.b      (a2)
[00002c72] 6628                      bne.s      _fninit_13
[00002c74] 2ebc 0002 0721            move.l     #$00020721,(a7) "bad function argument declaration"
[00002c7a] 4eb9 0000 3e84            jsr        _p1error
[00002c80] 601a                      bra.s      _fninit_13
_fninit_12:
[00002c82] 4aae fffc                 tst.l      -4(a6)
[00002c86] 665a                      bne.s      _fninit_14
[00002c88] 4287                      clr.l      d7
[00002c8a] 1e2d 000e                 move.b     14(a5),d7
[00002c8e] 0c47 003e                 cmpi.w     #$003E,d7
[00002c92] 667a                      bne.s      _fninit_15
[00002c94] 1b7c 002a 000e            move.b     #$2A,14(a5)
[00002c9a] 6072                      bra.s      _fninit_15
_fninit_13:
[00002c9c] 246e ffd6                 movea.l    -42(a6),a2
[00002ca0] 2e8a                      move.l     a2,(a7)
[00002ca2] 45f8 000e                 lea.l      ($0000000E).w,a2
[00002ca6] d5ee ffec                 adda.l     -20(a6),a2
[00002caa] 4287                      clr.l      d7
[00002cac] 1e12                      move.b     (a2),d7
[00002cae] 2f07                      move.l     d7,-(a7)
[00002cb0] 7e10                      moveq.l    #16,d7
[00002cb2] deae ffec                 add.l      -20(a6),d7
[00002cb6] 2f07                      move.l     d7,-(a7)
[00002cb8] 246e ffec                 movea.l    -20(a6),a2
[00002cbc] 588a                      addq.l     #4,a2
[00002cbe] 2f12                      move.l     (a2),-(a7)
[00002cc0] 4eb9 0000 7a78            jsr        _buysym
[00002cc6] 4fef 000c                 lea.l      12(a7),a7
[00002cca] 2257                      movea.l    (a7),a1
[00002ccc] 2287                      move.l     d7,(a1)
[00002cce] 246e ffd6                 movea.l    -42(a6),a2
[00002cd2] 2d52 ffd6                 move.l     (a2),-42(a6)
[00002cd6] 246e ffec                 movea.l    -20(a6),a2
[00002cda] 2d52 ffec                 move.l     (a2),-20(a6)
[00002cde] 6000 ff76                 bra        _fninit_16
_fninit_14:
[00002ce2] 4287                      clr.l      d7
[00002ce4] 1e2d 000e                 move.b     14(a5),d7
[00002ce8] 0c47 003c                 cmpi.w     #$003C,d7
[00002cec] 670e                      beq.s      _fninit_17
[00002cee] 4287                      clr.l      d7
[00002cf0] 1e2d 000e                 move.b     14(a5),d7
[00002cf4] 0c47 003d                 cmpi.w     #$003D,d7
[00002cf8] 6600 00f4                 bne        _fninit_18
_fninit_17:
[00002cfc] 486d 0010                 pea.l      16(a5)
[00002d00] 2f3c 0002 070e            move.l     #$0002070E,-(a7) "function redefined"
[00002d06] 4eb9 0000 3c8a            jsr        _nmerr
[00002d0c] 508f                      addq.l     #8,a7
_fninit_15:
[00002d0e] 246d 0004                 movea.l    4(a5),a2
[00002d12] 588a                      addq.l     #4,a2
[00002d14] 23d2 0002 04ae            move.l     (a2),_rat
[00002d1a] 2eb9 0002 04ae            move.l     _rat,(a7)
[00002d20] 4eb9 0000 84da            jsr        _maxify
[00002d26] 23c7 0002 04ce            move.l     d7,$000204CE
[00002d2c] 2ebc 0002 04ca            move.l     #_rterm,(a7)
[00002d32] 4eb9 0000 8cb6            jsr        _scalify
[00002d38] 4ab9 0002 0b8a            tst.l      _oldflag
[00002d3e] 6604                      bne.s      _fninit_19
[00002d40] 7e01                      moveq.l    #1,d7
[00002d42] 602a                      bra.s      _fninit_20
_fninit_19:
[00002d44] 2479 0002 04ce            movea.l    $000204CE,a2
[00002d4a] 508a                      addq.l     #8,a2
[00002d4c] 4287                      clr.l      d7
[00002d4e] 1e12                      move.b     (a2),d7
[00002d50] 2e87                      move.l     d7,(a7)
[00002d52] 2f3c 0002 14e6            move.l     #_typtab,-(a7)
[00002d58] 4eb9 0000 a7a6            jsr        _scnstr
[00002d5e] 588f                      addq.l     #4,a7
[00002d60] 2447                      movea.l    d7,a2
[00002d62] d5fc 0002 155f            adda.l     #_rettab,a2
[00002d68] 1e12                      move.b     (a2),d7
[00002d6a] 4887                      ext.w      d7
[00002d6c] 48c7                      ext.l      d7
_fninit_20:
[00002d6e] 2e87                      move.l     d7,(a7)
[00002d70] 42a7                      clr.l      -(a7)
[00002d72] 42a7                      clr.l      -(a7)
[00002d74] 42a7                      clr.l      -(a7)
[00002d76] 2f3c 0002 04ca            move.l     #_rterm,-(a7)
[00002d7c] 4eb9 0000 85aa            jsr        _setad
[00002d82] 4fef 0010                 lea.l      16(a7),a7
[00002d86] 4aae fffc                 tst.l      -4(a6)
[00002d8a] 6700 0092                 beq        _fninit_21
[00002d8e] 33f9 0002 0b64 0002 04a0  move.w     _iregs,_regset
[00002d98] 42b9 0002 04a2            clr.l      _autoff
[00002d9e] 42ae fff4                 clr.l      -12(a6)
[00002da2] 2d79 0002 0b9e fff8       move.l     _bndef,-8(a6)
[00002daa] 2ebc 0002 0dc2            move.l     #_atint,(a7)
[00002db0] 4eb9 0000 78b4            jsr        _bound
[00002db6] 23c7 0002 0b9e            move.l     d7,_bndef
[00002dbc] 45f8 000e                 lea.l      ($0000000E).w,a2
[00002dc0] d5ed 0004                 adda.l     4(a5),a2
[00002dc4] 2d52 ffec                 move.l     (a2),-20(a6)
[00002dc8] 4aae fff0                 tst.l      -16(a6)
[00002dcc] 665c                      bne.s      _fninit_22
[00002dce] 4aae ffec                 tst.l      -20(a6)
[00002dd2] 6756                      beq.s      _fninit_22
[00002dd4] 246e ffec                 movea.l    -20(a6),a2
[00002dd8] 588a                      addq.l     #4,a2
[00002dda] 2452                      movea.l    (a2),a2
[00002ddc] 508a                      addq.l     #8,a2
[00002dde] 4287                      clr.l      d7
[00002de0] 1e12                      move.b     (a2),d7
[00002de2] 0c47 0050                 cmpi.w     #$0050,d7
[00002de6] 6642                      bne.s      _fninit_22
[00002de8] 42ae ffec                 clr.l      -20(a6)
[00002dec] 603c                      bra.s      _fninit_22
_fninit_18:
[00002dee] 4287                      clr.l      d7
[00002df0] 1e2d 000e                 move.b     14(a5),d7
[00002df4] 0c47 0034                 cmpi.w     #$0034,d7
[00002df8] 6612                      bne.s      _fninit_23
[00002dfa] 1b7c 003d 000e            move.b     #$3D,14(a5)
[00002e00] 2e8d                      move.l     a5,(a7)
[00002e02] 4eb9 0000 5bec            jsr        _pfunc
[00002e08] 6000 ff04                 bra        _fninit_15
_fninit_23:
[00002e0c] 1b7c 003c 000e            move.b     #$3C,14(a5)
[00002e12] 2e8d                      move.l     a5,(a7)
[00002e14] 4eb9 0000 5bec            jsr        _pfunc
[00002e1a] 6000 fef2                 bra        _fninit_15
_fninit_21:
[00002e1e] 2e2e fffc                 move.l     -4(a6),d7
[00002e22] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00002e26] 4e5e                      unlk       a6
[00002e28] 4e75                      rts
_fninit_22:
[00002e2a] 45ee fff0                 lea.l      -16(a6),a2
[00002e2e] 2d4a ffd6                 move.l     a2,-42(a6)
_fninit_38:
[00002e32] 246e ffd6                 movea.l    -42(a6),a2
[00002e36] 2652                      movea.l    (a2),a3
[00002e38] 2e0b                      move.l     a3,d7
[00002e3a] 6722                      beq.s      _fninit_24
[00002e3c] 4a2b 000e                 tst.b      14(a3)
[00002e40] 6634                      bne.s      _fninit_25
[00002e42] 4ab9 0002 0b92            tst.l      _strictfl
[00002e48] 6770                      beq.s      _fninit_26
[00002e4a] 486b 0010                 pea.l      16(a3)
[00002e4e] 2f3c 0002 06fa            move.l     #$000206FA,-(a7) "undeclared argument"
[00002e54] 4eb9 0000 3c8a            jsr        _nmerr
[00002e5a] 508f                      addq.l     #8,a7
[00002e5c] 605c                      bra.s      _fninit_26
_fninit_24:
[00002e5e] 4aae ffec                 tst.l      -20(a6)
[00002e62] 6700 01c4                 beq        _fninit_27
[00002e66] 2ebc 0002 06a8            move.l     #$000206A8,(a7) "proto and arguments don',$27,'t match"
[00002e6c] 4eb9 0000 3e84            jsr        _p1error
[00002e72] 6000 01b4                 bra        _fninit_27
_fninit_25:
[00002e76] 4297                      clr.l      (a7)
[00002e78] 2f0b                      move.l     a3,-(a7)
[00002e7a] 4eb9 0000 8210            jsr        _fixargs
[00002e80] 588f                      addq.l     #4,a7
_fninit_31:
[00002e82] 4aae ffec                 tst.l      -20(a6)
[00002e86] 6756                      beq.s      _fninit_28
[00002e88] 4297                      clr.l      (a7)
[00002e8a] 2f2b 0004                 move.l     4(a3),-(a7)
[00002e8e] 246e ffec                 movea.l    -20(a6),a2
[00002e92] 588a                      addq.l     #4,a2
[00002e94] 2f12                      move.l     (a2),-(a7)
[00002e96] 4eb9 0000 7d40            jsr        _cmptype
[00002e9c] 508f                      addq.l     #8,a7
[00002e9e] 4a87                      tst.l      d7
[00002ea0] 6600 0108                 bne        _fninit_29
[00002ea4] 486b 0010                 pea.l      16(a3)
[00002ea8] 2f3c 0002 06e4            move.l     #$000206E4,-(a7) "illegal argument type"
[00002eae] 4eb9 0000 3c8a            jsr        _nmerr
[00002eb4] 508f                      addq.l     #8,a7
[00002eb6] 6000 011e                 bra        _fninit_30
_fninit_26:
[00002eba] 177c 003b 000e            move.b     #$3B,14(a3)
[00002ec0] 277c 0002 0dc2 0004       move.l     #_atint,4(a3)
[00002ec8] 4878 0018                 pea.l      ($00000018).w
[00002ecc] 4878 003b                 pea.l      ($0000003B).w
[00002ed0] 4eb9 0000 3252            jsr        _defspace
[00002ed6] 508f                      addq.l     #8,a7
[00002ed8] 3747 000c                 move.w     d7,12(a3)
[00002edc] 60a4                      bra.s      _fninit_31
_fninit_28:
[00002ede] 2eae fff4                 move.l     -12(a6),(a7)
[00002ee2] 2f2b 0004                 move.l     4(a3),-(a7)
[00002ee6] 4eb9 0000 7874            jsr        _bndify
[00002eec] 588f                      addq.l     #4,a7
[00002eee] 2747 0008                 move.l     d7,8(a3)
[00002ef2] 4878 0001                 pea.l      ($00000001).w
[00002ef6] 2f2b 0004                 move.l     4(a3),-(a7)
[00002efa] 4eb9 0000 7b74            jsr        _bytes
[00002f00] 508f                      addq.l     #8,a7
[00002f02] deab 0008                 add.l      8(a3),d7
[00002f06] 2d47 fff4                 move.l     d7,-12(a6)
[00002f0a] 4287                      clr.l      d7
[00002f0c] 1e2b 000e                 move.b     14(a3),d7
[00002f10] 0c47 0031                 cmpi.w     #$0031,d7
[00002f14] 6600 0104                 bne        _fninit_32
[00002f18] 2ebc 0002 04a0            move.l     #_regset,(a7)
[00002f1e] 2f2b 0004                 move.l     4(a3),-(a7)
[00002f22] 4eb9 0000 69ae            jsr        _rbuy
[00002f28] 588f                      addq.l     #4,a7
[00002f2a] 1d47 ffb9                 move.b     d7,-71(a6)
[00002f2e] 6700 00ea                 beq        _fninit_32
[00002f32] 4878 0001                 pea.l      ($00000001).w
[00002f36] 4878 00a0                 pea.l      ($000000A0).w
[00002f3a] 2f2b 0008                 move.l     8(a3),-(a7)
[00002f3e] 42a7                      clr.l      -(a7)
[00002f40] 2f2b 0004                 move.l     4(a3),-(a7)
[00002f44] 4eb9 0000 7aec            jsr        _buyterm
[00002f4a] 4fef 0014                 lea.l      20(a7),a7
[00002f4e] 2d47 ffd2                 move.l     d7,-46(a6)
[00002f52] 2d6b 0004 ffbe            move.l     4(a3),-66(a6)
[00002f58] 1e2e ffb9                 move.b     -71(a6),d7
[00002f5c] 4887                      ext.w      d7
[00002f5e] 48c7                      ext.l      d7
[00002f60] 2e87                      move.l     d7,(a7)
[00002f62] 42a7                      clr.l      -(a7)
[00002f64] 42a7                      clr.l      -(a7)
[00002f66] 42a7                      clr.l      -(a7)
[00002f68] 486e ffba                 pea.l      -70(a6)
[00002f6c] 4eb9 0000 85aa            jsr        _setad
[00002f72] 4fef 0010                 lea.l      16(a7),a7
[00002f76] 4287                      clr.l      d7
[00002f78] 3e39 0002 04a0            move.w     _regset,d7
[00002f7e] 2e87                      move.l     d7,(a7)
[00002f80] 4eb9 0000 60fe            jsr        _pregs
[00002f86] 2eb9 0002 04a2            move.l     _autoff,(a7)
[00002f8c] 4eb9 0000 59b0            jsr        _pauto
[00002f92] 2eae ffd2                 move.l     -46(a6),(a7)
[00002f96] 486e ffba                 pea.l      -70(a6)
[00002f9a] 4eb9 0000 607c            jsr        _pmove
[00002fa0] 588f                      addq.l     #4,a7
[00002fa2] 176e ffb9 0008            move.b     -71(a6),8(a3)
[00002fa8] 6076                      bra.s      _fninit_33
_fninit_29:
[00002faa] 246e ffec                 movea.l    -20(a6),a2
[00002fae] 588a                      addq.l     #4,a2
[00002fb0] 2452                      movea.l    (a2),a2
[00002fb2] 508a                      addq.l     #8,a2
[00002fb4] 4287                      clr.l      d7
[00002fb6] 1e12                      move.b     (a2),d7
[00002fb8] 0c47 0050                 cmpi.w     #$0050,d7
[00002fbc] 670c                      beq.s      _fninit_34
[00002fbe] 4a93                      tst.l      (a3)
[00002fc0] 672a                      beq.s      _fninit_35
[00002fc2] 246e ffec                 movea.l    -20(a6),a2
[00002fc6] 4a92                      tst.l      (a2)
[00002fc8] 6622                      bne.s      _fninit_35
_fninit_34:
[00002fca] 2ebc 0002 06c8            move.l     #$000206C8,(a7) "illegal number of arguments"
[00002fd0] 4eb9 0000 3e84            jsr        _p1error
_fninit_30:
[00002fd6] 246e ffec                 movea.l    -20(a6),a2
[00002fda] 4a92                      tst.l      (a2)
[00002fdc] 6728                      beq.s      _fninit_36
[00002fde] 246e ffec                 movea.l    -20(a6),a2
[00002fe2] 2452                      movea.l    (a2),a2
[00002fe4] 588a                      addq.l     #4,a2
[00002fe6] 4a92                      tst.l      (a2)
[00002fe8] 6624                      bne.s      _fninit_37
[00002fea] 601a                      bra.s      _fninit_36
_fninit_35:
[00002fec] 4a93                      tst.l      (a3)
[00002fee] 66e6                      bne.s      _fninit_30
[00002ff0] 246e ffec                 movea.l    -20(a6),a2
[00002ff4] 4a92                      tst.l      (a2)
[00002ff6] 67de                      beq.s      _fninit_30
[00002ff8] 246e ffec                 movea.l    -20(a6),a2
[00002ffc] 2452                      movea.l    (a2),a2
[00002ffe] 588a                      addq.l     #4,a2
[00003000] 4a92                      tst.l      (a2)
[00003002] 67d2                      beq.s      _fninit_30
[00003004] 60c4                      bra.s      _fninit_34
_fninit_36:
[00003006] 42ae ffec                 clr.l      -20(a6)
[0000300a] 6000 fed2                 bra        _fninit_28
_fninit_37:
[0000300e] 246e ffec                 movea.l    -20(a6),a2
[00003012] 2d52 ffec                 move.l     (a2),-20(a6)
[00003016] 6000 fec6                 bra        _fninit_28
_fninit_32:
[0000301a] 177c 003b 000e            move.b     #$3B,14(a3)
_fninit_33:
[00003020] 2d4b ffd6                 move.l     a3,-42(a6)
[00003024] 6000 fe0c                 bra        _fninit_38
_fninit_27:
[00003028] 23ee fff8 0002 0b9e       move.l     -8(a6),_bndef
[00003030] 246e ffd6                 movea.l    -42(a6),a2
[00003034] 24b9 0002 0d2e            move.l     _symtab,(a2)
[0000303a] 23ee fff0 0002 0d2e       move.l     -16(a6),_symtab
[00003042] 45f8 000a                 lea.l      ($0000000A).w,a2
[00003046] d5ed 0004                 adda.l     4(a5),a2
[0000304a] 4292                      clr.l      (a2)
[0000304c] 42b9 0002 0d1a            clr.l      _lbltab
[00003052] 4a79 0002 04aa            tst.w      _dbfulab
[00003058] 671e                      beq.s      _fninit_39
[0000305a] 2ebc 0000 00bb            move.l     #$000000BB,(a7)
[00003060] 4eb9 0000 5a16            jsr        _pcode
[00003066] 4878 0002                 pea.l      ($00000002).w
[0000306a] 2f3c 0002 04aa            move.l     #_dbfulab,-(a7)
[00003070] 4eb9 0000 695c            jsr        _putbytes
[00003076] 508f                      addq.l     #8,a7
_fninit_39:
[00003078] 4297                      clr.l      (a7)
[0000307a] 4878 ffff                 pea.l      ($FFFFFFFF).w
[0000307e] 4eba ec90                 jsr        _doblock(pc)
[00003082] 588f                      addq.l     #4,a7
[00003084] 4eba e91e                 jsr        _dbstat(pc)
[00003088] 4eb9 0000 612e            jsr        _pret
[0000308e] 4a79 0002 04aa            tst.w      _dbfulab
[00003094] 670a                      beq.s      _fninit_40
[00003096] 486d 0010                 pea.l      16(a5)
[0000309a] 4eba e7aa                 jsr        _dbfunc(pc)
[0000309e] 588f                      addq.l     #4,a7
_fninit_40:
[000030a0] 2679 0002 0d1a            movea.l    _lbltab,a3
_fninit_43:
[000030a6] 2e0b                      move.l     a3,d7
[000030a8] 671a                      beq.s      _fninit_41
[000030aa] 4a2b 000e                 tst.b      14(a3)
[000030ae] 661e                      bne.s      _fninit_42
[000030b0] 486b 0010                 pea.l      16(a3)
[000030b4] 2f3c 0002 069a            move.l     #$0002069A,-(a7) "missing label"
[000030ba] 4eb9 0000 3c8a            jsr        _nmerr
[000030c0] 508f                      addq.l     #8,a7
[000030c2] 600a                      bra.s      _fninit_42
_fninit_41:
[000030c4] 4eb9 0000 5b7a            jsr        _pfend
[000030ca] 6000 fd52                 bra        _fninit_21
_fninit_42:
[000030ce] 2e93                      move.l     (a3),(a7)
[000030d0] 2f0b                      move.l     a3,-(a7)
[000030d2] 4eb9 0000 aa76            jsr        _free
[000030d8] 588f                      addq.l     #4,a7
[000030da] 2647                      movea.l    d7,a3
[000030dc] 60c8                      bra.s      _fninit_43

_perc:
[000030de] 4e56 0000                 link       a6,#0
[000030e2] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[000030e6] 2a6e 0008                 movea.l    8(a6),a5
[000030ea] 2679 0002 0d2e            movea.l    _symtab,a3
[000030f0] 23cd 0002 0d2e            move.l     a5,_symtab
_perc_5:
[000030f6] b7cd                      cmpa.l     a5,a3
[000030f8] 6744                      beq.s      _perc_1
[000030fa] 4ab9 0002 0b72            tst.l      _deadflag
[00003100] 6744                      beq.s      _perc_2
[00003102] 4a2b 000f                 tst.b      15(a3)
[00003106] 663e                      bne.s      _perc_2
[00003108] 4a2b 0010                 tst.b      16(a3)
[0000310c] 6738                      beq.s      _perc_2
[0000310e] 486b 0010                 pea.l      16(a3)
[00003112] 4eb9 0000 7f98            jsr        _deadname
[00003118] 588f                      addq.l     #4,a7
[0000311a] 4a87                      tst.l      d7
[0000311c] 6628                      bne.s      _perc_2
[0000311e] 4287                      clr.l      d7
[00003120] 1e2b 000e                 move.b     14(a3),d7
[00003124] 0c47 0037                 cmpi.w     #$0037,d7
[00003128] 671c                      beq.s      _perc_2
[0000312a] 486b 0010                 pea.l      16(a3)
[0000312e] 2f3c 0002 0768            move.l     #$00020768,-(a7) "unused local symbol"
[00003134] 4eb9 0000 3c8a            jsr        _nmerr
[0000313a] 508f                      addq.l     #8,a7
[0000313c] 6008                      bra.s      _perc_2
_perc_1:
[0000313e] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00003142] 4e5e                      unlk       a6
[00003144] 4e75                      rts
_perc_2:
[00003146] 4287                      clr.l      d7
[00003148] 1e2b 000e                 move.b     14(a3),d7
[0000314c] 0c47 002a                 cmpi.w     #$002A,d7
[00003150] 670c                      beq.s      _perc_3
[00003152] 4287                      clr.l      d7
[00003154] 1e2b 000e                 move.b     14(a3),d7
[00003158] 0c47 0034                 cmpi.w     #$0034,d7
[0000315c] 6624                      bne.s      _perc_4
_perc_3:
[0000315e] 4297                      clr.l      (a7)
[00003160] 2f39 0002 0d16            move.l     _gblsym,-(a7)
[00003166] 486b 0010                 pea.l      16(a3)
[0000316a] 4eb9 0000 847e            jsr        _lookup
[00003170] 508f                      addq.l     #8,a7
[00003172] 2847                      movea.l    d7,a4
[00003174] 2e0c                      move.l     a4,d7
[00003176] 670a                      beq.s      _perc_4
[00003178] 4287                      clr.l      d7
[0000317a] 1e2b 000f                 move.b     15(a3),d7
[0000317e] 8f2c 000f                 or.b       d7,15(a4)
_perc_4:
[00003182] 2e93                      move.l     (a3),(a7)
[00003184] 2f0b                      move.l     a3,-(a7)
[00003186] 4eba e84a                 jsr        _dbvar(pc)
[0000318a] 588f                      addq.l     #4,a7
[0000318c] 2647                      movea.l    d7,a3
[0000318e] 6000 ff66                 bra        _perc_5

_alt:
[00003192] 4e56 fffa                 link       a6,#-6
[00003196] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[0000319a] 2a6e 0008                 movea.l    8(a6),a5
[0000319e] 486e fffa                 pea.l      -6(a6)
[000031a2] 4eb9 0000 34e6            jsr        _gettok1
[000031a8] 588f                      addq.l     #4,a7
[000031aa] 2447                      movea.l    d7,a2
[000031ac] 4287                      clr.l      d7
[000031ae] 1e12                      move.b     (a2),d7
[000031b0] 2e87                      move.l     d7,(a7)
[000031b2] 2f0d                      move.l     a5,-(a7)
[000031b4] 4eb9 0000 a7a6            jsr        _scnstr
[000031ba] 588f                      addq.l     #4,a7
[000031bc] 2447                      movea.l    d7,a2
[000031be] d5cd                      adda.l     a5,a2
[000031c0] 1a12                      move.b     (a2),d5
[000031c2] 4885                      ext.w      d5
[000031c4] 48c5                      ext.l      d5
[000031c6] 660c                      bne.s      _alt_1
[000031c8] 486e fffa                 pea.l      -6(a6)
[000031cc] 4eb9 0000 31e4            jsr        _baktok1
[000031d2] 588f                      addq.l     #4,a7
_alt_1:
[000031d4] 2e05                      move.l     d5,d7
[000031d6] 0287 0000 00ff            andi.l     #$000000FF,d7
[000031dc] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[000031e0] 4e5e                      unlk       a6
[000031e2] 4e75                      rts

_baktok1:
[000031e4] 4e56 0000                 link       a6,#0
[000031e8] 48e7 8004                 movem.l    d0/a5,-(a7)
[000031ec] 2a6e 0008                 movea.l    8(a6),a5
[000031f0] 3e39 0002 077e            move.w     _ntoks,d7
[000031f6] 48c7                      ext.l      d7
[000031f8] 0c47 0003                 cmpi.w     #$0003,d7
[000031fc] 6c38                      bge.s      _baktok1_1
[000031fe] 4878 0006                 pea.l      ($00000006).w
[00003202] 2f0d                      move.l     a5,-(a7)
[00003204] 3e39 0002 077e            move.w     _ntoks,d7
[0000320a] 48c7                      ext.l      d7
[0000320c] 2447                      movea.l    d7,a2
[0000320e] 5279 0002 077e            addq.w     #1,_ntoks
[00003214] 2f0a                      move.l     a2,-(a7)
[00003216] 4878 0006                 pea.l      ($00000006).w
[0000321a] 4eb9 0000 ade4            jsr        a.lmul
[00003220] 2e1f                      move.l     (a7)+,d7
[00003222] 2f07                      move.l     d7,-(a7)
[00003224] 0697 0002 0780            addi.l     #_tokstk,(a7)
[0000322a] 4eb9 0000 adac            jsr        _cpybuf
[00003230] 4fef 000c                 lea.l      12(a7),a7
[00003234] 6014                      bra.s      _baktok1_2
_baktok1_1:
[00003236] 2ebc 0002 07a2            move.l     #$000207A2,(a7) "!TOKEN OVERFLOW"
[0000323c] 4eb9 0000 3e84            jsr        _p1error
[00003242] 4297                      clr.l      (a7)
[00003244] 4eb9 0000 0080            jsr        _exit
_baktok1_2:
[0000324a] 4cdf 2001                 movem.l    (a7)+,d0/a5
[0000324e] 4e5e                      unlk       a6
[00003250] 4e75                      rts

_defspace:
[00003252] 4e56 0000                 link       a6,#0
[00003256] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[0000325a] 2a2e 0008                 move.l     8(a6),d5
[0000325e] 0c85 0000 003e            cmpi.l     #$0000003E,d5
[00003264] 6708                      beq.s      _defspace_1
[00003266] 0c85 0000 002a            cmpi.l     #$0000002A,d5
[0000326c] 6610                      bne.s      _defspace_2
_defspace_1:
[0000326e] 4284                      clr.l      d4
_defspace_5:
[00003270] 0cae 0000 0042 000c       cmpi.l     #$00000042,12(a6)
[00003278] 6634                      bne.s      _defspace_3
[0000327a] 5884                      addq.l     #4,d4
[0000327c] 6030                      bra.s      _defspace_3
_defspace_2:
[0000327e] 0c85 0000 0034            cmpi.l     #$00000034,d5
[00003284] 6604                      bne.s      _defspace_4
[00003286] 7801                      moveq.l    #1,d4
[00003288] 60e6                      bra.s      _defspace_5
_defspace_4:
[0000328a] 0c85 0000 0021            cmpi.l     #$00000021,d5
[00003290] 6708                      beq.s      _defspace_6
[00003292] 0c85 0000 003b            cmpi.l     #$0000003B,d5
[00003298] 6604                      bne.s      _defspace_7
_defspace_6:
[0000329a] 7802                      moveq.l    #2,d4
[0000329c] 60d2                      bra.s      _defspace_5
_defspace_7:
[0000329e] 0c85 0000 00e2            cmpi.l     #$000000E2,d5
[000032a4] 6604                      bne.s      _defspace_8
[000032a6] 7803                      moveq.l    #3,d4
[000032a8] 60c6                      bra.s      _defspace_5
_defspace_8:
[000032aa] 4287                      clr.l      d7
[000032ac] 6010                      bra.s      _defspace_9
_defspace_3:
[000032ae] 2e04                      move.l     d4,d7
[000032b0] e387                      asl.l      #1,d7
[000032b2] 2447                      movea.l    d7,a2
[000032b4] d5fc 0002 0792            adda.l     #_spaces,a2
[000032ba] 4287                      clr.l      d7
[000032bc] 3e12                      move.w     (a2),d7
_defspace_9:
[000032be] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[000032c2] 4e5e                      unlk       a6
[000032c4] 4e75                      rts

_domodel:
[000032c6] 4e56 0000                 link       a6,#0
[000032ca] 48e7 9c00                 movem.l    d0/d3-d5,-(a7)
[000032ce] 4284                      clr.l      d4
_domodel_2:
[000032d0] 0c84 0000 0008            cmpi.l     #$00000008,d4
[000032d6] 6c12                      bge.s      _domodel_1
[000032d8] 2e04                      move.l     d4,d7
[000032da] e387                      asl.l      #1,d7
[000032dc] 2447                      movea.l    d7,a2
[000032de] d5fc 0002 0792            adda.l     #_spaces,a2
[000032e4] 4252                      clr.w      (a2)
[000032e6] 5284                      addq.l     #1,d4
[000032e8] 60e6                      bra.s      _domodel_2
_domodel_1:
[000032ea] 4283                      clr.l      d3
[000032ec] 7a08                      moveq.l    #8,d5
[000032ee] 2e39 0002 0ba2            move.l     _model,d7
[000032f4] 41f9 0002 07b2            lea.l      $000207B2,a0
[000032fa] 4ef9 0000 a7dc            jmp        a.switch
[00003300] 4285                      clr.l      d5
_domodel_5:
[00003302] 2803                      move.l     d3,d4
_domodel_4:
[00003304] b885                      cmp.l      d5,d4
[00003306] 6c1e                      bge.s      _domodel_3
[00003308] 2e04                      move.l     d4,d7
[0000330a] e387                      asl.l      #1,d7
[0000330c] 2447                      movea.l    d7,a2
[0000330e] d5fc 0002 0792            adda.l     #_spaces,a2
[00003314] 34bc 0800                 move.w     #$0800,(a2)
[00003318] 5284                      addq.l     #1,d4
[0000331a] 60e8                      bra.s      _domodel_4
[0000331c] 7604                      moveq.l    #4,d3
[0000331e] 60e2                      bra.s      _domodel_5
[00003320] 7a04                      moveq.l    #4,d5
[00003322] 60de                      bra.s      _domodel_5
[00003324] 60dc                      bra.s      _domodel_5
_domodel_3:
[00003326] 4cdf 0039                 movem.l    (a7)+,d0/d3-d5
[0000332a] 4e5e                      unlk       a6
[0000332c] 4e75                      rts

_eat:
[0000332e] 4e56 fffa                 link       a6,#-6
[00003332] 48e7 8400                 movem.l    d0/d5,-(a7)
[00003336] 2a2e 0008                 move.l     8(a6),d5
[0000333a] 486e fffa                 pea.l      -6(a6)
[0000333e] 4eb9 0000 34e6            jsr        _gettok1
[00003344] 588f                      addq.l     #4,a7
[00003346] 2447                      movea.l    d7,a2
[00003348] 4287                      clr.l      d7
[0000334a] 1e12                      move.b     (a2),d7
[0000334c] be85                      cmp.l      d5,d7
[0000334e] 670e                      beq.s      _eat_1
[00003350] 486e fffa                 pea.l      -6(a6)
[00003354] 4eba fe8e                 jsr        _baktok1(pc)
[00003358] 588f                      addq.l     #4,a7
[0000335a] 4287                      clr.l      d7
[0000335c] 6002                      bra.s      _eat_2
_eat_1:
[0000335e] 2e05                      move.l     d5,d7
_eat_2:
[00003360] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00003364] 4e5e                      unlk       a6
[00003366] 4e75                      rts

_getch:
[00003368] 4e56 fffc                 link       a6,#-4
[0000336c] 4a79 0002 07da            tst.w      $000207DA
[00003372] 6626                      bne.s      _getch_1
[00003374] 2ebc 0000 0100            move.l     #$00000100,(a7)
[0000337a] 23fc 0002 07dc 0002 08dc  move.l     #$000207DC,$000208DC
[00003384] 2f39 0002 08dc            move.l     $000208DC,-(a7)
[0000338a] 42a7                      clr.l      -(a7)
[0000338c] 4eb9 0000 a79e            jsr        _read
[00003392] 508f                      addq.l     #8,a7
[00003394] 33c7 0002 07da            move.w     d7,$000207DA
_getch_1:
[0000339a] 4a79 0002 07da            tst.w      $000207DA
[000033a0] 6e14                      bgt.s      _getch_2
[000033a2] 33fc ffff 0002 07da       move.w     #$FFFF,$000207DA
[000033aa] 3e39 0002 07da            move.w     $000207DA,d7
[000033b0] 48c7                      ext.l      d7
[000033b2] 4e5e                      unlk       a6
[000033b4] 4e75                      rts
_getch_2:
[000033b6] 5379 0002 07da            subq.w     #1,$000207DA
[000033bc] 2479 0002 08dc            movea.l    $000208DC,a2
[000033c2] 52b9 0002 08dc            addq.l     #1,$000208DC
[000033c8] 4287                      clr.l      d7
[000033ca] 1e12                      move.b     (a2),d7
[000033cc] 0287 0000 00ff            andi.l     #$000000FF,d7
[000033d2] 4e5e                      unlk       a6
[000033d4] 4e75                      rts

_getspace:
[000033d6] 4e56 fffa                 link       a6,#-6
[000033da] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[000033de] 2a2e 0008                 move.l     8(a6),d5
[000033e2] 4ab9 0002 0d26            tst.l      _spacetab
[000033e8] 6626                      bne.s      _getspace_1
[000033ea] 4297                      clr.l      (a7)
[000033ec] 2f3c 0002 08f0            move.l     #$000208F0,-(a7)
[000033f2] 42a7                      clr.l      -(a7)
[000033f4] 4eb9 0000 7a78            jsr        _buysym
[000033fa] 508f                      addq.l     #8,a7
[000033fc] 23c7 0002 0d26            move.l     d7,_spacetab
[00003402] 45f8 000c                 lea.l      ($0000000C).w,a2
[00003406] d5f9 0002 0d26            adda.l     _spacetab,a2
[0000340c] 34bc 0800                 move.w     #$0800,(a2)
_getspace_1:
[00003410] 486e fffa                 pea.l      -6(a6)
[00003414] 4eb9 0000 3bae            jsr        _ident
[0000341a] 588f                      addq.l     #4,a7
[0000341c] 4a87                      tst.l      d7
[0000341e] 6700 0094                 beq        _getspace_2
[00003422] 4297                      clr.l      (a7)
[00003424] 2f39 0002 0d26            move.l     _spacetab,-(a7)
[0000342a] 2f2e fffc                 move.l     -4(a6),-(a7)
[0000342e] 4eb9 0000 847e            jsr        _lookup
[00003434] 508f                      addq.l     #8,a7
[00003436] 2a47                      movea.l    d7,a5
[00003438] 2e0d                      move.l     a5,d7
[0000343a] 670a                      beq.s      _getspace_3
[0000343c] 4287                      clr.l      d7
[0000343e] 3e2d 000c                 move.w     12(a5),d7
[00003442] 8a87                      or.l       d7,d5
[00003444] 606e                      bra.s      _getspace_2
_getspace_3:
[00003446] 4297                      clr.l      (a7)
[00003448] 2f2e fffc                 move.l     -4(a6),-(a7)
[0000344c] 42a7                      clr.l      -(a7)
[0000344e] 4eb9 0000 7a78            jsr        _buysym
[00003454] 508f                      addq.l     #8,a7
[00003456] 2a47                      movea.l    d7,a5
[00003458] 2ebc 0002 0d26            move.l     #_spacetab,(a7)
[0000345e] 2f0d                      move.l     a5,-(a7)
[00003460] 4eb9 0000 774e            jsr        _addsym
[00003466] 588f                      addq.l     #4,a7
[00003468] 45f8 000c                 lea.l      ($0000000C).w,a2
[0000346c] d5d5                      adda.l     (a5),a2
[0000346e] 4287                      clr.l      d7
[00003470] 3e12                      move.w     (a2),d7
[00003472] e287                      asr.l      #1,d7
[00003474] 3b47 000c                 move.w     d7,12(a5)
[00003478] 4a6d 000c                 tst.w      12(a5)
[0000347c] 660e                      bne.s      _getspace_4
[0000347e] 2ebc 0002 08e0            move.l     #$000208E0,(a7) "too many spaces"
[00003484] 4eb9 0000 3e84            jsr        _p1error
[0000348a] 6020                      bra.s      _getspace_5
_getspace_4:
[0000348c] 2ebc 0000 00ba            move.l     #$000000BA,(a7)
[00003492] 4eb9 0000 5a16            jsr        _pcode
[00003498] 4878 0001                 pea.l      ($00000001).w
[0000349c] 486d 0010                 pea.l      16(a5)
[000034a0] 42a7                      clr.l      -(a7)
[000034a2] 4eb9 0000 661a            jsr        _ptname
[000034a8] 4fef 000c                 lea.l      12(a7),a7
_getspace_5:
[000034ac] 4287                      clr.l      d7
[000034ae] 3e2d 000c                 move.w     12(a5),d7
[000034b2] 8a87                      or.l       d7,d5
_getspace_2:
[000034b4] 2e05                      move.l     d5,d7
[000034b6] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[000034ba] 4e5e                      unlk       a6
[000034bc] 4e75                      rts

_getstr:
[000034be] 4e56 0000                 link       a6,#0
[000034c2] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[000034c6] 2a6e 0008                 movea.l    8(a6),a5
[000034ca] 2a2e 000c                 move.l     12(a6),d5
_getstr_2:
[000034ce] 4a85                      tst.l      d5
[000034d0] 6f0c                      ble.s      _getstr_1
[000034d2] 4eb9 0000 3c56            jsr        _needc
[000034d8] 1ac7                      move.b     d7,(a5)+
[000034da] 5385                      subq.l     #1,d5
[000034dc] 60f0                      bra.s      _getstr_2
_getstr_1:
[000034de] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[000034e2] 4e5e                      unlk       a6
[000034e4] 4e75                      rts

_gettok1:
[000034e6] 4e56 fffa                 link       a6,#-6
[000034ea] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000034ee] 2a6e 0008                 movea.l    8(a6),a5
[000034f2] 4a79 0002 077e            tst.w      _ntoks
[000034f8] 6f3e                      ble.s      _gettok1_1
[000034fa] 4878 0006                 pea.l      ($00000006).w
[000034fe] 5379 0002 077e            subq.w     #1,_ntoks
[00003504] 3e39 0002 077e            move.w     _ntoks,d7
[0000350a] 48c7                      ext.l      d7
[0000350c] 2f07                      move.l     d7,-(a7)
[0000350e] 4878 0006                 pea.l      ($00000006).w
[00003512] 4eb9 0000 ade4            jsr        a.lmul
[00003518] 2e1f                      move.l     (a7)+,d7
[0000351a] 2f07                      move.l     d7,-(a7)
[0000351c] 0697 0002 0780            addi.l     #_tokstk,(a7)
[00003522] 2f0d                      move.l     a5,-(a7)
[00003524] 4eb9 0000 adac            jsr        _cpybuf
[0000352a] 4fef 000c                 lea.l      12(a7),a7
[0000352e] 2e0d                      move.l     a5,d7
[00003530] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00003534] 4e5e                      unlk       a6
[00003536] 4e75                      rts
_gettok1_1:
[00003538] 2e8d                      move.l     a5,(a7)
[0000353a] 4eb9 0000 3894            jsr        _gtok
[00003540] 4287                      clr.l      d7
[00003542] 1e15                      move.b     (a5),d7
[00003544] 0c47 0017                 cmpi.w     #$0017,d7
[00003548] 6622                      bne.s      _gettok1_2
_gettok1_7:
[0000354a] 486e fffa                 pea.l      -6(a6)
[0000354e] 4eb9 0000 3894            jsr        _gtok
[00003554] 588f                      addq.l     #4,a7
[00003556] 4287                      clr.l      d7
[00003558] 1e2e fffa                 move.b     -6(a6),d7
[0000355c] 0c47 0017                 cmpi.w     #$0017,d7
[00003560] 672a                      beq.s      _gettok1_3
[00003562] 486e fffa                 pea.l      -6(a6)
[00003566] 4eba fc7c                 jsr        _baktok1(pc)
[0000356a] 588f                      addq.l     #4,a7
_gettok1_2:
[0000356c] 4ab9 0002 0cbc            tst.l      _pperr
[00003572] 6700 00aa                 beq        _gettok1_4
_gettok1_6:
[00003576] 4287                      clr.l      d7
[00003578] 1e15                      move.b     (a5),d7
[0000357a] 0c47 00ff                 cmpi.w     #$00FF,d7
[0000357e] 6700 00a8                 beq        _gettok1_5
[00003582] 2e8d                      move.l     a5,(a7)
[00003584] 4eb9 0000 3894            jsr        _gtok
[0000358a] 60ea                      bra.s      _gettok1_6
_gettok1_3:
[0000358c] 246d 0002                 movea.l    2(a5),a2
[00003590] 4287                      clr.l      d7
[00003592] 3e12                      move.w     (a2),d7
[00003594] 246e fffc                 movea.l    -4(a6),a2
[00003598] 4286                      clr.l      d6
[0000359a] 3c12                      move.w     (a2),d6
[0000359c] de86                      add.l      d6,d7
[0000359e] 5387                      subq.l     #1,d7
[000035a0] 2a07                      move.l     d7,d5
[000035a2] 4297                      clr.l      (a7)
[000035a4] 2f05                      move.l     d5,-(a7)
[000035a6] 5497                      addq.l     #2,(a7)
[000035a8] 4eb9 0000 a906            jsr        _alloc
[000035ae] 588f                      addq.l     #4,a7
[000035b0] 2847                      movea.l    d7,a4
[000035b2] 3885                      move.w     d5,(a4)
[000035b4] 246d 0002                 movea.l    2(a5),a2
[000035b8] 4287                      clr.l      d7
[000035ba] 3e12                      move.w     (a2),d7
[000035bc] 2e87                      move.l     d7,(a7)
[000035be] 5397                      subq.l     #1,(a7)
[000035c0] 2f2d 0002                 move.l     2(a5),-(a7)
[000035c4] 5497                      addq.l     #2,(a7)
[000035c6] 486c 0002                 pea.l      2(a4)
[000035ca] 4eb9 0000 adac            jsr        _cpybuf
[000035d0] 508f                      addq.l     #8,a7
[000035d2] 246e fffc                 movea.l    -4(a6),a2
[000035d6] 4287                      clr.l      d7
[000035d8] 3e12                      move.w     (a2),d7
[000035da] 2e87                      move.l     d7,(a7)
[000035dc] 2f2e fffc                 move.l     -4(a6),-(a7)
[000035e0] 5497                      addq.l     #2,(a7)
[000035e2] 246d 0002                 movea.l    2(a5),a2
[000035e6] 4287                      clr.l      d7
[000035e8] 3e12                      move.w     (a2),d7
[000035ea] 45ec 0001                 lea.l      1(a4),a2
[000035ee] de8a                      add.l      a2,d7
[000035f0] 2f07                      move.l     d7,-(a7)
[000035f2] 4eb9 0000 adac            jsr        _cpybuf
[000035f8] 508f                      addq.l     #8,a7
[000035fa] 4297                      clr.l      (a7)
[000035fc] 2f2e fffc                 move.l     -4(a6),-(a7)
[00003600] 4eb9 0000 aa76            jsr        _free
[00003606] 588f                      addq.l     #4,a7
[00003608] 4297                      clr.l      (a7)
[0000360a] 2f2d 0002                 move.l     2(a5),-(a7)
[0000360e] 4eb9 0000 aa76            jsr        _free
[00003614] 588f                      addq.l     #4,a7
[00003616] 2b4c 0002                 move.l     a4,2(a5)
[0000361a] 6000 ff2e                 bra        _gettok1_7
_gettok1_4:
[0000361e] 2e0d                      move.l     a5,d7
[00003620] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00003624] 4e5e                      unlk       a6
[00003626] 4e75                      rts
_gettok1_5:
[00003628] 7001                      moveq.l    #1,d0
[0000362a] 23c0 0002 0cb4            move.l     d0,_p1p2ioct
[00003630] 4878 ffff                 pea.l      ($FFFFFFFF).w
[00003634] 4eb9 0000 3e98            jsr        _putchr
[0000363a] 588f                      addq.l     #4,a7
[0000363c] 4ab9 0002 0b76            tst.l      _errflag
[00003642] 6704                      beq.s      _gettok1_8
[00003644] 7e01                      moveq.l    #1,d7
[00003646] 6002                      bra.s      _gettok1_9
_gettok1_8:
[00003648] 4287                      clr.l      d7
_gettok1_9:
[0000364a] 2e87                      move.l     d7,(a7)
[0000364c] 4eb9 0000 0080            jsr        _exit
[00003652] 60ca                      bra.s      _gettok1_4

_gpragma:
[00003654] 4e56 fff2                 link       a6,#-14
[00003658] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[0000365c] 42ae fffa                 clr.l      -6(a6)
_gpragma_8:
[00003660] 486e fff4                 pea.l      -12(a6)
[00003664] 4eb9 0000 3bae            jsr        _ident
[0000366a] 588f                      addq.l     #4,a7
[0000366c] 4a87                      tst.l      d7
[0000366e] 6700 01ec                 beq        _gpragma_1
[00003672] 4878 0006                 pea.l      ($00000006).w
[00003676] 2f3c 0002 093f            move.l     #$0002093F,-(a7)
[0000367c] 2f2e fff6                 move.l     -10(a6),-(a7)
[00003680] 4eb9 0000 ad76            jsr        _cmpbuf
[00003686] 4fef 000c                 lea.l      12(a7),a7
[0000368a] 4a87                      tst.l      d7
[0000368c] 6730                      beq.s      _gpragma_2
[0000368e] 486e fff4                 pea.l      -12(a6)
[00003692] 4eb9 0000 3bae            jsr        _ident
[00003698] 588f                      addq.l     #4,a7
[0000369a] 4a87                      tst.l      d7
[0000369c] 6700 007e                 beq.w      _gpragma_3
[000036a0] 4878 0004                 pea.l      ($00000004).w
[000036a4] 2f3c 0002 093a            move.l     #$0002093A,-(a7)
[000036aa] 2f2e fff6                 move.l     -10(a6),-(a7)
[000036ae] 4eb9 0000 ad76            jsr        _cmpbuf
[000036b4] 4fef 000c                 lea.l      12(a7),a7
[000036b8] 4a87                      tst.l      d7
[000036ba] 6776                      beq.s      _gpragma_4
[000036bc] 605e                      bra.s      _gpragma_3
_gpragma_2:
[000036be] 4878 0006                 pea.l      ($00000006).w
[000036c2] 2f3c 0002 091d            move.l     #$0002091D,-(a7)
[000036c8] 2f2e fff6                 move.l     -10(a6),-(a7)
[000036cc] 4eb9 0000 ad76            jsr        _cmpbuf
[000036d2] 4fef 000c                 lea.l      12(a7),a7
[000036d6] 4a87                      tst.l      d7
[000036d8] 6700 0088                 beq        _gpragma_5
[000036dc] 2ebc 0002 08f6            move.l     #$000208F6,(a7)
[000036e2] 4eba faae                 jsr        _alt(pc)
[000036e6] 2e87                      move.l     d7,(a7)
[000036e8] 2f3c 0002 08f6            move.l     #$000208F6,-(a7)
[000036ee] 4eb9 0000 a7a6            jsr        _scnstr
[000036f4] 588f                      addq.l     #4,a7
[000036f6] 1d47 fff3                 move.b     d7,-13(a6)
[000036fa] 4878 0006                 pea.l      ($00000006).w
[000036fe] 4eba fc2e                 jsr        _eat(pc)
[00003702] 588f                      addq.l     #4,a7
[00003704] 2807                      move.l     d7,d4
[00003706] 6764                      beq.s      _gpragma_6
[00003708] 4878 000a                 pea.l      ($0000000A).w
[0000370c] 4eba fc20                 jsr        _eat(pc)
[00003710] 588f                      addq.l     #4,a7
[00003712] 4a87                      tst.l      d7
[00003714] 6600 007c                 bne.w      _gpragma_7
[00003718] 4284                      clr.l      d4
[0000371a] 6076                      bra.s      _gpragma_7
_gpragma_3:
[0000371c] 4284                      clr.l      d4
_gpragma_10:
[0000371e] 4a79 0002 04a8            tst.w      _dbfilab
[00003724] 6700 ff3a                 beq        _gpragma_8
[00003728] 23c4 0002 0b6e            move.l     d4,_dbflag
[0000372e] 6000 ff30                 bra        _gpragma_8
_gpragma_4:
[00003732] 4878 0003                 pea.l      ($00000003).w
[00003736] 2f3c 0002 0936            move.l     #$00020936,-(a7)
[0000373c] 2f2e fff6                 move.l     -10(a6),-(a7)
[00003740] 4eb9 0000 ad76            jsr        _cmpbuf
[00003746] 4fef 000c                 lea.l      12(a7),a7
[0000374a] 4a87                      tst.l      d7
[0000374c] 6704                      beq.s      _gpragma_9
[0000374e] 7801                      moveq.l    #1,d4
[00003750] 60cc                      bra.s      _gpragma_10
_gpragma_9:
[00003752] 2ebc 0002 0924            move.l     #$00020924,(a7) "bad #pragma debug"
[00003758] 4eb9 0000 3e84            jsr        _p1error
[0000375e] 6000 00fc                 bra        _gpragma_1
_gpragma_5:
[00003762] 7001                      moveq.l    #1,d0
[00003764] 2d40 fffa                 move.l     d0,-6(a6)
[00003768] 6000 00f2                 bra        _gpragma_1
_gpragma_6:
[0000376c] 4878 0004                 pea.l      ($00000004).w
[00003770] 4eba fbbc                 jsr        _eat(pc)
[00003774] 588f                      addq.l     #4,a7
[00003776] 2807                      move.l     d7,d4
[00003778] 6712                      beq.s      _gpragma_11
[0000377a] 4878 0008                 pea.l      ($00000008).w
[0000377e] 4eba fbae                 jsr        _eat(pc)
[00003782] 588f                      addq.l     #4,a7
[00003784] 4a87                      tst.l      d7
[00003786] 660a                      bne.s      _gpragma_7
[00003788] 4284                      clr.l      d4
[0000378a] 6006                      bra.s      _gpragma_7
_gpragma_11:
[0000378c] 383c 00e2                 move.w     #$00E2,d4
[00003790] 48c4                      ext.l      d4
_gpragma_7:
[00003792] 4a84                      tst.l      d4
[00003794] 6610                      bne.s      _gpragma_12
[00003796] 2ebc 0002 090b            move.l     #$0002090B,(a7) "bad #pragma space"
[0000379c] 4eb9 0000 3e84            jsr        _p1error
[000037a2] 6000 00b8                 bra        _gpragma_1
_gpragma_12:
[000037a6] 426e fffe                 clr.w      -2(a6)
_gpragma_14:
[000037aa] 4878 000c                 pea.l      ($0000000C).w
[000037ae] 4eba fb7e                 jsr        _eat(pc)
[000037b2] 588f                      addq.l     #4,a7
[000037b4] 4a87                      tst.l      d7
[000037b6] 6712                      beq.s      _gpragma_13
[000037b8] 4287                      clr.l      d7
[000037ba] 3e2e fffe                 move.w     -2(a6),d7
[000037be] 2e87                      move.l     d7,(a7)
[000037c0] 4eba fc14                 jsr        _getspace(pc)
[000037c4] 3d47 fffe                 move.w     d7,-2(a6)
[000037c8] 60e0                      bra.s      _gpragma_14
_gpragma_13:
[000037ca] 4285                      clr.l      d5
_gpragma_21:
[000037cc] 0c85 0000 0004            cmpi.l     #$00000004,d5
[000037d2] 6c18                      bge.s      _gpragma_15
[000037d4] 4287                      clr.l      d7
[000037d6] 1e2e fff3                 move.b     -13(a6),d7
[000037da] be85                      cmp.l      d5,d7
[000037dc] 6736                      beq.s      _gpragma_16
[000037de] 4287                      clr.l      d7
[000037e0] 1e2e fff3                 move.b     -13(a6),d7
[000037e4] 0c47 0004                 cmpi.w     #$0004,d7
[000037e8] 666c                      bne.s      _gpragma_17
[000037ea] 6028                      bra.s      _gpragma_16
_gpragma_15:
[000037ec] 0c84 0000 00e2            cmpi.l     #$000000E2,d4
[000037f2] 6600 fe6c                 bne        _gpragma_8
[000037f6] 4287                      clr.l      d7
[000037f8] 1e2e fff3                 move.b     -13(a6),d7
[000037fc] 0c47 0004                 cmpi.w     #$0004,d7
[00003800] 6600 fe5e                 bne        _gpragma_8
[00003804] 4a6e fffe                 tst.w      -2(a6)
[00003808] 6600 fe56                 bne        _gpragma_8
[0000380c] 4eba fab8                 jsr        _domodel(pc)
[00003810] 6000 fe4e                 bra        _gpragma_8
_gpragma_16:
[00003814] 0c84 0000 0004            cmpi.l     #$00000004,d4
[0000381a] 6708                      beq.s      _gpragma_18
[0000381c] 0c84 0000 00e2            cmpi.l     #$000000E2,d4
[00003822] 6610                      bne.s      _gpragma_19
_gpragma_18:
[00003824] 2e05                      move.l     d5,d7
[00003826] e387                      asl.l      #1,d7
[00003828] 2447                      movea.l    d7,a2
[0000382a] d5fc 0002 0792            adda.l     #_spaces,a2
[00003830] 34ae fffe                 move.w     -2(a6),(a2)
_gpragma_19:
[00003834] 0c84 0000 0006            cmpi.l     #$00000006,d4
[0000383a] 6708                      beq.s      _gpragma_20
[0000383c] 0c84 0000 00e2            cmpi.l     #$000000E2,d4
[00003842] 6612                      bne.s      _gpragma_17
_gpragma_20:
[00003844] 2e05                      move.l     d5,d7
[00003846] 5887                      addq.l     #4,d7
[00003848] e387                      asl.l      #1,d7
[0000384a] 2447                      movea.l    d7,a2
[0000384c] d5fc 0002 0792            adda.l     #_spaces,a2
[00003852] 34ae fffe                 move.w     -2(a6),(a2)
_gpragma_17:
[00003856] 5285                      addq.l     #1,d5
[00003858] 6000 ff72                 bra        _gpragma_21
_gpragma_1:
[0000385c] 486e fff4                 pea.l      -12(a6)
[00003860] 4eba fc84                 jsr        _gettok1(pc)
[00003864] 588f                      addq.l     #4,a7
[00003866] 2447                      movea.l    d7,a2
[00003868] 4287                      clr.l      d7
[0000386a] 1e12                      move.b     (a2),d7
[0000386c] 0c47 001d                 cmpi.w     #$001D,d7
[00003870] 6708                      beq.s      _gpragma_22
[00003872] 7001                      moveq.l    #1,d0
[00003874] 2d40 fffa                 move.l     d0,-6(a6)
[00003878] 60e2                      bra.s      _gpragma_1
_gpragma_22:
[0000387a] 4aae fffa                 tst.l      -6(a6)
[0000387e] 670c                      beq.s      _gpragma_23
[00003880] 2ebc 0002 08fb            move.l     #$000208FB,(a7) "unknown #pragma"
[00003886] 4eb9 0000 3e84            jsr        _p1error
_gpragma_23:
[0000388c] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[00003890] 4e5e                      unlk       a6
[00003892] 4e75                      rts

_gtok:
[00003894] 4e56 ffec                 link       a6,#-20
[00003898] 48e7 8c0c                 movem.l    d0/d4-d5/a4-a5,-(a7)
[0000389c] 2a6e 0008                 movea.l    8(a6),a5
[000038a0] 42ae fffc                 clr.l      -4(a6)
_gtok_5:
[000038a4] 4aae fffc                 tst.l      -4(a6)
[000038a8] 6616                      bne.s      _gtok_1
[000038aa] 4eba fabc                 jsr        _getch(pc)
[000038ae] 1a87                      move.b     d7,(a5)
[000038b0] 4287                      clr.l      d7
[000038b2] 1e15                      move.b     (a5),d7
[000038b4] 41f9 0002 094a            lea.l      $0002094A,a0
[000038ba] 4ef9 0000 a7dc            jmp        a.switch
_gtok_1:
[000038c0] 2b7c 0002 0bb4 0002       move.l     #_mainbuff,2(a5)
[000038c8] 4287                      clr.l      d7
[000038ca] 1e15                      move.b     (a5),d7
[000038cc] 0c47 00ff                 cmpi.w     #$00FF,d7
[000038d0] 6700 01c8                 beq        _gtok_2
[000038d4] 4a15                      tst.b      (a5)
[000038d6] 6600 01ce                 bne        _gtok_3
[000038da] 6000 01be                 bra        _gtok_2
[000038de] 7001                      moveq.l    #1,d0
[000038e0] 23c0 0002 0cb4            move.l     d0,_p1p2ioct
[000038e6] 7001                      moveq.l    #1,d0
[000038e8] 23c0 0002 0cbc            move.l     d0,_pperr
[000038ee] 7001                      moveq.l    #1,d0
[000038f0] 23c0 0002 0cb8            move.l     d0,_p1err
[000038f6] 33fc 0001 0002 0cce       move.w     #$0001,_nerrors
[000038fe] 4878 0002                 pea.l      ($00000002).w
[00003902] 486e fff6                 pea.l      -10(a6)
[00003906] 4eba fbb6                 jsr        _getstr(pc)
[0000390a] 508f                      addq.l     #8,a7
[0000390c] 3e2e fff6                 move.w     -10(a6),d7
[00003910] 48c7                      ext.l      d7
[00003912] 2e87                      move.l     d7,(a7)
[00003914] 2f3c 0002 0c34            move.l     #_errbuf,-(a7)
[0000391a] 4eba fba2                 jsr        _getstr(pc)
[0000391e] 588f                      addq.l     #4,a7
[00003920] 4ab9 0002 0b8a            tst.l      _oldflag
[00003926] 6632                      bne.s      _gtok_4
[00003928] 4287                      clr.l      d7
[0000392a] 1e15                      move.b     (a5),d7
[0000392c] 2e87                      move.l     d7,(a7)
[0000392e] 4eb9 0000 5a16            jsr        _pcode
[00003934] 4878 0002                 pea.l      ($00000002).w
[00003938] 486e fff6                 pea.l      -10(a6)
[0000393c] 4eb9 0000 695c            jsr        _putbytes
[00003942] 508f                      addq.l     #8,a7
[00003944] 3e2e fff6                 move.w     -10(a6),d7
[00003948] 48c7                      ext.l      d7
[0000394a] 2e87                      move.l     d7,(a7)
[0000394c] 2f3c 0002 0c34            move.l     #_errbuf,-(a7)
[00003952] 4eb9 0000 695c            jsr        _putbytes
[00003958] 588f                      addq.l     #4,a7
_gtok_4:
[0000395a] 42b9 0002 0cb4            clr.l      _p1p2ioct
[00003960] 6000 ff42                 bra        _gtok_5
[00003964] 6000 ff3e                 bra        _gtok_5
[00003968] 2d79 0002 0cb4 fff8       move.l     _p1p2ioct,-8(a6)
[00003970] 7001                      moveq.l    #1,d0
[00003972] 23c0 0002 0cb4            move.l     d0,_p1p2ioct
[00003978] 4878 0002                 pea.l      ($00000002).w
[0000397c] 2f3c 0002 0cd4            move.l     #_lineno,-(a7)
[00003982] 4eba fb3a                 jsr        _getstr(pc)
[00003986] 508f                      addq.l     #8,a7
[00003988] 4ab9 0002 0b8a            tst.l      _oldflag
[0000398e] 661e                      bne.s      _gtok_6
[00003990] 4878 0014                 pea.l      ($00000014).w
[00003994] 4eb9 0000 5a16            jsr        _pcode
[0000399a] 588f                      addq.l     #4,a7
[0000399c] 4878 0002                 pea.l      ($00000002).w
[000039a0] 2f3c 0002 0cd4            move.l     #_lineno,-(a7)
[000039a6] 4eb9 0000 695c            jsr        _putbytes
[000039ac] 508f                      addq.l     #8,a7
_gtok_6:
[000039ae] 23ee fff8 0002 0cb4       move.l     -8(a6),_p1p2ioct
[000039b6] 6000 feec                 bra        _gtok_5
[000039ba] 2d79 0002 0cb4 fff8       move.l     _p1p2ioct,-8(a6)
[000039c2] 7001                      moveq.l    #1,d0
[000039c4] 23c0 0002 0cb4            move.l     d0,_p1p2ioct
[000039ca] 4eb9 0000 3c56            jsr        _needc
[000039d0] 2807                      move.l     d7,d4
[000039d2] 4297                      clr.l      (a7)
[000039d4] 2f04                      move.l     d4,-(a7)
[000039d6] 5497                      addq.l     #2,(a7)
[000039d8] 4eb9 0000 a906            jsr        _alloc
[000039de] 588f                      addq.l     #4,a7
[000039e0] 2d47 fff2                 move.l     d7,-14(a6)
[000039e4] 246e fff2                 movea.l    -14(a6),a2
[000039e8] 1484                      move.b     d4,(a2)
[000039ea] 2e84                      move.l     d4,(a7)
[000039ec] 2f2e fff2                 move.l     -14(a6),-(a7)
[000039f0] 5297                      addq.l     #1,(a7)
[000039f2] 4eba faca                 jsr        _getstr(pc)
[000039f6] 588f                      addq.l     #4,a7
[000039f8] 246e fff2                 movea.l    -14(a6),a2
[000039fc] 2844                      movea.l    d4,a4
[000039fe] 528c                      addq.l     #1,a4
[00003a00] d5cc                      adda.l     a4,a2
[00003a02] 4212                      clr.b      (a2)
[00003a04] 4ab9 0002 0b6e            tst.l      _dbflag
[00003a0a] 671c                      beq.s      _gtok_7
[00003a0c] 4a79 0002 04a8            tst.w      _dbfilab
[00003a12] 6614                      bne.s      _gtok_7
[00003a14] 2479 0002 0cd0            movea.l    _infile,a2
[00003a1a] 4a12                      tst.b      (a2)
[00003a1c] 660a                      bne.s      _gtok_7
[00003a1e] 2eae fff2                 move.l     -14(a6),(a7)
[00003a22] 4eb9 0000 176a            jsr        _dbfile
_gtok_7:
[00003a28] 2eae fff2                 move.l     -14(a6),(a7)
[00003a2c] 2f39 0002 0cd0            move.l     _infile,-(a7)
[00003a32] 4eb9 0000 aa76            jsr        _free
[00003a38] 588f                      addq.l     #4,a7
[00003a3a] 23c7 0002 0cd0            move.l     d7,_infile
[00003a40] 4ab9 0002 0b8a            tst.l      _oldflag
[00003a46] 661c                      bne.s      _gtok_8
[00003a48] 4878 0013                 pea.l      ($00000013).w
[00003a4c] 4eb9 0000 5a16            jsr        _pcode
[00003a52] 588f                      addq.l     #4,a7
[00003a54] 4297                      clr.l      (a7)
[00003a56] 2f2e fff2                 move.l     -14(a6),-(a7)
[00003a5a] 42a7                      clr.l      -(a7)
[00003a5c] 4eb9 0000 661a            jsr        _ptname
[00003a62] 508f                      addq.l     #8,a7
_gtok_8:
[00003a64] 23ee fff8 0002 0cb4       move.l     -8(a6),_p1p2ioct
[00003a6c] 6000 fe36                 bra        _gtok_5
[00003a70] 4ab9 0002 0946            tst.l      $00020946
[00003a76] 6708                      beq.s      _gtok_9
[00003a78] 42b9 0002 0946            clr.l      $00020946
[00003a7e] 601e                      bra.s      _gtok_10
_gtok_9:
[00003a80] 7001                      moveq.l    #1,d0
[00003a82] 23c0 0002 0946            move.l     d0,$00020946
[00003a88] 4eba fbca                 jsr        _gpragma(pc)
[00003a8c] 6000 fe16                 bra        _gtok_5
[00003a90] 7001                      moveq.l    #1,d0
[00003a92] 2d40 fffc                 move.l     d0,-4(a6)
[00003a96] 6000 fe0c                 bra        _gtok_5
_gtok_2:
[00003a9a] 1abc 00ff                 move.b     #$FF,(a5)
_gtok_10:
[00003a9e] 4cdf 3031                 movem.l    (a7)+,d0/d4-d5/a4-a5
[00003aa2] 4e5e                      unlk       a6
[00003aa4] 4e75                      rts
_gtok_3:
[00003aa6] 4287                      clr.l      d7
[00003aa8] 1e15                      move.b     (a5),d7
[00003aaa] 0287 0000 00f0            andi.l     #$000000F0,d7
[00003ab0] 0c87 0000 0010            cmpi.l     #$00000010,d7
[00003ab6] 66e6                      bne.s      _gtok_10
[00003ab8] 4287                      clr.l      d7
[00003aba] 1e15                      move.b     (a5),d7
[00003abc] 41f9 0002 0972            lea.l      $00020972,a0
[00003ac2] 4ef9 0000 a7dc            jmp        a.switch
[00003ac8] 13fc 0008 0002 0bb4       move.b     #$08,_mainbuff
[00003ad0] 4878 0008                 pea.l      ($00000008).w
[00003ad4] 2f3c 0002 0bb5            move.l     #$00020BB5,-(a7)
[00003ada] 4eba f9e2                 jsr        _getstr(pc)
[00003ade] 508f                      addq.l     #8,a7
[00003ae0] 60bc                      bra.s      _gtok_10
[00003ae2] 60ba                      bra.s      _gtok_10
[00003ae4] 4eb9 0000 3c56            jsr        _needc
[00003aea] 2807                      move.l     d7,d4
[00003aec] 0c84 0000 007f            cmpi.l     #$0000007F,d4
[00003af2] 6c04                      bge.s      _gtok_11
[00003af4] 2e04                      move.l     d4,d7
[00003af6] 6002                      bra.s      _gtok_12
_gtok_11:
[00003af8] 7e7f                      moveq.l    #127,d7
_gtok_12:
[00003afa] 2a07                      move.l     d7,d5
[00003afc] 13c5 0002 0bb4            move.b     d5,_mainbuff
[00003b02] 2e85                      move.l     d5,(a7)
[00003b04] 2f3c 0002 0bb5            move.l     #$00020BB5,-(a7)
[00003b0a] 4eba f9b2                 jsr        _getstr(pc)
[00003b0e] 588f                      addq.l     #4,a7
_gtok_13:
[00003b10] ba84                      cmp.l      d4,d5
[00003b12] 6c8a                      bge.s      _gtok_10
[00003b14] 4878 0001                 pea.l      ($00000001).w
[00003b18] 486e ffec                 pea.l      -20(a6)
[00003b1c] 4eba f9a0                 jsr        _getstr(pc)
[00003b20] 508f                      addq.l     #8,a7
[00003b22] 5285                      addq.l     #1,d5
[00003b24] 60ea                      bra.s      _gtok_13
[00003b26] 4878 0004                 pea.l      ($00000004).w
[00003b2a] 2f3c 0002 0bb4            move.l     #_mainbuff,-(a7)
[00003b30] 4eba f98c                 jsr        _getstr(pc)
[00003b34] 508f                      addq.l     #8,a7
[00003b36] 6000 ff66                 bra        _gtok_10
[00003b3a] 4878 0002                 pea.l      ($00000002).w
[00003b3e] 486e fff6                 pea.l      -10(a6)
[00003b42] 4eba f97a                 jsr        _getstr(pc)
[00003b46] 508f                      addq.l     #8,a7
[00003b48] 4297                      clr.l      (a7)
[00003b4a] 3e2e fff6                 move.w     -10(a6),d7
[00003b4e] 48c7                      ext.l      d7
[00003b50] 2f07                      move.l     d7,-(a7)
[00003b52] 5697                      addq.l     #3,(a7)
[00003b54] 4eb9 0000 a906            jsr        _alloc
[00003b5a] 588f                      addq.l     #4,a7
[00003b5c] 2b47 0002                 move.l     d7,2(a5)
[00003b60] 246d 0002                 movea.l    2(a5),a2
[00003b64] 34ae fff6                 move.w     -10(a6),(a2)
[00003b68] 3e2e fff6                 move.w     -10(a6),d7
[00003b6c] 48c7                      ext.l      d7
[00003b6e] 2e87                      move.l     d7,(a7)
[00003b70] 2f2d 0002                 move.l     2(a5),-(a7)
[00003b74] 5497                      addq.l     #2,(a7)
[00003b76] 4eba f946                 jsr        _getstr(pc)
[00003b7a] 588f                      addq.l     #4,a7
[00003b7c] 246d 0002                 movea.l    2(a5),a2
[00003b80] 548a                      addq.l     #2,a2
[00003b82] 3e2e fff6                 move.w     -10(a6),d7
[00003b86] 48c7                      ext.l      d7
[00003b88] d5c7                      adda.l     d7,a2
[00003b8a] 4212                      clr.b      (a2)
[00003b8c] 246d 0002                 movea.l    2(a5),a2
[00003b90] 5252                      addq.w     #1,(a2)
[00003b92] 6000 ff0a                 bra        _gtok_10
[00003b96] 2ebc 0002 09d2            move.l     #$000209D2,(a7) "!BAD CHAR"
[00003b9c] 4eb9 0000 3e84            jsr        _p1error
[00003ba2] 4297                      clr.l      (a7)
[00003ba4] 4eb9 0000 0080            jsr        _exit
[00003baa] 6000 fef2                 bra        _gtok_10

_ident:
[00003bae] 4e56 0000                 link       a6,#0
[00003bb2] 48e7 8004                 movem.l    d0/a5,-(a7)
[00003bb6] 2a6e 0008                 movea.l    8(a6),a5
[00003bba] 2e8d                      move.l     a5,(a7)
[00003bbc] 4eba f928                 jsr        _gettok1(pc)
[00003bc0] 2447                      movea.l    d7,a2
[00003bc2] 4287                      clr.l      d7
[00003bc4] 1e12                      move.b     (a2),d7
[00003bc6] 0c47 0012                 cmpi.w     #$0012,d7
[00003bca] 670c                      beq.s      _ident_1
[00003bcc] 2e8d                      move.l     a5,(a7)
[00003bce] 4eba f614                 jsr        _baktok1(pc)
[00003bd2] 4215                      clr.b      (a5)
[00003bd4] 4287                      clr.l      d7
[00003bd6] 6002                      bra.s      _ident_2
_ident_1:
[00003bd8] 2e0d                      move.l     a5,d7
_ident_2:
[00003bda] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00003bde] 4e5e                      unlk       a6
[00003be0] 4e75                      rts

_neat:
[00003be2] 4e56 0000                 link       a6,#0
[00003be6] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[00003bea] 2a2e 0008                 move.l     8(a6),d5
[00003bee] 4284                      clr.l      d4
_neat_2:
[00003bf0] 2e85                      move.l     d5,(a7)
[00003bf2] 4eba f73a                 jsr        _eat(pc)
[00003bf6] 4a87                      tst.l      d7
[00003bf8] 6704                      beq.s      _neat_1
[00003bfa] 5284                      addq.l     #1,d4
[00003bfc] 60f2                      bra.s      _neat_2
_neat_1:
[00003bfe] 2e04                      move.l     d4,d7
[00003c00] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[00003c04] 4e5e                      unlk       a6
[00003c06] 4e75                      rts

_need:
[00003c08] 4e56 0000                 link       a6,#0
[00003c0c] 48e7 8400                 movem.l    d0/d5,-(a7)
[00003c10] 2a2e 0008                 move.l     8(a6),d5
[00003c14] 2e85                      move.l     d5,(a7)
[00003c16] 4eba f716                 jsr        _eat(pc)
[00003c1a] 4a87                      tst.l      d7
[00003c1c] 662e                      bne.s      _need_1
[00003c1e] 2e85                      move.l     d5,(a7)
[00003c20] 2f3c 0002 09dc            move.l     #$000209DC,-(a7)
[00003c26] 4eb9 0000 a7a6            jsr        _scnstr
[00003c2c] 588f                      addq.l     #4,a7
[00003c2e] e587                      asl.l      #2,d7
[00003c30] 2447                      movea.l    d7,a2
[00003c32] d5fc 0002 09e6            adda.l     #$000209E6,a2
[00003c38] 2e92                      move.l     (a2),(a7)
[00003c3a] 2f3c 0002 0a34            move.l     #$00020A34,-(a7) "missing"
[00003c40] 4eb9 0000 3c8a            jsr        _nmerr
[00003c46] 588f                      addq.l     #4,a7
[00003c48] 4287                      clr.l      d7
[00003c4a] 6002                      bra.s      _need_2
_need_1:
[00003c4c] 2e05                      move.l     d5,d7
_need_2:
[00003c4e] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00003c52] 4e5e                      unlk       a6
[00003c54] 4e75                      rts

_needc:
[00003c56] 4e56 0000                 link       a6,#0
[00003c5a] 48e7 8400                 movem.l    d0/d5,-(a7)
[00003c5e] 4eba f708                 jsr        _getch(pc)
[00003c62] 2a07                      move.l     d7,d5
[00003c64] 0c85 ffff ffff            cmpi.l     #$FFFFFFFF,d5
[00003c6a] 6614                      bne.s      _needc_1
[00003c6c] 2ebc 0002 0a3c            move.l     #$00020A3C,(a7) "!EOF"
[00003c72] 4eb9 0000 3e84            jsr        _p1error
[00003c78] 4297                      clr.l      (a7)
[00003c7a] 4eb9 0000 0080            jsr        _exit
_needc_1:
[00003c80] 2e05                      move.l     d5,d7
[00003c82] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00003c86] 4e5e                      unlk       a6
[00003c88] 4e75                      rts

_nmerr:
[00003c8a] 4e56 fff4                 link       a6,#-12
[00003c8e] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00003c92] 7001                      moveq.l    #1,d0
[00003c94] 23c0 0002 0cb8            move.l     d0,_p1err
[00003c9a] 7001                      moveq.l    #1,d0
[00003c9c] 23c0 0002 0cb4            move.l     d0,_p1p2ioct
[00003ca2] 4878 000a                 pea.l      ($0000000A).w
[00003ca6] 3e39 0002 0cd4            move.w     _lineno,d7
[00003cac] 48c7                      ext.l      d7
[00003cae] 2f07                      move.l     d7,-(a7)
[00003cb0] 486e fff8                 pea.l      -8(a6)
[00003cb4] 4eb9 0000 a352            jsr        _itob
[00003cba] 4fef 000c                 lea.l      12(a7),a7
[00003cbe] 2447                      movea.l    d7,a2
[00003cc0] 49ee fff8                 lea.l      -8(a6),a4
[00003cc4] d5cc                      adda.l     a4,a2
[00003cc6] 4212                      clr.b      (a2)
[00003cc8] 4297                      clr.l      (a7)
[00003cca] 2f3c 0002 0a44            move.l     #$00020A44,-(a7)
[00003cd0] 2f2e 0008                 move.l     8(a6),-(a7)
[00003cd4] 2f3c 0002 0a46            move.l     #$00020A46,-(a7)
[00003cda] 486e fff8                 pea.l      -8(a6)
[00003cde] 2f3c 0002 0a48            move.l     #$00020A48,-(a7)
[00003ce4] 2f39 0002 0cd0            move.l     _infile,-(a7)
[00003cea] 5297                      addq.l     #1,(a7)
[00003cec] 2f3c 0002 0a4a            move.l     #$00020A4A,-(a7)
[00003cf2] 2f39 0002 0cc0            move.l     __pname,-(a7)
[00003cf8] 2f3c 0002 0a4c            move.l     #$00020A4C,-(a7)
[00003cfe] 2f3c 0002 0c34            move.l     #_errbuf,-(a7)
[00003d04] 4eb9 0000 a51e            jsr        _cpystr
[00003d0a] 4fef 0028                 lea.l      40(a7),a7
[00003d0e] 2a47                      movea.l    d7,a5
[00003d10] 4297                      clr.l      (a7)
[00003d12] 2f3c 0002 0c34            move.l     #_errbuf,-(a7)
[00003d18] 3e39 0002 0cc8            move.w     _errfd,d7
[00003d1e] 48c7                      ext.l      d7
[00003d20] 2f07                      move.l     d7,-(a7)
[00003d22] 4eb9 0000 ae40            jsr        _putstr
[00003d28] 508f                      addq.l     #8,a7
[00003d2a] 4aae 000c                 tst.l      12(a6)
[00003d2e] 6750                      beq.s      _nmerr_1
[00003d30] 2d4d fff4                 move.l     a5,-12(a6)
[00003d34] 2e2e 000c                 move.l     12(a6),d7
[00003d38] 5287                      addq.l     #1,d7
[00003d3a] 2a47                      movea.l    d7,a5
[00003d3c] 426e fffe                 clr.w      -2(a6)
_nmerr_3:
[00003d40] 4287                      clr.l      d7
[00003d42] 1e15                      move.b     (a5),d7
[00003d44] 0c47 007c                 cmpi.w     #$007C,d7
[00003d48] 6700 00be                 beq        _nmerr_2
[00003d4c] 4a15                      tst.b      (a5)
[00003d4e] 6700 00b8                 beq        _nmerr_2
[00003d52] 3e2e fffe                 move.w     -2(a6),d7
[00003d56] 48c7                      ext.l      d7
[00003d58] 246e 000c                 movea.l    12(a6),a2
[00003d5c] 4286                      clr.l      d6
[00003d5e] 1c12                      move.b     (a2),d6
[00003d60] be86                      cmp.l      d6,d7
[00003d62] 6700 00a4                 beq        _nmerr_2
[00003d66] 246e fff4                 movea.l    -12(a6),a2
[00003d6a] 52ae fff4                 addq.l     #1,-12(a6)
[00003d6e] 1495                      move.b     (a5),(a2)
[00003d70] 3e2e fffe                 move.w     -2(a6),d7
[00003d74] 48c7                      ext.l      d7
[00003d76] 5287                      addq.l     #1,d7
[00003d78] 3d47 fffe                 move.w     d7,-2(a6)
[00003d7c] 528d                      addq.l     #1,a5
[00003d7e] 60c0                      bra.s      _nmerr_3
_nmerr_1:
[00003d80] 2d4d fff4                 move.l     a5,-12(a6)
_nmerr_6:
[00003d84] 4878 0001                 pea.l      ($00000001).w
[00003d88] 2f3c 0002 0a42            move.l     #$00020A42,-(a7)
[00003d8e] 3e39 0002 0cc8            move.w     _errfd,d7
[00003d94] 48c7                      ext.l      d7
[00003d96] 2f07                      move.l     d7,-(a7)
[00003d98] 4eb9 0000 b106            jsr        _write
[00003d9e] 4fef 000c                 lea.l      12(a7),a7
[00003da2] 5279 0002 0cce            addq.w     #1,_nerrors
[00003da8] 246e fff4                 movea.l    -12(a6),a2
[00003dac] 52ae fff4                 addq.l     #1,-12(a6)
[00003db0] 14bc 000a                 move.b     #$0A,(a2)
[00003db4] 246e fff4                 movea.l    -12(a6),a2
[00003db8] 4212                      clr.b      (a2)
[00003dba] 4ab9 0002 0b8a            tst.l      _oldflag
[00003dc0] 6600 0080                 bne        _nmerr_4 ; possibly optimized to short
[00003dc4] 2ebc 0000 00fe            move.l     #$000000FE,(a7)
[00003dca] 4eb9 0000 5a16            jsr        _pcode
[00003dd0] 2ebc 0002 0c34            move.l     #_errbuf,(a7)
[00003dd6] 4eb9 0000 aef4            jsr        _lenstr
[00003ddc] 3d47 fffe                 move.w     d7,-2(a6)
[00003de0] 4878 0002                 pea.l      ($00000002).w
[00003de4] 486e fffe                 pea.l      -2(a6)
[00003de8] 4eb9 0000 695c            jsr        _putbytes
[00003dee] 508f                      addq.l     #8,a7
[00003df0] 3e2e fffe                 move.w     -2(a6),d7
[00003df4] 48c7                      ext.l      d7
[00003df6] 2e87                      move.l     d7,(a7)
[00003df8] 2f3c 0002 0c34            move.l     #_errbuf,-(a7)
[00003dfe] 4eb9 0000 695c            jsr        _putbytes
[00003e04] 588f                      addq.l     #4,a7
[00003e06] 603a                      bra.s      _nmerr_4
_nmerr_2:
[00003e08] 246e 000c                 movea.l    12(a6),a2
[00003e0c] 4287                      clr.l      d7
[00003e0e] 1e12                      move.b     (a2),d7
[00003e10] 3c2e fffe                 move.w     -2(a6),d6
[00003e14] 48c6                      ext.l      d6
[00003e16] be86                      cmp.l      d6,d7
[00003e18] 6c04                      bge.s      _nmerr_5
[00003e1a] 536e fffe                 subq.w     #1,-2(a6)
_nmerr_5:
[00003e1e] 3e2e fffe                 move.w     -2(a6),d7
[00003e22] 48c7                      ext.l      d7
[00003e24] 2e87                      move.l     d7,(a7)
[00003e26] 2f2e 000c                 move.l     12(a6),-(a7)
[00003e2a] 5297                      addq.l     #1,(a7)
[00003e2c] 3e39 0002 0cc8            move.w     _errfd,d7
[00003e32] 48c7                      ext.l      d7
[00003e34] 2f07                      move.l     d7,-(a7)
[00003e36] 4eb9 0000 b106            jsr        _write
[00003e3c] 508f                      addq.l     #8,a7
[00003e3e] 6000 ff44                 bra        _nmerr_6
_nmerr_4:
[00003e42] 42b9 0002 0cb4            clr.l      _p1p2ioct
[00003e48] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00003e4c] 4e5e                      unlk       a6
[00003e4e] 4e75                      rts

_peek:
[00003e50] 4e56 fffa                 link       a6,#-6
[00003e54] 48e7 8400                 movem.l    d0/d5,-(a7)
[00003e58] 2a2e 0008                 move.l     8(a6),d5
[00003e5c] 486e fffa                 pea.l      -6(a6)
[00003e60] 4eba f684                 jsr        _gettok1(pc)
[00003e64] 588f                      addq.l     #4,a7
[00003e66] 2e87                      move.l     d7,(a7)
[00003e68] 4eba f37a                 jsr        _baktok1(pc)
[00003e6c] 4287                      clr.l      d7
[00003e6e] 1e2e fffa                 move.b     -6(a6),d7
[00003e72] be85                      cmp.l      d5,d7
[00003e74] 6604                      bne.s      _peek_1
[00003e76] 2e05                      move.l     d5,d7
[00003e78] 6002                      bra.s      _peek_2
_peek_1:
[00003e7a] 4287                      clr.l      d7
_peek_2:
[00003e7c] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00003e80] 4e5e                      unlk       a6
[00003e82] 4e75                      rts

_p1error:
[00003e84] 4e56 fffc                 link       a6,#-4
[00003e88] 4297                      clr.l      (a7)
[00003e8a] 2f2e 0008                 move.l     8(a6),-(a7)
[00003e8e] 4eba fdfa                 jsr        _nmerr(pc)
[00003e92] 588f                      addq.l     #4,a7
[00003e94] 4e5e                      unlk       a6
[00003e96] 4e75                      rts

_putchr:
[00003e98] 4e56 fffc                 link       a6,#-4
[00003e9c] 4ab9 0002 0cb4            tst.l      _p1p2ioct
[00003ea2] 6604                      bne.s      _putchr_1
[00003ea4] 4e5e                      unlk       a6
[00003ea6] 4e75                      rts
_putchr_1:
[00003ea8] 3e39 0002 0a54            move.w     $00020A54,d7
[00003eae] 48c7                      ext.l      d7
[00003eb0] 0c47 0100                 cmpi.w     #$0100,d7
[00003eb4] 670e                      beq.s      _putchr_2
[00003eb6] 4aae 0008                 tst.l      8(a6)
[00003eba] 6c4e                      bge.s      _putchr_3
[00003ebc] 4a79 0002 0a54            tst.w      $00020A54
[00003ec2] 6746                      beq.s      _putchr_3
_putchr_2:
[00003ec4] 3e39 0002 0a54            move.w     $00020A54,d7
[00003eca] 48c7                      ext.l      d7
[00003ecc] 2e87                      move.l     d7,(a7)
[00003ece] 2f3c 0002 0a56            move.l     #$00020A56,-(a7)
[00003ed4] 3e39 0002 0cd6            move.w     _outfd,d7
[00003eda] 48c7                      ext.l      d7
[00003edc] 2f07                      move.l     d7,-(a7)
[00003ede] 4eb9 0000 b106            jsr        _write
[00003ee4] 508f                      addq.l     #8,a7
[00003ee6] 3c39 0002 0a54            move.w     $00020A54,d6
[00003eec] 48c6                      ext.l      d6
[00003eee] be86                      cmp.l      d6,d7
[00003ef0] 6712                      beq.s      _putchr_4
[00003ef2] 2ebc 0002 0b56            move.l     #$00020B56,(a7) ":"
[00003ef8] 4eba ff8a                 jsr        _p1error(pc)
[00003efc] 4297                      clr.l      (a7)
[00003efe] 4eb9 0000 0080            jsr        _exit
_putchr_4:
[00003f04] 4279 0002 0a54            clr.w      $00020A54
_putchr_3:
[00003f0a] 3e39 0002 0a54            move.w     $00020A54,d7
[00003f10] 48c7                      ext.l      d7
[00003f12] 2447                      movea.l    d7,a2
[00003f14] 5279 0002 0a54            addq.w     #1,$00020A54
[00003f1a] d5fc 0002 0a56            adda.l     #$00020A56,a2
[00003f20] 14ae 000b                 move.b     11(a6),(a2)
[00003f24] 4e5e                      unlk       a6
[00003f26] 4e75                      rts

_recover:
[00003f28] 4e56 fff6                 link       a6,#-10
[00003f2c] 2eae 0008                 move.l     8(a6),(a7)
[00003f30] 4eba ff52                 jsr        _p1error(pc)
_recover_2:
[00003f34] 486e fffa                 pea.l      -6(a6)
[00003f38] 4eba f5ac                 jsr        _gettok1(pc)
[00003f3c] 588f                      addq.l     #4,a7
[00003f3e] 2447                      movea.l    d7,a2
[00003f40] 4287                      clr.l      d7
[00003f42] 1e12                      move.b     (a2),d7
[00003f44] 0c47 00ff                 cmpi.w     #$00FF,d7
[00003f48] 671c                      beq.s      _recover_1
[00003f4a] 4287                      clr.l      d7
[00003f4c] 1e2e fffa                 move.b     -6(a6),d7
[00003f50] beae 000c                 cmp.l      12(a6),d7
[00003f54] 6710                      beq.s      _recover_1
[00003f56] 4287                      clr.l      d7
[00003f58] 1e2e fffa                 move.b     -6(a6),d7
[00003f5c] 0c47 000b                 cmpi.w     #$000B,d7
[00003f60] 66d2                      bne.s      _recover_2
[00003f62] 4e5e                      unlk       a6
[00003f64] 4e75                      rts
_recover_1:
[00003f66] 486e fffa                 pea.l      -6(a6)
[00003f6a] 4eba f278                 jsr        _baktok1(pc)
[00003f6e] 588f                      addq.l     #4,a7
[00003f70] 4e5e                      unlk       a6
[00003f72] 4e75                      rts

_chktyp:
[00003f74] 4e56 0000                 link       a6,#0
[00003f78] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00003f7c] 2a6e 0008                 movea.l    8(a6),a5
[00003f80] 2a2e 000c                 move.l     12(a6),d5
[00003f84] 0285 ffff f3ff            andi.l     #$FFFFF3FF,d5
[00003f8a] 4284                      clr.l      d4
_chktyp_5:
[00003f8c] 2e04                      move.l     d4,d7
[00003f8e] e387                      asl.l      #1,d7
[00003f90] 2447                      movea.l    d7,a2
[00003f92] d5fc 0002 0e5a            adda.l     #_legals,a2
[00003f98] 4287                      clr.l      d7
[00003f9a] 3e12                      move.w     (a2),d7
[00003f9c] 0c87 0000 8000            cmpi.l     #$00008000,d7
[00003fa2] 6714                      beq.s      _chktyp_1
[00003fa4] 2e04                      move.l     d4,d7
[00003fa6] e387                      asl.l      #1,d7
[00003fa8] 2447                      movea.l    d7,a2
[00003faa] d5fc 0002 0e5a            adda.l     #_legals,a2
[00003fb0] 4287                      clr.l      d7
[00003fb2] 3e12                      move.w     (a2),d7
[00003fb4] be85                      cmp.l      d5,d7
[00003fb6] 662c                      bne.s      _chktyp_2
_chktyp_1:
[00003fb8] 2e04                      move.l     d4,d7
[00003fba] e387                      asl.l      #1,d7
[00003fbc] 2447                      movea.l    d7,a2
[00003fbe] d5fc 0002 0e5a            adda.l     #_legals,a2
[00003fc4] 4287                      clr.l      d7
[00003fc6] 3e12                      move.w     (a2),d7
[00003fc8] 0c87 0000 8000            cmpi.l     #$00008000,d7
[00003fce] 6618                      bne.s      _chktyp_3
[00003fd0] 2ebc 0002 0ef8            move.l     #$00020EF8,(a7) "illegal type specification"
[00003fd6] 4eb9 0000 3e84            jsr        _p1error
[00003fdc] 2a7c 0002 0dc2            movea.l    #_atint,a5
[00003fe2] 601a                      bra.s      _chktyp_4
_chktyp_2:
[00003fe4] 5284                      addq.l     #1,d4
[00003fe6] 60a4                      bra.s      _chktyp_5
_chktyp_3:
[00003fe8] 0c85 0000 0200            cmpi.l     #$00000200,d5
[00003fee] 670e                      beq.s      _chktyp_4
[00003ff0] 2e04                      move.l     d4,d7
[00003ff2] e587                      asl.l      #2,d7
[00003ff4] 2447                      movea.l    d7,a2
[00003ff6] d5fc 0002 0e90            adda.l     #_legalatt,a2
[00003ffc] 2a52                      movea.l    (a2),a5
_chktyp_4:
[00003ffe] 4287                      clr.l      d7
[00004000] 1e2d 0008                 move.b     8(a5),d7
[00004004] 0c47 004a                 cmpi.w     #$004A,d7
[00004008] 6604                      bne.s      _chktyp_6
[0000400a] 2a6d 0004                 movea.l    4(a5),a5
_chktyp_6:
[0000400e] 2e0d                      move.l     a5,d7
[00004010] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00004014] 4e5e                      unlk       a6
[00004016] 4e75                      rts

_decsu:
[00004018] 4e56 ff40                 link       a6,#-192
[0000401c] 48e7 8c0c                 movem.l    d0/d4-d5/a4-a5,-(a7)
[00004020] 4ab9 0002 0b7e            tst.l      _lflag
[00004026] 6704                      beq.s      _decsu_1
[00004028] 7e20                      moveq.l    #32,d7
[0000402a] 6002                      bra.s      _decsu_2
_decsu_1:
[0000402c] 7e10                      moveq.l    #16,d7
_decsu_2:
[0000402e] 2d47 fff8                 move.l     d7,-8(a6)
[00004032] 0cae 0000 0035 0008       cmpi.l     #$00000035,8(a6)
[0000403a] 6604                      bne.s      _decsu_3
[0000403c] 7e48                      moveq.l    #72,d7
[0000403e] 6010                      bra.s      _decsu_4
_decsu_3:
[00004040] 0cae 0000 0038 0008       cmpi.l     #$00000038,8(a6)
[00004048] 6604                      bne.s      _decsu_5
[0000404a] 7e49                      moveq.l    #73,d7
[0000404c] 6002                      bra.s      _decsu_4
_decsu_5:
[0000404e] 7e4a                      moveq.l    #74,d7
_decsu_4:
[00004050] 1d47 ff41                 move.b     d7,-191(a6)
[00004054] 42ae ffce                 clr.l      -50(a6)
[00004058] 42ae ffd2                 clr.l      -46(a6)
[0000405c] 45ee ffd2                 lea.l      -46(a6),a2
[00004060] 2d4a ffd6                 move.l     a2,-42(a6)
[00004064] 42ae fff0                 clr.l      -16(a6)
[00004068] 42ae fff4                 clr.l      -12(a6)
[0000406c] 4285                      clr.l      d5
[0000406e] 486e ff42                 pea.l      -190(a6)
[00004072] 4eb9 0000 3bae            jsr        _ident
[00004078] 588f                      addq.l     #4,a7
[0000407a] 4a87                      tst.l      d7
[0000407c] 662a                      bne.s      _decsu_6
[0000407e] 4878 0005                 pea.l      ($00000005).w
[00004082] 4eb9 0000 3e50            jsr        _peek
[00004088] 588f                      addq.l     #4,a7
[0000408a] 4a87                      tst.l      d7
[0000408c] 667a                      bne.s      _decsu_7
[0000408e] 2ebc 0002 0faf            move.l     #$00020FAF,(a7) "incomplete type"
[00004094] 4eb9 0000 3e84            jsr        _p1error
[0000409a] 2e3c 0002 0dc2            move.l     #_atint,d7
[000040a0] 4cdf 3031                 movem.l    (a7)+,d0/d4-d5/a4-a5
[000040a4] 4e5e                      unlk       a6
[000040a6] 4e75                      rts
_decsu_6:
[000040a8] 246e ff44                 movea.l    -188(a6),a2
[000040ac] 4287                      clr.l      d7
[000040ae] 1e12                      move.b     (a2),d7
[000040b0] 2e87                      move.l     d7,(a7)
[000040b2] 5297                      addq.l     #1,(a7)
[000040b4] 2f2e ff44                 move.l     -188(a6),-(a7)
[000040b8] 486e ff4d                 pea.l      -179(a6)
[000040bc] 4eb9 0000 adac            jsr        _cpybuf
[000040c2] 508f                      addq.l     #8,a7
[000040c4] 522e ff4d                 addq.b     #1,-179(a6)
[000040c8] 4287                      clr.l      d7
[000040ca] 1e2e ff4d                 move.b     -179(a6),d7
[000040ce] 2447                      movea.l    d7,a2
[000040d0] 49ee ff4d                 lea.l      -179(a6),a4
[000040d4] d5cc                      adda.l     a4,a2
[000040d6] 14bc 007c                 move.b     #$7C,(a2)
[000040da] 45ee ff4d                 lea.l      -179(a6),a2
[000040de] 2d4a ff48                 move.l     a2,-184(a6)
[000040e2] 2eb9 0002 0d2a            move.l     _symend,(a7)
[000040e8] 2f39 0002 0d2e            move.l     _symtab,-(a7)
[000040ee] 486e ff4d                 pea.l      -179(a6)
[000040f2] 4eb9 0000 847e            jsr        _lookup
[000040f8] 508f                      addq.l     #8,a7
[000040fa] 2d47 ffce                 move.l     d7,-50(a6)
[000040fe] 6770                      beq.s      _decsu_8
[00004100] 42ae ff48                 clr.l      -184(a6)
[00004104] 6000 0092                 bra        _decsu_9
_decsu_7:
[00004108] 2d7c 0002 077c ff48       move.l     #_noname,-184(a6)
_decsu_11:
[00004110] 4aae ff48                 tst.l      -184(a6)
[00004114] 6700 00ee                 beq        _decsu_10
[00004118] 4297                      clr.l      (a7)
[0000411a] 2f2e ff48                 move.l     -184(a6),-(a7)
[0000411e] 42a7                      clr.l      -(a7)
[00004120] 4287                      clr.l      d7
[00004122] 1e2e ff41                 move.b     -191(a6),d7
[00004126] 2f07                      move.l     d7,-(a7)
[00004128] 4eb9 0000 79aa            jsr        _buyattr
[0000412e] 508f                      addq.l     #8,a7
[00004130] 2f07                      move.l     d7,-(a7)
[00004132] 4eb9 0000 7a78            jsr        _buysym
[00004138] 508f                      addq.l     #8,a7
[0000413a] 2d47 ffce                 move.l     d7,-50(a6)
[0000413e] 2ebc 0002 0d2e            move.l     #_symtab,(a7)
[00004144] 2f2e ffce                 move.l     -50(a6),-(a7)
[00004148] 4eb9 0000 774e            jsr        _addsym
[0000414e] 588f                      addq.l     #4,a7
[00004150] 45f8 000a                 lea.l      ($0000000A).w,a2
[00004154] 286e ffce                 movea.l    -50(a6),a4
[00004158] 588c                      addq.l     #4,a4
[0000415a] d5d4                      adda.l     (a4),a2
[0000415c] 24ae ffce                 move.l     -50(a6),(a2)
[00004160] 45f8 000f                 lea.l      ($0000000F).w,a2
[00004164] d5ee ffce                 adda.l     -50(a6),a2
[00004168] 14bc 0001                 move.b     #$01,(a2)
[0000416c] 6000 0096                 bra        _decsu_10
_decsu_8:
[00004170] 4878 000b                 pea.l      ($0000000B).w
[00004174] 4eb9 0000 3e50            jsr        _peek
[0000417a] 588f                      addq.l     #4,a7
[0000417c] 4a87                      tst.l      d7
[0000417e] 6618                      bne.s      _decsu_9
[00004180] 4297                      clr.l      (a7)
[00004182] 2f39 0002 0d2a            move.l     _symend,-(a7)
[00004188] 486e ff4d                 pea.l      -179(a6)
[0000418c] 4eb9 0000 847e            jsr        _lookup
[00004192] 508f                      addq.l     #8,a7
[00004194] 2d47 ffce                 move.l     d7,-50(a6)
_decsu_9:
[00004198] 4aae ffce                 tst.l      -50(a6)
[0000419c] 6700 ff72                 beq        _decsu_11
[000041a0] 246e ffce                 movea.l    -50(a6),a2
[000041a4] 588a                      addq.l     #4,a2
[000041a6] 2452                      movea.l    (a2),a2
[000041a8] 508a                      addq.l     #8,a2
[000041aa] 4287                      clr.l      d7
[000041ac] 1e12                      move.b     (a2),d7
[000041ae] 4286                      clr.l      d6
[000041b0] 1c2e ff41                 move.b     -191(a6),d6
[000041b4] be86                      cmp.l      d6,d7
[000041b6] 661a                      bne.s      _decsu_12
[000041b8] 246e ffce                 movea.l    -50(a6),a2
[000041bc] 508a                      addq.l     #8,a2
[000041be] 4a92                      tst.l      (a2)
[000041c0] 673a                      beq.s      _decsu_13
[000041c2] 4878 0005                 pea.l      ($00000005).w
[000041c6] 4eb9 0000 3e50            jsr        _peek
[000041cc] 588f                      addq.l     #4,a7
[000041ce] 4a87                      tst.l      d7
[000041d0] 672a                      beq.s      _decsu_13
_decsu_12:
[000041d2] 4aae ff48                 tst.l      -184(a6)
[000041d6] 6600 ff38                 bne        _decsu_11
[000041da] 7e10                      moveq.l    #16,d7
[000041dc] deae ffce                 add.l      -50(a6),d7
[000041e0] 2e87                      move.l     d7,(a7)
[000041e2] 2f3c 0002 0fa1            move.l     #$00020FA1,-(a7) "redefined tag"
[000041e8] 4eb9 0000 3c8a            jsr        _nmerr
[000041ee] 588f                      addq.l     #4,a7
[000041f0] 45ee ff4d                 lea.l      -179(a6),a2
[000041f4] 2d4a ff48                 move.l     a2,-184(a6)
[000041f8] 6000 ff16                 bra        _decsu_11
_decsu_13:
[000041fc] 42ae ff48                 clr.l      -184(a6)
[00004200] 6000 ff0e                 bra        _decsu_11
_decsu_10:
[00004204] 4878 0005                 pea.l      ($00000005).w
[00004208] 4eb9 0000 332e            jsr        _eat
[0000420e] 588f                      addq.l     #4,a7
[00004210] 4a87                      tst.l      d7
[00004212] 672c                      beq.s      _decsu_14
_decsu_20:
[00004214] 4878 0009                 pea.l      ($00000009).w
[00004218] 4eb9 0000 332e            jsr        _eat
[0000421e] 588f                      addq.l     #4,a7
[00004220] 4a87                      tst.l      d7
[00004222] 661c                      bne.s      _decsu_14
[00004224] 4287                      clr.l      d7
[00004226] 1e2e ff41                 move.b     -191(a6),d7
[0000422a] 0c47 004a                 cmpi.w     #$004A,d7
[0000422e] 6628                      bne.s      _decsu_15
[00004230] 486e ff42                 pea.l      -190(a6)
[00004234] 4eb9 0000 3bae            jsr        _ident
[0000423a] 588f                      addq.l     #4,a7
[0000423c] 4a87                      tst.l      d7
[0000423e] 662e                      bne.s      _decsu_16
_decsu_14:
[00004240] 4287                      clr.l      d7
[00004242] 1e2e ff41                 move.b     -191(a6),d7
[00004246] 0c47 004a                 cmpi.w     #$004A,d7
[0000424a] 6700 0306                 beq        _decsu_17
[0000424e] 246e ffd6                 movea.l    -42(a6),a2
[00004252] 4292                      clr.l      (a2)
[00004254] 6000 02fc                 bra        _decsu_17
_decsu_15:
[00004258] 4297                      clr.l      (a7)
[0000425a] 486e ffde                 pea.l      -34(a6)
[0000425e] 4eb9 0000 4d4c            jsr        _gscty
[00004264] 588f                      addq.l     #4,a7
[00004266] 4a87                      tst.l      d7
[00004268] 6600 0108                 bne        _decsu_18
[0000426c] 60d2                      bra.s      _decsu_14
_decsu_16:
[0000426e] 2eb9 0002 0d2a            move.l     _symend,(a7)
[00004274] 2f39 0002 0d2e            move.l     _symtab,-(a7)
[0000427a] 2f2e ff44                 move.l     -188(a6),-(a7)
[0000427e] 4eb9 0000 847e            jsr        _lookup
[00004284] 508f                      addq.l     #8,a7
[00004286] 2a47                      movea.l    d7,a5
[00004288] 2e0d                      move.l     a5,d7
[0000428a] 6716                      beq.s      _decsu_19
[0000428c] 2eae ff44                 move.l     -188(a6),(a7)
[00004290] 2f3c 0002 0f89            move.l     #$00020F89,-(a7) "redeclared enum element"
[00004296] 4eb9 0000 3c8a            jsr        _nmerr
[0000429c] 588f                      addq.l     #4,a7
[0000429e] 6000 ff74                 bra        _decsu_20
_decsu_19:
[000042a2] 4878 003f                 pea.l      ($0000003F).w
[000042a6] 2f2e ff44                 move.l     -188(a6),-(a7)
[000042aa] 42a7                      clr.l      -(a7)
[000042ac] 4eb9 0000 7a78            jsr        _buysym
[000042b2] 4fef 000c                 lea.l      12(a7),a7
[000042b6] 2a47                      movea.l    d7,a5
[000042b8] 2ebc 0000 0088            move.l     #$00000088,(a7)
[000042be] 4eb9 0000 332e            jsr        _eat
[000042c4] 4a87                      tst.l      d7
[000042c6] 6710                      beq.s      _decsu_21
[000042c8] 4878 0001                 pea.l      ($00000001).w
[000042cc] 4eb9 0000 0b62            jsr        _cons
[000042d2] 588f                      addq.l     #4,a7
[000042d4] 2d47 fff4                 move.l     d7,-12(a6)
_decsu_21:
[000042d8] 2e39 0002 0baa            move.l     _maxint,d7
[000042de] beae fff4                 cmp.l      -12(a6),d7
[000042e2] 6d0c                      blt.s      _decsu_22
[000042e4] 2e2e fff4                 move.l     -12(a6),d7
[000042e8] beb9 0002 0bae            cmp.l      _minint,d7
[000042ee] 6c12                      bge.s      _decsu_23
_decsu_22:
[000042f0] 486d 0010                 pea.l      16(a5)
[000042f4] 2f3c 0002 0f64            move.l     #$00020F64,-(a7) "enumeration constant larger than int"
[000042fa] 4eb9 0000 3c8a            jsr        _nmerr
[00004300] 508f                      addq.l     #8,a7
_decsu_23:
[00004302] 4aae fff4                 tst.l      -12(a6)
[00004306] 6f12                      ble.s      _decsu_24
[00004308] 2e2e fff0                 move.l     -16(a6),d7
[0000430c] beae fff4                 cmp.l      -12(a6),d7
[00004310] 6c08                      bge.s      _decsu_24
[00004312] 2d6e fff4 fff0            move.l     -12(a6),-16(a6)
[00004318] 6022                      bra.s      _decsu_25
_decsu_24:
[0000431a] 4aae fff4                 tst.l      -12(a6)
[0000431e] 6c1c                      bge.s      _decsu_25
[00004320] 2e2e fff0                 move.l     -16(a6),d7
[00004324] 2c2e fff4                 move.l     -12(a6),d6
[00004328] 5286                      addq.l     #1,d6
[0000432a] 4486                      neg.l      d6
[0000432c] be86                      cmp.l      d6,d7
[0000432e] 6c0c                      bge.s      _decsu_25
[00004330] 2e2e fff4                 move.l     -12(a6),d7
[00004334] 5287                      addq.l     #1,d7
[00004336] 4487                      neg.l      d7
[00004338] 2d47 fff0                 move.l     d7,-16(a6)
_decsu_25:
[0000433c] 1b7c 0001 000f            move.b     #$01,15(a5)
[00004342] 2b6e fff4 0008            move.l     -12(a6),8(a5)
[00004348] 2ebc 0002 0d2e            move.l     #_symtab,(a7)
[0000434e] 2f0d                      move.l     a5,-(a7)
[00004350] 4eb9 0000 774e            jsr        _addsym
[00004356] 588f                      addq.l     #4,a7
[00004358] 2d4d ffd2                 move.l     a5,-46(a6)
[0000435c] 52ae fff4                 addq.l     #1,-12(a6)
[00004360] 5285                      addq.l     #1,d5
[00004362] 4878 0002                 pea.l      ($00000002).w
[00004366] 4eb9 0000 332e            jsr        _eat
[0000436c] 588f                      addq.l     #4,a7
[0000436e] 6000 fea4                 bra        _decsu_20
_decsu_18:
[00004372] 4297                      clr.l      (a7)
[00004374] 486e ffde                 pea.l      -34(a6)
[00004378] 4eb9 0000 4b1e            jsr        _gdecl
[0000437e] 588f                      addq.l     #4,a7
[00004380] 2a47                      movea.l    d7,a5
[00004382] 2e0d                      move.l     a5,d7
[00004384] 6612                      bne.s      _decsu_26
[00004386] 4878 0001                 pea.l      ($00000001).w
[0000438a] 4eb9 0000 3e50            jsr        _peek
[00004390] 588f                      addq.l     #4,a7
[00004392] 4a87                      tst.l      d7
[00004394] 6700 01ac                 beq        _decsu_27
_decsu_26:
[00004398] 2e0d                      move.l     a5,d7
[0000439a] 661a                      bne.s      _decsu_28
[0000439c] 4297                      clr.l      (a7)
[0000439e] 2f3c 0002 077c            move.l     #_noname,-(a7)
[000043a4] 2f3c 0002 0dc2            move.l     #_atint,-(a7)
[000043aa] 4eb9 0000 7a78            jsr        _buysym
[000043b0] 508f                      addq.l     #8,a7
[000043b2] 2a47                      movea.l    d7,a5
[000043b4] 6028                      bra.s      _decsu_29
_decsu_28:
[000043b6] 4297                      clr.l      (a7)
[000043b8] 2f2e ffd2                 move.l     -46(a6),-(a7)
[000043bc] 486d 0010                 pea.l      16(a5)
[000043c0] 4eb9 0000 847e            jsr        _lookup
[000043c6] 508f                      addq.l     #8,a7
[000043c8] 4a87                      tst.l      d7
[000043ca] 6712                      beq.s      _decsu_29
[000043cc] 486d 0010                 pea.l      16(a5)
[000043d0] 2f3c 0002 0f53            move.l     #$00020F53,-(a7) "member redefined"
[000043d6] 4eb9 0000 3c8a            jsr        _nmerr
[000043dc] 508f                      addq.l     #8,a7
_decsu_29:
[000043de] 026d f000 000c            andi.w     #$F000,12(a5)
[000043e4] 246e ffd6                 movea.l    -42(a6),a2
[000043e8] 248d                      move.l     a5,(a2)
[000043ea] 2d4d ffd6                 move.l     a5,-42(a6)
[000043ee] 4878 0001                 pea.l      ($00000001).w
[000043f2] 4eb9 0000 332e            jsr        _eat
[000043f8] 588f                      addq.l     #4,a7
[000043fa] 4a87                      tst.l      d7
[000043fc] 660c                      bne.s      _decsu_30
[000043fe] 4285                      clr.l      d5
[00004400] 7001                      moveq.l    #1,d0
[00004402] 2d40 fffc                 move.l     d0,-4(a6)
[00004406] 6000 00c4                 bra        _decsu_31
_decsu_30:
[0000440a] 4287                      clr.l      d7
[0000440c] 1e2e ff41                 move.b     -191(a6),d7
[00004410] 0c47 0048                 cmpi.w     #$0048,d7
[00004414] 670c                      beq.s      _decsu_32
[00004416] 2ebc 0002 0f45            move.l     #$00020F45,(a7) "illegal field"
[0000441c] 4eb9 0000 3e84            jsr        _p1error
_decsu_32:
[00004422] 4878 0001                 pea.l      ($00000001).w
[00004426] 4eb9 0000 0b62            jsr        _cons
[0000442c] 588f                      addq.l     #4,a7
[0000442e] 2807                      move.l     d7,d4
[00004430] 246d 0004                 movea.l    4(a5),a2
[00004434] 508a                      addq.l     #8,a2
[00004436] 4287                      clr.l      d7
[00004438] 1e12                      move.b     (a2),d7
[0000443a] 0c47 0018                 cmpi.w     #$0018,d7
[0000443e] 671c                      beq.s      _decsu_33
[00004440] 246d 0004                 movea.l    4(a5),a2
[00004444] 508a                      addq.l     #8,a2
[00004446] 4287                      clr.l      d7
[00004448] 1e12                      move.b     (a2),d7
[0000444a] 0c47 001a                 cmpi.w     #$001A,d7
[0000444e] 670c                      beq.s      _decsu_33
[00004450] 2ebc 0002 0f34            move.l     #$00020F34,(a7) "illegal bitfield"
[00004456] 4eb9 0000 3e84            jsr        _p1error
_decsu_33:
[0000445c] 4297                      clr.l      (a7)
[0000445e] 4878 0019                 pea.l      ($00000019).w
[00004462] 4eb9 0000 79aa            jsr        _buyattr
[00004468] 588f                      addq.l     #4,a7
[0000446a] 2b47 0004                 move.l     d7,4(a5)
[0000446e] 4a84                      tst.l      d4
[00004470] 6d12                      blt.s      _decsu_34
[00004472] 2e2e fff8                 move.l     -8(a6),d7
[00004476] be84                      cmp.l      d4,d7
[00004478] 650a                      bcs.s      _decsu_34
[0000447a] 4a84                      tst.l      d4
[0000447c] 6616                      bne.s      _decsu_35
[0000447e] 4a2d 0010                 tst.b      16(a5)
[00004482] 6710                      beq.s      _decsu_35
_decsu_34:
[00004484] 2ebc 0002 0f24            move.l     #$00020F24,(a7) "bad field width"
[0000448a] 4eb9 0000 3e84            jsr        _p1error
[00004490] 282e fff8                 move.l     -8(a6),d4
_decsu_35:
[00004494] 45f8 000b                 lea.l      ($0000000B).w,a2
[00004498] d5ed 0004                 adda.l     4(a5),a2
[0000449c] 1484                      move.b     d4,(a2)
[0000449e] 4a84                      tst.l      d4
[000044a0] 6608                      bne.s      _decsu_36
[000044a2] 4285                      clr.l      d5
[000044a4] 42ae fffc                 clr.l      -4(a6)
[000044a8] 6022                      bra.s      _decsu_31
_decsu_36:
[000044aa] 4a85                      tst.l      d5
[000044ac] 670c                      beq.s      _decsu_37
[000044ae] 2e2e fff8                 move.l     -8(a6),d7
[000044b2] 2c04                      move.l     d4,d6
[000044b4] dc85                      add.l      d5,d6
[000044b6] be86                      cmp.l      d6,d7
[000044b8] 6424                      bcc.s      _decsu_38
_decsu_37:
[000044ba] 45f8 000a                 lea.l      ($0000000A).w,a2
[000044be] d5ed 0004                 adda.l     4(a5),a2
[000044c2] 4212                      clr.b      (a2)
[000044c4] 2a04                      move.l     d4,d5
[000044c6] 7001                      moveq.l    #1,d0
[000044c8] 2d40 fffc                 move.l     d0,-4(a6)
_decsu_31:
[000044cc] 4287                      clr.l      d7
[000044ce] 1e2e ff41                 move.b     -191(a6),d7
[000044d2] 0c47 0049                 cmpi.w     #$0049,d7
[000044d6] 6618                      bne.s      _decsu_39
[000044d8] 42ad 0008                 clr.l      8(a5)
[000044dc] 6052                      bra.s      _decsu_40
_decsu_38:
[000044de] 45f8 000a                 lea.l      ($0000000A).w,a2
[000044e2] d5ed 0004                 adda.l     4(a5),a2
[000044e6] 1485                      move.b     d5,(a2)
[000044e8] da84                      add.l      d4,d5
[000044ea] 42ae fffc                 clr.l      -4(a6)
[000044ee] 60dc                      bra.s      _decsu_31
_decsu_39:
[000044f0] 4aae fffc                 tst.l      -4(a6)
[000044f4] 6608                      bne.s      _decsu_41
[000044f6] 2b6e fff4 0008            move.l     -12(a6),8(a5)
[000044fc] 6032                      bra.s      _decsu_40
_decsu_41:
[000044fe] 2eae fff0                 move.l     -16(a6),(a7)
[00004502] 2f2d 0004                 move.l     4(a5),-(a7)
[00004506] 4eb9 0000 7874            jsr        _bndify
[0000450c] 588f                      addq.l     #4,a7
[0000450e] 2b47 0008                 move.l     d7,8(a5)
[00004512] 4878 0001                 pea.l      ($00000001).w
[00004516] 2f2d 0004                 move.l     4(a5),-(a7)
[0000451a] 4eb9 0000 7b74            jsr        _bytes
[00004520] 508f                      addq.l     #8,a7
[00004522] dead 0008                 add.l      8(a5),d7
[00004526] 2d47 fff0                 move.l     d7,-16(a6)
[0000452a] 2d6d 0008 fff4            move.l     8(a5),-12(a6)
_decsu_40:
[00004530] 4878 0002                 pea.l      ($00000002).w
[00004534] 4eb9 0000 332e            jsr        _eat
[0000453a] 588f                      addq.l     #4,a7
[0000453c] 4a87                      tst.l      d7
[0000453e] 6600 fe32                 bne        _decsu_18
_decsu_27:
[00004542] 4878 000b                 pea.l      ($0000000B).w
[00004546] 4eb9 0000 3c08            jsr        _need
[0000454c] 588f                      addq.l     #4,a7
[0000454e] 6000 fcc4                 bra        _decsu_20
_decsu_17:
[00004552] 4ab9 0002 0b86            tst.l      _mflag
[00004558] 661e                      bne.s      _decsu_42
[0000455a] 4287                      clr.l      d7
[0000455c] 1e2e ff41                 move.b     -191(a6),d7
[00004560] 0c47 004a                 cmpi.w     #$004A,d7
[00004564] 6712                      beq.s      _decsu_42
[00004566] 2a6e ffd2                 movea.l    -46(a6),a5
_decsu_48:
[0000456a] 2e0d                      move.l     a5,d7
[0000456c] 670a                      beq.s      _decsu_42
[0000456e] 4a2d 0010                 tst.b      16(a5)
[00004572] 661a                      bne.s      _decsu_43
[00004574] 6000 00a0                 bra        _decsu_44
_decsu_42:
[00004578] 4aae ffd2                 tst.l      -46(a6)
[0000457c] 6700 009e                 beq        _decsu_45
[00004580] 246e ffce                 movea.l    -50(a6),a2
[00004584] 508a                      addq.l     #8,a2
[00004586] 24ae ffd2                 move.l     -46(a6),(a2)
[0000458a] 6000 0090                 bra        _decsu_45
_decsu_43:
[0000458e] 4297                      clr.l      (a7)
[00004590] 2f39 0002 0d22            move.l     _mostab,-(a7)
[00004596] 486d 0010                 pea.l      16(a5)
[0000459a] 4eb9 0000 847e            jsr        _lookup
[000045a0] 508f                      addq.l     #8,a7
[000045a2] 2d47 ffda                 move.l     d7,-38(a6)
[000045a6] 6634                      bne.s      _decsu_46
[000045a8] 4297                      clr.l      (a7)
[000045aa] 486d 0010                 pea.l      16(a5)
[000045ae] 2f2d 0004                 move.l     4(a5),-(a7)
[000045b2] 4eb9 0000 7a78            jsr        _buysym
[000045b8] 508f                      addq.l     #8,a7
[000045ba] 2d47 ffda                 move.l     d7,-38(a6)
[000045be] 246e ffda                 movea.l    -38(a6),a2
[000045c2] 508a                      addq.l     #8,a2
[000045c4] 24ad 0008                 move.l     8(a5),(a2)
[000045c8] 2ebc 0002 0d22            move.l     #_mostab,(a7)
[000045ce] 2f2e ffda                 move.l     -38(a6),-(a7)
[000045d2] 4eb9 0000 774e            jsr        _addsym
[000045d8] 588f                      addq.l     #4,a7
[000045da] 603a                      bra.s      _decsu_44
_decsu_46:
[000045dc] 4297                      clr.l      (a7)
[000045de] 246e ffda                 movea.l    -38(a6),a2
[000045e2] 588a                      addq.l     #4,a2
[000045e4] 2f12                      move.l     (a2),-(a7)
[000045e6] 2f2d 0004                 move.l     4(a5),-(a7)
[000045ea] 4eb9 0000 7d40            jsr        _cmptype
[000045f0] 508f                      addq.l     #8,a7
[000045f2] 4a87                      tst.l      d7
[000045f4] 670e                      beq.s      _decsu_47
[000045f6] 246e ffda                 movea.l    -38(a6),a2
[000045fa] 508a                      addq.l     #8,a2
[000045fc] 2e12                      move.l     (a2),d7
[000045fe] bead 0008                 cmp.l      8(a5),d7
[00004602] 6712                      beq.s      _decsu_44
_decsu_47:
[00004604] 486d 0010                 pea.l      16(a5)
[00004608] 2f3c 0002 0f14            move.l     #$00020F14,-(a7) "member conflict"
[0000460e] 4eb9 0000 3c8a            jsr        _nmerr
[00004614] 508f                      addq.l     #8,a7
_decsu_44:
[00004616] 2a55                      movea.l    (a5),a5
[00004618] 6000 ff50                 bra        _decsu_48
_decsu_45:
[0000461c] 4287                      clr.l      d7
[0000461e] 1e2e ff41                 move.b     -191(a6),d7
[00004622] 0c47 004a                 cmpi.w     #$004A,d7
[00004626] 664a                      bne.s      _decsu_49
[00004628] 4aae ff48                 tst.l      -184(a6)
[0000462c] 6744                      beq.s      _decsu_49
[0000462e] 246e ffce                 movea.l    -50(a6),a2
[00004632] 588a                      addq.l     #4,a2
[00004634] 2452                      movea.l    (a2),a2
[00004636] 588a                      addq.l     #4,a2
[00004638] 2e8a                      move.l     a2,(a7)
[0000463a] 0cae 0000 0080 fff0       cmpi.l     #$00000080,-16(a6)
[00004642] 6c08                      bge.s      _decsu_50
[00004644] 2e3c 0002 0d68            move.l     #_atchar,d7
[0000464a] 6006                      bra.s      _decsu_51
_decsu_50:
[0000464c] 2e3c 0002 0d9e            move.l     #_atshort,d7
_decsu_51:
[00004652] 2257                      movea.l    (a7),a1
[00004654] 2287                      move.l     d7,(a1)
[00004656] 2a6e ffd2                 movea.l    -46(a6),a5
_decsu_52:
[0000465a] 4a85                      tst.l      d5
[0000465c] 6714                      beq.s      _decsu_49
[0000465e] 246e ffce                 movea.l    -50(a6),a2
[00004662] 588a                      addq.l     #4,a2
[00004664] 2452                      movea.l    (a2),a2
[00004666] 588a                      addq.l     #4,a2
[00004668] 2b52 0004                 move.l     (a2),4(a5)
[0000466c] 5385                      subq.l     #1,d5
[0000466e] 2a55                      movea.l    (a5),a5
[00004670] 60e8                      bra.s      _decsu_52
_decsu_49:
[00004672] 246e ffce                 movea.l    -50(a6),a2
[00004676] 588a                      addq.l     #4,a2
[00004678] 2e12                      move.l     (a2),d7
[0000467a] 4cdf 3031                 movem.l    (a7)+,d0/d4-d5/a4-a5
[0000467e] 4e5e                      unlk       a6
[00004680] 4e75                      rts

_dterm:
[00004682] 4e56 ffd8                 link       a6,#-40
[00004686] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000468a] 2ebc 0000 00e2            move.l     #$000000E2,(a7)
[00004690] 4eb9 0000 332e            jsr        _eat
[00004696] 4a87                      tst.l      d7
[00004698] 674a                      beq.s      _dterm_1
[0000469a] 426e fffe                 clr.w      -2(a6)
[0000469e] 426e fffc                 clr.w      -4(a6)
_dterm_3:
[000046a2] 2ebc 0002 0fc3            move.l     #$00020FC3,(a7)
[000046a8] 4eb9 0000 3192            jsr        _alt
[000046ae] 2a07                      move.l     d7,d5
[000046b0] 6762                      beq.s      _dterm_2
[000046b2] 4287                      clr.l      d7
[000046b4] 3e2e fffe                 move.w     -2(a6),d7
[000046b8] 2e87                      move.l     d7,(a7)
[000046ba] 2f05                      move.l     d5,-(a7)
[000046bc] 4eb9 0000 4efc            jsr        _gtypspec
[000046c2] 588f                      addq.l     #4,a7
[000046c4] 3d47 fffe                 move.w     d7,-2(a6)
[000046c8] 0c85 0000 000c            cmpi.l     #$0000000C,d5
[000046ce] 66d2                      bne.s      _dterm_3
[000046d0] 4287                      clr.l      d7
[000046d2] 3e2e fffc                 move.w     -4(a6),d7
[000046d6] 2e87                      move.l     d7,(a7)
[000046d8] 4eb9 0000 33d6            jsr        _getspace
[000046de] 3d47 fffc                 move.w     d7,-4(a6)
[000046e2] 60be                      bra.s      _dterm_3
_dterm_1:
[000046e4] 4878 0006                 pea.l      ($00000006).w
[000046e8] 4eb9 0000 332e            jsr        _eat
[000046ee] 588f                      addq.l     #4,a7
[000046f0] 2a07                      move.l     d7,d5
[000046f2] 6700 009e                 beq        _dterm_4
[000046f6] 4aae 0008                 tst.l      8(a6)
[000046fa] 6700 00da                 beq        _dterm_5
[000046fe] 4878 000a                 pea.l      ($0000000A).w
[00004702] 4eb9 0000 332e            jsr        _eat
[00004708] 588f                      addq.l     #4,a7
[0000470a] 2a07                      move.l     d7,d5
[0000470c] 6600 0084                 bne        _dterm_4
[00004710] 6000 00c4                 bra        _dterm_5
_dterm_2:
[00004714] 2eae 0008                 move.l     8(a6),(a7)
[00004718] 4eba ff68                 jsr        _dterm(pc)
[0000471c] 2847                      movea.l    d7,a4
[0000471e] 2e0c                      move.l     a4,d7
[00004720] 6620                      bne.s      _dterm_6
[00004722] 2ebc 0002 102d            move.l     #$0002102D,(a7) "bad *declaration"
[00004728] 4eb9 0000 3e84            jsr        _p1error
[0000472e] 4297                      clr.l      (a7)
[00004730] 2f3c 0002 077c            move.l     #_noname,-(a7)
[00004736] 42a7                      clr.l      -(a7)
[00004738] 4eb9 0000 7a78            jsr        _buysym
[0000473e] 508f                      addq.l     #8,a7
[00004740] 2847                      movea.l    d7,a4
_dterm_6:
[00004742] 4287                      clr.l      d7
[00004744] 3e2e fffe                 move.w     -2(a6),d7
[00004748] 0807 000a                 btst       #10,d7
[0000474c] 6706                      beq.s      _dterm_7
[0000474e] 08ee 0005 fffc            bset       #5,-4(a6)
_dterm_7:
[00004754] 4287                      clr.l      d7
[00004756] 3e2e fffe                 move.w     -2(a6),d7
[0000475a] 0807 000b                 btst       #11,d7
[0000475e] 6706                      beq.s      _dterm_8
[00004760] 08ee 0006 fffc            bset       #6,-4(a6)
_dterm_8:
[00004766] 4297                      clr.l      (a7)
[00004768] 4878 0040                 pea.l      ($00000040).w
[0000476c] 4eb9 0000 79aa            jsr        _buyattr
[00004772] 588f                      addq.l     #4,a7
[00004774] 2a47                      movea.l    d7,a5
[00004776] 3b6e fffc 000a            move.w     -4(a6),10(a5)
[0000477c] 2e8d                      move.l     a5,(a7)
[0000477e] 2f0c                      move.l     a4,-(a7)
[00004780] 4eb9 0000 7846            jsr        _addtype
[00004786] 588f                      addq.l     #4,a7
[00004788] 2e0c                      move.l     a4,d7
[0000478a] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000478e] 4e5e                      unlk       a6
[00004790] 4e75                      rts
_dterm_4:
[00004792] 0c85 0000 000a            cmpi.l     #$0000000A,d5
[00004798] 6678                      bne.s      _dterm_9
[0000479a] 1d7c 000a ffd8            move.b     #$0A,-40(a6)
[000047a0] 486e ffd8                 pea.l      -40(a6)
[000047a4] 4eb9 0000 31e4            jsr        _baktok1
[000047aa] 588f                      addq.l     #4,a7
[000047ac] 1d7c 0006 ffd8            move.b     #$06,-40(a6)
[000047b2] 486e ffd8                 pea.l      -40(a6)
[000047b6] 4eb9 0000 31e4            jsr        _baktok1
[000047bc] 588f                      addq.l     #4,a7
[000047be] 4297                      clr.l      (a7)
[000047c0] 2f3c 0002 077c            move.l     #_noname,-(a7)
[000047c6] 42a7                      clr.l      -(a7)
[000047c8] 4eb9 0000 7a78            jsr        _buysym
[000047ce] 508f                      addq.l     #8,a7
[000047d0] 2847                      movea.l    d7,a4
[000047d2] 6000 0082                 bra        _dterm_10
_dterm_5:
[000047d6] 2eae 0008                 move.l     8(a6),(a7)
[000047da] 4eba fea6                 jsr        _dterm(pc)
[000047de] 2847                      movea.l    d7,a4
[000047e0] 2e0c                      move.l     a4,d7
[000047e2] 6620                      bne.s      _dterm_11
[000047e4] 2ebc 0002 101b            move.l     #$0002101B,(a7) "bad (declaration)"
[000047ea] 4eb9 0000 3e84            jsr        _p1error
[000047f0] 4297                      clr.l      (a7)
[000047f2] 2f3c 0002 077c            move.l     #_noname,-(a7)
[000047f8] 42a7                      clr.l      -(a7)
[000047fa] 4eb9 0000 7a78            jsr        _buysym
[00004800] 508f                      addq.l     #8,a7
[00004802] 2847                      movea.l    d7,a4
_dterm_11:
[00004804] 4878 000a                 pea.l      ($0000000A).w
[00004808] 4eb9 0000 3c08            jsr        _need
[0000480e] 588f                      addq.l     #4,a7
[00004810] 6044                      bra.s      _dterm_10
_dterm_9:
[00004812] 486e ffd8                 pea.l      -40(a6)
[00004816] 4eb9 0000 3bae            jsr        _ident
[0000481c] 588f                      addq.l     #4,a7
[0000481e] 4a2e ffd8                 tst.b      -40(a6)
[00004822] 6610                      bne.s      _dterm_12
[00004824] 4aae 0008                 tst.l      8(a6)
[00004828] 660a                      bne.s      _dterm_12
[0000482a] 4287                      clr.l      d7
[0000482c] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00004830] 4e5e                      unlk       a6
[00004832] 4e75                      rts
_dterm_12:
[00004834] 4297                      clr.l      (a7)
[00004836] 4a2e ffd8                 tst.b      -40(a6)
[0000483a] 6706                      beq.s      _dterm_13
[0000483c] 2e2e ffda                 move.l     -38(a6),d7
[00004840] 6006                      bra.s      _dterm_14
_dterm_13:
[00004842] 2e3c 0002 077c            move.l     #_noname,d7
_dterm_14:
[00004848] 2f07                      move.l     d7,-(a7)
[0000484a] 42a7                      clr.l      -(a7)
[0000484c] 4eb9 0000 7a78            jsr        _buysym
[00004852] 508f                      addq.l     #8,a7
[00004854] 2847                      movea.l    d7,a4
_dterm_10:
[00004856] 2ebc 0002 0fc0            move.l     #$00020FC0,(a7)
[0000485c] 4eb9 0000 3192            jsr        _alt
[00004862] 2a07                      move.l     d7,d5
[00004864] 6700 008c                 beq        _dterm_15
[00004868] 0c85 0000 0006            cmpi.l     #$00000006,d5
[0000486e] 6600 008c                 bne        _dterm_16
[00004872] 42ae fff8                 clr.l      -8(a6)
[00004876] 42ae ffe2                 clr.l      -30(a6)
[0000487a] 2d6e ffe2 ffde            move.l     -30(a6),-34(a6)
[00004880] 4297                      clr.l      (a7)
[00004882] 4878 0031                 pea.l      ($00000031).w
[00004886] 4878 003b                 pea.l      ($0000003B).w
[0000488a] 486e ffe6                 pea.l      -26(a6)
[0000488e] 4eb9 0000 4d4c            jsr        _gscty
[00004894] 4fef 000c                 lea.l      12(a7),a7
[00004898] 4a87                      tst.l      d7
[0000489a] 6600 008c                 bne        _dterm_17
[0000489e] 486e ffd8                 pea.l      -40(a6)
[000048a2] 4eb9 0000 3bae            jsr        _ident
[000048a8] 588f                      addq.l     #4,a7
[000048aa] 4a87                      tst.l      d7
[000048ac] 6700 0114                 beq        _dterm_18
[000048b0] 4297                      clr.l      (a7)
[000048b2] 2f2e ffda                 move.l     -38(a6),-(a7)
[000048b6] 42a7                      clr.l      -(a7)
[000048b8] 4eb9 0000 7a78            jsr        _buysym
[000048be] 508f                      addq.l     #8,a7
[000048c0] 2d47 ffe2                 move.l     d7,-30(a6)
[000048c4] 2d6e ffe2 ffde            move.l     -30(a6),-34(a6)
_dterm_25:
[000048ca] 4878 0002                 pea.l      ($00000002).w
[000048ce] 4eb9 0000 332e            jsr        _eat
[000048d4] 588f                      addq.l     #4,a7
[000048d6] 4a87                      tst.l      d7
[000048d8] 6700 00e8                 beq        _dterm_18
[000048dc] 4878 000d                 pea.l      ($0000000D).w
[000048e0] 4eb9 0000 332e            jsr        _eat
[000048e6] 588f                      addq.l     #4,a7
[000048e8] 4a87                      tst.l      d7
[000048ea] 6700 0084                 beq        _dterm_19
[000048ee] 6000 00d2                 bra        _dterm_18
_dterm_15:
[000048f2] 2e0c                      move.l     a4,d7
[000048f4] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000048f8] 4e5e                      unlk       a6
[000048fa] 4e75                      rts
_dterm_16:
[000048fc] 4297                      clr.l      (a7)
[000048fe] 4878 0041                 pea.l      ($00000041).w
[00004902] 4eb9 0000 79aa            jsr        _buyattr
[00004908] 588f                      addq.l     #4,a7
[0000490a] 2a47                      movea.l    d7,a5
[0000490c] 4297                      clr.l      (a7)
[0000490e] 4eb9 0000 0b62            jsr        _cons
[00004914] 2b47 000a                 move.l     d7,10(a5)
[00004918] 4aad 000a                 tst.l      10(a5)
[0000491c] 6c00 01e4                 bge        _dterm_20
[00004920] 42ad 000a                 clr.l      10(a5)
[00004924] 6000 01dc                 bra        _dterm_20
_dterm_17:
[00004928] 4878 0001                 pea.l      ($00000001).w
[0000492c] 486e ffe6                 pea.l      -26(a6)
[00004930] 4eb9 0000 4b1e            jsr        _gdecl
[00004936] 508f                      addq.l     #8,a7
[00004938] 2d47 ffe2                 move.l     d7,-30(a6)
[0000493c] 6700 0084                 beq        _dterm_18
[00004940] 2d6e ffe2 fff8            move.l     -30(a6),-8(a6)
[00004946] 246e ffe2                 movea.l    -30(a6),a2
[0000494a] 588a                      addq.l     #4,a2
[0000494c] 2452                      movea.l    (a2),a2
[0000494e] 508a                      addq.l     #8,a2
[00004950] 4287                      clr.l      d7
[00004952] 1e12                      move.b     (a2),d7
[00004954] 0c47 0050                 cmpi.w     #$0050,d7
[00004958] 6600 00aa                 bne        _dterm_21
[0000495c] 4878 000a                 pea.l      ($0000000A).w
[00004960] 4eb9 0000 3e50            jsr        _peek
[00004966] 588f                      addq.l     #4,a7
[00004968] 4a87                      tst.l      d7
[0000496a] 6700 0098                 beq        _dterm_21
[0000496e] 6052                      bra.s      _dterm_18
_dterm_19:
[00004970] 486e ffd8                 pea.l      -40(a6)
[00004974] 4eb9 0000 3bae            jsr        _ident
[0000497a] 588f                      addq.l     #4,a7
[0000497c] 4a87                      tst.l      d7
[0000497e] 660c                      bne.s      _dterm_22
[00004980] 2ebc 0002 0ff9            move.l     #$00020FF9,(a7) "bad function argument declaration"
[00004986] 4eb9 0000 3e84            jsr        _p1error
_dterm_22:
[0000498c] 246e ffe2                 movea.l    -30(a6),a2
[00004990] 2e8a                      move.l     a2,(a7)
[00004992] 42a7                      clr.l      -(a7)
[00004994] 4a2e ffd8                 tst.b      -40(a6)
[00004998] 6706                      beq.s      _dterm_23
[0000499a] 2e2e ffda                 move.l     -38(a6),d7
[0000499e] 6006                      bra.s      _dterm_24
_dterm_23:
[000049a0] 2e3c 0002 077c            move.l     #_noname,d7
_dterm_24:
[000049a6] 2f07                      move.l     d7,-(a7)
[000049a8] 42a7                      clr.l      -(a7)
[000049aa] 4eb9 0000 7a78            jsr        _buysym
[000049b0] 4fef 000c                 lea.l      12(a7),a7
[000049b4] 2257                      movea.l    (a7),a1
[000049b6] 2287                      move.l     d7,(a1)
[000049b8] 2257                      movea.l    (a7),a1
[000049ba] 2d51 ffe2                 move.l     (a1),-30(a6)
[000049be] 6000 ff0a                 bra        _dterm_25
_dterm_18:
[000049c2] 4297                      clr.l      (a7)
[000049c4] 4878 0042                 pea.l      ($00000042).w
[000049c8] 4eb9 0000 79aa            jsr        _buyattr
[000049ce] 588f                      addq.l     #4,a7
[000049d0] 2a47                      movea.l    d7,a5
[000049d2] 4878 000a                 pea.l      ($0000000A).w
[000049d6] 4eb9 0000 3c08            jsr        _need
[000049dc] 588f                      addq.l     #4,a7
[000049de] 4a87                      tst.l      d7
[000049e0] 6600 00f6                 bne        _dterm_26
_dterm_28:
[000049e4] 4aae ffde                 tst.l      -34(a6)
[000049e8] 6700 010a                 beq        _dterm_27
[000049ec] 246e ffde                 movea.l    -34(a6),a2
[000049f0] 2e92                      move.l     (a2),(a7)
[000049f2] 2f2e ffde                 move.l     -34(a6),-(a7)
[000049f6] 4eb9 0000 aa76            jsr        _free
[000049fc] 588f                      addq.l     #4,a7
[000049fe] 2d47 ffde                 move.l     d7,-34(a6)
[00004a02] 60e0                      bra.s      _dterm_28
_dterm_21:
[00004a04] 2eae ffe2                 move.l     -30(a6),(a7)
[00004a08] 4eb9 0000 8210            jsr        _fixargs
_dterm_32:
[00004a0e] 4878 0002                 pea.l      ($00000002).w
[00004a12] 4eb9 0000 332e            jsr        _eat
[00004a18] 588f                      addq.l     #4,a7
[00004a1a] 4a87                      tst.l      d7
[00004a1c] 67a4                      beq.s      _dterm_18
[00004a1e] 4878 000d                 pea.l      ($0000000D).w
[00004a22] 4eb9 0000 332e            jsr        _eat
[00004a28] 588f                      addq.l     #4,a7
[00004a2a] 4a87                      tst.l      d7
[00004a2c] 670c                      beq.s      _dterm_29
[00004a2e] 246e ffe2                 movea.l    -30(a6),a2
[00004a32] 24bc 0002 0cf2            move.l     #_badsym,(a2)
[00004a38] 6088                      bra.s      _dterm_18
_dterm_29:
[00004a3a] 4297                      clr.l      (a7)
[00004a3c] 4878 0031                 pea.l      ($00000031).w
[00004a40] 4878 003b                 pea.l      ($0000003B).w
[00004a44] 486e ffe6                 pea.l      -26(a6)
[00004a48] 4eb9 0000 4d4c            jsr        _gscty
[00004a4e] 4fef 000c                 lea.l      12(a7),a7
[00004a52] 4a87                      tst.l      d7
[00004a54] 6726                      beq.s      _dterm_30
[00004a56] 246e ffe2                 movea.l    -30(a6),a2
[00004a5a] 2e8a                      move.l     a2,(a7)
[00004a5c] 4878 0001                 pea.l      ($00000001).w
[00004a60] 486e ffe6                 pea.l      -26(a6)
[00004a64] 4eb9 0000 4b1e            jsr        _gdecl
[00004a6a] 508f                      addq.l     #8,a7
[00004a6c] 2f07                      move.l     d7,-(a7)
[00004a6e] 4eb9 0000 8210            jsr        _fixargs
[00004a74] 588f                      addq.l     #4,a7
[00004a76] 2257                      movea.l    (a7),a1
[00004a78] 2287                      move.l     d7,(a1)
[00004a7a] 660e                      bne.s      _dterm_31
_dterm_30:
[00004a7c] 2ebc 0002 0fe1            move.l     #$00020FE1,(a7) "bad proto argument type"
[00004a82] 4eb9 0000 3e84            jsr        _p1error
[00004a88] 6084                      bra.s      _dterm_32
_dterm_31:
[00004a8a] 246e ffe2                 movea.l    -30(a6),a2
[00004a8e] 2d52 ffe2                 move.l     (a2),-30(a6)
[00004a92] 45f8 0010                 lea.l      ($00000010).w,a2
[00004a96] d5ee ffe2                 adda.l     -30(a6),a2
[00004a9a] 4a12                      tst.b      (a2)
[00004a9c] 6700 ff70                 beq        _dterm_32
[00004aa0] 4297                      clr.l      (a7)
[00004aa2] 2f2e fff8                 move.l     -8(a6),-(a7)
[00004aa6] 7e10                      moveq.l    #16,d7
[00004aa8] deae ffe2                 add.l      -30(a6),d7
[00004aac] 2f07                      move.l     d7,-(a7)
[00004aae] 4eb9 0000 847e            jsr        _lookup
[00004ab4] 508f                      addq.l     #8,a7
[00004ab6] beae ffe2                 cmp.l      -30(a6),d7
[00004aba] 6700 ff52                 beq        _dterm_32
[00004abe] 7e10                      moveq.l    #16,d7
[00004ac0] deae ffe2                 add.l      -30(a6),d7
[00004ac4] 2e87                      move.l     d7,(a7)
[00004ac6] 2f3c 0002 0fc7            move.l     #$00020FC7,-(a7) "redeclared proto argument"
[00004acc] 4eb9 0000 3c8a            jsr        _nmerr
[00004ad2] 588f                      addq.l     #4,a7
[00004ad4] 6000 ff38                 bra        _dterm_32
_dterm_26:
[00004ad8] 2b6e fff8 000e            move.l     -8(a6),14(a5)
[00004ade] 2b6e ffde 000a            move.l     -34(a6),10(a5)
[00004ae4] 2e8d                      move.l     a5,(a7)
[00004ae6] 2f0c                      move.l     a4,-(a7)
[00004ae8] 4eb9 0000 7846            jsr        _addtype
[00004aee] 588f                      addq.l     #4,a7
[00004af0] 6000 fd64                 bra        _dterm_10
_dterm_27:
[00004af4] 4878 000a                 pea.l      ($0000000A).w
[00004af8] 4eb9 0000 3be2            jsr        _neat
[00004afe] 588f                      addq.l     #4,a7
[00004b00] 60d6                      bra.s      _dterm_26
_dterm_20:
[00004b02] 2e8d                      move.l     a5,(a7)
[00004b04] 2f0c                      move.l     a4,-(a7)
[00004b06] 4eb9 0000 7846            jsr        _addtype
[00004b0c] 588f                      addq.l     #4,a7
[00004b0e] 4878 0008                 pea.l      ($00000008).w
[00004b12] 4eb9 0000 3c08            jsr        _need
[00004b18] 588f                      addq.l     #4,a7
[00004b1a] 6000 fd3a                 bra        _dterm_10

_gdecl:
[00004b1e] 4e56 fffc                 link       a6,#-4
[00004b22] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[00004b26] 2eae 000c                 move.l     12(a6),(a7)
[00004b2a] 4eba fb56                 jsr        _dterm(pc)
[00004b2e] 2d47 fffc                 move.l     d7,-4(a6)
[00004b32] 660a                      bne.s      _gdecl_1
[00004b34] 4287                      clr.l      d7
[00004b36] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00004b3a] 4e5e                      unlk       a6
[00004b3c] 4e75                      rts
_gdecl_1:
[00004b3e] 45f8 000e                 lea.l      ($0000000E).w,a2
[00004b42] d5ee fffc                 adda.l     -4(a6),a2
[00004b46] 2e8a                      move.l     a2,(a7)
[00004b48] 45f8 000e                 lea.l      ($0000000E).w,a2
[00004b4c] d5ee 0008                 adda.l     8(a6),a2
[00004b50] 2257                      movea.l    (a7),a1
[00004b52] 1292                      move.b     (a2),(a1)
[00004b54] 4285                      clr.l      d5
[00004b56] 246e 0008                 movea.l    8(a6),a2
[00004b5a] 588a                      addq.l     #4,a2
[00004b5c] 2852                      movea.l    (a2),a4
_gdecl_5:
[00004b5e] 2e0c                      move.l     a4,d7
[00004b60] 6712                      beq.s      _gdecl_2
[00004b62] 4287                      clr.l      d7
[00004b64] 1e2c 0008                 move.b     8(a4),d7
[00004b68] 41f9 0002 103e            lea.l      $0002103E,a0
[00004b6e] 4ef9 0000 a7dc            jmp        a.switch
_gdecl_2:
[00004b74] 4a85                      tst.l      d5
[00004b76] 662e                      bne.s      _gdecl_3
[00004b78] 246e 0008                 movea.l    8(a6),a2
[00004b7c] 588a                      addq.l     #4,a2
[00004b7e] 2612                      move.l     (a2),d3
[00004b80] 606e                      bra.s      _gdecl_4
[00004b82] 2a2c 0004                 move.l     4(a4),d5
_gdecl_6:
[00004b86] 286c 0004                 movea.l    4(a4),a4
[00004b8a] 60d2                      bra.s      _gdecl_5
[00004b8c] 60f8                      bra.s      _gdecl_6
[00004b8e] 4aac 000e                 tst.l      14(a4)
[00004b92] 66f2                      bne.s      _gdecl_6
[00004b94] 2a2c 0004                 move.l     4(a4),d5
[00004b98] 60ec                      bra.s      _gdecl_6
[00004b9a] 4aac 000a                 tst.l      10(a4)
[00004b9e] 66e6                      bne.s      _gdecl_6
[00004ba0] 2a2c 0004                 move.l     4(a4),d5
[00004ba4] 60e0                      bra.s      _gdecl_6
_gdecl_3:
[00004ba6] 4283                      clr.l      d3
[00004ba8] 246e 0008                 movea.l    8(a6),a2
[00004bac] 588a                      addq.l     #4,a2
[00004bae] 2852                      movea.l    (a2),a4
_gdecl_11:
[00004bb0] b9c5                      cmpa.l     d5,a4
[00004bb2] 673c                      beq.s      _gdecl_4
[00004bb4] 2eac 0004                 move.l     4(a4),(a7)
[00004bb8] 4287                      clr.l      d7
[00004bba] 1e2c 0008                 move.b     8(a4),d7
[00004bbe] 2f07                      move.l     d7,-(a7)
[00004bc0] 4eb9 0000 79aa            jsr        _buyattr
[00004bc6] 588f                      addq.l     #4,a7
[00004bc8] 2807                      move.l     d7,d4
[00004bca] 4878 0008                 pea.l      ($00000008).w
[00004bce] 486c 000a                 pea.l      10(a4)
[00004bd2] 2f04                      move.l     d4,-(a7)
[00004bd4] 0697 0000 000a            addi.l     #$0000000A,(a7)
[00004bda] 4eb9 0000 adac            jsr        _cpybuf
[00004be0] 4fef 000c                 lea.l      12(a7),a7
[00004be4] 4a83                      tst.l      d3
[00004be6] 6600 00aa                 bne        _gdecl_7
[00004bea] 2604                      move.l     d4,d3
[00004bec] 6000 00a4                 bra        _gdecl_7
_gdecl_4:
[00004bf0] 2e83                      move.l     d3,(a7)
[00004bf2] 2f2e fffc                 move.l     -4(a6),-(a7)
[00004bf6] 4eb9 0000 7846            jsr        _addtype
[00004bfc] 588f                      addq.l     #4,a7
[00004bfe] 45f8 000c                 lea.l      ($0000000C).w,a2
[00004c02] d5ee fffc                 adda.l     -4(a6),a2
[00004c06] 2e8a                      move.l     a2,(a7)
[00004c08] 246e fffc                 movea.l    -4(a6),a2
[00004c0c] 588a                      addq.l     #4,a2
[00004c0e] 2e12                      move.l     (a2),d7
[00004c10] be83                      cmp.l      d3,d7
[00004c12] 660e                      bne.s      _gdecl_8
[00004c14] 45f8 000c                 lea.l      ($0000000C).w,a2
[00004c18] d5ee 0008                 adda.l     8(a6),a2
[00004c1c] 4287                      clr.l      d7
[00004c1e] 3e12                      move.w     (a2),d7
[00004c20] 6022                      bra.s      _gdecl_9
_gdecl_8:
[00004c22] 45f8 000c                 lea.l      ($0000000C).w,a2
[00004c26] d5ee 0008                 adda.l     8(a6),a2
[00004c2a] 4287                      clr.l      d7
[00004c2c] 3e12                      move.w     (a2),d7
[00004c2e] 2f07                      move.l     d7,-(a7)
[00004c30] 2f03                      move.l     d3,-(a7)
[00004c32] 246e fffc                 movea.l    -4(a6),a2
[00004c36] 588a                      addq.l     #4,a2
[00004c38] 2f12                      move.l     (a2),-(a7)
[00004c3a] 4eb9 0000 4d10            jsr        _gdspace
[00004c40] 4fef 000c                 lea.l      12(a7),a7
_gdecl_9:
[00004c44] 2257                      movea.l    (a7),a1
[00004c46] 3287                      move.w     d7,(a1)
[00004c48] 45f8 000c                 lea.l      ($0000000C).w,a2
[00004c4c] d5ee fffc                 adda.l     -4(a6),a2
[00004c50] 4287                      clr.l      d7
[00004c52] 3e12                      move.w     (a2),d7
[00004c54] 0287 0000 0fff            andi.l     #$00000FFF,d7
[00004c5a] 663e                      bne.s      _gdecl_10
[00004c5c] 45f8 000c                 lea.l      ($0000000C).w,a2
[00004c60] d5ee fffc                 adda.l     -4(a6),a2
[00004c64] 2e8a                      move.l     a2,(a7)
[00004c66] 246e fffc                 movea.l    -4(a6),a2
[00004c6a] 588a                      addq.l     #4,a2
[00004c6c] 2452                      movea.l    (a2),a2
[00004c6e] 508a                      addq.l     #8,a2
[00004c70] 4287                      clr.l      d7
[00004c72] 1e12                      move.b     (a2),d7
[00004c74] 2f07                      move.l     d7,-(a7)
[00004c76] 45f8 000e                 lea.l      ($0000000E).w,a2
[00004c7a] d5ee fffc                 adda.l     -4(a6),a2
[00004c7e] 4287                      clr.l      d7
[00004c80] 1e12                      move.b     (a2),d7
[00004c82] 2f07                      move.l     d7,-(a7)
[00004c84] 4eb9 0000 3252            jsr        _defspace
[00004c8a] 508f                      addq.l     #8,a7
[00004c8c] 2257                      movea.l    (a7),a1
[00004c8e] 8f51                      or.w       d7,(a1)
[00004c90] 6008                      bra.s      _gdecl_10
_gdecl_7:
[00004c92] 286c 0004                 movea.l    4(a4),a4
[00004c96] 6000 ff18                 bra        _gdecl_11
_gdecl_10:
[00004c9a] 246e fffc                 movea.l    -4(a6),a2
[00004c9e] 588a                      addq.l     #4,a2
[00004ca0] 2a52                      movea.l    (a2),a5
_gdecl_14:
[00004ca2] bbc3                      cmpa.l     d3,a5
[00004ca4] 6758                      beq.s      _gdecl_12
[00004ca6] 4287                      clr.l      d7
[00004ca8] 1e2d 0008                 move.b     8(a5),d7
[00004cac] 0c47 0040                 cmpi.w     #$0040,d7
[00004cb0] 6658                      bne.s      _gdecl_13
[00004cb2] 45f8 000c                 lea.l      ($0000000C).w,a2
[00004cb6] d5ee 0008                 adda.l     8(a6),a2
[00004cba] 4287                      clr.l      d7
[00004cbc] 3e12                      move.w     (a2),d7
[00004cbe] 2e87                      move.l     d7,(a7)
[00004cc0] 2f03                      move.l     d3,-(a7)
[00004cc2] 2f2d 0004                 move.l     4(a5),-(a7)
[00004cc6] 4eb9 0000 4d10            jsr        _gdspace
[00004ccc] 508f                      addq.l     #8,a7
[00004cce] 3b47 000a                 move.w     d7,10(a5)
[00004cd2] 4287                      clr.l      d7
[00004cd4] 3e2d 000a                 move.w     10(a5),d7
[00004cd8] 0287 0000 0fff            andi.l     #$00000FFF,d7
[00004cde] 662a                      bne.s      _gdecl_13
[00004ce0] 246d 0004                 movea.l    4(a5),a2
[00004ce4] 508a                      addq.l     #8,a2
[00004ce6] 4287                      clr.l      d7
[00004ce8] 1e12                      move.b     (a2),d7
[00004cea] 2e87                      move.l     d7,(a7)
[00004cec] 4878 00e2                 pea.l      ($000000E2).w
[00004cf0] 4eb9 0000 3252            jsr        _defspace
[00004cf6] 588f                      addq.l     #4,a7
[00004cf8] 8f6d 000a                 or.w       d7,10(a5)
[00004cfc] 600c                      bra.s      _gdecl_13
_gdecl_12:
[00004cfe] 2e2e fffc                 move.l     -4(a6),d7
[00004d02] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00004d06] 4e5e                      unlk       a6
[00004d08] 4e75                      rts
_gdecl_13:
[00004d0a] 2a6d 0004                 movea.l    4(a5),a5
[00004d0e] 6092                      bra.s      _gdecl_14

_gdspace:
[00004d10] 4e56 0000                 link       a6,#0
[00004d14] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00004d18] 2a6e 0008                 movea.l    8(a6),a5
[00004d1c] 286e 000c                 movea.l    12(a6),a4
[00004d20] 2a2e 0010                 move.l     16(a6),d5
_gdspace_3:
[00004d24] bbcc                      cmpa.l     a4,a5
[00004d26] 660a                      bne.s      _gdspace_1
[00004d28] 2e05                      move.l     d5,d7
[00004d2a] 6018                      bra.s      _gdspace_2
_gdspace_4:
[00004d2c] 2a6d 0004                 movea.l    4(a5),a5
[00004d30] 60f2                      bra.s      _gdspace_3
_gdspace_1:
[00004d32] 4287                      clr.l      d7
[00004d34] 1e2d 0008                 move.b     8(a5),d7
[00004d38] 0c47 0040                 cmpi.w     #$0040,d7
[00004d3c] 66ee                      bne.s      _gdspace_4
[00004d3e] 4287                      clr.l      d7
[00004d40] 3e2d 000a                 move.w     10(a5),d7
_gdspace_2:
[00004d44] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00004d48] 4e5e                      unlk       a6
[00004d4a] 4e75                      rts

_gscty:
[00004d4c] 4e56 ffee                 link       a6,#-18
[00004d50] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00004d54] 2a6e 0008                 movea.l    8(a6),a5
[00004d58] 2e8d                      move.l     a5,(a7)
[00004d5a] 4eb9 0000 7e5e            jsr        _clrsym
[00004d60] 2ebc 0002 105e            move.l     #$0002105E,(a7)
[00004d66] 4eb9 0000 3192            jsr        _alt
[00004d6c] 2807                      move.l     d7,d4
[00004d6e] 45ee 000c                 lea.l      12(a6),a2
[00004d72] 2d4a fffc                 move.l     a2,-4(a6)
_gscty_2:
[00004d76] 246e fffc                 movea.l    -4(a6),a2
[00004d7a] 4a92                      tst.l      (a2)
[00004d7c] 6710                      beq.s      _gscty_1
[00004d7e] 246e fffc                 movea.l    -4(a6),a2
[00004d82] 2e12                      move.l     (a2),d7
[00004d84] be84                      cmp.l      d4,d7
[00004d86] 6706                      beq.s      _gscty_1
[00004d88] 58ae fffc                 addq.l     #4,-4(a6)
[00004d8c] 60e8                      bra.s      _gscty_2
_gscty_1:
[00004d8e] 246e fffc                 movea.l    -4(a6),a2
[00004d92] 2e12                      move.l     (a2),d7
[00004d94] be84                      cmp.l      d4,d7
[00004d96] 670c                      beq.s      _gscty_3
[00004d98] 2ebc 0002 1064            move.l     #$00021064,(a7) "illegal storage class"
[00004d9e] 4eb9 0000 3e84            jsr        _p1error
_gscty_3:
[00004da4] 246e fffc                 movea.l    -4(a6),a2
[00004da8] 4a92                      tst.l      (a2)
[00004daa] 6704                      beq.s      _gscty_4
[00004dac] 2e04                      move.l     d4,d7
[00004dae] 6004                      bra.s      _gscty_5
_gscty_4:
[00004db0] 2e2e 000c                 move.l     12(a6),d7
_gscty_5:
[00004db4] 1b47 000e                 move.b     d7,14(a5)
[00004db8] 426e fffa                 clr.w      -6(a6)
[00004dbc] 4285                      clr.l      d5
_gscty_11:
[00004dbe] 2ebc 0002 0d36            move.l     #$00020D36,(a7)
[00004dc4] 4eb9 0000 3192            jsr        _alt
[00004dca] 1d47 ffef                 move.b     d7,-17(a6)
[00004dce] 673a                      beq.s      _gscty_6
[00004dd0] 2e85                      move.l     d5,(a7)
[00004dd2] 4287                      clr.l      d7
[00004dd4] 1e2e ffef                 move.b     -17(a6),d7
[00004dd8] 2f07                      move.l     d7,-(a7)
[00004dda] 4eb9 0000 4efc            jsr        _gtypspec
[00004de0] 588f                      addq.l     #4,a7
[00004de2] 2a07                      move.l     d7,d5
[00004de4] 4287                      clr.l      d7
[00004de6] 1e2e ffef                 move.b     -17(a6),d7
[00004dea] 0c47 0035                 cmpi.w     #$0035,d7
[00004dee] 672e                      beq.s      _gscty_7
[00004df0] 4287                      clr.l      d7
[00004df2] 1e2e ffef                 move.b     -17(a6),d7
[00004df6] 0c47 0038                 cmpi.w     #$0038,d7
[00004dfa] 6722                      beq.s      _gscty_7
[00004dfc] 4287                      clr.l      d7
[00004dfe] 1e2e ffef                 move.b     -17(a6),d7
[00004e02] 0c47 003c                 cmpi.w     #$003C,d7
[00004e06] 6628                      bne.s      _gscty_8
[00004e08] 6014                      bra.s      _gscty_7
_gscty_6:
[00004e0a] 486e fff0                 pea.l      -16(a6)
[00004e0e] 4eb9 0000 3bae            jsr        _ident
[00004e14] 588f                      addq.l     #4,a7
[00004e16] 4a87                      tst.l      d7
[00004e18] 6638                      bne.s      _gscty_9
[00004e1a] 6000 009c                 bra        _gscty_10
_gscty_7:
[00004e1e] 4287                      clr.l      d7
[00004e20] 1e2e ffef                 move.b     -17(a6),d7
[00004e24] 2e87                      move.l     d7,(a7)
[00004e26] 4eba f1f0                 jsr        _decsu(pc)
[00004e2a] 2b47 0004                 move.l     d7,4(a5)
[00004e2e] 608e                      bra.s      _gscty_11
_gscty_8:
[00004e30] 4287                      clr.l      d7
[00004e32] 1e2e ffef                 move.b     -17(a6),d7
[00004e36] 0c47 000c                 cmpi.w     #$000C,d7
[00004e3a] 6682                      bne.s      _gscty_11
[00004e3c] 4287                      clr.l      d7
[00004e3e] 3e2e fffa                 move.w     -6(a6),d7
[00004e42] 2e87                      move.l     d7,(a7)
[00004e44] 4eb9 0000 33d6            jsr        _getspace
[00004e4a] 3d47 fffa                 move.w     d7,-6(a6)
[00004e4e] 6000 ff6e                 bra        _gscty_11
_gscty_9:
[00004e52] 4297                      clr.l      (a7)
[00004e54] 2f39 0002 0d2e            move.l     _symtab,-(a7)
[00004e5a] 2f2e fff2                 move.l     -14(a6),-(a7)
[00004e5e] 4eb9 0000 847e            jsr        _lookup
[00004e64] 508f                      addq.l     #8,a7
[00004e66] 2d47 fff6                 move.l     d7,-10(a6)
[00004e6a] 6740                      beq.s      _gscty_12
[00004e6c] 45f8 000e                 lea.l      ($0000000E).w,a2
[00004e70] d5ee fff6                 adda.l     -10(a6),a2
[00004e74] 4287                      clr.l      d7
[00004e76] 1e12                      move.b     (a2),d7
[00004e78] 0c47 0037                 cmpi.w     #$0037,d7
[00004e7c] 662e                      bne.s      _gscty_12
[00004e7e] 2e85                      move.l     d5,(a7)
[00004e80] 4878 0037                 pea.l      ($00000037).w
[00004e84] 4eb9 0000 4efc            jsr        _gtypspec
[00004e8a] 588f                      addq.l     #4,a7
[00004e8c] 2a07                      move.l     d7,d5
[00004e8e] 246e fff6                 movea.l    -10(a6),a2
[00004e92] 588a                      addq.l     #4,a2
[00004e94] 2b52 0004                 move.l     (a2),4(a5)
[00004e98] 45f8 000c                 lea.l      ($0000000C).w,a2
[00004e9c] d5ee fff6                 adda.l     -10(a6),a2
[00004ea0] 4287                      clr.l      d7
[00004ea2] 3e12                      move.w     (a2),d7
[00004ea4] 8f6e fffa                 or.w       d7,-6(a6)
[00004ea8] 6000 ff14                 bra        _gscty_11
_gscty_12:
[00004eac] 486e fff0                 pea.l      -16(a6)
[00004eb0] 4eb9 0000 31e4            jsr        _baktok1
[00004eb6] 588f                      addq.l     #4,a7
_gscty_10:
[00004eb8] 2e85                      move.l     d5,(a7)
[00004eba] 2f2d 0004                 move.l     4(a5),-(a7)
[00004ebe] 4eba f0b4                 jsr        _chktyp(pc)
[00004ec2] 588f                      addq.l     #4,a7
[00004ec4] 2b47 0004                 move.l     d7,4(a5)
[00004ec8] 0805 000a                 btst       #10,d5
[00004ecc] 6706                      beq.s      _gscty_13
[00004ece] 08ee 0005 fffa            bset       #5,-6(a6)
_gscty_13:
[00004ed4] 0805 000b                 btst       #11,d5
[00004ed8] 6706                      beq.s      _gscty_14
[00004eda] 08ee 0006 fffa            bset       #6,-6(a6)
_gscty_14:
[00004ee0] 3b6e fffa 000c            move.w     -6(a6),12(a5)
[00004ee6] 4a85                      tst.l      d5
[00004ee8] 6604                      bne.s      _gscty_15
[00004eea] 4a84                      tst.l      d4
[00004eec] 6704                      beq.s      _gscty_16
_gscty_15:
[00004eee] 7e01                      moveq.l    #1,d7
[00004ef0] 6002                      bra.s      _gscty_17
_gscty_16:
[00004ef2] 4287                      clr.l      d7
_gscty_17:
[00004ef4] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00004ef8] 4e5e                      unlk       a6
[00004efa] 4e75                      rts

_gtypspec:
[00004efc] 4e56 0000                 link       a6,#0
[00004f00] 48e7 8400                 movem.l    d0/d5,-(a7)
[00004f04] 2eae 0008                 move.l     8(a6),(a7)
[00004f08] 2f3c 0002 0d36            move.l     #$00020D36,-(a7)
[00004f0e] 4eb9 0000 a7a6            jsr        _scnstr
[00004f14] 588f                      addq.l     #4,a7
[00004f16] e387                      asl.l      #1,d7
[00004f18] 2447                      movea.l    d7,a2
[00004f1a] d5fc 0002 0d48            adda.l     #$00020D48,a2
[00004f20] 4285                      clr.l      d5
[00004f22] 3a12                      move.w     (a2),d5
[00004f24] 2e2e 000c                 move.l     12(a6),d7
[00004f28] ce85                      and.l      d5,d7
[00004f2a] 670c                      beq.s      _gtypspec_1
[00004f2c] 2ebc 0002 107a            move.l     #$0002107A,(a7) "repeated type specification"
[00004f32] 4eb9 0000 3e84            jsr        _p1error
_gtypspec_1:
[00004f38] 2e2e 000c                 move.l     12(a6),d7
[00004f3c] 8e85                      or.l       d5,d7
[00004f3e] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00004f42] 4e5e                      unlk       a6
[00004f44] 4e75                      rts

_main:
[00004f46] 4e56 ffe2                 link       a6,#-30
[00004f4a] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00004f4e] 4297                      clr.l      (a7)
[00004f50] 42a7                      clr.l      -(a7)
[00004f52] 42a7                      clr.l      -(a7)
[00004f54] 42a7                      clr.l      -(a7)
[00004f56] 2f3c 0002 11cc            move.l     #_zeterm,-(a7)
[00004f5c] 4eb9 0000 85aa            jsr        _setad
[00004f62] 4fef 0010                 lea.l      16(a7),a7
[00004f66] 23fc 0002 0d68 0002 11d0  move.l     #_atchar,$000211D0
[00004f70] 4878 0001                 pea.l      ($00000001).w
[00004f74] 2f3c 0002 11cb            move.l     #$000211CB,-(a7)
[00004f7a] 4eb9 0000 a4b4            jsr        _buybuf
[00004f80] 508f                      addq.l     #8,a7
[00004f82] 23c7 0002 0cd0            move.l     d7,_infile
[00004f88] 2ebc 0002 0b9a            move.l     #_uflag,(a7)
[00004f8e] 2f3c 0002 0b7a            move.l     #_laxflag,-(a7)
[00004f94] 2f3c 0002 0b96            move.l     #_romstrin,-(a7)
[00004f9a] 2f3c 0002 0b92            move.l     #_strictfl,-(a7)
[00004fa0] 2f3c 0002 0b8e            move.l     #_stdflag,-(a7)
[00004fa6] 2f3c 0002 10a6            move.l     #_rbytes,-(a7)
[00004fac] 2f3c 0002 0cca            move.l     #_ofile,-(a7)
[00004fb2] 2f3c 0002 0b8a            move.l     #_oldflag,-(a7)
[00004fb8] 2f3c 0002 0ba6            move.l     #_nlen,-(a7)
[00004fbe] 2f3c 0002 0b86            move.l     #_mflag,-(a7)
[00004fc4] 2f3c 0002 0ba2            move.l     #_model,-(a7)
[00004fca] 2f3c 0002 0b7e            move.l     #_lflag,-(a7)
[00004fd0] 2f3c 0002 0b82            move.l     #_lregflag,-(a7)
[00004fd6] 2f3c 0002 0b76            move.l     #_errflag,-(a7)
[00004fdc] 2f3c 0002 0b6e            move.l     #_dbflag,-(a7)
[00004fe2] 2f3c 0002 0b72            move.l     #_deadflag,-(a7)
[00004fe8] 2f3c 0002 0b6a            move.l     #_cflag,-(a7)
[00004fee] 2f3c 0002 0b9e            move.l     #_bndef,-(a7)
[00004ff4] 2f3c 0002 0b66            move.l     #_aflag,-(a7)
[00004ffa] 2f3c 0002 1173            move.l     #$00021173,-(a7) "a,b#,c,+dead,+debug,err,lreg,l,model?,m,n#,+old,o*,r#,+std,+strict,sr,strict,u:F <file>"
[00005000] 486e 000c                 pea.l      12(a6)
[00005004] 486e 0008                 pea.l      8(a6)
[00005008] 4eb9 0000 9f16            jsr        _getflags
[0000500e] 4fef 0054                 lea.l      84(a7),a7
[00005012] 4878 0001                 pea.l      ($00000001).w
[00005016] 2f3c 0002 0df8            move.l     #_atulong,-(a7)
[0000501c] 4eb9 0000 7b74            jsr        _bytes
[00005022] 508f                      addq.l     #8,a7
[00005024] 23c7 0002 0e52            move.l     d7,_byulong
[0000502a] 4878 0001                 pea.l      ($00000001).w
[0000502e] 2f3c 0002 0dd4            move.l     #_atunsign,-(a7)
[00005034] 4eb9 0000 7b74            jsr        _bytes
[0000503a] 508f                      addq.l     #8,a7
[0000503c] 23c7 0002 0e56            move.l     d7,_byunsign
[00005042] 4ab9 0002 0b7e            tst.l      _lflag
[00005048] 6708                      beq.s      _main_1
[0000504a] 2e3c 7fff ffff            move.l     #$7FFFFFFF,d7
[00005050] 6006                      bra.s      _main_2
_main_1:
[00005052] 2e3c 0000 7fff            move.l     #$00007FFF,d7
_main_2:
[00005058] 23c7 0002 0baa            move.l     d7,_maxint
[0000505e] 4ab9 0002 0b7e            tst.l      _lflag
[00005064] 6708                      beq.s      _main_3
[00005066] 2e3c 8000 0000            move.l     #$80000000,d7
[0000506c] 6006                      bra.s      _main_4
_main_3:
[0000506e] 2e3c ffff 8000            move.l     #$FFFF8000,d7
_main_4:
[00005074] 23c7 0002 0bae            move.l     d7,_minint
[0000507a] 4ab9 0002 0b8e            tst.l      _stdflag
[00005080] 6708                      beq.s      _main_5
[00005082] 7001                      moveq.l    #1,d0
[00005084] 23c0 0002 0b86            move.l     d0,_mflag
_main_5:
[0000508a] 0cb9 0000 007f 0002 0ba6  cmpi.l     #$0000007F,_nlen
[00005094] 6308                      bls.s      _main_6
[00005096] 707f                      moveq.l    #127,d0
[00005098] 23c0 0002 0ba6            move.l     d0,_nlen
_main_6:
[0000509e] 02b9 0000 0003 0002 0b9e  andi.l     #$00000003,_bndef
[000050a8] 7e07                      moveq.l    #7,d7
[000050aa] ceb9 0002 10a6            and.l      _rbytes,d7
[000050b0] e387                      asl.l      #1,d7
[000050b2] 2447                      movea.l    d7,a2
[000050b4] d5fc 0002 1096            adda.l     #$00021096,a2
[000050ba] 33d2 0002 0b64            move.w     (a2),_iregs
[000050c0] 4ab9 0002 0cca            tst.l      _ofile
[000050c6] 6734                      beq.s      _main_7
[000050c8] 4878 0001                 pea.l      ($00000001).w
[000050cc] 4878 0001                 pea.l      ($00000001).w
[000050d0] 2f39 0002 0cca            move.l     _ofile,-(a7)
[000050d6] 4eb9 0000 a54e            jsr        _create
[000050dc] 4fef 000c                 lea.l      12(a7),a7
[000050e0] 33c7 0002 0cd6            move.w     d7,_outfd
[000050e6] 6c52                      bge.s      _main_8
[000050e8] 2ebc 0002 1163            move.l     #$00021163,(a7) "bad output file"
[000050ee] 4eb9 0000 3e84            jsr        _p1error
[000050f4] 4297                      clr.l      (a7)
[000050f6] 4eb9 0000 0080            jsr        _exit
_main_7:
[000050fc] 4aae 0008                 tst.l      8(a6)
[00005100] 6742                      beq.s      _main_9
[00005102] 4297                      clr.l      (a7)
[00005104] 4eb9 0000 ad6e            jsr        _close
[0000510a] 4878 0001                 pea.l      ($00000001).w
[0000510e] 42a7                      clr.l      -(a7)
[00005110] 246e 000c                 movea.l    12(a6),a2
[00005114] 2f12                      move.l     (a2),-(a7)
[00005116] 4eb9 0000 a796            jsr        _open
[0000511c] 4fef 000c                 lea.l      12(a7),a7
[00005120] 4a87                      tst.l      d7
[00005122] 6720                      beq.s      _main_9
[00005124] 2ebc 0002 1154            move.l     #$00021154,(a7) "bad input file"
[0000512a] 4eb9 0000 3e84            jsr        _p1error
[00005130] 4297                      clr.l      (a7)
[00005132] 4eb9 0000 0080            jsr        _exit
[00005138] 600a                      bra.s      _main_9
_main_8:
[0000513a] 33fc 0001 0002 0cc8       move.w     #$0001,_errfd
[00005142] 60b8                      bra.s      _main_7
_main_9:
[00005144] 4ab9 0002 0b8a            tst.l      _oldflag
[0000514a] 6600 0082                 bne        _main_10
[0000514e] 2ebc 0000 00be            move.l     #$000000BE,(a7)
[00005154] 4eb9 0000 5a16            jsr        _pcode
[0000515a] 0cb9 0000 0001 0002 0b7e  cmpi.l     #$00000001,_lflag
[00005164] 6604                      bne.s      _main_11
[00005166] 7e01                      moveq.l    #1,d7
[00005168] 6002                      bra.s      _main_12
_main_11:
[0000516a] 4287                      clr.l      d7
_main_12:
[0000516c] 8f39 0002 0bb2            or.b       d7,_dcbyte
[00005172] 0cb9 0000 0041 0002 0ba2  cmpi.l     #$00000041,_model
[0000517c] 6516                      bcs.s      _main_13
[0000517e] 0cb9 0000 005a 0002 0ba2  cmpi.l     #$0000005A,_model
[00005188] 620a                      bhi.s      _main_13
[0000518a] 7e20                      moveq.l    #32,d7
[0000518c] deb9 0002 0ba2            add.l      _model,d7
[00005192] 6006                      bra.s      _main_14
_main_13:
[00005194] 2e39 0002 0ba2            move.l     _model,d7
_main_14:
[0000519a] 23c7 0002 0ba2            move.l     d7,_model
[000051a0] 2eb9 0002 0ba2            move.l     _model,(a7)
[000051a6] 2f3c 0002 114f            move.l     #$0002114F,-(a7)
[000051ac] 4eb9 0000 a7a6            jsr        _scnstr
[000051b2] 588f                      addq.l     #4,a7
[000051b4] 0c87 0000 0003            cmpi.l     #$00000003,d7
[000051ba] 6f00 0092                 ble        _main_15
[000051be] 2ebc 0002 1141            move.l     #$00021141,(a7) "unknown model"
[000051c4] 4eb9 0000 3e84            jsr        _p1error
[000051ca] 6000 0082                 bra        _main_15
_main_10:
[000051ce] 2ebc 0000 00bd            move.l     #$000000BD,(a7)
[000051d4] 4eb9 0000 332e            jsr        _eat
[000051da] 4ab9 0002 0b8a            tst.l      _oldflag
[000051e0] 6700 00e4                 beq        _main_16
[000051e4] 2ebc 0000 0088            move.l     #$00000088,(a7)
[000051ea] 2f3c 0002 1762            move.l     #_tyops,-(a7)
[000051f0] 4eb9 0000 a7a6            jsr        _scnstr
[000051f6] 588f                      addq.l     #4,a7
[000051f8] e387                      asl.l      #1,d7
[000051fa] 2447                      movea.l    d7,a2
[000051fc] d5fc 0002 1704            adda.l     #_tycodes,a2
[00005202] 08ea 0003 0001            bset       #3,1(a2)
[00005208] 2ebc 0000 00af            move.l     #$000000AF,(a7)
[0000520e] 2f3c 0002 1762            move.l     #_tyops,-(a7)
[00005214] 4eb9 0000 a7a6            jsr        _scnstr
[0000521a] 588f                      addq.l     #4,a7
[0000521c] e387                      asl.l      #1,d7
[0000521e] 2447                      movea.l    d7,a2
[00005220] d5fc 0002 1704            adda.l     #_tycodes,a2
[00005226] 08ea 0006 0001            bset       #6,1(a2)
[0000522c] 4878 0066                 pea.l      ($00000066).w
[00005230] 2f3c 0002 1762            move.l     #_tyops,-(a7)
[00005236] 4eb9 0000 a7a6            jsr        _scnstr
[0000523c] 508f                      addq.l     #8,a7
[0000523e] e387                      asl.l      #1,d7
[00005240] 2447                      movea.l    d7,a2
[00005242] d5fc 0002 1704            adda.l     #_tycodes,a2
[00005248] 08d2 0000                 bset       #0,(a2)
[0000524c] 6078                      bra.s      _main_16
_main_15:
[0000524e] 2eb9 0002 0ba2            move.l     _model,(a7)
[00005254] 2f3c 0002 113c            move.l     #$0002113C,-(a7) "spdf"
[0000525a] 4eb9 0000 a7a6            jsr        _scnstr
[00005260] 588f                      addq.l     #4,a7
[00005262] e587                      asl.l      #2,d7
[00005264] 7c0c                      moveq.l    #12,d6
[00005266] cc87                      and.l      d7,d6
[00005268] 8d39 0002 0bb2            or.b       d6,_dcbyte
[0000526e] 4eb9 0000 32c6            jsr        _domodel
[00005274] 2e39 0002 0b9e            move.l     _bndef,d7
[0000527a] e987                      asl.l      #4,d7
[0000527c] 8f39 0002 0bb2            or.b       d7,_dcbyte
[00005282] 4287                      clr.l      d7
[00005284] 1e39 0002 0bb2            move.b     _dcbyte,d7
[0000528a] 2e87                      move.l     d7,(a7)
[0000528c] 4eb9 0000 5a16            jsr        _pcode
[00005292] 4ab9 0002 0b66            tst.l      _aflag
[00005298] 670c                      beq.s      _main_17
[0000529a] 2e39 0002 10a6            move.l     _rbytes,d7
[000052a0] 08c7 0007                 bset       #7,d7
[000052a4] 6006                      bra.s      _main_18
_main_17:
[000052a6] 2e39 0002 10a6            move.l     _rbytes,d7
_main_18:
[000052ac] 8f39 0002 0bb3            or.b       d7,_regbyte
[000052b2] 4287                      clr.l      d7
[000052b4] 1e39 0002 0bb3            move.b     _regbyte,d7
[000052ba] 2e87                      move.l     d7,(a7)
[000052bc] 4eb9 0000 5a16            jsr        _pcode
[000052c2] 6000 ff0a                 bra        _main_10
_main_16:
[000052c6] 4279 0002 0cce            clr.w      _nerrors
_main_39:
[000052cc] 2ebc 0000 00ff            move.l     #$000000FF,(a7)
[000052d2] 4eb9 0000 332e            jsr        _eat
[000052d8] 4a87                      tst.l      d7
[000052da] 6600 0080                 bne        _main_19 ; possibly optimized to short
[000052de] 33f9 0002 0cd4 0002 04a6  move.w     _lineno,_dbline
[000052e8] 4297                      clr.l      (a7)
[000052ea] 4878 0037                 pea.l      ($00000037).w
[000052ee] 4878 0034                 pea.l      ($00000034).w
[000052f2] 4878 002a                 pea.l      ($0000002A).w
[000052f6] 4878 003e                 pea.l      ($0000003E).w
[000052fa] 486e ffe2                 pea.l      -30(a6)
[000052fe] 4eba fa4c                 jsr        _gscty(pc)
[00005302] 4fef 0014                 lea.l      20(a7),a7
[00005306] 2d47 fff8                 move.l     d7,-8(a6)
[0000530a] 2d79 0002 0cea fffc       move.l     _attlist,-4(a6)
_main_25:
[00005312] 4297                      clr.l      (a7)
[00005314] 486e ffe2                 pea.l      -30(a6)
[00005318] 4eba f804                 jsr        _gdecl(pc)
[0000531c] 588f                      addq.l     #4,a7
[0000531e] 2a47                      movea.l    d7,a5
[00005320] 2e0d                      move.l     a5,d7
[00005322] 6756                      beq.s      _main_20
[00005324] 7001                      moveq.l    #1,d0
[00005326] 2d40 fff8                 move.l     d0,-8(a6)
[0000532a] 4297                      clr.l      (a7)
[0000532c] 2f39 0002 0d2e            move.l     _symtab,-(a7)
[00005332] 486d 0010                 pea.l      16(a5)
[00005336] 4eb9 0000 847e            jsr        _lookup
[0000533c] 508f                      addq.l     #8,a7
[0000533e] 2847                      movea.l    d7,a4
[00005340] 2e0c                      move.l     a4,d7
[00005342] 665a                      bne.s      _main_21
[00005344] 2ebc 0002 0d2e            move.l     #_symtab,(a7)
[0000534a] 2f0d                      move.l     a5,-(a7)
[0000534c] 4eb9 0000 774e            jsr        _addsym
[00005352] 588f                      addq.l     #4,a7
[00005354] 23c7 0002 0d16            move.l     d7,_gblsym
[0000535a] 606e                      bra.s      _main_22
_main_19:
[0000535c] 2879 0002 0d2e            movea.l    _symtab,a4
_main_43:
[00005362] 2e0c                      move.l     a4,d7
[00005364] 6700 0284                 beq        _main_23
[00005368] 4287                      clr.l      d7
[0000536a] 1e2c 000e                 move.b     14(a4),d7
[0000536e] 41f9 0002 10aa            lea.l      $000210AA,a0
[00005374] 4ef9 0000 a7dc            jmp        a.switch
_main_20:
[0000537a] 4aae fff8                 tst.l      -8(a6)
[0000537e] 6700 0200                 beq        _main_24
[00005382] 2e0d                      move.l     a5,d7
[00005384] 6600 01fa                 bne        _main_24
[00005388] 7001                      moveq.l    #1,d0
[0000538a] 2d40 fff4                 move.l     d0,-12(a6)
[0000538e] 6000 01f0                 bra        _main_24
_main_34:
[00005392] 2d79 0002 0cea fffc       move.l     _attlist,-4(a6)
[0000539a] 6000 ff76                 bra        _main_25
_main_21:
[0000539e] 4287                      clr.l      d7
[000053a0] 1e2d 000e                 move.b     14(a5),d7
[000053a4] 0c47 0037                 cmpi.w     #$0037,d7
[000053a8] 670c                      beq.s      _main_26
[000053aa] 4287                      clr.l      d7
[000053ac] 1e2c 000e                 move.b     14(a4),d7
[000053b0] 0c47 0037                 cmpi.w     #$0037,d7
[000053b4] 6662                      bne.s      _main_27
_main_26:
[000053b6] 486d 0010                 pea.l      16(a5)
[000053ba] 2f3c 0002 1129            move.l     #$00021129,-(a7) "redeclared typedef"
[000053c0] 4eb9 0000 3c8a            jsr        _nmerr
[000053c6] 508f                      addq.l     #8,a7
[000053c8] 99cc                      suba.l     a4,a4
_main_22:
[000053ca] 2e0c                      move.l     a4,d7
[000053cc] 6700 0140                 beq        _main_28
[000053d0] 2ead 0004                 move.l     4(a5),(a7)
[000053d4] 2f2c 0004                 move.l     4(a4),-(a7)
[000053d8] 4eb9 0000 8534            jsr        _mergatt
[000053de] 588f                      addq.l     #4,a7
[000053e0] 2947 0004                 move.l     d7,4(a4)
[000053e4] 4287                      clr.l      d7
[000053e6] 3e2d 000c                 move.w     12(a5),d7
[000053ea] 8f6c 000c                 or.w       d7,12(a4)
[000053ee] 2e8c                      move.l     a4,(a7)
[000053f0] 2f0d                      move.l     a5,-(a7)
[000053f2] 4eb9 0000 aa76            jsr        _free
[000053f8] 588f                      addq.l     #4,a7
[000053fa] 2a47                      movea.l    d7,a5
[000053fc] 2eae fffc                 move.l     -4(a6),(a7)
[00005400] 2f39 0002 0cea            move.l     _attlist,-(a7)
[00005406] 4eb9 0000 8332            jsr        _frealst
[0000540c] 588f                      addq.l     #4,a7
[0000540e] 23c7 0002 0cea            move.l     d7,_attlist
[00005414] 6000 00f8                 bra        _main_28
_main_27:
[00005418] 4ab9 0002 0b8e            tst.l      _stdflag
[0000541e] 664a                      bne.s      _main_29
[00005420] 246c 0004                 movea.l    4(a4),a2
[00005424] 508a                      addq.l     #8,a2
[00005426] 4287                      clr.l      d7
[00005428] 1e12                      move.b     (a2),d7
[0000542a] 0c47 0042                 cmpi.w     #$0042,d7
[0000542e] 663a                      bne.s      _main_29
[00005430] 246d 0004                 movea.l    4(a5),a2
[00005434] 508a                      addq.l     #8,a2
[00005436] 4287                      clr.l      d7
[00005438] 1e12                      move.b     (a2),d7
[0000543a] 0c47 0042                 cmpi.w     #$0042,d7
[0000543e] 662a                      bne.s      _main_29
[00005440] 45f8 000a                 lea.l      ($0000000A).w,a2
[00005444] d5ec 0004                 adda.l     4(a4),a2
[00005448] 2e12                      move.l     (a2),d7
[0000544a] 0c87 0002 0d04            cmpi.l     #_tentsym,d7
[00005450] 6618                      bne.s      _main_29
[00005452] 4287                      clr.l      d7
[00005454] 1e2d 000e                 move.b     14(a5),d7
[00005458] 0c47 002a                 cmpi.w     #$002A,d7
[0000545c] 6752                      beq.s      _main_30
[0000545e] 4287                      clr.l      d7
[00005460] 1e2d 000e                 move.b     14(a5),d7
[00005464] 0c47 003e                 cmpi.w     #$003E,d7
[00005468] 6746                      beq.s      _main_30
_main_29:
[0000546a] 4878 0001                 pea.l      ($00000001).w
[0000546e] 2f2c 0004                 move.l     4(a4),-(a7)
[00005472] 2f2d 0004                 move.l     4(a5),-(a7)
[00005476] 4eb9 0000 7d40            jsr        _cmptype
[0000547c] 4fef 000c                 lea.l      12(a7),a7
[00005480] 4a87                      tst.l      d7
[00005482] 6772                      beq.s      _main_31
[00005484] 4287                      clr.l      d7
[00005486] 1e2d 000e                 move.b     14(a5),d7
[0000548a] 0c47 0034                 cmpi.w     #$0034,d7
[0000548e] 6600 ff3a                 bne        _main_22
[00005492] 4287                      clr.l      d7
[00005494] 1e2c 000e                 move.b     14(a4),d7
[00005498] 0c47 0034                 cmpi.w     #$0034,d7
[0000549c] 6700 ff2c                 beq        _main_22
[000054a0] 4287                      clr.l      d7
[000054a2] 1e2c 000e                 move.b     14(a4),d7
[000054a6] 0c47 003d                 cmpi.w     #$003D,d7
[000054aa] 6700 ff1e                 beq        _main_22
[000054ae] 6046                      bra.s      _main_31
_main_30:
[000054b0] 296d 0004 0004            move.l     4(a5),4(a4)
[000054b6] 4297                      clr.l      (a7)
[000054b8] 486c 0004                 pea.l      4(a4)
[000054bc] 4eb9 0000 7e8c            jsr        _cpyats
[000054c2] 588f                      addq.l     #4,a7
[000054c4] 396d 000c 000c            move.w     12(a5),12(a4)
[000054ca] 2eae fffc                 move.l     -4(a6),(a7)
[000054ce] 2f39 0002 0cea            move.l     _attlist,-(a7)
[000054d4] 4eb9 0000 8332            jsr        _frealst
[000054da] 588f                      addq.l     #4,a7
[000054dc] 23c7 0002 0cea            move.l     d7,_attlist
[000054e2] 2e8c                      move.l     a4,(a7)
[000054e4] 2f0d                      move.l     a5,-(a7)
[000054e6] 4eb9 0000 aa76            jsr        _free
[000054ec] 588f                      addq.l     #4,a7
[000054ee] 2a47                      movea.l    d7,a5
[000054f0] 99cc                      suba.l     a4,a4
[000054f2] 6000 fed6                 bra        _main_22
_main_31:
[000054f6] 486d 0010                 pea.l      16(a5)
[000054fa] 2f3c 0002 1115            move.l     #$00021115,-(a7) "redeclared external"
[00005500] 4eb9 0000 3c8a            jsr        _nmerr
[00005506] 508f                      addq.l     #8,a7
[00005508] 99cc                      suba.l     a4,a4
[0000550a] 6000 febe                 bra        _main_22
_main_28:
[0000550e] 7001                      moveq.l    #1,d0
[00005510] 2d40 fff4                 move.l     d0,-12(a6)
[00005514] 4287                      clr.l      d7
[00005516] 1e2d 000e                 move.b     14(a5),d7
[0000551a] 0c47 0037                 cmpi.w     #$0037,d7
[0000551e] 6718                      beq.s      _main_32
[00005520] 4878 000c                 pea.l      ($0000000C).w
[00005524] 4eb9 0000 332e            jsr        _eat
[0000552a] 588f                      addq.l     #4,a7
[0000552c] 4a87                      tst.l      d7
[0000552e] 671e                      beq.s      _main_33
[00005530] 2e8d                      move.l     a5,(a7)
[00005532] 4eb9 0000 00c6            jsr        _alias
_main_32:
[00005538] 4878 0002                 pea.l      ($00000002).w
[0000553c] 4eb9 0000 332e            jsr        _eat
[00005542] 588f                      addq.l     #4,a7
[00005544] 4a87                      tst.l      d7
[00005546] 6600 fe4a                 bne        _main_34
[0000554a] 6000 fe2e                 bra        _main_20
_main_33:
[0000554e] 246d 0004                 movea.l    4(a5),a2
[00005552] 508a                      addq.l     #8,a2
[00005554] 4287                      clr.l      d7
[00005556] 1e12                      move.b     (a2),d7
[00005558] 0c47 0042                 cmpi.w     #$0042,d7
[0000555c] 670e                      beq.s      _main_35
[0000555e] 4297                      clr.l      (a7)
[00005560] 2f0d                      move.l     a5,-(a7)
[00005562] 4eb9 0000 03ba            jsr        _datinit
[00005568] 588f                      addq.l     #4,a7
[0000556a] 60cc                      bra.s      _main_32
_main_35:
[0000556c] 2e8d                      move.l     a5,(a7)
[0000556e] 4eb9 0000 2ade            jsr        _fninit
[00005574] 4a87                      tst.l      d7
[00005576] 67c0                      beq.s      _main_32
[00005578] 42ae fff4                 clr.l      -12(a6)
[0000557c] 6000 fdfc                 bra        _main_20
_main_24:
[00005580] 4aae fff4                 tst.l      -12(a6)
[00005584] 671e                      beq.s      _main_36
[00005586] 4878 000b                 pea.l      ($0000000B).w
[0000558a] 4eb9 0000 332e            jsr        _eat
[00005590] 588f                      addq.l     #4,a7
[00005592] 4a87                      tst.l      d7
[00005594] 663a                      bne.s      _main_37
[00005596] 4878 000b                 pea.l      ($0000000B).w
[0000559a] 4eb9 0000 3c08            jsr        _need
[000055a0] 588f                      addq.l     #4,a7
[000055a2] 602c                      bra.s      _main_37
_main_36:
[000055a4] 4aae fff8                 tst.l      -8(a6)
[000055a8] 662a                      bne.s      _main_38
[000055aa] 2ebc 0000 00ff            move.l     #$000000FF,(a7)
[000055b0] 4eb9 0000 332e            jsr        _eat
[000055b6] 4a87                      tst.l      d7
[000055b8] 661a                      bne.s      _main_38
[000055ba] 2ebc 0000 00ff            move.l     #$000000FF,(a7)
[000055c0] 2f3c 0002 1101            move.l     #$00021101,-(a7)
[000055c6] 4eb9 0000 3f28            jsr        _recover
[000055cc] 588f                      addq.l     #4,a7
[000055ce] 6004                      bra.s      _main_38
_main_37:
[000055d0] 42ae fff4                 clr.l      -12(a6)
_main_38:
[000055d4] 2ebc 0000 00ff            move.l     #$000000FF,(a7)
[000055da] 4eb9 0000 332e            jsr        _eat
[000055e0] 4a87                      tst.l      d7
[000055e2] 6700 fce8                 beq        _main_39
[000055e6] 6000 fd74                 bra        _main_19
_main_23:
[000055ea] 2879 0002 0d2e            movea.l    _symtab,a4
_main_41:
[000055f0] 2e0c                      move.l     a4,d7
[000055f2] 6700 00ce                 beq        _main_40
[000055f6] 2e94                      move.l     (a4),(a7)
[000055f8] 2f0c                      move.l     a4,-(a7)
[000055fa] 4eb9 0000 19d2            jsr        _dbvar
[00005600] 588f                      addq.l     #4,a7
[00005602] 2847                      movea.l    d7,a4
[00005604] 60ea                      bra.s      _main_41
[00005606] 4a2c 000f                 tst.b      15(a4)
[0000560a] 6710                      beq.s      _main_42
[0000560c] 2ebc 0000 0090            move.l     #$00000090,(a7)
[00005612] 2f0c                      move.l     a4,-(a7)
[00005614] 4eb9 0000 60c4            jsr        _preforde
[0000561a] 588f                      addq.l     #4,a7
_main_42:
[0000561c] 2e8c                      move.l     a4,(a7)
[0000561e] 4eb9 0000 80a0            jsr        _exchk
_main_44:
[00005624] 2854                      movea.l    (a4),a4
[00005626] 6000 fd3a                 bra        _main_43
[0000562a] 60f8                      bra.s      _main_44
[0000562c] 4878 0001                 pea.l      ($00000001).w
[00005630] 2f0c                      move.l     a4,-(a7)
[00005632] 4eb9 0000 03ba            jsr        _datinit
[00005638] 508f                      addq.l     #8,a7
[0000563a] 2ebc 0000 0084            move.l     #$00000084,(a7)
[00005640] 2f0c                      move.l     a4,-(a7)
[00005642] 4eb9 0000 60c4            jsr        _preforde
[00005648] 588f                      addq.l     #4,a7
[0000564a] 2e8c                      move.l     a4,(a7)
[0000564c] 4eb9 0000 80a0            jsr        _exchk
[00005652] 60d0                      bra.s      _main_44
[00005654] 4a2c 000f                 tst.b      15(a4)
[00005658] 6732                      beq.s      _main_45
[0000565a] 246c 0004                 movea.l    4(a4),a2
[0000565e] 508a                      addq.l     #8,a2
[00005660] 4287                      clr.l      d7
[00005662] 1e12                      move.b     (a2),d7
[00005664] 0c47 0042                 cmpi.w     #$0042,d7
[00005668] 6614                      bne.s      _main_46
[0000566a] 486c 0010                 pea.l      16(a4)
[0000566e] 2f3c 0002 10e8            move.l     #$000210E8,-(a7) "undefined local function"
[00005674] 4eb9 0000 3c8a            jsr        _nmerr
[0000567a] 508f                      addq.l     #8,a7
[0000567c] 600e                      bra.s      _main_45
_main_46:
[0000567e] 4878 0001                 pea.l      ($00000001).w
[00005682] 2f0c                      move.l     a4,-(a7)
[00005684] 4eb9 0000 03ba            jsr        _datinit
[0000568a] 508f                      addq.l     #8,a7
_main_45:
[0000568c] 4ab9 0002 0b72            tst.l      _deadflag
[00005692] 6790                      beq.s      _main_44
[00005694] 4a2c 000f                 tst.b      15(a4)
[00005698] 668a                      bne.s      _main_44
[0000569a] 486c 0010                 pea.l      16(a4)
[0000569e] 4eb9 0000 7f98            jsr        _deadname
[000056a4] 588f                      addq.l     #4,a7
[000056a6] 4a87                      tst.l      d7
[000056a8] 6600 ff7a                 bne        _main_44
[000056ac] 486c 0010                 pea.l      16(a4)
[000056b0] 2f3c 0002 10da            move.l     #$000210DA,-(a7) "unused static"
[000056b6] 4eb9 0000 3c8a            jsr        _nmerr
[000056bc] 508f                      addq.l     #8,a7
[000056be] 6000 ff64                 bra        _main_44
_main_40:
[000056c2] 4a79 0002 04a8            tst.w      _dbfilab
[000056c8] 6708                      beq.s      _main_47
[000056ca] 4297                      clr.l      (a7)
[000056cc] 4eb9 0000 1846            jsr        _dbfunc
_main_47:
[000056d2] 7001                      moveq.l    #1,d0
[000056d4] 23c0 0002 0cb4            move.l     d0,_p1p2ioct
[000056da] 4878 ffff                 pea.l      ($FFFFFFFF).w
[000056de] 4eb9 0000 3e98            jsr        _putchr
[000056e4] 588f                      addq.l     #4,a7
[000056e6] 4a79 0002 0cce            tst.w      _nerrors
[000056ec] 6708                      beq.s      _main_48
[000056ee] 4ab9 0002 0b76            tst.l      _errflag
[000056f4] 6704                      beq.s      _main_49
_main_48:
[000056f6] 7e01                      moveq.l    #1,d7
[000056f8] 6002                      bra.s      _main_50
_main_49:
[000056fa] 4287                      clr.l      d7
_main_50:
[000056fc] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00005700] 4e5e                      unlk       a6
[00005702] 4e75                      rts

_crs:
[00005704] 4e56 0000                 link       a6,#0
[00005708] 5079 0002 11fa            addq.w     #8,$000211FA
[0000570e] 3e39 0002 11fa            move.w     $000211FA,d7
[00005714] 48c7                      ext.l      d7
[00005716] 4e5e                      unlk       a6
[00005718] 4e75                      rts

_crx:
[0000571a] 4e56 0000                 link       a6,#0
[0000571e] 5079 0002 11fc            addq.w     #8,$000211FC
[00005724] 3e39 0002 11fc            move.w     $000211FC,d7
[0000572a] 48c7                      ext.l      d7
[0000572c] deae 0008                 add.l      8(a6),d7
[00005730] 5287                      addq.l     #1,d7
[00005732] 4e5e                      unlk       a6
[00005734] 4e75                      rts

_findlngs:
[00005736] 4e56 0000                 link       a6,#0
[0000573a] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000573e] 2a6e 0008                 movea.l    8(a6),a5
[00005742] 284d                      movea.l    a5,a4
[00005744] 2a55                      movea.l    (a5),a5
[00005746] 7a01                      moveq.l    #1,d5
_findlngs_3:
[00005748] bbcc                      cmpa.l     a4,a5
[0000574a] 6710                      beq.s      _findlngs_1
[0000574c] 2e05                      move.l     d5,d7
[0000574e] e387                      asl.l      #1,d7
[00005750] 2c2d 0006                 move.l     6(a5),d6
[00005754] 9cac 0006                 sub.l      6(a4),d6
[00005758] be86                      cmp.l      d6,d7
[0000575a] 640a                      bcc.s      _findlngs_2
_findlngs_1:
[0000575c] 2e05                      move.l     d5,d7
[0000575e] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00005762] 4e5e                      unlk       a6
[00005764] 4e75                      rts
_findlngs_2:
[00005766] 5285                      addq.l     #1,d5
[00005768] 2a55                      movea.l    (a5),a5
[0000576a] 60dc                      bra.s      _findlngs_3

_freecase:
[0000576c] 4e56 fff8                 link       a6,#-8
[00005770] 4aae 0008                 tst.l      8(a6)
[00005774] 6706                      beq.s      _freecase_1
[00005776] 4aae 000c                 tst.l      12(a6)
[0000577a] 6606                      bne.s      _freecase_2
_freecase_1:
[0000577c] 4287                      clr.l      d7
[0000577e] 4e5e                      unlk       a6
[00005780] 4e75                      rts
_freecase_2:
[00005782] 2d6e 0008 fffc            move.l     8(a6),-4(a6)
_freecase_4:
[00005788] 4aae fffc                 tst.l      -4(a6)
[0000578c] 671e                      beq.s      _freecase_3
[0000578e] 246e fffc                 movea.l    -4(a6),a2
[00005792] 4a92                      tst.l      (a2)
[00005794] 6716                      beq.s      _freecase_3
[00005796] 246e fffc                 movea.l    -4(a6),a2
[0000579a] 2e12                      move.l     (a2),d7
[0000579c] beae 0008                 cmp.l      8(a6),d7
[000057a0] 670a                      beq.s      _freecase_3
[000057a2] 246e fffc                 movea.l    -4(a6),a2
[000057a6] 2d52 fffc                 move.l     (a2),-4(a6)
[000057aa] 60dc                      bra.s      _freecase_4
_freecase_3:
[000057ac] 2e2e 0008                 move.l     8(a6),d7
[000057b0] beae 000c                 cmp.l      12(a6),d7
[000057b4] 6722                      beq.s      _freecase_5
[000057b6] 246e fffc                 movea.l    -4(a6),a2
[000057ba] 2e8a                      move.l     a2,(a7)
[000057bc] 2f2e 000c                 move.l     12(a6),-(a7)
[000057c0] 2f2e 0008                 move.l     8(a6),-(a7)
[000057c4] 4eb9 0000 9da6            jsr        _frelst
[000057ca] 508f                      addq.l     #8,a7
[000057cc] 2257                      movea.l    (a7),a1
[000057ce] 2287                      move.l     d7,(a1)
[000057d0] 2e2e 000c                 move.l     12(a6),d7
[000057d4] 4e5e                      unlk       a6
[000057d6] 4e75                      rts
_freecase_5:
[000057d8] 2e2e 0008                 move.l     8(a6),d7
[000057dc] 246e 0008                 movea.l    8(a6),a2
[000057e0] be92                      cmp.l      (a2),d7
[000057e2] 6612                      bne.s      _freecase_6
[000057e4] 4297                      clr.l      (a7)
[000057e6] 2f2e 0008                 move.l     8(a6),-(a7)
[000057ea] 4eb9 0000 aa76            jsr        _free
[000057f0] 588f                      addq.l     #4,a7
[000057f2] 4e5e                      unlk       a6
[000057f4] 4e75                      rts
_freecase_6:
[000057f6] 2eae 0008                 move.l     8(a6),(a7)
[000057fa] 246e 0008                 movea.l    8(a6),a2
[000057fe] 2f12                      move.l     (a2),-(a7)
[00005800] 4eb9 0000 9da6            jsr        _frelst
[00005806] 588f                      addq.l     #4,a7
[00005808] 4287                      clr.l      d7
[0000580a] 4e5e                      unlk       a6
[0000580c] 4e75                      rts

_gtlcase:
[0000580e] 4e56 fffc                 link       a6,#-4
[00005812] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00005816] 4aae 0008                 tst.l      8(a6)
[0000581a] 6604                      bne.s      _gtlcase_1
[0000581c] 4287                      clr.l      d7
[0000581e] 6010                      bra.s      _gtlcase_2
_gtlcase_1:
[00005820] 246e 0008                 movea.l    8(a6),a2
[00005824] 2e12                      move.l     (a2),d7
[00005826] beae 0008                 cmp.l      8(a6),d7
[0000582a] 660c                      bne.s      _gtlcase_3
[0000582c] 2e2e 0008                 move.l     8(a6),d7
_gtlcase_2:
[00005830] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00005834] 4e5e                      unlk       a6
[00005836] 4e75                      rts
_gtlcase_3:
[00005838] 2a6e 0008                 movea.l    8(a6),a5
[0000583c] 286e 0008                 movea.l    8(a6),a4
[00005840] 246e 0008                 movea.l    8(a6),a2
[00005844] 5c8a                      addq.l     #6,a2
[00005846] 2d52 fffc                 move.l     (a2),-4(a6)
[0000584a] 264d                      movea.l    a5,a3
_gtlcase_5:
[0000584c] 2854                      movea.l    (a4),a4
[0000584e] 2e2c 0006                 move.l     6(a4),d7
[00005852] beae fffc                 cmp.l      -4(a6),d7
[00005856] 6408                      bcc.s      _gtlcase_4
[00005858] 2d6c 0006 fffc            move.l     6(a4),-4(a6)
[0000585e] 264c                      movea.l    a4,a3
_gtlcase_4:
[00005860] b9cd                      cmpa.l     a5,a4
[00005862] 66e8                      bne.s      _gtlcase_5
[00005864] 2e0b                      move.l     a3,d7
[00005866] 60c8                      bra.s      _gtlcase_2

_lblname:
[00005868] 4e56 0000                 link       a6,#0
[0000586c] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[00005870] 2a2e 0008                 move.l     8(a6),d5
[00005874] 4239 0002 11fe            clr.b      $000211FE
[0000587a] 4a85                      tst.l      d5
[0000587c] 6608                      bne.s      _lblname_1
[0000587e] 2e3c 0002 11fe            move.l     #$000211FE,d7
[00005884] 6052                      bra.s      _lblname_2
_lblname_1:
[00005886] 13fc 003e 0002 11ff       move.b     #$3E,$000211FF
[0000588e] 7802                      moveq.l    #2,d4
_lblname_4:
[00005890] 4a85                      tst.l      d5
[00005892] 672a                      beq.s      _lblname_3
[00005894] 0c84 0000 0009            cmpi.l     #$00000009,d4
[0000589a] 6c22                      bge.s      _lblname_3
[0000589c] 2444                      movea.l    d4,a2
[0000589e] d5fc 0002 11fe            adda.l     #$000211FE,a2
[000058a4] 7e30                      moveq.l    #48,d7
[000058a6] 7c07                      moveq.l    #7,d6
[000058a8] cc85                      and.l      d5,d6
[000058aa] de86                      add.l      d6,d7
[000058ac] 1487                      move.b     d7,(a2)
[000058ae] 2e05                      move.l     d5,d7
[000058b0] e687                      asr.l      #3,d7
[000058b2] 0287 0000 1fff            andi.l     #$00001FFF,d7
[000058b8] 2a07                      move.l     d7,d5
[000058ba] 5284                      addq.l     #1,d4
[000058bc] 60d2                      bra.s      _lblname_4
_lblname_3:
[000058be] 2e04                      move.l     d4,d7
[000058c0] 5387                      subq.l     #1,d7
[000058c2] 13c7 0002 11fe            move.b     d7,$000211FE
[000058c8] 2444                      movea.l    d4,a2
[000058ca] d5fc 0002 11fe            adda.l     #$000211FE,a2
[000058d0] 4212                      clr.b      (a2)
[000058d2] 2e3c 0002 11fe            move.l     #$000211FE,d7
_lblname_2:
[000058d8] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[000058dc] 4e5e                      unlk       a6
[000058de] 4e75                      rts

_pad:
[000058e0] 4e56 0000                 link       a6,#0
[000058e4] 4878 0001                 pea.l      ($00000001).w
[000058e8] 42a7                      clr.l      -(a7)
[000058ea] 42a7                      clr.l      -(a7)
[000058ec] 2f2e 000c                 move.l     12(a6),-(a7)
[000058f0] 2f3c 0002 1208            move.l     #$00021208,-(a7)
[000058f6] 2f2e 0008                 move.l     8(a6),-(a7)
[000058fa] 4eb9 0000 5908            jsr        _paddr
[00005900] 4fef 0018                 lea.l      24(a7),a7
[00005904] 4e5e                      unlk       a6
[00005906] 4e75                      rts

_paddr:
[00005908] 4e56 0000                 link       a6,#0
[0000590c] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00005910] 2a6e 000c                 movea.l    12(a6),a5
[00005914] 4aae 0018                 tst.l      24(a6)
[00005918] 6708                      beq.s      _paddr_1
[0000591a] 2e39 0002 0e52            move.l     _byulong,d7
[00005920] 6006                      bra.s      _paddr_2
_paddr_1:
[00005922] 2e39 0002 0e56            move.l     _byunsign,d7
_paddr_2:
[00005928] 2a07                      move.l     d7,d5
[0000592a] 4a15                      tst.b      (a5)
[0000592c] 6606                      bne.s      _paddr_3
[0000592e] 4aae 0008                 tst.l      8(a6)
[00005932] 6756                      beq.s      _paddr_4
_paddr_3:
[00005934] 4aae 0018                 tst.l      24(a6)
[00005938] 6710                      beq.s      _paddr_5
[0000593a] 4ab9 0002 0b8a            tst.l      _oldflag
[00005940] 6608                      bne.s      _paddr_5
[00005942] 2e3c 0000 00c8            move.l     #$000000C8,d7
[00005948] 6006                      bra.s      _paddr_6
_paddr_5:
[0000594a] 2e3c 0000 00c0            move.l     #$000000C0,d7
_paddr_6:
[00005950] deae 0014                 add.l      20(a6),d7
[00005954] 2e87                      move.l     d7,(a7)
[00005956] 4eb9 0000 5a16            jsr        _pcode
[0000595c] 4878 0001                 pea.l      ($00000001).w
[00005960] 2f0d                      move.l     a5,-(a7)
[00005962] 2f2e 0008                 move.l     8(a6),-(a7)
[00005966] 4eb9 0000 661a            jsr        _ptname
[0000596c] 4fef 000c                 lea.l      12(a7),a7
[00005970] 4878 0004                 pea.l      ($00000004).w
[00005974] 486e 0010                 pea.l      16(a6)
[00005978] 4eb9 0000 695c            jsr        _putbytes
[0000597e] 508f                      addq.l     #8,a7
_paddr_9:
[00005980] 2e05                      move.l     d5,d7
[00005982] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00005986] 4e5e                      unlk       a6
[00005988] 4e75                      rts
_paddr_4:
[0000598a] 4aae 0010                 tst.l      16(a6)
[0000598e] 6606                      bne.s      _paddr_7
[00005990] 4aae 001c                 tst.l      28(a6)
[00005994] 6710                      beq.s      _paddr_8
_paddr_7:
[00005996] 2e85                      move.l     d5,(a7)
[00005998] 2f2e 0010                 move.l     16(a6),-(a7)
[0000599c] 4eb9 0000 5c34            jsr        _pint
[000059a2] 588f                      addq.l     #4,a7
[000059a4] 60da                      bra.s      _paddr_9
_paddr_8:
[000059a6] 2e85                      move.l     d5,(a7)
[000059a8] 4eb9 0000 6140            jsr        _pspace
[000059ae] 60d0                      bra.s      _paddr_9

_pauto:
[000059b0] 4e56 fffc                 link       a6,#-4
[000059b4] 2ebc 0000 0081            move.l     #$00000081,(a7)
[000059ba] 4eb9 0000 5a16            jsr        _pcode
[000059c0] 4878 0004                 pea.l      ($00000004).w
[000059c4] 486e 0008                 pea.l      8(a6)
[000059c8] 4eb9 0000 695c            jsr        _putbytes
[000059ce] 508f                      addq.l     #8,a7
[000059d0] 4e5e                      unlk       a6
[000059d2] 4e75                      rts

_pcase:
[000059d4] 4e56 fffa                 link       a6,#-6
[000059d8] 3d6e 000a fffe            move.w     10(a6),-2(a6)
[000059de] 2ebc 0000 0082            move.l     #$00000082,(a7)
[000059e4] 4eb9 0000 5a16            jsr        _pcode
[000059ea] 4878 0002                 pea.l      ($00000002).w
[000059ee] 486e fffe                 pea.l      -2(a6)
[000059f2] 4eb9 0000 695c            jsr        _putbytes
[000059f8] 508f                      addq.l     #8,a7
[000059fa] 4878 0002                 pea.l      ($00000002).w
[000059fe] 2f3c 0002 0cd4            move.l     #_lineno,-(a7)
[00005a04] 4eb9 0000 695c            jsr        _putbytes
[00005a0a] 508f                      addq.l     #8,a7
[00005a0c] 3e2e fffe                 move.w     -2(a6),d7
[00005a10] 48c7                      ext.l      d7
[00005a12] 4e5e                      unlk       a6
[00005a14] 4e75                      rts

_pcode:
[00005a16] 4e56 fffc                 link       a6,#-4
[00005a1a] 2e2e 0008                 move.l     8(a6),d7
[00005a1e] 0287 0000 00ff            andi.l     #$000000FF,d7
[00005a24] 2e87                      move.l     d7,(a7)
[00005a26] 4eb9 0000 3e98            jsr        _putchr
[00005a2c] 4e5e                      unlk       a6
[00005a2e] 4e75                      rts

_pdata:
[00005a30] 4e56 fffa                 link       a6,#-6
[00005a34] 3d6e 0016 fffe            move.w     22(a6),-2(a6)
[00005a3a] 4a6e fffe                 tst.w      -2(a6)
[00005a3e] 6708                      beq.s      _pdata_1
[00005a40] 2e3c 0000 00c7            move.l     #$000000C7,d7
[00005a46] 6006                      bra.s      _pdata_2
_pdata_1:
[00005a48] 2e3c 0000 0083            move.l     #$00000083,d7
_pdata_2:
[00005a4e] 2e87                      move.l     d7,(a7)
[00005a50] 4eba ffc4                 jsr        _pcode(pc)
[00005a54] 2eae 0010                 move.l     16(a6),(a7)
[00005a58] 4eba ffbc                 jsr        _pcode(pc)
[00005a5c] 4a6e fffe                 tst.w      -2(a6)
[00005a60] 6710                      beq.s      _pdata_3
[00005a62] 4878 0002                 pea.l      ($00000002).w
[00005a66] 486e fffe                 pea.l      -2(a6)
[00005a6a] 4eb9 0000 695c            jsr        _putbytes
[00005a70] 508f                      addq.l     #8,a7
_pdata_3:
[00005a72] 4878 0001                 pea.l      ($00000001).w
[00005a76] 2f2e 000c                 move.l     12(a6),-(a7)
[00005a7a] 2f2e 0008                 move.l     8(a6),-(a7)
[00005a7e] 4eb9 0000 661a            jsr        _ptname
[00005a84] 4fef 000c                 lea.l      12(a7),a7
[00005a88] 4e5e                      unlk       a6
[00005a8a] 4e75                      rts

_pdend:
[00005a8c] 4e56 fffc                 link       a6,#-4
[00005a90] 4ab9 0002 0b8a            tst.l      _oldflag
[00005a96] 660a                      bne.s      _pdend_1
[00005a98] 2ebc 0000 00d2            move.l     #$000000D2,(a7)
[00005a9e] 4eba ff76                 jsr        _pcode(pc)
_pdend_1:
[00005aa2] 4e5e                      unlk       a6
[00005aa4] 4e75                      rts

_pend:
[00005aa6] 4e56 fffc                 link       a6,#-4
[00005aaa] 48e7 8004                 movem.l    d0/a5,-(a7)
[00005aae] 2a79 0002 0d1e            movea.l    _littab,a5
_pend_6:
[00005ab4] 2e0d                      move.l     a5,d7
[00005ab6] 6746                      beq.s      _pend_1
[00005ab8] 4a2d 000f                 tst.b      15(a5)
[00005abc] 674e                      beq.s      _pend_2
[00005abe] 2ebc 0000 00b8            move.l     #$000000B8,(a7)
[00005ac4] 4eba ff50                 jsr        _pcode(pc)
[00005ac8] 4297                      clr.l      (a7)
[00005aca] 4eba ff4a                 jsr        _pcode(pc)
[00005ace] 4ab9 0002 0b8a            tst.l      _oldflag
[00005ad4] 6654                      bne.s      _pend_3
[00005ad6] 4ab9 0002 0b96            tst.l      _romstrin
[00005adc] 6708                      beq.s      _pend_4
[00005ade] 2e3c 0000 2000            move.l     #$00002000,d7
[00005ae4] 6002                      bra.s      _pend_5
_pend_4:
[00005ae6] 4287                      clr.l      d7
_pend_5:
[00005ae8] 8f6d 000c                 or.w       d7,12(a5)
[00005aec] 4878 0002                 pea.l      ($00000002).w
[00005af0] 486d 000c                 pea.l      12(a5)
[00005af4] 4eb9 0000 695c            jsr        _putbytes
[00005afa] 508f                      addq.l     #8,a7
[00005afc] 602c                      bra.s      _pend_3
_pend_1:
[00005afe] 42b9 0002 0d1e            clr.l      _littab
[00005b04] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00005b08] 4e5e                      unlk       a6
[00005b0a] 4e75                      rts
_pend_2:
[00005b0c] 4297                      clr.l      (a7)
[00005b0e] 2f2d 0008                 move.l     8(a5),-(a7)
[00005b12] 4eb9 0000 aa76            jsr        _free
[00005b18] 588f                      addq.l     #4,a7
[00005b1a] 2e95                      move.l     (a5),(a7)
[00005b1c] 2f0d                      move.l     a5,-(a7)
[00005b1e] 4eb9 0000 aa76            jsr        _free
[00005b24] 588f                      addq.l     #4,a7
[00005b26] 2a47                      movea.l    d7,a5
[00005b28] 608a                      bra.s      _pend_6
_pend_3:
[00005b2a] 4878 0004                 pea.l      ($00000004).w
[00005b2e] 486d 0010                 pea.l      16(a5)
[00005b32] 486e fffc                 pea.l      -4(a6)
[00005b36] 4eb9 0000 adac            jsr        _cpybuf
[00005b3c] 4fef 000c                 lea.l      12(a7),a7
[00005b40] 4878 0001                 pea.l      ($00000001).w
[00005b44] 2f3c 0002 120a            move.l     #$0002120A,-(a7)
[00005b4a] 3e2e fffe                 move.w     -2(a6),d7
[00005b4e] 48c7                      ext.l      d7
[00005b50] 2f07                      move.l     d7,-(a7)
[00005b52] 4eb9 0000 661a            jsr        _ptname
[00005b58] 4fef 000c                 lea.l      12(a7),a7
[00005b5c] 246d 0008                 movea.l    8(a5),a2
[00005b60] 4287                      clr.l      d7
[00005b62] 3e12                      move.w     (a2),d7
[00005b64] 2e87                      move.l     d7,(a7)
[00005b66] 2f2d 0008                 move.l     8(a5),-(a7)
[00005b6a] 5497                      addq.l     #2,(a7)
[00005b6c] 4eb9 0000 61ca            jsr        _pstr
[00005b72] 588f                      addq.l     #4,a7
[00005b74] 4eba ff16                 jsr        _pdend(pc)
[00005b78] 6092                      bra.s      _pend_2

_pfend:
[00005b7a] 4e56 fffc                 link       a6,#-4
[00005b7e] 4ab9 0002 0b8a            tst.l      _oldflag
[00005b84] 660a                      bne.s      _pfend_1
[00005b86] 2ebc 0000 00d3            move.l     #$000000D3,(a7)
[00005b8c] 4eba fe88                 jsr        _pcode(pc)
_pfend_1:
[00005b90] 4e5e                      unlk       a6
[00005b92] 4e75                      rts

_pfloat:
[00005b94] 4e56 fffc                 link       a6,#-4
[00005b98] 2ebc 0002 120c            move.l     #$0002120C,(a7)
[00005b9e] 4878 0008                 pea.l      ($00000008).w
[00005ba2] 2f2e 0008                 move.l     8(a6),-(a7)
[00005ba6] 4eb9 0000 a3ec            jsr        _notbuf
[00005bac] 508f                      addq.l     #8,a7
[00005bae] 0c87 0000 0008            cmpi.l     #$00000008,d7
[00005bb4] 660c                      bne.s      _pfloat_1
[00005bb6] 2eae 000c                 move.l     12(a6),(a7)
[00005bba] 4eb9 0000 6140            jsr        _pspace
[00005bc0] 6022                      bra.s      _pfloat_2
_pfloat_1:
[00005bc2] 2ebc 0000 0085            move.l     #$00000085,(a7)
[00005bc8] 4eba fe4c                 jsr        _pcode(pc)
[00005bcc] 2eae 000c                 move.l     12(a6),(a7)
[00005bd0] 4eba fe44                 jsr        _pcode(pc)
[00005bd4] 4878 0008                 pea.l      ($00000008).w
[00005bd8] 2f2e 0008                 move.l     8(a6),-(a7)
[00005bdc] 4eb9 0000 695c            jsr        _putbytes
[00005be2] 508f                      addq.l     #8,a7
_pfloat_2:
[00005be4] 2e2e 000c                 move.l     12(a6),d7
[00005be8] 4e5e                      unlk       a6
[00005bea] 4e75                      rts

_pfunc:
[00005bec] 4e56 0000                 link       a6,#0
[00005bf0] 48e7 8004                 movem.l    d0/a5,-(a7)
[00005bf4] 2a6e 0008                 movea.l    8(a6),a5
[00005bf8] 2ebc 0000 0086            move.l     #$00000086,(a7)
[00005bfe] 4eba fe16                 jsr        _pcode(pc)
[00005c02] 4878 0001                 pea.l      ($00000001).w
[00005c06] 486d 0010                 pea.l      16(a5)
[00005c0a] 3e2d 0008                 move.w     8(a5),d7
[00005c0e] 48c7                      ext.l      d7
[00005c10] 2f07                      move.l     d7,-(a7)
[00005c12] 4eb9 0000 661a            jsr        _ptname
[00005c18] 4fef 000c                 lea.l      12(a7),a7
[00005c1c] 4ab9 0002 0b8a            tst.l      _oldflag
[00005c22] 6608                      bne.s      _pfunc_1
[00005c24] 2e8d                      move.l     a5,(a7)
[00005c26] 4eb9 0000 6a90            jsr        _spaceinf
_pfunc_1:
[00005c2c] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00005c30] 4e5e                      unlk       a6
[00005c32] 4e75                      rts

_pint:
[00005c34] 4e56 0000                 link       a6,#0
[00005c38] 48e7 8400                 movem.l    d0/d5,-(a7)
[00005c3c] 2a2e 000c                 move.l     12(a6),d5
[00005c40] 4aae 0008                 tst.l      8(a6)
[00005c44] 660a                      bne.s      _pint_1
[00005c46] 2e85                      move.l     d5,(a7)
[00005c48] 4eb9 0000 6140            jsr        _pspace
[00005c4e] 6020                      bra.s      _pint_2
_pint_1:
[00005c50] 2ebc 0000 0089            move.l     #$00000089,(a7)
[00005c56] 4eba fdbe                 jsr        _pcode(pc)
[00005c5a] 2e85                      move.l     d5,(a7)
[00005c5c] 4eba fdb8                 jsr        _pcode(pc)
[00005c60] 4878 0004                 pea.l      ($00000004).w
[00005c64] 486e 0008                 pea.l      8(a6)
[00005c68] 4eb9 0000 695c            jsr        _putbytes
[00005c6e] 508f                      addq.l     #8,a7
_pint_2:
[00005c70] 2e05                      move.l     d5,d7
[00005c72] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00005c76] 4e5e                      unlk       a6
[00005c78] 4e75                      rts

_pjc:
[00005c7a] 4e56 fffa                 link       a6,#-6
[00005c7e] 3d6e 0016 fffe            move.w     22(a6),-2(a6)
[00005c84] 4a6e fffe                 tst.w      -2(a6)
[00005c88] 6608                      bne.s      _pjc_1
[00005c8a] 4eba fa78                 jsr        _crs(pc)
[00005c8e] 3d47 fffe                 move.w     d7,-2(a6)
_pjc_1:
[00005c92] 2eae 0008                 move.l     8(a6),(a7)
[00005c96] 2f3c 0002 11e4            move.l     #$000211E4,-(a7)
[00005c9c] 4eb9 0000 a7a6            jsr        _scnstr
[00005ca2] 588f                      addq.l     #4,a7
[00005ca4] 2447                      movea.l    d7,a2
[00005ca6] d5fc 0002 11f2            adda.l     #$000211F2,a2
[00005cac] 1e12                      move.b     (a2),d7
[00005cae] 4887                      ext.w      d7
[00005cb0] 48c7                      ext.l      d7
[00005cb2] 2e87                      move.l     d7,(a7)
[00005cb4] 4eba fd60                 jsr        _pcode(pc)
[00005cb8] 4878 0002                 pea.l      ($00000002).w
[00005cbc] 486e fffe                 pea.l      -2(a6)
[00005cc0] 4eb9 0000 695c            jsr        _putbytes
[00005cc6] 508f                      addq.l     #8,a7
[00005cc8] 2eae 000c                 move.l     12(a6),(a7)
[00005ccc] 4eb9 0000 64da            jsr        _ptexpr
[00005cd2] 2eae 0010                 move.l     16(a6),(a7)
[00005cd6] 4eb9 0000 64da            jsr        _ptexpr
[00005cdc] 4eba fdc8                 jsr        _pend(pc)
[00005ce0] 3e2e fffe                 move.w     -2(a6),d7
[00005ce4] 48c7                      ext.l      d7
[00005ce6] 4e5e                      unlk       a6
[00005ce8] 4e75                      rts

_pjf:
[00005cea] 4e56 fffe                 link       a6,#-2
[00005cee] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00005cf2] 2a6e 0008                 movea.l    8(a6),a5
[00005cf6] 2a2e 000c                 move.l     12(a6),d5
[00005cfa] 282e 0010                 move.l     16(a6),d4
[00005cfe] 2e0d                      move.l     a5,d7
[00005d00] 660e                      bne.s      _pjf_1
[00005d02] 4a85                      tst.l      d5
[00005d04] 6704                      beq.s      _pjf_2
[00005d06] 2e05                      move.l     d5,d7
[00005d08] 6004                      bra.s      _pjf_3
_pjf_2:
[00005d0a] 4eba f9f8                 jsr        _crs(pc)
_pjf_3:
[00005d0e] 602a                      bra.s      _pjf_4
_pjf_1:
[00005d10] 4287                      clr.l      d7
[00005d12] 1e2d 0016                 move.b     22(a5),d7
[00005d16] 0c47 0082                 cmpi.w     #$0082,d7
[00005d1a] 6626                      bne.s      _pjf_5
[00005d1c] 4297                      clr.l      (a7)
[00005d1e] 2f05                      move.l     d5,-(a7)
[00005d20] 2f2d 0008                 move.l     8(a5),-(a7)
[00005d24] 4eba ffc4                 jsr        _pjf(pc)
[00005d28] 508f                      addq.l     #8,a7
[00005d2a] 2a07                      move.l     d7,d5
[00005d2c] 2e84                      move.l     d4,(a7)
[00005d2e] 2f05                      move.l     d5,-(a7)
[00005d30] 2f2d 000c                 move.l     12(a5),-(a7)
[00005d34] 4eba ffb4                 jsr        _pjf(pc)
[00005d38] 508f                      addq.l     #8,a7
_pjf_4:
[00005d3a] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00005d3e] 4e5e                      unlk       a6
[00005d40] 4e75                      rts
_pjf_5:
[00005d42] 4287                      clr.l      d7
[00005d44] 1e2d 0016                 move.b     22(a5),d7
[00005d48] 0c47 009d                 cmpi.w     #$009D,d7
[00005d4c] 6622                      bne.s      _pjf_6
[00005d4e] 2e84                      move.l     d4,(a7)
[00005d50] 42a7                      clr.l      -(a7)
[00005d52] 2f2d 0008                 move.l     8(a5),-(a7)
[00005d56] 4eb9 0000 5f2e            jsr        _pjt
[00005d5c] 508f                      addq.l     #8,a7
[00005d5e] 2807                      move.l     d7,d4
[00005d60] 2e84                      move.l     d4,(a7)
[00005d62] 2f05                      move.l     d5,-(a7)
[00005d64] 2f2d 000c                 move.l     12(a5),-(a7)
[00005d68] 4eba ff80                 jsr        _pjf(pc)
[00005d6c] 508f                      addq.l     #8,a7
[00005d6e] 60ca                      bra.s      _pjf_4
_pjf_6:
[00005d70] 4287                      clr.l      d7
[00005d72] 1e2d 0016                 move.b     22(a5),d7
[00005d76] 0c47 005a                 cmpi.w     #$005A,d7
[00005d7a] 6612                      bne.s      _pjf_7
[00005d7c] 2e85                      move.l     d5,(a7)
[00005d7e] 2f04                      move.l     d4,-(a7)
[00005d80] 2f2d 0008                 move.l     8(a5),-(a7)
[00005d84] 4eb9 0000 5f2e            jsr        _pjt
[00005d8a] 508f                      addq.l     #8,a7
[00005d8c] 60ac                      bra.s      _pjf_4
_pjf_7:
[00005d8e] 4287                      clr.l      d7
[00005d90] 1e2d 0016                 move.b     22(a5),d7
[00005d94] 2e87                      move.l     d7,(a7)
[00005d96] 2f3c 0002 11e4            move.l     #$000211E4,-(a7)
[00005d9c] 4eb9 0000 a7a6            jsr        _scnstr
[00005da2] 588f                      addq.l     #4,a7
[00005da4] 1d47 ffff                 move.b     d7,-1(a6)
[00005da8] 1e2e ffff                 move.b     -1(a6),d7
[00005dac] 4887                      ext.w      d7
[00005dae] 48c7                      ext.l      d7
[00005db0] 2447                      movea.l    d7,a2
[00005db2] d5fc 0002 11e4            adda.l     #$000211E4,a2
[00005db8] 4a12                      tst.b      (a2)
[00005dba] 6734                      beq.s      _pjf_8
[00005dbc] 2e85                      move.l     d5,(a7)
[00005dbe] 2f2d 000c                 move.l     12(a5),-(a7)
[00005dc2] 2f2d 0008                 move.l     8(a5),-(a7)
[00005dc6] 247c 0002 11eb            movea.l    #$000211EB,a2
[00005dcc] 1e2e ffff                 move.b     -1(a6),d7
[00005dd0] 4887                      ext.w      d7
[00005dd2] 48c7                      ext.l      d7
[00005dd4] d5c7                      adda.l     d7,a2
[00005dd6] 1e12                      move.b     (a2),d7
[00005dd8] 4887                      ext.w      d7
[00005dda] 48c7                      ext.l      d7
[00005ddc] 0287 0000 00ff            andi.l     #$000000FF,d7
[00005de2] 2f07                      move.l     d7,-(a7)
[00005de4] 4eba fe94                 jsr        _pjc(pc)
[00005de8] 4fef 000c                 lea.l      12(a7),a7
[00005dec] 2a07                      move.l     d7,d5
[00005dee] 6018                      bra.s      _pjf_9
_pjf_8:
[00005df0] 2e85                      move.l     d5,(a7)
[00005df2] 2f3c 0002 11cc            move.l     #_zeterm,-(a7)
[00005df8] 2f0d                      move.l     a5,-(a7)
[00005dfa] 4878 0094                 pea.l      ($00000094).w
[00005dfe] 4eba fe7a                 jsr        _pjc(pc)
[00005e02] 4fef 000c                 lea.l      12(a7),a7
[00005e06] 2a07                      move.l     d7,d5
_pjf_9:
[00005e08] 2e84                      move.l     d4,(a7)
[00005e0a] 4eb9 0000 6036            jsr        _plabel
[00005e10] 2e05                      move.l     d5,d7
[00005e12] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00005e16] 4e5e                      unlk       a6
[00005e18] 4e75                      rts

_pjmptab:
[00005e1a] 4e56 fffa                 link       a6,#-6
[00005e1e] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00005e22] 2a6e 0008                 movea.l    8(a6),a5
[00005e26] 2a2e 000c                 move.l     12(a6),d5
[00005e2a] 4a85                      tst.l      d5
[00005e2c] 6608                      bne.s      _pjmptab_1
[00005e2e] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00005e32] 4e5e                      unlk       a6
[00005e34] 4e75                      rts
_pjmptab_1:
[00005e36] 2ebc 0000 00cd            move.l     #$000000CD,(a7)
[00005e3c] 4eba fbd8                 jsr        _pcode(pc)
[00005e40] 284d                      movea.l    a5,a4
[00005e42] 2445                      movea.l    d5,a2
[00005e44] 538a                      subq.l     #1,a2
[00005e46] 2d4a fffc                 move.l     a2,-4(a6)
_pjmptab_3:
[00005e4a] 4aae fffc                 tst.l      -4(a6)
[00005e4e] 6708                      beq.s      _pjmptab_2
[00005e50] 53ae fffc                 subq.l     #1,-4(a6)
[00005e54] 2854                      movea.l    (a4),a4
[00005e56] 60f2                      bra.s      _pjmptab_3
_pjmptab_2:
[00005e58] 2e2c 0006                 move.l     6(a4),d7
[00005e5c] 9ead 0006                 sub.l      6(a5),d7
[00005e60] 5287                      addq.l     #1,d7
[00005e62] 2d47 fffc                 move.l     d7,-4(a6)
[00005e66] 3d6e fffe fffa            move.w     -2(a6),-6(a6)
[00005e6c] 4878 0002                 pea.l      ($00000002).w
[00005e70] 486e fffa                 pea.l      -6(a6)
[00005e74] 4eb9 0000 695c            jsr        _putbytes
[00005e7a] 508f                      addq.l     #8,a7
[00005e7c] 4878 0004                 pea.l      ($00000004).w
[00005e80] 486d 0006                 pea.l      6(a5)
[00005e84] 4eb9 0000 695c            jsr        _putbytes
[00005e8a] 508f                      addq.l     #8,a7
[00005e8c] 3d6e 0012 fffa            move.w     18(a6),-6(a6)
[00005e92] 284d                      movea.l    a5,a4
[00005e94] 2d6d 0006 fffc            move.l     6(a5),-4(a6)
_pjmptab_7:
[00005e9a] 4a85                      tst.l      d5
[00005e9c] 6720                      beq.s      _pjmptab_4
[00005e9e] 2e2e fffc                 move.l     -4(a6),d7
[00005ea2] beac 0006                 cmp.l      6(a4),d7
[00005ea6] 6620                      bne.s      _pjmptab_5
[00005ea8] 4878 0002                 pea.l      ($00000002).w
[00005eac] 486c 0004                 pea.l      4(a4)
[00005eb0] 4eb9 0000 695c            jsr        _putbytes
[00005eb6] 508f                      addq.l     #8,a7
[00005eb8] 2854                      movea.l    (a4),a4
[00005eba] 5385                      subq.l     #1,d5
[00005ebc] 601a                      bra.s      _pjmptab_6
_pjmptab_4:
[00005ebe] 2e0c                      move.l     a4,d7
[00005ec0] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00005ec4] 4e5e                      unlk       a6
[00005ec6] 4e75                      rts
_pjmptab_5:
[00005ec8] 4878 0002                 pea.l      ($00000002).w
[00005ecc] 486e fffa                 pea.l      -6(a6)
[00005ed0] 4eb9 0000 695c            jsr        _putbytes
[00005ed6] 508f                      addq.l     #8,a7
_pjmptab_6:
[00005ed8] 52ae fffc                 addq.l     #1,-4(a6)
[00005edc] 60bc                      bra.s      _pjmptab_7

_pjump:
[00005ede] 4e56 fffe                 link       a6,#-2
[00005ee2] 48e7 8400                 movem.l    d0/d5,-(a7)
[00005ee6] 2a2e 000c                 move.l     12(a6),d5
[00005eea] 3d6e 000a fffe            move.w     10(a6),-2(a6)
[00005ef0] 4a6e fffe                 tst.w      -2(a6)
[00005ef4] 6608                      bne.s      _pjump_1
[00005ef6] 4eba f80c                 jsr        _crs(pc)
[00005efa] 3d47 fffe                 move.w     d7,-2(a6)
_pjump_1:
[00005efe] 2ebc 0000 008b            move.l     #$0000008B,(a7)
[00005f04] 4eba fb10                 jsr        _pcode(pc)
[00005f08] 4878 0002                 pea.l      ($00000002).w
[00005f0c] 486e fffe                 pea.l      -2(a6)
[00005f10] 4eb9 0000 695c            jsr        _putbytes
[00005f16] 508f                      addq.l     #8,a7
[00005f18] 2e85                      move.l     d5,(a7)
[00005f1a] 4eb9 0000 6036            jsr        _plabel
[00005f20] 3e2e fffe                 move.w     -2(a6),d7
[00005f24] 48c7                      ext.l      d7
[00005f26] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00005f2a] 4e5e                      unlk       a6
[00005f2c] 4e75                      rts

_pjt:
[00005f2e] 4e56 0000                 link       a6,#0
[00005f32] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00005f36] 2a6e 0008                 movea.l    8(a6),a5
[00005f3a] 2a2e 000c                 move.l     12(a6),d5
[00005f3e] 282e 0010                 move.l     16(a6),d4
[00005f42] 2e0d                      move.l     a5,d7
[00005f44] 660c                      bne.s      _pjt_1
[00005f46] 2e85                      move.l     d5,(a7)
[00005f48] 2f04                      move.l     d4,-(a7)
[00005f4a] 4eba ff92                 jsr        _pjump(pc)
[00005f4e] 588f                      addq.l     #4,a7
[00005f50] 602a                      bra.s      _pjt_2
_pjt_1:
[00005f52] 4287                      clr.l      d7
[00005f54] 1e2d 0016                 move.b     22(a5),d7
[00005f58] 0c47 0082                 cmpi.w     #$0082,d7
[00005f5c] 6626                      bne.s      _pjt_3
[00005f5e] 4297                      clr.l      (a7)
[00005f60] 2f05                      move.l     d5,-(a7)
[00005f62] 2f2d 0008                 move.l     8(a5),-(a7)
[00005f66] 4eba fd82                 jsr        _pjf(pc)
[00005f6a] 508f                      addq.l     #8,a7
[00005f6c] 2a07                      move.l     d7,d5
[00005f6e] 2e84                      move.l     d4,(a7)
[00005f70] 2f05                      move.l     d5,-(a7)
[00005f72] 2f2d 000c                 move.l     12(a5),-(a7)
[00005f76] 4eba ffb6                 jsr        _pjt(pc)
[00005f7a] 508f                      addq.l     #8,a7
_pjt_2:
[00005f7c] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00005f80] 4e5e                      unlk       a6
[00005f82] 4e75                      rts
_pjt_3:
[00005f84] 4287                      clr.l      d7
[00005f86] 1e2d 0016                 move.b     22(a5),d7
[00005f8a] 0c47 009d                 cmpi.w     #$009D,d7
[00005f8e] 6620                      bne.s      _pjt_4
[00005f90] 2e84                      move.l     d4,(a7)
[00005f92] 42a7                      clr.l      -(a7)
[00005f94] 2f2d 0008                 move.l     8(a5),-(a7)
[00005f98] 4eba ff94                 jsr        _pjt(pc)
[00005f9c] 508f                      addq.l     #8,a7
[00005f9e] 2807                      move.l     d7,d4
[00005fa0] 2e84                      move.l     d4,(a7)
[00005fa2] 2f05                      move.l     d5,-(a7)
[00005fa4] 2f2d 000c                 move.l     12(a5),-(a7)
[00005fa8] 4eba ff84                 jsr        _pjt(pc)
[00005fac] 508f                      addq.l     #8,a7
[00005fae] 60cc                      bra.s      _pjt_2
_pjt_4:
[00005fb0] 4287                      clr.l      d7
[00005fb2] 1e2d 0016                 move.b     22(a5),d7
[00005fb6] 0c47 005a                 cmpi.w     #$005A,d7
[00005fba] 6610                      bne.s      _pjt_5
[00005fbc] 2e85                      move.l     d5,(a7)
[00005fbe] 2f04                      move.l     d4,-(a7)
[00005fc0] 2f2d 0008                 move.l     8(a5),-(a7)
[00005fc4] 4eba fd24                 jsr        _pjf(pc)
[00005fc8] 508f                      addq.l     #8,a7
[00005fca] 60b0                      bra.s      _pjt_2
_pjt_5:
[00005fcc] 4287                      clr.l      d7
[00005fce] 1e2d 0016                 move.b     22(a5),d7
[00005fd2] 2e87                      move.l     d7,(a7)
[00005fd4] 2f3c 0002 11e4            move.l     #$000211E4,-(a7)
[00005fda] 4eb9 0000 a7a6            jsr        _scnstr
[00005fe0] 588f                      addq.l     #4,a7
[00005fe2] 2447                      movea.l    d7,a2
[00005fe4] d5fc 0002 11e4            adda.l     #$000211E4,a2
[00005fea] 4a12                      tst.b      (a2)
[00005fec] 671e                      beq.s      _pjt_6
[00005fee] 2e84                      move.l     d4,(a7)
[00005ff0] 2f2d 000c                 move.l     12(a5),-(a7)
[00005ff4] 2f2d 0008                 move.l     8(a5),-(a7)
[00005ff8] 4287                      clr.l      d7
[00005ffa] 1e2d 0016                 move.b     22(a5),d7
[00005ffe] 2f07                      move.l     d7,-(a7)
[00006000] 4eba fc78                 jsr        _pjc(pc)
[00006004] 4fef 000c                 lea.l      12(a7),a7
[00006008] 2807                      move.l     d7,d4
[0000600a] 6018                      bra.s      _pjt_7
_pjt_6:
[0000600c] 2e84                      move.l     d4,(a7)
[0000600e] 2f3c 0002 11cc            move.l     #_zeterm,-(a7)
[00006014] 2f0d                      move.l     a5,-(a7)
[00006016] 4878 009b                 pea.l      ($0000009B).w
[0000601a] 4eba fc5e                 jsr        _pjc(pc)
[0000601e] 4fef 000c                 lea.l      12(a7),a7
[00006022] 2807                      move.l     d7,d4
_pjt_7:
[00006024] 2e85                      move.l     d5,(a7)
[00006026] 4eb9 0000 6036            jsr        _plabel
[0000602c] 2e04                      move.l     d4,d7
[0000602e] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00006032] 4e5e                      unlk       a6
[00006034] 4e75                      rts

_plabel:
[00006036] 4e56 fffa                 link       a6,#-6
[0000603a] 3d6e 000a fffe            move.w     10(a6),-2(a6)
[00006040] 4a6e fffe                 tst.w      -2(a6)
[00006044] 672c                      beq.s      _plabel_1
[00006046] 2ebc 0000 008c            move.l     #$0000008C,(a7)
[0000604c] 4eba f9c8                 jsr        _pcode(pc)
[00006050] 4878 0002                 pea.l      ($00000002).w
[00006054] 486e fffe                 pea.l      -2(a6)
[00006058] 4eb9 0000 695c            jsr        _putbytes
[0000605e] 508f                      addq.l     #8,a7
[00006060] 4878 0002                 pea.l      ($00000002).w
[00006064] 2f3c 0002 0cd4            move.l     #_lineno,-(a7)
[0000606a] 4eb9 0000 695c            jsr        _putbytes
[00006070] 508f                      addq.l     #8,a7
_plabel_1:
[00006072] 3e2e fffe                 move.w     -2(a6),d7
[00006076] 48c7                      ext.l      d7
[00006078] 4e5e                      unlk       a6
[0000607a] 4e75                      rts

_pmove:
[0000607c] 4e56 fffc                 link       a6,#-4
[00006080] 4297                      clr.l      (a7)
[00006082] 4878 0018                 pea.l      ($00000018).w
[00006086] 2f3c 0002 120e            move.l     #$0002120E,-(a7)
[0000608c] 4eb9 0000 9d7e            jsr        _fill
[00006092] 508f                      addq.l     #8,a7
[00006094] 13fc 00af 0002 1224       move.b     #$AF,$00021224
[0000609c] 23ee 0008 0002 1216       move.l     8(a6),$00021216
[000060a4] 23ee 000c 0002 121a       move.l     12(a6),$0002121A
[000060ac] 2ebc 0002 120e            move.l     #$0002120E,(a7)
[000060b2] 4eb9 0000 94c6            jsr        _typify
[000060b8] 2e87                      move.l     d7,(a7)
[000060ba] 4eb9 0000 6988            jsr        _pvoid
[000060c0] 4e5e                      unlk       a6
[000060c2] 4e75                      rts

_preforde:
[000060c4] 4e56 fffc                 link       a6,#-4
[000060c8] 2eae 000c                 move.l     12(a6),(a7)
[000060cc] 4eba f948                 jsr        _pcode(pc)
[000060d0] 4878 0001                 pea.l      ($00000001).w
[000060d4] 7e10                      moveq.l    #16,d7
[000060d6] deae 0008                 add.l      8(a6),d7
[000060da] 2f07                      move.l     d7,-(a7)
[000060dc] 42a7                      clr.l      -(a7)
[000060de] 4eb9 0000 661a            jsr        _ptname
[000060e4] 4fef 000c                 lea.l      12(a7),a7
[000060e8] 4ab9 0002 0b8a            tst.l      _oldflag
[000060ee] 660a                      bne.s      _preforde_1
[000060f0] 2eae 0008                 move.l     8(a6),(a7)
[000060f4] 4eb9 0000 6a90            jsr        _spaceinf
_preforde_1:
[000060fa] 4e5e                      unlk       a6
[000060fc] 4e75                      rts

_pregs:
[000060fe] 4e56 0000                 link       a6,#0
[00006102] 48e7 8400                 movem.l    d0/d5,-(a7)
[00006106] 2a2e 0008                 move.l     8(a6),d5
[0000610a] 2ebc 0000 0091            move.l     #$00000091,(a7)
[00006110] 4eba f904                 jsr        _pcode(pc)
[00006114] 7e1c                      moveq.l    #28,d7
[00006116] ce85                      and.l      d5,d7
[00006118] 7ce3                      moveq.l    #-29,d6
[0000611a] cc85                      and.l      d5,d6
[0000611c] ec86                      asr.l      #6,d6
[0000611e] 8e86                      or.l       d6,d7
[00006120] 2e87                      move.l     d7,(a7)
[00006122] 4eba f8f2                 jsr        _pcode(pc)
[00006126] 4cdf 0021                 movem.l    (a7)+,d0/d5
[0000612a] 4e5e                      unlk       a6
[0000612c] 4e75                      rts

_pret:
[0000612e] 4e56 fffc                 link       a6,#-4
[00006132] 2ebc 0000 0092            move.l     #$00000092,(a7)
[00006138] 4eba f8dc                 jsr        _pcode(pc)
[0000613c] 4e5e                      unlk       a6
[0000613e] 4e75                      rts

_pspace:
[00006140] 4e56 fffc                 link       a6,#-4
[00006144] 4aae 0008                 tst.l      8(a6)
[00006148] 6f1a                      ble.s      _pspace_1
[0000614a] 2ebc 0000 0093            move.l     #$00000093,(a7)
[00006150] 4eba f8c4                 jsr        _pcode(pc)
[00006154] 4878 0004                 pea.l      ($00000004).w
[00006158] 486e 0008                 pea.l      8(a6)
[0000615c] 4eb9 0000 695c            jsr        _putbytes
[00006162] 508f                      addq.l     #8,a7
_pspace_1:
[00006164] 4e5e                      unlk       a6
[00006166] 4e75                      rts

_pscntab:
[00006168] 4e56 fffe                 link       a6,#-2
[0000616c] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00006170] 2a2e 000c                 move.l     12(a6),d5
[00006174] 2ebc 0000 00ce            move.l     #$000000CE,(a7)
[0000617a] 4eba f89a                 jsr        _pcode(pc)
[0000617e] 3d45 fffe                 move.w     d5,-2(a6)
[00006182] 4878 0002                 pea.l      ($00000002).w
[00006186] 486e fffe                 pea.l      -2(a6)
[0000618a] 4eb9 0000 695c            jsr        _putbytes
[00006190] 508f                      addq.l     #8,a7
[00006192] 2a6e 0008                 movea.l    8(a6),a5
_pscntab_2:
[00006196] 4a85                      tst.l      d5
[00006198] 6726                      beq.s      _pscntab_1
[0000619a] 4878 0004                 pea.l      ($00000004).w
[0000619e] 486d 0006                 pea.l      6(a5)
[000061a2] 4eb9 0000 695c            jsr        _putbytes
[000061a8] 508f                      addq.l     #8,a7
[000061aa] 4878 0002                 pea.l      ($00000002).w
[000061ae] 486d 0004                 pea.l      4(a5)
[000061b2] 4eb9 0000 695c            jsr        _putbytes
[000061b8] 508f                      addq.l     #8,a7
[000061ba] 5385                      subq.l     #1,d5
[000061bc] 2a55                      movea.l    (a5),a5
[000061be] 60d6                      bra.s      _pscntab_2
_pscntab_1:
[000061c0] 2e0d                      move.l     a5,d7
[000061c2] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[000061c6] 4e5e                      unlk       a6
[000061c8] 4e75                      rts

_pstr:
[000061ca] 4e56 0000                 link       a6,#0
[000061ce] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[000061d2] 2a6e 0008                 movea.l    8(a6),a5
[000061d6] 2a2e 000c                 move.l     12(a6),d5
[000061da] 2ebc 0002 1226            move.l     #$00021226,(a7)
[000061e0] 2f05                      move.l     d5,-(a7)
[000061e2] 2f0d                      move.l     a5,-(a7)
[000061e4] 4eb9 0000 a3ec            jsr        _notbuf
[000061ea] 508f                      addq.l     #8,a7
[000061ec] be85                      cmp.l      d5,d7
[000061ee] 660e                      bne.s      _pstr_1
[000061f0] 2e85                      move.l     d5,(a7)
[000061f2] 4eba ff4c                 jsr        _pspace(pc)
_pstr_4:
[000061f6] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[000061fa] 4e5e                      unlk       a6
[000061fc] 4e75                      rts
_pstr_1:
[000061fe] 0c85 0000 0100            cmpi.l     #$00000100,d5
[00006204] 642e                      bcc.s      _pstr_2
[00006206] 4a85                      tst.l      d5
[00006208] 6706                      beq.s      _pstr_3
[0000620a] 4a35 58ff                 tst.b      -1(a5,d5.l)
[0000620e] 6624                      bne.s      _pstr_2
_pstr_3:
[00006210] 4a85                      tst.l      d5
[00006212] 67e2                      beq.s      _pstr_4
[00006214] 2ebc 0000 0094            move.l     #$00000094,(a7)
[0000621a] 4eba f7fa                 jsr        _pcode(pc)
[0000621e] 5385                      subq.l     #1,d5
[00006220] 2e85                      move.l     d5,(a7)
[00006222] 4eba f7f2                 jsr        _pcode(pc)
[00006226] 2e85                      move.l     d5,(a7)
[00006228] 2f0d                      move.l     a5,-(a7)
[0000622a] 4eb9 0000 695c            jsr        _putbytes
[00006230] 588f                      addq.l     #4,a7
[00006232] 60c2                      bra.s      _pstr_4
_pstr_2:
[00006234] 4878 0001                 pea.l      ($00000001).w
[00006238] 4287                      clr.l      d7
[0000623a] 1e15                      move.b     (a5),d7
[0000623c] 2f07                      move.l     d7,-(a7)
[0000623e] 4eba f9f4                 jsr        _pint(pc)
[00006242] 508f                      addq.l     #8,a7
[00006244] 5385                      subq.l     #1,d5
[00006246] 528d                      addq.l     #1,a5
[00006248] 60b4                      bra.s      _pstr_1

_pswitch:
[0000624a] 4e56 fffa                 link       a6,#-6
[0000624e] 3d6e 000a fffe            move.w     10(a6),-2(a6)
[00006254] 4878 0001                 pea.l      ($00000001).w
[00006258] 2f3c 0002 0dc2            move.l     #_atint,-(a7)
[0000625e] 4eb9 0000 7b74            jsr        _bytes
[00006264] 508f                      addq.l     #8,a7
[00006266] beae 000c                 cmp.l      12(a6),d7
[0000626a] 6408                      bcc.s      _pswitch_1
[0000626c] 2e3c 0000 00bd            move.l     #$000000BD,d7
[00006272] 6006                      bra.s      _pswitch_2
_pswitch_1:
[00006274] 2e3c 0000 0095            move.l     #$00000095,d7
_pswitch_2:
[0000627a] 2e87                      move.l     d7,(a7)
[0000627c] 4eba f798                 jsr        _pcode(pc)
[00006280] 4878 0002                 pea.l      ($00000002).w
[00006284] 486e fffe                 pea.l      -2(a6)
[00006288] 4eb9 0000 695c            jsr        _putbytes
[0000628e] 508f                      addq.l     #8,a7
[00006290] 4e5e                      unlk       a6
[00006292] 4e75                      rts

_pswtab:
[00006294] 4e56 0000                 link       a6,#0
[00006298] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000629c] 2a6e 0008                 movea.l    8(a6),a5
[000062a0] 2a2e 000c                 move.l     12(a6),d5
[000062a4] 4ab9 0002 0b8a            tst.l      _oldflag
[000062aa] 6700 0078                 beq.w      _pswtab_1
[000062ae] 2ebc 0000 00b9            move.l     #$000000B9,(a7)
[000062b4] 4eba f760                 jsr        _pcode(pc)
[000062b8] 2ebc 0002 0dd4            move.l     #_atunsign,(a7)
[000062be] 4eb9 0000 78b4            jsr        _bound
[000062c4] 2e87                      move.l     d7,(a7)
[000062c6] 4eba f74e                 jsr        _pcode(pc)
[000062ca] 4878 0001                 pea.l      ($00000001).w
[000062ce] 2f3c 0002 077c            move.l     #_noname,-(a7)
[000062d4] 2f2e 0014                 move.l     20(a6),-(a7)
[000062d8] 4eb9 0000 661a            jsr        _ptname
[000062de] 4fef 000c                 lea.l      12(a7),a7
[000062e2] 284d                      movea.l    a5,a4
_pswtab_3:
[000062e4] 2e0c                      move.l     a4,d7
[000062e6] 675a                      beq.s      _pswtab_2
[000062e8] 4297                      clr.l      (a7)
[000062ea] 42a7                      clr.l      -(a7)
[000062ec] 4878 0004                 pea.l      ($00000004).w
[000062f0] 42a7                      clr.l      -(a7)
[000062f2] 2f3c 0002 077c            move.l     #_noname,-(a7)
[000062f8] 3e2c 0004                 move.w     4(a4),d7
[000062fc] 48c7                      ext.l      d7
[000062fe] 2f07                      move.l     d7,-(a7)
[00006300] 4eba f606                 jsr        _paddr(pc)
[00006304] 4fef 0014                 lea.l      20(a7),a7
[00006308] 2e85                      move.l     d5,(a7)
[0000630a] 2f2c 0006                 move.l     6(a4),-(a7)
[0000630e] 4eba f924                 jsr        _pint(pc)
[00006312] 588f                      addq.l     #4,a7
[00006314] 2e94                      move.l     (a4),(a7)
[00006316] 2f0c                      move.l     a4,-(a7)
[00006318] 4eb9 0000 aa76            jsr        _free
[0000631e] 588f                      addq.l     #4,a7
[00006320] 2847                      movea.l    d7,a4
[00006322] 60c0                      bra.s      _pswtab_3
_pswtab_1:
[00006324] 2eae 0014                 move.l     20(a6),(a7)
[00006328] 2f2e 0010                 move.l     16(a6),-(a7)
[0000632c] 2f05                      move.l     d5,-(a7)
[0000632e] 2f0d                      move.l     a5,-(a7)
[00006330] 4eb9 0000 6374            jsr        _pswntab
[00006336] 4fef 000c                 lea.l      12(a7),a7
_pswtab_4:
[0000633a] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000633e] 4e5e                      unlk       a6
[00006340] 4e75                      rts
_pswtab_2:
[00006342] 2e85                      move.l     d5,(a7)
[00006344] 42a7                      clr.l      -(a7)
[00006346] 4eba f8ec                 jsr        _pint(pc)
[0000634a] 588f                      addq.l     #4,a7
[0000634c] 4297                      clr.l      (a7)
[0000634e] 42a7                      clr.l      -(a7)
[00006350] 4878 0004                 pea.l      ($00000004).w
[00006354] 42a7                      clr.l      -(a7)
[00006356] 2f3c 0002 077c            move.l     #_noname,-(a7)
[0000635c] 2f2e 0010                 move.l     16(a6),-(a7)
[00006360] 4eba f5a6                 jsr        _paddr(pc)
[00006364] 4fef 0014                 lea.l      20(a7),a7
[00006368] 2ebc 0000 0097            move.l     #$00000097,(a7)
[0000636e] 4eba f6a6                 jsr        _pcode(pc)
[00006372] 60c6                      bra.s      _pswtab_4

_pswntab:
[00006374] 4e56 fff6                 link       a6,#-10
[00006378] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[0000637c] 2ebc 0000 00b9            move.l     #$000000B9,(a7)
[00006382] 4eba f692                 jsr        _pcode(pc)
[00006386] 2ebc 0002 0dd4            move.l     #_atunsign,(a7)
[0000638c] 4eb9 0000 78b4            jsr        _bound
[00006392] 2e87                      move.l     d7,(a7)
[00006394] 4eba f680                 jsr        _pcode(pc)
[00006398] 3d6e 0016 fff6            move.w     22(a6),-10(a6)
[0000639e] 4878 0002                 pea.l      ($00000002).w
[000063a2] 486e fff6                 pea.l      -10(a6)
[000063a6] 4eb9 0000 695c            jsr        _putbytes
[000063ac] 508f                      addq.l     #8,a7
[000063ae] 3d6e 0012 fff6            move.w     18(a6),-10(a6)
[000063b4] 4878 0002                 pea.l      ($00000002).w
[000063b8] 486e fff6                 pea.l      -10(a6)
[000063bc] 4eb9 0000 695c            jsr        _putbytes
[000063c2] 508f                      addq.l     #8,a7
[000063c4] 45ee 0008                 lea.l      8(a6),a2
[000063c8] 2a4a                      movea.l    a2,a5
[000063ca] 426e fff8                 clr.w      -8(a6)
_pswntab_2:
[000063ce] 4a95                      tst.l      (a5)
[000063d0] 6708                      beq.s      _pswntab_1
[000063d2] 526e fff8                 addq.w     #1,-8(a6)
[000063d6] 2a55                      movea.l    (a5),a5
[000063d8] 60f4                      bra.s      _pswntab_2
_pswntab_1:
[000063da] 4878 0002                 pea.l      ($00000002).w
[000063de] 486e fff8                 pea.l      -8(a6)
[000063e2] 4eb9 0000 695c            jsr        _putbytes
[000063e8] 508f                      addq.l     #8,a7
[000063ea] 3d6e 000e fffa            move.w     14(a6),-6(a6)
[000063f0] 4878 0002                 pea.l      ($00000002).w
[000063f4] 486e fffa                 pea.l      -6(a6)
[000063f8] 4eb9 0000 695c            jsr        _putbytes
[000063fe] 508f                      addq.l     #8,a7
[00006400] 2aae 0008                 move.l     8(a6),(a5)
[00006404] 45ee 0008                 lea.l      8(a6),a2
[00006408] 2a4a                      movea.l    a2,a5
_pswntab_8:
[0000640a] 3e2e fff8                 move.w     -8(a6),d7
[0000640e] 48c7                      ext.l      d7
[00006410] 0c47 0003                 cmpi.w     #$0003,d7
[00006414] 6f3e                      ble.s      _pswntab_3
[00006416] 284d                      movea.l    a5,a4
[00006418] 426e fffe                 clr.w      -2(a6)
[0000641c] 426e fffa                 clr.w      -6(a6)
_pswntab_7:
[00006420] 3e2e fffa                 move.w     -6(a6),d7
[00006424] 48c7                      ext.l      d7
[00006426] 3c2e fff8                 move.w     -8(a6),d6
[0000642a] 48c6                      ext.l      d6
[0000642c] be86                      cmp.l      d6,d7
[0000642e] 6c54                      bge.s      _pswntab_4
[00006430] 2e95                      move.l     (a5),(a7)
[00006432] 4eba f302                 jsr        _findlngs(pc)
[00006436] 3d47 fffc                 move.w     d7,-4(a6)
[0000643a] 3e2e fffe                 move.w     -2(a6),d7
[0000643e] 48c7                      ext.l      d7
[00006440] 3c2e fffc                 move.w     -4(a6),d6
[00006444] 48c6                      ext.l      d6
[00006446] be86                      cmp.l      d6,d7
[00006448] 6c48                      bge.s      _pswntab_5
[0000644a] 284d                      movea.l    a5,a4
[0000644c] 3d6e fffc fffe            move.w     -4(a6),-2(a6)
[00006452] 603e                      bra.s      _pswntab_5
_pswntab_3:
[00006454] 3e2e fff8                 move.w     -8(a6),d7
[00006458] 48c7                      ext.l      d7
[0000645a] 2e87                      move.l     d7,(a7)
[0000645c] 2f2e 0008                 move.l     8(a6),-(a7)
[00006460] 4eba fd06                 jsr        _pscntab(pc)
[00006464] 588f                      addq.l     #4,a7
[00006466] 2e87                      move.l     d7,(a7)
[00006468] 2f2e 0008                 move.l     8(a6),-(a7)
[0000646c] 4eba f2fe                 jsr        _freecase(pc)
[00006470] 588f                      addq.l     #4,a7
[00006472] 2ebc 0000 0097            move.l     #$00000097,(a7)
[00006478] 4eba f59c                 jsr        _pcode(pc)
[0000647c] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00006480] 4e5e                      unlk       a6
[00006482] 4e75                      rts
_pswntab_4:
[00006484] 3e2e fffe                 move.w     -2(a6),d7
[00006488] 48c7                      ext.l      d7
[0000648a] 0c47 0003                 cmpi.w     #$0003,d7
[0000648e] 6c0c                      bge.s      _pswntab_6
[00006490] 60c2                      bra.s      _pswntab_3
_pswntab_5:
[00006492] 2a55                      movea.l    (a5),a5
[00006494] 526e fffa                 addq.w     #1,-6(a6)
[00006498] 6000 ff86                 bra.w      _pswntab_7
_pswntab_6:
[0000649c] 2eae 0010                 move.l     16(a6),(a7)
[000064a0] 3e2e fffe                 move.w     -2(a6),d7
[000064a4] 48c7                      ext.l      d7
[000064a6] 2f07                      move.l     d7,-(a7)
[000064a8] 2f14                      move.l     (a4),-(a7)
[000064aa] 4eba f96e                 jsr        _pjmptab(pc)
[000064ae] 508f                      addq.l     #8,a7
[000064b0] 2e87                      move.l     d7,(a7)
[000064b2] 2f14                      move.l     (a4),-(a7)
[000064b4] 4eba f2b6                 jsr        _freecase(pc)
[000064b8] 588f                      addq.l     #4,a7
[000064ba] 2887                      move.l     d7,(a4)
[000064bc] 2e94                      move.l     (a4),(a7)
[000064be] 4eba f34e                 jsr        _gtlcase(pc)
[000064c2] 2d47 0008                 move.l     d7,8(a6)
[000064c6] 45ee 0008                 lea.l      8(a6),a2
[000064ca] 2a4a                      movea.l    a2,a5
[000064cc] 3e2e fffe                 move.w     -2(a6),d7
[000064d0] 48c7                      ext.l      d7
[000064d2] 9f6e fff8                 sub.w      d7,-8(a6)
[000064d6] 6000 ff32                 bra        _pswntab_8

_ptexpr:
[000064da] 4e56 0000                 link       a6,#0
[000064de] 48e7 8004                 movem.l    d0/a5,-(a7)
[000064e2] 2a6e 0008                 movea.l    8(a6),a5
[000064e6] 4287                      clr.l      d7
[000064e8] 1e2d 0016                 move.b     22(a5),d7
[000064ec] 0c47 006d                 cmpi.w     #$006D,d7
[000064f0] 6604                      bne.s      _ptexpr_1
[000064f2] 2a6d 0008                 movea.l    8(a5),a5
_ptexpr_1:
[000064f6] 4287                      clr.l      d7
[000064f8] 1e2d 0016                 move.b     22(a5),d7
[000064fc] 2e87                      move.l     d7,(a7)
[000064fe] 4eba f516                 jsr        _pcode(pc)
[00006502] 2e8d                      move.l     a5,(a7)
[00006504] 4eb9 0000 81ce            jsr        _exspace
[0000650a] 2e87                      move.l     d7,(a7)
[0000650c] 2f2d 0004                 move.l     4(a5),-(a7)
[00006510] 4eb9 0000 675e            jsr        _pttype
[00006516] 588f                      addq.l     #4,a7
[00006518] 4a2d 0016                 tst.b      22(a5)
[0000651c] 671e                      beq.s      _ptexpr_2
[0000651e] 2ead 0008                 move.l     8(a5),(a7)
[00006522] 4eba ffb6                 jsr        _ptexpr(pc)
[00006526] 4287                      clr.l      d7
[00006528] 1e2d 0016                 move.b     22(a5),d7
[0000652c] 0c47 009f                 cmpi.w     #$009F,d7
[00006530] 6640                      bne.s      _ptexpr_3
[00006532] 2ead 0010                 move.l     16(a5),(a7)
[00006536] 4eba ffa2                 jsr        _ptexpr(pc)
[0000653a] 6036                      bra.s      _ptexpr_3
_ptexpr_2:
[0000653c] 2e8d                      move.l     a5,(a7)
[0000653e] 4eb9 0000 7fda            jsr        _dlit
[00006544] 4a87                      tst.l      d7
[00006546] 6740                      beq.s      _ptexpr_4
[00006548] 4ab9 0002 0b8a            tst.l      _oldflag
[0000654e] 6700 0086                 beq        _ptexpr_5
[00006552] 4878 0008                 pea.l      ($00000008).w
[00006556] 4eba f4be                 jsr        _pcode(pc)
[0000655a] 588f                      addq.l     #4,a7
[0000655c] 4878 0008                 pea.l      ($00000008).w
[00006560] 2f2d 000c                 move.l     12(a5),-(a7)
[00006564] 5297                      addq.l     #1,(a7)
[00006566] 4eb9 0000 695c            jsr        _putbytes
[0000656c] 508f                      addq.l     #8,a7
[0000656e] 6000 0098                 bra        _ptexpr_6
_ptexpr_3:
[00006572] 4287                      clr.l      d7
[00006574] 1e2d 0016                 move.b     22(a5),d7
[00006578] 0807 0007                 btst       #7,d7
[0000657c] 6750                      beq.s      _ptexpr_7
[0000657e] 2ead 000c                 move.l     12(a5),(a7)
[00006582] 4eba ff56                 jsr        _ptexpr(pc)
[00006586] 6046                      bra.s      _ptexpr_7
_ptexpr_4:
[00006588] 4878 0001                 pea.l      ($00000001).w
[0000658c] 2f2d 000c                 move.l     12(a5),-(a7)
[00006590] 3e2d 0010                 move.w     16(a5),d7
[00006594] 48c7                      ext.l      d7
[00006596] 2f07                      move.l     d7,-(a7)
[00006598] 4eb9 0000 661a            jsr        _ptname
[0000659e] 4fef 000c                 lea.l      12(a7),a7
_ptexpr_8:
[000065a2] 4878 0004                 pea.l      ($00000004).w
[000065a6] 486d 0008                 pea.l      8(a5)
[000065aa] 4eb9 0000 695c            jsr        _putbytes
[000065b0] 508f                      addq.l     #8,a7
[000065b2] 1e2d 0014                 move.b     20(a5),d7
[000065b6] 4887                      ext.w      d7
[000065b8] 48c7                      ext.l      d7
[000065ba] 2e87                      move.l     d7,(a7)
[000065bc] 4eba f458                 jsr        _pcode(pc)
[000065c0] 1e2d 0015                 move.b     21(a5),d7
[000065c4] 4887                      ext.w      d7
[000065c6] 48c7                      ext.l      d7
[000065c8] 2e87                      move.l     d7,(a7)
[000065ca] 4eba f44a                 jsr        _pcode(pc)
_ptexpr_7:
[000065ce] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000065d2] 4e5e                      unlk       a6
[000065d4] 4e75                      rts
_ptexpr_5:
[000065d6] 4878 0009                 pea.l      ($00000009).w
[000065da] 4eba f43a                 jsr        _pcode(pc)
[000065de] 588f                      addq.l     #4,a7
[000065e0] 4297                      clr.l      (a7)
[000065e2] 4eba f432                 jsr        _pcode(pc)
[000065e6] 4297                      clr.l      (a7)
[000065e8] 4eba f42c                 jsr        _pcode(pc)
[000065ec] 4878 0002                 pea.l      ($00000002).w
[000065f0] 4eba f424                 jsr        _pcode(pc)
[000065f4] 588f                      addq.l     #4,a7
[000065f6] 4878 0008                 pea.l      ($00000008).w
[000065fa] 2f2d 000c                 move.l     12(a5),-(a7)
[000065fe] 5297                      addq.l     #1,(a7)
[00006600] 4eb9 0000 695c            jsr        _putbytes
[00006606] 508f                      addq.l     #8,a7
_ptexpr_6:
[00006608] 4297                      clr.l      (a7)
[0000660a] 2f2d 000c                 move.l     12(a5),-(a7)
[0000660e] 4eb9 0000 aa76            jsr        _free
[00006614] 588f                      addq.l     #4,a7
[00006616] 6000 ff8a                 bra.w      _ptexpr_8

_ptname:
[0000661a] 4e56 fffe                 link       a6,#-2
[0000661e] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[00006622] 2a6e 000c                 movea.l    12(a6),a5
[00006626] 3d6e 000a fffe            move.w     10(a6),-2(a6)
[0000662c] 4ab9 0002 0b8a            tst.l      _oldflag
[00006632] 6630                      bne.s      _ptname_1
[00006634] 2e0d                      move.l     a5,d7
[00006636] 670c                      beq.s      _ptname_2
[00006638] 4a15                      tst.b      (a5)
[0000663a] 6708                      beq.s      _ptname_2
[0000663c] 4287                      clr.l      d7
[0000663e] 1e15                      move.b     (a5),d7
[00006640] 5287                      addq.l     #1,d7
[00006642] 6002                      bra.s      _ptname_3
_ptname_2:
[00006644] 4287                      clr.l      d7
_ptname_3:
[00006646] 2a07                      move.l     d7,d5
[00006648] 4aae 0010                 tst.l      16(a6)
[0000664c] 6758                      beq.s      _ptname_4
[0000664e] 2e39 0002 0ba6            move.l     _nlen,d7
[00006654] be85                      cmp.l      d5,d7
[00006656] 644e                      bcc.s      _ptname_4
[00006658] 2e39 0002 0ba6            move.l     _nlen,d7
[0000665e] 5287                      addq.l     #1,d7
[00006660] 2a07                      move.l     d7,d5
[00006662] 6042                      bra.s      _ptname_4
_ptname_1:
[00006664] 3e2e fffe                 move.w     -2(a6),d7
[00006668] 48c7                      ext.l      d7
[0000666a] 2e87                      move.l     d7,(a7)
[0000666c] 4eba f1fa                 jsr        _lblname(pc)
[00006670] 2847                      movea.l    d7,a4
[00006672] 4a6e fffe                 tst.w      -2(a6)
[00006676] 6708                      beq.s      _ptname_5
[00006678] 4a15                      tst.b      (a5)
[0000667a] 6704                      beq.s      _ptname_5
[0000667c] 7e01                      moveq.l    #1,d7
[0000667e] 6002                      bra.s      _ptname_6
_ptname_5:
[00006680] 4287                      clr.l      d7
_ptname_6:
[00006682] 4286                      clr.l      d6
[00006684] 1c14                      move.b     (a4),d6
[00006686] de86                      add.l      d6,d7
[00006688] 4286                      clr.l      d6
[0000668a] 1c15                      move.b     (a5),d6
[0000668c] de86                      add.l      d6,d7
[0000668e] 2a07                      move.l     d7,d5
[00006690] 2e39 0002 0ba6            move.l     _nlen,d7
[00006696] be85                      cmp.l      d5,d7
[00006698] 6400 0084                 bcc        _ptname_7
[0000669c] 2a39 0002 0ba6            move.l     _nlen,d5
[000066a2] 6000 007a                 bra.w      _ptname_7
_ptname_4:
[000066a6] 2e85                      move.l     d5,(a7)
[000066a8] 4eba f36c                 jsr        _pcode(pc)
[000066ac] 4878 0002                 pea.l      ($00000002).w
[000066b0] 486e fffe                 pea.l      -2(a6)
[000066b4] 4eb9 0000 695c            jsr        _putbytes
[000066ba] 508f                      addq.l     #8,a7
[000066bc] 4a85                      tst.l      d5
[000066be] 6718                      beq.s      _ptname_8
[000066c0] 4287                      clr.l      d7
[000066c2] 1e15                      move.b     (a5),d7
[000066c4] 2447                      movea.l    d7,a2
[000066c6] 47ed 0001                 lea.l      1(a5),a3
[000066ca] d5cb                      adda.l     a3,a2
[000066cc] 4287                      clr.l      d7
[000066ce] 1e12                      move.b     (a2),d7
[000066d0] 2e87                      move.l     d7,(a7)
[000066d2] 4eba f342                 jsr        _pcode(pc)
[000066d6] 5385                      subq.l     #1,d5
_ptname_8:
[000066d8] 45ed 0001                 lea.l      1(a5),a2
[000066dc] 284a                      movea.l    a2,a4
_ptname_14:
[000066de] 4a85                      tst.l      d5
[000066e0] 6f74                      ble.s      _ptname_9
[000066e2] 4ab9 0002 0b6a            tst.l      _cflag
[000066e8] 6724                      beq.s      _ptname_10
[000066ea] 4287                      clr.l      d7
[000066ec] 1e14                      move.b     (a4),d7
[000066ee] 0c47 0041                 cmpi.w     #$0041,d7
[000066f2] 6514                      bcs.s      _ptname_11
[000066f4] 4287                      clr.l      d7
[000066f6] 1e14                      move.b     (a4),d7
[000066f8] 0c47 005a                 cmpi.w     #$005A,d7
[000066fc] 620a                      bhi.s      _ptname_11
[000066fe] 7e20                      moveq.l    #32,d7
[00006700] 4286                      clr.l      d6
[00006702] 1c14                      move.b     (a4),d6
[00006704] de86                      add.l      d6,d7
[00006706] 6004                      bra.s      _ptname_12
_ptname_11:
[00006708] 4287                      clr.l      d7
[0000670a] 1e14                      move.b     (a4),d7
_ptname_12:
[0000670c] 6004                      bra.s      _ptname_13
_ptname_10:
[0000670e] 4287                      clr.l      d7
[00006710] 1e14                      move.b     (a4),d7
_ptname_13:
[00006712] 2e87                      move.l     d7,(a7)
[00006714] 4eba f300                 jsr        _pcode(pc)
[00006718] 528c                      addq.l     #1,a4
[0000671a] 5385                      subq.l     #1,d5
[0000671c] 60c0                      bra.s      _ptname_14
_ptname_7:
[0000671e] 2e85                      move.l     d5,(a7)
[00006720] 4eba f2f4                 jsr        _pcode(pc)
[00006724] 4287                      clr.l      d7
[00006726] 1e14                      move.b     (a4),d7
[00006728] 2e87                      move.l     d7,(a7)
[0000672a] 486c 0001                 pea.l      1(a4)
[0000672e] 4eb9 0000 695c            jsr        _putbytes
[00006734] 588f                      addq.l     #4,a7
[00006736] 4287                      clr.l      d7
[00006738] 1e14                      move.b     (a4),d7
[0000673a] 9a87                      sub.l      d7,d5
[0000673c] 4a6e fffe                 tst.w      -2(a6)
[00006740] 6796                      beq.s      _ptname_8
[00006742] 4a15                      tst.b      (a5)
[00006744] 6792                      beq.s      _ptname_8
[00006746] 4878 005f                 pea.l      ($0000005F).w
[0000674a] 4eba f2ca                 jsr        _pcode(pc)
[0000674e] 588f                      addq.l     #4,a7
[00006750] 5385                      subq.l     #1,d5
[00006752] 6000 ff84                 bra.w      _ptname_8
_ptname_9:
[00006756] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[0000675a] 4e5e                      unlk       a6
[0000675c] 4e75                      rts

_pttype:
[0000675e] 4e56 fffa                 link       a6,#-6
[00006762] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00006766] 2a6e 0008                 movea.l    8(a6),a5
[0000676a] 426e fffe                 clr.w      -2(a6)
[0000676e] 4287                      clr.l      d7
[00006770] 1e2d 0008                 move.b     8(a5),d7
[00006774] 2e87                      move.l     d7,(a7)
[00006776] 2f3c 0002 14e6            move.l     #_typtab,-(a7)
[0000677c] 4eb9 0000 a7a6            jsr        _scnstr
[00006782] 588f                      addq.l     #4,a7
[00006784] 2447                      movea.l    d7,a2
[00006786] d5fc 0002 1550            adda.l     #_xtab,a2
[0000678c] 1a12                      move.b     (a2),d5
[0000678e] 4885                      ext.w      d5
[00006790] 48c5                      ext.l      d5
[00006792] 6728                      beq.s      _pttype_1
_pttype_6:
[00006794] 4aae 000c                 tst.l      12(a6)
[00006798] 6700 012a                 beq        _pttype_2
[0000679c] 2e05                      move.l     d5,d7
[0000679e] 08c7 0007                 bset       #7,d7
[000067a2] 2e87                      move.l     d7,(a7)
[000067a4] 4eba f270                 jsr        _pcode(pc)
[000067a8] 4878 0002                 pea.l      ($00000002).w
[000067ac] 486e 000c                 pea.l      12(a6)
[000067b0] 4eb9 0000 695c            jsr        _putbytes
[000067b6] 508f                      addq.l     #8,a7
[000067b8] 6000 0110                 bra        _pttype_3
_pttype_1:
[000067bc] 4287                      clr.l      d7
[000067be] 1e2d 0008                 move.b     8(a5),d7
[000067c2] 41f9 0002 1228            lea.l      $00021228,a0
[000067c8] 4ef9 0000 a7dc            jmp        a.switch
[000067ce] 4ab9 0002 0b9a            tst.l      _uflag
[000067d4] 6704                      beq.s      _pttype_4
[000067d6] 7e02                      moveq.l    #2,d7
[000067d8] 6002                      bra.s      _pttype_5
_pttype_4:
[000067da] 7e01                      moveq.l    #1,d7
_pttype_5:
[000067dc] 2a07                      move.l     d7,d5
[000067de] 60b4                      bra.s      _pttype_6
[000067e0] 60b2                      bra.s      _pttype_6
[000067e2] 4ab9 0002 0b7e            tst.l      _lflag
[000067e8] 6704                      beq.s      _pttype_7
[000067ea] 7e06                      moveq.l    #6,d7
[000067ec] 6002                      bra.s      _pttype_8
_pttype_7:
[000067ee] 7e03                      moveq.l    #3,d7
_pttype_8:
[000067f0] 2a07                      move.l     d7,d5
[000067f2] 60a0                      bra.s      _pttype_6
[000067f4] 4ab9 0002 0b7e            tst.l      _lflag
[000067fa] 6704                      beq.s      _pttype_9
[000067fc] 7e07                      moveq.l    #7,d7
[000067fe] 6002                      bra.s      _pttype_10
_pttype_9:
[00006800] 7e04                      moveq.l    #4,d7
_pttype_10:
[00006802] 2a07                      move.l     d7,d5
[00006804] 608e                      bra.s      _pttype_6
[00006806] 4ab9 0002 0b7e            tst.l      _lflag
[0000680c] 6704                      beq.s      _pttype_11
[0000680e] 7e08                      moveq.l    #8,d7
[00006810] 6002                      bra.s      _pttype_12
_pttype_11:
[00006812] 7e05                      moveq.l    #5,d7
_pttype_12:
[00006814] 2a07                      move.l     d7,d5
[00006816] 6000 ff7c                 bra        _pttype_6
[0000681a] 4ab9 0002 0b8a            tst.l      _oldflag
[00006820] 6616                      bne.s      _pttype_13
[00006822] 246d 0004                 movea.l    4(a5),a2
[00006826] 508a                      addq.l     #8,a2
[00006828] 4287                      clr.l      d7
[0000682a] 1e12                      move.b     (a2),d7
[0000682c] 0c47 0042                 cmpi.w     #$0042,d7
[00006830] 6606                      bne.s      _pttype_13
[00006832] 08ee 0007 fffe            bset       #7,-2(a6)
_pttype_13:
[00006838] 4287                      clr.l      d7
[0000683a] 3e2d 000a                 move.w     10(a5),d7
[0000683e] 8f6e fffe                 or.w       d7,-2(a6)
[00006842] 2ead 0004                 move.l     4(a5),(a7)
[00006846] 4eb9 0000 78b4            jsr        _bound
[0000684c] e987                      asl.l      #4,d7
[0000684e] 2e87                      move.l     d7,(a7)
[00006850] 4287                      clr.l      d7
[00006852] 3e2e fffe                 move.w     -2(a6),d7
[00006856] 0807 000b                 btst       #11,d7
[0000685a] 6704                      beq.s      _pttype_14
[0000685c] 7e0d                      moveq.l    #13,d7
[0000685e] 6002                      bra.s      _pttype_15
_pttype_14:
[00006860] 7e0b                      moveq.l    #11,d7
_pttype_15:
[00006862] 8e97                      or.l       (a7),d7
[00006864] 2a07                      move.l     d7,d5
[00006866] 6000 ff2c                 bra        _pttype_6
[0000686a] 3d6e 000e fffe            move.w     14(a6),-2(a6)
[00006870] 42ae 000c                 clr.l      12(a6)
[00006874] 4ab9 0002 0b8a            tst.l      _oldflag
[0000687a] 6606                      bne.s      _pttype_16
[0000687c] 08ee 0007 fffe            bset       #7,-2(a6)
_pttype_16:
[00006882] 4287                      clr.l      d7
[00006884] 3e2e fffe                 move.w     -2(a6),d7
[00006888] 0807 000b                 btst       #11,d7
[0000688c] 6704                      beq.s      _pttype_17
[0000688e] 7e0d                      moveq.l    #13,d7
[00006890] 6002                      bra.s      _pttype_18
_pttype_17:
[00006892] 7e0b                      moveq.l    #11,d7
_pttype_18:
[00006894] 7c70                      moveq.l    #112,d6
[00006896] 8c87                      or.l       d7,d6
[00006898] 2a06                      move.l     d6,d5
[0000689a] 4ab9 0002 0b8a            tst.l      _oldflag
[000068a0] 6700 fef2                 beq        _pttype_6
[000068a4] 7a05                      moveq.l    #5,d5
[000068a6] 6000 feec                 bra        _pttype_6
[000068aa] 7a02                      moveq.l    #2,d5
[000068ac] 6000 fee6                 bra        _pttype_6
[000068b0] 2e8d                      move.l     a5,(a7)
[000068b2] 4eb9 0000 78b4            jsr        _bound
[000068b8] e987                      asl.l      #4,d7
[000068ba] 7c0e                      moveq.l    #14,d6
[000068bc] 8c87                      or.l       d7,d6
[000068be] 2a06                      move.l     d6,d5
[000068c0] 6000 fed2                 bra        _pttype_6
_pttype_2:
[000068c4] 2e85                      move.l     d5,(a7)
[000068c6] 4eba f14e                 jsr        _pcode(pc)
_pttype_3:
[000068ca] 4ab9 0002 0b8a            tst.l      _oldflag
[000068d0] 6618                      bne.s      _pttype_19
[000068d2] 4287                      clr.l      d7
[000068d4] 1e2d 0008                 move.b     8(a5),d7
[000068d8] 0c47 0040                 cmpi.w     #$0040,d7
[000068dc] 6736                      beq.s      _pttype_20
[000068de] 4287                      clr.l      d7
[000068e0] 1e2d 0008                 move.b     8(a5),d7
[000068e4] 0c47 0042                 cmpi.w     #$0042,d7
[000068e8] 672a                      beq.s      _pttype_20
_pttype_19:
[000068ea] 4287                      clr.l      d7
[000068ec] 1e2d 0008                 move.b     8(a5),d7
[000068f0] 0c47 0019                 cmpi.w     #$0019,d7
[000068f4] 6630                      bne.s      _pttype_21
[000068f6] 1e2d 000a                 move.b     10(a5),d7
[000068fa] 4887                      ext.w      d7
[000068fc] 48c7                      ext.l      d7
[000068fe] 2e87                      move.l     d7,(a7)
[00006900] 4eba f114                 jsr        _pcode(pc)
[00006904] 1e2d 000b                 move.b     11(a5),d7
[00006908] 4887                      ext.w      d7
[0000690a] 48c7                      ext.l      d7
[0000690c] 2e87                      move.l     d7,(a7)
[0000690e] 4eba f106                 jsr        _pcode(pc)
[00006912] 6040                      bra.s      _pttype_22
_pttype_20:
[00006914] 4878 0002                 pea.l      ($00000002).w
[00006918] 486e fffe                 pea.l      -2(a6)
[0000691c] 4eb9 0000 695c            jsr        _putbytes
[00006922] 508f                      addq.l     #8,a7
[00006924] 60c4                      bra.s      _pttype_19
_pttype_21:
[00006926] 7e0f                      moveq.l    #15,d7
[00006928] ce85                      and.l      d5,d7
[0000692a] 0c87 0000 000e            cmpi.l     #$0000000E,d7
[00006930] 6622                      bne.s      _pttype_22
[00006932] 4878 0001                 pea.l      ($00000001).w
[00006936] 2f0d                      move.l     a5,-(a7)
[00006938] 4eb9 0000 7b74            jsr        _bytes
[0000693e] 508f                      addq.l     #8,a7
[00006940] 2d47 fffa                 move.l     d7,-6(a6)
[00006944] 4878 0004                 pea.l      ($00000004).w
[00006948] 486e fffa                 pea.l      -6(a6)
[0000694c] 4eb9 0000 695c            jsr        _putbytes
[00006952] 508f                      addq.l     #8,a7
_pttype_22:
[00006954] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00006958] 4e5e                      unlk       a6
[0000695a] 4e75                      rts

_putbytes:
[0000695c] 4e56 0000                 link       a6,#0
[00006960] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00006964] 2a6e 0008                 movea.l    8(a6),a5
[00006968] 2a2e 000c                 move.l     12(a6),d5
_putbytes_2:
[0000696c] 4a85                      tst.l      d5
[0000696e] 6710                      beq.s      _putbytes_1
[00006970] 4287                      clr.l      d7
[00006972] 1e1d                      move.b     (a5)+,d7
[00006974] 2e87                      move.l     d7,(a7)
[00006976] 4eb9 0000 3e98            jsr        _putchr
[0000697c] 5385                      subq.l     #1,d5
[0000697e] 60ec                      bra.s      _putbytes_2
_putbytes_1:
[00006980] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00006984] 4e5e                      unlk       a6
[00006986] 4e75                      rts

_pvoid:
[00006988] 4e56 fffc                 link       a6,#-4
[0000698c] 2ebc 0000 0096            move.l     #$00000096,(a7)
[00006992] 4eba f082                 jsr        _pcode(pc)
[00006996] 2eae 0008                 move.l     8(a6),(a7)
[0000699a] 4eb9 0000 8914            jsr        _docheck
[000069a0] 2e87                      move.l     d7,(a7)
[000069a2] 4eba fb36                 jsr        _ptexpr(pc)
[000069a6] 4eba f0fe                 jsr        _pend(pc)
[000069aa] 4e5e                      unlk       a6
[000069ac] 4e75                      rts

_rbuy:
[000069ae] 4e56 fffe                 link       a6,#-2
[000069b2] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[000069b6] 2a6e 000c                 movea.l    12(a6),a5
[000069ba] 246e 0008                 movea.l    8(a6),a2
[000069be] 508a                      addq.l     #8,a2
[000069c0] 4284                      clr.l      d4
[000069c2] 1812                      move.b     (a2),d4
[000069c4] 4a55                      tst.w      (a5)
[000069c6] 660a                      bne.s      _rbuy_1
[000069c8] 4287                      clr.l      d7
[000069ca] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[000069ce] 4e5e                      unlk       a6
[000069d0] 4e75                      rts
_rbuy_1:
[000069d2] 2e04                      move.l     d4,d7
[000069d4] 41f9 0002 1268            lea.l      $00021268,a0
[000069da] 4ef9 0000 a7dc            jmp        a.switch
_rbuy_7:
[000069e0] 4ab9 0002 0b66            tst.l      _aflag
[000069e6] 671c                      beq.s      _rbuy_2
[000069e8] 4287                      clr.l      d7
[000069ea] 3e15                      move.w     (a5),d7
[000069ec] 0287 0000 3800            andi.l     #$00003800,d7
[000069f2] 6710                      beq.s      _rbuy_2
[000069f4] 0c84 0000 0040            cmpi.l     #$00000040,d4
[000069fa] 6608                      bne.s      _rbuy_2
[000069fc] 2e3c 0000 3800            move.l     #$00003800,d7
[00006a02] 6002                      bra.s      _rbuy_3
_rbuy_2:
[00006a04] 7eff                      moveq.l    #-1,d7
_rbuy_3:
[00006a06] 3d47 fffe                 move.w     d7,-2(a6)
[00006a0a] 4287                      clr.l      d7
[00006a0c] 3e15                      move.w     (a5),d7
[00006a0e] 4286                      clr.l      d6
[00006a10] 3c2e fffe                 move.w     -2(a6),d6
[00006a14] ce86                      and.l      d6,d7
[00006a16] 2a07                      move.l     d7,d5
[00006a18] 2e05                      move.l     d5,d7
[00006a1a] 2c05                      move.l     d5,d6
[00006a1c] 5386                      subq.l     #1,d6
[00006a1e] ce86                      and.l      d6,d7
[00006a20] bf85                      eor.l      d7,d5
[00006a22] 2e05                      move.l     d5,d7
[00006a24] 4687                      not.l      d7
[00006a26] cf55                      and.w      d7,(a5)
[00006a28] 7e1c                      moveq.l    #28,d7
[00006a2a] ce85                      and.l      d5,d7
[00006a2c] 6704                      beq.s      _rbuy_4
[00006a2e] 2e05                      move.l     d5,d7
[00006a30] 600a                      bra.s      _rbuy_5
_rbuy_4:
[00006a32] 2e05                      move.l     d5,d7
[00006a34] 7c09                      moveq.l    #9,d6
[00006a36] eca7                      asr.l      d6,d7
[00006a38] 08c7 0007                 bset       #7,d7
_rbuy_5:
[00006a3c] 6024                      bra.s      _rbuy_6
[00006a3e] 4ab9 0002 0b7e            tst.l      _lflag
[00006a44] 669a                      bne.s      _rbuy_7
[00006a46] 4ab9 0002 0b82            tst.l      _lregflag
[00006a4c] 6692                      bne.s      _rbuy_7
[00006a4e] 45f8 000a                 lea.l      ($0000000A).w,a2
[00006a52] d5ee 0008                 adda.l     8(a6),a2
[00006a56] 4287                      clr.l      d7
[00006a58] 3e12                      move.w     (a2),d7
[00006a5a] 0807 000b                 btst       #11,d7
[00006a5e] 6780                      beq.s      _rbuy_7
[00006a60] 4287                      clr.l      d7
_rbuy_6:
[00006a62] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00006a66] 4e5e                      unlk       a6
[00006a68] 4e75                      rts

x6a6a_1:
x6a6a_2:
[00006a6a] 4287                      clr.l      d7
[00006a6c] 1e39 0002 0ddc            move.b     $00020DDC,d7
[00006a72] b887                      cmp.l      d7,d4
[00006a74] 6f00 ff6a                 ble        x6a6a_1
[00006a78] 4ab9 0002 0b7e            tst.l      _lflag
[00006a7e] 6600 ff60                 bne        x6a6a_1
[00006a82] 4ab9 0002 0b82            tst.l      _lregflag
[00006a88] 6600 ff56                 bne        x6a6a_1
[00006a8c] 4287                      clr.l      d7
[00006a8e] 60d2                      bra.s      x6a6a_2

_spaceinf:
[00006a90] 4e56 fffa                 link       a6,#-6
[00006a94] 48e7 8004                 movem.l    d0/a5,-(a7)
[00006a98] 2a6e 0008                 movea.l    8(a6),a5
[00006a9c] 3d6d 000c fffe            move.w     12(a5),-2(a6)
[00006aa2] 246d 0004                 movea.l    4(a5),a2
[00006aa6] 508a                      addq.l     #8,a2
[00006aa8] 4287                      clr.l      d7
[00006aaa] 1e12                      move.b     (a2),d7
[00006aac] 0c47 0042                 cmpi.w     #$0042,d7
[00006ab0] 6606                      bne.s      _spaceinf_1
[00006ab2] 08ee 0007 fffe            bset       #7,-2(a6)
_spaceinf_1:
[00006ab8] 4878 0002                 pea.l      ($00000002).w
[00006abc] 486e fffe                 pea.l      -2(a6)
[00006ac0] 4eba fe9a                 jsr        _putbytes(pc)
[00006ac4] 508f                      addq.l     #8,a7
[00006ac6] 246d 0004                 movea.l    4(a5),a2
[00006aca] 508a                      addq.l     #8,a2
[00006acc] 4287                      clr.l      d7
[00006ace] 1e12                      move.b     (a2),d7
[00006ad0] 0c47 0042                 cmpi.w     #$0042,d7
[00006ad4] 6714                      beq.s      _spaceinf_2
[00006ad6] 4297                      clr.l      (a7)
[00006ad8] 2f2d 0004                 move.l     4(a5),-(a7)
[00006adc] 4eb9 0000 7b74            jsr        _bytes
[00006ae2] 588f                      addq.l     #4,a7
[00006ae4] 2d47 fffa                 move.l     d7,-6(a6)
[00006ae8] 6040                      bra.s      _spaceinf_3
_spaceinf_2:
[00006aea] 246d 0004                 movea.l    4(a5),a2
[00006aee] 588a                      addq.l     #4,a2
[00006af0] 2452                      movea.l    (a2),a2
[00006af2] 508a                      addq.l     #8,a2
[00006af4] 4287                      clr.l      d7
[00006af6] 1e12                      move.b     (a2),d7
[00006af8] 0c47 0048                 cmpi.w     #$0048,d7
[00006afc] 6714                      beq.s      _spaceinf_4
[00006afe] 246d 0004                 movea.l    4(a5),a2
[00006b02] 588a                      addq.l     #4,a2
[00006b04] 2452                      movea.l    (a2),a2
[00006b06] 508a                      addq.l     #8,a2
[00006b08] 4287                      clr.l      d7
[00006b0a] 1e12                      move.b     (a2),d7
[00006b0c] 0c47 0049                 cmpi.w     #$0049,d7
[00006b10] 662e                      bne.s      _spaceinf_5
_spaceinf_4:
[00006b12] 4878 0001                 pea.l      ($00000001).w
[00006b16] 246d 0004                 movea.l    4(a5),a2
[00006b1a] 588a                      addq.l     #4,a2
[00006b1c] 2f12                      move.l     (a2),-(a7)
[00006b1e] 4eb9 0000 7b74            jsr        _bytes
[00006b24] 508f                      addq.l     #8,a7
[00006b26] 2d47 fffa                 move.l     d7,-6(a6)
_spaceinf_3:
[00006b2a] 4878 0004                 pea.l      ($00000004).w
[00006b2e] 486e fffa                 pea.l      -6(a6)
[00006b32] 4eba fe28                 jsr        _putbytes(pc)
[00006b36] 508f                      addq.l     #8,a7
[00006b38] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00006b3c] 4e5e                      unlk       a6
[00006b3e] 4e75                      rts
_spaceinf_5:
[00006b40] 42ae fffa                 clr.l      -6(a6)
[00006b44] 60e4                      bra.s      _spaceinf_3

_cachk:
[00006b46] 4e56 0000                 link       a6,#0
[00006b4a] 48e7 8004                 movem.l    d0/a5,-(a7)
[00006b4e] 2a6e 0008                 movea.l    8(a6),a5
[00006b52] 4a2d 0016                 tst.b      22(a5)
[00006b56] 6656                      bne.s      _cachk_1
[00006b58] 4a2d 0015                 tst.b      21(a5)
[00006b5c] 6650                      bne.s      _cachk_1
[00006b5e] 2ead 0004                 move.l     4(a5),(a7)
[00006b62] 4eb9 0000 8062            jsr        _dtype
[00006b68] 4a87                      tst.l      d7
[00006b6a] 6642                      bne.s      _cachk_1
[00006b6c] 4a2d 0014                 tst.b      20(a5)
[00006b70] 6738                      beq.s      _cachk_2
[00006b72] 246d 0004                 movea.l    4(a5),a2
[00006b76] 508a                      addq.l     #8,a2
[00006b78] 4287                      clr.l      d7
[00006b7a] 1e12                      move.b     (a2),d7
[00006b7c] 0c47 0040                 cmpi.w     #$0040,d7
[00006b80] 662c                      bne.s      _cachk_1
[00006b82] 4878 0001                 pea.l      ($00000001).w
[00006b86] 2f3c 0002 0dd4            move.l     #_atunsign,-(a7)
[00006b8c] 4eb9 0000 7b74            jsr        _bytes
[00006b92] 508f                      addq.l     #8,a7
[00006b94] 2e87                      move.l     d7,(a7)
[00006b96] 4878 0001                 pea.l      ($00000001).w
[00006b9a] 2f2d 0004                 move.l     4(a5),-(a7)
[00006b9e] 4eb9 0000 7b74            jsr        _bytes
[00006ba4] 508f                      addq.l     #8,a7
[00006ba6] be97                      cmp.l      (a7),d7
[00006ba8] 6604                      bne.s      _cachk_1
_cachk_2:
[00006baa] 7e01                      moveq.l    #1,d7
[00006bac] 6002                      bra.s      _cachk_3
_cachk_1:
[00006bae] 4287                      clr.l      d7
_cachk_3:
[00006bb0] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00006bb4] 4e5e                      unlk       a6
[00006bb6] 4e75                      rts

_canadd:
[00006bb8] 4e56 0000                 link       a6,#0
[00006bbc] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00006bc0] 2a6e 0008                 movea.l    8(a6),a5
[00006bc4] 286e 000c                 movea.l    12(a6),a4
[00006bc8] 2e8d                      move.l     a5,(a7)
[00006bca] 4eba ff7a                 jsr        _cachk(pc)
[00006bce] 4a87                      tst.l      d7
[00006bd0] 6722                      beq.s      _canadd_1
[00006bd2] 2e8c                      move.l     a4,(a7)
[00006bd4] 4eba ff70                 jsr        _cachk(pc)
[00006bd8] 4a87                      tst.l      d7
[00006bda] 6718                      beq.s      _canadd_1
[00006bdc] 2e8d                      move.l     a5,(a7)
[00006bde] 4eb9 0000 6e7a            jsr        _hasname
[00006be4] 4a87                      tst.l      d7
[00006be6] 6716                      beq.s      _canadd_2
[00006be8] 2e8c                      move.l     a4,(a7)
[00006bea] 4eb9 0000 6e7a            jsr        _hasname
[00006bf0] 4a87                      tst.l      d7
[00006bf2] 670a                      beq.s      _canadd_2
_canadd_1:
[00006bf4] 4287                      clr.l      d7
[00006bf6] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00006bfa] 4e5e                      unlk       a6
[00006bfc] 4e75                      rts
_canadd_2:
[00006bfe] 4a2d 0014                 tst.b      20(a5)
[00006c02] 6706                      beq.s      _canadd_3
[00006c04] 4a2c 0014                 tst.b      20(a4)
[00006c08] 66ea                      bne.s      _canadd_1
_canadd_3:
[00006c0a] 2e8d                      move.l     a5,(a7)
[00006c0c] 4eb9 0000 6e7a            jsr        _hasname
[00006c12] 4a87                      tst.l      d7
[00006c14] 660c                      bne.s      _canadd_4
[00006c16] 3b6c 0010 0010            move.w     16(a4),16(a5)
[00006c1c] 2b6c 000c 000c            move.l     12(a4),12(a5)
_canadd_4:
[00006c22] 2e2c 0008                 move.l     8(a4),d7
[00006c26] dfad 0008                 add.l      d7,8(a5)
[00006c2a] 1e2c 0014                 move.b     20(a4),d7
[00006c2e] 4887                      ext.w      d7
[00006c30] 48c7                      ext.l      d7
[00006c32] df2d 0014                 add.b      d7,20(a5)
[00006c36] 246d 0004                 movea.l    4(a5),a2
[00006c3a] 508a                      addq.l     #8,a2
[00006c3c] 4287                      clr.l      d7
[00006c3e] 1e12                      move.b     (a2),d7
[00006c40] 0c47 0040                 cmpi.w     #$0040,d7
[00006c44] 6732                      beq.s      _canadd_5
[00006c46] 246c 0004                 movea.l    4(a4),a2
[00006c4a] 508a                      addq.l     #8,a2
[00006c4c] 4287                      clr.l      d7
[00006c4e] 1e12                      move.b     (a2),d7
[00006c50] 0c47 0040                 cmpi.w     #$0040,d7
[00006c54] 6608                      bne.s      _canadd_6
[00006c56] 2b6c 0004 0004            move.l     4(a4),4(a5)
[00006c5c] 601a                      bra.s      _canadd_5
_canadd_6:
[00006c5e] 4878 0021                 pea.l      ($00000021).w
[00006c62] 2f2c 0004                 move.l     4(a4),-(a7)
[00006c66] 2f2d 0004                 move.l     4(a5),-(a7)
[00006c6a] 4eb9 0000 8b74            jsr        _maxty
[00006c70] 4fef 000c                 lea.l      12(a7),a7
[00006c74] 2b47 0004                 move.l     d7,4(a5)
_canadd_5:
[00006c78] 7e01                      moveq.l    #1,d7
[00006c7a] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00006c7e] 4e5e                      unlk       a6
[00006c80] 4e75                      rts

_canmul:
[00006c82] 4e56 0000                 link       a6,#0
[00006c86] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00006c8a] 2a6e 0008                 movea.l    8(a6),a5
[00006c8e] 286e 000c                 movea.l    12(a6),a4
[00006c92] 2e8d                      move.l     a5,(a7)
[00006c94] 4eb9 0000 83b6            jsr        _iscons
[00006c9a] 4a87                      tst.l      d7
[00006c9c] 673c                      beq.s      _canmul_1
[00006c9e] 2e8c                      move.l     a4,(a7)
[00006ca0] 4eb9 0000 83b6            jsr        _iscons
[00006ca6] 4a87                      tst.l      d7
[00006ca8] 6730                      beq.s      _canmul_1
[00006caa] 2ead 0008                 move.l     8(a5),(a7)
[00006cae] 2f2c 0008                 move.l     8(a4),-(a7)
[00006cb2] 4eb9 0000 ade4            jsr        a.lmul
[00006cb8] 2b57 0008                 move.l     (a7),8(a5)
[00006cbc] 4878 0021                 pea.l      ($00000021).w
[00006cc0] 2f2c 0004                 move.l     4(a4),-(a7)
[00006cc4] 2f2d 0004                 move.l     4(a5),-(a7)
[00006cc8] 4eb9 0000 8b74            jsr        _maxty
[00006cce] 4fef 000c                 lea.l      12(a7),a7
[00006cd2] 2b47 0004                 move.l     d7,4(a5)
[00006cd6] 7e01                      moveq.l    #1,d7
[00006cd8] 6002                      bra.s      _canmul_2
_canmul_1:
[00006cda] 4287                      clr.l      d7
_canmul_2:
[00006cdc] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00006ce0] 4e5e                      unlk       a6
[00006ce2] 4e75                      rts

_cansub:
[00006ce4] 4e56 0000                 link       a6,#0
[00006ce8] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00006cec] 2a6e 0008                 movea.l    8(a6),a5
[00006cf0] 286e 000c                 movea.l    12(a6),a4
[00006cf4] 2e8d                      move.l     a5,(a7)
[00006cf6] 4eba fe4e                 jsr        _cachk(pc)
[00006cfa] 4a87                      tst.l      d7
[00006cfc] 6746                      beq.s      _cansub_1
[00006cfe] 2e8c                      move.l     a4,(a7)
[00006d00] 4eba fe44                 jsr        _cachk(pc)
[00006d04] 4a87                      tst.l      d7
[00006d06] 673c                      beq.s      _cansub_1
[00006d08] 2e8c                      move.l     a4,(a7)
[00006d0a] 4eb9 0000 6e7a            jsr        _hasname
[00006d10] 4a87                      tst.l      d7
[00006d12] 6734                      beq.s      _cansub_2
[00006d14] 246d 000c                 movea.l    12(a5),a2
[00006d18] 4287                      clr.l      d7
[00006d1a] 1e12                      move.b     (a2),d7
[00006d1c] 2e87                      move.l     d7,(a7)
[00006d1e] 5297                      addq.l     #1,(a7)
[00006d20] 2f2c 000c                 move.l     12(a4),-(a7)
[00006d24] 2f2d 000c                 move.l     12(a5),-(a7)
[00006d28] 4eb9 0000 ad76            jsr        _cmpbuf
[00006d2e] 508f                      addq.l     #8,a7
[00006d30] 4a87                      tst.l      d7
[00006d32] 6710                      beq.s      _cansub_1
[00006d34] 3e2d 0010                 move.w     16(a5),d7
[00006d38] 48c7                      ext.l      d7
[00006d3a] 3c2c 0010                 move.w     16(a4),d6
[00006d3e] 48c6                      ext.l      d6
[00006d40] be86                      cmp.l      d6,d7
[00006d42] 6704                      beq.s      _cansub_2
_cansub_1:
[00006d44] 4287                      clr.l      d7
[00006d46] 6046                      bra.s      _cansub_3
_cansub_2:
[00006d48] 4a2c 0014                 tst.b      20(a4)
[00006d4c] 6714                      beq.s      _cansub_4
[00006d4e] 1e2d 0014                 move.b     20(a5),d7
[00006d52] 4887                      ext.w      d7
[00006d54] 48c7                      ext.l      d7
[00006d56] 1c2c 0014                 move.b     20(a4),d6
[00006d5a] 4886                      ext.w      d6
[00006d5c] 48c6                      ext.l      d6
[00006d5e] be86                      cmp.l      d6,d7
[00006d60] 66e2                      bne.s      _cansub_1
_cansub_4:
[00006d62] 2e8c                      move.l     a4,(a7)
[00006d64] 4eb9 0000 6e7a            jsr        _hasname
[00006d6a] 4a87                      tst.l      d7
[00006d6c] 670c                      beq.s      _cansub_5
[00006d6e] 426d 0010                 clr.w      16(a5)
[00006d72] 2b7c 0002 077c 000c       move.l     #_noname,12(a5)
_cansub_5:
[00006d7a] 4a2c 0014                 tst.b      20(a4)
[00006d7e] 6704                      beq.s      _cansub_6
[00006d80] 422d 0014                 clr.b      20(a5)
_cansub_6:
[00006d84] 2e2c 0008                 move.l     8(a4),d7
[00006d88] 9fad 0008                 sub.l      d7,8(a5)
[00006d8c] 7e01                      moveq.l    #1,d7
_cansub_3:
[00006d8e] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00006d92] 4e5e                      unlk       a6
[00006d94] 4e75                      rts

_cpyterm:
[00006d96] 4e56 0000                 link       a6,#0
[00006d9a] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00006d9e] 2a6e 0008                 movea.l    8(a6),a5
[00006da2] 286e 000c                 movea.l    12(a6),a4
[00006da6] 4878 000e                 pea.l      ($0000000E).w
[00006daa] 486c 0008                 pea.l      8(a4)
[00006dae] 486d 0008                 pea.l      8(a5)
[00006db2] 4eb9 0000 adac            jsr        _cpybuf
[00006db8] 4fef 000c                 lea.l      12(a7),a7
[00006dbc] 1b6c 0016 0016            move.b     22(a4),22(a5)
[00006dc2] 2b6c 0004 0004            move.l     4(a4),4(a5)
[00006dc8] 2e0d                      move.l     a5,d7
[00006dca] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00006dce] 4e5e                      unlk       a6
[00006dd0] 4e75                      rts

_docast:
[00006dd2] 4e56 fff8                 link       a6,#-8
[00006dd6] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00006dda] 2a6e 0008                 movea.l    8(a6),a5
[00006dde] 286e 000c                 movea.l    12(a6),a4
[00006de2] 2e0c                      move.l     a4,d7
[00006de4] 6604                      bne.s      _docast_1
[00006de6] 4287                      clr.l      d7
[00006de8] 6040                      bra.s      _docast_2
_docast_1:
[00006dea] 4287                      clr.l      d7
[00006dec] 1e2c 0008                 move.b     8(a4),d7
[00006df0] 0c47 0009                 cmpi.w     #$0009,d7
[00006df4] 6708                      beq.s      _docast_3
[00006df6] 4287                      clr.l      d7
[00006df8] 1e2c 0008                 move.b     8(a4),d7
[00006dfc] 600e                      bra.s      _docast_4
_docast_3:
[00006dfe] 4ab9 0002 0b9a            tst.l      _uflag
[00006e04] 6704                      beq.s      _docast_5
[00006e06] 7e0a                      moveq.l    #10,d7
[00006e08] 6002                      bra.s      _docast_4
_docast_5:
[00006e0a] 7e08                      moveq.l    #8,d7
_docast_4:
[00006e0c] 41f9 0002 131e            lea.l      $0002131E,a0
[00006e12] 4ef9 0000 a7dc            jmp        a.switch
[00006e18] 1d6d 0003 fffd            move.b     3(a5),-3(a6)
[00006e1e] 1e2e fffd                 move.b     -3(a6),d7
[00006e22] 4887                      ext.w      d7
[00006e24] 48c7                      ext.l      d7
[00006e26] 2a87                      move.l     d7,(a5)
[00006e28] 7e01                      moveq.l    #1,d7
_docast_2:
[00006e2a] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00006e2e] 4e5e                      unlk       a6
[00006e30] 4e75                      rts

x6e32_1:
x6e32_2:
[00006e32] 1d6d 0003 fff9            move.b     3(a5),-7(a6)
[00006e38] 4287                      clr.l      d7
[00006e3a] 1e2e fff9                 move.b     -7(a6),d7
[00006e3e] 2a87                      move.l     d7,(a5)
[00006e40] 60e6                      bra.s      x6e32_1
[00006e42] 4ab9 0002 0b7e            tst.l      _lflag
[00006e48] 66de                      bne.s      x6e32_1
[00006e4a] 3d6d 0002 fffe            move.w     2(a5),-2(a6)
[00006e50] 3e2e fffe                 move.w     -2(a6),d7
[00006e54] 48c7                      ext.l      d7
[00006e56] 2a87                      move.l     d7,(a5)
[00006e58] 60ce                      bra.s      x6e32_1
[00006e5a] 4ab9 0002 0b7e            tst.l      _lflag
[00006e60] 66c6                      bne.s      x6e32_1
[00006e62] 3d6d 0002 fffa            move.w     2(a5),-6(a6)
[00006e68] 4287                      clr.l      d7
[00006e6a] 3e2e fffa                 move.w     -6(a6),d7
[00006e6e] 2a87                      move.l     d7,(a5)
[00006e70] 60b6                      bra.s      x6e32_1
[00006e72] 60b4                      bra.s      x6e32_1
[00006e74] 60b2                      bra.s      x6e32_1
[00006e76] 4287                      clr.l      d7
[00006e78] 60b0                      bra.s      x6e32_2

_hasname:
[00006e7a] 4e56 0000                 link       a6,#0
[00006e7e] 48e7 8004                 movem.l    d0/a5,-(a7)
[00006e82] 2a6e 0008                 movea.l    8(a6),a5
[00006e86] 246d 000c                 movea.l    12(a5),a2
[00006e8a] 4a12                      tst.b      (a2)
[00006e8c] 6606                      bne.s      _hasname_1
[00006e8e] 4a6d 0010                 tst.w      16(a5)
[00006e92] 6704                      beq.s      _hasname_2
_hasname_1:
[00006e94] 7e01                      moveq.l    #1,d7
[00006e96] 6002                      bra.s      _hasname_3
_hasname_2:
[00006e98] 4287                      clr.l      d7
_hasname_3:
[00006e9a] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00006e9e] 4e5e                      unlk       a6
[00006ea0] 4e75                      rts

_hasside:
[00006ea2] 4e56 0000                 link       a6,#0
[00006ea6] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00006eaa] 2a6e 0008                 movea.l    8(a6),a5
[00006eae] 4a2d 0016                 tst.b      22(a5)
[00006eb2] 6610                      bne.s      _hasside_1
[00006eb4] 4287                      clr.l      d7
[00006eb6] 3e2d 0012                 move.w     18(a5),d7
[00006eba] 0807 000e                 btst       #14,d7
[00006ebe] 6704                      beq.s      _hasside_1
[00006ec0] 7e01                      moveq.l    #1,d7
[00006ec2] 602e                      bra.s      _hasside_2
_hasside_1:
[00006ec4] 4287                      clr.l      d7
[00006ec6] 1e2d 0016                 move.b     22(a5),d7
[00006eca] 41f9 0002 1366            lea.l      $00021366,a0
[00006ed0] 4ef9 0000 a7dc            jmp        a.switch
[00006ed6] 2e8d                      move.l     a5,(a7)
[00006ed8] 4eb9 0000 81ce            jsr        _exspace
[00006ede] 0807 000d                 btst       #13,d7
[00006ee2] 670c                      beq.s      _hasside_3
[00006ee4] 2ead 0008                 move.l     8(a5),(a7)
[00006ee8] 4eba ffb8                 jsr        _hasside(pc)
[00006eec] 4a87                      tst.l      d7
[00006eee] 670a                      beq.s      _hasside_4
_hasside_3:
[00006ef0] 7e01                      moveq.l    #1,d7
_hasside_2:
[00006ef2] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00006ef6] 4e5e                      unlk       a6
[00006ef8] 4e75                      rts
_hasside_4:
[00006efa] 286d 000c                 movea.l    12(a5),a4
_hasside_9:
[00006efe] 2e0c                      move.l     a4,d7
[00006f00] 6722                      beq.s      _hasside_5
[00006f02] 4287                      clr.l      d7
[00006f04] 1e2c 0016                 move.b     22(a4),d7
[00006f08] 0c47 00a5                 cmpi.w     #$00A5,d7
[00006f0c] 6606                      bne.s      _hasside_6
[00006f0e] 2e2c 000c                 move.l     12(a4),d7
[00006f12] 6002                      bra.s      _hasside_7
_hasside_6:
[00006f14] 2e0c                      move.l     a4,d7
_hasside_7:
[00006f16] 2e87                      move.l     d7,(a7)
[00006f18] 4eba ff88                 jsr        _hasside(pc)
[00006f1c] 4a87                      tst.l      d7
[00006f1e] 670e                      beq.s      _hasside_8
[00006f20] 7e01                      moveq.l    #1,d7
[00006f22] 60ce                      bra.s      _hasside_2
_hasside_5:
[00006f24] 4287                      clr.l      d7
[00006f26] 60ca                      bra.s      _hasside_2
_hasside_10:
[00006f28] 286c 000c                 movea.l    12(a4),a4
[00006f2c] 60d0                      bra.s      _hasside_9
_hasside_8:
[00006f2e] 4287                      clr.l      d7
[00006f30] 1e2c 0016                 move.b     22(a4),d7
[00006f34] 0c47 00a5                 cmpi.w     #$00A5,d7
[00006f38] 67ee                      beq.s      _hasside_10
[00006f3a] 60e8                      bra.s      _hasside_5
[00006f3c] 7e01                      moveq.l    #1,d7
[00006f3e] 600e                      bra.s      _hasside_11
[00006f40] 2ead 0010                 move.l     16(a5),(a7)
[00006f44] 4eba ff5c                 jsr        _hasside(pc)
[00006f48] 4a87                      tst.l      d7
[00006f4a] 670a                      beq.s      _hasside_12
[00006f4c] 7e01                      moveq.l    #1,d7
_hasside_11:
[00006f4e] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00006f52] 4e5e                      unlk       a6
[00006f54] 4e75                      rts
_hasside_12:
[00006f56] 4287                      clr.l      d7
[00006f58] 1e2d 0016                 move.b     22(a5),d7
[00006f5c] 0807 0007                 btst       #7,d7
[00006f60] 670c                      beq.s      _hasside_13
[00006f62] 2ead 000c                 move.l     12(a5),(a7)
[00006f66] 4eba ff3a                 jsr        _hasside(pc)
[00006f6a] 4a87                      tst.l      d7
[00006f6c] 661a                      bne.s      _hasside_14
_hasside_13:
[00006f6e] 4287                      clr.l      d7
[00006f70] 1e2d 0016                 move.b     22(a5),d7
[00006f74] 0287 0000 00c0            andi.l     #$000000C0,d7
[00006f7a] 6710                      beq.s      _hasside_15
[00006f7c] 2ead 0008                 move.l     8(a5),(a7)
[00006f80] 4eba ff20                 jsr        _hasside(pc)
[00006f84] 4a87                      tst.l      d7
[00006f86] 6704                      beq.s      _hasside_15
_hasside_14:
[00006f88] 7e01                      moveq.l    #1,d7
[00006f8a] 60c2                      bra.s      _hasside_11
_hasside_15:
[00006f8c] 4287                      clr.l      d7
[00006f8e] 60be                      bra.s      _hasside_11
[00006f90] 60bc                      bra.s      _hasside_11

_reduce:
[00006f92] 4e56 fffe                 link       a6,#-2
[00006f96] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00006f9a] 2a6e 0008                 movea.l    8(a6),a5
[00006f9e] 2e0d                      move.l     a5,d7
[00006fa0] 660a                      bne.s      _reduce_1
[00006fa2] 4287                      clr.l      d7
[00006fa4] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00006fa8] 4e5e                      unlk       a6
[00006faa] 4e75                      rts
_reduce_1:
[00006fac] 286d 0008                 movea.l    8(a5),a4
[00006fb0] 266d 000c                 movea.l    12(a5),a3
[00006fb4] 4a2d 0016                 tst.b      22(a5)
[00006fb8] 6604                      bne.s      _reduce_2
[00006fba] 4287                      clr.l      d7
[00006fbc] 6024                      bra.s      _reduce_3
_reduce_2:
[00006fbe] 4287                      clr.l      d7
[00006fc0] 1e2d 0016                 move.b     22(a5),d7
[00006fc4] 2e87                      move.l     d7,(a7)
[00006fc6] 2f3c 0002 1762            move.l     #_tyops,-(a7)
[00006fcc] 4eb9 0000 a7a6            jsr        _scnstr
[00006fd2] 588f                      addq.l     #4,a7
[00006fd4] e387                      asl.l      #1,d7
[00006fd6] 2447                      movea.l    d7,a2
[00006fd8] d5fc 0002 12c0            adda.l     #$000212C0,a2
[00006fde] 4287                      clr.l      d7
[00006fe0] 3e12                      move.w     (a2),d7
_reduce_3:
[00006fe2] 3d47 fffe                 move.w     d7,-2(a6)
[00006fe6] 3e2e fffe                 move.w     -2(a6),d7
[00006fea] 48c7                      ext.l      d7
[00006fec] 0807 0007                 btst       #7,d7
[00006ff0] 6706                      beq.s      _reduce_4
[00006ff2] 2e8b                      move.l     a3,(a7)
[00006ff4] 4eba ff9c                 jsr        _reduce(pc)
_reduce_4:
[00006ff8] 3e2e fffe                 move.w     -2(a6),d7
[00006ffc] 48c7                      ext.l      d7
[00006ffe] 0807 0006                 btst       #6,d7
[00007002] 6706                      beq.s      _reduce_5
[00007004] 2e8c                      move.l     a4,(a7)
[00007006] 4eba ff8a                 jsr        _reduce(pc)
_reduce_5:
[0000700a] 3e2e fffe                 move.w     -2(a6),d7
[0000700e] 48c7                      ext.l      d7
[00007010] 0807 0005                 btst       #5,d7
[00007014] 6718                      beq.s      _reduce_6
[00007016] 4a2c 0016                 tst.b      22(a4)
[0000701a] 6612                      bne.s      _reduce_6
[0000701c] 4a2b 0016                 tst.b      22(a3)
[00007020] 6636                      bne.s      _reduce_7
[00007022] 2e8c                      move.l     a4,(a7)
[00007024] 4eb9 0000 83b6            jsr        _iscons
[0000702a] 4a87                      tst.l      d7
[0000702c] 662a                      bne.s      _reduce_7
_reduce_6:
[0000702e] 3e2e fffe                 move.w     -2(a6),d7
[00007032] 48c7                      ext.l      d7
[00007034] 0807 0004                 btst       #4,d7
[00007038] 673a                      beq.s      _reduce_8
[0000703a] 2e8b                      move.l     a3,(a7)
[0000703c] 4eb9 0000 83b6            jsr        _iscons
[00007042] 4a87                      tst.l      d7
[00007044] 672e                      beq.s      _reduce_8
[00007046] 4aab 0008                 tst.l      8(a3)
[0000704a] 6628                      bne.s      _reduce_8
[0000704c] 2e8c                      move.l     a4,(a7)
[0000704e] 2f0d                      move.l     a5,-(a7)
[00007050] 4eba fd44                 jsr        _cpyterm(pc)
[00007054] 588f                      addq.l     #4,a7
[00007056] 6044                      bra.s      _reduce_9
_reduce_7:
[00007058] 2e8b                      move.l     a3,(a7)
[0000705a] 4eb9 0000 83b6            jsr        _iscons
[00007060] 4a87                      tst.l      d7
[00007062] 66ca                      bne.s      _reduce_6
[00007064] 2b4b 0008                 move.l     a3,8(a5)
[00007068] 2b4c 000c                 move.l     a4,12(a5)
[0000706c] 284b                      movea.l    a3,a4
[0000706e] 266d 000c                 movea.l    12(a5),a3
[00007072] 60ba                      bra.s      _reduce_6
_reduce_8:
[00007074] 3e2e fffe                 move.w     -2(a6),d7
[00007078] 48c7                      ext.l      d7
[0000707a] 0807 0003                 btst       #3,d7
[0000707e] 6724                      beq.s      _reduce_10
[00007080] 2e8b                      move.l     a3,(a7)
[00007082] 4eb9 0000 83b6            jsr        _iscons
[00007088] 4a87                      tst.l      d7
[0000708a] 6718                      beq.s      _reduce_10
[0000708c] 4aab 0008                 tst.l      8(a3)
[00007090] 6612                      bne.s      _reduce_10
[00007092] 2e8b                      move.l     a3,(a7)
[00007094] 2f0d                      move.l     a5,-(a7)
[00007096] 4eba fcfe                 jsr        _cpyterm(pc)
[0000709a] 588f                      addq.l     #4,a7
_reduce_9:
[0000709c] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000070a0] 4e5e                      unlk       a6
[000070a2] 4e75                      rts
_reduce_10:
[000070a4] 3e2e fffe                 move.w     -2(a6),d7
[000070a8] 48c7                      ext.l      d7
[000070aa] 0807 0002                 btst       #2,d7
[000070ae] 6722                      beq.s      _reduce_11
[000070b0] 2e8b                      move.l     a3,(a7)
[000070b2] 4eb9 0000 83b6            jsr        _iscons
[000070b8] 4a87                      tst.l      d7
[000070ba] 6716                      beq.s      _reduce_11
[000070bc] 0cab 0000 0001 0008       cmpi.l     #$00000001,8(a3)
[000070c4] 660c                      bne.s      _reduce_11
[000070c6] 2e8c                      move.l     a4,(a7)
[000070c8] 2f0d                      move.l     a5,-(a7)
[000070ca] 4eba fcca                 jsr        _cpyterm(pc)
[000070ce] 588f                      addq.l     #4,a7
[000070d0] 60ca                      bra.s      _reduce_9
_reduce_11:
[000070d2] 3e2e fffe                 move.w     -2(a6),d7
[000070d6] 48c7                      ext.l      d7
[000070d8] 0807 0001                 btst       #1,d7
[000070dc] 6710                      beq.s      _reduce_12
[000070de] 2e8b                      move.l     a3,(a7)
[000070e0] 4eb9 0000 83b6            jsr        _iscons
[000070e6] 4a87                      tst.l      d7
[000070e8] 6604                      bne.s      _reduce_12
[000070ea] 2e0d                      move.l     a5,d7
[000070ec] 60ae                      bra.s      _reduce_9
_reduce_12:
[000070ee] 3e2e fffe                 move.w     -2(a6),d7
[000070f2] 48c7                      ext.l      d7
[000070f4] 0807 0000                 btst       #0,d7
[000070f8] 6710                      beq.s      _reduce_13
[000070fa] 2e8c                      move.l     a4,(a7)
[000070fc] 4eb9 0000 83b6            jsr        _iscons
[00007102] 4a87                      tst.l      d7
[00007104] 6604                      bne.s      _reduce_13
[00007106] 2e0d                      move.l     a5,d7
[00007108] 6030                      bra.s      _reduce_14
_reduce_13:
[0000710a] 4287                      clr.l      d7
[0000710c] 1e2d 0016                 move.b     22(a5),d7
[00007110] 41f9 0002 13d6            lea.l      $000213D6,a0
[00007116] 4ef9 0000 a7dc            jmp        a.switch
[0000711c] 4a2c 0016                 tst.b      22(a4)
[00007120] 660a                      bne.s      _reduce_15
[00007122] 532c 0015                 subq.b     #1,21(a4)
[00007126] 426c 0012                 clr.w      18(a4)
[0000712a] 6050                      bra.s      _reduce_16
_reduce_15:
[0000712c] 4287                      clr.l      d7
[0000712e] 1e2c 0016                 move.b     22(a4),d7
[00007132] 0c47 006b                 cmpi.w     #$006B,d7
[00007136] 670a                      beq.s      _reduce_17
[00007138] 2e0d                      move.l     a5,d7
_reduce_14:
[0000713a] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000713e] 4e5e                      unlk       a6
[00007140] 4e75                      rts
_reduce_17:
[00007142] 4297                      clr.l      (a7)
[00007144] 246c 0008                 movea.l    8(a4),a2
[00007148] 588a                      addq.l     #4,a2
[0000714a] 2f12                      move.l     (a2),-(a7)
[0000714c] 2f2d 0004                 move.l     4(a5),-(a7)
[00007150] 4eb9 0000 7d40            jsr        _cmptype
[00007156] 508f                      addq.l     #8,a7
[00007158] 4a87                      tst.l      d7
[0000715a] 6610                      bne.s      _reduce_18
[0000715c] 1b7c 0066 0016            move.b     #$66,22(a5)
[00007162] 2b6c 0008 0008            move.l     8(a4),8(a5)
[00007168] 2e0d                      move.l     a5,d7
[0000716a] 60ce                      bra.s      _reduce_14
_reduce_18:
[0000716c] 2eac 0008                 move.l     8(a4),(a7)
[00007170] 2f0d                      move.l     a5,-(a7)
[00007172] 4eba fc22                 jsr        _cpyterm(pc)
[00007176] 588f                      addq.l     #4,a7
[00007178] 2e0d                      move.l     a5,d7
[0000717a] 60be                      bra.s      _reduce_14
_reduce_16:
[0000717c] 1e2c 0014                 move.b     20(a4),d7
[00007180] 4887                      ext.w      d7
[00007182] 48c7                      ext.l      d7
[00007184] 2e87                      move.l     d7,(a7)
[00007186] 2f2c 0008                 move.l     8(a4),-(a7)
[0000718a] 2f2c 000c                 move.l     12(a4),-(a7)
[0000718e] 3e2c 0010                 move.w     16(a4),d7
[00007192] 48c7                      ext.l      d7
[00007194] 2f07                      move.l     d7,-(a7)
[00007196] 2f0d                      move.l     a5,-(a7)
[00007198] 4eb9 0000 85aa            jsr        _setad
[0000719e] 4fef 0010                 lea.l      16(a7),a7
[000071a2] 1b6c 0015 0015            move.b     21(a4),21(a5)
[000071a8] 3b6c 0012 0012            move.w     18(a4),18(a5)
[000071ae] 2e0d                      move.l     a5,d7
[000071b0] 6020                      bra.s      _reduce_19
[000071b2] 4297                      clr.l      (a7)
[000071b4] 2f2c 0004                 move.l     4(a4),-(a7)
[000071b8] 2f2d 0004                 move.l     4(a5),-(a7)
[000071bc] 4eb9 0000 7d40            jsr        _cmptype
[000071c2] 508f                      addq.l     #8,a7
[000071c4] 4a87                      tst.l      d7
[000071c6] 6712                      beq.s      _reduce_20
[000071c8] 2e8c                      move.l     a4,(a7)
[000071ca] 2f0d                      move.l     a5,-(a7)
[000071cc] 4eba fbc8                 jsr        _cpyterm(pc)
[000071d0] 588f                      addq.l     #4,a7
_reduce_19:
[000071d2] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000071d6] 4e5e                      unlk       a6
[000071d8] 4e75                      rts
_reduce_20:
[000071da] 2e8c                      move.l     a4,(a7)
[000071dc] 4eb9 0000 83b6            jsr        _iscons
[000071e2] 4a87                      tst.l      d7
[000071e4] 6712                      beq.s      _reduce_21
[000071e6] 2ead 0004                 move.l     4(a5),(a7)
[000071ea] 486c 0008                 pea.l      8(a4)
[000071ee] 4eba fbe2                 jsr        _docast(pc)
[000071f2] 588f                      addq.l     #4,a7
[000071f4] 4a87                      tst.l      d7
[000071f6] 6684                      bne.s      _reduce_16
_reduce_21:
[000071f8] 2e0d                      move.l     a5,d7
[000071fa] 60d6                      bra.s      _reduce_19
[000071fc] 45f8 000a                 lea.l      ($0000000A).w,a2
[00007200] d5ec 0004                 adda.l     4(a4),a2
[00007204] 4287                      clr.l      d7
[00007206] 3e12                      move.w     (a2),d7
[00007208] 0287 0000 0fff            andi.l     #$00000FFF,d7
[0000720e] 6704                      beq.s      _reduce_22
[00007210] 2e0d                      move.l     a5,d7
[00007212] 60be                      bra.s      _reduce_19
_reduce_22:
[00007214] 4a2c 0016                 tst.b      22(a4)
[00007218] 660e                      bne.s      _reduce_23
[0000721a] 4a2c 0015                 tst.b      21(a4)
[0000721e] 6608                      bne.s      _reduce_23
[00007220] 522c 0015                 addq.b     #1,21(a4)
[00007224] 6000 ff56                 bra        _reduce_16
_reduce_23:
[00007228] 2e0d                      move.l     a5,d7
[0000722a] 60a6                      bra.s      _reduce_19
[0000722c] 4aac 0008                 tst.l      8(a4)
[00007230] 6604                      bne.s      _reduce_24
[00007232] 7e01                      moveq.l    #1,d7
[00007234] 6002                      bra.s      _reduce_25
_reduce_24:
[00007236] 4287                      clr.l      d7
_reduce_25:
[00007238] 2947 0008                 move.l     d7,8(a4)
[0000723c] 6000 ff3e                 bra        _reduce_16
[00007240] 2e2c 0008                 move.l     8(a4),d7
[00007244] 4687                      not.l      d7
[00007246] 2947 0008                 move.l     d7,8(a4)
[0000724a] 6000 ff30                 bra        _reduce_16
[0000724e] 2e8c                      move.l     a4,(a7)
[00007250] 4eb9 0000 7fda            jsr        _dlit
[00007256] 4a87                      tst.l      d7
[00007258] 6710                      beq.s      _reduce_26
[0000725a] 2eac 000c                 move.l     12(a4),(a7)
[0000725e] 5297                      addq.l     #1,(a7)
[00007260] 4eb9 0000 8016            jsr        _dnegate
[00007266] 6000 ff14                 bra        _reduce_16
_reduce_26:
[0000726a] 2e8c                      move.l     a4,(a7)
[0000726c] 4eb9 0000 83b6            jsr        _iscons
[00007272] 4a87                      tst.l      d7
[00007274] 670e                      beq.s      _reduce_27
[00007276] 2e2c 0008                 move.l     8(a4),d7
[0000727a] 4487                      neg.l      d7
[0000727c] 2947 0008                 move.l     d7,8(a4)
[00007280] 6000 fefa                 bra        _reduce_16
_reduce_27:
[00007284] 2e0d                      move.l     a5,d7
[00007286] 602e                      bra.s      _reduce_28
[00007288] 2ead 0010                 move.l     16(a5),(a7)
[0000728c] 4eba fd04                 jsr        _reduce(pc)
[00007290] 2e8c                      move.l     a4,(a7)
[00007292] 4eb9 0000 83b6            jsr        _iscons
[00007298] 4a87                      tst.l      d7
[0000729a] 6718                      beq.s      _reduce_29
[0000729c] 4aac 0008                 tst.l      8(a4)
[000072a0] 6706                      beq.s      _reduce_30
[000072a2] 2e2d 0010                 move.l     16(a5),d7
[000072a6] 6002                      bra.s      _reduce_31
_reduce_30:
[000072a8] 2e0b                      move.l     a3,d7
_reduce_31:
[000072aa] 2e87                      move.l     d7,(a7)
[000072ac] 2f0d                      move.l     a5,-(a7)
[000072ae] 4eba fae6                 jsr        _cpyterm(pc)
[000072b2] 588f                      addq.l     #4,a7
_reduce_29:
[000072b4] 2e0d                      move.l     a5,d7
_reduce_28:
[000072b6] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000072ba] 4e5e                      unlk       a6
[000072bc] 4e75                      rts

x72be_1:
x72be_3:
[000072be] 2e8b                      move.l     a3,(a7)
[000072c0] 2f0c                      move.l     a4,-(a7)
[000072c2] 4eba f8f4                 jsr        _canadd(pc)
[000072c6] 588f                      addq.l     #4,a7
[000072c8] 4a87                      tst.l      d7
[000072ca] 6600 feb0                 bne        x72be_1
[000072ce] 4287                      clr.l      d7
[000072d0] 1e2c 0016                 move.b     22(a4),d7
[000072d4] 0c47 00de                 cmpi.w     #$00DE,d7
[000072d8] 6630                      bne.s      x72be_2
[000072da] 2ead 0004                 move.l     4(a5),(a7)
[000072de] 4eb9 0000 8062            jsr        _dtype
[000072e4] 4a87                      tst.l      d7
[000072e6] 6622                      bne.s      x72be_2
[000072e8] 2e8b                      move.l     a3,(a7)
[000072ea] 2f2c 000c                 move.l     12(a4),-(a7)
[000072ee] 4eba f8c8                 jsr        _canadd(pc)
[000072f2] 588f                      addq.l     #4,a7
[000072f4] 4a87                      tst.l      d7
[000072f6] 6712                      beq.s      x72be_2
[000072f8] 296d 0004 0004            move.l     4(a5),4(a4)
[000072fe] 2e8c                      move.l     a4,(a7)
[00007300] 2f0d                      move.l     a5,-(a7)
[00007302] 4eba fa92                 jsr        _cpyterm(pc)
[00007306] 588f                      addq.l     #4,a7
[00007308] 60ac                      bra.s      x72be_3
x72be_2:
[0000730a] 2e0d                      move.l     a5,d7
[0000730c] 60a8                      bra.s      x72be_3
[0000730e] 1b7c 008e 0016            move.b     #$8E,22(a5)
[00007314] 2e2b 0008                 move.l     8(a3),d7
[00007318] 4487                      neg.l      d7
[0000731a] 2747 0008                 move.l     d7,8(a3)
[0000731e] 2e0d                      move.l     a5,d7
[00007320] 602e                      bra.s      x72be_4
[00007322] 2e8b                      move.l     a3,(a7)
[00007324] 2f0c                      move.l     a4,-(a7)
[00007326] 4eba f9bc                 jsr        _cansub(pc)
[0000732a] 588f                      addq.l     #4,a7
[0000732c] 4a87                      tst.l      d7
[0000732e] 6600 fe4c                 bne        x72be_1
[00007332] 2e8b                      move.l     a3,(a7)
[00007334] 4eb9 0000 83b6            jsr        _iscons
[0000733a] 4a87                      tst.l      d7
[0000733c] 671a                      beq.s      x72be_5
[0000733e] 1b7c 00de 0016            move.b     #$DE,22(a5)
[00007344] 2e2b 0008                 move.l     8(a3),d7
[00007348] 4487                      neg.l      d7
[0000734a] 2747 0008                 move.l     d7,8(a3)
[0000734e] 2e0d                      move.l     a5,d7
x72be_4:
[00007350] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00007354] 4e5e                      unlk       a6
[00007356] 4e75                      rts
x72be_5:
[00007358] 2e0d                      move.l     a5,d7
[0000735a] 60f4                      bra.s      x72be_4
[0000735c] 2e8b                      move.l     a3,(a7)
[0000735e] 2f0c                      move.l     a4,-(a7)
[00007360] 4eba f920                 jsr        _canmul(pc)
[00007364] 588f                      addq.l     #4,a7
[00007366] 4a87                      tst.l      d7
[00007368] 6600 fe12                 bne        x72be_1
[0000736c] 4287                      clr.l      d7
[0000736e] 1e2c 0016                 move.b     22(a4),d7
[00007372] 0c47 00de                 cmpi.w     #$00DE,d7
[00007376] 6638                      bne.s      x72be_6
[00007378] 2ead 0004                 move.l     4(a5),(a7)
[0000737c] 4eb9 0000 8062            jsr        _dtype
[00007382] 4a87                      tst.l      d7
[00007384] 662a                      bne.s      x72be_6
[00007386] 2e8b                      move.l     a3,(a7)
[00007388] 2f2c 000c                 move.l     12(a4),-(a7)
[0000738c] 4eba f8f4                 jsr        _canmul(pc)
[00007390] 588f                      addq.l     #4,a7
[00007392] 4a87                      tst.l      d7
[00007394] 671a                      beq.s      x72be_6
[00007396] 197c 00e2 0016            move.b     #$E2,22(a4)
[0000739c] 1b7c 00de 0016            move.b     #$DE,22(a5)
[000073a2] 2b6c 000c 000c            move.l     12(a4),12(a5)
[000073a8] 294b 000c                 move.l     a3,12(a4)
[000073ac] 2e0d                      move.l     a5,d7
[000073ae] 60a0                      bra.s      x72be_4
x72be_6:
[000073b0] 2e0d                      move.l     a5,d7
[000073b2] 609c                      bra.s      x72be_4
[000073b4] 4aab 0008                 tst.l      8(a3)
[000073b8] 6610                      bne.s      x72be_7
[000073ba] 2ebc 0002 14d4            move.l     #$000214D4,(a7) "illegal /"
[000073c0] 4eb9 0000 3e84            jsr        _p1error
[000073c6] 6000 fdb4                 bra        x72be_1
x72be_7:
[000073ca] 246d 0004                 movea.l    4(a5),a2
[000073ce] 508a                      addq.l     #8,a2
[000073d0] 4287                      clr.l      d7
[000073d2] 1e12                      move.b     (a2),d7
[000073d4] 0c47 0021                 cmpi.w     #$0021,d7
[000073d8] 6612                      bne.s      x72be_8
[000073da] 2eac 0008                 move.l     8(a4),(a7)
[000073de] 2f2b 0008                 move.l     8(a3),-(a7)
[000073e2] 4eb9 0000 a7f6            jsr        a.uldiv
[000073e8] 2e17                      move.l     (a7),d7
[000073ea] 6010                      bra.s      x72be_9
x72be_8:
[000073ec] 2eac 0008                 move.l     8(a4),(a7)
[000073f0] 2f2b 0008                 move.l     8(a3),-(a7)
[000073f4] 4eb9 0000 a748            jsr        a.ldiv
[000073fa] 2e17                      move.l     (a7),d7
x72be_9:
[000073fc] 2947 0008                 move.l     d7,8(a4)
[00007400] 6000 fd7a                 bra        x72be_1
[00007404] 4aab 0008                 tst.l      8(a3)
[00007408] 6610                      bne.s      x72be_10
[0000740a] 2ebc 0002 14ca            move.l     #$000214CA,(a7) "illegal %"
[00007410] 4eb9 0000 3e84            jsr        _p1error
[00007416] 6000 fd64                 bra        x72be_1
x72be_10:
[0000741a] 246d 0004                 movea.l    4(a5),a2
[0000741e] 508a                      addq.l     #8,a2
[00007420] 4287                      clr.l      d7
[00007422] 1e12                      move.b     (a2),d7
[00007424] 0c47 0021                 cmpi.w     #$0021,d7
[00007428] 6612                      bne.s      x72be_11
[0000742a] 2eac 0008                 move.l     8(a4),(a7)
[0000742e] 2f2b 0008                 move.l     8(a3),-(a7)
[00007432] 4eb9 0000 a7ee            jsr        a.ulmod
[00007438] 2e17                      move.l     (a7),d7
[0000743a] 6010                      bra.s      x72be_12
x72be_11:
[0000743c] 2eac 0008                 move.l     8(a4),(a7)
[00007440] 2f2b 0008                 move.l     8(a3),-(a7)
[00007444] 4eb9 0000 a736            jsr        a.lmod
[0000744a] 2e17                      move.l     (a7),d7
x72be_12:
[0000744c] 2947 0008                 move.l     d7,8(a4)
[00007450] 6000 fd2a                 bra        x72be_1
[00007454] 2e2b 0008                 move.l     8(a3),d7
[00007458] cfac 0008                 and.l      d7,8(a4)
[0000745c] 6000 fd1e                 bra        x72be_1
[00007460] 2e2b 0008                 move.l     8(a3),d7
[00007464] 8fac 0008                 or.l       d7,8(a4)
[00007468] 6000 fd12                 bra        x72be_1
[0000746c] 2e2b 0008                 move.l     8(a3),d7
[00007470] bfac 0008                 eor.l      d7,8(a4)
[00007474] 6000 fd06                 bra        x72be_1
[00007478] 2e2c 0008                 move.l     8(a4),d7
[0000747c] 2c2b 0008                 move.l     8(a3),d6
[00007480] eda7                      asl.l      d6,d7
[00007482] 2947 0008                 move.l     d7,8(a4)
[00007486] 6000 fcf4                 bra        x72be_1
[0000748a] 246d 0004                 movea.l    4(a5),a2
[0000748e] 508a                      addq.l     #8,a2
[00007490] 4287                      clr.l      d7
[00007492] 1e12                      move.b     (a2),d7
[00007494] 0c47 0021                 cmpi.w     #$0021,d7
[00007498] 660c                      bne.s      x72be_13
[0000749a] 2e2c 0008                 move.l     8(a4),d7
[0000749e] 2c2b 0008                 move.l     8(a3),d6
[000074a2] ecaf                      lsr.l      d6,d7
[000074a4] 600a                      bra.s      x72be_14
x72be_13:
[000074a6] 2e2c 0008                 move.l     8(a4),d7
[000074aa] 2c2b 0008                 move.l     8(a3),d6
[000074ae] eca7                      asr.l      d6,d7
x72be_14:
[000074b0] 2947 0008                 move.l     d7,8(a4)
[000074b4] 6000 fcc6                 bra        x72be_1
[000074b8] 246c 0004                 movea.l    4(a4),a2
[000074bc] 508a                      addq.l     #8,a2
[000074be] 4287                      clr.l      d7
[000074c0] 1e12                      move.b     (a2),d7
[000074c2] 0c47 0021                 cmpi.w     #$0021,d7
[000074c6] 6710                      beq.s      x72be_15
[000074c8] 246b 0004                 movea.l    4(a3),a2
[000074cc] 508a                      addq.l     #8,a2
[000074ce] 4287                      clr.l      d7
[000074d0] 1e12                      move.b     (a2),d7
[000074d2] 0c47 0021                 cmpi.w     #$0021,d7
[000074d6] 6612                      bne.s      x72be_16
x72be_15:
[000074d8] 2e2c 0008                 move.l     8(a4),d7
[000074dc] beab 0008                 cmp.l      8(a3),d7
[000074e0] 6404                      bcc.s      x72be_17
[000074e2] 7e01                      moveq.l    #1,d7
[000074e4] 6002                      bra.s      x72be_18
x72be_17:
[000074e6] 4287                      clr.l      d7
x72be_18:
[000074e8] 6010                      bra.s      x72be_19
x72be_16:
[000074ea] 2e2c 0008                 move.l     8(a4),d7
[000074ee] beab 0008                 cmp.l      8(a3),d7
[000074f2] 6c04                      bge.s      x72be_20
[000074f4] 7e01                      moveq.l    #1,d7
[000074f6] 6002                      bra.s      x72be_19
x72be_20:
[000074f8] 4287                      clr.l      d7
x72be_19:
[000074fa] 2947 0008                 move.l     d7,8(a4)
[000074fe] 6000 fc7c                 bra        x72be_1
[00007502] 246c 0004                 movea.l    4(a4),a2
[00007506] 508a                      addq.l     #8,a2
[00007508] 4287                      clr.l      d7
[0000750a] 1e12                      move.b     (a2),d7
[0000750c] 0c47 0021                 cmpi.w     #$0021,d7
[00007510] 6710                      beq.s      x72be_21
[00007512] 246b 0004                 movea.l    4(a3),a2
[00007516] 508a                      addq.l     #8,a2
[00007518] 4287                      clr.l      d7
[0000751a] 1e12                      move.b     (a2),d7
[0000751c] 0c47 0021                 cmpi.w     #$0021,d7
[00007520] 6612                      bne.s      x72be_22
x72be_21:
[00007522] 2e2c 0008                 move.l     8(a4),d7
[00007526] beab 0008                 cmp.l      8(a3),d7
[0000752a] 6204                      bhi.s      x72be_23
[0000752c] 7e01                      moveq.l    #1,d7
[0000752e] 6002                      bra.s      x72be_24
x72be_23:
[00007530] 4287                      clr.l      d7
x72be_24:
[00007532] 6010                      bra.s      x72be_25
x72be_22:
[00007534] 2e2c 0008                 move.l     8(a4),d7
[00007538] beab 0008                 cmp.l      8(a3),d7
[0000753c] 6e04                      bgt.s      x72be_26
[0000753e] 7e01                      moveq.l    #1,d7
[00007540] 6002                      bra.s      x72be_25
x72be_26:
[00007542] 4287                      clr.l      d7
x72be_25:
[00007544] 2947 0008                 move.l     d7,8(a4)
[00007548] 6000 fc32                 bra        x72be_1
[0000754c] 246c 0004                 movea.l    4(a4),a2
[00007550] 508a                      addq.l     #8,a2
[00007552] 4287                      clr.l      d7
[00007554] 1e12                      move.b     (a2),d7
[00007556] 0c47 0021                 cmpi.w     #$0021,d7
[0000755a] 6710                      beq.s      x72be_27
[0000755c] 246b 0004                 movea.l    4(a3),a2
[00007560] 508a                      addq.l     #8,a2
[00007562] 4287                      clr.l      d7
[00007564] 1e12                      move.b     (a2),d7
[00007566] 0c47 0021                 cmpi.w     #$0021,d7
[0000756a] 6612                      bne.s      x72be_28
x72be_27:
[0000756c] 2e2c 0008                 move.l     8(a4),d7
[00007570] beab 0008                 cmp.l      8(a3),d7
[00007574] 6304                      bls.s      x72be_29
[00007576] 7e01                      moveq.l    #1,d7
[00007578] 6002                      bra.s      x72be_30
x72be_29:
[0000757a] 4287                      clr.l      d7
x72be_30:
[0000757c] 6010                      bra.s      x72be_31
x72be_28:
[0000757e] 2e2c 0008                 move.l     8(a4),d7
[00007582] beab 0008                 cmp.l      8(a3),d7
[00007586] 6f04                      ble.s      x72be_32
[00007588] 7e01                      moveq.l    #1,d7
[0000758a] 6002                      bra.s      x72be_31
x72be_32:
[0000758c] 4287                      clr.l      d7
x72be_31:
[0000758e] 2947 0008                 move.l     d7,8(a4)
[00007592] 6000 fbe8                 bra        x72be_1
[00007596] 246c 0004                 movea.l    4(a4),a2
[0000759a] 508a                      addq.l     #8,a2
[0000759c] 4287                      clr.l      d7
[0000759e] 1e12                      move.b     (a2),d7
[000075a0] 0c47 0021                 cmpi.w     #$0021,d7
[000075a4] 6710                      beq.s      x72be_33
[000075a6] 246b 0004                 movea.l    4(a3),a2
[000075aa] 508a                      addq.l     #8,a2
[000075ac] 4287                      clr.l      d7
[000075ae] 1e12                      move.b     (a2),d7
[000075b0] 0c47 0021                 cmpi.w     #$0021,d7
[000075b4] 6612                      bne.s      x72be_34
x72be_33:
[000075b6] 2e2c 0008                 move.l     8(a4),d7
[000075ba] beab 0008                 cmp.l      8(a3),d7
[000075be] 6504                      bcs.s      x72be_35
[000075c0] 7e01                      moveq.l    #1,d7
[000075c2] 6002                      bra.s      x72be_36
x72be_35:
[000075c4] 4287                      clr.l      d7
x72be_36:
[000075c6] 6010                      bra.s      x72be_37
x72be_34:
[000075c8] 2e2c 0008                 move.l     8(a4),d7
[000075cc] beab 0008                 cmp.l      8(a3),d7
[000075d0] 6d04                      blt.s      x72be_38
[000075d2] 7e01                      moveq.l    #1,d7
[000075d4] 6002                      bra.s      x72be_37
x72be_38:
[000075d6] 4287                      clr.l      d7
x72be_37:
[000075d8] 2947 0008                 move.l     d7,8(a4)
[000075dc] 6000 fb9e                 bra        x72be_1
[000075e0] 2e2c 0008                 move.l     8(a4),d7
[000075e4] beab 0008                 cmp.l      8(a3),d7
[000075e8] 6604                      bne.s      x72be_39
[000075ea] 7e01                      moveq.l    #1,d7
[000075ec] 6002                      bra.s      x72be_40
x72be_39:
[000075ee] 4287                      clr.l      d7
x72be_40:
[000075f0] 2947 0008                 move.l     d7,8(a4)
[000075f4] 6000 fb86                 bra        x72be_1
[000075f8] 2e2c 0008                 move.l     8(a4),d7
[000075fc] beab 0008                 cmp.l      8(a3),d7
[00007600] 6704                      beq.s      x72be_41
[00007602] 7e01                      moveq.l    #1,d7
[00007604] 6002                      bra.s      x72be_42
x72be_41:
[00007606] 4287                      clr.l      d7
x72be_42:
[00007608] 2947 0008                 move.l     d7,8(a4)
[0000760c] 6000 fb6e                 bra        x72be_1
[00007610] 2e8c                      move.l     a4,(a7)
[00007612] 4eb9 0000 83b6            jsr        _iscons
[00007618] 4a87                      tst.l      d7
[0000761a] 670c                      beq.s      x72be_43
[0000761c] 4aac 0008                 tst.l      8(a4)
[00007620] 662e                      bne.s      x72be_44
[00007622] 42ad 0008                 clr.l      8(a5)
[00007626] 605a                      bra.s      x72be_45
x72be_43:
[00007628] 2e8b                      move.l     a3,(a7)
[0000762a] 4eb9 0000 83b6            jsr        _iscons
[00007630] 4a87                      tst.l      d7
[00007632] 673c                      beq.s      x72be_46
[00007634] 4aab 0008                 tst.l      8(a3)
[00007638] 673a                      beq.s      x72be_47
[0000763a] 2b7c 0002 11cc 000c       move.l     #_zeterm,12(a5)
[00007642] 1b7c 009b 0016            move.b     #$9B,22(a5)
[00007648] 2e8d                      move.l     a5,(a7)
[0000764a] 4eba f946                 jsr        _reduce(pc)
[0000764e] 6018                      bra.s      x72be_48
x72be_44:
[00007650] 2b4b 0008                 move.l     a3,8(a5)
[00007654] 2b7c 0002 11cc 000c       move.l     #_zeterm,12(a5)
[0000765c] 1b7c 009b 0016            move.b     #$9B,22(a5)
[00007662] 2e8d                      move.l     a5,(a7)
[00007664] 4eba f92c                 jsr        _reduce(pc)
x72be_48:
[00007668] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000766c] 4e5e                      unlk       a6
[0000766e] 4e75                      rts
x72be_46:
[00007670] 2e0d                      move.l     a5,d7
[00007672] 60f4                      bra.s      x72be_48
x72be_47:
[00007674] 2e8c                      move.l     a4,(a7)
[00007676] 4eba f82a                 jsr        _hasside(pc)
[0000767a] 4a87                      tst.l      d7
[0000767c] 661c                      bne.s      x72be_49
[0000767e] 42ad 0008                 clr.l      8(a5)
x72be_45:
[00007682] 4297                      clr.l      (a7)
[00007684] 2f2d 0008                 move.l     8(a5),-(a7)
[00007688] 42a7                      clr.l      -(a7)
[0000768a] 42a7                      clr.l      -(a7)
[0000768c] 2f0d                      move.l     a5,-(a7)
[0000768e] 4eb9 0000 85aa            jsr        _setad
[00007694] 4fef 0010                 lea.l      16(a7),a7
[00007698] 60ce                      bra.s      x72be_48
x72be_49:
[0000769a] 2e0d                      move.l     a5,d7
[0000769c] 60ca                      bra.s      x72be_48
[0000769e] 2e8c                      move.l     a4,(a7)
[000076a0] 4eb9 0000 83b6            jsr        _iscons
[000076a6] 4a87                      tst.l      d7
[000076a8] 670e                      beq.s      x72be_50
[000076aa] 4aac 0008                 tst.l      8(a4)
[000076ae] 6728                      beq.s      x72be_51
[000076b0] 7001                      moveq.l    #1,d0
[000076b2] 2b40 0008                 move.l     d0,8(a5)
[000076b6] 6054                      bra.s      x72be_52
x72be_50:
[000076b8] 2e8b                      move.l     a3,(a7)
[000076ba] 4eb9 0000 83b6            jsr        _iscons
[000076c0] 4a87                      tst.l      d7
[000076c2] 6734                      beq.s      x72be_53
[000076c4] 4aab 0008                 tst.l      8(a3)
[000076c8] 6632                      bne.s      x72be_54
[000076ca] 1b7c 009b 0016            move.b     #$9B,22(a5)
[000076d0] 2e8d                      move.l     a5,(a7)
[000076d2] 4eba f8be                 jsr        _reduce(pc)
[000076d6] 6018                      bra.s      x72be_55
x72be_51:
[000076d8] 2b4b 0008                 move.l     a3,8(a5)
[000076dc] 1b7c 009b 0016            move.b     #$9B,22(a5)
[000076e2] 2b7c 0002 11cc 000c       move.l     #_zeterm,12(a5)
[000076ea] 2e8d                      move.l     a5,(a7)
[000076ec] 4eba f8a4                 jsr        _reduce(pc)
x72be_55:
[000076f0] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000076f4] 4e5e                      unlk       a6
[000076f6] 4e75                      rts
x72be_53:
[000076f8] 2e0d                      move.l     a5,d7
[000076fa] 60f4                      bra.s      x72be_55
x72be_54:
[000076fc] 2e8c                      move.l     a4,(a7)
[000076fe] 4eba f7a2                 jsr        _hasside(pc)
[00007702] 4a87                      tst.l      d7
[00007704] 661e                      bne.s      x72be_56
[00007706] 7001                      moveq.l    #1,d0
[00007708] 2b40 0008                 move.l     d0,8(a5)
x72be_52:
[0000770c] 4297                      clr.l      (a7)
[0000770e] 2f2d 0008                 move.l     8(a5),-(a7)
[00007712] 42a7                      clr.l      -(a7)
[00007714] 42a7                      clr.l      -(a7)
[00007716] 2f0d                      move.l     a5,-(a7)
[00007718] 4eb9 0000 85aa            jsr        _setad
[0000771e] 4fef 0010                 lea.l      16(a7),a7
[00007722] 60cc                      bra.s      x72be_55
x72be_56:
[00007724] 2e0d                      move.l     a5,d7
[00007726] 60c8                      bra.s      x72be_55
[00007728] 2e8c                      move.l     a4,(a7)
[0000772a] 4eba f776                 jsr        _hasside(pc)
[0000772e] 4a87                      tst.l      d7
[00007730] 670c                      beq.s      x72be_57
[00007732] 2ebc 0002 14b6            move.l     #$000214B6,(a7) "illegal side effect"
[00007738] 4eb9 0000 3e84            jsr        _p1error
x72be_57:
[0000773e] 2e8c                      move.l     a4,(a7)
[00007740] 2f0d                      move.l     a5,-(a7)
[00007742] 4eba f652                 jsr        _cpyterm(pc)
[00007746] 588f                      addq.l     #4,a7
[00007748] 60a6                      bra.s      x72be_55
[0000774a] 2e0d                      move.l     a5,d7
[0000774c] 60a2                      bra.s      x72be_55

_addsym:
[0000774e] 4e56 fffe                 link       a6,#-2
[00007752] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00007756] 2a6e 0008                 movea.l    8(a6),a5
[0000775a] 286e 000c                 movea.l    12(a6),a4
[0000775e] 4ab9 0002 0b8a            tst.l      _oldflag
[00007764] 6648                      bne.s      _addsym_1
[00007766] 4a2d 0010                 tst.b      16(a5)
[0000776a] 6742                      beq.s      _addsym_1
[0000776c] 4aad 0004                 tst.l      4(a5)
[00007770] 673c                      beq.s      _addsym_1
[00007772] 4287                      clr.l      d7
[00007774] 1e2d 000e                 move.b     14(a5),d7
[00007778] 0c47 002a                 cmpi.w     #$002A,d7
[0000777c] 673e                      beq.s      _addsym_2
[0000777e] 4287                      clr.l      d7
[00007780] 1e2d 000e                 move.b     14(a5),d7
[00007784] 0c47 003e                 cmpi.w     #$003E,d7
[00007788] 6732                      beq.s      _addsym_2
[0000778a] 4287                      clr.l      d7
[0000778c] 1e2d 000e                 move.b     14(a5),d7
[00007790] 0c47 003c                 cmpi.w     #$003C,d7
[00007794] 6726                      beq.s      _addsym_2
[00007796] 4287                      clr.l      d7
[00007798] 1e2d 000e                 move.b     14(a5),d7
[0000779c] 0c47 0034                 cmpi.w     #$0034,d7
[000077a0] 671a                      beq.s      _addsym_2
[000077a2] 4287                      clr.l      d7
[000077a4] 1e2d 000e                 move.b     14(a5),d7
[000077a8] 0c47 003d                 cmpi.w     #$003D,d7
[000077ac] 670e                      beq.s      _addsym_2
_addsym_1:
[000077ae] 2a94                      move.l     (a4),(a5)
[000077b0] 288d                      move.l     a5,(a4)
[000077b2] 2e0d                      move.l     a5,d7
[000077b4] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000077b8] 4e5e                      unlk       a6
[000077ba] 4e75                      rts
_addsym_2:
[000077bc] 4287                      clr.l      d7
[000077be] 3e2d 000c                 move.w     12(a5),d7
[000077c2] 0807 000b                 btst       #11,d7
[000077c6] 6704                      beq.s      _addsym_3
[000077c8] 7e08                      moveq.l    #8,d7
[000077ca] 6002                      bra.s      _addsym_4
_addsym_3:
[000077cc] 4287                      clr.l      d7
_addsym_4:
[000077ce] 3d47 fffe                 move.w     d7,-2(a6)
[000077d2] 246d 0004                 movea.l    4(a5),a2
[000077d6] 508a                      addq.l     #8,a2
[000077d8] 4287                      clr.l      d7
[000077da] 1e12                      move.b     (a2),d7
[000077dc] 0c47 0042                 cmpi.w     #$0042,d7
[000077e0] 661a                      bne.s      _addsym_5
[000077e2] 246d 0004                 movea.l    4(a5),a2
[000077e6] 588a                      addq.l     #4,a2
[000077e8] 2452                      movea.l    (a2),a2
[000077ea] 508a                      addq.l     #8,a2
[000077ec] 4287                      clr.l      d7
[000077ee] 1e12                      move.b     (a2),d7
[000077f0] 41f9 0002 156e            lea.l      $0002156E,a0
[000077f6] 4ef9 0000 a7dc            jmp        a.switch
_addsym_5:
[000077fc] 4287                      clr.l      d7
[000077fe] 3e2d 000c                 move.w     12(a5),d7
[00007802] 0807 000d                 btst       #13,d7
[00007806] 6704                      beq.s      _addsym_6
[00007808] 7e02                      moveq.l    #2,d7
[0000780a] 6002                      bra.s      _addsym_7
_addsym_6:
[0000780c] 7e01                      moveq.l    #1,d7
_addsym_7:
[0000780e] 8f6e fffe                 or.w       d7,-2(a6)
_addsym_8:
[00007812] 08ee 0007 ffff            bset       #7,-1(a6)
[00007818] 4287                      clr.l      d7
[0000781a] 1e2d 0010                 move.b     16(a5),d7
[0000781e] 2447                      movea.l    d7,a2
[00007820] 47ed 0011                 lea.l      17(a5),a3
[00007824] d5cb                      adda.l     a3,a2
[00007826] 14ae ffff                 move.b     -1(a6),(a2)
[0000782a] 6082                      bra.s      _addsym_1
[0000782c] 006e 0005 fffe            ori.w      #$0005,-2(a6)
[00007832] 60de                      bra.s      _addsym_8
[00007834] 60dc                      bra.s      _addsym_8
[00007836] 006e 0006 fffe            ori.w      #$0006,-2(a6)
[0000783c] 60d4                      bra.s      _addsym_8
[0000783e] 08ee 0002 ffff            bset       #2,-1(a6)
[00007844] 60cc                      bra.s      _addsym_8

_addtype:
[00007846] 4e56 0000                 link       a6,#0
[0000784a] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000784e] 2a6e 0008                 movea.l    8(a6),a5
[00007852] 286e 000c                 movea.l    12(a6),a4
[00007856] 45ed 0004                 lea.l      4(a5),a2
[0000785a] 264a                      movea.l    a2,a3
_addtype_2:
[0000785c] 4a93                      tst.l      (a3)
[0000785e] 6708                      beq.s      _addtype_1
[00007860] 2e13                      move.l     (a3),d7
[00007862] 5887                      addq.l     #4,d7
[00007864] 2647                      movea.l    d7,a3
[00007866] 60f4                      bra.s      _addtype_2
_addtype_1:
[00007868] 268c                      move.l     a4,(a3)
[0000786a] 2e0d                      move.l     a5,d7
[0000786c] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00007870] 4e5e                      unlk       a6
[00007872] 4e75                      rts

_bndify:
[00007874] 4e56 0000                 link       a6,#0
[00007878] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[0000787c] 2a6e 0008                 movea.l    8(a6),a5
[00007880] 2e8d                      move.l     a5,(a7)
[00007882] 4eb9 0000 78b4            jsr        _bound
[00007888] 7c01                      moveq.l    #1,d6
[0000788a] efa6                      asl.l      d7,d6
[0000788c] 2e06                      move.l     d6,d7
[0000788e] 5387                      subq.l     #1,d7
[00007890] 2a07                      move.l     d7,d5
[00007892] 2e2e 000c                 move.l     12(a6),d7
[00007896] de85                      add.l      d5,d7
[00007898] 2d47 000c                 move.l     d7,12(a6)
[0000789c] 2e05                      move.l     d5,d7
[0000789e] 4687                      not.l      d7
[000078a0] ceae 000c                 and.l      12(a6),d7
[000078a4] 2d47 000c                 move.l     d7,12(a6)
[000078a8] 2e2e 000c                 move.l     12(a6),d7
[000078ac] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[000078b0] 4e5e                      unlk       a6
[000078b2] 4e75                      rts

_bound:
[000078b4] 4e56 fffe                 link       a6,#-2
[000078b8] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000078bc] 2a6e 0008                 movea.l    8(a6),a5
[000078c0] 1d6d 0008 ffff            move.b     8(a5),-1(a6)
[000078c6] 4287                      clr.l      d7
[000078c8] 1e2e ffff                 move.b     -1(a6),d7
[000078cc] 2e87                      move.l     d7,(a7)
[000078ce] 2f3c 0002 14e6            move.l     #_typtab,-(a7)
[000078d4] 4eb9 0000 a7a6            jsr        _scnstr
[000078da] 588f                      addq.l     #4,a7
[000078dc] 2447                      movea.l    d7,a2
[000078de] d5fc 0002 14f6            adda.l     #_bndtab,a2
[000078e4] 1a12                      move.b     (a2),d5
[000078e6] 4885                      ext.w      d5
[000078e8] 48c5                      ext.l      d5
[000078ea] 6c42                      bge.s      _bound_1
[000078ec] 0c85 ffff ffff            cmpi.l     #$FFFFFFFF,d5
[000078f2] 6612                      bne.s      _bound_2
[000078f4] 4ab9 0002 0b7e            tst.l      _lflag
[000078fa] 6704                      beq.s      _bound_3
[000078fc] 7e02                      moveq.l    #2,d7
[000078fe] 6002                      bra.s      _bound_4
_bound_3:
[00007900] 7e01                      moveq.l    #1,d7
_bound_4:
[00007902] 2a07                      move.l     d7,d5
[00007904] 6028                      bra.s      _bound_1
_bound_2:
[00007906] 4287                      clr.l      d7
[00007908] 1e2e ffff                 move.b     -1(a6),d7
[0000790c] 0c47 0040                 cmpi.w     #$0040,d7
[00007910] 6630                      bne.s      _bound_5
[00007912] 4ab9 0002 0b7e            tst.l      _lflag
[00007918] 660c                      bne.s      _bound_6
[0000791a] 4287                      clr.l      d7
[0000791c] 3e2d 000a                 move.w     10(a5),d7
[00007920] 0807 000b                 btst       #11,d7
[00007924] 6704                      beq.s      _bound_7
_bound_6:
[00007926] 7e02                      moveq.l    #2,d7
[00007928] 6002                      bra.s      _bound_8
_bound_7:
[0000792a] 7e01                      moveq.l    #1,d7
_bound_8:
[0000792c] 2a07                      move.l     d7,d5
_bound_1:
[0000792e] bab9 0002 0b9e            cmp.l      _bndef,d5
[00007934] 6404                      bcc.s      _bound_9
[00007936] 2e05                      move.l     d5,d7
[00007938] 6006                      bra.s      _bound_10
_bound_9:
[0000793a] 2e39 0002 0b9e            move.l     _bndef,d7
_bound_10:
[00007940] 6014                      bra.s      _bound_11
_bound_5:
[00007942] 4287                      clr.l      d7
[00007944] 1e2e ffff                 move.b     -1(a6),d7
[00007948] 0c47 0041                 cmpi.w     #$0041,d7
[0000794c] 6610                      bne.s      _bound_12
[0000794e] 2ead 0004                 move.l     4(a5),(a7)
[00007952] 4eba ff60                 jsr        _bound(pc)
_bound_11:
[00007956] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000795a] 4e5e                      unlk       a6
[0000795c] 4e75                      rts
_bound_12:
[0000795e] 4287                      clr.l      d7
[00007960] 1e2e ffff                 move.b     -1(a6),d7
[00007964] 0c47 0048                 cmpi.w     #$0048,d7
[00007968] 670c                      beq.s      _bound_13
[0000796a] 4287                      clr.l      d7
[0000796c] 1e2e ffff                 move.b     -1(a6),d7
[00007970] 0c47 0049                 cmpi.w     #$0049,d7
[00007974] 662c                      bne.s      _bound_14
_bound_13:
[00007976] 4285                      clr.l      d5
[00007978] 246d 000a                 movea.l    10(a5),a2
[0000797c] 508a                      addq.l     #8,a2
[0000797e] 2852                      movea.l    (a2),a4
_bound_18:
[00007980] 2e0c                      move.l     a4,d7
[00007982] 6722                      beq.s      _bound_15
[00007984] 2eac 0004                 move.l     4(a4),(a7)
[00007988] 4eba ff2a                 jsr        _bound(pc)
[0000798c] ba87                      cmp.l      d7,d5
[0000798e] 640a                      bcc.s      _bound_16
[00007990] 2eac 0004                 move.l     4(a4),(a7)
[00007994] 4eba ff1e                 jsr        _bound(pc)
[00007998] 6002                      bra.s      _bound_17
_bound_16:
[0000799a] 2e05                      move.l     d5,d7
_bound_17:
[0000799c] 2a07                      move.l     d7,d5
[0000799e] 2854                      movea.l    (a4),a4
[000079a0] 60de                      bra.s      _bound_18
_bound_14:
[000079a2] 7e04                      moveq.l    #4,d7
[000079a4] 60b0                      bra.s      _bound_11
_bound_15:
[000079a6] 2e05                      move.l     d5,d7
[000079a8] 60ac                      bra.s      _bound_11

_buyattr:
[000079aa] 4e56 0000                 link       a6,#0
[000079ae] 48e7 8004                 movem.l    d0/a5,-(a7)
[000079b2] 4ab9 0002 14de            tst.l      $000214DE
[000079b8] 671a                      beq.s      _buyattr_1
[000079ba] 2a79 0002 14de            movea.l    $000214DE,a5
[000079c0] 23d5 0002 14de            move.l     (a5),$000214DE
[000079c6] 2ab9 0002 0cea            move.l     _attlist,(a5)
[000079cc] 23cd 0002 0cea            move.l     a5,_attlist
[000079d2] 601a                      bra.s      _buyattr_2
_buyattr_1:
[000079d4] 2eb9 0002 0cea            move.l     _attlist,(a7)
[000079da] 4878 0012                 pea.l      ($00000012).w
[000079de] 4eb9 0000 a906            jsr        _alloc
[000079e4] 588f                      addq.l     #4,a7
[000079e6] 2a47                      movea.l    d7,a5
[000079e8] 23cd 0002 0cea            move.l     a5,_attlist
_buyattr_2:
[000079ee] 1b6e 000b 0008            move.b     11(a6),8(a5)
[000079f4] 2b6e 000c 0004            move.l     12(a6),4(a5)
[000079fa] 42ad 000a                 clr.l      10(a5)
[000079fe] 2b6d 000a 000e            move.l     10(a5),14(a5)
[00007a04] 2e0d                      move.l     a5,d7
[00007a06] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00007a0a] 4e5e                      unlk       a6
[00007a0c] 4e75                      rts

_buyop:
[00007a0e] 4e56 0000                 link       a6,#0
[00007a12] 48e7 8004                 movem.l    d0/a5,-(a7)
[00007a16] 4ab9 0002 14e2            tst.l      $000214E2
[00007a1c] 671a                      beq.s      _buyop_1
[00007a1e] 2a79 0002 14e2            movea.l    $000214E2,a5
[00007a24] 23d5 0002 14e2            move.l     (a5),$000214E2
[00007a2a] 2ab9 0002 0d32            move.l     _exlist,(a5)
[00007a30] 23cd 0002 0d32            move.l     a5,_exlist
[00007a36] 601a                      bra.s      _buyop_2
_buyop_1:
[00007a38] 2eb9 0002 0d32            move.l     _exlist,(a7)
[00007a3e] 4878 0018                 pea.l      ($00000018).w
[00007a42] 4eb9 0000 a906            jsr        _alloc
[00007a48] 588f                      addq.l     #4,a7
[00007a4a] 2a47                      movea.l    d7,a5
[00007a4c] 23cd 0002 0d32            move.l     a5,_exlist
_buyop_2:
[00007a52] 2b6e 0014 0004            move.l     20(a6),4(a5)
[00007a58] 1b6e 000b 0016            move.b     11(a6),22(a5)
[00007a5e] 2b6e 000c 0008            move.l     12(a6),8(a5)
[00007a64] 2b6e 0010 000c            move.l     16(a6),12(a5)
[00007a6a] 42ad 0010                 clr.l      16(a5)
[00007a6e] 2e0d                      move.l     a5,d7
[00007a70] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00007a74] 4e5e                      unlk       a6
[00007a76] 4e75                      rts

_buysym:
[00007a78] 4e56 0000                 link       a6,#0
[00007a7c] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00007a80] 2a6e 000c                 movea.l    12(a6),a5
[00007a84] 4297                      clr.l      (a7)
[00007a86] 7e12                      moveq.l    #18,d7
[00007a88] 4286                      clr.l      d6
[00007a8a] 1c15                      move.b     (a5),d6
[00007a8c] de86                      add.l      d6,d7
[00007a8e] 2f07                      move.l     d7,-(a7)
[00007a90] 4eb9 0000 a906            jsr        _alloc
[00007a96] 588f                      addq.l     #4,a7
[00007a98] 2847                      movea.l    d7,a4
[00007a9a] 2e0d                      move.l     a5,d7
[00007a9c] 6718                      beq.s      _buysym_1
[00007a9e] 4287                      clr.l      d7
[00007aa0] 1e15                      move.b     (a5),d7
[00007aa2] 2e87                      move.l     d7,(a7)
[00007aa4] 5297                      addq.l     #1,(a7)
[00007aa6] 2f0d                      move.l     a5,-(a7)
[00007aa8] 486c 0010                 pea.l      16(a4)
[00007aac] 4eb9 0000 adac            jsr        _cpybuf
[00007ab2] 508f                      addq.l     #8,a7
[00007ab4] 6004                      bra.s      _buysym_2
_buysym_1:
[00007ab6] 422c 0010                 clr.b      16(a4)
_buysym_2:
[00007aba] 4294                      clr.l      (a4)
[00007abc] 4287                      clr.l      d7
[00007abe] 1e15                      move.b     (a5),d7
[00007ac0] 2447                      movea.l    d7,a2
[00007ac2] 47ec 0011                 lea.l      17(a4),a3
[00007ac6] d5cb                      adda.l     a3,a2
[00007ac8] 4212                      clr.b      (a2)
[00007aca] 296e 0008 0004            move.l     8(a6),4(a4)
[00007ad0] 426c 000c                 clr.w      12(a4)
[00007ad4] 422c 000f                 clr.b      15(a4)
[00007ad8] 196e 0013 000e            move.b     19(a6),14(a4)
[00007ade] 42ac 0008                 clr.l      8(a4)
[00007ae2] 2e0c                      move.l     a4,d7
[00007ae4] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00007ae8] 4e5e                      unlk       a6
[00007aea] 4e75                      rts

_buyterm:
[00007aec] 4e56 0000                 link       a6,#0
[00007af0] 48e7 8004                 movem.l    d0/a5,-(a7)
[00007af4] 4ab9 0002 14e2            tst.l      $000214E2
[00007afa] 671a                      beq.s      _buyterm_1
[00007afc] 2a79 0002 14e2            movea.l    $000214E2,a5
[00007b02] 23d5 0002 14e2            move.l     (a5),$000214E2
[00007b08] 2ab9 0002 0d32            move.l     _exlist,(a5)
[00007b0e] 23cd 0002 0d32            move.l     a5,_exlist
[00007b14] 601a                      bra.s      _buyterm_2
_buyterm_1:
[00007b16] 2eb9 0002 0d32            move.l     _exlist,(a7)
[00007b1c] 4878 0018                 pea.l      ($00000018).w
[00007b20] 4eb9 0000 a906            jsr        _alloc
[00007b26] 588f                      addq.l     #4,a7
[00007b28] 2a47                      movea.l    d7,a5
[00007b2a] 23cd 0002 0d32            move.l     a5,_exlist
_buyterm_2:
[00007b30] 2b6e 0008 0004            move.l     8(a6),4(a5)
[00007b36] 422d 0016                 clr.b      22(a5)
[00007b3a] 426d 0010                 clr.w      16(a5)
[00007b3e] 4aae 000c                 tst.l      12(a6)
[00007b42] 6706                      beq.s      _buyterm_3
[00007b44] 2e2e 000c                 move.l     12(a6),d7
[00007b48] 6006                      bra.s      _buyterm_4
_buyterm_3:
[00007b4a] 2e3c 0002 077c            move.l     #_noname,d7
_buyterm_4:
[00007b50] 2b47 000c                 move.l     d7,12(a5)
[00007b54] 2b6e 0010 0008            move.l     16(a6),8(a5)
[00007b5a] 1b6e 0017 0014            move.b     23(a6),20(a5)
[00007b60] 1b6e 001b 0015            move.b     27(a6),21(a5)
[00007b66] 426d 0012                 clr.w      18(a5)
[00007b6a] 2e0d                      move.l     a5,d7
[00007b6c] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00007b70] 4e5e                      unlk       a6
[00007b72] 4e75                      rts

_bytes:
[00007b74] 4e56 fff2                 link       a6,#-14
[00007b78] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00007b7c] 2a6e 0008                 movea.l    8(a6),a5
[00007b80] 1d6d 0008 fff3            move.b     8(a5),-13(a6)
[00007b86] 42ae fffc                 clr.l      -4(a6)
[00007b8a] 42ae fff4                 clr.l      -12(a6)
[00007b8e] 4287                      clr.l      d7
[00007b90] 1e2e fff3                 move.b     -13(a6),d7
[00007b94] 0c47 0050                 cmpi.w     #$0050,d7
[00007b98] 660a                      bne.s      _bytes_1
[00007b9a] 2d7c 0002 1621 fff4       move.l     #$00021621,-12(a6)
[00007ba2] 6042                      bra.s      _bytes_2
_bytes_1:
[00007ba4] 4287                      clr.l      d7
[00007ba6] 1e2e fff3                 move.b     -13(a6),d7
[00007baa] 2e87                      move.l     d7,(a7)
[00007bac] 2f3c 0002 14e6            move.l     #_typtab,-(a7)
[00007bb2] 4eb9 0000 a7a6            jsr        _scnstr
[00007bb8] 588f                      addq.l     #4,a7
[00007bba] 2447                      movea.l    d7,a2
[00007bbc] d5fc 0002 1505            adda.l     #_bytab,a2
[00007bc2] 1a12                      move.b     (a2),d5
[00007bc4] 4885                      ext.w      d5
[00007bc6] 48c5                      ext.l      d5
[00007bc8] 6f06                      ble.s      _bytes_3
[00007bca] 2d45 fffc                 move.l     d5,-4(a6)
[00007bce] 6016                      bra.s      _bytes_2
_bytes_3:
[00007bd0] 4a85                      tst.l      d5
[00007bd2] 6c34                      bge.s      _bytes_4
[00007bd4] 4ab9 0002 0b7e            tst.l      _lflag
[00007bda] 6704                      beq.s      _bytes_5
[00007bdc] 7e04                      moveq.l    #4,d7
[00007bde] 6002                      bra.s      _bytes_6
_bytes_5:
[00007be0] 7e02                      moveq.l    #2,d7
_bytes_6:
[00007be2] 2d47 fffc                 move.l     d7,-4(a6)
_bytes_2:
[00007be6] 4ab9 0002 0b7e            tst.l      _lflag
[00007bec] 6600 0130                 bne        _bytes_7
[00007bf0] 0cae 0000 ffff fffc       cmpi.l     #$0000FFFF,-4(a6)
[00007bf8] 6f00 0124                 ble        _bytes_7
[00007bfc] 2d7c 0002 15c6 fff4       move.l     #$000215C6,-12(a6)
[00007c04] 6000 0118                 bra        _bytes_7
_bytes_4:
[00007c08] 4287                      clr.l      d7
[00007c0a] 1e2e fff3                 move.b     -13(a6),d7
[00007c0e] 41f9 0002 159e            lea.l      $0002159E,a0
[00007c14] 4ef9 0000 a7dc            jmp        a.switch
[00007c1a] 4ab9 0002 0b7e            tst.l      _lflag
[00007c20] 660c                      bne.s      _bytes_8
[00007c22] 4287                      clr.l      d7
[00007c24] 3e2d 000a                 move.w     10(a5),d7
[00007c28] 0807 000b                 btst       #11,d7
[00007c2c] 6704                      beq.s      _bytes_9
_bytes_8:
[00007c2e] 7e04                      moveq.l    #4,d7
[00007c30] 6002                      bra.s      _bytes_10
_bytes_9:
[00007c32] 7e02                      moveq.l    #2,d7
_bytes_10:
[00007c34] 2d47 fffc                 move.l     d7,-4(a6)
[00007c38] 60ac                      bra.s      _bytes_2
[00007c3a] 60aa                      bra.s      _bytes_2
[00007c3c] 4aad 000a                 tst.l      10(a5)
[00007c40] 6608                      bne.s      _bytes_11
[00007c42] 2d7c 0002 160e fff4       move.l     #$0002160E,-12(a6)
_bytes_11:
[00007c4a] 2eae 000c                 move.l     12(a6),(a7)
[00007c4e] 2f2d 0004                 move.l     4(a5),-(a7)
[00007c52] 4eba ff20                 jsr        _bytes(pc)
[00007c56] 588f                      addq.l     #4,a7
[00007c58] 2e87                      move.l     d7,(a7)
[00007c5a] 2f2d 000a                 move.l     10(a5),-(a7)
[00007c5e] 4eb9 0000 ade4            jsr        a.lmul
[00007c64] 2d57 fffc                 move.l     (a7),-4(a6)
[00007c68] 6000 ff7c                 bra        _bytes_2
[00007c6c] 246d 000a                 movea.l    10(a5),a2
[00007c70] 508a                      addq.l     #8,a2
[00007c72] 2852                      movea.l    (a2),a4
[00007c74] 2e0c                      move.l     a4,d7
[00007c76] 660c                      bne.s      _bytes_12
[00007c78] 2d7c 0002 15f7 fff4       move.l     #$000215F7,-12(a6)
[00007c80] 6000 ff64                 bra        _bytes_2
_bytes_12:
[00007c84] 4a94                      tst.l      (a4)
[00007c86] 6704                      beq.s      _bytes_13
[00007c88] 2854                      movea.l    (a4),a4
[00007c8a] 60f8                      bra.s      _bytes_12
_bytes_13:
[00007c8c] 2eae 000c                 move.l     12(a6),(a7)
[00007c90] 2f2c 0004                 move.l     4(a4),-(a7)
[00007c94] 4eba fede                 jsr        _bytes(pc)
[00007c98] 588f                      addq.l     #4,a7
[00007c9a] deac 0008                 add.l      8(a4),d7
[00007c9e] 2e87                      move.l     d7,(a7)
[00007ca0] 2f0d                      move.l     a5,-(a7)
[00007ca2] 4eba fbd0                 jsr        _bndify(pc)
[00007ca6] 588f                      addq.l     #4,a7
[00007ca8] 2d47 fffc                 move.l     d7,-4(a6)
[00007cac] 6000 ff38                 bra        _bytes_2
[00007cb0] 246d 000a                 movea.l    10(a5),a2
[00007cb4] 508a                      addq.l     #8,a2
[00007cb6] 2852                      movea.l    (a2),a4
[00007cb8] 2e0c                      move.l     a4,d7
[00007cba] 660c                      bne.s      _bytes_14
[00007cbc] 2d7c 0002 15e4 fff4       move.l     #$000215E4,-12(a6)
[00007cc4] 6000 ff20                 bra        _bytes_2
_bytes_14:
[00007cc8] 42ae fffc                 clr.l      -4(a6)
_bytes_18:
[00007ccc] 2e0c                      move.l     a4,d7
[00007cce] 672e                      beq.s      _bytes_15
[00007cd0] 2eae 000c                 move.l     12(a6),(a7)
[00007cd4] 2f2c 0004                 move.l     4(a4),-(a7)
[00007cd8] 4eba fe9a                 jsr        _bytes(pc)
[00007cdc] 588f                      addq.l     #4,a7
[00007cde] 2d47 fff8                 move.l     d7,-8(a6)
[00007ce2] 2e2e fffc                 move.l     -4(a6),d7
[00007ce6] beae fff8                 cmp.l      -8(a6),d7
[00007cea] 6c06                      bge.s      _bytes_16
[00007cec] 2e2e fff8                 move.l     -8(a6),d7
[00007cf0] 6004                      bra.s      _bytes_17
_bytes_16:
[00007cf2] 2e2e fffc                 move.l     -4(a6),d7
_bytes_17:
[00007cf6] 2d47 fffc                 move.l     d7,-4(a6)
[00007cfa] 2854                      movea.l    (a4),a4
[00007cfc] 60ce                      bra.s      _bytes_18
_bytes_15:
[00007cfe] 2eae fffc                 move.l     -4(a6),(a7)
[00007d02] 2f0d                      move.l     a5,-(a7)
[00007d04] 4eba fb6e                 jsr        _bndify(pc)
[00007d08] 588f                      addq.l     #4,a7
[00007d0a] 2d47 fffc                 move.l     d7,-4(a6)
[00007d0e] 6000 fed6                 bra        _bytes_2
[00007d12] 2d7c 0002 15d5 fff4       move.l     #$000215D5,-12(a6)
[00007d1a] 6000 feca                 bra        _bytes_2
_bytes_7:
[00007d1e] 4aae 000c                 tst.l      12(a6)
[00007d22] 6710                      beq.s      _bytes_19
[00007d24] 4aae fff4                 tst.l      -12(a6)
[00007d28] 670a                      beq.s      _bytes_19
[00007d2a] 2eae fff4                 move.l     -12(a6),(a7)
[00007d2e] 4eb9 0000 3e84            jsr        _p1error
_bytes_19:
[00007d34] 2e2e fffc                 move.l     -4(a6),d7
[00007d38] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00007d3c] 4e5e                      unlk       a6
[00007d3e] 4e75                      rts

_cmptype:
[00007d40] 4e56 fffc                 link       a6,#-4
[00007d44] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00007d48] 2a6e 0008                 movea.l    8(a6),a5
[00007d4c] 286e 000c                 movea.l    12(a6),a4
_cmptype_7:
[00007d50] 2e0d                      move.l     a5,d7
[00007d52] 6716                      beq.s      _cmptype_1
[00007d54] 2e0c                      move.l     a4,d7
[00007d56] 6728                      beq.s      _cmptype_2
[00007d58] 4287                      clr.l      d7
[00007d5a] 1e2d 0008                 move.b     8(a5),d7
[00007d5e] 4286                      clr.l      d6
[00007d60] 1c2c 0008                 move.b     8(a4),d6
[00007d64] be86                      cmp.l      d6,d7
[00007d66] 6722                      beq.s      _cmptype_3
[00007d68] 6016                      bra.s      _cmptype_2
_cmptype_1:
[00007d6a] 2e0c                      move.l     a4,d7
[00007d6c] 6704                      beq.s      _cmptype_4
[00007d6e] 4287                      clr.l      d7
[00007d70] 6002                      bra.s      _cmptype_5
_cmptype_4:
[00007d72] 7e01                      moveq.l    #1,d7
_cmptype_5:
[00007d74] 600c                      bra.s      _cmptype_6
_cmptype_8:
[00007d76] 2a6d 0004                 movea.l    4(a5),a5
[00007d7a] 286c 0004                 movea.l    4(a4),a4
[00007d7e] 60d0                      bra.s      _cmptype_7
_cmptype_2:
[00007d80] 4287                      clr.l      d7
_cmptype_6:
[00007d82] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00007d86] 4e5e                      unlk       a6
[00007d88] 4e75                      rts
_cmptype_3:
[00007d8a] 4287                      clr.l      d7
[00007d8c] 1e2d 0008                 move.b     8(a5),d7
[00007d90] 41f9 0002 162e            lea.l      $0002162E,a0
[00007d96] 4ef9 0000 a7dc            jmp        a.switch
[00007d9c] 4287                      clr.l      d7
[00007d9e] 3e2d 000a                 move.w     10(a5),d7
[00007da2] 0287 0000 0fff            andi.l     #$00000FFF,d7
[00007da8] 4286                      clr.l      d6
[00007daa] 3c2c 000a                 move.w     10(a4),d6
[00007dae] 0286 0000 0fff            andi.l     #$00000FFF,d6
[00007db4] be86                      cmp.l      d6,d7
[00007db6] 67be                      beq.s      _cmptype_8
[00007db8] 4aae 0010                 tst.l      16(a6)
[00007dbc] 66b8                      bne.s      _cmptype_8
[00007dbe] 4287                      clr.l      d7
[00007dc0] 60c0                      bra.s      _cmptype_6
[00007dc2] 60b2                      bra.s      _cmptype_8
[00007dc4] 4aad 000a                 tst.l      10(a5)
[00007dc8] 67ac                      beq.s      _cmptype_8
[00007dca] 4aac 000a                 tst.l      10(a4)
[00007dce] 67a6                      beq.s      _cmptype_8
[00007dd0] 2e2d 000a                 move.l     10(a5),d7
[00007dd4] beac 000a                 cmp.l      10(a4),d7
[00007dd8] 679c                      beq.s      _cmptype_8
[00007dda] 4287                      clr.l      d7
[00007ddc] 60a4                      bra.s      _cmptype_6
[00007dde] 2e2d 000a                 move.l     10(a5),d7
[00007de2] beac 000a                 cmp.l      10(a4),d7
[00007de6] 660c                      bne.s      _cmptype_9
[00007de8] 2e2d 000a                 move.l     10(a5),d7
[00007dec] 0c87 0002 0cf2            cmpi.l     #_badsym,d7
[00007df2] 6682                      bne.s      _cmptype_8
_cmptype_9:
[00007df4] 4287                      clr.l      d7
[00007df6] 6040                      bra.s      _cmptype_10
[00007df8] 4aad 000e                 tst.l      14(a5)
[00007dfc] 6700 ff78                 beq        _cmptype_8
[00007e00] 4aac 000e                 tst.l      14(a4)
[00007e04] 6700 ff70                 beq        _cmptype_8
[00007e08] 266d 000e                 movea.l    14(a5),a3
[00007e0c] 2d6c 000e fffc            move.l     14(a4),-4(a6)
_cmptype_14:
[00007e12] 2e0b                      move.l     a3,d7
[00007e14] 672a                      beq.s      _cmptype_11
[00007e16] 4aae fffc                 tst.l      -4(a6)
[00007e1a] 6724                      beq.s      _cmptype_11
[00007e1c] 2eae 0010                 move.l     16(a6),(a7)
[00007e20] 246e fffc                 movea.l    -4(a6),a2
[00007e24] 588a                      addq.l     #4,a2
[00007e26] 2f12                      move.l     (a2),-(a7)
[00007e28] 2f2b 0004                 move.l     4(a3),-(a7)
[00007e2c] 4eba ff12                 jsr        _cmptype(pc)
[00007e30] 508f                      addq.l     #8,a7
[00007e32] 4a87                      tst.l      d7
[00007e34] 6618                      bne.s      _cmptype_12
[00007e36] 4287                      clr.l      d7
_cmptype_10:
[00007e38] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00007e3c] 4e5e                      unlk       a6
[00007e3e] 4e75                      rts
_cmptype_11:
[00007e40] 4aae fffc                 tst.l      -4(a6)
[00007e44] 6614                      bne.s      _cmptype_13
[00007e46] 2e0b                      move.l     a3,d7
[00007e48] 6700 ff2c                 beq        _cmptype_8
[00007e4c] 600c                      bra.s      _cmptype_13
_cmptype_12:
[00007e4e] 2653                      movea.l    (a3),a3
[00007e50] 246e fffc                 movea.l    -4(a6),a2
[00007e54] 2d52 fffc                 move.l     (a2),-4(a6)
[00007e58] 60b8                      bra.s      _cmptype_14
_cmptype_13:
[00007e5a] 4287                      clr.l      d7
[00007e5c] 60da                      bra.s      _cmptype_10

_clrsym:
[00007e5e] 4e56 0000                 link       a6,#0
[00007e62] 48e7 8004                 movem.l    d0/a5,-(a7)
[00007e66] 2a6e 0008                 movea.l    8(a6),a5
[00007e6a] 4295                      clr.l      (a5)
[00007e6c] 42ad 0004                 clr.l      4(a5)
[00007e70] 42ad 0008                 clr.l      8(a5)
[00007e74] 426d 000c                 clr.w      12(a5)
[00007e78] 422d 000e                 clr.b      14(a5)
[00007e7c] 422d 000f                 clr.b      15(a5)
[00007e80] 422d 0010                 clr.b      16(a5)
[00007e84] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00007e88] 4e5e                      unlk       a6
[00007e8a] 4e75                      rts

_cpyats:
[00007e8c] 4e56 fff8                 link       a6,#-8
[00007e90] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00007e94] 2a6e 0008                 movea.l    8(a6),a5
_cpyats_6:
[00007e98] 2855                      movea.l    (a5),a4
[00007e9a] 2e0c                      move.l     a4,d7
[00007e9c] 671e                      beq.s      _cpyats_1
[00007e9e] b9ee 000c                 cmpa.l     12(a6),a4
[00007ea2] 6718                      beq.s      _cpyats_1
[00007ea4] 4aac 0004                 tst.l      4(a4)
[00007ea8] 6712                      beq.s      _cpyats_1
[00007eaa] 2679 0002 0cee            movea.l    _gblat,a3
_cpyats_3:
[00007eb0] 2e0b                      move.l     a3,d7
[00007eb2] 6710                      beq.s      _cpyats_2
[00007eb4] b7cc                      cmpa.l     a4,a3
[00007eb6] 670c                      beq.s      _cpyats_2
[00007eb8] 2653                      movea.l    (a3),a3
[00007eba] 60f4                      bra.s      _cpyats_3
_cpyats_1:
[00007ebc] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00007ec0] 4e5e                      unlk       a6
[00007ec2] 4e75                      rts
_cpyats_2:
[00007ec4] 2e0b                      move.l     a3,d7
[00007ec6] 66f4                      bne.s      _cpyats_1
[00007ec8] 2d79 0002 0cea fffc       move.l     _attlist,-4(a6)
[00007ed0] 2479 0002 0cee            movea.l    _gblat,a2
[00007ed6] 23d2 0002 0cea            move.l     (a2),_attlist
[00007edc] 2e8c                      move.l     a4,(a7)
[00007ede] 4eb9 0000 7f58            jsr        _cpyattr
[00007ee4] 2a87                      move.l     d7,(a5)
[00007ee6] 2479 0002 0cee            movea.l    _gblat,a2
[00007eec] 24b9 0002 0cea            move.l     _attlist,(a2)
[00007ef2] 23ee fffc 0002 0cea       move.l     -4(a6),_attlist
[00007efa] 4287                      clr.l      d7
[00007efc] 1e2c 0008                 move.b     8(a4),d7
[00007f00] 0c47 0048                 cmpi.w     #$0048,d7
[00007f04] 670c                      beq.s      _cpyats_4
[00007f06] 4287                      clr.l      d7
[00007f08] 1e2c 0008                 move.b     8(a4),d7
[00007f0c] 0c47 0049                 cmpi.w     #$0049,d7
[00007f10] 6616                      bne.s      _cpyats_5
_cpyats_4:
[00007f12] 45f8 000a                 lea.l      ($0000000A).w,a2
[00007f16] d5d5                      adda.l     (a5),a2
[00007f18] 24bc 0002 0cf2            move.l     #_badsym,(a2)
_cpyats_7:
[00007f1e] 2e15                      move.l     (a5),d7
[00007f20] 5887                      addq.l     #4,d7
[00007f22] 2a47                      movea.l    d7,a5
[00007f24] 6000 ff72                 bra        _cpyats_6
_cpyats_5:
[00007f28] 4287                      clr.l      d7
[00007f2a] 1e2c 0008                 move.b     8(a4),d7
[00007f2e] 0c47 0042                 cmpi.w     #$0042,d7
[00007f32] 66ea                      bne.s      _cpyats_7
[00007f34] 2d6c 000e fff8            move.l     14(a4),-8(a6)
_cpyats_8:
[00007f3a] 4aae fff8                 tst.l      -8(a6)
[00007f3e] 67de                      beq.s      _cpyats_7
[00007f40] 4297                      clr.l      (a7)
[00007f42] 2f2e fff8                 move.l     -8(a6),-(a7)
[00007f46] 5897                      addq.l     #4,(a7)
[00007f48] 4eba ff42                 jsr        _cpyats(pc)
[00007f4c] 588f                      addq.l     #4,a7
[00007f4e] 246e fff8                 movea.l    -8(a6),a2
[00007f52] 2d52 fff8                 move.l     (a2),-8(a6)
[00007f56] 60e2                      bra.s      _cpyats_8

_cpyattr:
[00007f58] 4e56 0000                 link       a6,#0
[00007f5c] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00007f60] 2a6e 0008                 movea.l    8(a6),a5
[00007f64] 2ead 0004                 move.l     4(a5),(a7)
[00007f68] 4287                      clr.l      d7
[00007f6a] 1e2d 0008                 move.b     8(a5),d7
[00007f6e] 2f07                      move.l     d7,-(a7)
[00007f70] 4eba fa38                 jsr        _buyattr(pc)
[00007f74] 588f                      addq.l     #4,a7
[00007f76] 2847                      movea.l    d7,a4
[00007f78] 4878 0008                 pea.l      ($00000008).w
[00007f7c] 486d 000a                 pea.l      10(a5)
[00007f80] 486c 000a                 pea.l      10(a4)
[00007f84] 4eb9 0000 adac            jsr        _cpybuf
[00007f8a] 4fef 000c                 lea.l      12(a7),a7
[00007f8e] 2e0c                      move.l     a4,d7
[00007f90] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00007f94] 4e5e                      unlk       a6
[00007f96] 4e75                      rts

_deadname:
[00007f98] 4e56 0000                 link       a6,#0
[00007f9c] 246e 0008                 movea.l    8(a6),a2
[00007fa0] 4a12                      tst.b      (a2)
[00007fa2] 672c                      beq.s      _deadname_1
[00007fa4] 246e 0008                 movea.l    8(a6),a2
[00007fa8] 4287                      clr.l      d7
[00007faa] 1e12                      move.b     (a2),d7
[00007fac] 0c47 0005                 cmpi.w     #$0005,d7
[00007fb0] 6522                      bcs.s      _deadname_2
[00007fb2] 4878 0005                 pea.l      ($00000005).w
[00007fb6] 2f3c 0002 165e            move.l     #$0002165E,-(a7)
[00007fbc] 2f2e 0008                 move.l     8(a6),-(a7)
[00007fc0] 5297                      addq.l     #1,(a7)
[00007fc2] 4eb9 0000 ad76            jsr        _cmpbuf
[00007fc8] 4fef 000c                 lea.l      12(a7),a7
[00007fcc] 4a87                      tst.l      d7
[00007fce] 6704                      beq.s      _deadname_2
_deadname_1:
[00007fd0] 7e01                      moveq.l    #1,d7
[00007fd2] 6002                      bra.s      _deadname_3
_deadname_2:
[00007fd4] 4287                      clr.l      d7
_deadname_3:
[00007fd6] 4e5e                      unlk       a6
[00007fd8] 4e75                      rts

_dlit:
[00007fda] 4e56 0000                 link       a6,#0
[00007fde] 48e7 8004                 movem.l    d0/a5,-(a7)
[00007fe2] 2a6e 0008                 movea.l    8(a6),a5
[00007fe6] 246d 0004                 movea.l    4(a5),a2
[00007fea] 508a                      addq.l     #8,a2
[00007fec] 4287                      clr.l      d7
[00007fee] 1e12                      move.b     (a2),d7
[00007ff0] 0c47 0029                 cmpi.w     #$0029,d7
[00007ff4] 6616                      bne.s      _dlit_1
[00007ff6] 4a2d 0016                 tst.b      22(a5)
[00007ffa] 6610                      bne.s      _dlit_1
[00007ffc] 4a2d 0015                 tst.b      21(a5)
[00008000] 660a                      bne.s      _dlit_1
[00008002] 4a2d 0014                 tst.b      20(a5)
[00008006] 6604                      bne.s      _dlit_1
[00008008] 7e01                      moveq.l    #1,d7
[0000800a] 6002                      bra.s      _dlit_2
_dlit_1:
[0000800c] 4287                      clr.l      d7
_dlit_2:
[0000800e] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00008012] 4e5e                      unlk       a6
[00008014] 4e75                      rts

_dnegate:
[00008016] 4e56 fff8                 link       a6,#-8
[0000801a] 4878 0008                 pea.l      ($00000008).w
[0000801e] 2f2e 0008                 move.l     8(a6),-(a7)
[00008022] 486e fff8                 pea.l      -8(a6)
[00008026] 4eb9 0000 adac            jsr        _cpybuf
[0000802c] 4fef 000c                 lea.l      12(a7),a7
[00008030] 2c2e fff8                 move.l     -8(a6),d6
[00008034] 2e2e fffc                 move.l     -4(a6),d7
[00008038] 4a86                      tst.l      d6
[0000803a] 6704                      beq.s      _dnegate_1
[0000803c] 0846 001f                 bchg       #31,d6
_dnegate_1:
[00008040] 2d46 fff8                 move.l     d6,-8(a6)
[00008044] 2d47 fffc                 move.l     d7,-4(a6)
[00008048] 4878 0008                 pea.l      ($00000008).w
[0000804c] 486e fff8                 pea.l      -8(a6)
[00008050] 2f2e 0008                 move.l     8(a6),-(a7)
[00008054] 4eb9 0000 adac            jsr        _cpybuf
[0000805a] 4fef 000c                 lea.l      12(a7),a7
[0000805e] 4e5e                      unlk       a6
[00008060] 4e75                      rts

_dtype:
[00008062] 4e56 0000                 link       a6,#0
[00008066] 48e7 8004                 movem.l    d0/a5,-(a7)
[0000806a] 2a6e 0008                 movea.l    8(a6),a5
[0000806e] 4287                      clr.l      d7
[00008070] 1e2d 0008                 move.b     8(a5),d7
[00008074] 0c47 0029                 cmpi.w     #$0029,d7
[00008078] 6718                      beq.s      _dtype_1
[0000807a] 4287                      clr.l      d7
[0000807c] 1e2d 0008                 move.b     8(a5),d7
[00008080] 0c47 0028                 cmpi.w     #$0028,d7
[00008084] 670c                      beq.s      _dtype_1
[00008086] 4287                      clr.l      d7
[00008088] 1e2d 0008                 move.b     8(a5),d7
[0000808c] 0c47 002a                 cmpi.w     #$002A,d7
[00008090] 6604                      bne.s      _dtype_2
_dtype_1:
[00008092] 7e01                      moveq.l    #1,d7
[00008094] 6002                      bra.s      _dtype_3
_dtype_2:
[00008096] 4287                      clr.l      d7
_dtype_3:
[00008098] 4cdf 2001                 movem.l    (a7)+,d0/a5
[0000809c] 4e5e                      unlk       a6
[0000809e] 4e75                      rts

_exchk:
[000080a0] 4e56 0000                 link       a6,#0
[000080a4] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000080a8] 2a6e 0008                 movea.l    8(a6),a5
[000080ac] 0cb9 0000 007f 0002 0ba6  cmpi.l     #$0000007F,_nlen
[000080b6] 6508                      bcs.s      _exchk_1
[000080b8] 4ab9 0002 0b6a            tst.l      _cflag
[000080be] 672e                      beq.s      _exchk_2
_exchk_1:
[000080c0] 284d                      movea.l    a5,a4
_exchk_4:
[000080c2] 2854                      movea.l    (a4),a4
[000080c4] 2e0c                      move.l     a4,d7
[000080c6] 6726                      beq.s      _exchk_2
[000080c8] 4287                      clr.l      d7
[000080ca] 1e2c 000e                 move.b     14(a4),d7
[000080ce] 0c47 002a                 cmpi.w     #$002A,d7
[000080d2] 6722                      beq.s      _exchk_3
[000080d4] 4287                      clr.l      d7
[000080d6] 1e2c 000e                 move.b     14(a4),d7
[000080da] 0c47 003e                 cmpi.w     #$003E,d7
[000080de] 6716                      beq.s      _exchk_3
[000080e0] 4287                      clr.l      d7
[000080e2] 1e2c 000e                 move.b     14(a4),d7
[000080e6] 0c47 003c                 cmpi.w     #$003C,d7
[000080ea] 66d6                      bne.s      _exchk_4
[000080ec] 6008                      bra.s      _exchk_3
_exchk_2:
[000080ee] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000080f2] 4e5e                      unlk       a6
[000080f4] 4e75                      rts
_exchk_3:
[000080f6] 2e8c                      move.l     a4,(a7)
[000080f8] 2f0d                      move.l     a5,-(a7)
[000080fa] 4eb9 0000 811a            jsr        _exmatch
[00008100] 588f                      addq.l     #4,a7
[00008102] 4a87                      tst.l      d7
[00008104] 67bc                      beq.s      _exchk_4
[00008106] 486d 0010                 pea.l      16(a5)
[0000810a] 2f3c 0002 1664            move.l     #$00021664,-(a7) "external name conflict"
[00008110] 4eb9 0000 3c8a            jsr        _nmerr
[00008116] 508f                      addq.l     #8,a7
[00008118] 60d4                      bra.s      _exchk_2

_exmatch:
[0000811a] 4e56 0000                 link       a6,#0
[0000811e] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00008122] 0cb9 0000 007f 0002 0ba6  cmpi.l     #$0000007F,_nlen
[0000812c] 6408                      bcc.s      _exmatch_1
[0000812e] 2e39 0002 0ba6            move.l     _nlen,d7
[00008134] 6002                      bra.s      _exmatch_2
_exmatch_1:
[00008136] 7e7f                      moveq.l    #127,d7
_exmatch_2:
[00008138] 2a07                      move.l     d7,d5
[0000813a] 7e11                      moveq.l    #17,d7
[0000813c] deae 0008                 add.l      8(a6),d7
[00008140] 2a47                      movea.l    d7,a5
[00008142] 7e11                      moveq.l    #17,d7
[00008144] deae 000c                 add.l      12(a6),d7
[00008148] 2847                      movea.l    d7,a4
_exmatch_11:
[0000814a] 5385                      subq.l     #1,d5
[0000814c] 6d52                      blt.s      _exmatch_3
[0000814e] 4ab9 0002 0b6a            tst.l      _cflag
[00008154] 6762                      beq.s      _exmatch_4
[00008156] 4287                      clr.l      d7
[00008158] 1e14                      move.b     (a4),d7
[0000815a] 0c47 0041                 cmpi.w     #$0041,d7
[0000815e] 6514                      bcs.s      _exmatch_5
[00008160] 4287                      clr.l      d7
[00008162] 1e14                      move.b     (a4),d7
[00008164] 0c47 005a                 cmpi.w     #$005A,d7
[00008168] 620a                      bhi.s      _exmatch_5
[0000816a] 7e20                      moveq.l    #32,d7
[0000816c] 4286                      clr.l      d6
[0000816e] 1c14                      move.b     (a4),d6
[00008170] de86                      add.l      d6,d7
[00008172] 6004                      bra.s      _exmatch_6
_exmatch_5:
[00008174] 4287                      clr.l      d7
[00008176] 1e14                      move.b     (a4),d7
_exmatch_6:
[00008178] 2e87                      move.l     d7,(a7)
[0000817a] 4287                      clr.l      d7
[0000817c] 1e15                      move.b     (a5),d7
[0000817e] 0c47 0041                 cmpi.w     #$0041,d7
[00008182] 6514                      bcs.s      _exmatch_7
[00008184] 4287                      clr.l      d7
[00008186] 1e15                      move.b     (a5),d7
[00008188] 0c47 005a                 cmpi.w     #$005A,d7
[0000818c] 620a                      bhi.s      _exmatch_7
[0000818e] 7e20                      moveq.l    #32,d7
[00008190] 4286                      clr.l      d6
[00008192] 1c15                      move.b     (a5),d6
[00008194] de86                      add.l      d6,d7
[00008196] 6004                      bra.s      _exmatch_8
_exmatch_7:
[00008198] 4287                      clr.l      d7
[0000819a] 1e15                      move.b     (a5),d7
_exmatch_8:
[0000819c] be97                      cmp.l      (a7),d7
[0000819e] 6718                      beq.s      _exmatch_4
_exmatch_3:
[000081a0] 4a85                      tst.l      d5
[000081a2] 6c04                      bge.s      _exmatch_9
[000081a4] 7e01                      moveq.l    #1,d7
[000081a6] 6002                      bra.s      _exmatch_10
_exmatch_9:
[000081a8] 4287                      clr.l      d7
_exmatch_10:
[000081aa] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000081ae] 4e5e                      unlk       a6
[000081b0] 4e75                      rts
_exmatch_12:
[000081b2] 528d                      addq.l     #1,a5
[000081b4] 528c                      addq.l     #1,a4
[000081b6] 6092                      bra.s      _exmatch_11
_exmatch_4:
[000081b8] 4ab9 0002 0b6a            tst.l      _cflag
[000081be] 66f2                      bne.s      _exmatch_12
[000081c0] 4287                      clr.l      d7
[000081c2] 1e15                      move.b     (a5),d7
[000081c4] 4286                      clr.l      d6
[000081c6] 1c14                      move.b     (a4),d6
[000081c8] be86                      cmp.l      d6,d7
[000081ca] 67e6                      beq.s      _exmatch_12
[000081cc] 60d2                      bra.s      _exmatch_3

_exspace:
[000081ce] 4e56 0000                 link       a6,#0
[000081d2] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000081d6] 2a6e 0008                 movea.l    8(a6),a5
[000081da] 4a2d 0016                 tst.b      22(a5)
[000081de] 6608                      bne.s      _exspace_1
[000081e0] 4287                      clr.l      d7
[000081e2] 3e2d 0012                 move.w     18(a5),d7
[000081e6] 6020                      bra.s      _exspace_2
_exspace_1:
[000081e8] 4287                      clr.l      d7
[000081ea] 1e2d 0016                 move.b     22(a5),d7
[000081ee] 0c47 006b                 cmpi.w     #$006B,d7
[000081f2] 6612                      bne.s      _exspace_3
[000081f4] 45f8 000a                 lea.l      ($0000000A).w,a2
[000081f8] 286d 0008                 movea.l    8(a5),a4
[000081fc] 588c                      addq.l     #4,a4
[000081fe] d5d4                      adda.l     (a4),a2
[00008200] 4287                      clr.l      d7
[00008202] 3e12                      move.w     (a2),d7
[00008204] 6002                      bra.s      _exspace_2
_exspace_3:
[00008206] 4287                      clr.l      d7
_exspace_2:
[00008208] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[0000820c] 4e5e                      unlk       a6
[0000820e] 4e75                      rts

_fixargs:
[00008210] 4e56 0000                 link       a6,#0
[00008214] 48e7 8004                 movem.l    d0/a5,-(a7)
[00008218] 2a6e 0008                 movea.l    8(a6),a5
[0000821c] 2e0d                      move.l     a5,d7
[0000821e] 6700 0108                 beq        _fixargs_1
[00008222] 246d 0004                 movea.l    4(a5),a2
[00008226] 508a                      addq.l     #8,a2
[00008228] 4287                      clr.l      d7
[0000822a] 1e12                      move.b     (a2),d7
[0000822c] 0c47 0042                 cmpi.w     #$0042,d7
[00008230] 6656                      bne.s      _fixargs_2
[00008232] 2ead 0004                 move.l     4(a5),(a7)
[00008236] 4878 0040                 pea.l      ($00000040).w
[0000823a] 4eba f76e                 jsr        _buyattr(pc)
[0000823e] 588f                      addq.l     #4,a7
[00008240] 2b47 0004                 move.l     d7,4(a5)
[00008244] 45f8 000a                 lea.l      ($0000000A).w,a2
[00008248] d5ed 0004                 adda.l     4(a5),a2
[0000824c] 2e8a                      move.l     a2,(a7)
[0000824e] 4a6d 000c                 tst.w      12(a5)
[00008252] 6708                      beq.s      _fixargs_3
[00008254] 4287                      clr.l      d7
[00008256] 3e2d 000c                 move.w     12(a5),d7
[0000825a] 6010                      bra.s      _fixargs_4
_fixargs_3:
[0000825c] 4878 0042                 pea.l      ($00000042).w
[00008260] 4878 003b                 pea.l      ($0000003B).w
[00008264] 4eb9 0000 3252            jsr        _defspace
[0000826a] 508f                      addq.l     #8,a7
_fixargs_4:
[0000826c] 2257                      movea.l    (a7),a1
[0000826e] 3287                      move.w     d7,(a1)
[00008270] 4878 0040                 pea.l      ($00000040).w
[00008274] 4878 003b                 pea.l      ($0000003B).w
[00008278] 4eb9 0000 3252            jsr        _defspace
[0000827e] 508f                      addq.l     #8,a7
[00008280] 3b47 000c                 move.w     d7,12(a5)
[00008284] 6000 00a2                 bra        _fixargs_1
_fixargs_2:
[00008288] 246d 0004                 movea.l    4(a5),a2
[0000828c] 508a                      addq.l     #8,a2
[0000828e] 4287                      clr.l      d7
[00008290] 1e12                      move.b     (a2),d7
[00008292] 0c47 0041                 cmpi.w     #$0041,d7
[00008296] 6658                      bne.s      _fixargs_5
[00008298] 246d 0004                 movea.l    4(a5),a2
[0000829c] 588a                      addq.l     #4,a2
[0000829e] 2e92                      move.l     (a2),(a7)
[000082a0] 4878 0040                 pea.l      ($00000040).w
[000082a4] 4eba f704                 jsr        _buyattr(pc)
[000082a8] 588f                      addq.l     #4,a7
[000082aa] 2b47 0004                 move.l     d7,4(a5)
[000082ae] 45f8 000a                 lea.l      ($0000000A).w,a2
[000082b2] d5ed 0004                 adda.l     4(a5),a2
[000082b6] 2e8a                      move.l     a2,(a7)
[000082b8] 4a6d 000c                 tst.w      12(a5)
[000082bc] 6708                      beq.s      _fixargs_6
[000082be] 4287                      clr.l      d7
[000082c0] 3e2d 000c                 move.w     12(a5),d7
[000082c4] 6010                      bra.s      _fixargs_7
_fixargs_6:
[000082c6] 4878 0040                 pea.l      ($00000040).w
[000082ca] 4878 003b                 pea.l      ($0000003B).w
[000082ce] 4eb9 0000 3252            jsr        _defspace
[000082d4] 508f                      addq.l     #8,a7
_fixargs_7:
[000082d6] 2257                      movea.l    (a7),a1
[000082d8] 3287                      move.w     d7,(a1)
[000082da] 4878 0040                 pea.l      ($00000040).w
[000082de] 4878 003b                 pea.l      ($0000003B).w
[000082e2] 4eb9 0000 3252            jsr        _defspace
[000082e8] 508f                      addq.l     #8,a7
[000082ea] 3b47 000c                 move.w     d7,12(a5)
[000082ee] 6038                      bra.s      _fixargs_1
_fixargs_5:
[000082f0] 4aae 000c                 tst.l      12(a6)
[000082f4] 6624                      bne.s      _fixargs_8
[000082f6] 246d 0004                 movea.l    4(a5),a2
[000082fa] 508a                      addq.l     #8,a2
[000082fc] 4287                      clr.l      d7
[000082fe] 1e12                      move.b     (a2),d7
[00008300] 0c47 0050                 cmpi.w     #$0050,d7
[00008304] 6614                      bne.s      _fixargs_8
[00008306] 486d 0010                 pea.l      16(a5)
[0000830a] 2f3c 0002 167c            move.l     #$0002167C,-(a7) "illegal argument type"
[00008310] 4eb9 0000 3c8a            jsr        _nmerr
[00008316] 508f                      addq.l     #8,a7
[00008318] 600e                      bra.s      _fixargs_1
_fixargs_8:
[0000831a] 2ead 0004                 move.l     4(a5),(a7)
[0000831e] 4eb9 0000 84da            jsr        _maxify
[00008324] 2b47 0004                 move.l     d7,4(a5)
_fixargs_1:
[00008328] 2e0d                      move.l     a5,d7
[0000832a] 4cdf 2001                 movem.l    (a7)+,d0/a5
[0000832e] 4e5e                      unlk       a6
[00008330] 4e75                      rts

_frealst:
[00008332] 4e56 0000                 link       a6,#0
[00008336] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000833a] 2a6e 0008                 movea.l    8(a6),a5
[0000833e] 286e 000c                 movea.l    12(a6),a4
[00008342] 2e0d                      move.l     a5,d7
[00008344] 6714                      beq.s      _frealst_1
[00008346] bbcc                      cmpa.l     a4,a5
[00008348] 6710                      beq.s      _frealst_1
[0000834a] 264d                      movea.l    a5,a3
_frealst_3:
[0000834c] 4a93                      tst.l      (a3)
[0000834e] 6714                      beq.s      _frealst_2
[00008350] 2e13                      move.l     (a3),d7
[00008352] be8c                      cmp.l      a4,d7
[00008354] 670e                      beq.s      _frealst_2
[00008356] 2653                      movea.l    (a3),a3
[00008358] 60f2                      bra.s      _frealst_3
_frealst_1:
[0000835a] 2e0c                      move.l     a4,d7
[0000835c] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00008360] 4e5e                      unlk       a6
[00008362] 4e75                      rts
_frealst_2:
[00008364] 26b9 0002 14de            move.l     $000214DE,(a3)
[0000836a] 23cd 0002 14de            move.l     a5,$000214DE
[00008370] 60e8                      bra.s      _frealst_1

_fretlst:
[00008372] 4e56 0000                 link       a6,#0
[00008376] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000837a] 2a6e 0008                 movea.l    8(a6),a5
[0000837e] 286e 000c                 movea.l    12(a6),a4
[00008382] 4ab9 0002 02be            tst.l      _freeexpr
[00008388] 6604                      bne.s      _fretlst_1
[0000838a] 2e0d                      move.l     a5,d7
[0000838c] 6010                      bra.s      _fretlst_2
_fretlst_1:
[0000838e] 2e0d                      move.l     a5,d7
[00008390] 670a                      beq.s      _fretlst_3
[00008392] 264d                      movea.l    a5,a3
_fretlst_5:
[00008394] 4a93                      tst.l      (a3)
[00008396] 670e                      beq.s      _fretlst_4
[00008398] 2653                      movea.l    (a3),a3
[0000839a] 60f8                      bra.s      _fretlst_5
_fretlst_3:
[0000839c] 4287                      clr.l      d7
_fretlst_2:
[0000839e] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000083a2] 4e5e                      unlk       a6
[000083a4] 4e75                      rts
_fretlst_4:
[000083a6] 26b9 0002 14e2            move.l     $000214E2,(a3)
[000083ac] 23cd 0002 14e2            move.l     a5,$000214E2
[000083b2] 2e0c                      move.l     a4,d7
[000083b4] 60e8                      bra.s      _fretlst_2

_iscons:
[000083b6] 4e56 0000                 link       a6,#0
[000083ba] 48e7 8004                 movem.l    d0/a5,-(a7)
[000083be] 2a6e 0008                 movea.l    8(a6),a5
[000083c2] 4a2d 0016                 tst.b      22(a5)
[000083c6] 6628                      bne.s      _iscons_1
[000083c8] 2e8d                      move.l     a5,(a7)
[000083ca] 4eb9 0000 6e7a            jsr        _hasname
[000083d0] 4a87                      tst.l      d7
[000083d2] 661c                      bne.s      _iscons_1
[000083d4] 4a2d 0014                 tst.b      20(a5)
[000083d8] 6616                      bne.s      _iscons_1
[000083da] 4a2d 0015                 tst.b      21(a5)
[000083de] 6610                      bne.s      _iscons_1
[000083e0] 2ead 0004                 move.l     4(a5),(a7)
[000083e4] 4eba fc7c                 jsr        _dtype(pc)
[000083e8] 4a87                      tst.l      d7
[000083ea] 6604                      bne.s      _iscons_1
[000083ec] 7e01                      moveq.l    #1,d7
[000083ee] 6002                      bra.s      _iscons_2
_iscons_1:
[000083f0] 4287                      clr.l      d7
_iscons_2:
[000083f2] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000083f6] 4e5e                      unlk       a6
[000083f8] 4e75                      rts

_issigned:
[000083fa] 4e56 0000                 link       a6,#0
[000083fe] 48e7 8400                 movem.l    d0/d5,-(a7)
[00008402] 246e 0008                 movea.l    8(a6),a2
[00008406] 508a                      addq.l     #8,a2
[00008408] 4285                      clr.l      d5
[0000840a] 1a12                      move.b     (a2),d5
[0000840c] 0c85 0000 000a            cmpi.l     #$0000000A,d5
[00008412] 672c                      beq.s      _issigned_1
[00008414] 0c85 0000 0011            cmpi.l     #$00000011,d5
[0000841a] 6724                      beq.s      _issigned_1
[0000841c] 0c85 0000 0021            cmpi.l     #$00000021,d5
[00008422] 671c                      beq.s      _issigned_1
[00008424] 0c85 0000 001a            cmpi.l     #$0000001A,d5
[0000842a] 6714                      beq.s      _issigned_1
[0000842c] 4ab9 0002 0b9a            tst.l      _uflag
[00008432] 660c                      bne.s      _issigned_1
[00008434] 0c85 0000 0009            cmpi.l     #$00000009,d5
[0000843a] 6604                      bne.s      _issigned_1
[0000843c] 7e01                      moveq.l    #1,d7
[0000843e] 6002                      bra.s      _issigned_2
_issigned_1:
[00008440] 4287                      clr.l      d7
_issigned_2:
[00008442] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00008446] 4e5e                      unlk       a6
[00008448] 4e75                      rts

_itype:
[0000844a] 4e56 fffc                 link       a6,#-4
[0000844e] 246e 0008                 movea.l    8(a6),a2
[00008452] 508a                      addq.l     #8,a2
[00008454] 4287                      clr.l      d7
[00008456] 1e12                      move.b     (a2),d7
[00008458] 2e87                      move.l     d7,(a7)
[0000845a] 2f3c 0002 14e6            move.l     #_typtab,-(a7)
[00008460] 4eb9 0000 a7a6            jsr        _scnstr
[00008466] 588f                      addq.l     #4,a7
[00008468] 4286                      clr.l      d6
[0000846a] 1c39 0002 14f5            move.b     $000214F5,d6
[00008470] be86                      cmp.l      d6,d7
[00008472] 6e04                      bgt.s      _itype_1
[00008474] 7e01                      moveq.l    #1,d7
[00008476] 6002                      bra.s      _itype_2
_itype_1:
[00008478] 4287                      clr.l      d7
_itype_2:
[0000847a] 4e5e                      unlk       a6
[0000847c] 4e75                      rts

_lookup:
[0000847e] 4e56 fffe                 link       a6,#-2
[00008482] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00008486] 2a6e 000c                 movea.l    12(a6),a5
_lookup_5:
[0000848a] bbee 0010                 cmpa.l     16(a6),a5
[0000848e] 672c                      beq.s      _lookup_1
[00008490] 45ed 0010                 lea.l      16(a5),a2
[00008494] 284a                      movea.l    a2,a4
[00008496] 266e 0008                 movea.l    8(a6),a3
[0000849a] 246e 0008                 movea.l    8(a6),a2
[0000849e] 4287                      clr.l      d7
[000084a0] 1e12                      move.b     (a2),d7
[000084a2] 5287                      addq.l     #1,d7
[000084a4] 3d47 fffe                 move.w     d7,-2(a6)
_lookup_7:
[000084a8] 4a6e fffe                 tst.w      -2(a6)
[000084ac] 6f16                      ble.s      _lookup_2
[000084ae] 4287                      clr.l      d7
[000084b0] 1e1c                      move.b     (a4)+,d7
[000084b2] 4286                      clr.l      d6
[000084b4] 1c1b                      move.b     (a3)+,d6
[000084b6] be86                      cmp.l      d6,d7
[000084b8] 671a                      beq.s      _lookup_3
[000084ba] 6008                      bra.s      _lookup_2
_lookup_1:
[000084bc] 4287                      clr.l      d7
[000084be] 600c                      bra.s      _lookup_4
_lookup_6:
[000084c0] 2a55                      movea.l    (a5),a5
[000084c2] 60c6                      bra.s      _lookup_5
_lookup_2:
[000084c4] 4a6e fffe                 tst.w      -2(a6)
[000084c8] 66f6                      bne.s      _lookup_6
[000084ca] 2e0d                      move.l     a5,d7
_lookup_4:
[000084cc] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000084d0] 4e5e                      unlk       a6
[000084d2] 4e75                      rts
_lookup_3:
[000084d4] 536e fffe                 subq.w     #1,-2(a6)
[000084d8] 60ce                      bra.s      _lookup_7

_maxify:
[000084da] 4e56 0000                 link       a6,#0
[000084de] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[000084e2] 2a6e 0008                 movea.l    8(a6),a5
[000084e6] 4285                      clr.l      d5
[000084e8] 1a2d 0008                 move.b     8(a5),d5
[000084ec] 2e05                      move.l     d5,d7
[000084ee] 41f9 0002 1692            lea.l      $00021692,a0
[000084f4] 4ef9 0000 a7dc            jmp        a.switch
[000084fa] 2e3c 0002 0dc2            move.l     #_atint,d7
[00008500] 6016                      bra.s      _maxify_1
[00008502] 4ab9 0002 0b7e            tst.l      _lflag
[00008508] 6708                      beq.s      _maxify_2
[0000850a] 2e3c 0002 0dc2            move.l     #_atint,d7
[00008510] 6006                      bra.s      _maxify_1
_maxify_2:
[00008512] 2e3c 0002 0dd4            move.l     #_atunsign,d7
_maxify_1:
[00008518] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[0000851c] 4e5e                      unlk       a6
[0000851e] 4e75                      rts

x8520_1:
[00008520] 2e3c 0002 0dd4            move.l     #_atunsign,d7
[00008526] 60f0                      bra.s      x8520_1
[00008528] 2e3c 0002 0e1c            move.l     #_atdouble,d7
[0000852e] 60e8                      bra.s      x8520_1
[00008530] 2e0d                      move.l     a5,d7
[00008532] 60e4                      bra.s      x8520_1

_mergatt:
[00008534] 4e56 0000                 link       a6,#0
[00008538] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[0000853c] 2a6e 0008                 movea.l    8(a6),a5
[00008540] 286e 000c                 movea.l    12(a6),a4
[00008544] 2e0d                      move.l     a5,d7
[00008546] 6712                      beq.s      _mergatt_1
[00008548] 4287                      clr.l      d7
[0000854a] 1e2d 0008                 move.b     8(a5),d7
[0000854e] 41f9 0002 16d2            lea.l      $000216D2,a0
[00008554] 4ef9 0000 a7dc            jmp        a.switch
_mergatt_1:
[0000855a] 2e2e 0008                 move.l     8(a6),d7
[0000855e] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00008562] 4e5e                      unlk       a6
[00008564] 4e75                      rts

x8566_1:
[00008566] 4287                      clr.l      d7
[00008568] 3e2c 000a                 move.w     10(a4),d7
[0000856c] 8f6d 000a                 or.w       d7,10(a5)
x8566_2:
[00008570] 2a6d 0004                 movea.l    4(a5),a5
[00008574] 286c 0004                 movea.l    4(a4),a4
[00008578] 60ca                      bra.s      x8566_1
[0000857a] 60f4                      bra.s      x8566_2
[0000857c] 4aad 000a                 tst.l      10(a5)
[00008580] 66ee                      bne.s      x8566_2
[00008582] 2b6c 000a 000a            move.l     10(a4),10(a5)
[00008588] 60e6                      bra.s      x8566_2
[0000858a] 4aac 000a                 tst.l      10(a4)
[0000858e] 6706                      beq.s      x8566_3
[00008590] 2b6c 000a 000a            move.l     10(a4),10(a5)
x8566_3:
[00008596] 4aad 000e                 tst.l      14(a5)
[0000859a] 66d4                      bne.s      x8566_2
[0000859c] 4aac 000e                 tst.l      14(a4)
[000085a0] 67ce                      beq.s      x8566_2
[000085a2] 2b6c 000e 000e            move.l     14(a4),14(a5)
[000085a8] 60c6                      bra.s      x8566_2

_setad:
[000085aa] 4e56 0000                 link       a6,#0
[000085ae] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000085b2] 2a6e 0008                 movea.l    8(a6),a5
[000085b6] 286e 0010                 movea.l    16(a6),a4
[000085ba] 422d 0016                 clr.b      22(a5)
[000085be] 2e0c                      move.l     a4,d7
[000085c0] 6704                      beq.s      _setad_1
[000085c2] 2e0c                      move.l     a4,d7
[000085c4] 6006                      bra.s      _setad_2
_setad_1:
[000085c6] 2e3c 0002 077c            move.l     #_noname,d7
_setad_2:
[000085cc] 2b47 000c                 move.l     d7,12(a5)
[000085d0] 3b6e 000e 0010            move.w     14(a6),16(a5)
[000085d6] 2b6e 0014 0008            move.l     20(a6),8(a5)
[000085dc] 1b6e 001b 0014            move.b     27(a6),20(a5)
[000085e2] 422d 0015                 clr.b      21(a5)
[000085e6] 426d 0012                 clr.w      18(a5)
[000085ea] 2e0d                      move.l     a5,d7
[000085ec] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000085f0] 4e5e                      unlk       a6
[000085f2] 4e75                      rts

_stype:
[000085f4] 4e56 0000                 link       a6,#0
[000085f8] 48e7 8004                 movem.l    d0/a5,-(a7)
[000085fc] 2a6e 0008                 movea.l    8(a6),a5
[00008600] 2e0d                      move.l     a5,d7
[00008602] 6726                      beq.s      _stype_1
[00008604] 4287                      clr.l      d7
[00008606] 1e2d 0008                 move.b     8(a5),d7
[0000860a] 2e87                      move.l     d7,(a7)
[0000860c] 2f3c 0002 14e6            move.l     #_typtab,-(a7)
[00008612] 4eb9 0000 a7a6            jsr        _scnstr
[00008618] 588f                      addq.l     #4,a7
[0000861a] 2447                      movea.l    d7,a2
[0000861c] d5fc 0002 14e6            adda.l     #_typtab,a2
[00008622] 4a12                      tst.b      (a2)
[00008624] 6704                      beq.s      _stype_1
[00008626] 7e01                      moveq.l    #1,d7
[00008628] 6002                      bra.s      _stype_2
_stype_1:
[0000862a] 4287                      clr.l      d7
_stype_2:
[0000862c] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00008630] 4e5e                      unlk       a6
[00008632] 4e75                      rts

_argchk:
[00008634] 4e56 0000                 link       a6,#0
[00008638] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[0000863c] 2a6e 0008                 movea.l    8(a6),a5
[00008640] 286e 000c                 movea.l    12(a6),a4
[00008644] 2e0c                      move.l     a4,d7
[00008646] 6706                      beq.s      _argchk_1
[00008648] 4aac 0004                 tst.l      4(a4)
[0000864c] 6604                      bne.s      _argchk_2
_argchk_1:
[0000864e] 2e0d                      move.l     a5,d7
[00008650] 604e                      bra.s      _argchk_3
_argchk_2:
[00008652] 2e8d                      move.l     a5,(a7)
[00008654] 2f2c 0004                 move.l     4(a4),-(a7)
[00008658] 4eb9 0000 86a8            jsr        _canass
[0000865e] 588f                      addq.l     #4,a7
[00008660] 4a87                      tst.l      d7
[00008662] 660c                      bne.s      _argchk_4
[00008664] 2ebc 0002 1791            move.l     #$00021791,(a7) "illegal actual argument"
[0000866a] 4eb9 0000 3e84            jsr        _p1error
_argchk_4:
[00008670] 4297                      clr.l      (a7)
[00008672] 2f2c 0004                 move.l     4(a4),-(a7)
[00008676] 2f2d 0004                 move.l     4(a5),-(a7)
[0000867a] 4eb9 0000 7d40            jsr        _cmptype
[00008680] 508f                      addq.l     #8,a7
[00008682] 4a87                      tst.l      d7
[00008684] 6618                      bne.s      _argchk_5
[00008686] 2eac 0004                 move.l     4(a4),(a7)
[0000868a] 42a7                      clr.l      -(a7)
[0000868c] 2f0d                      move.l     a5,-(a7)
[0000868e] 4878 0066                 pea.l      ($00000066).w
[00008692] 4eb9 0000 7a0e            jsr        _buyop
[00008698] 4fef 000c                 lea.l      12(a7),a7
[0000869c] 2a47                      movea.l    d7,a5
_argchk_5:
[0000869e] 2e0d                      move.l     a5,d7
_argchk_3:
[000086a0] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000086a4] 4e5e                      unlk       a6
[000086a6] 4e75                      rts

_canass:
[000086a8] 4e56 fffc                 link       a6,#-4
[000086ac] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[000086b0] 2a6e 0008                 movea.l    8(a6),a5
[000086b4] 286e 000c                 movea.l    12(a6),a4
[000086b8] 4287                      clr.l      d7
[000086ba] 1e2c 0016                 move.b     22(a4),d7
[000086be] 0c47 00a9                 cmpi.w     #$00A9,d7
[000086c2] 670c                      beq.s      _canass_1
[000086c4] 4287                      clr.l      d7
[000086c6] 1e2c 0016                 move.b     22(a4),d7
[000086ca] 0c47 0069                 cmpi.w     #$0069,d7
[000086ce] 662e                      bne.s      _canass_2
_canass_1:
[000086d0] 246c 0008                 movea.l    8(a4),a2
[000086d4] 588a                      addq.l     #4,a2
[000086d6] 2452                      movea.l    (a2),a2
[000086d8] 588a                      addq.l     #4,a2
[000086da] 2652                      movea.l    (a2),a3
_canass_5:
[000086dc] 4287                      clr.l      d7
[000086de] 1e2d 0008                 move.b     8(a5),d7
[000086e2] 0c47 0050                 cmpi.w     #$0050,d7
[000086e6] 671c                      beq.s      _canass_3
[000086e8] 4297                      clr.l      (a7)
[000086ea] 2f0b                      move.l     a3,-(a7)
[000086ec] 2f0d                      move.l     a5,-(a7)
[000086ee] 4eb9 0000 7d40            jsr        _cmptype
[000086f4] 508f                      addq.l     #8,a7
[000086f6] 4a87                      tst.l      d7
[000086f8] 670a                      beq.s      _canass_3
[000086fa] 7e01                      moveq.l    #1,d7
[000086fc] 6034                      bra.s      _canass_4
_canass_2:
[000086fe] 266c 0004                 movea.l    4(a4),a3
[00008702] 60d8                      bra.s      _canass_5
_canass_3:
[00008704] 4287                      clr.l      d7
[00008706] 1e2d 0008                 move.b     8(a5),d7
[0000870a] 0c47 0040                 cmpi.w     #$0040,d7
[0000870e] 672a                      beq.s      _canass_6
[00008710] 2e8d                      move.l     a5,(a7)
[00008712] 4eb9 0000 844a            jsr        _itype
[00008718] 4a87                      tst.l      d7
[0000871a] 675a                      beq.s      _canass_7
[0000871c] 4287                      clr.l      d7
[0000871e] 1e2b 0008                 move.b     8(a3),d7
[00008722] 0c47 0040                 cmpi.w     #$0040,d7
[00008726] 664e                      bne.s      _canass_7
[00008728] 4ab9 0002 0b7a            tst.l      _laxflag
[0000872e] 6746                      beq.s      _canass_7
[00008730] 7e01                      moveq.l    #1,d7
_canass_4:
[00008732] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00008736] 4e5e                      unlk       a6
[00008738] 4e75                      rts
_canass_6:
[0000873a] 4287                      clr.l      d7
[0000873c] 1e2b 0008                 move.b     8(a3),d7
[00008740] 0c47 0040                 cmpi.w     #$0040,d7
[00008744] 6700 00b8                 beq        _canass_8
[00008748] 2e8c                      move.l     a4,(a7)
[0000874a] 4eb9 0000 83b6            jsr        _iscons
[00008750] 4a87                      tst.l      d7
[00008752] 6706                      beq.s      _canass_9
[00008754] 4aac 0008                 tst.l      8(a4)
[00008758] 6714                      beq.s      _canass_10
_canass_9:
[0000875a] 4ab9 0002 0b7a            tst.l      _laxflag
[00008760] 6710                      beq.s      _canass_11
[00008762] 2e8b                      move.l     a3,(a7)
[00008764] 4eb9 0000 844a            jsr        _itype
[0000876a] 4a87                      tst.l      d7
[0000876c] 6704                      beq.s      _canass_11
_canass_10:
[0000876e] 7e01                      moveq.l    #1,d7
[00008770] 6002                      bra.s      _canass_12
_canass_11:
[00008772] 4287                      clr.l      d7
_canass_12:
[00008774] 60bc                      bra.s      _canass_4
_canass_7:
[00008776] 2e8d                      move.l     a5,(a7)
[00008778] 4eb9 0000 844a            jsr        _itype
[0000877e] 4a87                      tst.l      d7
[00008780] 660c                      bne.s      _canass_13
[00008782] 2e8d                      move.l     a5,(a7)
[00008784] 4eb9 0000 8062            jsr        _dtype
[0000878a] 4a87                      tst.l      d7
[0000878c] 6718                      beq.s      _canass_14
_canass_13:
[0000878e] 2e8b                      move.l     a3,(a7)
[00008790] 4eb9 0000 844a            jsr        _itype
[00008796] 4a87                      tst.l      d7
[00008798] 6610                      bne.s      _canass_15
[0000879a] 2e8b                      move.l     a3,(a7)
[0000879c] 4eb9 0000 8062            jsr        _dtype
[000087a2] 4a87                      tst.l      d7
[000087a4] 6604                      bne.s      _canass_15
_canass_14:
[000087a6] 4287                      clr.l      d7
[000087a8] 600a                      bra.s      _canass_16
_canass_15:
[000087aa] 4ab9 0002 0b92            tst.l      _strictfl
[000087b0] 660a                      bne.s      _canass_17
[000087b2] 7e01                      moveq.l    #1,d7
_canass_16:
[000087b4] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000087b8] 4e5e                      unlk       a6
[000087ba] 4e75                      rts
_canass_17:
[000087bc] 4878 0001                 pea.l      ($00000001).w
[000087c0] 2f0b                      move.l     a3,-(a7)
[000087c2] 4eb9 0000 7b74            jsr        _bytes
[000087c8] 508f                      addq.l     #8,a7
[000087ca] 2e87                      move.l     d7,(a7)
[000087cc] 4878 0001                 pea.l      ($00000001).w
[000087d0] 2f0d                      move.l     a5,-(a7)
[000087d2] 4eb9 0000 7b74            jsr        _bytes
[000087d8] 508f                      addq.l     #8,a7
[000087da] 9e97                      sub.l      (a7),d7
[000087dc] 2d47 fffc                 move.l     d7,-4(a6)
[000087e0] 4aae fffc                 tst.l      -4(a6)
[000087e4] 6c10                      bge.s      _canass_18
[000087e6] 4287                      clr.l      d7
[000087e8] 1e2d 0008                 move.b     8(a5),d7
[000087ec] 4286                      clr.l      d6
[000087ee] 1c2b 0008                 move.b     8(a3),d6
[000087f2] be86                      cmp.l      d6,d7
[000087f4] 6604                      bne.s      _canass_19
_canass_18:
[000087f6] 7e01                      moveq.l    #1,d7
[000087f8] 6002                      bra.s      _canass_20
_canass_19:
[000087fa] 4287                      clr.l      d7
_canass_20:
[000087fc] 60b6                      bra.s      _canass_16
_canass_8:
[000087fe] 4287                      clr.l      d7
[00008800] 3e2d 000a                 move.w     10(a5),d7
[00008804] 0287 0000 0800            andi.l     #$00000800,d7
[0000880a] 4286                      clr.l      d6
[0000880c] 3c2b 000a                 move.w     10(a3),d6
[00008810] 0286 0000 0800            andi.l     #$00000800,d6
[00008816] be86                      cmp.l      d6,d7
[00008818] 675a                      beq.s      _canass_21
[0000881a] 4287                      clr.l      d7
[0000881c] 3e2d 000a                 move.w     10(a5),d7
[00008820] 0807 000b                 btst       #11,d7
[00008824] 674a                      beq.s      _canass_22
[00008826] 246d 0004                 movea.l    4(a5),a2
[0000882a] 508a                      addq.l     #8,a2
[0000882c] 4287                      clr.l      d7
[0000882e] 1e12                      move.b     (a2),d7
[00008830] 0c47 0050                 cmpi.w     #$0050,d7
[00008834] 6726                      beq.s      _canass_23
[00008836] 246b 0004                 movea.l    4(a3),a2
[0000883a] 508a                      addq.l     #8,a2
[0000883c] 4287                      clr.l      d7
[0000883e] 1e12                      move.b     (a2),d7
[00008840] 0c47 0050                 cmpi.w     #$0050,d7
[00008844] 6716                      beq.s      _canass_23
[00008846] 4297                      clr.l      (a7)
[00008848] 2f2b 0004                 move.l     4(a3),-(a7)
[0000884c] 2f2d 0004                 move.l     4(a5),-(a7)
[00008850] 4eb9 0000 7d40            jsr        _cmptype
[00008856] 508f                      addq.l     #8,a7
[00008858] 4a87                      tst.l      d7
[0000885a] 6714                      beq.s      _canass_22
_canass_23:
[0000885c] 246b 0004                 movea.l    4(a3),a2
[00008860] 508a                      addq.l     #8,a2
[00008862] 4287                      clr.l      d7
[00008864] 1e12                      move.b     (a2),d7
[00008866] 0c47 0042                 cmpi.w     #$0042,d7
[0000886a] 6704                      beq.s      _canass_22
[0000886c] 7e01                      moveq.l    #1,d7
[0000886e] 6002                      bra.s      _canass_24
_canass_22:
[00008870] 4287                      clr.l      d7
_canass_24:
[00008872] 602e                      bra.s      _canass_25
_canass_21:
[00008874] 246d 0004                 movea.l    4(a5),a2
[00008878] 508a                      addq.l     #8,a2
[0000887a] 4287                      clr.l      d7
[0000887c] 1e12                      move.b     (a2),d7
[0000887e] 0c47 0050                 cmpi.w     #$0050,d7
[00008882] 6718                      beq.s      _canass_26
[00008884] 246b 0004                 movea.l    4(a3),a2
[00008888] 508a                      addq.l     #8,a2
[0000888a] 4287                      clr.l      d7
[0000888c] 1e12                      move.b     (a2),d7
[0000888e] 0c47 0050                 cmpi.w     #$0050,d7
[00008892] 6708                      beq.s      _canass_26
[00008894] 4ab9 0002 0b7a            tst.l      _laxflag
[0000889a] 6704                      beq.s      _canass_27
_canass_26:
[0000889c] 7e01                      moveq.l    #1,d7
[0000889e] 6002                      bra.s      _canass_25
_canass_27:
[000088a0] 4287                      clr.l      d7
_canass_25:
[000088a2] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000088a6] 4e5e                      unlk       a6
[000088a8] 4e75                      rts

_defat:
[000088aa] 4e56 0000                 link       a6,#0
[000088ae] 48e7 8004                 movem.l    d0/a5,-(a7)
[000088b2] 2a6e 0008                 movea.l    8(a6),a5
[000088b6] 2e8d                      move.l     a5,(a7)
[000088b8] 4eb9 0000 8cb6            jsr        _scalify
[000088be] 2447                      movea.l    d7,a2
[000088c0] 588a                      addq.l     #4,a2
[000088c2] 2e92                      move.l     (a2),(a7)
[000088c4] 4eb9 0000 85f4            jsr        _stype
[000088ca] 4a87                      tst.l      d7
[000088cc] 6626                      bne.s      _defat_1
[000088ce] 4aae 000c                 tst.l      12(a6)
[000088d2] 672a                      beq.s      _defat_2
[000088d4] 246d 0004                 movea.l    4(a5),a2
[000088d8] 508a                      addq.l     #8,a2
[000088da] 4287                      clr.l      d7
[000088dc] 1e12                      move.b     (a2),d7
[000088de] 0c47 0048                 cmpi.w     #$0048,d7
[000088e2] 6710                      beq.s      _defat_1
[000088e4] 246d 0004                 movea.l    4(a5),a2
[000088e8] 508a                      addq.l     #8,a2
[000088ea] 4287                      clr.l      d7
[000088ec] 1e12                      move.b     (a2),d7
[000088ee] 0c47 0049                 cmpi.w     #$0049,d7
[000088f2] 660a                      bne.s      _defat_2
_defat_1:
[000088f4] 2e0d                      move.l     a5,d7
[000088f6] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000088fa] 4e5e                      unlk       a6
[000088fc] 4e75                      rts
_defat_2:
[000088fe] 2ebc 0002 17aa            move.l     #$000217AA,(a7) "scalar type required"
[00008904] 4eb9 0000 3e84            jsr        _p1error
[0000890a] 2b7c 0002 0dc2 0004       move.l     #_atint,4(a5)
[00008912] 60e0                      bra.s      _defat_1

_docheck:
[00008914] 4e56 0000                 link       a6,#0
[00008918] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000891c] 2a6e 0008                 movea.l    8(a6),a5
_docheck_2:
[00008920] 4287                      clr.l      d7
[00008922] 1e2d 0016                 move.b     22(a5),d7
[00008926] 0c47 0066                 cmpi.w     #$0066,d7
[0000892a] 6616                      bne.s      _docheck_1
[0000892c] 246d 0004                 movea.l    4(a5),a2
[00008930] 508a                      addq.l     #8,a2
[00008932] 4287                      clr.l      d7
[00008934] 1e12                      move.b     (a2),d7
[00008936] 0c47 0050                 cmpi.w     #$0050,d7
[0000893a] 6606                      bne.s      _docheck_1
[0000893c] 2a6d 0008                 movea.l    8(a5),a5
[00008940] 60de                      bra.s      _docheck_2
_docheck_1:
[00008942] 284d                      movea.l    a5,a4
_docheck_4:
[00008944] 4287                      clr.l      d7
[00008946] 1e2c 0016                 move.b     22(a4),d7
[0000894a] 0c47 00a8                 cmpi.w     #$00A8,d7
[0000894e] 6606                      bne.s      _docheck_3
[00008950] 286c 000c                 movea.l    12(a4),a4
[00008954] 60ee                      bra.s      _docheck_4
_docheck_3:
[00008956] 4287                      clr.l      d7
[00008958] 1e2c 0016                 move.b     22(a4),d7
[0000895c] 0c47 0066                 cmpi.w     #$0066,d7
[00008960] 6604                      bne.s      _docheck_5
[00008962] 286c 0008                 movea.l    8(a4),a4
_docheck_5:
[00008966] 4287                      clr.l      d7
[00008968] 1e2c 0016                 move.b     22(a4),d7
[0000896c] 41f9 0002 17c0            lea.l      $000217C0,a0
[00008972] 4ef9 0000 a7dc            jmp        a.switch
[00008978] 197c 008e 0016            move.b     #$8E,22(a4)
[0000897e] 246c 0008                 movea.l    8(a4),a2
[00008982] 588a                      addq.l     #4,a2
[00008984] 2952 0004                 move.l     (a2),4(a4)
[00008988] 2e0d                      move.l     a5,d7
[0000898a] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000898e] 4e5e                      unlk       a6
[00008990] 4e75                      rts

x8992_1:
[00008992] 197c 008b 0016            move.b     #$8B,22(a4)
[00008998] 246c 0008                 movea.l    8(a4),a2
[0000899c] 588a                      addq.l     #4,a2
[0000899e] 2952 0004                 move.l     (a2),4(a4)
[000089a2] 60e4                      bra.s      x8992_1
[000089a4] 266c 0010                 movea.l    16(a4),a3
x8992_3:
[000089a8] 4287                      clr.l      d7
[000089aa] 1e2b 0016                 move.b     22(a3),d7
[000089ae] 0c47 0066                 cmpi.w     #$0066,d7
[000089b2] 6606                      bne.s      x8992_2
[000089b4] 266b 0008                 movea.l    8(a3),a3
[000089b8] 60ee                      bra.s      x8992_3
x8992_2:
[000089ba] 2eae 000c                 move.l     12(a6),(a7)
[000089be] 2f0b                      move.l     a3,-(a7)
[000089c0] 4eba ff52                 jsr        _docheck(pc)
[000089c4] 588f                      addq.l     #4,a7
[000089c6] 2947 0010                 move.l     d7,16(a4)
[000089ca] 266c 000c                 movea.l    12(a4),a3
x8992_5:
[000089ce] 4287                      clr.l      d7
[000089d0] 1e2b 0016                 move.b     22(a3),d7
[000089d4] 0c47 0066                 cmpi.w     #$0066,d7
[000089d8] 6606                      bne.s      x8992_4
[000089da] 266b 0008                 movea.l    8(a3),a3
[000089de] 60ee                      bra.s      x8992_5
x8992_4:
[000089e0] 2eae 000c                 move.l     12(a6),(a7)
[000089e4] 2f0b                      move.l     a3,-(a7)
[000089e6] 4eba ff2c                 jsr        _docheck(pc)
[000089ea] 588f                      addq.l     #4,a7
[000089ec] 2947 000c                 move.l     d7,12(a4)
[000089f0] 6096                      bra.s      x8992_1
[000089f2] 6094                      bra.s      x8992_1
[000089f4] 6092                      bra.s      x8992_1
[000089f6] 6090                      bra.s      x8992_1
[000089f8] 608e                      bra.s      x8992_1
[000089fa] 608c                      bra.s      x8992_1
[000089fc] 608a                      bra.s      x8992_1
[000089fe] 6088                      bra.s      x8992_1
[00008a00] 6086                      bra.s      x8992_1
[00008a02] 6084                      bra.s      x8992_1
[00008a04] 6000 ff82                 bra.w      x8992_1
[00008a08] 6000 ff7e                 bra        x8992_1
[00008a0c] 6000 ff7a                 bra        x8992_1
[00008a10] 6000 ff76                 bra        x8992_1
[00008a14] 4aae 000c                 tst.l      12(a6)
[00008a18] 6614                      bne.s      x8992_6
[00008a1a] 4ab9 0002 0b8e            tst.l      _stdflag
[00008a20] 660c                      bne.s      x8992_6
[00008a22] 2ebc 0002 1848            move.l     #$00021848,(a7) "useless expression"
[00008a28] 4eb9 0000 3e84            jsr        _p1error
x8992_6:
[00008a2e] 4287                      clr.l      d7
[00008a30] 1e2c 0016                 move.b     22(a4),d7
[00008a34] 0807 0006                 btst       #6,d7
[00008a38] 6714                      beq.s      x8992_7
[00008a3a] 4878 0001                 pea.l      ($00000001).w
[00008a3e] 2f2c 0008                 move.l     8(a4),-(a7)
[00008a42] 4eba fed0                 jsr        _docheck(pc)
[00008a46] 508f                      addq.l     #8,a7
[00008a48] 2a47                      movea.l    d7,a5
[00008a4a] 6000 ff3c                 bra        x8992_1
x8992_7:
[00008a4e] 4287                      clr.l      d7
[00008a50] 1e2c 0016                 move.b     22(a4),d7
[00008a54] 0807 0007                 btst       #7,d7
[00008a58] 6700 ff2e                 beq        x8992_1
[00008a5c] 197c 00a8 0016            move.b     #$A8,22(a4)
[00008a62] 4878 0001                 pea.l      ($00000001).w
[00008a66] 2f2c 0008                 move.l     8(a4),-(a7)
[00008a6a] 4eba fea8                 jsr        _docheck(pc)
[00008a6e] 508f                      addq.l     #8,a7
[00008a70] 2947 0008                 move.l     d7,8(a4)
[00008a74] 4878 0001                 pea.l      ($00000001).w
[00008a78] 2f2c 000c                 move.l     12(a4),-(a7)
[00008a7c] 4eba fe96                 jsr        _docheck(pc)
[00008a80] 508f                      addq.l     #8,a7
[00008a82] 2947 000c                 move.l     d7,12(a4)
[00008a86] 246c 000c                 movea.l    12(a4),a2
[00008a8a] 588a                      addq.l     #4,a2
[00008a8c] 2952 0004                 move.l     (a2),4(a4)
[00008a90] 6000 fef6                 bra        x8992_1

_fixsym:
[00008a94] 4e56 0000                 link       a6,#0
[00008a98] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00008a9c] 4297                      clr.l      (a7)
[00008a9e] 2f39 0002 0d2e            move.l     _symtab,-(a7)
[00008aa4] 2f2e 0008                 move.l     8(a6),-(a7)
[00008aa8] 4eb9 0000 847e            jsr        _lookup
[00008aae] 508f                      addq.l     #8,a7
[00008ab0] 2a47                      movea.l    d7,a5
[00008ab2] 2e0d                      move.l     a5,d7
[00008ab4] 660c                      bne.s      _fixsym_1
[00008ab6] 2ebc 0002 185c            move.l     #$0002185C,(a7) "not in table!"
[00008abc] 4eb9 0000 3e84            jsr        _p1error
_fixsym_1:
[00008ac2] 2b6e 000c 0004            move.l     12(a6),4(a5)
[00008ac8] 246d 0004                 movea.l    4(a5),a2
[00008acc] 508a                      addq.l     #8,a2
[00008ace] 4287                      clr.l      d7
[00008ad0] 1e12                      move.b     (a2),d7
[00008ad2] 2e87                      move.l     d7,(a7)
[00008ad4] 4287                      clr.l      d7
[00008ad6] 1e2d 000e                 move.b     14(a5),d7
[00008ada] 2f07                      move.l     d7,-(a7)
[00008adc] 4eb9 0000 3252            jsr        _defspace
[00008ae2] 588f                      addq.l     #4,a7
[00008ae4] 3b47 000c                 move.w     d7,12(a5)
[00008ae8] 4297                      clr.l      (a7)
[00008aea] 2f39 0002 0d16            move.l     _gblsym,-(a7)
[00008af0] 2f2e 0008                 move.l     8(a6),-(a7)
[00008af4] 4eb9 0000 847e            jsr        _lookup
[00008afa] 508f                      addq.l     #8,a7
[00008afc] 2847                      movea.l    d7,a4
[00008afe] 2e0c                      move.l     a4,d7
[00008b00] 6666                      bne.s      _fixsym_2
[00008b02] 4287                      clr.l      d7
[00008b04] 1e2d 000e                 move.b     14(a5),d7
[00008b08] 2e87                      move.l     d7,(a7)
[00008b0a] 486d 0010                 pea.l      16(a5)
[00008b0e] 2f2d 0004                 move.l     4(a5),-(a7)
[00008b12] 4eb9 0000 7a78            jsr        _buysym
[00008b18] 508f                      addq.l     #8,a7
[00008b1a] 2847                      movea.l    d7,a4
[00008b1c] 396d 000c 000c            move.w     12(a5),12(a4)
[00008b22] 196d 000f 000f            move.b     15(a5),15(a4)
[00008b28] 4ab9 0002 0d16            tst.l      _gblsym
[00008b2e] 6708                      beq.s      _fixsym_3
[00008b30] 2e39 0002 0d16            move.l     _gblsym,d7
[00008b36] 6006                      bra.s      _fixsym_4
_fixsym_3:
[00008b38] 2e3c 0002 0d16            move.l     #_gblsym,d7
_fixsym_4:
[00008b3e] 2e87                      move.l     d7,(a7)
[00008b40] 2f0c                      move.l     a4,-(a7)
[00008b42] 4eb9 0000 774e            jsr        _addsym
[00008b48] 588f                      addq.l     #4,a7
[00008b4a] 4287                      clr.l      d7
[00008b4c] 1e2d 0010                 move.b     16(a5),d7
[00008b50] 2447                      movea.l    d7,a2
[00008b52] 47ed 0011                 lea.l      17(a5),a3
[00008b56] d5cb                      adda.l     a3,a2
[00008b58] 4287                      clr.l      d7
[00008b5a] 1e2c 0010                 move.b     16(a4),d7
[00008b5e] 2647                      movea.l    d7,a3
[00008b60] 486c 0011                 pea.l      17(a4)
[00008b64] d7df                      adda.l     (a7)+,a3
[00008b66] 1493                      move.b     (a3),(a2)
_fixsym_2:
[00008b68] 2e2e 000c                 move.l     12(a6),d7
[00008b6c] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00008b70] 4e5e                      unlk       a6
[00008b72] 4e75                      rts

_maxty:
[00008b74] 4e56 0000                 link       a6,#0
[00008b78] 48e7 9c00                 movem.l    d0/d3-d5,-(a7)
[00008b7c] 2eae 0008                 move.l     8(a6),(a7)
[00008b80] 4eb9 0000 84da            jsr        _maxify
[00008b86] 2d47 0008                 move.l     d7,8(a6)
[00008b8a] 2eae 000c                 move.l     12(a6),(a7)
[00008b8e] 4eb9 0000 84da            jsr        _maxify
[00008b94] 2d47 000c                 move.l     d7,12(a6)
[00008b98] 246e 0008                 movea.l    8(a6),a2
[00008b9c] 508a                      addq.l     #8,a2
[00008b9e] 4287                      clr.l      d7
[00008ba0] 1e12                      move.b     (a2),d7
[00008ba2] 2e87                      move.l     d7,(a7)
[00008ba4] 2f3c 0002 14e6            move.l     #_typtab,-(a7)
[00008baa] 4eb9 0000 a7a6            jsr        _scnstr
[00008bb0] 588f                      addq.l     #4,a7
[00008bb2] 2a07                      move.l     d7,d5
[00008bb4] 246e 000c                 movea.l    12(a6),a2
[00008bb8] 508a                      addq.l     #8,a2
[00008bba] 4287                      clr.l      d7
[00008bbc] 1e12                      move.b     (a2),d7
[00008bbe] 2e87                      move.l     d7,(a7)
[00008bc0] 2f3c 0002 14e6            move.l     #_typtab,-(a7)
[00008bc6] 4eb9 0000 a7a6            jsr        _scnstr
[00008bcc] 588f                      addq.l     #4,a7
[00008bce] 2807                      move.l     d7,d4
[00008bd0] 2eae 0010                 move.l     16(a6),(a7)
[00008bd4] 2f3c 0002 14e6            move.l     #_typtab,-(a7)
[00008bda] 4eb9 0000 a7a6            jsr        _scnstr
[00008be0] 588f                      addq.l     #4,a7
[00008be2] 2607                      move.l     d7,d3
[00008be4] b685                      cmp.l      d5,d3
[00008be6] 6d04                      blt.s      _maxty_1
[00008be8] b684                      cmp.l      d4,d3
[00008bea] 6c22                      bge.s      _maxty_2
_maxty_1:
[00008bec] 2ebc 0002 186a            move.l     #$0002186A,(a7) "illegal operand type"
[00008bf2] 4eb9 0000 3e84            jsr        _p1error
_maxty_4:
[00008bf8] 2e03                      move.l     d3,d7
[00008bfa] e587                      asl.l      #2,d7
[00008bfc] 2447                      movea.l    d7,a2
[00008bfe] d5fc 0002 1514            adda.l     #_ttyptab,a2
[00008c04] 2e12                      move.l     (a2),d7
[00008c06] 4cdf 0039                 movem.l    (a7)+,d0/d3-d5
[00008c0a] 4e5e                      unlk       a6
[00008c0c] 4e75                      rts
_maxty_2:
[00008c0e] ba84                      cmp.l      d4,d5
[00008c10] 6c04                      bge.s      _maxty_3
[00008c12] 2604                      move.l     d4,d3
[00008c14] 60e2                      bra.s      _maxty_4
_maxty_3:
[00008c16] 2605                      move.l     d5,d3
[00008c18] 60de                      bra.s      _maxty_4

_ptify:
[00008c1a] 4e56 0000                 link       a6,#0
[00008c1e] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00008c22] 2a6e 0008                 movea.l    8(a6),a5
[00008c26] 286e 000c                 movea.l    12(a6),a4
[00008c2a] 4287                      clr.l      d7
[00008c2c] 3e2c 000a                 move.w     10(a4),d7
[00008c30] 0807 000b                 btst       #11,d7
[00008c34] 6708                      beq.s      _ptify_1
[00008c36] 2e3c 0002 0df8            move.l     #_atulong,d7
[00008c3c] 6006                      bra.s      _ptify_2
_ptify_1:
[00008c3e] 2e3c 0002 0dd4            move.l     #_atunsign,d7
_ptify_2:
[00008c44] 2647                      movea.l    d7,a3
[00008c46] 4287                      clr.l      d7
[00008c48] 1e2b 0008                 move.b     8(a3),d7
[00008c4c] 246d 0004                 movea.l    4(a5),a2
[00008c50] 508a                      addq.l     #8,a2
[00008c52] 4286                      clr.l      d6
[00008c54] 1c12                      move.b     (a2),d6
[00008c56] be86                      cmp.l      d6,d7
[00008c58] 6416                      bcc.s      _ptify_3
[00008c5a] 2e8b                      move.l     a3,(a7)
[00008c5c] 42a7                      clr.l      -(a7)
[00008c5e] 2f0d                      move.l     a5,-(a7)
[00008c60] 4878 0066                 pea.l      ($00000066).w
[00008c64] 4eb9 0000 7a0e            jsr        _buyop
[00008c6a] 4fef 000c                 lea.l      12(a7),a7
[00008c6e] 2a47                      movea.l    d7,a5
_ptify_3:
[00008c70] 2ead 0004                 move.l     4(a5),(a7)
[00008c74] 42a7                      clr.l      -(a7)
[00008c76] 42a7                      clr.l      -(a7)
[00008c78] 4878 0001                 pea.l      ($00000001).w
[00008c7c] 2f2c 0004                 move.l     4(a4),-(a7)
[00008c80] 4eb9 0000 7b74            jsr        _bytes
[00008c86] 508f                      addq.l     #8,a7
[00008c88] 2f07                      move.l     d7,-(a7)
[00008c8a] 42a7                      clr.l      -(a7)
[00008c8c] 2f3c 0002 0dc2            move.l     #_atint,-(a7)
[00008c92] 4eb9 0000 7aec            jsr        _buyterm
[00008c98] 4fef 0014                 lea.l      20(a7),a7
[00008c9c] 2f07                      move.l     d7,-(a7)
[00008c9e] 2f0d                      move.l     a5,-(a7)
[00008ca0] 4878 00e2                 pea.l      ($000000E2).w
[00008ca4] 4eb9 0000 7a0e            jsr        _buyop
[00008caa] 4fef 000c                 lea.l      12(a7),a7
[00008cae] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00008cb2] 4e5e                      unlk       a6
[00008cb4] 4e75                      rts

_scalify:
[00008cb6] 4e56 fffa                 link       a6,#-6
[00008cba] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[00008cbe] 2a6e 0008                 movea.l    8(a6),a5
[00008cc2] 2e0d                      move.l     a5,d7
[00008cc4] 6604                      bne.s      _scalify_1
[00008cc6] 4287                      clr.l      d7
[00008cc8] 601c                      bra.s      _scalify_2
_scalify_1:
[00008cca] 246d 0004                 movea.l    4(a5),a2
[00008cce] 508a                      addq.l     #8,a2
[00008cd0] 4285                      clr.l      d5
[00008cd2] 1a12                      move.b     (a2),d5
[00008cd4] 0c85 0000 0041            cmpi.l     #$00000041,d5
[00008cda] 6712                      beq.s      _scalify_3
[00008cdc] 0c85 0000 0042            cmpi.l     #$00000042,d5
[00008ce2] 670a                      beq.s      _scalify_3
[00008ce4] 2e0d                      move.l     a5,d7
_scalify_2:
[00008ce6] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[00008cea] 4e5e                      unlk       a6
[00008cec] 4e75                      rts
_scalify_3:
[00008cee] 2e8d                      move.l     a5,(a7)
[00008cf0] 4eb9 0000 81ce            jsr        _exspace
[00008cf6] 3d47 fffa                 move.w     d7,-6(a6)
[00008cfa] 0c85 0000 0041            cmpi.l     #$00000041,d5
[00008d00] 660a                      bne.s      _scalify_4
[00008d02] 246d 0004                 movea.l    4(a5),a2
[00008d06] 588a                      addq.l     #4,a2
[00008d08] 2e12                      move.l     (a2),d7
[00008d0a] 6004                      bra.s      _scalify_5
_scalify_4:
[00008d0c] 2e2d 0004                 move.l     4(a5),d7
_scalify_5:
[00008d10] 2d47 fffc                 move.l     d7,-4(a6)
[00008d14] 4287                      clr.l      d7
[00008d16] 3e2e fffa                 move.w     -6(a6),d7
[00008d1a] 0287 0000 0fff            andi.l     #$00000FFF,d7
[00008d20] 6600 00aa                 bne        _scalify_6
[00008d24] 2eae fffc                 move.l     -4(a6),(a7)
[00008d28] 4878 00e2                 pea.l      ($000000E2).w
[00008d2c] 4eb9 0000 3252            jsr        _defspace
[00008d32] 588f                      addq.l     #4,a7
[00008d34] 0807 000b                 btst       #11,d7
[00008d38] 6700 0092                 beq        _scalify_6
[00008d3c] 0c85 0000 0042            cmpi.l     #$00000042,d5
[00008d42] 6700 0088                 beq        _scalify_6
[00008d46] 4297                      clr.l      (a7)
[00008d48] 42a7                      clr.l      -(a7)
[00008d4a] 42a7                      clr.l      -(a7)
[00008d4c] 42a7                      clr.l      -(a7)
[00008d4e] 4eb9 0000 7a0e            jsr        _buyop
[00008d54] 4fef 000c                 lea.l      12(a7),a7
[00008d58] 2647                      movea.l    d7,a3
[00008d5a] 2e8d                      move.l     a5,(a7)
[00008d5c] 2f0b                      move.l     a3,-(a7)
[00008d5e] 4eb9 0000 6d96            jsr        _cpyterm
[00008d64] 588f                      addq.l     #4,a7
[00008d66] 1b7c 0066 0016            move.b     #$66,22(a5)
[00008d6c] 2eae fffc                 move.l     -4(a6),(a7)
[00008d70] 4878 0040                 pea.l      ($00000040).w
[00008d74] 4eb9 0000 79aa            jsr        _buyattr
[00008d7a] 588f                      addq.l     #4,a7
[00008d7c] 2b47 0004                 move.l     d7,4(a5)
[00008d80] 2eae fffc                 move.l     -4(a6),(a7)
[00008d84] 4878 0040                 pea.l      ($00000040).w
[00008d88] 4eb9 0000 79aa            jsr        _buyattr
[00008d8e] 588f                      addq.l     #4,a7
[00008d90] 2747 0004                 move.l     d7,4(a3)
[00008d94] 2b4b 0008                 move.l     a3,8(a5)
[00008d98] 42ad 000c                 clr.l      12(a5)
[00008d9c] 42ad 0010                 clr.l      16(a5)
[00008da0] 45f8 000a                 lea.l      ($0000000A).w,a2
[00008da4] d5ed 0004                 adda.l     4(a5),a2
[00008da8] 2e8a                      move.l     a2,(a7)
[00008daa] 2f2e fffc                 move.l     -4(a6),-(a7)
[00008dae] 4878 00e2                 pea.l      ($000000E2).w
[00008db2] 4eb9 0000 3252            jsr        _defspace
[00008db8] 508f                      addq.l     #8,a7
[00008dba] 2257                      movea.l    (a7),a1
[00008dbc] 3287                      move.w     d7,(a1)
[00008dbe] 45f8 000a                 lea.l      ($0000000A).w,a2
[00008dc2] d5eb 0004                 adda.l     4(a3),a2
[00008dc6] 34ae fffa                 move.w     -6(a6),(a2)
[00008dca] 6022                      bra.s      _scalify_7
_scalify_6:
[00008dcc] 264d                      movea.l    a5,a3
[00008dce] 2eae fffc                 move.l     -4(a6),(a7)
[00008dd2] 4878 0040                 pea.l      ($00000040).w
[00008dd6] 4eb9 0000 79aa            jsr        _buyattr
[00008ddc] 588f                      addq.l     #4,a7
[00008dde] 2b47 0004                 move.l     d7,4(a5)
[00008de2] 45f8 000a                 lea.l      ($0000000A).w,a2
[00008de6] d5ed 0004                 adda.l     4(a5),a2
[00008dea] 34ae fffa                 move.w     -6(a6),(a2)
_scalify_7:
[00008dee] 4a2b 0016                 tst.b      22(a3)
[00008df2] 660a                      bne.s      _scalify_8
[00008df4] 532b 0015                 subq.b     #1,21(a3)
[00008df8] 426b 0012                 clr.w      18(a3)
[00008dfc] 6034                      bra.s      _scalify_9
_scalify_8:
[00008dfe] 246b 0004                 movea.l    4(a3),a2
[00008e02] 588a                      addq.l     #4,a2
[00008e04] 2e92                      move.l     (a2),(a7)
[00008e06] 2f2b 000c                 move.l     12(a3),-(a7)
[00008e0a] 2f2b 0008                 move.l     8(a3),-(a7)
[00008e0e] 4287                      clr.l      d7
[00008e10] 1e2b 0016                 move.b     22(a3),d7
[00008e14] 2f07                      move.l     d7,-(a7)
[00008e16] 4eb9 0000 7a0e            jsr        _buyop
[00008e1c] 4fef 000c                 lea.l      12(a7),a7
[00008e20] 2847                      movea.l    d7,a4
[00008e22] 296b 0010 0010            move.l     16(a3),16(a4)
[00008e28] 177c 0064 0016            move.b     #$64,22(a3)
[00008e2e] 274c 0008                 move.l     a4,8(a3)
_scalify_9:
[00008e32] 2e0d                      move.l     a5,d7
[00008e34] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[00008e38] 4e5e                      unlk       a6
[00008e3a] 4e75                      rts

_tfn:
[00008e3c] 4e56 ffec                 link       a6,#-20
[00008e40] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[00008e44] 2a6e 0008                 movea.l    8(a6),a5
[00008e48] 7001                      moveq.l    #1,d0
[00008e4a] 2d40 fff0                 move.l     d0,-16(a6)
[00008e4e] 4285                      clr.l      d5
[00008e50] 4ab9 0002 0b8a            tst.l      _oldflag
[00008e56] 6704                      beq.s      _tfn_1
[00008e58] 4287                      clr.l      d7
[00008e5a] 6002                      bra.s      _tfn_2
_tfn_1:
[00008e5c] 7e01                      moveq.l    #1,d7
_tfn_2:
[00008e5e] 2d47 fff4                 move.l     d7,-12(a6)
[00008e62] 286d 0008                 movea.l    8(a5),a4
[00008e66] 266d 000c                 movea.l    12(a5),a3
[00008e6a] 4a2c 0016                 tst.b      22(a4)
[00008e6e] 6600 008c                 bne        _tfn_3
[00008e72] 4aac 0004                 tst.l      4(a4)
[00008e76] 6600 0084                 bne        _tfn_3
[00008e7a] 2d79 0002 0cea fffc       move.l     _attlist,-4(a6)
[00008e82] 23f9 0002 0cee 0002 0cea  move.l     _gblat,_attlist
[00008e8c] 4ab9 0002 0b92            tst.l      _strictfl
[00008e92] 6708                      beq.s      _tfn_4
[00008e94] 2e3c 0002 0e40            move.l     #_atvoid,d7
[00008e9a] 6006                      bra.s      _tfn_5
_tfn_4:
[00008e9c] 2e3c 0002 0dc2            move.l     #_atint,d7
_tfn_5:
[00008ea2] 2e87                      move.l     d7,(a7)
[00008ea4] 4878 0042                 pea.l      ($00000042).w
[00008ea8] 4eb9 0000 79aa            jsr        _buyattr
[00008eae] 588f                      addq.l     #4,a7
[00008eb0] 2e87                      move.l     d7,(a7)
[00008eb2] 2f2c 000c                 move.l     12(a4),-(a7)
[00008eb6] 4eba fbdc                 jsr        _fixsym(pc)
[00008eba] 588f                      addq.l     #4,a7
[00008ebc] 2947 0004                 move.l     d7,4(a4)
[00008ec0] 45f8 000a                 lea.l      ($0000000A).w,a2
[00008ec4] d5ec 0004                 adda.l     4(a4),a2
[00008ec8] 2e8a                      move.l     a2,(a7)
[00008eca] 4ab9 0002 0b8e            tst.l      _stdflag
[00008ed0] 6704                      beq.s      _tfn_6
[00008ed2] 4287                      clr.l      d7
[00008ed4] 6006                      bra.s      _tfn_7
_tfn_6:
[00008ed6] 2e3c 0002 0d04            move.l     #_tentsym,d7
_tfn_7:
[00008edc] 2257                      movea.l    (a7),a1
[00008ede] 2287                      move.l     d7,(a1)
[00008ee0] 4878 0042                 pea.l      ($00000042).w
[00008ee4] 4878 002a                 pea.l      ($0000002A).w
[00008ee8] 4eb9 0000 3252            jsr        _defspace
[00008eee] 508f                      addq.l     #8,a7
[00008ef0] 3947 0012                 move.w     d7,18(a4)
[00008ef4] 23ee fffc 0002 0cea       move.l     -4(a6),_attlist
_tfn_3:
[00008efc] 2e8c                      move.l     a4,(a7)
[00008efe] 4eb9 0000 94c6            jsr        _typify
[00008f04] 246c 0004                 movea.l    4(a4),a2
[00008f08] 508a                      addq.l     #8,a2
[00008f0a] 4287                      clr.l      d7
[00008f0c] 1e12                      move.b     (a2),d7
[00008f0e] 0c47 0042                 cmpi.w     #$0042,d7
[00008f12] 6756                      beq.s      _tfn_8
[00008f14] 246c 0004                 movea.l    4(a4),a2
[00008f18] 508a                      addq.l     #8,a2
[00008f1a] 4287                      clr.l      d7
[00008f1c] 1e12                      move.b     (a2),d7
[00008f1e] 0c47 0040                 cmpi.w     #$0040,d7
[00008f22] 6636                      bne.s      _tfn_9
[00008f24] 246c 0004                 movea.l    4(a4),a2
[00008f28] 588a                      addq.l     #4,a2
[00008f2a] 2452                      movea.l    (a2),a2
[00008f2c] 508a                      addq.l     #8,a2
[00008f2e] 4287                      clr.l      d7
[00008f30] 1e12                      move.b     (a2),d7
[00008f32] 0c47 0042                 cmpi.w     #$0042,d7
[00008f36] 6622                      bne.s      _tfn_9
[00008f38] 246c 0004                 movea.l    4(a4),a2
[00008f3c] 588a                      addq.l     #4,a2
[00008f3e] 2e92                      move.l     (a2),(a7)
[00008f40] 42a7                      clr.l      -(a7)
[00008f42] 2f0c                      move.l     a4,-(a7)
[00008f44] 4878 006b                 pea.l      ($0000006B).w
[00008f48] 4eb9 0000 7a0e            jsr        _buyop
[00008f4e] 4fef 000c                 lea.l      12(a7),a7
[00008f52] 2847                      movea.l    d7,a4
[00008f54] 2b4c 0008                 move.l     a4,8(a5)
[00008f58] 6010                      bra.s      _tfn_8
_tfn_9:
[00008f5a] 42ae fff0                 clr.l      -16(a6)
[00008f5e] 2ebc 0002 18b4            move.l     #$000218B4,(a7) "function required"
[00008f64] 4eb9 0000 3e84            jsr        _p1error
_tfn_8:
[00008f6a] 246c 0004                 movea.l    4(a4),a2
[00008f6e] 588a                      addq.l     #4,a2
[00008f70] 2b52 0004                 move.l     (a2),4(a5)
[00008f74] 246d 0004                 movea.l    4(a5),a2
[00008f78] 508a                      addq.l     #8,a2
[00008f7a] 4287                      clr.l      d7
[00008f7c] 1e12                      move.b     (a2),d7
[00008f7e] 0c47 0041                 cmpi.w     #$0041,d7
[00008f82] 6710                      beq.s      _tfn_10
[00008f84] 246d 0004                 movea.l    4(a5),a2
[00008f88] 508a                      addq.l     #8,a2
[00008f8a] 4287                      clr.l      d7
[00008f8c] 1e12                      move.b     (a2),d7
[00008f8e] 0c47 0042                 cmpi.w     #$0042,d7
[00008f92] 6618                      bne.s      _tfn_11
_tfn_10:
[00008f94] 2ebc 0002 18a0            move.l     #$000218A0,(a7) "illegal return type"
[00008f9a] 4eb9 0000 3e84            jsr        _p1error
[00008fa0] 2b7c 0002 0dc2 0004       move.l     #_atint,4(a5)
[00008fa8] 42ae fff0                 clr.l      -16(a6)
_tfn_11:
[00008fac] 2e8d                      move.l     a5,(a7)
[00008fae] 4eba fd06                 jsr        _scalify(pc)
[00008fb2] 4aae fff0                 tst.l      -16(a6)
[00008fb6] 6718                      beq.s      _tfn_12
[00008fb8] 45f8 000e                 lea.l      ($0000000E).w,a2
[00008fbc] d5ec 0004                 adda.l     4(a4),a2
[00008fc0] 2a12                      move.l     (a2),d5
[00008fc2] 6704                      beq.s      _tfn_13
[00008fc4] 7e01                      moveq.l    #1,d7
[00008fc6] 6002                      bra.s      _tfn_14
_tfn_13:
[00008fc8] 4287                      clr.l      d7
_tfn_14:
[00008fca] 2d47 fff8                 move.l     d7,-8(a6)
[00008fce] 6004                      bra.s      _tfn_15
_tfn_12:
[00008fd0] 42ae fff8                 clr.l      -8(a6)
_tfn_15:
[00008fd4] 2e0b                      move.l     a3,d7
[00008fd6] 6618                      bne.s      _tfn_16
[00008fd8] 4a85                      tst.l      d5
[00008fda] 6714                      beq.s      _tfn_16
[00008fdc] 2445                      movea.l    d5,a2
[00008fde] 588a                      addq.l     #4,a2
[00008fe0] 2452                      movea.l    (a2),a2
[00008fe2] 508a                      addq.l     #8,a2
[00008fe4] 4287                      clr.l      d7
[00008fe6] 1e12                      move.b     (a2),d7
[00008fe8] 0c47 0050                 cmpi.w     #$0050,d7
[00008fec] 6602                      bne.s      _tfn_16
[00008fee] 4285                      clr.l      d5
_tfn_16:
[00008ff0] 2d4d ffec                 move.l     a5,-20(a6)
_tfn_21:
[00008ff4] 2e0b                      move.l     a3,d7
[00008ff6] 6746                      beq.s      _tfn_17
[00008ff8] 4287                      clr.l      d7
[00008ffa] 1e2b 0016                 move.b     22(a3),d7
[00008ffe] 0c47 00a5                 cmpi.w     #$00A5,d7
[00009002] 6760                      beq.s      _tfn_18
[00009004] 45f8 000c                 lea.l      ($0000000C).w,a2
[00009008] d5ee ffec                 adda.l     -20(a6),a2
[0000900c] 2e8a                      move.l     a2,(a7)
[0000900e] 2f05                      move.l     d5,-(a7)
[00009010] 2f2e fff4                 move.l     -12(a6),-(a7)
[00009014] 2f0b                      move.l     a3,-(a7)
[00009016] 4eb9 0000 94c6            jsr        _typify
[0000901c] 588f                      addq.l     #4,a7
[0000901e] 2f07                      move.l     d7,-(a7)
[00009020] 4eba f888                 jsr        _defat(pc)
[00009024] 508f                      addq.l     #8,a7
[00009026] 2f07                      move.l     d7,-(a7)
[00009028] 4eba f60a                 jsr        _argchk(pc)
[0000902c] 508f                      addq.l     #8,a7
[0000902e] 2f07                      move.l     d7,-(a7)
[00009030] 4eb9 0000 6f92            jsr        _reduce
[00009036] 588f                      addq.l     #4,a7
[00009038] 2257                      movea.l    (a7),a1
[0000903a] 2287                      move.l     d7,(a1)
[0000903c] 6070                      bra.s      _tfn_19
_tfn_17:
[0000903e] 4a85                      tst.l      d5
[00009040] 6700 00b0                 beq        _tfn_20
[00009044] 2445                      movea.l    d5,a2
[00009046] 588a                      addq.l     #4,a2
[00009048] 4a92                      tst.l      (a2)
[0000904a] 6700 00a6                 beq        _tfn_20
[0000904e] 2ebc 0002 1880            move.l     #$00021880,(a7) "missing argument"
[00009054] 4eb9 0000 3e84            jsr        _p1error
[0000905a] 6000 0096                 bra        _tfn_20
_tfn_24:
[0000905e] 266b 000c                 movea.l    12(a3),a3
[00009062] 6090                      bra.s      _tfn_21
_tfn_18:
[00009064] 45f8 000c                 lea.l      ($0000000C).w,a2
[00009068] d5ee ffec                 adda.l     -20(a6),a2
[0000906c] 2452                      movea.l    (a2),a2
[0000906e] 508a                      addq.l     #8,a2
[00009070] 2e8a                      move.l     a2,(a7)
[00009072] 2f05                      move.l     d5,-(a7)
[00009074] 2f2e fff4                 move.l     -12(a6),-(a7)
[00009078] 2f2b 0008                 move.l     8(a3),-(a7)
[0000907c] 4eb9 0000 94c6            jsr        _typify
[00009082] 588f                      addq.l     #4,a7
[00009084] 2f07                      move.l     d7,-(a7)
[00009086] 4eba f822                 jsr        _defat(pc)
[0000908a] 508f                      addq.l     #8,a7
[0000908c] 2f07                      move.l     d7,-(a7)
[0000908e] 4eba f5a4                 jsr        _argchk(pc)
[00009092] 508f                      addq.l     #8,a7
[00009094] 2f07                      move.l     d7,-(a7)
[00009096] 4eb9 0000 6f92            jsr        _reduce
[0000909c] 588f                      addq.l     #4,a7
[0000909e] 2257                      movea.l    (a7),a1
[000090a0] 2287                      move.l     d7,(a1)
[000090a2] 45f8 000c                 lea.l      ($0000000C).w,a2
[000090a6] d5ee ffec                 adda.l     -20(a6),a2
[000090aa] 2d52 ffec                 move.l     (a2),-20(a6)
_tfn_19:
[000090ae] 4aae fff8                 tst.l      -8(a6)
[000090b2] 6710                      beq.s      _tfn_22
[000090b4] 4a85                      tst.l      d5
[000090b6] 661c                      bne.s      _tfn_23
[000090b8] 2ebc 0002 1891            move.l     #$00021891,(a7) "extra argument"
[000090be] 4eb9 0000 3e84            jsr        _p1error
_tfn_22:
[000090c4] 4287                      clr.l      d7
[000090c6] 1e2b 0016                 move.b     22(a3),d7
[000090ca] 0c47 00a5                 cmpi.w     #$00A5,d7
[000090ce] 678e                      beq.s      _tfn_24
[000090d0] 6000 ff6c                 bra        _tfn_17
_tfn_23:
[000090d4] 2445                      movea.l    d5,a2
[000090d6] 588a                      addq.l     #4,a2
[000090d8] 4a92                      tst.l      (a2)
[000090da] 6706                      beq.s      _tfn_25
[000090dc] 2445                      movea.l    d5,a2
[000090de] 2a12                      move.l     (a2),d5
[000090e0] 60e2                      bra.s      _tfn_22
_tfn_25:
[000090e2] 2445                      movea.l    d5,a2
[000090e4] 588a                      addq.l     #4,a2
[000090e6] 4a92                      tst.l      (a2)
[000090e8] 66da                      bne.s      _tfn_22
[000090ea] 42ae fff8                 clr.l      -8(a6)
[000090ee] 4285                      clr.l      d5
[000090f0] 60d2                      bra.s      _tfn_22
_tfn_20:
[000090f2] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[000090f6] 4e5e                      unlk       a6
[000090f8] 4e75                      rts

_tpoints:
[000090fa] 4e56 fff8                 link       a6,#-8
[000090fe] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00009102] 2a6e 0008                 movea.l    8(a6),a5
[00009106] 286e 000c                 movea.l    12(a6),a4
[0000910a] 2d79 0002 0d22 fffc       move.l     _mostab,-4(a6)
[00009112] 4ab9 0002 0b86            tst.l      _mflag
[00009118] 6738                      beq.s      _tpoints_1
[0000911a] 246d 0004                 movea.l    4(a5),a2
[0000911e] 508a                      addq.l     #8,a2
[00009120] 4287                      clr.l      d7
[00009122] 1e12                      move.b     (a2),d7
[00009124] 0c47 0040                 cmpi.w     #$0040,d7
[00009128] 6628                      bne.s      _tpoints_1
[0000912a] 246d 0004                 movea.l    4(a5),a2
[0000912e] 588a                      addq.l     #4,a2
[00009130] 2452                      movea.l    (a2),a2
[00009132] 508a                      addq.l     #8,a2
[00009134] 4287                      clr.l      d7
[00009136] 1e12                      move.b     (a2),d7
[00009138] 0c47 0048                 cmpi.w     #$0048,d7
[0000913c] 6722                      beq.s      _tpoints_2
[0000913e] 246d 0004                 movea.l    4(a5),a2
[00009142] 588a                      addq.l     #4,a2
[00009144] 2452                      movea.l    (a2),a2
[00009146] 508a                      addq.l     #8,a2
[00009148] 4287                      clr.l      d7
[0000914a] 1e12                      move.b     (a2),d7
[0000914c] 0c47 0049                 cmpi.w     #$0049,d7
[00009150] 670e                      beq.s      _tpoints_2
_tpoints_1:
[00009152] 4ab9 0002 0b86            tst.l      _mflag
[00009158] 6730                      beq.s      _tpoints_3
[0000915a] 42ae fffc                 clr.l      -4(a6)
[0000915e] 6016                      bra.s      _tpoints_4
_tpoints_2:
[00009160] 246d 0004                 movea.l    4(a5),a2
[00009164] 588a                      addq.l     #4,a2
[00009166] 2e92                      move.l     (a2),(a7)
[00009168] 45f8 000a                 lea.l      ($0000000A).w,a2
[0000916c] d5d7                      adda.l     (a7),a2
[0000916e] 2452                      movea.l    (a2),a2
[00009170] 508a                      addq.l     #8,a2
[00009172] 2d52 fffc                 move.l     (a2),-4(a6)
_tpoints_4:
[00009176] 2e8c                      move.l     a4,(a7)
[00009178] 4eb9 0000 6e7a            jsr        _hasname
[0000917e] 4a87                      tst.l      d7
[00009180] 6634                      bne.s      _tpoints_5
[00009182] 267c 0002 16f2            movea.l    #$000216F2,a3
[00009188] 605c                      bra.s      _tpoints_6
_tpoints_3:
[0000918a] 246d 0004                 movea.l    4(a5),a2
[0000918e] 508a                      addq.l     #8,a2
[00009190] 4287                      clr.l      d7
[00009192] 1e12                      move.b     (a2),d7
[00009194] 0c47 0040                 cmpi.w     #$0040,d7
[00009198] 67dc                      beq.s      _tpoints_4
[0000919a] 2ead 0004                 move.l     4(a5),(a7)
[0000919e] 4eb9 0000 844a            jsr        _itype
[000091a4] 4a87                      tst.l      d7
[000091a6] 66ce                      bne.s      _tpoints_4
[000091a8] 2ebc 0002 18d5            move.l     #$000218D5,(a7) "illegal selection"
[000091ae] 4eb9 0000 3e84            jsr        _p1error
[000091b4] 60c0                      bra.s      _tpoints_4
_tpoints_5:
[000091b6] 4297                      clr.l      (a7)
[000091b8] 2f2e fffc                 move.l     -4(a6),-(a7)
[000091bc] 2f2c 000c                 move.l     12(a4),-(a7)
[000091c0] 4eb9 0000 847e            jsr        _lookup
[000091c6] 508f                      addq.l     #8,a7
[000091c8] 2647                      movea.l    d7,a3
[000091ca] 2e0b                      move.l     a3,d7
[000091cc] 6618                      bne.s      _tpoints_6
[000091ce] 2eac 000c                 move.l     12(a4),(a7)
[000091d2] 2f3c 0002 18c6            move.l     #$000218C6,-(a7) "unknown member"
[000091d8] 4eb9 0000 3c8a            jsr        _nmerr
[000091de] 588f                      addq.l     #4,a7
[000091e0] 267c 0002 16f2            movea.l    #$000216F2,a3
_tpoints_6:
[000091e6] 246d 0004                 movea.l    4(a5),a2
[000091ea] 508a                      addq.l     #8,a2
[000091ec] 4287                      clr.l      d7
[000091ee] 1e12                      move.b     (a2),d7
[000091f0] 0c47 0040                 cmpi.w     #$0040,d7
[000091f4] 6750                      beq.s      _tpoints_7
[000091f6] 2ebc 0002 0d68            move.l     #_atchar,(a7)
[000091fc] 4878 0040                 pea.l      ($00000040).w
[00009200] 4eb9 0000 79aa            jsr        _buyattr
[00009206] 588f                      addq.l     #4,a7
[00009208] 2e87                      move.l     d7,(a7)
[0000920a] 42a7                      clr.l      -(a7)
[0000920c] 2f0d                      move.l     a5,-(a7)
[0000920e] 4878 0066                 pea.l      ($00000066).w
[00009212] 4eb9 0000 7a0e            jsr        _buyop
[00009218] 4fef 000c                 lea.l      12(a7),a7
[0000921c] 2a47                      movea.l    d7,a5
[0000921e] 45f8 000a                 lea.l      ($0000000A).w,a2
[00009222] d5ed 0004                 adda.l     4(a5),a2
[00009226] 2e8a                      move.l     a2,(a7)
[00009228] 4878 0008                 pea.l      ($00000008).w
[0000922c] 4878 00e2                 pea.l      ($000000E2).w
[00009230] 4eb9 0000 3252            jsr        _defspace
[00009236] 508f                      addq.l     #8,a7
[00009238] 2257                      movea.l    (a7),a1
[0000923a] 3287                      move.w     d7,(a1)
[0000923c] 246e 0010                 movea.l    16(a6),a2
[00009240] 508a                      addq.l     #8,a2
[00009242] 248d                      move.l     a5,(a2)
[00009244] 603a                      bra.s      _tpoints_8
_tpoints_7:
[00009246] 45f8 000a                 lea.l      ($0000000A).w,a2
[0000924a] d5ed 0004                 adda.l     4(a5),a2
[0000924e] 4287                      clr.l      d7
[00009250] 3e12                      move.w     (a2),d7
[00009252] 4286                      clr.l      d6
[00009254] 3c2b 000c                 move.w     12(a3),d6
[00009258] be86                      cmp.l      d6,d7
[0000925a] 6704                      beq.s      _tpoints_9
[0000925c] 7e01                      moveq.l    #1,d7
[0000925e] 6002                      bra.s      _tpoints_10
_tpoints_9:
[00009260] 4287                      clr.l      d7
_tpoints_10:
[00009262] 45f8 000a                 lea.l      ($0000000A).w,a2
[00009266] d5ed 0004                 adda.l     4(a5),a2
[0000926a] 4286                      clr.l      d6
[0000926c] 3c12                      move.w     (a2),d6
[0000926e] 8c87                      or.l       d7,d6
[00009270] 670e                      beq.s      _tpoints_8
[00009272] 2ead 0004                 move.l     4(a5),(a7)
[00009276] 4eb9 0000 7f58            jsr        _cpyattr
[0000927c] 2b47 0004                 move.l     d7,4(a5)
_tpoints_8:
[00009280] 45f8 000a                 lea.l      ($0000000A).w,a2
[00009284] d5ed 0004                 adda.l     4(a5),a2
[00009288] 4287                      clr.l      d7
[0000928a] 3e2b 000c                 move.w     12(a3),d7
[0000928e] 8f52                      or.w       d7,(a2)
[00009290] 246e 0010                 movea.l    16(a6),a2
[00009294] 508a                      addq.l     #8,a2
[00009296] 2e8a                      move.l     a2,(a7)
[00009298] 2f2d 0004                 move.l     4(a5),-(a7)
[0000929c] 2f0c                      move.l     a4,-(a7)
[0000929e] 2f0d                      move.l     a5,-(a7)
[000092a0] 4878 00de                 pea.l      ($000000DE).w
[000092a4] 4eb9 0000 7a0e            jsr        _buyop
[000092aa] 4fef 0010                 lea.l      16(a7),a7
[000092ae] 2257                      movea.l    (a7),a1
[000092b0] 2287                      move.l     d7,(a1)
[000092b2] 45f8 0016                 lea.l      ($00000016).w,a2
[000092b6] d5ee 0010                 adda.l     16(a6),a2
[000092ba] 14bc 006b                 move.b     #$6B,(a2)
[000092be] 246e 0010                 movea.l    16(a6),a2
[000092c2] 588a                      addq.l     #4,a2
[000092c4] 24ab 0004                 move.l     4(a3),(a2)
[000092c8] 2e8c                      move.l     a4,(a7)
[000092ca] 4eb9 0000 6e7a            jsr        _hasname
[000092d0] 4a87                      tst.l      d7
[000092d2] 6706                      beq.s      _tpoints_11
[000092d4] 2e2c 000c                 move.l     12(a4),d7
[000092d8] 6002                      bra.s      _tpoints_12
_tpoints_11:
[000092da] 4287                      clr.l      d7
_tpoints_12:
[000092dc] 2d47 fff8                 move.l     d7,-8(a6)
[000092e0] 4297                      clr.l      (a7)
[000092e2] 2f2b 0008                 move.l     8(a3),-(a7)
[000092e6] 42a7                      clr.l      -(a7)
[000092e8] 42a7                      clr.l      -(a7)
[000092ea] 2f0c                      move.l     a4,-(a7)
[000092ec] 4eb9 0000 85aa            jsr        _setad
[000092f2] 4fef 0010                 lea.l      16(a7),a7
[000092f6] 4aae fff8                 tst.l      -8(a6)
[000092fa] 670e                      beq.s      _tpoints_13
[000092fc] 4297                      clr.l      (a7)
[000092fe] 2f2e fff8                 move.l     -8(a6),-(a7)
[00009302] 4eb9 0000 aa76            jsr        _free
[00009308] 588f                      addq.l     #4,a7
_tpoints_13:
[0000930a] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000930e] 4e5e                      unlk       a6
[00009310] 4e75                      rts

_tquery:
[00009312] 4e56 0000                 link       a6,#0
[00009316] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000931a] 2a6e 0008                 movea.l    8(a6),a5
[0000931e] 266d 000c                 movea.l    12(a5),a3
[00009322] 2ead 0010                 move.l     16(a5),(a7)
[00009326] 4eb9 0000 94c6            jsr        _typify
[0000932c] 2e87                      move.l     d7,(a7)
[0000932e] 4eba f986                 jsr        _scalify(pc)
[00009332] 2847                      movea.l    d7,a4
[00009334] 2b6c 0004 0004            move.l     4(a4),4(a5)
[0000933a] 246c 0004                 movea.l    4(a4),a2
[0000933e] 508a                      addq.l     #8,a2
[00009340] 4287                      clr.l      d7
[00009342] 1e12                      move.b     (a2),d7
[00009344] 0c47 0040                 cmpi.w     #$0040,d7
[00009348] 6620                      bne.s      _tquery_1
[0000934a] 2eab 0004                 move.l     4(a3),(a7)
[0000934e] 4eb9 0000 844a            jsr        _itype
[00009354] 4a87                      tst.l      d7
[00009356] 6712                      beq.s      _tquery_1
[00009358] 2e8b                      move.l     a3,(a7)
[0000935a] 2f2c 0004                 move.l     4(a4),-(a7)
[0000935e] 4eba f348                 jsr        _canass(pc)
[00009362] 588f                      addq.l     #4,a7
[00009364] 4a87                      tst.l      d7
[00009366] 6600 00e8                 bne        _tquery_2
_tquery_1:
[0000936a] 246c 0004                 movea.l    4(a4),a2
[0000936e] 508a                      addq.l     #8,a2
[00009370] 4287                      clr.l      d7
[00009372] 1e12                      move.b     (a2),d7
[00009374] 0c47 0040                 cmpi.w     #$0040,d7
[00009378] 6710                      beq.s      _tquery_3
[0000937a] 246b 0004                 movea.l    4(a3),a2
[0000937e] 508a                      addq.l     #8,a2
[00009380] 4287                      clr.l      d7
[00009382] 1e12                      move.b     (a2),d7
[00009384] 0c47 0040                 cmpi.w     #$0040,d7
[00009388] 6612                      bne.s      _tquery_4
_tquery_3:
[0000938a] 2e8b                      move.l     a3,(a7)
[0000938c] 2f2c 0004                 move.l     4(a4),-(a7)
[00009390] 4eba f316                 jsr        _canass(pc)
[00009394] 588f                      addq.l     #4,a7
[00009396] 4a87                      tst.l      d7
[00009398] 6600 00b6                 bne        _tquery_2
_tquery_4:
[0000939c] 2eac 0004                 move.l     4(a4),(a7)
[000093a0] 4eb9 0000 844a            jsr        _itype
[000093a6] 4a87                      tst.l      d7
[000093a8] 672a                      beq.s      _tquery_5
[000093aa] 246b 0004                 movea.l    4(a3),a2
[000093ae] 508a                      addq.l     #8,a2
[000093b0] 4287                      clr.l      d7
[000093b2] 1e12                      move.b     (a2),d7
[000093b4] 0c47 0040                 cmpi.w     #$0040,d7
[000093b8] 661a                      bne.s      _tquery_5
[000093ba] 2e8c                      move.l     a4,(a7)
[000093bc] 2f2b 0004                 move.l     4(a3),-(a7)
[000093c0] 4eba f2e6                 jsr        _canass(pc)
[000093c4] 588f                      addq.l     #4,a7
[000093c6] 4a87                      tst.l      d7
[000093c8] 670a                      beq.s      _tquery_5
[000093ca] 2b6b 0004 0004            move.l     4(a3),4(a5)
[000093d0] 6000 007e                 bra.w      _tquery_2
_tquery_5:
[000093d4] 2eac 0004                 move.l     4(a4),(a7)
[000093d8] 4eb9 0000 844a            jsr        _itype
[000093de] 4a87                      tst.l      d7
[000093e0] 660e                      bne.s      _tquery_6
[000093e2] 2eac 0004                 move.l     4(a4),(a7)
[000093e6] 4eb9 0000 8062            jsr        _dtype
[000093ec] 4a87                      tst.l      d7
[000093ee] 671c                      beq.s      _tquery_7
_tquery_6:
[000093f0] 2eab 0004                 move.l     4(a3),(a7)
[000093f4] 4eb9 0000 844a            jsr        _itype
[000093fa] 4a87                      tst.l      d7
[000093fc] 663a                      bne.s      _tquery_8
[000093fe] 2eab 0004                 move.l     4(a3),(a7)
[00009402] 4eb9 0000 8062            jsr        _dtype
[00009408] 4a87                      tst.l      d7
[0000940a] 662c                      bne.s      _tquery_8
_tquery_7:
[0000940c] 4297                      clr.l      (a7)
[0000940e] 2f2b 0004                 move.l     4(a3),-(a7)
[00009412] 2f2c 0004                 move.l     4(a4),-(a7)
[00009416] 4eb9 0000 7d40            jsr        _cmptype
[0000941c] 508f                      addq.l     #8,a7
[0000941e] 4a87                      tst.l      d7
[00009420] 662e                      bne.s      _tquery_2
[00009422] 4ab9 0002 0b7a            tst.l      _laxflag
[00009428] 6626                      bne.s      _tquery_2
[0000942a] 2ebc 0002 18e8            move.l     #$000218E8,(a7) "type conflict in conditional"
[00009430] 4eb9 0000 3e84            jsr        _p1error
[00009436] 6018                      bra.s      _tquery_2
_tquery_8:
[00009438] 4878 002a                 pea.l      ($0000002A).w
[0000943c] 2f2b 0004                 move.l     4(a3),-(a7)
[00009440] 2f2c 0004                 move.l     4(a4),-(a7)
[00009444] 4eba f72e                 jsr        _maxty(pc)
[00009448] 4fef 000c                 lea.l      12(a7),a7
[0000944c] 2b47 0004                 move.l     d7,4(a5)
_tquery_2:
[00009450] 2ead 0004                 move.l     4(a5),(a7)
[00009454] 4eb9 0000 84da            jsr        _maxify
[0000945a] 2b47 0004                 move.l     d7,4(a5)
[0000945e] 4297                      clr.l      (a7)
[00009460] 2f2c 0004                 move.l     4(a4),-(a7)
[00009464] 2f2d 0004                 move.l     4(a5),-(a7)
[00009468] 4eb9 0000 7d40            jsr        _cmptype
[0000946e] 508f                      addq.l     #8,a7
[00009470] 4a87                      tst.l      d7
[00009472] 661a                      bne.s      _tquery_9
[00009474] 2ead 0004                 move.l     4(a5),(a7)
[00009478] 42a7                      clr.l      -(a7)
[0000947a] 2f0c                      move.l     a4,-(a7)
[0000947c] 4878 0066                 pea.l      ($00000066).w
[00009480] 4eb9 0000 7a0e            jsr        _buyop
[00009486] 4fef 000c                 lea.l      12(a7),a7
[0000948a] 2b47 0010                 move.l     d7,16(a5)
_tquery_9:
[0000948e] 4297                      clr.l      (a7)
[00009490] 2f2b 0004                 move.l     4(a3),-(a7)
[00009494] 2f2d 0004                 move.l     4(a5),-(a7)
[00009498] 4eb9 0000 7d40            jsr        _cmptype
[0000949e] 508f                      addq.l     #8,a7
[000094a0] 4a87                      tst.l      d7
[000094a2] 661a                      bne.s      _tquery_10
[000094a4] 2ead 0004                 move.l     4(a5),(a7)
[000094a8] 42a7                      clr.l      -(a7)
[000094aa] 2f0b                      move.l     a3,-(a7)
[000094ac] 4878 0066                 pea.l      ($00000066).w
[000094b0] 4eb9 0000 7a0e            jsr        _buyop
[000094b6] 4fef 000c                 lea.l      12(a7),a7
[000094ba] 2b47 000c                 move.l     d7,12(a5)
_tquery_10:
[000094be] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000094c2] 4e5e                      unlk       a6
[000094c4] 4e75                      rts

_typify:
[000094c6] 4e56 fffc                 link       a6,#-4
[000094ca] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[000094ce] 2a6e 0008                 movea.l    8(a6),a5
[000094d2] 2e0d                      move.l     a5,d7
[000094d4] 660a                      bne.s      _typify_1
[000094d6] 4287                      clr.l      d7
[000094d8] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000094dc] 4e5e                      unlk       a6
[000094de] 4e75                      rts
_typify_1:
[000094e0] 286d 0008                 movea.l    8(a5),a4
[000094e4] 266d 000c                 movea.l    12(a5),a3
[000094e8] 4a2d 0016                 tst.b      22(a5)
[000094ec] 6604                      bne.s      _typify_2
[000094ee] 4287                      clr.l      d7
[000094f0] 6024                      bra.s      _typify_3
_typify_2:
[000094f2] 4287                      clr.l      d7
[000094f4] 1e2d 0016                 move.b     22(a5),d7
[000094f8] 2e87                      move.l     d7,(a7)
[000094fa] 2f3c 0002 1762            move.l     #_tyops,-(a7)
[00009500] 4eb9 0000 a7a6            jsr        _scnstr
[00009506] 588f                      addq.l     #4,a7
[00009508] e387                      asl.l      #1,d7
[0000950a] 2447                      movea.l    d7,a2
[0000950c] d5fc 0002 1704            adda.l     #_tycodes,a2
[00009512] 4287                      clr.l      d7
[00009514] 3e12                      move.w     (a2),d7
_typify_3:
[00009516] 3d47 fffc                 move.w     d7,-4(a6)
[0000951a] 3e2e fffc                 move.w     -4(a6),d7
[0000951e] 48c7                      ext.l      d7
[00009520] 0807 0007                 btst       #7,d7
[00009524] 6706                      beq.s      _typify_4
[00009526] 2e8b                      move.l     a3,(a7)
[00009528] 4eba ff9c                 jsr        _typify(pc)
_typify_4:
[0000952c] 3e2e fffc                 move.w     -4(a6),d7
[00009530] 48c7                      ext.l      d7
[00009532] 0807 0006                 btst       #6,d7
[00009536] 670a                      beq.s      _typify_5
[00009538] 4297                      clr.l      (a7)
[0000953a] 2f0b                      move.l     a3,-(a7)
[0000953c] 4eba f36c                 jsr        _defat(pc)
[00009540] 588f                      addq.l     #4,a7
_typify_5:
[00009542] 3e2e fffc                 move.w     -4(a6),d7
[00009546] 48c7                      ext.l      d7
[00009548] 0807 0009                 btst       #9,d7
[0000954c] 6706                      beq.s      _typify_6
[0000954e] 2e8b                      move.l     a3,(a7)
[00009550] 4eba f764                 jsr        _scalify(pc)
_typify_6:
[00009554] 3e2e fffc                 move.w     -4(a6),d7
[00009558] 48c7                      ext.l      d7
[0000955a] 0807 0004                 btst       #4,d7
[0000955e] 6706                      beq.s      _typify_7
[00009560] 2e8c                      move.l     a4,(a7)
[00009562] 4eba ff62                 jsr        _typify(pc)
_typify_7:
[00009566] 3e2e fffc                 move.w     -4(a6),d7
[0000956a] 48c7                      ext.l      d7
[0000956c] 0807 0003                 btst       #3,d7
[00009570] 670a                      beq.s      _typify_8
[00009572] 4297                      clr.l      (a7)
[00009574] 2f0c                      move.l     a4,-(a7)
[00009576] 4eba f332                 jsr        _defat(pc)
[0000957a] 588f                      addq.l     #4,a7
_typify_8:
[0000957c] 3e2e fffc                 move.w     -4(a6),d7
[00009580] 48c7                      ext.l      d7
[00009582] 0807 000a                 btst       #10,d7
[00009586] 6706                      beq.s      _typify_9
[00009588] 2e8c                      move.l     a4,(a7)
[0000958a] 4eba f72a                 jsr        _scalify(pc)
_typify_9:
[0000958e] 3e2e fffc                 move.w     -4(a6),d7
[00009592] 48c7                      ext.l      d7
[00009594] 0807 0005                 btst       #5,d7
[00009598] 673c                      beq.s      _typify_10
[0000959a] 4287                      clr.l      d7
[0000959c] 1e2c 0016                 move.b     22(a4),d7
[000095a0] 0c47 006b                 cmpi.w     #$006B,d7
[000095a4] 6756                      beq.s      _typify_11
[000095a6] 4a2c 0016                 tst.b      22(a4)
[000095aa] 6664                      bne.s      _typify_12
[000095ac] 4a2c 0015                 tst.b      21(a4)
[000095b0] 664a                      bne.s      _typify_11
[000095b2] 4aac 0008                 tst.l      8(a4)
[000095b6] 6658                      bne.s      _typify_12
[000095b8] 4a2c 0014                 tst.b      20(a4)
[000095bc] 6752                      beq.s      _typify_12
[000095be] 0c2c 0020 0014            cmpi.b     #$20,20(a4)
[000095c4] 674a                      beq.s      _typify_12
[000095c6] 1e2c 0014                 move.b     20(a4),d7
[000095ca] 4887                      ext.w      d7
[000095cc] 48c7                      ext.l      d7
[000095ce] 0c47 00a0                 cmpi.w     #$00A0,d7
[000095d2] 6628                      bne.s      _typify_11
[000095d4] 603a                      bra.s      _typify_12
_typify_10:
[000095d6] 3e2e fffc                 move.w     -4(a6),d7
[000095da] 48c7                      ext.l      d7
[000095dc] 0807 0002                 btst       #2,d7
[000095e0] 6770                      beq.s      _typify_13
[000095e2] 4878 002a                 pea.l      ($0000002A).w
[000095e6] 2f2b 0004                 move.l     4(a3),-(a7)
[000095ea] 2f2c 0004                 move.l     4(a4),-(a7)
[000095ee] 4eba f584                 jsr        _maxty(pc)
[000095f2] 4fef 000c                 lea.l      12(a7),a7
[000095f6] 2b47 0004                 move.l     d7,4(a5)
[000095fa] 6056                      bra.s      _typify_13
_typify_11:
[000095fc] 4a2c 0016                 tst.b      22(a4)
[00009600] 661c                      bne.s      _typify_14
[00009602] 4287                      clr.l      d7
[00009604] 3e2c 0012                 move.w     18(a4),d7
[00009608] 0807 000d                 btst       #13,d7
[0000960c] 6636                      bne.s      _typify_15
[0000960e] 600e                      bra.s      _typify_14
_typify_12:
[00009610] 2ebc 0002 1a8b            move.l     #$00021A8B,(a7) "lvalue required"
[00009616] 4eb9 0000 3e84            jsr        _p1error
[0000961c] 60b8                      bra.s      _typify_10
_typify_14:
[0000961e] 4287                      clr.l      d7
[00009620] 1e2c 0016                 move.b     22(a4),d7
[00009624] 0c47 006b                 cmpi.w     #$006B,d7
[00009628] 66ac                      bne.s      _typify_10
[0000962a] 246c 0008                 movea.l    8(a4),a2
[0000962e] 588a                      addq.l     #4,a2
[00009630] 2e92                      move.l     (a2),(a7)
[00009632] 45f8 000a                 lea.l      ($0000000A).w,a2
[00009636] d5d7                      adda.l     (a7),a2
[00009638] 4287                      clr.l      d7
[0000963a] 3e12                      move.w     (a2),d7
[0000963c] 0287 0000 3000            andi.l     #$00003000,d7
[00009642] 6792                      beq.s      _typify_10
_typify_15:
[00009644] 2ebc 0002 1a7c            move.l     #$00021A7C,(a7) "const modified"
[0000964a] 4eb9 0000 3e84            jsr        _p1error
[00009650] 6084                      bra.s      _typify_10
_typify_13:
[00009652] 3e2e fffc                 move.w     -4(a6),d7
[00009656] 48c7                      ext.l      d7
[00009658] 0807 0001                 btst       #1,d7
[0000965c] 6718                      beq.s      _typify_16
[0000965e] 4878 0021                 pea.l      ($00000021).w
[00009662] 2f2b 0004                 move.l     4(a3),-(a7)
[00009666] 2f2c 0004                 move.l     4(a4),-(a7)
[0000966a] 4eba f508                 jsr        _maxty(pc)
[0000966e] 4fef 000c                 lea.l      12(a7),a7
[00009672] 2b47 0004                 move.l     d7,4(a5)
_typify_16:
[00009676] 3e2e fffc                 move.w     -4(a6),d7
[0000967a] 48c7                      ext.l      d7
[0000967c] 0807 0000                 btst       #0,d7
[00009680] 6706                      beq.s      _typify_17
[00009682] 2b6c 0004 0004            move.l     4(a4),4(a5)
_typify_17:
[00009688] 4287                      clr.l      d7
[0000968a] 1e2d 0016                 move.b     22(a5),d7
[0000968e] 41f9 0002 1906            lea.l      $00021906,a0
[00009694] 4ef9 0000 a7dc            jmp        a.switch
[0000969a] 4aad 0004                 tst.l      4(a5)
[0000969e] 6626                      bne.s      _typify_18
[000096a0] 2ead 000c                 move.l     12(a5),(a7)
[000096a4] 2f3c 0002 1a71            move.l     #$00021A71,-(a7) "undeclared"
[000096aa] 4eb9 0000 3c8a            jsr        _nmerr
[000096b0] 588f                      addq.l     #4,a7
[000096b2] 2ebc 0002 0dc2            move.l     #_atint,(a7)
[000096b8] 2f2d 000c                 move.l     12(a5),-(a7)
[000096bc] 4eba f3d6                 jsr        _fixsym(pc)
[000096c0] 588f                      addq.l     #4,a7
[000096c2] 2b47 0004                 move.l     d7,4(a5)
_typify_18:
[000096c6] 4aad 0004                 tst.l      4(a5)
[000096ca] 6600 062e                 bne        _typify_19
[000096ce] 2b7c 0002 0dc2 0004       move.l     #_atint,4(a5)
[000096d6] 6000 063c                 bra        _typify_20
[000096da] 4287                      clr.l      d7
[000096dc] 1e2c 0016                 move.b     22(a4),d7
[000096e0] 0c47 0066                 cmpi.w     #$0066,d7
[000096e4] 6706                      beq.s      _typify_21
[000096e6] 2e8c                      move.l     a4,(a7)
[000096e8] 4eba fddc                 jsr        _typify(pc)
_typify_21:
[000096ec] 4297                      clr.l      (a7)
[000096ee] 4878 0001                 pea.l      ($00000001).w
[000096f2] 2f2c 0004                 move.l     4(a4),-(a7)
[000096f6] 4eb9 0000 7b74            jsr        _bytes
[000096fc] 508f                      addq.l     #8,a7
[000096fe] 2f07                      move.l     d7,-(a7)
[00009700] 42a7                      clr.l      -(a7)
[00009702] 42a7                      clr.l      -(a7)
[00009704] 2f0d                      move.l     a5,-(a7)
[00009706] 4eb9 0000 85aa            jsr        _setad
[0000970c] 4fef 0010                 lea.l      16(a7),a7
[00009710] 60b4                      bra.s      _typify_18
[00009712] 426e fffe                 clr.w      -2(a6)
[00009716] 246c 0004                 movea.l    4(a4),a2
[0000971a] 508a                      addq.l     #8,a2
[0000971c] 4287                      clr.l      d7
[0000971e] 1e12                      move.b     (a2),d7
[00009720] 0c47 0048                 cmpi.w     #$0048,d7
[00009724] 6710                      beq.s      _typify_22
[00009726] 246c 0004                 movea.l    4(a4),a2
[0000972a] 508a                      addq.l     #8,a2
[0000972c] 4287                      clr.l      d7
[0000972e] 1e12                      move.b     (a2),d7
[00009730] 0c47 0049                 cmpi.w     #$0049,d7
[00009734] 6630                      bne.s      _typify_23
_typify_22:
[00009736] 4287                      clr.l      d7
[00009738] 1e2c 0016                 move.b     22(a4),d7
[0000973c] 0c47 00a9                 cmpi.w     #$00A9,d7
[00009740] 6762                      beq.s      _typify_24
[00009742] 4287                      clr.l      d7
[00009744] 1e2c 0016                 move.b     22(a4),d7
[00009748] 0c47 0069                 cmpi.w     #$0069,d7
[0000974c] 6756                      beq.s      _typify_24
[0000974e] 4287                      clr.l      d7
[00009750] 1e2c 0016                 move.b     22(a4),d7
[00009754] 0c47 0088                 cmpi.w     #$0088,d7
[00009758] 674a                      beq.s      _typify_24
[0000975a] 4287                      clr.l      d7
[0000975c] 1e2c 0016                 move.b     22(a4),d7
[00009760] 0c47 009f                 cmpi.w     #$009F,d7
[00009764] 673e                      beq.s      _typify_24
_typify_23:
[00009766] 246c 0004                 movea.l    4(a4),a2
[0000976a] 508a                      addq.l     #8,a2
[0000976c] 4287                      clr.l      d7
[0000976e] 1e12                      move.b     (a2),d7
[00009770] 0c47 0019                 cmpi.w     #$0019,d7
[00009774] 6700 00e4                 beq        _typify_25
[00009778] 4287                      clr.l      d7
[0000977a] 1e2c 0016                 move.b     22(a4),d7
[0000977e] 0c47 006b                 cmpi.w     #$006B,d7
[00009782] 6600 00e6                 bne        _typify_26
[00009786] 246c 0008                 movea.l    8(a4),a2
[0000978a] 588a                      addq.l     #4,a2
[0000978c] 2e92                      move.l     (a2),(a7)
[0000978e] 45f8 000a                 lea.l      ($0000000A).w,a2
[00009792] d5d7                      adda.l     (a7),a2
[00009794] 4287                      clr.l      d7
[00009796] 3e12                      move.w     (a2),d7
[00009798] 0807 000c                 btst       #12,d7
[0000979c] 6600 00bc                 bne        _typify_25
[000097a0] 6000 00c8                 bra        _typify_26
_typify_24:
[000097a4] 08ee 0004 fffe            bset       #4,-2(a6)
_typify_27:
[000097aa] 2ead 0004                 move.l     4(a5),(a7)
[000097ae] 4878 0040                 pea.l      ($00000040).w
[000097b2] 4eb9 0000 79aa            jsr        _buyattr
[000097b8] 588f                      addq.l     #4,a7
[000097ba] 2b47 0004                 move.l     d7,4(a5)
[000097be] 45f8 000a                 lea.l      ($0000000A).w,a2
[000097c2] d5ed 0004                 adda.l     4(a5),a2
[000097c6] 2e8a                      move.l     a2,(a7)
[000097c8] 2f0c                      move.l     a4,-(a7)
[000097ca] 4eb9 0000 81ce            jsr        _exspace
[000097d0] 588f                      addq.l     #4,a7
[000097d2] 4286                      clr.l      d6
[000097d4] 3c2e fffe                 move.w     -2(a6),d6
[000097d8] 8e86                      or.l       d6,d7
[000097da] 2257                      movea.l    (a7),a1
[000097dc] 3287                      move.w     d7,(a1)
[000097de] 4878 0018                 pea.l      ($00000018).w
[000097e2] 4878 00e2                 pea.l      ($000000E2).w
[000097e6] 4eb9 0000 3252            jsr        _defspace
[000097ec] 508f                      addq.l     #8,a7
[000097ee] 0807 000b                 btst       #11,d7
[000097f2] 6700 fed2                 beq        _typify_18
[000097f6] 45f8 000a                 lea.l      ($0000000A).w,a2
[000097fa] d5ed 0004                 adda.l     4(a5),a2
[000097fe] 4287                      clr.l      d7
[00009800] 3e12                      move.w     (a2),d7
[00009802] 0807 000b                 btst       #11,d7
[00009806] 6600 febe                 bne        _typify_18
[0000980a] 246d 0004                 movea.l    4(a5),a2
[0000980e] 588a                      addq.l     #4,a2
[00009810] 2452                      movea.l    (a2),a2
[00009812] 508a                      addq.l     #8,a2
[00009814] 4287                      clr.l      d7
[00009816] 1e12                      move.b     (a2),d7
[00009818] 0c47 0042                 cmpi.w     #$0042,d7
[0000981c] 6700 fea8                 beq        _typify_18
[00009820] 246d 0004                 movea.l    4(a5),a2
[00009824] 588a                      addq.l     #4,a2
[00009826] 2e92                      move.l     (a2),(a7)
[00009828] 4878 0040                 pea.l      ($00000040).w
[0000982c] 4eb9 0000 79aa            jsr        _buyattr
[00009832] 588f                      addq.l     #4,a7
[00009834] 2e87                      move.l     d7,(a7)
[00009836] 42a7                      clr.l      -(a7)
[00009838] 2f0d                      move.l     a5,-(a7)
[0000983a] 4878 0066                 pea.l      ($00000066).w
[0000983e] 4eb9 0000 7a0e            jsr        _buyop
[00009844] 4fef 000c                 lea.l      12(a7),a7
[00009848] 2a47                      movea.l    d7,a5
[0000984a] 45f8 000a                 lea.l      ($0000000A).w,a2
[0000984e] d5ed 0004                 adda.l     4(a5),a2
[00009852] 34bc 0800                 move.w     #$0800,(a2)
[00009856] 6000 fe6e                 bra        _typify_18
_typify_25:
[0000985a] 2ebc 0002 1a67            move.l     #$00021A67,(a7) "illegal &"
[00009860] 4eb9 0000 3e84            jsr        _p1error
[00009866] 6000 ff42                 bra        _typify_27
_typify_26:
[0000986a] 4287                      clr.l      d7
[0000986c] 1e2c 0016                 move.b     22(a4),d7
[00009870] 0c47 006b                 cmpi.w     #$006B,d7
[00009874] 6700 ff34                 beq        _typify_27
[00009878] 4a2c 0016                 tst.b      22(a4)
[0000987c] 66dc                      bne.s      _typify_25
[0000987e] 4a2c 0015                 tst.b      21(a4)
[00009882] 6600 ff26                 bne        _typify_27
[00009886] 60d2                      bra.s      _typify_25
[00009888] 2e8d                      move.l     a5,(a7)
[0000988a] 4eba f5b0                 jsr        _tfn(pc)
[0000988e] 6000 fe36                 bra        _typify_18
[00009892] 2e8d                      move.l     a5,(a7)
[00009894] 2f0b                      move.l     a3,-(a7)
[00009896] 2f0c                      move.l     a4,-(a7)
[00009898] 4eba f860                 jsr        _tpoints(pc)
[0000989c] 508f                      addq.l     #8,a7
[0000989e] 6000 fe26                 bra        _typify_18
[000098a2] 2ead 0004                 move.l     4(a5),(a7)
[000098a6] 4eb9 0000 85f4            jsr        _stype
[000098ac] 4a87                      tst.l      d7
[000098ae] 6610                      bne.s      _typify_28
[000098b0] 246d 0004                 movea.l    4(a5),a2
[000098b4] 508a                      addq.l     #8,a2
[000098b6] 4287                      clr.l      d7
[000098b8] 1e12                      move.b     (a2),d7
[000098ba] 0c47 0050                 cmpi.w     #$0050,d7
[000098be] 6664                      bne.s      _typify_29
_typify_28:
[000098c0] 246d 0004                 movea.l    4(a5),a2
[000098c4] 508a                      addq.l     #8,a2
[000098c6] 4287                      clr.l      d7
[000098c8] 1e12                      move.b     (a2),d7
[000098ca] 0c47 0040                 cmpi.w     #$0040,d7
[000098ce] 6600 fdf6                 bne        _typify_18
[000098d2] 246c 0004                 movea.l    4(a4),a2
[000098d6] 508a                      addq.l     #8,a2
[000098d8] 4287                      clr.l      d7
[000098da] 1e12                      move.b     (a2),d7
[000098dc] 0c47 0040                 cmpi.w     #$0040,d7
[000098e0] 6600 fde4                 bne        _typify_18
[000098e4] 246c 0004                 movea.l    4(a4),a2
[000098e8] 588a                      addq.l     #4,a2
[000098ea] 2452                      movea.l    (a2),a2
[000098ec] 508a                      addq.l     #8,a2
[000098ee] 4287                      clr.l      d7
[000098f0] 1e12                      move.b     (a2),d7
[000098f2] 0c47 0042                 cmpi.w     #$0042,d7
[000098f6] 6600 fdce                 bne        _typify_18
[000098fa] 45f8 000a                 lea.l      ($0000000A).w,a2
[000098fe] d5ed 0004                 adda.l     4(a5),a2
[00009902] 4287                      clr.l      d7
[00009904] 3e12                      move.w     (a2),d7
[00009906] 0287 0000 0800            andi.l     #$00000800,d7
[0000990c] 45f8 000a                 lea.l      ($0000000A).w,a2
[00009910] d5ec 0004                 adda.l     4(a4),a2
[00009914] 4286                      clr.l      d6
[00009916] 3c12                      move.w     (a2),d6
[00009918] 0286 0000 0800            andi.l     #$00000800,d6
[0000991e] be86                      cmp.l      d6,d7
[00009920] 6700 fda4                 beq        _typify_18
_typify_29:
[00009924] 2ebc 0002 1a5a            move.l     #$00021A5A,(a7) "illegal cast"
[0000992a] 4eb9 0000 3e84            jsr        _p1error
[00009930] 2b7c 0002 0dc2 0004       move.l     #_atint,4(a5)
[00009938] 6000 fd8c                 bra        _typify_18
[0000993c] 246c 0004                 movea.l    4(a4),a2
[00009940] 508a                      addq.l     #8,a2
[00009942] 4287                      clr.l      d7
[00009944] 1e12                      move.b     (a2),d7
[00009946] 0c47 0040                 cmpi.w     #$0040,d7
[0000994a] 6724                      beq.s      _typify_30
[0000994c] 2ebc 0002 1a46            move.l     #$00021A46,(a7) "illegal indirection"
[00009952] 4eb9 0000 3e84            jsr        _p1error
[00009958] 2eac 0004                 move.l     4(a4),(a7)
[0000995c] 4878 0040                 pea.l      ($00000040).w
[00009960] 4eb9 0000 79aa            jsr        _buyattr
[00009966] 588f                      addq.l     #4,a7
[00009968] 2947 0004                 move.l     d7,4(a4)
[0000996c] 6000 fd58                 bra        _typify_18
_typify_30:
[00009970] 246c 0004                 movea.l    4(a4),a2
[00009974] 588a                      addq.l     #4,a2
[00009976] 2b52 0004                 move.l     (a2),4(a5)
[0000997a] 6000 fd4a                 bra        _typify_18
[0000997e] 2ead 0004                 move.l     4(a5),(a7)
[00009982] 4eb9 0000 844a            jsr        _itype
[00009988] 4a87                      tst.l      d7
[0000998a] 6600 fd3a                 bne        _typify_18
[0000998e] 2ebc 0002 1a30            move.l     #$00021A30,(a7) "integer type required"
[00009994] 4eb9 0000 3e84            jsr        _p1error
[0000999a] 6000 fd2a                 bra        _typify_18
[0000999e] 2ead 0004                 move.l     4(a5),(a7)
[000099a2] 4eb9 0000 844a            jsr        _itype
[000099a8] 4a87                      tst.l      d7
[000099aa] 6600 fd1a                 bne        _typify_18
[000099ae] 2ead 0004                 move.l     4(a5),(a7)
[000099b2] 4eb9 0000 8062            jsr        _dtype
[000099b8] 4a87                      tst.l      d7
[000099ba] 6600 fd0a                 bne        _typify_18
[000099be] 2ebc 0002 1a17            move.l     #$00021A17,(a7) "arithmetic type required"
[000099c4] 4eb9 0000 3e84            jsr        _p1error
[000099ca] 6000 fcfa                 bra        _typify_18
[000099ce] 2e8c                      move.l     a4,(a7)
[000099d0] 4eba ef42                 jsr        _docheck(pc)
[000099d4] 2b47 0008                 move.l     d7,8(a5)
[000099d8] 2b6b 0004 0004            move.l     4(a3),4(a5)
[000099de] 6000 fce6                 bra        _typify_18
[000099e2] 2e8d                      move.l     a5,(a7)
[000099e4] 4eba f92c                 jsr        _tquery(pc)
[000099e8] 6000 fcdc                 bra        _typify_18
[000099ec] 1b7c 0088 0016            move.b     #$88,22(a5)
[000099f2] 2e8b                      move.l     a3,(a7)
[000099f4] 2f2c 0004                 move.l     4(a4),-(a7)
[000099f8] 4eba ecae                 jsr        _canass(pc)
[000099fc] 588f                      addq.l     #4,a7
[000099fe] 4a87                      tst.l      d7
[00009a00] 6600 fcc4                 bne        _typify_18
[00009a04] 2ebc 0002 1a04            move.l     #$00021A04,(a7) "illegal assignment"
[00009a0a] 4eb9 0000 3e84            jsr        _p1error
[00009a10] 6000 fcb4                 bra        _typify_18
[00009a14] 246c 0004                 movea.l    4(a4),a2
[00009a18] 508a                      addq.l     #8,a2
[00009a1a] 4287                      clr.l      d7
[00009a1c] 1e12                      move.b     (a2),d7
[00009a1e] 0c47 0040                 cmpi.w     #$0040,d7
[00009a22] 6622                      bne.s      _typify_31
[00009a24] 2eab 0004                 move.l     4(a3),(a7)
[00009a28] 4eb9 0000 844a            jsr        _itype
[00009a2e] 4a87                      tst.l      d7
[00009a30] 6714                      beq.s      _typify_31
[00009a32] 2eac 0004                 move.l     4(a4),(a7)
[00009a36] 2f0b                      move.l     a3,-(a7)
[00009a38] 4eba f1e0                 jsr        _ptify(pc)
[00009a3c] 588f                      addq.l     #4,a7
[00009a3e] 2b47 000c                 move.l     d7,12(a5)
[00009a42] 6000 fc82                 bra        _typify_18
_typify_31:
[00009a46] 246c 0004                 movea.l    4(a4),a2
[00009a4a] 508a                      addq.l     #8,a2
[00009a4c] 4287                      clr.l      d7
[00009a4e] 1e12                      move.b     (a2),d7
[00009a50] 0c47 0040                 cmpi.w     #$0040,d7
[00009a54] 6712                      beq.s      _typify_32
[00009a56] 246b 0004                 movea.l    4(a3),a2
[00009a5a] 508a                      addq.l     #8,a2
[00009a5c] 4287                      clr.l      d7
[00009a5e] 1e12                      move.b     (a2),d7
[00009a60] 0c47 0040                 cmpi.w     #$0040,d7
[00009a64] 6600 fc60                 bne        _typify_18
_typify_32:
[00009a68] 2ebc 0002 19f9            move.l     #$000219F9,(a7) "illegal +="
[00009a6e] 4eb9 0000 3e84            jsr        _p1error
[00009a74] 6000 fc50                 bra        _typify_18
[00009a78] 246c 0004                 movea.l    4(a4),a2
[00009a7c] 508a                      addq.l     #8,a2
[00009a7e] 4287                      clr.l      d7
[00009a80] 1e12                      move.b     (a2),d7
[00009a82] 0c47 0040                 cmpi.w     #$0040,d7
[00009a86] 6628                      bne.s      _typify_33
[00009a88] 2eab 0004                 move.l     4(a3),(a7)
[00009a8c] 4eb9 0000 844a            jsr        _itype
[00009a92] 4a87                      tst.l      d7
[00009a94] 671a                      beq.s      _typify_33
[00009a96] 2eac 0004                 move.l     4(a4),(a7)
[00009a9a] 2f0b                      move.l     a3,-(a7)
[00009a9c] 4eba f17c                 jsr        _ptify(pc)
[00009aa0] 588f                      addq.l     #4,a7
[00009aa2] 2b47 000c                 move.l     d7,12(a5)
[00009aa6] 2b6c 0004 0004            move.l     4(a4),4(a5)
[00009aac] 6000 fc18                 bra        _typify_18
_typify_33:
[00009ab0] 2eac 0004                 move.l     4(a4),(a7)
[00009ab4] 4eb9 0000 844a            jsr        _itype
[00009aba] 4a87                      tst.l      d7
[00009abc] 672a                      beq.s      _typify_34
[00009abe] 246b 0004                 movea.l    4(a3),a2
[00009ac2] 508a                      addq.l     #8,a2
[00009ac4] 4287                      clr.l      d7
[00009ac6] 1e12                      move.b     (a2),d7
[00009ac8] 0c47 0040                 cmpi.w     #$0040,d7
[00009acc] 661a                      bne.s      _typify_34
[00009ace] 2eab 0004                 move.l     4(a3),(a7)
[00009ad2] 2f0c                      move.l     a4,-(a7)
[00009ad4] 4eba f144                 jsr        _ptify(pc)
[00009ad8] 588f                      addq.l     #4,a7
[00009ada] 2b47 0008                 move.l     d7,8(a5)
[00009ade] 2b6b 0004 0004            move.l     4(a3),4(a5)
[00009ae4] 6000 fbe0                 bra        _typify_18
_typify_34:
[00009ae8] 4878 002a                 pea.l      ($0000002A).w
[00009aec] 2f2b 0004                 move.l     4(a3),-(a7)
[00009af0] 2f2c 0004                 move.l     4(a4),-(a7)
[00009af4] 4eba f07e                 jsr        _maxty(pc)
[00009af8] 4fef 000c                 lea.l      12(a7),a7
[00009afc] 2b47 0004                 move.l     d7,4(a5)
[00009b00] 6000 fbc4                 bra        _typify_18
[00009b04] 246c 0004                 movea.l    4(a4),a2
[00009b08] 508a                      addq.l     #8,a2
[00009b0a] 4287                      clr.l      d7
[00009b0c] 1e12                      move.b     (a2),d7
[00009b0e] 0c47 0040                 cmpi.w     #$0040,d7
[00009b12] 6628                      bne.s      _typify_35
[00009b14] 2eab 0004                 move.l     4(a3),(a7)
[00009b18] 4eb9 0000 844a            jsr        _itype
[00009b1e] 4a87                      tst.l      d7
[00009b20] 671a                      beq.s      _typify_35
[00009b22] 2eac 0004                 move.l     4(a4),(a7)
[00009b26] 2f0b                      move.l     a3,-(a7)
[00009b28] 4eba f0f0                 jsr        _ptify(pc)
[00009b2c] 588f                      addq.l     #4,a7
[00009b2e] 2b47 000c                 move.l     d7,12(a5)
[00009b32] 2b6c 0004 0004            move.l     4(a4),4(a5)
[00009b38] 6000 fb8c                 bra        _typify_18
_typify_35:
[00009b3c] 246c 0004                 movea.l    4(a4),a2
[00009b40] 508a                      addq.l     #8,a2
[00009b42] 4287                      clr.l      d7
[00009b44] 1e12                      move.b     (a2),d7
[00009b46] 0c47 0040                 cmpi.w     #$0040,d7
[00009b4a] 6600 00a4                 bne        _typify_36
[00009b4e] 246b 0004                 movea.l    4(a3),a2
[00009b52] 508a                      addq.l     #8,a2
[00009b54] 4287                      clr.l      d7
[00009b56] 1e12                      move.b     (a2),d7
[00009b58] 0c47 0040                 cmpi.w     #$0040,d7
[00009b5c] 6600 0092                 bne        _typify_36
[00009b60] 4297                      clr.l      (a7)
[00009b62] 2f2b 0004                 move.l     4(a3),-(a7)
[00009b66] 2f2c 0004                 move.l     4(a4),-(a7)
[00009b6a] 4eb9 0000 7d40            jsr        _cmptype
[00009b70] 508f                      addq.l     #8,a7
[00009b72] 4a87                      tst.l      d7
[00009b74] 677a                      beq.s      _typify_36
[00009b76] 2ebc 0002 0dc2            move.l     #_atint,(a7)
[00009b7c] 2f0b                      move.l     a3,-(a7)
[00009b7e] 2f0c                      move.l     a4,-(a7)
[00009b80] 4878 00d8                 pea.l      ($000000D8).w
[00009b84] 4eb9 0000 7a0e            jsr        _buyop
[00009b8a] 4fef 000c                 lea.l      12(a7),a7
[00009b8e] 2b47 0008                 move.l     d7,8(a5)
[00009b92] 4297                      clr.l      (a7)
[00009b94] 42a7                      clr.l      -(a7)
[00009b96] 4878 0001                 pea.l      ($00000001).w
[00009b9a] 246c 0004                 movea.l    4(a4),a2
[00009b9e] 588a                      addq.l     #4,a2
[00009ba0] 2f12                      move.l     (a2),-(a7)
[00009ba2] 4eb9 0000 7b74            jsr        _bytes
[00009ba8] 508f                      addq.l     #8,a7
[00009baa] 2f07                      move.l     d7,-(a7)
[00009bac] 42a7                      clr.l      -(a7)
[00009bae] 2f3c 0002 0dc2            move.l     #_atint,-(a7)
[00009bb4] 4eb9 0000 7aec            jsr        _buyterm
[00009bba] 4fef 0010                 lea.l      16(a7),a7
[00009bbe] 2b47 000c                 move.l     d7,12(a5)
[00009bc2] 1b7c 0085 0016            move.b     #$85,22(a5)
[00009bc8] 45f8 000a                 lea.l      ($0000000A).w,a2
[00009bcc] d5ec 0004                 adda.l     4(a4),a2
[00009bd0] 4287                      clr.l      d7
[00009bd2] 3e12                      move.w     (a2),d7
[00009bd4] 0807 000b                 btst       #11,d7
[00009bd8] 6708                      beq.s      _typify_37
[00009bda] 2e3c 0002 0de6            move.l     #_atlong,d7
[00009be0] 6006                      bra.s      _typify_38
_typify_37:
[00009be2] 2e3c 0002 0dc2            move.l     #_atint,d7
_typify_38:
[00009be8] 2b47 0004                 move.l     d7,4(a5)
[00009bec] 6000 fad8                 bra        _typify_18
_typify_36:
[00009bf0] 4878 002a                 pea.l      ($0000002A).w
[00009bf4] 2f2b 0004                 move.l     4(a3),-(a7)
[00009bf8] 2f2c 0004                 move.l     4(a4),-(a7)
[00009bfc] 4eba ef76                 jsr        _maxty(pc)
[00009c00] 4fef 000c                 lea.l      12(a7),a7
[00009c04] 2b47 0004                 move.l     d7,4(a5)
[00009c08] 6000 fabc                 bra        _typify_18
[00009c0c] 4287                      clr.l      d7
[00009c0e] 1e2d 0016                 move.b     22(a5),d7
[00009c12] 0c47 0095                 cmpi.w     #$0095,d7
[00009c16] 670c                      beq.s      _typify_39
[00009c18] 4287                      clr.l      d7
[00009c1a] 1e2d 0016                 move.b     22(a5),d7
[00009c1e] 0c47 0090                 cmpi.w     #$0090,d7
[00009c22] 660e                      bne.s      _typify_40
_typify_39:
[00009c24] 2e8b                      move.l     a3,(a7)
[00009c26] 2f0c                      move.l     a4,-(a7)
[00009c28] 4eb9 0000 9d1e            jsr        _untest
[00009c2e] 588f                      addq.l     #4,a7
[00009c30] 600c                      bra.s      _typify_41
_typify_40:
[00009c32] 2e8c                      move.l     a4,(a7)
[00009c34] 2f0b                      move.l     a3,-(a7)
[00009c36] 4eb9 0000 9d1e            jsr        _untest
[00009c3c] 588f                      addq.l     #4,a7
_typify_41:
[00009c3e] 246c 0004                 movea.l    4(a4),a2
[00009c42] 508a                      addq.l     #8,a2
[00009c44] 4287                      clr.l      d7
[00009c46] 1e12                      move.b     (a2),d7
[00009c48] 0c47 0040                 cmpi.w     #$0040,d7
[00009c4c] 6610                      bne.s      _typify_42
[00009c4e] 2eab 0004                 move.l     4(a3),(a7)
[00009c52] 4eb9 0000 844a            jsr        _itype
[00009c58] 4a87                      tst.l      d7
[00009c5a] 6600 fa6a                 bne        _typify_18
_typify_42:
[00009c5e] 2eac 0004                 move.l     4(a4),(a7)
[00009c62] 4eb9 0000 844a            jsr        _itype
[00009c68] 4a87                      tst.l      d7
[00009c6a] 6712                      beq.s      _typify_43
[00009c6c] 246b 0004                 movea.l    4(a3),a2
[00009c70] 508a                      addq.l     #8,a2
[00009c72] 4287                      clr.l      d7
[00009c74] 1e12                      move.b     (a2),d7
[00009c76] 0c47 0040                 cmpi.w     #$0040,d7
[00009c7a] 6700 fa4a                 beq        _typify_18
_typify_43:
[00009c7e] 246c 0004                 movea.l    4(a4),a2
[00009c82] 508a                      addq.l     #8,a2
[00009c84] 4287                      clr.l      d7
[00009c86] 1e12                      move.b     (a2),d7
[00009c88] 0c47 0040                 cmpi.w     #$0040,d7
[00009c8c] 6628                      bne.s      _typify_44
[00009c8e] 246b 0004                 movea.l    4(a3),a2
[00009c92] 508a                      addq.l     #8,a2
[00009c94] 4287                      clr.l      d7
[00009c96] 1e12                      move.b     (a2),d7
[00009c98] 0c47 0040                 cmpi.w     #$0040,d7
[00009c9c] 6618                      bne.s      _typify_44
[00009c9e] 4297                      clr.l      (a7)
[00009ca0] 2f2b 0004                 move.l     4(a3),-(a7)
[00009ca4] 2f2c 0004                 move.l     4(a4),-(a7)
[00009ca8] 4eb9 0000 7d40            jsr        _cmptype
[00009cae] 508f                      addq.l     #8,a7
[00009cb0] 4a87                      tst.l      d7
[00009cb2] 6600 fa12                 bne        _typify_18
_typify_44:
[00009cb6] 246c 0004                 movea.l    4(a4),a2
[00009cba] 508a                      addq.l     #8,a2
[00009cbc] 4287                      clr.l      d7
[00009cbe] 1e12                      move.b     (a2),d7
[00009cc0] 0c47 0040                 cmpi.w     #$0040,d7
[00009cc4] 6712                      beq.s      _typify_45
[00009cc6] 246b 0004                 movea.l    4(a3),a2
[00009cca] 508a                      addq.l     #8,a2
[00009ccc] 4287                      clr.l      d7
[00009cce] 1e12                      move.b     (a2),d7
[00009cd0] 0c47 0040                 cmpi.w     #$0040,d7
[00009cd4] 6600 f9f0                 bne        _typify_18
_typify_45:
[00009cd8] 2e8b                      move.l     a3,(a7)
[00009cda] 2f2c 0004                 move.l     4(a4),-(a7)
[00009cde] 4eba e9c8                 jsr        _canass(pc)
[00009ce2] 588f                      addq.l     #4,a7
[00009ce4] 4a87                      tst.l      d7
[00009ce6] 6600 f9de                 bne        _typify_18
[00009cea] 2ebc 0002 19e6            move.l     #$000219E6,(a7) "illegal comparison"
[00009cf0] 4eb9 0000 3e84            jsr        _p1error
[00009cf6] 6000 f9ce                 bra        _typify_18
_typify_19:
[00009cfa] 3e2e fffc                 move.w     -4(a6),d7
[00009cfe] 48c7                      ext.l      d7
[00009d00] 0807 0008                 btst       #8,d7
[00009d04] 670e                      beq.s      _typify_20
[00009d06] 2ead 0004                 move.l     4(a5),(a7)
[00009d0a] 4eb9 0000 84da            jsr        _maxify
[00009d10] 2b47 0004                 move.l     d7,4(a5)
_typify_20:
[00009d14] 2e0d                      move.l     a5,d7
[00009d16] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00009d1a] 4e5e                      unlk       a6
[00009d1c] 4e75                      rts

_untest:
[00009d1e] 4e56 0000                 link       a6,#0
[00009d22] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00009d26] 2a6e 0008                 movea.l    8(a6),a5
[00009d2a] 286e 000c                 movea.l    12(a6),a4
[00009d2e] 246d 0004                 movea.l    4(a5),a2
[00009d32] 508a                      addq.l     #8,a2
[00009d34] 4285                      clr.l      d5
[00009d36] 1a12                      move.b     (a2),d5
[00009d38] 4ab9 0002 0b92            tst.l      _strictfl
[00009d3e] 6728                      beq.s      _untest_1
[00009d40] 2e8c                      move.l     a4,(a7)
[00009d42] 4eb9 0000 83b6            jsr        _iscons
[00009d48] 4a87                      tst.l      d7
[00009d4a] 671c                      beq.s      _untest_1
[00009d4c] 4aac 0008                 tst.l      8(a4)
[00009d50] 6616                      bne.s      _untest_1
[00009d52] 0c85 0000 0040            cmpi.l     #$00000040,d5
[00009d58] 6716                      beq.s      _untest_2
[00009d5a] 2ead 0004                 move.l     4(a5),(a7)
[00009d5e] 4eb9 0000 83fa            jsr        _issigned
[00009d64] 4a87                      tst.l      d7
[00009d66] 6708                      beq.s      _untest_2
_untest_1:
[00009d68] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00009d6c] 4e5e                      unlk       a6
[00009d6e] 4e75                      rts
_untest_2:
[00009d70] 2ebc 0002 1a9c            move.l     #$00021A9C,(a7) "illegal unsigned compare"
[00009d76] 4eb9 0000 3e84            jsr        _p1error
[00009d7c] 60ea                      bra.s      _untest_1

_fill:
[00009d7e] 4e56 0000                 link       a6,#0
[00009d82] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00009d86] 2a6e 0008                 movea.l    8(a6),a5
[00009d8a] 2a2e 000c                 move.l     12(a6),d5
_fill_2:
[00009d8e] 4a85                      tst.l      d5
[00009d90] 6708                      beq.s      _fill_1
[00009d92] 1aee 0013                 move.b     19(a6),(a5)+
[00009d96] 5385                      subq.l     #1,d5
[00009d98] 60f4                      bra.s      _fill_2
_fill_1:
[00009d9a] 2e2e 000c                 move.l     12(a6),d7
[00009d9e] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00009da2] 4e5e                      unlk       a6
[00009da4] 4e75                      rts

_frelst:
[00009da6] 4e56 0000                 link       a6,#0
[00009daa] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00009dae] 2a6e 0008                 movea.l    8(a6),a5
[00009db2] 286e 000c                 movea.l    12(a6),a4
_frelst_2:
[00009db6] 2e0d                      move.l     a5,d7
[00009db8] 6714                      beq.s      _frelst_1
[00009dba] bbcc                      cmpa.l     a4,a5
[00009dbc] 6710                      beq.s      _frelst_1
[00009dbe] 2e95                      move.l     (a5),(a7)
[00009dc0] 2f0d                      move.l     a5,-(a7)
[00009dc2] 4eb9 0000 aa76            jsr        _free
[00009dc8] 588f                      addq.l     #4,a7
[00009dca] 2a47                      movea.l    d7,a5
[00009dcc] 60e8                      bra.s      _frelst_2
_frelst_1:
[00009dce] 2e0d                      move.l     a5,d7
[00009dd0] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00009dd4] 4e5e                      unlk       a6
[00009dd6] 4e75                      rts

x9dd8:
[00009dd8] 4e56 0000                 link       a6,#0
[00009ddc] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00009de0] 2a6e 0008                 movea.l    8(a6),a5
[00009de4] 286e 000c                 movea.l    12(a6),a4
[00009de8] 4297                      clr.l      (a7)
[00009dea] 4eb9 0000 a43e            jsr        _usage
[00009df0] 2a07                      move.l     d7,d5
x9dd8_7:
[00009df2] 4a15                      tst.b      (a5)
[00009df4] 6720                      beq.s      x9dd8_1
[00009df6] 4287                      clr.l      d7
[00009df8] 1e15                      move.b     (a5),d7
[00009dfa] 0c47 0046                 cmpi.w     #$0046,d7
[00009dfe] 673e                      beq.s      x9dd8_2
[00009e00] 2e85                      move.l     d5,(a7)
[00009e02] 2f0d                      move.l     a5,-(a7)
[00009e04] 4878 0002                 pea.l      ($00000002).w
[00009e08] 4eb9 0000 a2e8            jsr        $0000A2E8
[00009e0e] 508f                      addq.l     #8,a7
[00009e10] 2a07                      move.l     d7,d5
[00009e12] 6000 0098                 bra        x9dd8_3
x9dd8_1:
[00009e16] 4878 0001                 pea.l      ($00000001).w
[00009e1a] 2f3c 0002 1ab6            move.l     #$00021AB6,-(a7)
[00009e20] 4878 0002                 pea.l      ($00000002).w
[00009e24] 4eb9 0000 b106            jsr        _write
[00009e2a] 4fef 000c                 lea.l      12(a7),a7
[00009e2e] 4297                      clr.l      (a7)
[00009e30] 4eb9 0000 0080            jsr        _exit
[00009e36] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00009e3a] 4e5e                      unlk       a6
[00009e3c] 4e75                      rts
x9dd8_2:
[00009e3e] 4878 0002                 pea.l      ($00000002).w
[00009e42] 2f3c 0002 1ac0            move.l     #$00021AC0,-(a7)
[00009e48] 4878 0002                 pea.l      ($00000002).w
[00009e4c] 4eb9 0000 b106            jsr        _write
[00009e52] 4fef 000c                 lea.l      12(a7),a7
[00009e56] da87                      add.l      d7,d5
x9dd8_9:
[00009e58] 4287                      clr.l      d7
[00009e5a] 1e14                      move.b     (a4),d7
[00009e5c] 0c47 003a                 cmpi.w     #$003A,d7
[00009e60] 6730                      beq.s      x9dd8_4
[00009e62] 4287                      clr.l      d7
[00009e64] 1e14                      move.b     (a4),d7
[00009e66] 0c47 002c                 cmpi.w     #$002C,d7
[00009e6a] 6646                      bne.s      x9dd8_5
[00009e6c] 4287                      clr.l      d7
[00009e6e] 1e2c 0001                 move.b     1(a4),d7
[00009e72] 0c47 003a                 cmpi.w     #$003A,d7
[00009e76] 673a                      beq.s      x9dd8_5
[00009e78] 2e85                      move.l     d5,(a7)
[00009e7a] 2f3c 0002 1abe            move.l     #$00021ABE,-(a7)
[00009e80] 4878 0002                 pea.l      ($00000002).w
[00009e84] 4eb9 0000 a2e8            jsr        $0000A2E8
[00009e8a] 508f                      addq.l     #8,a7
[00009e8c] 2a07                      move.l     d7,d5
[00009e8e] 6000 0080                 bra        x9dd8_6 ; possibly optimized to short
x9dd8_4:
[00009e92] 4878 0001                 pea.l      ($00000001).w
[00009e96] 2f3c 0002 1ab8            move.l     #$00021AB8,-(a7)
[00009e9c] 4878 0002                 pea.l      ($00000002).w
[00009ea0] 4eb9 0000 b106            jsr        _write
[00009ea6] 4fef 000c                 lea.l      12(a7),a7
[00009eaa] da87                      add.l      d7,d5
x9dd8_3:
[00009eac] 528d                      addq.l     #1,a5
[00009eae] 6000 ff42                 bra        x9dd8_7
x9dd8_5:
[00009eb2] 4287                      clr.l      d7
[00009eb4] 1e14                      move.b     (a4),d7
[00009eb6] 0c47 003e                 cmpi.w     #$003E,d7
[00009eba] 663e                      bne.s      x9dd8_8
[00009ebc] 4878 0001                 pea.l      ($00000001).w
[00009ec0] 2f3c 0002 1abc            move.l     #$00021ABC,-(a7)
[00009ec6] 4878 0002                 pea.l      ($00000002).w
[00009eca] 4eb9 0000 b106            jsr        _write
[00009ed0] 4fef 000c                 lea.l      12(a7),a7
[00009ed4] da87                      add.l      d7,d5
[00009ed6] 4287                      clr.l      d7
[00009ed8] 1e2c 0001                 move.b     1(a4),d7
[00009edc] 0c47 003a                 cmpi.w     #$003A,d7
[00009ee0] 672e                      beq.s      x9dd8_6
[00009ee2] 2e85                      move.l     d5,(a7)
[00009ee4] 2f3c 0002 1aba            move.l     #$00021ABA,-(a7)
[00009eea] 4878 0002                 pea.l      ($00000002).w
[00009eee] 4eb9 0000 a2e8            jsr        $0000A2E8
[00009ef4] 508f                      addq.l     #8,a7
[00009ef6] 2a07                      move.l     d7,d5
[00009ef8] 6016                      bra.s      x9dd8_6
x9dd8_8:
[00009efa] 4878 0001                 pea.l      ($00000001).w
[00009efe] 2f0c                      move.l     a4,-(a7)
[00009f00] 4878 0002                 pea.l      ($00000002).w
[00009f04] 4eb9 0000 b106            jsr        _write
[00009f0a] 4fef 000c                 lea.l      12(a7),a7
[00009f0e] da87                      add.l      d7,d5
x9dd8_6:
[00009f10] 528c                      addq.l     #1,a4
[00009f12] 6000 ff44                 bra        x9dd8_9

_getflags:
[00009f16] 4e56 ffe2                 link       a6,#-30
[00009f1a] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00009f1e] 246e 000c                 movea.l    12(a6),a2
[00009f22] 5892                      addq.l     #4,(a2)
_getflags_3:
[00009f24] 246e 0008                 movea.l    8(a6),a2
[00009f28] 4a92                      tst.l      (a2)
[00009f2a] 6730                      beq.s      _getflags_1
[00009f2c] 246e 0008                 movea.l    8(a6),a2
[00009f30] 5392                      subq.l     #1,(a2)
[00009f32] 6728                      beq.s      _getflags_1
[00009f34] 246e 000c                 movea.l    12(a6),a2
[00009f38] 2452                      movea.l    (a2),a2
[00009f3a] 2852                      movea.l    (a2),a4
[00009f3c] 2ebc 0002 1b0b            move.l     #$00021B0B,(a7)
[00009f42] 2f0c                      move.l     a4,-(a7)
[00009f44] 4eb9 0000 a4e8            jsr        _cmpstr
[00009f4a] 588f                      addq.l     #4,a7
[00009f4c] 4a87                      tst.l      d7
[00009f4e] 671e                      beq.s      _getflags_2
[00009f50] 246e 0008                 movea.l    8(a6),a2
[00009f54] 5392                      subq.l     #1,(a2)
[00009f56] 246e 000c                 movea.l    12(a6),a2
[00009f5a] 5892                      addq.l     #4,(a2)
_getflags_1:
[00009f5c] 4287                      clr.l      d7
[00009f5e] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00009f62] 4e5e                      unlk       a6
[00009f64] 4e75                      rts
_getflags_10:
[00009f66] 246e 000c                 movea.l    12(a6),a2
[00009f6a] 5892                      addq.l     #4,(a2)
[00009f6c] 60b6                      bra.s      _getflags_3
_getflags_2:
[00009f6e] 2ebc 0002 1b09            move.l     #$00021B09,(a7)
[00009f74] 2f0c                      move.l     a4,-(a7)
[00009f76] 4eb9 0000 a4e8            jsr        _cmpstr
[00009f7c] 588f                      addq.l     #4,a7
[00009f7e] 4a87                      tst.l      d7
[00009f80] 66da                      bne.s      _getflags_1
[00009f82] 4287                      clr.l      d7
[00009f84] 1e14                      move.b     (a4),d7
[00009f86] 0c47 002d                 cmpi.w     #$002D,d7
[00009f8a] 670a                      beq.s      _getflags_4
[00009f8c] 4287                      clr.l      d7
[00009f8e] 1e14                      move.b     (a4),d7
[00009f90] 0c47 002b                 cmpi.w     #$002B,d7
[00009f94] 66c6                      bne.s      _getflags_1
_getflags_4:
[00009f96] 4287                      clr.l      d7
[00009f98] 1e14                      move.b     (a4),d7
[00009f9a] 0c47 002d                 cmpi.w     #$002D,d7
[00009f9e] 6602                      bne.s      _getflags_5
[00009fa0] 528c                      addq.l     #1,a4
_getflags_5:
[00009fa2] 4878 0004                 pea.l      ($00000004).w
[00009fa6] 2f0c                      move.l     a4,-(a7)
[00009fa8] 2f3c 0002 1b04            move.l     #$00021B04,-(a7)
[00009fae] 4eb9 0000 ad76            jsr        _cmpbuf
[00009fb4] 4fef 000c                 lea.l      12(a7),a7
[00009fb8] 4a87                      tst.l      d7
[00009fba] 6768                      beq.s      _getflags_6
[00009fbc] 4878 003a                 pea.l      ($0000003A).w
[00009fc0] 2f2e 0010                 move.l     16(a6),-(a7)
[00009fc4] 4eb9 0000 a7a6            jsr        _scnstr
[00009fca] 508f                      addq.l     #8,a7
[00009fcc] 3d47 fff2                 move.w     d7,-14(a6)
[00009fd0] 3e2e fff2                 move.w     -14(a6),d7
[00009fd4] 48c7                      ext.l      d7
[00009fd6] 2447                      movea.l    d7,a2
[00009fd8] d5ee 0010                 adda.l     16(a6),a2
[00009fdc] 4a12                      tst.b      (a2)
[00009fde] 6616                      bne.s      _getflags_7
[00009fe0] 4287                      clr.l      d7
[00009fe2] 1e2c 0004                 move.b     4(a4),d7
[00009fe6] 0c47 003a                 cmpi.w     #$003A,d7
[00009fea] 670a                      beq.s      _getflags_7
[00009fec] 2e0c                      move.l     a4,d7
[00009fee] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00009ff2] 4e5e                      unlk       a6
[00009ff4] 4e75                      rts
_getflags_7:
[00009ff6] 2eae 0010                 move.l     16(a6),(a7)
[00009ffa] 4287                      clr.l      d7
[00009ffc] 1e2c 0004                 move.b     4(a4),d7
[0000a000] 0c47 003a                 cmpi.w     #$003A,d7
[0000a004] 670e                      beq.s      _getflags_8
[0000a006] 2e2e 0010                 move.l     16(a6),d7
[0000a00a] 3c2e fff2                 move.w     -14(a6),d6
[0000a00e] 48c6                      ext.l      d6
[0000a010] de86                      add.l      d6,d7
[0000a012] 6006                      bra.s      _getflags_9
_getflags_8:
[0000a014] 2e3c 0002 0000            move.l     #__data,d7
_getflags_9:
[0000a01a] 2f07                      move.l     d7,-(a7)
[0000a01c] 5297                      addq.l     #1,(a7)
[0000a01e] 4eba fdb8                 jsr        $00009DD8(pc)
[0000a022] 588f                      addq.l     #4,a7
_getflags_6:
[0000a024] 4a14                      tst.b      (a4)
[0000a026] 6700 ff3e                 beq        _getflags_10
[0000a02a] 42ae fff4                 clr.l      -12(a6)
[0000a02e] 42ae fff8                 clr.l      -8(a6)
[0000a032] 45ee 0014                 lea.l      20(a6),a2
[0000a036] 2d4a ffea                 move.l     a2,-22(a6)
[0000a03a] 264c                      movea.l    a4,a3
[0000a03c] 2a6e 0010                 movea.l    16(a6),a5
[0000a040] 42ae fffc                 clr.l      -4(a6)
_getflags_18:
[0000a044] 4aae fffc                 tst.l      -4(a6)
[0000a048] 66da                      bne.s      _getflags_6
[0000a04a] 4287                      clr.l      d7
[0000a04c] 1e15                      move.b     (a5),d7
[0000a04e] 41f9 0002 1ac4            lea.l      $00021AC4,a0
[0000a054] 4ef9 0000 a7dc            jmp        a.switch
[0000a05a] 7001                      moveq.l    #1,d0
[0000a05c] 2d40 fff4                 move.l     d0,-12(a6)
[0000a060] 4a13                      tst.b      (a3)
[0000a062] 6704                      beq.s      _getflags_11
[0000a064] 2e0b                      move.l     a3,d7
[0000a066] 6016                      bra.s      _getflags_12
_getflags_11:
[0000a068] 246e 0008                 movea.l    8(a6),a2
[0000a06c] 5392                      subq.l     #1,(a2)
[0000a06e] 670c                      beq.s      _getflags_13
[0000a070] 246e 000c                 movea.l    12(a6),a2
[0000a074] 5892                      addq.l     #4,(a2)
[0000a076] 2452                      movea.l    (a2),a2
[0000a078] 2e12                      move.l     (a2),d7
[0000a07a] 6002                      bra.s      _getflags_12
_getflags_13:
[0000a07c] 2e0b                      move.l     a3,d7
_getflags_12:
[0000a07e] 2d47 ffe2                 move.l     d7,-30(a6)
[0000a082] 266e ffe2                 movea.l    -30(a6),a3
[0000a086] 2d4b ffe6                 move.l     a3,-26(a6)
_getflags_17:
[0000a08a] 246e ffe6                 movea.l    -26(a6),a2
[0000a08e] 4a12                      tst.b      (a2)
[0000a090] 672e                      beq.s      _getflags_14
[0000a092] 246e ffe6                 movea.l    -26(a6),a2
[0000a096] 4287                      clr.l      d7
[0000a098] 1e12                      move.b     (a2),d7
[0000a09a] 0c47 005c                 cmpi.w     #$005C,d7
[0000a09e] 6610                      bne.s      _getflags_15
[0000a0a0] 4297                      clr.l      (a7)
[0000a0a2] 486e ffe6                 pea.l      -26(a6)
[0000a0a6] 4eb9 0000 a5c8            jsr        _doesc
[0000a0ac] 588f                      addq.l     #4,a7
[0000a0ae] 6008                      bra.s      _getflags_16
_getflags_15:
[0000a0b0] 246e ffe6                 movea.l    -26(a6),a2
[0000a0b4] 4287                      clr.l      d7
[0000a0b6] 1e12                      move.b     (a2),d7
_getflags_16:
[0000a0b8] 16c7                      move.b     d7,(a3)+
[0000a0ba] 52ae ffe6                 addq.l     #1,-26(a6)
[0000a0be] 60ca                      bra.s      _getflags_17
_getflags_14:
[0000a0c0] 4213                      clr.b      (a3)
_getflags_19:
[0000a0c2] 528d                      addq.l     #1,a5
[0000a0c4] 6000 ff7e                 bra        _getflags_18
[0000a0c8] 60f8                      bra.s      _getflags_19
[0000a0ca] 7001                      moveq.l    #1,d0
[0000a0cc] 2d40 fff4                 move.l     d0,-12(a6)
[0000a0d0] 4287                      clr.l      d7
[0000a0d2] 1e13                      move.b     (a3),d7
[0000a0d4] 0c47 005c                 cmpi.w     #$005C,d7
[0000a0d8] 670a                      beq.s      _getflags_20
[0000a0da] 4287                      clr.l      d7
[0000a0dc] 1e13                      move.b     (a3),d7
[0000a0de] 2d47 ffe2                 move.l     d7,-30(a6)
[0000a0e2] 601a                      bra.s      _getflags_21
_getflags_20:
[0000a0e4] 2d4b ffe6                 move.l     a3,-26(a6)
[0000a0e8] 4297                      clr.l      (a7)
[0000a0ea] 486e ffe6                 pea.l      -26(a6)
[0000a0ee] 4eb9 0000 a5c8            jsr        _doesc
[0000a0f4] 588f                      addq.l     #4,a7
[0000a0f6] 2d47 ffe2                 move.l     d7,-30(a6)
[0000a0fa] 266e ffe6                 movea.l    -26(a6),a3
_getflags_21:
[0000a0fe] 4a13                      tst.b      (a3)
[0000a100] 67c0                      beq.s      _getflags_19
[0000a102] 528b                      addq.l     #1,a3
[0000a104] 60bc                      bra.s      _getflags_19
[0000a106] 4a13                      tst.b      (a3)
[0000a108] 6618                      bne.s      _getflags_22
[0000a10a] 246e 0008                 movea.l    8(a6),a2
[0000a10e] 5392                      subq.l     #1,(a2)
[0000a110] 670c                      beq.s      _getflags_23
[0000a112] 246e 000c                 movea.l    12(a6),a2
[0000a116] 5892                      addq.l     #4,(a2)
[0000a118] 2452                      movea.l    (a2),a2
[0000a11a] 2e12                      move.l     (a2),d7
[0000a11c] 6002                      bra.s      _getflags_24
_getflags_23:
[0000a11e] 2e0b                      move.l     a3,d7
_getflags_24:
[0000a120] 2647                      movea.l    d7,a3
_getflags_22:
[0000a122] 4878 0001                 pea.l      ($00000001).w
[0000a126] 486e ffee                 pea.l      -18(a6)
[0000a12a] 2f0b                      move.l     a3,-(a7)
[0000a12c] 4eb9 0000 aef4            jsr        _lenstr
[0000a132] 588f                      addq.l     #4,a7
[0000a134] 2f07                      move.l     d7,-(a7)
[0000a136] 2f0b                      move.l     a3,-(a7)
[0000a138] 4eb9 0000 ab38            jsr        _btol
[0000a13e] 4fef 0010                 lea.l      16(a7),a7
[0000a142] d7c7                      adda.l     d7,a3
[0000a144] 4a13                      tst.b      (a3)
[0000a146] 6604                      bne.s      _getflags_25
[0000a148] 7e01                      moveq.l    #1,d7
[0000a14a] 6002                      bra.s      _getflags_26
_getflags_25:
[0000a14c] 4287                      clr.l      d7
_getflags_26:
[0000a14e] 2d47 fff4                 move.l     d7,-12(a6)
[0000a152] 4aae fff4                 tst.l      -12(a6)
[0000a156] 6616                      bne.s      _getflags_27
[0000a158] 4878 003a                 pea.l      ($0000003A).w
[0000a15c] 2f0d                      move.l     a5,-(a7)
[0000a15e] 4eb9 0000 a7a6            jsr        _scnstr
[0000a164] 508f                      addq.l     #8,a7
[0000a166] 5387                      subq.l     #1,d7
[0000a168] dbc7                      adda.l     d7,a5
[0000a16a] 6000 ff56                 bra        _getflags_19
_getflags_27:
[0000a16e] 4287                      clr.l      d7
[0000a170] 1e2d 0001                 move.b     1(a5),d7
[0000a174] 0c47 0023                 cmpi.w     #$0023,d7
[0000a178] 660c                      bne.s      _getflags_28
[0000a17a] 528d                      addq.l     #1,a5
[0000a17c] 7001                      moveq.l    #1,d0
[0000a17e] 2d40 fff8                 move.l     d0,-8(a6)
[0000a182] 6000 ff3e                 bra        _getflags_19
_getflags_28:
[0000a186] 2d6e ffee ffe2            move.l     -18(a6),-30(a6)
[0000a18c] 6000 ff34                 bra        _getflags_19
[0000a190] 4aae fff4                 tst.l      -12(a6)
[0000a194] 6712                      beq.s      _getflags_29
[0000a196] 4aae fff8                 tst.l      -8(a6)
[0000a19a] 671a                      beq.s      _getflags_30
[0000a19c] 246e ffea                 movea.l    -22(a6),a2
[0000a1a0] 2452                      movea.l    (a2),a2
[0000a1a2] 24ae ffee                 move.l     -18(a6),(a2)
[0000a1a6] 6018                      bra.s      _getflags_31
_getflags_29:
[0000a1a8] 4a15                      tst.b      (a5)
[0000a1aa] 6620                      bne.s      _getflags_32
[0000a1ac] 2e0c                      move.l     a4,d7
[0000a1ae] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000a1b2] 4e5e                      unlk       a6
[0000a1b4] 4e75                      rts
_getflags_30:
[0000a1b6] 246e ffea                 movea.l    -22(a6),a2
[0000a1ba] 2452                      movea.l    (a2),a2
[0000a1bc] 24ae ffe2                 move.l     -30(a6),(a2)
_getflags_31:
[0000a1c0] 284b                      movea.l    a3,a4
[0000a1c2] 7001                      moveq.l    #1,d0
[0000a1c4] 2d40 fffc                 move.l     d0,-4(a6)
[0000a1c8] 6000 fef8                 bra        _getflags_19
_getflags_32:
[0000a1cc] 4287                      clr.l      d7
[0000a1ce] 1e15                      move.b     (a5),d7
[0000a1d0] 0c47 003a                 cmpi.w     #$003A,d7
[0000a1d4] 6612                      bne.s      _getflags_33
[0000a1d6] 2eae 0010                 move.l     16(a6),(a7)
[0000a1da] 528d                      addq.l     #1,a5
[0000a1dc] 2f0d                      move.l     a5,-(a7)
[0000a1de] 4eba fbf8                 jsr        $00009DD8(pc)
[0000a1e2] 588f                      addq.l     #4,a7
[0000a1e4] 6000 fedc                 bra        _getflags_19
_getflags_33:
[0000a1e8] 58ae ffea                 addq.l     #4,-22(a6)
[0000a1ec] 264c                      movea.l    a4,a3
[0000a1ee] 6000 fed2                 bra        _getflags_19
[0000a1f2] 4aae fff4                 tst.l      -12(a6)
[0000a1f6] 660a                      bne.s      _getflags_34
[0000a1f8] 58ae ffea                 addq.l     #4,-22(a6)
[0000a1fc] 264c                      movea.l    a4,a3
[0000a1fe] 6000 fec2                 bra        _getflags_19
_getflags_34:
[0000a202] 246e ffea                 movea.l    -22(a6),a2
[0000a206] 2452                      movea.l    (a2),a2
[0000a208] 4a92                      tst.l      (a2)
[0000a20a] 663c                      bne.s      _getflags_35
[0000a20c] 4878 003a                 pea.l      ($0000003A).w
[0000a210] 2f0d                      move.l     a5,-(a7)
[0000a212] 4eb9 0000 a7a6            jsr        _scnstr
[0000a218] 508f                      addq.l     #8,a7
[0000a21a] 3d47 fff2                 move.w     d7,-14(a6)
[0000a21e] 3e2e fff2                 move.w     -14(a6),d7
[0000a222] 48c7                      ext.l      d7
[0000a224] 2447                      movea.l    d7,a2
[0000a226] d5cd                      adda.l     a5,a2
[0000a228] 4a12                      tst.b      (a2)
[0000a22a] 673e                      beq.s      _getflags_36
[0000a22c] 2eae 0010                 move.l     16(a6),(a7)
[0000a230] 3e2e fff2                 move.w     -14(a6),d7
[0000a234] 48c7                      ext.l      d7
[0000a236] 45ed 0001                 lea.l      1(a5),a2
[0000a23a] de8a                      add.l      a2,d7
[0000a23c] 2f07                      move.l     d7,-(a7)
[0000a23e] 4eba fb98                 jsr        $00009DD8(pc)
[0000a242] 588f                      addq.l     #4,a7
[0000a244] 6000 fe7c                 bra        _getflags_19
_getflags_35:
[0000a248] 4aae fff8                 tst.l      -8(a6)
[0000a24c] 6726                      beq.s      _getflags_37
[0000a24e] 246e ffea                 movea.l    -22(a6),a2
[0000a252] 2452                      movea.l    (a2),a2
[0000a254] 5392                      subq.l     #1,(a2)
[0000a256] 2e12                      move.l     (a2),d7
[0000a258] e587                      asl.l      #2,d7
[0000a25a] 246e ffea                 movea.l    -22(a6),a2
[0000a25e] 2452                      movea.l    (a2),a2
[0000a260] 588a                      addq.l     #4,a2
[0000a262] d5c7                      adda.l     d7,a2
[0000a264] 24ae ffee                 move.l     -18(a6),(a2)
[0000a268] 6024                      bra.s      _getflags_38
_getflags_36:
[0000a26a] 2e0c                      move.l     a4,d7
[0000a26c] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000a270] 4e5e                      unlk       a6
[0000a272] 4e75                      rts
_getflags_37:
[0000a274] 246e ffea                 movea.l    -22(a6),a2
[0000a278] 2452                      movea.l    (a2),a2
[0000a27a] 5392                      subq.l     #1,(a2)
[0000a27c] 2e12                      move.l     (a2),d7
[0000a27e] e587                      asl.l      #2,d7
[0000a280] 246e ffea                 movea.l    -22(a6),a2
[0000a284] 2452                      movea.l    (a2),a2
[0000a286] 588a                      addq.l     #4,a2
[0000a288] d5c7                      adda.l     d7,a2
[0000a28a] 24ae ffe2                 move.l     -30(a6),(a2)
_getflags_38:
[0000a28e] 284b                      movea.l    a3,a4
[0000a290] 7001                      moveq.l    #1,d0
[0000a292] 2d40 fffc                 move.l     d0,-4(a6)
[0000a296] 6000 fe2a                 bra        _getflags_19
[0000a29a] 4287                      clr.l      d7
[0000a29c] 1e15                      move.b     (a5),d7
[0000a29e] 4286                      clr.l      d6
[0000a2a0] 1c13                      move.b     (a3),d6
[0000a2a2] be86                      cmp.l      d6,d7
[0000a2a4] 6612                      bne.s      _getflags_39
[0000a2a6] 7001                      moveq.l    #1,d0
[0000a2a8] 2d40 fff4                 move.l     d0,-12(a6)
[0000a2ac] 7001                      moveq.l    #1,d0
[0000a2ae] 2d40 ffe2                 move.l     d0,-30(a6)
[0000a2b2] 528b                      addq.l     #1,a3
[0000a2b4] 6000 fe0c                 bra        _getflags_19
_getflags_39:
[0000a2b8] 42ae fff4                 clr.l      -12(a6)
_getflags_41:
[0000a2bc] 4a15                      tst.b      (a5)
[0000a2be] 6722                      beq.s      _getflags_40
[0000a2c0] 4287                      clr.l      d7
[0000a2c2] 1e15                      move.b     (a5),d7
[0000a2c4] 0c47 002c                 cmpi.w     #$002C,d7
[0000a2c8] 6718                      beq.s      _getflags_40
[0000a2ca] 4287                      clr.l      d7
[0000a2cc] 1e15                      move.b     (a5),d7
[0000a2ce] 0c47 003e                 cmpi.w     #$003E,d7
[0000a2d2] 670e                      beq.s      _getflags_40
[0000a2d4] 4287                      clr.l      d7
[0000a2d6] 1e15                      move.b     (a5),d7
[0000a2d8] 0c47 003a                 cmpi.w     #$003A,d7
[0000a2dc] 6704                      beq.s      _getflags_40
[0000a2de] 528d                      addq.l     #1,a5
[0000a2e0] 60da                      bra.s      _getflags_41
_getflags_40:
[0000a2e2] 538d                      subq.l     #1,a5
[0000a2e4] 6000 fddc                 bra        _getflags_19
[0000a2e8] 4e56 0000                 link       a6,#0
[0000a2ec] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[0000a2f0] 2a2e 0008                 move.l     8(a6),d5
[0000a2f4] 2a6e 000c                 movea.l    12(a6),a5
[0000a2f8] 282e 0010                 move.l     16(a6),d4
[0000a2fc] 0c84 0000 003c            cmpi.l     #$0000003C,d4
[0000a302] 6f14                      ble.s      _getflags_42
[0000a304] 4287                      clr.l      d7
[0000a306] 1e15                      move.b     (a5),d7
[0000a308] 0c47 0020                 cmpi.w     #$0020,d7
[0000a30c] 6724                      beq.s      _getflags_43
[0000a30e] 4287                      clr.l      d7
[0000a310] 1e15                      move.b     (a5),d7
[0000a312] 0c47 0009                 cmpi.w     #$0009,d7
[0000a316] 671a                      beq.s      _getflags_43
_getflags_42:
[0000a318] 4878 0001                 pea.l      ($00000001).w
[0000a31c] 2f0d                      move.l     a5,-(a7)
[0000a31e] 2f05                      move.l     d5,-(a7)
[0000a320] 4eb9 0000 b106            jsr        _write
[0000a326] 4fef 000c                 lea.l      12(a7),a7
[0000a32a] 2444                      movea.l    d4,a2
[0000a32c] 528a                      addq.l     #1,a2
[0000a32e] 2e0a                      move.l     a2,d7
[0000a330] 6018                      bra.s      _getflags_44
_getflags_43:
[0000a332] 4878 0002                 pea.l      ($00000002).w
[0000a336] 2f3c 0002 1b0e            move.l     #$00021B0E,-(a7)
[0000a33c] 2f05                      move.l     d5,-(a7)
[0000a33e] 4eb9 0000 b106            jsr        _write
[0000a344] 4fef 000c                 lea.l      12(a7),a7
[0000a348] 7e04                      moveq.l    #4,d7
_getflags_44:
[0000a34a] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[0000a34e] 4e5e                      unlk       a6
[0000a350] 4e75                      rts

_itob:
[0000a352] 4e56 0000                 link       a6,#0
[0000a356] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000a35a] 2a6e 0008                 movea.l    8(a6),a5
[0000a35e] 284d                      movea.l    a5,a4
[0000a360] 4aae 000c                 tst.l      12(a6)
[0000a364] 6c14                      bge.s      _itob_1
[0000a366] 4aae 0010                 tst.l      16(a6)
[0000a36a] 6e0e                      bgt.s      _itob_1
[0000a36c] 2e2e 000c                 move.l     12(a6),d7
[0000a370] 4487                      neg.l      d7
[0000a372] 2a07                      move.l     d7,d5
[0000a374] 18fc 002d                 move.b     #$2D,(a4)+
[0000a378] 6004                      bra.s      _itob_2
_itob_1:
[0000a37a] 2a2e 000c                 move.l     12(a6),d5
_itob_2:
[0000a37e] 4aae 0010                 tst.l      16(a6)
[0000a382] 6608                      bne.s      _itob_3
[0000a384] 700a                      moveq.l    #10,d0
[0000a386] 2d40 0010                 move.l     d0,16(a6)
[0000a38a] 6010                      bra.s      _itob_4
_itob_3:
[0000a38c] 4aae 0010                 tst.l      16(a6)
[0000a390] 6c0a                      bge.s      _itob_4
[0000a392] 2e2e 0010                 move.l     16(a6),d7
[0000a396] 4487                      neg.l      d7
[0000a398] 2d47 0010                 move.l     d7,16(a6)
_itob_4:
[0000a39c] 2e2e 0010                 move.l     16(a6),d7
[0000a3a0] be85                      cmp.l      d5,d7
[0000a3a2] 621a                      bhi.s      _itob_5
[0000a3a4] 2eae 0010                 move.l     16(a6),(a7)
[0000a3a8] 2f05                      move.l     d5,-(a7)
[0000a3aa] 2f2e 0010                 move.l     16(a6),-(a7)
[0000a3ae] 4eb9 0000 a7f6            jsr        a.uldiv
[0000a3b4] 2f0c                      move.l     a4,-(a7)
[0000a3b6] 4eba ff9a                 jsr        _itob(pc)
[0000a3ba] 508f                      addq.l     #8,a7
[0000a3bc] d9c7                      adda.l     d7,a4
_itob_5:
[0000a3be] 7e30                      moveq.l    #48,d7
[0000a3c0] 2e85                      move.l     d5,(a7)
[0000a3c2] 2f2e 0010                 move.l     16(a6),-(a7)
[0000a3c6] 4eb9 0000 a7ee            jsr        a.ulmod
[0000a3cc] de97                      add.l      (a7),d7
[0000a3ce] 1887                      move.b     d7,(a4)
[0000a3d0] 4287                      clr.l      d7
[0000a3d2] 1e14                      move.b     (a4),d7
[0000a3d4] 0c47 0039                 cmpi.w     #$0039,d7
[0000a3d8] 6304                      bls.s      _itob_6
[0000a3da] 0614 0027                 addi.b     #$27,(a4)
_itob_6:
[0000a3de] 2e0c                      move.l     a4,d7
[0000a3e0] 9e8d                      sub.l      a5,d7
[0000a3e2] 5287                      addq.l     #1,d7
[0000a3e4] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000a3e8] 4e5e                      unlk       a6
[0000a3ea] 4e75                      rts

_notbuf:
[0000a3ec] 4e56 fffc                 link       a6,#-4
[0000a3f0] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000a3f4] 2a2e 000c                 move.l     12(a6),d5
[0000a3f8] 2a6e 0008                 movea.l    8(a6),a5
_notbuf_4:
[0000a3fc] 4a85                      tst.l      d5
[0000a3fe] 671c                      beq.s      _notbuf_1
[0000a400] 42ae fffc                 clr.l      -4(a6)
[0000a404] 286e 0010                 movea.l    16(a6),a4
_notbuf_5:
[0000a408] 4287                      clr.l      d7
[0000a40a] 1e15                      move.b     (a5),d7
[0000a40c] 4286                      clr.l      d6
[0000a40e] 1c14                      move.b     (a4),d6
[0000a410] be86                      cmp.l      d6,d7
[0000a412] 661c                      bne.s      _notbuf_2
[0000a414] 7001                      moveq.l    #1,d0
[0000a416] 2d40 fffc                 move.l     d0,-4(a6)
[0000a41a] 601a                      bra.s      _notbuf_3
_notbuf_1:
[0000a41c] 2e0d                      move.l     a5,d7
[0000a41e] 9eae 0008                 sub.l      8(a6),d7
[0000a422] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000a426] 4e5e                      unlk       a6
[0000a428] 4e75                      rts
_notbuf_6:
[0000a42a] 5385                      subq.l     #1,d5
[0000a42c] 528d                      addq.l     #1,a5
[0000a42e] 60cc                      bra.s      _notbuf_4
_notbuf_2:
[0000a430] 528c                      addq.l     #1,a4
[0000a432] 4a14                      tst.b      (a4)
[0000a434] 66d2                      bne.s      _notbuf_5
_notbuf_3:
[0000a436] 4aae fffc                 tst.l      -4(a6)
[0000a43a] 66ee                      bne.s      _notbuf_6
[0000a43c] 60de                      bra.s      _notbuf_1

_usage:
[0000a43e] 4e56 0000                 link       a6,#0
[0000a442] 48e7 8400                 movem.l    d0/d5,-(a7)
[0000a446] 4285                      clr.l      d5
[0000a448] 4297                      clr.l      (a7)
[0000a44a] 2f2e 0008                 move.l     8(a6),-(a7)
[0000a44e] 2f3c 0002 1b12            move.l     #$00021B12,-(a7)
[0000a454] 2f39 0002 0cc0            move.l     __pname,-(a7)
[0000a45a] 2f3c 0002 1b14            move.l     #$00021B14,-(a7)
[0000a460] 4878 0002                 pea.l      ($00000002).w
[0000a464] 4eb9 0000 ae40            jsr        _putstr
[0000a46a] 4fef 0014                 lea.l      20(a7),a7
[0000a46e] 4aae 0008                 tst.l      8(a6)
[0000a472] 6726                      beq.s      _usage_1
[0000a474] 2eae 0008                 move.l     8(a6),(a7)
[0000a478] 4eb9 0000 aef4            jsr        _lenstr
[0000a47e] 2a07                      move.l     d7,d5
[0000a480] 2445                      movea.l    d5,a2
[0000a482] 538a                      subq.l     #1,a2
[0000a484] d5ee 0008                 adda.l     8(a6),a2
[0000a488] 4287                      clr.l      d7
[0000a48a] 1e12                      move.b     (a2),d7
[0000a48c] 0c47 000a                 cmpi.w     #$000A,d7
[0000a490] 6608                      bne.s      _usage_1
[0000a492] 4297                      clr.l      (a7)
[0000a494] 4eb9 0000 0080            jsr        _exit
_usage_1:
[0000a49a] 2eb9 0002 0cc0            move.l     __pname,(a7)
[0000a4a0] 4eb9 0000 aef4            jsr        _lenstr
[0000a4a6] 2445                      movea.l    d5,a2
[0000a4a8] 508a                      addq.l     #8,a2
[0000a4aa] de8a                      add.l      a2,d7
[0000a4ac] 4cdf 0021                 movem.l    (a7)+,d0/d5
[0000a4b0] 4e5e                      unlk       a6
[0000a4b2] 4e75                      rts

_buybuf:
[0000a4b4] 4e56 0000                 link       a6,#0
[0000a4b8] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[0000a4bc] 2a6e 0008                 movea.l    8(a6),a5
[0000a4c0] 2a2e 000c                 move.l     12(a6),d5
[0000a4c4] 4297                      clr.l      (a7)
[0000a4c6] 2f05                      move.l     d5,-(a7)
[0000a4c8] 4eb9 0000 a906            jsr        _alloc
[0000a4ce] 588f                      addq.l     #4,a7
[0000a4d0] 2647                      movea.l    d7,a3
[0000a4d2] 284b                      movea.l    a3,a4
_buybuf_2:
[0000a4d4] 4a85                      tst.l      d5
[0000a4d6] 6706                      beq.s      _buybuf_1
[0000a4d8] 18dd                      move.b     (a5)+,(a4)+
[0000a4da] 5385                      subq.l     #1,d5
[0000a4dc] 60f6                      bra.s      _buybuf_2
_buybuf_1:
[0000a4de] 2e0b                      move.l     a3,d7
[0000a4e0] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[0000a4e4] 4e5e                      unlk       a6
[0000a4e6] 4e75                      rts

_cmpstr:
[0000a4e8] 4e56 0000                 link       a6,#0
[0000a4ec] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[0000a4f0] 2a6e 0008                 movea.l    8(a6),a5
[0000a4f4] 286e 000c                 movea.l    12(a6),a4
_cmpstr_2:
[0000a4f8] 4a14                      tst.b      (a4)
[0000a4fa] 6710                      beq.s      _cmpstr_1
[0000a4fc] 4287                      clr.l      d7
[0000a4fe] 1e1d                      move.b     (a5)+,d7
[0000a500] 4286                      clr.l      d6
[0000a502] 1c1c                      move.b     (a4)+,d6
[0000a504] be86                      cmp.l      d6,d7
[0000a506] 67f0                      beq.s      _cmpstr_2
[0000a508] 4287                      clr.l      d7
[0000a50a] 600a                      bra.s      _cmpstr_3
_cmpstr_1:
[0000a50c] 4a15                      tst.b      (a5)
[0000a50e] 6604                      bne.s      _cmpstr_4
[0000a510] 7e01                      moveq.l    #1,d7
[0000a512] 6002                      bra.s      _cmpstr_3
_cmpstr_4:
[0000a514] 4287                      clr.l      d7
_cmpstr_3:
[0000a516] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[0000a51a] 4e5e                      unlk       a6
[0000a51c] 4e75                      rts

_cpystr:
[0000a51e] 4e56 0000                 link       a6,#0
[0000a522] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000a526] 286e 0008                 movea.l    8(a6),a4
[0000a52a] 45ee 000c                 lea.l      12(a6),a2
[0000a52e] 2a4a                      movea.l    a2,a5
_cpystr_4:
[0000a530] 2655                      movea.l    (a5),a3
[0000a532] 2e0b                      move.l     a3,d7
[0000a534] 6708                      beq.s      _cpystr_1
_cpystr_3:
[0000a536] 4a13                      tst.b      (a3)
[0000a538] 6710                      beq.s      _cpystr_2
[0000a53a] 18db                      move.b     (a3)+,(a4)+
[0000a53c] 60f8                      bra.s      _cpystr_3
_cpystr_1:
[0000a53e] 4214                      clr.b      (a4)
[0000a540] 2e0c                      move.l     a4,d7
[0000a542] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000a546] 4e5e                      unlk       a6
[0000a548] 4e75                      rts
_cpystr_2:
[0000a54a] 588d                      addq.l     #4,a5
[0000a54c] 60e2                      bra.s      _cpystr_4

_create:
[0000a54e] 4e56 0000                 link       a6,#0
[0000a552] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000a556] 4eb9 0000 a85e            jsr        _uname
[0000a55c] 2a47                      movea.l    d7,a5
[0000a55e] 286e 0008                 movea.l    8(a6),a4
_create_2:
[0000a562] 4a15                      tst.b      (a5)
[0000a564] 6710                      beq.s      _create_1
[0000a566] 4287                      clr.l      d7
[0000a568] 1e1c                      move.b     (a4)+,d7
[0000a56a] 4286                      clr.l      d6
[0000a56c] 1c15                      move.b     (a5),d6
[0000a56e] be86                      cmp.l      d6,d7
[0000a570] 6604                      bne.s      _create_1
[0000a572] 528d                      addq.l     #1,a5
[0000a574] 60ec                      bra.s      _create_2
_create_1:
[0000a576] 4a15                      tst.b      (a5)
[0000a578] 6708                      beq.s      _create_3
[0000a57a] 2e3c 0000 01b6            move.l     #$000001B6,d7
[0000a580] 6006                      bra.s      _create_4
_create_3:
[0000a582] 2e3c 0000 0180            move.l     #$00000180,d7
_create_4:
[0000a588] 2e87                      move.l     d7,(a7)
[0000a58a] 2f2e 0008                 move.l     8(a6),-(a7)
[0000a58e] 4eb9 0000 add6            jsr        _creat
[0000a594] 588f                      addq.l     #4,a7
[0000a596] 2a07                      move.l     d7,d5
[0000a598] 6d0a                      blt.s      _create_5
[0000a59a] 0cae 0000 0001 000c       cmpi.l     #$00000001,12(a6)
[0000a5a2] 6604                      bne.s      _create_6
_create_5:
[0000a5a4] 2e05                      move.l     d5,d7
[0000a5a6] 6018                      bra.s      _create_7
_create_6:
[0000a5a8] 2e85                      move.l     d5,(a7)
[0000a5aa] 4eb9 0000 ad6e            jsr        _close
[0000a5b0] 2eae 000c                 move.l     12(a6),(a7)
[0000a5b4] 2f2e 0008                 move.l     8(a6),-(a7)
[0000a5b8] 4eb9 0000 a796            jsr        _open
[0000a5be] 588f                      addq.l     #4,a7
_create_7:
[0000a5c0] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000a5c4] 4e5e                      unlk       a6
[0000a5c6] 4e75                      rts

_doesc:
[0000a5c8] 4e56 0000                 link       a6,#0
[0000a5cc] 48e7 9c0c                 movem.l    d0/d3-d5/a4-a5,-(a7)
[0000a5d0] 246e 0008                 movea.l    8(a6),a2
[0000a5d4] 2e12                      move.l     (a2),d7
[0000a5d6] 5287                      addq.l     #1,d7
[0000a5d8] 2a47                      movea.l    d7,a5
[0000a5da] 4a15                      tst.b      (a5)
[0000a5dc] 6612                      bne.s      _doesc_1
[0000a5de] 246e 0008                 movea.l    8(a6),a2
[0000a5e2] 2452                      movea.l    (a2),a2
[0000a5e4] 4287                      clr.l      d7
[0000a5e6] 1e12                      move.b     (a2),d7
[0000a5e8] 4cdf 3039                 movem.l    (a7)+,d0/d3-d5/a4-a5
[0000a5ec] 4e5e                      unlk       a6
[0000a5ee] 4e75                      rts
_doesc_1:
[0000a5f0] 4287                      clr.l      d7
[0000a5f2] 1e15                      move.b     (a5),d7
[0000a5f4] 0c47 0030                 cmpi.w     #$0030,d7
[0000a5f8] 6540                      bcs.s      _doesc_2
[0000a5fa] 4287                      clr.l      d7
[0000a5fc] 1e15                      move.b     (a5),d7
[0000a5fe] 0c47 0039                 cmpi.w     #$0039,d7
[0000a602] 6236                      bhi.s      _doesc_2
[0000a604] 4285                      clr.l      d5
[0000a606] 7801                      moveq.l    #1,d4
_doesc_4:
[0000a608] 4287                      clr.l      d7
[0000a60a] 1e15                      move.b     (a5),d7
[0000a60c] 0c47 0030                 cmpi.w     #$0030,d7
[0000a610] 6578                      bcs.s      _doesc_3
[0000a612] 4287                      clr.l      d7
[0000a614] 1e15                      move.b     (a5),d7
[0000a616] 0c47 0039                 cmpi.w     #$0039,d7
[0000a61a] 626e                      bhi.s      _doesc_3
[0000a61c] 0c84 0000 0003            cmpi.l     #$00000003,d4
[0000a622] 6e66                      bgt.s      _doesc_3
[0000a624] 7ed0                      moveq.l    #-48,d7
[0000a626] 2c05                      move.l     d5,d6
[0000a628] e786                      asl.l      #3,d6
[0000a62a] 4283                      clr.l      d3
[0000a62c] 1615                      move.b     (a5),d3
[0000a62e] dc83                      add.l      d3,d6
[0000a630] de86                      add.l      d6,d7
[0000a632] 2a07                      move.l     d7,d5
[0000a634] 528d                      addq.l     #1,a5
[0000a636] 5284                      addq.l     #1,d4
[0000a638] 60ce                      bra.s      _doesc_4
_doesc_2:
[0000a63a] 4287                      clr.l      d7
[0000a63c] 1e15                      move.b     (a5),d7
[0000a63e] 0c47 0041                 cmpi.w     #$0041,d7
[0000a642] 6514                      bcs.s      _doesc_5
[0000a644] 4287                      clr.l      d7
[0000a646] 1e15                      move.b     (a5),d7
[0000a648] 0c47 005a                 cmpi.w     #$005A,d7
[0000a64c] 620a                      bhi.s      _doesc_5
[0000a64e] 7e20                      moveq.l    #32,d7
[0000a650] 4286                      clr.l      d6
[0000a652] 1c15                      move.b     (a5),d6
[0000a654] de86                      add.l      d6,d7
[0000a656] 6004                      bra.s      _doesc_6
_doesc_5:
[0000a658] 4287                      clr.l      d7
[0000a65a] 1e15                      move.b     (a5),d7
_doesc_6:
[0000a65c] 2e87                      move.l     d7,(a7)
[0000a65e] 2f3c 0002 1b23            move.l     #$00021B23,-(a7)
[0000a664] 4eb9 0000 a7a6            jsr        _scnstr
[0000a66a] 588f                      addq.l     #4,a7
[0000a66c] 2a07                      move.l     d7,d5
[0000a66e] 0c85 0000 0005            cmpi.l     #$00000005,d5
[0000a674] 6c28                      bge.s      _doesc_7
[0000a676] 246e 0008                 movea.l    8(a6),a2
[0000a67a] 248d                      move.l     a5,(a2)
[0000a67c] 2445                      movea.l    d5,a2
[0000a67e] d5fc 0002 1b1c            adda.l     #$00021B1C,a2
[0000a684] 4287                      clr.l      d7
[0000a686] 1e12                      move.b     (a2),d7
[0000a688] 600c                      bra.s      _doesc_8
_doesc_3:
[0000a68a] 246e 0008                 movea.l    8(a6),a2
[0000a68e] 49ed ffff                 lea.l      -1(a5),a4
[0000a692] 248c                      move.l     a4,(a2)
[0000a694] 2e05                      move.l     d5,d7
_doesc_8:
[0000a696] 4cdf 3039                 movem.l    (a7)+,d0/d3-d5/a4-a5
[0000a69a] 4e5e                      unlk       a6
[0000a69c] 4e75                      rts
_doesc_7:
[0000a69e] 4aae 000c                 tst.l      12(a6)
[0000a6a2] 672a                      beq.s      _doesc_9
[0000a6a4] 4287                      clr.l      d7
[0000a6a6] 1e15                      move.b     (a5),d7
[0000a6a8] 2e87                      move.l     d7,(a7)
[0000a6aa] 2f2e 000c                 move.l     12(a6),-(a7)
[0000a6ae] 4eb9 0000 a7a6            jsr        _scnstr
[0000a6b4] 588f                      addq.l     #4,a7
[0000a6b6] 2a07                      move.l     d7,d5
[0000a6b8] 2445                      movea.l    d5,a2
[0000a6ba] d5ee 000c                 adda.l     12(a6),a2
[0000a6be] 4a12                      tst.b      (a2)
[0000a6c0] 670c                      beq.s      _doesc_9
[0000a6c2] 246e 0008                 movea.l    8(a6),a2
[0000a6c6] 248d                      move.l     a5,(a2)
[0000a6c8] 7eff                      moveq.l    #-1,d7
[0000a6ca] 9e85                      sub.l      d5,d7
[0000a6cc] 60c8                      bra.s      _doesc_8
_doesc_9:
[0000a6ce] 246e 0008                 movea.l    8(a6),a2
[0000a6d2] 248d                      move.l     a5,(a2)
[0000a6d4] 4287                      clr.l      d7
[0000a6d6] 1e15                      move.b     (a5),d7
[0000a6d8] 60bc                      bra.s      _doesc_8

_getenv:
[0000a6da] 4e56 0000                 link       a6,#0
[0000a6de] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000a6e2] 2a6e 0008                 movea.l    8(a6),a5
[0000a6e6] 2e8d                      move.l     a5,(a7)
[0000a6e8] 4eb9 0000 aef4            jsr        _lenstr
[0000a6ee] 2a07                      move.l     d7,d5
[0000a6f0] 2879 0002 0072            movea.l    _environ,a4
_getenv_4:
[0000a6f6] 2e0c                      move.l     a4,d7
[0000a6f8] 672e                      beq.s      _getenv_1
[0000a6fa] 4a94                      tst.l      (a4)
[0000a6fc] 672a                      beq.s      _getenv_1
[0000a6fe] 2e85                      move.l     d5,(a7)
[0000a700] 2f14                      move.l     (a4),-(a7)
[0000a702] 2f0d                      move.l     a5,-(a7)
[0000a704] 4eb9 0000 ad76            jsr        _cmpbuf
[0000a70a] 508f                      addq.l     #8,a7
[0000a70c] 4a87                      tst.l      d7
[0000a70e] 6722                      beq.s      _getenv_2
[0000a710] 2454                      movea.l    (a4),a2
[0000a712] d5c5                      adda.l     d5,a2
[0000a714] 4287                      clr.l      d7
[0000a716] 1e12                      move.b     (a2),d7
[0000a718] 0c47 003d                 cmpi.w     #$003D,d7
[0000a71c] 6614                      bne.s      _getenv_2
[0000a71e] 2e14                      move.l     (a4),d7
[0000a720] 2445                      movea.l    d5,a2
[0000a722] 528a                      addq.l     #1,a2
[0000a724] de8a                      add.l      a2,d7
[0000a726] 6002                      bra.s      _getenv_3
_getenv_1:
[0000a728] 4287                      clr.l      d7
_getenv_3:
[0000a72a] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000a72e] 4e5e                      unlk       a6
[0000a730] 4e75                      rts
_getenv_2:
[0000a732] 588c                      addq.l     #4,a4
[0000a734] 60c0                      bra.s      _getenv_4

a.lmod:
[0000a736] 48e7 7c00                 movem.l    d1-d5,-(a7)
[0000a73a] 3a3c ff00                 move.w     #$FF00,d5
[0000a73e] 282f 0018                 move.l     24(a7),d4
[0000a742] 6c14                      bge.s      a.lmod_1
[0000a744] 4484                      neg.l      d4
[0000a746] 6010                      bra.s      a.lmod_1
a.lmod_1: ; not found: 0000a758

a.ldiv:
[0000a748] 48e7 7c00                 movem.l    d1-d5,-(a7)
[0000a74c] 4245                      clr.w      d5
[0000a74e] 282f 0018                 move.l     24(a7),d4
[0000a752] 6c04                      bge.s      a.ldiv_1
[0000a754] 4484                      neg.l      d4
[0000a756] 4605                      not.b      d5
a.ldiv_1:
[0000a758] 262f 001c                 move.l     28(a7),d3
[0000a75c] 6c04                      bge.s      a.ldiv_2
[0000a75e] 4483                      neg.l      d3
[0000a760] 4605                      not.b      d5
a.ldiv_2:
[0000a762] 4282                      clr.l      d2
[0000a764] 721f                      moveq.l    #31,d1
[0000a766] 4280                      clr.l      d0
a.ldiv_4:
[0000a768] e38a                      lsl.l      #1,d2
[0000a76a] e38b                      lsl.l      #1,d3
[0000a76c] d580                      addx.l     d0,d2
[0000a76e] b484                      cmp.l      d4,d2
[0000a770] 6504                      bcs.s      a.ldiv_3
[0000a772] 9484                      sub.l      d4,d2
[0000a774] 5283                      addq.l     #1,d3
a.ldiv_3:
[0000a776] 51c9 fff0                 dbf        d1,a.ldiv_4
[0000a77a] 4a45                      tst.w      d5
[0000a77c] 6c04                      bge.s      a.ldiv_5
[0000a77e] 2002                      move.l     d2,d0
[0000a780] 6002                      bra.s      a.ldiv_6
a.ldiv_5:
[0000a782] 2003                      move.l     d3,d0
a.ldiv_6:
[0000a784] 4a05                      tst.b      d5
[0000a786] 6702                      beq.s      a.ldiv_7
[0000a788] 4480                      neg.l      d0
a.ldiv_7:
[0000a78a] 4cdf 003e                 movem.l    (a7)+,d1-d5
[0000a78e] 2e9f                      move.l     (a7)+,(a7)
[0000a790] 2f40 0004                 move.l     d0,4(a7)
[0000a794] 4e75                      rts

_open:
[0000a796] 205f                      movea.l    (a7)+,a0
[0000a798] 7e05                      moveq.l    #5,d7
[0000a79a] 4e41                      trap       #1
[0000a79c] 4ed0                      jmp        (a0)

_read:
[0000a79e] 205f                      movea.l    (a7)+,a0
[0000a7a0] 7e03                      moveq.l    #3,d7
[0000a7a2] 4e41                      trap       #1
[0000a7a4] 4ed0                      jmp        (a0)

_scnstr:
[0000a7a6] 4e56 fffe                 link       a6,#-2
[0000a7aa] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[0000a7ae] 2a6e 0008                 movea.l    8(a6),a5
[0000a7b2] 1d6e 000f ffff            move.b     15(a6),-1(a6)
[0000a7b8] 284d                      movea.l    a5,a4
_scnstr_3:
[0000a7ba] 4a14                      tst.b      (a4)
[0000a7bc] 670e                      beq.s      _scnstr_1
[0000a7be] 4287                      clr.l      d7
[0000a7c0] 1e14                      move.b     (a4),d7
[0000a7c2] 4286                      clr.l      d6
[0000a7c4] 1c2e ffff                 move.b     -1(a6),d6
[0000a7c8] be86                      cmp.l      d6,d7
[0000a7ca] 660c                      bne.s      _scnstr_2
_scnstr_1:
[0000a7cc] 2e0c                      move.l     a4,d7
[0000a7ce] 9e8d                      sub.l      a5,d7
[0000a7d0] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[0000a7d4] 4e5e                      unlk       a6
[0000a7d6] 4e75                      rts
_scnstr_2:
[0000a7d8] 528c                      addq.l     #1,a4
[0000a7da] 60de                      bra.s      _scnstr_3

a.switch:
[0000a7dc] 4a98                      tst.l      (a0)+
[0000a7de] 670a                      beq.s      a.switch_1
[0000a7e0] be98                      cmp.l      (a0)+,d7
[0000a7e2] 66f8                      bne.s      a.switch
[0000a7e4] 2068 fff8                 movea.l    -8(a0),a0
[0000a7e8] 4ed0                      jmp        (a0)
a.switch_1:
[0000a7ea] 2050                      movea.l    (a0),a0
[0000a7ec] 4ed0                      jmp        (a0)

a.ulmod:
[0000a7ee] 48e7 7c00                 movem.l    d1-d5,-(a7)
[0000a7f2] 7aff                      moveq.l    #-1,d5
[0000a7f4] 6006                      bra.s      a.ulmod_1
a.ulmod_1: ; not found: 0000a7fc

a.uldiv:
[0000a7f6] 48e7 7c00                 movem.l    d1-d5,-(a7)
[0000a7fa] 4205                      clr.b      d5
[0000a7fc] 282f 0018                 move.l     24(a7),d4
[0000a800] 262f 001c                 move.l     28(a7),d3
[0000a804] 4282                      clr.l      d2
[0000a806] 721f                      moveq.l    #31,d1
[0000a808] 4280                      clr.l      d0
a.uldiv_2:
[0000a80a] e38a                      lsl.l      #1,d2
[0000a80c] e38b                      lsl.l      #1,d3
[0000a80e] d580                      addx.l     d0,d2
[0000a810] b484                      cmp.l      d4,d2
[0000a812] 6504                      bcs.s      a.uldiv_1
[0000a814] 9484                      sub.l      d4,d2
[0000a816] 5283                      addq.l     #1,d3
a.uldiv_1:
[0000a818] 51c9 fff0                 dbf        d1,a.uldiv_2
[0000a81c] 4a05                      tst.b      d5
[0000a81e] 6c04                      bge.s      a.uldiv_3
[0000a820] 2002                      move.l     d2,d0
[0000a822] 6002                      bra.s      a.uldiv_4
a.uldiv_3:
[0000a824] 2003                      move.l     d3,d0
a.uldiv_4:
[0000a826] 4cdf 003e                 movem.l    (a7)+,d1-d5
[0000a82a] 2e9f                      move.l     (a7)+,(a7)
[0000a82c] 2f40 0004                 move.l     d0,4(a7)
[0000a830] 4e75                      rts

a.1ultd:
[0000a832] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[0000a836] 41d7                      lea.l      (a7),a0
[0000a838] 6008                      bra.s      a.1ultd_1
a.1ultd_1: ; not found: 0000a842

a.6ultd:
[0000a83a] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[0000a83e] 41ef 0008                 lea.l      8(a7),a0
[0000a842] 2140 0004                 move.l     d0,4(a0)
[0000a846] 4290                      clr.l      (a0)
[0000a848] 4878 0436                 pea.l      ($00000436).w
[0000a84c] 4850                      pea.l      (a0)
[0000a84e] 4eb9 0000 aff8            jsr        a.repk
[0000a854] 4fef 0008                 lea.l      8(a7),a7
[0000a858] 4cdf 06c6                 movem.l    (a7)+,d1-d2/d6-d7/a1-a2
[0000a85c] 4e75                      rts

_uname:
[0000a85e] 4e56 0000                 link       a6,#0
[0000a862] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[0000a866] 4a39 0002 1b30            tst.b      $00021B30
[0000a86c] 662a                      bne.s      _uname_1
[0000a86e] 4eb9 0000 adde            jsr        _getpid
[0000a874] 2807                      move.l     d7,d4
[0000a876] 7a0b                      moveq.l    #11,d5
_uname_2:
[0000a878] 5385                      subq.l     #1,d5
[0000a87a] 0c85 0000 0006            cmpi.l     #$00000006,d5
[0000a880] 6d16                      blt.s      _uname_1
[0000a882] 2445                      movea.l    d5,a2
[0000a884] d5fc 0002 1b2a            adda.l     #$00021B2A,a2
[0000a88a] 7e30                      moveq.l    #48,d7
[0000a88c] 7c07                      moveq.l    #7,d6
[0000a88e] cc84                      and.l      d4,d6
[0000a890] de86                      add.l      d6,d7
[0000a892] 1487                      move.b     d7,(a2)
[0000a894] e684                      asr.l      #3,d4
[0000a896] 60e0                      bra.s      _uname_2
_uname_1:
[0000a898] 2e3c 0002 1b2a            move.l     #$00021B2A,d7
[0000a89e] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[0000a8a2] 4e5e                      unlk       a6
[0000a8a4] 4e75                      rts

xa8a6:
[0000a8a6] 4e56 0000                 link       a6,#0
[0000a8aa] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000a8ae] 2a6e 0008                 movea.l    8(a6),a5
[0000a8b2] 2a2e 000c                 move.l     12(a6),d5
[0000a8b6] 2e0d                      move.l     a5,d7
[0000a8b8] de85                      add.l      d5,d7
[0000a8ba] 2847                      movea.l    d7,a4
[0000a8bc] 2e15                      move.l     (a5),d7
[0000a8be] 9e85                      sub.l      d5,d7
[0000a8c0] 2887                      move.l     d7,(a4)
[0000a8c2] 296d 0004 0004            move.l     4(a5),4(a4)
[0000a8c8] 2445                      movea.l    d5,a2
[0000a8ca] 518a                      subq.l     #8,a2
[0000a8cc] 2a8a                      move.l     a2,(a5)
[0000a8ce] 2e0c                      move.l     a4,d7
[0000a8d0] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000a8d4] 4e5e                      unlk       a6
[0000a8d6] 4e75                      rts

xa8d8:
[0000a8d8] 4e56 0000                 link       a6,#0
[0000a8dc] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[0000a8e0] 2a6e 0008                 movea.l    8(a6),a5
[0000a8e4] 286d 0004                 movea.l    4(a5),a4
[0000a8e8] 2e0d                      move.l     a5,d7
[0000a8ea] de95                      add.l      (a5),d7
[0000a8ec] 5087                      addq.l     #8,d7
[0000a8ee] be8c                      cmp.l      a4,d7
[0000a8f0] 660c                      bne.s      xa8d8_1
[0000a8f2] 2e14                      move.l     (a4),d7
[0000a8f4] 5087                      addq.l     #8,d7
[0000a8f6] df95                      add.l      d7,(a5)
[0000a8f8] 2b6c 0004 0004            move.l     4(a4),4(a5)
xa8d8_1:
[0000a8fe] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[0000a902] 4e5e                      unlk       a6
[0000a904] 4e75                      rts

_alloc:
[0000a906] 4e56 0000                 link       a6,#0
[0000a90a] 48e7 8004                 movem.l    d0/a5,-(a7)
[0000a90e] 2eae 000c                 move.l     12(a6),(a7)
[0000a912] 2f2e 0008                 move.l     8(a6),-(a7)
[0000a916] 4eb9 0000 a940            jsr        _nalloc
[0000a91c] 588f                      addq.l     #4,a7
[0000a91e] 2a47                      movea.l    d7,a5
[0000a920] 2e0d                      move.l     a5,d7
[0000a922] 6704                      beq.s      _alloc_1
[0000a924] 2e0d                      move.l     a5,d7
[0000a926] 6010                      bra.s      _alloc_2
_alloc_1:
[0000a928] 2ebc 0002 1b54            move.l     #__memerr,(a7)
[0000a92e] 42a7                      clr.l      -(a7)
[0000a930] 4eb9 0000 af16            jsr        __raise
[0000a936] 588f                      addq.l     #4,a7
_alloc_2:
[0000a938] 4cdf 2001                 movem.l    (a7)+,d0/a5
[0000a93c] 4e5e                      unlk       a6
[0000a93e] 4e75                      rts

_nalloc:
[0000a940] 4e56 fffc                 link       a6,#-4
[0000a944] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[0000a948] 2a2e 0008                 move.l     8(a6),d5
[0000a94c] 0c85 0000 0004            cmpi.l     #$00000004,d5
[0000a952] 6404                      bcc.s      _nalloc_1
[0000a954] 7e04                      moveq.l    #4,d7
[0000a956] 6002                      bra.s      _nalloc_2
_nalloc_1:
[0000a958] 2e05                      move.l     d5,d7
_nalloc_2:
[0000a95a] 5687                      addq.l     #3,d7
[0000a95c] 7cfc                      moveq.l    #-4,d6
[0000a95e] cc87                      and.l      d7,d6
[0000a960] 2e06                      move.l     d6,d7
[0000a962] 5887                      addq.l     #4,d7
[0000a964] 2a07                      move.l     d7,d5
_nalloc_18:
[0000a966] 2a7c 0002 1b3a            movea.l    #$00021B3A,a5
_nalloc_9:
[0000a96c] 2855                      movea.l    (a5),a4
[0000a96e] 2e0c                      move.l     a4,d7
[0000a970] 6714                      beq.s      _nalloc_3
[0000a972] 2e14                      move.l     (a4),d7
[0000a974] 5087                      addq.l     #8,d7
[0000a976] ba87                      cmp.l      d7,d5
[0000a978] 6220                      bhi.s      _nalloc_4
[0000a97a] 2e14                      move.l     (a4),d7
[0000a97c] be85                      cmp.l      d5,d7
[0000a97e] 6422                      bcc.s      _nalloc_5
[0000a980] 2aac 0004                 move.l     4(a4),(a5)
[0000a984] 6028                      bra.s      _nalloc_6
_nalloc_3:
[0000a986] 4ab9 0002 1b36            tst.l      $00021B36
[0000a98c] 662e                      bne.s      _nalloc_7
[0000a98e] 23fc 0000 0200 0002 1b36  move.l     #$00000200,$00021B36
[0000a998] 603c                      bra.s      _nalloc_8
_nalloc_4:
[0000a99a] 45ec 0004                 lea.l      4(a4),a2
[0000a99e] 2a4a                      movea.l    a2,a5
[0000a9a0] 60ca                      bra.s      _nalloc_9
_nalloc_5:
[0000a9a2] 2e85                      move.l     d5,(a7)
[0000a9a4] 2f0c                      move.l     a4,-(a7)
[0000a9a6] 4eba fefe                 jsr        $0000A8A6(pc)
[0000a9aa] 588f                      addq.l     #4,a7
[0000a9ac] 2a87                      move.l     d7,(a5)
_nalloc_6:
[0000a9ae] 296e 000c 0004            move.l     12(a6),4(a4)
[0000a9b4] 45ec 0004                 lea.l      4(a4),a2
[0000a9b8] 2e0a                      move.l     a2,d7
[0000a9ba] 6066                      bra.s      _nalloc_10
_nalloc_7:
[0000a9bc] 0cb9 0000 0200 0002 1b36  cmpi.l     #$00000200,$00021B36
[0000a9c6] 670e                      beq.s      _nalloc_8
[0000a9c8] 2e39 0002 1b36            move.l     $00021B36,d7
[0000a9ce] e28f                      lsr.l      #1,d7
[0000a9d0] 23c7 0002 1b36            move.l     d7,$00021B36
_nalloc_8:
[0000a9d6] 97cb                      suba.l     a3,a3
_nalloc_12:
[0000a9d8] bab9 0002 1b36            cmp.l      $00021B36,d5
[0000a9de] 6228                      bhi.s      _nalloc_11
[0000a9e0] 2d79 0002 1b36 fffc       move.l     $00021B36,-4(a6)
[0000a9e8] 2eae fffc                 move.l     -4(a6),(a7)
[0000a9ec] 4eb9 0000 ae76            jsr        _sbreak
[0000a9f2] 2647                      movea.l    d7,a3
[0000a9f4] 2e0b                      move.l     a3,d7
[0000a9f6] 6610                      bne.s      _nalloc_11
[0000a9f8] 2e39 0002 1b36            move.l     $00021B36,d7
[0000a9fe] e28f                      lsr.l      #1,d7
[0000aa00] 23c7 0002 1b36            move.l     d7,$00021B36
[0000aa06] 60d0                      bra.s      _nalloc_12
_nalloc_11:
[0000aa08] 2e0b                      move.l     a3,d7
[0000aa0a] 6610                      bne.s      _nalloc_13
[0000aa0c] 2d45 fffc                 move.l     d5,-4(a6)
[0000aa10] 2eae fffc                 move.l     -4(a6),(a7)
[0000aa14] 4eb9 0000 ae76            jsr        _sbreak
[0000aa1a] 2647                      movea.l    d7,a3
_nalloc_13:
[0000aa1c] 2e0b                      move.l     a3,d7
[0000aa1e] 660a                      bne.s      _nalloc_14
[0000aa20] 4287                      clr.l      d7
_nalloc_10:
[0000aa22] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[0000aa26] 4e5e                      unlk       a6
[0000aa28] 4e75                      rts
_nalloc_14:
[0000aa2a] 2e2e fffc                 move.l     -4(a6),d7
[0000aa2e] 5187                      subq.l     #8,d7
[0000aa30] 2687                      move.l     d7,(a3)
[0000aa32] 4ab9 0002 1b3e            tst.l      $00021B3E
[0000aa38] 6708                      beq.s      _nalloc_15
[0000aa3a] b7f9 0002 1b3e            cmpa.l     $00021B3E,a3
[0000aa40] 6406                      bcc.s      _nalloc_16
_nalloc_15:
[0000aa42] 23cb 0002 1b3e            move.l     a3,$00021B3E
_nalloc_16:
[0000aa48] 2e39 0002 1b42            move.l     $00021B42,d7
[0000aa4e] 2c0b                      move.l     a3,d6
[0000aa50] dcae fffc                 add.l      -4(a6),d6
[0000aa54] be86                      cmp.l      d6,d7
[0000aa56] 640c                      bcc.s      _nalloc_17
[0000aa58] 2e0b                      move.l     a3,d7
[0000aa5a] deae fffc                 add.l      -4(a6),d7
[0000aa5e] 23c7 0002 1b42            move.l     d7,$00021B42
_nalloc_17:
[0000aa64] 4297                      clr.l      (a7)
[0000aa66] 486b 0004                 pea.l      4(a3)
[0000aa6a] 4eb9 0000 aa76            jsr        _free
[0000aa70] 588f                      addq.l     #4,a7
[0000aa72] 6000 fef2                 bra        _nalloc_18

_free:
[0000aa76] 4e56 0000                 link       a6,#0
[0000aa7a] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000aa7e] 2e2e 0008                 move.l     8(a6),d7
[0000aa82] 5987                      subq.l     #4,d7
[0000aa84] 2a47                      movea.l    d7,a5
[0000aa86] 4aae 0008                 tst.l      8(a6)
[0000aa8a] 672c                      beq.s      _free_1
[0000aa8c] bbf9 0002 1b3e            cmpa.l     $00021B3E,a5
[0000aa92] 650a                      bcs.s      _free_2
[0000aa94] 2e39 0002 1b42            move.l     $00021B42,d7
[0000aa9a] be8d                      cmp.l      a5,d7
[0000aa9c] 6226                      bhi.s      _free_3
_free_2:
[0000aa9e] 23fc 0002 1b46 0002 1b54  move.l     #$00021B46,__memerr
[0000aaa8] 2ebc 0002 1b54            move.l     #__memerr,(a7)
[0000aaae] 42a7                      clr.l      -(a7)
[0000aab0] 4eb9 0000 af16            jsr        __raise
[0000aab6] 588f                      addq.l     #4,a7
_free_1:
[0000aab8] 2e2e 000c                 move.l     12(a6),d7
[0000aabc] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000aac0] 4e5e                      unlk       a6
[0000aac2] 4e75                      rts
_free_3:
[0000aac4] 4ab9 0002 1b3a            tst.l      $00021B3A
[0000aaca] 660c                      bne.s      _free_4
[0000aacc] 42ad 0004                 clr.l      4(a5)
[0000aad0] 23cd 0002 1b3a            move.l     a5,$00021B3A
[0000aad6] 60e0                      bra.s      _free_1
_free_4:
[0000aad8] bbf9 0002 1b3a            cmpa.l     $00021B3A,a5
[0000aade] 6416                      bcc.s      _free_5
[0000aae0] 2b79 0002 1b3a 0004       move.l     $00021B3A,4(a5)
[0000aae8] 23cd 0002 1b3a            move.l     a5,$00021B3A
[0000aaee] 2e8d                      move.l     a5,(a7)
[0000aaf0] 4eba fde6                 jsr        $0000A8D8(pc)
[0000aaf4] 60c2                      bra.s      _free_1
_free_5:
[0000aaf6] 2879 0002 1b3a            movea.l    $00021B3A,a4
_free_7:
[0000aafc] 266c 0004                 movea.l    4(a4),a3
[0000ab00] 2e0b                      move.l     a3,d7
[0000ab02] 6708                      beq.s      _free_6
[0000ab04] b7cd                      cmpa.l     a5,a3
[0000ab06] 6404                      bcc.s      _free_6
[0000ab08] 284b                      movea.l    a3,a4
[0000ab0a] 60f0                      bra.s      _free_7
_free_6:
[0000ab0c] 2e0b                      move.l     a3,d7
[0000ab0e] 6716                      beq.s      _free_8
[0000ab10] 2b4b 0004                 move.l     a3,4(a5)
[0000ab14] 294d 0004                 move.l     a5,4(a4)
[0000ab18] 2e8d                      move.l     a5,(a7)
[0000ab1a] 4eba fdbc                 jsr        $0000A8D8(pc)
[0000ab1e] 2e8c                      move.l     a4,(a7)
[0000ab20] 4eba fdb6                 jsr        $0000A8D8(pc)
[0000ab24] 6092                      bra.s      _free_1
_free_8:
[0000ab26] 42ad 0004                 clr.l      4(a5)
[0000ab2a] 294d 0004                 move.l     a5,4(a4)
[0000ab2e] 2e8c                      move.l     a4,(a7)
[0000ab30] 4eba fda6                 jsr        $0000A8D8(pc)
[0000ab34] 6000 ff82                 bra.w      _free_1

_btol:
[0000ab38] 4e56 fff4                 link       a6,#-12
[0000ab3c] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[0000ab40] 2a6e 0008                 movea.l    8(a6),a5
[0000ab44] 2a2e 000c                 move.l     12(a6),d5
[0000ab48] 42ae fff8                 clr.l      -8(a6)
[0000ab4c] 2d4d fff4                 move.l     a5,-12(a6)
[0000ab50] 42ae fffc                 clr.l      -4(a6)
_btol_5:
[0000ab54] 4a85                      tst.l      d5
[0000ab56] 6714                      beq.s      _btol_1
[0000ab58] 4287                      clr.l      d7
[0000ab5a] 1e15                      move.b     (a5),d7
[0000ab5c] 0c47 0020                 cmpi.w     #$0020,d7
[0000ab60] 6324                      bls.s      _btol_2
[0000ab62] 4287                      clr.l      d7
[0000ab64] 1e15                      move.b     (a5),d7
[0000ab66] 0c47 007f                 cmpi.w     #$007F,d7
[0000ab6a] 641a                      bcc.s      _btol_2
_btol_1:
[0000ab6c] 4a85                      tst.l      d5
[0000ab6e] 671c                      beq.s      _btol_3
[0000ab70] 4287                      clr.l      d7
[0000ab72] 1e15                      move.b     (a5),d7
[0000ab74] 0c47 002d                 cmpi.w     #$002D,d7
[0000ab78] 661a                      bne.s      _btol_4
[0000ab7a] 7001                      moveq.l    #1,d0
[0000ab7c] 2d40 fffc                 move.l     d0,-4(a6)
[0000ab80] 528d                      addq.l     #1,a5
[0000ab82] 5385                      subq.l     #1,d5
[0000ab84] 6006                      bra.s      _btol_3
_btol_2:
[0000ab86] 5385                      subq.l     #1,d5
[0000ab88] 528d                      addq.l     #1,a5
[0000ab8a] 60c8                      bra.s      _btol_5
_btol_3:
[0000ab8c] 4a85                      tst.l      d5
[0000ab8e] 6614                      bne.s      _btol_6
[0000ab90] 6000 00d6                 bra        _btol_7
_btol_4:
[0000ab94] 4287                      clr.l      d7
[0000ab96] 1e15                      move.b     (a5),d7
[0000ab98] 0c47 002b                 cmpi.w     #$002B,d7
[0000ab9c] 66ee                      bne.s      _btol_3
[0000ab9e] 528d                      addq.l     #1,a5
[0000aba0] 5385                      subq.l     #1,d5
[0000aba2] 60e8                      bra.s      _btol_3
_btol_6:
[0000aba4] 0cae 0000 0001 0014       cmpi.l     #$00000001,20(a6)
[0000abac] 6614                      bne.s      _btol_8
[0000abae] 4287                      clr.l      d7
[0000abb0] 1e15                      move.b     (a5),d7
[0000abb2] 0c47 0030                 cmpi.w     #$0030,d7
[0000abb6] 6764                      beq.s      _btol_9
[0000abb8] 700a                      moveq.l    #10,d0
[0000abba] 2d40 0014                 move.l     d0,20(a6)
[0000abbe] 6000 00a8                 bra        _btol_7
_btol_8:
[0000abc2] 0cae 0000 0010 0014       cmpi.l     #$00000010,20(a6)
[0000abca] 6600 009c                 bne        _btol_7
[0000abce] 0c85 0000 0002            cmpi.l     #$00000002,d5
[0000abd4] 6500 0092                 bcs        _btol_7
[0000abd8] 4287                      clr.l      d7
[0000abda] 1e15                      move.b     (a5),d7
[0000abdc] 0c47 0030                 cmpi.w     #$0030,d7
[0000abe0] 6600 0086                 bne        _btol_7
[0000abe4] 4287                      clr.l      d7
[0000abe6] 1e2d 0001                 move.b     1(a5),d7
[0000abea] 0c47 0041                 cmpi.w     #$0041,d7
[0000abee] 6518                      bcs.s      _btol_10
[0000abf0] 4287                      clr.l      d7
[0000abf2] 1e2d 0001                 move.b     1(a5),d7
[0000abf6] 0c47 005a                 cmpi.w     #$005A,d7
[0000abfa] 620c                      bhi.s      _btol_10
[0000abfc] 7e20                      moveq.l    #32,d7
[0000abfe] 4286                      clr.l      d6
[0000ac00] 1c2d 0001                 move.b     1(a5),d6
[0000ac04] de86                      add.l      d6,d7
[0000ac06] 6006                      bra.s      _btol_11
_btol_10:
[0000ac08] 4287                      clr.l      d7
[0000ac0a] 1e2d 0001                 move.b     1(a5),d7
_btol_11:
[0000ac0e] 0c87 0000 0078            cmpi.l     #$00000078,d7
[0000ac14] 6652                      bne.s      _btol_7
[0000ac16] 548d                      addq.l     #2,a5
[0000ac18] 5585                      subq.l     #2,d5
[0000ac1a] 604c                      bra.s      _btol_7
_btol_9:
[0000ac1c] 0c85 0000 0001            cmpi.l     #$00000001,d5
[0000ac22] 633e                      bls.s      _btol_12
[0000ac24] 4287                      clr.l      d7
[0000ac26] 1e2d 0001                 move.b     1(a5),d7
[0000ac2a] 0c47 0041                 cmpi.w     #$0041,d7
[0000ac2e] 6518                      bcs.s      _btol_13
[0000ac30] 4287                      clr.l      d7
[0000ac32] 1e2d 0001                 move.b     1(a5),d7
[0000ac36] 0c47 005a                 cmpi.w     #$005A,d7
[0000ac3a] 620c                      bhi.s      _btol_13
[0000ac3c] 7e20                      moveq.l    #32,d7
[0000ac3e] 4286                      clr.l      d6
[0000ac40] 1c2d 0001                 move.b     1(a5),d6
[0000ac44] de86                      add.l      d6,d7
[0000ac46] 6006                      bra.s      _btol_14
_btol_13:
[0000ac48] 4287                      clr.l      d7
[0000ac4a] 1e2d 0001                 move.b     1(a5),d7
_btol_14:
[0000ac4e] 0c87 0000 0078            cmpi.l     #$00000078,d7
[0000ac54] 660c                      bne.s      _btol_12
[0000ac56] 7010                      moveq.l    #16,d0
[0000ac58] 2d40 0014                 move.l     d0,20(a6)
[0000ac5c] 548d                      addq.l     #2,a5
[0000ac5e] 5585                      subq.l     #2,d5
[0000ac60] 6006                      bra.s      _btol_7
_btol_12:
[0000ac62] 7008                      moveq.l    #8,d0
[0000ac64] 2d40 0014                 move.l     d0,20(a6)
_btol_7:
[0000ac68] 4a85                      tst.l      d5
[0000ac6a] 6720                      beq.s      _btol_15
[0000ac6c] 4287                      clr.l      d7
[0000ac6e] 1e15                      move.b     (a5),d7
[0000ac70] 0c47 0030                 cmpi.w     #$0030,d7
[0000ac74] 656a                      bcs.s      _btol_16
[0000ac76] 4287                      clr.l      d7
[0000ac78] 1e15                      move.b     (a5),d7
[0000ac7a] 0c47 0039                 cmpi.w     #$0039,d7
[0000ac7e] 6260                      bhi.s      _btol_16
[0000ac80] 7ed0                      moveq.l    #-48,d7
[0000ac82] 4286                      clr.l      d6
[0000ac84] 1c15                      move.b     (a5),d6
[0000ac86] de86                      add.l      d6,d7
[0000ac88] 2807                      move.l     d7,d4
[0000ac8a] 606a                      bra.s      _btol_17
_btol_15:
[0000ac8c] 246e 0010                 movea.l    16(a6),a2
[0000ac90] 2e8a                      move.l     a2,(a7)
[0000ac92] 4aae fffc                 tst.l      -4(a6)
[0000ac96] 6708                      beq.s      _btol_18
[0000ac98] 2e2e fff8                 move.l     -8(a6),d7
[0000ac9c] 4487                      neg.l      d7
[0000ac9e] 6004                      bra.s      _btol_19
_btol_18:
[0000aca0] 2e2e fff8                 move.l     -8(a6),d7
_btol_19:
[0000aca4] 2257                      movea.l    (a7),a1
[0000aca6] 2287                      move.l     d7,(a1)
[0000aca8] 4a85                      tst.l      d5
[0000acaa] 6700 00b4                 beq        _btol_20
[0000acae] 4287                      clr.l      d7
[0000acb0] 1e15                      move.b     (a5),d7
[0000acb2] 0c47 0041                 cmpi.w     #$0041,d7
[0000acb6] 6514                      bcs.s      _btol_21
[0000acb8] 4287                      clr.l      d7
[0000acba] 1e15                      move.b     (a5),d7
[0000acbc] 0c47 005a                 cmpi.w     #$005A,d7
[0000acc0] 620a                      bhi.s      _btol_21
[0000acc2] 7e20                      moveq.l    #32,d7
[0000acc4] 4286                      clr.l      d6
[0000acc6] 1c15                      move.b     (a5),d6
[0000acc8] de86                      add.l      d6,d7
[0000acca] 6004                      bra.s      _btol_22
_btol_21:
[0000accc] 4287                      clr.l      d7
[0000acce] 1e15                      move.b     (a5),d7
_btol_22:
[0000acd0] 0c87 0000 006c            cmpi.l     #$0000006C,d7
[0000acd6] 6600 0088                 bne        _btol_20
[0000acda] 528d                      addq.l     #1,a5
[0000acdc] 6000 0082                 bra        _btol_20
_btol_16:
[0000ace0] 4287                      clr.l      d7
[0000ace2] 1e15                      move.b     (a5),d7
[0000ace4] 0c47 0061                 cmpi.w     #$0061,d7
[0000ace8] 652a                      bcs.s      _btol_23
[0000acea] 4287                      clr.l      d7
[0000acec] 1e15                      move.b     (a5),d7
[0000acee] 0c47 007a                 cmpi.w     #$007A,d7
[0000acf2] 6338                      bls.s      _btol_24
[0000acf4] 601e                      bra.s      _btol_23
_btol_17:
[0000acf6] 2eae fff8                 move.l     -8(a6),(a7)
[0000acfa] 2f2e 0014                 move.l     20(a6),-(a7)
[0000acfe] 4eb9 0000 ade4            jsr        a.lmul
[0000ad04] 2e17                      move.l     (a7),d7
[0000ad06] de84                      add.l      d4,d7
[0000ad08] 2d47 fff8                 move.l     d7,-8(a6)
[0000ad0c] 5385                      subq.l     #1,d5
[0000ad0e] 528d                      addq.l     #1,a5
[0000ad10] 6000 ff56                 bra        _btol_7
_btol_23:
[0000ad14] 4287                      clr.l      d7
[0000ad16] 1e15                      move.b     (a5),d7
[0000ad18] 0c47 0041                 cmpi.w     #$0041,d7
[0000ad1c] 6500 ff6e                 bcs        _btol_15
[0000ad20] 4287                      clr.l      d7
[0000ad22] 1e15                      move.b     (a5),d7
[0000ad24] 0c47 005a                 cmpi.w     #$005A,d7
[0000ad28] 6200 ff62                 bhi        _btol_15
_btol_24:
[0000ad2c] 4287                      clr.l      d7
[0000ad2e] 1e15                      move.b     (a5),d7
[0000ad30] 0c47 0041                 cmpi.w     #$0041,d7
[0000ad34] 6514                      bcs.s      _btol_25
[0000ad36] 4287                      clr.l      d7
[0000ad38] 1e15                      move.b     (a5),d7
[0000ad3a] 0c47 005a                 cmpi.w     #$005A,d7
[0000ad3e] 620a                      bhi.s      _btol_25
[0000ad40] 7e20                      moveq.l    #32,d7
[0000ad42] 4286                      clr.l      d6
[0000ad44] 1c15                      move.b     (a5),d6
[0000ad46] de86                      add.l      d6,d7
[0000ad48] 6004                      bra.s      _btol_26
_btol_25:
[0000ad4a] 4287                      clr.l      d7
[0000ad4c] 1e15                      move.b     (a5),d7
_btol_26:
[0000ad4e] 7ca9                      moveq.l    #-87,d6
[0000ad50] dc87                      add.l      d7,d6
[0000ad52] 2806                      move.l     d6,d4
[0000ad54] 2e2e 0014                 move.l     20(a6),d7
[0000ad58] be84                      cmp.l      d4,d7
[0000ad5a] 6e9a                      bgt.s      _btol_17
[0000ad5c] 6000 ff2e                 bra        _btol_15
_btol_20:
[0000ad60] 2e0d                      move.l     a5,d7
[0000ad62] 9eae fff4                 sub.l      -12(a6),d7
[0000ad66] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[0000ad6a] 4e5e                      unlk       a6
[0000ad6c] 4e75                      rts

_close:
[0000ad6e] 205f                      movea.l    (a7)+,a0
[0000ad70] 7e06                      moveq.l    #6,d7
[0000ad72] 4e41                      trap       #1
[0000ad74] 4ed0                      jmp        (a0)

_cmpbuf:
[0000ad76] 4e56 0000                 link       a6,#0
[0000ad7a] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000ad7e] 2a6e 0008                 movea.l    8(a6),a5
[0000ad82] 286e 000c                 movea.l    12(a6),a4
[0000ad86] 2a2e 0010                 move.l     16(a6),d5
_cmpbuf_4:
[0000ad8a] 4a85                      tst.l      d5
[0000ad8c] 6710                      beq.s      _cmpbuf_1
[0000ad8e] 4287                      clr.l      d7
[0000ad90] 1e1d                      move.b     (a5)+,d7
[0000ad92] 4286                      clr.l      d6
[0000ad94] 1c1c                      move.b     (a4)+,d6
[0000ad96] be86                      cmp.l      d6,d7
[0000ad98] 670e                      beq.s      _cmpbuf_2
[0000ad9a] 4287                      clr.l      d7
[0000ad9c] 6002                      bra.s      _cmpbuf_3
_cmpbuf_1:
[0000ad9e] 7e01                      moveq.l    #1,d7
_cmpbuf_3:
[0000ada0] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000ada4] 4e5e                      unlk       a6
[0000ada6] 4e75                      rts
_cmpbuf_2:
[0000ada8] 5385                      subq.l     #1,d5
[0000adaa] 60de                      bra.s      _cmpbuf_4

_cpybuf:
[0000adac] 4e56 0000                 link       a6,#0
[0000adb0] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000adb4] 2a6e 0008                 movea.l    8(a6),a5
[0000adb8] 286e 000c                 movea.l    12(a6),a4
[0000adbc] 2a2e 0010                 move.l     16(a6),d5
_cpybuf_2:
[0000adc0] 4a85                      tst.l      d5
[0000adc2] 6706                      beq.s      _cpybuf_1
[0000adc4] 1adc                      move.b     (a4)+,(a5)+
[0000adc6] 5385                      subq.l     #1,d5
[0000adc8] 60f6                      bra.s      _cpybuf_2
_cpybuf_1:
[0000adca] 2e2e 0010                 move.l     16(a6),d7
[0000adce] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000add2] 4e5e                      unlk       a6
[0000add4] 4e75                      rts

_creat:
[0000add6] 205f                      movea.l    (a7)+,a0
[0000add8] 7e08                      moveq.l    #8,d7
[0000adda] 4e41                      trap       #1
[0000addc] 4ed0                      jmp        (a0)

_getpid:
[0000adde] 7e14                      moveq.l    #20,d7
[0000ade0] 4e41                      trap       #1
[0000ade2] 4e75                      rts

a.lmul:
[0000ade4] 302f 0008                 move.w     8(a7),d0
[0000ade8] c0ef 0006                 mulu.w     6(a7),d0
[0000adec] 3f40 0008                 move.w     d0,8(a7)
[0000adf0] 302f 000a                 move.w     10(a7),d0
[0000adf4] c0ef 0004                 mulu.w     4(a7),d0
[0000adf8] d16f 0008                 add.w      d0,8(a7)
[0000adfc] 302f 000a                 move.w     10(a7),d0
[0000ae00] c0ef 0006                 mulu.w     6(a7),d0
[0000ae04] 426f 000a                 clr.w      10(a7)
[0000ae08] 2e9f                      move.l     (a7)+,(a7)
[0000ae0a] d1af 0004                 add.l      d0,4(a7)
[0000ae0e] 4e75                      rts

a.1ltd:
[0000ae10] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[0000ae14] 41d7                      lea.l      (a7),a0
[0000ae16] 6008                      bra.s      a.1ltd_1
a.1ltd_1: ; not found: 0000ae20

a.6ltd:
[0000ae18] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[0000ae1c] 41ef 0008                 lea.l      8(a7),a0
[0000ae20] 4290                      clr.l      (a0)
[0000ae22] 2140 0004                 move.l     d0,4(a0)
[0000ae26] 6c02                      bge.s      a.6ltd_1
[0000ae28] 5390                      subq.l     #1,(a0)
a.6ltd_1:
[0000ae2a] 4878 0436                 pea.l      ($00000436).w
[0000ae2e] 4850                      pea.l      (a0)
[0000ae30] 4eb9 0000 aff8            jsr        a.repk
[0000ae36] 4fef 0008                 lea.l      8(a7),a7
[0000ae3a] 4cdf 06c6                 movem.l    (a7)+,d1-d2/d6-d7/a1-a2
[0000ae3e] 4e75                      rts

_putstr:
[0000ae40] 4e56 0000                 link       a6,#0
[0000ae44] 48e7 8004                 movem.l    d0/a5,-(a7)
[0000ae48] 45ee 000c                 lea.l      12(a6),a2
[0000ae4c] 2a4a                      movea.l    a2,a5
_putstr_2:
[0000ae4e] 4a95                      tst.l      (a5)
[0000ae50] 671c                      beq.s      _putstr_1
[0000ae52] 2e95                      move.l     (a5),(a7)
[0000ae54] 4eb9 0000 aef4            jsr        _lenstr
[0000ae5a] 2e87                      move.l     d7,(a7)
[0000ae5c] 2f15                      move.l     (a5),-(a7)
[0000ae5e] 2f2e 0008                 move.l     8(a6),-(a7)
[0000ae62] 4eb9 0000 aeba            jsr        _fwrite
[0000ae68] 508f                      addq.l     #8,a7
[0000ae6a] 588d                      addq.l     #4,a5
[0000ae6c] 60e0                      bra.s      _putstr_2
_putstr_1:
[0000ae6e] 4cdf 2001                 movem.l    (a7)+,d0/a5
[0000ae72] 4e5e                      unlk       a6
[0000ae74] 4e75                      rts

_sbreak:
[0000ae76] 205f                      movea.l    (a7)+,a0
[0000ae78] 2e17                      move.l     (a7),d7
[0000ae7a] 5287                      addq.l     #1,d7
[0000ae7c] 0887 0000                 bclr       #0,d7
[0000ae80] deb9 0002 1b62            add.l      $00021B62,d7
[0000ae86] 2f07                      move.l     d7,-(a7)
[0000ae88] 7e11                      moveq.l    #17,d7
[0000ae8a] 4e41                      trap       #1
[0000ae8c] 0c87 ffff ffff            cmpi.l     #$FFFFFFFF,d7
[0000ae92] 6606                      bne.s      _sbreak_1
[0000ae94] 4a9f                      tst.l      (a7)+
[0000ae96] 4287                      clr.l      d7
[0000ae98] 4ed0                      jmp        (a0)
_sbreak_1:
[0000ae9a] 2e39 0002 1b62            move.l     $00021B62,d7
[0000aea0] 23df 0002 1b62            move.l     (a7)+,$00021B62
[0000aea6] 4ab9 0002 1b66            tst.l      __stop
[0000aeac] 670a                      beq.s      _sbreak_2
[0000aeae] 23f9 0002 1b62 0002 1b66  move.l     $00021B62,__stop
_sbreak_2:
[0000aeb8] 4ed0                      jmp        (a0)

_fwrite:
[0000aeba] 4e56 0000                 link       a6,#0
[0000aebe] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[0000aec2] 2eae 0010                 move.l     16(a6),(a7)
[0000aec6] 2f2e 000c                 move.l     12(a6),-(a7)
[0000aeca] 2f2e 0008                 move.l     8(a6),-(a7)
[0000aece] 4eb9 0000 b106            jsr        _write
[0000aed4] 508f                      addq.l     #8,a7
[0000aed6] beae 0010                 cmp.l      16(a6),d7
[0000aeda] 6710                      beq.s      _fwrite_1
[0000aedc] 2ebc 0002 1b86            move.l     #_writerr,(a7)
[0000aee2] 42a7                      clr.l      -(a7)
[0000aee4] 4eb9 0000 af16            jsr        __raise
[0000aeea] 588f                      addq.l     #4,a7
_fwrite_1:
[0000aeec] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[0000aef0] 4e5e                      unlk       a6
[0000aef2] 4e75                      rts

_lenstr:
[0000aef4] 4e56 0000                 link       a6,#0
[0000aef8] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[0000aefc] 2a6e 0008                 movea.l    8(a6),a5
[0000af00] 284d                      movea.l    a5,a4
_lenstr_2:
[0000af02] 4a14                      tst.b      (a4)
[0000af04] 6704                      beq.s      _lenstr_1
[0000af06] 528c                      addq.l     #1,a4
[0000af08] 60f8                      bra.s      _lenstr_2
_lenstr_1:
[0000af0a] 2e0c                      move.l     a4,d7
[0000af0c] 9e8d                      sub.l      a5,d7
[0000af0e] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[0000af12] 4e5e                      unlk       a6
[0000af14] 4e75                      rts

__raise:
[0000af16] 246f 0004                 movea.l    4(a7),a2
[0000af1a] 262f 0008                 move.l     8(a7),d3
[0000af1e] 2803                      move.l     d3,d4
[0000af20] 670c                      beq.s      __raise_1
[0000af22] 280a                      move.l     a2,d4
[0000af24] 0c83 ffff ffff            cmpi.l     #$FFFFFFFF,d3
[0000af2a] 6602                      bne.s      __raise_1
[0000af2c] 4283                      clr.l      d3
__raise_1:
[0000af2e] 200a                      move.l     a2,d0
[0000af30] 6708                      beq.s      __raise_2
[0000af32] b5fc ffff ffff            cmpa.l     #$FFFFFFFF,a2
[0000af38] 660a                      bne.s      __raise_3
__raise_2:
[0000af3a] 2479 0002 1b6a            movea.l    $00021B6A,a2
[0000af40] 200a                      move.l     a2,d0
[0000af42] 674e                      beq.s      __raise_4
__raise_3:
[0000af44] 4a83                      tst.l      d3
[0000af46] 6626                      bne.s      __raise_5
[0000af48] 4287                      clr.l      d7
__raise_12:
[0000af4a] 2e4a                      movea.l    a2,a7
[0000af4c] 4a84                      tst.l      d4
[0000af4e] 6600 0096                 bne        __raise_6
[0000af52] 202a 0028                 move.l     40(a2),d0
[0000af56] 6704                      beq.s      __raise_7
[0000af58] 2040                      movea.l    d0,a0
[0000af5a] 2083                      move.l     d3,(a0)
__raise_7:
[0000af5c] 23df 0002 1b6a            move.l     (a7)+,$00021B6A
[0000af62] 4cdf 783a                 movem.l    (a7)+,d1/d3-d5/a3-a6
[0000af66] 4e75                      rts
__raise_8:
[0000af68] 2452                      movea.l    (a2),a2
[0000af6a] 200a                      move.l     a2,d0
[0000af6c] 6724                      beq.s      __raise_4
__raise_5:
[0000af6e] 41ea 002c                 lea.l      44(a2),a0
[0000af72] 2e08                      move.l     a0,d7
__raise_11:
[0000af74] 0c90 ffff ffff            cmpi.l     #$FFFFFFFF,(a0)
[0000af7a] 67ec                      beq.s      __raise_8
[0000af7c] 4a98                      tst.l      (a0)+
[0000af7e] 6604                      bne.s      __raise_9
[0000af80] 4284                      clr.l      d4
[0000af82] 6006                      bra.s      __raise_10
__raise_9:
[0000af84] b6a8 fffc                 cmp.l      -4(a0),d3
[0000af88] 66ea                      bne.s      __raise_11
__raise_10:
[0000af8a] 9e88                      sub.l      a0,d7
[0000af8c] 4487                      neg.l      d7
[0000af8e] e487                      asr.l      #2,d7
[0000af90] 60b8                      bra.s      __raise_12
__raise_4:
[0000af92] 42a7                      clr.l      -(a7)
[0000af94] 4a83                      tst.l      d3
[0000af96] 6706                      beq.s      __raise_13
[0000af98] 0803 0000                 btst       #0,d3
[0000af9c] 6706                      beq.s      __raise_14
__raise_13:
[0000af9e] 263c 0002 1b6e            move.l     #$00021B6E,d3
__raise_14:
[0000afa4] 2043                      movea.l    d3,a0
[0000afa6] 2f10                      move.l     (a0),-(a7)
[0000afa8] 4eb9 0000 b0c8            jsr        _error
__raise_15:
[0000afae] 4e71                      nop
[0000afb0] 60fc                      bra.s      __raise_15
__raise_6: ; not found: 0000afe6

__when:
[0000afb2] 2039 0002 1b6a            move.l     $00021B6A,d0
[0000afb8] 720c                      moveq.l    #12,d1
[0000afba] 48e7 dc1e                 movem.l    d0-d1/d3-d5/a3-a6,-(a7)
[0000afbe] 244f                      movea.l    a7,a2
[0000afc0] 202a 0028                 move.l     40(a2),d0
[0000afc4] 6704                      beq.s      __when_1
[0000afc6] 2040                      movea.l    d0,a0
[0000afc8] 208a                      move.l     a2,(a0)
__when_1:
[0000afca] 41ea 002c                 lea.l      44(a2),a0
__when_3:
[0000afce] 4a90                      tst.l      (a0)
[0000afd0] 6712                      beq.s      __when_2
[0000afd2] 0c98 ffff ffff            cmpi.l     #$FFFFFFFF,(a0)+
[0000afd8] 670a                      beq.s      __when_2
[0000afda] 06aa 0000 0004 0004       addi.l     #$00000004,4(a2)
[0000afe2] 60ea                      bra.s      __when_3
__when_2:
[0000afe4] 7eff                      moveq.l    #-1,d7
[0000afe6] 23ca 0002 1b6a            move.l     a2,$00021B6A
[0000afec] 206a 0024                 movea.l    36(a2),a0
[0000aff0] 4cd2 783b                 movem.l    (a2),d0-d1/d3-d5/a3-a6
[0000aff4] 9fc1                      suba.l     d1,a7
[0000aff6] 4ed0                      jmp        (a0)

a.repk:
[0000aff8] 206f 0004                 movea.l    4(a7),a0
[0000affc] 4280                      clr.l      d0
[0000affe] 2428 0004                 move.l     4(a0),d2
[0000b002] 2210                      move.l     (a0),d1
[0000b004] 6c08                      bge.s      a.repk_1
[0000b006] 08c0 001f                 bset       #31,d0
[0000b00a] 4482                      neg.l      d2
[0000b00c] 4081                      negx.l     d1
a.repk_1:
[0000b00e] 6606                      bne.s      a.repk_2
[0000b010] 4a82                      tst.l      d2
[0000b012] 6602                      bne.s      a.repk_2
[0000b014] 4e75                      rts
a.repk_2:
[0000b016] 2e2f 0008                 move.l     8(a7),d7
[0000b01a] 5587                      subq.l     #2,d7
a.repk_4:
[0000b01c] 0c81 0040 0000            cmpi.l     #$00400000,d1
[0000b022] 650e                      bcs.s      a.repk_3
[0000b024] 5287                      addq.l     #1,d7
[0000b026] e28a                      lsr.l      #1,d2
[0000b028] e281                      asr.l      #1,d1
[0000b02a] 64f0                      bcc.s      a.repk_4
[0000b02c] 08c2 001f                 bset       #31,d2
[0000b030] 60ea                      bra.s      a.repk_4
a.repk_3:
[0000b032] 0c81 0020 0000            cmpi.l     #$00200000,d1
[0000b038] 640c                      bcc.s      a.repk_5
[0000b03a] 5387                      subq.l     #1,d7
[0000b03c] e389                      lsl.l      #1,d1
[0000b03e] e38a                      lsl.l      #1,d2
[0000b040] 64f0                      bcc.s      a.repk_3
[0000b042] 5281                      addq.l     #1,d1
[0000b044] 60ec                      bra.s      a.repk_3
a.repk_5:
[0000b046] 0802 0000                 btst       #0,d2
[0000b04a] 6708                      beq.s      a.repk_6
[0000b04c] 5282                      addq.l     #1,d2
[0000b04e] 6404                      bcc.s      a.repk_6
[0000b050] 5281                      addq.l     #1,d1
[0000b052] 60c8                      bra.s      a.repk_4
a.repk_6:
[0000b054] e28a                      lsr.l      #1,d2
[0000b056] e281                      asr.l      #1,d1
[0000b058] 6404                      bcc.s      a.repk_7
[0000b05a] 08c2 001f                 bset       #31,d2
a.repk_7:
[0000b05e] 4a87                      tst.l      d7
[0000b060] 6e06                      bgt.s      a.repk_8
[0000b062] 4298                      clr.l      (a0)+
[0000b064] 4290                      clr.l      (a0)
[0000b066] 4e75                      rts
a.repk_8:
[0000b068] 0c47 07ff                 cmpi.w     #$07FF,d7
[0000b06c] 6f0c                      ble.s      a.repk_9
[0000b06e] 72ff                      moveq.l    #-1,d1
[0000b070] 74ff                      moveq.l    #-1,d2
[0000b072] 3e3c 07ff                 move.w     #$07FF,d7
[0000b076] 0881 001f                 bclr       #31,d1
a.repk_9:
[0000b07a] 2081                      move.l     d1,(a0)
[0000b07c] 0250 000f                 andi.w     #$000F,(a0)
[0000b080] e94f                      lsl.w      #4,d7
[0000b082] 8f50                      or.w       d7,(a0)
[0000b084] 2142 0004                 move.l     d2,4(a0)
[0000b088] 8190                      or.l       d0,(a0)
[0000b08a] 4e75                      rts

xb08c:
[0000b08c] 4e56 0000                 link       a6,#0
[0000b090] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[0000b094] 2a6e 0008                 movea.l    8(a6),a5
[0000b098] 2e0d                      move.l     a5,d7
[0000b09a] 670e                      beq.s      xb08c_1
[0000b09c] 4a15                      tst.b      (a5)
[0000b09e] 670a                      beq.s      xb08c_1
[0000b0a0] 284d                      movea.l    a5,a4
xb08c_3:
[0000b0a2] 4a14                      tst.b      (a4)
[0000b0a4] 670c                      beq.s      xb08c_2
[0000b0a6] 528c                      addq.l     #1,a4
[0000b0a8] 60f8                      bra.s      xb08c_3
xb08c_1:
[0000b0aa] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[0000b0ae] 4e5e                      unlk       a6
[0000b0b0] 4e75                      rts
xb08c_2:
[0000b0b2] 2e0c                      move.l     a4,d7
[0000b0b4] 9e8d                      sub.l      a5,d7
[0000b0b6] 2e87                      move.l     d7,(a7)
[0000b0b8] 2f0d                      move.l     a5,-(a7)
[0000b0ba] 4878 0002                 pea.l      ($00000002).w
[0000b0be] 4eb9 0000 b106            jsr        _write
[0000b0c4] 508f                      addq.l     #8,a7
[0000b0c6] 60e2                      bra.s      xb08c_1

_error:
[0000b0c8] 4e56 fffc                 link       a6,#-4
[0000b0cc] 2eb9 0002 0cc0            move.l     __pname,(a7)
[0000b0d2] 4eba ffb8                 jsr        $0000B08C(pc)
[0000b0d6] 2ebc 0002 1b98            move.l     #$00021B98,(a7)
[0000b0dc] 4eba ffae                 jsr        $0000B08C(pc)
[0000b0e0] 2eae 0008                 move.l     8(a6),(a7)
[0000b0e4] 4eba ffa6                 jsr        $0000B08C(pc)
[0000b0e8] 2eae 000c                 move.l     12(a6),(a7)
[0000b0ec] 4eba ff9e                 jsr        $0000B08C(pc)
[0000b0f0] 2ebc 0002 1b96            move.l     #$00021B96,(a7)
[0000b0f6] 4eba ff94                 jsr        $0000B08C(pc)
[0000b0fa] 4297                      clr.l      (a7)
[0000b0fc] 4eb9 0000 0080            jsr        _exit
[0000b102] 4e5e                      unlk       a6
[0000b104] 4e75                      rts

_write:
[0000b106] 205f                      movea.l    (a7)+,a0
[0000b108] 7e04                      moveq.l    #4,d7
[0000b10a] 4e41                      trap       #1
[0000b10c] 4ed0                      jmp        (a0)

	.data
__data:
[00020000]                           dc.b $00
[00020001]                           dc.b 'idr68k Edition 3.0: Copyright (c) 1981,1983,1985 by Whitesmiths, Ltd. all rights reserved',0
[0002005b]                           dc.b '|/bin/|/usr/bin/',0
[0002006c]                           dc.b 'PATH',0
[00020071]                           dc.b $00
_environ:
[00020072]                           dc.b $00
[00020073]                           dc.b $00
[00020074]                           dc.b $00
[00020075]                           dc.b $00
_errno:
[00020076]                           dc.b $00
[00020077]                           dc.b $00
[00020078]                           dc.b $00
[00020079]                           dc.b $00
__paths:
[0002007a] 0002005b                  dc.l $0002005b ; no symbol found
[0002007e] 000000aa                  dc.l _onexit
[00020082]                           dc.b $00
[00020083]                           dc.b $00
[00020084]                           dc.b $00
[00020085]                           dc.b $00
[00020086]                           dc.b $00
[00020087]                           dc.b $00
[00020088]                           dc.b $00
[00020089]                           dc.b $00
[0002008a]                           dc.b $00
[0002008b]                           dc.b $00
[0002008c]                           dc.b $00
[0002008d]                           dc.b $00
[0002008e]                           dc.b $00
[0002008f]                           dc.b $00
[00020090]                           dc.b $00
[00020091]                           dc.b $00
[00020092]                           dc.b $00
[00020093]                           dc.b $00
[00020094]                           dc.b $00
[00020095]                           dc.b $00
[00020096]                           dc.b $00
[00020097]                           dc.b $00
[00020098]                           dc.b $00
[00020099]                           dc.b $00
[0002009a]                           dc.b $00
[0002009b]                           dc.b $00
[0002009c]                           dc.b $00
[0002009d]                           dc.b $00
[0002009e]                           dc.b 'bad alias',0
[000200a8]                           dc.b 'alias defined',0
[000200b6]                           dc.w $0300
[000200b8]                           dc.b $00
[000200b9]                           dc.b $00
[000200ba]                           dc.b 'string initializer too long',0
[000200d6]                           dc.b 'too many initializers',0
[000200ec]                           dc.b 'redefined',0
[000200f6] 00000788                  dc.l $00000788 ; no symbol found
[000200fa]                           dc.b $00
[000200fb]                           dc.b $00
[000200fc]                           dc.b $00
[000200fd]                           dc.b $2a
[000200fe] 00000788                  dc.l $00000788 ; no symbol found
[00020102]                           dc.b $00
[00020103]                           dc.b $00
[00020104]                           dc.b $00
[00020105]                           dc.b $29
[00020106] 00000788                  dc.l $00000788 ; no symbol found
[0002010a]                           dc.b $00
[0002010b]                           dc.b $00
[0002010c]                           dc.b $00
[0002010d]                           dc.b $28
[0002010e] 000006de                  dc.l $000006de ; no symbol found
[00020112]                           dc.b $00
[00020113]                           dc.b $00
[00020114]                           dc.b $00
[00020115]                           dc.b $40
[00020116] 00000678                  dc.l $00000678 ; no symbol found
[0002011a]                           dc.b $00
[0002011b]                           dc.b $00
[0002011c]                           dc.b $00
[0002011d]                           dc.b $21
[0002011e] 00000678                  dc.l $00000678 ; no symbol found
[00020122]                           dc.b $00
[00020123]                           dc.b $00
[00020124]                           dc.b $00
[00020125]                           dc.b $20
[00020126] 00000678                  dc.l $00000678 ; no symbol found
[0002012a]                           dc.b $00
[0002012b]                           dc.b $00
[0002012c]                           dc.b $00
[0002012d]                           dc.b $1a
[0002012e] 00000678                  dc.l $00000678 ; no symbol found
[00020132]                           dc.b $00
[00020133]                           dc.b $00
[00020134]                           dc.b $00
[00020135]                           dc.b $18
[00020136] 00000678                  dc.l $00000678 ; no symbol found
[0002013a]                           dc.b $00
[0002013b]                           dc.b $00
[0002013c]                           dc.b $00
[0002013d]                           dc.b $11
[0002013e] 00000678                  dc.l $00000678 ; no symbol found
[00020142]                           dc.b $00
[00020143]                           dc.b $00
[00020144]                           dc.b $00
[00020145]                           dc.b $10
[00020146] 00000678                  dc.l $00000678 ; no symbol found
[0002014a]                           dc.b $00
[0002014b]                           dc.b $00
[0002014c]                           dc.b $00
[0002014d]                           dc.b $0a
[0002014e] 00000678                  dc.l $00000678 ; no symbol found
[00020152]                           dc.b $00
[00020153]                           dc.b $00
[00020154]                           dc.b $00
[00020155]                           dc.b $09
[00020156] 00000678                  dc.l $00000678 ; no symbol found
[0002015a]                           dc.b $00
[0002015b]                           dc.b $00
[0002015c]                           dc.b $00
[0002015d]                           dc.b $08
[0002015e] 00000636                  dc.l $00000636 ; no symbol found
[00020162]                           dc.b $00
[00020163]                           dc.b $00
[00020164]                           dc.b $00
[00020165]                           dc.b $49
[00020166]                           dc.b $00
[00020167]                           dc.b $00
[00020168]                           dc.b $00
[00020169]                           dc.b $00
[0002016a] 00000826                  dc.l $00000826 ; no symbol found
[0002016e]                           dc.b 'cannot initialize',0
[00020180]                           dc.b 'illegal double initializer',0
[0002019b]                           dc.b 'illegal pointer initializer',0
[000201b7]                           dc.b 'illegal pointer initializer type',0
[000201d8]                           dc.b 'illegal integer initializer',0
[000201f4]                           dc.b $00
[000201f5]                           dc.b $00
[000201f6]                           dc.b $00
[000201f7]                           dc.b $00
[000201f8]                           dc.b 'illegal repeat count',0
[0002020d]                           dc.b 'excess repeated initializers',0
[0002022a]                           dc.b 'illegal field initializer',0
[00020244]                           dc.w $e285
[00020246]                           dc.w $99de
[00020248]                           dc.w $d897
[0002024a]                           dc.w $a095
[0002024c]                           dc.w $968f
[0002024e]                           dc.w $9094
[00020250]                           dc.w $9bc1
[00020252]                           dc.w $a39c
[00020254]                           dc.w $829d
[00020256]                           dc.w $9f88
[00020258]                           dc.w $9187
[0002025a]                           dc.w $8c8e
[0002025c]                           dc.w $8b89
[0002025e]                           dc.w $8a86
[00020260]                           dc.w $928d
[00020262]                           dc.b $00
[00020263]                           dc.b $91
[00020264]                           dc.w $878c
[00020266]                           dc.w $8e8b
[00020268]                           dc.w $898a
[0002026a]                           dc.b $00
[0002026b]                           dc.b $00
[0002026c]                           dc.b $00
[0002026d]                           dc.b $00
[0002026e]                           dc.b $00
[0002026f]                           dc.b $00
[00020270]                           dc.w $8692
[00020272]                           dc.w $8d00
[00020274]                           dc.b $00
[00020275]                           dc.b $00
[00020276]                           dc.b $00
[00020277]                           dc.b $00
[00020278]                           dc.b $00
[00020279]                           dc.b $00
[0002027a]                           dc.b $00
[0002027b]                           dc.b $00
[0002027c]                           dc.b $00
[0002027d]                           dc.b $00
[0002027e]                           dc.b $00
[0002027f]                           dc.b $00
[00020280]                           dc.b $00
[00020281]                           dc.b $0e
[00020282]                           dc.w $0e0e
[00020284]                           dc.w $0d0d
[00020286]                           dc.w $0c0c
[00020288]                           dc.w $0b0b
[0002028a]                           dc.w $0b0b
[0002028c]                           dc.w $0a0a
[0002028e]                           dc.w $0908
[00020290]                           dc.w $0706
[00020292]                           dc.w $0503
[00020294]                           dc.w $0101
[00020296]                           dc.w $0101
[00020298]                           dc.w $0101
[0002029a]                           dc.w $0101
[0002029c]                           dc.w $0101
[0002029e]                           dc.w $010e
[000202a0]                           dc.w $0e0e
[000202a2]                           dc.w $0d0d
[000202a4]                           dc.w $0c0c
[000202a6]                           dc.w $0b0b
[000202a8]                           dc.w $0b0b
[000202aa]                           dc.w $0a0a
[000202ac]                           dc.w $0908
[000202ae]                           dc.w $0706
[000202b0]                           dc.w $0504
[000202b2]                           dc.w $0202
[000202b4]                           dc.w $0202
[000202b6]                           dc.w $0202
[000202b8]                           dc.w $0202
[000202ba]                           dc.w $0202
[000202bc]                           dc.w $0200
_freeexpr:
[000202be]                           dc.b $00
[000202bf]                           dc.b $00
[000202c0]                           dc.b $00
[000202c1]                           dc.b $01
[000202c2]                           dc.b 'constant required',0
[000202d4] 00000f20                  dc.l $00000f20 ; no symbol found
[000202d8]                           dc.b $00
[000202d9]                           dc.b $00
[000202da]                           dc.b $00
[000202db]                           dc.b $3a
[000202dc] 00000f14                  dc.l $00000f14 ; no symbol found
[000202e0]                           dc.b $00
[000202e1]                           dc.b $00
[000202e2]                           dc.b $00
[000202e3]                           dc.b $3f
[000202e4] 00000f08                  dc.l $00000f08 ; no symbol found
[000202e8]                           dc.b $00
[000202e9]                           dc.b $00
[000202ea]                           dc.b $00
[000202eb]                           dc.b $31
[000202ec] 00000efa                  dc.l $00000efa ; no symbol found
[000202f0]                           dc.b $00
[000202f1]                           dc.b $00
[000202f2]                           dc.b $00
[000202f3]                           dc.b $21
[000202f4] 00000eec                  dc.l $00000eec ; no symbol found
[000202f8]                           dc.b $00
[000202f9]                           dc.b $00
[000202fa]                           dc.b $00
[000202fb]                           dc.b $3b
[000202fc] 00000edc                  dc.l $00000edc ; no symbol found
[00020300]                           dc.b $00
[00020301]                           dc.b $00
[00020302]                           dc.b $00
[00020303]                           dc.b $3d
[00020304] 00000edc                  dc.l $00000edc ; no symbol found
[00020308]                           dc.b $00
[00020309]                           dc.b $00
[0002030a]                           dc.b $00
[0002030b]                           dc.b $34
[0002030c] 00000ec6                  dc.l $00000ec6 ; no symbol found
[00020310]                           dc.b $00
[00020311]                           dc.b $00
[00020312]                           dc.b $00
[00020313]                           dc.b $3c
[00020314] 00000ec6                  dc.l $00000ec6 ; no symbol found
[00020318]                           dc.b $00
[00020319]                           dc.b $00
[0002031a]                           dc.b $00
[0002031b]                           dc.b $2a
[0002031c] 00000ec6                  dc.l $00000ec6 ; no symbol found
[00020320]                           dc.b $00
[00020321]                           dc.b $00
[00020322]                           dc.b $00
[00020323]                           dc.b $3e
[00020324]                           dc.b $00
[00020325]                           dc.b $00
[00020326]                           dc.b $00
[00020327]                           dc.b $00
[00020328] 00000f28                  dc.l $00000f28 ; no symbol found
[0002032c]                           dc.b 'illegal use of typedef',0
[00020343]                           dc.b $00
[00020344]                           dc.w $0300
[00020346]                           dc.b $00
[00020347]                           dc.b $00
[00020348]                           dc.w $e2c1
[0002034a]                           dc.w $ded8
[0002034c]                           dc.b 'ZC`',0
[00020350]                           dc.b 'kdmlZC`',0
[00020358] 000012b2                  dc.l $000012b2 ; no symbol found
[0002035c]                           dc.b $00
[0002035d]                           dc.b $00
[0002035e]                           dc.b $00
[0002035f]                           dc.b $61
[00020360] 0000127a                  dc.l $0000127a ; no symbol found
[00020364]                           dc.b $00
[00020365]                           dc.b $00
[00020366]                           dc.b $00
[00020367]                           dc.b $06
[00020368] 00001222                  dc.l $00001222 ; no symbol found
[0002036c]                           dc.b $00
[0002036d]                           dc.b $00
[0002036e]                           dc.b $00
[0002036f]                           dc.b $44
[00020370] 00001222                  dc.l $00001222 ; no symbol found
[00020374]                           dc.b $00
[00020375]                           dc.b $00
[00020376]                           dc.b $00
[00020377]                           dc.b $53
[00020378] 000011e2                  dc.l $000011e2 ; no symbol found
[0002037c]                           dc.b $00
[0002037d]                           dc.b $00
[0002037e]                           dc.b $00
[0002037f]                           dc.b $60
[00020380] 000011e2                  dc.l $000011e2 ; no symbol found
[00020384]                           dc.b $00
[00020385]                           dc.b $00
[00020386]                           dc.b $00
[00020387]                           dc.b $43
[00020388] 000011e2                  dc.l $000011e2 ; no symbol found
[0002038c]                           dc.b $00
[0002038d]                           dc.b $00
[0002038e]                           dc.b $00
[0002038f]                           dc.b $5a
[00020390] 000011e2                  dc.l $000011e2 ; no symbol found
[00020394]                           dc.b $00
[00020395]                           dc.b $00
[00020396]                           dc.b $00
[00020397]                           dc.b $d8
[00020398] 000011e2                  dc.l $000011e2 ; no symbol found
[0002039c]                           dc.b $00
[0002039d]                           dc.b $00
[0002039e]                           dc.b $00
[0002039f]                           dc.b $de
[000203a0] 000011e2                  dc.l $000011e2 ; no symbol found
[000203a4]                           dc.b $00
[000203a5]                           dc.b $00
[000203a6]                           dc.b $00
[000203a7]                           dc.b $c1
[000203a8] 000011e2                  dc.l $000011e2 ; no symbol found
[000203ac]                           dc.b $00
[000203ad]                           dc.b $00
[000203ae]                           dc.b $00
[000203af]                           dc.b $e2
[000203b0] 00001182                  dc.l $00001182 ; no symbol found
[000203b4]                           dc.b $00
[000203b5]                           dc.b $00
[000203b6]                           dc.b $00
[000203b7]                           dc.b $11
[000203b8] 00001182                  dc.l $00001182 ; no symbol found
[000203bc]                           dc.b $00
[000203bd]                           dc.b $00
[000203be]                           dc.b $00
[000203bf]                           dc.b $10
[000203c0] 00001182                  dc.l $00001182 ; no symbol found
[000203c4]                           dc.b $00
[000203c5]                           dc.b $00
[000203c6]                           dc.b $00
[000203c7]                           dc.b $1e
[000203c8] 000010d8                  dc.l $000010d8 ; no symbol found
[000203cc]                           dc.b $00
[000203cd]                           dc.b $00
[000203ce]                           dc.b $00
[000203cf]                           dc.b $17
[000203d0] 0000106e                  dc.l $0000106e ; no symbol found
[000203d4]                           dc.b $00
[000203d5]                           dc.b $00
[000203d6]                           dc.b $00
[000203d7]                           dc.b $19
[000203d8] 0000106e                  dc.l $0000106e ; no symbol found
[000203dc]                           dc.b $00
[000203dd]                           dc.b $00
[000203de]                           dc.b $00
[000203df]                           dc.b $15
[000203e0] 0000106e                  dc.l $0000106e ; no symbol found
[000203e4]                           dc.b $00
[000203e5]                           dc.b $00
[000203e6]                           dc.b $00
[000203e7]                           dc.b $1a
[000203e8] 0000106e                  dc.l $0000106e ; no symbol found
[000203ec]                           dc.b $00
[000203ed]                           dc.b $00
[000203ee]                           dc.b $00
[000203ef]                           dc.b $16
[000203f0] 0000106e                  dc.l $0000106e ; no symbol found
[000203f4]                           dc.b $00
[000203f5]                           dc.b $00
[000203f6]                           dc.b $00
[000203f7]                           dc.b $1b
[000203f8] 0000106e                  dc.l $0000106e ; no symbol found
[000203fc]                           dc.b $00
[000203fd]                           dc.b $00
[000203fe]                           dc.b $00
[000203ff]                           dc.b $18
[00020400] 00001054                  dc.l $00001054 ; no symbol found
[00020404]                           dc.b $00
[00020405]                           dc.b $00
[00020406]                           dc.b $00
[00020407]                           dc.b $12
[00020408]                           dc.b $00
[00020409]                           dc.b $00
[0002040a]                           dc.b $00
[0002040b]                           dc.b $00
[0002040c] 00001334                  dc.l $00001334 ; no symbol found
[00020410]                           dc.b 'missing expression',0
[00020423]                           dc.b $00
[00020424] 00001504                  dc.l $00001504 ; no symbol found
[00020428]                           dc.b $00
[00020429]                           dc.b $00
[0002042a]                           dc.b $00
[0002042b]                           dc.b $53
[0002042c] 00001504                  dc.l $00001504 ; no symbol found
[00020430]                           dc.b $00
[00020431]                           dc.b $00
[00020432]                           dc.b $00
[00020433]                           dc.b $44
[00020434] 00001466                  dc.l $00001466 ; no symbol found
[00020438]                           dc.b $00
[00020439]                           dc.b $00
[0002043a]                           dc.b $00
[0002043b]                           dc.b $03
[0002043c] 00001466                  dc.l $00001466 ; no symbol found
[00020440]                           dc.b $00
[00020441]                           dc.b $00
[00020442]                           dc.b $00
[00020443]                           dc.b $07
[00020444] 00001422                  dc.l $00001422 ; no symbol found
[00020448]                           dc.b $00
[00020449]                           dc.b $00
[0002044a]                           dc.b $00
[0002044b]                           dc.b $04
[0002044c] 000013a4                  dc.l $000013a4 ; no symbol found
[00020450]                           dc.b $00
[00020451]                           dc.b $00
[00020452]                           dc.b $00
[00020453]                           dc.b $06
[00020454]                           dc.b $00
[00020455]                           dc.b $00
[00020456]                           dc.b $00
[00020457]                           dc.b $00
[00020458] 00001550                  dc.l $00001550 ; no symbol found
[0002045c]                           dc.b 'missing member name',0
[00020470] 00020d68                  dc.l _atchar
[00020474] 00020d8c                  dc.l _atuchar
[00020478] 00020d9e                  dc.l _atshort
[0002047c] 00020db0                  dc.l _atushort
[00020480] 00020dc2                  dc.l _atint
[00020484] 00020dd4                  dc.l _atunsign
[00020488] 00020d68                  dc.l _atchar
[0002048c] 00020d8c                  dc.l _atuchar
[00020490] 00020dc2                  dc.l _atint
[00020494] 00020dd4                  dc.l _atunsign
[00020498] 00020de6                  dc.l _atlong
[0002049c] 00020df8                  dc.l _atulong
_regset:
[000204a0]                           dc.b $00
[000204a1]                           dc.b $1c
_autoff:
[000204a2]                           dc.b $00
[000204a3]                           dc.b $00
[000204a4]                           dc.b $00
[000204a5]                           dc.b $00
_dbline:
[000204a6]                           dc.b $00
[000204a7]                           dc.b $00
_dbfilab:
[000204a8]                           dc.b $00
[000204a9]                           dc.b $00
_dbfulab:
[000204aa]                           dc.b $00
[000204ab]                           dc.b $00
_dbfvlab:
[000204ac]                           dc.b $00
[000204ad]                           dc.b $00
_rat:
[000204ae]                           dc.b $00
[000204af]                           dc.b $00
[000204b0]                           dc.b $00
[000204b1]                           dc.b $00
_caseterm:
[000204b2]                           dc.b $00
[000204b3]                           dc.b $00
[000204b4]                           dc.b $00
[000204b5]                           dc.b $00
[000204b6]                           dc.b $00
[000204b7]                           dc.b $00
[000204b8]                           dc.b $00
[000204b9]                           dc.b $00
[000204ba]                           dc.b $00
[000204bb]                           dc.b $00
[000204bc]                           dc.b $00
[000204bd]                           dc.b $00
[000204be]                           dc.b $00
[000204bf]                           dc.b $00
[000204c0]                           dc.b $00
[000204c1]                           dc.b $00
[000204c2]                           dc.b $00
[000204c3]                           dc.b $00
[000204c4]                           dc.b $00
[000204c5]                           dc.b $00
[000204c6]                           dc.b $00
[000204c7]                           dc.b $00
[000204c8]                           dc.b $00
[000204c9]                           dc.b $00
_rterm:
[000204ca]                           dc.b $00
[000204cb]                           dc.b $00
[000204cc]                           dc.b $00
[000204cd]                           dc.b $00
[000204ce]                           dc.b $00
[000204cf]                           dc.b $00
[000204d0]                           dc.b $00
[000204d1]                           dc.b $00
[000204d2]                           dc.b $00
[000204d3]                           dc.b $00
[000204d4]                           dc.b $00
[000204d5]                           dc.b $00
[000204d6]                           dc.b $00
[000204d7]                           dc.b $00
[000204d8]                           dc.b $00
[000204d9]                           dc.b $00
[000204da]                           dc.b $00
[000204db]                           dc.b $00
[000204dc]                           dc.b $00
[000204dd]                           dc.b $00
[000204de]                           dc.b $00
[000204df]                           dc.b $00
[000204e0]                           dc.b $00
[000204e1]                           dc.b $00
[000204e2]                           dc.b 'duplicate case value',0
[000204f7]                           dc.b $00
[000204f8] 000204fc                  dc.l $000204fc ; no symbol found
[000204fc]                           dc.b $00
[000204fd]                           dc.b $00
[000204fe] 00020502                  dc.l $00020502 ; no symbol found
[00020502]                           dc.b $00
[00020503]                           dc.b $00
[00020504]                           dc.b '4=<;!1',0
[0002050b]                           dc.b $00
[0002050c]                           dc.b $00
[0002050d]                           dc.b $00
[0002050e]                           dc.b $00
[0002050f]                           dc.b $00
[00020510] 00020514                  dc.l $00020514 ; no symbol found
[00020514]                           dc.b $00
[00020515]                           dc.b $01
[00020516]                           dc.w $0101
[00020518]                           dc.w $0203
[0002051a]                           dc.w $0400
[0002051c]                           dc.b '*4><=:',0
[00020523]                           dc.b 'unexpected EOF',0
[00020532]                           dc.b 'redefined external',0
[00020545]                           dc.b 'redeclared local',0
[00020556]                           dc.b $00
[00020557]                           dc.b $00
[00020558]                           dc.b $00
[00020559]                           dc.b $00
[0002055a]                           dc.b $00
[0002055b]                           dc.b $00
[0002055c]                           dc.b $00
[0002055d]                           dc.b $00
[0002055e]                           dc.b $00
[0002055f]                           dc.b $00
[00020560]                           dc.b $00
[00020561]                           dc.b $00
[00020562]                           dc.b $00
[00020563]                           dc.b $00
[00020564]                           dc.b $00
[00020565]                           dc.b $00
[00020566]                           dc.b $00
[00020567]                           dc.b $00
[00020568]                           dc.b $00
[00020569]                           dc.b $00
[0002056a]                           dc.b $00
[0002056b]                           dc.b $00
[0002056c]                           dc.b $00
[0002056d]                           dc.b $00
[0002056e]                           dc.b $00
[0002056f]                           dc.b $00
[00020570]                           dc.b $00
[00020571]                           dc.b $00
[00020572]                           dc.b $00
[00020573]                           dc.b $00
[00020574] 000023c6                  dc.l $000023c6 ; no symbol found
[00020578]                           dc.b $00
[00020579]                           dc.b $00
[0002057a]                           dc.b $00
[0002057b]                           dc.b $26
[0002057c] 0000229e                  dc.l $0000229e ; no symbol found
[00020580]                           dc.b $00
[00020581]                           dc.b $00
[00020582]                           dc.b $00
[00020583]                           dc.b $23
[00020584]                           dc.b $00
[00020585]                           dc.b $00
[00020586]                           dc.b $00
[00020587]                           dc.b $00
[00020588] 0000240a                  dc.l $0000240a ; no symbol found
[0002058c] 00002904                  dc.l $00002904 ; no symbol found
[00020590]                           dc.b $00
[00020591]                           dc.b $00
[00020592]                           dc.b $00
[00020593]                           dc.b $36
[00020594] 0000286e                  dc.l $0000286e ; no symbol found
[00020598]                           dc.b $00
[00020599]                           dc.b $00
[0002059a]                           dc.b $00
[0002059b]                           dc.b $2d
[0002059c] 000027ea                  dc.l $000027ea ; no symbol found
[000205a0]                           dc.b $00
[000205a1]                           dc.b $00
[000205a2]                           dc.b $00
[000205a3]                           dc.b $32
[000205a4] 000027b4                  dc.l $000027b4 ; no symbol found
[000205a8]                           dc.b $00
[000205a9]                           dc.b $00
[000205aa]                           dc.b $00
[000205ab]                           dc.b $25
[000205ac] 0000277e                  dc.l $0000277e ; no symbol found
[000205b0]                           dc.b $00
[000205b1]                           dc.b $00
[000205b2]                           dc.b $00
[000205b3]                           dc.b $22
[000205b4] 0000266c                  dc.l $0000266c ; no symbol found
[000205b8]                           dc.b $00
[000205b9]                           dc.b $00
[000205ba]                           dc.b $00
[000205bb]                           dc.b $2c
[000205bc] 000025d8                  dc.l $000025d8 ; no symbol found
[000205c0]                           dc.b $00
[000205c1]                           dc.b $00
[000205c2]                           dc.b $00
[000205c3]                           dc.b $27
[000205c4] 0000256c                  dc.l $0000256c ; no symbol found
[000205c8]                           dc.b $00
[000205c9]                           dc.b $00
[000205ca]                           dc.b $00
[000205cb]                           dc.b $3a
[000205cc] 000024ec                  dc.l $000024ec ; no symbol found
[000205d0]                           dc.b $00
[000205d1]                           dc.b $00
[000205d2]                           dc.b $00
[000205d3]                           dc.b $2e
[000205d4] 000024e6                  dc.l $000024e6 ; no symbol found
[000205d8]                           dc.b $00
[000205d9]                           dc.b $00
[000205da]                           dc.b $00
[000205db]                           dc.b $0b
[000205dc] 000024b8                  dc.l $000024b8 ; no symbol found
[000205e0]                           dc.b $00
[000205e1]                           dc.b $00
[000205e2]                           dc.b $00
[000205e3]                           dc.b $05
[000205e4]                           dc.b $00
[000205e5]                           dc.b $00
[000205e6]                           dc.b $00
[000205e7]                           dc.b $00
[000205e8] 00002a92                  dc.l $00002a92 ; no symbol found
[000205ec]                           dc.b 'illegal statement',0
[000205fe]                           dc.b 'illegal switch expression',0
[00020618]                           dc.b 'missing goto label',0
[0002062b]                           dc.b 'illegal return type',0
[0002063f]                           dc.b 'illegal continue',0
[00020650]                           dc.b 'illegal break',0
[0002065e]                           dc.b 'redefined label',0
[0002066e]                           dc.b 'illegal default',0
[0002067e]                           dc.b 'bad case range',0
[0002068d]                           dc.b 'illegal case',0
[0002069a]                           dc.b 'missing label',0
[000206a8]                           dc.b 'proto and arguments don',$27,'t match',0
[000206c8]                           dc.b 'illegal number of arguments',0
[000206e4]                           dc.b 'illegal argument type',0
[000206fa]                           dc.b 'undeclared argument',0
[0002070e]                           dc.b 'function redefined',0
[00020721]                           dc.b 'bad function argument declaration',0
[00020743]                           dc.b 'redeclared argument',0
[00020757]                           dc.b 'not an argument',0
[00020767]                           dc.b $00
[00020768]                           dc.b 'unused local symbol',0
_noname:
[0002077c]                           dc.b $00
[0002077d]                           dc.b $00
_ntoks:
[0002077e]                           dc.b $00
[0002077f]                           dc.b $00
_tokstk:
[00020780]                           dc.b $00
[00020781]                           dc.b $00
[00020782]                           dc.b $00
[00020783]                           dc.b $00
[00020784]                           dc.b $00
[00020785]                           dc.b $00
[00020786]                           dc.b $00
[00020787]                           dc.b $00
[00020788]                           dc.b $00
[00020789]                           dc.b $00
[0002078a]                           dc.b $00
[0002078b]                           dc.b $00
[0002078c]                           dc.b $00
[0002078d]                           dc.b $00
[0002078e]                           dc.b $00
[0002078f]                           dc.b $00
[00020790]                           dc.b $00
[00020791]                           dc.b $00
_spaces:
[00020792]                           dc.b $00
[00020793]                           dc.b $00
[00020794]                           dc.b $00
[00020795]                           dc.b $00
[00020796]                           dc.b $00
[00020797]                           dc.b $00
[00020798]                           dc.b $00
[00020799]                           dc.b $00
[0002079a]                           dc.b $00
[0002079b]                           dc.b $00
[0002079c]                           dc.b $00
[0002079d]                           dc.b $00
[0002079e]                           dc.b $00
[0002079f]                           dc.b $00
[000207a0]                           dc.b $00
[000207a1]                           dc.b $00
[000207a2]                           dc.b '!TOKEN OVERFLOW',0
[000207b2] 00003324                  dc.l $00003324 ; no symbol found
[000207b6]                           dc.b $00
[000207b7]                           dc.b $00
[000207b8]                           dc.b $00
[000207b9]                           dc.b $66
[000207ba] 00003320                  dc.l $00003320 ; no symbol found
[000207be]                           dc.b $00
[000207bf]                           dc.b $00
[000207c0]                           dc.b $00
[000207c1]                           dc.b $64
[000207c2] 0000331c                  dc.l $0000331c ; no symbol found
[000207c6]                           dc.b $00
[000207c7]                           dc.b $00
[000207c8]                           dc.b $00
[000207c9]                           dc.b $70
[000207ca] 00003300                  dc.l $00003300 ; no symbol found
[000207ce]                           dc.b $00
[000207cf]                           dc.b $00
[000207d0]                           dc.b $00
[000207d1]                           dc.b $73
[000207d2]                           dc.b $00
[000207d3]                           dc.b $00
[000207d4]                           dc.b $00
[000207d5]                           dc.b $00
[000207d6] 00003302                  dc.l $00003302 ; no symbol found
[000207da]                           dc.b $00
[000207db]                           dc.b $00
[000207dc]                           dc.b $00
[000207dd]                           dc.b $00
[000207de]                           dc.b $00
[000207df]                           dc.b $00
[000207e0]                           dc.b $00
[000207e1]                           dc.b $00
[000207e2]                           dc.b $00
[000207e3]                           dc.b $00
[000207e4]                           dc.b $00
[000207e5]                           dc.b $00
[000207e6]                           dc.b $00
[000207e7]                           dc.b $00
[000207e8]                           dc.b $00
[000207e9]                           dc.b $00
[000207ea]                           dc.b $00
[000207eb]                           dc.b $00
[000207ec]                           dc.b $00
[000207ed]                           dc.b $00
[000207ee]                           dc.b $00
[000207ef]                           dc.b $00
[000207f0]                           dc.b $00
[000207f1]                           dc.b $00
[000207f2]                           dc.b $00
[000207f3]                           dc.b $00
[000207f4]                           dc.b $00
[000207f5]                           dc.b $00
[000207f6]                           dc.b $00
[000207f7]                           dc.b $00
[000207f8]                           dc.b $00
[000207f9]                           dc.b $00
[000207fa]                           dc.b $00
[000207fb]                           dc.b $00
[000207fc]                           dc.b $00
[000207fd]                           dc.b $00
[000207fe]                           dc.b $00
[000207ff]                           dc.b $00
[00020800]                           dc.b $00
[00020801]                           dc.b $00
[00020802]                           dc.b $00
[00020803]                           dc.b $00
[00020804]                           dc.b $00
[00020805]                           dc.b $00
[00020806]                           dc.b $00
[00020807]                           dc.b $00
[00020808]                           dc.b $00
[00020809]                           dc.b $00
[0002080a]                           dc.b $00
[0002080b]                           dc.b $00
[0002080c]                           dc.b $00
[0002080d]                           dc.b $00
[0002080e]                           dc.b $00
[0002080f]                           dc.b $00
[00020810]                           dc.b $00
[00020811]                           dc.b $00
[00020812]                           dc.b $00
[00020813]                           dc.b $00
[00020814]                           dc.b $00
[00020815]                           dc.b $00
[00020816]                           dc.b $00
[00020817]                           dc.b $00
[00020818]                           dc.b $00
[00020819]                           dc.b $00
[0002081a]                           dc.b $00
[0002081b]                           dc.b $00
[0002081c]                           dc.b $00
[0002081d]                           dc.b $00
[0002081e]                           dc.b $00
[0002081f]                           dc.b $00
[00020820]                           dc.b $00
[00020821]                           dc.b $00
[00020822]                           dc.b $00
[00020823]                           dc.b $00
[00020824]                           dc.b $00
[00020825]                           dc.b $00
[00020826]                           dc.b $00
[00020827]                           dc.b $00
[00020828]                           dc.b $00
[00020829]                           dc.b $00
[0002082a]                           dc.b $00
[0002082b]                           dc.b $00
[0002082c]                           dc.b $00
[0002082d]                           dc.b $00
[0002082e]                           dc.b $00
[0002082f]                           dc.b $00
[00020830]                           dc.b $00
[00020831]                           dc.b $00
[00020832]                           dc.b $00
[00020833]                           dc.b $00
[00020834]                           dc.b $00
[00020835]                           dc.b $00
[00020836]                           dc.b $00
[00020837]                           dc.b $00
[00020838]                           dc.b $00
[00020839]                           dc.b $00
[0002083a]                           dc.b $00
[0002083b]                           dc.b $00
[0002083c]                           dc.b $00
[0002083d]                           dc.b $00
[0002083e]                           dc.b $00
[0002083f]                           dc.b $00
[00020840]                           dc.b $00
[00020841]                           dc.b $00
[00020842]                           dc.b $00
[00020843]                           dc.b $00
[00020844]                           dc.b $00
[00020845]                           dc.b $00
[00020846]                           dc.b $00
[00020847]                           dc.b $00
[00020848]                           dc.b $00
[00020849]                           dc.b $00
[0002084a]                           dc.b $00
[0002084b]                           dc.b $00
[0002084c]                           dc.b $00
[0002084d]                           dc.b $00
[0002084e]                           dc.b $00
[0002084f]                           dc.b $00
[00020850]                           dc.b $00
[00020851]                           dc.b $00
[00020852]                           dc.b $00
[00020853]                           dc.b $00
[00020854]                           dc.b $00
[00020855]                           dc.b $00
[00020856]                           dc.b $00
[00020857]                           dc.b $00
[00020858]                           dc.b $00
[00020859]                           dc.b $00
[0002085a]                           dc.b $00
[0002085b]                           dc.b $00
[0002085c]                           dc.b $00
[0002085d]                           dc.b $00
[0002085e]                           dc.b $00
[0002085f]                           dc.b $00
[00020860]                           dc.b $00
[00020861]                           dc.b $00
[00020862]                           dc.b $00
[00020863]                           dc.b $00
[00020864]                           dc.b $00
[00020865]                           dc.b $00
[00020866]                           dc.b $00
[00020867]                           dc.b $00
[00020868]                           dc.b $00
[00020869]                           dc.b $00
[0002086a]                           dc.b $00
[0002086b]                           dc.b $00
[0002086c]                           dc.b $00
[0002086d]                           dc.b $00
[0002086e]                           dc.b $00
[0002086f]                           dc.b $00
[00020870]                           dc.b $00
[00020871]                           dc.b $00
[00020872]                           dc.b $00
[00020873]                           dc.b $00
[00020874]                           dc.b $00
[00020875]                           dc.b $00
[00020876]                           dc.b $00
[00020877]                           dc.b $00
[00020878]                           dc.b $00
[00020879]                           dc.b $00
[0002087a]                           dc.b $00
[0002087b]                           dc.b $00
[0002087c]                           dc.b $00
[0002087d]                           dc.b $00
[0002087e]                           dc.b $00
[0002087f]                           dc.b $00
[00020880]                           dc.b $00
[00020881]                           dc.b $00
[00020882]                           dc.b $00
[00020883]                           dc.b $00
[00020884]                           dc.b $00
[00020885]                           dc.b $00
[00020886]                           dc.b $00
[00020887]                           dc.b $00
[00020888]                           dc.b $00
[00020889]                           dc.b $00
[0002088a]                           dc.b $00
[0002088b]                           dc.b $00
[0002088c]                           dc.b $00
[0002088d]                           dc.b $00
[0002088e]                           dc.b $00
[0002088f]                           dc.b $00
[00020890]                           dc.b $00
[00020891]                           dc.b $00
[00020892]                           dc.b $00
[00020893]                           dc.b $00
[00020894]                           dc.b $00
[00020895]                           dc.b $00
[00020896]                           dc.b $00
[00020897]                           dc.b $00
[00020898]                           dc.b $00
[00020899]                           dc.b $00
[0002089a]                           dc.b $00
[0002089b]                           dc.b $00
[0002089c]                           dc.b $00
[0002089d]                           dc.b $00
[0002089e]                           dc.b $00
[0002089f]                           dc.b $00
[000208a0]                           dc.b $00
[000208a1]                           dc.b $00
[000208a2]                           dc.b $00
[000208a3]                           dc.b $00
[000208a4]                           dc.b $00
[000208a5]                           dc.b $00
[000208a6]                           dc.b $00
[000208a7]                           dc.b $00
[000208a8]                           dc.b $00
[000208a9]                           dc.b $00
[000208aa]                           dc.b $00
[000208ab]                           dc.b $00
[000208ac]                           dc.b $00
[000208ad]                           dc.b $00
[000208ae]                           dc.b $00
[000208af]                           dc.b $00
[000208b0]                           dc.b $00
[000208b1]                           dc.b $00
[000208b2]                           dc.b $00
[000208b3]                           dc.b $00
[000208b4]                           dc.b $00
[000208b5]                           dc.b $00
[000208b6]                           dc.b $00
[000208b7]                           dc.b $00
[000208b8]                           dc.b $00
[000208b9]                           dc.b $00
[000208ba]                           dc.b $00
[000208bb]                           dc.b $00
[000208bc]                           dc.b $00
[000208bd]                           dc.b $00
[000208be]                           dc.b $00
[000208bf]                           dc.b $00
[000208c0]                           dc.b $00
[000208c1]                           dc.b $00
[000208c2]                           dc.b $00
[000208c3]                           dc.b $00
[000208c4]                           dc.b $00
[000208c5]                           dc.b $00
[000208c6]                           dc.b $00
[000208c7]                           dc.b $00
[000208c8]                           dc.b $00
[000208c9]                           dc.b $00
[000208ca]                           dc.b $00
[000208cb]                           dc.b $00
[000208cc]                           dc.b $00
[000208cd]                           dc.b $00
[000208ce]                           dc.b $00
[000208cf]                           dc.b $00
[000208d0]                           dc.b $00
[000208d1]                           dc.b $00
[000208d2]                           dc.b $00
[000208d3]                           dc.b $00
[000208d4]                           dc.b $00
[000208d5]                           dc.b $00
[000208d6]                           dc.b $00
[000208d7]                           dc.b $00
[000208d8]                           dc.b $00
[000208d9]                           dc.b $00
[000208da]                           dc.b $00
[000208db]                           dc.b $00
[000208dc]                           dc.b $00
[000208dd]                           dc.b $00
[000208de]                           dc.b $00
[000208df]                           dc.b $00
[000208e0]                           dc.b 'too many spaces',0
[000208f0]                           dc.w $0366
[000208f2]                           dc.w $6172
[000208f4]                           dc.b $00
[000208f5]                           dc.b $00
[000208f6]                           dc.w $2a34
[000208f8]                           dc.w $21e2
[000208fa]                           dc.b $00
[000208fb]                           dc.b 'unknown #pragma',0
[0002090b]                           dc.b 'bad #pragma space',0
[0002091d]                           dc.b $05
[0002091e]                           dc.b 'space',0
[00020924]                           dc.b 'bad #pragma debug',0
[00020936]                           dc.w $026f
[00020938]                           dc.w $6e00
[0002093a]                           dc.w $036f
[0002093c]                           dc.w $6666
[0002093e]                           dc.b $00
[0002093f]                           dc.b $05
[00020940]                           dc.b 'debug',0
[00020946]                           dc.b $00
[00020947]                           dc.b $00
[00020948]                           dc.b $00
[00020949]                           dc.b $00
[0002094a] 00003a70                  dc.l $00003a70 ; no symbol found
[0002094e]                           dc.b $00
[0002094f]                           dc.b $00
[00020950]                           dc.b $00
[00020951]                           dc.b $1d
[00020952] 000039ba                  dc.l $000039ba ; no symbol found
[00020956]                           dc.b $00
[00020957]                           dc.b $00
[00020958]                           dc.b $00
[00020959]                           dc.b $13
[0002095a] 00003968                  dc.l $00003968 ; no symbol found
[0002095e]                           dc.b $00
[0002095f]                           dc.b $00
[00020960]                           dc.b $00
[00020961]                           dc.b $14
[00020962] 000038de                  dc.l $000038de ; no symbol found
[00020966]                           dc.b $00
[00020967]                           dc.b $00
[00020968]                           dc.b $00
[00020969]                           dc.b $fe
[0002096a]                           dc.b $00
[0002096b]                           dc.b $00
[0002096c]                           dc.b $00
[0002096d]                           dc.b $00
[0002096e] 00003a90                  dc.l $00003a90 ; no symbol found
[00020972] 00003b3a                  dc.l $00003b3a ; no symbol found
[00020976]                           dc.b $00
[00020977]                           dc.b $00
[00020978]                           dc.b $00
[00020979]                           dc.b $17
[0002097a] 00003b26                  dc.l $00003b26 ; no symbol found
[0002097e]                           dc.b $00
[0002097f]                           dc.b $00
[00020980]                           dc.b $00
[00020981]                           dc.b $19
[00020982] 00003b26                  dc.l $00003b26 ; no symbol found
[00020986]                           dc.b $00
[00020987]                           dc.b $00
[00020988]                           dc.b $00
[00020989]                           dc.b $15
[0002098a] 00003b26                  dc.l $00003b26 ; no symbol found
[0002098e]                           dc.b $00
[0002098f]                           dc.b $00
[00020990]                           dc.b $00
[00020991]                           dc.b $1a
[00020992] 00003b26                  dc.l $00003b26 ; no symbol found
[00020996]                           dc.b $00
[00020997]                           dc.b $00
[00020998]                           dc.b $00
[00020999]                           dc.b $16
[0002099a] 00003b26                  dc.l $00003b26 ; no symbol found
[0002099e]                           dc.b $00
[0002099f]                           dc.b $00
[000209a0]                           dc.b $00
[000209a1]                           dc.b $1b
[000209a2] 00003b26                  dc.l $00003b26 ; no symbol found
[000209a6]                           dc.b $00
[000209a7]                           dc.b $00
[000209a8]                           dc.b $00
[000209a9]                           dc.b $18
[000209aa] 00003ae4                  dc.l $00003ae4 ; no symbol found
[000209ae]                           dc.b $00
[000209af]                           dc.b $00
[000209b0]                           dc.b $00
[000209b1]                           dc.b $12
[000209b2] 00003ac8                  dc.l $00003ac8 ; no symbol found
[000209b6]                           dc.b $00
[000209b7]                           dc.b $00
[000209b8]                           dc.b $00
[000209b9]                           dc.b $11
[000209ba] 00003ac8                  dc.l $00003ac8 ; no symbol found
[000209be]                           dc.b $00
[000209bf]                           dc.b $00
[000209c0]                           dc.b $00
[000209c1]                           dc.b $10
[000209c2] 00003ac8                  dc.l $00003ac8 ; no symbol found
[000209c6]                           dc.b $00
[000209c7]                           dc.b $00
[000209c8]                           dc.b $00
[000209c9]                           dc.b $1e
[000209ca]                           dc.b $00
[000209cb]                           dc.b $00
[000209cc]                           dc.b $00
[000209cd]                           dc.b $00
[000209ce] 00003b96                  dc.l $00003b96 ; no symbol found
[000209d2]                           dc.b '!BAD CHAR',0
[000209dc]                           dc.w $060a
[000209de]                           dc.w $0b01
[000209e0]                           dc.w $0509
[000209e2]                           dc.w $3a08
[000209e4]                           dc.b $00
[000209e5]                           dc.b $00
[000209e6] 00020a30                  dc.l $00020a30 ; no symbol found
[000209ea] 00020a2c                  dc.l $00020a2c ; no symbol found
[000209ee] 00020a28                  dc.l $00020a28 ; no symbol found
[000209f2] 00020a24                  dc.l $00020a24 ; no symbol found
[000209f6] 00020a20                  dc.l $00020a20 ; no symbol found
[000209fa] 00020a1c                  dc.l $00020a1c ; no symbol found
[000209fe] 00020a14                  dc.l $00020a14 ; no symbol found
[00020a02] 00020a10                  dc.l $00020a10 ; no symbol found
[00020a06] 00020a0a                  dc.l $00020a0a ; no symbol found
[00020a0a]                           dc.w $033f
[00020a0c]                           dc.w $3f3f
[00020a0e]                           dc.b $00
[00020a0f]                           dc.b $00
[00020a10]                           dc.w $015d
[00020a12]                           dc.b $00
[00020a13]                           dc.b $00
[00020a14]                           dc.w $0577
[00020a16]                           dc.b 'hile',0
[00020a1b]                           dc.b $00
[00020a1c]                           dc.w $017d
[00020a1e]                           dc.b $00
[00020a1f]                           dc.b $00
[00020a20]                           dc.w $017d
[00020a22]                           dc.b $00
[00020a23]                           dc.b $00
[00020a24]                           dc.w $013a
[00020a26]                           dc.b $00
[00020a27]                           dc.b $00
[00020a28]                           dc.w $013b
[00020a2a]                           dc.b $00
[00020a2b]                           dc.b $00
[00020a2c]                           dc.w $0129
[00020a2e]                           dc.b $00
[00020a2f]                           dc.b $00
[00020a30]                           dc.w $0128
[00020a32]                           dc.b $00
[00020a33]                           dc.b $00
[00020a34]                           dc.b 'missing',0
[00020a3c]                           dc.b '!EOF',0
[00020a41]                           dc.b $00
[00020a42]                           dc.w $0a00
[00020a44]                           dc.w $2000
[00020a46]                           dc.w $0900
[00020a48]                           dc.w $3a00
[00020a4a]                           dc.w $2000
[00020a4c]                           dc.b '#error ',0
[00020a54]                           dc.b $00
[00020a55]                           dc.b $00
[00020a56]                           dc.b $00
[00020a57]                           dc.b $00
[00020a58]                           dc.b $00
[00020a59]                           dc.b $00
[00020a5a]                           dc.b $00
[00020a5b]                           dc.b $00
[00020a5c]                           dc.b $00
[00020a5d]                           dc.b $00
[00020a5e]                           dc.b $00
[00020a5f]                           dc.b $00
[00020a60]                           dc.b $00
[00020a61]                           dc.b $00
[00020a62]                           dc.b $00
[00020a63]                           dc.b $00
[00020a64]                           dc.b $00
[00020a65]                           dc.b $00
[00020a66]                           dc.b $00
[00020a67]                           dc.b $00
[00020a68]                           dc.b $00
[00020a69]                           dc.b $00
[00020a6a]                           dc.b $00
[00020a6b]                           dc.b $00
[00020a6c]                           dc.b $00
[00020a6d]                           dc.b $00
[00020a6e]                           dc.b $00
[00020a6f]                           dc.b $00
[00020a70]                           dc.b $00
[00020a71]                           dc.b $00
[00020a72]                           dc.b $00
[00020a73]                           dc.b $00
[00020a74]                           dc.b $00
[00020a75]                           dc.b $00
[00020a76]                           dc.b $00
[00020a77]                           dc.b $00
[00020a78]                           dc.b $00
[00020a79]                           dc.b $00
[00020a7a]                           dc.b $00
[00020a7b]                           dc.b $00
[00020a7c]                           dc.b $00
[00020a7d]                           dc.b $00
[00020a7e]                           dc.b $00
[00020a7f]                           dc.b $00
[00020a80]                           dc.b $00
[00020a81]                           dc.b $00
[00020a82]                           dc.b $00
[00020a83]                           dc.b $00
[00020a84]                           dc.b $00
[00020a85]                           dc.b $00
[00020a86]                           dc.b $00
[00020a87]                           dc.b $00
[00020a88]                           dc.b $00
[00020a89]                           dc.b $00
[00020a8a]                           dc.b $00
[00020a8b]                           dc.b $00
[00020a8c]                           dc.b $00
[00020a8d]                           dc.b $00
[00020a8e]                           dc.b $00
[00020a8f]                           dc.b $00
[00020a90]                           dc.b $00
[00020a91]                           dc.b $00
[00020a92]                           dc.b $00
[00020a93]                           dc.b $00
[00020a94]                           dc.b $00
[00020a95]                           dc.b $00
[00020a96]                           dc.b $00
[00020a97]                           dc.b $00
[00020a98]                           dc.b $00
[00020a99]                           dc.b $00
[00020a9a]                           dc.b $00
[00020a9b]                           dc.b $00
[00020a9c]                           dc.b $00
[00020a9d]                           dc.b $00
[00020a9e]                           dc.b $00
[00020a9f]                           dc.b $00
[00020aa0]                           dc.b $00
[00020aa1]                           dc.b $00
[00020aa2]                           dc.b $00
[00020aa3]                           dc.b $00
[00020aa4]                           dc.b $00
[00020aa5]                           dc.b $00
[00020aa6]                           dc.b $00
[00020aa7]                           dc.b $00
[00020aa8]                           dc.b $00
[00020aa9]                           dc.b $00
[00020aaa]                           dc.b $00
[00020aab]                           dc.b $00
[00020aac]                           dc.b $00
[00020aad]                           dc.b $00
[00020aae]                           dc.b $00
[00020aaf]                           dc.b $00
[00020ab0]                           dc.b $00
[00020ab1]                           dc.b $00
[00020ab2]                           dc.b $00
[00020ab3]                           dc.b $00
[00020ab4]                           dc.b $00
[00020ab5]                           dc.b $00
[00020ab6]                           dc.b $00
[00020ab7]                           dc.b $00
[00020ab8]                           dc.b $00
[00020ab9]                           dc.b $00
[00020aba]                           dc.b $00
[00020abb]                           dc.b $00
[00020abc]                           dc.b $00
[00020abd]                           dc.b $00
[00020abe]                           dc.b $00
[00020abf]                           dc.b $00
[00020ac0]                           dc.b $00
[00020ac1]                           dc.b $00
[00020ac2]                           dc.b $00
[00020ac3]                           dc.b $00
[00020ac4]                           dc.b $00
[00020ac5]                           dc.b $00
[00020ac6]                           dc.b $00
[00020ac7]                           dc.b $00
[00020ac8]                           dc.b $00
[00020ac9]                           dc.b $00
[00020aca]                           dc.b $00
[00020acb]                           dc.b $00
[00020acc]                           dc.b $00
[00020acd]                           dc.b $00
[00020ace]                           dc.b $00
[00020acf]                           dc.b $00
[00020ad0]                           dc.b $00
[00020ad1]                           dc.b $00
[00020ad2]                           dc.b $00
[00020ad3]                           dc.b $00
[00020ad4]                           dc.b $00
[00020ad5]                           dc.b $00
[00020ad6]                           dc.b $00
[00020ad7]                           dc.b $00
[00020ad8]                           dc.b $00
[00020ad9]                           dc.b $00
[00020ada]                           dc.b $00
[00020adb]                           dc.b $00
[00020adc]                           dc.b $00
[00020add]                           dc.b $00
[00020ade]                           dc.b $00
[00020adf]                           dc.b $00
[00020ae0]                           dc.b $00
[00020ae1]                           dc.b $00
[00020ae2]                           dc.b $00
[00020ae3]                           dc.b $00
[00020ae4]                           dc.b $00
[00020ae5]                           dc.b $00
[00020ae6]                           dc.b $00
[00020ae7]                           dc.b $00
[00020ae8]                           dc.b $00
[00020ae9]                           dc.b $00
[00020aea]                           dc.b $00
[00020aeb]                           dc.b $00
[00020aec]                           dc.b $00
[00020aed]                           dc.b $00
[00020aee]                           dc.b $00
[00020aef]                           dc.b $00
[00020af0]                           dc.b $00
[00020af1]                           dc.b $00
[00020af2]                           dc.b $00
[00020af3]                           dc.b $00
[00020af4]                           dc.b $00
[00020af5]                           dc.b $00
[00020af6]                           dc.b $00
[00020af7]                           dc.b $00
[00020af8]                           dc.b $00
[00020af9]                           dc.b $00
[00020afa]                           dc.b $00
[00020afb]                           dc.b $00
[00020afc]                           dc.b $00
[00020afd]                           dc.b $00
[00020afe]                           dc.b $00
[00020aff]                           dc.b $00
[00020b00]                           dc.b $00
[00020b01]                           dc.b $00
[00020b02]                           dc.b $00
[00020b03]                           dc.b $00
[00020b04]                           dc.b $00
[00020b05]                           dc.b $00
[00020b06]                           dc.b $00
[00020b07]                           dc.b $00
[00020b08]                           dc.b $00
[00020b09]                           dc.b $00
[00020b0a]                           dc.b $00
[00020b0b]                           dc.b $00
[00020b0c]                           dc.b $00
[00020b0d]                           dc.b $00
[00020b0e]                           dc.b $00
[00020b0f]                           dc.b $00
[00020b10]                           dc.b $00
[00020b11]                           dc.b $00
[00020b12]                           dc.b $00
[00020b13]                           dc.b $00
[00020b14]                           dc.b $00
[00020b15]                           dc.b $00
[00020b16]                           dc.b $00
[00020b17]                           dc.b $00
[00020b18]                           dc.b $00
[00020b19]                           dc.b $00
[00020b1a]                           dc.b $00
[00020b1b]                           dc.b $00
[00020b1c]                           dc.b $00
[00020b1d]                           dc.b $00
[00020b1e]                           dc.b $00
[00020b1f]                           dc.b $00
[00020b20]                           dc.b $00
[00020b21]                           dc.b $00
[00020b22]                           dc.b $00
[00020b23]                           dc.b $00
[00020b24]                           dc.b $00
[00020b25]                           dc.b $00
[00020b26]                           dc.b $00
[00020b27]                           dc.b $00
[00020b28]                           dc.b $00
[00020b29]                           dc.b $00
[00020b2a]                           dc.b $00
[00020b2b]                           dc.b $00
[00020b2c]                           dc.b $00
[00020b2d]                           dc.b $00
[00020b2e]                           dc.b $00
[00020b2f]                           dc.b $00
[00020b30]                           dc.b $00
[00020b31]                           dc.b $00
[00020b32]                           dc.b $00
[00020b33]                           dc.b $00
[00020b34]                           dc.b $00
[00020b35]                           dc.b $00
[00020b36]                           dc.b $00
[00020b37]                           dc.b $00
[00020b38]                           dc.b $00
[00020b39]                           dc.b $00
[00020b3a]                           dc.b $00
[00020b3b]                           dc.b $00
[00020b3c]                           dc.b $00
[00020b3d]                           dc.b $00
[00020b3e]                           dc.b $00
[00020b3f]                           dc.b $00
[00020b40]                           dc.b $00
[00020b41]                           dc.b $00
[00020b42]                           dc.b $00
[00020b43]                           dc.b $00
[00020b44]                           dc.b $00
[00020b45]                           dc.b $00
[00020b46]                           dc.b $00
[00020b47]                           dc.b $00
[00020b48]                           dc.b $00
[00020b49]                           dc.b $00
[00020b4a]                           dc.b $00
[00020b4b]                           dc.b $00
[00020b4c]                           dc.b $00
[00020b4d]                           dc.b $00
[00020b4e]                           dc.b $00
[00020b4f]                           dc.b $00
[00020b50]                           dc.b $00
[00020b51]                           dc.b $00
[00020b52]                           dc.b $00
[00020b53]                           dc.b $00
[00020b54]                           dc.b $00
[00020b55]                           dc.b $00
[00020b56]                           dc.b 'can',$27,'t write!',0
[00020b63]                           dc.b $00
_iregs:
[00020b64]                           dc.w 28
_aflag:
[00020b66]                           dc.l 0
_cflag:
[00020b6a]                           dc.l 0
_dbflag:
[00020b6e]                           dc.l 0
_deadflag:
[00020b72]                           dc.l 0
_errflag:
[00020b76]                           dc.l 0
_laxflag:
[00020b7a]                           dc.l 0
_lflag:
[00020b7e]                           dc.l 0
_lregflag:
[00020b82]                           dc.l 0
_mflag:
[00020b86]                           dc.l 0
_oldflag:
[00020b8a]                           dc.l 0
_stdflag:
[00020b8e]                           dc.l 0
_strictfl:
[00020b92]                           dc.l 0
_romstrin:
[00020b96]                           dc.l 0
_uflag:
[00020b9a]                           dc.l 0
_bndef:
[00020b9e]                           dc.l 1
_model:
[00020ba2]                           dc.l 's'
_nlen:
[00020ba6]                           dc.l 31
_maxint:
[00020baa]                           dc.l 0
_minint:
[00020bae]                           dc.l 0
_dcbyte:
[00020bb2]                           dc.b $00
_regbyte:
[00020bb3]                           dc.b $00
_mainbuff:
[00020bb4]                           ds.b 128
_errbuf:
[00020c34]                           ds.b 128
_p1p2ioct:
[00020cb4]                           dc.l 1
_p1err:
[00020cb8]                           dc.l 0
_pperr:
[00020cbc]                           dc.l 0
__pname:
[00020cc0] 00020cc4                  dc.l $00020cc4 ; no symbol found
[00020cc4]                           dc.w $7031
[00020cc6]                           dc.b $00
[00020cc7]                           dc.b $00
_errfd:
[00020cc8]                           dc.w 2
_ofile:
[00020cca]                           dc.l 0
_nerrors:
[00020cce]                           dc.w 0
_infile:
[00020cd0]                           dc.l 0
_lineno:
[00020cd4]                           dc.w 0
_outfd:
[00020cd6]                           dc.w 1
_dummyatt:
[00020cd8]                           dc.b $00
[00020cd9]                           dc.b $00
[00020cda]                           dc.b $00
[00020cdb]                           dc.b $00
[00020cdc]                           dc.b $00
[00020cdd]                           dc.b $00
[00020cde]                           dc.b $00
[00020cdf]                           dc.b $00
[00020ce0]                           dc.w $ff00
[00020ce2]                           dc.b $00
[00020ce3]                           dc.b $00
[00020ce4]                           dc.b $00
[00020ce5]                           dc.b $00
[00020ce6]                           dc.b $00
[00020ce7]                           dc.b $00
[00020ce8]                           dc.b $00
[00020ce9]                           dc.b $00
_attlist:
[00020cea] 00020cd8                  dc.l _dummyatt
_gblat:
[00020cee] 00020cd8                  dc.l _dummyatt
_badsym:
[00020cf2]                           dc.b $00
[00020cf3]                           dc.b $00
[00020cf4]                           dc.b $00
[00020cf5]                           dc.b $00
[00020cf6]                           dc.b $00
[00020cf7]                           dc.b $00
[00020cf8]                           dc.b $00
[00020cf9]                           dc.b $00
[00020cfa]                           dc.b $00
[00020cfb]                           dc.b $00
[00020cfc]                           dc.b $00
[00020cfd]                           dc.b $00
[00020cfe]                           dc.b $00
[00020cff]                           dc.b $00
[00020d00]                           dc.b $00
[00020d01]                           dc.b $00
[00020d02]                           dc.b $00
[00020d03]                           dc.b $00
_tentsym:
[00020d04]                           dc.b $00
[00020d05]                           dc.b $00
[00020d06]                           dc.b $00
[00020d07]                           dc.b $00
[00020d08]                           dc.b $00
[00020d09]                           dc.b $00
[00020d0a]                           dc.b $00
[00020d0b]                           dc.b $00
[00020d0c]                           dc.b $00
[00020d0d]                           dc.b $00
[00020d0e]                           dc.b $00
[00020d0f]                           dc.b $00
[00020d10]                           dc.b $00
[00020d11]                           dc.b $00
[00020d12]                           dc.b $00
[00020d13]                           dc.b $00
[00020d14]                           dc.b $00
[00020d15]                           dc.b $00
_gblsym:
[00020d16]                           dc.b $00
[00020d17]                           dc.b $00
[00020d18]                           dc.b $00
[00020d19]                           dc.b $00
_lbltab:
[00020d1a]                           dc.b $00
[00020d1b]                           dc.b $00
[00020d1c]                           dc.b $00
[00020d1d]                           dc.b $00
_littab:
[00020d1e]                           dc.b $00
[00020d1f]                           dc.b $00
[00020d20]                           dc.b $00
[00020d21]                           dc.b $00
_mostab:
[00020d22]                           dc.b $00
[00020d23]                           dc.b $00
[00020d24]                           dc.b $00
[00020d25]                           dc.b $00
_spacetab:
[00020d26]                           dc.b $00
[00020d27]                           dc.b $00
[00020d28]                           dc.b $00
[00020d29]                           dc.b $00
_symend:
[00020d2a]                           dc.b $00
[00020d2b]                           dc.b $00
[00020d2c]                           dc.b $00
[00020d2d]                           dc.b $00
_symtab:
[00020d2e]                           dc.b $00
[00020d2f]                           dc.b $00
[00020d30]                           dc.b $00
[00020d31]                           dc.b $00
_exlist:
[00020d32]                           dc.b $00
[00020d33]                           dc.b $00
[00020d34]                           dc.b $00
[00020d35]                           dc.b $00
[00020d36]                           dc.b '$3/0=9+(>758<'
[00020d43]                           dc.b $0c
[00020d44]                           dc.w $3b3f
[00020d46]                           dc.b $00
[00020d47]                           dc.b $00
[00020d48]                           dc.b $00
[00020d49]                           dc.b $01
[00020d4a]                           dc.b $00
[00020d4b]                           dc.b $08
[00020d4c]                           dc.b $00
[00020d4d]                           dc.b $10
[00020d4e]                           dc.b $00
[00020d4f]                           dc.b $20
[00020d50]                           dc.b $00
[00020d51]                           dc.b $02
[00020d52]                           dc.b $00
[00020d53]                           dc.b $04
[00020d54]                           dc.b $00
[00020d55]                           dc.b $40
[00020d56]                           dc.b $00
[00020d57]                           dc.b $80
[00020d58]                           dc.w $0100
[00020d5a]                           dc.w $0200
[00020d5c]                           dc.w $0200
[00020d5e]                           dc.w $0200
[00020d60]                           dc.w $0200
[00020d62]                           dc.b $00
[00020d63]                           dc.b $00
[00020d64]                           dc.w $0400
[00020d66]                           dc.w $0800
_atchar:
[00020d68]                           dc.b $00
[00020d69]                           dc.b $00
[00020d6a]                           dc.b $00
[00020d6b]                           dc.b $00
[00020d6c]                           dc.b $00
[00020d6d]                           dc.b $00
[00020d6e]                           dc.b $00
[00020d6f]                           dc.b $00
[00020d70]                           dc.w $0800
[00020d72]                           dc.b $00
[00020d73]                           dc.b $00
[00020d74]                           dc.b $00
[00020d75]                           dc.b $00
[00020d76]                           dc.b $00
[00020d77]                           dc.b $00
[00020d78]                           dc.b $00
[00020d79]                           dc.b $00
_atichar:
[00020d7a]                           dc.b $00
[00020d7b]                           dc.b $00
[00020d7c]                           dc.b $00
[00020d7d]                           dc.b $00
[00020d7e]                           dc.b $00
[00020d7f]                           dc.b $00
[00020d80]                           dc.b $00
[00020d81]                           dc.b $00
[00020d82]                           dc.w $0900
[00020d84]                           dc.b $00
[00020d85]                           dc.b $00
[00020d86]                           dc.b $00
[00020d87]                           dc.b $00
[00020d88]                           dc.b $00
[00020d89]                           dc.b $00
[00020d8a]                           dc.b $00
[00020d8b]                           dc.b $00
_atuchar:
[00020d8c]                           dc.b $00
[00020d8d]                           dc.b $00
[00020d8e]                           dc.b $00
[00020d8f]                           dc.b $00
[00020d90]                           dc.b $00
[00020d91]                           dc.b $00
[00020d92]                           dc.b $00
[00020d93]                           dc.b $00
[00020d94]                           dc.w $0a00
[00020d96]                           dc.b $00
[00020d97]                           dc.b $00
[00020d98]                           dc.b $00
[00020d99]                           dc.b $00
[00020d9a]                           dc.b $00
[00020d9b]                           dc.b $00
[00020d9c]                           dc.b $00
[00020d9d]                           dc.b $00
_atshort:
[00020d9e]                           dc.b $00
[00020d9f]                           dc.b $00
[00020da0]                           dc.b $00
[00020da1]                           dc.b $00
[00020da2]                           dc.b $00
[00020da3]                           dc.b $00
[00020da4]                           dc.b $00
[00020da5]                           dc.b $00
[00020da6]                           dc.w $1000
[00020da8]                           dc.b $00
[00020da9]                           dc.b $00
[00020daa]                           dc.b $00
[00020dab]                           dc.b $00
[00020dac]                           dc.b $00
[00020dad]                           dc.b $00
[00020dae]                           dc.b $00
[00020daf]                           dc.b $00
_atushort:
[00020db0]                           dc.b $00
[00020db1]                           dc.b $00
[00020db2]                           dc.b $00
[00020db3]                           dc.b $00
[00020db4]                           dc.b $00
[00020db5]                           dc.b $00
[00020db6]                           dc.b $00
[00020db7]                           dc.b $00
[00020db8]                           dc.w $1100
[00020dba]                           dc.b $00
[00020dbb]                           dc.b $00
[00020dbc]                           dc.b $00
[00020dbd]                           dc.b $00
[00020dbe]                           dc.b $00
[00020dbf]                           dc.b $00
[00020dc0]                           dc.b $00
[00020dc1]                           dc.b $00
_atint:
[00020dc2]                           dc.b $00
[00020dc3]                           dc.b $00
[00020dc4]                           dc.b $00
[00020dc5]                           dc.b $00
[00020dc6]                           dc.b $00
[00020dc7]                           dc.b $00
[00020dc8]                           dc.b $00
[00020dc9]                           dc.b $00
[00020dca]                           dc.w $1800
[00020dcc]                           dc.b $00
[00020dcd]                           dc.b $00
[00020dce]                           dc.b $00
[00020dcf]                           dc.b $00
[00020dd0]                           dc.b $00
[00020dd1]                           dc.b $00
[00020dd2]                           dc.b $00
[00020dd3]                           dc.b $00
_atunsign:
[00020dd4]                           dc.b $00
[00020dd5]                           dc.b $00
[00020dd6]                           dc.b $00
[00020dd7]                           dc.b $00
[00020dd8]                           dc.b $00
[00020dd9]                           dc.b $00
[00020dda]                           dc.b $00
[00020ddb]                           dc.b $00
[00020ddc]                           dc.w $1a00
[00020dde]                           dc.b $00
[00020ddf]                           dc.b $00
[00020de0]                           dc.b $00
[00020de1]                           dc.b $00
[00020de2]                           dc.b $00
[00020de3]                           dc.b $00
[00020de4]                           dc.b $00
[00020de5]                           dc.b $00
_atlong:
[00020de6]                           dc.b $00
[00020de7]                           dc.b $00
[00020de8]                           dc.b $00
[00020de9]                           dc.b $00
[00020dea]                           dc.b $00
[00020deb]                           dc.b $00
[00020dec]                           dc.b $00
[00020ded]                           dc.b $00
[00020dee]                           dc.w $2000
[00020df0]                           dc.b $00
[00020df1]                           dc.b $00
[00020df2]                           dc.b $00
[00020df3]                           dc.b $00
[00020df4]                           dc.b $00
[00020df5]                           dc.b $00
[00020df6]                           dc.b $00
[00020df7]                           dc.b $00
_atulong:
[00020df8]                           dc.b $00
[00020df9]                           dc.b $00
[00020dfa]                           dc.b $00
[00020dfb]                           dc.b $00
[00020dfc]                           dc.b $00
[00020dfd]                           dc.b $00
[00020dfe]                           dc.b $00
[00020dff]                           dc.b $00
[00020e00]                           dc.w $2100
[00020e02]                           dc.b $00
[00020e03]                           dc.b $00
[00020e04]                           dc.b $00
[00020e05]                           dc.b $00
[00020e06]                           dc.b $00
[00020e07]                           dc.b $00
[00020e08]                           dc.b $00
[00020e09]                           dc.b $00
_atfloat:
[00020e0a]                           dc.b $00
[00020e0b]                           dc.b $00
[00020e0c]                           dc.b $00
[00020e0d]                           dc.b $00
[00020e0e]                           dc.b $00
[00020e0f]                           dc.b $00
[00020e10]                           dc.b $00
[00020e11]                           dc.b $00
[00020e12]                           dc.w $2800
[00020e14]                           dc.b $00
[00020e15]                           dc.b $00
[00020e16]                           dc.b $00
[00020e17]                           dc.b $00
[00020e18]                           dc.b $00
[00020e19]                           dc.b $00
[00020e1a]                           dc.b $00
[00020e1b]                           dc.b $00
_atdouble:
[00020e1c]                           dc.b $00
[00020e1d]                           dc.b $00
[00020e1e]                           dc.b $00
[00020e1f]                           dc.b $00
[00020e20]                           dc.b $00
[00020e21]                           dc.b $00
[00020e22]                           dc.b $00
[00020e23]                           dc.b $00
[00020e24]                           dc.w $2900
[00020e26]                           dc.b $00
[00020e27]                           dc.b $00
[00020e28]                           dc.b $00
[00020e29]                           dc.b $00
[00020e2a]                           dc.b $00
[00020e2b]                           dc.b $00
[00020e2c]                           dc.b $00
[00020e2d]                           dc.b $00
_atldoubl:
[00020e2e]                           dc.b $00
[00020e2f]                           dc.b $00
[00020e30]                           dc.b $00
[00020e31]                           dc.b $00
[00020e32]                           dc.b $00
[00020e33]                           dc.b $00
[00020e34]                           dc.b $00
[00020e35]                           dc.b $00
[00020e36]                           dc.w $2a00
[00020e38]                           dc.b $00
[00020e39]                           dc.b $00
[00020e3a]                           dc.b $00
[00020e3b]                           dc.b $00
[00020e3c]                           dc.b $00
[00020e3d]                           dc.b $00
[00020e3e]                           dc.b $00
[00020e3f]                           dc.b $00
_atvoid:
[00020e40]                           dc.b $00
[00020e41]                           dc.b $00
[00020e42]                           dc.b $00
[00020e43]                           dc.b $00
[00020e44]                           dc.b $00
[00020e45]                           dc.b $00
[00020e46]                           dc.b $00
[00020e47]                           dc.b $00
[00020e48]                           dc.w $5000
[00020e4a]                           dc.b $00
[00020e4b]                           dc.b $00
[00020e4c]                           dc.b $00
[00020e4d]                           dc.b $00
[00020e4e]                           dc.b $00
[00020e4f]                           dc.b $00
[00020e50]                           dc.b $00
[00020e51]                           dc.b $00
_byulong:
[00020e52]                           dc.b $00
[00020e53]                           dc.b $00
[00020e54]                           dc.b $00
[00020e55]                           dc.b $00
_byunsign:
[00020e56]                           dc.b $00
[00020e57]                           dc.b $00
[00020e58]                           dc.b $00
[00020e59]                           dc.b $00
_legals:
[00020e5a]                           dc.b $00
[00020e5b]                           dc.b $01
[00020e5c]                           dc.b $00
[00020e5d]                           dc.b $03
[00020e5e]                           dc.b $00
[00020e5f]                           dc.b $05
[00020e60]                           dc.b $00
[00020e61]                           dc.b $08
[00020e62]                           dc.b $00
[00020e63]                           dc.b $1a
[00020e64]                           dc.b $00
[00020e65]                           dc.b $1c
[00020e66]                           dc.b $00
[00020e67]                           dc.b $18
[00020e68]                           dc.b $00
[00020e69]                           dc.b $0a
[00020e6a]                           dc.b $00
[00020e6b]                           dc.b $0c
[00020e6c]                           dc.b $00
[00020e6d]                           dc.b $00
[00020e6e]                           dc.b $00
[00020e6f]                           dc.b $10
[00020e70]                           dc.b $00
[00020e71]                           dc.b $02
[00020e72]                           dc.b $00
[00020e73]                           dc.b $12
[00020e74]                           dc.b $00
[00020e75]                           dc.b $04
[00020e76]                           dc.b $00
[00020e77]                           dc.b $14
[00020e78]                           dc.b $00
[00020e79]                           dc.b $20
[00020e7a]                           dc.b $00
[00020e7b]                           dc.b $22
[00020e7c]                           dc.b $00
[00020e7d]                           dc.b $24
[00020e7e]                           dc.b $00
[00020e7f]                           dc.b $32
[00020e80]                           dc.b $00
[00020e81]                           dc.b $34
[00020e82]                           dc.b $00
[00020e83]                           dc.b $30
[00020e84]                           dc.b $00
[00020e85]                           dc.b $40
[00020e86]                           dc.b $00
[00020e87]                           dc.b $80
[00020e88]                           dc.b $00
[00020e89]                           dc.b $a0
[00020e8a]                           dc.w $0100
[00020e8c]                           dc.w $0200
[00020e8e]                           dc.w $8000
_legalatt:
[00020e90] 00020d7a                  dc.l _atichar
[00020e94] 00020d68                  dc.l _atchar
[00020e98] 00020d8c                  dc.l _atuchar
[00020e9c] 00020d9e                  dc.l _atshort
[00020ea0] 00020d9e                  dc.l _atshort
[00020ea4] 00020db0                  dc.l _atushort
[00020ea8] 00020d9e                  dc.l _atshort
[00020eac] 00020d9e                  dc.l _atshort
[00020eb0] 00020db0                  dc.l _atushort
[00020eb4] 00020dc2                  dc.l _atint
[00020eb8] 00020dc2                  dc.l _atint
[00020ebc] 00020dc2                  dc.l _atint
[00020ec0] 00020dc2                  dc.l _atint
[00020ec4] 00020dd4                  dc.l _atunsign
[00020ec8] 00020dd4                  dc.l _atunsign
[00020ecc] 00020de6                  dc.l _atlong
[00020ed0] 00020de6                  dc.l _atlong
[00020ed4] 00020df8                  dc.l _atulong
[00020ed8] 00020de6                  dc.l _atlong
[00020edc] 00020df8                  dc.l _atulong
[00020ee0] 00020de6                  dc.l _atlong
[00020ee4] 00020e0a                  dc.l _atfloat
[00020ee8] 00020e1c                  dc.l _atdouble
[00020eec] 00020e2e                  dc.l _atldoubl
[00020ef0] 00020e40                  dc.l _atvoid
[00020ef4]                           dc.b $00
[00020ef5]                           dc.b $00
[00020ef6]                           dc.b $00
[00020ef7]                           dc.b $00
[00020ef8]                           dc.b 'illegal type specification',0
[00020f13]                           dc.b $00
[00020f14]                           dc.b 'member conflict',0
[00020f24]                           dc.b 'bad field width',0
[00020f34]                           dc.b 'illegal bitfield',0
[00020f45]                           dc.b 'illegal field',0
[00020f53]                           dc.b 'member redefined',0
[00020f64]                           dc.b 'enumeration constant larger than int',0
[00020f89]                           dc.b 'redeclared enum element',0
[00020fa1]                           dc.b 'redefined tag',0
[00020faf]                           dc.b 'incomplete type',0
[00020fbf]                           dc.b $00
[00020fc0]                           dc.w $0604
[00020fc2]                           dc.b $00
[00020fc3]                           dc.b $3b
[00020fc4]                           dc.w $3f0c
[00020fc6]                           dc.b $00
[00020fc7]                           dc.b 'redeclared proto argument',0
[00020fe1]                           dc.b 'bad proto argument type',0
[00020ff9]                           dc.b 'bad function argument declaration',0
[0002101b]                           dc.b 'bad (declaration)',0
[0002102d]                           dc.b 'bad *declaration',0
[0002103e] 00004b9a                  dc.l $00004b9a ; no symbol found
[00021042]                           dc.b $00
[00021043]                           dc.b $00
[00021044]                           dc.b $00
[00021045]                           dc.b $41
[00021046] 00004b8e                  dc.l $00004b8e ; no symbol found
[0002104a]                           dc.b $00
[0002104b]                           dc.b $00
[0002104c]                           dc.b $00
[0002104d]                           dc.b $42
[0002104e] 00004b82                  dc.l $00004b82 ; no symbol found
[00021052]                           dc.b $00
[00021053]                           dc.b $00
[00021054]                           dc.b $00
[00021055]                           dc.b $40
[00021056]                           dc.b $00
[00021057]                           dc.b $00
[00021058]                           dc.b $00
[00021059]                           dc.b $00
[0002105a] 00004b8c                  dc.l $00004b8c ; no symbol found
[0002105e]                           dc.b '*4!17',0
[00021064]                           dc.b 'illegal storage class',0
[0002107a]                           dc.b 'repeated type specification',0
[00021096]                           dc.w 0
[00021098]                           dc.w 4
[0002109a]                           dc.w 12
[0002109c]                           dc.w 28
[0002109e]                           dc.w $081c
[000210a0]                           dc.w $181c
[000210a2]                           dc.w $381c
[000210a4]                           dc.w $389c
_rbytes:
[000210a6]                           dc.l 3
[000210aa] 0000568c                  dc.l $0000568c ; no symbol found
[000210ae]                           dc.b $00
[000210af]                           dc.b $00
[000210b0]                           dc.b $00
[000210b1]                           dc.b $3d
[000210b2] 00005654                  dc.l $00005654 ; no symbol found
[000210b6]                           dc.b $00
[000210b7]                           dc.b $00
[000210b8]                           dc.b $00
[000210b9]                           dc.b $34
[000210ba] 0000563a                  dc.l $0000563a ; no symbol found
[000210be]                           dc.b $00
[000210bf]                           dc.b $00
[000210c0]                           dc.b $00
[000210c1]                           dc.b $3c
[000210c2] 0000562c                  dc.l $0000562c ; no symbol found
[000210c6]                           dc.b $00
[000210c7]                           dc.b $00
[000210c8]                           dc.b $00
[000210c9]                           dc.b $3e
[000210ca] 00005606                  dc.l $00005606 ; no symbol found
[000210ce]                           dc.b $00
[000210cf]                           dc.b $00
[000210d0]                           dc.b $00
[000210d1]                           dc.b $2a
[000210d2]                           dc.b $00
[000210d3]                           dc.b $00
[000210d4]                           dc.b $00
[000210d5]                           dc.b $00
[000210d6] 0000562a                  dc.l $0000562a ; no symbol found
[000210da]                           dc.b 'unused static',0
[000210e8]                           dc.b 'undefined local function',0
[00021101]                           dc.b 'bad external syntax',0
[00021115]                           dc.b 'redeclared external',0
[00021129]                           dc.b 'redeclared typedef',0
[0002113c]                           dc.b 'spdf',0
[00021141]                           dc.b 'unknown model',0
[0002114f]                           dc.b 'spdf',0
[00021154]                           dc.b 'bad input file',0
[00021163]                           dc.b 'bad output file',0
[00021173]                           dc.b 'a,b#,c,+dead,+debug,err,lreg,l,model?,m,n#,+old,o*,r#,+std,+strict,sr,strict,u:F <file>',0
[000211cb]                           dc.b $00
_zeterm:
[000211cc]                           dc.b $00
[000211cd]                           dc.b $00
[000211ce]                           dc.b $00
[000211cf]                           dc.b $00
[000211d0]                           dc.b $00
[000211d1]                           dc.b $00
[000211d2]                           dc.b $00
[000211d3]                           dc.b $00
[000211d4]                           dc.b $00
[000211d5]                           dc.b $00
[000211d6]                           dc.b $00
[000211d7]                           dc.b $00
[000211d8]                           dc.b $00
[000211d9]                           dc.b $00
[000211da]                           dc.b $00
[000211db]                           dc.b $00
[000211dc]                           dc.b $00
[000211dd]                           dc.b $00
[000211de]                           dc.b $00
[000211df]                           dc.b $00
[000211e0]                           dc.b $00
[000211e1]                           dc.b $00
[000211e2]                           dc.b $00
[000211e3]                           dc.b $00
[000211e4]                           dc.w $949b
[000211e6]                           dc.w $9596
[000211e8]                           dc.w $8f90
[000211ea]                           dc.b $00
[000211eb]                           dc.b $9b
[000211ec]                           dc.w $9490
[000211ee]                           dc.w $8f96
[000211f0]                           dc.w $9500
[000211f2]                           dc.w $8a8f
[000211f4]                           dc.w $8d8e
[000211f6]                           dc.w $8887
[000211f8]                           dc.b $00
[000211f9]                           dc.b $00
[000211fa]                           dc.w $fff9
[000211fc]                           dc.w $fff8
[000211fe]                           dc.b $00
[000211ff]                           dc.b $00
[00021200]                           dc.b $00
[00021201]                           dc.b $00
[00021202]                           dc.b $00
[00021203]                           dc.b $00
[00021204]                           dc.b $00
[00021205]                           dc.b $00
[00021206]                           dc.b $00
[00021207]                           dc.b $00
[00021208]                           dc.b $00
[00021209]                           dc.b $00
[0002120a]                           dc.b $00
[0002120b]                           dc.b $00
[0002120c]                           dc.b $00
[0002120d]                           dc.b $00
[0002120e]                           dc.b $00
[0002120f]                           dc.b $00
[00021210]                           dc.b $00
[00021211]                           dc.b $00
[00021212]                           dc.b $00
[00021213]                           dc.b $00
[00021214]                           dc.b $00
[00021215]                           dc.b $00
[00021216]                           dc.b $00
[00021217]                           dc.b $00
[00021218]                           dc.b $00
[00021219]                           dc.b $00
[0002121a]                           dc.b $00
[0002121b]                           dc.b $00
[0002121c]                           dc.b $00
[0002121d]                           dc.b $00
[0002121e]                           dc.b $00
[0002121f]                           dc.b $00
[00021220]                           dc.b $00
[00021221]                           dc.b $00
[00021222]                           dc.b $00
[00021223]                           dc.b $00
[00021224]                           dc.b $00
[00021225]                           dc.b $00
[00021226]                           dc.b $00
[00021227]                           dc.b $00
[00021228] 000068aa                  dc.l $000068aa ; no symbol found
[0002122c]                           dc.b $00
[0002122d]                           dc.b $00
[0002122e]                           dc.b $00
[0002122f]                           dc.b $50
[00021230] 0000686a                  dc.l $0000686a ; no symbol found
[00021234]                           dc.b $00
[00021235]                           dc.b $00
[00021236]                           dc.b $00
[00021237]                           dc.b $42
[00021238] 0000681a                  dc.l $0000681a ; no symbol found
[0002123c]                           dc.b $00
[0002123d]                           dc.b $00
[0002123e]                           dc.b $00
[0002123f]                           dc.b $40
[00021240] 00006806                  dc.l $00006806 ; no symbol found
[00021244]                           dc.b $00
[00021245]                           dc.b $00
[00021246]                           dc.b $00
[00021247]                           dc.b $1a
[00021248] 000067f4                  dc.l $000067f4 ; no symbol found
[0002124c]                           dc.b $00
[0002124d]                           dc.b $00
[0002124e]                           dc.b $00
[0002124f]                           dc.b $19
[00021250] 000067e2                  dc.l $000067e2 ; no symbol found
[00021254]                           dc.b $00
[00021255]                           dc.b $00
[00021256]                           dc.b $00
[00021257]                           dc.b $18
[00021258] 000067ce                  dc.l $000067ce ; no symbol found
[0002125c]                           dc.b $00
[0002125d]                           dc.b $00
[0002125e]                           dc.b $00
[0002125f]                           dc.b $09
[00021260]                           dc.b $00
[00021261]                           dc.b $00
[00021262]                           dc.b $00
[00021263]                           dc.b $00
[00021264] 000068b0                  dc.l $000068b0 ; no symbol found
[00021268] 00006a6a                  dc.l $00006a6a ; no symbol found
[0002126c]                           dc.b $00
[0002126d]                           dc.b $00
[0002126e]                           dc.b $00
[0002126f]                           dc.b $21
[00021270] 00006a6a                  dc.l $00006a6a ; no symbol found
[00021274]                           dc.b $00
[00021275]                           dc.b $00
[00021276]                           dc.b $00
[00021277]                           dc.b $20
[00021278] 00006a3e                  dc.l $00006a3e ; no symbol found
[0002127c]                           dc.b $00
[0002127d]                           dc.b $00
[0002127e]                           dc.b $00
[0002127f]                           dc.b $40
[00021280] 000069e0                  dc.l $000069e0 ; no symbol found
[00021284]                           dc.b $00
[00021285]                           dc.b $00
[00021286]                           dc.b $00
[00021287]                           dc.b $1a
[00021288] 000069e0                  dc.l $000069e0 ; no symbol found
[0002128c]                           dc.b $00
[0002128d]                           dc.b $00
[0002128e]                           dc.b $00
[0002128f]                           dc.b $18
[00021290] 000069e0                  dc.l $000069e0 ; no symbol found
[00021294]                           dc.b $00
[00021295]                           dc.b $00
[00021296]                           dc.b $00
[00021297]                           dc.b $11
[00021298] 000069e0                  dc.l $000069e0 ; no symbol found
[0002129c]                           dc.b $00
[0002129d]                           dc.b $00
[0002129e]                           dc.b $00
[0002129f]                           dc.b $10
[000212a0] 000069e0                  dc.l $000069e0 ; no symbol found
[000212a4]                           dc.b $00
[000212a5]                           dc.b $00
[000212a6]                           dc.b $00
[000212a7]                           dc.b $0a
[000212a8] 000069e0                  dc.l $000069e0 ; no symbol found
[000212ac]                           dc.b $00
[000212ad]                           dc.b $00
[000212ae]                           dc.b $00
[000212af]                           dc.b $09
[000212b0] 000069e0                  dc.l $000069e0 ; no symbol found
[000212b4]                           dc.b $00
[000212b5]                           dc.b $00
[000212b6]                           dc.b $00
[000212b7]                           dc.b $08
[000212b8]                           dc.b $00
[000212b9]                           dc.b $00
[000212ba]                           dc.b $00
[000212bb]                           dc.b $00
[000212bc] 00006a8c                  dc.l $00006a8c ; no symbol found
[000212c0]                           dc.b $00
[000212c1]                           dc.b $00
[000212c2]                           dc.b $00
[000212c3]                           dc.b $40
[000212c4]                           dc.b $00
[000212c5]                           dc.b $40
[000212c6]                           dc.b $00
[000212c7]                           dc.b $00
[000212c8]                           dc.b $00
[000212c9]                           dc.b $40
[000212ca]                           dc.b $00
[000212cb]                           dc.b $40
[000212cc]                           dc.b $00
[000212cd]                           dc.b $41
[000212ce]                           dc.b $00
[000212cf]                           dc.b $41
[000212d0]                           dc.b $00
[000212d1]                           dc.b $40
[000212d2]                           dc.b $00
[000212d3]                           dc.b $40
[000212d4]                           dc.b $00
[000212d5]                           dc.b $c0
[000212d6]                           dc.b $00
[000212d7]                           dc.b $c0
[000212d8]                           dc.b $00
[000212d9]                           dc.b $40
[000212da]                           dc.b $00
[000212db]                           dc.b $c0
[000212dc]                           dc.b $00
[000212dd]                           dc.b $c0
[000212de]                           dc.b $00
[000212df]                           dc.b $c0
[000212e0]                           dc.b $00
[000212e1]                           dc.b $c0
[000212e2]                           dc.b $00
[000212e3]                           dc.b $c2
[000212e4]                           dc.b $00
[000212e5]                           dc.b $c0
[000212e6]                           dc.b $00
[000212e7]                           dc.b $c0
[000212e8]                           dc.b $00
[000212e9]                           dc.b $c0
[000212ea]                           dc.b $00
[000212eb]                           dc.b $c0
[000212ec]                           dc.b $00
[000212ed]                           dc.b $c0
[000212ee]                           dc.b $00
[000212ef]                           dc.b $c0
[000212f0]                           dc.b $00
[000212f1]                           dc.b $c0
[000212f2]                           dc.b $00
[000212f3]                           dc.b $c0
[000212f4]                           dc.b $00
[000212f5]                           dc.b $f0
[000212f6]                           dc.b $00
[000212f7]                           dc.b $d0
[000212f8]                           dc.b $00
[000212f9]                           dc.b $ec
[000212fa]                           dc.b $00
[000212fb]                           dc.b $c7
[000212fc]                           dc.b $00
[000212fd]                           dc.b $c3
[000212fe]                           dc.b $00
[000212ff]                           dc.b $eb
[00021300]                           dc.b $00
[00021301]                           dc.b $f3
[00021302]                           dc.b $00
[00021303]                           dc.b $f3
[00021304]                           dc.b $00
[00021305]                           dc.b $d3
[00021306]                           dc.b $00
[00021307]                           dc.b $d3
[00021308]                           dc.b $00
[00021309]                           dc.b $c3
[0002130a]                           dc.b $00
[0002130b]                           dc.b $c3
[0002130c]                           dc.b $00
[0002130d]                           dc.b $c3
[0002130e]                           dc.b $00
[0002130f]                           dc.b $c3
[00021310]                           dc.b $00
[00021311]                           dc.b $e3
[00021312]                           dc.b $00
[00021313]                           dc.b $e3
[00021314]                           dc.b $00
[00021315]                           dc.b $c0
[00021316]                           dc.b $00
[00021317]                           dc.b $c0
[00021318]                           dc.b $00
[00021319]                           dc.b $00
[0002131a]                           dc.b $00
[0002131b]                           dc.b $40
[0002131c]                           dc.b $00
[0002131d]                           dc.b $00
[0002131e] 00006e74                  dc.l $00006e74 ; no symbol found
[00021322]                           dc.b $00
[00021323]                           dc.b $00
[00021324]                           dc.b $00
[00021325]                           dc.b $21
[00021326] 00006e72                  dc.l $00006e72 ; no symbol found
[0002132a]                           dc.b $00
[0002132b]                           dc.b $00
[0002132c]                           dc.b $00
[0002132d]                           dc.b $20
[0002132e] 00006e62                  dc.l $00006e62 ; no symbol found
[00021332]                           dc.b $00
[00021333]                           dc.b $00
[00021334]                           dc.b $00
[00021335]                           dc.b $11
[00021336] 00006e5a                  dc.l $00006e5a ; no symbol found
[0002133a]                           dc.b $00
[0002133b]                           dc.b $00
[0002133c]                           dc.b $00
[0002133d]                           dc.b $1a
[0002133e] 00006e4a                  dc.l $00006e4a ; no symbol found
[00021342]                           dc.b $00
[00021343]                           dc.b $00
[00021344]                           dc.b $00
[00021345]                           dc.b $10
[00021346] 00006e42                  dc.l $00006e42 ; no symbol found
[0002134a]                           dc.b $00
[0002134b]                           dc.b $00
[0002134c]                           dc.b $00
[0002134d]                           dc.b $18
[0002134e] 00006e32                  dc.l $00006e32 ; no symbol found
[00021352]                           dc.b $00
[00021353]                           dc.b $00
[00021354]                           dc.b $00
[00021355]                           dc.b $0a
[00021356] 00006e18                  dc.l $00006e18 ; no symbol found
[0002135a]                           dc.b $00
[0002135b]                           dc.b $00
[0002135c]                           dc.b $00
[0002135d]                           dc.b $08
[0002135e]                           dc.b $00
[0002135f]                           dc.b $00
[00021360]                           dc.b $00
[00021361]                           dc.b $00
[00021362] 00006e76                  dc.l $00006e76 ; no symbol found
[00021366] 00006f40                  dc.l $00006f40 ; no symbol found
[0002136a]                           dc.b $00
[0002136b]                           dc.b $00
[0002136c]                           dc.b $00
[0002136d]                           dc.b $9f
[0002136e] 00006f3c                  dc.l $00006f3c ; no symbol found
[00021372]                           dc.b $00
[00021373]                           dc.b $00
[00021374]                           dc.b $00
[00021375]                           dc.b $8a
[00021376] 00006f3c                  dc.l $00006f3c ; no symbol found
[0002137a]                           dc.b $00
[0002137b]                           dc.b $00
[0002137c]                           dc.b $00
[0002137d]                           dc.b $89
[0002137e] 00006f3c                  dc.l $00006f3c ; no symbol found
[00021382]                           dc.b $00
[00021383]                           dc.b $00
[00021384]                           dc.b $00
[00021385]                           dc.b $92
[00021386] 00006f3c                  dc.l $00006f3c ; no symbol found
[0002138a]                           dc.b $00
[0002138b]                           dc.b $00
[0002138c]                           dc.b $00
[0002138d]                           dc.b $86
[0002138e] 00006f3c                  dc.l $00006f3c ; no symbol found
[00021392]                           dc.b $00
[00021393]                           dc.b $00
[00021394]                           dc.b $00
[00021395]                           dc.b $8c
[00021396] 00006f3c                  dc.l $00006f3c ; no symbol found
[0002139a]                           dc.b $00
[0002139b]                           dc.b $00
[0002139c]                           dc.b $00
[0002139d]                           dc.b $8b
[0002139e] 00006f3c                  dc.l $00006f3c ; no symbol found
[000213a2]                           dc.b $00
[000213a3]                           dc.b $00
[000213a4]                           dc.b $00
[000213a5]                           dc.b $8e
[000213a6] 00006f3c                  dc.l $00006f3c ; no symbol found
[000213aa]                           dc.b $00
[000213ab]                           dc.b $00
[000213ac]                           dc.b $00
[000213ad]                           dc.b $88
[000213ae] 00006f3c                  dc.l $00006f3c ; no symbol found
[000213b2]                           dc.b $00
[000213b3]                           dc.b $00
[000213b4]                           dc.b $00
[000213b5]                           dc.b $a7
[000213b6] 00006f3c                  dc.l $00006f3c ; no symbol found
[000213ba]                           dc.b $00
[000213bb]                           dc.b $00
[000213bc]                           dc.b $00
[000213bd]                           dc.b $aa
[000213be] 00006ed6                  dc.l $00006ed6 ; no symbol found
[000213c2]                           dc.b $00
[000213c3]                           dc.b $00
[000213c4]                           dc.b $00
[000213c5]                           dc.b $69
[000213c6] 00006ed6                  dc.l $00006ed6 ; no symbol found
[000213ca]                           dc.b $00
[000213cb]                           dc.b $00
[000213cc]                           dc.b $00
[000213cd]                           dc.b $a9
[000213ce]                           dc.b $00
[000213cf]                           dc.b $00
[000213d0]                           dc.b $00
[000213d1]                           dc.b $00
[000213d2] 00006f56                  dc.l $00006f56 ; no symbol found
[000213d6] 00007728                  dc.l $00007728 ; no symbol found
[000213da]                           dc.b $00
[000213db]                           dc.b $00
[000213dc]                           dc.b $00
[000213dd]                           dc.b $60
[000213de] 0000769e                  dc.l $0000769e ; no symbol found
[000213e2]                           dc.b $00
[000213e3]                           dc.b $00
[000213e4]                           dc.b $00
[000213e5]                           dc.b $9d
[000213e6] 00007610                  dc.l $00007610 ; no symbol found
[000213ea]                           dc.b $00
[000213eb]                           dc.b $00
[000213ec]                           dc.b $00
[000213ed]                           dc.b $82
[000213ee] 000075f8                  dc.l $000075f8 ; no symbol found
[000213f2]                           dc.b $00
[000213f3]                           dc.b $00
[000213f4]                           dc.b $00
[000213f5]                           dc.b $9b
[000213f6] 000075e0                  dc.l $000075e0 ; no symbol found
[000213fa]                           dc.b $00
[000213fb]                           dc.b $00
[000213fc]                           dc.b $00
[000213fd]                           dc.b $94
[000213fe] 00007596                  dc.l $00007596 ; no symbol found
[00021402]                           dc.b $00
[00021403]                           dc.b $00
[00021404]                           dc.b $00
[00021405]                           dc.b $90
[00021406] 0000754c                  dc.l $0000754c ; no symbol found
[0002140a]                           dc.b $00
[0002140b]                           dc.b $00
[0002140c]                           dc.b $00
[0002140d]                           dc.b $8f
[0002140e] 00007502                  dc.l $00007502 ; no symbol found
[00021412]                           dc.b $00
[00021413]                           dc.b $00
[00021414]                           dc.b $00
[00021415]                           dc.b $96
[00021416] 000074b8                  dc.l $000074b8 ; no symbol found
[0002141a]                           dc.b $00
[0002141b]                           dc.b $00
[0002141c]                           dc.b $00
[0002141d]                           dc.b $95
[0002141e] 0000748a                  dc.l $0000748a ; no symbol found
[00021422]                           dc.b $00
[00021423]                           dc.b $00
[00021424]                           dc.b $00
[00021425]                           dc.b $a0
[00021426] 00007478                  dc.l $00007478 ; no symbol found
[0002142a]                           dc.b $00
[0002142b]                           dc.b $00
[0002142c]                           dc.b $00
[0002142d]                           dc.b $97
[0002142e] 0000746c                  dc.l $0000746c ; no symbol found
[00021432]                           dc.b $00
[00021433]                           dc.b $00
[00021434]                           dc.b $00
[00021435]                           dc.b $a3
[00021436] 00007460                  dc.l $00007460 ; no symbol found
[0002143a]                           dc.b $00
[0002143b]                           dc.b $00
[0002143c]                           dc.b $00
[0002143d]                           dc.b $9c
[0002143e] 00007454                  dc.l $00007454 ; no symbol found
[00021442]                           dc.b $00
[00021443]                           dc.b $00
[00021444]                           dc.b $00
[00021445]                           dc.b $c1
[00021446] 00007404                  dc.l $00007404 ; no symbol found
[0002144a]                           dc.b $00
[0002144b]                           dc.b $00
[0002144c]                           dc.b $00
[0002144d]                           dc.b $99
[0002144e] 000073b4                  dc.l $000073b4 ; no symbol found
[00021452]                           dc.b $00
[00021453]                           dc.b $00
[00021454]                           dc.b $00
[00021455]                           dc.b $85
[00021456] 0000735c                  dc.l $0000735c ; no symbol found
[0002145a]                           dc.b $00
[0002145b]                           dc.b $00
[0002145c]                           dc.b $00
[0002145d]                           dc.b $e2
[0002145e] 00007322                  dc.l $00007322 ; no symbol found
[00021462]                           dc.b $00
[00021463]                           dc.b $00
[00021464]                           dc.b $00
[00021465]                           dc.b $d8
[00021466] 0000730e                  dc.l $0000730e ; no symbol found
[0002146a]                           dc.b $00
[0002146b]                           dc.b $00
[0002146c]                           dc.b $00
[0002146d]                           dc.b $8b
[0002146e] 000072be                  dc.l $000072be ; no symbol found
[00021472]                           dc.b $00
[00021473]                           dc.b $00
[00021474]                           dc.b $00
[00021475]                           dc.b $de
[00021476] 00007288                  dc.l $00007288 ; no symbol found
[0002147a]                           dc.b $00
[0002147b]                           dc.b $00
[0002147c]                           dc.b $00
[0002147d]                           dc.b $9f
[0002147e] 0000724e                  dc.l $0000724e ; no symbol found
[00021482]                           dc.b $00
[00021483]                           dc.b $00
[00021484]                           dc.b $00
[00021485]                           dc.b $6c
[00021486] 00007240                  dc.l $00007240 ; no symbol found
[0002148a]                           dc.b $00
[0002148b]                           dc.b $00
[0002148c]                           dc.b $00
[0002148d]                           dc.b $43
[0002148e] 0000722c                  dc.l $0000722c ; no symbol found
[00021492]                           dc.b $00
[00021493]                           dc.b $00
[00021494]                           dc.b $00
[00021495]                           dc.b $5a
[00021496] 000071fc                  dc.l $000071fc ; no symbol found
[0002149a]                           dc.b $00
[0002149b]                           dc.b $00
[0002149c]                           dc.b $00
[0002149d]                           dc.b $6b
[0002149e] 000071b2                  dc.l $000071b2 ; no symbol found
[000214a2]                           dc.b $00
[000214a3]                           dc.b $00
[000214a4]                           dc.b $00
[000214a5]                           dc.b $66
[000214a6] 0000711c                  dc.l $0000711c ; no symbol found
[000214aa]                           dc.b $00
[000214ab]                           dc.b $00
[000214ac]                           dc.b $00
[000214ad]                           dc.b $64
[000214ae]                           dc.b $00
[000214af]                           dc.b $00
[000214b0]                           dc.b $00
[000214b1]                           dc.b $00
[000214b2] 0000774a                  dc.l $0000774a ; no symbol found
[000214b6]                           dc.b 'illegal side effect',0
[000214ca]                           dc.b 'illegal %',0
[000214d4]                           dc.b 'illegal /',0
[000214de]                           dc.b $00
[000214df]                           dc.b $00
[000214e0]                           dc.b $00
[000214e1]                           dc.b $00
[000214e2]                           dc.b $00
[000214e3]                           dc.b $00
[000214e4]                           dc.b $00
[000214e5]                           dc.b $00
_typtab:
[000214e6]                           dc.w $0809
[000214e8]                           dc.w $0a10
[000214ea]                           dc.w $1118
[000214ec]                           dc.w $191a
[000214ee]                           dc.b ' !()*@',0
[000214f5]                           dc.b $09
_bndtab:
[000214f6]                           dc.b $00
[000214f7]                           dc.b $00
[000214f8]                           dc.b $00
[000214f9]                           dc.b $01
[000214fa]                           dc.w $01ff
[000214fc]                           dc.w $ffff
[000214fe]                           dc.w $0202
[00021500]                           dc.w $0203
[00021502]                           dc.w $03fe
[00021504]                           dc.b $fe
_bytab:
[00021505]                           dc.b $01
[00021506]                           dc.w $0101
[00021508]                           dc.w $0202
[0002150a]                           dc.w $ffff
[0002150c]                           dc.w $ff04
[0002150e]                           dc.w $0404
[00021510]                           dc.w $0808
[00021512]                           dc.b $00
[00021513]                           dc.b $00
_ttyptab:
[00021514] 00020d68                  dc.l _atchar
[00021518] 00020d7a                  dc.l _atichar
[0002151c] 00020d8c                  dc.l _atuchar
[00021520] 00020d9e                  dc.l _atshort
[00021524] 00020db0                  dc.l _atushort
[00021528] 00020dc2                  dc.l _atint
[0002152c]                           dc.l 0
[00021530] 00020dd4                  dc.l _atunsign
[00021534] 00020de6                  dc.l _atlong
[00021538] 00020df8                  dc.l _atulong
[0002153c] 00020e0a                  dc.l _atfloat
[00021540] 00020e1c                  dc.l _atdouble
[00021544] 00020e2e                  dc.l _atldoubl
[00021548]                           dc.l 0
[0002154c]                           dc.l 0
_xtab:
[00021550]                           dc.w $0100
[00021552]                           dc.w $0203
[00021554]                           dc.w $0500
[00021556]                           dc.b $00
[00021557]                           dc.b $00
[00021558]                           dc.w $0608
[0002155a]                           dc.b $09,$0a,$0a,0
[0002155e]                           dc.b $00
_rettab:
[0002155f]                           dc.b $01
[00021560]                           dc.w $0101
[00021562]                           dc.w $0101
[00021564]                           dc.w $0101
[00021566]                           dc.w $0103
[00021568]                           dc.w $0340
[0002156a]                           dc.w $4040
[0002156c]                           dc.w $0101
[0002156e] 00007836                  dc.l $00007836 ; no symbol found
[00021572]                           dc.b $00
[00021573]                           dc.b $00
[00021574]                           dc.b $00
[00021575]                           dc.b $49
[00021576] 00007836                  dc.l $00007836 ; no symbol found
[0002157a]                           dc.b $00
[0002157b]                           dc.b $00
[0002157c]                           dc.b $00
[0002157d]                           dc.b $48
[0002157e] 0000782c                  dc.l $0000782c ; no symbol found
[00021582]                           dc.b $00
[00021583]                           dc.b $00
[00021584]                           dc.b $00
[00021585]                           dc.b $28
[00021586] 0000782c                  dc.l $0000782c ; no symbol found
[0002158a]                           dc.b $00
[0002158b]                           dc.b $00
[0002158c]                           dc.b $00
[0002158d]                           dc.b $29
[0002158e] 0000782c                  dc.l $0000782c ; no symbol found
[00021592]                           dc.b $00
[00021593]                           dc.b $00
[00021594]                           dc.b $00
[00021595]                           dc.b $2a
[00021596]                           dc.b $00
[00021597]                           dc.b $00
[00021598]                           dc.b $00
[00021599]                           dc.b $00
[0002159a] 0000783e                  dc.l $0000783e ; no symbol found
[0002159e] 00007cb0                  dc.l $00007cb0 ; no symbol found
[000215a2]                           dc.b $00
[000215a3]                           dc.b $00
[000215a4]                           dc.b $00
[000215a5]                           dc.b $49
[000215a6] 00007c6c                  dc.l $00007c6c ; no symbol found
[000215aa]                           dc.b $00
[000215ab]                           dc.b $00
[000215ac]                           dc.b $00
[000215ad]                           dc.b $48
[000215ae] 00007c3c                  dc.l $00007c3c ; no symbol found
[000215b2]                           dc.b $00
[000215b3]                           dc.b $00
[000215b4]                           dc.b $00
[000215b5]                           dc.b $41
[000215b6] 00007c1a                  dc.l $00007c1a ; no symbol found
[000215ba]                           dc.b $00
[000215bb]                           dc.b $00
[000215bc]                           dc.b $00
[000215bd]                           dc.b $40
[000215be]                           dc.b $00
[000215bf]                           dc.b $00
[000215c0]                           dc.b $00
[000215c1]                           dc.b $00
[000215c2] 00007d12                  dc.l $00007d12 ; no symbol found
[000215c6]                           dc.b 'size too large',0
[000215d5]                           dc.b 'size undefined',0
[000215e4]                           dc.b 'union size unknown',0
[000215f7]                           dc.b 'structure size unknown',0
[0002160e]                           dc.b 'array size unknown',0
[00021621]                           dc.b 'illegal void',0
[0002162e] 00007df8                  dc.l $00007df8 ; no symbol found
[00021632]                           dc.b $00
[00021633]                           dc.b $00
[00021634]                           dc.b $00
[00021635]                           dc.b $42
[00021636] 00007dde                  dc.l $00007dde ; no symbol found
[0002163a]                           dc.b $00
[0002163b]                           dc.b $00
[0002163c]                           dc.b $00
[0002163d]                           dc.b $49
[0002163e] 00007dde                  dc.l $00007dde ; no symbol found
[00021642]                           dc.b $00
[00021643]                           dc.b $00
[00021644]                           dc.b $00
[00021645]                           dc.b $48
[00021646] 00007dc4                  dc.l $00007dc4 ; no symbol found
[0002164a]                           dc.b $00
[0002164b]                           dc.b $00
[0002164c]                           dc.b $00
[0002164d]                           dc.b $41
[0002164e] 00007d9c                  dc.l $00007d9c ; no symbol found
[00021652]                           dc.b $00
[00021653]                           dc.b $00
[00021654]                           dc.b $00
[00021655]                           dc.b $40
[00021656]                           dc.b $00
[00021657]                           dc.b $00
[00021658]                           dc.b $00
[00021659]                           dc.b $00
[0002165a] 00007dc2                  dc.l $00007dc2 ; no symbol found
[0002165e]                           dc.b 'dead_',0
[00021664]                           dc.b 'external name conflict',0
[0002167b]                           dc.b $00
[0002167c]                           dc.b 'illegal argument type',0
[00021692] 00008528                  dc.l $00008528 ; no symbol found
[00021696]                           dc.b $00
[00021697]                           dc.b $00
[00021698]                           dc.b $00
[00021699]                           dc.b $28
[0002169a] 00008520                  dc.l $00008520 ; no symbol found
[0002169e]                           dc.b $00
[0002169f]                           dc.b $00
[000216a0]                           dc.b $00
[000216a1]                           dc.b $19
[000216a2] 00008502                  dc.l $00008502 ; no symbol found
[000216a6]                           dc.b $00
[000216a7]                           dc.b $00
[000216a8]                           dc.b $00
[000216a9]                           dc.b $11
[000216aa] 000084fa                  dc.l $000084fa ; no symbol found
[000216ae]                           dc.b $00
[000216af]                           dc.b $00
[000216b0]                           dc.b $00
[000216b1]                           dc.b $10
[000216b2] 000084fa                  dc.l $000084fa ; no symbol found
[000216b6]                           dc.b $00
[000216b7]                           dc.b $00
[000216b8]                           dc.b $00
[000216b9]                           dc.b $0a
[000216ba] 000084fa                  dc.l $000084fa ; no symbol found
[000216be]                           dc.b $00
[000216bf]                           dc.b $00
[000216c0]                           dc.b $00
[000216c1]                           dc.b $09
[000216c2] 000084fa                  dc.l $000084fa ; no symbol found
[000216c6]                           dc.b $00
[000216c7]                           dc.b $00
[000216c8]                           dc.b $00
[000216c9]                           dc.b $08
[000216ca]                           dc.b $00
[000216cb]                           dc.b $00
[000216cc]                           dc.b $00
[000216cd]                           dc.b $00
[000216ce] 00008530                  dc.l $00008530 ; no symbol found
[000216d2] 0000858a                  dc.l $0000858a ; no symbol found
[000216d6]                           dc.b $00
[000216d7]                           dc.b $00
[000216d8]                           dc.b $00
[000216d9]                           dc.b $42
[000216da] 0000857c                  dc.l $0000857c ; no symbol found
[000216de]                           dc.b $00
[000216df]                           dc.b $00
[000216e0]                           dc.b $00
[000216e1]                           dc.b $41
[000216e2] 00008566                  dc.l $00008566 ; no symbol found
[000216e6]                           dc.b $00
[000216e7]                           dc.b $00
[000216e8]                           dc.b $00
[000216e9]                           dc.b $40
[000216ea]                           dc.b $00
[000216eb]                           dc.b $00
[000216ec]                           dc.b $00
[000216ed]                           dc.b $00
[000216ee] 0000857a                  dc.l $0000857a ; no symbol found
[000216f2]                           dc.b $00
[000216f3]                           dc.b $00
[000216f4]                           dc.b $00
[000216f5]                           dc.b $00
[000216f6] 00020dc2                  dc.l _atint
[000216fa]                           dc.b $00
[000216fb]                           dc.b $00
[000216fc]                           dc.b $00
[000216fd]                           dc.b $00
[000216fe]                           dc.b $00
[000216ff]                           dc.b $00
[00021700]                           dc.b $00
[00021701]                           dc.b $00
[00021702]                           dc.b $00
[00021703]                           dc.b $00
_tycodes:
[00021704]                           dc.b $00
[00021705]                           dc.b $00
[00021706]                           dc.b $00
[00021707]                           dc.b $11
[00021708]                           dc.w $0100
[0002170a]                           dc.b $00
[0002170b]                           dc.b $18
[0002170c]                           dc.b $00
[0002170d]                           dc.b $18
[0002170e]                           dc.b $00
[0002170f]                           dc.b $18
[00021710]                           dc.b $00
[00021711]                           dc.b $18
[00021712]                           dc.w $0119
[00021714]                           dc.w $0119
[00021716]                           dc.w $0119
[00021718]                           dc.w $01f9
[0002171a]                           dc.w $01f9
[0002171c]                           dc.w $0100
[0002171e]                           dc.w $0690
[00021720]                           dc.w $0298
[00021722]                           dc.w $06b1
[00021724]                           dc.b $00
[00021725]                           dc.b $f9
[00021726]                           dc.b $00
[00021727]                           dc.b $f9
[00021728]                           dc.b $00
[00021729]                           dc.b $fd
[0002172a]                           dc.b $00
[0002172b]                           dc.b $fd
[0002172c]                           dc.b $00
[0002172d]                           dc.b $fb
[0002172e]                           dc.b $00
[0002172f]                           dc.b $fb
[00021730]                           dc.b $00
[00021731]                           dc.b $fb
[00021732]                           dc.b $00
[00021733]                           dc.b $fb
[00021734]                           dc.b $00
[00021735]                           dc.b $fb
[00021736]                           dc.b $00
[00021737]                           dc.b $fb
[00021738]                           dc.w $01d8
[0002173a]                           dc.w $01d8
[0002173c]                           dc.w $01dc
[0002173e]                           dc.w $01dc
[00021740]                           dc.w $01da
[00021742]                           dc.w $01da
[00021744]                           dc.w $01da
[00021746]                           dc.w $01da
[00021748]                           dc.w $01db
[0002174a]                           dc.w $01db
[0002174c]                           dc.b $00
[0002174d]                           dc.b $d8
[0002174e]                           dc.b $00
[0002174f]                           dc.b $d8
[00021750]                           dc.b $00
[00021751]                           dc.b $d8
[00021752]                           dc.b $00
[00021753]                           dc.b $d8
[00021754]                           dc.b $00
[00021755]                           dc.b $d8
[00021756]                           dc.b $00
[00021757]                           dc.b $d8
[00021758]                           dc.b $00
[00021759]                           dc.b $d8
[0002175a]                           dc.b $00
[0002175b]                           dc.b $d8
[0002175c]                           dc.b $00
[0002175d]                           dc.b $21
[0002175e]                           dc.b $00
[0002175f]                           dc.b $19
[00021760]                           dc.b $00
[00021761]                           dc.b $00
_tyops:
[00021762]                           dc.w $6164
[00021764]                           dc.w $a907
[00021766]                           dc.b 'fkZClm'
[0002176c]                           dc.w $aaa7
[0002176e]                           dc.w $69a8
[00021770]                           dc.w $9f88
[00021772]                           dc.w $8e8b
[00021774]                           dc.w $9187
[00021776]                           dc.w $8c86
[00021778]                           dc.w $928d
[0002177a]                           dc.w $898a
[0002177c]                           dc.w $ded8
[0002177e]                           dc.w $e285
[00021780]                           dc.w $99c1
[00021782]                           dc.w $9ca3
[00021784]                           dc.w $97a0
[00021786]                           dc.w $9596
[00021788]                           dc.w $8f90
[0002178a]                           dc.w $949b
[0002178c]                           dc.w $829d
[0002178e]                           dc.w $af60
[00021790]                           dc.b $00
[00021791]                           dc.b 'illegal actual argument',0
[000217a9]                           dc.b $00
[000217aa]                           dc.b 'scalar type required',0
[000217bf]                           dc.b $00
[000217c0] 00008a10                  dc.l $00008a10 ; no symbol found
[000217c4]                           dc.b $00
[000217c5]                           dc.b $00
[000217c6]                           dc.b $00
[000217c7]                           dc.b $8a
[000217c8] 00008a0c                  dc.l $00008a0c ; no symbol found
[000217cc]                           dc.b $00
[000217cd]                           dc.b $00
[000217ce]                           dc.b $00
[000217cf]                           dc.b $89
[000217d0] 00008a08                  dc.l $00008a08 ; no symbol found
[000217d4]                           dc.b $00
[000217d5]                           dc.b $00
[000217d6]                           dc.b $00
[000217d7]                           dc.b $8d
[000217d8] 00008a04                  dc.l $00008a04 ; no symbol found
[000217dc]                           dc.b $00
[000217dd]                           dc.b $00
[000217de]                           dc.b $00
[000217df]                           dc.b $92
[000217e0] 00008a02                  dc.l $00008a02 ; no symbol found
[000217e4]                           dc.b $00
[000217e5]                           dc.b $00
[000217e6]                           dc.b $00
[000217e7]                           dc.b $86
[000217e8] 00008a00                  dc.l $00008a00 ; no symbol found
[000217ec]                           dc.b $00
[000217ed]                           dc.b $00
[000217ee]                           dc.b $00
[000217ef]                           dc.b $8c
[000217f0] 000089fe                  dc.l $000089fe ; no symbol found
[000217f4]                           dc.b $00
[000217f5]                           dc.b $00
[000217f6]                           dc.b $00
[000217f7]                           dc.b $87
[000217f8] 000089fc                  dc.l $000089fc ; no symbol found
[000217fc]                           dc.b $00
[000217fd]                           dc.b $00
[000217fe]                           dc.b $00
[000217ff]                           dc.b $91
[00021800] 000089fa                  dc.l $000089fa ; no symbol found
[00021804]                           dc.b $00
[00021805]                           dc.b $00
[00021806]                           dc.b $00
[00021807]                           dc.b $8b
[00021808] 000089f8                  dc.l $000089f8 ; no symbol found
[0002180c]                           dc.b $00
[0002180d]                           dc.b $00
[0002180e]                           dc.b $00
[0002180f]                           dc.b $8e
[00021810] 000089f6                  dc.l $000089f6 ; no symbol found
[00021814]                           dc.b $00
[00021815]                           dc.b $00
[00021816]                           dc.b $00
[00021817]                           dc.b $88
[00021818] 000089f4                  dc.l $000089f4 ; no symbol found
[0002181c]                           dc.b $00
[0002181d]                           dc.b $00
[0002181e]                           dc.b $00
[0002181f]                           dc.b $69
[00021820] 000089f2                  dc.l $000089f2 ; no symbol found
[00021824]                           dc.b $00
[00021825]                           dc.b $00
[00021826]                           dc.b $00
[00021827]                           dc.b $a9
[00021828] 000089a4                  dc.l $000089a4 ; no symbol found
[0002182c]                           dc.b $00
[0002182d]                           dc.b $00
[0002182e]                           dc.b $00
[0002182f]                           dc.b $9f
[00021830] 00008992                  dc.l $00008992 ; no symbol found
[00021834]                           dc.b $00
[00021835]                           dc.b $00
[00021836]                           dc.b $00
[00021837]                           dc.b $a7
[00021838] 00008978                  dc.l $00008978 ; no symbol found
[0002183c]                           dc.b $00
[0002183d]                           dc.b $00
[0002183e]                           dc.b $00
[0002183f]                           dc.b $aa
[00021840]                           dc.b $00
[00021841]                           dc.b $00
[00021842]                           dc.b $00
[00021843]                           dc.b $00
[00021844] 00008a14                  dc.l $00008a14 ; no symbol found
[00021848]                           dc.b 'useless expression',0
[0002185b]                           dc.b $00
[0002185c]                           dc.b 'not in table!',0
[0002186a]                           dc.b 'illegal operand type',0
[0002187f]                           dc.b $00
[00021880]                           dc.b 'missing argument',0
[00021891]                           dc.b 'extra argument',0
[000218a0]                           dc.b 'illegal return type',0
[000218b4]                           dc.b 'function required',0
[000218c6]                           dc.b 'unknown member',0
[000218d5]                           dc.b 'illegal selection',0
[000218e7]                           dc.b $00
[000218e8]                           dc.b 'type conflict in conditional',0
[00021905]                           dc.b $00
[00021906] 00009c3e                  dc.l $00009c3e ; no symbol found
[0002190a]                           dc.b $00
[0002190b]                           dc.b $00
[0002190c]                           dc.b $00
[0002190d]                           dc.b $9b
[0002190e] 00009c3e                  dc.l $00009c3e ; no symbol found
[00021912]                           dc.b $00
[00021913]                           dc.b $00
[00021914]                           dc.b $00
[00021915]                           dc.b $94
[00021916] 00009c0c                  dc.l $00009c0c ; no symbol found
[0002191a]                           dc.b $00
[0002191b]                           dc.b $00
[0002191c]                           dc.b $00
[0002191d]                           dc.b $8f
[0002191e] 00009c0c                  dc.l $00009c0c ; no symbol found
[00021922]                           dc.b $00
[00021923]                           dc.b $00
[00021924]                           dc.b $00
[00021925]                           dc.b $96
[00021926] 00009c0c                  dc.l $00009c0c ; no symbol found
[0002192a]                           dc.b $00
[0002192b]                           dc.b $00
[0002192c]                           dc.b $00
[0002192d]                           dc.b $90
[0002192e] 00009c0c                  dc.l $00009c0c ; no symbol found
[00021932]                           dc.b $00
[00021933]                           dc.b $00
[00021934]                           dc.b $00
[00021935]                           dc.b $95
[00021936] 00009b04                  dc.l $00009b04 ; no symbol found
[0002193a]                           dc.b $00
[0002193b]                           dc.b $00
[0002193c]                           dc.b $00
[0002193d]                           dc.b $d8
[0002193e] 00009a78                  dc.l $00009a78 ; no symbol found
[00021942]                           dc.b $00
[00021943]                           dc.b $00
[00021944]                           dc.b $00
[00021945]                           dc.b $de
[00021946] 00009a14                  dc.l $00009a14 ; no symbol found
[0002194a]                           dc.b $00
[0002194b]                           dc.b $00
[0002194c]                           dc.b $00
[0002194d]                           dc.b $8b
[0002194e] 00009a14                  dc.l $00009a14 ; no symbol found
[00021952]                           dc.b $00
[00021953]                           dc.b $00
[00021954]                           dc.b $00
[00021955]                           dc.b $8e
[00021956] 00009a14                  dc.l $00009a14 ; no symbol found
[0002195a]                           dc.b $00
[0002195b]                           dc.b $00
[0002195c]                           dc.b $00
[0002195d]                           dc.b $a7
[0002195e] 00009a14                  dc.l $00009a14 ; no symbol found
[00021962]                           dc.b $00
[00021963]                           dc.b $00
[00021964]                           dc.b $00
[00021965]                           dc.b $aa
[00021966] 000099f2                  dc.l $000099f2 ; no symbol found
[0002196a]                           dc.b $00
[0002196b]                           dc.b $00
[0002196c]                           dc.b $00
[0002196d]                           dc.b $88
[0002196e] 000099ec                  dc.l $000099ec ; no symbol found
[00021972]                           dc.b $00
[00021973]                           dc.b $00
[00021974]                           dc.b $00
[00021975]                           dc.b $af
[00021976] 000099e2                  dc.l $000099e2 ; no symbol found
[0002197a]                           dc.b $00
[0002197b]                           dc.b $00
[0002197c]                           dc.b $00
[0002197d]                           dc.b $9f
[0002197e] 000099ce                  dc.l $000099ce ; no symbol found
[00021982]                           dc.b $00
[00021983]                           dc.b $00
[00021984]                           dc.b $00
[00021985]                           dc.b $a8
[00021986] 0000999e                  dc.l $0000999e ; no symbol found
[0002198a]                           dc.b $00
[0002198b]                           dc.b $00
[0002198c]                           dc.b $00
[0002198d]                           dc.b $6d
[0002198e] 0000999e                  dc.l $0000999e ; no symbol found
[00021992]                           dc.b $00
[00021993]                           dc.b $00
[00021994]                           dc.b $00
[00021995]                           dc.b $6c
[00021996] 0000997e                  dc.l $0000997e ; no symbol found
[0002199a]                           dc.b $00
[0002199b]                           dc.b $00
[0002199c]                           dc.b $00
[0002199d]                           dc.b $43
[0002199e] 0000993c                  dc.l $0000993c ; no symbol found
[000219a2]                           dc.b $00
[000219a3]                           dc.b $00
[000219a4]                           dc.b $00
[000219a5]                           dc.b $6b
[000219a6] 000098a2                  dc.l $000098a2 ; no symbol found
[000219aa]                           dc.b $00
[000219ab]                           dc.b $00
[000219ac]                           dc.b $00
[000219ad]                           dc.b $66
[000219ae] 00009892                  dc.l $00009892 ; no symbol found
[000219b2]                           dc.b $00
[000219b3]                           dc.b $00
[000219b4]                           dc.b $00
[000219b5]                           dc.b $07
[000219b6] 00009888                  dc.l $00009888 ; no symbol found
[000219ba]                           dc.b $00
[000219bb]                           dc.b $00
[000219bc]                           dc.b $00
[000219bd]                           dc.b $69
[000219be] 00009888                  dc.l $00009888 ; no symbol found
[000219c2]                           dc.b $00
[000219c3]                           dc.b $00
[000219c4]                           dc.b $00
[000219c5]                           dc.b $a9
[000219c6] 00009712                  dc.l $00009712 ; no symbol found
[000219ca]                           dc.b $00
[000219cb]                           dc.b $00
[000219cc]                           dc.b $00
[000219cd]                           dc.b $64
[000219ce] 000096da                  dc.l $000096da ; no symbol found
[000219d2]                           dc.b $00
[000219d3]                           dc.b $00
[000219d4]                           dc.b $00
[000219d5]                           dc.b $61
[000219d6] 0000969a                  dc.l $0000969a ; no symbol found
[000219da]                           dc.b $00
[000219db]                           dc.b $00
[000219dc]                           dc.b $00
[000219dd]                           dc.b $00
[000219de]                           dc.b $00
[000219df]                           dc.b $00
[000219e0]                           dc.b $00
[000219e1]                           dc.b $00
[000219e2] 000096c6                  dc.l $000096c6 ; no symbol found
[000219e6]                           dc.b 'illegal comparison',0
[000219f9]                           dc.b 'illegal +=',0
[00021a04]                           dc.b 'illegal assignment',0
[00021a17]                           dc.b 'arithmetic type required',0
[00021a30]                           dc.b 'integer type required',0
[00021a46]                           dc.b 'illegal indirection',0
[00021a5a]                           dc.b 'illegal cast',0
[00021a67]                           dc.b 'illegal &',0
[00021a71]                           dc.b 'undeclared',0
[00021a7c]                           dc.b 'const modified',0
[00021a8b]                           dc.b 'lvalue required',0
[00021a9b]                           dc.b $00
[00021a9c]                           dc.b 'illegal unsigned compare',0
[00021ab5]                           dc.b $00
[00021ab6]                           dc.w $0a00
[00021ab8]                           dc.w $5d00
[00021aba]                           dc.w $2000
[00021abc]                           dc.w $5e00
[00021abe]                           dc.w $2000
[00021ac0]                           dc.w $2d5b
[00021ac2]                           dc.b $00
[00021ac3]                           dc.b $00
[00021ac4] 0000a1f2                  dc.l $0000a1f2 ; no symbol found
[00021ac8]                           dc.b $00
[00021ac9]                           dc.b $00
[00021aca]                           dc.b $00
[00021acb]                           dc.b $3e
[00021acc] 0000a190                  dc.l $0000a190 ; no symbol found
[00021ad0]                           dc.b $00
[00021ad1]                           dc.b $00
[00021ad2]                           dc.b $00
[00021ad3]                           dc.b $00
[00021ad4] 0000a190                  dc.l $0000a190 ; no symbol found
[00021ad8]                           dc.b $00
[00021ad9]                           dc.b $00
[00021ada]                           dc.b $00
[00021adb]                           dc.b $3a
[00021adc] 0000a190                  dc.l $0000a190 ; no symbol found
[00021ae0]                           dc.b $00
[00021ae1]                           dc.b $00
[00021ae2]                           dc.b $00
[00021ae3]                           dc.b $2c
[00021ae4] 0000a106                  dc.l $0000a106 ; no symbol found
[00021ae8]                           dc.b $00
[00021ae9]                           dc.b $00
[00021aea]                           dc.b $00
[00021aeb]                           dc.b $23
[00021aec] 0000a0ca                  dc.l $0000a0ca ; no symbol found
[00021af0]                           dc.b $00
[00021af1]                           dc.b $00
[00021af2]                           dc.b $00
[00021af3]                           dc.b $3f
[00021af4] 0000a05a                  dc.l $0000a05a ; no symbol found
[00021af8]                           dc.b $00
[00021af9]                           dc.b $00
[00021afa]                           dc.b $00
[00021afb]                           dc.b $2a
[00021afc]                           dc.b $00
[00021afd]                           dc.b $00
[00021afe]                           dc.b $00
[00021aff]                           dc.b $00
[00021b00] 0000a29a                  dc.l $0000a29a ; no symbol found
[00021b04]                           dc.b 'help',0
[00021b09]                           dc.b $2d
[00021b0a]                           dc.b $00
[00021b0b]                           dc.b $2d
[00021b0c]                           dc.w $2d00
[00021b0e]                           dc.w $0a09
[00021b10]                           dc.b $00
[00021b11]                           dc.b $00
[00021b12]                           dc.w $2000
[00021b14]                           dc.b 'usage: ',0
[00021b1c]                           dc.w $080c
[00021b1e]                           dc.w $0a0d
[00021b20]                           dc.w $090b
[00021b22]                           dc.b $00
[00021b23]                           dc.b 'bfnrtv',0
[00021b2a]                           dc.b '/tmp/t',0
[00021b31]                           dc.b 'pppp',0
[00021b36]                           dc.b $00
[00021b37]                           dc.b $00
[00021b38]                           dc.b $00
[00021b39]                           dc.b $00
[00021b3a]                           dc.b $00
[00021b3b]                           dc.b $00
[00021b3c]                           dc.b $00
[00021b3d]                           dc.b $00
[00021b3e]                           dc.b $00
[00021b3f]                           dc.b $00
[00021b40]                           dc.b $00
[00021b41]                           dc.b $00
[00021b42]                           dc.b $00
[00021b43]                           dc.b $00
[00021b44]                           dc.b $00
[00021b45]                           dc.b $00
[00021b46]                           dc.b 'bad free call',0
__memerr:
[00021b54] 00021b58                  dc.l $00021b58 ; no symbol found
[00021b58]                           dc.b 'no memory',0
[00021b62] 00021b9c                  dc.l _end
__stop:
[00021b66]                           dc.b $00
[00021b67]                           dc.b $00
[00021b68]                           dc.b $00
[00021b69]                           dc.b $01
[00021b6a]                           dc.b $00
[00021b6b]                           dc.b $00
[00021b6c]                           dc.b $00
[00021b6d]                           dc.b $00
[00021b6e] 00021b72                  dc.l $00021b72 ; no symbol found
[00021b72]                           dc.b 'unchecked condition',0
_writerr:
[00021b86] 00021b8a                  dc.l $00021b8a ; no symbol found
[00021b8a]                           dc.b 'write error',0
[00021b96]                           dc.w $0a00
[00021b98]                           dc.w $3a20
[00021b9a]                           dc.b $00
[00021b9b]                           dc.b $00
;
00000000 T start
00000080 T _exit
000000aa T _onexit
000000ba T seterr
000000c6 T _alias
00000142 T _arinit
00000352 T _datend
000003ba T _datinit
0000053c T _dinit
0000085a T _ginit
0000094a T _stinit
00000b3e T _stnext
00000b62 T _cons
00000ba6 T _gelist
00000be6 T _gexpr
00000c26 T _gtest
00000c5a T _mbin
00000d2c T _mcast
00000da8 T _melist
00000e02 T _mexpr
00000e46 T _mident
00000f44 T _mtail
0000102e T _mterm
0000137a T _mtrail
00001566 T _numattr
00001604 T _addcase
0000167e T _autinit
0000176a T _dbfile
00001846 T _dbfunc
000019a4 T _dbstat
000019d2 T _dbvar
00001d10 T _doblock
0000224e T _dostat
00002ade T _fninit
000030de T _perc
00003192 T _alt
000031e4 T _baktok1
00003252 T _defspace
000032c6 T _domodel
0000332e T _eat
00003368 T _getch
000033d6 T _getspace
000034be T _getstr
000034e6 T _gettok1
00003654 T _gpragma
00003894 T _gtok
00003bae T _ident
00003be2 T _neat
00003c08 T _need
00003c56 T _needc
00003c8a T _nmerr
00003e50 T _peek
00003e84 T _p1error
00003e98 T _putchr
00003f28 T _recover
00003f74 T _chktyp
00004018 T _decsu
00004682 T _dterm
00004b1e T _gdecl
00004d10 T _gdspace
00004d4c T _gscty
00004efc T _gtypspec
00004f46 T _main
00005704 T _crs
0000571a T _crx
00005736 T _findlngs
0000576c T _freecase
0000580e T _gtlcase
00005868 T _lblname
000058e0 T _pad
00005908 T _paddr
000059b0 T _pauto
000059d4 T _pcase
00005a16 T _pcode
00005a30 T _pdata
00005a8c T _pdend
00005aa6 T _pend
00005b7a T _pfend
00005b94 T _pfloat
00005bec T _pfunc
00005c34 T _pint
00005c7a T _pjc
00005cea T _pjf
00005e1a T _pjmptab
00005ede T _pjump
00005f2e T _pjt
00006036 T _plabel
0000607c T _pmove
000060c4 T _preforde
000060fe T _pregs
0000612e T _pret
00006140 T _pspace
00006168 T _pscntab
000061ca T _pstr
0000624a T _pswitch
00006294 T _pswtab
00006374 T _pswntab
000064da T _ptexpr
0000661a T _ptname
0000675e T _pttype
0000695c T _putbytes
00006988 T _pvoid
000069ae T _rbuy
00006a90 T _spaceinf
00006b46 T _cachk
00006bb8 T _canadd
00006c82 T _canmul
00006ce4 T _cansub
00006d96 T _cpyterm
00006dd2 T _docast
00006e7a T _hasname
00006ea2 T _hasside
00006f92 T _reduce
0000774e T _addsym
00007846 T _addtype
00007874 T _bndify
000078b4 T _bound
000079aa T _buyattr
00007a0e T _buyop
00007a78 T _buysym
00007aec T _buyterm
00007b74 T _bytes
00007d40 T _cmptype
00007e5e T _clrsym
00007e8c T _cpyats
00007f58 T _cpyattr
00007f98 T _deadname
00007fda T _dlit
00008016 T _dnegate
00008062 T _dtype
000080a0 T _exchk
0000811a T _exmatch
000081ce T _exspace
00008210 T _fixargs
00008332 T _frealst
00008372 T _fretlst
000083b6 T _iscons
000083fa T _issigned
0000844a T _itype
0000847e T _lookup
000084da T _maxify
00008534 T _mergatt
000085aa T _setad
000085f4 T _stype
00008634 T _argchk
000086a8 T _canass
000088aa T _defat
00008914 T _docheck
00008a94 T _fixsym
00008b74 T _maxty
00008c1a T _ptify
00008cb6 T _scalify
00008e3c T _tfn
000090fa T _tpoints
00009312 T _tquery
000094c6 T _typify
00009d1e T _untest
00009d7e T _fill
00009da6 T _frelst
00009f16 T _getflags
0000a352 T _itob
0000a3ec T _notbuf
0000a43e T _usage
0000a4b4 T _buybuf
0000a4e8 T _cmpstr
0000a51e T _cpystr
0000a54e T _create
0000a5c8 T _doesc
0000a6da T _getenv
0000a736 T a.lmod
0000a748 T a.ldiv
0000a796 T _open
0000a79e T _read
0000a7a6 T _scnstr
0000a7dc T a.switch
0000a7ee T a.ulmod
0000a7f6 T a.uldiv
0000a832 T a.1ultd
0000a83a T a.6ultd
0000a85e T _uname
0000a906 T _alloc
0000a940 T _nalloc
0000aa76 T _free
0000ab38 T _btol
0000ad6e T _close
0000ad76 T _cmpbuf
0000adac T _cpybuf
0000add6 T _creat
0000adde T _getpid
0000ade4 T a.lmul
0000ae10 T a.1ltd
0000ae18 T a.6ltd
0000ae40 T _putstr
0000ae76 T _sbreak
0000aeba T _fwrite
0000aef4 T _lenstr
0000af16 T __raise
0000afb2 T __when
0000aff8 T a.repk
0000b0c8 T _error
0000b106 T _write

00020000 D __data
00020072 D _environ
00020076 D _errno
0002007a D __paths
000202be D _freeexpr
000204a0 D _regset
000204a2 D _autoff
000204a6 D _dbline
000204a8 D _dbfilab
000204aa D _dbfulab
000204ac D _dbfvlab
000204ae D _rat
000204b2 D _caseterm
000204ca D _rterm
0002077c D _noname
0002077e D _ntoks
00020780 D _tokstk
00020792 D _spaces
00020b64 D _iregs
00020b66 D _aflag
00020b6a D _cflag
00020b6e D _dbflag
00020b72 D _deadflag
00020b76 D _errflag
00020b7a D _laxflag
00020b7e D _lflag
00020b82 D _lregflag
00020b86 D _mflag
00020b8a D _oldflag
00020b8e D _stdflag
00020b92 D _strictfl
00020b96 D _romstrin
00020b9a D _uflag
00020b9e D _bndef
00020ba2 D _model
00020ba6 D _nlen
00020baa D _maxint
00020bae D _minint
00020bb2 D _dcbyte
00020bb3 D _regbyte
00020bb4 D _mainbuff
00020c34 D _errbuf
00020cb4 D _p1p2ioct
00020cb8 D _p1err
00020cbc D _pperr
00020cc0 D __pname
00020cc8 D _errfd
00020cca D _ofile
00020cce D _nerrors
00020cd0 D _infile
00020cd4 D _lineno
00020cd6 D _outfd
00020cd8 D _dummyatt
00020cea D _attlist
00020cee D _gblat
00020cf2 D _badsym
00020d04 D _tentsym
00020d16 D _gblsym
00020d1a D _lbltab
00020d1e D _littab
00020d22 D _mostab
00020d26 D _spacetab
00020d2a D _symend
00020d2e D _symtab
00020d32 D _exlist
00020d68 D _atchar
00020d7a D _atichar
00020d8c D _atuchar
00020d9e D _atshort
00020db0 D _atushort
00020dc2 D _atint
00020dd4 D _atunsign
00020de6 D _atlong
00020df8 D _atulong
00020e0a D _atfloat
00020e1c D _atdouble
00020e2e D _atldoubl
00020e40 D _atvoid
00020e52 D _byulong
00020e56 D _byunsign
00020e5a D _legals
00020e90 D _legalatt
000211cc D _zeterm
000214e6 D _typtab
000214f6 D _bndtab
00021505 D _bytab
00021514 D _ttyptab
00021550 D _xtab
0002155f D _rettab
00021704 D _tycodes
00021762 D _tyops
00021b54 D __memerr
00021b66 D __stop
00021b86 D _writerr
00036a8e B _end

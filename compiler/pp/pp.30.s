; a_magic   = 0x992d
; a_text    = 0x00005550
; a_data    = 0x00001430
; a_bss     = 0x00000000
; a_syms    = 0x000009d0
; a_heap    = 0x0000fffe
; a_textoff = 0x00000000
; a_dataoff = 0x00020000
; a_relocs  = 0x00000804@0x0000736c


start:
[00000000] 201f                      move.l     (a7)+,d0
[00000002] 204f                      movea.l    a7,a0
[00000004] 2f08                      move.l     a0,-(a7)
[00000006] 2f08                      move.l     a0,-(a7)
[00000008] 2f00                      move.l     d0,-(a7)
[0000000a] e598                      rol.l      #2,d0
[0000000c] 5880                      addq.l     #4,d0
[0000000e] d1af 0008                 add.l      d0,8(a7)
[00000012] 23ef 0008 0002 0072       move.l     8(a7),$000255C2
[0000001a] 4a97                      tst.l      (a7)
[0000001c] 6726                      beq.s      start_1
[0000001e] 206f 0004                 movea.l    4(a7),a0
[00000022] 2050                      movea.l    (a0),a0
[00000024] 23c8 0002 0a4e            move.l     a0,$00025F9E
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
[0000003e] 23c8 0002 007a            move.l     a0,$000255CA
start_1:
[00000044] 4879 0002 006c            pea.l      $000255BC
[0000004a] 4eb9 0000 4358            jsr        _getenv
[00000050] 4a9f                      tst.l      (a7)+
[00000052] 4a87                      tst.l      d7
[00000054] 6706                      beq.s      start_4
[00000056] 23c7 0002 007a            move.l     d7,$000255CA
start_4:
[0000005c] 0cb9 0000 0001 0002 13a0  cmpi.l     #$00000001,$000268F0
[00000066] 660a                      bne.s      start_5
[00000068] 23fc 0002 1430 0002 13a0  move.l     #$00027DB0,$000268F0
start_5:
[00000072] 4eb9 0000 20bc            jsr        _main
[00000078] 2e87                      move.l     d7,(a7)
[0000007a] 4eb9 0000 0080            jsr        _exit

_exit:
[00000080] 2e39 0002 007e            move.l     $000255CE,d7
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
[000000aa] 2e39 0002 007e            move.l     $000255CE,d7
[000000b0] 23ef 0004 0002 007e       move.l     4(a7),$000255CE
[000000b8] 4e75                      rts

seterr:
[000000ba] 4487                      neg.l      d7
[000000bc] 23c7 0002 0076            move.l     d7,$000255C6
[000000c2] 7eff                      moveq.l    #-1,d7
[000000c4] 4ed0                      jmp        (a0)

_builtin:
[000000c6] 4e56 fff8                 link       a6,#-8
[000000ca] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[000000ce] 2a6e 0008                 movea.l    8(a6),a5
[000000d2] 286e 000c                 movea.l    12(a6),a4
[000000d6] 2eac 0014                 move.l     20(a4),(a7)
[000000da] 2f2c 0010                 move.l     16(a4),-(a7)
[000000de] 4878 0004                 pea.l      ($00000004).w
[000000e2] 2f3c 0002 0082            move.l     #$000255D2,-(a7)
[000000e8] 4eb9 0000 336e            jsr        _scntab
[000000ee] 4fef 000c                 lea.l      12(a7),a7
[000000f2] 2a07                      move.l     d7,d5
[000000f4] 660a                      bne.s      _builtin_1
[000000f6] 2e0c                      move.l     a4,d7
[000000f8] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[000000fc] 4e5e                      unlk       a6
[000000fe] 4e75                      rts
_builtin_1:
[00000100] 2e05                      move.l     d5,d7
[00000102] 41f9 0002 00e8            lea.l      $00025638,a0
[00000108] 4ef9 0000 4770            jmp        a.switch
[0000010e] 45f8 0014                 lea.l      ($00000014).w,a2
[00000112] d5d4                      adda.l     (a4),a2
[00000114] 0c92 0000 0001            cmpi.l     #$00000001,(a2)
[0000011a] 6678                      bne.s      _builtin_2
[0000011c] 45f8 0010                 lea.l      ($00000010).w,a2
[00000120] d5d4                      adda.l     (a4),a2
[00000122] 2452                      movea.l    (a2),a2
[00000124] 4287                      clr.l      d7
[00000126] 1e12                      move.b     (a2),d7
[00000128] 0c47 0028                 cmpi.w     #$0028,d7
[0000012c] 6666                      bne.s      _builtin_2
[0000012e] 42ae fffc                 clr.l      -4(a6)
[00000132] 4878 0001                 pea.l      ($00000001).w
[00000136] 486e fffc                 pea.l      -4(a6)
[0000013a] 2f14                      move.l     (a4),-(a7)
[0000013c] 4eb9 0000 08f6            jsr        _getargs
[00000142] 4fef 000c                 lea.l      12(a7),a7
[00000146] 2d47 fff8                 move.l     d7,-8(a6)
[0000014a] 2eae fffc                 move.l     -4(a6),(a7)
[0000014e] 2f2e fff8                 move.l     -8(a6),-(a7)
[00000152] 4eb9 0000 084a            jsr        _doif
[00000158] 588f                      addq.l     #4,a7
[0000015a] 2a87                      move.l     d7,(a5)
[0000015c] 2e15                      move.l     (a5),d7
[0000015e] beae fff8                 cmp.l      -8(a6),d7
[00000162] 6712                      beq.s      _builtin_3
[00000164] 2455                      movea.l    (a5),a2
[00000166] 508a                      addq.l     #8,a2
[00000168] 24ac 0008                 move.l     8(a4),(a2)
[0000016c] 45f8 000c                 lea.l      ($0000000C).w,a2
[00000170] d5d5                      adda.l     (a5),a2
[00000172] 24ac 000c                 move.l     12(a4),(a2)
_builtin_3:
[00000176] 4297                      clr.l      (a7)
[00000178] 2f2e fffc                 move.l     -4(a6),-(a7)
[0000017c] 4eb9 0000 38f2            jsr        _frelst
[00000182] 588f                      addq.l     #4,a7
[00000184] 2eae fff8                 move.l     -8(a6),(a7)
[00000188] 2f0c                      move.l     a4,-(a7)
[0000018a] 4eb9 0000 2b20            jsr        _fretlist
[00000190] 588f                      addq.l     #4,a7
[00000192] 2855                      movea.l    (a5),a4
_builtin_2:
[00000194] 2e0c                      move.l     a4,d7
[00000196] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[0000019a] 4e5e                      unlk       a6
[0000019c] 4e75                      rts

x19e_3:
[0000019e] 42ac 000c                 clr.l      12(a4)
[000001a2] 2479 0002 0a6c            movea.l    $00025FBC,a2
[000001a8] 588a                      addq.l     #4,a2
[000001aa] 4a92                      tst.l      (a2)
[000001ac] 6712                      beq.s      x19e_1
[000001ae] 2479 0002 0a6c            movea.l    $00025FBC,a2
[000001b4] 588a                      addq.l     #4,a2
[000001b6] 2e92                      move.l     (a2),(a7)
[000001b8] 4eb9 0000 52f4            jsr        _lenstr
[000001be] 6002                      bra.s      x19e_2
x19e_1:
[000001c0] 4287                      clr.l      d7
x19e_2:
[000001c2] 2947 0014                 move.l     d7,20(a4)
[000001c6] 7008                      moveq.l    #8,d0
[000001c8] 2940 0004                 move.l     d0,4(a4)
[000001cc] 2479 0002 0a6c            movea.l    $00025FBC,a2
[000001d2] 588a                      addq.l     #4,a2
[000001d4] 2952 0010                 move.l     (a2),16(a4)
[000001d8] 60ba                      bra.s      x19e_3
[000001da] 4878 000a                 pea.l      ($0000000A).w
[000001de] 2479 0002 0a6c            movea.l    $00025FBC,a2
[000001e4] 508a                      addq.l     #8,a2
[000001e6] 3e12                      move.w     (a2),d7
[000001e8] 48c7                      ext.l      d7
[000001ea] 2f07                      move.l     d7,-(a7)
[000001ec] 2f3c 0002 00de            move.l     #$0002562E,-(a7)
[000001f2] 4eb9 0000 3f4a            jsr        _itob
[000001f8] 4fef 000c                 lea.l      12(a7),a7
[000001fc] 2947 0014                 move.l     d7,20(a4)
[00000200] 7004                      moveq.l    #4,d0
[00000202] 2940 0004                 move.l     d0,4(a4)
[00000206] 297c 0002 00de 0010       move.l     #$0002562E,16(a4)
[0000020e] 6084                      bra.s      x19e_3
[00000210] 4a79 0002 0a3a            tst.w      $00025F8A
[00000216] 6700 ff7c                 beq        x19e_3
[0000021a] 2454                      movea.l    (a4),a2
[0000021c] 588a                      addq.l     #4,a2
[0000021e] 0c92 0000 0003            cmpi.l     #$00000003,(a2)
[00000224] 6650                      bne.s      x19e_4
[00000226] 7001                      moveq.l    #1,d0
[00000228] 2940 0014                 move.l     d0,20(a4)
[0000022c] 7004                      moveq.l    #4,d0
[0000022e] 2940 0004                 move.l     d0,4(a4)
[00000232] 4297                      clr.l      (a7)
[00000234] 45f8 0014                 lea.l      ($00000014).w,a2
[00000238] d5d4                      adda.l     (a4),a2
[0000023a] 2f12                      move.l     (a2),-(a7)
[0000023c] 45f8 0010                 lea.l      ($00000010).w,a2
[00000240] d5d4                      adda.l     (a4),a2
[00000242] 2f12                      move.l     (a2),-(a7)
[00000244] 4eb9 0000 2e8a            jsr        _lookup
[0000024a] 508f                      addq.l     #8,a7
[0000024c] 4a87                      tst.l      d7
[0000024e] 6708                      beq.s      x19e_5
[00000250] 2e3c 0002 0129            move.l     #$00025679,d7
[00000256] 6006                      bra.s      x19e_6
x19e_5:
[00000258] 2e3c 0002 0127            move.l     #$00025677,d7
x19e_6:
[0000025e] 2947 0010                 move.l     d7,16(a4)
[00000262] 2454                      movea.l    (a4),a2
[00000264] 2e92                      move.l     (a2),(a7)
[00000266] 2f14                      move.l     (a4),-(a7)
[00000268] 4eb9 0000 2b20            jsr        _fretlist
[0000026e] 588f                      addq.l     #4,a7
[00000270] 2887                      move.l     d7,(a4)
[00000272] 6000 ff20                 bra        x19e_3
x19e_4:
[00000276] 2454                      movea.l    (a4),a2
[00000278] 4a92                      tst.l      (a2)
[0000027a] 675e                      beq.s      x19e_7
[0000027c] 2454                      movea.l    (a4),a2
[0000027e] 2452                      movea.l    (a2),a2
[00000280] 4a92                      tst.l      (a2)
[00000282] 6756                      beq.s      x19e_7
[00000284] 45f8 0014                 lea.l      ($00000014).w,a2
[00000288] d5d4                      adda.l     (a4),a2
[0000028a] 0c92 0000 0001            cmpi.l     #$00000001,(a2)
[00000290] 6648                      bne.s      x19e_7
[00000292] 45f8 0010                 lea.l      ($00000010).w,a2
[00000296] d5d4                      adda.l     (a4),a2
[00000298] 2452                      movea.l    (a2),a2
[0000029a] 4287                      clr.l      d7
[0000029c] 1e12                      move.b     (a2),d7
[0000029e] 0c47 0028                 cmpi.w     #$0028,d7
[000002a2] 6636                      bne.s      x19e_7
[000002a4] 2454                      movea.l    (a4),a2
[000002a6] 2452                      movea.l    (a2),a2
[000002a8] 588a                      addq.l     #4,a2
[000002aa] 0c92 0000 0003            cmpi.l     #$00000003,(a2)
[000002b0] 6628                      bne.s      x19e_7
[000002b2] 45f8 0014                 lea.l      ($00000014).w,a2
[000002b6] 2654                      movea.l    (a4),a3
[000002b8] 2653                      movea.l    (a3),a3
[000002ba] d5d3                      adda.l     (a3),a2
[000002bc] 0c92 0000 0001            cmpi.l     #$00000001,(a2)
[000002c2] 6616                      bne.s      x19e_7
[000002c4] 45f8 0010                 lea.l      ($00000010).w,a2
[000002c8] 2654                      movea.l    (a4),a3
[000002ca] 2653                      movea.l    (a3),a3
[000002cc] d5d3                      adda.l     (a3),a2
[000002ce] 2452                      movea.l    (a2),a2
[000002d0] 4287                      clr.l      d7
[000002d2] 1e12                      move.b     (a2),d7
[000002d4] 0c47 0029                 cmpi.w     #$0029,d7
[000002d8] 6710                      beq.s      x19e_8
x19e_7:
[000002da] 2ebc 0002 0114            move.l     #$00025664,(a7)
[000002e0] 4eb9 0000 310e            jsr        _p0error
[000002e6] 6000 feac                 bra        x19e_3
x19e_8:
[000002ea] 7001                      moveq.l    #1,d0
[000002ec] 2940 0014                 move.l     d0,20(a4)
[000002f0] 7004                      moveq.l    #4,d0
[000002f2] 2940 0004                 move.l     d0,4(a4)
[000002f6] 4297                      clr.l      (a7)
[000002f8] 45f8 0014                 lea.l      ($00000014).w,a2
[000002fc] 2654                      movea.l    (a4),a3
[000002fe] d5d3                      adda.l     (a3),a2
[00000300] 2f12                      move.l     (a2),-(a7)
[00000302] 45f8 0010                 lea.l      ($00000010).w,a2
[00000306] 2654                      movea.l    (a4),a3
[00000308] d5d3                      adda.l     (a3),a2
[0000030a] 2f12                      move.l     (a2),-(a7)
[0000030c] 4eb9 0000 2e8a            jsr        _lookup
[00000312] 508f                      addq.l     #8,a7
[00000314] 4a87                      tst.l      d7
[00000316] 6708                      beq.s      x19e_9
[00000318] 2e3c 0002 0112            move.l     #$00025662,d7
[0000031e] 6006                      bra.s      x19e_10
x19e_9:
[00000320] 2e3c 0002 0110            move.l     #$00025660,d7
x19e_10:
[00000326] 2947 0010                 move.l     d7,16(a4)
[0000032a] 2454                      movea.l    (a4),a2
[0000032c] 2452                      movea.l    (a2),a2
[0000032e] 2452                      movea.l    (a2),a2
[00000330] 2e92                      move.l     (a2),(a7)
[00000332] 2f14                      move.l     (a4),-(a7)
[00000334] 4eb9 0000 2b20            jsr        _fretlist
[0000033a] 588f                      addq.l     #4,a7
[0000033c] 2887                      move.l     d7,(a4)
[0000033e] 6000 fe54                 bra        x19e_3

_dodef:
[00000342] 4e56 ffe2                 link       a6,#-30
[00000346] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000034a] 45ee ffe6                 lea.l      -26(a6),a2
[0000034e] 2a4a                      movea.l    a2,a5
[00000350] 426e fff4                 clr.w      -12(a6)
[00000354] 426e fff2                 clr.w      -14(a6)
[00000358] 45f8 000c                 lea.l      ($0000000C).w,a2
[0000035c] d5ee 0008                 adda.l     8(a6),a2
[00000360] 4a92                      tst.l      (a2)
[00000362] 6624                      bne.s      _dodef_1
[00000364] 45f8 0014                 lea.l      ($00000014).w,a2
[00000368] d5ee 0008                 adda.l     8(a6),a2
[0000036c] 0c92 0000 0001            cmpi.l     #$00000001,(a2)
[00000372] 6614                      bne.s      _dodef_1
[00000374] 45f8 0010                 lea.l      ($00000010).w,a2
[00000378] d5ee 0008                 adda.l     8(a6),a2
[0000037c] 2452                      movea.l    (a2),a2
[0000037e] 4287                      clr.l      d7
[00000380] 1e12                      move.b     (a2),d7
[00000382] 0c47 0028                 cmpi.w     #$0028,d7
[00000386] 6724                      beq.s      _dodef_2
_dodef_1:
[00000388] 286e 0008                 movea.l    8(a6),a4
_dodef_9:
[0000038c] 2d6e 0010 fffc            move.l     16(a6),-4(a6)
[00000392] 426e fff6                 clr.w      -10(a6)
_dodef_4:
[00000396] 4aae fffc                 tst.l      -4(a6)
[0000039a] 6700 00d6                 beq        _dodef_3
[0000039e] 246e fffc                 movea.l    -4(a6),a2
[000003a2] 2d52 fffc                 move.l     (a2),-4(a6)
[000003a6] 526e fff6                 addq.w     #1,-10(a6)
[000003aa] 60ea                      bra.s      _dodef_4
_dodef_2:
[000003ac] 246e 0008                 movea.l    8(a6),a2
[000003b0] 2852                      movea.l    (a2),a4
[000003b2] 0cac 0000 0003 0004       cmpi.l     #$00000003,4(a4)
[000003ba] 6608                      bne.s      _dodef_5
[000003bc] 3d7c 0001 fff4            move.w     #$0001,-12(a6)
[000003c2] 2854                      movea.l    (a4),a4
_dodef_5:
[000003c4] 2e0c                      move.l     a4,d7
[000003c6] 6718                      beq.s      _dodef_6
[000003c8] 0cac 0000 0001 0014       cmpi.l     #$00000001,20(a4)
[000003d0] 662a                      bne.s      _dodef_7
[000003d2] 246c 0010                 movea.l    16(a4),a2
[000003d6] 4287                      clr.l      d7
[000003d8] 1e12                      move.b     (a2),d7
[000003da] 0c47 0029                 cmpi.w     #$0029,d7
[000003de] 661c                      bne.s      _dodef_7
_dodef_6:
[000003e0] 2e0c                      move.l     a4,d7
[000003e2] 6600 0088                 bne        _dodef_8
[000003e6] 2ebc 0002 015d            move.l     #$000256AD,(a7)
[000003ec] 4eb9 0000 310e            jsr        _p0error
[000003f2] 426e fff4                 clr.w      -12(a6)
[000003f6] 286e 0008                 movea.l    8(a6),a4
[000003fa] 6090                      bra.s      _dodef_9
_dodef_7:
[000003fc] 4ab9 0002 0a2a            tst.l      $00025F7A
[00000402] 662c                      bne.s      _dodef_10
[00000404] 4a6e fff4                 tst.w      -12(a6)
[00000408] 6726                      beq.s      _dodef_10
[0000040a] 0cac 0000 0001 0014       cmpi.l     #$00000001,20(a4)
[00000412] 661c                      bne.s      _dodef_10
[00000414] 246c 0010                 movea.l    16(a4),a2
[00000418] 4287                      clr.l      d7
[0000041a] 1e12                      move.b     (a2),d7
[0000041c] 0c47 0023                 cmpi.w     #$0023,d7
[00000420] 660e                      bne.s      _dodef_10
[00000422] 4a6e fff2                 tst.w      -14(a6)
[00000426] 6638                      bne.s      _dodef_11
[00000428] 3d6e fff4 fff2            move.w     -12(a6),-14(a6)
[0000042e] 6030                      bra.s      _dodef_11
_dodef_10:
[00000430] 0cac 0000 0001 0014       cmpi.l     #$00000001,20(a4)
[00000438] 662c                      bne.s      _dodef_12
[0000043a] 246c 0010                 movea.l    16(a4),a2
[0000043e] 4287                      clr.l      d7
[00000440] 1e12                      move.b     (a2),d7
[00000442] 0c47 002c                 cmpi.w     #$002C,d7
[00000446] 661e                      bne.s      _dodef_12
[00000448] 2454                      movea.l    (a4),a2
[0000044a] 588a                      addq.l     #4,a2
[0000044c] 0c92 0000 0003            cmpi.l     #$00000003,(a2)
[00000452] 6612                      bne.s      _dodef_12
[00000454] 2454                      movea.l    (a4),a2
[00000456] 2852                      movea.l    (a2),a4
[00000458] 526e fff4                 addq.w     #1,-12(a6)
[0000045c] 6000 ff66                 bra        _dodef_5
_dodef_11:
[00000460] 2854                      movea.l    (a4),a4
[00000462] 6000 ff60                 bra        _dodef_5
_dodef_12:
[00000466] 99cc                      suba.l     a4,a4
[00000468] 6000 ff5a                 bra        _dodef_5
_dodef_8:
[0000046c] 2854                      movea.l    (a4),a4
[0000046e] 6000 ff1c                 bra        _dodef_9
_dodef_3:
[00000472] 4ab9 0002 0a2a            tst.l      $00025F7A
[00000478] 672c                      beq.s      _dodef_13
[0000047a] 4a6e fff2                 tst.w      -14(a6)
[0000047e] 670a                      beq.s      _dodef_14
[00000480] 3e2e fff2                 move.w     -14(a6),d7
[00000484] 48c7                      ext.l      d7
[00000486] 5387                      subq.l     #1,d7
[00000488] 6006                      bra.s      _dodef_15
_dodef_14:
[0000048a] 3e2e fff4                 move.w     -12(a6),d7
[0000048e] 48c7                      ext.l      d7
_dodef_15:
[00000490] 3c2e fff6                 move.w     -10(a6),d6
[00000494] 48c6                      ext.l      d6
[00000496] bc87                      cmp.l      d7,d6
[00000498] 6c3a                      bge.s      _dodef_16
[0000049a] 2ebc 0002 0145            move.l     #$00025695,(a7)
[000004a0] 4eb9 0000 310e            jsr        _p0error
_dodef_13:
[000004a6] 2d4c ffee                 move.l     a4,-18(a6)
_dodef_30:
[000004aa] 0cac 0000 0002 0004       cmpi.l     #$00000002,4(a4)
[000004b2] 6744                      beq.s      _dodef_17
[000004b4] 0cac 0000 0001 0014       cmpi.l     #$00000001,20(a4)
[000004bc] 6650                      bne.s      _dodef_18
[000004be] 246c 0010                 movea.l    16(a4),a2
[000004c2] 4287                      clr.l      d7
[000004c4] 1e12                      move.b     (a2),d7
[000004c6] 0c47 0023                 cmpi.w     #$0023,d7
[000004ca] 6642                      bne.s      _dodef_18
[000004cc] 2d4c ffe2                 move.l     a4,-30(a6)
[000004d0] 2854                      movea.l    (a4),a4
[000004d2] 603e                      bra.s      _dodef_19
_dodef_16:
[000004d4] 4a6e fff2                 tst.w      -14(a6)
[000004d8] 66cc                      bne.s      _dodef_13
[000004da] 3e2e fff4                 move.w     -12(a6),d7
[000004de] 48c7                      ext.l      d7
[000004e0] 3c2e fff6                 move.w     -10(a6),d6
[000004e4] 48c6                      ext.l      d6
[000004e6] be86                      cmp.l      d6,d7
[000004e8] 6cbc                      bge.s      _dodef_13
[000004ea] 2ebc 0002 012c            move.l     #$0002567C,(a7)
[000004f0] 4eb9 0000 310e            jsr        _p0error
[000004f6] 60ae                      bra.s      _dodef_13
_dodef_17:
[000004f8] 2e0c                      move.l     a4,d7
[000004fa] 6700 01da                 beq        _dodef_20
[000004fe] 4297                      clr.l      (a7)
[00000500] 2f0c                      move.l     a4,-(a7)
[00000502] 4eb9 0000 2b20            jsr        _fretlist
[00000508] 588f                      addq.l     #4,a7
[0000050a] 6000 01ca                 bra        _dodef_20
_dodef_18:
[0000050e] 42ae ffe2                 clr.l      -30(a6)
_dodef_19:
[00000512] 0cac 0000 0003 0004       cmpi.l     #$00000003,4(a4)
[0000051a] 663c                      bne.s      _dodef_21
[0000051c] 246e 0008                 movea.l    8(a6),a2
[00000520] 2652                      movea.l    (a2),a3
[00000522] 426e fff6                 clr.w      -10(a6)
_dodef_29:
[00000526] 3e2e fff6                 move.w     -10(a6),d7
[0000052a] 48c7                      ext.l      d7
[0000052c] 3c2e fff4                 move.w     -12(a6),d6
[00000530] 48c6                      ext.l      d6
[00000532] be86                      cmp.l      d6,d7
[00000534] 6c22                      bge.s      _dodef_21
[00000536] 2e2c 0014                 move.l     20(a4),d7
[0000053a] beab 0014                 cmp.l      20(a3),d7
[0000053e] 6676                      bne.s      _dodef_22
[00000540] 2eab 0014                 move.l     20(a3),(a7)
[00000544] 2f2b 0010                 move.l     16(a3),-(a7)
[00000548] 2f2c 0010                 move.l     16(a4),-(a7)
[0000054c] 4eb9 0000 4cde            jsr        _cmpbuf
[00000552] 508f                      addq.l     #8,a7
[00000554] 4a87                      tst.l      d7
[00000556] 675e                      beq.s      _dodef_22
_dodef_21:
[00000558] 0cac 0000 0003 0004       cmpi.l     #$00000003,4(a4)
[00000560] 6600 0084                 bne        _dodef_23
[00000564] 3e2e fff6                 move.w     -10(a6),d7
[00000568] 48c7                      ext.l      d7
[0000056a] 3c2e fff4                 move.w     -12(a6),d6
[0000056e] 48c6                      ext.l      d6
[00000570] be86                      cmp.l      d6,d7
[00000572] 6c72                      bge.s      _dodef_23
[00000574] 4a6e fff2                 tst.w      -14(a6)
[00000578] 6716                      beq.s      _dodef_24
[0000057a] 3e2e fff4                 move.w     -12(a6),d7
[0000057e] 48c7                      ext.l      d7
[00000580] 5387                      subq.l     #1,d7
[00000582] 3c2e fff6                 move.w     -10(a6),d6
[00000586] 48c6                      ext.l      d6
[00000588] be86                      cmp.l      d6,d7
[0000058a] 6604                      bne.s      _dodef_24
[0000058c] 7e01                      moveq.l    #1,d7
[0000058e] 6002                      bra.s      _dodef_25
_dodef_24:
[00000590] 4287                      clr.l      d7
_dodef_25:
[00000592] 2d47 fff8                 move.l     d7,-8(a6)
[00000596] 2d6e 0010 fffc            move.l     16(a6),-4(a6)
_dodef_27:
[0000059c] 4a6e fff6                 tst.w      -10(a6)
[000005a0] 6f4e                      ble.s      _dodef_26
[000005a2] 4aae fffc                 tst.l      -4(a6)
[000005a6] 6748                      beq.s      _dodef_26
[000005a8] 246e fffc                 movea.l    -4(a6),a2
[000005ac] 2d52 fffc                 move.l     (a2),-4(a6)
[000005b0] 536e fff6                 subq.w     #1,-10(a6)
[000005b4] 60e6                      bra.s      _dodef_27
_dodef_22:
[000005b6] 45f8 0014                 lea.l      ($00000014).w,a2
[000005ba] d5d3                      adda.l     (a3),a2
[000005bc] 0c92 0000 0001            cmpi.l     #$00000001,(a2)
[000005c2] 6616                      bne.s      _dodef_28
[000005c4] 45f8 0010                 lea.l      ($00000010).w,a2
[000005c8] d5d3                      adda.l     (a3),a2
[000005ca] 2452                      movea.l    (a2),a2
[000005cc] 4287                      clr.l      d7
[000005ce] 1e12                      move.b     (a2),d7
[000005d0] 0c47 0023                 cmpi.w     #$0023,d7
[000005d4] 6604                      bne.s      _dodef_28
[000005d6] 2653                      movea.l    (a3),a3
[000005d8] 60dc                      bra.s      _dodef_22
_dodef_28:
[000005da] 2453                      movea.l    (a3),a2
[000005dc] 2652                      movea.l    (a2),a3
[000005de] 526e fff6                 addq.w     #1,-10(a6)
[000005e2] 6000 ff42                 bra        _dodef_29
_dodef_23:
[000005e6] 2a8c                      move.l     a4,(a5)
[000005e8] 2a55                      movea.l    (a5),a5
[000005ea] 2854                      movea.l    (a4),a4
[000005ec] 6000 febc                 bra        _dodef_30
_dodef_26:
[000005f0] 4aae fffc                 tst.l      -4(a6)
[000005f4] 6732                      beq.s      _dodef_31
[000005f6] 4aae fff8                 tst.l      -8(a6)
[000005fa] 6748                      beq.s      _dodef_32
[000005fc] 2e2e fffc                 move.l     -4(a6),d7
[00000600] beae 0010                 cmp.l      16(a6),d7
[00000604] 673e                      beq.s      _dodef_32
[00000606] 4297                      clr.l      (a7)
[00000608] 2f3c 0002 00c4            move.l     #$00025614,-(a7)
[0000060e] 4eb9 0000 2a88            jsr        _buytl
[00000614] 588f                      addq.l     #4,a7
[00000616] 2a87                      move.l     d7,(a5)
[00000618] 4aae ffe2                 tst.l      -30(a6)
[0000061c] 6768                      beq.s      _dodef_33
[0000061e] 2455                      movea.l    (a5),a2
[00000620] 588a                      addq.l     #4,a2
[00000622] 7008                      moveq.l    #8,d0
[00000624] 2480                      move.l     d0,(a2)
[00000626] 605e                      bra.s      _dodef_33
_dodef_31:
[00000628] 2e94                      move.l     (a4),(a7)
[0000062a] 2f0c                      move.l     a4,-(a7)
[0000062c] 4eb9 0000 2b20            jsr        _fretlist
[00000632] 588f                      addq.l     #4,a7
[00000634] 2847                      movea.l    d7,a4
[00000636] 6000 fe72                 bra        _dodef_30
_dodef_36:
[0000063a] 246e fffc                 movea.l    -4(a6),a2
[0000063e] 2d52 fffc                 move.l     (a2),-4(a6)
[00000642] 60ac                      bra.s      _dodef_26
_dodef_32:
[00000644] 246e fffc                 movea.l    -4(a6),a2
[00000648] 588a                      addq.l     #4,a2
[0000064a] 2d52 ffea                 move.l     (a2),-22(a6)
_dodef_40:
[0000064e] 246e fffc                 movea.l    -4(a6),a2
[00000652] 508a                      addq.l     #8,a2
[00000654] 2e12                      move.l     (a2),d7
[00000656] beae ffea                 cmp.l      -22(a6),d7
[0000065a] 672e                      beq.s      _dodef_34
[0000065c] 2e94                      move.l     (a4),(a7)
[0000065e] 2f2e ffea                 move.l     -22(a6),-(a7)
[00000662] 4eb9 0000 2a88            jsr        _buytl
[00000668] 588f                      addq.l     #4,a7
[0000066a] 2a87                      move.l     d7,(a5)
[0000066c] 4aae ffe2                 tst.l      -30(a6)
[00000670] 6720                      beq.s      _dodef_35
[00000672] 2455                      movea.l    (a5),a2
[00000674] 588a                      addq.l     #4,a2
[00000676] 7008                      moveq.l    #8,d0
[00000678] 2480                      move.l     d0,(a2)
[0000067a] 45f8 0014                 lea.l      ($00000014).w,a2
[0000067e] d5ee ffe2                 adda.l     -30(a6),a2
[00000682] 4292                      clr.l      (a2)
[00000684] 600c                      bra.s      _dodef_35
_dodef_33:
[00000686] 2a55                      movea.l    (a5),a5
[00000688] 60ba                      bra.s      _dodef_32
_dodef_34:
[0000068a] 4aae fff8                 tst.l      -8(a6)
[0000068e] 66aa                      bne.s      _dodef_36
[00000690] 6096                      bra.s      _dodef_31
_dodef_35:
[00000692] 246e fffc                 movea.l    -4(a6),a2
[00000696] 588a                      addq.l     #4,a2
[00000698] 2e12                      move.l     (a2),d7
[0000069a] beae ffea                 cmp.l      -22(a6),d7
[0000069e] 6628                      bne.s      _dodef_37
[000006a0] 2455                      movea.l    (a5),a2
[000006a2] 508a                      addq.l     #8,a2
[000006a4] 24ac 0008                 move.l     8(a4),(a2)
[000006a8] 45f8 000c                 lea.l      ($0000000C).w,a2
[000006ac] d5d5                      adda.l     (a5),a2
[000006ae] 2e8a                      move.l     a2,(a7)
[000006b0] 4aae ffe2                 tst.l      -30(a6)
[000006b4] 670a                      beq.s      _dodef_38
[000006b6] 4aae fff8                 tst.l      -8(a6)
[000006ba] 6604                      bne.s      _dodef_38
[000006bc] 4287                      clr.l      d7
[000006be] 6004                      bra.s      _dodef_39
_dodef_38:
[000006c0] 2e2c 000c                 move.l     12(a4),d7
_dodef_39:
[000006c4] 2257                      movea.l    (a7),a1
[000006c6] 2287                      move.l     d7,(a1)
_dodef_37:
[000006c8] 2a55                      movea.l    (a5),a5
[000006ca] 246e ffea                 movea.l    -22(a6),a2
[000006ce] 2d52 ffea                 move.l     (a2),-22(a6)
[000006d2] 6000 ff7a                 bra        _dodef_40
_dodef_20:
[000006d6] 2e2e 0008                 move.l     8(a6),d7
[000006da] beae ffee                 cmp.l      -18(a6),d7
[000006de] 6718                      beq.s      _dodef_41
[000006e0] 246e 0008                 movea.l    8(a6),a2
[000006e4] 2e92                      move.l     (a2),(a7)
[000006e6] 2f2e 0008                 move.l     8(a6),-(a7)
[000006ea] 4eb9 0000 2b20            jsr        _fretlist
[000006f0] 588f                      addq.l     #4,a7
[000006f2] 2d47 0008                 move.l     d7,8(a6)
[000006f6] 60de                      bra.s      _dodef_20
_dodef_41:
[000006f8] 2aae 000c                 move.l     12(a6),(a5)
[000006fc] 2e2e ffe6                 move.l     -26(a6),d7
[00000700] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00000704] 4e5e                      unlk       a6
[00000706] 4e75                      rts

_doexp:
[00000708] 4e56 fff0                 link       a6,#-16
[0000070c] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00000710] 45ee 0008                 lea.l      8(a6),a2
[00000714] 264a                      movea.l    a2,a3
_doexp_3:
[00000716] 2853                      movea.l    (a3),a4
[00000718] b9ee 000c                 cmpa.l     12(a6),a4
[0000071c] 670e                      beq.s      _doexp_1
[0000071e] 0cac 0000 0003 0004       cmpi.l     #$00000003,4(a4)
[00000726] 6710                      beq.s      _doexp_2
[00000728] 264c                      movea.l    a4,a3
[0000072a] 60ea                      bra.s      _doexp_3
_doexp_1:
[0000072c] 2e2e 0008                 move.l     8(a6),d7
[00000730] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00000734] 4e5e                      unlk       a6
[00000736] 4e75                      rts
_doexp_2:
[00000738] 486e fff8                 pea.l      -8(a6)
[0000073c] 2f2c 0014                 move.l     20(a4),-(a7)
[00000740] 2f2c 0010                 move.l     16(a4),-(a7)
[00000744] 4eb9 0000 2e8a            jsr        _lookup
[0000074a] 4fef 000c                 lea.l      12(a7),a7
[0000074e] 2d47 fff4                 move.l     d7,-12(a6)
[00000752] 672e                      beq.s      _doexp_4
[00000754] 246e fff4                 movea.l    -12(a6),a2
[00000758] 4287                      clr.l      d7
[0000075a] 1e12                      move.b     (a2),d7
[0000075c] 0c47 0028                 cmpi.w     #$0028,d7
[00000760] 6630                      bne.s      _doexp_5
[00000762] 45f8 0014                 lea.l      ($00000014).w,a2
[00000766] d5d4                      adda.l     (a4),a2
[00000768] 0c92 0000 0001            cmpi.l     #$00000001,(a2)
[0000076e] 6612                      bne.s      _doexp_4
[00000770] 45f8 0010                 lea.l      ($00000010).w,a2
[00000774] d5d4                      adda.l     (a4),a2
[00000776] 2452                      movea.l    (a2),a2
[00000778] 4287                      clr.l      d7
[0000077a] 1e12                      move.b     (a2),d7
[0000077c] 0c47 0028                 cmpi.w     #$0028,d7
[00000780] 6710                      beq.s      _doexp_5
_doexp_4:
[00000782] 2e8c                      move.l     a4,(a7)
[00000784] 2f0b                      move.l     a3,-(a7)
[00000786] 4eba f93e                 jsr        _builtin(pc)
[0000078a] 588f                      addq.l     #4,a7
[0000078c] 2847                      movea.l    d7,a4
[0000078e] 264c                      movea.l    a4,a3
[00000790] 6084                      bra.s      _doexp_3
_doexp_5:
[00000792] 4297                      clr.l      (a7)
[00000794] 2f2e fff4                 move.l     -12(a6),-(a7)
[00000798] 4eb9 0000 340e            jsr        _stotl
[0000079e] 588f                      addq.l     #4,a7
[000007a0] 2a47                      movea.l    d7,a5
[000007a2] 42ae fffc                 clr.l      -4(a6)
[000007a6] 246e fff4                 movea.l    -12(a6),a2
[000007aa] 4287                      clr.l      d7
[000007ac] 1e12                      move.b     (a2),d7
[000007ae] 0c47 0028                 cmpi.w     #$0028,d7
[000007b2] 6616                      bne.s      _doexp_6
[000007b4] 4297                      clr.l      (a7)
[000007b6] 486e fffc                 pea.l      -4(a6)
[000007ba] 2f14                      move.l     (a4),-(a7)
[000007bc] 4eb9 0000 08f6            jsr        _getargs
[000007c2] 508f                      addq.l     #8,a7
[000007c4] 2d47 fff0                 move.l     d7,-16(a6)
[000007c8] 6004                      bra.s      _doexp_7
_doexp_6:
[000007ca] 2d54 fff0                 move.l     (a4),-16(a6)
_doexp_7:
[000007ce] 45f8 000c                 lea.l      ($0000000C).w,a2
[000007d2] d5ee fff8                 adda.l     -8(a6),a2
[000007d6] 7001                      moveq.l    #1,d0
[000007d8] 2480                      move.l     d0,(a2)
[000007da] 2eae fffc                 move.l     -4(a6),(a7)
[000007de] 2f2e fff0                 move.l     -16(a6),-(a7)
[000007e2] 2f0d                      move.l     a5,-(a7)
[000007e4] 4eba fb5c                 jsr        _dodef(pc)
[000007e8] 508f                      addq.l     #8,a7
[000007ea] 2687                      move.l     d7,(a3)
[000007ec] 2e13                      move.l     (a3),d7
[000007ee] beae fff0                 cmp.l      -16(a6),d7
[000007f2] 6712                      beq.s      _doexp_8
[000007f4] 2453                      movea.l    (a3),a2
[000007f6] 508a                      addq.l     #8,a2
[000007f8] 24ac 0008                 move.l     8(a4),(a2)
[000007fc] 45f8 000c                 lea.l      ($0000000C).w,a2
[00000800] d5d3                      adda.l     (a3),a2
[00000802] 24ac 000c                 move.l     12(a4),(a2)
_doexp_8:
[00000806] 4297                      clr.l      (a7)
[00000808] 2f2e fffc                 move.l     -4(a6),-(a7)
[0000080c] 4eb9 0000 38f2            jsr        _frelst
[00000812] 588f                      addq.l     #4,a7
[00000814] 2eae fff0                 move.l     -16(a6),(a7)
[00000818] 2f0c                      move.l     a4,-(a7)
[0000081a] 4eb9 0000 2b20            jsr        _fretlist
[00000820] 588f                      addq.l     #4,a7
[00000822] 2eae fff0                 move.l     -16(a6),(a7)
[00000826] 2f13                      move.l     (a3),-(a7)
[00000828] 4eba fede                 jsr        _doexp(pc)
[0000082c] 588f                      addq.l     #4,a7
[0000082e] 2687                      move.l     d7,(a3)
_doexp_10:
[00000830] 2e13                      move.l     (a3),d7
[00000832] beae fff0                 cmp.l      -16(a6),d7
[00000836] 6704                      beq.s      _doexp_9
[00000838] 2653                      movea.l    (a3),a3
[0000083a] 60f4                      bra.s      _doexp_10
_doexp_9:
[0000083c] 45f8 000c                 lea.l      ($0000000C).w,a2
[00000840] d5ee fff8                 adda.l     -8(a6),a2
[00000844] 4292                      clr.l      (a2)
[00000846] 6000 fece                 bra        _doexp_3

_doif:
[0000084a] 4e56 fff8                 link       a6,#-8
[0000084e] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00000852] 45ee fff8                 lea.l      -8(a6),a2
[00000856] 264a                      movea.l    a2,a3
[00000858] 4aae 000c                 tst.l      12(a6)
[0000085c] 660e                      bne.s      _doif_1
[0000085e] 2ebc 0002 0182            move.l     #$000256D2,(a7)
[00000864] 4eb9 0000 310e            jsr        _p0error
[0000086a] 602a                      bra.s      _doif_2
_doif_1:
[0000086c] 486e fffc                 pea.l      -4(a6)
[00000870] 246e 000c                 movea.l    12(a6),a2
[00000874] 588a                      addq.l     #4,a2
[00000876] 2f12                      move.l     (a2),-(a7)
[00000878] 4eb9 0000 0e16            jsr        _expr
[0000087e] 508f                      addq.l     #8,a7
[00000880] 246e 000c                 movea.l    12(a6),a2
[00000884] 508a                      addq.l     #8,a2
[00000886] be92                      cmp.l      (a2),d7
[00000888] 671c                      beq.s      _doif_3
[0000088a] 2ebc 0002 0174            move.l     #$000256C4,(a7)
[00000890] 4eb9 0000 310e            jsr        _p0error
_doif_2:
[00000896] 26ae 0008                 move.l     8(a6),(a3)
[0000089a] 2e2e fff8                 move.l     -8(a6),d7
[0000089e] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000008a2] 4e5e                      unlk       a6
[000008a4] 4e75                      rts
_doif_3:
[000008a6] 4aae fffc                 tst.l      -4(a6)
[000008aa] 67ea                      beq.s      _doif_2
[000008ac] 246e 000c                 movea.l    12(a6),a2
[000008b0] 2a52                      movea.l    (a2),a5
_doif_6:
[000008b2] 2e0d                      move.l     a5,d7
[000008b4] 67e0                      beq.s      _doif_2
[000008b6] 286d 0004                 movea.l    4(a5),a4
_doif_5:
[000008ba] b9ed 0008                 cmpa.l     8(a5),a4
[000008be] 671a                      beq.s      _doif_4
[000008c0] 2eae 0008                 move.l     8(a6),(a7)
[000008c4] 2f0c                      move.l     a4,-(a7)
[000008c6] 4eb9 0000 2a88            jsr        _buytl
[000008cc] 588f                      addq.l     #4,a7
[000008ce] 2687                      move.l     d7,(a3)
[000008d0] 2653                      movea.l    (a3),a3
[000008d2] 2854                      movea.l    (a4),a4
[000008d4] 60e4                      bra.s      _doif_5
_doif_7:
[000008d6] 2a55                      movea.l    (a5),a5
[000008d8] 60d8                      bra.s      _doif_6
_doif_4:
[000008da] 4a95                      tst.l      (a5)
[000008dc] 67f8                      beq.s      _doif_7
[000008de] 2eae 0008                 move.l     8(a6),(a7)
[000008e2] 2f3c 0002 00c4            move.l     #$00025614,-(a7)
[000008e8] 4eb9 0000 2a88            jsr        _buytl
[000008ee] 588f                      addq.l     #4,a7
[000008f0] 2687                      move.l     d7,(a3)
[000008f2] 2653                      movea.l    (a3),a3
[000008f4] 60e0                      bra.s      _doif_7

_getargs:
[000008f6] 4e56 fff6                 link       a6,#-10
[000008fa] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[000008fe] 266e 0008                 movea.l    8(a6),a3
[00000902] 2d4b fff6                 move.l     a3,-10(a6)
[00000906] 2a6e 000c                 movea.l    12(a6),a5
[0000090a] 2653                      movea.l    (a3),a3
_getargs_7:
[0000090c] 2e0b                      move.l     a3,d7
[0000090e] 6718                      beq.s      _getargs_1
[00000910] 0cab 0000 0001 0014       cmpi.l     #$00000001,20(a3)
[00000918] 661e                      bne.s      _getargs_2
[0000091a] 246b 0010                 movea.l    16(a3),a2
[0000091e] 4287                      clr.l      d7
[00000920] 1e12                      move.b     (a2),d7
[00000922] 0c47 0029                 cmpi.w     #$0029,d7
[00000926] 6610                      bne.s      _getargs_2
_getargs_1:
[00000928] 2e0b                      move.l     a3,d7
[0000092a] 6700 012a                 beq        _getargs_3
[0000092e] 2e13                      move.l     (a3),d7
[00000930] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00000934] 4e5e                      unlk       a6
[00000936] 4e75                      rts
_getargs_2:
[00000938] 4297                      clr.l      (a7)
[0000093a] 4878 000c                 pea.l      ($0000000C).w
[0000093e] 4eb9 0000 486e            jsr        _alloc
[00000944] 588f                      addq.l     #4,a7
[00000946] 2847                      movea.l    d7,a4
[00000948] 2a8c                      move.l     a4,(a5)
[0000094a] 294b 0004                 move.l     a3,4(a4)
[0000094e] 2d6e fff6 fffa            move.l     -10(a6),-6(a6)
[00000954] 426e fffe                 clr.w      -2(a6)
_getargs_10:
[00000958] 2e0b                      move.l     a3,d7
[0000095a] 6724                      beq.s      _getargs_4
[0000095c] 4a6e fffe                 tst.w      -2(a6)
[00000960] 6e3c                      bgt.s      _getargs_5
[00000962] 0cab 0000 0001 0014       cmpi.l     #$00000001,20(a3)
[0000096a] 661a                      bne.s      _getargs_6
[0000096c] 246b 0010                 movea.l    16(a3),a2
[00000970] 4287                      clr.l      d7
[00000972] 1e12                      move.b     (a2),d7
[00000974] 0c47 002c                 cmpi.w     #$002C,d7
[00000978] 6706                      beq.s      _getargs_4
[0000097a] 600a                      bra.s      _getargs_6
_getargs_15:
[0000097c] 2a4c                      movea.l    a4,a5
[0000097e] 608c                      bra.s      _getargs_7
_getargs_4:
[00000980] 2e0b                      move.l     a3,d7
[00000982] 667a                      bne.s      _getargs_8
[00000984] 60a2                      bra.s      _getargs_1
_getargs_6:
[00000986] 0cab 0000 0001 0014       cmpi.l     #$00000001,20(a3)
[0000098e] 660e                      bne.s      _getargs_5
[00000990] 246b 0010                 movea.l    16(a3),a2
[00000994] 4287                      clr.l      d7
[00000996] 1e12                      move.b     (a2),d7
[00000998] 0c47 0029                 cmpi.w     #$0029,d7
[0000099c] 67e2                      beq.s      _getargs_4
_getargs_5:
[0000099e] 0cab 0000 0001 0014       cmpi.l     #$00000001,20(a3)
[000009a6] 6616                      bne.s      _getargs_9
[000009a8] 246b 0010                 movea.l    16(a3),a2
[000009ac] 4287                      clr.l      d7
[000009ae] 1e12                      move.b     (a2),d7
[000009b0] 0c47 0028                 cmpi.w     #$0028,d7
[000009b4] 6608                      bne.s      _getargs_9
[000009b6] 526e fffe                 addq.w     #1,-2(a6)
_getargs_12:
[000009ba] 2653                      movea.l    (a3),a3
[000009bc] 609a                      bra.s      _getargs_10
_getargs_9:
[000009be] 0cab 0000 0001 0014       cmpi.l     #$00000001,20(a3)
[000009c6] 6614                      bne.s      _getargs_11
[000009c8] 246b 0010                 movea.l    16(a3),a2
[000009cc] 4287                      clr.l      d7
[000009ce] 1e12                      move.b     (a2),d7
[000009d0] 0c47 0029                 cmpi.w     #$0029,d7
[000009d4] 6606                      bne.s      _getargs_11
[000009d6] 536e fffe                 subq.w     #1,-2(a6)
[000009da] 60de                      bra.s      _getargs_12
_getargs_11:
[000009dc] 0cab 0000 0002 0004       cmpi.l     #$00000002,4(a3)
[000009e4] 66d4                      bne.s      _getargs_12
[000009e6] 4878 0001                 pea.l      ($00000001).w
[000009ea] 4eb9 0000 1d30            jsr        _getex
[000009f0] 588f                      addq.l     #4,a7
[000009f2] be93                      cmp.l      (a3),d7
[000009f4] 66c4                      bne.s      _getargs_12
[000009f6] 7007                      moveq.l    #7,d0
[000009f8] 2740 0004                 move.l     d0,4(a3)
[000009fc] 60bc                      bra.s      _getargs_12
_getargs_8:
[000009fe] 294b 0008                 move.l     a3,8(a4)
[00000a02] 0cab 0000 0001 0014       cmpi.l     #$00000001,20(a3)
[00000a0a] 6614                      bne.s      _getargs_13
[00000a0c] 246b 0010                 movea.l    16(a3),a2
[00000a10] 4287                      clr.l      d7
[00000a12] 1e12                      move.b     (a2),d7
[00000a14] 0c47 002c                 cmpi.w     #$002C,d7
[00000a18] 6606                      bne.s      _getargs_13
[00000a1a] 2d4b fff6                 move.l     a3,-10(a6)
[00000a1e] 2653                      movea.l    (a3),a3
_getargs_13:
[00000a20] 4aae 0010                 tst.l      16(a6)
[00000a24] 6706                      beq.s      _getargs_14
[00000a26] 5279 0002 0a3a            addq.w     #1,$00025F8A
_getargs_14:
[00000a2c] 2eac 0008                 move.l     8(a4),(a7)
[00000a30] 2f2e fffa                 move.l     -6(a6),-(a7)
[00000a34] 4eba fcd2                 jsr        _doexp(pc)
[00000a38] 588f                      addq.l     #4,a7
[00000a3a] 2447                      movea.l    d7,a2
[00000a3c] 2952 0004                 move.l     (a2),4(a4)
[00000a40] 4aae 0010                 tst.l      16(a6)
[00000a44] 6700 ff36                 beq        _getargs_15
[00000a48] 5379 0002 0a3a            subq.w     #1,$00025F8A
[00000a4e] 42ae 0010                 clr.l      16(a6)
[00000a52] 6000 ff28                 bra        _getargs_15
_getargs_3:
[00000a56] 2ebc 0002 0198            move.l     #$000256E8,(a7)
[00000a5c] 4eb9 0000 310e            jsr        _p0error
[00000a62] 246e 000c                 movea.l    12(a6),a2
[00000a66] 4292                      clr.l      (a2)
[00000a68] 2e2e 0008                 move.l     8(a6),d7
[00000a6c] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00000a70] 4e5e                      unlk       a6
[00000a72] 4e75                      rts

_undef:
[00000a74] 4e56 0000                 link       a6,#0
[00000a78] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00000a7c] 2a6e 0008                 movea.l    8(a6),a5
[00000a80] 0cae 0000 007f 000c       cmpi.l     #$0000007F,12(a6)
[00000a88] 6406                      bcc.s      _undef_1
[00000a8a] 2e2e 000c                 move.l     12(a6),d7
[00000a8e] 6002                      bra.s      _undef_2
_undef_1:
[00000a90] 7e7f                      moveq.l    #127,d7
_undef_2:
[00000a92] 2d47 000c                 move.l     d7,12(a6)
[00000a96] 2eae 000c                 move.l     12(a6),(a7)
[00000a9a] 2f0d                      move.l     a5,-(a7)
[00000a9c] 4eb9 0000 2dda            jsr        _hash
[00000aa2] 588f                      addq.l     #4,a7
[00000aa4] 2847                      movea.l    d7,a4
_undef_6:
[00000aa6] 2654                      movea.l    (a4),a3
[00000aa8] 2e0b                      move.l     a3,d7
[00000aaa] 6720                      beq.s      _undef_3
[00000aac] 2e2e 000c                 move.l     12(a6),d7
[00000ab0] beab 0008                 cmp.l      8(a3),d7
[00000ab4] 6638                      bne.s      _undef_4
[00000ab6] 2eae 000c                 move.l     12(a6),(a7)
[00000aba] 486b 0010                 pea.l      16(a3)
[00000abe] 2f0d                      move.l     a5,-(a7)
[00000ac0] 4eb9 0000 4cde            jsr        _cmpbuf
[00000ac6] 508f                      addq.l     #8,a7
[00000ac8] 4a87                      tst.l      d7
[00000aca] 6722                      beq.s      _undef_4
_undef_3:
[00000acc] 2e0b                      move.l     a3,d7
[00000ace] 6722                      beq.s      _undef_5
[00000ad0] 4297                      clr.l      (a7)
[00000ad2] 2f2b 0004                 move.l     4(a3),-(a7)
[00000ad6] 4eb9 0000 49de            jsr        _free
[00000adc] 588f                      addq.l     #4,a7
[00000ade] 2e93                      move.l     (a3),(a7)
[00000ae0] 2f0b                      move.l     a3,-(a7)
[00000ae2] 4eb9 0000 49de            jsr        _free
[00000ae8] 588f                      addq.l     #4,a7
[00000aea] 2887                      move.l     d7,(a4)
[00000aec] 6004                      bra.s      _undef_5
_undef_4:
[00000aee] 284b                      movea.l    a3,a4
[00000af0] 60b4                      bra.s      _undef_6
_undef_5:
[00000af2] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00000af6] 4e5e                      unlk       a6
[00000af8] 4e75                      rts

_dobesc:
[00000afa] 4e56 fff2                 link       a6,#-14
[00000afe] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00000b02] 2a6e 0008                 movea.l    8(a6),a5
[00000b06] 286e 000c                 movea.l    12(a6),a4
[00000b0a] 0cae 0000 0002 0010       cmpi.l     #$00000002,16(a6)
[00000b12] 6404                      bcc.s      _dobesc_1
[00000b14] 7e02                      moveq.l    #2,d7
[00000b16] 6004                      bra.s      _dobesc_2
_dobesc_1:
[00000b18] 2e2e 0010                 move.l     16(a6),d7
_dobesc_2:
[00000b1c] de8c                      add.l      a4,d7
[00000b1e] 2d47 fffc                 move.l     d7,-4(a6)
[00000b22] 70fe                      moveq.l    #-2,d0
[00000b24] 2d40 fff8                 move.l     d0,-8(a6)
_dobesc_6:
[00000b28] b9ee fffc                 cmpa.l     -4(a6),a4
[00000b2c] 6416                      bcc.s      _dobesc_3
[00000b2e] 4287                      clr.l      d7
[00000b30] 1e14                      move.b     (a4),d7
[00000b32] 0c47 005c                 cmpi.w     #$005C,d7
[00000b36] 6618                      bne.s      _dobesc_4
[00000b38] 45ec 0001                 lea.l      1(a4),a2
[00000b3c] b5ee fffc                 cmpa.l     -4(a6),a2
[00000b40] 6630                      bne.s      _dobesc_5
[00000b42] 600c                      bra.s      _dobesc_4
_dobesc_3:
[00000b44] 2e2e fff8                 move.l     -8(a6),d7
[00000b48] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00000b4c] 4e5e                      unlk       a6
[00000b4e] 4e75                      rts
_dobesc_4:
[00000b50] 4287                      clr.l      d7
[00000b52] 1e14                      move.b     (a4),d7
[00000b54] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000b5a] 2447                      movea.l    d7,a2
[00000b5c] d5fc 0002 04e6            adda.l     #$00025A36,a2
[00000b62] 1d52 fff3                 move.b     (a2),-13(a6)
_dobesc_8:
[00000b66] 1aee fff3                 move.b     -13(a6),(a5)+
[00000b6a] 52ae fff8                 addq.l     #1,-8(a6)
[00000b6e] 528c                      addq.l     #1,a4
[00000b70] 60b6                      bra.s      _dobesc_6
_dobesc_5:
[00000b72] 528c                      addq.l     #1,a4
[00000b74] 4287                      clr.l      d7
[00000b76] 1e14                      move.b     (a4),d7
[00000b78] 2e87                      move.l     d7,(a7)
[00000b7a] 2f3c 0002 0614            move.l     #$00025B64,-(a7)
[00000b80] 4eb9 0000 4732            jsr        _scnstr
[00000b86] 588f                      addq.l     #4,a7
[00000b88] 1d47 fff3                 move.b     d7,-13(a6)
[00000b8c] 4287                      clr.l      d7
[00000b8e] 1e2e fff3                 move.b     -13(a6),d7
[00000b92] 2447                      movea.l    d7,a2
[00000b94] d5fc 0002 0614            adda.l     #$00025B64,a2
[00000b9a] 4a12                      tst.b      (a2)
[00000b9c] 6726                      beq.s      _dobesc_7
[00000b9e] 247c 0002 0620            movea.l    #$00025B70,a2
[00000ba4] 4287                      clr.l      d7
[00000ba6] 1e2e fff3                 move.b     -13(a6),d7
[00000baa] d5c7                      adda.l     d7,a2
[00000bac] 4287                      clr.l      d7
[00000bae] 1e12                      move.b     (a2),d7
[00000bb0] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000bb6] 2447                      movea.l    d7,a2
[00000bb8] d5fc 0002 04e6            adda.l     #$00025A36,a2
[00000bbe] 1d52 fff3                 move.b     (a2),-13(a6)
[00000bc2] 60a2                      bra.s      _dobesc_8
_dobesc_7:
[00000bc4] 4287                      clr.l      d7
[00000bc6] 1e14                      move.b     (a4),d7
[00000bc8] 0c47 0078                 cmpi.w     #$0078,d7
[00000bcc] 665c                      bne.s      _dobesc_9
[00000bce] 422e fff3                 clr.b      -13(a6)
[00000bd2] 4285                      clr.l      d5
_dobesc_11:
[00000bd4] 0c85 0000 0003            cmpi.l     #$00000003,d5
[00000bda] 6c8a                      bge.s      _dobesc_8
[00000bdc] 528c                      addq.l     #1,a4
[00000bde] b9ee fffc                 cmpa.l     -4(a6),a4
[00000be2] 6482                      bcc.s      _dobesc_8
[00000be4] 4287                      clr.l      d7
[00000be6] 1e14                      move.b     (a4),d7
[00000be8] 2e87                      move.l     d7,(a7)
[00000bea] 2f3c 0002 05e6            move.l     #$00025B36,-(a7)
[00000bf0] 4eb9 0000 4732            jsr        _scnstr
[00000bf6] 588f                      addq.l     #4,a7
[00000bf8] 2d47 fff4                 move.l     d7,-12(a6)
[00000bfc] 246e fff4                 movea.l    -12(a6),a2
[00000c00] d5fc 0002 05e6            adda.l     #$00025B36,a2
[00000c06] 4a12                      tst.b      (a2)
[00000c08] 6772                      beq.s      _dobesc_10
[00000c0a] 4287                      clr.l      d7
[00000c0c] 1e2e fff3                 move.b     -13(a6),d7
[00000c10] e987                      asl.l      #4,d7
[00000c12] 247c 0002 05fd            movea.l    #$00025B4D,a2
[00000c18] d5ee fff4                 adda.l     -12(a6),a2
[00000c1c] 4286                      clr.l      d6
[00000c1e] 1c12                      move.b     (a2),d6
[00000c20] 8e86                      or.l       d6,d7
[00000c22] 1d47 fff3                 move.b     d7,-13(a6)
[00000c26] 5285                      addq.l     #1,d5
[00000c28] 60aa                      bra.s      _dobesc_11
_dobesc_9:
[00000c2a] 422e fff3                 clr.b      -13(a6)
[00000c2e] 4285                      clr.l      d5
[00000c30] 538c                      subq.l     #1,a4
_dobesc_13:
[00000c32] 0c85 0000 0003            cmpi.l     #$00000003,d5
[00000c38] 6c00 ff2c                 bge        _dobesc_8
[00000c3c] 528c                      addq.l     #1,a4
[00000c3e] b9ee fffc                 cmpa.l     -4(a6),a4
[00000c42] 6400 ff22                 bcc        _dobesc_8
[00000c46] 4287                      clr.l      d7
[00000c48] 1e14                      move.b     (a4),d7
[00000c4a] 2e87                      move.l     d7,(a7)
[00000c4c] 2f3c 0002 05e6            move.l     #$00025B36,-(a7)
[00000c52] 4eb9 0000 4732            jsr        _scnstr
[00000c58] 588f                      addq.l     #4,a7
[00000c5a] 2d47 fff4                 move.l     d7,-12(a6)
[00000c5e] 0cae 0000 0008 fff4       cmpi.l     #$00000008,-12(a6)
[00000c66] 641a                      bcc.s      _dobesc_12
[00000c68] 4287                      clr.l      d7
[00000c6a] 1e2e fff3                 move.b     -13(a6),d7
[00000c6e] e787                      asl.l      #3,d7
[00000c70] 8eae fff4                 or.l       -12(a6),d7
[00000c74] 1d47 fff3                 move.b     d7,-13(a6)
[00000c78] 5285                      addq.l     #1,d5
[00000c7a] 60b6                      bra.s      _dobesc_13
_dobesc_10:
[00000c7c] 538c                      subq.l     #1,a4
[00000c7e] 6000 fee6                 bra        _dobesc_8
_dobesc_12:
[00000c82] 4a85                      tst.l      d5
[00000c84] 661a                      bne.s      _dobesc_14
[00000c86] 4287                      clr.l      d7
[00000c88] 1e14                      move.b     (a4),d7
[00000c8a] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000c90] 2447                      movea.l    d7,a2
[00000c92] d5fc 0002 04e6            adda.l     #$00025A36,a2
[00000c98] 1d52 fff3                 move.b     (a2),-13(a6)
[00000c9c] 6000 fec8                 bra        _dobesc_8
_dobesc_14:
[00000ca0] 538c                      subq.l     #1,a4
[00000ca2] 6000 fec2                 bra        _dobesc_8

_dopunct:
[00000ca6] 4e56 fff8                 link       a6,#-8
[00000caa] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[00000cae] 246e 0008                 movea.l    8(a6),a2
[00000cb2] 2a52                      movea.l    (a2),a5
[00000cb4] 246d 0010                 movea.l    16(a5),a2
[00000cb8] 1d52 fffd                 move.b     (a2),-3(a6)
[00000cbc] 7a01                      moveq.l    #1,d5
[00000cbe] 2855                      movea.l    (a5),a4
_dopunct_2:
[00000cc0] 0c85 0000 0003            cmpi.l     #$00000003,d5
[00000cc6] 6c22                      bge.s      _dopunct_1
[00000cc8] 0cac 0000 0005 0004       cmpi.l     #$00000005,4(a4)
[00000cd0] 6618                      bne.s      _dopunct_1
[00000cd2] 4aac 000c                 tst.l      12(a4)
[00000cd6] 6612                      bne.s      _dopunct_1
[00000cd8] 45ee fffd                 lea.l      -3(a6),a2
[00000cdc] d5c5                      adda.l     d5,a2
[00000cde] 266c 0010                 movea.l    16(a4),a3
[00000ce2] 1493                      move.b     (a3),(a2)
[00000ce4] 5285                      addq.l     #1,d5
[00000ce6] 2854                      movea.l    (a4),a4
[00000ce8] 60d6                      bra.s      _dopunct_2
_dopunct_1:
[00000cea] 4a85                      tst.l      d5
[00000cec] 6f48                      ble.s      _dopunct_3
[00000cee] 2e85                      move.l     d5,(a7)
[00000cf0] 486e fffd                 pea.l      -3(a6)
[00000cf4] 4878 002e                 pea.l      ($0000002E).w
[00000cf8] 2f3c 0002 01d4            move.l     #$00025724,-(a7)
[00000cfe] 4eb9 0000 336e            jsr        _scntab
[00000d04] 4fef 000c                 lea.l      12(a7),a7
[00000d08] 2d47 fff8                 move.l     d7,-8(a6)
[00000d0c] 6628                      bne.s      _dopunct_3
[00000d0e] 4ab9 0002 0a2a            tst.l      $00025F7A
[00000d14] 664a                      bne.s      _dopunct_4
[00000d16] 2e85                      move.l     d5,(a7)
[00000d18] 486e fffd                 pea.l      -3(a6)
[00000d1c] 4878 0015                 pea.l      ($00000015).w
[00000d20] 2f3c 0002 03e8            move.l     #$00025938,-(a7)
[00000d26] 4eb9 0000 336e            jsr        _scntab
[00000d2c] 4fef 000c                 lea.l      12(a7),a7
[00000d30] 2d47 fff8                 move.l     d7,-8(a6)
[00000d34] 672a                      beq.s      _dopunct_4
_dopunct_3:
[00000d36] 4a85                      tst.l      d5
[00000d38] 6e2a                      bgt.s      _dopunct_5
[00000d3a] 246d 0010                 movea.l    16(a5),a2
[00000d3e] 4287                      clr.l      d7
[00000d40] 1e12                      move.b     (a2),d7
[00000d42] 2e87                      move.l     d7,(a7)
[00000d44] 2f3c 0002 062c            move.l     #$00025B7C,-(a7)
[00000d4a] 4eb9 0000 310e            jsr        _p0error
[00000d50] 588f                      addq.l     #4,a7
[00000d52] 246e 0008                 movea.l    8(a6),a2
[00000d56] 2495                      move.l     (a5),(a2)
[00000d58] 3e3c 00de                 move.w     #$00DE,d7
[00000d5c] 48c7                      ext.l      d7
[00000d5e] 6018                      bra.s      _dopunct_6
_dopunct_4:
[00000d60] 5385                      subq.l     #1,d5
[00000d62] 6086                      bra.s      _dopunct_1
_dopunct_5:
[00000d64] 4a85                      tst.l      d5
[00000d66] 6f06                      ble.s      _dopunct_7
[00000d68] 2a55                      movea.l    (a5),a5
[00000d6a] 5385                      subq.l     #1,d5
[00000d6c] 60f6                      bra.s      _dopunct_5
_dopunct_7:
[00000d6e] 246e 0008                 movea.l    8(a6),a2
[00000d72] 248d                      move.l     a5,(a2)
[00000d74] 2e2e fff8                 move.l     -8(a6),d7
_dopunct_6:
[00000d78] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[00000d7c] 4e5e                      unlk       a6
[00000d7e] 4e75                      rts

_eval:
[00000d80] 4e56 fffc                 link       a6,#-4
[00000d84] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000d88] 2a6e 0008                 movea.l    8(a6),a5
[00000d8c] 486e fffc                 pea.l      -4(a6)
[00000d90] 2f0d                      move.l     a5,-(a7)
[00000d92] 4eb9 0000 0e16            jsr        _expr
[00000d98] 508f                      addq.l     #8,a7
[00000d9a] 2a47                      movea.l    d7,a5
[00000d9c] 2e0d                      move.l     a5,d7
[00000d9e] 6604                      bne.s      _eval_1
[00000da0] 4287                      clr.l      d7
[00000da2] 6018                      bra.s      _eval_2
_eval_1:
[00000da4] 0cad 0000 0002 0004       cmpi.l     #$00000002,4(a5)
[00000dac] 6716                      beq.s      _eval_3
[00000dae] 2ebc 0002 0642            move.l     #$00025B92,(a7)
[00000db4] 4eb9 0000 310e            jsr        _p0error
[00000dba] 4287                      clr.l      d7
_eval_2:
[00000dbc] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000dc0] 4e5e                      unlk       a6
[00000dc2] 4e75                      rts
_eval_3:
[00000dc4] 4aae fffc                 tst.l      -4(a6)
[00000dc8] 6704                      beq.s      _eval_4
[00000dca] 7e01                      moveq.l    #1,d7
[00000dcc] 6002                      bra.s      _eval_5
_eval_4:
[00000dce] 4287                      clr.l      d7
_eval_5:
[00000dd0] 60ea                      bra.s      _eval_2

_exop:
[00000dd2] 4e56 fffc                 link       a6,#-4
[00000dd6] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00000dda] 2a6e 0008                 movea.l    8(a6),a5
[00000dde] 2d55 fffc                 move.l     (a5),-4(a6)
[00000de2] 246e fffc                 movea.l    -4(a6),a2
[00000de6] 588a                      addq.l     #4,a2
[00000de8] 0c92 0000 0005            cmpi.l     #$00000005,(a2)
[00000dee] 661c                      bne.s      _exop_1
[00000df0] 486e fffc                 pea.l      -4(a6)
[00000df4] 4eba feb0                 jsr        _dopunct(pc)
[00000df8] 588f                      addq.l     #4,a7
[00000dfa] 2a07                      move.l     d7,d5
[00000dfc] 2e05                      move.l     d5,d7
[00000dfe] ceae 000c                 and.l      12(a6),d7
[00000e02] 6708                      beq.s      _exop_1
[00000e04] 2aae fffc                 move.l     -4(a6),(a5)
[00000e08] 2e05                      move.l     d5,d7
[00000e0a] 6002                      bra.s      _exop_2
_exop_1:
[00000e0c] 4287                      clr.l      d7
_exop_2:
[00000e0e] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00000e12] 4e5e                      unlk       a6
[00000e14] 4e75                      rts

_expr:
[00000e16] 4e56 fff8                 link       a6,#-8
[00000e1a] 2eae 000c                 move.l     12(a6),(a7)
[00000e1e] 2f2e 0008                 move.l     8(a6),-(a7)
[00000e22] 4eb9 0000 1130            jsr        _exterm
[00000e28] 588f                      addq.l     #4,a7
[00000e2a] 2d47 0008                 move.l     d7,8(a6)
[00000e2e] 6606                      bne.s      _expr_1
[00000e30] 4287                      clr.l      d7
[00000e32] 4e5e                      unlk       a6
[00000e34] 4e75                      rts
_expr_1:
[00000e36] 2ebc 0000 0080            move.l     #$00000080,(a7)
[00000e3c] 486e 0008                 pea.l      8(a6)
[00000e40] 4eba ff90                 jsr        _exop(pc)
[00000e44] 588f                      addq.l     #4,a7
[00000e46] 2d47 fffc                 move.l     d7,-4(a6)
[00000e4a] 671c                      beq.s      _expr_2
[00000e4c] 2eae 0008                 move.l     8(a6),(a7)
[00000e50] 486e fffc                 pea.l      -4(a6)
[00000e54] 2f2e 000c                 move.l     12(a6),-(a7)
[00000e58] 42a7                      clr.l      -(a7)
[00000e5a] 4eb9 0000 0eb6            jsr        _extail
[00000e60] 4fef 000c                 lea.l      12(a7),a7
[00000e64] 4e5e                      unlk       a6
[00000e66] 4e75                      rts
_expr_2:
[00000e68] 2e2e 0008                 move.l     8(a6),d7
[00000e6c] 4e5e                      unlk       a6
[00000e6e] 4e75                      rts

_expri:
[00000e70] 4e56 0000                 link       a6,#0
[00000e74] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[00000e78] 2a2e 0008                 move.l     8(a6),d5
[00000e7c] 4a85                      tst.l      d5
[00000e7e] 671e                      beq.s      _expri_1
[00000e80] 2e85                      move.l     d5,(a7)
[00000e82] 2f3c 0002 01ac            move.l     #$000256FC,-(a7)
[00000e88] 4eb9 0000 4732            jsr        _scnstr
[00000e8e] 588f                      addq.l     #4,a7
[00000e90] 2807                      move.l     d7,d4
[00000e92] 2444                      movea.l    d4,a2
[00000e94] d5fc 0002 01ac            adda.l     #$000256FC,a2
[00000e9a] 4a12                      tst.b      (a2)
[00000e9c] 6604                      bne.s      _expri_2
_expri_1:
[00000e9e] 4287                      clr.l      d7
[00000ea0] 600c                      bra.s      _expri_3
_expri_2:
[00000ea2] 2444                      movea.l    d4,a2
[00000ea4] d5fc 0002 01c0            adda.l     #$00025710,a2
[00000eaa] 4287                      clr.l      d7
[00000eac] 1e12                      move.b     (a2),d7
_expri_3:
[00000eae] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[00000eb2] 4e5e                      unlk       a6
[00000eb4] 4e75                      rts

_extail:
[00000eb6] 4e56 fff0                 link       a6,#-16
[00000eba] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[00000ebe] 246e 0010                 movea.l    16(a6),a2
[00000ec2] 2d52 fff0                 move.l     (a2),-16(a6)
_extail_6:
[00000ec6] 2eae fff0                 move.l     -16(a6),(a7)
[00000eca] 4eba ffa4                 jsr        _expri(pc)
[00000ece] 2a07                      move.l     d7,d5
[00000ed0] 2e2e 0008                 move.l     8(a6),d7
[00000ed4] be85                      cmp.l      d5,d7
[00000ed6] 6c18                      bge.s      _extail_1
[00000ed8] 486e fff4                 pea.l      -12(a6)
[00000edc] 2f2e 0014                 move.l     20(a6),-(a7)
[00000ee0] 4eb9 0000 1130            jsr        _exterm
[00000ee6] 508f                      addq.l     #8,a7
[00000ee8] 2d47 0014                 move.l     d7,20(a6)
[00000eec] 6608                      bne.s      _extail_2
[00000eee] 6040                      bra.s      _extail_3
_extail_1:
[00000ef0] 2e2e 0014                 move.l     20(a6),d7
[00000ef4] 6042                      bra.s      _extail_4
_extail_2:
[00000ef6] 2ebc 0000 0080            move.l     #$00000080,(a7)
[00000efc] 486e 0014                 pea.l      20(a6)
[00000f00] 4eba fed0                 jsr        _exop(pc)
[00000f04] 588f                      addq.l     #4,a7
[00000f06] 2d47 fff0                 move.l     d7,-16(a6)
[00000f0a] 2eae fff0                 move.l     -16(a6),(a7)
[00000f0e] 4eba ff60                 jsr        _expri(pc)
[00000f12] ba87                      cmp.l      d7,d5
[00000f14] 6c1a                      bge.s      _extail_3
[00000f16] 2eae 0014                 move.l     20(a6),(a7)
[00000f1a] 486e fff0                 pea.l      -16(a6)
[00000f1e] 486e fff4                 pea.l      -12(a6)
[00000f22] 2f05                      move.l     d5,-(a7)
[00000f24] 4eba ff90                 jsr        _extail(pc)
[00000f28] 4fef 000c                 lea.l      12(a7),a7
[00000f2c] 2d47 0014                 move.l     d7,20(a6)
_extail_3:
[00000f30] 4aae 0014                 tst.l      20(a6)
[00000f34] 660a                      bne.s      _extail_5
[00000f36] 4287                      clr.l      d7
_extail_4:
[00000f38] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[00000f3c] 4e5e                      unlk       a6
[00000f3e] 4e75                      rts
_extail_5:
[00000f40] 246e 0010                 movea.l    16(a6),a2
[00000f44] 2812                      move.l     (a2),d4
[00000f46] 246e 000c                 movea.l    12(a6),a2
[00000f4a] 2d52 fffc                 move.l     (a2),-4(a6)
[00000f4e] 2e2e fffc                 move.l     -4(a6),d7
[00000f52] 9eae fff4                 sub.l      -12(a6),d7
[00000f56] 2d47 fff8                 move.l     d7,-8(a6)
[00000f5a] 2e04                      move.l     d4,d7
[00000f5c] 41f9 0002 065a            lea.l      $00025BAA,a0
[00000f62] 4ef9 0000 4770            jmp        a.switch
[00000f68] 2e2e fff4                 move.l     -12(a6),d7
[00000f6c] dfae fffc                 add.l      d7,-4(a6)
_extail_7:
[00000f70] 246e 000c                 movea.l    12(a6),a2
[00000f74] 24ae fffc                 move.l     -4(a6),(a2)
[00000f78] 246e 0010                 movea.l    16(a6),a2
[00000f7c] 24ae fff0                 move.l     -16(a6),(a2)
[00000f80] 6000 ff44                 bra        _extail_6
[00000f84] 2d6e fff8 fffc            move.l     -8(a6),-4(a6)
[00000f8a] 60e4                      bra.s      _extail_7
[00000f8c] 2eae fffc                 move.l     -4(a6),(a7)
[00000f90] 2f2e fff4                 move.l     -12(a6),-(a7)
[00000f94] 4eb9 0000 4fd0            jsr        a.lmul
[00000f9a] 2d57 fffc                 move.l     (a7),-4(a6)
[00000f9e] 60d0                      bra.s      _extail_7
[00000fa0] 2eae fffc                 move.l     -4(a6),(a7)
[00000fa4] 2f2e fff4                 move.l     -12(a6),-(a7)
[00000fa8] 4eb9 0000 44c0            jsr        a.ldiv
[00000fae] 2d57 fffc                 move.l     (a7),-4(a6)
[00000fb2] 60bc                      bra.s      _extail_7
[00000fb4] 2eae fffc                 move.l     -4(a6),(a7)
[00000fb8] 2f2e fff4                 move.l     -12(a6),-(a7)
[00000fbc] 4eb9 0000 44ae            jsr        a.lmod
[00000fc2] 2d57 fffc                 move.l     (a7),-4(a6)
[00000fc6] 60a8                      bra.s      _extail_7
[00000fc8] 2e2e fff4                 move.l     -12(a6),d7
[00000fcc] cfae fffc                 and.l      d7,-4(a6)
[00000fd0] 609e                      bra.s      _extail_7
[00000fd2] 2e2e fff4                 move.l     -12(a6),d7
[00000fd6] 8fae fffc                 or.l       d7,-4(a6)
[00000fda] 6094                      bra.s      _extail_7
[00000fdc] 2e2e fff4                 move.l     -12(a6),d7
[00000fe0] bfae fffc                 eor.l      d7,-4(a6)
[00000fe4] 608a                      bra.s      _extail_7
[00000fe6] 2e2e fffc                 move.l     -4(a6),d7
[00000fea] 2c2e fff4                 move.l     -12(a6),d6
[00000fee] eda7                      asl.l      d6,d7
[00000ff0] 2d47 fffc                 move.l     d7,-4(a6)
[00000ff4] 6000 ff7a                 bra        _extail_7
[00000ff8] 2e2e fffc                 move.l     -4(a6),d7
[00000ffc] 2c2e fff4                 move.l     -12(a6),d6
[00001000] eca7                      asr.l      d6,d7
[00001002] 2d47 fffc                 move.l     d7,-4(a6)
[00001006] 6000 ff68                 bra        _extail_7
[0000100a] 4aae fff8                 tst.l      -8(a6)
[0000100e] 6c04                      bge.s      _extail_8
[00001010] 7e01                      moveq.l    #1,d7
[00001012] 6002                      bra.s      _extail_9
_extail_8:
[00001014] 4287                      clr.l      d7
_extail_9:
[00001016] 2d47 fffc                 move.l     d7,-4(a6)
[0000101a] 6000 ff54                 bra        _extail_7
[0000101e] 4aae fff8                 tst.l      -8(a6)
[00001022] 6604                      bne.s      _extail_10
[00001024] 7e01                      moveq.l    #1,d7
[00001026] 6002                      bra.s      _extail_11
_extail_10:
[00001028] 4287                      clr.l      d7
_extail_11:
[0000102a] 2d47 fffc                 move.l     d7,-4(a6)
[0000102e] 6000 ff40                 bra        _extail_7
[00001032] 4aae fff8                 tst.l      -8(a6)
[00001036] 6f04                      ble.s      _extail_12
[00001038] 7e01                      moveq.l    #1,d7
[0000103a] 6002                      bra.s      _extail_13
_extail_12:
[0000103c] 4287                      clr.l      d7
_extail_13:
[0000103e] 2d47 fffc                 move.l     d7,-4(a6)
[00001042] 6000 ff2c                 bra        _extail_7
[00001046] 4aae fff8                 tst.l      -8(a6)
[0000104a] 6e04                      bgt.s      _extail_14
[0000104c] 7e01                      moveq.l    #1,d7
[0000104e] 6002                      bra.s      _extail_15
_extail_14:
[00001050] 4287                      clr.l      d7
_extail_15:
[00001052] 2d47 fffc                 move.l     d7,-4(a6)
[00001056] 6000 ff18                 bra        _extail_7
[0000105a] 4aae fff8                 tst.l      -8(a6)
[0000105e] 6704                      beq.s      _extail_16
[00001060] 7e01                      moveq.l    #1,d7
[00001062] 6002                      bra.s      _extail_17
_extail_16:
[00001064] 4287                      clr.l      d7
_extail_17:
[00001066] 2d47 fffc                 move.l     d7,-4(a6)
[0000106a] 6000 ff04                 bra        _extail_7
[0000106e] 4aae fff8                 tst.l      -8(a6)
[00001072] 6d04                      blt.s      _extail_18
[00001074] 7e01                      moveq.l    #1,d7
[00001076] 6002                      bra.s      _extail_19
_extail_18:
[00001078] 4287                      clr.l      d7
_extail_19:
[0000107a] 2d47 fffc                 move.l     d7,-4(a6)
[0000107e] 6000 fef0                 bra        _extail_7
[00001082] 4aae fffc                 tst.l      -4(a6)
[00001086] 670a                      beq.s      _extail_20
[00001088] 4aae fff4                 tst.l      -12(a6)
[0000108c] 6704                      beq.s      _extail_20
[0000108e] 7e01                      moveq.l    #1,d7
[00001090] 6002                      bra.s      _extail_21
_extail_20:
[00001092] 4287                      clr.l      d7
_extail_21:
[00001094] 2d47 fffc                 move.l     d7,-4(a6)
[00001098] 6000 fed6                 bra        _extail_7
[0000109c] 4aae fffc                 tst.l      -4(a6)
[000010a0] 6606                      bne.s      _extail_22
[000010a2] 4aae fff4                 tst.l      -12(a6)
[000010a6] 6704                      beq.s      _extail_23
_extail_22:
[000010a8] 7e01                      moveq.l    #1,d7
[000010aa] 6002                      bra.s      _extail_24
_extail_23:
[000010ac] 4287                      clr.l      d7
_extail_24:
[000010ae] 2d47 fffc                 move.l     d7,-4(a6)
[000010b2] 6000 febc                 bra        _extail_7
[000010b6] 45f8 0014                 lea.l      ($00000014).w,a2
[000010ba] d5ee 0014                 adda.l     20(a6),a2
[000010be] 0c92 0000 0001            cmpi.l     #$00000001,(a2)
[000010c4] 662a                      bne.s      _extail_25
[000010c6] 45f8 0010                 lea.l      ($00000010).w,a2
[000010ca] d5ee 0014                 adda.l     20(a6),a2
[000010ce] 2452                      movea.l    (a2),a2
[000010d0] 4287                      clr.l      d7
[000010d2] 1e12                      move.b     (a2),d7
[000010d4] 0c47 003a                 cmpi.w     #$003A,d7
[000010d8] 6616                      bne.s      _extail_25
[000010da] 486e fff8                 pea.l      -8(a6)
[000010de] 246e 0014                 movea.l    20(a6),a2
[000010e2] 2f12                      move.l     (a2),-(a7)
[000010e4] 4eba fd30                 jsr        _expr(pc)
[000010e8] 508f                      addq.l     #8,a7
[000010ea] 2d47 0014                 move.l     d7,20(a6)
[000010ee] 6610                      bne.s      _extail_26
_extail_25:
[000010f0] 2ebc 0002 0712            move.l     #$00025C62,(a7)
[000010f6] 4eb9 0000 310e            jsr        _p0error
[000010fc] 4287                      clr.l      d7
[000010fe] 6028                      bra.s      _extail_27
_extail_26:
[00001100] 4aae fffc                 tst.l      -4(a6)
[00001104] 670a                      beq.s      _extail_28
[00001106] 2d6e fff4 fffc            move.l     -12(a6),-4(a6)
[0000110c] 6000 fe62                 bra        _extail_7
_extail_28:
[00001110] 2d6e fff8 fffc            move.l     -8(a6),-4(a6)
[00001116] 6000 fe58                 bra        _extail_7
[0000111a] 2ebc 0002 06fa            move.l     #$00025C4A,(a7)
[00001120] 4eb9 0000 310e            jsr        _p0error
[00001126] 4287                      clr.l      d7
_extail_27:
[00001128] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[0000112c] 4e5e                      unlk       a6
[0000112e] 4e75                      rts

_exterm:
[00001130] 4e56 fdfc                 link       a6,#-516
[00001134] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00001138] 2a6e 000c                 movea.l    12(a6),a5
[0000113c] 246e 0008                 movea.l    8(a6),a2
[00001140] 588a                      addq.l     #4,a2
[00001142] 0c92 0000 0004            cmpi.l     #$00000004,(a2)
[00001148] 6620                      bne.s      _exterm_1
[0000114a] 4297                      clr.l      (a7)
[0000114c] 42a7                      clr.l      -(a7)
[0000114e] 2f2e 0008                 move.l     8(a6),-(a7)
[00001152] 4eb9 0000 12da            jsr        _bton
[00001158] 508f                      addq.l     #8,a7
[0000115a] 2a87                      move.l     d7,(a5)
[0000115c] 246e 0008                 movea.l    8(a6),a2
[00001160] 2e12                      move.l     (a2),d7
[00001162] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00001166] 4e5e                      unlk       a6
[00001168] 4e75                      rts
_exterm_1:
[0000116a] 246e 0008                 movea.l    8(a6),a2
[0000116e] 588a                      addq.l     #4,a2
[00001170] 0c92 0000 0001            cmpi.l     #$00000001,(a2)
[00001176] 6644                      bne.s      _exterm_2
[00001178] 45ee fe01                 lea.l      -511(a6),a2
[0000117c] 284a                      movea.l    a2,a4
[0000117e] 45f8 0014                 lea.l      ($00000014).w,a2
[00001182] d5ee 0008                 adda.l     8(a6),a2
[00001186] 2e92                      move.l     (a2),(a7)
[00001188] 45f8 0010                 lea.l      ($00000010).w,a2
[0000118c] d5ee 0008                 adda.l     8(a6),a2
[00001190] 2f12                      move.l     (a2),-(a7)
[00001192] 486e fe00                 pea.l      -512(a6)
[00001196] 4eba f962                 jsr        _dobesc(pc)
[0000119a] 508f                      addq.l     #8,a7
[0000119c] 2a07                      move.l     d7,d5
[0000119e] 4295                      clr.l      (a5)
_exterm_4:
[000011a0] 4a85                      tst.l      d5
[000011a2] 6754                      beq.s      _exterm_3
[000011a4] 2e15                      move.l     (a5),d7
[000011a6] e187                      asl.l      #8,d7
[000011a8] 4286                      clr.l      d6
[000011aa] 1c14                      move.b     (a4),d6
[000011ac] 0286 0000 00ff            andi.l     #$000000FF,d6
[000011b2] 8e86                      or.l       d6,d7
[000011b4] 2a87                      move.l     d7,(a5)
[000011b6] 528c                      addq.l     #1,a4
[000011b8] 5385                      subq.l     #1,d5
[000011ba] 60e4                      bra.s      _exterm_4
_exterm_2:
[000011bc] 45f8 0014                 lea.l      ($00000014).w,a2
[000011c0] d5ee 0008                 adda.l     8(a6),a2
[000011c4] 0c92 0000 0001            cmpi.l     #$00000001,(a2)
[000011ca] 663a                      bne.s      _exterm_5
[000011cc] 45f8 0010                 lea.l      ($00000010).w,a2
[000011d0] d5ee 0008                 adda.l     8(a6),a2
[000011d4] 2452                      movea.l    (a2),a2
[000011d6] 4287                      clr.l      d7
[000011d8] 1e12                      move.b     (a2),d7
[000011da] 0c47 0028                 cmpi.w     #$0028,d7
[000011de] 6626                      bne.s      _exterm_5
[000011e0] 2e8d                      move.l     a5,(a7)
[000011e2] 246e 0008                 movea.l    8(a6),a2
[000011e6] 2f12                      move.l     (a2),-(a7)
[000011e8] 4eba fc2c                 jsr        _expr(pc)
[000011ec] 588f                      addq.l     #4,a7
[000011ee] 2d47 0008                 move.l     d7,8(a6)
[000011f2] 6636                      bne.s      _exterm_6
[000011f4] 4287                      clr.l      d7
[000011f6] 6006                      bra.s      _exterm_7
_exterm_3:
[000011f8] 246e 0008                 movea.l    8(a6),a2
[000011fc] 2e12                      move.l     (a2),d7
_exterm_7:
[000011fe] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00001202] 4e5e                      unlk       a6
[00001204] 4e75                      rts
_exterm_5:
[00001206] 4878 0040                 pea.l      ($00000040).w
[0000120a] 486e 0008                 pea.l      8(a6)
[0000120e] 4eba fbc2                 jsr        _exop(pc)
[00001212] 508f                      addq.l     #8,a7
[00001214] 2d47 fdfc                 move.l     d7,-516(a6)
[00001218] 664c                      bne.s      _exterm_8
[0000121a] 2ebc 0002 073e            move.l     #$00025C8E,(a7)
[00001220] 4eb9 0000 310e            jsr        _p0error
[00001226] 4287                      clr.l      d7
[00001228] 60d4                      bra.s      _exterm_7
_exterm_6:
[0000122a] 45f8 0014                 lea.l      ($00000014).w,a2
[0000122e] d5ee 0008                 adda.l     8(a6),a2
[00001232] 0c92 0000 0001            cmpi.l     #$00000001,(a2)
[00001238] 6614                      bne.s      _exterm_9
[0000123a] 45f8 0010                 lea.l      ($00000010).w,a2
[0000123e] d5ee 0008                 adda.l     8(a6),a2
[00001242] 2452                      movea.l    (a2),a2
[00001244] 4287                      clr.l      d7
[00001246] 1e12                      move.b     (a2),d7
[00001248] 0c47 0029                 cmpi.w     #$0029,d7
[0000124c] 6710                      beq.s      _exterm_10
_exterm_9:
[0000124e] 2ebc 0002 0751            move.l     #$00025CA1,(a7)
[00001254] 4eb9 0000 310e            jsr        _p0error
[0000125a] 4287                      clr.l      d7
[0000125c] 60a0                      bra.s      _exterm_7
_exterm_10:
[0000125e] 246e 0008                 movea.l    8(a6),a2
[00001262] 2e12                      move.l     (a2),d7
[00001264] 6098                      bra.s      _exterm_7
_exterm_8:
[00001266] 2e8d                      move.l     a5,(a7)
[00001268] 2f2e 0008                 move.l     8(a6),-(a7)
[0000126c] 4eba fec2                 jsr        _exterm(pc)
[00001270] 588f                      addq.l     #4,a7
[00001272] 2d47 0008                 move.l     d7,8(a6)
[00001276] 6604                      bne.s      _exterm_11
[00001278] 4287                      clr.l      d7
[0000127a] 602c                      bra.s      _exterm_12
_exterm_11:
[0000127c] 0cae 0000 00d8 fdfc       cmpi.l     #$000000D8,-516(a6)
[00001284] 6608                      bne.s      _exterm_13
[00001286] 2e15                      move.l     (a5),d7
[00001288] 4487                      neg.l      d7
[0000128a] 2a87                      move.l     d7,(a5)
[0000128c] 6016                      bra.s      _exterm_14
_exterm_13:
[0000128e] 0cae 0000 005a fdfc       cmpi.l     #$0000005A,-516(a6)
[00001296] 6618                      bne.s      _exterm_15
[00001298] 4a95                      tst.l      (a5)
[0000129a] 6604                      bne.s      _exterm_16
[0000129c] 7e01                      moveq.l    #1,d7
[0000129e] 6002                      bra.s      _exterm_17
_exterm_16:
[000012a0] 4287                      clr.l      d7
_exterm_17:
[000012a2] 2a87                      move.l     d7,(a5)
_exterm_14:
[000012a4] 2e2e 0008                 move.l     8(a6),d7
_exterm_12:
[000012a8] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000012ac] 4e5e                      unlk       a6
[000012ae] 4e75                      rts
_exterm_15:
[000012b0] 0cae 0000 0043 fdfc       cmpi.l     #$00000043,-516(a6)
[000012b8] 6608                      bne.s      _exterm_18
[000012ba] 2e15                      move.l     (a5),d7
[000012bc] 4687                      not.l      d7
[000012be] 2a87                      move.l     d7,(a5)
[000012c0] 60e2                      bra.s      _exterm_14
_exterm_18:
[000012c2] 0cae 0000 00de fdfc       cmpi.l     #$000000DE,-516(a6)
[000012ca] 67d8                      beq.s      _exterm_14
[000012cc] 2ebc 0002 0726            move.l     #$00025C76,(a7)
[000012d2] 4eb9 0000 310e            jsr        _p0error
[000012d8] 60ca                      bra.s      _exterm_14

_bton:
[000012da] 4e56 fff0                 link       a6,#-16
[000012de] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000012e2] 2a6e 0008                 movea.l    8(a6),a5
[000012e6] 42ae fff8                 clr.l      -8(a6)
[000012ea] 286d 0010                 movea.l    16(a5),a4
[000012ee] 2a2d 0014                 move.l     20(a5),d5
[000012f2] 4a85                      tst.l      d5
[000012f4] 6f12                      ble.s      _bton_1
[000012f6] 4287                      clr.l      d7
[000012f8] 1e14                      move.b     (a4),d7
[000012fa] 0c47 0030                 cmpi.w     #$0030,d7
[000012fe] 6708                      beq.s      _bton_1
[00001300] 3d7c 000a fff6            move.w     #$000A,-10(a6)
[00001306] 602a                      bra.s      _bton_2
_bton_1:
[00001308] 0c85 0000 0001            cmpi.l     #$00000001,d5
[0000130e] 6f1c                      ble.s      _bton_3
[00001310] 4287                      clr.l      d7
[00001312] 1e2c 0001                 move.b     1(a4),d7
[00001316] 0c47 0078                 cmpi.w     #$0078,d7
[0000131a] 6700 0096                 beq        _bton_4
[0000131e] 4287                      clr.l      d7
[00001320] 1e2c 0001                 move.b     1(a4),d7
[00001324] 0c47 0058                 cmpi.w     #$0058,d7
[00001328] 6700 0088                 beq        _bton_4
_bton_3:
[0000132c] 3d7c 0008 fff6            move.w     #$0008,-10(a6)
_bton_2:
[00001332] 42ae fff0                 clr.l      -16(a6)
_bton_6:
[00001336] 4a85                      tst.l      d5
[00001338] 6f00 0086                 ble        _bton_5
[0000133c] 4287                      clr.l      d7
[0000133e] 1e14                      move.b     (a4),d7
[00001340] 2e87                      move.l     d7,(a7)
[00001342] 2f3c 0002 05e6            move.l     #$00025B36,-(a7)
[00001348] 4eb9 0000 4732            jsr        _scnstr
[0000134e] 588f                      addq.l     #4,a7
[00001350] 3d47 fff4                 move.w     d7,-12(a6)
[00001354] 3e2e fff4                 move.w     -12(a6),d7
[00001358] 48c7                      ext.l      d7
[0000135a] 2447                      movea.l    d7,a2
[0000135c] d5fc 0002 05e6            adda.l     #$00025B36,a2
[00001362] 4a12                      tst.b      (a2)
[00001364] 675a                      beq.s      _bton_5
[00001366] 247c 0002 05fd            movea.l    #$00025B4D,a2
[0000136c] 3e2e fff4                 move.w     -12(a6),d7
[00001370] 48c7                      ext.l      d7
[00001372] d5c7                      adda.l     d7,a2
[00001374] 4240                      clr.w      d0
[00001376] 1012                      move.b     (a2),d0
[00001378] 3d40 fff4                 move.w     d0,-12(a6)
[0000137c] 3e2e fff4                 move.w     -12(a6),d7
[00001380] 48c7                      ext.l      d7
[00001382] 3c2e fff6                 move.w     -10(a6),d6
[00001386] 48c6                      ext.l      d6
[00001388] be86                      cmp.l      d6,d7
[0000138a] 6c34                      bge.s      _bton_5
[0000138c] 2eae fff0                 move.l     -16(a6),(a7)
[00001390] 3e2e fff6                 move.w     -10(a6),d7
[00001394] 48c7                      ext.l      d7
[00001396] 2f07                      move.l     d7,-(a7)
[00001398] 4eb9 0000 4fd0            jsr        a.lmul
[0000139e] 2e17                      move.l     (a7),d7
[000013a0] 3c2e fff4                 move.w     -12(a6),d6
[000013a4] 48c6                      ext.l      d6
[000013a6] de86                      add.l      d6,d7
[000013a8] 2d47 fff0                 move.l     d7,-16(a6)
[000013ac] 528c                      addq.l     #1,a4
[000013ae] 5385                      subq.l     #1,d5
[000013b0] 6084                      bra.s      _bton_6
_bton_4:
[000013b2] 3d7c 0010 fff6            move.w     #$0010,-10(a6)
[000013b8] 548c                      addq.l     #2,a4
[000013ba] 5585                      subq.l     #2,d5
[000013bc] 6000 ff74                 bra        _bton_2
_bton_5:
[000013c0] 42ae fff8                 clr.l      -8(a6)
[000013c4] 42ae fffc                 clr.l      -4(a6)
_bton_13:
[000013c8] 4a85                      tst.l      d5
[000013ca] 6f16                      ble.s      _bton_7
[000013cc] 4287                      clr.l      d7
[000013ce] 1e14                      move.b     (a4),d7
[000013d0] 0c47 006c                 cmpi.w     #$006C,d7
[000013d4] 6728                      beq.s      _bton_8
[000013d6] 4287                      clr.l      d7
[000013d8] 1e14                      move.b     (a4),d7
[000013da] 0c47 004c                 cmpi.w     #$004C,d7
[000013de] 662c                      bne.s      _bton_9
[000013e0] 601c                      bra.s      _bton_8
_bton_7:
[000013e2] 4a85                      tst.l      d5
[000013e4] 674c                      beq.s      _bton_10
[000013e6] 2ead 0014                 move.l     20(a5),(a7)
[000013ea] 2f2d 0010                 move.l     16(a5),-(a7)
[000013ee] 2f3c 0002 095a            move.l     #$00025EAA,-(a7)
[000013f4] 4eb9 0000 310e            jsr        _p0error
[000013fa] 508f                      addq.l     #8,a7
[000013fc] 6034                      bra.s      _bton_10
_bton_8:
[000013fe] 4aae fffc                 tst.l      -4(a6)
[00001402] 6608                      bne.s      _bton_9
[00001404] 7001                      moveq.l    #1,d0
[00001406] 2d40 fffc                 move.l     d0,-4(a6)
[0000140a] 6020                      bra.s      _bton_11
_bton_9:
[0000140c] 4287                      clr.l      d7
[0000140e] 1e14                      move.b     (a4),d7
[00001410] 0c47 0075                 cmpi.w     #$0075,d7
[00001414] 670a                      beq.s      _bton_12
[00001416] 4287                      clr.l      d7
[00001418] 1e14                      move.b     (a4),d7
[0000141a] 0c47 0055                 cmpi.w     #$0055,d7
[0000141e] 66c2                      bne.s      _bton_7
_bton_12:
[00001420] 4aae fff8                 tst.l      -8(a6)
[00001424] 66bc                      bne.s      _bton_7
[00001426] 7001                      moveq.l    #1,d0
[00001428] 2d40 fff8                 move.l     d0,-8(a6)
_bton_11:
[0000142c] 528c                      addq.l     #1,a4
[0000142e] 5385                      subq.l     #1,d5
[00001430] 6096                      bra.s      _bton_13
_bton_10:
[00001432] 4aae 000c                 tst.l      12(a6)
[00001436] 6708                      beq.s      _bton_14
[00001438] 246e 000c                 movea.l    12(a6),a2
[0000143c] 24ae fffc                 move.l     -4(a6),(a2)
_bton_14:
[00001440] 4aae 0010                 tst.l      16(a6)
[00001444] 6708                      beq.s      _bton_15
[00001446] 246e 0010                 movea.l    16(a6),a2
[0000144a] 24ae fff8                 move.l     -8(a6),(a2)
_bton_15:
[0000144e] 2e2e fff0                 move.l     -16(a6),d7
[00001452] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00001456] 4e5e                      unlk       a6
[00001458] 4e75                      rts

_flaccum:
[0000145a] 4e56 0000                 link       a6,#0
[0000145e] 48e7 9c0c                 movem.l    d0/d3-d5/a4-a5,-(a7)
[00001462] 2a6e 0008                 movea.l    8(a6),a5
[00001466] 2a2e 0010                 move.l     16(a6),d5
[0000146a] 4284                      clr.l      d4
_flaccum_2:
[0000146c] b885                      cmp.l      d5,d4
[0000146e] 6452                      bcc.s      _flaccum_1
[00001470] 4287                      clr.l      d7
[00001472] 1e15                      move.b     (a5),d7
[00001474] 0c47 0030                 cmpi.w     #$0030,d7
[00001478] 6548                      bcs.s      _flaccum_1
[0000147a] 4287                      clr.l      d7
[0000147c] 1e15                      move.b     (a5),d7
[0000147e] 0c47 0039                 cmpi.w     #$0039,d7
[00001482] 623e                      bhi.s      _flaccum_1
[00001484] 246e 000c                 movea.l    12(a6),a2
[00001488] 286e 000c                 movea.l    12(a6),a4
[0000148c] 2c14                      move.l     (a4),d6
[0000148e] 2e2c 0004                 move.l     4(a4),d7
[00001492] 41f9 0002 13ac            lea.l      $000268FC,a0
[00001498] 4eb9 0000 51da            jsr        a.6mul
[0000149e] 76d0                      moveq.l    #-48,d3
[000014a0] 4282                      clr.l      d2
[000014a2] 1415                      move.b     (a5),d2
[000014a4] d682                      add.l      d2,d3
[000014a6] 2003                      move.l     d3,d0
[000014a8] 4eb9 0000 4ffc            jsr        a.1ltd
[000014ae] 91c8                      suba.l     a0,a0
[000014b0] 4eb9 0000 4d98            jsr        a.6add
[000014b6] 2486                      move.l     d6,(a2)
[000014b8] 2547 0004                 move.l     d7,4(a2)
[000014bc] 5284                      addq.l     #1,d4
[000014be] 528d                      addq.l     #1,a5
[000014c0] 60aa                      bra.s      _flaccum_2
_flaccum_1:
[000014c2] 2e04                      move.l     d4,d7
[000014c4] 4cdf 3039                 movem.l    (a7)+,d0/d3-d5/a4-a5
[000014c8] 4e5e                      unlk       a6
[000014ca] 4e75                      rts

_lexchars:
[000014cc] 4e56 fdfc                 link       a6,#-516
[000014d0] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[000014d4] 2a6e 0008                 movea.l    8(a6),a5
[000014d8] 2ead 0014                 move.l     20(a5),(a7)
[000014dc] 2f2d 0010                 move.l     16(a5),-(a7)
[000014e0] 486e fdfc                 pea.l      -516(a6)
[000014e4] 4eb9 0000 0afa            jsr        _dobesc
[000014ea] 508f                      addq.l     #8,a7
[000014ec] 2807                      move.l     d7,d4
[000014ee] 0c84 0000 0004            cmpi.l     #$00000004,d4
[000014f4] 6404                      bcc.s      _lexchars_1
[000014f6] 7e01                      moveq.l    #1,d7
[000014f8] 6006                      bra.s      _lexchars_2
_lexchars_1:
[000014fa] 2444                      movea.l    d4,a2
[000014fc] 578a                      subq.l     #3,a2
[000014fe] 2e0a                      move.l     a2,d7
_lexchars_2:
[00001500] 2a07                      move.l     d7,d5
[00001502] 42ae fffc                 clr.l      -4(a6)
_lexchars_4:
[00001506] ba84                      cmp.l      d4,d5
[00001508] 621a                      bhi.s      _lexchars_3
[0000150a] 2e2e fffc                 move.l     -4(a6),d7
[0000150e] e187                      asl.l      #8,d7
[00001510] 45ee fdfc                 lea.l      -516(a6),a2
[00001514] d5c5                      adda.l     d5,a2
[00001516] 4286                      clr.l      d6
[00001518] 1c12                      move.b     (a2),d6
[0000151a] 8e86                      or.l       d6,d7
[0000151c] 2d47 fffc                 move.l     d7,-4(a6)
[00001520] 5285                      addq.l     #1,d5
[00001522] 60e2                      bra.s      _lexchars_4
_lexchars_3:
[00001524] 486e fffc                 pea.l      -4(a6)
[00001528] 0c84 0000 0001            cmpi.l     #$00000001,d4
[0000152e] 6204                      bhi.s      _lexchars_5
[00001530] 7e18                      moveq.l    #24,d7
[00001532] 6002                      bra.s      _lexchars_6
_lexchars_5:
[00001534] 7e16                      moveq.l    #22,d7
_lexchars_6:
[00001536] 2f07                      move.l     d7,-(a7)
[00001538] 2f3c 0002 096e            move.l     #$00025EBE,-(a7)
[0000153e] 4eb9 0000 19aa            jsr        _putcode
[00001544] 4fef 000c                 lea.l      12(a7),a7
[00001548] 2e15                      move.l     (a5),d7
[0000154a] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[0000154e] 4e5e                      unlk       a6
[00001550] 4e75                      rts

_lexfloat:
[00001552] 4e56 fff0                 link       a6,#-16
[00001556] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[0000155a] 45f8 0010                 lea.l      ($00000010).w,a2
[0000155e] d5ee 0008                 adda.l     8(a6),a2
[00001562] 2a52                      movea.l    (a2),a5
[00001564] 42ae fff2                 clr.l      -14(a6)
[00001568] 42ae fff6                 clr.l      -10(a6)
[0000156c] 45f8 0014                 lea.l      ($00000014).w,a2
[00001570] d5ee 0008                 adda.l     8(a6),a2
[00001574] 2e92                      move.l     (a2),(a7)
[00001576] 486e fff2                 pea.l      -14(a6)
[0000157a] 2f0d                      move.l     a5,-(a7)
[0000157c] 4eba fedc                 jsr        _flaccum(pc)
[00001580] 508f                      addq.l     #8,a7
[00001582] dbc7                      adda.l     d7,a5
[00001584] 2e8d                      move.l     a5,(a7)
[00001586] 486e 0008                 pea.l      8(a6)
[0000158a] 4eb9 0000 1772            jsr        _lexfnxt
[00001590] 588f                      addq.l     #4,a7
[00001592] 2a47                      movea.l    d7,a5
[00001594] 4287                      clr.l      d7
[00001596] 1e15                      move.b     (a5),d7
[00001598] 0c47 002e                 cmpi.w     #$002E,d7
[0000159c] 6646                      bne.s      _lexfloat_1
[0000159e] 486d 0001                 pea.l      1(a5)
[000015a2] 486e 0008                 pea.l      8(a6)
[000015a6] 4eb9 0000 1772            jsr        _lexfnxt
[000015ac] 508f                      addq.l     #8,a7
[000015ae] 2a47                      movea.l    d7,a5
[000015b0] 45f8 0014                 lea.l      ($00000014).w,a2
[000015b4] d5ee 0008                 adda.l     8(a6),a2
[000015b8] 2e92                      move.l     (a2),(a7)
[000015ba] 486e fff2                 pea.l      -14(a6)
[000015be] 2f0d                      move.l     a5,-(a7)
[000015c0] 4eba fe98                 jsr        _flaccum(pc)
[000015c4] 508f                      addq.l     #8,a7
[000015c6] 2a07                      move.l     d7,d5
[000015c8] 2e05                      move.l     d5,d7
[000015ca] 4487                      neg.l      d7
[000015cc] 3d47 fffa                 move.w     d7,-6(a6)
[000015d0] dbc5                      adda.l     d5,a5
[000015d2] 2e8d                      move.l     a5,(a7)
[000015d4] 486e 0008                 pea.l      8(a6)
[000015d8] 4eb9 0000 1772            jsr        _lexfnxt
[000015de] 588f                      addq.l     #4,a7
[000015e0] 2a47                      movea.l    d7,a5
[000015e2] 6004                      bra.s      _lexfloat_2
_lexfloat_1:
[000015e4] 426e fffa                 clr.w      -6(a6)
_lexfloat_2:
[000015e8] 4287                      clr.l      d7
[000015ea] 1e15                      move.b     (a5),d7
[000015ec] 0c47 0065                 cmpi.w     #$0065,d7
[000015f0] 670c                      beq.s      _lexfloat_3
[000015f2] 4287                      clr.l      d7
[000015f4] 1e15                      move.b     (a5),d7
[000015f6] 0c47 0045                 cmpi.w     #$0045,d7
[000015fa] 6600 008c                 bne        _lexfloat_4
_lexfloat_3:
[000015fe] 528d                      addq.l     #1,a5
[00001600] 2e8d                      move.l     a5,(a7)
[00001602] 486e 0008                 pea.l      8(a6)
[00001606] 4eb9 0000 1772            jsr        _lexfnxt
[0000160c] 588f                      addq.l     #4,a7
[0000160e] 2a47                      movea.l    d7,a5
[00001610] 42ae fffc                 clr.l      -4(a6)
[00001614] 4287                      clr.l      d7
[00001616] 1e15                      move.b     (a5),d7
[00001618] 0c47 002b                 cmpi.w     #$002B,d7
[0000161c] 6604                      bne.s      _lexfloat_5
[0000161e] 528d                      addq.l     #1,a5
[00001620] 6012                      bra.s      _lexfloat_6
_lexfloat_5:
[00001622] 4287                      clr.l      d7
[00001624] 1e15                      move.b     (a5),d7
[00001626] 0c47 002d                 cmpi.w     #$002D,d7
[0000162a] 6608                      bne.s      _lexfloat_6
[0000162c] 528d                      addq.l     #1,a5
[0000162e] 7001                      moveq.l    #1,d0
[00001630] 2d40 fffc                 move.l     d0,-4(a6)
_lexfloat_6:
[00001634] 2e8d                      move.l     a5,(a7)
[00001636] 486e 0008                 pea.l      8(a6)
[0000163a] 4eb9 0000 1772            jsr        _lexfnxt
[00001640] 588f                      addq.l     #4,a7
[00001642] 2a47                      movea.l    d7,a5
[00001644] 4285                      clr.l      d5
_lexfloat_8:
[00001646] 4287                      clr.l      d7
[00001648] 1e15                      move.b     (a5),d7
[0000164a] 0c47 0030                 cmpi.w     #$0030,d7
[0000164e] 6528                      bcs.s      _lexfloat_7
[00001650] 4287                      clr.l      d7
[00001652] 1e15                      move.b     (a5),d7
[00001654] 0c47 0039                 cmpi.w     #$0039,d7
[00001658] 621e                      bhi.s      _lexfloat_7
[0000165a] 7ed0                      moveq.l    #-48,d7
[0000165c] 2e85                      move.l     d5,(a7)
[0000165e] 4878 000a                 pea.l      ($0000000A).w
[00001662] 4eb9 0000 4fd0            jsr        a.lmul
[00001668] 2c17                      move.l     (a7),d6
[0000166a] 4284                      clr.l      d4
[0000166c] 1815                      move.b     (a5),d4
[0000166e] dc84                      add.l      d4,d6
[00001670] de86                      add.l      d6,d7
[00001672] 2a07                      move.l     d7,d5
[00001674] 528d                      addq.l     #1,a5
[00001676] 60ce                      bra.s      _lexfloat_8
_lexfloat_7:
[00001678] 4aae fffc                 tst.l      -4(a6)
[0000167c] 6706                      beq.s      _lexfloat_9
[0000167e] 9b6e fffa                 sub.w      d5,-6(a6)
[00001682] 6004                      bra.s      _lexfloat_4
_lexfloat_9:
[00001684] db6e fffa                 add.w      d5,-6(a6)
_lexfloat_4:
[00001688] 3e2e fffa                 move.w     -6(a6),d7
[0000168c] 48c7                      ext.l      d7
[0000168e] 2e87                      move.l     d7,(a7)
[00001690] 2f2e fff6                 move.l     -10(a6),-(a7)
[00001694] 2f2e fff2                 move.l     -14(a6),-(a7)
[00001698] 4eb9 0000 4e46            jsr        _dtento
[0000169e] 508f                      addq.l     #8,a7
[000016a0] 2d46 fff2                 move.l     d6,-14(a6)
[000016a4] 2d47 fff6                 move.l     d7,-10(a6)
[000016a8] 2e8d                      move.l     a5,(a7)
[000016aa] 486e 0008                 pea.l      8(a6)
[000016ae] 4eb9 0000 1772            jsr        _lexfnxt
[000016b4] 588f                      addq.l     #4,a7
[000016b6] 2a47                      movea.l    d7,a5
[000016b8] 4287                      clr.l      d7
[000016ba] 1e15                      move.b     (a5),d7
[000016bc] 0c47 006c                 cmpi.w     #$006C,d7
[000016c0] 670a                      beq.s      _lexfloat_10
[000016c2] 4287                      clr.l      d7
[000016c4] 1e15                      move.b     (a5),d7
[000016c6] 0c47 004c                 cmpi.w     #$004C,d7
[000016ca] 663e                      bne.s      _lexfloat_11
_lexfloat_10:
[000016cc] 528d                      addq.l     #1,a5
[000016ce] 1d7c 0010 fff1            move.b     #$10,-15(a6)
_lexfloat_16:
[000016d4] 486e fff2                 pea.l      -14(a6)
[000016d8] 1e2e fff1                 move.b     -15(a6),d7
[000016dc] 4887                      ext.w      d7
[000016de] 48c7                      ext.l      d7
[000016e0] 2f07                      move.l     d7,-(a7)
[000016e2] 2f3c 0002 0989            move.l     #$00025ED9,-(a7)
[000016e8] 4eb9 0000 19aa            jsr        _putcode
[000016ee] 4fef 000c                 lea.l      12(a7),a7
[000016f2] bbfc 0002 0959            cmpa.l     #$00025EA9,a5
[000016f8] 6756                      beq.s      _lexfloat_12
[000016fa] 45f8 0010                 lea.l      ($00000010).w,a2
[000016fe] d5ee 0008                 adda.l     8(a6),a2
[00001702] 2e12                      move.l     (a2),d7
[00001704] be8d                      cmp.l      a5,d7
[00001706] 6628                      bne.s      _lexfloat_13
[00001708] 6046                      bra.s      _lexfloat_12
_lexfloat_11:
[0000170a] 4287                      clr.l      d7
[0000170c] 1e15                      move.b     (a5),d7
[0000170e] 0c47 0066                 cmpi.w     #$0066,d7
[00001712] 670a                      beq.s      _lexfloat_14
[00001714] 4287                      clr.l      d7
[00001716] 1e15                      move.b     (a5),d7
[00001718] 0c47 0046                 cmpi.w     #$0046,d7
[0000171c] 660a                      bne.s      _lexfloat_15
_lexfloat_14:
[0000171e] 528d                      addq.l     #1,a5
[00001720] 1d7c 001e fff1            move.b     #$1E,-15(a6)
[00001726] 60ac                      bra.s      _lexfloat_16
_lexfloat_15:
[00001728] 1d7c 0011 fff1            move.b     #$11,-15(a6)
[0000172e] 60a4                      bra.s      _lexfloat_16
_lexfloat_13:
[00001730] 45f8 0010                 lea.l      ($00000010).w,a2
[00001734] d5ee 0008                 adda.l     8(a6),a2
[00001738] 2e12                      move.l     (a2),d7
[0000173a] 45f8 0014                 lea.l      ($00000014).w,a2
[0000173e] d5ee 0008                 adda.l     8(a6),a2
[00001742] de92                      add.l      (a2),d7
[00001744] be8d                      cmp.l      a5,d7
[00001746] 6614                      bne.s      _lexfloat_17
[00001748] 246e 0008                 movea.l    8(a6),a2
[0000174c] 2d52 0008                 move.l     (a2),8(a6)
_lexfloat_12:
[00001750] 2e2e 0008                 move.l     8(a6),d7
[00001754] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00001758] 4e5e                      unlk       a6
[0000175a] 4e75                      rts
_lexfloat_17:
[0000175c] 246e 0008                 movea.l    8(a6),a2
[00001760] 2d52 0008                 move.l     (a2),8(a6)
[00001764] 2ebc 0002 0972            move.l     #$00025EC2,(a7)
[0000176a] 4eb9 0000 310e            jsr        _p0error
[00001770] 60de                      bra.s      _lexfloat_12

_lexfnxt:
[00001772] 4e56 0000                 link       a6,#0
[00001776] 48e7 8004                 movem.l    d0/a5,-(a7)
[0000177a] 246e 0008                 movea.l    8(a6),a2
[0000177e] 2a52                      movea.l    (a2),a5
[00001780] 2e2e 000c                 move.l     12(a6),d7
[00001784] 0c87 0002 0959            cmpi.l     #$00025EA9,d7
[0000178a] 672a                      beq.s      _lexfnxt_1
[0000178c] 2e2d 0010                 move.l     16(a5),d7
[00001790] dead 0014                 add.l      20(a5),d7
[00001794] beae 000c                 cmp.l      12(a6),d7
[00001798] 621c                      bhi.s      _lexfnxt_1
[0000179a] 2a55                      movea.l    (a5),a5
[0000179c] 246e 0008                 movea.l    8(a6),a2
[000017a0] 248d                      move.l     a5,(a2)
[000017a2] 4aad 000c                 tst.l      12(a5)
[000017a6] 6708                      beq.s      _lexfnxt_2
[000017a8] 2e3c 0002 0959            move.l     #$00025EA9,d7
[000017ae] 6004                      bra.s      _lexfnxt_3
_lexfnxt_2:
[000017b0] 2e2d 0010                 move.l     16(a5),d7
_lexfnxt_3:
[000017b4] 6004                      bra.s      _lexfnxt_4
_lexfnxt_1:
[000017b6] 2e2e 000c                 move.l     12(a6),d7
_lexfnxt_4:
[000017ba] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000017be] 4e5e                      unlk       a6
[000017c0] 4e75                      rts

_lexident:
[000017c2] 4e56 0000                 link       a6,#0
[000017c6] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[000017ca] 2a6e 0008                 movea.l    8(a6),a5
[000017ce] 0cad 0000 007f 0014       cmpi.l     #$0000007F,20(a5)
[000017d6] 6406                      bcc.s      _lexident_1
[000017d8] 2e2d 0014                 move.l     20(a5),d7
[000017dc] 6002                      bra.s      _lexident_2
_lexident_1:
[000017de] 7e7f                      moveq.l    #127,d7
_lexident_2:
[000017e0] 2a07                      move.l     d7,d5
[000017e2] 4287                      clr.l      d7
[000017e4] 1e39 0002 0a3e            move.b     $00025F8E,d7
[000017ea] ba87                      cmp.l      d7,d5
[000017ec] 662e                      bne.s      _lexident_3
[000017ee] 2e85                      move.l     d5,(a7)
[000017f0] 2f3c 0002 0a3f            move.l     #$00025F8F,-(a7)
[000017f6] 2f2d 0010                 move.l     16(a5),-(a7)
[000017fa] 4eb9 0000 4cde            jsr        _cmpbuf
[00001800] 508f                      addq.l     #8,a7
[00001802] 4a87                      tst.l      d7
[00001804] 6716                      beq.s      _lexident_3
[00001806] 2455                      movea.l    (a5),a2
[00001808] 588a                      addq.l     #4,a2
[0000180a] 0c92 0000 0003            cmpi.l     #$00000003,(a2)
[00001810] 660a                      bne.s      _lexident_3
[00001812] 2a55                      movea.l    (a5),a5
[00001814] 2a2d 0014                 move.l     20(a5),d5
[00001818] 4284                      clr.l      d4
[0000181a] 601c                      bra.s      _lexident_4
_lexident_3:
[0000181c] 2e85                      move.l     d5,(a7)
[0000181e] 2f2d 0010                 move.l     16(a5),-(a7)
[00001822] 4878 0021                 pea.l      ($00000021).w
[00001826] 2f3c 0002 0762            move.l     #$00025CB2,-(a7)
[0000182c] 4eb9 0000 336e            jsr        _scntab
[00001832] 4fef 000c                 lea.l      12(a7),a7
[00001836] 2807                      move.l     d7,d4
_lexident_4:
[00001838] 4a84                      tst.l      d4
[0000183a] 6712                      beq.s      _lexident_5
[0000183c] 2e84                      move.l     d4,(a7)
[0000183e] 2f3c 0002 0990            move.l     #$00025EE0,-(a7)
[00001844] 4eb9 0000 19aa            jsr        _putcode
[0000184a] 588f                      addq.l     #4,a7
[0000184c] 601c                      bra.s      _lexident_6
_lexident_5:
[0000184e] 2e85                      move.l     d5,(a7)
[00001850] 2f2d 0010                 move.l     16(a5),-(a7)
[00001854] 2f05                      move.l     d5,-(a7)
[00001856] 4878 0012                 pea.l      ($00000012).w
[0000185a] 2f3c 0002 098c            move.l     #$00025EDC,-(a7)
[00001860] 4eb9 0000 19aa            jsr        _putcode
[00001866] 4fef 0010                 lea.l      16(a7),a7
_lexident_6:
[0000186a] 2e15                      move.l     (a5),d7
[0000186c] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00001870] 4e5e                      unlk       a6
[00001872] 4e75                      rts

_lexint:
[00001874] 4e56 fff2                 link       a6,#-14
[00001878] 486e fff8                 pea.l      -8(a6)
[0000187c] 486e fffc                 pea.l      -4(a6)
[00001880] 2f2e 0008                 move.l     8(a6),-(a7)
[00001884] 4eba fa54                 jsr        _bton(pc)
[00001888] 4fef 000c                 lea.l      12(a7),a7
[0000188c] 2d47 fff4                 move.l     d7,-12(a6)
[00001890] 4aae fffc                 tst.l      -4(a6)
[00001894] 6718                      beq.s      _lexint_1
[00001896] 4aae fff8                 tst.l      -8(a6)
[0000189a] 6606                      bne.s      _lexint_2
[0000189c] 4aae fff4                 tst.l      -12(a6)
[000018a0] 6c04                      bge.s      _lexint_3
_lexint_2:
[000018a2] 7e19                      moveq.l    #25,d7
[000018a4] 6002                      bra.s      _lexint_4
_lexint_3:
[000018a6] 7e15                      moveq.l    #21,d7
_lexint_4:
[000018a8] 1d47 fff3                 move.b     d7,-13(a6)
[000018ac] 6010                      bra.s      _lexint_5
_lexint_1:
[000018ae] 4aae fff8                 tst.l      -8(a6)
[000018b2] 6704                      beq.s      _lexint_6
[000018b4] 7e1a                      moveq.l    #26,d7
[000018b6] 6002                      bra.s      _lexint_7
_lexint_6:
[000018b8] 7e16                      moveq.l    #22,d7
_lexint_7:
[000018ba] 1d47 fff3                 move.b     d7,-13(a6)
_lexint_5:
[000018be] 486e fff4                 pea.l      -12(a6)
[000018c2] 1e2e fff3                 move.b     -13(a6),d7
[000018c6] 4887                      ext.w      d7
[000018c8] 48c7                      ext.l      d7
[000018ca] 2f07                      move.l     d7,-(a7)
[000018cc] 2f3c 0002 0992            move.l     #$00025EE2,-(a7)
[000018d2] 4eb9 0000 19aa            jsr        _putcode
[000018d8] 4fef 000c                 lea.l      12(a7),a7
[000018dc] 246e 0008                 movea.l    8(a6),a2
[000018e0] 2e12                      move.l     (a2),d7
[000018e2] 4e5e                      unlk       a6
[000018e4] 4e75                      rts

_lexpunct:
[000018e6] 4e56 fffc                 link       a6,#-4
[000018ea] 486e 0008                 pea.l      8(a6)
[000018ee] 4eb9 0000 0ca6            jsr        _dopunct
[000018f4] 588f                      addq.l     #4,a7
[000018f6] 2e87                      move.l     d7,(a7)
[000018f8] 2f3c 0002 0996            move.l     #$00025EE6,-(a7)
[000018fe] 4eb9 0000 19aa            jsr        _putcode
[00001904] 588f                      addq.l     #4,a7
[00001906] 2e2e 0008                 move.l     8(a6),d7
[0000190a] 4e5e                      unlk       a6
[0000190c] 4e75                      rts

_lexstrin:
[0000190e] 4e56 fdfe                 link       a6,#-514
[00001912] 48e7 8004                 movem.l    d0/a5,-(a7)
[00001916] 2a6e 0008                 movea.l    8(a6),a5
[0000191a] 2ead 0014                 move.l     20(a5),(a7)
[0000191e] 2f2d 0010                 move.l     16(a5),-(a7)
[00001922] 486e fdfe                 pea.l      -514(a6)
[00001926] 4eb9 0000 0afa            jsr        _dobesc
[0000192c] 508f                      addq.l     #8,a7
[0000192e] 3d47 fffe                 move.w     d7,-2(a6)
[00001932] 3e2e fffe                 move.w     -2(a6),d7
[00001936] 48c7                      ext.l      d7
[00001938] 2e87                      move.l     d7,(a7)
[0000193a] 486e fdff                 pea.l      -513(a6)
[0000193e] 486e fffe                 pea.l      -2(a6)
[00001942] 4878 0017                 pea.l      ($00000017).w
[00001946] 2f3c 0002 0998            move.l     #$00025EE8,-(a7)
[0000194c] 4eb9 0000 19aa            jsr        _putcode
[00001952] 4fef 0010                 lea.l      16(a7),a7
[00001956] 2e15                      move.l     (a5),d7
[00001958] 4cdf 2001                 movem.l    (a7)+,d0/a5
[0000195c] 4e5e                      unlk       a6
[0000195e] 4e75                      rts

_lexxstr:
[00001960] 4e56 fffe                 link       a6,#-2
[00001964] 48e7 8004                 movem.l    d0/a5,-(a7)
[00001968] 2a6e 0008                 movea.l    8(a6),a5
[0000196c] 2e2d 000c                 move.l     12(a5),d7
[00001970] dead 0014                 add.l      20(a5),d7
[00001974] 3d47 fffe                 move.w     d7,-2(a6)
[00001978] 2ead 0014                 move.l     20(a5),(a7)
[0000197c] 2f2d 0010                 move.l     16(a5),-(a7)
[00001980] 2f2d 000c                 move.l     12(a5),-(a7)
[00001984] 2f2d 0008                 move.l     8(a5),-(a7)
[00001988] 486e fffe                 pea.l      -2(a6)
[0000198c] 4878 0017                 pea.l      ($00000017).w
[00001990] 2f3c 0002 099c            move.l     #$00025EEC,-(a7)
[00001996] 4eb9 0000 19aa            jsr        _putcode
[0000199c] 4fef 0018                 lea.l      24(a7),a7
[000019a0] 2e15                      move.l     (a5),d7
[000019a2] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000019a6] 4e5e                      unlk       a6
[000019a8] 4e75                      rts

_putcode:
[000019aa] 4e56 fffe                 link       a6,#-2
[000019ae] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[000019b2] 286e 0008                 movea.l    8(a6),a4
[000019b6] 45ee 000c                 lea.l      12(a6),a2
[000019ba] 2a4a                      movea.l    a2,a5
_putcode_6:
[000019bc] 4a14                      tst.b      (a4)
[000019be] 6758                      beq.s      _putcode_1
[000019c0] 4287                      clr.l      d7
[000019c2] 1e14                      move.b     (a4),d7
[000019c4] 0c47 0063                 cmpi.w     #$0063,d7
[000019c8] 665a                      bne.s      _putcode_2
[000019ca] 3e39 0002 1116            move.w     $00026666,d7
[000019d0] 48c7                      ext.l      d7
[000019d2] 0c47 0200                 cmpi.w     #$0200,d7
[000019d6] 6c26                      bge.s      _putcode_3
[000019d8] 3e39 0002 1116            move.w     $00026666,d7
[000019de] 48c7                      ext.l      d7
[000019e0] 2447                      movea.l    d7,a2
[000019e2] 5279 0002 1116            addq.w     #1,$00026666
[000019e8] d5fc 0002 111e            adda.l     #$0002666E,a2
[000019ee] 2e1d                      move.l     (a5)+,d7
[000019f0] 0287 0000 00ff            andi.l     #$000000FF,d7
[000019f6] 1487                      move.b     d7,(a2)
[000019f8] 4287                      clr.l      d7
[000019fa] 1e12                      move.b     (a2),d7
[000019fc] 6018                      bra.s      _putcode_4
_putcode_3:
[000019fe] 2e1d                      move.l     (a5)+,d7
[00001a00] 0287 0000 00ff            andi.l     #$000000FF,d7
[00001a06] 2e87                      move.l     d7,(a7)
[00001a08] 2f3c 0002 1114            move.l     #$00026664,-(a7)
[00001a0e] 4eb9 0000 4590            jsr        _putc
[00001a14] 588f                      addq.l     #4,a7
_putcode_4:
[00001a16] 6008                      bra.s      _putcode_5
_putcode_1:
[00001a18] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00001a1c] 4e5e                      unlk       a6
[00001a1e] 4e75                      rts
_putcode_5:
[00001a20] 528c                      addq.l     #1,a4
[00001a22] 6098                      bra.s      _putcode_6
_putcode_2:
[00001a24] 2655                      movea.l    (a5),a3
[00001a26] 2e0d                      move.l     a5,d7
[00001a28] 5887                      addq.l     #4,d7
[00001a2a] 2a47                      movea.l    d7,a5
[00001a2c] 4287                      clr.l      d7
[00001a2e] 1e14                      move.b     (a4),d7
[00001a30] 0c47 0062                 cmpi.w     #$0062,d7
[00001a34] 6604                      bne.s      _putcode_7
[00001a36] 2e1d                      move.l     (a5)+,d7
[00001a38] 601c                      bra.s      _putcode_8
_putcode_7:
[00001a3a] 4287                      clr.l      d7
[00001a3c] 1e14                      move.b     (a4),d7
[00001a3e] 0c47 0070                 cmpi.w     #$0070,d7
[00001a42] 660a                      bne.s      _putcode_9
[00001a44] 2e8b                      move.l     a3,(a7)
[00001a46] 4eb9 0000 52f4            jsr        _lenstr
[00001a4c] 6008                      bra.s      _putcode_8
_putcode_9:
[00001a4e] 7ed0                      moveq.l    #-48,d7
[00001a50] 4286                      clr.l      d6
[00001a52] 1c14                      move.b     (a4),d6
[00001a54] de86                      add.l      d6,d7
_putcode_8:
[00001a56] 3d47 fffe                 move.w     d7,-2(a6)
_putcode_12:
[00001a5a] 536e fffe                 subq.w     #1,-2(a6)
[00001a5e] 6dc0                      blt.s      _putcode_5
[00001a60] 3e39 0002 1116            move.w     $00026666,d7
[00001a66] 48c7                      ext.l      d7
[00001a68] 0c47 0200                 cmpi.w     #$0200,d7
[00001a6c] 6c28                      bge.s      _putcode_10
[00001a6e] 3e39 0002 1116            move.w     $00026666,d7
[00001a74] 48c7                      ext.l      d7
[00001a76] 2447                      movea.l    d7,a2
[00001a78] 5279 0002 1116            addq.w     #1,$00026666
[00001a7e] d5fc 0002 111e            adda.l     #$0002666E,a2
[00001a84] 4287                      clr.l      d7
[00001a86] 1e1b                      move.b     (a3)+,d7
[00001a88] 0287 0000 00ff            andi.l     #$000000FF,d7
[00001a8e] 1487                      move.b     d7,(a2)
[00001a90] 4287                      clr.l      d7
[00001a92] 1e12                      move.b     (a2),d7
[00001a94] 601a                      bra.s      _putcode_11
_putcode_10:
[00001a96] 4287                      clr.l      d7
[00001a98] 1e1b                      move.b     (a3)+,d7
[00001a9a] 0287 0000 00ff            andi.l     #$000000FF,d7
[00001aa0] 2e87                      move.l     d7,(a7)
[00001aa2] 2f3c 0002 1114            move.l     #$00026664,-(a7)
[00001aa8] 4eb9 0000 4590            jsr        _putc
[00001aae] 588f                      addq.l     #4,a7
_putcode_11:
[00001ab0] 60a8                      bra.s      _putcode_12

_putfile:
[00001ab2] 4e56 fffc                 link       a6,#-4
[00001ab6] 4ab9 0002 0a2e            tst.l      $00025F7E
[00001abc] 6720                      beq.s      _putfile_1
[00001abe] 4ab9 0002 0a6c            tst.l      $00025FBC
[00001ac4] 6718                      beq.s      _putfile_1
[00001ac6] 4ab9 0002 0a5e            tst.l      $00025FAE
[00001acc] 6710                      beq.s      _putfile_1
[00001ace] 4a79 0002 0a3c            tst.w      $00025F8C
[00001ad4] 670c                      beq.s      _putfile_2
[00001ad6] 4ab9 0002 0a1e            tst.l      $00025F6E
[00001adc] 6604                      bne.s      _putfile_2
_putfile_1:
[00001ade] 4e5e                      unlk       a6
[00001ae0] 4e75                      rts
_putfile_2:
[00001ae2] 4ab9 0002 0a56            tst.l      $00025FA6
[00001ae8] 66f4                      bne.s      _putfile_1
[00001aea] 42b9 0002 0a5e            clr.l      $00025FAE
[00001af0] 2479 0002 0a6c            movea.l    $00025FBC,a2
[00001af6] 588a                      addq.l     #4,a2
[00001af8] 4a92                      tst.l      (a2)
[00001afa] 6614                      bne.s      _putfile_3
[00001afc] 4297                      clr.l      (a7)
[00001afe] 4878 0013                 pea.l      ($00000013).w
[00001b02] 2f3c 0002 09a6            move.l     #$00025EF6,-(a7)
[00001b08] 4eba fea0                 jsr        _putcode(pc)
[00001b0c] 508f                      addq.l     #8,a7
[00001b0e] 60ce                      bra.s      _putfile_1
_putfile_3:
[00001b10] 2479 0002 0a6c            movea.l    $00025FBC,a2
[00001b16] 588a                      addq.l     #4,a2
[00001b18] 2e92                      move.l     (a2),(a7)
[00001b1a] 2479 0002 0a6c            movea.l    $00025FBC,a2
[00001b20] 588a                      addq.l     #4,a2
[00001b22] 2f12                      move.l     (a2),-(a7)
[00001b24] 4eb9 0000 52f4            jsr        _lenstr
[00001b2a] 588f                      addq.l     #4,a7
[00001b2c] 2f07                      move.l     d7,-(a7)
[00001b2e] 4878 0013                 pea.l      ($00000013).w
[00001b32] 2f3c 0002 09a2            move.l     #$00025EF2,-(a7)
[00001b38] 4eba fe70                 jsr        _putcode(pc)
[00001b3c] 4fef 000c                 lea.l      12(a7),a7
[00001b40] 609c                      bra.s      _putfile_1

_putls:
[00001b42] 4e56 fffc                 link       a6,#-4
[00001b46] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[00001b4a] 2a6e 0008                 movea.l    8(a6),a5
[00001b4e] 4ab9 0002 0a2e            tst.l      $00025F7E
[00001b54] 661c                      bne.s      _putls_1
[00001b56] 284d                      movea.l    a5,a4
[00001b58] 42ae fffc                 clr.l      -4(a6)
_putls_10:
[00001b5c] 2e0c                      move.l     a4,d7
[00001b5e] 6778                      beq.s      _putls_2
[00001b60] 4aae fffc                 tst.l      -4(a6)
[00001b64] 661c                      bne.s      _putls_3
[00001b66] 0cac 0000 0008 0004       cmpi.l     #$00000008,4(a4)
[00001b6e] 6722                      beq.s      _putls_4
[00001b70] 6010                      bra.s      _putls_3
_putls_1:
[00001b72] 284d                      movea.l    a5,a4
_putls_6:
[00001b74] 0cac 0000 0007 0004       cmpi.l     #$00000007,4(a4)
[00001b7c] 6662                      bne.s      _putls_5
[00001b7e] 2854                      movea.l    (a4),a4
[00001b80] 60f2                      bra.s      _putls_6
_putls_3:
[00001b82] 4aae fffc                 tst.l      -4(a6)
[00001b86] 672c                      beq.s      _putls_7
[00001b88] 0cac 0000 0008 0004       cmpi.l     #$00000008,4(a4)
[00001b90] 6722                      beq.s      _putls_7
_putls_4:
[00001b92] 4aae fffc                 tst.l      -4(a6)
[00001b96] 6604                      bne.s      _putls_8
[00001b98] 7e01                      moveq.l    #1,d7
[00001b9a] 6002                      bra.s      _putls_9
_putls_8:
[00001b9c] 4287                      clr.l      d7
_putls_9:
[00001b9e] 2d47 fffc                 move.l     d7,-4(a6)
[00001ba2] 4878 0001                 pea.l      ($00000001).w
[00001ba6] 2f3c 0002 09e7            move.l     #$00025F37,-(a7)
[00001bac] 4eb9 0000 3fe4            jsr        _putlin
[00001bb2] 508f                      addq.l     #8,a7
_putls_7:
[00001bb4] 2eac 000c                 move.l     12(a4),(a7)
[00001bb8] 2f2c 0008                 move.l     8(a4),-(a7)
[00001bbc] 4eb9 0000 3fe4            jsr        _putlin
[00001bc2] 588f                      addq.l     #4,a7
[00001bc4] 2eac 0014                 move.l     20(a4),(a7)
[00001bc8] 2f2c 0010                 move.l     16(a4),-(a7)
[00001bcc] 4eb9 0000 3fe4            jsr        _putlin
[00001bd2] 588f                      addq.l     #4,a7
[00001bd4] 2854                      movea.l    (a4),a4
[00001bd6] 6084                      bra.s      _putls_10
_putls_2:
[00001bd8] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[00001bdc] 4e5e                      unlk       a6
[00001bde] 4e75                      rts
_putls_5:
[00001be0] 4eba fed0                 jsr        _putfile(pc)
[00001be4] 4eb9 0000 3322            jsr        _ptline
_putls_11:
[00001bea] 0cad 0000 0002 0004       cmpi.l     #$00000002,4(a5)
[00001bf2] 67e4                      beq.s      _putls_2
[00001bf4] 2e2d 0004                 move.l     4(a5),d7
[00001bf8] 41f9 0002 09aa            lea.l      $00025EFA,a0
[00001bfe] 4ef9 0000 4770            jmp        a.switch
[00001c04] 2e8d                      move.l     a5,(a7)
[00001c06] 4eba fbba                 jsr        _lexident(pc)
[00001c0a] 2a47                      movea.l    d7,a5
[00001c0c] 60dc                      bra.s      _putls_11
[00001c0e] 60da                      bra.s      _putls_11
[00001c10] 2e8d                      move.l     a5,(a7)
[00001c12] 4eba fcfa                 jsr        _lexstrin(pc)
[00001c16] 2a47                      movea.l    d7,a5
[00001c18] 60d0                      bra.s      _putls_11
[00001c1a] 2e8d                      move.l     a5,(a7)
[00001c1c] 4eba fd42                 jsr        _lexxstr(pc)
[00001c20] 2a47                      movea.l    d7,a5
[00001c22] 60c6                      bra.s      _putls_11
[00001c24] 2e8d                      move.l     a5,(a7)
[00001c26] 4eba f8a4                 jsr        _lexchars(pc)
[00001c2a] 2a47                      movea.l    d7,a5
[00001c2c] 60bc                      bra.s      _putls_11
[00001c2e] 45f8 000c                 lea.l      ($0000000C).w,a2
[00001c32] d5d5                      adda.l     (a5),a2
[00001c34] 4a92                      tst.l      (a2)
[00001c36] 6656                      bne.s      _putls_12
[00001c38] 45f8 0014                 lea.l      ($00000014).w,a2
[00001c3c] d5d5                      adda.l     (a5),a2
[00001c3e] 0c92 0000 0001            cmpi.l     #$00000001,(a2)
[00001c44] 6648                      bne.s      _putls_12
[00001c46] 45f8 0010                 lea.l      ($00000010).w,a2
[00001c4a] d5d5                      adda.l     (a5),a2
[00001c4c] 2452                      movea.l    (a2),a2
[00001c4e] 4287                      clr.l      d7
[00001c50] 1e12                      move.b     (a2),d7
[00001c52] 0c47 002e                 cmpi.w     #$002E,d7
[00001c56] 6636                      bne.s      _putls_12
[00001c58] 2455                      movea.l    (a5),a2
[00001c5a] 4a92                      tst.l      (a2)
[00001c5c] 676e                      beq.s      _putls_13
[00001c5e] 45f8 000c                 lea.l      ($0000000C).w,a2
[00001c62] 2655                      movea.l    (a5),a3
[00001c64] d5d3                      adda.l     (a3),a2
[00001c66] 4a92                      tst.l      (a2)
[00001c68] 6662                      bne.s      _putls_13
[00001c6a] 45f8 0014                 lea.l      ($00000014).w,a2
[00001c6e] 2655                      movea.l    (a5),a3
[00001c70] d5d3                      adda.l     (a3),a2
[00001c72] 0c92 0000 0001            cmpi.l     #$00000001,(a2)
[00001c78] 6652                      bne.s      _putls_13
[00001c7a] 45f8 0010                 lea.l      ($00000010).w,a2
[00001c7e] 2655                      movea.l    (a5),a3
[00001c80] d5d3                      adda.l     (a3),a2
[00001c82] 2452                      movea.l    (a2),a2
[00001c84] 4287                      clr.l      d7
[00001c86] 1e12                      move.b     (a2),d7
[00001c88] 0c47 002e                 cmpi.w     #$002E,d7
[00001c8c] 663e                      bne.s      _putls_13
_putls_12:
[00001c8e] 2ebc 0002 09e2            move.l     #$00025F32,(a7)
[00001c94] 2f2d 0014                 move.l     20(a5),-(a7)
[00001c98] 2f2d 0010                 move.l     16(a5),-(a7)
[00001c9c] 4eb9 0000 3f04            jsr        _inbuf
[00001ca2] 508f                      addq.l     #8,a7
[00001ca4] 2a07                      move.l     d7,d5
[00001ca6] baad 0014                 cmp.l      20(a5),d5
[00001caa] 642c                      bcc.s      _putls_14
[00001cac] 246d 0010                 movea.l    16(a5),a2
[00001cb0] d5c5                      adda.l     d5,a2
[00001cb2] 4287                      clr.l      d7
[00001cb4] 1e12                      move.b     (a2),d7
[00001cb6] 0c47 0065                 cmpi.w     #$0065,d7
[00001cba] 6710                      beq.s      _putls_13
[00001cbc] 246d 0010                 movea.l    16(a5),a2
[00001cc0] d5c5                      adda.l     d5,a2
[00001cc2] 4287                      clr.l      d7
[00001cc4] 1e12                      move.b     (a2),d7
[00001cc6] 0c47 0045                 cmpi.w     #$0045,d7
[00001cca] 660c                      bne.s      _putls_14
_putls_13:
[00001ccc] 2e8d                      move.l     a5,(a7)
[00001cce] 4eba f882                 jsr        _lexfloat(pc)
[00001cd2] 2a47                      movea.l    d7,a5
[00001cd4] 6000 ff14                 bra        _putls_11
_putls_14:
[00001cd8] 2e8d                      move.l     a5,(a7)
[00001cda] 4eba fb98                 jsr        _lexint(pc)
[00001cde] 2a47                      movea.l    d7,a5
[00001ce0] 6000 ff08                 bra        _putls_11
[00001ce4] 2a55                      movea.l    (a5),a5
[00001ce6] 6000 ff02                 bra        _putls_11
[00001cea] 0cad 0000 0001 0014       cmpi.l     #$00000001,20(a5)
[00001cf2] 6630                      bne.s      _putls_15
[00001cf4] 246d 0010                 movea.l    16(a5),a2
[00001cf8] 4287                      clr.l      d7
[00001cfa] 1e12                      move.b     (a2),d7
[00001cfc] 0c47 002e                 cmpi.w     #$002E,d7
[00001d00] 6622                      bne.s      _putls_15
[00001d02] 45f8 000c                 lea.l      ($0000000C).w,a2
[00001d06] d5d5                      adda.l     (a5),a2
[00001d08] 4a92                      tst.l      (a2)
[00001d0a] 6618                      bne.s      _putls_15
[00001d0c] 2455                      movea.l    (a5),a2
[00001d0e] 588a                      addq.l     #4,a2
[00001d10] 0c92 0000 0004            cmpi.l     #$00000004,(a2)
[00001d16] 660c                      bne.s      _putls_15
[00001d18] 2e8d                      move.l     a5,(a7)
[00001d1a] 4eba f836                 jsr        _lexfloat(pc)
[00001d1e] 2a47                      movea.l    d7,a5
[00001d20] 6000 fec8                 bra        _putls_11
_putls_15:
[00001d24] 2e8d                      move.l     a5,(a7)
[00001d26] 4eba fbbe                 jsr        _lexpunct(pc)
[00001d2a] 2a47                      movea.l    d7,a5
[00001d2c] 6000 febc                 bra        _putls_11

_getex:
[00001d30] 4e56 0000                 link       a6,#0
[00001d34] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00001d38] 2eae 0008                 move.l     8(a6),(a7)
[00001d3c] 4eb9 0000 1ecc            jsr        _getinl
[00001d42] 2a47                      movea.l    d7,a5
[00001d44] 2e0d                      move.l     a5,d7
[00001d46] 671c                      beq.s      _getex_1
[00001d48] 0cad 0000 0001 0014       cmpi.l     #$00000001,20(a5)
[00001d50] 661c                      bne.s      _getex_2
[00001d52] 246d 0010                 movea.l    16(a5),a2
[00001d56] 4287                      clr.l      d7
[00001d58] 1e12                      move.b     (a2),d7
[00001d5a] beb9 0002 0a32            cmp.l      $00025F82,d7
[00001d60] 6726                      beq.s      _getex_3
[00001d62] 600a                      bra.s      _getex_2
_getex_1:
[00001d64] 2e0d                      move.l     a5,d7
[00001d66] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00001d6a] 4e5e                      unlk       a6
[00001d6c] 4e75                      rts
_getex_2:
[00001d6e] 0cad 0000 0001 0014       cmpi.l     #$00000001,20(a5)
[00001d76] 6624                      bne.s      _getex_4
[00001d78] 246d 0010                 movea.l    16(a5),a2
[00001d7c] 4287                      clr.l      d7
[00001d7e] 1e12                      move.b     (a2),d7
[00001d80] beb9 0002 0a36            cmp.l      $00025F86,d7
[00001d86] 6614                      bne.s      _getex_4
_getex_3:
[00001d88] 4aae 0008                 tst.l      8(a6)
[00001d8c] 671e                      beq.s      _getex_5
[00001d8e] 2ebc 0002 0cae            move.l     #$000261FE,(a7)
[00001d94] 4eb9 0000 310e            jsr        _p0error
[00001d9a] 6010                      bra.s      _getex_5
_getex_4:
[00001d9c] 2e2d 0004                 move.l     4(a5),d7
[00001da0] 41f9 0002 0c5e            lea.l      $000261AE,a0
[00001da6] 4ef9 0000 4770            jmp        a.switch
_getex_5:
[00001dac] 45f8 0014                 lea.l      ($00000014).w,a2
[00001db0] d5d5                      adda.l     (a5),a2
[00001db2] 2e92                      move.l     (a2),(a7)
[00001db4] 45f8 0010                 lea.l      ($00000010).w,a2
[00001db8] d5d5                      adda.l     (a5),a2
[00001dba] 2f12                      move.l     (a2),-(a7)
[00001dbc] 4878 0018                 pea.l      ($00000018).w
[00001dc0] 2f3c 0002 0af8            move.l     #$00026048,-(a7)
[00001dc6] 4eb9 0000 336e            jsr        _scntab
[00001dcc] 4fef 000c                 lea.l      12(a7),a7
[00001dd0] 2a07                      move.l     d7,d5
[00001dd2] 6714                      beq.s      _getex_6
[00001dd4] 2e95                      move.l     (a5),(a7)
[00001dd6] 2f0d                      move.l     a5,-(a7)
[00001dd8] 4eb9 0000 2b20            jsr        _fretlist
[00001dde] 588f                      addq.l     #4,a7
[00001de0] 2a47                      movea.l    d7,a5
[00001de2] 2b45 0004                 move.l     d5,4(a5)
[00001de6] 60b4                      bra.s      _getex_4
_getex_6:
[00001de8] 7014                      moveq.l    #20,d0
[00001dea] 2b40 0004                 move.l     d0,4(a5)
[00001dee] 60ac                      bra.s      _getex_4
[00001df0] 4297                      clr.l      (a7)
[00001df2] 2f0d                      move.l     a5,-(a7)
[00001df4] 4eb9 0000 0708            jsr        _doexp
[00001dfa] 588f                      addq.l     #4,a7
[00001dfc] 2a47                      movea.l    d7,a5
[00001dfe] 6000 ff64                 bra        _getex_1
[00001e02] 6000 ff60                 bra        _getex_1
[00001e06] 6000 ff5c                 bra        _getex_1
[00001e0a] 6000 ff58                 bra        _getex_1
[00001e0e] 6000 ff54                 bra        _getex_1
[00001e12] 5279 0002 0a3a            addq.w     #1,$00025F8A
[00001e18] 4297                      clr.l      (a7)
[00001e1a] 2f0d                      move.l     a5,-(a7)
[00001e1c] 4eb9 0000 0708            jsr        _doexp
[00001e22] 588f                      addq.l     #4,a7
[00001e24] 2a47                      movea.l    d7,a5
[00001e26] 5379 0002 0a3a            subq.w     #1,$00025F8A
[00001e2c] 6000 ff36                 bra        _getex_1
[00001e30] 2455                      movea.l    (a5),a2
[00001e32] 588a                      addq.l     #4,a2
[00001e34] 0c92 0000 0003            cmpi.l     #$00000003,(a2)
[00001e3a] 671a                      beq.s      _getex_7
[00001e3c] 2ead 0014                 move.l     20(a5),(a7)
[00001e40] 2f2d 0010                 move.l     16(a5),-(a7)
[00001e44] 2f3c 0002 0ca6            move.l     #$000261F6,-(a7)
[00001e4a] 4eb9 0000 310e            jsr        _p0error
[00001e50] 508f                      addq.l     #8,a7
[00001e52] 6000 ff10                 bra        _getex_1
_getex_7:
[00001e56] 4297                      clr.l      (a7)
[00001e58] 45f8 0014                 lea.l      ($00000014).w,a2
[00001e5c] d5d5                      adda.l     (a5),a2
[00001e5e] 2f12                      move.l     (a2),-(a7)
[00001e60] 45f8 0010                 lea.l      ($00000010).w,a2
[00001e64] d5d5                      adda.l     (a5),a2
[00001e66] 2f12                      move.l     (a2),-(a7)
[00001e68] 4eb9 0000 2e8a            jsr        _lookup
[00001e6e] 508f                      addq.l     #8,a7
[00001e70] 4a87                      tst.l      d7
[00001e72] 6600 fef0                 bne        _getex_1
[00001e76] 45f8 0014                 lea.l      ($00000014).w,a2
[00001e7a] d5d5                      adda.l     (a5),a2
[00001e7c] 2e92                      move.l     (a2),(a7)
[00001e7e] 45f8 0010                 lea.l      ($00000010).w,a2
[00001e82] d5d5                      adda.l     (a5),a2
[00001e84] 2f12                      move.l     (a2),-(a7)
[00001e86] 4878 0003                 pea.l      ($00000003).w
[00001e8a] 2f3c 0002 0082            move.l     #$000255D2,-(a7)
[00001e90] 4eb9 0000 336e            jsr        _scntab
[00001e96] 4fef 000c                 lea.l      12(a7),a7
[00001e9a] 4a87                      tst.l      d7
[00001e9c] 6600 fec6                 bne        _getex_1
[00001ea0] 4297                      clr.l      (a7)
[00001ea2] 2f15                      move.l     (a5),-(a7)
[00001ea4] 4eb9 0000 2b20            jsr        _fretlist
[00001eaa] 588f                      addq.l     #4,a7
[00001eac] 2a87                      move.l     d7,(a5)
[00001eae] 6000 feb4                 bra        _getex_1
[00001eb2] 4aae 0008                 tst.l      8(a6)
[00001eb6] 6600 feac                 bne        _getex_1
[00001eba] 4297                      clr.l      (a7)
[00001ebc] 2f0d                      move.l     a5,-(a7)
[00001ebe] 4eb9 0000 0708            jsr        _doexp
[00001ec4] 588f                      addq.l     #4,a7
[00001ec6] 2a47                      movea.l    d7,a5
[00001ec8] 6000 fe9a                 bra        _getex_1

_getinl:
[00001ecc] 4e56 fff8                 link       a6,#-8
[00001ed0] 4ab9 0002 0cca            tst.l      $0002621A
[00001ed6] 6614                      bne.s      _getinl_1
[00001ed8] 4297                      clr.l      (a7)
[00001eda] 4878 0200                 pea.l      ($00000200).w
[00001ede] 4eb9 0000 486e            jsr        _alloc
[00001ee4] 588f                      addq.l     #4,a7
[00001ee6] 23c7 0002 0cca            move.l     d7,$0002621A
_getinl_1:
[00001eec] 4aae 0008                 tst.l      8(a6)
[00001ef0] 6606                      bne.s      _getinl_2
[00001ef2] 42b9 0002 0cc6            clr.l      $00026216
_getinl_2:
[00001ef8] 4ab9 0002 0a6c            tst.l      $00025FBC
[00001efe] 660c                      bne.s      _getinl_3
[00001f00] 4eb9 0000 2efe            jsr        _nxtfile
[00001f06] 23c7 0002 0a6c            move.l     d7,$00025FBC
_getinl_3:
[00001f0c] 4ab9 0002 0a6c            tst.l      $00025FBC
[00001f12] 6606                      bne.s      _getinl_4
[00001f14] 4287                      clr.l      d7
[00001f16] 4e5e                      unlk       a6
[00001f18] 4e75                      rts
_getinl_4:
[00001f1a] 2e3c 0000 0200            move.l     #$00000200,d7
[00001f20] 9eb9 0002 0cc6            sub.l      $00026216,d7
[00001f26] 2e87                      move.l     d7,(a7)
[00001f28] 2e39 0002 0cca            move.l     $0002621A,d7
[00001f2e] deb9 0002 0cc6            add.l      $00026216,d7
[00001f34] 2f07                      move.l     d7,-(a7)
[00001f36] 2f39 0002 0a6c            move.l     $00025FBC,-(a7)
[00001f3c] 4eb9 0000 2018            jsr        _getln
[00001f42] 508f                      addq.l     #8,a7
[00001f44] 2d47 fffc                 move.l     d7,-4(a6)
[00001f48] 672e                      beq.s      _getinl_5
[00001f4a] 2e2e fffc                 move.l     -4(a6),d7
[00001f4e] dfb9 0002 0cc6            add.l      d7,$00026216
[00001f54] 2ebc 0002 0cc2            move.l     #$00026212,(a7)
[00001f5a] 2e39 0002 0cc6            move.l     $00026216,d7
[00001f60] 9eae fffc                 sub.l      -4(a6),d7
[00001f64] deb9 0002 0cca            add.l      $0002621A,d7
[00001f6a] 2f07                      move.l     d7,-(a7)
[00001f6c] 4eb9 0000 340e            jsr        _stotl
[00001f72] 588f                      addq.l     #4,a7
[00001f74] 4e5e                      unlk       a6
[00001f76] 4e75                      rts
_getinl_5:
[00001f78] 4ab9 0002 0cc2            tst.l      $00026212
[00001f7e] 6726                      beq.s      _getinl_6
[00001f80] 2ebc 0002 0cd0            move.l     #$00026220,(a7)
[00001f86] 4eb9 0000 310e            jsr        _p0error
[00001f8c] 42b9 0002 0cc2            clr.l      $00026212
[00001f92] 4297                      clr.l      (a7)
[00001f94] 2f3c 0002 0cce            move.l     #$0002621E,-(a7)
[00001f9a] 4eb9 0000 340e            jsr        _stotl
[00001fa0] 588f                      addq.l     #4,a7
[00001fa2] 4e5e                      unlk       a6
[00001fa4] 4e75                      rts
_getinl_6:
[00001fa6] 2479 0002 0a6c            movea.l    $00025FBC,a2
[00001fac] 508a                      addq.l     #8,a2
[00001fae] 5252                      addq.w     #1,(a2)
[00001fb0] 4eb9 0000 3322            jsr        _ptline
[00001fb6] 7e0a                      moveq.l    #10,d7
[00001fb8] deb9 0002 0a6c            add.l      $00025FBC,d7
[00001fbe] 2e87                      move.l     d7,(a7)
[00001fc0] 4eb9 0000 37f0            jsr        _fclose
[00001fc6] 4297                      clr.l      (a7)
[00001fc8] 2479 0002 0a6c            movea.l    $00025FBC,a2
[00001fce] 588a                      addq.l     #4,a2
[00001fd0] 2f12                      move.l     (a2),-(a7)
[00001fd2] 4eb9 0000 49de            jsr        _free
[00001fd8] 588f                      addq.l     #4,a7
[00001fda] 2479 0002 0a6c            movea.l    $00025FBC,a2
[00001fe0] 2e92                      move.l     (a2),(a7)
[00001fe2] 2f39 0002 0a6c            move.l     $00025FBC,-(a7)
[00001fe8] 4eb9 0000 49de            jsr        _free
[00001fee] 588f                      addq.l     #4,a7
[00001ff0] 23c7 0002 0a6c            move.l     d7,$00025FBC
[00001ff6] 7001                      moveq.l    #1,d0
[00001ff8] 23c0 0002 0a5e            move.l     d0,$00025FAE
[00001ffe] 4eb9 0000 1ab2            jsr        _putfile
[00002004] 4a79 0002 0a3c            tst.w      $00025F8C
[0000200a] 6700 feec                 beq        _getinl_2
[0000200e] 5379 0002 0a3c            subq.w     #1,$00025F8C
[00002014] 6000 fee2                 bra        _getinl_2

_getln:
[00002018] 4e56 0000                 link       a6,#0
[0000201c] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00002020] 2a6e 000c                 movea.l    12(a6),a5
[00002024] 53ae 0010                 subq.l     #1,16(a6)
[00002028] 284d                      movea.l    a5,a4
_getln_5:
[0000202a] 2e2e 0010                 move.l     16(a6),d7
[0000202e] 2c0c                      move.l     a4,d6
[00002030] 9c8d                      sub.l      a5,d6
[00002032] 9e86                      sub.l      d6,d7
[00002034] 2e87                      move.l     d7,(a7)
[00002036] 2f0c                      move.l     a4,-(a7)
[00002038] 7e0a                      moveq.l    #10,d7
[0000203a] deae 0008                 add.l      8(a6),d7
[0000203e] 2f07                      move.l     d7,-(a7)
[00002040] 4eb9 0000 43b4            jsr        _getl
[00002046] 508f                      addq.l     #8,a7
[00002048] 2a07                      move.l     d7,d5
[0000204a] 6f36                      ble.s      _getln_1
[0000204c] 246e 0008                 movea.l    8(a6),a2
[00002050] 508a                      addq.l     #8,a2
[00002052] 5252                      addq.w     #1,(a2)
[00002054] 246e 0008                 movea.l    8(a6),a2
[00002058] 508a                      addq.l     #8,a2
[0000205a] 33d2 0002 0a66            move.w     (a2),$00025FB6
[00002060] d9c5                      adda.l     d5,a4
[00002062] 0c85 0000 0001            cmpi.l     #$00000001,d5
[00002068] 6d18                      blt.s      _getln_1
[0000206a] 4287                      clr.l      d7
[0000206c] 1e2c fffe                 move.b     -2(a4),d7
[00002070] 0c47 005c                 cmpi.w     #$005C,d7
[00002074] 660c                      bne.s      _getln_1
[00002076] 4287                      clr.l      d7
[00002078] 1e2c ffff                 move.b     -1(a4),d7
[0000207c] 0c47 000a                 cmpi.w     #$000A,d7
[00002080] 6712                      beq.s      _getln_2
_getln_1:
[00002082] 4214                      clr.b      (a4)
[00002084] 2e0d                      move.l     a5,d7
[00002086] deae 0010                 add.l      16(a6),d7
[0000208a] b9c7                      cmpa.l     d7,a4
[0000208c] 640a                      bcc.s      _getln_3
[0000208e] 2e0c                      move.l     a4,d7
[00002090] 9e8d                      sub.l      a5,d7
[00002092] 6020                      bra.s      _getln_4
_getln_2:
[00002094] 558c                      subq.l     #2,a4
[00002096] 6092                      bra.s      _getln_5
_getln_3:
[00002098] 2ebc 0002 0cec            move.l     #$0002623C,(a7)
[0000209e] 4eb9 0000 310e            jsr        _p0error
[000020a4] 244d                      movea.l    a5,a2
[000020a6] d5ee 0010                 adda.l     16(a6),a2
[000020aa] 14bc 000a                 move.b     #$0A,(a2)
[000020ae] 2e2e 0010                 move.l     16(a6),d7
[000020b2] 5287                      addq.l     #1,d7
_getln_4:
[000020b4] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000020b8] 4e5e                      unlk       a6
[000020ba] 4e75                      rts

_main:
[000020bc] 4e56 fffe                 link       a6,#-2
[000020c0] 48e7 8004                 movem.l    d0/a5,-(a7)
[000020c4] 23ee 000c 0002 0a70       move.l     12(a6),$00025FC0
[000020cc] 23ee 0008 0002 0a62       move.l     8(a6),$00025FB2
[000020d4] 2ebc 0002 0a2e            move.l     #$00025F7E,(a7)
[000020da] 2f3c 0002 0a36            move.l     #$00025F86,-(a7)
[000020e0] 2f3c 0002 0a2a            move.l     #$00025F7A,-(a7)
[000020e6] 2f3c 0002 0a32            move.l     #$00025F82,-(a7)
[000020ec] 2f3c 0002 0a26            move.l     #$00025F76,-(a7)
[000020f2] 2f3c 0002 0a16            move.l     #$00025F66,-(a7)
[000020f8] 2f3c 0002 0a22            move.l     #$00025F72,-(a7)
[000020fe] 2f3c 0002 0a4a            move.l     #$00025F9A,-(a7)
[00002104] 2f3c 0002 0a1e            move.l     #$00025F6E,-(a7)
[0000210a] 2f3c 0002 0a44            move.l     #$00025F94,-(a7)
[00002110] 2f3c 0002 0a1a            move.l     #$00025F6A,-(a7)
[00002116] 2f3c 0002 09ea            move.l     #$00025F3A,-(a7)
[0000211c] 2f3c 0002 0d4a            move.l     #$0002629A,-(a7)
[00002122] 2f3c 0002 0a70            move.l     #$00025FC0,-(a7)
[00002128] 2f3c 0002 0a62            move.l     #$00025FB2,-(a7)
[0000212e] 4eb9 0000 3ac8            jsr        _getflags
[00002134] 4fef 0038                 lea.l      56(a7),a7
[00002138] 4ab9 0002 0a16            tst.l      $00025F66
[0000213e] 6608                      bne.s      _main_1
[00002140] 3d7c 0001 fffe            move.w     #$0001,-2(a6)
[00002146] 6046                      bra.s      _main_2
_main_1:
[00002148] 4ab9 0002 0a2e            tst.l      $00025F7E
[0000214e] 6704                      beq.s      _main_3
[00002150] 7e01                      moveq.l    #1,d7
[00002152] 6002                      bra.s      _main_4
_main_3:
[00002154] 4287                      clr.l      d7
_main_4:
[00002156] 2e87                      move.l     d7,(a7)
[00002158] 4878 0001                 pea.l      ($00000001).w
[0000215c] 2f39 0002 0a16            move.l     $00025F66,-(a7)
[00002162] 4eb9 0000 40ec            jsr        _create
[00002168] 508f                      addq.l     #8,a7
[0000216a] 3d47 fffe                 move.w     d7,-2(a6)
[0000216e] 6c16                      bge.s      _main_5
[00002170] 2eb9 0002 0a16            move.l     $00025F66,(a7)
[00002176] 2f3c 0002 0d3c            move.l     #$0002628C,-(a7)
[0000217c] 4eb9 0000 550a            jsr        _error
[00002182] 588f                      addq.l     #4,a7
[00002184] 6008                      bra.s      _main_2
_main_5:
[00002186] 33fc 0001 0002 0a6a       move.w     #$0001,$00025FBA
_main_2:
[0000218e] 4878 0001                 pea.l      ($00000001).w
[00002192] 3e2e fffe                 move.w     -2(a6),d7
[00002196] 48c7                      ext.l      d7
[00002198] 2f07                      move.l     d7,-(a7)
[0000219a] 2f3c 0002 1114            move.l     #$00026664,-(a7)
[000021a0] 4eb9 0000 42c0            jsr        _finit
[000021a6] 4fef 000c                 lea.l      12(a7),a7
[000021aa] 4ab9 0002 0a2e            tst.l      $00025F7E
[000021b0] 6762                      beq.s      _main_6
[000021b2] 4ab9 0002 0a22            tst.l      $00025F72
[000021b8] 665a                      bne.s      _main_6
[000021ba] 2ebc 0000 00bd            move.l     #$000000BD,(a7)
[000021c0] 2f3c 0002 0d3a            move.l     #$0002628A,-(a7)
[000021c6] 4eb9 0000 19aa            jsr        _putcode
[000021cc] 588f                      addq.l     #4,a7
[000021ce] 2e39 0002 0a62            move.l     $00025FB2,d7
[000021d4] e587                      asl.l      #2,d7
[000021d6] 2447                      movea.l    d7,a2
[000021d8] 598a                      subq.l     #4,a2
[000021da] d5f9 0002 0a70            adda.l     $00025FC0,a2
[000021e0] 2e92                      move.l     (a2),(a7)
[000021e2] 2e39 0002 0a62            move.l     $00025FB2,d7
[000021e8] e587                      asl.l      #2,d7
[000021ea] 2447                      movea.l    d7,a2
[000021ec] 598a                      subq.l     #4,a2
[000021ee] d5f9 0002 0a70            adda.l     $00025FC0,a2
[000021f4] 2f12                      move.l     (a2),-(a7)
[000021f6] 4eb9 0000 52f4            jsr        _lenstr
[000021fc] 588f                      addq.l     #4,a7
[000021fe] 2f07                      move.l     d7,-(a7)
[00002200] 4878 0013                 pea.l      ($00000013).w
[00002204] 2f3c 0002 0d36            move.l     #$00026286,-(a7)
[0000220a] 4eb9 0000 19aa            jsr        _putcode
[00002210] 4fef 000c                 lea.l      12(a7),a7
_main_6:
[00002214] 4eb9 0000 2efe            jsr        _nxtfile
[0000221a] 23c7 0002 0a6c            move.l     d7,$00025FBC
[00002220] 4eb9 0000 1ab2            jsr        _putfile
[00002226] 2ebc 0002 09ea            move.l     #$00025F3A,(a7)
[0000222c] 4eb9 0000 3236            jsr        _predef
[00002232] 4ab9 0002 0a4a            tst.l      $00025F9A
[00002238] 677a                      beq.s      _main_7
[0000223a] 4878 0001                 pea.l      ($00000001).w
[0000223e] 42a7                      clr.l      -(a7)
[00002240] 2f39 0002 0a4a            move.l     $00025F9A,-(a7)
[00002246] 4eb9 0000 4588            jsr        _open
[0000224c] 4fef 000c                 lea.l      12(a7),a7
[00002250] 3d47 fffe                 move.w     d7,-2(a6)
[00002254] 6c16                      bge.s      _main_8
[00002256] 2eb9 0002 0a4a            move.l     $00025F9A,(a7)
[0000225c] 2f3c 0002 0d1e            move.l     #$0002626E,-(a7)
[00002262] 4eb9 0000 2b00            jsr        _fatal
[00002268] 588f                      addq.l     #4,a7
[0000226a] 6048                      bra.s      _main_7
_main_8:
[0000226c] 2ebc 0000 0100            move.l     #$00000100,(a7)
[00002272] 2f3c 0002 04e6            move.l     #$00025A36,-(a7)
[00002278] 3e2e fffe                 move.w     -2(a6),d7
[0000227c] 48c7                      ext.l      d7
[0000227e] 2f07                      move.l     d7,-(a7)
[00002280] 4eb9 0000 389e            jsr        _fread
[00002286] 508f                      addq.l     #8,a7
[00002288] 0c87 0000 0100            cmpi.l     #$00000100,d7
[0000228e] 6716                      beq.s      _main_9
[00002290] 2eb9 0002 0a4a            move.l     $00025F9A,(a7)
[00002296] 2f3c 0002 0d06            move.l     #$00026256,-(a7)
[0000229c] 4eb9 0000 2b00            jsr        _fatal
[000022a2] 588f                      addq.l     #4,a7
[000022a4] 600e                      bra.s      _main_7
_main_9:
[000022a6] 3e2e fffe                 move.w     -2(a6),d7
[000022aa] 48c7                      ext.l      d7
[000022ac] 2e87                      move.l     d7,(a7)
[000022ae] 4eb9 0000 4cd6            jsr        _close
_main_7:
[000022b4] 4297                      clr.l      (a7)
[000022b6] 42a7                      clr.l      -(a7)
[000022b8] 4eba fa76                 jsr        _getex(pc)
[000022bc] 588f                      addq.l     #4,a7
[000022be] 2f07                      move.l     d7,-(a7)
[000022c0] 4eb9 0000 231c            jsr        _putgr
[000022c6] 588f                      addq.l     #4,a7
[000022c8] 2a47                      movea.l    d7,a5
[000022ca] 2e0d                      move.l     a5,d7
[000022cc] 6724                      beq.s      _main_10
[000022ce] 2ead 0014                 move.l     20(a5),(a7)
[000022d2] 2f2d 0010                 move.l     16(a5),-(a7)
[000022d6] 2f3c 0002 0cf8            move.l     #$00026248,-(a7)
[000022dc] 4eb9 0000 310e            jsr        _p0error
[000022e2] 508f                      addq.l     #8,a7
[000022e4] 4297                      clr.l      (a7)
[000022e6] 2f0d                      move.l     a5,-(a7)
[000022e8] 4eb9 0000 2b20            jsr        _fretlist
[000022ee] 588f                      addq.l     #4,a7
[000022f0] 60c2                      bra.s      _main_7
_main_10:
[000022f2] 2ebc 0002 1114            move.l     #$00026664,(a7)
[000022f8] 4eb9 0000 37f0            jsr        _fclose
[000022fe] 4a79 0002 0a68            tst.w      $00025FB8
[00002304] 6708                      beq.s      _main_11
[00002306] 4ab9 0002 0a1a            tst.l      $00025F6A
[0000230c] 6704                      beq.s      _main_12
_main_11:
[0000230e] 7e01                      moveq.l    #1,d7
[00002310] 6002                      bra.s      _main_13
_main_12:
[00002312] 4287                      clr.l      d7
_main_13:
[00002314] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00002318] 4e5e                      unlk       a6
[0000231a] 4e75                      rts

_putgr:
[0000231c] 4e56 0000                 link       a6,#0
[00002320] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00002324] 2a6e 0008                 movea.l    8(a6),a5
[00002328] 2a2e 000c                 move.l     12(a6),d5
_putgr_9:
[0000232c] 2e0d                      move.l     a5,d7
[0000232e] 674e                      beq.s      _putgr_1
[00002330] 0cad 0000 000c 0004       cmpi.l     #$0000000C,4(a5)
[00002338] 6744                      beq.s      _putgr_1
[0000233a] 0cad 0000 000d 0004       cmpi.l     #$0000000D,4(a5)
[00002342] 673a                      beq.s      _putgr_1
[00002344] 0cad 0000 000b 0004       cmpi.l     #$0000000B,4(a5)
[0000234c] 6730                      beq.s      _putgr_1
[0000234e] 0cad 0000 000e 0004       cmpi.l     #$0000000E,4(a5)
[00002356] 6730                      beq.s      _putgr_2
[00002358] 0cad 0000 000f 0004       cmpi.l     #$0000000F,4(a5)
[00002360] 6726                      beq.s      _putgr_2
[00002362] 0cad 0000 0010 0004       cmpi.l     #$00000010,4(a5)
[0000236a] 671c                      beq.s      _putgr_2
[0000236c] 4a85                      tst.l      d5
[0000236e] 6736                      beq.s      _putgr_3
[00002370] 4297                      clr.l      (a7)
[00002372] 2f0d                      move.l     a5,-(a7)
[00002374] 4eb9 0000 2b20            jsr        _fretlist
[0000237a] 588f                      addq.l     #4,a7
[0000237c] 6030                      bra.s      _putgr_4
_putgr_1:
[0000237e] 2e0d                      move.l     a5,d7
[00002380] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00002384] 4e5e                      unlk       a6
[00002386] 4e75                      rts
_putgr_2:
[00002388] 0cad 0000 000e 0004       cmpi.l     #$0000000E,4(a5)
[00002390] 6628                      bne.s      _putgr_5
[00002392] 4a85                      tst.l      d5
[00002394] 6704                      beq.s      _putgr_6
[00002396] 4287                      clr.l      d7
[00002398] 6008                      bra.s      _putgr_7
_putgr_6:
[0000239a] 2e95                      move.l     (a5),(a7)
[0000239c] 4eb9 0000 0d80            jsr        _eval
_putgr_7:
[000023a2] 2807                      move.l     d7,d4
[000023a4] 6038                      bra.s      _putgr_8
_putgr_3:
[000023a6] 2e8d                      move.l     a5,(a7)
[000023a8] 4eb9 0000 2508            jsr        _putns
_putgr_4:
[000023ae] 4297                      clr.l      (a7)
[000023b0] 4eba f97e                 jsr        _getex(pc)
[000023b4] 2a47                      movea.l    d7,a5
[000023b6] 6000 ff74                 bra        _putgr_9
_putgr_5:
[000023ba] 0cad 0000 000f 0004       cmpi.l     #$0000000F,4(a5)
[000023c2] 660e                      bne.s      _putgr_10
[000023c4] 4a95                      tst.l      (a5)
[000023c6] 6704                      beq.s      _putgr_11
[000023c8] 7e01                      moveq.l    #1,d7
[000023ca] 6002                      bra.s      _putgr_12
_putgr_11:
[000023cc] 4287                      clr.l      d7
_putgr_12:
[000023ce] 2807                      move.l     d7,d4
[000023d0] 600c                      bra.s      _putgr_8
_putgr_10:
[000023d2] 4a95                      tst.l      (a5)
[000023d4] 6604                      bne.s      _putgr_13
[000023d6] 7e01                      moveq.l    #1,d7
[000023d8] 6002                      bra.s      _putgr_14
_putgr_13:
[000023da] 4287                      clr.l      d7
_putgr_14:
[000023dc] 2807                      move.l     d7,d4
_putgr_8:
[000023de] 4297                      clr.l      (a7)
[000023e0] 2f0d                      move.l     a5,-(a7)
[000023e2] 4eb9 0000 2b20            jsr        _fretlist
[000023e8] 588f                      addq.l     #4,a7
[000023ea] 4a85                      tst.l      d5
[000023ec] 6604                      bne.s      _putgr_15
[000023ee] 4a84                      tst.l      d4
[000023f0] 6604                      bne.s      _putgr_16
_putgr_15:
[000023f2] 7e01                      moveq.l    #1,d7
[000023f4] 6002                      bra.s      _putgr_17
_putgr_16:
[000023f6] 4287                      clr.l      d7
_putgr_17:
[000023f8] 2e87                      move.l     d7,(a7)
[000023fa] 42a7                      clr.l      -(a7)
[000023fc] 4eba f932                 jsr        _getex(pc)
[00002400] 588f                      addq.l     #4,a7
[00002402] 2f07                      move.l     d7,-(a7)
[00002404] 4eba ff16                 jsr        _putgr(pc)
[00002408] 588f                      addq.l     #4,a7
[0000240a] 2a47                      movea.l    d7,a5
_putgr_25:
[0000240c] 2e0d                      move.l     a5,d7
[0000240e] 6752                      beq.s      _putgr_18
[00002410] 0cad 0000 000b 0004       cmpi.l     #$0000000B,4(a5)
[00002418] 6648                      bne.s      _putgr_18
[0000241a] 4a84                      tst.l      d4
[0000241c] 6600 0082                 bne        _putgr_19
[00002420] 4a85                      tst.l      d5
[00002422] 6704                      beq.s      _putgr_20
[00002424] 4287                      clr.l      d7
[00002426] 6008                      bra.s      _putgr_21
_putgr_20:
[00002428] 2e95                      move.l     (a5),(a7)
[0000242a] 4eb9 0000 0d80            jsr        _eval
_putgr_21:
[00002430] 2807                      move.l     d7,d4
[00002432] 4297                      clr.l      (a7)
[00002434] 2f0d                      move.l     a5,-(a7)
[00002436] 4eb9 0000 2b20            jsr        _fretlist
[0000243c] 588f                      addq.l     #4,a7
[0000243e] 4a85                      tst.l      d5
[00002440] 6604                      bne.s      _putgr_22
[00002442] 4a84                      tst.l      d4
[00002444] 6604                      bne.s      _putgr_23
_putgr_22:
[00002446] 7e01                      moveq.l    #1,d7
[00002448] 6002                      bra.s      _putgr_24
_putgr_23:
[0000244a] 4287                      clr.l      d7
_putgr_24:
[0000244c] 2e87                      move.l     d7,(a7)
[0000244e] 42a7                      clr.l      -(a7)
[00002450] 4eba f8de                 jsr        _getex(pc)
[00002454] 588f                      addq.l     #4,a7
[00002456] 2f07                      move.l     d7,-(a7)
[00002458] 4eba fec2                 jsr        _putgr(pc)
[0000245c] 588f                      addq.l     #4,a7
[0000245e] 2a47                      movea.l    d7,a5
[00002460] 60aa                      bra.s      _putgr_25
_putgr_18:
[00002462] 2e0d                      move.l     a5,d7
[00002464] 676c                      beq.s      _putgr_26
[00002466] 0cad 0000 000c 0004       cmpi.l     #$0000000C,4(a5)
[0000246e] 6662                      bne.s      _putgr_26
[00002470] 4297                      clr.l      (a7)
[00002472] 2f0d                      move.l     a5,-(a7)
[00002474] 4eb9 0000 2b20            jsr        _fretlist
[0000247a] 588f                      addq.l     #4,a7
[0000247c] 4a85                      tst.l      d5
[0000247e] 6604                      bne.s      _putgr_27
[00002480] 4a84                      tst.l      d4
[00002482] 6704                      beq.s      _putgr_28
_putgr_27:
[00002484] 7e01                      moveq.l    #1,d7
[00002486] 6002                      bra.s      _putgr_29
_putgr_28:
[00002488] 4287                      clr.l      d7
_putgr_29:
[0000248a] 2e87                      move.l     d7,(a7)
[0000248c] 42a7                      clr.l      -(a7)
[0000248e] 4eba f8a0                 jsr        _getex(pc)
[00002492] 588f                      addq.l     #4,a7
[00002494] 2f07                      move.l     d7,-(a7)
[00002496] 4eba fe84                 jsr        _putgr(pc)
[0000249a] 588f                      addq.l     #4,a7
[0000249c] 2a47                      movea.l    d7,a5
[0000249e] 6032                      bra.s      _putgr_26
_putgr_19:
[000024a0] 4297                      clr.l      (a7)
[000024a2] 2f0d                      move.l     a5,-(a7)
[000024a4] 4eb9 0000 2b20            jsr        _fretlist
[000024aa] 588f                      addq.l     #4,a7
[000024ac] 4a85                      tst.l      d5
[000024ae] 6604                      bne.s      _putgr_30
[000024b0] 4a84                      tst.l      d4
[000024b2] 6704                      beq.s      _putgr_31
_putgr_30:
[000024b4] 7e01                      moveq.l    #1,d7
[000024b6] 6002                      bra.s      _putgr_32
_putgr_31:
[000024b8] 4287                      clr.l      d7
_putgr_32:
[000024ba] 2e87                      move.l     d7,(a7)
[000024bc] 42a7                      clr.l      -(a7)
[000024be] 4eba f870                 jsr        _getex(pc)
[000024c2] 588f                      addq.l     #4,a7
[000024c4] 2f07                      move.l     d7,-(a7)
[000024c6] 4eba fe54                 jsr        _putgr(pc)
[000024ca] 588f                      addq.l     #4,a7
[000024cc] 2a47                      movea.l    d7,a5
[000024ce] 6000 ff3c                 bra        _putgr_25
_putgr_26:
[000024d2] 2e0d                      move.l     a5,d7
[000024d4] 6722                      beq.s      _putgr_33
[000024d6] 0cad 0000 000d 0004       cmpi.l     #$0000000D,4(a5)
[000024de] 6618                      bne.s      _putgr_33
[000024e0] 4297                      clr.l      (a7)
[000024e2] 2f0d                      move.l     a5,-(a7)
[000024e4] 4eb9 0000 2b20            jsr        _fretlist
[000024ea] 588f                      addq.l     #4,a7
[000024ec] 4297                      clr.l      (a7)
[000024ee] 4eba f840                 jsr        _getex(pc)
[000024f2] 2a47                      movea.l    d7,a5
[000024f4] 6000 fe36                 bra        _putgr_9
_putgr_33:
[000024f8] 2ebc 0002 0d86            move.l     #$000262D6,(a7)
[000024fe] 4eb9 0000 310e            jsr        _p0error
[00002504] 6000 fe26                 bra        _putgr_9

_putns:
[00002508] 4e56 ffee                 link       a6,#-18
[0000250c] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00002510] 2a6e 0008                 movea.l    8(a6),a5
[00002514] 2e2d 0004                 move.l     4(a5),d7
[00002518] 41f9 0002 0d96            lea.l      $000262E6,a0
[0000251e] 4ef9 0000 4770            jmp        a.switch
[00002524] 2d4d fffc                 move.l     a5,-4(a6)
_putns_2:
[00002528] 246e fffc                 movea.l    -4(a6),a2
[0000252c] 588a                      addq.l     #4,a2
[0000252e] 0c92 0000 0002            cmpi.l     #$00000002,(a2)
[00002534] 670a                      beq.s      _putns_1
[00002536] 246e fffc                 movea.l    -4(a6),a2
[0000253a] 2d52 fffc                 move.l     (a2),-4(a6)
[0000253e] 60e8                      bra.s      _putns_2
_putns_1:
[00002540] 4ab9 0002 0a2e            tst.l      $00025F7E
[00002546] 660a                      bne.s      _putns_3
[00002548] 2e8d                      move.l     a5,(a7)
[0000254a] 4eb9 0000 1b42            jsr        _putls
[00002550] 605e                      bra.s      _putns_4
_putns_3:
[00002552] 4ab9 0002 0a22            tst.l      $00025F72
[00002558] 6656                      bne.s      _putns_4
[0000255a] 2ebc 0000 00fe            move.l     #$000000FE,(a7)
[00002560] 2f3c 0002 0e4d            move.l     #$0002639D,-(a7)
[00002566] 4eb9 0000 19aa            jsr        _putcode
[0000256c] 588f                      addq.l     #4,a7
[0000256e] 45f8 0010                 lea.l      ($00000010).w,a2
[00002572] d5ee fffc                 adda.l     -4(a6),a2
[00002576] 2e12                      move.l     (a2),d7
[00002578] 9ead 0010                 sub.l      16(a5),d7
[0000257c] 5487                      addq.l     #2,d7
[0000257e] 3d47 fff2                 move.w     d7,-14(a6)
[00002582] 486e fff2                 pea.l      -14(a6)
[00002586] 2f3c 0002 0e4b            move.l     #$0002639B,-(a7)
[0000258c] 4eb9 0000 19aa            jsr        _putcode
[00002592] 508f                      addq.l     #8,a7
[00002594] 3e2e fff2                 move.w     -14(a6),d7
[00002598] 48c7                      ext.l      d7
[0000259a] 2e87                      move.l     d7,(a7)
[0000259c] 2f2d 0010                 move.l     16(a5),-(a7)
[000025a0] 5397                      subq.l     #1,(a7)
[000025a2] 2f3c 0002 0e49            move.l     #$00026399,-(a7)
[000025a8] 4eb9 0000 19aa            jsr        _putcode
[000025ae] 508f                      addq.l     #8,a7
_putns_4:
[000025b0] 4297                      clr.l      (a7)
[000025b2] 2f0d                      move.l     a5,-(a7)
[000025b4] 4eb9 0000 2b20            jsr        _fretlist
[000025ba] 588f                      addq.l     #4,a7
[000025bc] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000025c0] 4e5e                      unlk       a6
[000025c2] 4e75                      rts

x25c4_2:
[000025c4] 2455                      movea.l    (a5),a2
[000025c6] 588a                      addq.l     #4,a2
[000025c8] 0c92 0000 0003            cmpi.l     #$00000003,(a2)
[000025ce] 670e                      beq.s      x25c4_1
[000025d0] 2ebc 0002 0e3d            move.l     #$0002638D,(a7)
[000025d6] 4eb9 0000 310e            jsr        _p0error
[000025dc] 60d2                      bra.s      x25c4_2
x25c4_1:
[000025de] 2d55 fffc                 move.l     (a5),-4(a6)
x25c4_4:
[000025e2] 246e fffc                 movea.l    -4(a6),a2
[000025e6] 4a92                      tst.l      (a2)
[000025e8] 670a                      beq.s      x25c4_3
[000025ea] 246e fffc                 movea.l    -4(a6),a2
[000025ee] 2d52 fffc                 move.l     (a2),-4(a6)
[000025f2] 60ee                      bra.s      x25c4_4
x25c4_3:
[000025f4] 45f8 0010                 lea.l      ($00000010).w,a2
[000025f8] d5ee fffc                 adda.l     -4(a6),a2
[000025fc] 2e12                      move.l     (a2),d7
[000025fe] 45f8 0014                 lea.l      ($00000014).w,a2
[00002602] d5ee fffc                 adda.l     -4(a6),a2
[00002606] de92                      add.l      (a2),d7
[00002608] 2455                      movea.l    (a5),a2
[0000260a] 2452                      movea.l    (a2),a2
[0000260c] 508a                      addq.l     #8,a2
[0000260e] 9e92                      sub.l      (a2),d7
[00002610] 3d47 fff2                 move.w     d7,-14(a6)
[00002614] 4ab9 0002 0a2a            tst.l      $00025F7A
[0000261a] 6720                      beq.s      x25c4_5
[0000261c] 4297                      clr.l      (a7)
[0000261e] 45f8 0014                 lea.l      ($00000014).w,a2
[00002622] d5d5                      adda.l     (a5),a2
[00002624] 2f12                      move.l     (a2),-(a7)
[00002626] 45f8 0010                 lea.l      ($00000010).w,a2
[0000262a] d5d5                      adda.l     (a5),a2
[0000262c] 2f12                      move.l     (a2),-(a7)
[0000262e] 4eb9 0000 2e8a            jsr        _lookup
[00002634] 508f                      addq.l     #8,a7
[00002636] 2647                      movea.l    d7,a3
[00002638] 2e0b                      move.l     a3,d7
[0000263a] 6636                      bne.s      x25c4_6
x25c4_5:
[0000263c] 3e2e fff2                 move.w     -14(a6),d7
[00002640] 48c7                      ext.l      d7
[00002642] 2e87                      move.l     d7,(a7)
[00002644] 2455                      movea.l    (a5),a2
[00002646] 2452                      movea.l    (a2),a2
[00002648] 508a                      addq.l     #8,a2
[0000264a] 2f12                      move.l     (a2),-(a7)
[0000264c] 4eb9 0000 4082            jsr        _buybuf
[00002652] 588f                      addq.l     #4,a7
[00002654] 2e87                      move.l     d7,(a7)
[00002656] 45f8 0014                 lea.l      ($00000014).w,a2
[0000265a] d5d5                      adda.l     (a5),a2
[0000265c] 2f12                      move.l     (a2),-(a7)
[0000265e] 45f8 0010                 lea.l      ($00000010).w,a2
[00002662] d5d5                      adda.l     (a5),a2
[00002664] 2f12                      move.l     (a2),-(a7)
[00002666] 4eb9 0000 2e22            jsr        _install
[0000266c] 508f                      addq.l     #8,a7
[0000266e] 6000 ff40                 bra        x25c4_2
x25c4_6:
[00002672] 3e2e fff2                 move.w     -14(a6),d7
[00002676] 48c7                      ext.l      d7
[00002678] 2e87                      move.l     d7,(a7)
[0000267a] 2455                      movea.l    (a5),a2
[0000267c] 2452                      movea.l    (a2),a2
[0000267e] 508a                      addq.l     #8,a2
[00002680] 2f12                      move.l     (a2),-(a7)
[00002682] 2f0b                      move.l     a3,-(a7)
[00002684] 4eb9 0000 4cde            jsr        _cmpbuf
[0000268a] 508f                      addq.l     #8,a7
[0000268c] 4a87                      tst.l      d7
[0000268e] 6600 ff20                 bne        x25c4_2
[00002692] 45f8 0014                 lea.l      ($00000014).w,a2
[00002696] d5d5                      adda.l     (a5),a2
[00002698] 2e92                      move.l     (a2),(a7)
[0000269a] 45f8 0010                 lea.l      ($00000010).w,a2
[0000269e] d5d5                      adda.l     (a5),a2
[000026a0] 2f12                      move.l     (a2),-(a7)
[000026a2] 2f3c 0002 0e30            move.l     #$00026380,-(a7)
[000026a8] 4eb9 0000 310e            jsr        _p0error
[000026ae] 508f                      addq.l     #8,a7
[000026b0] 6000 fefe                 bra        x25c4_2
[000026b4] 2455                      movea.l    (a5),a2
[000026b6] 588a                      addq.l     #4,a2
[000026b8] 0c92 0000 0003            cmpi.l     #$00000003,(a2)
[000026be] 6710                      beq.s      x25c4_7
[000026c0] 2ebc 0002 0e25            move.l     #$00026375,(a7)
[000026c6] 4eb9 0000 310e            jsr        _p0error
[000026cc] 6000 fee2                 bra        x25c4_2
x25c4_7:
[000026d0] 45f8 0014                 lea.l      ($00000014).w,a2
[000026d4] d5d5                      adda.l     (a5),a2
[000026d6] 2e92                      move.l     (a2),(a7)
[000026d8] 45f8 0010                 lea.l      ($00000010).w,a2
[000026dc] d5d5                      adda.l     (a5),a2
[000026de] 2f12                      move.l     (a2),-(a7)
[000026e0] 4eb9 0000 0a74            jsr        _undef
[000026e6] 588f                      addq.l     #4,a7
[000026e8] 6000 fec6                 bra        x25c4_2
[000026ec] 2e95                      move.l     (a5),(a7)
[000026ee] 4eb9 0000 2b56            jsr        _getfincl
[000026f4] 2847                      movea.l    d7,a4
[000026f6] 4ab9 0002 0a5a            tst.l      $00025FAA
[000026fc] 671a                      beq.s      x25c4_8
[000026fe] 2e8c                      move.l     a4,(a7)
[00002700] 2f3c 0002 0e13            move.l     #$00026363,-(a7)
[00002706] 4eb9 0000 310e            jsr        _p0error
[0000270c] 588f                      addq.l     #4,a7
[0000270e] 42b9 0002 0a5a            clr.l      $00025FAA
[00002714] 6000 fe9a                 bra        x25c4_2
x25c4_8:
[00002718] 4297                      clr.l      (a7)
[0000271a] 42a7                      clr.l      -(a7)
[0000271c] 2f0c                      move.l     a4,-(a7)
[0000271e] 4eb9 0000 4588            jsr        _open
[00002724] 508f                      addq.l     #8,a7
[00002726] 3d47 fff6                 move.w     d7,-10(a6)
[0000272a] 6c1a                      bge.s      x25c4_9
[0000272c] 2ebc 0002 0dfe            move.l     #$0002634E,(a7)
[00002732] 45f8 0010                 lea.l      ($00000010).w,a2
[00002736] d5d5                      adda.l     (a5),a2
[00002738] 2f12                      move.l     (a2),-(a7)
[0000273a] 4eb9 0000 550a            jsr        _error
[00002740] 588f                      addq.l     #4,a7
[00002742] 6000 fe6c                 bra        x25c4_2
x25c4_9:
[00002746] 4eb9 0000 3322            jsr        _ptline
[0000274c] 2eb9 0002 0a6c            move.l     $00025FBC,(a7)
[00002752] 4878 0214                 pea.l      ($00000214).w
[00002756] 4eb9 0000 486e            jsr        _alloc
[0000275c] 588f                      addq.l     #4,a7
[0000275e] 23c7 0002 0a6c            move.l     d7,$00025FBC
[00002764] 2479 0002 0a6c            movea.l    $00025FBC,a2
[0000276a] 588a                      addq.l     #4,a2
[0000276c] 248c                      move.l     a4,(a2)
[0000276e] 2479 0002 0a6c            movea.l    $00025FBC,a2
[00002774] 508a                      addq.l     #8,a2
[00002776] 4252                      clr.w      (a2)
[00002778] 4297                      clr.l      (a7)
[0000277a] 3e2e fff6                 move.w     -10(a6),d7
[0000277e] 48c7                      ext.l      d7
[00002780] 2f07                      move.l     d7,-(a7)
[00002782] 7e0a                      moveq.l    #10,d7
[00002784] deb9 0002 0a6c            add.l      $00025FBC,d7
[0000278a] 2f07                      move.l     d7,-(a7)
[0000278c] 4eb9 0000 42c0            jsr        _finit
[00002792] 508f                      addq.l     #8,a7
[00002794] 7001                      moveq.l    #1,d0
[00002796] 23c0 0002 0a5e            move.l     d0,$00025FAE
[0000279c] 5279 0002 0a3c            addq.w     #1,$00025F8C
[000027a2] 6000 fe0c                 bra        x25c4_2
[000027a6] 45f8 0014                 lea.l      ($00000014).w,a2
[000027aa] d5d5                      adda.l     (a5),a2
[000027ac] 0c92 0000 0001            cmpi.l     #$00000001,(a2)
[000027b2] 662e                      bne.s      x25c4_10
[000027b4] 45f8 0010                 lea.l      ($00000010).w,a2
[000027b8] d5d5                      adda.l     (a5),a2
[000027ba] 2452                      movea.l    (a2),a2
[000027bc] 4287                      clr.l      d7
[000027be] 1e12                      move.b     (a2),d7
[000027c0] 0c47 003d                 cmpi.w     #$003D,d7
[000027c4] 661c                      bne.s      x25c4_10
[000027c6] 4ab9 0002 0a2e            tst.l      $00025F7E
[000027cc] 6632                      bne.s      x25c4_11
[000027ce] 53ad 0010                 subq.l     #1,16(a5)
[000027d2] 52ad 0014                 addq.l     #1,20(a5)
[000027d6] 2e8d                      move.l     a5,(a7)
[000027d8] 4eb9 0000 1b42            jsr        _putls
[000027de] 6000 fdd0                 bra        x25c4_2
x25c4_10:
[000027e2] 2455                      movea.l    (a5),a2
[000027e4] 588a                      addq.l     #4,a2
[000027e6] 0c92 0000 0004            cmpi.l     #$00000004,(a2)
[000027ec] 6700 0132                 beq        x25c4_12
[000027f0] 2ebc 0002 0df4            move.l     #$00026344,(a7)
[000027f6] 4eb9 0000 310e            jsr        _p0error
[000027fc] 6000 fdb2                 bra        x25c4_2
x25c4_11:
[00002800] 2455                      movea.l    (a5),a2
[00002802] 2d52 fffc                 move.l     (a2),-4(a6)
[00002806] 2d6e fffc fff8            move.l     -4(a6),-8(a6)
x25c4_15:
[0000280c] 45f8 0014                 lea.l      ($00000014).w,a2
[00002810] d5ee fff8                 adda.l     -8(a6),a2
[00002814] 0c92 0000 0001            cmpi.l     #$00000001,(a2)
[0000281a] 6614                      bne.s      x25c4_13
[0000281c] 45f8 0010                 lea.l      ($00000010).w,a2
[00002820] d5ee fff8                 adda.l     -8(a6),a2
[00002824] 2452                      movea.l    (a2),a2
[00002826] 4287                      clr.l      d7
[00002828] 1e12                      move.b     (a2),d7
[0000282a] 0c47 003a                 cmpi.w     #$003A,d7
[0000282e] 6718                      beq.s      x25c4_14
x25c4_13:
[00002830] 246e fff8                 movea.l    -8(a6),a2
[00002834] 588a                      addq.l     #4,a2
[00002836] 0c92 0000 0002            cmpi.l     #$00000002,(a2)
[0000283c] 670a                      beq.s      x25c4_14
[0000283e] 246e fff8                 movea.l    -8(a6),a2
[00002842] 2d52 fff8                 move.l     (a2),-8(a6)
[00002846] 60c4                      bra.s      x25c4_15
x25c4_14:
[00002848] 2e2e fff8                 move.l     -8(a6),d7
[0000284c] beae fffc                 cmp.l      -4(a6),d7
[00002850] 677a                      beq.s      x25c4_16
[00002852] 42b9 0002 0a56            clr.l      $00025FA6
[00002858] 45f8 0010                 lea.l      ($00000010).w,a2
[0000285c] d5ee fff8                 adda.l     -8(a6),a2
[00002860] 2e12                      move.l     (a2),d7
[00002862] 45f8 0010                 lea.l      ($00000010).w,a2
[00002866] d5ee fffc                 adda.l     -4(a6),a2
[0000286a] 9e92                      sub.l      (a2),d7
[0000286c] 2e87                      move.l     d7,(a7)
[0000286e] 5297                      addq.l     #1,(a7)
[00002870] 45f8 0010                 lea.l      ($00000010).w,a2
[00002874] d5ee fffc                 adda.l     -4(a6),a2
[00002878] 2f12                      move.l     (a2),-(a7)
[0000287a] 4eb9 0000 4082            jsr        _buybuf
[00002880] 588f                      addq.l     #4,a7
[00002882] 2d47 ffee                 move.l     d7,-18(a6)
[00002886] 45f8 0010                 lea.l      ($00000010).w,a2
[0000288a] d5ee fffc                 adda.l     -4(a6),a2
[0000288e] 2e92                      move.l     (a2),(a7)
[00002890] 45f8 0010                 lea.l      ($00000010).w,a2
[00002894] d5ee fff8                 adda.l     -8(a6),a2
[00002898] 2452                      movea.l    (a2),a2
[0000289a] 95d7                      suba.l     (a7),a2
[0000289c] d5ee ffee                 adda.l     -18(a6),a2
[000028a0] 4212                      clr.b      (a2)
[000028a2] 7001                      moveq.l    #1,d0
[000028a4] 23c0 0002 0a5e            move.l     d0,$00025FAE
[000028aa] 2479 0002 0a6c            movea.l    $00025FBC,a2
[000028b0] 588a                      addq.l     #4,a2
[000028b2] 4a92                      tst.l      (a2)
[000028b4] 6756                      beq.s      x25c4_17
[000028b6] 4297                      clr.l      (a7)
[000028b8] 2479 0002 0a6c            movea.l    $00025FBC,a2
[000028be] 588a                      addq.l     #4,a2
[000028c0] 2f12                      move.l     (a2),-(a7)
[000028c2] 4eb9 0000 49de            jsr        _free
[000028c8] 588f                      addq.l     #4,a7
[000028ca] 6040                      bra.s      x25c4_17
x25c4_16:
[000028cc] 246e fff8                 movea.l    -8(a6),a2
[000028d0] 2d52 fff8                 move.l     (a2),-8(a6)
[000028d4] 4297                      clr.l      (a7)
[000028d6] 42a7                      clr.l      -(a7)
[000028d8] 2f2e fff8                 move.l     -8(a6),-(a7)
[000028dc] 4eb9 0000 12da            jsr        _bton
[000028e2] 508f                      addq.l     #8,a7
[000028e4] 3d47 fff4                 move.w     d7,-12(a6)
[000028e8] 2479 0002 0a6c            movea.l    $00025FBC,a2
[000028ee] 508a                      addq.l     #8,a2
[000028f0] 34ae fff4                 move.w     -12(a6),(a2)
[000028f4] 42b9 0002 0a56            clr.l      $00025FA6
[000028fa] 4eb9 0000 3322            jsr        _ptline
[00002900] 7001                      moveq.l    #1,d0
[00002902] 23c0 0002 0a56            move.l     d0,$00025FA6
[00002908] 6000 fca6                 bra        x25c4_2
x25c4_17:
[0000290c] 2479 0002 0a6c            movea.l    $00025FBC,a2
[00002912] 588a                      addq.l     #4,a2
[00002914] 24ae ffee                 move.l     -18(a6),(a2)
[00002918] 4eb9 0000 1ab2            jsr        _putfile
[0000291e] 60ac                      bra.s      x25c4_16
x25c4_12:
[00002920] 4297                      clr.l      (a7)
[00002922] 42a7                      clr.l      -(a7)
[00002924] 2f15                      move.l     (a5),-(a7)
[00002926] 4eb9 0000 12da            jsr        _bton
[0000292c] 508f                      addq.l     #8,a7
[0000292e] 3d47 fff4                 move.w     d7,-12(a6)
[00002932] 2479 0002 0a6c            movea.l    $00025FBC,a2
[00002938] 508a                      addq.l     #8,a2
[0000293a] 34ae fff4                 move.w     -12(a6),(a2)
[0000293e] 2455                      movea.l    (a5),a2
[00002940] 2d52 fffc                 move.l     (a2),-4(a6)
[00002944] 246e fffc                 movea.l    -4(a6),a2
[00002948] 588a                      addq.l     #4,a2
[0000294a] 0c92 0000 0002            cmpi.l     #$00000002,(a2)
[00002950] 6700 fc5e                 beq        x25c4_2
[00002954] 246e fffc                 movea.l    -4(a6),a2
[00002958] 588a                      addq.l     #4,a2
[0000295a] 0c92 0000 0006            cmpi.l     #$00000006,(a2)
[00002960] 6660                      bne.s      x25c4_18
[00002962] 45f8 0014                 lea.l      ($00000014).w,a2
[00002966] d5ee fffc                 adda.l     -4(a6),a2
[0000296a] 2e92                      move.l     (a2),(a7)
[0000296c] 5397                      subq.l     #1,(a7)
[0000296e] 45f8 0010                 lea.l      ($00000010).w,a2
[00002972] d5ee fffc                 adda.l     -4(a6),a2
[00002976] 2f12                      move.l     (a2),-(a7)
[00002978] 5297                      addq.l     #1,(a7)
[0000297a] 4eb9 0000 4082            jsr        _buybuf
[00002980] 588f                      addq.l     #4,a7
[00002982] 2d47 ffee                 move.l     d7,-18(a6)
[00002986] 45f8 0014                 lea.l      ($00000014).w,a2
[0000298a] d5ee fffc                 adda.l     -4(a6),a2
[0000298e] 2452                      movea.l    (a2),a2
[00002990] 558a                      subq.l     #2,a2
[00002992] d5ee ffee                 adda.l     -18(a6),a2
[00002996] 4212                      clr.b      (a2)
[00002998] 7001                      moveq.l    #1,d0
[0000299a] 23c0 0002 0a5e            move.l     d0,$00025FAE
[000029a0] 2479 0002 0a6c            movea.l    $00025FBC,a2
[000029a6] 588a                      addq.l     #4,a2
[000029a8] 4a92                      tst.l      (a2)
[000029aa] 6732                      beq.s      x25c4_19
[000029ac] 4297                      clr.l      (a7)
[000029ae] 2479 0002 0a6c            movea.l    $00025FBC,a2
[000029b4] 588a                      addq.l     #4,a2
[000029b6] 2f12                      move.l     (a2),-(a7)
[000029b8] 4eb9 0000 49de            jsr        _free
[000029be] 588f                      addq.l     #4,a7
[000029c0] 601c                      bra.s      x25c4_19
x25c4_18:
[000029c2] 246e fffc                 movea.l    -4(a6),a2
[000029c6] 588a                      addq.l     #4,a2
[000029c8] 0c92 0000 0002            cmpi.l     #$00000002,(a2)
[000029ce] 6724                      beq.s      x25c4_20
[000029d0] 2ebc 0002 0de3            move.l     #$00026333,(a7)
[000029d6] 4eb9 0000 310e            jsr        _p0error
[000029dc] 6016                      bra.s      x25c4_20
x25c4_19:
[000029de] 2479 0002 0a6c            movea.l    $00025FBC,a2
[000029e4] 588a                      addq.l     #4,a2
[000029e6] 24ae ffee                 move.l     -18(a6),(a2)
[000029ea] 246e fffc                 movea.l    -4(a6),a2
[000029ee] 2d52 fffc                 move.l     (a2),-4(a6)
[000029f2] 60ce                      bra.s      x25c4_18
x25c4_20:
[000029f4] 4ab9 0002 0a2e            tst.l      $00025F7E
[000029fa] 6600 fbb4                 bne        x25c4_2
[000029fe] 53ad 0010                 subq.l     #1,16(a5)
[00002a02] 52ad 0014                 addq.l     #1,20(a5)
[00002a06] 2e8d                      move.l     a5,(a7)
[00002a08] 4eb9 0000 1b42            jsr        _putls
[00002a0e] 6000 fba0                 bra        x25c4_2
[00002a12] 4ab9 0002 0a2e            tst.l      $00025F7E
[00002a18] 6614                      bne.s      x25c4_21
[00002a1a] 53ad 0010                 subq.l     #1,16(a5)
[00002a1e] 52ad 0014                 addq.l     #1,20(a5)
[00002a22] 2e8d                      move.l     a5,(a7)
[00002a24] 4eb9 0000 1b42            jsr        _putls
[00002a2a] 6000 fb84                 bra        x25c4_2
x25c4_21:
[00002a2e] 4878 001d                 pea.l      ($0000001D).w
[00002a32] 2f3c 0002 0de1            move.l     #$00026331,-(a7)
[00002a38] 4eb9 0000 19aa            jsr        _putcode
[00002a3e] 508f                      addq.l     #8,a7
[00002a40] 2e95                      move.l     (a5),(a7)
[00002a42] 4eb9 0000 1b42            jsr        _putls
[00002a48] 4878 001d                 pea.l      ($0000001D).w
[00002a4c] 2f3c 0002 0ddf            move.l     #$0002632F,-(a7)
[00002a52] 4eb9 0000 19aa            jsr        _putcode
[00002a58] 508f                      addq.l     #8,a7
[00002a5a] 6000 fb54                 bra        x25c4_2
[00002a5e] 2455                      movea.l    (a5),a2
[00002a60] 588a                      addq.l     #4,a2
[00002a62] 0c92 0000 0002            cmpi.l     #$00000002,(a2)
[00002a68] 6700 fb46                 beq        x25c4_2
[00002a6c] 2ebc 0002 0dd6            move.l     #$00026326,(a7)
[00002a72] 4eb9 0000 310e            jsr        _p0error
[00002a78] 6000 fb36                 bra        x25c4_2
[00002a7c] 2e8d                      move.l     a5,(a7)
[00002a7e] 4eb9 0000 1b42            jsr        _putls
[00002a84] 6000 fb2a                 bra        x25c4_2

_buytl:
[00002a88] 4e56 0000                 link       a6,#0
[00002a8c] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00002a90] 2a6e 0008                 movea.l    8(a6),a5
[00002a94] 286e 000c                 movea.l    12(a6),a4
[00002a98] 4ab9 0002 1050            tst.l      $000265A0
[00002a9e] 6710                      beq.s      _buytl_1
[00002aa0] 2679 0002 1050            movea.l    $000265A0,a3
[00002aa6] 23d3 0002 1050            move.l     (a3),$000265A0
[00002aac] 268c                      move.l     a4,(a3)
[00002aae] 6010                      bra.s      _buytl_2
_buytl_1:
[00002ab0] 2e8c                      move.l     a4,(a7)
[00002ab2] 4878 0018                 pea.l      ($00000018).w
[00002ab6] 4eb9 0000 486e            jsr        _alloc
[00002abc] 588f                      addq.l     #4,a7
[00002abe] 2647                      movea.l    d7,a3
_buytl_2:
[00002ac0] 42ab 0004                 clr.l      4(a3)
[00002ac4] 42ab 0008                 clr.l      8(a3)
[00002ac8] 42ab 000c                 clr.l      12(a3)
[00002acc] 42ab 0014                 clr.l      20(a3)
[00002ad0] 42ab 0010                 clr.l      16(a3)
[00002ad4] 2e0d                      move.l     a5,d7
[00002ad6] 671e                      beq.s      _buytl_3
[00002ad8] 276d 0004 0004            move.l     4(a5),4(a3)
[00002ade] 276d 0008 0008            move.l     8(a5),8(a3)
[00002ae4] 276d 000c 000c            move.l     12(a5),12(a3)
[00002aea] 276d 0010 0010            move.l     16(a5),16(a3)
[00002af0] 276d 0014 0014            move.l     20(a5),20(a3)
_buytl_3:
[00002af6] 2e0b                      move.l     a3,d7
[00002af8] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00002afc] 4e5e                      unlk       a6
[00002afe] 4e75                      rts

_fatal:
[00002b00] 4e56 fffc                 link       a6,#-4
[00002b04] 2eae 000c                 move.l     12(a6),(a7)
[00002b08] 2f2e 0008                 move.l     8(a6),-(a7)
[00002b0c] 4eb9 0000 310e            jsr        _p0error
[00002b12] 588f                      addq.l     #4,a7
[00002b14] 4297                      clr.l      (a7)
[00002b16] 4eb9 0000 0080            jsr        _exit
[00002b1c] 4e5e                      unlk       a6
[00002b1e] 4e75                      rts

_fretlist:
[00002b20] 4e56 0000                 link       a6,#0
[00002b24] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00002b28] 2a6e 000c                 movea.l    12(a6),a5
[00002b2c] 286e 0008                 movea.l    8(a6),a4
_fretlist_2:
[00002b30] 4a94                      tst.l      (a4)
[00002b32] 670a                      beq.s      _fretlist_1
[00002b34] 2e14                      move.l     (a4),d7
[00002b36] be8d                      cmp.l      a5,d7
[00002b38] 6704                      beq.s      _fretlist_1
[00002b3a] 2854                      movea.l    (a4),a4
[00002b3c] 60f2                      bra.s      _fretlist_2
_fretlist_1:
[00002b3e] 28b9 0002 1050            move.l     $000265A0,(a4)
[00002b44] 23ee 0008 0002 1050       move.l     8(a6),$000265A0
[00002b4c] 2e0d                      move.l     a5,d7
[00002b4e] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00002b52] 4e5e                      unlk       a6
[00002b54] 4e75                      rts

_getfincl:
[00002b56] 4e56 fff0                 link       a6,#-16
[00002b5a] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00002b5e] 2a6e 0008                 movea.l    8(a6),a5
[00002b62] 4aad 0014                 tst.l      20(a5)
[00002b66] 671c                      beq.s      _getfincl_1
[00002b68] 246d 0010                 movea.l    16(a5),a2
[00002b6c] 4287                      clr.l      d7
[00002b6e] 1e12                      move.b     (a2),d7
[00002b70] 0c47 0022                 cmpi.w     #$0022,d7
[00002b74] 6722                      beq.s      _getfincl_2
[00002b76] 246d 0010                 movea.l    16(a5),a2
[00002b7a] 4287                      clr.l      d7
[00002b7c] 1e12                      move.b     (a2),d7
[00002b7e] 0c47 003c                 cmpi.w     #$003C,d7
[00002b82] 6714                      beq.s      _getfincl_2
_getfincl_1:
[00002b84] 7001                      moveq.l    #1,d0
[00002b86] 23c0 0002 0a5a            move.l     d0,$00025FAA
[00002b8c] 2e2d 0010                 move.l     16(a5),d7
[00002b90] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00002b94] 4e5e                      unlk       a6
[00002b96] 4e75                      rts
_getfincl_2:
[00002b98] 2e2d 000c                 move.l     12(a5),d7
[00002b9c] 4487                      neg.l      d7
[00002b9e] 2d47 fffc                 move.l     d7,-4(a6)
[00002ba2] 264d                      movea.l    a5,a3
_getfincl_4:
[00002ba4] 0cab 0000 0002 0004       cmpi.l     #$00000002,4(a3)
[00002bac] 6710                      beq.s      _getfincl_3
[00002bae] 2e2b 000c                 move.l     12(a3),d7
[00002bb2] deab 0014                 add.l      20(a3),d7
[00002bb6] dfae fffc                 add.l      d7,-4(a6)
[00002bba] 2653                      movea.l    (a3),a3
[00002bbc] 60e6                      bra.s      _getfincl_4
_getfincl_3:
[00002bbe] 4297                      clr.l      (a7)
[00002bc0] 2f2e fffc                 move.l     -4(a6),-(a7)
[00002bc4] 4eb9 0000 486e            jsr        _alloc
[00002bca] 588f                      addq.l     #4,a7
[00002bcc] 2d47 fff4                 move.l     d7,-12(a6)
[00002bd0] 286e fff4                 movea.l    -12(a6),a4
[00002bd4] 264d                      movea.l    a5,a3
_getfincl_10:
[00002bd6] 0cab 0000 0002 0004       cmpi.l     #$00000002,4(a3)
[00002bde] 671e                      beq.s      _getfincl_5
[00002be0] b7cd                      cmpa.l     a5,a3
[00002be2] 663a                      bne.s      _getfincl_6
[00002be4] 2ead 0014                 move.l     20(a5),(a7)
[00002be8] 5397                      subq.l     #1,(a7)
[00002bea] 2f2d 0010                 move.l     16(a5),-(a7)
[00002bee] 5297                      addq.l     #1,(a7)
[00002bf0] 2f0c                      move.l     a4,-(a7)
[00002bf2] 4eb9 0000 4d14            jsr        _cpybuf
[00002bf8] 508f                      addq.l     #8,a7
[00002bfa] d9c7                      adda.l     d7,a4
[00002bfc] 6048                      bra.s      _getfincl_7
_getfincl_5:
[00002bfe] 538c                      subq.l     #1,a4
[00002c00] 246d 0010                 movea.l    16(a5),a2
[00002c04] 4287                      clr.l      d7
[00002c06] 1e12                      move.b     (a2),d7
[00002c08] 0c47 0022                 cmpi.w     #$0022,d7
[00002c0c] 666e                      bne.s      _getfincl_8
[00002c0e] 4287                      clr.l      d7
[00002c10] 1e14                      move.b     (a4),d7
[00002c12] 0c47 0022                 cmpi.w     #$0022,d7
[00002c16] 667c                      bne.s      _getfincl_9
[00002c18] 6062                      bra.s      _getfincl_8
_getfincl_11:
[00002c1a] 2653                      movea.l    (a3),a3
[00002c1c] 60b8                      bra.s      _getfincl_10
_getfincl_6:
[00002c1e] 2eab 000c                 move.l     12(a3),(a7)
[00002c22] 2f2b 0008                 move.l     8(a3),-(a7)
[00002c26] 2f0c                      move.l     a4,-(a7)
[00002c28] 4eb9 0000 4d14            jsr        _cpybuf
[00002c2e] 508f                      addq.l     #8,a7
[00002c30] d9c7                      adda.l     d7,a4
[00002c32] 2eab 0014                 move.l     20(a3),(a7)
[00002c36] 2f2b 0010                 move.l     16(a3),-(a7)
[00002c3a] 2f0c                      move.l     a4,-(a7)
[00002c3c] 4eb9 0000 4d14            jsr        _cpybuf
[00002c42] 508f                      addq.l     #8,a7
[00002c44] d9c7                      adda.l     d7,a4
_getfincl_7:
[00002c46] 0cab 0000 0006 0004       cmpi.l     #$00000006,4(a3)
[00002c4e] 66ca                      bne.s      _getfincl_11
[00002c50] 2453                      movea.l    (a3),a2
[00002c52] 588a                      addq.l     #4,a2
[00002c54] 0c92 0000 0006            cmpi.l     #$00000006,(a2)
[00002c5a] 66be                      bne.s      _getfincl_11
[00002c5c] 2653                      movea.l    (a3),a3
[00002c5e] 2eab 0014                 move.l     20(a3),(a7)
[00002c62] 5397                      subq.l     #1,(a7)
[00002c64] 2f2b 0010                 move.l     16(a3),-(a7)
[00002c68] 5297                      addq.l     #1,(a7)
[00002c6a] 486c ffff                 pea.l      -1(a4)
[00002c6e] 4eb9 0000 4d14            jsr        _cpybuf
[00002c74] 508f                      addq.l     #8,a7
[00002c76] 5387                      subq.l     #1,d7
[00002c78] d9c7                      adda.l     d7,a4
[00002c7a] 60ca                      bra.s      _getfincl_7
_getfincl_8:
[00002c7c] 246d 0010                 movea.l    16(a5),a2
[00002c80] 4287                      clr.l      d7
[00002c82] 1e12                      move.b     (a2),d7
[00002c84] 0c47 003c                 cmpi.w     #$003C,d7
[00002c88] 661a                      bne.s      _getfincl_12
[00002c8a] 4287                      clr.l      d7
[00002c8c] 1e14                      move.b     (a4),d7
[00002c8e] 0c47 003e                 cmpi.w     #$003E,d7
[00002c92] 6710                      beq.s      _getfincl_12
_getfincl_9:
[00002c94] 7001                      moveq.l    #1,d0
[00002c96] 23c0 0002 0a5a            move.l     d0,$00025FAA
[00002c9c] 4214                      clr.b      (a4)
[00002c9e] 2e2e fff4                 move.l     -12(a6),d7
[00002ca2] 6038                      bra.s      _getfincl_13
_getfincl_12:
[00002ca4] 4214                      clr.b      (a4)
[00002ca6] 246d 0010                 movea.l    16(a5),a2
[00002caa] 4287                      clr.l      d7
[00002cac] 1e12                      move.b     (a2),d7
[00002cae] 0c47 0022                 cmpi.w     #$0022,d7
[00002cb2] 6630                      bne.s      _getfincl_14
[00002cb4] 4297                      clr.l      (a7)
[00002cb6] 42a7                      clr.l      -(a7)
[00002cb8] 2f2e fff4                 move.l     -12(a6),-(a7)
[00002cbc] 4eb9 0000 4588            jsr        _open
[00002cc2] 508f                      addq.l     #8,a7
[00002cc4] 3d47 fff8                 move.w     d7,-8(a6)
[00002cc8] 6d1a                      blt.s      _getfincl_14
[00002cca] 3e2e fff8                 move.w     -8(a6),d7
[00002cce] 48c7                      ext.l      d7
[00002cd0] 2e87                      move.l     d7,(a7)
[00002cd2] 4eb9 0000 4cd6            jsr        _close
[00002cd8] 2e2e fff4                 move.l     -12(a6),d7
_getfincl_13:
[00002cdc] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00002ce0] 4e5e                      unlk       a6
[00002ce2] 4e75                      rts
_getfincl_14:
[00002ce4] 2e0c                      move.l     a4,d7
[00002ce6] 9eae fff4                 sub.l      -12(a6),d7
[00002cea] 2d47 fffc                 move.l     d7,-4(a6)
[00002cee] 2879 0002 0a44            movea.l    $00025F94,a4
_getfincl_20:
[00002cf4] 4a14                      tst.b      (a4)
[00002cf6] 6700 009c                 beq        _getfincl_15
[00002cfa] 4878 007c                 pea.l      ($0000007C).w
[00002cfe] 2f0c                      move.l     a4,-(a7)
[00002d00] 4eb9 0000 4732            jsr        _scnstr
[00002d06] 508f                      addq.l     #8,a7
[00002d08] 3d47 fffa                 move.w     d7,-6(a6)
[00002d0c] 4297                      clr.l      (a7)
[00002d0e] 3e2e fffa                 move.w     -6(a6),d7
[00002d12] 48c7                      ext.l      d7
[00002d14] deae fffc                 add.l      -4(a6),d7
[00002d18] 2f07                      move.l     d7,-(a7)
[00002d1a] 5297                      addq.l     #1,(a7)
[00002d1c] 4eb9 0000 486e            jsr        _alloc
[00002d22] 588f                      addq.l     #4,a7
[00002d24] 2d47 fff0                 move.l     d7,-16(a6)
[00002d28] 3e2e fffa                 move.w     -6(a6),d7
[00002d2c] 48c7                      ext.l      d7
[00002d2e] 2e87                      move.l     d7,(a7)
[00002d30] 2f0c                      move.l     a4,-(a7)
[00002d32] 2f2e fff0                 move.l     -16(a6),-(a7)
[00002d36] 4eb9 0000 4d14            jsr        _cpybuf
[00002d3c] 508f                      addq.l     #8,a7
[00002d3e] 2eae fffc                 move.l     -4(a6),(a7)
[00002d42] 5297                      addq.l     #1,(a7)
[00002d44] 2f2e fff4                 move.l     -12(a6),-(a7)
[00002d48] 2e2e fff0                 move.l     -16(a6),d7
[00002d4c] 3c2e fffa                 move.w     -6(a6),d6
[00002d50] 48c6                      ext.l      d6
[00002d52] de86                      add.l      d6,d7
[00002d54] 2f07                      move.l     d7,-(a7)
[00002d56] 4eb9 0000 4d14            jsr        _cpybuf
[00002d5c] 508f                      addq.l     #8,a7
[00002d5e] 4297                      clr.l      (a7)
[00002d60] 42a7                      clr.l      -(a7)
[00002d62] 2f2e fff0                 move.l     -16(a6),-(a7)
[00002d66] 4eb9 0000 4588            jsr        _open
[00002d6c] 508f                      addq.l     #8,a7
[00002d6e] 3d47 fff8                 move.w     d7,-8(a6)
[00002d72] 6d34                      blt.s      _getfincl_16
[00002d74] 3e2e fff8                 move.w     -8(a6),d7
[00002d78] 48c7                      ext.l      d7
[00002d7a] 2e87                      move.l     d7,(a7)
[00002d7c] 4eb9 0000 4cd6            jsr        _close
[00002d82] 2eae fff0                 move.l     -16(a6),(a7)
[00002d86] 2f2e fff4                 move.l     -12(a6),-(a7)
[00002d8a] 4eb9 0000 49de            jsr        _free
[00002d90] 588f                      addq.l     #4,a7
[00002d92] 600c                      bra.s      _getfincl_17
_getfincl_15:
[00002d94] 7001                      moveq.l    #1,d0
[00002d96] 23c0 0002 0a5a            move.l     d0,$00025FAA
[00002d9c] 2e2e fff4                 move.l     -12(a6),d7
_getfincl_17:
[00002da0] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00002da4] 4e5e                      unlk       a6
[00002da6] 4e75                      rts
_getfincl_16:
[00002da8] 4297                      clr.l      (a7)
[00002daa] 2f2e fff0                 move.l     -16(a6),-(a7)
[00002dae] 4eb9 0000 49de            jsr        _free
[00002db4] 588f                      addq.l     #4,a7
[00002db6] 244c                      movea.l    a4,a2
[00002db8] 3e2e fffa                 move.w     -6(a6),d7
[00002dbc] 48c7                      ext.l      d7
[00002dbe] d5c7                      adda.l     d7,a2
[00002dc0] 4a12                      tst.b      (a2)
[00002dc2] 670a                      beq.s      _getfincl_18
[00002dc4] 3e2e fffa                 move.w     -6(a6),d7
[00002dc8] 48c7                      ext.l      d7
[00002dca] 5287                      addq.l     #1,d7
[00002dcc] 6006                      bra.s      _getfincl_19
_getfincl_18:
[00002dce] 3e2e fffa                 move.w     -6(a6),d7
[00002dd2] 48c7                      ext.l      d7
_getfincl_19:
[00002dd4] d9c7                      adda.l     d7,a4
[00002dd6] 6000 ff1c                 bra        _getfincl_20

_hash:
[00002dda] 4e56 0000                 link       a6,#0
[00002dde] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00002de2] 2a6e 0008                 movea.l    8(a6),a5
[00002de6] 2a2e 000c                 move.l     12(a6),d5
[00002dea] 0c85 0000 0008            cmpi.l     #$00000008,d5
[00002df0] 6302                      bls.s      _hash_1
[00002df2] 7a08                      moveq.l    #8,d5
_hash_1:
[00002df4] 4284                      clr.l      d4
_hash_3:
[00002df6] 4a85                      tst.l      d5
[00002df8] 670a                      beq.s      _hash_2
[00002dfa] 4287                      clr.l      d7
[00002dfc] 1e1d                      move.b     (a5)+,d7
[00002dfe] d887                      add.l      d7,d4
[00002e00] 5385                      subq.l     #1,d5
[00002e02] 60f2                      bra.s      _hash_3
_hash_2:
[00002e04] 2e84                      move.l     d4,(a7)
[00002e06] 4878 0080                 pea.l      (_exit).w
[00002e0a] 4eb9 0000 44ae            jsr        a.lmod
[00002e10] 2e17                      move.l     (a7),d7
[00002e12] e587                      asl.l      #2,d7
[00002e14] 0687 0002 0e50            addi.l     #$000263A0,d7
[00002e1a] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00002e1e] 4e5e                      unlk       a6
[00002e20] 4e75                      rts

_install:
[00002e22] 4e56 0000                 link       a6,#0
[00002e26] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00002e2a] 2a2e 000c                 move.l     12(a6),d5
[00002e2e] 0c85 0000 007f            cmpi.l     #$0000007F,d5
[00002e34] 6404                      bcc.s      _install_1
[00002e36] 2e05                      move.l     d5,d7
[00002e38] 6002                      bra.s      _install_2
_install_1:
[00002e3a] 7e7f                      moveq.l    #127,d7
_install_2:
[00002e3c] 2a07                      move.l     d7,d5
[00002e3e] 2e85                      move.l     d5,(a7)
[00002e40] 2f2e 0008                 move.l     8(a6),-(a7)
[00002e44] 4eba ff94                 jsr        _hash(pc)
[00002e48] 588f                      addq.l     #4,a7
[00002e4a] 2a47                      movea.l    d7,a5
[00002e4c] 2e95                      move.l     (a5),(a7)
[00002e4e] 2f05                      move.l     d5,-(a7)
[00002e50] 0697 0000 0010            addi.l     #$00000010,(a7)
[00002e56] 4eb9 0000 486e            jsr        _alloc
[00002e5c] 588f                      addq.l     #4,a7
[00002e5e] 2847                      movea.l    d7,a4
[00002e60] 2a8c                      move.l     a4,(a5)
[00002e62] 42ac 000c                 clr.l      12(a4)
[00002e66] 2e85                      move.l     d5,(a7)
[00002e68] 2f2e 0008                 move.l     8(a6),-(a7)
[00002e6c] 486c 0010                 pea.l      16(a4)
[00002e70] 4eb9 0000 4d14            jsr        _cpybuf
[00002e76] 508f                      addq.l     #8,a7
[00002e78] 2945 0008                 move.l     d5,8(a4)
[00002e7c] 296e 0010 0004            move.l     16(a6),4(a4)
[00002e82] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00002e86] 4e5e                      unlk       a6
[00002e88] 4e75                      rts

_lookup:
[00002e8a] 4e56 0000                 link       a6,#0
[00002e8e] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00002e92] 2a6e 0008                 movea.l    8(a6),a5
[00002e96] 2a2e 000c                 move.l     12(a6),d5
[00002e9a] 0c85 0000 007f            cmpi.l     #$0000007F,d5
[00002ea0] 6404                      bcc.s      _lookup_1
[00002ea2] 2e05                      move.l     d5,d7
[00002ea4] 6002                      bra.s      _lookup_2
_lookup_1:
[00002ea6] 7e7f                      moveq.l    #127,d7
_lookup_2:
[00002ea8] 2a07                      move.l     d7,d5
[00002eaa] 2e85                      move.l     d5,(a7)
[00002eac] 2f0d                      move.l     a5,-(a7)
[00002eae] 4eba ff2a                 jsr        _hash(pc)
[00002eb2] 588f                      addq.l     #4,a7
[00002eb4] 2447                      movea.l    d7,a2
[00002eb6] 2852                      movea.l    (a2),a4
_lookup_7:
[00002eb8] 2e0c                      move.l     a4,d7
[00002eba] 672e                      beq.s      _lookup_3
[00002ebc] 4aac 000c                 tst.l      12(a4)
[00002ec0] 662c                      bne.s      _lookup_4
[00002ec2] baac 0008                 cmp.l      8(a4),d5
[00002ec6] 6626                      bne.s      _lookup_4
[00002ec8] 2e85                      move.l     d5,(a7)
[00002eca] 486c 0010                 pea.l      16(a4)
[00002ece] 2f0d                      move.l     a5,-(a7)
[00002ed0] 4eb9 0000 4cde            jsr        _cmpbuf
[00002ed6] 508f                      addq.l     #8,a7
[00002ed8] 4a87                      tst.l      d7
[00002eda] 6712                      beq.s      _lookup_4
[00002edc] 4aae 0010                 tst.l      16(a6)
[00002ee0] 6710                      beq.s      _lookup_5
[00002ee2] 246e 0010                 movea.l    16(a6),a2
[00002ee6] 248c                      move.l     a4,(a2)
[00002ee8] 6008                      bra.s      _lookup_5
_lookup_3:
[00002eea] 4287                      clr.l      d7
[00002eec] 6008                      bra.s      _lookup_6
_lookup_4:
[00002eee] 2854                      movea.l    (a4),a4
[00002ef0] 60c6                      bra.s      _lookup_7
_lookup_5:
[00002ef2] 2e2c 0004                 move.l     4(a4),d7
_lookup_6:
[00002ef6] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00002efa] 4e5e                      unlk       a6
[00002efc] 4e75                      rts

_nxtfile:
[00002efe] 4e56 0000                 link       a6,#0
[00002f02] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00002f06] 4878 0002                 pea.l      ($00000002).w
[00002f0a] 42a7                      clr.l      -(a7)
[00002f0c] 2f3c 0002 0a70            move.l     #$00025FC0,-(a7)
[00002f12] 2f3c 0002 0a62            move.l     #$00025FB2,-(a7)
[00002f18] 4eb9 0000 3924            jsr        _getfiles
[00002f1e] 4fef 0010                 lea.l      16(a7),a7
[00002f22] 2a07                      move.l     d7,d5
[00002f24] 0c85 0000 0002            cmpi.l     #$00000002,d5
[00002f2a] 661c                      bne.s      _nxtfile_1
[00002f2c] 42b9 0002 0a62            clr.l      $00025FB2
[00002f32] 2479 0002 0a70            movea.l    $00025FC0,a2
[00002f38] 598a                      subq.l     #4,a2
[00002f3a] 2e92                      move.l     (a2),(a7)
[00002f3c] 2f3c 0002 1054            move.l     #$000265A4,-(a7)
[00002f42] 4eba fbbc                 jsr        _fatal(pc)
[00002f46] 588f                      addq.l     #4,a7
_nxtfile_1:
[00002f48] 4a85                      tst.l      d5
[00002f4a] 6c04                      bge.s      _nxtfile_2
[00002f4c] 4287                      clr.l      d7
[00002f4e] 6062                      bra.s      _nxtfile_3
_nxtfile_2:
[00002f50] 4297                      clr.l      (a7)
[00002f52] 4878 0214                 pea.l      ($00000214).w
[00002f56] 4eb9 0000 486e            jsr        _alloc
[00002f5c] 588f                      addq.l     #4,a7
[00002f5e] 2a47                      movea.l    d7,a5
[00002f60] 4a85                      tst.l      d5
[00002f62] 6606                      bne.s      _nxtfile_4
[00002f64] 42ad 0004                 clr.l      4(a5)
[00002f68] 602a                      bra.s      _nxtfile_5
_nxtfile_4:
[00002f6a] 2479 0002 0a70            movea.l    $00025FC0,a2
[00002f70] 598a                      subq.l     #4,a2
[00002f72] 2e92                      move.l     (a2),(a7)
[00002f74] 4eb9 0000 52f4            jsr        _lenstr
[00002f7a] 2e87                      move.l     d7,(a7)
[00002f7c] 5297                      addq.l     #1,(a7)
[00002f7e] 2479 0002 0a70            movea.l    $00025FC0,a2
[00002f84] 598a                      subq.l     #4,a2
[00002f86] 2f12                      move.l     (a2),-(a7)
[00002f88] 4eb9 0000 4082            jsr        _buybuf
[00002f8e] 588f                      addq.l     #4,a7
[00002f90] 2b47 0004                 move.l     d7,4(a5)
_nxtfile_5:
[00002f94] 7001                      moveq.l    #1,d0
[00002f96] 23c0 0002 0a5e            move.l     d0,$00025FAE
[00002f9c] 426d 0008                 clr.w      8(a5)
[00002fa0] 4297                      clr.l      (a7)
[00002fa2] 2f05                      move.l     d5,-(a7)
[00002fa4] 486d 000a                 pea.l      10(a5)
[00002fa8] 4eb9 0000 42c0            jsr        _finit
[00002fae] 508f                      addq.l     #8,a7
[00002fb0] 2e0d                      move.l     a5,d7
_nxtfile_3:
[00002fb2] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00002fb6] 4e5e                      unlk       a6
[00002fb8] 4e75                      rts

_perrfmt:
[00002fba] 4e56 fff2                 link       a6,#-14
[00002fbe] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00002fc2] 45ee 000c                 lea.l      12(a6),a2
[00002fc6] 2a4a                      movea.l    a2,a5
[00002fc8] 286e 0008                 movea.l    8(a6),a4
_perrfmt_8:
[00002fcc] 4a14                      tst.b      (a4)
[00002fce] 6736                      beq.s      _perrfmt_1
[00002fd0] 4287                      clr.l      d7
[00002fd2] 1e14                      move.b     (a4),d7
[00002fd4] 0c47 0025                 cmpi.w     #$0025,d7
[00002fd8] 6734                      beq.s      _perrfmt_2
[00002fda] 4878 0001                 pea.l      ($00000001).w
[00002fde] 2f0c                      move.l     a4,-(a7)
[00002fe0] 3e39 0002 0a6a            move.w     $00025FBA,d7
[00002fe6] 48c7                      ext.l      d7
[00002fe8] 2f07                      move.l     d7,-(a7)
[00002fea] 4eb9 0000 5548            jsr        _write
[00002ff0] 4fef 000c                 lea.l      12(a7),a7
[00002ff4] 2479 0002 0a74            movea.l    $00025FC4,a2
[00002ffa] 52b9 0002 0a74            addq.l     #1,$00025FC4
[00003000] 1494                      move.b     (a4),(a2)
[00003002] 6000 0104                 bra        _perrfmt_3
_perrfmt_1:
[00003006] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000300a] 4e5e                      unlk       a6
[0000300c] 4e75                      rts
_perrfmt_2:
[0000300e] 528c                      addq.l     #1,a4
[00003010] 4287                      clr.l      d7
[00003012] 1e14                      move.b     (a4),d7
[00003014] 0c47 0063                 cmpi.w     #$0063,d7
[00003018] 6636                      bne.s      _perrfmt_4
[0000301a] 201d                      move.l     (a5)+,d0
[0000301c] 1d40 fff2                 move.b     d0,-14(a6)
[00003020] 4878 0001                 pea.l      ($00000001).w
[00003024] 486e fff2                 pea.l      -14(a6)
[00003028] 3e39 0002 0a6a            move.w     $00025FBA,d7
[0000302e] 48c7                      ext.l      d7
[00003030] 2f07                      move.l     d7,-(a7)
[00003032] 4eb9 0000 5548            jsr        _write
[00003038] 4fef 000c                 lea.l      12(a7),a7
[0000303c] 2479 0002 0a74            movea.l    $00025FC4,a2
[00003042] 52b9 0002 0a74            addq.l     #1,$00025FC4
[00003048] 14ae fff2                 move.b     -14(a6),(a2)
[0000304c] 6000 00ba                 bra        _perrfmt_3
_perrfmt_4:
[00003050] 4287                      clr.l      d7
[00003052] 1e14                      move.b     (a4),d7
[00003054] 0c47 0073                 cmpi.w     #$0073,d7
[00003058] 665a                      bne.s      _perrfmt_5
[0000305a] 4878 000a                 pea.l      ($0000000A).w
[0000305e] 2f1d                      move.l     (a5)+,-(a7)
[00003060] 486e fff2                 pea.l      -14(a6)
[00003064] 4eb9 0000 3f4a            jsr        _itob
[0000306a] 4fef 000c                 lea.l      12(a7),a7
[0000306e] 2d47 fffc                 move.l     d7,-4(a6)
[00003072] 45ee fff2                 lea.l      -14(a6),a2
[00003076] d5ee fffc                 adda.l     -4(a6),a2
[0000307a] 4212                      clr.b      (a2)
[0000307c] 2eae fffc                 move.l     -4(a6),(a7)
[00003080] 486e fff2                 pea.l      -14(a6)
[00003084] 3e39 0002 0a6a            move.w     $00025FBA,d7
[0000308a] 48c7                      ext.l      d7
[0000308c] 2f07                      move.l     d7,-(a7)
[0000308e] 4eb9 0000 5548            jsr        _write
[00003094] 508f                      addq.l     #8,a7
[00003096] 2eae fffc                 move.l     -4(a6),(a7)
[0000309a] 486e fff2                 pea.l      -14(a6)
[0000309e] 2f39 0002 0a74            move.l     $00025FC4,-(a7)
[000030a4] 4eb9 0000 4d14            jsr        _cpybuf
[000030aa] 508f                      addq.l     #8,a7
[000030ac] dfb9 0002 0a74            add.l      d7,$00025FC4
[000030b2] 6054                      bra.s      _perrfmt_3
_perrfmt_5:
[000030b4] 2655                      movea.l    (a5),a3
[000030b6] 2e0d                      move.l     a5,d7
[000030b8] 5887                      addq.l     #4,d7
[000030ba] 2a47                      movea.l    d7,a5
[000030bc] 4287                      clr.l      d7
[000030be] 1e14                      move.b     (a4),d7
[000030c0] 0c47 0062                 cmpi.w     #$0062,d7
[000030c4] 6604                      bne.s      _perrfmt_6
[000030c6] 2e1d                      move.l     (a5)+,d7
[000030c8] 6008                      bra.s      _perrfmt_7
_perrfmt_6:
[000030ca] 2e8b                      move.l     a3,(a7)
[000030cc] 4eb9 0000 52f4            jsr        _lenstr
_perrfmt_7:
[000030d2] 2d47 fffc                 move.l     d7,-4(a6)
[000030d6] 2eae fffc                 move.l     -4(a6),(a7)
[000030da] 2f0b                      move.l     a3,-(a7)
[000030dc] 3e39 0002 0a6a            move.w     $00025FBA,d7
[000030e2] 48c7                      ext.l      d7
[000030e4] 2f07                      move.l     d7,-(a7)
[000030e6] 4eb9 0000 5548            jsr        _write
[000030ec] 508f                      addq.l     #8,a7
[000030ee] 2eae fffc                 move.l     -4(a6),(a7)
[000030f2] 2f0b                      move.l     a3,-(a7)
[000030f4] 2f39 0002 0a74            move.l     $00025FC4,-(a7)
[000030fa] 4eb9 0000 4d14            jsr        _cpybuf
[00003100] 508f                      addq.l     #8,a7
[00003102] dfb9 0002 0a74            add.l      d7,$00025FC4
_perrfmt_3:
[00003108] 528c                      addq.l     #1,a4
[0000310a] 6000 fec0                 bra        _perrfmt_8

_p0error:
[0000310e] 4e56 fff8                 link       a6,#-8
[00003112] 23fc 0002 0a7a 0002 0a74  move.l     #$00025FCA,$00025FC4
[0000311c] 2e39 0002 0a62            move.l     $00025FB2,d7
[00003122] e587                      asl.l      #2,d7
[00003124] 2447                      movea.l    d7,a2
[00003126] 598a                      subq.l     #4,a2
[00003128] d5f9 0002 0a70            adda.l     $00025FC0,a2
[0000312e] 4a92                      tst.l      (a2)
[00003130] 660c                      bne.s      _p0error_1
[00003132] 2ebc 0002 1084            move.l     #$000265D4,(a7)
[00003138] 4eba fe80                 jsr        _perrfmt(pc)
[0000313c] 6076                      bra.s      _p0error_2
_p0error_1:
[0000313e] 2ebc 0002 1067            move.l     #$000265B7,(a7)
[00003144] 4ab9 0002 0a6c            tst.l      $00025FBC
[0000314a] 670e                      beq.s      _p0error_3
[0000314c] 2479 0002 0a6c            movea.l    $00025FBC,a2
[00003152] 508a                      addq.l     #8,a2
[00003154] 3e12                      move.w     (a2),d7
[00003156] 48c7                      ext.l      d7
[00003158] 6008                      bra.s      _p0error_4
_p0error_3:
[0000315a] 3e39 0002 0a66            move.w     $00025FB6,d7
[00003160] 48c7                      ext.l      d7
_p0error_4:
[00003162] 2f07                      move.l     d7,-(a7)
[00003164] 2f3c 0002 1069            move.l     #$000265B9,-(a7)
[0000316a] 4ab9 0002 0a6c            tst.l      $00025FBC
[00003170] 670c                      beq.s      _p0error_5
[00003172] 2479 0002 0a6c            movea.l    $00025FBC,a2
[00003178] 588a                      addq.l     #4,a2
[0000317a] 2e12                      move.l     (a2),d7
[0000317c] 6014                      bra.s      _p0error_6
_p0error_5:
[0000317e] 2e39 0002 0a62            move.l     $00025FB2,d7
[00003184] e587                      asl.l      #2,d7
[00003186] 2447                      movea.l    d7,a2
[00003188] 598a                      subq.l     #4,a2
[0000318a] d5f9 0002 0a70            adda.l     $00025FC0,a2
[00003190] 2e12                      move.l     (a2),d7
_p0error_6:
[00003192] 2f07                      move.l     d7,-(a7)
[00003194] 2f3c 0002 106b            move.l     #$000265BB,-(a7)
[0000319a] 2f39 0002 0a4e            move.l     $00025F9E,-(a7)
[000031a0] 2f3c 0002 106d            move.l     #$000265BD,-(a7)
[000031a6] 2f3c 0002 1075            move.l     #$000265C5,-(a7)
[000031ac] 4eba fe0c                 jsr        _perrfmt(pc)
[000031b0] 4fef 001c                 lea.l      28(a7),a7
_p0error_2:
[000031b4] 2eae 0010                 move.l     16(a6),(a7)
[000031b8] 2f2e 000c                 move.l     12(a6),-(a7)
[000031bc] 2f2e 0008                 move.l     8(a6),-(a7)
[000031c0] 4eba fdf8                 jsr        _perrfmt(pc)
[000031c4] 508f                      addq.l     #8,a7
[000031c6] 2ebc 0002 1065            move.l     #$000265B5,(a7)
[000031cc] 4eba fdec                 jsr        _perrfmt(pc)
[000031d0] 5279 0002 0a68            addq.w     #1,$00025FB8
[000031d6] 2479 0002 0a74            movea.l    $00025FC4,a2
[000031dc] 4212                      clr.b      (a2)
[000031de] 2e39 0002 0a74            move.l     $00025FC4,d7
[000031e4] 0487 0002 0a78            subi.l     #$00025FC8,d7
[000031ea] 5587                      subq.l     #2,d7
[000031ec] 2d47 fffc                 move.l     d7,-4(a6)
[000031f0] 4878 0002                 pea.l      ($00000002).w
[000031f4] 486e fffc                 pea.l      -4(a6)
[000031f8] 2f3c 0002 0a78            move.l     #$00025FC8,-(a7)
[000031fe] 4eb9 0000 4d14            jsr        _cpybuf
[00003204] 4fef 000c                 lea.l      12(a7),a7
[00003208] 54ae fffc                 addq.l     #2,-4(a6)
[0000320c] 4ab9 0002 0a2e            tst.l      $00025F7E
[00003212] 671e                      beq.s      _p0error_7
[00003214] 2eae fffc                 move.l     -4(a6),(a7)
[00003218] 2f3c 0002 0a78            move.l     #$00025FC8,-(a7)
[0000321e] 4878 00fe                 pea.l      ($000000FE).w
[00003222] 2f3c 0002 1062            move.l     #$000265B2,-(a7)
[00003228] 4eb9 0000 19aa            jsr        _putcode
[0000322e] 4fef 000c                 lea.l      12(a7),a7
_p0error_7:
[00003232] 4e5e                      unlk       a6
[00003234] 4e75                      rts

_predef:
[00003236] 4e56 fff8                 link       a6,#-8
[0000323a] 48e7 8c1c                 movem.l    d0/d4-d5/a3-a5,-(a7)
[0000323e] 2a6e 0008                 movea.l    8(a6),a5
[00003242] 426e fffe                 clr.w      -2(a6)
_predef_7:
[00003246] 2e15                      move.l     (a5),d7
[00003248] 7c0a                      moveq.l    #10,d6
[0000324a] 382e fffe                 move.w     -2(a6),d4
[0000324e] 48c4                      ext.l      d4
[00003250] 9c84                      sub.l      d4,d6
[00003252] be86                      cmp.l      d6,d7
[00003254] 643e                      bcc.s      _predef_1
[00003256] 7e09                      moveq.l    #9,d7
[00003258] 3c2e fffe                 move.w     -2(a6),d6
[0000325c] 48c6                      ext.l      d6
[0000325e] 9e86                      sub.l      d6,d7
[00003260] e587                      asl.l      #2,d7
[00003262] 2447                      movea.l    d7,a2
[00003264] 47ed 0004                 lea.l      4(a5),a3
[00003268] d5cb                      adda.l     a3,a2
[0000326a] 2852                      movea.l    (a2),a4
[0000326c] 2ebc 0002 109e            move.l     #$000265EE,(a7)
[00003272] 2f0c                      move.l     a4,-(a7)
[00003274] 4eb9 0000 446c            jsr        _instr
[0000327a] 588f                      addq.l     #4,a7
[0000327c] 2a07                      move.l     d7,d5
[0000327e] 4a34 5800                 tst.b      0(a4,d5.l)
[00003282] 6618                      bne.s      _predef_2
[00003284] 3d7c 0003 fffc            move.w     #$0003,-4(a6)
[0000328a] 2d7c 0002 109a fff8       move.l     #$000265EA,-8(a6)
[00003292] 6044                      bra.s      _predef_3
_predef_1:
[00003294] 4cdf 3831                 movem.l    (a7)+,d0/d4-d5/a3-a5
[00003298] 4e5e                      unlk       a6
[0000329a] 4e75                      rts
_predef_2:
[0000329c] 4287                      clr.l      d7
[0000329e] 1e34 5800                 move.b     0(a4,d5.l),d7
[000032a2] 0c47 003d                 cmpi.w     #$003D,d7
[000032a6] 6606                      bne.s      _predef_4
[000032a8] 19bc 0020 5800            move.b     #$20,0(a4,d5.l)
_predef_4:
[000032ae] 2e8c                      move.l     a4,(a7)
[000032b0] 4eb9 0000 52f4            jsr        _lenstr
[000032b6] 9e85                      sub.l      d5,d7
[000032b8] 5287                      addq.l     #1,d7
[000032ba] 3d47 fffc                 move.w     d7,-4(a6)
[000032be] 2e0c                      move.l     a4,d7
[000032c0] de85                      add.l      d5,d7
[000032c2] 2d47 fff8                 move.l     d7,-8(a6)
[000032c6] 3e2e fffc                 move.w     -4(a6),d7
[000032ca] 48c7                      ext.l      d7
[000032cc] 2447                      movea.l    d7,a2
[000032ce] 538a                      subq.l     #1,a2
[000032d0] d5ee fff8                 adda.l     -8(a6),a2
[000032d4] 14bc 000a                 move.b     #$0A,(a2)
_predef_3:
[000032d8] 4297                      clr.l      (a7)
[000032da] 2f05                      move.l     d5,-(a7)
[000032dc] 2f0c                      move.l     a4,-(a7)
[000032de] 4eba fbaa                 jsr        _lookup(pc)
[000032e2] 508f                      addq.l     #8,a7
[000032e4] 4a87                      tst.l      d7
[000032e6] 6712                      beq.s      _predef_5
[000032e8] 2e85                      move.l     d5,(a7)
[000032ea] 2f0c                      move.l     a4,-(a7)
[000032ec] 2f3c 0002 108a            move.l     #$000265DA,-(a7)
[000032f2] 4eba fe1a                 jsr        _p0error(pc)
[000032f6] 508f                      addq.l     #8,a7
[000032f8] 6020                      bra.s      _predef_6
_predef_5:
[000032fa] 3e2e fffc                 move.w     -4(a6),d7
[000032fe] 48c7                      ext.l      d7
[00003300] 2e87                      move.l     d7,(a7)
[00003302] 2f2e fff8                 move.l     -8(a6),-(a7)
[00003306] 4eb9 0000 4082            jsr        _buybuf
[0000330c] 588f                      addq.l     #4,a7
[0000330e] 2e87                      move.l     d7,(a7)
[00003310] 2f05                      move.l     d5,-(a7)
[00003312] 2f0c                      move.l     a4,-(a7)
[00003314] 4eba fb0c                 jsr        _install(pc)
[00003318] 508f                      addq.l     #8,a7
_predef_6:
[0000331a] 526e fffe                 addq.w     #1,-2(a6)
[0000331e] 6000 ff26                 bra        _predef_7

_ptline:
[00003322] 4e56 fffc                 link       a6,#-4
[00003326] 4ab9 0002 0a6c            tst.l      $00025FBC
[0000332c] 6720                      beq.s      _ptline_1
[0000332e] 4ab9 0002 0a2e            tst.l      $00025F7E
[00003334] 6718                      beq.s      _ptline_1
[00003336] 4ab9 0002 0a56            tst.l      $00025FA6
[0000333c] 6610                      bne.s      _ptline_1
[0000333e] 4ab9 0002 0a1e            tst.l      $00025F6E
[00003344] 660c                      bne.s      _ptline_2
[00003346] 4a79 0002 0a3c            tst.w      $00025F8C
[0000334c] 6704                      beq.s      _ptline_2
_ptline_1:
[0000334e] 4e5e                      unlk       a6
[00003350] 4e75                      rts
_ptline_2:
[00003352] 2eb9 0002 0a6c            move.l     $00025FBC,(a7)
[00003358] 5097                      addq.l     #8,(a7)
[0000335a] 4878 0014                 pea.l      ($00000014).w
[0000335e] 2f3c 0002 10a2            move.l     #$000265F2,-(a7)
[00003364] 4eb9 0000 19aa            jsr        _putcode
[0000336a] 508f                      addq.l     #8,a7
[0000336c] 60e0                      bra.s      _ptline_1

_scntab:
[0000336e] 4e56 fff6                 link       a6,#-10
[00003372] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00003376] 42ae fff8                 clr.l      -8(a6)
_scntab_6:
[0000337a] 2e2e fff8                 move.l     -8(a6),d7
[0000337e] beae 000c                 cmp.l      12(a6),d7
[00003382] 6448                      bcc.s      _scntab_1
[00003384] 2e2e 000c                 move.l     12(a6),d7
[00003388] deae fff8                 add.l      -8(a6),d7
[0000338c] e28f                      lsr.l      #1,d7
[0000338e] 2d47 fffc                 move.l     d7,-4(a6)
[00003392] 2e2e fffc                 move.l     -4(a6),d7
[00003396] e787                      asl.l      #3,d7
[00003398] 2447                      movea.l    d7,a2
[0000339a] d5ee 0008                 adda.l     8(a6),a2
[0000339e] 2852                      movea.l    (a2),a4
[000033a0] 4287                      clr.l      d7
[000033a2] 1e1c                      move.b     (a4)+,d7
[000033a4] 9eae 0014                 sub.l      20(a6),d7
[000033a8] 3d47 fff6                 move.w     d7,-10(a6)
[000033ac] 6622                      bne.s      _scntab_2
[000033ae] 4285                      clr.l      d5
[000033b0] 2a6e 0010                 movea.l    16(a6),a5
_scntab_7:
[000033b4] baae 0014                 cmp.l      20(a6),d5
[000033b8] 6416                      bcc.s      _scntab_2
[000033ba] 4287                      clr.l      d7
[000033bc] 1e1c                      move.b     (a4)+,d7
[000033be] 4286                      clr.l      d6
[000033c0] 1c1d                      move.b     (a5)+,d6
[000033c2] 9e86                      sub.l      d6,d7
[000033c4] 3d47 fff6                 move.w     d7,-10(a6)
[000033c8] 6718                      beq.s      _scntab_3
[000033ca] 6004                      bra.s      _scntab_2
_scntab_1:
[000033cc] 4287                      clr.l      d7
[000033ce] 602c                      bra.s      _scntab_4
_scntab_2:
[000033d0] 4a6e fff6                 tst.w      -10(a6)
[000033d4] 6c10                      bge.s      _scntab_5
[000033d6] 2e2e fffc                 move.l     -4(a6),d7
[000033da] 5287                      addq.l     #1,d7
[000033dc] 2d47 fff8                 move.l     d7,-8(a6)
[000033e0] 6098                      bra.s      _scntab_6
_scntab_3:
[000033e2] 5285                      addq.l     #1,d5
[000033e4] 60ce                      bra.s      _scntab_7
_scntab_5:
[000033e6] 4a6e fff6                 tst.w      -10(a6)
[000033ea] 6618                      bne.s      _scntab_8
[000033ec] 2e2e fffc                 move.l     -4(a6),d7
[000033f0] e787                      asl.l      #3,d7
[000033f2] 2447                      movea.l    d7,a2
[000033f4] d5ee 0008                 adda.l     8(a6),a2
[000033f8] 588a                      addq.l     #4,a2
[000033fa] 2e12                      move.l     (a2),d7
_scntab_4:
[000033fc] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00003400] 4e5e                      unlk       a6
[00003402] 4e75                      rts
_scntab_8:
[00003404] 2d6e fffc 000c            move.l     -4(a6),12(a6)
[0000340a] 6000 ff6e                 bra        _scntab_6

_stotl:
[0000340e] 4e56 fff8                 link       a6,#-8
[00003412] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00003416] 2a6e 0008                 movea.l    8(a6),a5
[0000341a] 4aae 000c                 tst.l      12(a6)
[0000341e] 660c                      bne.s      _stotl_1
[00003420] 45ee fff8                 lea.l      -8(a6),a2
[00003424] 2d4a 000c                 move.l     a2,12(a6)
[00003428] 42ae fff8                 clr.l      -8(a6)
_stotl_1:
[0000342c] 45ee fffc                 lea.l      -4(a6),a2
[00003430] 264a                      movea.l    a2,a3
_stotl_47:
[00003432] 4297                      clr.l      (a7)
[00003434] 42a7                      clr.l      -(a7)
[00003436] 4eba f650                 jsr        _buytl(pc)
[0000343a] 588f                      addq.l     #4,a7
[0000343c] 2847                      movea.l    d7,a4
[0000343e] 294d 0008                 move.l     a5,8(a4)
_stotl_7:
[00003442] 4287                      clr.l      d7
[00003444] 1e15                      move.b     (a5),d7
[00003446] 0c47 000a                 cmpi.w     #$000A,d7
[0000344a] 6716                      beq.s      _stotl_2
[0000344c] 4287                      clr.l      d7
[0000344e] 1e15                      move.b     (a5),d7
[00003450] 0c47 0020                 cmpi.w     #$0020,d7
[00003454] 6336                      bls.s      _stotl_3
[00003456] 4287                      clr.l      d7
[00003458] 1e15                      move.b     (a5),d7
[0000345a] 0c47 007f                 cmpi.w     #$007F,d7
[0000345e] 6530                      bcs.s      _stotl_4
[00003460] 602a                      bra.s      _stotl_3
_stotl_2:
[00003462] 2e0d                      move.l     a5,d7
[00003464] 9eac 0008                 sub.l      8(a4),d7
[00003468] 2947 000c                 move.l     d7,12(a4)
[0000346c] 294d 0010                 move.l     a5,16(a4)
[00003470] 42ac 0014                 clr.l      20(a4)
[00003474] 4287                      clr.l      d7
[00003476] 1e15                      move.b     (a5),d7
[00003478] 0c47 000a                 cmpi.w     #$000A,d7
[0000347c] 6600 00fe                 bne        _stotl_5
[00003480] 528d                      addq.l     #1,a5
[00003482] 7002                      moveq.l    #2,d0
[00003484] 2940 0004                 move.l     d0,4(a4)
[00003488] 6000 01cc                 bra        _stotl_6
_stotl_3:
[0000348c] 528d                      addq.l     #1,a5
[0000348e] 60b2                      bra.s      _stotl_7
_stotl_4:
[00003490] 246e 000c                 movea.l    12(a6),a2
[00003494] 4a92                      tst.l      (a2)
[00003496] 661e                      bne.s      _stotl_8
[00003498] 4ab9 0002 0a26            tst.l      $00025F76
[0000349e] 6632                      bne.s      _stotl_9
[000034a0] 4287                      clr.l      d7
[000034a2] 1e15                      move.b     (a5),d7
[000034a4] 0c47 002f                 cmpi.w     #$002F,d7
[000034a8] 6628                      bne.s      _stotl_9
[000034aa] 4287                      clr.l      d7
[000034ac] 1e2d 0001                 move.b     1(a5),d7
[000034b0] 0c47 002a                 cmpi.w     #$002A,d7
[000034b4] 661c                      bne.s      _stotl_9
_stotl_8:
[000034b6] 246e 000c                 movea.l    12(a6),a2
[000034ba] 4a92                      tst.l      (a2)
[000034bc] 6642                      bne.s      _stotl_10
[000034be] 4287                      clr.l      d7
[000034c0] 1e15                      move.b     (a5),d7
[000034c2] 0c47 007b                 cmpi.w     #$007B,d7
[000034c6] 6604                      bne.s      _stotl_11
[000034c8] 7e01                      moveq.l    #1,d7
[000034ca] 6002                      bra.s      _stotl_12
_stotl_11:
[000034cc] 7e02                      moveq.l    #2,d7
_stotl_12:
[000034ce] dbc7                      adda.l     d7,a5
[000034d0] 602e                      bra.s      _stotl_10
_stotl_9:
[000034d2] 4ab9 0002 0a26            tst.l      $00025F76
[000034d8] 6788                      beq.s      _stotl_2
[000034da] 4287                      clr.l      d7
[000034dc] 1e15                      move.b     (a5),d7
[000034de] 0c47 007b                 cmpi.w     #$007B,d7
[000034e2] 67d2                      beq.s      _stotl_8
[000034e4] 4287                      clr.l      d7
[000034e6] 1e15                      move.b     (a5),d7
[000034e8] 0c47 0028                 cmpi.w     #$0028,d7
[000034ec] 6600 ff74                 bne        _stotl_2
[000034f0] 4287                      clr.l      d7
[000034f2] 1e2d 0001                 move.b     1(a5),d7
[000034f6] 0c47 002a                 cmpi.w     #$002A,d7
[000034fa] 67ba                      beq.s      _stotl_8
[000034fc] 6000 ff64                 bra        _stotl_2
_stotl_10:
[00003500] 246e 000c                 movea.l    12(a6),a2
[00003504] 7001                      moveq.l    #1,d0
[00003506] 2480                      move.l     d0,(a2)
_stotl_15:
[00003508] 4287                      clr.l      d7
[0000350a] 1e15                      move.b     (a5),d7
[0000350c] 0c47 000a                 cmpi.w     #$000A,d7
[00003510] 6700 ff30                 beq        _stotl_7
[00003514] 4ab9 0002 0a26            tst.l      $00025F76
[0000351a] 661c                      bne.s      _stotl_13
[0000351c] 4287                      clr.l      d7
[0000351e] 1e15                      move.b     (a5),d7
[00003520] 0c47 002a                 cmpi.w     #$002A,d7
[00003524] 6612                      bne.s      _stotl_13
[00003526] 4287                      clr.l      d7
[00003528] 1e2d 0001                 move.b     1(a5),d7
[0000352c] 0c47 002f                 cmpi.w     #$002F,d7
[00003530] 672e                      beq.s      _stotl_14
[00003532] 6004                      bra.s      _stotl_13
_stotl_16:
[00003534] 528d                      addq.l     #1,a5
[00003536] 60d0                      bra.s      _stotl_15
_stotl_13:
[00003538] 4ab9 0002 0a26            tst.l      $00025F76
[0000353e] 67f4                      beq.s      _stotl_16
[00003540] 4287                      clr.l      d7
[00003542] 1e15                      move.b     (a5),d7
[00003544] 0c47 007d                 cmpi.w     #$007D,d7
[00003548] 6716                      beq.s      _stotl_14
[0000354a] 4287                      clr.l      d7
[0000354c] 1e15                      move.b     (a5),d7
[0000354e] 0c47 002a                 cmpi.w     #$002A,d7
[00003552] 66e0                      bne.s      _stotl_16
[00003554] 4287                      clr.l      d7
[00003556] 1e2d 0001                 move.b     1(a5),d7
[0000355a] 0c47 0029                 cmpi.w     #$0029,d7
[0000355e] 66d4                      bne.s      _stotl_16
_stotl_14:
[00003560] 246e 000c                 movea.l    12(a6),a2
[00003564] 4292                      clr.l      (a2)
[00003566] 4287                      clr.l      d7
[00003568] 1e15                      move.b     (a5),d7
[0000356a] 0c47 007d                 cmpi.w     #$007D,d7
[0000356e] 6604                      bne.s      _stotl_17
[00003570] 7e01                      moveq.l    #1,d7
[00003572] 6002                      bra.s      _stotl_18
_stotl_17:
[00003574] 7e02                      moveq.l    #2,d7
_stotl_18:
[00003576] dbc7                      adda.l     d7,a5
[00003578] 6000 fec8                 bra        _stotl_7
_stotl_5:
[0000357c] 4287                      clr.l      d7
[0000357e] 1e15                      move.b     (a5),d7
[00003580] 0c47 0061                 cmpi.w     #$0061,d7
[00003584] 650a                      bcs.s      _stotl_19
[00003586] 4287                      clr.l      d7
[00003588] 1e15                      move.b     (a5),d7
[0000358a] 0c47 007a                 cmpi.w     #$007A,d7
[0000358e] 6364                      bls.s      _stotl_20
_stotl_19:
[00003590] 4287                      clr.l      d7
[00003592] 1e15                      move.b     (a5),d7
[00003594] 0c47 0041                 cmpi.w     #$0041,d7
[00003598] 650a                      bcs.s      _stotl_21
[0000359a] 4287                      clr.l      d7
[0000359c] 1e15                      move.b     (a5),d7
[0000359e] 0c47 005a                 cmpi.w     #$005A,d7
[000035a2] 6350                      bls.s      _stotl_20
_stotl_21:
[000035a4] 4287                      clr.l      d7
[000035a6] 1e15                      move.b     (a5),d7
[000035a8] 0c47 005f                 cmpi.w     #$005F,d7
[000035ac] 6746                      beq.s      _stotl_20
[000035ae] 4ab9 0002 0a2a            tst.l      $00025F7A
[000035b4] 660a                      bne.s      _stotl_22
[000035b6] 4287                      clr.l      d7
[000035b8] 1e15                      move.b     (a5),d7
[000035ba] 0c47 0024                 cmpi.w     #$0024,d7
[000035be] 6734                      beq.s      _stotl_20
_stotl_22:
[000035c0] 4287                      clr.l      d7
[000035c2] 1e15                      move.b     (a5),d7
[000035c4] 0c47 0030                 cmpi.w     #$0030,d7
[000035c8] 6500 00a2                 bcs        _stotl_23
[000035cc] 4287                      clr.l      d7
[000035ce] 1e15                      move.b     (a5),d7
[000035d0] 0c47 0039                 cmpi.w     #$0039,d7
[000035d4] 6200 0096                 bhi        _stotl_23
_stotl_37:
[000035d8] 4287                      clr.l      d7
[000035da] 1e15                      move.b     (a5),d7
[000035dc] 0c47 0061                 cmpi.w     #$0061,d7
[000035e0] 6500 00a4                 bcs        _stotl_24
[000035e4] 4287                      clr.l      d7
[000035e6] 1e15                      move.b     (a5),d7
[000035e8] 0c47 007a                 cmpi.w     #$007A,d7
[000035ec] 6300 00d2                 bls        _stotl_25
[000035f0] 6000 0094                 bra        _stotl_24
_stotl_20:
[000035f4] 4287                      clr.l      d7
[000035f6] 1e15                      move.b     (a5),d7
[000035f8] 0c47 0061                 cmpi.w     #$0061,d7
[000035fc] 650a                      bcs.s      _stotl_26
[000035fe] 4287                      clr.l      d7
[00003600] 1e15                      move.b     (a5),d7
[00003602] 0c47 007a                 cmpi.w     #$007A,d7
[00003606] 6314                      bls.s      _stotl_27
_stotl_26:
[00003608] 4287                      clr.l      d7
[0000360a] 1e15                      move.b     (a5),d7
[0000360c] 0c47 0041                 cmpi.w     #$0041,d7
[00003610] 650e                      bcs.s      _stotl_28
[00003612] 4287                      clr.l      d7
[00003614] 1e15                      move.b     (a5),d7
[00003616] 0c47 005a                 cmpi.w     #$005A,d7
[0000361a] 6204                      bhi.s      _stotl_28
_stotl_27:
[0000361c] 528d                      addq.l     #1,a5
[0000361e] 60d4                      bra.s      _stotl_20
_stotl_28:
[00003620] 4287                      clr.l      d7
[00003622] 1e15                      move.b     (a5),d7
[00003624] 0c47 005f                 cmpi.w     #$005F,d7
[00003628] 67f2                      beq.s      _stotl_27
[0000362a] 4ab9 0002 0a2a            tst.l      $00025F7A
[00003630] 660a                      bne.s      _stotl_29
[00003632] 4287                      clr.l      d7
[00003634] 1e15                      move.b     (a5),d7
[00003636] 0c47 0024                 cmpi.w     #$0024,d7
[0000363a] 67e0                      beq.s      _stotl_27
_stotl_29:
[0000363c] 4287                      clr.l      d7
[0000363e] 1e15                      move.b     (a5),d7
[00003640] 0c47 0030                 cmpi.w     #$0030,d7
[00003644] 650a                      bcs.s      _stotl_30
[00003646] 4287                      clr.l      d7
[00003648] 1e15                      move.b     (a5),d7
[0000364a] 0c47 0039                 cmpi.w     #$0039,d7
[0000364e] 63cc                      bls.s      _stotl_27
_stotl_30:
[00003650] 7003                      moveq.l    #3,d0
[00003652] 2940 0004                 move.l     d0,4(a4)
_stotl_6:
[00003656] 4aac 0014                 tst.l      20(a4)
[0000365a] 6600 0178                 bne        _stotl_31
[0000365e] 2e0d                      move.l     a5,d7
[00003660] 9eac 0010                 sub.l      16(a4),d7
[00003664] 2947 0014                 move.l     d7,20(a4)
[00003668] 6000 016a                 bra        _stotl_31
_stotl_23:
[0000366c] 4287                      clr.l      d7
[0000366e] 1e15                      move.b     (a5),d7
[00003670] 0c47 0022                 cmpi.w     #$0022,d7
[00003674] 6700 0096                 beq        _stotl_32
[00003678] 4287                      clr.l      d7
[0000367a] 1e15                      move.b     (a5),d7
[0000367c] 0c47 0027                 cmpi.w     #$0027,d7
[00003680] 664c                      bne.s      _stotl_33
[00003682] 6000 0088                 bra        _stotl_32
_stotl_24:
[00003686] 4287                      clr.l      d7
[00003688] 1e15                      move.b     (a5),d7
[0000368a] 0c47 0041                 cmpi.w     #$0041,d7
[0000368e] 650a                      bcs.s      _stotl_34
[00003690] 4287                      clr.l      d7
[00003692] 1e15                      move.b     (a5),d7
[00003694] 0c47 005a                 cmpi.w     #$005A,d7
[00003698] 6326                      bls.s      _stotl_25
_stotl_34:
[0000369a] 4287                      clr.l      d7
[0000369c] 1e15                      move.b     (a5),d7
[0000369e] 0c47 0030                 cmpi.w     #$0030,d7
[000036a2] 650a                      bcs.s      _stotl_35
[000036a4] 4287                      clr.l      d7
[000036a6] 1e15                      move.b     (a5),d7
[000036a8] 0c47 0039                 cmpi.w     #$0039,d7
[000036ac] 6312                      bls.s      _stotl_25
_stotl_35:
[000036ae] 4ab9 0002 0a2a            tst.l      $00025F7A
[000036b4] 6610                      bne.s      _stotl_36
[000036b6] 4287                      clr.l      d7
[000036b8] 1e15                      move.b     (a5),d7
[000036ba] 0c47 005f                 cmpi.w     #$005F,d7
[000036be] 6606                      bne.s      _stotl_36
_stotl_25:
[000036c0] 528d                      addq.l     #1,a5
[000036c2] 6000 ff14                 bra        _stotl_37
_stotl_36:
[000036c6] 7004                      moveq.l    #4,d0
[000036c8] 2940 0004                 move.l     d0,4(a4)
[000036cc] 6088                      bra.s      _stotl_6
_stotl_33:
[000036ce] 4ab9 0002 0a2e            tst.l      $00025F7E
[000036d4] 6600 00f2                 bne        _stotl_38
[000036d8] 4287                      clr.l      d7
[000036da] 1e15                      move.b     (a5),d7
[000036dc] 0c47 005c                 cmpi.w     #$005C,d7
[000036e0] 6600 00e6                 bne        _stotl_38
[000036e4] 4287                      clr.l      d7
[000036e6] 1e2d 0001                 move.b     1(a5),d7
[000036ea] 0c47 006e                 cmpi.w     #$006E,d7
[000036ee] 6600 00d8                 bne        _stotl_38
[000036f2] 548d                      addq.l     #2,a5
[000036f4] 297c 0002 10a6 0010       move.l     #$000265F6,16(a4)
[000036fc] 7001                      moveq.l    #1,d0
[000036fe] 2940 0014                 move.l     d0,20(a4)
[00003702] 7005                      moveq.l    #5,d0
[00003704] 2940 0004                 move.l     d0,4(a4)
[00003708] 6000 ff4c                 bra        _stotl_6
_stotl_32:
[0000370c] 528d                      addq.l     #1,a5
[0000370e] 4287                      clr.l      d7
[00003710] 1e15                      move.b     (a5),d7
[00003712] 246c 0010                 movea.l    16(a4),a2
[00003716] 4286                      clr.l      d6
[00003718] 1c12                      move.b     (a2),d6
[0000371a] be86                      cmp.l      d6,d7
[0000371c] 6724                      beq.s      _stotl_39
[0000371e] 4287                      clr.l      d7
[00003720] 1e15                      move.b     (a5),d7
[00003722] 0c47 000a                 cmpi.w     #$000A,d7
[00003726] 671a                      beq.s      _stotl_39
[00003728] 4287                      clr.l      d7
[0000372a] 1e15                      move.b     (a5),d7
[0000372c] 0c47 005c                 cmpi.w     #$005C,d7
[00003730] 663e                      bne.s      _stotl_40
[00003732] 4287                      clr.l      d7
[00003734] 1e2d 0001                 move.b     1(a5),d7
[00003738] 0c47 000a                 cmpi.w     #$000A,d7
[0000373c] 6732                      beq.s      _stotl_40
[0000373e] 528d                      addq.l     #1,a5
[00003740] 60ca                      bra.s      _stotl_32
_stotl_39:
[00003742] 4287                      clr.l      d7
[00003744] 1e15                      move.b     (a5),d7
[00003746] 246c 0010                 movea.l    16(a4),a2
[0000374a] 4286                      clr.l      d6
[0000374c] 1c12                      move.b     (a2),d6
[0000374e] be86                      cmp.l      d6,d7
[00003750] 662a                      bne.s      _stotl_41
[00003752] 528d                      addq.l     #1,a5
[00003754] 246c 0010                 movea.l    16(a4),a2
[00003758] 4287                      clr.l      d7
[0000375a] 1e12                      move.b     (a2),d7
[0000375c] 0c47 0022                 cmpi.w     #$0022,d7
[00003760] 6604                      bne.s      _stotl_42
[00003762] 7e06                      moveq.l    #6,d7
[00003764] 6002                      bra.s      _stotl_43
_stotl_42:
[00003766] 7e01                      moveq.l    #1,d7
_stotl_43:
[00003768] 2947 0004                 move.l     d7,4(a4)
[0000376c] 6000 fee8                 bra        _stotl_6
_stotl_40:
[00003770] 4287                      clr.l      d7
[00003772] 1e15                      move.b     (a5),d7
[00003774] 0c47 005c                 cmpi.w     #$005C,d7
[00003778] 6692                      bne.s      _stotl_32
[0000377a] 60c6                      bra.s      _stotl_39
_stotl_41:
[0000377c] 4ab9 0002 0a2e            tst.l      $00025F7E
[00003782] 6732                      beq.s      _stotl_44
[00003784] 246c 0010                 movea.l    16(a4),a2
[00003788] 4287                      clr.l      d7
[0000378a] 1e12                      move.b     (a2),d7
[0000378c] 0c47 0022                 cmpi.w     #$0022,d7
[00003790] 6604                      bne.s      _stotl_45
[00003792] 7e06                      moveq.l    #6,d7
[00003794] 6002                      bra.s      _stotl_46
_stotl_45:
[00003796] 7e01                      moveq.l    #1,d7
_stotl_46:
[00003798] 2947 0004                 move.l     d7,4(a4)
[0000379c] 246c 0010                 movea.l    16(a4),a2
[000037a0] 4287                      clr.l      d7
[000037a2] 1e12                      move.b     (a2),d7
[000037a4] 2e87                      move.l     d7,(a7)
[000037a6] 2f3c 0002 10a8            move.l     #$000265F8,-(a7)
[000037ac] 4eba f960                 jsr        _p0error(pc)
[000037b0] 588f                      addq.l     #4,a7
[000037b2] 6000 fea2                 bra        _stotl_6
_stotl_44:
[000037b6] 7005                      moveq.l    #5,d0
[000037b8] 2940 0004                 move.l     d0,4(a4)
[000037bc] 2e2c 0010                 move.l     16(a4),d7
[000037c0] 5287                      addq.l     #1,d7
[000037c2] 2a47                      movea.l    d7,a5
[000037c4] 6000 fe90                 bra        _stotl_6
_stotl_38:
[000037c8] 528d                      addq.l     #1,a5
[000037ca] 7005                      moveq.l    #5,d0
[000037cc] 2940 0004                 move.l     d0,4(a4)
[000037d0] 6000 fe84                 bra        _stotl_6
_stotl_31:
[000037d4] 268c                      move.l     a4,(a3)
[000037d6] 264c                      movea.l    a4,a3
[000037d8] 0cac 0000 0002 0004       cmpi.l     #$00000002,4(a4)
[000037e0] 6600 fc50                 bne        _stotl_47
[000037e4] 2e2e fffc                 move.l     -4(a6),d7
[000037e8] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000037ec] 4e5e                      unlk       a6
[000037ee] 4e75                      rts

_fclose:
[000037f0] 4e56 0000                 link       a6,#0
[000037f4] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[000037f8] 2a6e 0008                 movea.l    8(a6),a5
[000037fc] 2e0d                      move.l     a5,d7
[000037fe] 6610                      bne.s      _fclose_1
[00003800] 2ebc 0002 1378            move.l     #$000268C8,(a7)
[00003806] 42a7                      clr.l      -(a7)
[00003808] 4eb9 0000 5316            jsr        __raise
[0000380e] 588f                      addq.l     #4,a7
_fclose_1:
[00003810] 267c 0002 1336            movea.l    #$00026886,a3
_fclose_6:
[00003816] 2853                      movea.l    (a3),a4
[00003818] 2e0c                      move.l     a4,d7
[0000381a] 6708                      beq.s      _fclose_2
[0000381c] b9cd                      cmpa.l     a5,a4
[0000381e] 661e                      bne.s      _fclose_3
[00003820] 26ac 0006                 move.l     6(a4),(a3)
_fclose_2:
[00003824] 3e2d 0004                 move.w     4(a5),d7
[00003828] 48c7                      ext.l      d7
[0000382a] 0c47 0001                 cmpi.w     #$0001,d7
[0000382e] 6716                      beq.s      _fclose_4
[00003830] 3e2d 0004                 move.w     4(a5),d7
[00003834] 48c7                      ext.l      d7
[00003836] 0c47 ffff                 cmpi.w     #$FFFF,d7
[0000383a] 6644                      bne.s      _fclose_5
[0000383c] 6008                      bra.s      _fclose_4
_fclose_3:
[0000383e] 45ec 0006                 lea.l      6(a4),a2
[00003842] 264a                      movea.l    a2,a3
[00003844] 60d0                      bra.s      _fclose_6
_fclose_4:
[00003846] 4a6d 0002                 tst.w      2(a5)
[0000384a] 6734                      beq.s      _fclose_5
[0000384c] 3e2d 0002                 move.w     2(a5),d7
[00003850] 48c7                      ext.l      d7
[00003852] 2e87                      move.l     d7,(a7)
[00003854] 486d 000a                 pea.l      10(a5)
[00003858] 3e15                      move.w     (a5),d7
[0000385a] 48c7                      ext.l      d7
[0000385c] 2f07                      move.l     d7,-(a7)
[0000385e] 4eb9 0000 5548            jsr        _write
[00003864] 508f                      addq.l     #8,a7
[00003866] 3c2d 0002                 move.w     2(a5),d6
[0000386a] 48c6                      ext.l      d6
[0000386c] be86                      cmp.l      d6,d7
[0000386e] 6710                      beq.s      _fclose_5
[00003870] 2ebc 0002 141a            move.l     #$0002696A,(a7)
[00003876] 42a7                      clr.l      -(a7)
[00003878] 4eb9 0000 5316            jsr        __raise
[0000387e] 588f                      addq.l     #4,a7
_fclose_5:
[00003880] 3e15                      move.w     (a5),d7
[00003882] 48c7                      ext.l      d7
[00003884] 2e87                      move.l     d7,(a7)
[00003886] 4eb9 0000 4cd6            jsr        _close
[0000388c] 4a87                      tst.l      d7
[0000388e] 6d04                      blt.s      _fclose_7
[00003890] 2e0d                      move.l     a5,d7
[00003892] 6002                      bra.s      _fclose_8
_fclose_7:
[00003894] 4287                      clr.l      d7
_fclose_8:
[00003896] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000389a] 4e5e                      unlk       a6
[0000389c] 4e75                      rts

_fread:
[0000389e] 4e56 0000                 link       a6,#0
[000038a2] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[000038a6] 4285                      clr.l      d5
_fread_3:
[000038a8] baae 0010                 cmp.l      16(a6),d5
[000038ac] 641c                      bcc.s      _fread_1
[000038ae] 2e2e 0010                 move.l     16(a6),d7
[000038b2] 9e85                      sub.l      d5,d7
[000038b4] 2e87                      move.l     d7,(a7)
[000038b6] 2f2e 000c                 move.l     12(a6),-(a7)
[000038ba] 2f2e 0008                 move.l     8(a6),-(a7)
[000038be] 4eb9 0000 472a            jsr        _read
[000038c4] 508f                      addq.l     #8,a7
[000038c6] 2807                      move.l     d7,d4
[000038c8] 6612                      bne.s      _fread_2
_fread_1:
[000038ca] 2e05                      move.l     d5,d7
[000038cc] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[000038d0] 4e5e                      unlk       a6
[000038d2] 4e75                      rts
_fread_4:
[000038d4] d9ae 000c                 add.l      d4,12(a6)
[000038d8] da84                      add.l      d4,d5
[000038da] 60cc                      bra.s      _fread_3
_fread_2:
[000038dc] 4a84                      tst.l      d4
[000038de] 6cf4                      bge.s      _fread_4
[000038e0] 2ebc 0002 133e            move.l     #$0002688E,(a7)
[000038e6] 42a7                      clr.l      -(a7)
[000038e8] 4eb9 0000 5316            jsr        __raise
[000038ee] 588f                      addq.l     #4,a7
[000038f0] 60e2                      bra.s      _fread_4

_frelst:
[000038f2] 4e56 0000                 link       a6,#0
[000038f6] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000038fa] 2a6e 0008                 movea.l    8(a6),a5
[000038fe] 286e 000c                 movea.l    12(a6),a4
_frelst_2:
[00003902] 2e0d                      move.l     a5,d7
[00003904] 6714                      beq.s      _frelst_1
[00003906] bbcc                      cmpa.l     a4,a5
[00003908] 6710                      beq.s      _frelst_1
[0000390a] 2e95                      move.l     (a5),(a7)
[0000390c] 2f0d                      move.l     a5,-(a7)
[0000390e] 4eb9 0000 49de            jsr        _free
[00003914] 588f                      addq.l     #4,a7
[00003916] 2a47                      movea.l    d7,a5
[00003918] 60e8                      bra.s      _frelst_2
_frelst_1:
[0000391a] 2e0d                      move.l     a5,d7
[0000391c] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00003920] 4e5e                      unlk       a6
[00003922] 4e75                      rts

_getfiles:
[00003924] 4e56 0000                 link       a6,#0
[00003928] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000392c] 2a6e 0008                 movea.l    8(a6),a5
[00003930] 286e 000c                 movea.l    12(a6),a4
[00003934] 4a95                      tst.l      (a5)
[00003936] 6c04                      bge.s      _getfiles_1
[00003938] 7aff                      moveq.l    #-1,d5
[0000393a] 601e                      bra.s      _getfiles_2
_getfiles_1:
[0000393c] 4a95                      tst.l      (a5)
[0000393e] 6716                      beq.s      _getfiles_3
[00003940] 2ebc 0002 10b6            move.l     #$00026606,(a7)
[00003946] 2454                      movea.l    (a4),a2
[00003948] 2f12                      move.l     (a2),-(a7)
[0000394a] 4eb9 0000 40b6            jsr        _cmpstr
[00003950] 588f                      addq.l     #4,a7
[00003952] 4a87                      tst.l      d7
[00003954] 6710                      beq.s      _getfiles_4
_getfiles_3:
[00003956] 2a2e 0010                 move.l     16(a6),d5
_getfiles_2:
[0000395a] 5894                      addq.l     #4,(a4)
[0000395c] 5395                      subq.l     #1,(a5)
[0000395e] 6e20                      bgt.s      _getfiles_5
[00003960] 70ff                      moveq.l    #-1,d0
[00003962] 2a80                      move.l     d0,(a5)
[00003964] 601a                      bra.s      _getfiles_5
_getfiles_4:
[00003966] 4297                      clr.l      (a7)
[00003968] 42a7                      clr.l      -(a7)
[0000396a] 2454                      movea.l    (a4),a2
[0000396c] 2f12                      move.l     (a2),-(a7)
[0000396e] 4eb9 0000 4588            jsr        _open
[00003974] 508f                      addq.l     #8,a7
[00003976] 2a07                      move.l     d7,d5
[00003978] 6ce0                      bge.s      _getfiles_2
[0000397a] 2a2e 0014                 move.l     20(a6),d5
[0000397e] 60da                      bra.s      _getfiles_2
_getfiles_5:
[00003980] 2e05                      move.l     d5,d7
[00003982] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00003986] 4e5e                      unlk       a6
[00003988] 4e75                      rts

x398a:
[0000398a] 4e56 0000                 link       a6,#0
[0000398e] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00003992] 2a6e 0008                 movea.l    8(a6),a5
[00003996] 286e 000c                 movea.l    12(a6),a4
[0000399a] 4297                      clr.l      (a7)
[0000399c] 4eb9 0000 400c            jsr        _usage
[000039a2] 2a07                      move.l     d7,d5
x398a_7:
[000039a4] 4a15                      tst.b      (a5)
[000039a6] 6720                      beq.s      x398a_1
[000039a8] 4287                      clr.l      d7
[000039aa] 1e15                      move.b     (a5),d7
[000039ac] 0c47 0046                 cmpi.w     #$0046,d7
[000039b0] 673e                      beq.s      x398a_2
[000039b2] 2e85                      move.l     d5,(a7)
[000039b4] 2f0d                      move.l     a5,-(a7)
[000039b6] 4878 0002                 pea.l      ($00000002).w
[000039ba] 4eb9 0000 3e9a            jsr        $00003E9A
[000039c0] 508f                      addq.l     #8,a7
[000039c2] 2a07                      move.l     d7,d5
[000039c4] 6000 0098                 bra        x398a_3
x398a_1:
[000039c8] 4878 0001                 pea.l      ($00000001).w
[000039cc] 2f3c 0002 10b8            move.l     #$00026608,-(a7)
[000039d2] 4878 0002                 pea.l      ($00000002).w
[000039d6] 4eb9 0000 5548            jsr        _write
[000039dc] 4fef 000c                 lea.l      12(a7),a7
[000039e0] 4297                      clr.l      (a7)
[000039e2] 4eb9 0000 0080            jsr        _exit
[000039e8] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000039ec] 4e5e                      unlk       a6
[000039ee] 4e75                      rts
x398a_2:
[000039f0] 4878 0002                 pea.l      ($00000002).w
[000039f4] 2f3c 0002 10c2            move.l     #$00026612,-(a7)
[000039fa] 4878 0002                 pea.l      ($00000002).w
[000039fe] 4eb9 0000 5548            jsr        _write
[00003a04] 4fef 000c                 lea.l      12(a7),a7
[00003a08] da87                      add.l      d7,d5
x398a_9:
[00003a0a] 4287                      clr.l      d7
[00003a0c] 1e14                      move.b     (a4),d7
[00003a0e] 0c47 003a                 cmpi.w     #$003A,d7
[00003a12] 6730                      beq.s      x398a_4
[00003a14] 4287                      clr.l      d7
[00003a16] 1e14                      move.b     (a4),d7
[00003a18] 0c47 002c                 cmpi.w     #$002C,d7
[00003a1c] 6646                      bne.s      x398a_5
[00003a1e] 4287                      clr.l      d7
[00003a20] 1e2c 0001                 move.b     1(a4),d7
[00003a24] 0c47 003a                 cmpi.w     #$003A,d7
[00003a28] 673a                      beq.s      x398a_5
[00003a2a] 2e85                      move.l     d5,(a7)
[00003a2c] 2f3c 0002 10c0            move.l     #$00026610,-(a7)
[00003a32] 4878 0002                 pea.l      ($00000002).w
[00003a36] 4eb9 0000 3e9a            jsr        $00003E9A
[00003a3c] 508f                      addq.l     #8,a7
[00003a3e] 2a07                      move.l     d7,d5
[00003a40] 6000 0080                 bra        x398a_6 ; possibly optimized to short
x398a_4:
[00003a44] 4878 0001                 pea.l      ($00000001).w
[00003a48] 2f3c 0002 10ba            move.l     #$0002660A,-(a7)
[00003a4e] 4878 0002                 pea.l      ($00000002).w
[00003a52] 4eb9 0000 5548            jsr        _write
[00003a58] 4fef 000c                 lea.l      12(a7),a7
[00003a5c] da87                      add.l      d7,d5
x398a_3:
[00003a5e] 528d                      addq.l     #1,a5
[00003a60] 6000 ff42                 bra        x398a_7
x398a_5:
[00003a64] 4287                      clr.l      d7
[00003a66] 1e14                      move.b     (a4),d7
[00003a68] 0c47 003e                 cmpi.w     #$003E,d7
[00003a6c] 663e                      bne.s      x398a_8
[00003a6e] 4878 0001                 pea.l      ($00000001).w
[00003a72] 2f3c 0002 10be            move.l     #$0002660E,-(a7)
[00003a78] 4878 0002                 pea.l      ($00000002).w
[00003a7c] 4eb9 0000 5548            jsr        _write
[00003a82] 4fef 000c                 lea.l      12(a7),a7
[00003a86] da87                      add.l      d7,d5
[00003a88] 4287                      clr.l      d7
[00003a8a] 1e2c 0001                 move.b     1(a4),d7
[00003a8e] 0c47 003a                 cmpi.w     #$003A,d7
[00003a92] 672e                      beq.s      x398a_6
[00003a94] 2e85                      move.l     d5,(a7)
[00003a96] 2f3c 0002 10bc            move.l     #$0002660C,-(a7)
[00003a9c] 4878 0002                 pea.l      ($00000002).w
[00003aa0] 4eb9 0000 3e9a            jsr        $00003E9A
[00003aa6] 508f                      addq.l     #8,a7
[00003aa8] 2a07                      move.l     d7,d5
[00003aaa] 6016                      bra.s      x398a_6
x398a_8:
[00003aac] 4878 0001                 pea.l      ($00000001).w
[00003ab0] 2f0c                      move.l     a4,-(a7)
[00003ab2] 4878 0002                 pea.l      ($00000002).w
[00003ab6] 4eb9 0000 5548            jsr        _write
[00003abc] 4fef 000c                 lea.l      12(a7),a7
[00003ac0] da87                      add.l      d7,d5
x398a_6:
[00003ac2] 528c                      addq.l     #1,a4
[00003ac4] 6000 ff44                 bra        x398a_9

_getflags:
[00003ac8] 4e56 ffe2                 link       a6,#-30
[00003acc] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00003ad0] 246e 000c                 movea.l    12(a6),a2
[00003ad4] 5892                      addq.l     #4,(a2)
_getflags_3:
[00003ad6] 246e 0008                 movea.l    8(a6),a2
[00003ada] 4a92                      tst.l      (a2)
[00003adc] 6730                      beq.s      _getflags_1
[00003ade] 246e 0008                 movea.l    8(a6),a2
[00003ae2] 5392                      subq.l     #1,(a2)
[00003ae4] 6728                      beq.s      _getflags_1
[00003ae6] 246e 000c                 movea.l    12(a6),a2
[00003aea] 2452                      movea.l    (a2),a2
[00003aec] 2852                      movea.l    (a2),a4
[00003aee] 2ebc 0002 110d            move.l     #$0002665D,(a7)
[00003af4] 2f0c                      move.l     a4,-(a7)
[00003af6] 4eb9 0000 40b6            jsr        _cmpstr
[00003afc] 588f                      addq.l     #4,a7
[00003afe] 4a87                      tst.l      d7
[00003b00] 671e                      beq.s      _getflags_2
[00003b02] 246e 0008                 movea.l    8(a6),a2
[00003b06] 5392                      subq.l     #1,(a2)
[00003b08] 246e 000c                 movea.l    12(a6),a2
[00003b0c] 5892                      addq.l     #4,(a2)
_getflags_1:
[00003b0e] 4287                      clr.l      d7
[00003b10] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00003b14] 4e5e                      unlk       a6
[00003b16] 4e75                      rts
_getflags_10:
[00003b18] 246e 000c                 movea.l    12(a6),a2
[00003b1c] 5892                      addq.l     #4,(a2)
[00003b1e] 60b6                      bra.s      _getflags_3
_getflags_2:
[00003b20] 2ebc 0002 110b            move.l     #$0002665B,(a7)
[00003b26] 2f0c                      move.l     a4,-(a7)
[00003b28] 4eb9 0000 40b6            jsr        _cmpstr
[00003b2e] 588f                      addq.l     #4,a7
[00003b30] 4a87                      tst.l      d7
[00003b32] 66da                      bne.s      _getflags_1
[00003b34] 4287                      clr.l      d7
[00003b36] 1e14                      move.b     (a4),d7
[00003b38] 0c47 002d                 cmpi.w     #$002D,d7
[00003b3c] 670a                      beq.s      _getflags_4
[00003b3e] 4287                      clr.l      d7
[00003b40] 1e14                      move.b     (a4),d7
[00003b42] 0c47 002b                 cmpi.w     #$002B,d7
[00003b46] 66c6                      bne.s      _getflags_1
_getflags_4:
[00003b48] 4287                      clr.l      d7
[00003b4a] 1e14                      move.b     (a4),d7
[00003b4c] 0c47 002d                 cmpi.w     #$002D,d7
[00003b50] 6602                      bne.s      _getflags_5
[00003b52] 528c                      addq.l     #1,a4
_getflags_5:
[00003b54] 4878 0004                 pea.l      ($00000004).w
[00003b58] 2f0c                      move.l     a4,-(a7)
[00003b5a] 2f3c 0002 1106            move.l     #$00026656,-(a7)
[00003b60] 4eb9 0000 4cde            jsr        _cmpbuf
[00003b66] 4fef 000c                 lea.l      12(a7),a7
[00003b6a] 4a87                      tst.l      d7
[00003b6c] 6768                      beq.s      _getflags_6
[00003b6e] 4878 003a                 pea.l      ($0000003A).w
[00003b72] 2f2e 0010                 move.l     16(a6),-(a7)
[00003b76] 4eb9 0000 4732            jsr        _scnstr
[00003b7c] 508f                      addq.l     #8,a7
[00003b7e] 3d47 fff2                 move.w     d7,-14(a6)
[00003b82] 3e2e fff2                 move.w     -14(a6),d7
[00003b86] 48c7                      ext.l      d7
[00003b88] 2447                      movea.l    d7,a2
[00003b8a] d5ee 0010                 adda.l     16(a6),a2
[00003b8e] 4a12                      tst.b      (a2)
[00003b90] 6616                      bne.s      _getflags_7
[00003b92] 4287                      clr.l      d7
[00003b94] 1e2c 0004                 move.b     4(a4),d7
[00003b98] 0c47 003a                 cmpi.w     #$003A,d7
[00003b9c] 670a                      beq.s      _getflags_7
[00003b9e] 2e0c                      move.l     a4,d7
[00003ba0] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00003ba4] 4e5e                      unlk       a6
[00003ba6] 4e75                      rts
_getflags_7:
[00003ba8] 2eae 0010                 move.l     16(a6),(a7)
[00003bac] 4287                      clr.l      d7
[00003bae] 1e2c 0004                 move.b     4(a4),d7
[00003bb2] 0c47 003a                 cmpi.w     #$003A,d7
[00003bb6] 670e                      beq.s      _getflags_8
[00003bb8] 2e2e 0010                 move.l     16(a6),d7
[00003bbc] 3c2e fff2                 move.w     -14(a6),d6
[00003bc0] 48c6                      ext.l      d6
[00003bc2] de86                      add.l      d6,d7
[00003bc4] 6006                      bra.s      _getflags_9
_getflags_8:
[00003bc6] 2e3c 0002 0000            move.l     #$00025550,d7
_getflags_9:
[00003bcc] 2f07                      move.l     d7,-(a7)
[00003bce] 5297                      addq.l     #1,(a7)
[00003bd0] 4eba fdb8                 jsr        $0000398A(pc)
[00003bd4] 588f                      addq.l     #4,a7
_getflags_6:
[00003bd6] 4a14                      tst.b      (a4)
[00003bd8] 6700 ff3e                 beq        _getflags_10
[00003bdc] 42ae fff4                 clr.l      -12(a6)
[00003be0] 42ae fff8                 clr.l      -8(a6)
[00003be4] 45ee 0014                 lea.l      20(a6),a2
[00003be8] 2d4a ffea                 move.l     a2,-22(a6)
[00003bec] 264c                      movea.l    a4,a3
[00003bee] 2a6e 0010                 movea.l    16(a6),a5
[00003bf2] 42ae fffc                 clr.l      -4(a6)
_getflags_18:
[00003bf6] 4aae fffc                 tst.l      -4(a6)
[00003bfa] 66da                      bne.s      _getflags_6
[00003bfc] 4287                      clr.l      d7
[00003bfe] 1e15                      move.b     (a5),d7
[00003c00] 41f9 0002 10c6            lea.l      $00026616,a0
[00003c06] 4ef9 0000 4770            jmp        a.switch
[00003c0c] 7001                      moveq.l    #1,d0
[00003c0e] 2d40 fff4                 move.l     d0,-12(a6)
[00003c12] 4a13                      tst.b      (a3)
[00003c14] 6704                      beq.s      _getflags_11
[00003c16] 2e0b                      move.l     a3,d7
[00003c18] 6016                      bra.s      _getflags_12
_getflags_11:
[00003c1a] 246e 0008                 movea.l    8(a6),a2
[00003c1e] 5392                      subq.l     #1,(a2)
[00003c20] 670c                      beq.s      _getflags_13
[00003c22] 246e 000c                 movea.l    12(a6),a2
[00003c26] 5892                      addq.l     #4,(a2)
[00003c28] 2452                      movea.l    (a2),a2
[00003c2a] 2e12                      move.l     (a2),d7
[00003c2c] 6002                      bra.s      _getflags_12
_getflags_13:
[00003c2e] 2e0b                      move.l     a3,d7
_getflags_12:
[00003c30] 2d47 ffe2                 move.l     d7,-30(a6)
[00003c34] 266e ffe2                 movea.l    -30(a6),a3
[00003c38] 2d4b ffe6                 move.l     a3,-26(a6)
_getflags_17:
[00003c3c] 246e ffe6                 movea.l    -26(a6),a2
[00003c40] 4a12                      tst.b      (a2)
[00003c42] 672e                      beq.s      _getflags_14
[00003c44] 246e ffe6                 movea.l    -26(a6),a2
[00003c48] 4287                      clr.l      d7
[00003c4a] 1e12                      move.b     (a2),d7
[00003c4c] 0c47 005c                 cmpi.w     #$005C,d7
[00003c50] 6610                      bne.s      _getflags_15
[00003c52] 4297                      clr.l      (a7)
[00003c54] 486e ffe6                 pea.l      -26(a6)
[00003c58] 4eb9 0000 4166            jsr        _doesc
[00003c5e] 588f                      addq.l     #4,a7
[00003c60] 6008                      bra.s      _getflags_16
_getflags_15:
[00003c62] 246e ffe6                 movea.l    -26(a6),a2
[00003c66] 4287                      clr.l      d7
[00003c68] 1e12                      move.b     (a2),d7
_getflags_16:
[00003c6a] 16c7                      move.b     d7,(a3)+
[00003c6c] 52ae ffe6                 addq.l     #1,-26(a6)
[00003c70] 60ca                      bra.s      _getflags_17
_getflags_14:
[00003c72] 4213                      clr.b      (a3)
_getflags_19:
[00003c74] 528d                      addq.l     #1,a5
[00003c76] 6000 ff7e                 bra        _getflags_18
[00003c7a] 60f8                      bra.s      _getflags_19
[00003c7c] 7001                      moveq.l    #1,d0
[00003c7e] 2d40 fff4                 move.l     d0,-12(a6)
[00003c82] 4287                      clr.l      d7
[00003c84] 1e13                      move.b     (a3),d7
[00003c86] 0c47 005c                 cmpi.w     #$005C,d7
[00003c8a] 670a                      beq.s      _getflags_20
[00003c8c] 4287                      clr.l      d7
[00003c8e] 1e13                      move.b     (a3),d7
[00003c90] 2d47 ffe2                 move.l     d7,-30(a6)
[00003c94] 601a                      bra.s      _getflags_21
_getflags_20:
[00003c96] 2d4b ffe6                 move.l     a3,-26(a6)
[00003c9a] 4297                      clr.l      (a7)
[00003c9c] 486e ffe6                 pea.l      -26(a6)
[00003ca0] 4eb9 0000 4166            jsr        _doesc
[00003ca6] 588f                      addq.l     #4,a7
[00003ca8] 2d47 ffe2                 move.l     d7,-30(a6)
[00003cac] 266e ffe6                 movea.l    -26(a6),a3
_getflags_21:
[00003cb0] 4a13                      tst.b      (a3)
[00003cb2] 67c0                      beq.s      _getflags_19
[00003cb4] 528b                      addq.l     #1,a3
[00003cb6] 60bc                      bra.s      _getflags_19
[00003cb8] 4a13                      tst.b      (a3)
[00003cba] 6618                      bne.s      _getflags_22
[00003cbc] 246e 0008                 movea.l    8(a6),a2
[00003cc0] 5392                      subq.l     #1,(a2)
[00003cc2] 670c                      beq.s      _getflags_23
[00003cc4] 246e 000c                 movea.l    12(a6),a2
[00003cc8] 5892                      addq.l     #4,(a2)
[00003cca] 2452                      movea.l    (a2),a2
[00003ccc] 2e12                      move.l     (a2),d7
[00003cce] 6002                      bra.s      _getflags_24
_getflags_23:
[00003cd0] 2e0b                      move.l     a3,d7
_getflags_24:
[00003cd2] 2647                      movea.l    d7,a3
_getflags_22:
[00003cd4] 4878 0001                 pea.l      ($00000001).w
[00003cd8] 486e ffee                 pea.l      -18(a6)
[00003cdc] 2f0b                      move.l     a3,-(a7)
[00003cde] 4eb9 0000 52f4            jsr        _lenstr
[00003ce4] 588f                      addq.l     #4,a7
[00003ce6] 2f07                      move.l     d7,-(a7)
[00003ce8] 2f0b                      move.l     a3,-(a7)
[00003cea] 4eb9 0000 4aa0            jsr        _btol
[00003cf0] 4fef 0010                 lea.l      16(a7),a7
[00003cf4] d7c7                      adda.l     d7,a3
[00003cf6] 4a13                      tst.b      (a3)
[00003cf8] 6604                      bne.s      _getflags_25
[00003cfa] 7e01                      moveq.l    #1,d7
[00003cfc] 6002                      bra.s      _getflags_26
_getflags_25:
[00003cfe] 4287                      clr.l      d7
_getflags_26:
[00003d00] 2d47 fff4                 move.l     d7,-12(a6)
[00003d04] 4aae fff4                 tst.l      -12(a6)
[00003d08] 6616                      bne.s      _getflags_27
[00003d0a] 4878 003a                 pea.l      ($0000003A).w
[00003d0e] 2f0d                      move.l     a5,-(a7)
[00003d10] 4eb9 0000 4732            jsr        _scnstr
[00003d16] 508f                      addq.l     #8,a7
[00003d18] 5387                      subq.l     #1,d7
[00003d1a] dbc7                      adda.l     d7,a5
[00003d1c] 6000 ff56                 bra        _getflags_19
_getflags_27:
[00003d20] 4287                      clr.l      d7
[00003d22] 1e2d 0001                 move.b     1(a5),d7
[00003d26] 0c47 0023                 cmpi.w     #$0023,d7
[00003d2a] 660c                      bne.s      _getflags_28
[00003d2c] 528d                      addq.l     #1,a5
[00003d2e] 7001                      moveq.l    #1,d0
[00003d30] 2d40 fff8                 move.l     d0,-8(a6)
[00003d34] 6000 ff3e                 bra        _getflags_19
_getflags_28:
[00003d38] 2d6e ffee ffe2            move.l     -18(a6),-30(a6)
[00003d3e] 6000 ff34                 bra        _getflags_19
[00003d42] 4aae fff4                 tst.l      -12(a6)
[00003d46] 6712                      beq.s      _getflags_29
[00003d48] 4aae fff8                 tst.l      -8(a6)
[00003d4c] 671a                      beq.s      _getflags_30
[00003d4e] 246e ffea                 movea.l    -22(a6),a2
[00003d52] 2452                      movea.l    (a2),a2
[00003d54] 24ae ffee                 move.l     -18(a6),(a2)
[00003d58] 6018                      bra.s      _getflags_31
_getflags_29:
[00003d5a] 4a15                      tst.b      (a5)
[00003d5c] 6620                      bne.s      _getflags_32
[00003d5e] 2e0c                      move.l     a4,d7
[00003d60] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00003d64] 4e5e                      unlk       a6
[00003d66] 4e75                      rts
_getflags_30:
[00003d68] 246e ffea                 movea.l    -22(a6),a2
[00003d6c] 2452                      movea.l    (a2),a2
[00003d6e] 24ae ffe2                 move.l     -30(a6),(a2)
_getflags_31:
[00003d72] 284b                      movea.l    a3,a4
[00003d74] 7001                      moveq.l    #1,d0
[00003d76] 2d40 fffc                 move.l     d0,-4(a6)
[00003d7a] 6000 fef8                 bra        _getflags_19
_getflags_32:
[00003d7e] 4287                      clr.l      d7
[00003d80] 1e15                      move.b     (a5),d7
[00003d82] 0c47 003a                 cmpi.w     #$003A,d7
[00003d86] 6612                      bne.s      _getflags_33
[00003d88] 2eae 0010                 move.l     16(a6),(a7)
[00003d8c] 528d                      addq.l     #1,a5
[00003d8e] 2f0d                      move.l     a5,-(a7)
[00003d90] 4eba fbf8                 jsr        $0000398A(pc)
[00003d94] 588f                      addq.l     #4,a7
[00003d96] 6000 fedc                 bra        _getflags_19
_getflags_33:
[00003d9a] 58ae ffea                 addq.l     #4,-22(a6)
[00003d9e] 264c                      movea.l    a4,a3
[00003da0] 6000 fed2                 bra        _getflags_19
[00003da4] 4aae fff4                 tst.l      -12(a6)
[00003da8] 660a                      bne.s      _getflags_34
[00003daa] 58ae ffea                 addq.l     #4,-22(a6)
[00003dae] 264c                      movea.l    a4,a3
[00003db0] 6000 fec2                 bra        _getflags_19
_getflags_34:
[00003db4] 246e ffea                 movea.l    -22(a6),a2
[00003db8] 2452                      movea.l    (a2),a2
[00003dba] 4a92                      tst.l      (a2)
[00003dbc] 663c                      bne.s      _getflags_35
[00003dbe] 4878 003a                 pea.l      ($0000003A).w
[00003dc2] 2f0d                      move.l     a5,-(a7)
[00003dc4] 4eb9 0000 4732            jsr        _scnstr
[00003dca] 508f                      addq.l     #8,a7
[00003dcc] 3d47 fff2                 move.w     d7,-14(a6)
[00003dd0] 3e2e fff2                 move.w     -14(a6),d7
[00003dd4] 48c7                      ext.l      d7
[00003dd6] 2447                      movea.l    d7,a2
[00003dd8] d5cd                      adda.l     a5,a2
[00003dda] 4a12                      tst.b      (a2)
[00003ddc] 673e                      beq.s      _getflags_36
[00003dde] 2eae 0010                 move.l     16(a6),(a7)
[00003de2] 3e2e fff2                 move.w     -14(a6),d7
[00003de6] 48c7                      ext.l      d7
[00003de8] 45ed 0001                 lea.l      1(a5),a2
[00003dec] de8a                      add.l      a2,d7
[00003dee] 2f07                      move.l     d7,-(a7)
[00003df0] 4eba fb98                 jsr        $0000398A(pc)
[00003df4] 588f                      addq.l     #4,a7
[00003df6] 6000 fe7c                 bra        _getflags_19
_getflags_35:
[00003dfa] 4aae fff8                 tst.l      -8(a6)
[00003dfe] 6726                      beq.s      _getflags_37
[00003e00] 246e ffea                 movea.l    -22(a6),a2
[00003e04] 2452                      movea.l    (a2),a2
[00003e06] 5392                      subq.l     #1,(a2)
[00003e08] 2e12                      move.l     (a2),d7
[00003e0a] e587                      asl.l      #2,d7
[00003e0c] 246e ffea                 movea.l    -22(a6),a2
[00003e10] 2452                      movea.l    (a2),a2
[00003e12] 588a                      addq.l     #4,a2
[00003e14] d5c7                      adda.l     d7,a2
[00003e16] 24ae ffee                 move.l     -18(a6),(a2)
[00003e1a] 6024                      bra.s      _getflags_38
_getflags_36:
[00003e1c] 2e0c                      move.l     a4,d7
[00003e1e] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00003e22] 4e5e                      unlk       a6
[00003e24] 4e75                      rts
_getflags_37:
[00003e26] 246e ffea                 movea.l    -22(a6),a2
[00003e2a] 2452                      movea.l    (a2),a2
[00003e2c] 5392                      subq.l     #1,(a2)
[00003e2e] 2e12                      move.l     (a2),d7
[00003e30] e587                      asl.l      #2,d7
[00003e32] 246e ffea                 movea.l    -22(a6),a2
[00003e36] 2452                      movea.l    (a2),a2
[00003e38] 588a                      addq.l     #4,a2
[00003e3a] d5c7                      adda.l     d7,a2
[00003e3c] 24ae ffe2                 move.l     -30(a6),(a2)
_getflags_38:
[00003e40] 284b                      movea.l    a3,a4
[00003e42] 7001                      moveq.l    #1,d0
[00003e44] 2d40 fffc                 move.l     d0,-4(a6)
[00003e48] 6000 fe2a                 bra        _getflags_19
[00003e4c] 4287                      clr.l      d7
[00003e4e] 1e15                      move.b     (a5),d7
[00003e50] 4286                      clr.l      d6
[00003e52] 1c13                      move.b     (a3),d6
[00003e54] be86                      cmp.l      d6,d7
[00003e56] 6612                      bne.s      _getflags_39
[00003e58] 7001                      moveq.l    #1,d0
[00003e5a] 2d40 fff4                 move.l     d0,-12(a6)
[00003e5e] 7001                      moveq.l    #1,d0
[00003e60] 2d40 ffe2                 move.l     d0,-30(a6)
[00003e64] 528b                      addq.l     #1,a3
[00003e66] 6000 fe0c                 bra        _getflags_19
_getflags_39:
[00003e6a] 42ae fff4                 clr.l      -12(a6)
_getflags_41:
[00003e6e] 4a15                      tst.b      (a5)
[00003e70] 6722                      beq.s      _getflags_40
[00003e72] 4287                      clr.l      d7
[00003e74] 1e15                      move.b     (a5),d7
[00003e76] 0c47 002c                 cmpi.w     #$002C,d7
[00003e7a] 6718                      beq.s      _getflags_40
[00003e7c] 4287                      clr.l      d7
[00003e7e] 1e15                      move.b     (a5),d7
[00003e80] 0c47 003e                 cmpi.w     #$003E,d7
[00003e84] 670e                      beq.s      _getflags_40
[00003e86] 4287                      clr.l      d7
[00003e88] 1e15                      move.b     (a5),d7
[00003e8a] 0c47 003a                 cmpi.w     #$003A,d7
[00003e8e] 6704                      beq.s      _getflags_40
[00003e90] 528d                      addq.l     #1,a5
[00003e92] 60da                      bra.s      _getflags_41
_getflags_40:
[00003e94] 538d                      subq.l     #1,a5
[00003e96] 6000 fddc                 bra        _getflags_19
[00003e9a] 4e56 0000                 link       a6,#0
[00003e9e] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00003ea2] 2a2e 0008                 move.l     8(a6),d5
[00003ea6] 2a6e 000c                 movea.l    12(a6),a5
[00003eaa] 282e 0010                 move.l     16(a6),d4
[00003eae] 0c84 0000 003c            cmpi.l     #$0000003C,d4
[00003eb4] 6f14                      ble.s      _getflags_42
[00003eb6] 4287                      clr.l      d7
[00003eb8] 1e15                      move.b     (a5),d7
[00003eba] 0c47 0020                 cmpi.w     #$0020,d7
[00003ebe] 6724                      beq.s      _getflags_43
[00003ec0] 4287                      clr.l      d7
[00003ec2] 1e15                      move.b     (a5),d7
[00003ec4] 0c47 0009                 cmpi.w     #$0009,d7
[00003ec8] 671a                      beq.s      _getflags_43
_getflags_42:
[00003eca] 4878 0001                 pea.l      ($00000001).w
[00003ece] 2f0d                      move.l     a5,-(a7)
[00003ed0] 2f05                      move.l     d5,-(a7)
[00003ed2] 4eb9 0000 5548            jsr        _write
[00003ed8] 4fef 000c                 lea.l      12(a7),a7
[00003edc] 2444                      movea.l    d4,a2
[00003ede] 528a                      addq.l     #1,a2
[00003ee0] 2e0a                      move.l     a2,d7
[00003ee2] 6018                      bra.s      _getflags_44
_getflags_43:
[00003ee4] 4878 0002                 pea.l      ($00000002).w
[00003ee8] 2f3c 0002 1110            move.l     #$00026660,-(a7)
[00003eee] 2f05                      move.l     d5,-(a7)
[00003ef0] 4eb9 0000 5548            jsr        _write
[00003ef6] 4fef 000c                 lea.l      12(a7),a7
[00003efa] 7e04                      moveq.l    #4,d7
_getflags_44:
[00003efc] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00003f00] 4e5e                      unlk       a6
[00003f02] 4e75                      rts

_inbuf:
[00003f04] 4e56 0000                 link       a6,#0
[00003f08] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00003f0c] 2a2e 000c                 move.l     12(a6),d5
[00003f10] 2a6e 0008                 movea.l    8(a6),a5
_inbuf_5:
[00003f14] 4a85                      tst.l      d5
[00003f16] 6718                      beq.s      _inbuf_1
[00003f18] 286e 0010                 movea.l    16(a6),a4
_inbuf_4:
[00003f1c] 4287                      clr.l      d7
[00003f1e] 1e15                      move.b     (a5),d7
[00003f20] 4286                      clr.l      d6
[00003f22] 1c14                      move.b     (a4),d6
[00003f24] be86                      cmp.l      d6,d7
[00003f26] 6616                      bne.s      _inbuf_2
[00003f28] 2e0d                      move.l     a5,d7
[00003f2a] 9eae 0008                 sub.l      8(a6),d7
[00003f2e] 6006                      bra.s      _inbuf_3
_inbuf_1:
[00003f30] 2e0d                      move.l     a5,d7
[00003f32] 9eae 0008                 sub.l      8(a6),d7
_inbuf_3:
[00003f36] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00003f3a] 4e5e                      unlk       a6
[00003f3c] 4e75                      rts
_inbuf_2:
[00003f3e] 528c                      addq.l     #1,a4
[00003f40] 4a14                      tst.b      (a4)
[00003f42] 66d8                      bne.s      _inbuf_4
[00003f44] 5385                      subq.l     #1,d5
[00003f46] 528d                      addq.l     #1,a5
[00003f48] 60ca                      bra.s      _inbuf_5

_itob:
[00003f4a] 4e56 0000                 link       a6,#0
[00003f4e] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00003f52] 2a6e 0008                 movea.l    8(a6),a5
[00003f56] 284d                      movea.l    a5,a4
[00003f58] 4aae 000c                 tst.l      12(a6)
[00003f5c] 6c14                      bge.s      _itob_1
[00003f5e] 4aae 0010                 tst.l      16(a6)
[00003f62] 6e0e                      bgt.s      _itob_1
[00003f64] 2e2e 000c                 move.l     12(a6),d7
[00003f68] 4487                      neg.l      d7
[00003f6a] 2a07                      move.l     d7,d5
[00003f6c] 18fc 002d                 move.b     #$2D,(a4)+
[00003f70] 6004                      bra.s      _itob_2
_itob_1:
[00003f72] 2a2e 000c                 move.l     12(a6),d5
_itob_2:
[00003f76] 4aae 0010                 tst.l      16(a6)
[00003f7a] 6608                      bne.s      _itob_3
[00003f7c] 700a                      moveq.l    #10,d0
[00003f7e] 2d40 0010                 move.l     d0,16(a6)
[00003f82] 6010                      bra.s      _itob_4
_itob_3:
[00003f84] 4aae 0010                 tst.l      16(a6)
[00003f88] 6c0a                      bge.s      _itob_4
[00003f8a] 2e2e 0010                 move.l     16(a6),d7
[00003f8e] 4487                      neg.l      d7
[00003f90] 2d47 0010                 move.l     d7,16(a6)
_itob_4:
[00003f94] 2e2e 0010                 move.l     16(a6),d7
[00003f98] be85                      cmp.l      d5,d7
[00003f9a] 621a                      bhi.s      _itob_5
[00003f9c] 2eae 0010                 move.l     16(a6),(a7)
[00003fa0] 2f05                      move.l     d5,-(a7)
[00003fa2] 2f2e 0010                 move.l     16(a6),-(a7)
[00003fa6] 4eb9 0000 478a            jsr        a.uldiv
[00003fac] 2f0c                      move.l     a4,-(a7)
[00003fae] 4eba ff9a                 jsr        _itob(pc)
[00003fb2] 508f                      addq.l     #8,a7
[00003fb4] d9c7                      adda.l     d7,a4
_itob_5:
[00003fb6] 7e30                      moveq.l    #48,d7
[00003fb8] 2e85                      move.l     d5,(a7)
[00003fba] 2f2e 0010                 move.l     16(a6),-(a7)
[00003fbe] 4eb9 0000 4782            jsr        a.ulmod
[00003fc4] de97                      add.l      (a7),d7
[00003fc6] 1887                      move.b     d7,(a4)
[00003fc8] 4287                      clr.l      d7
[00003fca] 1e14                      move.b     (a4),d7
[00003fcc] 0c47 0039                 cmpi.w     #$0039,d7
[00003fd0] 6304                      bls.s      _itob_6
[00003fd2] 0614 0027                 addi.b     #$27,(a4)
_itob_6:
[00003fd6] 2e0c                      move.l     a4,d7
[00003fd8] 9e8d                      sub.l      a5,d7
[00003fda] 5287                      addq.l     #1,d7
[00003fdc] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00003fe0] 4e5e                      unlk       a6
[00003fe2] 4e75                      rts

_putlin:
[00003fe4] 4e56 0000                 link       a6,#0
[00003fe8] 48e7 8004                 movem.l    d0/a5,-(a7)
[00003fec] 2a6e 0008                 movea.l    8(a6),a5
[00003ff0] 2eae 000c                 move.l     12(a6),(a7)
[00003ff4] 2f0d                      move.l     a5,-(a7)
[00003ff6] 2f3c 0002 1114            move.l     #$00026664,-(a7)
[00003ffc] 4eb9 0000 4648            jsr        _putl
[00004002] 508f                      addq.l     #8,a7
[00004004] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00004008] 4e5e                      unlk       a6
[0000400a] 4e75                      rts

_usage:
[0000400c] 4e56 0000                 link       a6,#0
[00004010] 48e7 8400                 movem.l    d0/d5,-(a7)
[00004014] 4285                      clr.l      d5
[00004016] 4297                      clr.l      (a7)
[00004018] 2f2e 0008                 move.l     8(a6),-(a7)
[0000401c] 2f3c 0002 131e            move.l     #$0002686E,-(a7)
[00004022] 2f39 0002 0a4e            move.l     $00025F9E,-(a7)
[00004028] 2f3c 0002 1320            move.l     #$00026870,-(a7)
[0000402e] 4878 0002                 pea.l      ($00000002).w
[00004032] 4eb9 0000 502c            jsr        _putstr
[00004038] 4fef 0014                 lea.l      20(a7),a7
[0000403c] 4aae 0008                 tst.l      8(a6)
[00004040] 6726                      beq.s      _usage_1
[00004042] 2eae 0008                 move.l     8(a6),(a7)
[00004046] 4eb9 0000 52f4            jsr        _lenstr
[0000404c] 2a07                      move.l     d7,d5
[0000404e] 2445                      movea.l    d5,a2
[00004050] 538a                      subq.l     #1,a2
[00004052] d5ee 0008                 adda.l     8(a6),a2
[00004056] 4287                      clr.l      d7
[00004058] 1e12                      move.b     (a2),d7
[0000405a] 0c47 000a                 cmpi.w     #$000A,d7
[0000405e] 6608                      bne.s      _usage_1
[00004060] 4297                      clr.l      (a7)
[00004062] 4eb9 0000 0080            jsr        _exit
_usage_1:
[00004068] 2eb9 0002 0a4e            move.l     $00025F9E,(a7)
[0000406e] 4eb9 0000 52f4            jsr        _lenstr
[00004074] 2445                      movea.l    d5,a2
[00004076] 508a                      addq.l     #8,a2
[00004078] de8a                      add.l      a2,d7
[0000407a] 4cdf 0021                 movem.l    (a7)+,d0/d5
[0000407e] 4e5e                      unlk       a6
[00004080] 4e75                      rts

_buybuf:
[00004082] 4e56 0000                 link       a6,#0
[00004086] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[0000408a] 2a6e 0008                 movea.l    8(a6),a5
[0000408e] 2a2e 000c                 move.l     12(a6),d5
[00004092] 4297                      clr.l      (a7)
[00004094] 2f05                      move.l     d5,-(a7)
[00004096] 4eb9 0000 486e            jsr        _alloc
[0000409c] 588f                      addq.l     #4,a7
[0000409e] 2647                      movea.l    d7,a3
[000040a0] 284b                      movea.l    a3,a4
_buybuf_2:
[000040a2] 4a85                      tst.l      d5
[000040a4] 6706                      beq.s      _buybuf_1
[000040a6] 18dd                      move.b     (a5)+,(a4)+
[000040a8] 5385                      subq.l     #1,d5
[000040aa] 60f6                      bra.s      _buybuf_2
_buybuf_1:
[000040ac] 2e0b                      move.l     a3,d7
[000040ae] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[000040b2] 4e5e                      unlk       a6
[000040b4] 4e75                      rts

_cmpstr:
[000040b6] 4e56 0000                 link       a6,#0
[000040ba] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000040be] 2a6e 0008                 movea.l    8(a6),a5
[000040c2] 286e 000c                 movea.l    12(a6),a4
_cmpstr_2:
[000040c6] 4a14                      tst.b      (a4)
[000040c8] 6710                      beq.s      _cmpstr_1
[000040ca] 4287                      clr.l      d7
[000040cc] 1e1d                      move.b     (a5)+,d7
[000040ce] 4286                      clr.l      d6
[000040d0] 1c1c                      move.b     (a4)+,d6
[000040d2] be86                      cmp.l      d6,d7
[000040d4] 67f0                      beq.s      _cmpstr_2
[000040d6] 4287                      clr.l      d7
[000040d8] 600a                      bra.s      _cmpstr_3
_cmpstr_1:
[000040da] 4a15                      tst.b      (a5)
[000040dc] 6604                      bne.s      _cmpstr_4
[000040de] 7e01                      moveq.l    #1,d7
[000040e0] 6002                      bra.s      _cmpstr_3
_cmpstr_4:
[000040e2] 4287                      clr.l      d7
_cmpstr_3:
[000040e4] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000040e8] 4e5e                      unlk       a6
[000040ea] 4e75                      rts

_create:
[000040ec] 4e56 0000                 link       a6,#0
[000040f0] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000040f4] 4eb9 0000 47c6            jsr        _uname
[000040fa] 2a47                      movea.l    d7,a5
[000040fc] 286e 0008                 movea.l    8(a6),a4
_create_2:
[00004100] 4a15                      tst.b      (a5)
[00004102] 6710                      beq.s      _create_1
[00004104] 4287                      clr.l      d7
[00004106] 1e1c                      move.b     (a4)+,d7
[00004108] 4286                      clr.l      d6
[0000410a] 1c15                      move.b     (a5),d6
[0000410c] be86                      cmp.l      d6,d7
[0000410e] 6604                      bne.s      _create_1
[00004110] 528d                      addq.l     #1,a5
[00004112] 60ec                      bra.s      _create_2
_create_1:
[00004114] 4a15                      tst.b      (a5)
[00004116] 6708                      beq.s      _create_3
[00004118] 2e3c 0000 01b6            move.l     #$000001B6,d7
[0000411e] 6006                      bra.s      _create_4
_create_3:
[00004120] 2e3c 0000 0180            move.l     #$00000180,d7
_create_4:
[00004126] 2e87                      move.l     d7,(a7)
[00004128] 2f2e 0008                 move.l     8(a6),-(a7)
[0000412c] 4eb9 0000 4d3e            jsr        _creat
[00004132] 588f                      addq.l     #4,a7
[00004134] 2a07                      move.l     d7,d5
[00004136] 6d0a                      blt.s      _create_5
[00004138] 0cae 0000 0001 000c       cmpi.l     #$00000001,12(a6)
[00004140] 6604                      bne.s      _create_6
_create_5:
[00004142] 2e05                      move.l     d5,d7
[00004144] 6018                      bra.s      _create_7
_create_6:
[00004146] 2e85                      move.l     d5,(a7)
[00004148] 4eb9 0000 4cd6            jsr        _close
[0000414e] 2eae 000c                 move.l     12(a6),(a7)
[00004152] 2f2e 0008                 move.l     8(a6),-(a7)
[00004156] 4eb9 0000 4588            jsr        _open
[0000415c] 588f                      addq.l     #4,a7
_create_7:
[0000415e] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00004162] 4e5e                      unlk       a6
[00004164] 4e75                      rts

_doesc:
[00004166] 4e56 0000                 link       a6,#0
[0000416a] 48e7 9c0c                 movem.l    d0/d3-d5/a4-a5,-(a7)
[0000416e] 246e 0008                 movea.l    8(a6),a2
[00004172] 2e12                      move.l     (a2),d7
[00004174] 5287                      addq.l     #1,d7
[00004176] 2a47                      movea.l    d7,a5
[00004178] 4a15                      tst.b      (a5)
[0000417a] 6612                      bne.s      _doesc_1
[0000417c] 246e 0008                 movea.l    8(a6),a2
[00004180] 2452                      movea.l    (a2),a2
[00004182] 4287                      clr.l      d7
[00004184] 1e12                      move.b     (a2),d7
[00004186] 4cdf 3039                 movem.l    (a7)+,d0/d3-d5/a4-a5
[0000418a] 4e5e                      unlk       a6
[0000418c] 4e75                      rts
_doesc_1:
[0000418e] 4287                      clr.l      d7
[00004190] 1e15                      move.b     (a5),d7
[00004192] 0c47 0030                 cmpi.w     #$0030,d7
[00004196] 6540                      bcs.s      _doesc_2
[00004198] 4287                      clr.l      d7
[0000419a] 1e15                      move.b     (a5),d7
[0000419c] 0c47 0039                 cmpi.w     #$0039,d7
[000041a0] 6236                      bhi.s      _doesc_2
[000041a2] 4285                      clr.l      d5
[000041a4] 7801                      moveq.l    #1,d4
_doesc_4:
[000041a6] 4287                      clr.l      d7
[000041a8] 1e15                      move.b     (a5),d7
[000041aa] 0c47 0030                 cmpi.w     #$0030,d7
[000041ae] 6578                      bcs.s      _doesc_3
[000041b0] 4287                      clr.l      d7
[000041b2] 1e15                      move.b     (a5),d7
[000041b4] 0c47 0039                 cmpi.w     #$0039,d7
[000041b8] 626e                      bhi.s      _doesc_3
[000041ba] 0c84 0000 0003            cmpi.l     #$00000003,d4
[000041c0] 6e66                      bgt.s      _doesc_3
[000041c2] 7ed0                      moveq.l    #-48,d7
[000041c4] 2c05                      move.l     d5,d6
[000041c6] e786                      asl.l      #3,d6
[000041c8] 4283                      clr.l      d3
[000041ca] 1615                      move.b     (a5),d3
[000041cc] dc83                      add.l      d3,d6
[000041ce] de86                      add.l      d6,d7
[000041d0] 2a07                      move.l     d7,d5
[000041d2] 528d                      addq.l     #1,a5
[000041d4] 5284                      addq.l     #1,d4
[000041d6] 60ce                      bra.s      _doesc_4
_doesc_2:
[000041d8] 4287                      clr.l      d7
[000041da] 1e15                      move.b     (a5),d7
[000041dc] 0c47 0041                 cmpi.w     #$0041,d7
[000041e0] 6514                      bcs.s      _doesc_5
[000041e2] 4287                      clr.l      d7
[000041e4] 1e15                      move.b     (a5),d7
[000041e6] 0c47 005a                 cmpi.w     #$005A,d7
[000041ea] 620a                      bhi.s      _doesc_5
[000041ec] 7e20                      moveq.l    #32,d7
[000041ee] 4286                      clr.l      d6
[000041f0] 1c15                      move.b     (a5),d6
[000041f2] de86                      add.l      d6,d7
[000041f4] 6004                      bra.s      _doesc_6
_doesc_5:
[000041f6] 4287                      clr.l      d7
[000041f8] 1e15                      move.b     (a5),d7
_doesc_6:
[000041fa] 2e87                      move.l     d7,(a7)
[000041fc] 2f3c 0002 132f            move.l     #$0002687F,-(a7)
[00004202] 4eb9 0000 4732            jsr        _scnstr
[00004208] 588f                      addq.l     #4,a7
[0000420a] 2a07                      move.l     d7,d5
[0000420c] 0c85 0000 0005            cmpi.l     #$00000005,d5
[00004212] 6c28                      bge.s      _doesc_7
[00004214] 246e 0008                 movea.l    8(a6),a2
[00004218] 248d                      move.l     a5,(a2)
[0000421a] 2445                      movea.l    d5,a2
[0000421c] d5fc 0002 1328            adda.l     #$00026878,a2
[00004222] 4287                      clr.l      d7
[00004224] 1e12                      move.b     (a2),d7
[00004226] 600c                      bra.s      _doesc_8
_doesc_3:
[00004228] 246e 0008                 movea.l    8(a6),a2
[0000422c] 49ed ffff                 lea.l      -1(a5),a4
[00004230] 248c                      move.l     a4,(a2)
[00004232] 2e05                      move.l     d5,d7
_doesc_8:
[00004234] 4cdf 3039                 movem.l    (a7)+,d0/d3-d5/a4-a5
[00004238] 4e5e                      unlk       a6
[0000423a] 4e75                      rts
_doesc_7:
[0000423c] 4aae 000c                 tst.l      12(a6)
[00004240] 672a                      beq.s      _doesc_9
[00004242] 4287                      clr.l      d7
[00004244] 1e15                      move.b     (a5),d7
[00004246] 2e87                      move.l     d7,(a7)
[00004248] 2f2e 000c                 move.l     12(a6),-(a7)
[0000424c] 4eb9 0000 4732            jsr        _scnstr
[00004252] 588f                      addq.l     #4,a7
[00004254] 2a07                      move.l     d7,d5
[00004256] 2445                      movea.l    d5,a2
[00004258] d5ee 000c                 adda.l     12(a6),a2
[0000425c] 4a12                      tst.b      (a2)
[0000425e] 670c                      beq.s      _doesc_9
[00004260] 246e 0008                 movea.l    8(a6),a2
[00004264] 248d                      move.l     a5,(a2)
[00004266] 7eff                      moveq.l    #-1,d7
[00004268] 9e85                      sub.l      d5,d7
[0000426a] 60c8                      bra.s      _doesc_8
_doesc_9:
[0000426c] 246e 0008                 movea.l    8(a6),a2
[00004270] 248d                      move.l     a5,(a2)
[00004272] 4287                      clr.l      d7
[00004274] 1e15                      move.b     (a5),d7
[00004276] 60bc                      bra.s      _doesc_8
[00004278] 4e56 0000                 link       a6,#0
[0000427c] 48e7 8004                 movem.l    d0/a5,-(a7)
[00004280] 2a79 0002 1336            movea.l    $00026886,a5
_doesc_12:
[00004286] 2e0d                      move.l     a5,d7
[00004288] 6722                      beq.s      _doesc_10
[0000428a] 4a6d 0002                 tst.w      2(a5)
[0000428e] 6f2a                      ble.s      _doesc_11
[00004290] 3e2d 0002                 move.w     2(a5),d7
[00004294] 48c7                      ext.l      d7
[00004296] 2e87                      move.l     d7,(a7)
[00004298] 486d 000a                 pea.l      10(a5)
[0000429c] 3e15                      move.w     (a5),d7
[0000429e] 48c7                      ext.l      d7
[000042a0] 2f07                      move.l     d7,-(a7)
[000042a2] 4eb9 0000 5548            jsr        _write
[000042a8] 508f                      addq.l     #8,a7
[000042aa] 600e                      bra.s      _doesc_11
_doesc_10:
[000042ac] 2e39 0002 133a            move.l     $0002688A,d7
[000042b2] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000042b6] 4e5e                      unlk       a6
[000042b8] 4e75                      rts
_doesc_11:
[000042ba] 2a6d 0006                 movea.l    6(a5),a5
[000042be] 60c6                      bra.s      _doesc_12

_finit:
[000042c0] 4e56 0000                 link       a6,#0
[000042c4] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[000042c8] 2a6e 0008                 movea.l    8(a6),a5
[000042cc] 2a2e 0010                 move.l     16(a6),d5
[000042d0] 2e0d                      move.l     a5,d7
[000042d2] 6610                      bne.s      _finit_1
[000042d4] 2ebc 0002 1378            move.l     #$000268C8,(a7)
[000042da] 42a7                      clr.l      -(a7)
[000042dc] 4eb9 0000 5316            jsr        __raise
[000042e2] 588f                      addq.l     #4,a7
_finit_1:
[000042e4] 3aae 000e                 move.w     14(a6),(a5)
[000042e8] 426d 0002                 clr.w      2(a5)
[000042ec] 0c85 0000 0001            cmpi.l     #$00000001,d5
[000042f2] 661c                      bne.s      _finit_2
[000042f4] 4878 0001                 pea.l      ($00000001).w
[000042f8] 42a7                      clr.l      -(a7)
[000042fa] 2f2e 000c                 move.l     12(a6),-(a7)
[000042fe] 4eb9 0000 450e            jsr        _lseek
[00004304] 4fef 000c                 lea.l      12(a7),a7
[00004308] 4a87                      tst.l      d7
[0000430a] 6d04                      blt.s      _finit_2
[0000430c] 7eff                      moveq.l    #-1,d7
[0000430e] 6002                      bra.s      _finit_3
_finit_2:
[00004310] 2e05                      move.l     d5,d7
_finit_3:
[00004312] 3b47 0004                 move.w     d7,4(a5)
[00004316] 0c85 0000 0001            cmpi.l     #$00000001,d5
[0000431c] 6708                      beq.s      _finit_4
[0000431e] 0c85 ffff ffff            cmpi.l     #$FFFFFFFF,d5
[00004324] 6628                      bne.s      _finit_5
_finit_4:
[00004326] 2b79 0002 1336 0006       move.l     $00026886,6(a5)
[0000432e] 23cd 0002 1336            move.l     a5,$00026886
[00004334] 4ab9 0002 133a            tst.l      $0002688A
[0000433a] 6612                      bne.s      _finit_5
[0000433c] 2ebc 0000 4278            move.l     #$00004278,(a7)
[00004342] 4eb9 0000 00aa            jsr        _onexit
[00004348] 23c7 0002 133a            move.l     d7,$0002688A
_finit_5:
[0000434e] 2e0d                      move.l     a5,d7
[00004350] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00004354] 4e5e                      unlk       a6
[00004356] 4e75                      rts

_getenv:
[00004358] 4e56 0000                 link       a6,#0
[0000435c] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00004360] 2a6e 0008                 movea.l    8(a6),a5
[00004364] 2e8d                      move.l     a5,(a7)
[00004366] 4eb9 0000 52f4            jsr        _lenstr
[0000436c] 2a07                      move.l     d7,d5
[0000436e] 2879 0002 0072            movea.l    $000255C2,a4
_getenv_4:
[00004374] 2e0c                      move.l     a4,d7
[00004376] 672e                      beq.s      _getenv_1
[00004378] 4a94                      tst.l      (a4)
[0000437a] 672a                      beq.s      _getenv_1
[0000437c] 2e85                      move.l     d5,(a7)
[0000437e] 2f14                      move.l     (a4),-(a7)
[00004380] 2f0d                      move.l     a5,-(a7)
[00004382] 4eb9 0000 4cde            jsr        _cmpbuf
[00004388] 508f                      addq.l     #8,a7
[0000438a] 4a87                      tst.l      d7
[0000438c] 6722                      beq.s      _getenv_2
[0000438e] 2454                      movea.l    (a4),a2
[00004390] d5c5                      adda.l     d5,a2
[00004392] 4287                      clr.l      d7
[00004394] 1e12                      move.b     (a2),d7
[00004396] 0c47 003d                 cmpi.w     #$003D,d7
[0000439a] 6614                      bne.s      _getenv_2
[0000439c] 2e14                      move.l     (a4),d7
[0000439e] 2445                      movea.l    d5,a2
[000043a0] 528a                      addq.l     #1,a2
[000043a2] de8a                      add.l      a2,d7
[000043a4] 6002                      bra.s      _getenv_3
_getenv_1:
[000043a6] 4287                      clr.l      d7
_getenv_3:
[000043a8] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000043ac] 4e5e                      unlk       a6
[000043ae] 4e75                      rts
_getenv_2:
[000043b0] 588c                      addq.l     #4,a4
[000043b2] 60c0                      bra.s      _getenv_4

_getl:
[000043b4] 4e56 0000                 link       a6,#0
[000043b8] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000043bc] 2a6e 0008                 movea.l    8(a6),a5
[000043c0] 286e 000c                 movea.l    12(a6),a4
[000043c4] 2e0d                      move.l     a5,d7
[000043c6] 6610                      bne.s      _getl_1
[000043c8] 2ebc 0002 1378            move.l     #$000268C8,(a7)
[000043ce] 42a7                      clr.l      -(a7)
[000043d0] 4eb9 0000 5316            jsr        __raise
[000043d6] 588f                      addq.l     #4,a7
_getl_1:
[000043d8] 4285                      clr.l      d5
_getl_7:
[000043da] 4a6d 0002                 tst.w      2(a5)
[000043de] 663a                      bne.s      _getl_2
[000043e0] 2ebc 0000 0200            move.l     #$00000200,(a7)
[000043e6] 45ed 000a                 lea.l      10(a5),a2
[000043ea] 2b4a 0006                 move.l     a2,6(a5)
[000043ee] 2f2d 0006                 move.l     6(a5),-(a7)
[000043f2] 3e15                      move.w     (a5),d7
[000043f4] 48c7                      ext.l      d7
[000043f6] 2f07                      move.l     d7,-(a7)
[000043f8] 4eb9 0000 472a            jsr        _read
[000043fe] 508f                      addq.l     #8,a7
[00004400] 3b47 0002                 move.w     d7,2(a5)
[00004404] 4a6d 0002                 tst.w      2(a5)
[00004408] 6c10                      bge.s      _getl_2
[0000440a] 2ebc 0002 133e            move.l     #$0002688E,(a7)
[00004410] 42a7                      clr.l      -(a7)
[00004412] 4eb9 0000 5316            jsr        __raise
[00004418] 588f                      addq.l     #4,a7
_getl_2:
[0000441a] 4a6d 0002                 tst.w      2(a5)
[0000441e] 6e0a                      bgt.s      _getl_3
[00004420] 3b7c ffff 0002            move.w     #$FFFF,2(a5)
[00004426] 2e05                      move.l     d5,d7
[00004428] 6028                      bra.s      _getl_4
_getl_3:
[0000442a] baae 0010                 cmp.l      16(a6),d5
[0000442e] 642a                      bcc.s      _getl_5
[00004430] 4a6d 0002                 tst.w      2(a5)
[00004434] 6f24                      ble.s      _getl_5
[00004436] 5285                      addq.l     #1,d5
[00004438] 536d 0002                 subq.w     #1,2(a5)
[0000443c] 246d 0006                 movea.l    6(a5),a2
[00004440] 52ad 0006                 addq.l     #1,6(a5)
[00004444] 1892                      move.b     (a2),(a4)
[00004446] 4287                      clr.l      d7
[00004448] 1e14                      move.b     (a4),d7
[0000444a] 0c47 000a                 cmpi.w     #$000A,d7
[0000444e] 6618                      bne.s      _getl_6
[00004450] 2e05                      move.l     d5,d7
_getl_4:
[00004452] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00004456] 4e5e                      unlk       a6
[00004458] 4e75                      rts
_getl_5:
[0000445a] 2e2e 0010                 move.l     16(a6),d7
[0000445e] be85                      cmp.l      d5,d7
[00004460] 6200 ff78                 bhi        _getl_7
[00004464] 2e05                      move.l     d5,d7
[00004466] 60ea                      bra.s      _getl_4
_getl_6:
[00004468] 528c                      addq.l     #1,a4
[0000446a] 60be                      bra.s      _getl_3

_instr:
[0000446c] 4e56 0000                 link       a6,#0
[00004470] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00004474] 2a6e 0008                 movea.l    8(a6),a5
_instr_5:
[00004478] 4a15                      tst.b      (a5)
[0000447a] 671c                      beq.s      _instr_1
[0000447c] 286e 000c                 movea.l    12(a6),a4
_instr_6:
[00004480] 4a14                      tst.b      (a4)
[00004482] 6722                      beq.s      _instr_2
[00004484] 4287                      clr.l      d7
[00004486] 1e15                      move.b     (a5),d7
[00004488] 4286                      clr.l      d6
[0000448a] 1c14                      move.b     (a4),d6
[0000448c] be86                      cmp.l      d6,d7
[0000448e] 661a                      bne.s      _instr_3
[00004490] 2e0d                      move.l     a5,d7
[00004492] 9eae 0008                 sub.l      8(a6),d7
[00004496] 6006                      bra.s      _instr_4
_instr_1:
[00004498] 2e0d                      move.l     a5,d7
[0000449a] 9eae 0008                 sub.l      8(a6),d7
_instr_4:
[0000449e] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000044a2] 4e5e                      unlk       a6
[000044a4] 4e75                      rts
_instr_2:
[000044a6] 528d                      addq.l     #1,a5
[000044a8] 60ce                      bra.s      _instr_5
_instr_3:
[000044aa] 528c                      addq.l     #1,a4
[000044ac] 60d2                      bra.s      _instr_6

a.lmod:
[000044ae] 48e7 7c00                 movem.l    d1-d5,-(a7)
[000044b2] 3a3c ff00                 move.w     #$FF00,d5
[000044b6] 282f 0018                 move.l     24(a7),d4
[000044ba] 6c14                      bge.s      a.lmod_1
[000044bc] 4484                      neg.l      d4
[000044be] 6010                      bra.s      a.lmod_1
a.lmod_1: ; not found: 000044d0

a.ldiv:
[000044c0] 48e7 7c00                 movem.l    d1-d5,-(a7)
[000044c4] 4245                      clr.w      d5
[000044c6] 282f 0018                 move.l     24(a7),d4
[000044ca] 6c04                      bge.s      a.ldiv_1
[000044cc] 4484                      neg.l      d4
[000044ce] 4605                      not.b      d5
a.ldiv_1:
[000044d0] 262f 001c                 move.l     28(a7),d3
[000044d4] 6c04                      bge.s      a.ldiv_2
[000044d6] 4483                      neg.l      d3
[000044d8] 4605                      not.b      d5
a.ldiv_2:
[000044da] 4282                      clr.l      d2
[000044dc] 721f                      moveq.l    #31,d1
[000044de] 4280                      clr.l      d0
a.ldiv_4:
[000044e0] e38a                      lsl.l      #1,d2
[000044e2] e38b                      lsl.l      #1,d3
[000044e4] d580                      addx.l     d0,d2
[000044e6] b484                      cmp.l      d4,d2
[000044e8] 6504                      bcs.s      a.ldiv_3
[000044ea] 9484                      sub.l      d4,d2
[000044ec] 5283                      addq.l     #1,d3
a.ldiv_3:
[000044ee] 51c9 fff0                 dbf        d1,a.ldiv_4
[000044f2] 4a45                      tst.w      d5
[000044f4] 6c04                      bge.s      a.ldiv_5
[000044f6] 2002                      move.l     d2,d0
[000044f8] 6002                      bra.s      a.ldiv_6
a.ldiv_5:
[000044fa] 2003                      move.l     d3,d0
a.ldiv_6:
[000044fc] 4a05                      tst.b      d5
[000044fe] 6702                      beq.s      a.ldiv_7
[00004500] 4480                      neg.l      d0
a.ldiv_7:
[00004502] 4cdf 003e                 movem.l    (a7)+,d1-d5
[00004506] 2e9f                      move.l     (a7)+,(a7)
[00004508] 2f40 0004                 move.l     d0,4(a7)
[0000450c] 4e75                      rts

_lseek:
[0000450e] 4e56 ffda                 link       a6,#-38
[00004512] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[00004516] 2a2e 0008                 move.l     8(a6),d5
[0000451a] 4aae 000c                 tst.l      12(a6)
[0000451e] 660a                      bne.s      _lseek_1
[00004520] 0cae 0000 0001 0010       cmpi.l     #$00000001,16(a6)
[00004528] 6720                      beq.s      _lseek_2
_lseek_1:
[0000452a] 2eae 0010                 move.l     16(a6),(a7)
[0000452e] 2f2e 000c                 move.l     12(a6),-(a7)
[00004532] 2f05                      move.l     d5,-(a7)
[00004534] 4eb9 0000 4768            jsr        _seek
[0000453a] 508f                      addq.l     #8,a7
[0000453c] 2807                      move.l     d7,d4
[0000453e] 4a84                      tst.l      d4
[00004540] 6c04                      bge.s      _lseek_3
[00004542] 2e04                      move.l     d4,d7
[00004544] 6002                      bra.s      _lseek_4
_lseek_3:
[00004546] 2e05                      move.l     d5,d7
_lseek_4:
[00004548] 6014                      bra.s      _lseek_5
_lseek_2:
[0000454a] 486e ffda                 pea.l      -38(a6)
[0000454e] 2f05                      move.l     d5,-(a7)
[00004550] 4eb9 0000 4fc2            jsr        _fstat
[00004556] 508f                      addq.l     #8,a7
[00004558] 2807                      move.l     d7,d4
[0000455a] 6c0a                      bge.s      _lseek_6
[0000455c] 2e04                      move.l     d4,d7
_lseek_5:
[0000455e] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[00004562] 4e5e                      unlk       a6
[00004564] 4e75                      rts
_lseek_6:
[00004566] 4287                      clr.l      d7
[00004568] 3e2e ffde                 move.w     -34(a6),d7
[0000456c] 0287 0000 6000            andi.l     #$00006000,d7
[00004572] 0c87 0000 2000            cmpi.l     #$00002000,d7
[00004578] 6706                      beq.s      _lseek_7
[0000457a] 4a2e ffe0                 tst.b      -32(a6)
[0000457e] 6604                      bne.s      _lseek_8
_lseek_7:
[00004580] 7ee3                      moveq.l    #-29,d7
[00004582] 60da                      bra.s      _lseek_5
_lseek_8:
[00004584] 2e05                      move.l     d5,d7
[00004586] 60d6                      bra.s      _lseek_5

_open:
[00004588] 205f                      movea.l    (a7)+,a0
[0000458a] 7e05                      moveq.l    #5,d7
[0000458c] 4e41                      trap       #1
[0000458e] 4ed0                      jmp        (a0)

_putc:
[00004590] 4e56 0000                 link       a6,#0
[00004594] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00004598] 2a6e 0008                 movea.l    8(a6),a5
[0000459c] 2a2e 000c                 move.l     12(a6),d5
[000045a0] 2e0d                      move.l     a5,d7
[000045a2] 6610                      bne.s      _putc_1
[000045a4] 2ebc 0002 1378            move.l     #$000268C8,(a7)
[000045aa] 42a7                      clr.l      -(a7)
[000045ac] 4eb9 0000 5316            jsr        __raise
[000045b2] 588f                      addq.l     #4,a7
_putc_1:
[000045b4] 4a85                      tst.l      d5
[000045b6] 6d22                      blt.s      _putc_2
[000045b8] 3e2d 0002                 move.w     2(a5),d7
[000045bc] 48c7                      ext.l      d7
[000045be] 0c47 0200                 cmpi.w     #$0200,d7
[000045c2] 6c20                      bge.s      _putc_3
[000045c4] 3e2d 0002                 move.w     2(a5),d7
[000045c8] 48c7                      ext.l      d7
[000045ca] 2447                      movea.l    d7,a2
[000045cc] 526d 0002                 addq.w     #1,2(a5)
[000045d0] 49ed 000a                 lea.l      10(a5),a4
[000045d4] d5cc                      adda.l     a4,a2
[000045d6] 1485                      move.b     d5,(a2)
[000045d8] 602e                      bra.s      _putc_4
_putc_2:
[000045da] 4a6d 0002                 tst.w      2(a5)
[000045de] 6e46                      bgt.s      _putc_5
[000045e0] 2e05                      move.l     d5,d7
[000045e2] 603a                      bra.s      _putc_6
_putc_3:
[000045e4] 3e2d 0002                 move.w     2(a5),d7
[000045e8] 48c7                      ext.l      d7
[000045ea] 2e87                      move.l     d7,(a7)
[000045ec] 486d 000a                 pea.l      10(a5)
[000045f0] 3e15                      move.w     (a5),d7
[000045f2] 48c7                      ext.l      d7
[000045f4] 2f07                      move.l     d7,-(a7)
[000045f6] 4eb9 0000 52ba            jsr        _fwrite
[000045fc] 508f                      addq.l     #8,a7
[000045fe] 3b7c 0001 0002            move.w     #$0001,2(a5)
[00004604] 1b45 000a                 move.b     d5,10(a5)
_putc_4:
[00004608] 0c85 0000 000a            cmpi.l     #$0000000A,d5
[0000460e] 660c                      bne.s      _putc_7
[00004610] 3e2d 0004                 move.w     4(a5),d7
[00004614] 48c7                      ext.l      d7
[00004616] 0c47 ffff                 cmpi.w     #$FFFF,d7
[0000461a] 66be                      bne.s      _putc_2
_putc_7:
[0000461c] 2e05                      move.l     d5,d7
_putc_6:
[0000461e] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00004622] 4e5e                      unlk       a6
[00004624] 4e75                      rts
_putc_5:
[00004626] 3e2d 0002                 move.w     2(a5),d7
[0000462a] 48c7                      ext.l      d7
[0000462c] 2e87                      move.l     d7,(a7)
[0000462e] 486d 000a                 pea.l      10(a5)
[00004632] 3e15                      move.w     (a5),d7
[00004634] 48c7                      ext.l      d7
[00004636] 2f07                      move.l     d7,-(a7)
[00004638] 4eb9 0000 52ba            jsr        _fwrite
[0000463e] 508f                      addq.l     #8,a7
[00004640] 426d 0002                 clr.w      2(a5)
[00004644] 2e05                      move.l     d5,d7
[00004646] 60d6                      bra.s      _putc_6

_putl:
[00004648] 4e56 fffc                 link       a6,#-4
[0000464c] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[00004650] 2a6e 0008                 movea.l    8(a6),a5
[00004654] 286e 000c                 movea.l    12(a6),a4
[00004658] 2e0d                      move.l     a5,d7
[0000465a] 6618                      bne.s      _putl_1
[0000465c] 2ebc 0002 1378            move.l     #$000268C8,(a7)
[00004662] 42a7                      clr.l      -(a7)
[00004664] 4eb9 0000 5316            jsr        __raise
[0000466a] 588f                      addq.l     #4,a7
[0000466c] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[00004670] 4e5e                      unlk       a6
[00004672] 4e75                      rts
_putl_1:
[00004674] 2a2e 0010                 move.l     16(a6),d5
_putl_6:
[00004678] 4a85                      tst.l      d5
[0000467a] 6f32                      ble.s      _putl_2
[0000467c] 45ed 000a                 lea.l      10(a5),a2
[00004680] 3e2d 0002                 move.w     2(a5),d7
[00004684] 48c7                      ext.l      d7
[00004686] d5c7                      adda.l     d7,a2
[00004688] 2d4a fffc                 move.l     a2,-4(a6)
_putl_4:
[0000468c] 4a85                      tst.l      d5
[0000468e] 6f68                      ble.s      _putl_3
[00004690] 3e2d 0002                 move.w     2(a5),d7
[00004694] 48c7                      ext.l      d7
[00004696] 0c47 0200                 cmpi.w     #$0200,d7
[0000469a] 6c5c                      bge.s      _putl_3
[0000469c] 246e fffc                 movea.l    -4(a6),a2
[000046a0] 52ae fffc                 addq.l     #1,-4(a6)
[000046a4] 149c                      move.b     (a4)+,(a2)
[000046a6] 5385                      subq.l     #1,d5
[000046a8] 526d 0002                 addq.w     #1,2(a5)
[000046ac] 60de                      bra.s      _putl_4
_putl_2:
[000046ae] 3e2d 0004                 move.w     4(a5),d7
[000046b2] 48c7                      ext.l      d7
[000046b4] 0c47 ffff                 cmpi.w     #$FFFF,d7
[000046b8] 6764                      beq.s      _putl_5
[000046ba] 4a6d 0002                 tst.w      2(a5)
[000046be] 675e                      beq.s      _putl_5
[000046c0] 3e2d 0002                 move.w     2(a5),d7
[000046c4] 48c7                      ext.l      d7
[000046c6] 2447                      movea.l    d7,a2
[000046c8] 47ed 0009                 lea.l      9(a5),a3
[000046cc] d5cb                      adda.l     a3,a2
[000046ce] 4287                      clr.l      d7
[000046d0] 1e12                      move.b     (a2),d7
[000046d2] 0c47 000a                 cmpi.w     #$000A,d7
[000046d6] 6646                      bne.s      _putl_5
[000046d8] 3e2d 0002                 move.w     2(a5),d7
[000046dc] 48c7                      ext.l      d7
[000046de] 2e87                      move.l     d7,(a7)
[000046e0] 486d 000a                 pea.l      10(a5)
[000046e4] 3e15                      move.w     (a5),d7
[000046e6] 48c7                      ext.l      d7
[000046e8] 2f07                      move.l     d7,-(a7)
[000046ea] 4eb9 0000 52ba            jsr        _fwrite
[000046f0] 508f                      addq.l     #8,a7
[000046f2] 426d 0002                 clr.w      2(a5)
[000046f6] 6026                      bra.s      _putl_5
_putl_3:
[000046f8] 4a85                      tst.l      d5
[000046fa] 6f00 ff7c                 ble        _putl_6
[000046fe] 2ebc 0000 0200            move.l     #$00000200,(a7)
[00004704] 486d 000a                 pea.l      10(a5)
[00004708] 3e15                      move.w     (a5),d7
[0000470a] 48c7                      ext.l      d7
[0000470c] 2f07                      move.l     d7,-(a7)
[0000470e] 4eb9 0000 52ba            jsr        _fwrite
[00004714] 508f                      addq.l     #8,a7
[00004716] 426d 0002                 clr.w      2(a5)
[0000471a] 6000 ff5c                 bra        _putl_6
_putl_5:
[0000471e] 2e2e 0010                 move.l     16(a6),d7
[00004722] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[00004726] 4e5e                      unlk       a6
[00004728] 4e75                      rts

_read:
[0000472a] 205f                      movea.l    (a7)+,a0
[0000472c] 7e03                      moveq.l    #3,d7
[0000472e] 4e41                      trap       #1
[00004730] 4ed0                      jmp        (a0)

_scnstr:
[00004732] 4e56 fffe                 link       a6,#-2
[00004736] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[0000473a] 2a6e 0008                 movea.l    8(a6),a5
[0000473e] 1d6e 000f ffff            move.b     15(a6),-1(a6)
[00004744] 284d                      movea.l    a5,a4
_scnstr_3:
[00004746] 4a14                      tst.b      (a4)
[00004748] 670e                      beq.s      _scnstr_1
[0000474a] 4287                      clr.l      d7
[0000474c] 1e14                      move.b     (a4),d7
[0000474e] 4286                      clr.l      d6
[00004750] 1c2e ffff                 move.b     -1(a6),d6
[00004754] be86                      cmp.l      d6,d7
[00004756] 660c                      bne.s      _scnstr_2
_scnstr_1:
[00004758] 2e0c                      move.l     a4,d7
[0000475a] 9e8d                      sub.l      a5,d7
[0000475c] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00004760] 4e5e                      unlk       a6
[00004762] 4e75                      rts
_scnstr_2:
[00004764] 528c                      addq.l     #1,a4
[00004766] 60de                      bra.s      _scnstr_3

_seek:
[00004768] 205f                      movea.l    (a7)+,a0
[0000476a] 7e13                      moveq.l    #19,d7
[0000476c] 4e41                      trap       #1
[0000476e] 4ed0                      jmp        (a0)

a.switch:
[00004770] 4a98                      tst.l      (a0)+
[00004772] 670a                      beq.s      a.switch_1
[00004774] be98                      cmp.l      (a0)+,d7
[00004776] 66f8                      bne.s      a.switch
[00004778] 2068 fff8                 movea.l    -8(a0),a0
[0000477c] 4ed0                      jmp        (a0)
a.switch_1:
[0000477e] 2050                      movea.l    (a0),a0
[00004780] 4ed0                      jmp        (a0)

a.ulmod:
[00004782] 48e7 7c00                 movem.l    d1-d5,-(a7)
[00004786] 7aff                      moveq.l    #-1,d5
[00004788] 6006                      bra.s      a.ulmod_1
a.ulmod_1: ; not found: 00004790

a.uldiv:
[0000478a] 48e7 7c00                 movem.l    d1-d5,-(a7)
[0000478e] 4205                      clr.b      d5
[00004790] 282f 0018                 move.l     24(a7),d4
[00004794] 262f 001c                 move.l     28(a7),d3
[00004798] 4282                      clr.l      d2
[0000479a] 721f                      moveq.l    #31,d1
[0000479c] 4280                      clr.l      d0
a.uldiv_2:
[0000479e] e38a                      lsl.l      #1,d2
[000047a0] e38b                      lsl.l      #1,d3
[000047a2] d580                      addx.l     d0,d2
[000047a4] b484                      cmp.l      d4,d2
[000047a6] 6504                      bcs.s      a.uldiv_1
[000047a8] 9484                      sub.l      d4,d2
[000047aa] 5283                      addq.l     #1,d3
a.uldiv_1:
[000047ac] 51c9 fff0                 dbf        d1,a.uldiv_2
[000047b0] 4a05                      tst.b      d5
[000047b2] 6c04                      bge.s      a.uldiv_3
[000047b4] 2002                      move.l     d2,d0
[000047b6] 6002                      bra.s      a.uldiv_4
a.uldiv_3:
[000047b8] 2003                      move.l     d3,d0
a.uldiv_4:
[000047ba] 4cdf 003e                 movem.l    (a7)+,d1-d5
[000047be] 2e9f                      move.l     (a7)+,(a7)
[000047c0] 2f40 0004                 move.l     d0,4(a7)
[000047c4] 4e75                      rts

_uname:
[000047c6] 4e56 0000                 link       a6,#0
[000047ca] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[000047ce] 4a39 0002 1354            tst.b      $000268A4
[000047d4] 662a                      bne.s      _uname_1
[000047d6] 4eb9 0000 4fca            jsr        _getpid
[000047dc] 2807                      move.l     d7,d4
[000047de] 7a0b                      moveq.l    #11,d5
_uname_2:
[000047e0] 5385                      subq.l     #1,d5
[000047e2] 0c85 0000 0006            cmpi.l     #$00000006,d5
[000047e8] 6d16                      blt.s      _uname_1
[000047ea] 2445                      movea.l    d5,a2
[000047ec] d5fc 0002 134e            adda.l     #$0002689E,a2
[000047f2] 7e30                      moveq.l    #48,d7
[000047f4] 7c07                      moveq.l    #7,d6
[000047f6] cc84                      and.l      d4,d6
[000047f8] de86                      add.l      d6,d7
[000047fa] 1487                      move.b     d7,(a2)
[000047fc] e684                      asr.l      #3,d4
[000047fe] 60e0                      bra.s      _uname_2
_uname_1:
[00004800] 2e3c 0002 134e            move.l     #$0002689E,d7
[00004806] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[0000480a] 4e5e                      unlk       a6
[0000480c] 4e75                      rts

x480e:
[0000480e] 4e56 0000                 link       a6,#0
[00004812] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00004816] 2a6e 0008                 movea.l    8(a6),a5
[0000481a] 2a2e 000c                 move.l     12(a6),d5
[0000481e] 2e0d                      move.l     a5,d7
[00004820] de85                      add.l      d5,d7
[00004822] 2847                      movea.l    d7,a4
[00004824] 2e15                      move.l     (a5),d7
[00004826] 9e85                      sub.l      d5,d7
[00004828] 2887                      move.l     d7,(a4)
[0000482a] 296d 0004 0004            move.l     4(a5),4(a4)
[00004830] 2445                      movea.l    d5,a2
[00004832] 518a                      subq.l     #8,a2
[00004834] 2a8a                      move.l     a2,(a5)
[00004836] 2e0c                      move.l     a4,d7
[00004838] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000483c] 4e5e                      unlk       a6
[0000483e] 4e75                      rts

x4840:
[00004840] 4e56 0000                 link       a6,#0
[00004844] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00004848] 2a6e 0008                 movea.l    8(a6),a5
[0000484c] 286d 0004                 movea.l    4(a5),a4
[00004850] 2e0d                      move.l     a5,d7
[00004852] de95                      add.l      (a5),d7
[00004854] 5087                      addq.l     #8,d7
[00004856] be8c                      cmp.l      a4,d7
[00004858] 660c                      bne.s      x4840_1
[0000485a] 2e14                      move.l     (a4),d7
[0000485c] 5087                      addq.l     #8,d7
[0000485e] df95                      add.l      d7,(a5)
[00004860] 2b6c 0004 0004            move.l     4(a4),4(a5)
x4840_1:
[00004866] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[0000486a] 4e5e                      unlk       a6
[0000486c] 4e75                      rts

_alloc:
[0000486e] 4e56 0000                 link       a6,#0
[00004872] 48e7 8004                 movem.l    d0/a5,-(a7)
[00004876] 2eae 000c                 move.l     12(a6),(a7)
[0000487a] 2f2e 0008                 move.l     8(a6),-(a7)
[0000487e] 4eb9 0000 48a8            jsr        _nalloc
[00004884] 588f                      addq.l     #4,a7
[00004886] 2a47                      movea.l    d7,a5
[00004888] 2e0d                      move.l     a5,d7
[0000488a] 6704                      beq.s      _alloc_1
[0000488c] 2e0d                      move.l     a5,d7
[0000488e] 6010                      bra.s      _alloc_2
_alloc_1:
[00004890] 2ebc 0002 138e            move.l     #$000268DE,(a7)
[00004896] 42a7                      clr.l      -(a7)
[00004898] 4eb9 0000 5316            jsr        __raise
[0000489e] 588f                      addq.l     #4,a7
_alloc_2:
[000048a0] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000048a4] 4e5e                      unlk       a6
[000048a6] 4e75                      rts

_nalloc:
[000048a8] 4e56 fffc                 link       a6,#-4
[000048ac] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[000048b0] 2a2e 0008                 move.l     8(a6),d5
[000048b4] 0c85 0000 0004            cmpi.l     #$00000004,d5
[000048ba] 6404                      bcc.s      _nalloc_1
[000048bc] 7e04                      moveq.l    #4,d7
[000048be] 6002                      bra.s      _nalloc_2
_nalloc_1:
[000048c0] 2e05                      move.l     d5,d7
_nalloc_2:
[000048c2] 5687                      addq.l     #3,d7
[000048c4] 7cfc                      moveq.l    #-4,d6
[000048c6] cc87                      and.l      d7,d6
[000048c8] 2e06                      move.l     d6,d7
[000048ca] 5887                      addq.l     #4,d7
[000048cc] 2a07                      move.l     d7,d5
_nalloc_18:
[000048ce] 2a7c 0002 135e            movea.l    #$000268AE,a5
_nalloc_9:
[000048d4] 2855                      movea.l    (a5),a4
[000048d6] 2e0c                      move.l     a4,d7
[000048d8] 6714                      beq.s      _nalloc_3
[000048da] 2e14                      move.l     (a4),d7
[000048dc] 5087                      addq.l     #8,d7
[000048de] ba87                      cmp.l      d7,d5
[000048e0] 6220                      bhi.s      _nalloc_4
[000048e2] 2e14                      move.l     (a4),d7
[000048e4] be85                      cmp.l      d5,d7
[000048e6] 6422                      bcc.s      _nalloc_5
[000048e8] 2aac 0004                 move.l     4(a4),(a5)
[000048ec] 6028                      bra.s      _nalloc_6
_nalloc_3:
[000048ee] 4ab9 0002 135a            tst.l      $000268AA
[000048f4] 662e                      bne.s      _nalloc_7
[000048f6] 23fc 0000 0200 0002 135a  move.l     #$00000200,$000268AA
[00004900] 603c                      bra.s      _nalloc_8
_nalloc_4:
[00004902] 45ec 0004                 lea.l      4(a4),a2
[00004906] 2a4a                      movea.l    a2,a5
[00004908] 60ca                      bra.s      _nalloc_9
_nalloc_5:
[0000490a] 2e85                      move.l     d5,(a7)
[0000490c] 2f0c                      move.l     a4,-(a7)
[0000490e] 4eba fefe                 jsr        $0000480E(pc)
[00004912] 588f                      addq.l     #4,a7
[00004914] 2a87                      move.l     d7,(a5)
_nalloc_6:
[00004916] 296e 000c 0004            move.l     12(a6),4(a4)
[0000491c] 45ec 0004                 lea.l      4(a4),a2
[00004920] 2e0a                      move.l     a2,d7
[00004922] 6066                      bra.s      _nalloc_10
_nalloc_7:
[00004924] 0cb9 0000 0200 0002 135a  cmpi.l     #$00000200,$000268AA
[0000492e] 670e                      beq.s      _nalloc_8
[00004930] 2e39 0002 135a            move.l     $000268AA,d7
[00004936] e28f                      lsr.l      #1,d7
[00004938] 23c7 0002 135a            move.l     d7,$000268AA
_nalloc_8:
[0000493e] 97cb                      suba.l     a3,a3
_nalloc_12:
[00004940] bab9 0002 135a            cmp.l      $000268AA,d5
[00004946] 6228                      bhi.s      _nalloc_11
[00004948] 2d79 0002 135a fffc       move.l     $000268AA,-4(a6)
[00004950] 2eae fffc                 move.l     -4(a6),(a7)
[00004954] 4eb9 0000 5062            jsr        _sbreak
[0000495a] 2647                      movea.l    d7,a3
[0000495c] 2e0b                      move.l     a3,d7
[0000495e] 6610                      bne.s      _nalloc_11
[00004960] 2e39 0002 135a            move.l     $000268AA,d7
[00004966] e28f                      lsr.l      #1,d7
[00004968] 23c7 0002 135a            move.l     d7,$000268AA
[0000496e] 60d0                      bra.s      _nalloc_12
_nalloc_11:
[00004970] 2e0b                      move.l     a3,d7
[00004972] 6610                      bne.s      _nalloc_13
[00004974] 2d45 fffc                 move.l     d5,-4(a6)
[00004978] 2eae fffc                 move.l     -4(a6),(a7)
[0000497c] 4eb9 0000 5062            jsr        _sbreak
[00004982] 2647                      movea.l    d7,a3
_nalloc_13:
[00004984] 2e0b                      move.l     a3,d7
[00004986] 660a                      bne.s      _nalloc_14
[00004988] 4287                      clr.l      d7
_nalloc_10:
[0000498a] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[0000498e] 4e5e                      unlk       a6
[00004990] 4e75                      rts
_nalloc_14:
[00004992] 2e2e fffc                 move.l     -4(a6),d7
[00004996] 5187                      subq.l     #8,d7
[00004998] 2687                      move.l     d7,(a3)
[0000499a] 4ab9 0002 1362            tst.l      $000268B2
[000049a0] 6708                      beq.s      _nalloc_15
[000049a2] b7f9 0002 1362            cmpa.l     $000268B2,a3
[000049a8] 6406                      bcc.s      _nalloc_16
_nalloc_15:
[000049aa] 23cb 0002 1362            move.l     a3,$000268B2
_nalloc_16:
[000049b0] 2e39 0002 1366            move.l     $000268B6,d7
[000049b6] 2c0b                      move.l     a3,d6
[000049b8] dcae fffc                 add.l      -4(a6),d6
[000049bc] be86                      cmp.l      d6,d7
[000049be] 640c                      bcc.s      _nalloc_17
[000049c0] 2e0b                      move.l     a3,d7
[000049c2] deae fffc                 add.l      -4(a6),d7
[000049c6] 23c7 0002 1366            move.l     d7,$000268B6
_nalloc_17:
[000049cc] 4297                      clr.l      (a7)
[000049ce] 486b 0004                 pea.l      4(a3)
[000049d2] 4eb9 0000 49de            jsr        _free
[000049d8] 588f                      addq.l     #4,a7
[000049da] 6000 fef2                 bra        _nalloc_18

_free:
[000049de] 4e56 0000                 link       a6,#0
[000049e2] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[000049e6] 2e2e 0008                 move.l     8(a6),d7
[000049ea] 5987                      subq.l     #4,d7
[000049ec] 2a47                      movea.l    d7,a5
[000049ee] 4aae 0008                 tst.l      8(a6)
[000049f2] 672c                      beq.s      _free_1
[000049f4] bbf9 0002 1362            cmpa.l     $000268B2,a5
[000049fa] 650a                      bcs.s      _free_2
[000049fc] 2e39 0002 1366            move.l     $000268B6,d7
[00004a02] be8d                      cmp.l      a5,d7
[00004a04] 6226                      bhi.s      _free_3
_free_2:
[00004a06] 23fc 0002 136a 0002 138e  move.l     #$000268BA,$000268DE
[00004a10] 2ebc 0002 138e            move.l     #$000268DE,(a7)
[00004a16] 42a7                      clr.l      -(a7)
[00004a18] 4eb9 0000 5316            jsr        __raise
[00004a1e] 588f                      addq.l     #4,a7
_free_1:
[00004a20] 2e2e 000c                 move.l     12(a6),d7
[00004a24] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00004a28] 4e5e                      unlk       a6
[00004a2a] 4e75                      rts
_free_3:
[00004a2c] 4ab9 0002 135e            tst.l      $000268AE
[00004a32] 660c                      bne.s      _free_4
[00004a34] 42ad 0004                 clr.l      4(a5)
[00004a38] 23cd 0002 135e            move.l     a5,$000268AE
[00004a3e] 60e0                      bra.s      _free_1
_free_4:
[00004a40] bbf9 0002 135e            cmpa.l     $000268AE,a5
[00004a46] 6416                      bcc.s      _free_5
[00004a48] 2b79 0002 135e 0004       move.l     $000268AE,4(a5)
[00004a50] 23cd 0002 135e            move.l     a5,$000268AE
[00004a56] 2e8d                      move.l     a5,(a7)
[00004a58] 4eba fde6                 jsr        $00004840(pc)
[00004a5c] 60c2                      bra.s      _free_1
_free_5:
[00004a5e] 2879 0002 135e            movea.l    $000268AE,a4
_free_7:
[00004a64] 266c 0004                 movea.l    4(a4),a3
[00004a68] 2e0b                      move.l     a3,d7
[00004a6a] 6708                      beq.s      _free_6
[00004a6c] b7cd                      cmpa.l     a5,a3
[00004a6e] 6404                      bcc.s      _free_6
[00004a70] 284b                      movea.l    a3,a4
[00004a72] 60f0                      bra.s      _free_7
_free_6:
[00004a74] 2e0b                      move.l     a3,d7
[00004a76] 6716                      beq.s      _free_8
[00004a78] 2b4b 0004                 move.l     a3,4(a5)
[00004a7c] 294d 0004                 move.l     a5,4(a4)
[00004a80] 2e8d                      move.l     a5,(a7)
[00004a82] 4eba fdbc                 jsr        $00004840(pc)
[00004a86] 2e8c                      move.l     a4,(a7)
[00004a88] 4eba fdb6                 jsr        $00004840(pc)
[00004a8c] 6092                      bra.s      _free_1
_free_8:
[00004a8e] 42ad 0004                 clr.l      4(a5)
[00004a92] 294d 0004                 move.l     a5,4(a4)
[00004a96] 2e8c                      move.l     a4,(a7)
[00004a98] 4eba fda6                 jsr        $00004840(pc)
[00004a9c] 6000 ff82                 bra.w      _free_1

_btol:
[00004aa0] 4e56 fff4                 link       a6,#-12
[00004aa4] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00004aa8] 2a6e 0008                 movea.l    8(a6),a5
[00004aac] 2a2e 000c                 move.l     12(a6),d5
[00004ab0] 42ae fff8                 clr.l      -8(a6)
[00004ab4] 2d4d fff4                 move.l     a5,-12(a6)
[00004ab8] 42ae fffc                 clr.l      -4(a6)
_btol_5:
[00004abc] 4a85                      tst.l      d5
[00004abe] 6714                      beq.s      _btol_1
[00004ac0] 4287                      clr.l      d7
[00004ac2] 1e15                      move.b     (a5),d7
[00004ac4] 0c47 0020                 cmpi.w     #$0020,d7
[00004ac8] 6324                      bls.s      _btol_2
[00004aca] 4287                      clr.l      d7
[00004acc] 1e15                      move.b     (a5),d7
[00004ace] 0c47 007f                 cmpi.w     #$007F,d7
[00004ad2] 641a                      bcc.s      _btol_2
_btol_1:
[00004ad4] 4a85                      tst.l      d5
[00004ad6] 671c                      beq.s      _btol_3
[00004ad8] 4287                      clr.l      d7
[00004ada] 1e15                      move.b     (a5),d7
[00004adc] 0c47 002d                 cmpi.w     #$002D,d7
[00004ae0] 661a                      bne.s      _btol_4
[00004ae2] 7001                      moveq.l    #1,d0
[00004ae4] 2d40 fffc                 move.l     d0,-4(a6)
[00004ae8] 528d                      addq.l     #1,a5
[00004aea] 5385                      subq.l     #1,d5
[00004aec] 6006                      bra.s      _btol_3
_btol_2:
[00004aee] 5385                      subq.l     #1,d5
[00004af0] 528d                      addq.l     #1,a5
[00004af2] 60c8                      bra.s      _btol_5
_btol_3:
[00004af4] 4a85                      tst.l      d5
[00004af6] 6614                      bne.s      _btol_6
[00004af8] 6000 00d6                 bra        _btol_7
_btol_4:
[00004afc] 4287                      clr.l      d7
[00004afe] 1e15                      move.b     (a5),d7
[00004b00] 0c47 002b                 cmpi.w     #$002B,d7
[00004b04] 66ee                      bne.s      _btol_3
[00004b06] 528d                      addq.l     #1,a5
[00004b08] 5385                      subq.l     #1,d5
[00004b0a] 60e8                      bra.s      _btol_3
_btol_6:
[00004b0c] 0cae 0000 0001 0014       cmpi.l     #$00000001,20(a6)
[00004b14] 6614                      bne.s      _btol_8
[00004b16] 4287                      clr.l      d7
[00004b18] 1e15                      move.b     (a5),d7
[00004b1a] 0c47 0030                 cmpi.w     #$0030,d7
[00004b1e] 6764                      beq.s      _btol_9
[00004b20] 700a                      moveq.l    #10,d0
[00004b22] 2d40 0014                 move.l     d0,20(a6)
[00004b26] 6000 00a8                 bra        _btol_7
_btol_8:
[00004b2a] 0cae 0000 0010 0014       cmpi.l     #$00000010,20(a6)
[00004b32] 6600 009c                 bne        _btol_7
[00004b36] 0c85 0000 0002            cmpi.l     #$00000002,d5
[00004b3c] 6500 0092                 bcs        _btol_7
[00004b40] 4287                      clr.l      d7
[00004b42] 1e15                      move.b     (a5),d7
[00004b44] 0c47 0030                 cmpi.w     #$0030,d7
[00004b48] 6600 0086                 bne        _btol_7
[00004b4c] 4287                      clr.l      d7
[00004b4e] 1e2d 0001                 move.b     1(a5),d7
[00004b52] 0c47 0041                 cmpi.w     #$0041,d7
[00004b56] 6518                      bcs.s      _btol_10
[00004b58] 4287                      clr.l      d7
[00004b5a] 1e2d 0001                 move.b     1(a5),d7
[00004b5e] 0c47 005a                 cmpi.w     #$005A,d7
[00004b62] 620c                      bhi.s      _btol_10
[00004b64] 7e20                      moveq.l    #32,d7
[00004b66] 4286                      clr.l      d6
[00004b68] 1c2d 0001                 move.b     1(a5),d6
[00004b6c] de86                      add.l      d6,d7
[00004b6e] 6006                      bra.s      _btol_11
_btol_10:
[00004b70] 4287                      clr.l      d7
[00004b72] 1e2d 0001                 move.b     1(a5),d7
_btol_11:
[00004b76] 0c87 0000 0078            cmpi.l     #$00000078,d7
[00004b7c] 6652                      bne.s      _btol_7
[00004b7e] 548d                      addq.l     #2,a5
[00004b80] 5585                      subq.l     #2,d5
[00004b82] 604c                      bra.s      _btol_7
_btol_9:
[00004b84] 0c85 0000 0001            cmpi.l     #$00000001,d5
[00004b8a] 633e                      bls.s      _btol_12
[00004b8c] 4287                      clr.l      d7
[00004b8e] 1e2d 0001                 move.b     1(a5),d7
[00004b92] 0c47 0041                 cmpi.w     #$0041,d7
[00004b96] 6518                      bcs.s      _btol_13
[00004b98] 4287                      clr.l      d7
[00004b9a] 1e2d 0001                 move.b     1(a5),d7
[00004b9e] 0c47 005a                 cmpi.w     #$005A,d7
[00004ba2] 620c                      bhi.s      _btol_13
[00004ba4] 7e20                      moveq.l    #32,d7
[00004ba6] 4286                      clr.l      d6
[00004ba8] 1c2d 0001                 move.b     1(a5),d6
[00004bac] de86                      add.l      d6,d7
[00004bae] 6006                      bra.s      _btol_14
_btol_13:
[00004bb0] 4287                      clr.l      d7
[00004bb2] 1e2d 0001                 move.b     1(a5),d7
_btol_14:
[00004bb6] 0c87 0000 0078            cmpi.l     #$00000078,d7
[00004bbc] 660c                      bne.s      _btol_12
[00004bbe] 7010                      moveq.l    #16,d0
[00004bc0] 2d40 0014                 move.l     d0,20(a6)
[00004bc4] 548d                      addq.l     #2,a5
[00004bc6] 5585                      subq.l     #2,d5
[00004bc8] 6006                      bra.s      _btol_7
_btol_12:
[00004bca] 7008                      moveq.l    #8,d0
[00004bcc] 2d40 0014                 move.l     d0,20(a6)
_btol_7:
[00004bd0] 4a85                      tst.l      d5
[00004bd2] 6720                      beq.s      _btol_15
[00004bd4] 4287                      clr.l      d7
[00004bd6] 1e15                      move.b     (a5),d7
[00004bd8] 0c47 0030                 cmpi.w     #$0030,d7
[00004bdc] 656a                      bcs.s      _btol_16
[00004bde] 4287                      clr.l      d7
[00004be0] 1e15                      move.b     (a5),d7
[00004be2] 0c47 0039                 cmpi.w     #$0039,d7
[00004be6] 6260                      bhi.s      _btol_16
[00004be8] 7ed0                      moveq.l    #-48,d7
[00004bea] 4286                      clr.l      d6
[00004bec] 1c15                      move.b     (a5),d6
[00004bee] de86                      add.l      d6,d7
[00004bf0] 2807                      move.l     d7,d4
[00004bf2] 606a                      bra.s      _btol_17
_btol_15:
[00004bf4] 246e 0010                 movea.l    16(a6),a2
[00004bf8] 2e8a                      move.l     a2,(a7)
[00004bfa] 4aae fffc                 tst.l      -4(a6)
[00004bfe] 6708                      beq.s      _btol_18
[00004c00] 2e2e fff8                 move.l     -8(a6),d7
[00004c04] 4487                      neg.l      d7
[00004c06] 6004                      bra.s      _btol_19
_btol_18:
[00004c08] 2e2e fff8                 move.l     -8(a6),d7
_btol_19:
[00004c0c] 2257                      movea.l    (a7),a1
[00004c0e] 2287                      move.l     d7,(a1)
[00004c10] 4a85                      tst.l      d5
[00004c12] 6700 00b4                 beq        _btol_20
[00004c16] 4287                      clr.l      d7
[00004c18] 1e15                      move.b     (a5),d7
[00004c1a] 0c47 0041                 cmpi.w     #$0041,d7
[00004c1e] 6514                      bcs.s      _btol_21
[00004c20] 4287                      clr.l      d7
[00004c22] 1e15                      move.b     (a5),d7
[00004c24] 0c47 005a                 cmpi.w     #$005A,d7
[00004c28] 620a                      bhi.s      _btol_21
[00004c2a] 7e20                      moveq.l    #32,d7
[00004c2c] 4286                      clr.l      d6
[00004c2e] 1c15                      move.b     (a5),d6
[00004c30] de86                      add.l      d6,d7
[00004c32] 6004                      bra.s      _btol_22
_btol_21:
[00004c34] 4287                      clr.l      d7
[00004c36] 1e15                      move.b     (a5),d7
_btol_22:
[00004c38] 0c87 0000 006c            cmpi.l     #$0000006C,d7
[00004c3e] 6600 0088                 bne        _btol_20
[00004c42] 528d                      addq.l     #1,a5
[00004c44] 6000 0082                 bra        _btol_20
_btol_16:
[00004c48] 4287                      clr.l      d7
[00004c4a] 1e15                      move.b     (a5),d7
[00004c4c] 0c47 0061                 cmpi.w     #$0061,d7
[00004c50] 652a                      bcs.s      _btol_23
[00004c52] 4287                      clr.l      d7
[00004c54] 1e15                      move.b     (a5),d7
[00004c56] 0c47 007a                 cmpi.w     #$007A,d7
[00004c5a] 6338                      bls.s      _btol_24
[00004c5c] 601e                      bra.s      _btol_23
_btol_17:
[00004c5e] 2eae fff8                 move.l     -8(a6),(a7)
[00004c62] 2f2e 0014                 move.l     20(a6),-(a7)
[00004c66] 4eb9 0000 4fd0            jsr        a.lmul
[00004c6c] 2e17                      move.l     (a7),d7
[00004c6e] de84                      add.l      d4,d7
[00004c70] 2d47 fff8                 move.l     d7,-8(a6)
[00004c74] 5385                      subq.l     #1,d5
[00004c76] 528d                      addq.l     #1,a5
[00004c78] 6000 ff56                 bra        _btol_7
_btol_23:
[00004c7c] 4287                      clr.l      d7
[00004c7e] 1e15                      move.b     (a5),d7
[00004c80] 0c47 0041                 cmpi.w     #$0041,d7
[00004c84] 6500 ff6e                 bcs        _btol_15
[00004c88] 4287                      clr.l      d7
[00004c8a] 1e15                      move.b     (a5),d7
[00004c8c] 0c47 005a                 cmpi.w     #$005A,d7
[00004c90] 6200 ff62                 bhi        _btol_15
_btol_24:
[00004c94] 4287                      clr.l      d7
[00004c96] 1e15                      move.b     (a5),d7
[00004c98] 0c47 0041                 cmpi.w     #$0041,d7
[00004c9c] 6514                      bcs.s      _btol_25
[00004c9e] 4287                      clr.l      d7
[00004ca0] 1e15                      move.b     (a5),d7
[00004ca2] 0c47 005a                 cmpi.w     #$005A,d7
[00004ca6] 620a                      bhi.s      _btol_25
[00004ca8] 7e20                      moveq.l    #32,d7
[00004caa] 4286                      clr.l      d6
[00004cac] 1c15                      move.b     (a5),d6
[00004cae] de86                      add.l      d6,d7
[00004cb0] 6004                      bra.s      _btol_26
_btol_25:
[00004cb2] 4287                      clr.l      d7
[00004cb4] 1e15                      move.b     (a5),d7
_btol_26:
[00004cb6] 7ca9                      moveq.l    #-87,d6
[00004cb8] dc87                      add.l      d7,d6
[00004cba] 2806                      move.l     d6,d4
[00004cbc] 2e2e 0014                 move.l     20(a6),d7
[00004cc0] be84                      cmp.l      d4,d7
[00004cc2] 6e9a                      bgt.s      _btol_17
[00004cc4] 6000 ff2e                 bra        _btol_15
_btol_20:
[00004cc8] 2e0d                      move.l     a5,d7
[00004cca] 9eae fff4                 sub.l      -12(a6),d7
[00004cce] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00004cd2] 4e5e                      unlk       a6
[00004cd4] 4e75                      rts

_close:
[00004cd6] 205f                      movea.l    (a7)+,a0
[00004cd8] 7e06                      moveq.l    #6,d7
[00004cda] 4e41                      trap       #1
[00004cdc] 4ed0                      jmp        (a0)

_cmpbuf:
[00004cde] 4e56 0000                 link       a6,#0
[00004ce2] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00004ce6] 2a6e 0008                 movea.l    8(a6),a5
[00004cea] 286e 000c                 movea.l    12(a6),a4
[00004cee] 2a2e 0010                 move.l     16(a6),d5
_cmpbuf_4:
[00004cf2] 4a85                      tst.l      d5
[00004cf4] 6710                      beq.s      _cmpbuf_1
[00004cf6] 4287                      clr.l      d7
[00004cf8] 1e1d                      move.b     (a5)+,d7
[00004cfa] 4286                      clr.l      d6
[00004cfc] 1c1c                      move.b     (a4)+,d6
[00004cfe] be86                      cmp.l      d6,d7
[00004d00] 670e                      beq.s      _cmpbuf_2
[00004d02] 4287                      clr.l      d7
[00004d04] 6002                      bra.s      _cmpbuf_3
_cmpbuf_1:
[00004d06] 7e01                      moveq.l    #1,d7
_cmpbuf_3:
[00004d08] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00004d0c] 4e5e                      unlk       a6
[00004d0e] 4e75                      rts
_cmpbuf_2:
[00004d10] 5385                      subq.l     #1,d5
[00004d12] 60de                      bra.s      _cmpbuf_4

_cpybuf:
[00004d14] 4e56 0000                 link       a6,#0
[00004d18] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00004d1c] 2a6e 0008                 movea.l    8(a6),a5
[00004d20] 286e 000c                 movea.l    12(a6),a4
[00004d24] 2a2e 0010                 move.l     16(a6),d5
_cpybuf_2:
[00004d28] 4a85                      tst.l      d5
[00004d2a] 6706                      beq.s      _cpybuf_1
[00004d2c] 1adc                      move.b     (a4)+,(a5)+
[00004d2e] 5385                      subq.l     #1,d5
[00004d30] 60f6                      bra.s      _cpybuf_2
_cpybuf_1:
[00004d32] 2e2e 0010                 move.l     16(a6),d7
[00004d36] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00004d3a] 4e5e                      unlk       a6
[00004d3c] 4e75                      rts

_creat:
[00004d3e] 205f                      movea.l    (a7)+,a0
[00004d40] 7e08                      moveq.l    #8,d7
[00004d42] 4e41                      trap       #1
[00004d44] 4ed0                      jmp        (a0)

a.1sub:
[00004d46] 4e56 ffdc                 link       a6,#-36
[00004d4a] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[00004d4e] 43d7                      lea.l      (a7),a1
[00004d50] 2008                      move.l     a0,d0
[00004d52] 6618                      bne.s      a.1sub_1
[00004d54] 41ef 0008                 lea.l      8(a7),a0
[00004d58] 6012                      bra.s      a.1sub_1
a.1sub_1: ; not found: 00004d6c

a.6sub:
[00004d5a] 4e56 ffdc                 link       a6,#-36
[00004d5e] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[00004d62] 43ef 0008                 lea.l      8(a7),a1
[00004d66] 2008                      move.l     a0,d0
[00004d68] 6602                      bne.s      a.6sub_1
[00004d6a] 41d7                      lea.l      (a7),a0
a.6sub_1:
[00004d6c] 2d50 ffdc                 move.l     (a0),-36(a6)
[00004d70] 6738                      beq.s      a.6sub_2
[00004d72] 086e 0007 ffdc            bchg       #7,-36(a6)
[00004d78] 2d68 0004 ffe0            move.l     4(a0),-32(a6)
[00004d7e] 41ee ffdc                 lea.l      -36(a6),a0
[00004d82] 6026                      bra.s      a.6sub_2
a.6sub_2: ; not found: 00004daa

a.1add:
[00004d84] 4e56 ffe4                 link       a6,#-28
[00004d88] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[00004d8c] 43d7                      lea.l      (a7),a1
[00004d8e] 2008                      move.l     a0,d0
[00004d90] 6618                      bne.s      a.1add_1
[00004d92] 41ef 0008                 lea.l      8(a7),a0
[00004d96] 6012                      bra.s      a.1add_1
a.1add_1: ; not found: 00004daa

a.6add:
[00004d98] 4e56 ffe4                 link       a6,#-28
[00004d9c] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[00004da0] 43ef 0008                 lea.l      8(a7),a1
[00004da4] 2008                      move.l     a0,d0
[00004da6] 6602                      bne.s      a.6add_1
[00004da8] 41d7                      lea.l      (a7),a0
a.6add_1:
[00004daa] 2d49 fffc                 move.l     a1,-4(a6)
[00004dae] 2d48 fff8                 move.l     a0,-8(a6)
[00004db2] 4850                      pea.l      (a0)
[00004db4] 486e ffe4                 pea.l      -28(a6)
[00004db8] 4eb9 0000 548c            jsr        a.unpk
[00004dbe] 508f                      addq.l     #8,a7
[00004dc0] 2d47 fff4                 move.l     d7,-12(a6)
[00004dc4] 6778                      beq.s      a.6add_2
[00004dc6] 2f2e fffc                 move.l     -4(a6),-(a7)
[00004dca] 486e ffec                 pea.l      -20(a6)
[00004dce] 4eb9 0000 548c            jsr        a.unpk
[00004dd4] 508f                      addq.l     #8,a7
[00004dd6] 4a87                      tst.l      d7
[00004dd8] 6606                      bne.s      a.6add_3
[00004dda] 206e fff8                 movea.l    -8(a6),a0
[00004dde] 6054                      bra.s      a.6add_4
a.6add_3:
[00004de0] 9eae fff4                 sub.l      -12(a6),d7
[00004de4] 672e                      beq.s      a.6add_5
[00004de6] 6e08                      bgt.s      a.6add_6
[00004de8] 4487                      neg.l      d7
[00004dea] 41ee ffec                 lea.l      -20(a6),a0
[00004dee] 6008                      bra.s      a.6add_7
a.6add_6:
[00004df0] dfae fff4                 add.l      d7,-12(a6)
[00004df4] 41ee ffe4                 lea.l      -28(a6),a0
a.6add_7:
[00004df8] 2218                      move.l     (a0)+,d1
[00004dfa] 2410                      move.l     (a0),d2
a.6add_10:
[00004dfc] e28a                      lsr.l      #1,d2
[00004dfe] 6404                      bcc.s      a.6add_8
[00004e00] 08c2 0000                 bset       #0,d2
a.6add_8:
[00004e04] e281                      asr.l      #1,d1
[00004e06] 6404                      bcc.s      a.6add_9
[00004e08] 08c2 001f                 bset       #31,d2
a.6add_9:
[00004e0c] 5387                      subq.l     #1,d7
[00004e0e] 6eec                      bgt.s      a.6add_10
[00004e10] 2082                      move.l     d2,(a0)
[00004e12] 2101                      move.l     d1,-(a0)
a.6add_5:
[00004e14] 41ee ffe8                 lea.l      -24(a6),a0
[00004e18] 43ee fff0                 lea.l      -16(a6),a1
[00004e1c] 2e10                      move.l     (a0),d7
[00004e1e] df91                      add.l      d7,(a1)
[00004e20] d388                      addx.l     -(a0),-(a1)
[00004e22] 2f2e fff4                 move.l     -12(a6),-(a7)
[00004e26] 4851                      pea.l      (a1)
[00004e28] 4eb9 0000 53f8            jsr        a.repk
[00004e2e] 508f                      addq.l     #8,a7
[00004e30] 41ee ffec                 lea.l      -20(a6),a0
a.6add_4:
[00004e34] 226e fffc                 movea.l    -4(a6),a1
[00004e38] 22d8                      move.l     (a0)+,(a1)+
[00004e3a] 2290                      move.l     (a0),(a1)
[00004e3c] 4aa1                      tst.l      -(a1)
a.6add_2:
[00004e3e] 4cdf 06c6                 movem.l    (a7)+,d1-d2/d6-d7/a1-a2
[00004e42] 4e5e                      unlk       a6
[00004e44] 4e75                      rts

_dtento:
[00004e46] 4e56 0000                 link       a6,#0
[00004e4a] 48e7 9c00                 movem.l    d0/d3-d5,-(a7)
[00004e4e] 2a2e 0010                 move.l     16(a6),d5
[00004e52] 4a85                      tst.l      d5
[00004e54] 6c48                      bge.s      _dtento_1
[00004e56] 2e05                      move.l     d5,d7
[00004e58] 4487                      neg.l      d7
[00004e5a] 2807                      move.l     d7,d4
[00004e5c] 7601                      moveq.l    #1,d3
_dtento_7:
[00004e5e] 4a84                      tst.l      d4
[00004e60] 6700 0090                 beq        _dtento_2
[00004e64] 3e39 0002 13fc            move.w     $0002694C,d7
[00004e6a] 48c7                      ext.l      d7
[00004e6c] b687                      cmp.l      d7,d3
[00004e6e] 6c00 0082                 bge        _dtento_2
[00004e72] 0804 0000                 btst       #0,d4
[00004e76] 6772                      beq.s      _dtento_3
[00004e78] 2c2e 0008                 move.l     8(a6),d6
[00004e7c] 2e2e 000c                 move.l     12(a6),d7
[00004e80] 2403                      move.l     d3,d2
[00004e82] e782                      asl.l      #3,d2
[00004e84] 2442                      movea.l    d2,a2
[00004e86] d5fc 0002 13a4            adda.l     #$000268F4,a2
[00004e8c] 41d2                      lea.l      (a2),a0
[00004e8e] 4eb9 0000 50ba            jsr        a.6div
[00004e94] 2d46 0008                 move.l     d6,8(a6)
[00004e98] 2d47 000c                 move.l     d7,12(a6)
[00004e9c] 604c                      bra.s      _dtento_3
_dtento_1:
[00004e9e] 4a85                      tst.l      d5
[00004ea0] 6f00 00ac                 ble        _dtento_4
[00004ea4] 2805                      move.l     d5,d4
[00004ea6] 7601                      moveq.l    #1,d3
_dtento_8:
[00004ea8] 4a84                      tst.l      d4
[00004eaa] 6700 00ba                 beq        _dtento_5
[00004eae] 3e39 0002 13fc            move.w     $0002694C,d7
[00004eb4] 48c7                      ext.l      d7
[00004eb6] b687                      cmp.l      d7,d3
[00004eb8] 6c00 00ac                 bge        _dtento_5
[00004ebc] 0804 0000                 btst       #0,d4
[00004ec0] 6700 009c                 beq        _dtento_6
[00004ec4] 2e03                      move.l     d3,d7
[00004ec6] e787                      asl.l      #3,d7
[00004ec8] 2447                      movea.l    d7,a2
[00004eca] d5fc 0002 13a4            adda.l     #$000268F4,a2
[00004ed0] 2c12                      move.l     (a2),d6
[00004ed2] 2e2a 0004                 move.l     4(a2),d7
[00004ed6] 41ee 0008                 lea.l      8(a6),a0
[00004eda] 4eb9 0000 51da            jsr        a.6mul
[00004ee0] 2d46 0008                 move.l     d6,8(a6)
[00004ee4] 2d47 000c                 move.l     d7,12(a6)
[00004ee8] 6074                      bra.s      _dtento_6
_dtento_3:
[00004eea] e28c                      lsr.l      #1,d4
[00004eec] 5283                      addq.l     #1,d3
[00004eee] 6000 ff6e                 bra        _dtento_7
_dtento_2:
[00004ef2] 4a84                      tst.l      d4
[00004ef4] 6758                      beq.s      _dtento_4
[00004ef6] 2c2e 0008                 move.l     8(a6),d6
[00004efa] 2e2e 000c                 move.l     12(a6),d7
[00004efe] 3439 0002 13fc            move.w     $0002694C,d2
[00004f04] 48c2                      ext.l      d2
[00004f06] e782                      asl.l      #3,d2
[00004f08] 2442                      movea.l    d2,a2
[00004f0a] d5fc 0002 139c            adda.l     #$000268EC,a2
[00004f10] 41d2                      lea.l      (a2),a0
[00004f12] 4eb9 0000 50ba            jsr        a.6div
[00004f18] 2d46 0008                 move.l     d6,8(a6)
[00004f1c] 2d47 000c                 move.l     d7,12(a6)
[00004f20] 2c2e 0008                 move.l     8(a6),d6
[00004f24] 2e2e 000c                 move.l     12(a6),d7
[00004f28] 3439 0002 13fc            move.w     $0002694C,d2
[00004f2e] 48c2                      ext.l      d2
[00004f30] e782                      asl.l      #3,d2
[00004f32] 2442                      movea.l    d2,a2
[00004f34] d5fc 0002 139c            adda.l     #$000268EC,a2
[00004f3a] 41d2                      lea.l      (a2),a0
[00004f3c] 4eb9 0000 50ba            jsr        a.6div
[00004f42] 2d46 0008                 move.l     d6,8(a6)
[00004f46] 2d47 000c                 move.l     d7,12(a6)
[00004f4a] 5384                      subq.l     #1,d4
[00004f4c] 60a4                      bra.s      _dtento_2
_dtento_4:
[00004f4e] 2c2e 0008                 move.l     8(a6),d6
[00004f52] 2e2e 000c                 move.l     12(a6),d7
[00004f56] 4cdf 0039                 movem.l    (a7)+,d0/d3-d5
[00004f5a] 4e5e                      unlk       a6
[00004f5c] 4e75                      rts
_dtento_6:
[00004f5e] e28c                      lsr.l      #1,d4
[00004f60] 5283                      addq.l     #1,d3
[00004f62] 6000 ff44                 bra        _dtento_8
_dtento_5:
[00004f66] 4a84                      tst.l      d4
[00004f68] 67e4                      beq.s      _dtento_4
[00004f6a] 3e39 0002 13fc            move.w     $0002694C,d7
[00004f70] 48c7                      ext.l      d7
[00004f72] e787                      asl.l      #3,d7
[00004f74] 2447                      movea.l    d7,a2
[00004f76] d5fc 0002 139c            adda.l     #$000268EC,a2
[00004f7c] 2c12                      move.l     (a2),d6
[00004f7e] 2e2a 0004                 move.l     4(a2),d7
[00004f82] 41ee 0008                 lea.l      8(a6),a0
[00004f86] 4eb9 0000 51da            jsr        a.6mul
[00004f8c] 2d46 0008                 move.l     d6,8(a6)
[00004f90] 2d47 000c                 move.l     d7,12(a6)
[00004f94] 3e39 0002 13fc            move.w     $0002694C,d7
[00004f9a] 48c7                      ext.l      d7
[00004f9c] e787                      asl.l      #3,d7
[00004f9e] 2447                      movea.l    d7,a2
[00004fa0] d5fc 0002 139c            adda.l     #$000268EC,a2
[00004fa6] 2c12                      move.l     (a2),d6
[00004fa8] 2e2a 0004                 move.l     4(a2),d7
[00004fac] 41ee 0008                 lea.l      8(a6),a0
[00004fb0] 4eb9 0000 51da            jsr        a.6mul
[00004fb6] 2d46 0008                 move.l     d6,8(a6)
[00004fba] 2d47 000c                 move.l     d7,12(a6)
[00004fbe] 5384                      subq.l     #1,d4
[00004fc0] 60a4                      bra.s      _dtento_5

_fstat:
[00004fc2] 205f                      movea.l    (a7)+,a0
[00004fc4] 7e1c                      moveq.l    #28,d7
[00004fc6] 4e41                      trap       #1
[00004fc8] 4ed0                      jmp        (a0)

_getpid:
[00004fca] 7e14                      moveq.l    #20,d7
[00004fcc] 4e41                      trap       #1
[00004fce] 4e75                      rts

a.lmul:
[00004fd0] 302f 0008                 move.w     8(a7),d0
[00004fd4] c0ef 0006                 mulu.w     6(a7),d0
[00004fd8] 3f40 0008                 move.w     d0,8(a7)
[00004fdc] 302f 000a                 move.w     10(a7),d0
[00004fe0] c0ef 0004                 mulu.w     4(a7),d0
[00004fe4] d16f 0008                 add.w      d0,8(a7)
[00004fe8] 302f 000a                 move.w     10(a7),d0
[00004fec] c0ef 0006                 mulu.w     6(a7),d0
[00004ff0] 426f 000a                 clr.w      10(a7)
[00004ff4] 2e9f                      move.l     (a7)+,(a7)
[00004ff6] d1af 0004                 add.l      d0,4(a7)
[00004ffa] 4e75                      rts

a.1ltd:
[00004ffc] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[00005000] 41d7                      lea.l      (a7),a0
[00005002] 6008                      bra.s      a.1ltd_1
a.1ltd_1: ; not found: 0000500c

a.6ltd:
[00005004] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[00005008] 41ef 0008                 lea.l      8(a7),a0
[0000500c] 4290                      clr.l      (a0)
[0000500e] 2140 0004                 move.l     d0,4(a0)
[00005012] 6c02                      bge.s      a.6ltd_1
[00005014] 5390                      subq.l     #1,(a0)
a.6ltd_1:
[00005016] 4878 0436                 pea.l      ($00000436).w
[0000501a] 4850                      pea.l      (a0)
[0000501c] 4eb9 0000 53f8            jsr        a.repk
[00005022] 4fef 0008                 lea.l      8(a7),a7
[00005026] 4cdf 06c6                 movem.l    (a7)+,d1-d2/d6-d7/a1-a2
[0000502a] 4e75                      rts

_putstr:
[0000502c] 4e56 0000                 link       a6,#0
[00005030] 48e7 8004                 movem.l    d0/a5,-(a7)
[00005034] 45ee 000c                 lea.l      12(a6),a2
[00005038] 2a4a                      movea.l    a2,a5
_putstr_2:
[0000503a] 4a95                      tst.l      (a5)
[0000503c] 671c                      beq.s      _putstr_1
[0000503e] 2e95                      move.l     (a5),(a7)
[00005040] 4eb9 0000 52f4            jsr        _lenstr
[00005046] 2e87                      move.l     d7,(a7)
[00005048] 2f15                      move.l     (a5),-(a7)
[0000504a] 2f2e 0008                 move.l     8(a6),-(a7)
[0000504e] 4eb9 0000 52ba            jsr        _fwrite
[00005054] 508f                      addq.l     #8,a7
[00005056] 588d                      addq.l     #4,a5
[00005058] 60e0                      bra.s      _putstr_2
_putstr_1:
[0000505a] 4cdf 2001                 movem.l    (a7)+,d0/a5
[0000505e] 4e5e                      unlk       a6
[00005060] 4e75                      rts

_sbreak:
[00005062] 205f                      movea.l    (a7)+,a0
[00005064] 2e17                      move.l     (a7),d7
[00005066] 5287                      addq.l     #1,d7
[00005068] 0887 0000                 bclr       #0,d7
[0000506c] deb9 0002 139c            add.l      $000268EC,d7
[00005072] 2f07                      move.l     d7,-(a7)
[00005074] 7e11                      moveq.l    #17,d7
[00005076] 4e41                      trap       #1
[00005078] 0c87 ffff ffff            cmpi.l     #$FFFFFFFF,d7
[0000507e] 6606                      bne.s      _sbreak_1
[00005080] 4a9f                      tst.l      (a7)+
[00005082] 4287                      clr.l      d7
[00005084] 4ed0                      jmp        (a0)
_sbreak_1:
[00005086] 2e39 0002 139c            move.l     $000268EC,d7
[0000508c] 23df 0002 139c            move.l     (a7)+,$000268EC
[00005092] 4ab9 0002 13a0            tst.l      $000268F0
[00005098] 670a                      beq.s      _sbreak_2
[0000509a] 23f9 0002 139c 0002 13a0  move.l     $000268EC,$000268F0
_sbreak_2:
[000050a4] 4ed0                      jmp        (a0)

a.1div:
[000050a6] 4e56 ffde                 link       a6,#-34
[000050aa] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[000050ae] 43d7                      lea.l      (a7),a1
[000050b0] 2008                      move.l     a0,d0
[000050b2] 6618                      bne.s      a.1div_1
[000050b4] 41ef 0008                 lea.l      8(a7),a0
[000050b8] 6012                      bra.s      a.1div_1
a.1div_1: ; not found: 000050cc

a.6div:
[000050ba] 4e56 ffda                 link       a6,#-38
[000050be] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[000050c2] 43ef 0008                 lea.l      8(a7),a1
[000050c6] 2008                      move.l     a0,d0
[000050c8] 6602                      bne.s      a.6div_1
[000050ca] 41d7                      lea.l      (a7),a0
a.6div_1:
[000050cc] 2d49 fffc                 move.l     a1,-4(a6)
[000050d0] 422e ffdf                 clr.b      -33(a6)
[000050d4] 4850                      pea.l      (a0)
[000050d6] 486e ffe8                 pea.l      -24(a6)
[000050da] 4eb9 0000 548c            jsr        a.unpk
[000050e0] 508f                      addq.l     #8,a7
[000050e2] 226e fffc                 movea.l    -4(a6),a1
[000050e6] 2d47 fff8                 move.l     d7,-8(a6)
[000050ea] 6618                      bne.s      a.6div_2
[000050ec] 70ff                      moveq.l    #-1,d0
[000050ee] 2280                      move.l     d0,(a1)
[000050f0] 2340 0004                 move.l     d0,4(a1)
[000050f4] 4a2e ffe8                 tst.b      -24(a6)
[000050f8] 6d00 00c4                 blt        a.6div_3
[000050fc] 0a11 0080                 eori.b     #$80,(a1)
[00005100] 6000 00bc                 bra        a.6div_3
a.6div_2:
[00005104] 4a2e ffe8                 tst.b      -24(a6)
[00005108] 6c0c                      bge.s      a.6div_4
[0000510a] 44ae ffec                 neg.l      -20(a6)
[0000510e] 40ae ffe8                 negx.l     -24(a6)
[00005112] 462e ffdf                 not.b      -33(a6)
a.6div_4:
[00005116] 4a11                      tst.b      (a1)
[00005118] 6c08                      bge.s      a.6div_5
[0000511a] 0891 0007                 bclr       #7,(a1)
[0000511e] 462e ffdf                 not.b      -33(a6)
a.6div_5:
[00005122] 4851                      pea.l      (a1)
[00005124] 486e fff0                 pea.l      -16(a6)
[00005128] 4eb9 0000 548c            jsr        a.unpk
[0000512e] 508f                      addq.l     #8,a7
[00005130] 4a87                      tst.l      d7
[00005132] 6700 008a                 beq        a.6div_3
[00005136] 9eae fff8                 sub.l      -8(a6),d7
[0000513a] 0687 0000 03fe            addi.l     #$000003FE,d7
[00005140] 2d47 fff8                 move.l     d7,-8(a6)
[00005144] 42ae ffe0                 clr.l      -32(a6)
[00005148] 42ae ffe4                 clr.l      -28(a6)
[0000514c] 7038                      moveq.l    #56,d0
[0000514e] 2c2e ffe8                 move.l     -24(a6),d6
[00005152] 2e2e ffec                 move.l     -20(a6),d7
a.6div_9:
[00005156] 41ee ffe4                 lea.l      -28(a6),a0
[0000515a] 2248                      movea.l    a0,a1
[0000515c] 2210                      move.l     (a0),d1
[0000515e] d391                      add.l      d1,(a1)
[00005160] d388                      addx.l     -(a0),-(a1)
[00005162] bcae fff0                 cmp.l      -16(a6),d6
[00005166] 6604                      bne.s      a.6div_6
[00005168] beae fff4                 cmp.l      -12(a6),d7
a.6div_6:
[0000516c] 6212                      bhi.s      a.6div_7
[0000516e] 222e fff0                 move.l     -16(a6),d1
[00005172] 9fae fff4                 sub.l      d7,-12(a6)
[00005176] 9386                      subx.l     d6,d1
[00005178] 2d41 fff0                 move.l     d1,-16(a6)
[0000517c] 522e ffe7                 addq.b     #1,-25(a6)
a.6div_7:
[00005180] e28f                      lsr.l      #1,d7
[00005182] e28e                      lsr.l      #1,d6
[00005184] 6404                      bcc.s      a.6div_8
[00005186] 08c7 001f                 bset       #31,d7
a.6div_8:
[0000518a] 51c8 ffca                 dbf        d0,a.6div_9
[0000518e] 2f2e fff8                 move.l     -8(a6),-(a7)
[00005192] 486e ffe0                 pea.l      -32(a6)
[00005196] 4eb9 0000 53f8            jsr        a.repk
[0000519c] 508f                      addq.l     #8,a7
[0000519e] 4aae ffe0                 tst.l      -32(a6)
[000051a2] 670c                      beq.s      a.6div_10
[000051a4] 4a2e ffdf                 tst.b      -33(a6)
[000051a8] 6706                      beq.s      a.6div_10
[000051aa] 086e 0007 ffe0            bchg       #7,-32(a6)
a.6div_10:
[000051b0] 226e fffc                 movea.l    -4(a6),a1
[000051b4] 22ee ffe0                 move.l     -32(a6),(a1)+
[000051b8] 22ae ffe4                 move.l     -28(a6),(a1)
[000051bc] 4aa1                      tst.l      -(a1)
a.6div_3:
[000051be] 4cdf 06c6                 movem.l    (a7)+,d1-d2/d6-d7/a1-a2
[000051c2] 4e5e                      unlk       a6
[000051c4] 4e75                      rts

a.1mul:
[000051c6] 4e56 ffda                 link       a6,#-38
[000051ca] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[000051ce] 43d7                      lea.l      (a7),a1
[000051d0] 2008                      move.l     a0,d0
[000051d2] 6618                      bne.s      a.1mul_1
[000051d4] 41ef 0008                 lea.l      8(a7),a0
[000051d8] 6012                      bra.s      a.1mul_1
a.1mul_1: ; not found: 000051ec

a.6mul:
[000051da] 4e56 ffda                 link       a6,#-38
[000051de] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[000051e2] 43ef 0008                 lea.l      8(a7),a1
[000051e6] 2008                      move.l     a0,d0
[000051e8] 6602                      bne.s      a.6mul_1
[000051ea] 41d7                      lea.l      (a7),a0
a.6mul_1:
[000051ec] 2d49 fffc                 move.l     a1,-4(a6)
[000051f0] 2d48 fff8                 move.l     a0,-8(a6)
[000051f4] 422e ffdb                 clr.b      -37(a6)
[000051f8] 4a91                      tst.l      (a1)
[000051fa] 6c08                      bge.s      a.6mul_2
[000051fc] 0851 0007                 bchg       #7,(a1)
[00005200] 462e ffdb                 not.b      -37(a6)
a.6mul_2:
[00005204] 4851                      pea.l      (a1)
[00005206] 486e ffec                 pea.l      -20(a6)
[0000520a] 4eb9 0000 548c            jsr        a.unpk
[00005210] 508f                      addq.l     #8,a7
[00005212] 2d47 fff4                 move.l     d7,-12(a6)
[00005216] 6700 009a                 beq        a.6mul_3
[0000521a] 2f2e fff8                 move.l     -8(a6),-(a7)
[0000521e] 486e ffe4                 pea.l      -28(a6)
[00005222] 4eb9 0000 548c            jsr        a.unpk
[00005228] 508f                      addq.l     #8,a7
[0000522a] 4a87                      tst.l      d7
[0000522c] 660a                      bne.s      a.6mul_4
[0000522e] 206e fffc                 movea.l    -4(a6),a0
[00005232] 4298                      clr.l      (a0)+
[00005234] 4290                      clr.l      (a0)
[00005236] 607a                      bra.s      a.6mul_3
a.6mul_4:
[00005238] 0487 0000 03fe            subi.l     #$000003FE,d7
[0000523e] dfae fff4                 add.l      d7,-12(a6)
[00005242] 42ae ffdc                 clr.l      -36(a6)
[00005246] 42ae ffe0                 clr.l      -32(a6)
[0000524a] 7037                      moveq.l    #55,d0
[0000524c] 2c2e ffe4                 move.l     -28(a6),d6
[00005250] 2e2e ffe8                 move.l     -24(a6),d7
a.6mul_7:
[00005254] e28f                      lsr.l      #1,d7
[00005256] e286                      asr.l      #1,d6
[00005258] 6404                      bcc.s      a.6mul_5
[0000525a] 08c7 001f                 bset       #31,d7
a.6mul_5:
[0000525e] 4a2e ffed                 tst.b      -19(a6)
[00005262] 6c0e                      bge.s      a.6mul_6
[00005264] 222e ffdc                 move.l     -36(a6),d1
[00005268] dfae ffe0                 add.l      d7,-32(a6)
[0000526c] d386                      addx.l     d6,d1
[0000526e] 2d41 ffdc                 move.l     d1,-36(a6)
a.6mul_6:
[00005272] 41ee fff0                 lea.l      -16(a6),a0
[00005276] 2248                      movea.l    a0,a1
[00005278] 2210                      move.l     (a0),d1
[0000527a] d391                      add.l      d1,(a1)
[0000527c] d388                      addx.l     -(a0),-(a1)
[0000527e] 51c8 ffd4                 dbf        d0,a.6mul_7
[00005282] 2f2e fff4                 move.l     -12(a6),-(a7)
[00005286] 486e ffdc                 pea.l      -36(a6)
[0000528a] 4eb9 0000 53f8            jsr        a.repk
[00005290] 508f                      addq.l     #8,a7
[00005292] 4a6e ffdc                 tst.w      -36(a6)
[00005296] 670c                      beq.s      a.6mul_8
[00005298] 4a2e ffdb                 tst.b      -37(a6)
[0000529c] 6706                      beq.s      a.6mul_8
[0000529e] 086e 0007 ffdc            bchg       #7,-36(a6)
a.6mul_8:
[000052a4] 226e fffc                 movea.l    -4(a6),a1
[000052a8] 22ee ffdc                 move.l     -36(a6),(a1)+
[000052ac] 22ae ffe0                 move.l     -32(a6),(a1)
[000052b0] 4aa1                      tst.l      -(a1)
a.6mul_3:
[000052b2] 4cdf 06c6                 movem.l    (a7)+,d1-d2/d6-d7/a1-a2
[000052b6] 4e5e                      unlk       a6
[000052b8] 4e75                      rts

_fwrite:
[000052ba] 4e56 0000                 link       a6,#0
[000052be] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[000052c2] 2eae 0010                 move.l     16(a6),(a7)
[000052c6] 2f2e 000c                 move.l     12(a6),-(a7)
[000052ca] 2f2e 0008                 move.l     8(a6),-(a7)
[000052ce] 4eb9 0000 5548            jsr        _write
[000052d4] 508f                      addq.l     #8,a7
[000052d6] beae 0010                 cmp.l      16(a6),d7
[000052da] 6710                      beq.s      _fwrite_1
[000052dc] 2ebc 0002 141a            move.l     #$0002696A,(a7)
[000052e2] 42a7                      clr.l      -(a7)
[000052e4] 4eb9 0000 5316            jsr        __raise
[000052ea] 588f                      addq.l     #4,a7
_fwrite_1:
[000052ec] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[000052f0] 4e5e                      unlk       a6
[000052f2] 4e75                      rts

_lenstr:
[000052f4] 4e56 0000                 link       a6,#0
[000052f8] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000052fc] 2a6e 0008                 movea.l    8(a6),a5
[00005300] 284d                      movea.l    a5,a4
_lenstr_2:
[00005302] 4a14                      tst.b      (a4)
[00005304] 6704                      beq.s      _lenstr_1
[00005306] 528c                      addq.l     #1,a4
[00005308] 60f8                      bra.s      _lenstr_2
_lenstr_1:
[0000530a] 2e0c                      move.l     a4,d7
[0000530c] 9e8d                      sub.l      a5,d7
[0000530e] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00005312] 4e5e                      unlk       a6
[00005314] 4e75                      rts

__raise:
[00005316] 246f 0004                 movea.l    4(a7),a2
[0000531a] 262f 0008                 move.l     8(a7),d3
[0000531e] 2803                      move.l     d3,d4
[00005320] 670c                      beq.s      __raise_1
[00005322] 280a                      move.l     a2,d4
[00005324] 0c83 ffff ffff            cmpi.l     #$FFFFFFFF,d3
[0000532a] 6602                      bne.s      __raise_1
[0000532c] 4283                      clr.l      d3
__raise_1:
[0000532e] 200a                      move.l     a2,d0
[00005330] 6708                      beq.s      __raise_2
[00005332] b5fc ffff ffff            cmpa.l     #$FFFFFFFF,a2
[00005338] 660a                      bne.s      __raise_3
__raise_2:
[0000533a] 2479 0002 13fe            movea.l    $0002694E,a2
[00005340] 200a                      move.l     a2,d0
[00005342] 674e                      beq.s      __raise_4
__raise_3:
[00005344] 4a83                      tst.l      d3
[00005346] 6626                      bne.s      __raise_5
[00005348] 4287                      clr.l      d7
__raise_12:
[0000534a] 2e4a                      movea.l    a2,a7
[0000534c] 4a84                      tst.l      d4
[0000534e] 6600 0096                 bne        __raise_6
[00005352] 202a 0028                 move.l     40(a2),d0
[00005356] 6704                      beq.s      __raise_7
[00005358] 2040                      movea.l    d0,a0
[0000535a] 2083                      move.l     d3,(a0)
__raise_7:
[0000535c] 23df 0002 13fe            move.l     (a7)+,$0002694E
[00005362] 4cdf 783a                 movem.l    (a7)+,d1/d3-d5/a3-a6
[00005366] 4e75                      rts
__raise_8:
[00005368] 2452                      movea.l    (a2),a2
[0000536a] 200a                      move.l     a2,d0
[0000536c] 6724                      beq.s      __raise_4
__raise_5:
[0000536e] 41ea 002c                 lea.l      44(a2),a0
[00005372] 2e08                      move.l     a0,d7
__raise_11:
[00005374] 0c90 ffff ffff            cmpi.l     #$FFFFFFFF,(a0)
[0000537a] 67ec                      beq.s      __raise_8
[0000537c] 4a98                      tst.l      (a0)+
[0000537e] 6604                      bne.s      __raise_9
[00005380] 4284                      clr.l      d4
[00005382] 6006                      bra.s      __raise_10
__raise_9:
[00005384] b6a8 fffc                 cmp.l      -4(a0),d3
[00005388] 66ea                      bne.s      __raise_11
__raise_10:
[0000538a] 9e88                      sub.l      a0,d7
[0000538c] 4487                      neg.l      d7
[0000538e] e487                      asr.l      #2,d7
[00005390] 60b8                      bra.s      __raise_12
__raise_4:
[00005392] 42a7                      clr.l      -(a7)
[00005394] 4a83                      tst.l      d3
[00005396] 6706                      beq.s      __raise_13
[00005398] 0803 0000                 btst       #0,d3
[0000539c] 6706                      beq.s      __raise_14
__raise_13:
[0000539e] 263c 0002 1402            move.l     #$00026952,d3
__raise_14:
[000053a4] 2043                      movea.l    d3,a0
[000053a6] 2f10                      move.l     (a0),-(a7)
[000053a8] 4eb9 0000 550a            jsr        _error
__raise_15:
[000053ae] 4e71                      nop
[000053b0] 60fc                      bra.s      __raise_15
__raise_6: ; not found: 000053e6

__when:
[000053b2] 2039 0002 13fe            move.l     $0002694E,d0
[000053b8] 720c                      moveq.l    #12,d1
[000053ba] 48e7 dc1e                 movem.l    d0-d1/d3-d5/a3-a6,-(a7)
[000053be] 244f                      movea.l    a7,a2
[000053c0] 202a 0028                 move.l     40(a2),d0
[000053c4] 6704                      beq.s      __when_1
[000053c6] 2040                      movea.l    d0,a0
[000053c8] 208a                      move.l     a2,(a0)
__when_1:
[000053ca] 41ea 002c                 lea.l      44(a2),a0
__when_3:
[000053ce] 4a90                      tst.l      (a0)
[000053d0] 6712                      beq.s      __when_2
[000053d2] 0c98 ffff ffff            cmpi.l     #$FFFFFFFF,(a0)+
[000053d8] 670a                      beq.s      __when_2
[000053da] 06aa 0000 0004 0004       addi.l     #$00000004,4(a2)
[000053e2] 60ea                      bra.s      __when_3
__when_2:
[000053e4] 7eff                      moveq.l    #-1,d7
[000053e6] 23ca 0002 13fe            move.l     a2,$0002694E
[000053ec] 206a 0024                 movea.l    36(a2),a0
[000053f0] 4cd2 783b                 movem.l    (a2),d0-d1/d3-d5/a3-a6
[000053f4] 9fc1                      suba.l     d1,a7
[000053f6] 4ed0                      jmp        (a0)

a.repk:
[000053f8] 206f 0004                 movea.l    4(a7),a0
[000053fc] 4280                      clr.l      d0
[000053fe] 2428 0004                 move.l     4(a0),d2
[00005402] 2210                      move.l     (a0),d1
[00005404] 6c08                      bge.s      a.repk_1
[00005406] 08c0 001f                 bset       #31,d0
[0000540a] 4482                      neg.l      d2
[0000540c] 4081                      negx.l     d1
a.repk_1:
[0000540e] 6606                      bne.s      a.repk_2
[00005410] 4a82                      tst.l      d2
[00005412] 6602                      bne.s      a.repk_2
[00005414] 4e75                      rts
a.repk_2:
[00005416] 2e2f 0008                 move.l     8(a7),d7
[0000541a] 5587                      subq.l     #2,d7
a.repk_4:
[0000541c] 0c81 0040 0000            cmpi.l     #$00400000,d1
[00005422] 650e                      bcs.s      a.repk_3
[00005424] 5287                      addq.l     #1,d7
[00005426] e28a                      lsr.l      #1,d2
[00005428] e281                      asr.l      #1,d1
[0000542a] 64f0                      bcc.s      a.repk_4
[0000542c] 08c2 001f                 bset       #31,d2
[00005430] 60ea                      bra.s      a.repk_4
a.repk_3:
[00005432] 0c81 0020 0000            cmpi.l     #$00200000,d1
[00005438] 640c                      bcc.s      a.repk_5
[0000543a] 5387                      subq.l     #1,d7
[0000543c] e389                      lsl.l      #1,d1
[0000543e] e38a                      lsl.l      #1,d2
[00005440] 64f0                      bcc.s      a.repk_3
[00005442] 5281                      addq.l     #1,d1
[00005444] 60ec                      bra.s      a.repk_3
a.repk_5:
[00005446] 0802 0000                 btst       #0,d2
[0000544a] 6708                      beq.s      a.repk_6
[0000544c] 5282                      addq.l     #1,d2
[0000544e] 6404                      bcc.s      a.repk_6
[00005450] 5281                      addq.l     #1,d1
[00005452] 60c8                      bra.s      a.repk_4
a.repk_6:
[00005454] e28a                      lsr.l      #1,d2
[00005456] e281                      asr.l      #1,d1
[00005458] 6404                      bcc.s      a.repk_7
[0000545a] 08c2 001f                 bset       #31,d2
a.repk_7:
[0000545e] 4a87                      tst.l      d7
[00005460] 6e06                      bgt.s      a.repk_8
[00005462] 4298                      clr.l      (a0)+
[00005464] 4290                      clr.l      (a0)
[00005466] 4e75                      rts
a.repk_8:
[00005468] 0c47 07ff                 cmpi.w     #$07FF,d7
[0000546c] 6f0c                      ble.s      a.repk_9
[0000546e] 72ff                      moveq.l    #-1,d1
[00005470] 74ff                      moveq.l    #-1,d2
[00005472] 3e3c 07ff                 move.w     #$07FF,d7
[00005476] 0881 001f                 bclr       #31,d1
a.repk_9:
[0000547a] 2081                      move.l     d1,(a0)
[0000547c] 0250 000f                 andi.w     #$000F,(a0)
[00005480] e94f                      lsl.w      #4,d7
[00005482] 8f50                      or.w       d7,(a0)
[00005484] 2142 0004                 move.l     d2,4(a0)
[00005488] 8190                      or.l       d0,(a0)
[0000548a] 4e75                      rts

a.unpk:
[0000548c] 4cd7 0301                 movem.l    (a7),d0/a0-a1
[00005490] 3e11                      move.w     (a1),d7
[00005492] e88f                      lsr.l      #4,d7
[00005494] 0287 0000 07ff            andi.l     #$000007FF,d7
[0000549a] 6606                      bne.s      a.unpk_1
[0000549c] 4298                      clr.l      (a0)+
[0000549e] 4290                      clr.l      (a0)
[000054a0] 4e75                      rts
a.unpk_1:
[000054a2] 2219                      move.l     (a1)+,d1
[000054a4] 2411                      move.l     (a1),d2
[000054a6] 0281 000f ffff            andi.l     #$000FFFFF,d1
[000054ac] 0081 0010 0000            ori.l      #$00100000,d1
[000054b2] 7002                      moveq.l    #2,d0
a.unpk_3:
[000054b4] e389                      lsl.l      #1,d1
[000054b6] e38a                      lsl.l      #1,d2
[000054b8] 6402                      bcc.s      a.unpk_2
[000054ba] 5281                      addq.l     #1,d1
a.unpk_2:
[000054bc] 51c8 fff6                 dbf        d0,a.unpk_3
[000054c0] 4aa1                      tst.l      -(a1)
[000054c2] 6c04                      bge.s      a.unpk_4
[000054c4] 4482                      neg.l      d2
[000054c6] 4081                      negx.l     d1
a.unpk_4:
[000054c8] 20c1                      move.l     d1,(a0)+
[000054ca] 2082                      move.l     d2,(a0)
[000054cc] 4e75                      rts

x54ce:
[000054ce] 4e56 0000                 link       a6,#0
[000054d2] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000054d6] 2a6e 0008                 movea.l    8(a6),a5
[000054da] 2e0d                      move.l     a5,d7
[000054dc] 670e                      beq.s      x54ce_1
[000054de] 4a15                      tst.b      (a5)
[000054e0] 670a                      beq.s      x54ce_1
[000054e2] 284d                      movea.l    a5,a4
x54ce_3:
[000054e4] 4a14                      tst.b      (a4)
[000054e6] 670c                      beq.s      x54ce_2
[000054e8] 528c                      addq.l     #1,a4
[000054ea] 60f8                      bra.s      x54ce_3
x54ce_1:
[000054ec] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000054f0] 4e5e                      unlk       a6
[000054f2] 4e75                      rts
x54ce_2:
[000054f4] 2e0c                      move.l     a4,d7
[000054f6] 9e8d                      sub.l      a5,d7
[000054f8] 2e87                      move.l     d7,(a7)
[000054fa] 2f0d                      move.l     a5,-(a7)
[000054fc] 4878 0002                 pea.l      ($00000002).w
[00005500] 4eb9 0000 5548            jsr        _write
[00005506] 508f                      addq.l     #8,a7
[00005508] 60e2                      bra.s      x54ce_1

_error:
[0000550a] 4e56 fffc                 link       a6,#-4
[0000550e] 2eb9 0002 0a4e            move.l     $00025F9E,(a7)
[00005514] 4eba ffb8                 jsr        $000054CE(pc)
[00005518] 2ebc 0002 142c            move.l     #$0002697C,(a7)
[0000551e] 4eba ffae                 jsr        $000054CE(pc)
[00005522] 2eae 0008                 move.l     8(a6),(a7)
[00005526] 4eba ffa6                 jsr        $000054CE(pc)
[0000552a] 2eae 000c                 move.l     12(a6),(a7)
[0000552e] 4eba ff9e                 jsr        $000054CE(pc)
[00005532] 2ebc 0002 142a            move.l     #$0002697A,(a7)
[00005538] 4eba ff94                 jsr        $000054CE(pc)
[0000553c] 4297                      clr.l      (a7)
[0000553e] 4eb9 0000 0080            jsr        _exit
[00005544] 4e5e                      unlk       a6
[00005546] 4e75                      rts

_write:
[00005548] 205f                      movea.l    (a7)+,a0
[0000554a] 7e04                      moveq.l    #4,d7
[0000554c] 4e41                      trap       #1
[0000554e] 4ed0                      jmp        (a0)

	.data
__data:
[00005550]                           dc.b $00
[00005551]                           dc.b 'idr68k Edition 3.0: Copyright (c) 1981,1983,1985 by Whitesmiths, Ltd. all rights reserved',0
[000055ab]                           dc.b '|/bin/|/usr/bin/',0
[000055bc]                           dc.b 'PATH',0
[000055c1]                           dc.b $00
_environ:
[000055c2]                           dc.b $00
[000055c3]                           dc.b $00
[000055c4]                           dc.b $00
[000055c5]                           dc.b $00
_errno:
[000055c6]                           dc.b $00
[000055c7]                           dc.b $00
[000055c8]                           dc.b $00
[000055c9]                           dc.b $00
__paths:
[000055ca] 0002005b                  dc.l $0002005b ; no symbol found
[000055ce] 000000aa                  dc.l _onexit
_bltintab:
[000055d2] 000200bf                  dc.l $000200bf ; no symbol found
[000055d6]                           dc.b $00
[000055d7]                           dc.b $00
[000055d8]                           dc.b $00
[000055d9]                           dc.b $1e
[000055da] 000200b6                  dc.l $000200b6 ; no symbol found
[000055de]                           dc.b $00
[000055df]                           dc.b $00
[000055e0]                           dc.b $00
[000055e1]                           dc.b $21
[000055e2] 000200ac                  dc.l $000200ac ; no symbol found
[000055e6]                           dc.b $00
[000055e7]                           dc.b $00
[000055e8]                           dc.b $00
[000055e9]                           dc.b $1f
[000055ea] 000200a2                  dc.l $000200a2 ; no symbol found
[000055ee]                           dc.b $00
[000055ef]                           dc.b $00
[000055f0]                           dc.b $00
[000055f1]                           dc.b $20
[000055f2]                           dc.w $085f
[000055f4]                           dc.b '_LINE__',0
[000055fc]                           dc.w $085f
[000055fe]                           dc.b '_FILE__',0
[00005606]                           dc.w $0764
[00005608]                           dc.b 'efined',0
[0000560f]                           dc.b $03
[00005610]                           dc.b '$if',0
[00005614]                           dc.b $00
[00005615]                           dc.b $00
[00005616]                           dc.b $00
[00005617]                           dc.b $00
[00005618]                           dc.b $00
[00005619]                           dc.b $00
[0000561a]                           dc.b $00
[0000561b]                           dc.b $05
[0000561c]                           dc.b $00
[0000561d]                           dc.b $00
[0000561e]                           dc.b $00
[0000561f]                           dc.b $00
[00005620]                           dc.b $00
[00005621]                           dc.b $00
[00005622]                           dc.b $00
[00005623]                           dc.b $00
[00005624] 000200dc                  dc.l $000200dc ; no symbol found
[00005628]                           dc.b $00
[00005629]                           dc.b $00
[0000562a]                           dc.b $00
[0000562b]                           dc.b $01
[0000562c]                           dc.w $2c00
[0000562e]                           dc.b $00
[0000562f]                           dc.b $00
[00005630]                           dc.b $00
[00005631]                           dc.b $00
[00005632]                           dc.b $00
[00005633]                           dc.b $00
[00005634]                           dc.b $00
[00005635]                           dc.b $00
[00005636]                           dc.b $00
[00005637]                           dc.b $00
[00005638] 00000210                  dc.l $00000210 ; no symbol found
[0000563c]                           dc.b $00
[0000563d]                           dc.b $00
[0000563e]                           dc.b $00
[0000563f]                           dc.b $21
[00005640] 000001da                  dc.l $000001da ; no symbol found
[00005644]                           dc.b $00
[00005645]                           dc.b $00
[00005646]                           dc.b $00
[00005647]                           dc.b $20
[00005648] 0000019e                  dc.l $0000019e ; no symbol found
[0000564c]                           dc.b $00
[0000564d]                           dc.b $00
[0000564e]                           dc.b $00
[0000564f]                           dc.b $1f
[00005650] 0000010e                  dc.l $0000010e ; no symbol found
[00005654]                           dc.b $00
[00005655]                           dc.b $00
[00005656]                           dc.b $00
[00005657]                           dc.b $1e
[00005658]                           dc.b $00
[00005659]                           dc.b $00
[0000565a]                           dc.b $00
[0000565b]                           dc.b $00
[0000565c] 00000194                  dc.l $00000194 ; no symbol found
[00005660]                           dc.w $3000
[00005662]                           dc.w $3100
[00005664]                           dc.b 'bad defined syntax',0
[00005677]                           dc.b $30
[00005678]                           dc.b $00
[00005679]                           dc.b $31
[0000567a]                           dc.b $00
[0000567b]                           dc.b $00
[0000567c]                           dc.b 'too many macro arguments',0
[00005695]                           dc.b 'too few macro arguments',0
[000056ad]                           dc.b 'bad #define arguments',0
[000056c3]                           dc.b $00
[000056c4]                           dc.b 'bad $if(test)',0
[000056d2]                           dc.b '$if expects arguments',0
[000056e8]                           dc.b 'bad macro arguments',0
[000056fc]                           dc.w $e285
[000056fe]                           dc.w $99de
[00005700]                           dc.w $d897
[00005702]                           dc.w $a095
[00005704]                           dc.w $968f
[00005706]                           dc.w $9094
[00005708]                           dc.w $9bc1
[0000570a]                           dc.w $a39c
[0000570c]                           dc.w $829d
[0000570e]                           dc.w $9f00
[00005710]                           dc.w $0e0e
[00005712]                           dc.w $0e0d
[00005714]                           dc.w $0d0c
[00005716]                           dc.w $0c0b
[00005718]                           dc.w $0b0b
[0000571a]                           dc.w $0b0a
[0000571c]                           dc.w $0a09
[0000571e]                           dc.w $0807
[00005720]                           dc.w $0605
[00005722]                           dc.w $0400
[00005724] 000203e4                  dc.l $000203e4 ; no symbol found
[00005728]                           dc.b $00
[00005729]                           dc.b $00
[0000572a]                           dc.b $00
[0000572b]                           dc.b $5a
[0000572c] 000203e1                  dc.l $000203e1 ; no symbol found
[00005730]                           dc.b $00
[00005731]                           dc.b $00
[00005732]                           dc.b $00
[00005733]                           dc.b $99
[00005734] 000203de                  dc.l $000203de ; no symbol found
[00005738]                           dc.b $00
[00005739]                           dc.b $00
[0000573a]                           dc.b $00
[0000573b]                           dc.b $c1
[0000573c] 000203db                  dc.l $000203db ; no symbol found
[00005740]                           dc.b $00
[00005741]                           dc.b $00
[00005742]                           dc.b $00
[00005743]                           dc.b $06
[00005744] 000203d8                  dc.l $000203d8 ; no symbol found
[00005748]                           dc.b $00
[00005749]                           dc.b $00
[0000574a]                           dc.b $00
[0000574b]                           dc.b $0a
[0000574c] 000203d5                  dc.l $000203d5 ; no symbol found
[00005750]                           dc.b $00
[00005751]                           dc.b $00
[00005752]                           dc.b $00
[00005753]                           dc.b $e2
[00005754] 000203d2                  dc.l $000203d2 ; no symbol found
[00005758]                           dc.b $00
[00005759]                           dc.b $00
[0000575a]                           dc.b $00
[0000575b]                           dc.b $de
[0000575c] 000203cf                  dc.l $000203cf ; no symbol found
[00005760]                           dc.b $00
[00005761]                           dc.b $00
[00005762]                           dc.b $00
[00005763]                           dc.b $02
[00005764] 000203cc                  dc.l $000203cc ; no symbol found
[00005768]                           dc.b $00
[00005769]                           dc.b $00
[0000576a]                           dc.b $00
[0000576b]                           dc.b $d8
[0000576c] 000203c9                  dc.l $000203c9 ; no symbol found
[00005770]                           dc.b $00
[00005771]                           dc.b $00
[00005772]                           dc.b $00
[00005773]                           dc.b $03
[00005774] 000203c6                  dc.l $000203c6 ; no symbol found
[00005778]                           dc.b $00
[00005779]                           dc.b $00
[0000577a]                           dc.b $00
[0000577b]                           dc.b $85
[0000577c] 000203c3                  dc.l $000203c3 ; no symbol found
[00005780]                           dc.b $00
[00005781]                           dc.b $00
[00005782]                           dc.b $00
[00005783]                           dc.b $01
[00005784] 000203c0                  dc.l $000203c0 ; no symbol found
[00005788]                           dc.b $00
[00005789]                           dc.b $00
[0000578a]                           dc.b $00
[0000578b]                           dc.b $0b
[0000578c] 000203bd                  dc.l $000203bd ; no symbol found
[00005790]                           dc.b $00
[00005791]                           dc.b $00
[00005792]                           dc.b $00
[00005793]                           dc.b $95
[00005794] 000203ba                  dc.l $000203ba ; no symbol found
[00005798]                           dc.b $00
[00005799]                           dc.b $00
[0000579a]                           dc.b $00
[0000579b]                           dc.b $88
[0000579c] 000203b7                  dc.l $000203b7 ; no symbol found
[000057a0]                           dc.b $00
[000057a1]                           dc.b $00
[000057a2]                           dc.b $00
[000057a3]                           dc.b $8f
[000057a4] 000203b4                  dc.l $000203b4 ; no symbol found
[000057a8]                           dc.b $00
[000057a9]                           dc.b $00
[000057aa]                           dc.b $00
[000057ab]                           dc.b $9f
[000057ac] 000203b1                  dc.l $000203b1 ; no symbol found
[000057b0]                           dc.b $00
[000057b1]                           dc.b $00
[000057b2]                           dc.b $00
[000057b3]                           dc.b $04
[000057b4] 000203ae                  dc.l $000203ae ; no symbol found
[000057b8]                           dc.b $00
[000057b9]                           dc.b $00
[000057ba]                           dc.b $00
[000057bb]                           dc.b $08
[000057bc] 000203ab                  dc.l $000203ab ; no symbol found
[000057c0]                           dc.b $00
[000057c1]                           dc.b $00
[000057c2]                           dc.b $00
[000057c3]                           dc.b $a3
[000057c4] 000203a8                  dc.l $000203a8 ; no symbol found
[000057c8]                           dc.b $00
[000057c9]                           dc.b $00
[000057ca]                           dc.b $00
[000057cb]                           dc.b $05
[000057cc] 000203a5                  dc.l $000203a5 ; no symbol found
[000057d0]                           dc.b $00
[000057d1]                           dc.b $00
[000057d2]                           dc.b $00
[000057d3]                           dc.b $9c
[000057d4] 000203a2                  dc.l $000203a2 ; no symbol found
[000057d8]                           dc.b $00
[000057d9]                           dc.b $00
[000057da]                           dc.b $00
[000057db]                           dc.b $09
[000057dc] 0002039f                  dc.l $0002039f ; no symbol found
[000057e0]                           dc.b $00
[000057e1]                           dc.b $00
[000057e2]                           dc.b $00
[000057e3]                           dc.b $43
[000057e4] 0002039b                  dc.l $0002039b ; no symbol found
[000057e8]                           dc.b $00
[000057e9]                           dc.b $00
[000057ea]                           dc.b $00
[000057eb]                           dc.b $9b
[000057ec] 00020397                  dc.l $00020397 ; no symbol found
[000057f0]                           dc.b $00
[000057f1]                           dc.b $00
[000057f2]                           dc.b $00
[000057f3]                           dc.b $8c
[000057f4] 00020393                  dc.l $00020393 ; no symbol found
[000057f8]                           dc.b $00
[000057f9]                           dc.b $00
[000057fa]                           dc.b $00
[000057fb]                           dc.b $82
[000057fc] 0002038f                  dc.l $0002038f ; no symbol found
[00005800]                           dc.b $00
[00005801]                           dc.b $00
[00005802]                           dc.b $00
[00005803]                           dc.b $86
[00005804] 0002038b                  dc.l $0002038b ; no symbol found
[00005808]                           dc.b $00
[00005809]                           dc.b $00
[0000580a]                           dc.b $00
[0000580b]                           dc.b $91
[0000580c] 00020387                  dc.l $00020387 ; no symbol found
[00005810]                           dc.b $00
[00005811]                           dc.b $00
[00005812]                           dc.b $00
[00005813]                           dc.b $53
[00005814] 00020383                  dc.l $00020383 ; no symbol found
[00005818]                           dc.b $00
[00005819]                           dc.b $00
[0000581a]                           dc.b $00
[0000581b]                           dc.b $8e
[0000581c] 0002037f                  dc.l $0002037f ; no symbol found
[00005820]                           dc.b $00
[00005821]                           dc.b $00
[00005822]                           dc.b $00
[00005823]                           dc.b $44
[00005824] 0002037b                  dc.l $0002037b ; no symbol found
[00005828]                           dc.b $00
[00005829]                           dc.b $00
[0000582a]                           dc.b $00
[0000582b]                           dc.b $8b
[0000582c] 00020377                  dc.l $00020377 ; no symbol found
[00005830]                           dc.b $00
[00005831]                           dc.b $00
[00005832]                           dc.b $00
[00005833]                           dc.b $07
[00005834] 00020373                  dc.l $00020373 ; no symbol found
[00005838]                           dc.b $00
[00005839]                           dc.b $00
[0000583a]                           dc.b $00
[0000583b]                           dc.b $87
[0000583c] 0002036f                  dc.l $0002036f ; no symbol found
[00005840]                           dc.b $00
[00005841]                           dc.b $00
[00005842]                           dc.b $00
[00005843]                           dc.b $97
[00005844] 0002036b                  dc.l $0002036b ; no symbol found
[00005848]                           dc.b $00
[00005849]                           dc.b $00
[0000584a]                           dc.b $00
[0000584b]                           dc.b $96
[0000584c] 00020367                  dc.l $00020367 ; no symbol found
[00005850]                           dc.b $00
[00005851]                           dc.b $00
[00005852]                           dc.b $00
[00005853]                           dc.b $94
[00005854] 00020363                  dc.l $00020363 ; no symbol found
[00005858]                           dc.b $00
[00005859]                           dc.b $00
[0000585a]                           dc.b $00
[0000585b]                           dc.b $90
[0000585c] 0002035f                  dc.l $0002035f ; no symbol found
[00005860]                           dc.b $00
[00005861]                           dc.b $00
[00005862]                           dc.b $00
[00005863]                           dc.b $a0
[00005864] 0002035b                  dc.l $0002035b ; no symbol found
[00005868]                           dc.b $00
[00005869]                           dc.b $00
[0000586a]                           dc.b $00
[0000586b]                           dc.b $92
[0000586c] 00020357                  dc.l $00020357 ; no symbol found
[00005870]                           dc.b $00
[00005871]                           dc.b $00
[00005872]                           dc.b $00
[00005873]                           dc.b $8d
[00005874] 00020353                  dc.l $00020353 ; no symbol found
[00005878]                           dc.b $00
[00005879]                           dc.b $00
[0000587a]                           dc.b $00
[0000587b]                           dc.b $9d
[0000587c] 0002034e                  dc.l $0002034e ; no symbol found
[00005880]                           dc.b $00
[00005881]                           dc.b $00
[00005882]                           dc.b $00
[00005883]                           dc.b $0d
[00005884] 00020349                  dc.l $00020349 ; no symbol found
[00005888]                           dc.b $00
[00005889]                           dc.b $00
[0000588a]                           dc.b $00
[0000588b]                           dc.b $89
[0000588c] 00020344                  dc.l $00020344 ; no symbol found
[00005890]                           dc.b $00
[00005891]                           dc.b $00
[00005892]                           dc.b $00
[00005893]                           dc.b $8a
[00005894]                           dc.w $033e
[00005896]                           dc.w $3e3d
[00005898]                           dc.b $00
[00005899]                           dc.b $03
[0000589a]                           dc.b '<<=',0
[0000589e]                           dc.w $032e
[000058a0]                           dc.w $2e2e
[000058a2]                           dc.b $00
[000058a3]                           dc.b $02
[000058a4]                           dc.w $7c7c
[000058a6]                           dc.b $00
[000058a7]                           dc.b $02
[000058a8]                           dc.w $7c3d
[000058aa]                           dc.b $00
[000058ab]                           dc.b $02
[000058ac]                           dc.w $5e3d
[000058ae]                           dc.b $00
[000058af]                           dc.b $02
[000058b0]                           dc.w $3e3e
[000058b2]                           dc.b $00
[000058b3]                           dc.b $02
[000058b4]                           dc.w $3e3d
[000058b6]                           dc.b $00
[000058b7]                           dc.b $02
[000058b8]                           dc.w $3d3d
[000058ba]                           dc.b $00
[000058bb]                           dc.b $02
[000058bc]                           dc.w $3c3d
[000058be]                           dc.b $00
[000058bf]                           dc.b $02
[000058c0]                           dc.w $3c3c
[000058c2]                           dc.b $00
[000058c3]                           dc.b $02
[000058c4]                           dc.w $2f3d
[000058c6]                           dc.b $00
[000058c7]                           dc.b $02
[000058c8]                           dc.w $2d3e
[000058ca]                           dc.b $00
[000058cb]                           dc.b $02
[000058cc]                           dc.w $2d3d
[000058ce]                           dc.b $00
[000058cf]                           dc.b $02
[000058d0]                           dc.w $2d2d
[000058d2]                           dc.b $00
[000058d3]                           dc.b $02
[000058d4]                           dc.w $2b3d
[000058d6]                           dc.b $00
[000058d7]                           dc.b $02
[000058d8]                           dc.w $2b2b
[000058da]                           dc.b $00
[000058db]                           dc.b $02
[000058dc]                           dc.w $2a3d
[000058de]                           dc.b $00
[000058df]                           dc.b $02
[000058e0]                           dc.w $263d
[000058e2]                           dc.b $00
[000058e3]                           dc.b $02
[000058e4]                           dc.w $2626
[000058e6]                           dc.b $00
[000058e7]                           dc.b $02
[000058e8]                           dc.w $253d
[000058ea]                           dc.b $00
[000058eb]                           dc.b $02
[000058ec]                           dc.w $213d
[000058ee]                           dc.b $00
[000058ef]                           dc.b $01
[000058f0]                           dc.w $7e00
[000058f2]                           dc.w $017d
[000058f4]                           dc.b $00
[000058f5]                           dc.b $01
[000058f6]                           dc.w $7c00
[000058f8]                           dc.w $017b
[000058fa]                           dc.b $00
[000058fb]                           dc.b $01
[000058fc]                           dc.w $5e00
[000058fe]                           dc.w $015d
[00005900]                           dc.b $00
[00005901]                           dc.b $01
[00005902]                           dc.w $5b00
[00005904]                           dc.w $013f
[00005906]                           dc.b $00
[00005907]                           dc.b $01
[00005908]                           dc.w $3e00
[0000590a]                           dc.w $013d
[0000590c]                           dc.b $00
[0000590d]                           dc.b $01
[0000590e]                           dc.w $3c00
[00005910]                           dc.w $013b
[00005912]                           dc.b $00
[00005913]                           dc.b $01
[00005914]                           dc.w $3a00
[00005916]                           dc.w $012f
[00005918]                           dc.b $00
[00005919]                           dc.b $01
[0000591a]                           dc.w $2e00
[0000591c]                           dc.w $012d
[0000591e]                           dc.b $00
[0000591f]                           dc.b $01
[00005920]                           dc.w $2c00
[00005922]                           dc.w $012b
[00005924]                           dc.b $00
[00005925]                           dc.b $01
[00005926]                           dc.w $2a00
[00005928]                           dc.w $0129
[0000592a]                           dc.b $00
[0000592b]                           dc.b $01
[0000592c]                           dc.w $2800
[0000592e]                           dc.w $0126
[00005930]                           dc.b $00
[00005931]                           dc.b $01
[00005932]                           dc.w $2500
[00005934]                           dc.w $0121
[00005936]                           dc.b $00
[00005937]                           dc.b $00
[00005938] 000204e3                  dc.l $000204e3 ; no symbol found
[0000593c]                           dc.b $00
[0000593d]                           dc.b $00
[0000593e]                           dc.b $00
[0000593f]                           dc.b $0c
[00005940] 000204df                  dc.l $000204df ; no symbol found
[00005944]                           dc.b $00
[00005945]                           dc.b $00
[00005946]                           dc.b $00
[00005947]                           dc.b $05
[00005948] 000204db                  dc.l $000204db ; no symbol found
[0000594c]                           dc.b $00
[0000594d]                           dc.b $00
[0000594e]                           dc.b $00
[0000594f]                           dc.b $04
[00005950] 000204d7                  dc.l $000204d7 ; no symbol found
[00005954]                           dc.b $00
[00005955]                           dc.b $00
[00005956]                           dc.b $00
[00005957]                           dc.b $0e
[00005958] 000204d3                  dc.l $000204d3 ; no symbol found
[0000595c]                           dc.b $00
[0000595d]                           dc.b $00
[0000595e]                           dc.b $00
[0000595f]                           dc.b $8c
[00005960] 000204cf                  dc.l $000204cf ; no symbol found
[00005964]                           dc.b $00
[00005965]                           dc.b $00
[00005966]                           dc.b $00
[00005967]                           dc.b $86
[00005968] 000204cb                  dc.l $000204cb ; no symbol found
[0000596c]                           dc.b $00
[0000596d]                           dc.b $00
[0000596e]                           dc.b $00
[0000596f]                           dc.b $91
[00005970] 000204c7                  dc.l $000204c7 ; no symbol found
[00005974]                           dc.b $00
[00005975]                           dc.b $00
[00005976]                           dc.b $00
[00005977]                           dc.b $8e
[00005978] 000204c3                  dc.l $000204c3 ; no symbol found
[0000597c]                           dc.b $00
[0000597d]                           dc.b $00
[0000597e]                           dc.b $00
[0000597f]                           dc.b $8b
[00005980] 000204bf                  dc.l $000204bf ; no symbol found
[00005984]                           dc.b $00
[00005985]                           dc.b $00
[00005986]                           dc.b $00
[00005987]                           dc.b $87
[00005988] 000204bb                  dc.l $000204bb ; no symbol found
[0000598c]                           dc.b $00
[0000598d]                           dc.b $00
[0000598e]                           dc.b $00
[0000598f]                           dc.b $92
[00005990] 000204b7                  dc.l $000204b7 ; no symbol found
[00005994]                           dc.b $00
[00005995]                           dc.b $00
[00005996]                           dc.b $00
[00005997]                           dc.b $8d
[00005998] 000204b3                  dc.l $000204b3 ; no symbol found
[0000599c]                           dc.b $00
[0000599d]                           dc.b $00
[0000599e]                           dc.b $00
[0000599f]                           dc.b $09
[000059a0] 000204af                  dc.l $000204af ; no symbol found
[000059a4]                           dc.b $00
[000059a5]                           dc.b $00
[000059a6]                           dc.b $00
[000059a7]                           dc.b $9c
[000059a8] 000204ab                  dc.l $000204ab ; no symbol found
[000059ac]                           dc.b $00
[000059ad]                           dc.b $00
[000059ae]                           dc.b $00
[000059af]                           dc.b $05
[000059b0] 000204a7                  dc.l $000204a7 ; no symbol found
[000059b4]                           dc.b $00
[000059b5]                           dc.b $00
[000059b6]                           dc.b $00
[000059b7]                           dc.b $09
[000059b8] 000204a3                  dc.l $000204a3 ; no symbol found
[000059bc]                           dc.b $00
[000059bd]                           dc.b $00
[000059be]                           dc.b $00
[000059bf]                           dc.b $43
[000059c0] 0002049f                  dc.l $0002049f ; no symbol found
[000059c4]                           dc.b $00
[000059c5]                           dc.b $00
[000059c6]                           dc.b $00
[000059c7]                           dc.b $08
[000059c8] 0002049a                  dc.l $0002049a ; no symbol found
[000059cc]                           dc.b $00
[000059cd]                           dc.b $00
[000059ce]                           dc.b $00
[000059cf]                           dc.b $89
[000059d0] 00020495                  dc.l $00020495 ; no symbol found
[000059d4]                           dc.b $00
[000059d5]                           dc.b $00
[000059d6]                           dc.b $00
[000059d7]                           dc.b $8a
[000059d8] 00020490                  dc.l $00020490 ; no symbol found
[000059dc]                           dc.b $00
[000059dd]                           dc.b $00
[000059de]                           dc.b $00
[000059df]                           dc.b $9d
[000059e0]                           dc.w $035c
[000059e2]                           dc.w $2121
[000059e4]                           dc.b $00
[000059e5]                           dc.b $03
[000059e6]                           dc.b '=>>',0
[000059ea]                           dc.w $033d
[000059ec]                           dc.w $3c3c
[000059ee]                           dc.b $00
[000059ef]                           dc.b $02
[000059f0]                           dc.w $7c29
[000059f2]                           dc.b $00
[000059f3]                           dc.b $02
[000059f4]                           dc.w $5c5e
[000059f6]                           dc.b $00
[000059f7]                           dc.b $02
[000059f8]                           dc.w $5c29
[000059fa]                           dc.b $00
[000059fb]                           dc.b $02
[000059fc]                           dc.w $5c28
[000059fe]                           dc.b $00
[000059ff]                           dc.b $02
[00005a00]                           dc.w $5c21
[00005a02]                           dc.b $00
[00005a03]                           dc.b $02
[00005a04]                           dc.w $3e29
[00005a06]                           dc.b $00
[00005a07]                           dc.b $02
[00005a08]                           dc.w $3d7c
[00005a0a]                           dc.b $00
[00005a0b]                           dc.b $02
[00005a0c]                           dc.w $3d5e
[00005a0e]                           dc.b $00
[00005a0f]                           dc.b $02
[00005a10]                           dc.w $3d2f
[00005a12]                           dc.b $00
[00005a13]                           dc.b $02
[00005a14]                           dc.w $3d2d
[00005a16]                           dc.b $00
[00005a17]                           dc.b $02
[00005a18]                           dc.w $3d2b
[00005a1a]                           dc.b $00
[00005a1b]                           dc.b $02
[00005a1c]                           dc.w $3d2a
[00005a1e]                           dc.b $00
[00005a1f]                           dc.b $02
[00005a20]                           dc.w $3d26
[00005a22]                           dc.b $00
[00005a23]                           dc.b $02
[00005a24]                           dc.w $3d25
[00005a26]                           dc.b $00
[00005a27]                           dc.b $02
[00005a28]                           dc.w $2e2e
[00005a2a]                           dc.b $00
[00005a2b]                           dc.b $02
[00005a2c]                           dc.w $287c
[00005a2e]                           dc.b $00
[00005a2f]                           dc.b $02
[00005a30]                           dc.w $283c
[00005a32]                           dc.b $00
[00005a33]                           dc.b $01
[00005a34]                           dc.w $4000
_cmap:
[00005a36]                           dc.b $00
[00005a37]                           dc.b $01
[00005a38]                           dc.w $0203
[00005a3a]                           dc.w $0405
[00005a3c]                           dc.w $0607
[00005a3e]                           dc.w $0809
[00005a40]                           dc.w $0a0b
[00005a42]                           dc.w $0c0d
[00005a44]                           dc.w $0e0f
[00005a46]                           dc.w $1011
[00005a48]                           dc.w $1213
[00005a4a]                           dc.w $1415
[00005a4c]                           dc.w $1617
[00005a4e]                           dc.w $1819
[00005a50]                           dc.w $1a1b
[00005a52]                           dc.w $1c1d
[00005a54]                           dc.w $1e1f
[00005a56]                           dc.b ' !"#$%&',$27,'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~'
[00005ab5]                           dc.b $7f
[00005ab6]                           dc.w $8081
[00005ab8]                           dc.w $8283
[00005aba]                           dc.w $8485
[00005abc]                           dc.w $8687
[00005abe]                           dc.w $8889
[00005ac0]                           dc.w $8a8b
[00005ac2]                           dc.w $8c8d
[00005ac4]                           dc.w $8e8f
[00005ac6]                           dc.w $9091
[00005ac8]                           dc.w $9293
[00005aca]                           dc.w $9495
[00005acc]                           dc.w $9697
[00005ace]                           dc.w $9899
[00005ad0]                           dc.w $9a9b
[00005ad2]                           dc.w $9c9d
[00005ad4]                           dc.w $9e9f
[00005ad6]                           dc.w $a0a1
[00005ad8]                           dc.w $a2a3
[00005ada]                           dc.w $a4a5
[00005adc]                           dc.w $a6a7
[00005ade]                           dc.w $a8a9
[00005ae0]                           dc.w $aaab
[00005ae2]                           dc.w $acad
[00005ae4]                           dc.w $aeaf
[00005ae6]                           dc.w $b0b1
[00005ae8]                           dc.w $b2b3
[00005aea]                           dc.w $b4b5
[00005aec]                           dc.w $b6b7
[00005aee]                           dc.w $b8b9
[00005af0]                           dc.w $babb
[00005af2]                           dc.w $bcbd
[00005af4]                           dc.w $bebf
[00005af6]                           dc.w $c0c1
[00005af8]                           dc.w $c2c3
[00005afa]                           dc.w $c4c5
[00005afc]                           dc.w $c6c7
[00005afe]                           dc.w $c8c9
[00005b00]                           dc.w $cacb
[00005b02]                           dc.w $cccd
[00005b04]                           dc.w $cecf
[00005b06]                           dc.w $d0d1
[00005b08]                           dc.w $d2d3
[00005b0a]                           dc.w $d4d5
[00005b0c]                           dc.w $d6d7
[00005b0e]                           dc.w $d8d9
[00005b10]                           dc.w $dadb
[00005b12]                           dc.w $dcdd
[00005b14]                           dc.w $dedf
[00005b16]                           dc.w $e0e1
[00005b18]                           dc.w $e2e3
[00005b1a]                           dc.w $e4e5
[00005b1c]                           dc.w $e6e7
[00005b1e]                           dc.w $e8e9
[00005b20]                           dc.w $eaeb
[00005b22]                           dc.w $eced
[00005b24]                           dc.w $eeef
[00005b26]                           dc.w $f0f1
[00005b28]                           dc.w $f2f3
[00005b2a]                           dc.w $f4f5
[00005b2c]                           dc.w $f6f7
[00005b2e]                           dc.w $f8f9
[00005b30]                           dc.w $fafb
[00005b32]                           dc.w $fcfd
[00005b34]                           dc.w $feff
_digfr:
[00005b36]                           dc.b '0123456789abcdefABCDEF',0
_digto:
[00005b4d]                           dc.b $00
[00005b4e]                           dc.w $0102
[00005b50]                           dc.w $0304
[00005b52]                           dc.w $0506
[00005b54]                           dc.w $0708
[00005b56]                           dc.w $090a
[00005b58]                           dc.w $0b0c
[00005b5a]                           dc.w $0d0e
[00005b5c]                           dc.w $0f0a
[00005b5e]                           dc.w $0b0c
[00005b60]                           dc.w $0d0e
[00005b62]                           dc.w $0f00
[00005b64]                           dc.b 'abnfrtv(!)^',0
[00005b70]                           dc.w $0708
[00005b72]                           dc.w $0a0c
[00005b74]                           dc.w $0d09
[00005b76]                           dc.w $0b7b
[00005b78]                           dc.b '|}~',0
[00005b7c]                           dc.b 'illegal character: %c',0
[00005b92]                           dc.b 'illegal #if expression',0
[00005ba9]                           dc.b $00
[00005baa] 000010b6                  dc.l $000010b6 ; no symbol found
[00005bae]                           dc.b $00
[00005baf]                           dc.b $00
[00005bb0]                           dc.b $00
[00005bb1]                           dc.b $9f
[00005bb2] 0000109c                  dc.l $0000109c ; no symbol found
[00005bb6]                           dc.b $00
[00005bb7]                           dc.b $00
[00005bb8]                           dc.b $00
[00005bb9]                           dc.b $9d
[00005bba] 00001082                  dc.l $00001082 ; no symbol found
[00005bbe]                           dc.b $00
[00005bbf]                           dc.b $00
[00005bc0]                           dc.b $00
[00005bc1]                           dc.b $82
[00005bc2] 0000106e                  dc.l $0000106e ; no symbol found
[00005bc6]                           dc.b $00
[00005bc7]                           dc.b $00
[00005bc8]                           dc.b $00
[00005bc9]                           dc.b $90
[00005bca] 0000105a                  dc.l $0000105a ; no symbol found
[00005bce]                           dc.b $00
[00005bcf]                           dc.b $00
[00005bd0]                           dc.b $00
[00005bd1]                           dc.b $9b
[00005bd2] 00001046                  dc.l $00001046 ; no symbol found
[00005bd6]                           dc.b $00
[00005bd7]                           dc.b $00
[00005bd8]                           dc.b $00
[00005bd9]                           dc.b $96
[00005bda] 00001032                  dc.l $00001032 ; no symbol found
[00005bde]                           dc.b $00
[00005bdf]                           dc.b $00
[00005be0]                           dc.b $00
[00005be1]                           dc.b $8f
[00005be2] 0000101e                  dc.l $0000101e ; no symbol found
[00005be6]                           dc.b $00
[00005be7]                           dc.b $00
[00005be8]                           dc.b $00
[00005be9]                           dc.b $94
[00005bea] 0000100a                  dc.l $0000100a ; no symbol found
[00005bee]                           dc.b $00
[00005bef]                           dc.b $00
[00005bf0]                           dc.b $00
[00005bf1]                           dc.b $95
[00005bf2] 00000ff8                  dc.l $00000ff8 ; no symbol found
[00005bf6]                           dc.b $00
[00005bf7]                           dc.b $00
[00005bf8]                           dc.b $00
[00005bf9]                           dc.b $a0
[00005bfa] 00000fe6                  dc.l $00000fe6 ; no symbol found
[00005bfe]                           dc.b $00
[00005bff]                           dc.b $00
[00005c00]                           dc.b $00
[00005c01]                           dc.b $97
[00005c02] 00000fdc                  dc.l $00000fdc ; no symbol found
[00005c06]                           dc.b $00
[00005c07]                           dc.b $00
[00005c08]                           dc.b $00
[00005c09]                           dc.b $a3
[00005c0a] 00000fd2                  dc.l $00000fd2 ; no symbol found
[00005c0e]                           dc.b $00
[00005c0f]                           dc.b $00
[00005c10]                           dc.b $00
[00005c11]                           dc.b $9c
[00005c12] 00000fc8                  dc.l $00000fc8 ; no symbol found
[00005c16]                           dc.b $00
[00005c17]                           dc.b $00
[00005c18]                           dc.b $00
[00005c19]                           dc.b $c1
[00005c1a] 00000fb4                  dc.l $00000fb4 ; no symbol found
[00005c1e]                           dc.b $00
[00005c1f]                           dc.b $00
[00005c20]                           dc.b $00
[00005c21]                           dc.b $99
[00005c22] 00000fa0                  dc.l $00000fa0 ; no symbol found
[00005c26]                           dc.b $00
[00005c27]                           dc.b $00
[00005c28]                           dc.b $00
[00005c29]                           dc.b $85
[00005c2a] 00000f8c                  dc.l $00000f8c ; no symbol found
[00005c2e]                           dc.b $00
[00005c2f]                           dc.b $00
[00005c30]                           dc.b $00
[00005c31]                           dc.b $e2
[00005c32] 00000f84                  dc.l $00000f84 ; no symbol found
[00005c36]                           dc.b $00
[00005c37]                           dc.b $00
[00005c38]                           dc.b $00
[00005c39]                           dc.b $d8
[00005c3a] 00000f68                  dc.l $00000f68 ; no symbol found
[00005c3e]                           dc.b $00
[00005c3f]                           dc.b $00
[00005c40]                           dc.b $00
[00005c41]                           dc.b $de
[00005c42]                           dc.b $00
[00005c43]                           dc.b $00
[00005c44]                           dc.b $00
[00005c45]                           dc.b $00
[00005c46] 0000111a                  dc.l $0000111a ; no symbol found
[00005c4a]                           dc.b 'illegal operator in #if',0
[00005c62]                           dc.b 'illegal ? : in #if',0
[00005c75]                           dc.b $00
[00005c76]                           dc.b 'illegal unary op in #if',0
[00005c8e]                           dc.b 'illegal #if syntax',0
[00005ca1]                           dc.b 'missing ) in #if',0
[00005cb2] 00020955                  dc.l $00020955 ; no symbol found
[00005cb6]                           dc.b $00
[00005cb7]                           dc.b $00
[00005cb8]                           dc.b $00
[00005cb9]                           dc.b $27
[00005cba] 00020951                  dc.l $00020951 ; no symbol found
[00005cbe]                           dc.b $00
[00005cbf]                           dc.b $00
[00005cc0]                           dc.b $00
[00005cc1]                           dc.b $2e
[00005cc2] 0002094c                  dc.l $0002094c ; no symbol found
[00005cc6]                           dc.b $00
[00005cc7]                           dc.b $00
[00005cc8]                           dc.b $00
[00005cc9]                           dc.b $2c
[00005cca] 00020947                  dc.l $00020947 ; no symbol found
[00005cce]                           dc.b $00
[00005ccf]                           dc.b $00
[00005cd0]                           dc.b $00
[00005cd1]                           dc.b $2f
[00005cd2] 00020941                  dc.l $00020941 ; no symbol found
[00005cd6]                           dc.b $00
[00005cd7]                           dc.b $00
[00005cd8]                           dc.b $00
[00005cd9]                           dc.b $21
[00005cda] 0002093b                  dc.l $0002093b ; no symbol found
[00005cde]                           dc.b $00
[00005cdf]                           dc.b $00
[00005ce0]                           dc.b $00
[00005ce1]                           dc.b $23
[00005ce2] 00020935                  dc.l $00020935 ; no symbol found
[00005ce6]                           dc.b $00
[00005ce7]                           dc.b $00
[00005ce8]                           dc.b $00
[00005ce9]                           dc.b $24
[00005cea] 0002092f                  dc.l $0002092f ; no symbol found
[00005cee]                           dc.b $00
[00005cef]                           dc.b $00
[00005cf0]                           dc.b $00
[00005cf1]                           dc.b $29
[00005cf2] 00020929                  dc.l $00020929 ; no symbol found
[00005cf6]                           dc.b $00
[00005cf7]                           dc.b $00
[00005cf8]                           dc.b $00
[00005cf9]                           dc.b $3c
[00005cfa] 00020923                  dc.l $00020923 ; no symbol found
[00005cfe]                           dc.b $00
[00005cff]                           dc.b $00
[00005d00]                           dc.b $00
[00005d01]                           dc.b $2d
[00005d02] 0002091d                  dc.l $0002091d ; no symbol found
[00005d06]                           dc.b $00
[00005d07]                           dc.b $00
[00005d08]                           dc.b $00
[00005d09]                           dc.b $30
[00005d0a] 00020917                  dc.l $00020917 ; no symbol found
[00005d0e]                           dc.b $00
[00005d0f]                           dc.b $00
[00005d10]                           dc.b $00
[00005d11]                           dc.b $3e
[00005d12] 00020910                  dc.l $00020910 ; no symbol found
[00005d16]                           dc.b $00
[00005d17]                           dc.b $00
[00005d18]                           dc.b $00
[00005d19]                           dc.b $22
[00005d1a] 00020909                  dc.l $00020909 ; no symbol found
[00005d1e]                           dc.b $00
[00005d1f]                           dc.b $00
[00005d20]                           dc.b $00
[00005d21]                           dc.b $3b
[00005d22] 00020902                  dc.l $00020902 ; no symbol found
[00005d26]                           dc.b $00
[00005d27]                           dc.b $00
[00005d28]                           dc.b $00
[00005d29]                           dc.b $2b
[00005d2a] 000208fb                  dc.l $000208fb ; no symbol found
[00005d2e]                           dc.b $00
[00005d2f]                           dc.b $00
[00005d30]                           dc.b $00
[00005d31]                           dc.b $33
[00005d32] 000208f4                  dc.l $000208f4 ; no symbol found
[00005d36]                           dc.b $00
[00005d37]                           dc.b $00
[00005d38]                           dc.b $00
[00005d39]                           dc.b $38
[00005d3a] 000208ed                  dc.l $000208ed ; no symbol found
[00005d3e]                           dc.b $00
[00005d3f]                           dc.b $00
[00005d40]                           dc.b $00
[00005d41]                           dc.b $3a
[00005d42] 000208e5                  dc.l $000208e5 ; no symbol found
[00005d46]                           dc.b $00
[00005d47]                           dc.b $00
[00005d48]                           dc.b $00
[00005d49]                           dc.b $28
[00005d4a] 000208dd                  dc.l $000208dd ; no symbol found
[00005d4e]                           dc.b $00
[00005d4f]                           dc.b $00
[00005d50]                           dc.b $00
[00005d51]                           dc.b $2a
[00005d52] 000208d5                  dc.l $000208d5 ; no symbol found
[00005d56]                           dc.b $00
[00005d57]                           dc.b $00
[00005d58]                           dc.b $00
[00005d59]                           dc.b $32
[00005d5a] 000208cd                  dc.l $000208cd ; no symbol found
[00005d5e]                           dc.b $00
[00005d5f]                           dc.b $00
[00005d60]                           dc.b $00
[00005d61]                           dc.b $3d
[00005d62] 000208c5                  dc.l $000208c5 ; no symbol found
[00005d66]                           dc.b $00
[00005d67]                           dc.b $00
[00005d68]                           dc.b $00
[00005d69]                           dc.b $61
[00005d6a] 000208bd                  dc.l $000208bd ; no symbol found
[00005d6e]                           dc.b $00
[00005d6f]                           dc.b $00
[00005d70]                           dc.b $00
[00005d71]                           dc.b $34
[00005d72] 000208b5                  dc.l $000208b5 ; no symbol found
[00005d76]                           dc.b $00
[00005d77]                           dc.b $00
[00005d78]                           dc.b $00
[00005d79]                           dc.b $35
[00005d7a] 000208ad                  dc.l $000208ad ; no symbol found
[00005d7e]                           dc.b $00
[00005d7f]                           dc.b $00
[00005d80]                           dc.b $00
[00005d81]                           dc.b $36
[00005d82] 000208a4                  dc.l $000208a4 ; no symbol found
[00005d86]                           dc.b $00
[00005d87]                           dc.b $00
[00005d88]                           dc.b $00
[00005d89]                           dc.b $60
[00005d8a] 0002089b                  dc.l $0002089b ; no symbol found
[00005d8e]                           dc.b $00
[00005d8f]                           dc.b $00
[00005d90]                           dc.b $00
[00005d91]                           dc.b $26
[00005d92] 00020892                  dc.l $00020892 ; no symbol found
[00005d96]                           dc.b $00
[00005d97]                           dc.b $00
[00005d98]                           dc.b $00
[00005d99]                           dc.b $37
[00005d9a] 00020888                  dc.l $00020888 ; no symbol found
[00005d9e]                           dc.b $00
[00005d9f]                           dc.b $00
[00005da0]                           dc.b $00
[00005da1]                           dc.b $25
[00005da2] 0002087e                  dc.l $0002087e ; no symbol found
[00005da6]                           dc.b $00
[00005da7]                           dc.b $00
[00005da8]                           dc.b $00
[00005da9]                           dc.b $31
[00005daa] 00020874                  dc.l $00020874 ; no symbol found
[00005dae]                           dc.b $00
[00005daf]                           dc.b $00
[00005db0]                           dc.b $00
[00005db1]                           dc.b $39
[00005db2] 0002086a                  dc.l $0002086a ; no symbol found
[00005db6]                           dc.b $00
[00005db7]                           dc.b $00
[00005db8]                           dc.b $00
[00005db9]                           dc.b $3f
[00005dba]                           dc.w $0876
[00005dbc]                           dc.b 'olatile',0
[00005dc4]                           dc.w $0875
[00005dc6]                           dc.b 'nsigned',0
[00005dce]                           dc.w $0872
[00005dd0]                           dc.b 'egister',0
[00005dd8]                           dc.w $0863
[00005dda]                           dc.b 'ontinue',0
[00005de2]                           dc.w $0774
[00005de4]                           dc.b 'ypedef',0
[00005deb]                           dc.b $07
[00005dec]                           dc.b 'default',0
[00005df4]                           dc.w $0724
[00005df6]                           dc.b 'noside',0
[00005dfd]                           dc.b $06
[00005dfe]                           dc.b 'switch',0
[00005e05]                           dc.b $06
[00005e06]                           dc.b 'struct',0
[00005e0d]                           dc.b $06
[00005e0e]                           dc.b 'static',0
[00005e15]                           dc.b $06
[00005e16]                           dc.b 'sizeof',0
[00005e1d]                           dc.b $06
[00005e1e]                           dc.b 'signed',0
[00005e25]                           dc.b $06
[00005e26]                           dc.b 'return',0
[00005e2d]                           dc.b $06
[00005e2e]                           dc.b 'extern',0
[00005e35]                           dc.b $06
[00005e36]                           dc.b 'double',0
[00005e3d]                           dc.b $05
[00005e3e]                           dc.b 'while',0
[00005e44]                           dc.w $0575
[00005e46]                           dc.b 'nion',0
[00005e4b]                           dc.b $05
[00005e4c]                           dc.b 'short',0
[00005e52]                           dc.w $0566
[00005e54]                           dc.b 'loat',0
[00005e59]                           dc.b $05
[00005e5a]                           dc.b 'const',0
[00005e60]                           dc.w $0562
[00005e62]                           dc.b 'reak',0
[00005e67]                           dc.b $04
[00005e68]                           dc.b 'void',0
[00005e6d]                           dc.b $04
[00005e6e]                           dc.b 'long',0
[00005e73]                           dc.b $04
[00005e74]                           dc.b 'goto',0
[00005e79]                           dc.b $04
[00005e7a]                           dc.b 'enum',0
[00005e7f]                           dc.b $04
[00005e80]                           dc.b 'else',0
[00005e85]                           dc.b $04
[00005e86]                           dc.b 'char',0
[00005e8b]                           dc.b $04
[00005e8c]                           dc.b 'case',0
[00005e91]                           dc.b $04
[00005e92]                           dc.b 'auto',0
[00005e97]                           dc.b $03
[00005e98]                           dc.b 'int',0
[00005e9c]                           dc.w $0366
[00005e9e]                           dc.w $6f72
[00005ea0]                           dc.b $00
[00005ea1]                           dc.b $02
[00005ea2]                           dc.w $6966
[00005ea4]                           dc.b $00
[00005ea5]                           dc.b $02
[00005ea6]                           dc.w $646f
[00005ea8]                           dc.b $00
[00005ea9]                           dc.b ' illegal integer %b',0
[00005ebd]                           dc.b $00
[00005ebe]                           dc.w $6334
[00005ec0]                           dc.b $00
[00005ec1]                           dc.b $00
[00005ec2]                           dc.b 'illegal float constant',0
[00005ed9]                           dc.b $63
[00005eda]                           dc.w $3800
[00005edc]                           dc.b 'ccb',0
[00005ee0]                           dc.w $6300
[00005ee2]                           dc.w $6334
[00005ee4]                           dc.b $00
[00005ee5]                           dc.b $00
[00005ee6]                           dc.w $6300
[00005ee8]                           dc.b 'c2b',0
[00005eec]                           dc.b 'c2bb',0
[00005ef1]                           dc.b $00
[00005ef2]                           dc.b 'ccp',0
[00005ef6]                           dc.w $6363
[00005ef8]                           dc.b $00
[00005ef9]                           dc.b $00
[00005efa] 00001ce4                  dc.l $00001ce4 ; no symbol found
[00005efe]                           dc.b $00
[00005eff]                           dc.b $00
[00005f00]                           dc.b $00
[00005f01]                           dc.b $07
[00005f02] 00001c2e                  dc.l $00001c2e ; no symbol found
[00005f06]                           dc.b $00
[00005f07]                           dc.b $00
[00005f08]                           dc.b $00
[00005f09]                           dc.b $04
[00005f0a] 00001c24                  dc.l $00001c24 ; no symbol found
[00005f0e]                           dc.b $00
[00005f0f]                           dc.b $00
[00005f10]                           dc.b $00
[00005f11]                           dc.b $01
[00005f12] 00001c1a                  dc.l $00001c1a ; no symbol found
[00005f16]                           dc.b $00
[00005f17]                           dc.b $00
[00005f18]                           dc.b $00
[00005f19]                           dc.b $08
[00005f1a] 00001c10                  dc.l $00001c10 ; no symbol found
[00005f1e]                           dc.b $00
[00005f1f]                           dc.b $00
[00005f20]                           dc.b $00
[00005f21]                           dc.b $06
[00005f22] 00001c04                  dc.l $00001c04 ; no symbol found
[00005f26]                           dc.b $00
[00005f27]                           dc.b $00
[00005f28]                           dc.b $00
[00005f29]                           dc.b $03
[00005f2a]                           dc.b $00
[00005f2b]                           dc.b $00
[00005f2c]                           dc.b $00
[00005f2d]                           dc.b $00
[00005f2e] 00001cea                  dc.l $00001cea ; no symbol found
[00005f32]                           dc.b 'eExX',0
[00005f37]                           dc.b $22
[00005f38]                           dc.b $00
[00005f39]                           dc.b $00
[00005f3a]                           dc.b $00
[00005f3b]                           dc.b $00
[00005f3c]                           dc.b $00
[00005f3d]                           dc.b $0a
[00005f3e]                           dc.b $00
[00005f3f]                           dc.b $00
[00005f40]                           dc.b $00
[00005f41]                           dc.b $00
[00005f42]                           dc.b $00
[00005f43]                           dc.b $00
[00005f44]                           dc.b $00
[00005f45]                           dc.b $00
[00005f46]                           dc.b $00
[00005f47]                           dc.b $00
[00005f48]                           dc.b $00
[00005f49]                           dc.b $00
[00005f4a]                           dc.b $00
[00005f4b]                           dc.b $00
[00005f4c]                           dc.b $00
[00005f4d]                           dc.b $00
[00005f4e]                           dc.b $00
[00005f4f]                           dc.b $00
[00005f50]                           dc.b $00
[00005f51]                           dc.b $00
[00005f52]                           dc.b $00
[00005f53]                           dc.b $00
[00005f54]                           dc.b $00
[00005f55]                           dc.b $00
[00005f56]                           dc.b $00
[00005f57]                           dc.b $00
[00005f58]                           dc.b $00
[00005f59]                           dc.b $00
[00005f5a]                           dc.b $00
[00005f5b]                           dc.b $00
[00005f5c]                           dc.b $00
[00005f5d]                           dc.b $00
[00005f5e]                           dc.b $00
[00005f5f]                           dc.b $00
[00005f60]                           dc.b $00
[00005f61]                           dc.b $00
[00005f62]                           dc.b $00
[00005f63]                           dc.b $00
[00005f64]                           dc.b $00
[00005f65]                           dc.b $00
[00005f66]                           dc.b $00
[00005f67]                           dc.b $00
[00005f68]                           dc.b $00
[00005f69]                           dc.b $00
_errflag:
[00005f6a]                           dc.b $00
[00005f6b]                           dc.b $00
[00005f6c]                           dc.b $00
[00005f6d]                           dc.b $00
_liflag:
[00005f6e]                           dc.b $00
[00005f6f]                           dc.b $00
[00005f70]                           dc.b $00
[00005f71]                           dc.b $00
_oldflag:
[00005f72]                           dc.b $00
[00005f73]                           dc.b $00
[00005f74]                           dc.b $00
[00005f75]                           dc.b $00
_pasflag:
[00005f76]                           dc.b $00
[00005f77]                           dc.b $00
[00005f78]                           dc.b $00
[00005f79]                           dc.b $00
_stdflag:
[00005f7a]                           dc.b $00
[00005f7b]                           dc.b $00
[00005f7c]                           dc.b $00
[00005f7d]                           dc.b $00
_xflag:
[00005f7e]                           dc.b $00
[00005f7f]                           dc.b $00
[00005f80]                           dc.b $00
[00005f81]                           dc.b $00
_pchar:
[00005f82]                           dc.b $00
[00005f83]                           dc.b $00
[00005f84]                           dc.b $00
[00005f85]                           dc.b $23
_schar:
[00005f86]                           dc.b $00
[00005f87]                           dc.b $00
[00005f88]                           dc.b $00
[00005f89]                           dc.b $00
_inif:
[00005f8a]                           dc.b $00
[00005f8b]                           dc.b $00
_inincl:
[00005f8c]                           dc.b $00
[00005f8d]                           dc.b $00
_escname:
[00005f8e]                           dc.w $0424
[00005f90]                           dc.b 'esc',0
_iprefix:
[00005f94] 00020a48                  dc.l $00020a48 ; no symbol found
[00005f98]                           dc.w $7c00
_mapfile:
[00005f9a]                           dc.b $00
[00005f9b]                           dc.b $00
[00005f9c]                           dc.b $00
[00005f9d]                           dc.b $00
__pname:
[00005f9e] 00020a52                  dc.l $00020a52 ; no symbol found
[00005fa2]                           dc.w $7070
[00005fa4]                           dc.b $00
[00005fa5]                           dc.b $00
_pasline:
[00005fa6]                           dc.b $00
[00005fa7]                           dc.b $00
[00005fa8]                           dc.b $00
[00005fa9]                           dc.b $00
_failincl:
[00005faa]                           dc.b $00
[00005fab]                           dc.b $00
[00005fac]                           dc.b $00
[00005fad]                           dc.b $00
_pflag:
[00005fae]                           dc.b $00
[00005faf]                           dc.b $00
[00005fb0]                           dc.b $00
[00005fb1]                           dc.b $01
_argc:
[00005fb2]                           dc.b $00
[00005fb3]                           dc.b $00
[00005fb4]                           dc.b $00
[00005fb5]                           dc.b $00
_lineno:
[00005fb6]                           dc.b $00
[00005fb7]                           dc.b $00
_nerrors:
[00005fb8]                           dc.b $00
[00005fb9]                           dc.b $00
_errfd:
[00005fba]                           dc.b $00
[00005fbb]                           dc.b $02
_pincl:
[00005fbc]                           dc.b $00
[00005fbd]                           dc.b $00
[00005fbe]                           dc.b $00
[00005fbf]                           dc.b $00
_argv:
[00005fc0]                           dc.b $00
[00005fc1]                           dc.b $00
[00005fc2]                           dc.b $00
[00005fc3]                           dc.b $00
_perr:
[00005fc4]                           dc.b $00
[00005fc5]                           dc.b $00
[00005fc6]                           dc.b $00
[00005fc7]                           dc.b $00
_errbuf:
[00005fc8]                           dc.b $00
[00005fc9]                           dc.b $00
[00005fca]                           dc.b $00
[00005fcb]                           dc.b $00
[00005fcc]                           dc.b $00
[00005fcd]                           dc.b $00
[00005fce]                           dc.b $00
[00005fcf]                           dc.b $00
[00005fd0]                           dc.b $00
[00005fd1]                           dc.b $00
[00005fd2]                           dc.b $00
[00005fd3]                           dc.b $00
[00005fd4]                           dc.b $00
[00005fd5]                           dc.b $00
[00005fd6]                           dc.b $00
[00005fd7]                           dc.b $00
[00005fd8]                           dc.b $00
[00005fd9]                           dc.b $00
[00005fda]                           dc.b $00
[00005fdb]                           dc.b $00
[00005fdc]                           dc.b $00
[00005fdd]                           dc.b $00
[00005fde]                           dc.b $00
[00005fdf]                           dc.b $00
[00005fe0]                           dc.b $00
[00005fe1]                           dc.b $00
[00005fe2]                           dc.b $00
[00005fe3]                           dc.b $00
[00005fe4]                           dc.b $00
[00005fe5]                           dc.b $00
[00005fe6]                           dc.b $00
[00005fe7]                           dc.b $00
[00005fe8]                           dc.b $00
[00005fe9]                           dc.b $00
[00005fea]                           dc.b $00
[00005feb]                           dc.b $00
[00005fec]                           dc.b $00
[00005fed]                           dc.b $00
[00005fee]                           dc.b $00
[00005fef]                           dc.b $00
[00005ff0]                           dc.b $00
[00005ff1]                           dc.b $00
[00005ff2]                           dc.b $00
[00005ff3]                           dc.b $00
[00005ff4]                           dc.b $00
[00005ff5]                           dc.b $00
[00005ff6]                           dc.b $00
[00005ff7]                           dc.b $00
[00005ff8]                           dc.b $00
[00005ff9]                           dc.b $00
[00005ffa]                           dc.b $00
[00005ffb]                           dc.b $00
[00005ffc]                           dc.b $00
[00005ffd]                           dc.b $00
[00005ffe]                           dc.b $00
[00005fff]                           dc.b $00
[00006000]                           dc.b $00
[00006001]                           dc.b $00
[00006002]                           dc.b $00
[00006003]                           dc.b $00
[00006004]                           dc.b $00
[00006005]                           dc.b $00
[00006006]                           dc.b $00
[00006007]                           dc.b $00
[00006008]                           dc.b $00
[00006009]                           dc.b $00
[0000600a]                           dc.b $00
[0000600b]                           dc.b $00
[0000600c]                           dc.b $00
[0000600d]                           dc.b $00
[0000600e]                           dc.b $00
[0000600f]                           dc.b $00
[00006010]                           dc.b $00
[00006011]                           dc.b $00
[00006012]                           dc.b $00
[00006013]                           dc.b $00
[00006014]                           dc.b $00
[00006015]                           dc.b $00
[00006016]                           dc.b $00
[00006017]                           dc.b $00
[00006018]                           dc.b $00
[00006019]                           dc.b $00
[0000601a]                           dc.b $00
[0000601b]                           dc.b $00
[0000601c]                           dc.b $00
[0000601d]                           dc.b $00
[0000601e]                           dc.b $00
[0000601f]                           dc.b $00
[00006020]                           dc.b $00
[00006021]                           dc.b $00
[00006022]                           dc.b $00
[00006023]                           dc.b $00
[00006024]                           dc.b $00
[00006025]                           dc.b $00
[00006026]                           dc.b $00
[00006027]                           dc.b $00
[00006028]                           dc.b $00
[00006029]                           dc.b $00
[0000602a]                           dc.b $00
[0000602b]                           dc.b $00
[0000602c]                           dc.b $00
[0000602d]                           dc.b $00
[0000602e]                           dc.b $00
[0000602f]                           dc.b $00
[00006030]                           dc.b $00
[00006031]                           dc.b $00
[00006032]                           dc.b $00
[00006033]                           dc.b $00
[00006034]                           dc.b $00
[00006035]                           dc.b $00
[00006036]                           dc.b $00
[00006037]                           dc.b $00
[00006038]                           dc.b $00
[00006039]                           dc.b $00
[0000603a]                           dc.b $00
[0000603b]                           dc.b $00
[0000603c]                           dc.b $00
[0000603d]                           dc.b $00
[0000603e]                           dc.b $00
[0000603f]                           dc.b $00
[00006040]                           dc.b $00
[00006041]                           dc.b $00
[00006042]                           dc.b $00
[00006043]                           dc.b $00
[00006044]                           dc.b $00
[00006045]                           dc.b $00
[00006046]                           dc.b $00
[00006047]                           dc.b $00
[00006048] 00020c5a                  dc.l $00020c5a ; no symbol found
[0000604c]                           dc.b $00
[0000604d]                           dc.b $00
[0000604e]                           dc.b $00
[0000604f]                           dc.b $0e
[00006050] 00020c56                  dc.l $00020c56 ; no symbol found
[00006054]                           dc.b $00
[00006055]                           dc.b $00
[00006056]                           dc.b $00
[00006057]                           dc.b $0e
[00006058] 00020c50                  dc.l $00020c50 ; no symbol found
[0000605c]                           dc.b $00
[0000605d]                           dc.b $00
[0000605e]                           dc.b $00
[0000605f]                           dc.b $0b
[00006060] 00020c4a                  dc.l $00020c4a ; no symbol found
[00006064]                           dc.b $00
[00006065]                           dc.b $00
[00006066]                           dc.b $00
[00006067]                           dc.b $0c
[00006068] 00020c44                  dc.l $00020c44 ; no symbol found
[0000606c]                           dc.b $00
[0000606d]                           dc.b $00
[0000606e]                           dc.b $00
[0000606f]                           dc.b $12
[00006070] 00020c3e                  dc.l $00020c3e ; no symbol found
[00006074]                           dc.b $00
[00006075]                           dc.b $00
[00006076]                           dc.b $00
[00006077]                           dc.b $0b
[00006078] 00020c38                  dc.l $00020c38 ; no symbol found
[0000607c]                           dc.b $00
[0000607d]                           dc.b $00
[0000607e]                           dc.b $00
[0000607f]                           dc.b $0c
[00006080] 00020c32                  dc.l $00020c32 ; no symbol found
[00006084]                           dc.b $00
[00006085]                           dc.b $00
[00006086]                           dc.b $00
[00006087]                           dc.b $12
[00006088] 00020c2b                  dc.l $00020c2b ; no symbol found
[0000608c]                           dc.b $00
[0000608d]                           dc.b $00
[0000608e]                           dc.b $00
[0000608f]                           dc.b $0d
[00006090] 00020c24                  dc.l $00020c24 ; no symbol found
[00006094]                           dc.b $00
[00006095]                           dc.b $00
[00006096]                           dc.b $00
[00006097]                           dc.b $16
[00006098] 00020c1d                  dc.l $00020c1d ; no symbol found
[0000609c]                           dc.b $00
[0000609d]                           dc.b $00
[0000609e]                           dc.b $00
[0000609f]                           dc.b $0f
[000060a0] 00020c16                  dc.l $00020c16 ; no symbol found
[000060a4]                           dc.b $00
[000060a5]                           dc.b $00
[000060a6]                           dc.b $00
[000060a7]                           dc.b $15
[000060a8] 00020c0f                  dc.l $00020c0f ; no symbol found
[000060ac]                           dc.b $00
[000060ad]                           dc.b $00
[000060ae]                           dc.b $00
[000060af]                           dc.b $0d
[000060b0] 00020c08                  dc.l $00020c08 ; no symbol found
[000060b4]                           dc.b $00
[000060b5]                           dc.b $00
[000060b6]                           dc.b $00
[000060b7]                           dc.b $16
[000060b8] 00020c01                  dc.l $00020c01 ; no symbol found
[000060bc]                           dc.b $00
[000060bd]                           dc.b $00
[000060be]                           dc.b $00
[000060bf]                           dc.b $0f
[000060c0] 00020bfa                  dc.l $00020bfa ; no symbol found
[000060c4]                           dc.b $00
[000060c5]                           dc.b $00
[000060c6]                           dc.b $00
[000060c7]                           dc.b $15
[000060c8] 00020bf2                  dc.l $00020bf2 ; no symbol found
[000060cc]                           dc.b $00
[000060cd]                           dc.b $00
[000060ce]                           dc.b $00
[000060cf]                           dc.b $0a
[000060d0] 00020bea                  dc.l $00020bea ; no symbol found
[000060d4]                           dc.b $00
[000060d5]                           dc.b $00
[000060d6]                           dc.b $00
[000060d7]                           dc.b $10
[000060d8] 00020be2                  dc.l $00020be2 ; no symbol found
[000060dc]                           dc.b $00
[000060dd]                           dc.b $00
[000060de]                           dc.b $00
[000060df]                           dc.b $13
[000060e0] 00020bda                  dc.l $00020bda ; no symbol found
[000060e4]                           dc.b $00
[000060e5]                           dc.b $00
[000060e6]                           dc.b $00
[000060e7]                           dc.b $0a
[000060e8] 00020bd2                  dc.l $00020bd2 ; no symbol found
[000060ec]                           dc.b $00
[000060ed]                           dc.b $00
[000060ee]                           dc.b $00
[000060ef]                           dc.b $10
[000060f0] 00020bca                  dc.l $00020bca ; no symbol found
[000060f4]                           dc.b $00
[000060f5]                           dc.b $00
[000060f6]                           dc.b $00
[000060f7]                           dc.b $13
[000060f8] 00020bc1                  dc.l $00020bc1 ; no symbol found
[000060fc]                           dc.b $00
[000060fd]                           dc.b $00
[000060fe]                           dc.b $00
[000060ff]                           dc.b $11
[00006100] 00020bb8                  dc.l $00020bb8 ; no symbol found
[00006104]                           dc.b $00
[00006105]                           dc.b $00
[00006106]                           dc.b $00
[00006107]                           dc.b $11
[00006108]                           dc.w $0769
[0000610a]                           dc.b 'nclude',0
[00006111]                           dc.b $07
[00006112]                           dc.b 'INCLUDE',0
[0000611a]                           dc.w $0670
[0000611c]                           dc.b 'ragma',0
[00006122]                           dc.w $0669
[00006124]                           dc.b 'fndef',0
[0000612a]                           dc.w $0664
[0000612c]                           dc.b 'efine',0
[00006132]                           dc.w $0650
[00006134]                           dc.b 'RAGMA',0
[0000613a]                           dc.w $0649
[0000613c]                           dc.b 'FNDEF',0
[00006142]                           dc.w $0644
[00006144]                           dc.b 'EFINE',0
[0000614a]                           dc.w $0575
[0000614c]                           dc.b 'ndef',0
[00006151]                           dc.b $05
[00006152]                           dc.b 'ifdef',0
[00006158]                           dc.w $0565
[0000615a]                           dc.b 'rror',0
[0000615f]                           dc.b $05
[00006160]                           dc.b 'endif',0
[00006166]                           dc.w $0555
[00006168]                           dc.b 'NDEF',0
[0000616d]                           dc.b $05
[0000616e]                           dc.b 'IFDEF',0
[00006174]                           dc.w $0545
[00006176]                           dc.b 'RROR',0
[0000617b]                           dc.b $05
[0000617c]                           dc.b 'ENDIF',0
[00006182]                           dc.w $046c
[00006184]                           dc.b 'ine',0
[00006188]                           dc.w $0465
[0000618a]                           dc.b 'lse',0
[0000618e]                           dc.w $0465
[00006190]                           dc.b 'lif',0
[00006194]                           dc.w $044c
[00006196]                           dc.b 'INE',0
[0000619a]                           dc.w $0445
[0000619c]                           dc.b 'LSE',0
[000061a0]                           dc.w $0445
[000061a2]                           dc.b 'LIF',0
[000061a6]                           dc.w $0269
[000061a8]                           dc.w $6600
[000061aa]                           dc.w $0249
[000061ac]                           dc.w $4600
[000061ae] 00001e30                  dc.l $00001e30 ; no symbol found
[000061b2]                           dc.b $00
[000061b3]                           dc.b $00
[000061b4]                           dc.b $00
[000061b5]                           dc.b $10
[000061b6] 00001e30                  dc.l $00001e30 ; no symbol found
[000061ba]                           dc.b $00
[000061bb]                           dc.b $00
[000061bc]                           dc.b $00
[000061bd]                           dc.b $0f
[000061be] 00001e12                  dc.l $00001e12 ; no symbol found
[000061c2]                           dc.b $00
[000061c3]                           dc.b $00
[000061c4]                           dc.b $00
[000061c5]                           dc.b $0b
[000061c6] 00001e12                  dc.l $00001e12 ; no symbol found
[000061ca]                           dc.b $00
[000061cb]                           dc.b $00
[000061cc]                           dc.b $00
[000061cd]                           dc.b $0e
[000061ce] 00001e0e                  dc.l $00001e0e ; no symbol found
[000061d2]                           dc.b $00
[000061d3]                           dc.b $00
[000061d4]                           dc.b $00
[000061d5]                           dc.b $14
[000061d6] 00001e0a                  dc.l $00001e0a ; no symbol found
[000061da]                           dc.b $00
[000061db]                           dc.b $00
[000061dc]                           dc.b $00
[000061dd]                           dc.b $15
[000061de] 00001e06                  dc.l $00001e06 ; no symbol found
[000061e2]                           dc.b $00
[000061e3]                           dc.b $00
[000061e4]                           dc.b $00
[000061e5]                           dc.b $0a
[000061e6] 00001df0                  dc.l $00001df0 ; no symbol found
[000061ea]                           dc.b $00
[000061eb]                           dc.b $00
[000061ec]                           dc.b $00
[000061ed]                           dc.b $11
[000061ee]                           dc.b $00
[000061ef]                           dc.b $00
[000061f0]                           dc.b $00
[000061f1]                           dc.b $00
[000061f2] 00001eb2                  dc.l $00001eb2 ; no symbol found
[000061f6]                           dc.b 'bad #%b',0
[000061fe]                           dc.b '#line inside macro',0
[00006211]                           dc.b $00
[00006212]                           dc.b $00
[00006213]                           dc.b $00
[00006214]                           dc.b $00
[00006215]                           dc.b $00
[00006216]                           dc.b $00
[00006217]                           dc.b $00
[00006218]                           dc.b $00
[00006219]                           dc.b $00
[0000621a]                           dc.b $00
[0000621b]                           dc.b $00
[0000621c]                           dc.b $00
[0000621d]                           dc.b $00
[0000621e]                           dc.w $0a00
[00006220]                           dc.b 'unbalanced comment in file',0
[0000623b]                           dc.b $00
[0000623c]                           dc.b 'folded line',0
[00006248]                           dc.b 'misplaced #%b',0
[00006256]                           dc.b 'can',$27,'t read map file: %p',0
[0000626e]                           dc.b 'can',$27,'t open map file: %p',0
[00006286]                           dc.b 'ccp',0
[0000628a]                           dc.w $6300
[0000628c]                           dc.b 'can',$27,'t create ',0
[0000629a]                           dc.b 'd*>err,i*,+lincl,+map*,+old,o*,+pas,p?,+std,s?,x:F <files>',0
[000062d5]                           dc.b $00
[000062d6]                           dc.b 'missing #endif',0
[000062e5]                           dc.b $00
[000062e6] 00002a5e                  dc.l $00002a5e ; no symbol found
[000062ea]                           dc.b $00
[000062eb]                           dc.b $00
[000062ec]                           dc.b $00
[000062ed]                           dc.b $14
[000062ee] 00002a12                  dc.l $00002a12 ; no symbol found
[000062f2]                           dc.b $00
[000062f3]                           dc.b $00
[000062f4]                           dc.b $00
[000062f5]                           dc.b $13
[000062f6] 000027a6                  dc.l $000027a6 ; no symbol found
[000062fa]                           dc.b $00
[000062fb]                           dc.b $00
[000062fc]                           dc.b $00
[000062fd]                           dc.b $12
[000062fe] 000026ec                  dc.l $000026ec ; no symbol found
[00006302]                           dc.b $00
[00006303]                           dc.b $00
[00006304]                           dc.b $00
[00006305]                           dc.b $11
[00006306] 000026b4                  dc.l $000026b4 ; no symbol found
[0000630a]                           dc.b $00
[0000630b]                           dc.b $00
[0000630c]                           dc.b $00
[0000630d]                           dc.b $15
[0000630e] 000025c4                  dc.l $000025c4 ; no symbol found
[00006312]                           dc.b $00
[00006313]                           dc.b $00
[00006314]                           dc.b $00
[00006315]                           dc.b $0a
[00006316] 00002524                  dc.l $00002524 ; no symbol found
[0000631a]                           dc.b $00
[0000631b]                           dc.b $00
[0000631c]                           dc.b $00
[0000631d]                           dc.b $16
[0000631e]                           dc.b $00
[0000631f]                           dc.b $00
[00006320]                           dc.b $00
[00006321]                           dc.b $00
[00006322] 00002a7c                  dc.l $00002a7c ; no symbol found
[00006326]                           dc.b 'bad #xxx',0
[0000632f]                           dc.b $63
[00006330]                           dc.b $00
[00006331]                           dc.b $63
[00006332]                           dc.b $00
[00006333]                           dc.b 'bad #line syntax',0
[00006344]                           dc.b 'bad #line',0
[0000634e]                           dc.b 'can',$27,'t open #include!',0
[00006363]                           dc.b 'can',$27,'t #include %p',0
[00006375]                           dc.b 'bad #undef',0
[00006380]                           dc.b 'redefined %b',0
[0000638d]                           dc.b 'bad #define',0
[00006399]                           dc.b $62
[0000639a]                           dc.b $00
[0000639b]                           dc.b $32
[0000639c]                           dc.b $00
[0000639d]                           dc.b $63
[0000639e]                           dc.b $00
[0000639f]                           dc.b $00
[000063a0]                           dc.b $00
[000063a1]                           dc.b $00
[000063a2]                           dc.b $00
[000063a3]                           dc.b $00
[000063a4]                           dc.b $00
[000063a5]                           dc.b $00
[000063a6]                           dc.b $00
[000063a7]                           dc.b $00
[000063a8]                           dc.b $00
[000063a9]                           dc.b $00
[000063aa]                           dc.b $00
[000063ab]                           dc.b $00
[000063ac]                           dc.b $00
[000063ad]                           dc.b $00
[000063ae]                           dc.b $00
[000063af]                           dc.b $00
[000063b0]                           dc.b $00
[000063b1]                           dc.b $00
[000063b2]                           dc.b $00
[000063b3]                           dc.b $00
[000063b4]                           dc.b $00
[000063b5]                           dc.b $00
[000063b6]                           dc.b $00
[000063b7]                           dc.b $00
[000063b8]                           dc.b $00
[000063b9]                           dc.b $00
[000063ba]                           dc.b $00
[000063bb]                           dc.b $00
[000063bc]                           dc.b $00
[000063bd]                           dc.b $00
[000063be]                           dc.b $00
[000063bf]                           dc.b $00
[000063c0]                           dc.b $00
[000063c1]                           dc.b $00
[000063c2]                           dc.b $00
[000063c3]                           dc.b $00
[000063c4]                           dc.b $00
[000063c5]                           dc.b $00
[000063c6]                           dc.b $00
[000063c7]                           dc.b $00
[000063c8]                           dc.b $00
[000063c9]                           dc.b $00
[000063ca]                           dc.b $00
[000063cb]                           dc.b $00
[000063cc]                           dc.b $00
[000063cd]                           dc.b $00
[000063ce]                           dc.b $00
[000063cf]                           dc.b $00
[000063d0]                           dc.b $00
[000063d1]                           dc.b $00
[000063d2]                           dc.b $00
[000063d3]                           dc.b $00
[000063d4]                           dc.b $00
[000063d5]                           dc.b $00
[000063d6]                           dc.b $00
[000063d7]                           dc.b $00
[000063d8]                           dc.b $00
[000063d9]                           dc.b $00
[000063da]                           dc.b $00
[000063db]                           dc.b $00
[000063dc]                           dc.b $00
[000063dd]                           dc.b $00
[000063de]                           dc.b $00
[000063df]                           dc.b $00
[000063e0]                           dc.b $00
[000063e1]                           dc.b $00
[000063e2]                           dc.b $00
[000063e3]                           dc.b $00
[000063e4]                           dc.b $00
[000063e5]                           dc.b $00
[000063e6]                           dc.b $00
[000063e7]                           dc.b $00
[000063e8]                           dc.b $00
[000063e9]                           dc.b $00
[000063ea]                           dc.b $00
[000063eb]                           dc.b $00
[000063ec]                           dc.b $00
[000063ed]                           dc.b $00
[000063ee]                           dc.b $00
[000063ef]                           dc.b $00
[000063f0]                           dc.b $00
[000063f1]                           dc.b $00
[000063f2]                           dc.b $00
[000063f3]                           dc.b $00
[000063f4]                           dc.b $00
[000063f5]                           dc.b $00
[000063f6]                           dc.b $00
[000063f7]                           dc.b $00
[000063f8]                           dc.b $00
[000063f9]                           dc.b $00
[000063fa]                           dc.b $00
[000063fb]                           dc.b $00
[000063fc]                           dc.b $00
[000063fd]                           dc.b $00
[000063fe]                           dc.b $00
[000063ff]                           dc.b $00
[00006400]                           dc.b $00
[00006401]                           dc.b $00
[00006402]                           dc.b $00
[00006403]                           dc.b $00
[00006404]                           dc.b $00
[00006405]                           dc.b $00
[00006406]                           dc.b $00
[00006407]                           dc.b $00
[00006408]                           dc.b $00
[00006409]                           dc.b $00
[0000640a]                           dc.b $00
[0000640b]                           dc.b $00
[0000640c]                           dc.b $00
[0000640d]                           dc.b $00
[0000640e]                           dc.b $00
[0000640f]                           dc.b $00
[00006410]                           dc.b $00
[00006411]                           dc.b $00
[00006412]                           dc.b $00
[00006413]                           dc.b $00
[00006414]                           dc.b $00
[00006415]                           dc.b $00
[00006416]                           dc.b $00
[00006417]                           dc.b $00
[00006418]                           dc.b $00
[00006419]                           dc.b $00
[0000641a]                           dc.b $00
[0000641b]                           dc.b $00
[0000641c]                           dc.b $00
[0000641d]                           dc.b $00
[0000641e]                           dc.b $00
[0000641f]                           dc.b $00
[00006420]                           dc.b $00
[00006421]                           dc.b $00
[00006422]                           dc.b $00
[00006423]                           dc.b $00
[00006424]                           dc.b $00
[00006425]                           dc.b $00
[00006426]                           dc.b $00
[00006427]                           dc.b $00
[00006428]                           dc.b $00
[00006429]                           dc.b $00
[0000642a]                           dc.b $00
[0000642b]                           dc.b $00
[0000642c]                           dc.b $00
[0000642d]                           dc.b $00
[0000642e]                           dc.b $00
[0000642f]                           dc.b $00
[00006430]                           dc.b $00
[00006431]                           dc.b $00
[00006432]                           dc.b $00
[00006433]                           dc.b $00
[00006434]                           dc.b $00
[00006435]                           dc.b $00
[00006436]                           dc.b $00
[00006437]                           dc.b $00
[00006438]                           dc.b $00
[00006439]                           dc.b $00
[0000643a]                           dc.b $00
[0000643b]                           dc.b $00
[0000643c]                           dc.b $00
[0000643d]                           dc.b $00
[0000643e]                           dc.b $00
[0000643f]                           dc.b $00
[00006440]                           dc.b $00
[00006441]                           dc.b $00
[00006442]                           dc.b $00
[00006443]                           dc.b $00
[00006444]                           dc.b $00
[00006445]                           dc.b $00
[00006446]                           dc.b $00
[00006447]                           dc.b $00
[00006448]                           dc.b $00
[00006449]                           dc.b $00
[0000644a]                           dc.b $00
[0000644b]                           dc.b $00
[0000644c]                           dc.b $00
[0000644d]                           dc.b $00
[0000644e]                           dc.b $00
[0000644f]                           dc.b $00
[00006450]                           dc.b $00
[00006451]                           dc.b $00
[00006452]                           dc.b $00
[00006453]                           dc.b $00
[00006454]                           dc.b $00
[00006455]                           dc.b $00
[00006456]                           dc.b $00
[00006457]                           dc.b $00
[00006458]                           dc.b $00
[00006459]                           dc.b $00
[0000645a]                           dc.b $00
[0000645b]                           dc.b $00
[0000645c]                           dc.b $00
[0000645d]                           dc.b $00
[0000645e]                           dc.b $00
[0000645f]                           dc.b $00
[00006460]                           dc.b $00
[00006461]                           dc.b $00
[00006462]                           dc.b $00
[00006463]                           dc.b $00
[00006464]                           dc.b $00
[00006465]                           dc.b $00
[00006466]                           dc.b $00
[00006467]                           dc.b $00
[00006468]                           dc.b $00
[00006469]                           dc.b $00
[0000646a]                           dc.b $00
[0000646b]                           dc.b $00
[0000646c]                           dc.b $00
[0000646d]                           dc.b $00
[0000646e]                           dc.b $00
[0000646f]                           dc.b $00
[00006470]                           dc.b $00
[00006471]                           dc.b $00
[00006472]                           dc.b $00
[00006473]                           dc.b $00
[00006474]                           dc.b $00
[00006475]                           dc.b $00
[00006476]                           dc.b $00
[00006477]                           dc.b $00
[00006478]                           dc.b $00
[00006479]                           dc.b $00
[0000647a]                           dc.b $00
[0000647b]                           dc.b $00
[0000647c]                           dc.b $00
[0000647d]                           dc.b $00
[0000647e]                           dc.b $00
[0000647f]                           dc.b $00
[00006480]                           dc.b $00
[00006481]                           dc.b $00
[00006482]                           dc.b $00
[00006483]                           dc.b $00
[00006484]                           dc.b $00
[00006485]                           dc.b $00
[00006486]                           dc.b $00
[00006487]                           dc.b $00
[00006488]                           dc.b $00
[00006489]                           dc.b $00
[0000648a]                           dc.b $00
[0000648b]                           dc.b $00
[0000648c]                           dc.b $00
[0000648d]                           dc.b $00
[0000648e]                           dc.b $00
[0000648f]                           dc.b $00
[00006490]                           dc.b $00
[00006491]                           dc.b $00
[00006492]                           dc.b $00
[00006493]                           dc.b $00
[00006494]                           dc.b $00
[00006495]                           dc.b $00
[00006496]                           dc.b $00
[00006497]                           dc.b $00
[00006498]                           dc.b $00
[00006499]                           dc.b $00
[0000649a]                           dc.b $00
[0000649b]                           dc.b $00
[0000649c]                           dc.b $00
[0000649d]                           dc.b $00
[0000649e]                           dc.b $00
[0000649f]                           dc.b $00
[000064a0]                           dc.b $00
[000064a1]                           dc.b $00
[000064a2]                           dc.b $00
[000064a3]                           dc.b $00
[000064a4]                           dc.b $00
[000064a5]                           dc.b $00
[000064a6]                           dc.b $00
[000064a7]                           dc.b $00
[000064a8]                           dc.b $00
[000064a9]                           dc.b $00
[000064aa]                           dc.b $00
[000064ab]                           dc.b $00
[000064ac]                           dc.b $00
[000064ad]                           dc.b $00
[000064ae]                           dc.b $00
[000064af]                           dc.b $00
[000064b0]                           dc.b $00
[000064b1]                           dc.b $00
[000064b2]                           dc.b $00
[000064b3]                           dc.b $00
[000064b4]                           dc.b $00
[000064b5]                           dc.b $00
[000064b6]                           dc.b $00
[000064b7]                           dc.b $00
[000064b8]                           dc.b $00
[000064b9]                           dc.b $00
[000064ba]                           dc.b $00
[000064bb]                           dc.b $00
[000064bc]                           dc.b $00
[000064bd]                           dc.b $00
[000064be]                           dc.b $00
[000064bf]                           dc.b $00
[000064c0]                           dc.b $00
[000064c1]                           dc.b $00
[000064c2]                           dc.b $00
[000064c3]                           dc.b $00
[000064c4]                           dc.b $00
[000064c5]                           dc.b $00
[000064c6]                           dc.b $00
[000064c7]                           dc.b $00
[000064c8]                           dc.b $00
[000064c9]                           dc.b $00
[000064ca]                           dc.b $00
[000064cb]                           dc.b $00
[000064cc]                           dc.b $00
[000064cd]                           dc.b $00
[000064ce]                           dc.b $00
[000064cf]                           dc.b $00
[000064d0]                           dc.b $00
[000064d1]                           dc.b $00
[000064d2]                           dc.b $00
[000064d3]                           dc.b $00
[000064d4]                           dc.b $00
[000064d5]                           dc.b $00
[000064d6]                           dc.b $00
[000064d7]                           dc.b $00
[000064d8]                           dc.b $00
[000064d9]                           dc.b $00
[000064da]                           dc.b $00
[000064db]                           dc.b $00
[000064dc]                           dc.b $00
[000064dd]                           dc.b $00
[000064de]                           dc.b $00
[000064df]                           dc.b $00
[000064e0]                           dc.b $00
[000064e1]                           dc.b $00
[000064e2]                           dc.b $00
[000064e3]                           dc.b $00
[000064e4]                           dc.b $00
[000064e5]                           dc.b $00
[000064e6]                           dc.b $00
[000064e7]                           dc.b $00
[000064e8]                           dc.b $00
[000064e9]                           dc.b $00
[000064ea]                           dc.b $00
[000064eb]                           dc.b $00
[000064ec]                           dc.b $00
[000064ed]                           dc.b $00
[000064ee]                           dc.b $00
[000064ef]                           dc.b $00
[000064f0]                           dc.b $00
[000064f1]                           dc.b $00
[000064f2]                           dc.b $00
[000064f3]                           dc.b $00
[000064f4]                           dc.b $00
[000064f5]                           dc.b $00
[000064f6]                           dc.b $00
[000064f7]                           dc.b $00
[000064f8]                           dc.b $00
[000064f9]                           dc.b $00
[000064fa]                           dc.b $00
[000064fb]                           dc.b $00
[000064fc]                           dc.b $00
[000064fd]                           dc.b $00
[000064fe]                           dc.b $00
[000064ff]                           dc.b $00
[00006500]                           dc.b $00
[00006501]                           dc.b $00
[00006502]                           dc.b $00
[00006503]                           dc.b $00
[00006504]                           dc.b $00
[00006505]                           dc.b $00
[00006506]                           dc.b $00
[00006507]                           dc.b $00
[00006508]                           dc.b $00
[00006509]                           dc.b $00
[0000650a]                           dc.b $00
[0000650b]                           dc.b $00
[0000650c]                           dc.b $00
[0000650d]                           dc.b $00
[0000650e]                           dc.b $00
[0000650f]                           dc.b $00
[00006510]                           dc.b $00
[00006511]                           dc.b $00
[00006512]                           dc.b $00
[00006513]                           dc.b $00
[00006514]                           dc.b $00
[00006515]                           dc.b $00
[00006516]                           dc.b $00
[00006517]                           dc.b $00
[00006518]                           dc.b $00
[00006519]                           dc.b $00
[0000651a]                           dc.b $00
[0000651b]                           dc.b $00
[0000651c]                           dc.b $00
[0000651d]                           dc.b $00
[0000651e]                           dc.b $00
[0000651f]                           dc.b $00
[00006520]                           dc.b $00
[00006521]                           dc.b $00
[00006522]                           dc.b $00
[00006523]                           dc.b $00
[00006524]                           dc.b $00
[00006525]                           dc.b $00
[00006526]                           dc.b $00
[00006527]                           dc.b $00
[00006528]                           dc.b $00
[00006529]                           dc.b $00
[0000652a]                           dc.b $00
[0000652b]                           dc.b $00
[0000652c]                           dc.b $00
[0000652d]                           dc.b $00
[0000652e]                           dc.b $00
[0000652f]                           dc.b $00
[00006530]                           dc.b $00
[00006531]                           dc.b $00
[00006532]                           dc.b $00
[00006533]                           dc.b $00
[00006534]                           dc.b $00
[00006535]                           dc.b $00
[00006536]                           dc.b $00
[00006537]                           dc.b $00
[00006538]                           dc.b $00
[00006539]                           dc.b $00
[0000653a]                           dc.b $00
[0000653b]                           dc.b $00
[0000653c]                           dc.b $00
[0000653d]                           dc.b $00
[0000653e]                           dc.b $00
[0000653f]                           dc.b $00
[00006540]                           dc.b $00
[00006541]                           dc.b $00
[00006542]                           dc.b $00
[00006543]                           dc.b $00
[00006544]                           dc.b $00
[00006545]                           dc.b $00
[00006546]                           dc.b $00
[00006547]                           dc.b $00
[00006548]                           dc.b $00
[00006549]                           dc.b $00
[0000654a]                           dc.b $00
[0000654b]                           dc.b $00
[0000654c]                           dc.b $00
[0000654d]                           dc.b $00
[0000654e]                           dc.b $00
[0000654f]                           dc.b $00
[00006550]                           dc.b $00
[00006551]                           dc.b $00
[00006552]                           dc.b $00
[00006553]                           dc.b $00
[00006554]                           dc.b $00
[00006555]                           dc.b $00
[00006556]                           dc.b $00
[00006557]                           dc.b $00
[00006558]                           dc.b $00
[00006559]                           dc.b $00
[0000655a]                           dc.b $00
[0000655b]                           dc.b $00
[0000655c]                           dc.b $00
[0000655d]                           dc.b $00
[0000655e]                           dc.b $00
[0000655f]                           dc.b $00
[00006560]                           dc.b $00
[00006561]                           dc.b $00
[00006562]                           dc.b $00
[00006563]                           dc.b $00
[00006564]                           dc.b $00
[00006565]                           dc.b $00
[00006566]                           dc.b $00
[00006567]                           dc.b $00
[00006568]                           dc.b $00
[00006569]                           dc.b $00
[0000656a]                           dc.b $00
[0000656b]                           dc.b $00
[0000656c]                           dc.b $00
[0000656d]                           dc.b $00
[0000656e]                           dc.b $00
[0000656f]                           dc.b $00
[00006570]                           dc.b $00
[00006571]                           dc.b $00
[00006572]                           dc.b $00
[00006573]                           dc.b $00
[00006574]                           dc.b $00
[00006575]                           dc.b $00
[00006576]                           dc.b $00
[00006577]                           dc.b $00
[00006578]                           dc.b $00
[00006579]                           dc.b $00
[0000657a]                           dc.b $00
[0000657b]                           dc.b $00
[0000657c]                           dc.b $00
[0000657d]                           dc.b $00
[0000657e]                           dc.b $00
[0000657f]                           dc.b $00
[00006580]                           dc.b $00
[00006581]                           dc.b $00
[00006582]                           dc.b $00
[00006583]                           dc.b $00
[00006584]                           dc.b $00
[00006585]                           dc.b $00
[00006586]                           dc.b $00
[00006587]                           dc.b $00
[00006588]                           dc.b $00
[00006589]                           dc.b $00
[0000658a]                           dc.b $00
[0000658b]                           dc.b $00
[0000658c]                           dc.b $00
[0000658d]                           dc.b $00
[0000658e]                           dc.b $00
[0000658f]                           dc.b $00
[00006590]                           dc.b $00
[00006591]                           dc.b $00
[00006592]                           dc.b $00
[00006593]                           dc.b $00
[00006594]                           dc.b $00
[00006595]                           dc.b $00
[00006596]                           dc.b $00
[00006597]                           dc.b $00
[00006598]                           dc.b $00
[00006599]                           dc.b $00
[0000659a]                           dc.b $00
[0000659b]                           dc.b $00
[0000659c]                           dc.b $00
[0000659d]                           dc.b $00
[0000659e]                           dc.b $00
[0000659f]                           dc.b $00
[000065a0]                           dc.b $00
[000065a1]                           dc.b $00
[000065a2]                           dc.b $00
[000065a3]                           dc.b $00
[000065a4]                           dc.b 'can',$27,'t open %p',0
[000065b2]                           dc.w $6362
[000065b4]                           dc.b $00
[000065b5]                           dc.b $0a
[000065b6]                           dc.b $00
[000065b7]                           dc.b $09
[000065b8]                           dc.b $00
[000065b9]                           dc.b $3a
[000065ba]                           dc.b $00
[000065bb]                           dc.b $20
[000065bc]                           dc.b $00
[000065bd]                           dc.b '#error ',0
[000065c5]                           dc.b '%p%p%p%p%p%s%p',0
[000065d4]                           dc.b 'EOF: ',0
[000065da]                           dc.b '-d %b redefined',0
[000065ea]                           dc.b ' 1',$0a,0
[000065ee]                           dc.w $283d
[000065f0]                           dc.b $00
[000065f1]                           dc.b $00
[000065f2]                           dc.w $6332
[000065f4]                           dc.b $00
[000065f5]                           dc.b $00
[000065f6]                           dc.w $0a00
[000065f8]                           dc.b 'unbalanced %c',0
[00006606]                           dc.w $2d00
[00006608]                           dc.w $0a00
[0000660a]                           dc.w $5d00
[0000660c]                           dc.w $2000
[0000660e]                           dc.w $5e00
[00006610]                           dc.w $2000
[00006612]                           dc.w $2d5b
[00006614]                           dc.b $00
[00006615]                           dc.b $00
[00006616] 00003da4                  dc.l $00003da4 ; no symbol found
[0000661a]                           dc.b $00
[0000661b]                           dc.b $00
[0000661c]                           dc.b $00
[0000661d]                           dc.b $3e
[0000661e] 00003d42                  dc.l $00003d42 ; no symbol found
[00006622]                           dc.b $00
[00006623]                           dc.b $00
[00006624]                           dc.b $00
[00006625]                           dc.b $00
[00006626] 00003d42                  dc.l $00003d42 ; no symbol found
[0000662a]                           dc.b $00
[0000662b]                           dc.b $00
[0000662c]                           dc.b $00
[0000662d]                           dc.b $3a
[0000662e] 00003d42                  dc.l $00003d42 ; no symbol found
[00006632]                           dc.b $00
[00006633]                           dc.b $00
[00006634]                           dc.b $00
[00006635]                           dc.b $2c
[00006636] 00003cb8                  dc.l $00003cb8 ; no symbol found
[0000663a]                           dc.b $00
[0000663b]                           dc.b $00
[0000663c]                           dc.b $00
[0000663d]                           dc.b $23
[0000663e] 00003c7c                  dc.l $00003c7c ; no symbol found
[00006642]                           dc.b $00
[00006643]                           dc.b $00
[00006644]                           dc.b $00
[00006645]                           dc.b $3f
[00006646] 00003c0c                  dc.l $00003c0c ; no symbol found
[0000664a]                           dc.b $00
[0000664b]                           dc.b $00
[0000664c]                           dc.b $00
[0000664d]                           dc.b $2a
[0000664e]                           dc.b $00
[0000664f]                           dc.b $00
[00006650]                           dc.b $00
[00006651]                           dc.b $00
[00006652] 00003e4c                  dc.l $00003e4c ; no symbol found
[00006656]                           dc.b 'help',0
[0000665b]                           dc.b $2d
[0000665c]                           dc.b $00
[0000665d]                           dc.b $2d
[0000665e]                           dc.w $2d00
[00006660]                           dc.w $0a09
[00006662]                           dc.b $00
[00006663]                           dc.b $00
_stdout:
[00006664]                           dc.b $00
[00006665]                           dc.b $01
[00006666]                           dc.b $00
[00006667]                           dc.b $00
[00006668]                           dc.b $00
[00006669]                           dc.b $01
[0000666a]                           dc.b $00
[0000666b]                           dc.b $00
[0000666c]                           dc.b $00
[0000666d]                           dc.b $00
[0000666e]                           dc.b $00
[0000666f]                           dc.b $00
[00006670]                           dc.b $00
[00006671]                           dc.b $00
[00006672]                           dc.b $00
[00006673]                           dc.b $00
[00006674]                           dc.b $00
[00006675]                           dc.b $00
[00006676]                           dc.b $00
[00006677]                           dc.b $00
[00006678]                           dc.b $00
[00006679]                           dc.b $00
[0000667a]                           dc.b $00
[0000667b]                           dc.b $00
[0000667c]                           dc.b $00
[0000667d]                           dc.b $00
[0000667e]                           dc.b $00
[0000667f]                           dc.b $00
[00006680]                           dc.b $00
[00006681]                           dc.b $00
[00006682]                           dc.b $00
[00006683]                           dc.b $00
[00006684]                           dc.b $00
[00006685]                           dc.b $00
[00006686]                           dc.b $00
[00006687]                           dc.b $00
[00006688]                           dc.b $00
[00006689]                           dc.b $00
[0000668a]                           dc.b $00
[0000668b]                           dc.b $00
[0000668c]                           dc.b $00
[0000668d]                           dc.b $00
[0000668e]                           dc.b $00
[0000668f]                           dc.b $00
[00006690]                           dc.b $00
[00006691]                           dc.b $00
[00006692]                           dc.b $00
[00006693]                           dc.b $00
[00006694]                           dc.b $00
[00006695]                           dc.b $00
[00006696]                           dc.b $00
[00006697]                           dc.b $00
[00006698]                           dc.b $00
[00006699]                           dc.b $00
[0000669a]                           dc.b $00
[0000669b]                           dc.b $00
[0000669c]                           dc.b $00
[0000669d]                           dc.b $00
[0000669e]                           dc.b $00
[0000669f]                           dc.b $00
[000066a0]                           dc.b $00
[000066a1]                           dc.b $00
[000066a2]                           dc.b $00
[000066a3]                           dc.b $00
[000066a4]                           dc.b $00
[000066a5]                           dc.b $00
[000066a6]                           dc.b $00
[000066a7]                           dc.b $00
[000066a8]                           dc.b $00
[000066a9]                           dc.b $00
[000066aa]                           dc.b $00
[000066ab]                           dc.b $00
[000066ac]                           dc.b $00
[000066ad]                           dc.b $00
[000066ae]                           dc.b $00
[000066af]                           dc.b $00
[000066b0]                           dc.b $00
[000066b1]                           dc.b $00
[000066b2]                           dc.b $00
[000066b3]                           dc.b $00
[000066b4]                           dc.b $00
[000066b5]                           dc.b $00
[000066b6]                           dc.b $00
[000066b7]                           dc.b $00
[000066b8]                           dc.b $00
[000066b9]                           dc.b $00
[000066ba]                           dc.b $00
[000066bb]                           dc.b $00
[000066bc]                           dc.b $00
[000066bd]                           dc.b $00
[000066be]                           dc.b $00
[000066bf]                           dc.b $00
[000066c0]                           dc.b $00
[000066c1]                           dc.b $00
[000066c2]                           dc.b $00
[000066c3]                           dc.b $00
[000066c4]                           dc.b $00
[000066c5]                           dc.b $00
[000066c6]                           dc.b $00
[000066c7]                           dc.b $00
[000066c8]                           dc.b $00
[000066c9]                           dc.b $00
[000066ca]                           dc.b $00
[000066cb]                           dc.b $00
[000066cc]                           dc.b $00
[000066cd]                           dc.b $00
[000066ce]                           dc.b $00
[000066cf]                           dc.b $00
[000066d0]                           dc.b $00
[000066d1]                           dc.b $00
[000066d2]                           dc.b $00
[000066d3]                           dc.b $00
[000066d4]                           dc.b $00
[000066d5]                           dc.b $00
[000066d6]                           dc.b $00
[000066d7]                           dc.b $00
[000066d8]                           dc.b $00
[000066d9]                           dc.b $00
[000066da]                           dc.b $00
[000066db]                           dc.b $00
[000066dc]                           dc.b $00
[000066dd]                           dc.b $00
[000066de]                           dc.b $00
[000066df]                           dc.b $00
[000066e0]                           dc.b $00
[000066e1]                           dc.b $00
[000066e2]                           dc.b $00
[000066e3]                           dc.b $00
[000066e4]                           dc.b $00
[000066e5]                           dc.b $00
[000066e6]                           dc.b $00
[000066e7]                           dc.b $00
[000066e8]                           dc.b $00
[000066e9]                           dc.b $00
[000066ea]                           dc.b $00
[000066eb]                           dc.b $00
[000066ec]                           dc.b $00
[000066ed]                           dc.b $00
[000066ee]                           dc.b $00
[000066ef]                           dc.b $00
[000066f0]                           dc.b $00
[000066f1]                           dc.b $00
[000066f2]                           dc.b $00
[000066f3]                           dc.b $00
[000066f4]                           dc.b $00
[000066f5]                           dc.b $00
[000066f6]                           dc.b $00
[000066f7]                           dc.b $00
[000066f8]                           dc.b $00
[000066f9]                           dc.b $00
[000066fa]                           dc.b $00
[000066fb]                           dc.b $00
[000066fc]                           dc.b $00
[000066fd]                           dc.b $00
[000066fe]                           dc.b $00
[000066ff]                           dc.b $00
[00006700]                           dc.b $00
[00006701]                           dc.b $00
[00006702]                           dc.b $00
[00006703]                           dc.b $00
[00006704]                           dc.b $00
[00006705]                           dc.b $00
[00006706]                           dc.b $00
[00006707]                           dc.b $00
[00006708]                           dc.b $00
[00006709]                           dc.b $00
[0000670a]                           dc.b $00
[0000670b]                           dc.b $00
[0000670c]                           dc.b $00
[0000670d]                           dc.b $00
[0000670e]                           dc.b $00
[0000670f]                           dc.b $00
[00006710]                           dc.b $00
[00006711]                           dc.b $00
[00006712]                           dc.b $00
[00006713]                           dc.b $00
[00006714]                           dc.b $00
[00006715]                           dc.b $00
[00006716]                           dc.b $00
[00006717]                           dc.b $00
[00006718]                           dc.b $00
[00006719]                           dc.b $00
[0000671a]                           dc.b $00
[0000671b]                           dc.b $00
[0000671c]                           dc.b $00
[0000671d]                           dc.b $00
[0000671e]                           dc.b $00
[0000671f]                           dc.b $00
[00006720]                           dc.b $00
[00006721]                           dc.b $00
[00006722]                           dc.b $00
[00006723]                           dc.b $00
[00006724]                           dc.b $00
[00006725]                           dc.b $00
[00006726]                           dc.b $00
[00006727]                           dc.b $00
[00006728]                           dc.b $00
[00006729]                           dc.b $00
[0000672a]                           dc.b $00
[0000672b]                           dc.b $00
[0000672c]                           dc.b $00
[0000672d]                           dc.b $00
[0000672e]                           dc.b $00
[0000672f]                           dc.b $00
[00006730]                           dc.b $00
[00006731]                           dc.b $00
[00006732]                           dc.b $00
[00006733]                           dc.b $00
[00006734]                           dc.b $00
[00006735]                           dc.b $00
[00006736]                           dc.b $00
[00006737]                           dc.b $00
[00006738]                           dc.b $00
[00006739]                           dc.b $00
[0000673a]                           dc.b $00
[0000673b]                           dc.b $00
[0000673c]                           dc.b $00
[0000673d]                           dc.b $00
[0000673e]                           dc.b $00
[0000673f]                           dc.b $00
[00006740]                           dc.b $00
[00006741]                           dc.b $00
[00006742]                           dc.b $00
[00006743]                           dc.b $00
[00006744]                           dc.b $00
[00006745]                           dc.b $00
[00006746]                           dc.b $00
[00006747]                           dc.b $00
[00006748]                           dc.b $00
[00006749]                           dc.b $00
[0000674a]                           dc.b $00
[0000674b]                           dc.b $00
[0000674c]                           dc.b $00
[0000674d]                           dc.b $00
[0000674e]                           dc.b $00
[0000674f]                           dc.b $00
[00006750]                           dc.b $00
[00006751]                           dc.b $00
[00006752]                           dc.b $00
[00006753]                           dc.b $00
[00006754]                           dc.b $00
[00006755]                           dc.b $00
[00006756]                           dc.b $00
[00006757]                           dc.b $00
[00006758]                           dc.b $00
[00006759]                           dc.b $00
[0000675a]                           dc.b $00
[0000675b]                           dc.b $00
[0000675c]                           dc.b $00
[0000675d]                           dc.b $00
[0000675e]                           dc.b $00
[0000675f]                           dc.b $00
[00006760]                           dc.b $00
[00006761]                           dc.b $00
[00006762]                           dc.b $00
[00006763]                           dc.b $00
[00006764]                           dc.b $00
[00006765]                           dc.b $00
[00006766]                           dc.b $00
[00006767]                           dc.b $00
[00006768]                           dc.b $00
[00006769]                           dc.b $00
[0000676a]                           dc.b $00
[0000676b]                           dc.b $00
[0000676c]                           dc.b $00
[0000676d]                           dc.b $00
[0000676e]                           dc.b $00
[0000676f]                           dc.b $00
[00006770]                           dc.b $00
[00006771]                           dc.b $00
[00006772]                           dc.b $00
[00006773]                           dc.b $00
[00006774]                           dc.b $00
[00006775]                           dc.b $00
[00006776]                           dc.b $00
[00006777]                           dc.b $00
[00006778]                           dc.b $00
[00006779]                           dc.b $00
[0000677a]                           dc.b $00
[0000677b]                           dc.b $00
[0000677c]                           dc.b $00
[0000677d]                           dc.b $00
[0000677e]                           dc.b $00
[0000677f]                           dc.b $00
[00006780]                           dc.b $00
[00006781]                           dc.b $00
[00006782]                           dc.b $00
[00006783]                           dc.b $00
[00006784]                           dc.b $00
[00006785]                           dc.b $00
[00006786]                           dc.b $00
[00006787]                           dc.b $00
[00006788]                           dc.b $00
[00006789]                           dc.b $00
[0000678a]                           dc.b $00
[0000678b]                           dc.b $00
[0000678c]                           dc.b $00
[0000678d]                           dc.b $00
[0000678e]                           dc.b $00
[0000678f]                           dc.b $00
[00006790]                           dc.b $00
[00006791]                           dc.b $00
[00006792]                           dc.b $00
[00006793]                           dc.b $00
[00006794]                           dc.b $00
[00006795]                           dc.b $00
[00006796]                           dc.b $00
[00006797]                           dc.b $00
[00006798]                           dc.b $00
[00006799]                           dc.b $00
[0000679a]                           dc.b $00
[0000679b]                           dc.b $00
[0000679c]                           dc.b $00
[0000679d]                           dc.b $00
[0000679e]                           dc.b $00
[0000679f]                           dc.b $00
[000067a0]                           dc.b $00
[000067a1]                           dc.b $00
[000067a2]                           dc.b $00
[000067a3]                           dc.b $00
[000067a4]                           dc.b $00
[000067a5]                           dc.b $00
[000067a6]                           dc.b $00
[000067a7]                           dc.b $00
[000067a8]                           dc.b $00
[000067a9]                           dc.b $00
[000067aa]                           dc.b $00
[000067ab]                           dc.b $00
[000067ac]                           dc.b $00
[000067ad]                           dc.b $00
[000067ae]                           dc.b $00
[000067af]                           dc.b $00
[000067b0]                           dc.b $00
[000067b1]                           dc.b $00
[000067b2]                           dc.b $00
[000067b3]                           dc.b $00
[000067b4]                           dc.b $00
[000067b5]                           dc.b $00
[000067b6]                           dc.b $00
[000067b7]                           dc.b $00
[000067b8]                           dc.b $00
[000067b9]                           dc.b $00
[000067ba]                           dc.b $00
[000067bb]                           dc.b $00
[000067bc]                           dc.b $00
[000067bd]                           dc.b $00
[000067be]                           dc.b $00
[000067bf]                           dc.b $00
[000067c0]                           dc.b $00
[000067c1]                           dc.b $00
[000067c2]                           dc.b $00
[000067c3]                           dc.b $00
[000067c4]                           dc.b $00
[000067c5]                           dc.b $00
[000067c6]                           dc.b $00
[000067c7]                           dc.b $00
[000067c8]                           dc.b $00
[000067c9]                           dc.b $00
[000067ca]                           dc.b $00
[000067cb]                           dc.b $00
[000067cc]                           dc.b $00
[000067cd]                           dc.b $00
[000067ce]                           dc.b $00
[000067cf]                           dc.b $00
[000067d0]                           dc.b $00
[000067d1]                           dc.b $00
[000067d2]                           dc.b $00
[000067d3]                           dc.b $00
[000067d4]                           dc.b $00
[000067d5]                           dc.b $00
[000067d6]                           dc.b $00
[000067d7]                           dc.b $00
[000067d8]                           dc.b $00
[000067d9]                           dc.b $00
[000067da]                           dc.b $00
[000067db]                           dc.b $00
[000067dc]                           dc.b $00
[000067dd]                           dc.b $00
[000067de]                           dc.b $00
[000067df]                           dc.b $00
[000067e0]                           dc.b $00
[000067e1]                           dc.b $00
[000067e2]                           dc.b $00
[000067e3]                           dc.b $00
[000067e4]                           dc.b $00
[000067e5]                           dc.b $00
[000067e6]                           dc.b $00
[000067e7]                           dc.b $00
[000067e8]                           dc.b $00
[000067e9]                           dc.b $00
[000067ea]                           dc.b $00
[000067eb]                           dc.b $00
[000067ec]                           dc.b $00
[000067ed]                           dc.b $00
[000067ee]                           dc.b $00
[000067ef]                           dc.b $00
[000067f0]                           dc.b $00
[000067f1]                           dc.b $00
[000067f2]                           dc.b $00
[000067f3]                           dc.b $00
[000067f4]                           dc.b $00
[000067f5]                           dc.b $00
[000067f6]                           dc.b $00
[000067f7]                           dc.b $00
[000067f8]                           dc.b $00
[000067f9]                           dc.b $00
[000067fa]                           dc.b $00
[000067fb]                           dc.b $00
[000067fc]                           dc.b $00
[000067fd]                           dc.b $00
[000067fe]                           dc.b $00
[000067ff]                           dc.b $00
[00006800]                           dc.b $00
[00006801]                           dc.b $00
[00006802]                           dc.b $00
[00006803]                           dc.b $00
[00006804]                           dc.b $00
[00006805]                           dc.b $00
[00006806]                           dc.b $00
[00006807]                           dc.b $00
[00006808]                           dc.b $00
[00006809]                           dc.b $00
[0000680a]                           dc.b $00
[0000680b]                           dc.b $00
[0000680c]                           dc.b $00
[0000680d]                           dc.b $00
[0000680e]                           dc.b $00
[0000680f]                           dc.b $00
[00006810]                           dc.b $00
[00006811]                           dc.b $00
[00006812]                           dc.b $00
[00006813]                           dc.b $00
[00006814]                           dc.b $00
[00006815]                           dc.b $00
[00006816]                           dc.b $00
[00006817]                           dc.b $00
[00006818]                           dc.b $00
[00006819]                           dc.b $00
[0000681a]                           dc.b $00
[0000681b]                           dc.b $00
[0000681c]                           dc.b $00
[0000681d]                           dc.b $00
[0000681e]                           dc.b $00
[0000681f]                           dc.b $00
[00006820]                           dc.b $00
[00006821]                           dc.b $00
[00006822]                           dc.b $00
[00006823]                           dc.b $00
[00006824]                           dc.b $00
[00006825]                           dc.b $00
[00006826]                           dc.b $00
[00006827]                           dc.b $00
[00006828]                           dc.b $00
[00006829]                           dc.b $00
[0000682a]                           dc.b $00
[0000682b]                           dc.b $00
[0000682c]                           dc.b $00
[0000682d]                           dc.b $00
[0000682e]                           dc.b $00
[0000682f]                           dc.b $00
[00006830]                           dc.b $00
[00006831]                           dc.b $00
[00006832]                           dc.b $00
[00006833]                           dc.b $00
[00006834]                           dc.b $00
[00006835]                           dc.b $00
[00006836]                           dc.b $00
[00006837]                           dc.b $00
[00006838]                           dc.b $00
[00006839]                           dc.b $00
[0000683a]                           dc.b $00
[0000683b]                           dc.b $00
[0000683c]                           dc.b $00
[0000683d]                           dc.b $00
[0000683e]                           dc.b $00
[0000683f]                           dc.b $00
[00006840]                           dc.b $00
[00006841]                           dc.b $00
[00006842]                           dc.b $00
[00006843]                           dc.b $00
[00006844]                           dc.b $00
[00006845]                           dc.b $00
[00006846]                           dc.b $00
[00006847]                           dc.b $00
[00006848]                           dc.b $00
[00006849]                           dc.b $00
[0000684a]                           dc.b $00
[0000684b]                           dc.b $00
[0000684c]                           dc.b $00
[0000684d]                           dc.b $00
[0000684e]                           dc.b $00
[0000684f]                           dc.b $00
[00006850]                           dc.b $00
[00006851]                           dc.b $00
[00006852]                           dc.b $00
[00006853]                           dc.b $00
[00006854]                           dc.b $00
[00006855]                           dc.b $00
[00006856]                           dc.b $00
[00006857]                           dc.b $00
[00006858]                           dc.b $00
[00006859]                           dc.b $00
[0000685a]                           dc.b $00
[0000685b]                           dc.b $00
[0000685c]                           dc.b $00
[0000685d]                           dc.b $00
[0000685e]                           dc.b $00
[0000685f]                           dc.b $00
[00006860]                           dc.b $00
[00006861]                           dc.b $00
[00006862]                           dc.b $00
[00006863]                           dc.b $00
[00006864]                           dc.b $00
[00006865]                           dc.b $00
[00006866]                           dc.b $00
[00006867]                           dc.b $00
[00006868]                           dc.b $00
[00006869]                           dc.b $00
[0000686a]                           dc.b $00
[0000686b]                           dc.b $00
[0000686c]                           dc.b $00
[0000686d]                           dc.b $00
[0000686e]                           dc.w $2000
[00006870]                           dc.b 'usage: ',0
[00006878]                           dc.w $080c
[0000687a]                           dc.w $0a0d
[0000687c]                           dc.w $090b
[0000687e]                           dc.b $00
[0000687f]                           dc.b 'bfnrtv',0
__pfio:
[00006886]                           dc.b $00
[00006887]                           dc.b $00
[00006888]                           dc.b $00
[00006889]                           dc.b $00
[0000688a]                           dc.b $00
[0000688b]                           dc.b $00
[0000688c]                           dc.b $00
[0000688d]                           dc.b $00
_readerr:
[0000688e] 00021342                  dc.l $00021342 ; no symbol found
[00006892]                           dc.b 'read error',0
[0000689d]                           dc.b $00
[0000689e]                           dc.b '/tmp/t',0
[000068a5]                           dc.b 'pppp',0
[000068aa]                           dc.b $00
[000068ab]                           dc.b $00
[000068ac]                           dc.b $00
[000068ad]                           dc.b $00
[000068ae]                           dc.b $00
[000068af]                           dc.b $00
[000068b0]                           dc.b $00
[000068b1]                           dc.b $00
[000068b2]                           dc.b $00
[000068b3]                           dc.b $00
[000068b4]                           dc.b $00
[000068b5]                           dc.b $00
[000068b6]                           dc.b $00
[000068b7]                           dc.b $00
[000068b8]                           dc.b $00
[000068b9]                           dc.b $00
[000068ba]                           dc.b 'bad free call',0
_fioerr:
[000068c8] 0002137c                  dc.l $0002137c ; no symbol found
[000068cc]                           dc.b 'NULL FIO pointer',0
[000068dd]                           dc.b $00
__memerr:
[000068de] 00021392                  dc.l $00021392 ; no symbol found
[000068e2]                           dc.b 'no memory',0
[000068ec] 00021430                  dc.l _end
__stop:
[000068f0]                           dc.b $00
[000068f1]                           dc.b $00
[000068f2]                           dc.b $00
[000068f3]                           dc.b $01
__dtens:
[000068f4]                           dc.w $3ff0
[000068f6]                           dc.b $00
[000068f7]                           dc.b $00
[000068f8]                           dc.b $00
[000068f9]                           dc.b $00
[000068fa]                           dc.b $00
[000068fb]                           dc.b $00
[000068fc]                           dc.w $4024
[000068fe]                           dc.b $00
[000068ff]                           dc.b $00
[00006900]                           dc.b $00
[00006901]                           dc.b $00
[00006902]                           dc.b $00
[00006903]                           dc.b $00
[00006904]                           dc.w $4059
[00006906]                           dc.b $00
[00006907]                           dc.b $00
[00006908]                           dc.b $00
[00006909]                           dc.b $00
[0000690a]                           dc.b $00
[0000690b]                           dc.b $00
[0000690c]                           dc.w $40c3
[0000690e]                           dc.w $8800
[00006910]                           dc.b $00
[00006911]                           dc.b $00
[00006912]                           dc.b $00
[00006913]                           dc.b $00
[00006914]                           dc.w $4197
[00006916]                           dc.w $d784
[00006918]                           dc.b $00
[00006919]                           dc.b $00
[0000691a]                           dc.b $00
[0000691b]                           dc.b $00
[0000691c]                           dc.w $4341
[0000691e]                           dc.w $c379
[00006920]                           dc.w $37e0
[00006922]                           dc.w $8000
[00006924]                           dc.w $4693
[00006926]                           dc.w $b8b5
[00006928]                           dc.w $b505
[0000692a]                           dc.w $6e17
[0000692c]                           dc.w $4d38
[0000692e]                           dc.w $4f03
[00006930]                           dc.w $e93f
[00006932]                           dc.w $f9f5
[00006934]                           dc.w $5a82
[00006936]                           dc.w $7748
[00006938]                           dc.w $f930
[0000693a]                           dc.w $1d32
[0000693c]                           dc.w $7515
[0000693e]                           dc.w $4fdd
[00006940]                           dc.w $7f73
[00006942]                           dc.w $bf3c
__dzero:
[00006944]                           dc.b $00
[00006945]                           dc.b $00
[00006946]                           dc.b $00
[00006947]                           dc.b $00
[00006948]                           dc.b $00
[00006949]                           dc.b $00
[0000694a]                           dc.b $00
[0000694b]                           dc.b $00
__ntens:
[0000694c]                           dc.b $00
[0000694d]                           dc.b $0a
[0000694e]                           dc.b $00
[0000694f]                           dc.b $00
[00006950]                           dc.b $00
[00006951]                           dc.b $00
[00006952] 00021406                  dc.l $00021406 ; no symbol found
[00006956]                           dc.b 'unchecked condition',0
_writerr:
[0000696a] 0002141e                  dc.l $0002141e ; no symbol found
[0000696e]                           dc.b 'write error',0
[0000697a]                           dc.w $0a00
[0000697c]                           dc.w $3a20
[0000697e]                           dc.b $00
[0000697f]                           dc.b $00
;
00000000 T start
00000080 T _exit
000000aa T _onexit
000000ba T seterr
000000c6 T _builtin
00000342 T _dodef
00000708 T _doexp
0000084a T _doif
000008f6 T _getargs
00000a74 T _undef
00000afa T _dobesc
00000ca6 T _dopunct
00000d80 T _eval
00000dd2 T _exop
00000e16 T _expr
00000e70 T _expri
00000eb6 T _extail
00001130 T _exterm
000012da T _bton
0000145a T _flaccum
000014cc T _lexchars
00001552 T _lexfloat
00001772 T _lexfnxt
000017c2 T _lexident
00001874 T _lexint
000018e6 T _lexpunct
0000190e T _lexstrin
00001960 T _lexxstr
000019aa T _putcode
00001ab2 T _putfile
00001b42 T _putls
00001d30 T _getex
00001ecc T _getinl
00002018 T _getln
000020bc T _main
0000231c T _putgr
00002508 T _putns
00002a88 T _buytl
00002b00 T _fatal
00002b20 T _fretlist
00002b56 T _getfincl
00002dda T _hash
00002e22 T _install
00002e8a T _lookup
00002efe T _nxtfile
00002fba T _perrfmt
0000310e T _p0error
00003236 T _predef
00003322 T _ptline
0000336e T _scntab
0000340e T _stotl
000037f0 T _fclose
0000389e T _fread
000038f2 T _frelst
00003924 T _getfiles
00003ac8 T _getflags
00003f04 T _inbuf
00003f4a T _itob
00003fe4 T _putlin
0000400c T _usage
00004082 T _buybuf
000040b6 T _cmpstr
000040ec T _create
00004166 T _doesc
000042c0 T _finit
00004358 T _getenv
000043b4 T _getl
0000446c T _instr
000044ae T a.lmod
000044c0 T a.ldiv
0000450e T _lseek
00004588 T _open
00004590 T _putc
00004648 T _putl
0000472a T _read
00004732 T _scnstr
00004768 T _seek
00004770 T a.switch
00004782 T a.ulmod
0000478a T a.uldiv
000047c6 T _uname
0000486e T _alloc
000048a8 T _nalloc
000049de T _free
00004aa0 T _btol
00004cd6 T _close
00004cde T _cmpbuf
00004d14 T _cpybuf
00004d3e T _creat
00004d46 T a.1sub
00004d5a T a.6sub
00004d84 T a.1add
00004d98 T a.6add
00004e46 T _dtento
00004fc2 T _fstat
00004fca T _getpid
00004fd0 T a.lmul
00004ffc T a.1ltd
00005004 T a.6ltd
0000502c T _putstr
00005062 T _sbreak
000050a6 T a.1div
000050ba T a.6div
000051c6 T a.1mul
000051da T a.6mul
000052ba T _fwrite
000052f4 T _lenstr
00005316 T __raise
000053b2 T __when
000053f8 T a.repk
0000548c T a.unpk
0000550a T _error
00005548 T _write
00005550 D __data
000055c2 D _environ
000055c6 D _errno
000055ca D __paths
000055d2 D _bltintab
00005a36 D _cmap
00005b36 D _digfr
00005b4d D _digto
00005f6a D _errflag
00005f6e D _liflag
00005f72 D _oldflag
00005f76 D _pasflag
00005f7a D _stdflag
00005f7e D _xflag
00005f82 D _pchar
00005f86 D _schar
00005f8a D _inif
00005f8c D _inincl
00005f8e D _escname
00005f94 D _iprefix
00005f9a D _mapfile
00005f9e D __pname
00005fa6 D _pasline
00005faa D _failincl
00005fae D _pflag
00005fb2 D _argc
00005fb6 D _lineno
00005fb8 D _nerrors
00005fba D _errfd
00005fbc D _pincl
00005fc0 D _argv
00005fc4 D _perr
00005fc8 D _errbuf
00006664 D _stdout
00006886 D __pfio
0000688e D _readerr
000068c8 D _fioerr
000068de D __memerr
000068f0 D __stop
000068f4 D __dtens
00006944 D __dzero
0000694c D __ntens
0000696a D _writerr
00021430 B _end
;
; a.out Relocations:
00000016: 00005550
00000026: 00005550
00000040: 00005550
00000046: 00005550
0000004c: 00000000
00000058: 00005550
00000062: 00005550
0000006a: 00006980
0000006e: 00005550
00000074: 00000000
0000007c: 00000000
00000082: 00005550
00000088: 00000000
000000ac: 00005550
000000b4: 00005550
000000be: 00005550
000000e4: 00005550
000000ea: 00000000
00000104: 00005550
0000010a: 00000000
0000013e: 00000000
00000154: 00000000
0000017e: 00000000
0000018c: 00000000
000001a4: 00005550
000001b0: 00005550
000001ba: 00000000
000001ce: 00005550
000001e0: 00005550
000001ee: 00005550
000001f4: 00000000
00000208: 00005550
00000212: 00005550
00000246: 00000000
00000252: 00005550
0000025a: 00005550
0000026a: 00000000
000002dc: 00005550
000002e2: 00000000
0000030e: 00000000
0000031a: 00005550
00000322: 00005550
00000336: 00000000
000003e8: 00005550
000003ee: 00000000
000003fe: 00005550
00000474: 00005550
0000049c: 00005550
000004a2: 00000000
000004ec: 00005550
000004f2: 00000000
00000504: 00000000
0000054e: 00000000
0000060a: 00005550
00000610: 00000000
0000062e: 00000000
00000664: 00000000
000006ec: 00000000
00000746: 00000000
0000079a: 00000000
000007be: 00000000
0000080e: 00000000
0000081c: 00000000
00000860: 00005550
00000866: 00000000
0000087a: 00000000
0000088c: 00005550
00000892: 00000000
000008c8: 00000000
000008e4: 00005550
000008ea: 00000000
00000940: 00000000
000009ec: 00000000
00000a28: 00005550
00000a4a: 00005550
00000a58: 00005550
00000a5e: 00000000
00000a9e: 00000000
00000ac2: 00000000
00000ad8: 00000000
00000ae4: 00000000
00000b5e: 00005550
00000b7c: 00005550
00000b82: 00000000
00000b96: 00005550
00000ba0: 00005550
00000bba: 00005550
00000bec: 00005550
00000bf2: 00000000
00000c02: 00005550
00000c14: 00005550
00000c4e: 00005550
00000c54: 00000000
00000c94: 00005550
00000cfa: 00005550
00000d00: 00000000
00000d10: 00005550
00000d22: 00005550
00000d28: 00000000
00000d46: 00005550
00000d4c: 00000000
00000d94: 00000000
00000db0: 00005550
00000db6: 00000000
00000e24: 00000000
00000e5c: 00000000
00000e84: 00005550
00000e8a: 00000000
00000e96: 00005550
00000ea6: 00005550
00000ee2: 00000000
00000f5e: 00005550
00000f64: 00000000
00000f96: 00000000
00000faa: 00000000
00000fbe: 00000000
000010f2: 00005550
000010f8: 00000000
0000111c: 00005550
00001122: 00000000
00001154: 00000000
0000121c: 00005550
00001222: 00000000
00001250: 00005550
00001256: 00000000
000012ce: 00005550
000012d4: 00000000
00001344: 00005550
0000134a: 00000000
0000135e: 00005550
00001368: 00005550
0000139a: 00000000
000013f0: 00005550
000013f6: 00000000
00001494: 00005550
0000149a: 00000000
000014aa: 00000000
000014b2: 00000000
000014e6: 00000000
0000153a: 00005550
00001540: 00000000
0000158c: 00000000
000015a8: 00000000
000015da: 00000000
00001608: 00000000
0000163c: 00000000
00001664: 00000000
0000169a: 00000000
000016b0: 00000000
000016e4: 00005550
000016ea: 00000000
000016f4: 00005550
00001766: 00005550
0000176c: 00000000
00001786: 00005550
000017aa: 00005550
000017e6: 00005550
000017f2: 00005550
000017fc: 00000000
00001828: 00005550
0000182e: 00000000
00001840: 00005550
00001846: 00000000
0000185c: 00005550
00001862: 00000000
000018ce: 00005550
000018d4: 00000000
000018f0: 00000000
000018fa: 00005550
00001900: 00000000
00001928: 00000000
00001948: 00005550
0000194e: 00000000
00001992: 00005550
00001998: 00000000
000019cc: 00005550
000019da: 00005550
000019e4: 00005550
000019ea: 00005550
00001a0a: 00005550
00001a10: 00000000
00001a48: 00000000
00001a62: 00005550
00001a70: 00005550
00001a7a: 00005550
00001a80: 00005550
00001aa4: 00005550
00001aaa: 00000000
00001ab8: 00005550
00001ac0: 00005550
00001ac8: 00005550
00001ad0: 00005550
00001ad8: 00005550
00001ae4: 00005550
00001aec: 00005550
00001af2: 00005550
00001b04: 00005550
00001b12: 00005550
00001b1c: 00005550
00001b26: 00000000
00001b34: 00005550
00001b50: 00005550
00001ba8: 00005550
00001bae: 00000000
00001bbe: 00000000
00001bce: 00000000
00001be6: 00000000
00001bfa: 00005550
00001c00: 00000000
00001c90: 00005550
00001c9e: 00000000
00001d3e: 00000000
00001d5c: 00005550
00001d82: 00005550
00001d90: 00005550
00001d96: 00000000
00001da2: 00005550
00001da8: 00000000
00001dc2: 00005550
00001dc8: 00000000
00001dda: 00000000
00001df6: 00000000
00001e14: 00005550
00001e1e: 00000000
00001e28: 00005550
00001e46: 00005550
00001e4c: 00000000
00001e6a: 00000000
00001e8c: 00005550
00001e92: 00000000
00001ea6: 00000000
00001ec0: 00000000
00001ed2: 00005550
00001ee0: 00000000
00001ee8: 00005550
00001ef4: 00005550
00001efa: 00005550
00001f02: 00000000
00001f08: 00005550
00001f0e: 00005550
00001f22: 00005550
00001f2a: 00005550
00001f30: 00005550
00001f38: 00005550
00001f3e: 00000000
00001f50: 00005550
00001f56: 00005550
00001f5c: 00005550
00001f66: 00005550
00001f6e: 00000000
00001f7a: 00005550
00001f82: 00005550
00001f88: 00000000
00001f8e: 00005550
00001f96: 00005550
00001f9c: 00000000
00001fa8: 00005550
00001fb2: 00000000
00001fba: 00005550
00001fc2: 00000000
00001fca: 00005550
00001fd4: 00000000
00001fdc: 00005550
00001fe4: 00005550
00001fea: 00000000
00001ff2: 00005550
00001ffa: 00005550
00002000: 00000000
00002006: 00005550
00002010: 00005550
00002042: 00000000
0000205c: 00005550
0000209a: 00005550
000020a0: 00000000
000020c8: 00005550
000020d0: 00005550
000020d6: 00005550
000020dc: 00005550
000020e2: 00005550
000020e8: 00005550
000020ee: 00005550
000020f4: 00005550
000020fa: 00005550
00002100: 00005550
00002106: 00005550
0000210c: 00005550
00002112: 00005550
00002118: 00005550
0000211e: 00005550
00002124: 00005550
0000212a: 00005550
00002130: 00000000
0000213a: 00005550
0000214a: 00005550
0000215e: 00005550
00002164: 00000000
00002172: 00005550
00002178: 00005550
0000217e: 00000000
0000218a: 00005550
0000219c: 00005550
000021a2: 00000000
000021ac: 00005550
000021b4: 00005550
000021c2: 00005550
000021c8: 00000000
000021d0: 00005550
000021dc: 00005550
000021e4: 00005550
000021f0: 00005550
000021f8: 00000000
00002206: 00005550
0000220c: 00000000
00002216: 00000000
0000221c: 00005550
00002222: 00000000
00002228: 00005550
0000222e: 00000000
00002234: 00005550
00002242: 00005550
00002248: 00000000
00002258: 00005550
0000225e: 00005550
00002264: 00000000
00002274: 00005550
00002282: 00000000
00002292: 00005550
00002298: 00005550
0000229e: 00000000
000022b0: 00000000
000022c2: 00000000
000022d8: 00005550
000022de: 00000000
000022ea: 00000000
000022f4: 00005550
000022fa: 00000000
00002300: 00005550
00002308: 00005550
00002376: 00000000
0000239e: 00000000
000023aa: 00000000
000023e4: 00000000
0000242c: 00000000
00002438: 00000000
00002476: 00000000
000024a6: 00000000
000024e6: 00000000
000024fa: 00005550
00002500: 00000000
0000251a: 00005550
00002520: 00000000
00002542: 00005550
0000254c: 00000000
00002554: 00005550
00002562: 00005550
00002568: 00000000
00002588: 00005550
0000258e: 00000000
000025a4: 00005550
000025aa: 00000000
000025b6: 00000000
000025d2: 00005550
000025d8: 00000000
00002616: 00005550
00002630: 00000000
0000264e: 00000000
00002668: 00000000
00002686: 00000000
000026a4: 00005550
000026aa: 00000000
000026c2: 00005550
000026c8: 00000000
000026e2: 00000000
000026f0: 00000000
000026f8: 00005550
00002702: 00005550
00002708: 00000000
00002710: 00005550
00002720: 00000000
0000272e: 00005550
0000273c: 00000000
00002748: 00000000
0000274e: 00005550
00002758: 00000000
00002760: 00005550
00002766: 00005550
00002770: 00005550
00002786: 00005550
0000278e: 00000000
00002798: 00005550
0000279e: 00005550
000027c8: 00005550
000027da: 00000000
000027f2: 00005550
000027f8: 00000000
00002854: 00005550
0000287c: 00000000
000028a6: 00005550
000028ac: 00005550
000028ba: 00005550
000028c4: 00000000
000028de: 00000000
000028ea: 00005550
000028f6: 00005550
000028fc: 00000000
00002904: 00005550
0000290e: 00005550
0000291a: 00000000
00002928: 00000000
00002934: 00005550
0000297c: 00000000
0000299c: 00005550
000029a2: 00005550
000029b0: 00005550
000029ba: 00000000
000029d2: 00005550
000029d8: 00000000
000029e0: 00005550
000029f6: 00005550
00002a0a: 00000000
00002a14: 00005550
00002a26: 00000000
00002a34: 00005550
00002a3a: 00000000
00002a44: 00000000
00002a4e: 00005550
00002a54: 00000000
00002a6e: 00005550
00002a74: 00000000
00002a80: 00000000
00002a9a: 00005550
00002aa2: 00005550
00002aa8: 00005550
00002ab8: 00000000
00002b0e: 00000000
00002b18: 00000000
00002b40: 00005550
00002b48: 00005550
00002b88: 00005550
00002bc6: 00000000
00002bf4: 00000000
00002c2a: 00000000
00002c3e: 00000000
00002c70: 00000000
00002c98: 00005550
00002cbe: 00000000
00002cd4: 00000000
00002cf0: 00005550
00002d02: 00000000
00002d1e: 00000000
00002d38: 00000000
00002d58: 00000000
00002d68: 00000000
00002d7e: 00000000
00002d8c: 00000000
00002d98: 00005550
00002db0: 00000000
00002e0c: 00000000
00002e16: 00005550
00002e58: 00000000
00002e72: 00000000
00002ed2: 00000000
00002f0e: 00005550
00002f14: 00005550
00002f1a: 00000000
00002f2e: 00005550
00002f34: 00005550
00002f3e: 00005550
00002f58: 00000000
00002f6c: 00005550
00002f76: 00000000
00002f80: 00005550
00002f8a: 00000000
00002f98: 00005550
00002faa: 00000000
00002fe2: 00005550
00002fec: 00000000
00002ff6: 00005550
00002ffc: 00005550
0000302a: 00005550
00003034: 00000000
0000303e: 00005550
00003044: 00005550
00003066: 00000000
00003086: 00005550
00003090: 00000000
000030a0: 00005550
000030a6: 00000000
000030ae: 00005550
000030ce: 00000000
000030de: 00005550
000030e8: 00000000
000030f6: 00005550
000030fc: 00000000
00003104: 00005550
00003114: 00005550
00003118: 00005550
0000311e: 00005550
0000312a: 00005550
00003134: 00005550
00003140: 00005550
00003146: 00005550
0000314e: 00005550
0000315c: 00005550
00003166: 00005550
0000316c: 00005550
00003174: 00005550
00003180: 00005550
0000318c: 00005550
00003196: 00005550
0000319c: 00005550
000031a2: 00005550
000031a8: 00005550
000031c8: 00005550
000031d2: 00005550
000031d8: 00005550
000031e0: 00005550
000031e6: 00005550
000031fa: 00005550
00003200: 00000000
0000320e: 00005550
0000321a: 00005550
00003224: 00005550
0000322a: 00000000
0000326e: 00005550
00003276: 00000000
0000328c: 00005550
000032b2: 00000000
000032ee: 00005550
00003308: 00000000
00003328: 00005550
00003330: 00005550
00003338: 00005550
00003340: 00005550
00003348: 00005550
00003354: 00005550
00003360: 00005550
00003366: 00000000
0000349a: 00005550
000034d4: 00005550
00003516: 00005550
0000353a: 00005550
000035b0: 00005550
0000362c: 00005550
000036b0: 00005550
000036d0: 00005550
000036f6: 00005550
0000377e: 00005550
000037a8: 00005550
00003802: 00005550
0000380a: 00000000
00003812: 00005550
00003860: 00000000
00003872: 00005550
0000387a: 00000000
00003888: 00000000
000038c0: 00000000
000038e2: 00005550
000038ea: 00000000
00003910: 00000000
00003942: 00005550
0000394c: 00000000
00003970: 00000000
0000399e: 00000000
000039bc: 00000000
000039ce: 00005550
000039d8: 00000000
000039e4: 00000000
000039f6: 00005550
00003a00: 00000000
00003a2e: 00005550
00003a38: 00000000
00003a4a: 00005550
00003a54: 00000000
00003a74: 00005550
00003a7e: 00000000
00003a98: 00005550
00003aa2: 00000000
00003ab8: 00000000
00003af0: 00005550
00003af8: 00000000
00003b22: 00005550
00003b2a: 00000000
00003b5c: 00005550
00003b62: 00000000
00003b78: 00000000
00003bc8: 00005550
00003c02: 00005550
00003c08: 00000000
00003c5a: 00000000
00003ca2: 00000000
00003ce0: 00000000
00003cec: 00000000
00003d12: 00000000
00003dc6: 00000000
00003ed4: 00000000
00003eea: 00005550
00003ef2: 00000000
00003fa8: 00000000
00003fc0: 00000000
00003ff8: 00005550
00003ffe: 00000000
0000401e: 00005550
00004024: 00005550
0000402a: 00005550
00004034: 00000000
00004048: 00000000
00004064: 00000000
0000406a: 00005550
00004070: 00000000
00004098: 00000000
000040f6: 00000000
0000412e: 00000000
0000414a: 00000000
00004158: 00000000
000041fe: 00005550
00004204: 00000000
0000421e: 00005550
0000424e: 00000000
00004282: 00005550
000042a4: 00000000
000042ae: 00005550
000042d6: 00005550
000042de: 00000000
00004300: 00000000
00004328: 00005550
00004330: 00005550
00004336: 00005550
0000433e: 00000000
00004344: 00000000
0000434a: 00005550
00004368: 00000000
00004370: 00005550
00004384: 00000000
000043ca: 00005550
000043d2: 00000000
000043fa: 00000000
0000440c: 00005550
00004414: 00000000
00004536: 00000000
00004552: 00000000
000045a6: 00005550
000045ae: 00000000
000045f8: 00000000
0000463a: 00000000
0000465e: 00005550
00004666: 00000000
000046ec: 00000000
00004710: 00000000
000047d0: 00005550
000047d8: 00000000
000047ee: 00005550
00004802: 00005550
00004880: 00000000
00004892: 00005550
0000489a: 00000000
000048d0: 00005550
000048f0: 00005550
000048fc: 00005550
0000492a: 00005550
00004932: 00005550
0000493a: 00005550
00004942: 00005550
0000494a: 00005550
00004956: 00000000
00004962: 00005550
0000496a: 00005550
0000497e: 00000000
0000499c: 00005550
000049a4: 00005550
000049ac: 00005550
000049b2: 00005550
000049c8: 00005550
000049d4: 00000000
000049f6: 00005550
000049fe: 00005550
00004a08: 00005550
00004a0c: 00005550
00004a12: 00005550
00004a1a: 00000000
00004a2e: 00005550
00004a3a: 00005550
00004a42: 00005550
00004a4a: 00005550
00004a52: 00005550
00004a60: 00005550
00004c68: 00000000
00004dba: 00000000
00004dd0: 00000000
00004e2a: 00000000
00004e66: 00005550
00004e88: 00005550
00004e90: 00000000
00004eb0: 00005550
00004ecc: 00005550
00004edc: 00000000
00004f00: 00005550
00004f0c: 00005550
00004f14: 00000000
00004f2a: 00005550
00004f36: 00005550
00004f3e: 00000000
00004f6c: 00005550
00004f78: 00005550
00004f88: 00000000
00004f96: 00005550
00004fa2: 00005550
00004fb2: 00000000
0000501e: 00000000
00005042: 00000000
00005050: 00000000
0000506e: 00005550
00005088: 00005550
0000508e: 00005550
00005094: 00005550
0000509c: 00005550
000050a0: 00005550
000050dc: 00000000
0000512a: 00000000
00005198: 00000000
0000520c: 00000000
00005224: 00000000
0000528c: 00000000
000052d0: 00000000
000052de: 00005550
000052e6: 00000000
0000533c: 00005550
0000535e: 00005550
000053a0: 00005550
000053aa: 00000000
000053b4: 00005550
000053e8: 00005550
00005502: 00000000
00005510: 00005550
0000551a: 00005550
00005534: 00005550
00005540: 00000000
000055ca: 00005550
000055ce: 00000000
000055d2: 00005550
000055da: 00005550
000055e2: 00005550
000055ea: 00005550
00005624: 00005550
00005638: 00000000
00005640: 00000000
00005648: 00000000
00005650: 00000000
0000565c: 00000000
00005724: 00005550
0000572c: 00005550
00005734: 00005550
0000573c: 00005550
00005744: 00005550
0000574c: 00005550
00005754: 00005550
0000575c: 00005550
00005764: 00005550
0000576c: 00005550
00005774: 00005550
0000577c: 00005550
00005784: 00005550
0000578c: 00005550
00005794: 00005550
0000579c: 00005550
000057a4: 00005550
000057ac: 00005550
000057b4: 00005550
000057bc: 00005550
000057c4: 00005550
000057cc: 00005550
000057d4: 00005550
000057dc: 00005550
000057e4: 00005550
000057ec: 00005550
000057f4: 00005550
000057fc: 00005550
00005804: 00005550
0000580c: 00005550
00005814: 00005550
0000581c: 00005550
00005824: 00005550
0000582c: 00005550
00005834: 00005550
0000583c: 00005550
00005844: 00005550
0000584c: 00005550
00005854: 00005550
0000585c: 00005550
00005864: 00005550
0000586c: 00005550
00005874: 00005550
0000587c: 00005550
00005884: 00005550
0000588c: 00005550
00005938: 00005550
00005940: 00005550
00005948: 00005550
00005950: 00005550
00005958: 00005550
00005960: 00005550
00005968: 00005550
00005970: 00005550
00005978: 00005550
00005980: 00005550
00005988: 00005550
00005990: 00005550
00005998: 00005550
000059a0: 00005550
000059a8: 00005550
000059b0: 00005550
000059b8: 00005550
000059c0: 00005550
000059c8: 00005550
000059d0: 00005550
000059d8: 00005550
00005baa: 00000000
00005bb2: 00000000
00005bba: 00000000
00005bc2: 00000000
00005bca: 00000000
00005bd2: 00000000
00005bda: 00000000
00005be2: 00000000
00005bea: 00000000
00005bf2: 00000000
00005bfa: 00000000
00005c02: 00000000
00005c0a: 00000000
00005c12: 00000000
00005c1a: 00000000
00005c22: 00000000
00005c2a: 00000000
00005c32: 00000000
00005c3a: 00000000
00005c46: 00000000
00005cb2: 00005550
00005cba: 00005550
00005cc2: 00005550
00005cca: 00005550
00005cd2: 00005550
00005cda: 00005550
00005ce2: 00005550
00005cea: 00005550
00005cf2: 00005550
00005cfa: 00005550
00005d02: 00005550
00005d0a: 00005550
00005d12: 00005550
00005d1a: 00005550
00005d22: 00005550
00005d2a: 00005550
00005d32: 00005550
00005d3a: 00005550
00005d42: 00005550
00005d4a: 00005550
00005d52: 00005550
00005d5a: 00005550
00005d62: 00005550
00005d6a: 00005550
00005d72: 00005550
00005d7a: 00005550
00005d82: 00005550
00005d8a: 00005550
00005d92: 00005550
00005d9a: 00005550
00005da2: 00005550
00005daa: 00005550
00005db2: 00005550
00005efa: 00000000
00005f02: 00000000
00005f0a: 00000000
00005f12: 00000000
00005f1a: 00000000
00005f22: 00000000
00005f2e: 00000000
00005f94: 00005550
00005f9e: 00005550
00006048: 00005550
00006050: 00005550
00006058: 00005550
00006060: 00005550
00006068: 00005550
00006070: 00005550
00006078: 00005550
00006080: 00005550
00006088: 00005550
00006090: 00005550
00006098: 00005550
000060a0: 00005550
000060a8: 00005550
000060b0: 00005550
000060b8: 00005550
000060c0: 00005550
000060c8: 00005550
000060d0: 00005550
000060d8: 00005550
000060e0: 00005550
000060e8: 00005550
000060f0: 00005550
000060f8: 00005550
00006100: 00005550
000061ae: 00000000
000061b6: 00000000
000061be: 00000000
000061c6: 00000000
000061ce: 00000000
000061d6: 00000000
000061de: 00000000
000061e6: 00000000
000061f2: 00000000
000062e6: 00000000
000062ee: 00000000
000062f6: 00000000
000062fe: 00000000
00006306: 00000000
0000630e: 00000000
00006316: 00000000
00006322: 00000000
00006616: 00000000
0000661e: 00000000
00006626: 00000000
0000662e: 00000000
00006636: 00000000
0000663e: 00000000
00006646: 00000000
00006652: 00000000
0000688e: 00005550
000068c8: 00005550
000068de: 00005550
000068ec: 00006980
00006952: 00005550
0000696a: 00005550

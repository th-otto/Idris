; a_magic   = 0x992d
; a_text    = 0x000056ae
; a_data    = 0x000024ea
; a_bss     = 0x00000000
; a_syms    = 0x00000a00
; a_heap    = 0x00020000
; a_textoff = 0x00000000
; a_dataoff = 0x000056ae
; a_relocs  = 0x00000848@0x000085b4


start:
[00000000] 201f                      move.l     (a7)+,d0
[00000002] 204f                      movea.l    a7,a0
[00000004] 2f08                      move.l     a0,-(a7)
[00000006] 2f08                      move.l     a0,-(a7)
[00000008] 2f00                      move.l     d0,-(a7)
[0000000a] e598                      rol.l      #2,d0
[0000000c] 5880                      addq.l     #4,d0
[0000000e] d1af 0008                 add.l      d0,8(a7)
[00000012] 23ef 0008 0000 5720       move.l     8(a7),$0000ADCE
[0000001a] 4a97                      tst.l      (a7)
[0000001c] 6726                      beq.s      start_1
[0000001e] 206f 0004                 movea.l    4(a7),a0
[00000022] 2050                      movea.l    (a0),a0
[00000024] 23c8 0000 6216            move.l     a0,$0000B8C4
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
[0000003e] 23c8 0000 5728            move.l     a0,$0000ADD6
start_1:
[00000044] 4879 0000 571a            pea.l      $0000ADC8
[0000004a] 4eb9 0000 3a60            jsr        _getenv
[00000050] 4a9f                      tst.l      (a7)+
[00000052] 4a87                      tst.l      d7
[00000054] 6706                      beq.s      start_4
[00000056] 23c7 0000 5728            move.l     d7,$0000ADD6
start_4:
[0000005c] 0cb9 0000 0001 0000 7b1a  cmpi.l     #$00000001,$0000D1C8
[00000066] 660a                      bne.s      start_5
[00000068] 23fc 0000 7b98 0000 7b1a  move.l     #$0000F730,$0000D1C8
start_5:
[00000072] 4eb9 0000 21d8            jsr        _main
[00000078] 2e87                      move.l     d7,(a7)
[0000007a] 4eb9 0000 0080            jsr        _exit

_exit:
[00000080] 2e39 0000 572c            move.l     $0000ADDA,d7
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
[000000aa] 2e39 0000 572c            move.l     $0000ADDA,d7
[000000b0] 23ef 0004 0000 572c       move.l     4(a7),$0000ADDA
[000000b8] 4e75                      rts

seterr:
[000000ba] 4487                      neg.l      d7
[000000bc] 23c7 0000 5724            move.l     d7,$0000ADD2
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
[000000e2] 2f3c 0000 5730            move.l     #$0000ADDE,-(a7)
[000000e8] 4eb9 0000 34aa            jsr        _scntab
[000000ee] 4fef 000c                 lea.l      12(a7),a7
[000000f2] 2a07                      move.l     d7,d5
[000000f4] 660a                      bne.s      _builtin_1
[000000f6] 2e0c                      move.l     a4,d7
[000000f8] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[000000fc] 4e5e                      unlk       a6
[000000fe] 4e75                      rts
_builtin_1:
[00000100] 2e05                      move.l     d5,d7
[00000102] 41f9 0000 5796            lea.l      $0000AE44,a0
[00000108] 4ef9 0000 48e0            jmp        a.switch
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
[0000017c] 4eb9 0000 3a2e            jsr        _frelst
[00000182] 588f                      addq.l     #4,a7
[00000184] 2eae fff8                 move.l     -8(a6),(a7)
[00000188] 2f0c                      move.l     a4,-(a7)
[0000018a] 4eb9 0000 2c5c            jsr        _fretlist
[00000190] 588f                      addq.l     #4,a7
[00000192] 2855                      movea.l    (a5),a4
_builtin_2:
[00000194] 2e0c                      move.l     a4,d7
[00000196] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[0000019a] 4e5e                      unlk       a6
[0000019c] 4e75                      rts

x19e_3:
[0000019e] 42ac 000c                 clr.l      12(a4)
[000001a2] 2479 0000 6234            movea.l    $0000B8E2,a2
[000001a8] 588a                      addq.l     #4,a2
[000001aa] 4a92                      tst.l      (a2)
[000001ac] 6712                      beq.s      x19e_1
[000001ae] 2479 0000 6234            movea.l    $0000B8E2,a2
[000001b4] 588a                      addq.l     #4,a2
[000001b6] 2e92                      move.l     (a2),(a7)
[000001b8] 4eb9 0000 5450            jsr        _lenstr
[000001be] 6002                      bra.s      x19e_2
x19e_1:
[000001c0] 4287                      clr.l      d7
x19e_2:
[000001c2] 2947 0014                 move.l     d7,20(a4)
[000001c6] 7008                      moveq.l    #8,d0
[000001c8] 2940 0004                 move.l     d0,4(a4)
[000001cc] 2479 0000 6234            movea.l    $0000B8E2,a2
[000001d2] 588a                      addq.l     #4,a2
[000001d4] 2952 0010                 move.l     (a2),16(a4)
[000001d8] 60ba                      bra.s      x19e_3
[000001da] 4878 000a                 pea.l      ($0000000A).w
[000001de] 2479 0000 6234            movea.l    $0000B8E2,a2
[000001e4] 508a                      addq.l     #8,a2
[000001e6] 4287                      clr.l      d7
[000001e8] 3e12                      move.w     (a2),d7
[000001ea] 2f07                      move.l     d7,-(a7)
[000001ec] 2f3c 0000 578c            move.l     #$0000AE3A,-(a7)
[000001f2] 4eb9 0000 40e4            jsr        _itob
[000001f8] 4fef 000c                 lea.l      12(a7),a7
[000001fc] 2947 0014                 move.l     d7,20(a4)
[00000200] 7004                      moveq.l    #4,d0
[00000202] 2940 0004                 move.l     d0,4(a4)
[00000206] 297c 0000 578c 0010       move.l     #$0000AE3A,16(a4)
[0000020e] 6084                      bra.s      x19e_3
[00000210] 4a79 0000 6202            tst.w      $0000B8B0
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
[00000244] 4eb9 0000 2fc6            jsr        _lookup
[0000024a] 508f                      addq.l     #8,a7
[0000024c] 4a87                      tst.l      d7
[0000024e] 6708                      beq.s      x19e_5
[00000250] 2e3c 0000 57d7            move.l     #$0000AE85,d7
[00000256] 6006                      bra.s      x19e_6
x19e_5:
[00000258] 2e3c 0000 57d5            move.l     #$0000AE83,d7
x19e_6:
[0000025e] 2947 0010                 move.l     d7,16(a4)
[00000262] 2454                      movea.l    (a4),a2
[00000264] 2e92                      move.l     (a2),(a7)
[00000266] 2f14                      move.l     (a4),-(a7)
[00000268] 4eb9 0000 2c5c            jsr        _fretlist
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
[000002da] 2ebc 0000 57c2            move.l     #$0000AE70,(a7) "bad defined syntax"
[000002e0] 4eb9 0000 324a            jsr        _p0error
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
[0000030c] 4eb9 0000 2fc6            jsr        _lookup
[00000312] 508f                      addq.l     #8,a7
[00000314] 4a87                      tst.l      d7
[00000316] 6708                      beq.s      x19e_9
[00000318] 2e3c 0000 57c0            move.l     #$0000AE6E,d7
[0000031e] 6006                      bra.s      x19e_10
x19e_9:
[00000320] 2e3c 0000 57be            move.l     #$0000AE6C,d7
x19e_10:
[00000326] 2947 0010                 move.l     d7,16(a4)
[0000032a] 2454                      movea.l    (a4),a2
[0000032c] 2452                      movea.l    (a2),a2
[0000032e] 2452                      movea.l    (a2),a2
[00000330] 2e92                      move.l     (a2),(a7)
[00000332] 2f14                      move.l     (a4),-(a7)
[00000334] 4eb9 0000 2c5c            jsr        _fretlist
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
[000003e6] 2ebc 0000 580b            move.l     #$0000AEB9,(a7) "bad #define arguments"
[000003ec] 4eb9 0000 324a            jsr        _p0error
[000003f2] 426e fff4                 clr.w      -12(a6)
[000003f6] 286e 0008                 movea.l    8(a6),a4
[000003fa] 6090                      bra.s      _dodef_9
_dodef_7:
[000003fc] 4ab9 0000 61f2            tst.l      _std
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
[00000472] 4ab9 0000 61f2            tst.l      _std
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
[0000049a] 2ebc 0000 57f3            move.l     #$0000AEA1,(a7) "too few macro arguments"
[000004a0] 4eb9 0000 324a            jsr        _p0error
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
[000004ea] 2ebc 0000 57da            move.l     #$0000AE88,(a7) "too many macro arguments"
[000004f0] 4eb9 0000 324a            jsr        _p0error
[000004f6] 60ae                      bra.s      _dodef_13
_dodef_17:
[000004f8] 2e0c                      move.l     a4,d7
[000004fa] 6700 01da                 beq        _dodef_20
[000004fe] 4297                      clr.l      (a7)
[00000500] 2f0c                      move.l     a4,-(a7)
[00000502] 4eb9 0000 2c5c            jsr        _fretlist
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
[0000054c] 4eb9 0000 425a            jsr        _cmpbuf
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
[00000608] 2f3c 0000 5772            move.l     #$0000AE20,-(a7)
[0000060e] 4eb9 0000 2bc4            jsr        _buytl
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
[0000062c] 4eb9 0000 2c5c            jsr        _fretlist
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
[00000662] 4eb9 0000 2bc4            jsr        _buytl
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
[000006ea] 4eb9 0000 2c5c            jsr        _fretlist
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
[00000744] 4eb9 0000 2fc6            jsr        _lookup
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
[00000798] 4eb9 0000 354a            jsr        _stotl
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
[0000080c] 4eb9 0000 3a2e            jsr        _frelst
[00000812] 588f                      addq.l     #4,a7
[00000814] 2eae fff0                 move.l     -16(a6),(a7)
[00000818] 2f0c                      move.l     a4,-(a7)
[0000081a] 4eb9 0000 2c5c            jsr        _fretlist
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
[0000085e] 2ebc 0000 5830            move.l     #$0000AEDE,(a7) "$if expects arguments"
[00000864] 4eb9 0000 324a            jsr        _p0error
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
[0000088a] 2ebc 0000 5822            move.l     #$0000AED0,(a7) "bad $if(test)"
[00000890] 4eb9 0000 324a            jsr        _p0error
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
[000008c6] 4eb9 0000 2bc4            jsr        _buytl
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
[000008e2] 2f3c 0000 5772            move.l     #$0000AE20,-(a7)
[000008e8] 4eb9 0000 2bc4            jsr        _buytl
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
[0000093e] 4eb9 0000 49de            jsr        _alloc
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
[000009ea] 4eb9 0000 1e68            jsr        _getex
[000009f0] 588f                      addq.l     #4,a7
[000009f2] 2687                      move.l     d7,(a3)
[000009f4] 67c4                      beq.s      _getargs_12
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
[00000a26] 5279 0000 6202            addq.w     #1,$0000B8B0
_getargs_14:
[00000a2c] 2eac 0008                 move.l     8(a4),(a7)
[00000a30] 2f2e fffa                 move.l     -6(a6),-(a7)
[00000a34] 4eba fcd2                 jsr        _doexp(pc)
[00000a38] 588f                      addq.l     #4,a7
[00000a3a] 2447                      movea.l    d7,a2
[00000a3c] 2952 0004                 move.l     (a2),4(a4)
[00000a40] 4aae 0010                 tst.l      16(a6)
[00000a44] 6700 ff36                 beq        _getargs_15
[00000a48] 5379 0000 6202            subq.w     #1,$0000B8B0
[00000a4e] 42ae 0010                 clr.l      16(a6)
[00000a52] 6000 ff28                 bra        _getargs_15
_getargs_3:
[00000a56] 2ebc 0000 5846            move.l     #$0000AEF4,(a7) "bad macro arguments"
[00000a5c] 4eb9 0000 324a            jsr        _p0error
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
[00000a9c] 4eb9 0000 2f16            jsr        _hash
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
[00000ac0] 4eb9 0000 425a            jsr        _cmpbuf
[00000ac6] 508f                      addq.l     #8,a7
[00000ac8] 4a87                      tst.l      d7
[00000aca] 6722                      beq.s      _undef_4
_undef_3:
[00000acc] 2e0b                      move.l     a3,d7
[00000ace] 6722                      beq.s      _undef_5
[00000ad0] 4297                      clr.l      (a7)
[00000ad2] 2f2b 0004                 move.l     4(a3),-(a7)
[00000ad6] 4eb9 0000 4b5c            jsr        _free
[00000adc] 588f                      addq.l     #4,a7
[00000ade] 2e93                      move.l     (a3),(a7)
[00000ae0] 2f0b                      move.l     a3,-(a7)
[00000ae2] 4eb9 0000 4b5c            jsr        _free
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
[00000b5c] d5fc 0000 5b94            adda.l     #$0000B242,a2
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
[00000b7a] 2f3c 0000 5cc2            move.l     #$0000B370,-(a7)
[00000b80] 4eb9 0000 48be            jsr        _scnstr
[00000b86] 588f                      addq.l     #4,a7
[00000b88] 1d47 fff3                 move.b     d7,-13(a6)
[00000b8c] 4287                      clr.l      d7
[00000b8e] 1e2e fff3                 move.b     -13(a6),d7
[00000b92] 2447                      movea.l    d7,a2
[00000b94] d5fc 0000 5cc2            adda.l     #$0000B370,a2
[00000b9a] 4a12                      tst.b      (a2)
[00000b9c] 6726                      beq.s      _dobesc_7
[00000b9e] 247c 0000 5cce            movea.l    #$0000B37C,a2
[00000ba4] 4287                      clr.l      d7
[00000ba6] 1e2e fff3                 move.b     -13(a6),d7
[00000baa] d5c7                      adda.l     d7,a2
[00000bac] 4287                      clr.l      d7
[00000bae] 1e12                      move.b     (a2),d7
[00000bb0] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000bb6] 2447                      movea.l    d7,a2
[00000bb8] d5fc 0000 5b94            adda.l     #$0000B242,a2
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
[00000bea] 2f3c 0000 5c94            move.l     #$0000B342,-(a7)
[00000bf0] 4eb9 0000 48be            jsr        _scnstr
[00000bf6] 588f                      addq.l     #4,a7
[00000bf8] 2d47 fff4                 move.l     d7,-12(a6)
[00000bfc] 246e fff4                 movea.l    -12(a6),a2
[00000c00] d5fc 0000 5c94            adda.l     #$0000B342,a2
[00000c06] 4a12                      tst.b      (a2)
[00000c08] 6772                      beq.s      _dobesc_10
[00000c0a] 4287                      clr.l      d7
[00000c0c] 1e2e fff3                 move.b     -13(a6),d7
[00000c10] e987                      asl.l      #4,d7
[00000c12] 247c 0000 5cab            movea.l    #$0000B359,a2
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
[00000c4c] 2f3c 0000 5c94            move.l     #$0000B342,-(a7)
[00000c52] 4eb9 0000 48be            jsr        _scnstr
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
[00000c92] d5fc 0000 5b94            adda.l     #$0000B242,a2
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
[00000cf8] 2f3c 0000 5882            move.l     #$0000AF30,-(a7)
[00000cfe] 4eb9 0000 34aa            jsr        _scntab
[00000d04] 4fef 000c                 lea.l      12(a7),a7
[00000d08] 2d47 fff8                 move.l     d7,-8(a6)
[00000d0c] 6628                      bne.s      _dopunct_3
[00000d0e] 4ab9 0000 61f2            tst.l      _std
[00000d14] 664a                      bne.s      _dopunct_4
[00000d16] 2e85                      move.l     d5,(a7)
[00000d18] 486e fffd                 pea.l      -3(a6)
[00000d1c] 4878 0015                 pea.l      ($00000015).w
[00000d20] 2f3c 0000 5a96            move.l     #$0000B144,-(a7)
[00000d26] 4eb9 0000 34aa            jsr        _scntab
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
[00000d44] 2f3c 0000 5cda            move.l     #$0000B388,-(a7) "illegal character: %c"
[00000d4a] 4eb9 0000 324a            jsr        _p0error
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
[00000dae] 2ebc 0000 5cf0            move.l     #$0000B39E,(a7) "illegal #if expression"
[00000db4] 4eb9 0000 324a            jsr        _p0error
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
[00000e82] 2f3c 0000 585a            move.l     #$0000AF08,-(a7)
[00000e88] 4eb9 0000 48be            jsr        _scnstr
[00000e8e] 588f                      addq.l     #4,a7
[00000e90] 2807                      move.l     d7,d4
[00000e92] 2444                      movea.l    d4,a2
[00000e94] d5fc 0000 585a            adda.l     #$0000AF08,a2
[00000e9a] 4a12                      tst.b      (a2)
[00000e9c] 6604                      bne.s      _expri_2
_expri_1:
[00000e9e] 4287                      clr.l      d7
[00000ea0] 600c                      bra.s      _expri_3
_expri_2:
[00000ea2] 2444                      movea.l    d4,a2
[00000ea4] d5fc 0000 586e            adda.l     #$0000AF1C,a2
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
[00000f5c] 41f9 0000 5d08            lea.l      $0000B3B6,a0
[00000f62] 4ef9 0000 48e0            jmp        a.switch
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
[00000f94] 4eb9 0000 5122            jsr        a.lmul
[00000f9a] 2d57 fffc                 move.l     (a7),-4(a6)
[00000f9e] 60d0                      bra.s      _extail_7
[00000fa0] 2eae fffc                 move.l     -4(a6),(a7)
[00000fa4] 2f2e fff4                 move.l     -12(a6),-(a7)
[00000fa8] 4eb9 0000 4640            jsr        a.ldiv
[00000fae] 2d57 fffc                 move.l     (a7),-4(a6)
[00000fb2] 60bc                      bra.s      _extail_7
[00000fb4] 2eae fffc                 move.l     -4(a6),(a7)
[00000fb8] 2f2e fff4                 move.l     -12(a6),-(a7)
[00000fbc] 4eb9 0000 462e            jsr        a.lmod
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
[000010f0] 2ebc 0000 5dc0            move.l     #$0000B46E,(a7) "illegal ? : in #if"
[000010f6] 4eb9 0000 324a            jsr        _p0error
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
[0000111a] 2ebc 0000 5da8            move.l     #$0000B456,(a7) "illegal operator in #if"
[00001120] 4eb9 0000 324a            jsr        _p0error
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
[0000121a] 2ebc 0000 5dec            move.l     #$0000B49A,(a7) "illegal #if syntax"
[00001220] 4eb9 0000 324a            jsr        _p0error
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
[0000124e] 2ebc 0000 5dff            move.l     #$0000B4AD,(a7) "missing ) in #if"
[00001254] 4eb9 0000 324a            jsr        _p0error
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
[000012cc] 2ebc 0000 5dd4            move.l     #$0000B482,(a7) "illegal unary op in #if"
[000012d2] 4eb9 0000 324a            jsr        _p0error
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
[00001342] 2f3c 0000 5c94            move.l     #$0000B342,-(a7)
[00001348] 4eb9 0000 48be            jsr        _scnstr
[0000134e] 588f                      addq.l     #4,a7
[00001350] 3d47 fff4                 move.w     d7,-12(a6)
[00001354] 3e2e fff4                 move.w     -12(a6),d7
[00001358] 48c7                      ext.l      d7
[0000135a] 2447                      movea.l    d7,a2
[0000135c] d5fc 0000 5c94            adda.l     #$0000B342,a2
[00001362] 4a12                      tst.b      (a2)
[00001364] 675a                      beq.s      _bton_5
[00001366] 247c 0000 5cab            movea.l    #$0000B359,a2
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
[00001398] 4eb9 0000 5122            jsr        a.lmul
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
[000013ee] 2f3c 0000 600a            move.l     #$0000B6B8,-(a7) "illegal integer %b"
[000013f4] 4eb9 0000 324a            jsr        _p0error
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
[00001492] 41f9 0000 7b26            lea.l      $0000D1D4,a0
[00001498] 4eb9 0000 5336            jsr        a.6mul
[0000149e] 76d0                      moveq.l    #-48,d3
[000014a0] 4282                      clr.l      d2
[000014a2] 1415                      move.b     (a5),d2
[000014a4] d682                      add.l      d2,d3
[000014a6] 2003                      move.l     d3,d0
[000014a8] 4eb9 0000 514e            jsr        a.1ltd
[000014ae] 91c8                      suba.l     a0,a0
[000014b0] 4eb9 0000 4ed8            jsr        a.6add
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
[00001538] 2f3c 0000 601e            move.l     #$0000B6CC,-(a7)
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
[00001662] 4eb9 0000 5122            jsr        a.lmul
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
[00001698] 4eb9 0000 4f86            jsr        _dtento
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
[000016e2] 2f3c 0000 6039            move.l     #$0000B6E7,-(a7)
[000016e8] 4eb9 0000 19aa            jsr        _putcode
[000016ee] 4fef 000c                 lea.l      12(a7),a7
[000016f2] bbfc 0000 6007            cmpa.l     #$0000B6B5,a5
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
[00001764] 2ebc 0000 6022            move.l     #$0000B6D0,(a7) "illegal float constant"
[0000176a] 4eb9 0000 324a            jsr        _p0error
[00001770] 60de                      bra.s      _lexfloat_12

_lexfnxt:
[00001772] 4e56 0000                 link       a6,#0
[00001776] 48e7 8004                 movem.l    d0/a5,-(a7)
[0000177a] 246e 0008                 movea.l    8(a6),a2
[0000177e] 2a52                      movea.l    (a2),a5
[00001780] 2e2e 000c                 move.l     12(a6),d7
[00001784] 0c87 0000 6007            cmpi.l     #$0000B6B5,d7
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
[000017a8] 2e3c 0000 6007            move.l     #$0000B6B5,d7
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
[000017e4] 1e39 0000 6206            move.b     $0000B8B4,d7
[000017ea] ba87                      cmp.l      d7,d5
[000017ec] 662e                      bne.s      _lexident_3
[000017ee] 2e85                      move.l     d5,(a7)
[000017f0] 2f3c 0000 6207            move.l     #$0000B8B5,-(a7)
[000017f6] 2f2d 0010                 move.l     16(a5),-(a7)
[000017fa] 4eb9 0000 425a            jsr        _cmpbuf
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
[00001826] 2f3c 0000 5e10            move.l     #$0000B4BE,-(a7)
[0000182c] 4eb9 0000 34aa            jsr        _scntab
[00001832] 4fef 000c                 lea.l      12(a7),a7
[00001836] 2807                      move.l     d7,d4
_lexident_4:
[00001838] 4a84                      tst.l      d4
[0000183a] 6712                      beq.s      _lexident_5
[0000183c] 2e84                      move.l     d4,(a7)
[0000183e] 2f3c 0000 6040            move.l     #$0000B6EE,-(a7)
[00001844] 4eb9 0000 19aa            jsr        _putcode
[0000184a] 588f                      addq.l     #4,a7
[0000184c] 601c                      bra.s      _lexident_6
_lexident_5:
[0000184e] 2e85                      move.l     d5,(a7)
[00001850] 2f2d 0010                 move.l     16(a5),-(a7)
[00001854] 2f05                      move.l     d5,-(a7)
[00001856] 4878 0012                 pea.l      ($00000012).w
[0000185a] 2f3c 0000 603c            move.l     #$0000B6EA,-(a7)
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
[000018cc] 2f3c 0000 6042            move.l     #$0000B6F0,-(a7)
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
[000018f8] 2f3c 0000 6046            move.l     #$0000B6F4,-(a7)
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
[00001946] 2f3c 0000 6048            move.l     #$0000B6F6,-(a7)
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
[00001990] 2f3c 0000 604c            move.l     #$0000B6FA,-(a7)
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
[000019ca] 3e39 0000 78de            move.w     $0000CF8C,d7
[000019d0] 48c7                      ext.l      d7
[000019d2] 0c47 0200                 cmpi.w     #$0200,d7
[000019d6] 6c26                      bge.s      _putcode_3
[000019d8] 3e39 0000 78de            move.w     $0000CF8C,d7
[000019de] 48c7                      ext.l      d7
[000019e0] 2447                      movea.l    d7,a2
[000019e2] 5279 0000 78de            addq.w     #1,$0000CF8C
[000019e8] d5fc 0000 78e6            adda.l     #$0000CF94,a2
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
[00001a08] 2f3c 0000 78dc            move.l     #$0000CF8A,-(a7)
[00001a0e] 4eb9 0000 4710            jsr        _putc
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
[00001a46] 4eb9 0000 5450            jsr        _lenstr
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
[00001a60] 3e39 0000 78de            move.w     $0000CF8C,d7
[00001a66] 48c7                      ext.l      d7
[00001a68] 0c47 0200                 cmpi.w     #$0200,d7
[00001a6c] 6c28                      bge.s      _putcode_10
[00001a6e] 3e39 0000 78de            move.w     $0000CF8C,d7
[00001a74] 48c7                      ext.l      d7
[00001a76] 2447                      movea.l    d7,a2
[00001a78] 5279 0000 78de            addq.w     #1,$0000CF8C
[00001a7e] d5fc 0000 78e6            adda.l     #$0000CF94,a2
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
[00001aa2] 2f3c 0000 78dc            move.l     #$0000CF8A,-(a7)
[00001aa8] 4eb9 0000 4710            jsr        _putc
[00001aae] 588f                      addq.l     #4,a7
_putcode_11:
[00001ab0] 60a8                      bra.s      _putcode_12

_putfile:
[00001ab2] 4e56 0000                 link       a6,#0
[00001ab6] 48e7 8400                 movem.l    d0/d5,-(a7)
[00001aba] 4ab9 0000 61f6            tst.l      _xflag
[00001ac0] 6724                      beq.s      _putfile_1
[00001ac2] 4ab9 0000 6234            tst.l      $0000B8E2
[00001ac8] 671c                      beq.s      _putfile_1
[00001aca] 4ab9 0000 6226            tst.l      $0000B8D4
[00001ad0] 6714                      beq.s      _putfile_1
[00001ad2] 4a79 0000 6204            tst.w      $0000B8B2
[00001ad8] 6700 00e2                 beq        _putfile_2
[00001adc] 4ab9 0000 61e6            tst.l      _lincl
[00001ae2] 6600 00d8                 bne        _putfile_2
_putfile_1:
[00001ae6] 4ab9 0000 61de            tst.l      _cplus_flag
[00001aec] 6700 012e                 beq        _putfile_3
[00001af0] 4ab9 0000 6234            tst.l      $0000B8E2
[00001af6] 6700 0124                 beq        _putfile_3
[00001afa] 4ab9 0000 6226            tst.l      $0000B8D4
[00001b00] 6700 011a                 beq        _putfile_3
[00001b04] 4ab9 0000 61f6            tst.l      _xflag
[00001b0a] 6600 0110                 bne        _putfile_3
[00001b0e] 42b9 0000 6226            clr.l      $0000B8D4
[00001b14] 2479 0000 6234            movea.l    $0000B8E2,a2
[00001b1a] 588a                      addq.l     #4,a2
[00001b1c] 4a92                      tst.l      (a2)
[00001b1e] 6700 0104                 beq        _putfile_4
[00001b22] 4878 000a                 pea.l      ($0000000A).w
[00001b26] 2479 0000 6234            movea.l    $0000B8E2,a2
[00001b2c] 508a                      addq.l     #8,a2
[00001b2e] 4a52                      tst.w      (a2)
[00001b30] 670e                      beq.s      _putfile_5
[00001b32] 2479 0000 6234            movea.l    $0000B8E2,a2
[00001b38] 508a                      addq.l     #8,a2
[00001b3a] 4287                      clr.l      d7
[00001b3c] 3e12                      move.w     (a2),d7
[00001b3e] 600e                      bra.s      _putfile_6
_putfile_5:
[00001b40] 2479 0000 6234            movea.l    $0000B8E2,a2
[00001b46] 508a                      addq.l     #8,a2
[00001b48] 4287                      clr.l      d7
[00001b4a] 3e12                      move.w     (a2),d7
[00001b4c] 5287                      addq.l     #1,d7
_putfile_6:
[00001b4e] 2f07                      move.l     d7,-(a7)
[00001b50] 2f3c 0000 6052            move.l     #$0000B700,-(a7)
[00001b56] 4eb9 0000 40e4            jsr        _itob
[00001b5c] 4fef 000c                 lea.l      12(a7),a7
[00001b60] 2447                      movea.l    d7,a2
[00001b62] d5fc 0000 6052            adda.l     #$0000B700,a2
[00001b68] 4212                      clr.b      (a2)
[00001b6a] 4297                      clr.l      (a7)
[00001b6c] 2f3c 0000 615e            move.l     #$0000B80C,-(a7)
[00001b72] 2479 0000 6234            movea.l    $0000B8E2,a2
[00001b78] 588a                      addq.l     #4,a2
[00001b7a] 2f12                      move.l     (a2),-(a7)
[00001b7c] 2f3c 0000 6161            move.l     #$0000B80F,-(a7)
[00001b82] 2f3c 0000 6052            move.l     #$0000B700,-(a7)
[00001b88] 2f3c 0000 6164            move.l     #$0000B812,-(a7)
[00001b8e] 2f3c 0000 605e            move.l     #$0000B70C,-(a7)
[00001b94] 4eb9 0000 429c            jsr        _cpystr
[00001b9a] 4fef 0018                 lea.l      24(a7),a7
[00001b9e] 2ebc 0000 605e            move.l     #$0000B70C,(a7)
[00001ba4] 4eb9 0000 5450            jsr        _lenstr
[00001baa] 2e87                      move.l     d7,(a7)
[00001bac] 2f3c 0000 605e            move.l     #$0000B70C,-(a7)
[00001bb2] 4eb9 0000 417e            jsr        _putlin
[00001bb8] 588f                      addq.l     #4,a7
[00001bba] 6068                      bra.s      _putfile_4
_putfile_2:
[00001bbc] 4ab9 0000 621e            tst.l      $0000B8CC
[00001bc2] 6600 ff22                 bne        _putfile_1
[00001bc6] 42b9 0000 6226            clr.l      $0000B8D4
[00001bcc] 2479 0000 6234            movea.l    $0000B8E2,a2
[00001bd2] 588a                      addq.l     #4,a2
[00001bd4] 4a92                      tst.l      (a2)
[00001bd6] 6614                      bne.s      _putfile_7
[00001bd8] 4297                      clr.l      (a7)
[00001bda] 4878 0013                 pea.l      ($00000013).w
[00001bde] 2f3c 0000 616b            move.l     #$0000B819,-(a7)
[00001be4] 4eba fdc4                 jsr        _putcode(pc)
[00001be8] 508f                      addq.l     #8,a7
[00001bea] 6030                      bra.s      _putfile_3
_putfile_7:
[00001bec] 2479 0000 6234            movea.l    $0000B8E2,a2
[00001bf2] 588a                      addq.l     #4,a2
[00001bf4] 2e92                      move.l     (a2),(a7)
[00001bf6] 2479 0000 6234            movea.l    $0000B8E2,a2
[00001bfc] 588a                      addq.l     #4,a2
[00001bfe] 2f12                      move.l     (a2),-(a7)
[00001c00] 4eb9 0000 5450            jsr        _lenstr
[00001c06] 588f                      addq.l     #4,a7
[00001c08] 2f07                      move.l     d7,-(a7)
[00001c0a] 4878 0013                 pea.l      ($00000013).w
[00001c0e] 2f3c 0000 6167            move.l     #$0000B815,-(a7)
[00001c14] 4eba fd94                 jsr        _putcode(pc)
[00001c18] 4fef 000c                 lea.l      12(a7),a7
_putfile_3:
[00001c1c] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00001c20] 4e5e                      unlk       a6
[00001c22] 4e75                      rts
_putfile_4:
[00001c24] 2479 0000 6234            movea.l    $0000B8E2,a2
[00001c2a] 508a                      addq.l     #8,a2
[00001c2c] 33d2 0000 6008            move.w     (a2),$0000B6B6
[00001c32] 60e8                      bra.s      _putfile_3

_putls:
[00001c34] 4e56 fffc                 link       a6,#-4
[00001c38] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[00001c3c] 2a6e 0008                 movea.l    8(a6),a5
[00001c40] 4ab9 0000 61f6            tst.l      _xflag
[00001c46] 6638                      bne.s      _putls_1
[00001c48] 4ab9 0000 61de            tst.l      _cplus_flag
[00001c4e] 6742                      beq.s      _putls_2
[00001c50] 4ab9 0000 6234            tst.l      $0000B8E2
[00001c56] 673a                      beq.s      _putls_2
[00001c58] 4287                      clr.l      d7
[00001c5a] 3e39 0000 6008            move.w     $0000B6B6,d7
[00001c60] 5287                      addq.l     #1,d7
[00001c62] 2479 0000 6234            movea.l    $0000B8E2,a2
[00001c68] 508a                      addq.l     #8,a2
[00001c6a] 4286                      clr.l      d6
[00001c6c] 3c12                      move.w     (a2),d6
[00001c6e] be86                      cmp.l      d6,d7
[00001c70] 6720                      beq.s      _putls_2
[00001c72] 7001                      moveq.l    #1,d0
[00001c74] 23c0 0000 6226            move.l     d0,$0000B8D4
[00001c7a] 4eba fe36                 jsr        _putfile(pc)
[00001c7e] 6012                      bra.s      _putls_2
_putls_1:
[00001c80] 284d                      movea.l    a5,a4
_putls_4:
[00001c82] 0cac 0000 0007 0004       cmpi.l     #$00000007,4(a4)
[00001c8a] 6600 008c                 bne        _putls_3
[00001c8e] 2854                      movea.l    (a4),a4
[00001c90] 60f0                      bra.s      _putls_4
_putls_2:
[00001c92] 2479 0000 6234            movea.l    $0000B8E2,a2
[00001c98] 508a                      addq.l     #8,a2
[00001c9a] 33d2 0000 6008            move.w     (a2),$0000B6B6
[00001ca0] 284d                      movea.l    a5,a4
[00001ca2] 42ae fffc                 clr.l      -4(a6)
_putls_11:
[00001ca6] 2e0c                      move.l     a4,d7
[00001ca8] 6766                      beq.s      _putls_5
[00001caa] 4aae fffc                 tst.l      -4(a6)
[00001cae] 660a                      bne.s      _putls_6
[00001cb0] 0cac 0000 0008 0004       cmpi.l     #$00000008,4(a4)
[00001cb8] 6710                      beq.s      _putls_7
_putls_6:
[00001cba] 4aae fffc                 tst.l      -4(a6)
[00001cbe] 672c                      beq.s      _putls_8
[00001cc0] 0cac 0000 0008 0004       cmpi.l     #$00000008,4(a4)
[00001cc8] 6722                      beq.s      _putls_8
_putls_7:
[00001cca] 4aae fffc                 tst.l      -4(a6)
[00001cce] 6604                      bne.s      _putls_9
[00001cd0] 7e01                      moveq.l    #1,d7
[00001cd2] 6002                      bra.s      _putls_10
_putls_9:
[00001cd4] 4287                      clr.l      d7
_putls_10:
[00001cd6] 2d47 fffc                 move.l     d7,-4(a6)
[00001cda] 4878 0001                 pea.l      ($00000001).w
[00001cde] 2f3c 0000 61ab            move.l     #$0000B859,-(a7)
[00001ce4] 4eb9 0000 417e            jsr        _putlin
[00001cea] 508f                      addq.l     #8,a7
_putls_8:
[00001cec] 2eac 000c                 move.l     12(a4),(a7)
[00001cf0] 2f2c 0008                 move.l     8(a4),-(a7)
[00001cf4] 4eb9 0000 417e            jsr        _putlin
[00001cfa] 588f                      addq.l     #4,a7
[00001cfc] 2eac 0014                 move.l     20(a4),(a7)
[00001d00] 2f2c 0010                 move.l     16(a4),-(a7)
[00001d04] 4eb9 0000 417e            jsr        _putlin
[00001d0a] 588f                      addq.l     #4,a7
[00001d0c] 2854                      movea.l    (a4),a4
[00001d0e] 6096                      bra.s      _putls_11
_putls_5:
[00001d10] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[00001d14] 4e5e                      unlk       a6
[00001d16] 4e75                      rts
_putls_3:
[00001d18] 4eba fd98                 jsr        _putfile(pc)
[00001d1c] 4eb9 0000 345e            jsr        _ptline
_putls_12:
[00001d22] 0cad 0000 0002 0004       cmpi.l     #$00000002,4(a5)
[00001d2a] 67e4                      beq.s      _putls_5
[00001d2c] 2e2d 0004                 move.l     4(a5),d7
[00001d30] 41f9 0000 616e            lea.l      $0000B81C,a0
[00001d36] 4ef9 0000 48e0            jmp        a.switch
[00001d3c] 2e8d                      move.l     a5,(a7)
[00001d3e] 4eba fa82                 jsr        _lexident(pc)
[00001d42] 2a47                      movea.l    d7,a5
[00001d44] 60dc                      bra.s      _putls_12
[00001d46] 60da                      bra.s      _putls_12
[00001d48] 2e8d                      move.l     a5,(a7)
[00001d4a] 4eba fbc2                 jsr        _lexstrin(pc)
[00001d4e] 2a47                      movea.l    d7,a5
[00001d50] 60d0                      bra.s      _putls_12
[00001d52] 2e8d                      move.l     a5,(a7)
[00001d54] 4eba fc0a                 jsr        _lexxstr(pc)
[00001d58] 2a47                      movea.l    d7,a5
[00001d5a] 60c6                      bra.s      _putls_12
[00001d5c] 2e8d                      move.l     a5,(a7)
[00001d5e] 4eba f76c                 jsr        _lexchars(pc)
[00001d62] 2a47                      movea.l    d7,a5
[00001d64] 60bc                      bra.s      _putls_12
[00001d66] 45f8 000c                 lea.l      ($0000000C).w,a2
[00001d6a] d5d5                      adda.l     (a5),a2
[00001d6c] 4a92                      tst.l      (a2)
[00001d6e] 6656                      bne.s      _putls_13
[00001d70] 45f8 0014                 lea.l      ($00000014).w,a2
[00001d74] d5d5                      adda.l     (a5),a2
[00001d76] 0c92 0000 0001            cmpi.l     #$00000001,(a2)
[00001d7c] 6648                      bne.s      _putls_13
[00001d7e] 45f8 0010                 lea.l      ($00000010).w,a2
[00001d82] d5d5                      adda.l     (a5),a2
[00001d84] 2452                      movea.l    (a2),a2
[00001d86] 4287                      clr.l      d7
[00001d88] 1e12                      move.b     (a2),d7
[00001d8a] 0c47 002e                 cmpi.w     #$002E,d7
[00001d8e] 6636                      bne.s      _putls_13
[00001d90] 2455                      movea.l    (a5),a2
[00001d92] 4a92                      tst.l      (a2)
[00001d94] 676e                      beq.s      _putls_14
[00001d96] 45f8 000c                 lea.l      ($0000000C).w,a2
[00001d9a] 2655                      movea.l    (a5),a3
[00001d9c] d5d3                      adda.l     (a3),a2
[00001d9e] 4a92                      tst.l      (a2)
[00001da0] 6662                      bne.s      _putls_14
[00001da2] 45f8 0014                 lea.l      ($00000014).w,a2
[00001da6] 2655                      movea.l    (a5),a3
[00001da8] d5d3                      adda.l     (a3),a2
[00001daa] 0c92 0000 0001            cmpi.l     #$00000001,(a2)
[00001db0] 6652                      bne.s      _putls_14
[00001db2] 45f8 0010                 lea.l      ($00000010).w,a2
[00001db6] 2655                      movea.l    (a5),a3
[00001db8] d5d3                      adda.l     (a3),a2
[00001dba] 2452                      movea.l    (a2),a2
[00001dbc] 4287                      clr.l      d7
[00001dbe] 1e12                      move.b     (a2),d7
[00001dc0] 0c47 002e                 cmpi.w     #$002E,d7
[00001dc4] 663e                      bne.s      _putls_14
_putls_13:
[00001dc6] 2ebc 0000 61a6            move.l     #$0000B854,(a7)
[00001dcc] 2f2d 0014                 move.l     20(a5),-(a7)
[00001dd0] 2f2d 0010                 move.l     16(a5),-(a7)
[00001dd4] 4eb9 0000 409e            jsr        _inbuf
[00001dda] 508f                      addq.l     #8,a7
[00001ddc] 2a07                      move.l     d7,d5
[00001dde] baad 0014                 cmp.l      20(a5),d5
[00001de2] 642c                      bcc.s      _putls_15
[00001de4] 246d 0010                 movea.l    16(a5),a2
[00001de8] d5c5                      adda.l     d5,a2
[00001dea] 4287                      clr.l      d7
[00001dec] 1e12                      move.b     (a2),d7
[00001dee] 0c47 0065                 cmpi.w     #$0065,d7
[00001df2] 6710                      beq.s      _putls_14
[00001df4] 246d 0010                 movea.l    16(a5),a2
[00001df8] d5c5                      adda.l     d5,a2
[00001dfa] 4287                      clr.l      d7
[00001dfc] 1e12                      move.b     (a2),d7
[00001dfe] 0c47 0045                 cmpi.w     #$0045,d7
[00001e02] 660c                      bne.s      _putls_15
_putls_14:
[00001e04] 2e8d                      move.l     a5,(a7)
[00001e06] 4eba f74a                 jsr        _lexfloat(pc)
[00001e0a] 2a47                      movea.l    d7,a5
[00001e0c] 6000 ff14                 bra        _putls_12
_putls_15:
[00001e10] 2e8d                      move.l     a5,(a7)
[00001e12] 4eba fa60                 jsr        _lexint(pc)
[00001e16] 2a47                      movea.l    d7,a5
[00001e18] 6000 ff08                 bra        _putls_12
[00001e1c] 2a55                      movea.l    (a5),a5
[00001e1e] 6000 ff02                 bra        _putls_12
[00001e22] 0cad 0000 0001 0014       cmpi.l     #$00000001,20(a5)
[00001e2a] 6630                      bne.s      _putls_16
[00001e2c] 246d 0010                 movea.l    16(a5),a2
[00001e30] 4287                      clr.l      d7
[00001e32] 1e12                      move.b     (a2),d7
[00001e34] 0c47 002e                 cmpi.w     #$002E,d7
[00001e38] 6622                      bne.s      _putls_16
[00001e3a] 45f8 000c                 lea.l      ($0000000C).w,a2
[00001e3e] d5d5                      adda.l     (a5),a2
[00001e40] 4a92                      tst.l      (a2)
[00001e42] 6618                      bne.s      _putls_16
[00001e44] 2455                      movea.l    (a5),a2
[00001e46] 588a                      addq.l     #4,a2
[00001e48] 0c92 0000 0004            cmpi.l     #$00000004,(a2)
[00001e4e] 660c                      bne.s      _putls_16
[00001e50] 2e8d                      move.l     a5,(a7)
[00001e52] 4eba f6fe                 jsr        _lexfloat(pc)
[00001e56] 2a47                      movea.l    d7,a5
[00001e58] 6000 fec8                 bra        _putls_12
_putls_16:
[00001e5c] 2e8d                      move.l     a5,(a7)
[00001e5e] 4eba fa86                 jsr        _lexpunct(pc)
[00001e62] 2a47                      movea.l    d7,a5
[00001e64] 6000 febc                 bra        _putls_12

_getex:
[00001e68] 4e56 0000                 link       a6,#0
[00001e6c] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00001e70] 2eae 0008                 move.l     8(a6),(a7)
[00001e74] 4eb9 0000 2004            jsr        _getinl
[00001e7a] 2a47                      movea.l    d7,a5
[00001e7c] 2e0d                      move.l     a5,d7
[00001e7e] 671c                      beq.s      _getex_1
[00001e80] 0cad 0000 0001 0014       cmpi.l     #$00000001,20(a5)
[00001e88] 661c                      bne.s      _getex_2
[00001e8a] 246d 0010                 movea.l    16(a5),a2
[00001e8e] 4287                      clr.l      d7
[00001e90] 1e12                      move.b     (a2),d7
[00001e92] beb9 0000 61fa            cmp.l      _pchar,d7
[00001e98] 6726                      beq.s      _getex_3
[00001e9a] 600a                      bra.s      _getex_2
_getex_1:
[00001e9c] 2e0d                      move.l     a5,d7
[00001e9e] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00001ea2] 4e5e                      unlk       a6
[00001ea4] 4e75                      rts
_getex_2:
[00001ea6] 0cad 0000 0001 0014       cmpi.l     #$00000001,20(a5)
[00001eae] 6624                      bne.s      _getex_4
[00001eb0] 246d 0010                 movea.l    16(a5),a2
[00001eb4] 4287                      clr.l      d7
[00001eb6] 1e12                      move.b     (a2),d7
[00001eb8] beb9 0000 61fe            cmp.l      _schar,d7
[00001ebe] 6614                      bne.s      _getex_4
_getex_3:
[00001ec0] 4aae 0008                 tst.l      8(a6)
[00001ec4] 671e                      beq.s      _getex_5
[00001ec6] 2ebc 0000 6476            move.l     #$0000BB24,(a7) "#line inside macro"
[00001ecc] 4eb9 0000 324a            jsr        _p0error
[00001ed2] 6010                      bra.s      _getex_5
_getex_4:
[00001ed4] 2e2d 0004                 move.l     4(a5),d7
[00001ed8] 41f9 0000 6426            lea.l      $0000BAD4,a0
[00001ede] 4ef9 0000 48e0            jmp        a.switch
_getex_5:
[00001ee4] 45f8 0014                 lea.l      ($00000014).w,a2
[00001ee8] d5d5                      adda.l     (a5),a2
[00001eea] 2e92                      move.l     (a2),(a7)
[00001eec] 45f8 0010                 lea.l      ($00000010).w,a2
[00001ef0] d5d5                      adda.l     (a5),a2
[00001ef2] 2f12                      move.l     (a2),-(a7)
[00001ef4] 4878 0018                 pea.l      ($00000018).w
[00001ef8] 2f3c 0000 62c0            move.l     #$0000B96E,-(a7)
[00001efe] 4eb9 0000 34aa            jsr        _scntab
[00001f04] 4fef 000c                 lea.l      12(a7),a7
[00001f08] 2a07                      move.l     d7,d5
[00001f0a] 6714                      beq.s      _getex_6
[00001f0c] 2e95                      move.l     (a5),(a7)
[00001f0e] 2f0d                      move.l     a5,-(a7)
[00001f10] 4eb9 0000 2c5c            jsr        _fretlist
[00001f16] 588f                      addq.l     #4,a7
[00001f18] 2a47                      movea.l    d7,a5
[00001f1a] 2b45 0004                 move.l     d5,4(a5)
[00001f1e] 60b4                      bra.s      _getex_4
_getex_6:
[00001f20] 7014                      moveq.l    #20,d0
[00001f22] 2b40 0004                 move.l     d0,4(a5)
[00001f26] 60ac                      bra.s      _getex_4
[00001f28] 4297                      clr.l      (a7)
[00001f2a] 2f0d                      move.l     a5,-(a7)
[00001f2c] 4eb9 0000 0708            jsr        _doexp
[00001f32] 588f                      addq.l     #4,a7
[00001f34] 2a47                      movea.l    d7,a5
[00001f36] 6000 ff64                 bra        _getex_1
[00001f3a] 6000 ff60                 bra        _getex_1
[00001f3e] 6000 ff5c                 bra        _getex_1
[00001f42] 6000 ff58                 bra        _getex_1
[00001f46] 6000 ff54                 bra        _getex_1
[00001f4a] 5279 0000 6202            addq.w     #1,$0000B8B0
[00001f50] 4297                      clr.l      (a7)
[00001f52] 2f0d                      move.l     a5,-(a7)
[00001f54] 4eb9 0000 0708            jsr        _doexp
[00001f5a] 588f                      addq.l     #4,a7
[00001f5c] 2a47                      movea.l    d7,a5
[00001f5e] 5379 0000 6202            subq.w     #1,$0000B8B0
[00001f64] 6000 ff36                 bra        _getex_1
[00001f68] 2455                      movea.l    (a5),a2
[00001f6a] 588a                      addq.l     #4,a2
[00001f6c] 0c92 0000 0003            cmpi.l     #$00000003,(a2)
[00001f72] 671a                      beq.s      _getex_7
[00001f74] 2ead 0014                 move.l     20(a5),(a7)
[00001f78] 2f2d 0010                 move.l     16(a5),-(a7)
[00001f7c] 2f3c 0000 646e            move.l     #$0000BB1C,-(a7) "bad #%b"
[00001f82] 4eb9 0000 324a            jsr        _p0error
[00001f88] 508f                      addq.l     #8,a7
[00001f8a] 6000 ff10                 bra        _getex_1
_getex_7:
[00001f8e] 4297                      clr.l      (a7)
[00001f90] 45f8 0014                 lea.l      ($00000014).w,a2
[00001f94] d5d5                      adda.l     (a5),a2
[00001f96] 2f12                      move.l     (a2),-(a7)
[00001f98] 45f8 0010                 lea.l      ($00000010).w,a2
[00001f9c] d5d5                      adda.l     (a5),a2
[00001f9e] 2f12                      move.l     (a2),-(a7)
[00001fa0] 4eb9 0000 2fc6            jsr        _lookup
[00001fa6] 508f                      addq.l     #8,a7
[00001fa8] 4a87                      tst.l      d7
[00001faa] 6600 fef0                 bne        _getex_1
[00001fae] 45f8 0014                 lea.l      ($00000014).w,a2
[00001fb2] d5d5                      adda.l     (a5),a2
[00001fb4] 2e92                      move.l     (a2),(a7)
[00001fb6] 45f8 0010                 lea.l      ($00000010).w,a2
[00001fba] d5d5                      adda.l     (a5),a2
[00001fbc] 2f12                      move.l     (a2),-(a7)
[00001fbe] 4878 0003                 pea.l      ($00000003).w
[00001fc2] 2f3c 0000 5730            move.l     #$0000ADDE,-(a7)
[00001fc8] 4eb9 0000 34aa            jsr        _scntab
[00001fce] 4fef 000c                 lea.l      12(a7),a7
[00001fd2] 4a87                      tst.l      d7
[00001fd4] 6600 fec6                 bne        _getex_1
[00001fd8] 4297                      clr.l      (a7)
[00001fda] 2f15                      move.l     (a5),-(a7)
[00001fdc] 4eb9 0000 2c5c            jsr        _fretlist
[00001fe2] 588f                      addq.l     #4,a7
[00001fe4] 2a87                      move.l     d7,(a5)
[00001fe6] 6000 feb4                 bra        _getex_1
[00001fea] 4aae 0008                 tst.l      8(a6)
[00001fee] 6600 feac                 bne        _getex_1
[00001ff2] 4297                      clr.l      (a7)
[00001ff4] 2f0d                      move.l     a5,-(a7)
[00001ff6] 4eb9 0000 0708            jsr        _doexp
[00001ffc] 588f                      addq.l     #4,a7
[00001ffe] 2a47                      movea.l    d7,a5
[00002000] 6000 fe9a                 bra        _getex_1

_getinl:
[00002004] 4e56 fff8                 link       a6,#-8
[00002008] 4aae 0008                 tst.l      8(a6)
[0000200c] 6606                      bne.s      _getinl_1
[0000200e] 42b9 0000 648e            clr.l      $0000BB3C
_getinl_1:
[00002014] 4ab9 0000 6234            tst.l      $0000B8E2
[0000201a] 6612                      bne.s      _getinl_2
[0000201c] 4eb9 0000 303a            jsr        _nxtfile
[00002022] 23c7 0000 6234            move.l     d7,$0000B8E2
[00002028] 4eb9 0000 1ab2            jsr        _putfile
_getinl_2:
[0000202e] 4ab9 0000 6234            tst.l      $0000B8E2
[00002034] 6606                      bne.s      _getinl_3
[00002036] 4287                      clr.l      d7
[00002038] 4e5e                      unlk       a6
[0000203a] 4e75                      rts
_getinl_3:
[0000203c] 2e3c 0000 1000            move.l     #$00001000,d7
[00002042] 9eb9 0000 648e            sub.l      $0000BB3C,d7
[00002048] 2e87                      move.l     d7,(a7)
[0000204a] 2e3c 0000 6492            move.l     #$0000BB40,d7
[00002050] deb9 0000 648e            add.l      $0000BB3C,d7
[00002056] 2f07                      move.l     d7,-(a7)
[00002058] 2f39 0000 6234            move.l     $0000B8E2,-(a7)
[0000205e] 4eb9 0000 2134            jsr        _getln
[00002064] 508f                      addq.l     #8,a7
[00002066] 2d47 fffc                 move.l     d7,-4(a6)
[0000206a] 672e                      beq.s      _getinl_4
[0000206c] 2e2e fffc                 move.l     -4(a6),d7
[00002070] dfb9 0000 648e            add.l      d7,$0000BB3C
[00002076] 2ebc 0000 648a            move.l     #$0000BB38,(a7)
[0000207c] 2e39 0000 648e            move.l     $0000BB3C,d7
[00002082] 9eae fffc                 sub.l      -4(a6),d7
[00002086] 2f07                      move.l     d7,-(a7)
[00002088] 0697 0000 6492            addi.l     #$0000BB40,(a7)
[0000208e] 4eb9 0000 354a            jsr        _stotl
[00002094] 588f                      addq.l     #4,a7
[00002096] 4e5e                      unlk       a6
[00002098] 4e75                      rts
_getinl_4:
[0000209a] 4ab9 0000 648a            tst.l      $0000BB38
[000020a0] 6726                      beq.s      _getinl_5
[000020a2] 2ebc 0000 7494            move.l     #$0000CB42,(a7) "unbalanced comment in file"
[000020a8] 4eb9 0000 324a            jsr        _p0error
[000020ae] 42b9 0000 648a            clr.l      $0000BB38
[000020b4] 4297                      clr.l      (a7)
[000020b6] 2f3c 0000 7492            move.l     #$0000CB40,-(a7)
[000020bc] 4eb9 0000 354a            jsr        _stotl
[000020c2] 588f                      addq.l     #4,a7
[000020c4] 4e5e                      unlk       a6
[000020c6] 4e75                      rts
_getinl_5:
[000020c8] 2479 0000 6234            movea.l    $0000B8E2,a2
[000020ce] 508a                      addq.l     #8,a2
[000020d0] 5252                      addq.w     #1,(a2)
[000020d2] 4eb9 0000 345e            jsr        _ptline
[000020d8] 7e0a                      moveq.l    #10,d7
[000020da] deb9 0000 6234            add.l      $0000B8E2,d7
[000020e0] 2e87                      move.l     d7,(a7)
[000020e2] 4eb9 0000 392c            jsr        _fclose
[000020e8] 4297                      clr.l      (a7)
[000020ea] 2479 0000 6234            movea.l    $0000B8E2,a2
[000020f0] 588a                      addq.l     #4,a2
[000020f2] 2f12                      move.l     (a2),-(a7)
[000020f4] 4eb9 0000 4b5c            jsr        _free
[000020fa] 588f                      addq.l     #4,a7
[000020fc] 2479 0000 6234            movea.l    $0000B8E2,a2
[00002102] 2e92                      move.l     (a2),(a7)
[00002104] 2f39 0000 6234            move.l     $0000B8E2,-(a7)
[0000210a] 4eb9 0000 4b5c            jsr        _free
[00002110] 588f                      addq.l     #4,a7
[00002112] 23c7 0000 6234            move.l     d7,$0000B8E2
[00002118] 7001                      moveq.l    #1,d0
[0000211a] 23c0 0000 6226            move.l     d0,$0000B8D4
[00002120] 4a79 0000 6204            tst.w      $0000B8B2
[00002126] 6700 feec                 beq        _getinl_1
[0000212a] 5379 0000 6204            subq.w     #1,$0000B8B2
[00002130] 6000 fee2                 bra        _getinl_1

_getln:
[00002134] 4e56 0000                 link       a6,#0
[00002138] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000213c] 2a6e 000c                 movea.l    12(a6),a5
[00002140] 53ae 0010                 subq.l     #1,16(a6)
[00002144] 284d                      movea.l    a5,a4
_getln_5:
[00002146] 2e2e 0010                 move.l     16(a6),d7
[0000214a] 2c0c                      move.l     a4,d6
[0000214c] 9c8d                      sub.l      a5,d6
[0000214e] 9e86                      sub.l      d6,d7
[00002150] 2e87                      move.l     d7,(a7)
[00002152] 2f0c                      move.l     a4,-(a7)
[00002154] 7e0a                      moveq.l    #10,d7
[00002156] deae 0008                 add.l      8(a6),d7
[0000215a] 2f07                      move.l     d7,-(a7)
[0000215c] 4eb9 0000 4534            jsr        _getl
[00002162] 508f                      addq.l     #8,a7
[00002164] 2a07                      move.l     d7,d5
[00002166] 6f36                      ble.s      _getln_1
[00002168] 246e 0008                 movea.l    8(a6),a2
[0000216c] 508a                      addq.l     #8,a2
[0000216e] 5252                      addq.w     #1,(a2)
[00002170] 246e 0008                 movea.l    8(a6),a2
[00002174] 508a                      addq.l     #8,a2
[00002176] 33d2 0000 622e            move.w     (a2),$0000B8DC
[0000217c] d9c5                      adda.l     d5,a4
[0000217e] 0c85 0000 0001            cmpi.l     #$00000001,d5
[00002184] 6d18                      blt.s      _getln_1
[00002186] 4287                      clr.l      d7
[00002188] 1e2c fffe                 move.b     -2(a4),d7
[0000218c] 0c47 005c                 cmpi.w     #$005C,d7
[00002190] 660c                      bne.s      _getln_1
[00002192] 4287                      clr.l      d7
[00002194] 1e2c ffff                 move.b     -1(a4),d7
[00002198] 0c47 000a                 cmpi.w     #$000A,d7
[0000219c] 6712                      beq.s      _getln_2
_getln_1:
[0000219e] 4214                      clr.b      (a4)
[000021a0] 2e0d                      move.l     a5,d7
[000021a2] deae 0010                 add.l      16(a6),d7
[000021a6] b9c7                      cmpa.l     d7,a4
[000021a8] 640a                      bcc.s      _getln_3
[000021aa] 2e0c                      move.l     a4,d7
[000021ac] 9e8d                      sub.l      a5,d7
[000021ae] 6020                      bra.s      _getln_4
_getln_2:
[000021b0] 558c                      subq.l     #2,a4
[000021b2] 6092                      bra.s      _getln_5
_getln_3:
[000021b4] 2ebc 0000 74b0            move.l     #$0000CB5E,(a7) "folded line"
[000021ba] 4eb9 0000 324a            jsr        _p0error
[000021c0] 244d                      movea.l    a5,a2
[000021c2] d5ee 0010                 adda.l     16(a6),a2
[000021c6] 14bc 000a                 move.b     #$0A,(a2)
[000021ca] 2e2e 0010                 move.l     16(a6),d7
[000021ce] 5287                      addq.l     #1,d7
_getln_4:
[000021d0] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000021d4] 4e5e                      unlk       a6
[000021d6] 4e75                      rts

_main:
[000021d8] 4e56 fffe                 link       a6,#-2
[000021dc] 48e7 8004                 movem.l    d0/a5,-(a7)
[000021e0] 23ee 000c 0000 6238       move.l     12(a6),_argv
[000021e8] 23ee 0008 0000 622a       move.l     8(a6),_argc
[000021f0] 2ebc 0000 61f6            move.l     #_xflag,(a7) _xflag
[000021f6] 2f3c 0000 61fe            move.l     #_schar,-(a7) _schar
[000021fc] 2f3c 0000 61f2            move.l     #_std,-(a7) _std
[00002202] 2f3c 0000 61fa            move.l     #_pchar,-(a7) _pchar
[00002208] 2f3c 0000 61ee            move.l     #_forpascal,-(a7) _forpascal
[0000220e] 2f3c 0000 61da            move.l     #_ofile,-(a7) _ofile
[00002214] 2f3c 0000 61ea            move.l     #_old,-(a7) _old
[0000221a] 2f3c 0000 6212            move.l     #_mapfile,-(a7) _mapfile
[00002220] 2f3c 0000 61e6            move.l     #_lincl,-(a7) _lincl
[00002226] 2f3c 0000 620c            move.l     #_iprefix,-(a7) _iprefix
[0000222c] 2f3c 0000 61e2            move.l     #$0000B890,-(a7) _errfile
[00002232] 2f3c 0000 61ae            move.l     #_pdefs,-(a7)
[00002238] 2f3c 0000 61de            move.l     #_cplus_flag,-(a7)
[0000223e] 2f3c 0000 750e            move.l     #$0000CBBC,-(a7) ""+cplus,d*>err,i*,+lincl,+map*,+old,o*,+pas,p?,+std,s?,x:F <files>"
[00002244] 2f3c 0000 6238            move.l     #_argv,-(a7)
[0000224a] 2f3c 0000 622a            move.l     #_argc,-(a7)
[00002250] 4eb9 0000 3c62            jsr        _getflags
[00002256] 4fef 003c                 lea.l      60(a7),a7
[0000225a] 4ab9 0000 61da            tst.l      _ofile
[00002260] 6608                      bne.s      _main_1
[00002262] 3d7c 0001 fffe            move.w     #$0001,-2(a6)
[00002268] 6046                      bra.s      _main_2
_main_1:
[0000226a] 4ab9 0000 61f6            tst.l      _xflag
[00002270] 6704                      beq.s      _main_3
[00002272] 7e01                      moveq.l    #1,d7
[00002274] 6002                      bra.s      _main_4
_main_3:
[00002276] 4287                      clr.l      d7
_main_4:
[00002278] 2e87                      move.l     d7,(a7)
[0000227a] 4878 0001                 pea.l      ($00000001).w
[0000227e] 2f39 0000 61da            move.l     _ofile,-(a7)
[00002284] 4eb9 0000 42ba            jsr        _create
[0000228a] 508f                      addq.l     #8,a7
[0000228c] 3d47 fffe                 move.w     d7,-2(a6)
[00002290] 6c16                      bge.s      _main_5
[00002292] 2eb9 0000 61da            move.l     _ofile,(a7)
[00002298] 2f3c 0000 7500            move.l     #$0000CBAE,-(a7)
[0000229e] 4eb9 0000 5668            jsr        _error
[000022a4] 588f                      addq.l     #4,a7
[000022a6] 6008                      bra.s      _main_2
_main_5:
[000022a8] 33fc 0001 0000 6232       move.w     #$0001,$0000B8E0
_main_2:
[000022b0] 4878 0001                 pea.l      ($00000001).w
[000022b4] 3e2e fffe                 move.w     -2(a6),d7
[000022b8] 48c7                      ext.l      d7
[000022ba] 2f07                      move.l     d7,-(a7)
[000022bc] 2f3c 0000 78dc            move.l     #$0000CF8A,-(a7)
[000022c2] 4eb9 0000 449c            jsr        _finit
[000022c8] 4fef 000c                 lea.l      12(a7),a7
[000022cc] 4ab9 0000 61f6            tst.l      _xflag
[000022d2] 6762                      beq.s      _main_6
[000022d4] 4ab9 0000 61ea            tst.l      _old
[000022da] 665a                      bne.s      _main_6
[000022dc] 2ebc 0000 00bd            move.l     #$000000BD,(a7)
[000022e2] 2f3c 0000 74fe            move.l     #$0000CBAC,-(a7)
[000022e8] 4eb9 0000 19aa            jsr        _putcode
[000022ee] 588f                      addq.l     #4,a7
[000022f0] 2e39 0000 622a            move.l     _argc,d7
[000022f6] e587                      asl.l      #2,d7
[000022f8] 2447                      movea.l    d7,a2
[000022fa] 598a                      subq.l     #4,a2
[000022fc] d5f9 0000 6238            adda.l     _argv,a2
[00002302] 2e92                      move.l     (a2),(a7)
[00002304] 2e39 0000 622a            move.l     _argc,d7
[0000230a] e587                      asl.l      #2,d7
[0000230c] 2447                      movea.l    d7,a2
[0000230e] 598a                      subq.l     #4,a2
[00002310] d5f9 0000 6238            adda.l     _argv,a2
[00002316] 2f12                      move.l     (a2),-(a7)
[00002318] 4eb9 0000 5450            jsr        _lenstr
[0000231e] 588f                      addq.l     #4,a7
[00002320] 2f07                      move.l     d7,-(a7)
[00002322] 4878 0013                 pea.l      ($00000013).w
[00002326] 2f3c 0000 74fa            move.l     #$0000CBA8,-(a7)
[0000232c] 4eb9 0000 19aa            jsr        _putcode
[00002332] 4fef 000c                 lea.l      12(a7),a7
_main_6:
[00002336] 4eb9 0000 303a            jsr        _nxtfile
[0000233c] 23c7 0000 6234            move.l     d7,$0000B8E2
[00002342] 4eb9 0000 1ab2            jsr        _putfile
[00002348] 2ebc 0000 61ae            move.l     #_pdefs,(a7)
[0000234e] 4eb9 0000 3372            jsr        _predef
[00002354] 4ab9 0000 6212            tst.l      _mapfile
[0000235a] 677a                      beq.s      _main_7
[0000235c] 4878 0001                 pea.l      ($00000001).w
[00002360] 42a7                      clr.l      -(a7)
[00002362] 2f39 0000 6212            move.l     _mapfile,-(a7)
[00002368] 4eb9 0000 4708            jsr        _open
[0000236e] 4fef 000c                 lea.l      12(a7),a7
[00002372] 3d47 fffe                 move.w     d7,-2(a6)
[00002376] 6c16                      bge.s      _main_8
[00002378] 2eb9 0000 6212            move.l     _mapfile,(a7)
[0000237e] 2f3c 0000 74e2            move.l     #$0000CB90,-(a7) "can',$27,'t open map file: %p"
[00002384] 4eb9 0000 2c3c            jsr        _fatal
[0000238a] 588f                      addq.l     #4,a7
[0000238c] 6048                      bra.s      _main_7
_main_8:
[0000238e] 2ebc 0000 0100            move.l     #$00000100,(a7)
[00002394] 2f3c 0000 5b94            move.l     #$0000B242,-(a7)
[0000239a] 3e2e fffe                 move.w     -2(a6),d7
[0000239e] 48c7                      ext.l      d7
[000023a0] 2f07                      move.l     d7,-(a7)
[000023a2] 4eb9 0000 39da            jsr        _fread
[000023a8] 508f                      addq.l     #8,a7
[000023aa] 0c87 0000 0100            cmpi.l     #$00000100,d7
[000023b0] 6716                      beq.s      _main_9
[000023b2] 2eb9 0000 6212            move.l     _mapfile,(a7)
[000023b8] 2f3c 0000 74ca            move.l     #$0000CB78,-(a7) "can',$27,'t read map file: %p"
[000023be] 4eb9 0000 2c3c            jsr        _fatal
[000023c4] 588f                      addq.l     #4,a7
[000023c6] 600e                      bra.s      _main_7
_main_9:
[000023c8] 3e2e fffe                 move.w     -2(a6),d7
[000023cc] 48c7                      ext.l      d7
[000023ce] 2e87                      move.l     d7,(a7)
[000023d0] 4eb9 0000 4e54            jsr        _close
_main_7:
[000023d6] 4297                      clr.l      (a7)
[000023d8] 42a7                      clr.l      -(a7)
[000023da] 4eba fa8c                 jsr        _getex(pc)
[000023de] 588f                      addq.l     #4,a7
[000023e0] 2f07                      move.l     d7,-(a7)
[000023e2] 4eb9 0000 243e            jsr        _putgr
[000023e8] 588f                      addq.l     #4,a7
[000023ea] 2a47                      movea.l    d7,a5
[000023ec] 2e0d                      move.l     a5,d7
[000023ee] 6724                      beq.s      _main_10
[000023f0] 2ead 0014                 move.l     20(a5),(a7)
[000023f4] 2f2d 0010                 move.l     16(a5),-(a7)
[000023f8] 2f3c 0000 74bc            move.l     #$0000CB6A,-(a7) "misplaced #%b"
[000023fe] 4eb9 0000 324a            jsr        _p0error
[00002404] 508f                      addq.l     #8,a7
[00002406] 4297                      clr.l      (a7)
[00002408] 2f0d                      move.l     a5,-(a7)
[0000240a] 4eb9 0000 2c5c            jsr        _fretlist
[00002410] 588f                      addq.l     #4,a7
[00002412] 60c2                      bra.s      _main_7
_main_10:
[00002414] 2ebc 0000 78dc            move.l     #$0000CF8A,(a7)
[0000241a] 4eb9 0000 392c            jsr        _fclose
[00002420] 4a79 0000 6230            tst.w      $0000B8DE
[00002426] 6708                      beq.s      _main_11
[00002428] 4ab9 0000 61e2            tst.l      $0000B890
[0000242e] 6704                      beq.s      _main_12
_main_11:
[00002430] 7e01                      moveq.l    #1,d7
[00002432] 6002                      bra.s      _main_13
_main_12:
[00002434] 4287                      clr.l      d7
_main_13:
[00002436] 4cdf 2001                 movem.l    (a7)+,d0/a5
[0000243a] 4e5e                      unlk       a6
[0000243c] 4e75                      rts

_putgr:
[0000243e] 4e56 0000                 link       a6,#0
[00002442] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00002446] 2a6e 0008                 movea.l    8(a6),a5
[0000244a] 2a2e 000c                 move.l     12(a6),d5
_putgr_9:
[0000244e] 2e0d                      move.l     a5,d7
[00002450] 674e                      beq.s      _putgr_1
[00002452] 0cad 0000 000c 0004       cmpi.l     #$0000000C,4(a5)
[0000245a] 6744                      beq.s      _putgr_1
[0000245c] 0cad 0000 000d 0004       cmpi.l     #$0000000D,4(a5)
[00002464] 673a                      beq.s      _putgr_1
[00002466] 0cad 0000 000b 0004       cmpi.l     #$0000000B,4(a5)
[0000246e] 6730                      beq.s      _putgr_1
[00002470] 0cad 0000 000e 0004       cmpi.l     #$0000000E,4(a5)
[00002478] 6730                      beq.s      _putgr_2
[0000247a] 0cad 0000 000f 0004       cmpi.l     #$0000000F,4(a5)
[00002482] 6726                      beq.s      _putgr_2
[00002484] 0cad 0000 0010 0004       cmpi.l     #$00000010,4(a5)
[0000248c] 671c                      beq.s      _putgr_2
[0000248e] 4a85                      tst.l      d5
[00002490] 6736                      beq.s      _putgr_3
[00002492] 4297                      clr.l      (a7)
[00002494] 2f0d                      move.l     a5,-(a7)
[00002496] 4eb9 0000 2c5c            jsr        _fretlist
[0000249c] 588f                      addq.l     #4,a7
[0000249e] 6030                      bra.s      _putgr_4
_putgr_1:
[000024a0] 2e0d                      move.l     a5,d7
[000024a2] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[000024a6] 4e5e                      unlk       a6
[000024a8] 4e75                      rts
_putgr_2:
[000024aa] 0cad 0000 000e 0004       cmpi.l     #$0000000E,4(a5)
[000024b2] 6628                      bne.s      _putgr_5
[000024b4] 4a85                      tst.l      d5
[000024b6] 6704                      beq.s      _putgr_6
[000024b8] 4287                      clr.l      d7
[000024ba] 6008                      bra.s      _putgr_7
_putgr_6:
[000024bc] 2e95                      move.l     (a5),(a7)
[000024be] 4eb9 0000 0d80            jsr        _eval
_putgr_7:
[000024c4] 2807                      move.l     d7,d4
[000024c6] 6038                      bra.s      _putgr_8
_putgr_3:
[000024c8] 2e8d                      move.l     a5,(a7)
[000024ca] 4eb9 0000 262a            jsr        _putns
_putgr_4:
[000024d0] 4297                      clr.l      (a7)
[000024d2] 4eba f994                 jsr        _getex(pc)
[000024d6] 2a47                      movea.l    d7,a5
[000024d8] 6000 ff74                 bra        _putgr_9
_putgr_5:
[000024dc] 0cad 0000 000f 0004       cmpi.l     #$0000000F,4(a5)
[000024e4] 660e                      bne.s      _putgr_10
[000024e6] 4a95                      tst.l      (a5)
[000024e8] 6704                      beq.s      _putgr_11
[000024ea] 7e01                      moveq.l    #1,d7
[000024ec] 6002                      bra.s      _putgr_12
_putgr_11:
[000024ee] 4287                      clr.l      d7
_putgr_12:
[000024f0] 2807                      move.l     d7,d4
[000024f2] 600c                      bra.s      _putgr_8
_putgr_10:
[000024f4] 4a95                      tst.l      (a5)
[000024f6] 6604                      bne.s      _putgr_13
[000024f8] 7e01                      moveq.l    #1,d7
[000024fa] 6002                      bra.s      _putgr_14
_putgr_13:
[000024fc] 4287                      clr.l      d7
_putgr_14:
[000024fe] 2807                      move.l     d7,d4
_putgr_8:
[00002500] 4297                      clr.l      (a7)
[00002502] 2f0d                      move.l     a5,-(a7)
[00002504] 4eb9 0000 2c5c            jsr        _fretlist
[0000250a] 588f                      addq.l     #4,a7
[0000250c] 4a85                      tst.l      d5
[0000250e] 6604                      bne.s      _putgr_15
[00002510] 4a84                      tst.l      d4
[00002512] 6604                      bne.s      _putgr_16
_putgr_15:
[00002514] 7e01                      moveq.l    #1,d7
[00002516] 6002                      bra.s      _putgr_17
_putgr_16:
[00002518] 4287                      clr.l      d7
_putgr_17:
[0000251a] 2e87                      move.l     d7,(a7)
[0000251c] 42a7                      clr.l      -(a7)
[0000251e] 4eba f948                 jsr        _getex(pc)
[00002522] 588f                      addq.l     #4,a7
[00002524] 2f07                      move.l     d7,-(a7)
[00002526] 4eba ff16                 jsr        _putgr(pc)
[0000252a] 588f                      addq.l     #4,a7
[0000252c] 2a47                      movea.l    d7,a5
_putgr_25:
[0000252e] 2e0d                      move.l     a5,d7
[00002530] 6752                      beq.s      _putgr_18
[00002532] 0cad 0000 000b 0004       cmpi.l     #$0000000B,4(a5)
[0000253a] 6648                      bne.s      _putgr_18
[0000253c] 4a84                      tst.l      d4
[0000253e] 6600 0082                 bne        _putgr_19
[00002542] 4a85                      tst.l      d5
[00002544] 6704                      beq.s      _putgr_20
[00002546] 4287                      clr.l      d7
[00002548] 6008                      bra.s      _putgr_21
_putgr_20:
[0000254a] 2e95                      move.l     (a5),(a7)
[0000254c] 4eb9 0000 0d80            jsr        _eval
_putgr_21:
[00002552] 2807                      move.l     d7,d4
[00002554] 4297                      clr.l      (a7)
[00002556] 2f0d                      move.l     a5,-(a7)
[00002558] 4eb9 0000 2c5c            jsr        _fretlist
[0000255e] 588f                      addq.l     #4,a7
[00002560] 4a85                      tst.l      d5
[00002562] 6604                      bne.s      _putgr_22
[00002564] 4a84                      tst.l      d4
[00002566] 6604                      bne.s      _putgr_23
_putgr_22:
[00002568] 7e01                      moveq.l    #1,d7
[0000256a] 6002                      bra.s      _putgr_24
_putgr_23:
[0000256c] 4287                      clr.l      d7
_putgr_24:
[0000256e] 2e87                      move.l     d7,(a7)
[00002570] 42a7                      clr.l      -(a7)
[00002572] 4eba f8f4                 jsr        _getex(pc)
[00002576] 588f                      addq.l     #4,a7
[00002578] 2f07                      move.l     d7,-(a7)
[0000257a] 4eba fec2                 jsr        _putgr(pc)
[0000257e] 588f                      addq.l     #4,a7
[00002580] 2a47                      movea.l    d7,a5
[00002582] 60aa                      bra.s      _putgr_25
_putgr_18:
[00002584] 2e0d                      move.l     a5,d7
[00002586] 676c                      beq.s      _putgr_26
[00002588] 0cad 0000 000c 0004       cmpi.l     #$0000000C,4(a5)
[00002590] 6662                      bne.s      _putgr_26
[00002592] 4297                      clr.l      (a7)
[00002594] 2f0d                      move.l     a5,-(a7)
[00002596] 4eb9 0000 2c5c            jsr        _fretlist
[0000259c] 588f                      addq.l     #4,a7
[0000259e] 4a85                      tst.l      d5
[000025a0] 6604                      bne.s      _putgr_27
[000025a2] 4a84                      tst.l      d4
[000025a4] 6704                      beq.s      _putgr_28
_putgr_27:
[000025a6] 7e01                      moveq.l    #1,d7
[000025a8] 6002                      bra.s      _putgr_29
_putgr_28:
[000025aa] 4287                      clr.l      d7
_putgr_29:
[000025ac] 2e87                      move.l     d7,(a7)
[000025ae] 42a7                      clr.l      -(a7)
[000025b0] 4eba f8b6                 jsr        _getex(pc)
[000025b4] 588f                      addq.l     #4,a7
[000025b6] 2f07                      move.l     d7,-(a7)
[000025b8] 4eba fe84                 jsr        _putgr(pc)
[000025bc] 588f                      addq.l     #4,a7
[000025be] 2a47                      movea.l    d7,a5
[000025c0] 6032                      bra.s      _putgr_26
_putgr_19:
[000025c2] 4297                      clr.l      (a7)
[000025c4] 2f0d                      move.l     a5,-(a7)
[000025c6] 4eb9 0000 2c5c            jsr        _fretlist
[000025cc] 588f                      addq.l     #4,a7
[000025ce] 4a85                      tst.l      d5
[000025d0] 6604                      bne.s      _putgr_30
[000025d2] 4a84                      tst.l      d4
[000025d4] 6704                      beq.s      _putgr_31
_putgr_30:
[000025d6] 7e01                      moveq.l    #1,d7
[000025d8] 6002                      bra.s      _putgr_32
_putgr_31:
[000025da] 4287                      clr.l      d7
_putgr_32:
[000025dc] 2e87                      move.l     d7,(a7)
[000025de] 42a7                      clr.l      -(a7)
[000025e0] 4eba f886                 jsr        _getex(pc)
[000025e4] 588f                      addq.l     #4,a7
[000025e6] 2f07                      move.l     d7,-(a7)
[000025e8] 4eba fe54                 jsr        _putgr(pc)
[000025ec] 588f                      addq.l     #4,a7
[000025ee] 2a47                      movea.l    d7,a5
[000025f0] 6000 ff3c                 bra        _putgr_25
_putgr_26:
[000025f4] 2e0d                      move.l     a5,d7
[000025f6] 6722                      beq.s      _putgr_33
[000025f8] 0cad 0000 000d 0004       cmpi.l     #$0000000D,4(a5)
[00002600] 6618                      bne.s      _putgr_33
[00002602] 4297                      clr.l      (a7)
[00002604] 2f0d                      move.l     a5,-(a7)
[00002606] 4eb9 0000 2c5c            jsr        _fretlist
[0000260c] 588f                      addq.l     #4,a7
[0000260e] 4297                      clr.l      (a7)
[00002610] 4eba f856                 jsr        _getex(pc)
[00002614] 2a47                      movea.l    d7,a5
[00002616] 6000 fe36                 bra        _putgr_9
_putgr_33:
[0000261a] 2ebc 0000 7550            move.l     #$0000CBFE,(a7) "missing #endif"
[00002620] 4eb9 0000 324a            jsr        _p0error
[00002626] 6000 fe26                 bra        _putgr_9

_putns:
[0000262a] 4e56 ffee                 link       a6,#-18
[0000262e] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00002632] 2a6e 0008                 movea.l    8(a6),a5
[00002636] 2e2d 0004                 move.l     4(a5),d7
[0000263a] 41f9 0000 7560            lea.l      $0000CC0E,a0
[00002640] 4ef9 0000 48e0            jmp        a.switch
[00002646] 2d4d fffc                 move.l     a5,-4(a6)
_putns_2:
[0000264a] 246e fffc                 movea.l    -4(a6),a2
[0000264e] 588a                      addq.l     #4,a2
[00002650] 0c92 0000 0002            cmpi.l     #$00000002,(a2)
[00002656] 670a                      beq.s      _putns_1
[00002658] 246e fffc                 movea.l    -4(a6),a2
[0000265c] 2d52 fffc                 move.l     (a2),-4(a6)
[00002660] 60e8                      bra.s      _putns_2
_putns_1:
[00002662] 4ab9 0000 61f6            tst.l      _xflag
[00002668] 660a                      bne.s      _putns_3
[0000266a] 2e8d                      move.l     a5,(a7)
[0000266c] 4eb9 0000 1c34            jsr        _putls
[00002672] 605e                      bra.s      _putns_4
_putns_3:
[00002674] 4ab9 0000 61ea            tst.l      _old
[0000267a] 6656                      bne.s      _putns_4
[0000267c] 2ebc 0000 00fe            move.l     #$000000FE,(a7)
[00002682] 2f3c 0000 7617            move.l     #$0000CCC5,-(a7)
[00002688] 4eb9 0000 19aa            jsr        _putcode
[0000268e] 588f                      addq.l     #4,a7
[00002690] 45f8 0010                 lea.l      ($00000010).w,a2
[00002694] d5ee fffc                 adda.l     -4(a6),a2
[00002698] 2e12                      move.l     (a2),d7
[0000269a] 9ead 0010                 sub.l      16(a5),d7
[0000269e] 5487                      addq.l     #2,d7
[000026a0] 3d47 fff2                 move.w     d7,-14(a6)
[000026a4] 486e fff2                 pea.l      -14(a6)
[000026a8] 2f3c 0000 7615            move.l     #$0000CCC3,-(a7)
[000026ae] 4eb9 0000 19aa            jsr        _putcode
[000026b4] 508f                      addq.l     #8,a7
[000026b6] 3e2e fff2                 move.w     -14(a6),d7
[000026ba] 48c7                      ext.l      d7
[000026bc] 2e87                      move.l     d7,(a7)
[000026be] 2f2d 0010                 move.l     16(a5),-(a7)
[000026c2] 5397                      subq.l     #1,(a7)
[000026c4] 2f3c 0000 7613            move.l     #$0000CCC1,-(a7)
[000026ca] 4eb9 0000 19aa            jsr        _putcode
[000026d0] 508f                      addq.l     #8,a7
_putns_4:
[000026d2] 4297                      clr.l      (a7)
[000026d4] 2f0d                      move.l     a5,-(a7)
[000026d6] 4eb9 0000 2c5c            jsr        _fretlist
[000026dc] 588f                      addq.l     #4,a7
[000026de] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000026e2] 4e5e                      unlk       a6
[000026e4] 4e75                      rts

x26e6_2:
[000026e6] 2455                      movea.l    (a5),a2
[000026e8] 588a                      addq.l     #4,a2
[000026ea] 0c92 0000 0003            cmpi.l     #$00000003,(a2)
[000026f0] 670e                      beq.s      x26e6_1
[000026f2] 2ebc 0000 7607            move.l     #$0000CCB5,(a7) "bad #define"
[000026f8] 4eb9 0000 324a            jsr        _p0error
[000026fe] 60d2                      bra.s      x26e6_2
x26e6_1:
[00002700] 2d55 fffc                 move.l     (a5),-4(a6)
x26e6_4:
[00002704] 246e fffc                 movea.l    -4(a6),a2
[00002708] 4a92                      tst.l      (a2)
[0000270a] 670a                      beq.s      x26e6_3
[0000270c] 246e fffc                 movea.l    -4(a6),a2
[00002710] 2d52 fffc                 move.l     (a2),-4(a6)
[00002714] 60ee                      bra.s      x26e6_4
x26e6_3:
[00002716] 45f8 0010                 lea.l      ($00000010).w,a2
[0000271a] d5ee fffc                 adda.l     -4(a6),a2
[0000271e] 2e12                      move.l     (a2),d7
[00002720] 45f8 0014                 lea.l      ($00000014).w,a2
[00002724] d5ee fffc                 adda.l     -4(a6),a2
[00002728] de92                      add.l      (a2),d7
[0000272a] 2455                      movea.l    (a5),a2
[0000272c] 2452                      movea.l    (a2),a2
[0000272e] 508a                      addq.l     #8,a2
[00002730] 9e92                      sub.l      (a2),d7
[00002732] 3d47 fff2                 move.w     d7,-14(a6)
[00002736] 4ab9 0000 61f2            tst.l      _std
[0000273c] 6720                      beq.s      x26e6_5
[0000273e] 4297                      clr.l      (a7)
[00002740] 45f8 0014                 lea.l      ($00000014).w,a2
[00002744] d5d5                      adda.l     (a5),a2
[00002746] 2f12                      move.l     (a2),-(a7)
[00002748] 45f8 0010                 lea.l      ($00000010).w,a2
[0000274c] d5d5                      adda.l     (a5),a2
[0000274e] 2f12                      move.l     (a2),-(a7)
[00002750] 4eb9 0000 2fc6            jsr        _lookup
[00002756] 508f                      addq.l     #8,a7
[00002758] 2647                      movea.l    d7,a3
[0000275a] 2e0b                      move.l     a3,d7
[0000275c] 6636                      bne.s      x26e6_6
x26e6_5:
[0000275e] 3e2e fff2                 move.w     -14(a6),d7
[00002762] 48c7                      ext.l      d7
[00002764] 2e87                      move.l     d7,(a7)
[00002766] 2455                      movea.l    (a5),a2
[00002768] 2452                      movea.l    (a2),a2
[0000276a] 508a                      addq.l     #8,a2
[0000276c] 2f12                      move.l     (a2),-(a7)
[0000276e] 4eb9 0000 4226            jsr        _buybuf
[00002774] 588f                      addq.l     #4,a7
[00002776] 2e87                      move.l     d7,(a7)
[00002778] 45f8 0014                 lea.l      ($00000014).w,a2
[0000277c] d5d5                      adda.l     (a5),a2
[0000277e] 2f12                      move.l     (a2),-(a7)
[00002780] 45f8 0010                 lea.l      ($00000010).w,a2
[00002784] d5d5                      adda.l     (a5),a2
[00002786] 2f12                      move.l     (a2),-(a7)
[00002788] 4eb9 0000 2f5e            jsr        _install
[0000278e] 508f                      addq.l     #8,a7
[00002790] 6000 ff40                 bra        x26e6_2
x26e6_6:
[00002794] 3e2e fff2                 move.w     -14(a6),d7
[00002798] 48c7                      ext.l      d7
[0000279a] 2e87                      move.l     d7,(a7)
[0000279c] 2455                      movea.l    (a5),a2
[0000279e] 2452                      movea.l    (a2),a2
[000027a0] 508a                      addq.l     #8,a2
[000027a2] 2f12                      move.l     (a2),-(a7)
[000027a4] 2f0b                      move.l     a3,-(a7)
[000027a6] 4eb9 0000 425a            jsr        _cmpbuf
[000027ac] 508f                      addq.l     #8,a7
[000027ae] 4a87                      tst.l      d7
[000027b0] 6600 ff20                 bne        x26e6_2
[000027b4] 45f8 0014                 lea.l      ($00000014).w,a2
[000027b8] d5d5                      adda.l     (a5),a2
[000027ba] 2e92                      move.l     (a2),(a7)
[000027bc] 45f8 0010                 lea.l      ($00000010).w,a2
[000027c0] d5d5                      adda.l     (a5),a2
[000027c2] 2f12                      move.l     (a2),-(a7)
[000027c4] 2f3c 0000 75fa            move.l     #$0000CCA8,-(a7) "redefined %b"
[000027ca] 4eb9 0000 324a            jsr        _p0error
[000027d0] 508f                      addq.l     #8,a7
[000027d2] 6000 fefe                 bra        x26e6_2
[000027d6] 2455                      movea.l    (a5),a2
[000027d8] 588a                      addq.l     #4,a2
[000027da] 0c92 0000 0003            cmpi.l     #$00000003,(a2)
[000027e0] 6710                      beq.s      x26e6_7
[000027e2] 2ebc 0000 75ef            move.l     #$0000CC9D,(a7) "bad #undef"
[000027e8] 4eb9 0000 324a            jsr        _p0error
[000027ee] 6000 fee2                 bra        x26e6_2
x26e6_7:
[000027f2] 45f8 0014                 lea.l      ($00000014).w,a2
[000027f6] d5d5                      adda.l     (a5),a2
[000027f8] 2e92                      move.l     (a2),(a7)
[000027fa] 45f8 0010                 lea.l      ($00000010).w,a2
[000027fe] d5d5                      adda.l     (a5),a2
[00002800] 2f12                      move.l     (a2),-(a7)
[00002802] 4eb9 0000 0a74            jsr        _undef
[00002808] 588f                      addq.l     #4,a7
[0000280a] 6000 fec6                 bra        x26e6_2
[0000280e] 2e95                      move.l     (a5),(a7)
[00002810] 4eb9 0000 2c92            jsr        _getfincl
[00002816] 2847                      movea.l    d7,a4
[00002818] 4ab9 0000 6222            tst.l      $0000B8D0
[0000281e] 671a                      beq.s      x26e6_8
[00002820] 2e8c                      move.l     a4,(a7)
[00002822] 2f3c 0000 75dd            move.l     #$0000CC8B,-(a7) "can',$27,'t #include %p"
[00002828] 4eb9 0000 324a            jsr        _p0error
[0000282e] 588f                      addq.l     #4,a7
[00002830] 42b9 0000 6222            clr.l      $0000B8D0
[00002836] 6000 fe9a                 bra        x26e6_2
x26e6_8:
[0000283a] 4297                      clr.l      (a7)
[0000283c] 42a7                      clr.l      -(a7)
[0000283e] 2f0c                      move.l     a4,-(a7)
[00002840] 4eb9 0000 4708            jsr        _open
[00002846] 508f                      addq.l     #8,a7
[00002848] 3d47 fff6                 move.w     d7,-10(a6)
[0000284c] 6c1a                      bge.s      x26e6_9
[0000284e] 2ebc 0000 75c8            move.l     #$0000CC76,(a7)
[00002854] 45f8 0010                 lea.l      ($00000010).w,a2
[00002858] d5d5                      adda.l     (a5),a2
[0000285a] 2f12                      move.l     (a2),-(a7)
[0000285c] 4eb9 0000 5668            jsr        _error
[00002862] 588f                      addq.l     #4,a7
[00002864] 6000 fe6c                 bra        x26e6_2
x26e6_9:
[00002868] 4eb9 0000 345e            jsr        _ptline
[0000286e] 7001                      moveq.l    #1,d0
[00002870] 23c0 0000 6226            move.l     d0,$0000B8D4
[00002876] 4279 0000 6008            clr.w      $0000B6B6
[0000287c] 4eb9 0000 1ab2            jsr        _putfile
[00002882] 2eb9 0000 6234            move.l     $0000B8E2,(a7)
[00002888] 4878 0214                 pea.l      ($00000214).w
[0000288c] 4eb9 0000 49de            jsr        _alloc
[00002892] 588f                      addq.l     #4,a7
[00002894] 23c7 0000 6234            move.l     d7,$0000B8E2
[0000289a] 2479 0000 6234            movea.l    $0000B8E2,a2
[000028a0] 588a                      addq.l     #4,a2
[000028a2] 248c                      move.l     a4,(a2)
[000028a4] 2479 0000 6234            movea.l    $0000B8E2,a2
[000028aa] 508a                      addq.l     #8,a2
[000028ac] 4252                      clr.w      (a2)
[000028ae] 4297                      clr.l      (a7)
[000028b0] 3e2e fff6                 move.w     -10(a6),d7
[000028b4] 48c7                      ext.l      d7
[000028b6] 2f07                      move.l     d7,-(a7)
[000028b8] 7e0a                      moveq.l    #10,d7
[000028ba] deb9 0000 6234            add.l      $0000B8E2,d7
[000028c0] 2f07                      move.l     d7,-(a7)
[000028c2] 4eb9 0000 449c            jsr        _finit
[000028c8] 508f                      addq.l     #8,a7
[000028ca] 7001                      moveq.l    #1,d0
[000028cc] 23c0 0000 6226            move.l     d0,$0000B8D4
[000028d2] 5279 0000 6204            addq.w     #1,$0000B8B2
[000028d8] 4eb9 0000 1ab2            jsr        _putfile
[000028de] 6000 fdf2                 bra        x26e6_2
[000028e2] 45f8 0014                 lea.l      ($00000014).w,a2
[000028e6] d5d5                      adda.l     (a5),a2
[000028e8] 0c92 0000 0001            cmpi.l     #$00000001,(a2)
[000028ee] 662e                      bne.s      x26e6_10
[000028f0] 45f8 0010                 lea.l      ($00000010).w,a2
[000028f4] d5d5                      adda.l     (a5),a2
[000028f6] 2452                      movea.l    (a2),a2
[000028f8] 4287                      clr.l      d7
[000028fa] 1e12                      move.b     (a2),d7
[000028fc] 0c47 003d                 cmpi.w     #$003D,d7
[00002900] 661c                      bne.s      x26e6_10
[00002902] 4ab9 0000 61f6            tst.l      _xflag
[00002908] 6632                      bne.s      x26e6_11
[0000290a] 53ad 0010                 subq.l     #1,16(a5)
[0000290e] 52ad 0014                 addq.l     #1,20(a5)
[00002912] 2e8d                      move.l     a5,(a7)
[00002914] 4eb9 0000 1c34            jsr        _putls
[0000291a] 6000 fdb6                 bra        x26e6_2
x26e6_10:
[0000291e] 2455                      movea.l    (a5),a2
[00002920] 588a                      addq.l     #4,a2
[00002922] 0c92 0000 0004            cmpi.l     #$00000004,(a2)
[00002928] 6700 0132                 beq        x26e6_12
[0000292c] 2ebc 0000 75be            move.l     #$0000CC6C,(a7) "bad #line"
[00002932] 4eb9 0000 324a            jsr        _p0error
[00002938] 6000 fd98                 bra        x26e6_2
x26e6_11:
[0000293c] 2455                      movea.l    (a5),a2
[0000293e] 2d52 fffc                 move.l     (a2),-4(a6)
[00002942] 2d6e fffc fff8            move.l     -4(a6),-8(a6)
x26e6_15:
[00002948] 45f8 0014                 lea.l      ($00000014).w,a2
[0000294c] d5ee fff8                 adda.l     -8(a6),a2
[00002950] 0c92 0000 0001            cmpi.l     #$00000001,(a2)
[00002956] 6614                      bne.s      x26e6_13
[00002958] 45f8 0010                 lea.l      ($00000010).w,a2
[0000295c] d5ee fff8                 adda.l     -8(a6),a2
[00002960] 2452                      movea.l    (a2),a2
[00002962] 4287                      clr.l      d7
[00002964] 1e12                      move.b     (a2),d7
[00002966] 0c47 003a                 cmpi.w     #$003A,d7
[0000296a] 6718                      beq.s      x26e6_14
x26e6_13:
[0000296c] 246e fff8                 movea.l    -8(a6),a2
[00002970] 588a                      addq.l     #4,a2
[00002972] 0c92 0000 0002            cmpi.l     #$00000002,(a2)
[00002978] 670a                      beq.s      x26e6_14
[0000297a] 246e fff8                 movea.l    -8(a6),a2
[0000297e] 2d52 fff8                 move.l     (a2),-8(a6)
[00002982] 60c4                      bra.s      x26e6_15
x26e6_14:
[00002984] 2e2e fff8                 move.l     -8(a6),d7
[00002988] beae fffc                 cmp.l      -4(a6),d7
[0000298c] 677a                      beq.s      x26e6_16
[0000298e] 42b9 0000 621e            clr.l      $0000B8CC
[00002994] 45f8 0010                 lea.l      ($00000010).w,a2
[00002998] d5ee fff8                 adda.l     -8(a6),a2
[0000299c] 2e12                      move.l     (a2),d7
[0000299e] 45f8 0010                 lea.l      ($00000010).w,a2
[000029a2] d5ee fffc                 adda.l     -4(a6),a2
[000029a6] 9e92                      sub.l      (a2),d7
[000029a8] 2e87                      move.l     d7,(a7)
[000029aa] 5297                      addq.l     #1,(a7)
[000029ac] 45f8 0010                 lea.l      ($00000010).w,a2
[000029b0] d5ee fffc                 adda.l     -4(a6),a2
[000029b4] 2f12                      move.l     (a2),-(a7)
[000029b6] 4eb9 0000 4226            jsr        _buybuf
[000029bc] 588f                      addq.l     #4,a7
[000029be] 2d47 ffee                 move.l     d7,-18(a6)
[000029c2] 45f8 0010                 lea.l      ($00000010).w,a2
[000029c6] d5ee fffc                 adda.l     -4(a6),a2
[000029ca] 2e92                      move.l     (a2),(a7)
[000029cc] 45f8 0010                 lea.l      ($00000010).w,a2
[000029d0] d5ee fff8                 adda.l     -8(a6),a2
[000029d4] 2452                      movea.l    (a2),a2
[000029d6] 95d7                      suba.l     (a7),a2
[000029d8] d5ee ffee                 adda.l     -18(a6),a2
[000029dc] 4212                      clr.b      (a2)
[000029de] 7001                      moveq.l    #1,d0
[000029e0] 23c0 0000 6226            move.l     d0,$0000B8D4
[000029e6] 2479 0000 6234            movea.l    $0000B8E2,a2
[000029ec] 588a                      addq.l     #4,a2
[000029ee] 4a92                      tst.l      (a2)
[000029f0] 6756                      beq.s      x26e6_17
[000029f2] 4297                      clr.l      (a7)
[000029f4] 2479 0000 6234            movea.l    $0000B8E2,a2
[000029fa] 588a                      addq.l     #4,a2
[000029fc] 2f12                      move.l     (a2),-(a7)
[000029fe] 4eb9 0000 4b5c            jsr        _free
[00002a04] 588f                      addq.l     #4,a7
[00002a06] 6040                      bra.s      x26e6_17
x26e6_16:
[00002a08] 246e fff8                 movea.l    -8(a6),a2
[00002a0c] 2d52 fff8                 move.l     (a2),-8(a6)
[00002a10] 4297                      clr.l      (a7)
[00002a12] 42a7                      clr.l      -(a7)
[00002a14] 2f2e fff8                 move.l     -8(a6),-(a7)
[00002a18] 4eb9 0000 12da            jsr        _bton
[00002a1e] 508f                      addq.l     #8,a7
[00002a20] 3d47 fff4                 move.w     d7,-12(a6)
[00002a24] 2479 0000 6234            movea.l    $0000B8E2,a2
[00002a2a] 508a                      addq.l     #8,a2
[00002a2c] 34ae fff4                 move.w     -12(a6),(a2)
[00002a30] 42b9 0000 621e            clr.l      $0000B8CC
[00002a36] 4eb9 0000 345e            jsr        _ptline
[00002a3c] 7001                      moveq.l    #1,d0
[00002a3e] 23c0 0000 621e            move.l     d0,$0000B8CC
[00002a44] 6000 fc8c                 bra        x26e6_2
x26e6_17:
[00002a48] 2479 0000 6234            movea.l    $0000B8E2,a2
[00002a4e] 588a                      addq.l     #4,a2
[00002a50] 24ae ffee                 move.l     -18(a6),(a2)
[00002a54] 4eb9 0000 1ab2            jsr        _putfile
[00002a5a] 60ac                      bra.s      x26e6_16
x26e6_12:
[00002a5c] 4297                      clr.l      (a7)
[00002a5e] 42a7                      clr.l      -(a7)
[00002a60] 2f15                      move.l     (a5),-(a7)
[00002a62] 4eb9 0000 12da            jsr        _bton
[00002a68] 508f                      addq.l     #8,a7
[00002a6a] 3d47 fff4                 move.w     d7,-12(a6)
[00002a6e] 2479 0000 6234            movea.l    $0000B8E2,a2
[00002a74] 508a                      addq.l     #8,a2
[00002a76] 34ae fff4                 move.w     -12(a6),(a2)
[00002a7a] 2455                      movea.l    (a5),a2
[00002a7c] 2d52 fffc                 move.l     (a2),-4(a6)
[00002a80] 246e fffc                 movea.l    -4(a6),a2
[00002a84] 588a                      addq.l     #4,a2
[00002a86] 0c92 0000 0002            cmpi.l     #$00000002,(a2)
[00002a8c] 6700 fc44                 beq        x26e6_2
[00002a90] 246e fffc                 movea.l    -4(a6),a2
[00002a94] 588a                      addq.l     #4,a2
[00002a96] 0c92 0000 0006            cmpi.l     #$00000006,(a2)
[00002a9c] 6660                      bne.s      x26e6_18
[00002a9e] 45f8 0014                 lea.l      ($00000014).w,a2
[00002aa2] d5ee fffc                 adda.l     -4(a6),a2
[00002aa6] 2e92                      move.l     (a2),(a7)
[00002aa8] 5397                      subq.l     #1,(a7)
[00002aaa] 45f8 0010                 lea.l      ($00000010).w,a2
[00002aae] d5ee fffc                 adda.l     -4(a6),a2
[00002ab2] 2f12                      move.l     (a2),-(a7)
[00002ab4] 5297                      addq.l     #1,(a7)
[00002ab6] 4eb9 0000 4226            jsr        _buybuf
[00002abc] 588f                      addq.l     #4,a7
[00002abe] 2d47 ffee                 move.l     d7,-18(a6)
[00002ac2] 45f8 0014                 lea.l      ($00000014).w,a2
[00002ac6] d5ee fffc                 adda.l     -4(a6),a2
[00002aca] 2452                      movea.l    (a2),a2
[00002acc] 558a                      subq.l     #2,a2
[00002ace] d5ee ffee                 adda.l     -18(a6),a2
[00002ad2] 4212                      clr.b      (a2)
[00002ad4] 7001                      moveq.l    #1,d0
[00002ad6] 23c0 0000 6226            move.l     d0,$0000B8D4
[00002adc] 2479 0000 6234            movea.l    $0000B8E2,a2
[00002ae2] 588a                      addq.l     #4,a2
[00002ae4] 4a92                      tst.l      (a2)
[00002ae6] 6732                      beq.s      x26e6_19
[00002ae8] 4297                      clr.l      (a7)
[00002aea] 2479 0000 6234            movea.l    $0000B8E2,a2
[00002af0] 588a                      addq.l     #4,a2
[00002af2] 2f12                      move.l     (a2),-(a7)
[00002af4] 4eb9 0000 4b5c            jsr        _free
[00002afa] 588f                      addq.l     #4,a7
[00002afc] 601c                      bra.s      x26e6_19
x26e6_18:
[00002afe] 246e fffc                 movea.l    -4(a6),a2
[00002b02] 588a                      addq.l     #4,a2
[00002b04] 0c92 0000 0002            cmpi.l     #$00000002,(a2)
[00002b0a] 6724                      beq.s      x26e6_20
[00002b0c] 2ebc 0000 75ad            move.l     #$0000CC5B,(a7) "bad #line syntax"
[00002b12] 4eb9 0000 324a            jsr        _p0error
[00002b18] 6016                      bra.s      x26e6_20
x26e6_19:
[00002b1a] 2479 0000 6234            movea.l    $0000B8E2,a2
[00002b20] 588a                      addq.l     #4,a2
[00002b22] 24ae ffee                 move.l     -18(a6),(a2)
[00002b26] 246e fffc                 movea.l    -4(a6),a2
[00002b2a] 2d52 fffc                 move.l     (a2),-4(a6)
[00002b2e] 60ce                      bra.s      x26e6_18
x26e6_20:
[00002b30] 4ab9 0000 61f6            tst.l      _xflag
[00002b36] 6600 fb9a                 bne        x26e6_2
[00002b3a] 53ad 0010                 subq.l     #1,16(a5)
[00002b3e] 52ad 0014                 addq.l     #1,20(a5)
[00002b42] 2e8d                      move.l     a5,(a7)
[00002b44] 4eb9 0000 1c34            jsr        _putls
[00002b4a] 6000 fb86                 bra        x26e6_2
[00002b4e] 4ab9 0000 61f6            tst.l      _xflag
[00002b54] 6614                      bne.s      x26e6_21
[00002b56] 53ad 0010                 subq.l     #1,16(a5)
[00002b5a] 52ad 0014                 addq.l     #1,20(a5)
[00002b5e] 2e8d                      move.l     a5,(a7)
[00002b60] 4eb9 0000 1c34            jsr        _putls
[00002b66] 6000 fb6a                 bra        x26e6_2
x26e6_21:
[00002b6a] 4878 001d                 pea.l      ($0000001D).w
[00002b6e] 2f3c 0000 75ab            move.l     #$0000CC59,-(a7)
[00002b74] 4eb9 0000 19aa            jsr        _putcode
[00002b7a] 508f                      addq.l     #8,a7
[00002b7c] 2e95                      move.l     (a5),(a7)
[00002b7e] 4eb9 0000 1c34            jsr        _putls
[00002b84] 4878 001d                 pea.l      ($0000001D).w
[00002b88] 2f3c 0000 75a9            move.l     #$0000CC57,-(a7)
[00002b8e] 4eb9 0000 19aa            jsr        _putcode
[00002b94] 508f                      addq.l     #8,a7
[00002b96] 6000 fb3a                 bra        x26e6_2
[00002b9a] 2455                      movea.l    (a5),a2
[00002b9c] 588a                      addq.l     #4,a2
[00002b9e] 0c92 0000 0002            cmpi.l     #$00000002,(a2)
[00002ba4] 6700 fb2c                 beq        x26e6_2
[00002ba8] 2ebc 0000 75a0            move.l     #$0000CC4E,(a7) "bad #xxx"
[00002bae] 4eb9 0000 324a            jsr        _p0error
[00002bb4] 6000 fb1c                 bra        x26e6_2
[00002bb8] 2e8d                      move.l     a5,(a7)
[00002bba] 4eb9 0000 1c34            jsr        _putls
[00002bc0] 6000 fb10                 bra        x26e6_2

_buytl:
[00002bc4] 4e56 0000                 link       a6,#0
[00002bc8] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00002bcc] 2a6e 0008                 movea.l    8(a6),a5
[00002bd0] 286e 000c                 movea.l    12(a6),a4
[00002bd4] 4ab9 0000 781a            tst.l      $0000CEC8
[00002bda] 6710                      beq.s      _buytl_1
[00002bdc] 2679 0000 781a            movea.l    $0000CEC8,a3
[00002be2] 23d3 0000 781a            move.l     (a3),$0000CEC8
[00002be8] 268c                      move.l     a4,(a3)
[00002bea] 6010                      bra.s      _buytl_2
_buytl_1:
[00002bec] 2e8c                      move.l     a4,(a7)
[00002bee] 4878 0018                 pea.l      ($00000018).w
[00002bf2] 4eb9 0000 49de            jsr        _alloc
[00002bf8] 588f                      addq.l     #4,a7
[00002bfa] 2647                      movea.l    d7,a3
_buytl_2:
[00002bfc] 42ab 0004                 clr.l      4(a3)
[00002c00] 42ab 0008                 clr.l      8(a3)
[00002c04] 42ab 000c                 clr.l      12(a3)
[00002c08] 42ab 0014                 clr.l      20(a3)
[00002c0c] 42ab 0010                 clr.l      16(a3)
[00002c10] 2e0d                      move.l     a5,d7
[00002c12] 671e                      beq.s      _buytl_3
[00002c14] 276d 0004 0004            move.l     4(a5),4(a3)
[00002c1a] 276d 0008 0008            move.l     8(a5),8(a3)
[00002c20] 276d 000c 000c            move.l     12(a5),12(a3)
[00002c26] 276d 0010 0010            move.l     16(a5),16(a3)
[00002c2c] 276d 0014 0014            move.l     20(a5),20(a3)
_buytl_3:
[00002c32] 2e0b                      move.l     a3,d7
[00002c34] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00002c38] 4e5e                      unlk       a6
[00002c3a] 4e75                      rts

_fatal:
[00002c3c] 4e56 fffc                 link       a6,#-4
[00002c40] 2eae 000c                 move.l     12(a6),(a7)
[00002c44] 2f2e 0008                 move.l     8(a6),-(a7)
[00002c48] 4eb9 0000 324a            jsr        _p0error
[00002c4e] 588f                      addq.l     #4,a7
[00002c50] 4297                      clr.l      (a7)
[00002c52] 4eb9 0000 0080            jsr        _exit
[00002c58] 4e5e                      unlk       a6
[00002c5a] 4e75                      rts

_fretlist:
[00002c5c] 4e56 0000                 link       a6,#0
[00002c60] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00002c64] 2a6e 000c                 movea.l    12(a6),a5
[00002c68] 286e 0008                 movea.l    8(a6),a4
_fretlist_2:
[00002c6c] 4a94                      tst.l      (a4)
[00002c6e] 670a                      beq.s      _fretlist_1
[00002c70] 2e14                      move.l     (a4),d7
[00002c72] be8d                      cmp.l      a5,d7
[00002c74] 6704                      beq.s      _fretlist_1
[00002c76] 2854                      movea.l    (a4),a4
[00002c78] 60f2                      bra.s      _fretlist_2
_fretlist_1:
[00002c7a] 28b9 0000 781a            move.l     $0000CEC8,(a4)
[00002c80] 23ee 0008 0000 781a       move.l     8(a6),$0000CEC8
[00002c88] 2e0d                      move.l     a5,d7
[00002c8a] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00002c8e] 4e5e                      unlk       a6
[00002c90] 4e75                      rts

_getfincl:
[00002c92] 4e56 fff0                 link       a6,#-16
[00002c96] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00002c9a] 2a6e 0008                 movea.l    8(a6),a5
[00002c9e] 4aad 0014                 tst.l      20(a5)
[00002ca2] 671c                      beq.s      _getfincl_1
[00002ca4] 246d 0010                 movea.l    16(a5),a2
[00002ca8] 4287                      clr.l      d7
[00002caa] 1e12                      move.b     (a2),d7
[00002cac] 0c47 0022                 cmpi.w     #$0022,d7
[00002cb0] 6722                      beq.s      _getfincl_2
[00002cb2] 246d 0010                 movea.l    16(a5),a2
[00002cb6] 4287                      clr.l      d7
[00002cb8] 1e12                      move.b     (a2),d7
[00002cba] 0c47 003c                 cmpi.w     #$003C,d7
[00002cbe] 6714                      beq.s      _getfincl_2
_getfincl_1:
[00002cc0] 7001                      moveq.l    #1,d0
[00002cc2] 23c0 0000 6222            move.l     d0,$0000B8D0
[00002cc8] 2e2d 0010                 move.l     16(a5),d7
[00002ccc] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00002cd0] 4e5e                      unlk       a6
[00002cd2] 4e75                      rts
_getfincl_2:
[00002cd4] 2e2d 000c                 move.l     12(a5),d7
[00002cd8] 4487                      neg.l      d7
[00002cda] 2d47 fffc                 move.l     d7,-4(a6)
[00002cde] 264d                      movea.l    a5,a3
_getfincl_4:
[00002ce0] 0cab 0000 0002 0004       cmpi.l     #$00000002,4(a3)
[00002ce8] 6710                      beq.s      _getfincl_3
[00002cea] 2e2b 000c                 move.l     12(a3),d7
[00002cee] deab 0014                 add.l      20(a3),d7
[00002cf2] dfae fffc                 add.l      d7,-4(a6)
[00002cf6] 2653                      movea.l    (a3),a3
[00002cf8] 60e6                      bra.s      _getfincl_4
_getfincl_3:
[00002cfa] 4297                      clr.l      (a7)
[00002cfc] 2f2e fffc                 move.l     -4(a6),-(a7)
[00002d00] 4eb9 0000 49de            jsr        _alloc
[00002d06] 588f                      addq.l     #4,a7
[00002d08] 2d47 fff4                 move.l     d7,-12(a6)
[00002d0c] 286e fff4                 movea.l    -12(a6),a4
[00002d10] 264d                      movea.l    a5,a3
_getfincl_10:
[00002d12] 0cab 0000 0002 0004       cmpi.l     #$00000002,4(a3)
[00002d1a] 671e                      beq.s      _getfincl_5
[00002d1c] b7cd                      cmpa.l     a5,a3
[00002d1e] 663a                      bne.s      _getfincl_6
[00002d20] 2ead 0014                 move.l     20(a5),(a7)
[00002d24] 5397                      subq.l     #1,(a7)
[00002d26] 2f2d 0010                 move.l     16(a5),-(a7)
[00002d2a] 5297                      addq.l     #1,(a7)
[00002d2c] 2f0c                      move.l     a4,-(a7)
[00002d2e] 4eb9 0000 4e5c            jsr        _cpybuf
[00002d34] 508f                      addq.l     #8,a7
[00002d36] d9c7                      adda.l     d7,a4
[00002d38] 6048                      bra.s      _getfincl_7
_getfincl_5:
[00002d3a] 538c                      subq.l     #1,a4
[00002d3c] 246d 0010                 movea.l    16(a5),a2
[00002d40] 4287                      clr.l      d7
[00002d42] 1e12                      move.b     (a2),d7
[00002d44] 0c47 0022                 cmpi.w     #$0022,d7
[00002d48] 666e                      bne.s      _getfincl_8
[00002d4a] 4287                      clr.l      d7
[00002d4c] 1e14                      move.b     (a4),d7
[00002d4e] 0c47 0022                 cmpi.w     #$0022,d7
[00002d52] 667c                      bne.s      _getfincl_9
[00002d54] 6062                      bra.s      _getfincl_8
_getfincl_11:
[00002d56] 2653                      movea.l    (a3),a3
[00002d58] 60b8                      bra.s      _getfincl_10
_getfincl_6:
[00002d5a] 2eab 000c                 move.l     12(a3),(a7)
[00002d5e] 2f2b 0008                 move.l     8(a3),-(a7)
[00002d62] 2f0c                      move.l     a4,-(a7)
[00002d64] 4eb9 0000 4e5c            jsr        _cpybuf
[00002d6a] 508f                      addq.l     #8,a7
[00002d6c] d9c7                      adda.l     d7,a4
[00002d6e] 2eab 0014                 move.l     20(a3),(a7)
[00002d72] 2f2b 0010                 move.l     16(a3),-(a7)
[00002d76] 2f0c                      move.l     a4,-(a7)
[00002d78] 4eb9 0000 4e5c            jsr        _cpybuf
[00002d7e] 508f                      addq.l     #8,a7
[00002d80] d9c7                      adda.l     d7,a4
_getfincl_7:
[00002d82] 0cab 0000 0006 0004       cmpi.l     #$00000006,4(a3)
[00002d8a] 66ca                      bne.s      _getfincl_11
[00002d8c] 2453                      movea.l    (a3),a2
[00002d8e] 588a                      addq.l     #4,a2
[00002d90] 0c92 0000 0006            cmpi.l     #$00000006,(a2)
[00002d96] 66be                      bne.s      _getfincl_11
[00002d98] 2653                      movea.l    (a3),a3
[00002d9a] 2eab 0014                 move.l     20(a3),(a7)
[00002d9e] 5397                      subq.l     #1,(a7)
[00002da0] 2f2b 0010                 move.l     16(a3),-(a7)
[00002da4] 5297                      addq.l     #1,(a7)
[00002da6] 486c ffff                 pea.l      -1(a4)
[00002daa] 4eb9 0000 4e5c            jsr        _cpybuf
[00002db0] 508f                      addq.l     #8,a7
[00002db2] 5387                      subq.l     #1,d7
[00002db4] d9c7                      adda.l     d7,a4
[00002db6] 60ca                      bra.s      _getfincl_7
_getfincl_8:
[00002db8] 246d 0010                 movea.l    16(a5),a2
[00002dbc] 4287                      clr.l      d7
[00002dbe] 1e12                      move.b     (a2),d7
[00002dc0] 0c47 003c                 cmpi.w     #$003C,d7
[00002dc4] 661a                      bne.s      _getfincl_12
[00002dc6] 4287                      clr.l      d7
[00002dc8] 1e14                      move.b     (a4),d7
[00002dca] 0c47 003e                 cmpi.w     #$003E,d7
[00002dce] 6710                      beq.s      _getfincl_12
_getfincl_9:
[00002dd0] 7001                      moveq.l    #1,d0
[00002dd2] 23c0 0000 6222            move.l     d0,$0000B8D0
[00002dd8] 4214                      clr.b      (a4)
[00002dda] 2e2e fff4                 move.l     -12(a6),d7
[00002dde] 6038                      bra.s      _getfincl_13
_getfincl_12:
[00002de0] 4214                      clr.b      (a4)
[00002de2] 246d 0010                 movea.l    16(a5),a2
[00002de6] 4287                      clr.l      d7
[00002de8] 1e12                      move.b     (a2),d7
[00002dea] 0c47 0022                 cmpi.w     #$0022,d7
[00002dee] 6630                      bne.s      _getfincl_14
[00002df0] 4297                      clr.l      (a7)
[00002df2] 42a7                      clr.l      -(a7)
[00002df4] 2f2e fff4                 move.l     -12(a6),-(a7)
[00002df8] 4eb9 0000 4708            jsr        _open
[00002dfe] 508f                      addq.l     #8,a7
[00002e00] 3d47 fff8                 move.w     d7,-8(a6)
[00002e04] 6d1a                      blt.s      _getfincl_14
[00002e06] 3e2e fff8                 move.w     -8(a6),d7
[00002e0a] 48c7                      ext.l      d7
[00002e0c] 2e87                      move.l     d7,(a7)
[00002e0e] 4eb9 0000 4e54            jsr        _close
[00002e14] 2e2e fff4                 move.l     -12(a6),d7
_getfincl_13:
[00002e18] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00002e1c] 4e5e                      unlk       a6
[00002e1e] 4e75                      rts
_getfincl_14:
[00002e20] 2e0c                      move.l     a4,d7
[00002e22] 9eae fff4                 sub.l      -12(a6),d7
[00002e26] 2d47 fffc                 move.l     d7,-4(a6)
[00002e2a] 2879 0000 620c            movea.l    _iprefix,a4
_getfincl_20:
[00002e30] 4a14                      tst.b      (a4)
[00002e32] 6700 009c                 beq        _getfincl_15
[00002e36] 4878 007c                 pea.l      ($0000007C).w
[00002e3a] 2f0c                      move.l     a4,-(a7)
[00002e3c] 4eb9 0000 48be            jsr        _scnstr
[00002e42] 508f                      addq.l     #8,a7
[00002e44] 3d47 fffa                 move.w     d7,-6(a6)
[00002e48] 4297                      clr.l      (a7)
[00002e4a] 3e2e fffa                 move.w     -6(a6),d7
[00002e4e] 48c7                      ext.l      d7
[00002e50] deae fffc                 add.l      -4(a6),d7
[00002e54] 2f07                      move.l     d7,-(a7)
[00002e56] 5297                      addq.l     #1,(a7)
[00002e58] 4eb9 0000 49de            jsr        _alloc
[00002e5e] 588f                      addq.l     #4,a7
[00002e60] 2d47 fff0                 move.l     d7,-16(a6)
[00002e64] 3e2e fffa                 move.w     -6(a6),d7
[00002e68] 48c7                      ext.l      d7
[00002e6a] 2e87                      move.l     d7,(a7)
[00002e6c] 2f0c                      move.l     a4,-(a7)
[00002e6e] 2f2e fff0                 move.l     -16(a6),-(a7)
[00002e72] 4eb9 0000 4e5c            jsr        _cpybuf
[00002e78] 508f                      addq.l     #8,a7
[00002e7a] 2eae fffc                 move.l     -4(a6),(a7)
[00002e7e] 5297                      addq.l     #1,(a7)
[00002e80] 2f2e fff4                 move.l     -12(a6),-(a7)
[00002e84] 2e2e fff0                 move.l     -16(a6),d7
[00002e88] 3c2e fffa                 move.w     -6(a6),d6
[00002e8c] 48c6                      ext.l      d6
[00002e8e] de86                      add.l      d6,d7
[00002e90] 2f07                      move.l     d7,-(a7)
[00002e92] 4eb9 0000 4e5c            jsr        _cpybuf
[00002e98] 508f                      addq.l     #8,a7
[00002e9a] 4297                      clr.l      (a7)
[00002e9c] 42a7                      clr.l      -(a7)
[00002e9e] 2f2e fff0                 move.l     -16(a6),-(a7)
[00002ea2] 4eb9 0000 4708            jsr        _open
[00002ea8] 508f                      addq.l     #8,a7
[00002eaa] 3d47 fff8                 move.w     d7,-8(a6)
[00002eae] 6d34                      blt.s      _getfincl_16
[00002eb0] 3e2e fff8                 move.w     -8(a6),d7
[00002eb4] 48c7                      ext.l      d7
[00002eb6] 2e87                      move.l     d7,(a7)
[00002eb8] 4eb9 0000 4e54            jsr        _close
[00002ebe] 2eae fff0                 move.l     -16(a6),(a7)
[00002ec2] 2f2e fff4                 move.l     -12(a6),-(a7)
[00002ec6] 4eb9 0000 4b5c            jsr        _free
[00002ecc] 588f                      addq.l     #4,a7
[00002ece] 600c                      bra.s      _getfincl_17
_getfincl_15:
[00002ed0] 7001                      moveq.l    #1,d0
[00002ed2] 23c0 0000 6222            move.l     d0,$0000B8D0
[00002ed8] 2e2e fff4                 move.l     -12(a6),d7
_getfincl_17:
[00002edc] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00002ee0] 4e5e                      unlk       a6
[00002ee2] 4e75                      rts
_getfincl_16:
[00002ee4] 4297                      clr.l      (a7)
[00002ee6] 2f2e fff0                 move.l     -16(a6),-(a7)
[00002eea] 4eb9 0000 4b5c            jsr        _free
[00002ef0] 588f                      addq.l     #4,a7
[00002ef2] 244c                      movea.l    a4,a2
[00002ef4] 3e2e fffa                 move.w     -6(a6),d7
[00002ef8] 48c7                      ext.l      d7
[00002efa] d5c7                      adda.l     d7,a2
[00002efc] 4a12                      tst.b      (a2)
[00002efe] 670a                      beq.s      _getfincl_18
[00002f00] 3e2e fffa                 move.w     -6(a6),d7
[00002f04] 48c7                      ext.l      d7
[00002f06] 5287                      addq.l     #1,d7
[00002f08] 6006                      bra.s      _getfincl_19
_getfincl_18:
[00002f0a] 3e2e fffa                 move.w     -6(a6),d7
[00002f0e] 48c7                      ext.l      d7
_getfincl_19:
[00002f10] d9c7                      adda.l     d7,a4
[00002f12] 6000 ff1c                 bra        _getfincl_20

_hash:
[00002f16] 4e56 0000                 link       a6,#0
[00002f1a] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00002f1e] 2a6e 0008                 movea.l    8(a6),a5
[00002f22] 2a2e 000c                 move.l     12(a6),d5
[00002f26] 0c85 0000 0008            cmpi.l     #$00000008,d5
[00002f2c] 6302                      bls.s      _hash_1
[00002f2e] 7a08                      moveq.l    #8,d5
_hash_1:
[00002f30] 4284                      clr.l      d4
_hash_3:
[00002f32] 4a85                      tst.l      d5
[00002f34] 670a                      beq.s      _hash_2
[00002f36] 4287                      clr.l      d7
[00002f38] 1e1d                      move.b     (a5)+,d7
[00002f3a] d887                      add.l      d7,d4
[00002f3c] 5385                      subq.l     #1,d5
[00002f3e] 60f2                      bra.s      _hash_3
_hash_2:
[00002f40] 2e84                      move.l     d4,(a7)
[00002f42] 4878 0080                 pea.l      (_exit).w
[00002f46] 4eb9 0000 462e            jsr        a.lmod
[00002f4c] 2e17                      move.l     (a7),d7
[00002f4e] e587                      asl.l      #2,d7
[00002f50] 0687 0000 761a            addi.l     #$0000CCC8,d7
[00002f56] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00002f5a] 4e5e                      unlk       a6
[00002f5c] 4e75                      rts

_install:
[00002f5e] 4e56 0000                 link       a6,#0
[00002f62] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00002f66] 2a2e 000c                 move.l     12(a6),d5
[00002f6a] 0c85 0000 007f            cmpi.l     #$0000007F,d5
[00002f70] 6404                      bcc.s      _install_1
[00002f72] 2e05                      move.l     d5,d7
[00002f74] 6002                      bra.s      _install_2
_install_1:
[00002f76] 7e7f                      moveq.l    #127,d7
_install_2:
[00002f78] 2a07                      move.l     d7,d5
[00002f7a] 2e85                      move.l     d5,(a7)
[00002f7c] 2f2e 0008                 move.l     8(a6),-(a7)
[00002f80] 4eba ff94                 jsr        _hash(pc)
[00002f84] 588f                      addq.l     #4,a7
[00002f86] 2a47                      movea.l    d7,a5
[00002f88] 2e95                      move.l     (a5),(a7)
[00002f8a] 2f05                      move.l     d5,-(a7)
[00002f8c] 0697 0000 0010            addi.l     #$00000010,(a7)
[00002f92] 4eb9 0000 49de            jsr        _alloc
[00002f98] 588f                      addq.l     #4,a7
[00002f9a] 2847                      movea.l    d7,a4
[00002f9c] 2a8c                      move.l     a4,(a5)
[00002f9e] 42ac 000c                 clr.l      12(a4)
[00002fa2] 2e85                      move.l     d5,(a7)
[00002fa4] 2f2e 0008                 move.l     8(a6),-(a7)
[00002fa8] 486c 0010                 pea.l      16(a4)
[00002fac] 4eb9 0000 4e5c            jsr        _cpybuf
[00002fb2] 508f                      addq.l     #8,a7
[00002fb4] 2945 0008                 move.l     d5,8(a4)
[00002fb8] 296e 0010 0004            move.l     16(a6),4(a4)
[00002fbe] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00002fc2] 4e5e                      unlk       a6
[00002fc4] 4e75                      rts

_lookup:
[00002fc6] 4e56 0000                 link       a6,#0
[00002fca] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00002fce] 2a6e 0008                 movea.l    8(a6),a5
[00002fd2] 2a2e 000c                 move.l     12(a6),d5
[00002fd6] 0c85 0000 007f            cmpi.l     #$0000007F,d5
[00002fdc] 6404                      bcc.s      _lookup_1
[00002fde] 2e05                      move.l     d5,d7
[00002fe0] 6002                      bra.s      _lookup_2
_lookup_1:
[00002fe2] 7e7f                      moveq.l    #127,d7
_lookup_2:
[00002fe4] 2a07                      move.l     d7,d5
[00002fe6] 2e85                      move.l     d5,(a7)
[00002fe8] 2f0d                      move.l     a5,-(a7)
[00002fea] 4eba ff2a                 jsr        _hash(pc)
[00002fee] 588f                      addq.l     #4,a7
[00002ff0] 2447                      movea.l    d7,a2
[00002ff2] 2852                      movea.l    (a2),a4
_lookup_7:
[00002ff4] 2e0c                      move.l     a4,d7
[00002ff6] 672e                      beq.s      _lookup_3
[00002ff8] 4aac 000c                 tst.l      12(a4)
[00002ffc] 662c                      bne.s      _lookup_4
[00002ffe] baac 0008                 cmp.l      8(a4),d5
[00003002] 6626                      bne.s      _lookup_4
[00003004] 2e85                      move.l     d5,(a7)
[00003006] 486c 0010                 pea.l      16(a4)
[0000300a] 2f0d                      move.l     a5,-(a7)
[0000300c] 4eb9 0000 425a            jsr        _cmpbuf
[00003012] 508f                      addq.l     #8,a7
[00003014] 4a87                      tst.l      d7
[00003016] 6712                      beq.s      _lookup_4
[00003018] 4aae 0010                 tst.l      16(a6)
[0000301c] 6710                      beq.s      _lookup_5
[0000301e] 246e 0010                 movea.l    16(a6),a2
[00003022] 248c                      move.l     a4,(a2)
[00003024] 6008                      bra.s      _lookup_5
_lookup_3:
[00003026] 4287                      clr.l      d7
[00003028] 6008                      bra.s      _lookup_6
_lookup_4:
[0000302a] 2854                      movea.l    (a4),a4
[0000302c] 60c6                      bra.s      _lookup_7
_lookup_5:
[0000302e] 2e2c 0004                 move.l     4(a4),d7
_lookup_6:
[00003032] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00003036] 4e5e                      unlk       a6
[00003038] 4e75                      rts

_nxtfile:
[0000303a] 4e56 0000                 link       a6,#0
[0000303e] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00003042] 4878 0002                 pea.l      ($00000002).w
[00003046] 42a7                      clr.l      -(a7)
[00003048] 2f3c 0000 6238            move.l     #_argv,-(a7)
[0000304e] 2f3c 0000 622a            move.l     #_argc,-(a7)
[00003054] 4eb9 0000 3abe            jsr        _getfiles
[0000305a] 4fef 0010                 lea.l      16(a7),a7
[0000305e] 2a07                      move.l     d7,d5
[00003060] 0c85 0000 0002            cmpi.l     #$00000002,d5
[00003066] 661c                      bne.s      _nxtfile_1
[00003068] 42b9 0000 622a            clr.l      _argc
[0000306e] 2479 0000 6238            movea.l    _argv,a2
[00003074] 598a                      subq.l     #4,a2
[00003076] 2e92                      move.l     (a2),(a7)
[00003078] 2f3c 0000 781e            move.l     #$0000CECC,-(a7) "can',$27,'t open %p"
[0000307e] 4eba fbbc                 jsr        _fatal(pc)
[00003082] 588f                      addq.l     #4,a7
_nxtfile_1:
[00003084] 4a85                      tst.l      d5
[00003086] 6c04                      bge.s      _nxtfile_2
[00003088] 4287                      clr.l      d7
[0000308a] 6062                      bra.s      _nxtfile_3
_nxtfile_2:
[0000308c] 4297                      clr.l      (a7)
[0000308e] 4878 0214                 pea.l      ($00000214).w
[00003092] 4eb9 0000 49de            jsr        _alloc
[00003098] 588f                      addq.l     #4,a7
[0000309a] 2a47                      movea.l    d7,a5
[0000309c] 4a85                      tst.l      d5
[0000309e] 6606                      bne.s      _nxtfile_4
[000030a0] 42ad 0004                 clr.l      4(a5)
[000030a4] 602a                      bra.s      _nxtfile_5
_nxtfile_4:
[000030a6] 2479 0000 6238            movea.l    _argv,a2
[000030ac] 598a                      subq.l     #4,a2
[000030ae] 2e92                      move.l     (a2),(a7)
[000030b0] 4eb9 0000 5450            jsr        _lenstr
[000030b6] 2e87                      move.l     d7,(a7)
[000030b8] 5297                      addq.l     #1,(a7)
[000030ba] 2479 0000 6238            movea.l    _argv,a2
[000030c0] 598a                      subq.l     #4,a2
[000030c2] 2f12                      move.l     (a2),-(a7)
[000030c4] 4eb9 0000 4226            jsr        _buybuf
[000030ca] 588f                      addq.l     #4,a7
[000030cc] 2b47 0004                 move.l     d7,4(a5)
_nxtfile_5:
[000030d0] 7001                      moveq.l    #1,d0
[000030d2] 23c0 0000 6226            move.l     d0,$0000B8D4
[000030d8] 426d 0008                 clr.w      8(a5)
[000030dc] 4297                      clr.l      (a7)
[000030de] 2f05                      move.l     d5,-(a7)
[000030e0] 486d 000a                 pea.l      10(a5)
[000030e4] 4eb9 0000 449c            jsr        _finit
[000030ea] 508f                      addq.l     #8,a7
[000030ec] 2e0d                      move.l     a5,d7
_nxtfile_3:
[000030ee] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[000030f2] 4e5e                      unlk       a6
[000030f4] 4e75                      rts

_perrfmt:
[000030f6] 4e56 fff2                 link       a6,#-14
[000030fa] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[000030fe] 45ee 000c                 lea.l      12(a6),a2
[00003102] 2a4a                      movea.l    a2,a5
[00003104] 286e 0008                 movea.l    8(a6),a4
_perrfmt_8:
[00003108] 4a14                      tst.b      (a4)
[0000310a] 6736                      beq.s      _perrfmt_1
[0000310c] 4287                      clr.l      d7
[0000310e] 1e14                      move.b     (a4),d7
[00003110] 0c47 0025                 cmpi.w     #$0025,d7
[00003114] 6734                      beq.s      _perrfmt_2
[00003116] 4878 0001                 pea.l      ($00000001).w
[0000311a] 2f0c                      move.l     a4,-(a7)
[0000311c] 3e39 0000 6232            move.w     $0000B8E0,d7
[00003122] 48c7                      ext.l      d7
[00003124] 2f07                      move.l     d7,-(a7)
[00003126] 4eb9 0000 56a6            jsr        _write
[0000312c] 4fef 000c                 lea.l      12(a7),a7
[00003130] 2479 0000 623c            movea.l    $0000B8EA,a2
[00003136] 52b9 0000 623c            addq.l     #1,$0000B8EA
[0000313c] 1494                      move.b     (a4),(a2)
[0000313e] 6000 0104                 bra        _perrfmt_3
_perrfmt_1:
[00003142] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00003146] 4e5e                      unlk       a6
[00003148] 4e75                      rts
_perrfmt_2:
[0000314a] 528c                      addq.l     #1,a4
[0000314c] 4287                      clr.l      d7
[0000314e] 1e14                      move.b     (a4),d7
[00003150] 0c47 0063                 cmpi.w     #$0063,d7
[00003154] 6636                      bne.s      _perrfmt_4
[00003156] 201d                      move.l     (a5)+,d0
[00003158] 1d40 fff2                 move.b     d0,-14(a6)
[0000315c] 4878 0001                 pea.l      ($00000001).w
[00003160] 486e fff2                 pea.l      -14(a6)
[00003164] 3e39 0000 6232            move.w     $0000B8E0,d7
[0000316a] 48c7                      ext.l      d7
[0000316c] 2f07                      move.l     d7,-(a7)
[0000316e] 4eb9 0000 56a6            jsr        _write
[00003174] 4fef 000c                 lea.l      12(a7),a7
[00003178] 2479 0000 623c            movea.l    $0000B8EA,a2
[0000317e] 52b9 0000 623c            addq.l     #1,$0000B8EA
[00003184] 14ae fff2                 move.b     -14(a6),(a2)
[00003188] 6000 00ba                 bra        _perrfmt_3
_perrfmt_4:
[0000318c] 4287                      clr.l      d7
[0000318e] 1e14                      move.b     (a4),d7
[00003190] 0c47 0073                 cmpi.w     #$0073,d7
[00003194] 665a                      bne.s      _perrfmt_5
[00003196] 4878 000a                 pea.l      ($0000000A).w
[0000319a] 2f1d                      move.l     (a5)+,-(a7)
[0000319c] 486e fff2                 pea.l      -14(a6)
[000031a0] 4eb9 0000 40e4            jsr        _itob
[000031a6] 4fef 000c                 lea.l      12(a7),a7
[000031aa] 2d47 fffc                 move.l     d7,-4(a6)
[000031ae] 45ee fff2                 lea.l      -14(a6),a2
[000031b2] d5ee fffc                 adda.l     -4(a6),a2
[000031b6] 4212                      clr.b      (a2)
[000031b8] 2eae fffc                 move.l     -4(a6),(a7)
[000031bc] 486e fff2                 pea.l      -14(a6)
[000031c0] 3e39 0000 6232            move.w     $0000B8E0,d7
[000031c6] 48c7                      ext.l      d7
[000031c8] 2f07                      move.l     d7,-(a7)
[000031ca] 4eb9 0000 56a6            jsr        _write
[000031d0] 508f                      addq.l     #8,a7
[000031d2] 2eae fffc                 move.l     -4(a6),(a7)
[000031d6] 486e fff2                 pea.l      -14(a6)
[000031da] 2f39 0000 623c            move.l     $0000B8EA,-(a7)
[000031e0] 4eb9 0000 4e5c            jsr        _cpybuf
[000031e6] 508f                      addq.l     #8,a7
[000031e8] dfb9 0000 623c            add.l      d7,$0000B8EA
[000031ee] 6054                      bra.s      _perrfmt_3
_perrfmt_5:
[000031f0] 2655                      movea.l    (a5),a3
[000031f2] 2e0d                      move.l     a5,d7
[000031f4] 5887                      addq.l     #4,d7
[000031f6] 2a47                      movea.l    d7,a5
[000031f8] 4287                      clr.l      d7
[000031fa] 1e14                      move.b     (a4),d7
[000031fc] 0c47 0062                 cmpi.w     #$0062,d7
[00003200] 6604                      bne.s      _perrfmt_6
[00003202] 2e1d                      move.l     (a5)+,d7
[00003204] 6008                      bra.s      _perrfmt_7
_perrfmt_6:
[00003206] 2e8b                      move.l     a3,(a7)
[00003208] 4eb9 0000 5450            jsr        _lenstr
_perrfmt_7:
[0000320e] 2d47 fffc                 move.l     d7,-4(a6)
[00003212] 2eae fffc                 move.l     -4(a6),(a7)
[00003216] 2f0b                      move.l     a3,-(a7)
[00003218] 3e39 0000 6232            move.w     $0000B8E0,d7
[0000321e] 48c7                      ext.l      d7
[00003220] 2f07                      move.l     d7,-(a7)
[00003222] 4eb9 0000 56a6            jsr        _write
[00003228] 508f                      addq.l     #8,a7
[0000322a] 2eae fffc                 move.l     -4(a6),(a7)
[0000322e] 2f0b                      move.l     a3,-(a7)
[00003230] 2f39 0000 623c            move.l     $0000B8EA,-(a7)
[00003236] 4eb9 0000 4e5c            jsr        _cpybuf
[0000323c] 508f                      addq.l     #8,a7
[0000323e] dfb9 0000 623c            add.l      d7,$0000B8EA
_perrfmt_3:
[00003244] 528c                      addq.l     #1,a4
[00003246] 6000 fec0                 bra        _perrfmt_8

_p0error:
[0000324a] 4e56 fff8                 link       a6,#-8
[0000324e] 23fc 0000 6242 0000 623c  move.l     #$0000B8F0,$0000B8EA
[00003258] 2e39 0000 622a            move.l     _argc,d7
[0000325e] e587                      asl.l      #2,d7
[00003260] 2447                      movea.l    d7,a2
[00003262] 598a                      subq.l     #4,a2
[00003264] d5f9 0000 6238            adda.l     _argv,a2
[0000326a] 4a92                      tst.l      (a2)
[0000326c] 660c                      bne.s      _p0error_1
[0000326e] 2ebc 0000 784e            move.l     #$0000CEFC,(a7)
[00003274] 4eba fe80                 jsr        _perrfmt(pc)
[00003278] 6076                      bra.s      _p0error_2
_p0error_1:
[0000327a] 2ebc 0000 7831            move.l     #$0000CEDF,(a7)
[00003280] 4ab9 0000 6234            tst.l      $0000B8E2
[00003286] 670e                      beq.s      _p0error_3
[00003288] 2479 0000 6234            movea.l    $0000B8E2,a2
[0000328e] 508a                      addq.l     #8,a2
[00003290] 4287                      clr.l      d7
[00003292] 3e12                      move.w     (a2),d7
[00003294] 6008                      bra.s      _p0error_4
_p0error_3:
[00003296] 4287                      clr.l      d7
[00003298] 3e39 0000 622e            move.w     $0000B8DC,d7
_p0error_4:
[0000329e] 2f07                      move.l     d7,-(a7)
[000032a0] 2f3c 0000 7833            move.l     #$0000CEE1,-(a7)
[000032a6] 4ab9 0000 6234            tst.l      $0000B8E2
[000032ac] 670c                      beq.s      _p0error_5
[000032ae] 2479 0000 6234            movea.l    $0000B8E2,a2
[000032b4] 588a                      addq.l     #4,a2
[000032b6] 2e12                      move.l     (a2),d7
[000032b8] 6014                      bra.s      _p0error_6
_p0error_5:
[000032ba] 2e39 0000 622a            move.l     _argc,d7
[000032c0] e587                      asl.l      #2,d7
[000032c2] 2447                      movea.l    d7,a2
[000032c4] 598a                      subq.l     #4,a2
[000032c6] d5f9 0000 6238            adda.l     _argv,a2
[000032cc] 2e12                      move.l     (a2),d7
_p0error_6:
[000032ce] 2f07                      move.l     d7,-(a7)
[000032d0] 2f3c 0000 7835            move.l     #$0000CEE3,-(a7)
[000032d6] 2f39 0000 6216            move.l     $0000B8C4,-(a7)
[000032dc] 2f3c 0000 7837            move.l     #$0000CEE5,-(a7)
[000032e2] 2f3c 0000 783f            move.l     #$0000CEED,-(a7)
[000032e8] 4eba fe0c                 jsr        _perrfmt(pc)
[000032ec] 4fef 001c                 lea.l      28(a7),a7
_p0error_2:
[000032f0] 2eae 0010                 move.l     16(a6),(a7)
[000032f4] 2f2e 000c                 move.l     12(a6),-(a7)
[000032f8] 2f2e 0008                 move.l     8(a6),-(a7)
[000032fc] 4eba fdf8                 jsr        _perrfmt(pc)
[00003300] 508f                      addq.l     #8,a7
[00003302] 2ebc 0000 782f            move.l     #$0000CEDD,(a7)
[00003308] 4eba fdec                 jsr        _perrfmt(pc)
[0000330c] 5279 0000 6230            addq.w     #1,$0000B8DE
[00003312] 2479 0000 623c            movea.l    $0000B8EA,a2
[00003318] 4212                      clr.b      (a2)
[0000331a] 2e39 0000 623c            move.l     $0000B8EA,d7
[00003320] 0487 0000 6240            subi.l     #$0000B8EE,d7
[00003326] 5587                      subq.l     #2,d7
[00003328] 2d47 fffc                 move.l     d7,-4(a6)
[0000332c] 4878 0002                 pea.l      ($00000002).w
[00003330] 486e fffc                 pea.l      -4(a6)
[00003334] 2f3c 0000 6240            move.l     #$0000B8EE,-(a7)
[0000333a] 4eb9 0000 4e5c            jsr        _cpybuf
[00003340] 4fef 000c                 lea.l      12(a7),a7
[00003344] 54ae fffc                 addq.l     #2,-4(a6)
[00003348] 4ab9 0000 61f6            tst.l      _xflag
[0000334e] 671e                      beq.s      _p0error_7
[00003350] 2eae fffc                 move.l     -4(a6),(a7)
[00003354] 2f3c 0000 6240            move.l     #$0000B8EE,-(a7)
[0000335a] 4878 00fe                 pea.l      ($000000FE).w
[0000335e] 2f3c 0000 782c            move.l     #$0000CEDA,-(a7)
[00003364] 4eb9 0000 19aa            jsr        _putcode
[0000336a] 4fef 000c                 lea.l      12(a7),a7
_p0error_7:
[0000336e] 4e5e                      unlk       a6
[00003370] 4e75                      rts

_predef:
[00003372] 4e56 fff8                 link       a6,#-8
[00003376] 48e7 8c1c                 movem.l    d0/d4-d5/a3-a5,-(a7)
[0000337a] 2a6e 0008                 movea.l    8(a6),a5
[0000337e] 426e fffe                 clr.w      -2(a6)
_predef_7:
[00003382] 2e15                      move.l     (a5),d7
[00003384] 7c0a                      moveq.l    #10,d6
[00003386] 382e fffe                 move.w     -2(a6),d4
[0000338a] 48c4                      ext.l      d4
[0000338c] 9c84                      sub.l      d4,d6
[0000338e] be86                      cmp.l      d6,d7
[00003390] 643e                      bcc.s      _predef_1
[00003392] 7e09                      moveq.l    #9,d7
[00003394] 3c2e fffe                 move.w     -2(a6),d6
[00003398] 48c6                      ext.l      d6
[0000339a] 9e86                      sub.l      d6,d7
[0000339c] e587                      asl.l      #2,d7
[0000339e] 2447                      movea.l    d7,a2
[000033a0] 47ed 0004                 lea.l      4(a5),a3
[000033a4] d5cb                      adda.l     a3,a2
[000033a6] 2852                      movea.l    (a2),a4
[000033a8] 2ebc 0000 7868            move.l     #$0000CF16,(a7)
[000033ae] 2f0c                      move.l     a4,-(a7)
[000033b0] 4eb9 0000 45ec            jsr        _instr
[000033b6] 588f                      addq.l     #4,a7
[000033b8] 2a07                      move.l     d7,d5
[000033ba] 4a34 5800                 tst.b      0(a4,d5.l)
[000033be] 6618                      bne.s      _predef_2
[000033c0] 3d7c 0003 fffc            move.w     #$0003,-4(a6)
[000033c6] 2d7c 0000 7864 fff8       move.l     #$0000CF12,-8(a6)
[000033ce] 6044                      bra.s      _predef_3
_predef_1:
[000033d0] 4cdf 3831                 movem.l    (a7)+,d0/d4-d5/a3-a5
[000033d4] 4e5e                      unlk       a6
[000033d6] 4e75                      rts
_predef_2:
[000033d8] 4287                      clr.l      d7
[000033da] 1e34 5800                 move.b     0(a4,d5.l),d7
[000033de] 0c47 003d                 cmpi.w     #$003D,d7
[000033e2] 6606                      bne.s      _predef_4
[000033e4] 19bc 0020 5800            move.b     #$20,0(a4,d5.l)
_predef_4:
[000033ea] 2e8c                      move.l     a4,(a7)
[000033ec] 4eb9 0000 5450            jsr        _lenstr
[000033f2] 9e85                      sub.l      d5,d7
[000033f4] 5287                      addq.l     #1,d7
[000033f6] 3d47 fffc                 move.w     d7,-4(a6)
[000033fa] 2e0c                      move.l     a4,d7
[000033fc] de85                      add.l      d5,d7
[000033fe] 2d47 fff8                 move.l     d7,-8(a6)
[00003402] 3e2e fffc                 move.w     -4(a6),d7
[00003406] 48c7                      ext.l      d7
[00003408] 2447                      movea.l    d7,a2
[0000340a] 538a                      subq.l     #1,a2
[0000340c] d5ee fff8                 adda.l     -8(a6),a2
[00003410] 14bc 000a                 move.b     #$0A,(a2)
_predef_3:
[00003414] 4297                      clr.l      (a7)
[00003416] 2f05                      move.l     d5,-(a7)
[00003418] 2f0c                      move.l     a4,-(a7)
[0000341a] 4eba fbaa                 jsr        _lookup(pc)
[0000341e] 508f                      addq.l     #8,a7
[00003420] 4a87                      tst.l      d7
[00003422] 6712                      beq.s      _predef_5
[00003424] 2e85                      move.l     d5,(a7)
[00003426] 2f0c                      move.l     a4,-(a7)
[00003428] 2f3c 0000 7854            move.l     #$0000CF02,-(a7) "-d %b redefined"
[0000342e] 4eba fe1a                 jsr        _p0error(pc)
[00003432] 508f                      addq.l     #8,a7
[00003434] 6020                      bra.s      _predef_6
_predef_5:
[00003436] 3e2e fffc                 move.w     -4(a6),d7
[0000343a] 48c7                      ext.l      d7
[0000343c] 2e87                      move.l     d7,(a7)
[0000343e] 2f2e fff8                 move.l     -8(a6),-(a7)
[00003442] 4eb9 0000 4226            jsr        _buybuf
[00003448] 588f                      addq.l     #4,a7
[0000344a] 2e87                      move.l     d7,(a7)
[0000344c] 2f05                      move.l     d5,-(a7)
[0000344e] 2f0c                      move.l     a4,-(a7)
[00003450] 4eba fb0c                 jsr        _install(pc)
[00003454] 508f                      addq.l     #8,a7
_predef_6:
[00003456] 526e fffe                 addq.w     #1,-2(a6)
[0000345a] 6000 ff26                 bra        _predef_7

_ptline:
[0000345e] 4e56 fffc                 link       a6,#-4
[00003462] 4ab9 0000 6234            tst.l      $0000B8E2
[00003468] 6720                      beq.s      _ptline_1
[0000346a] 4ab9 0000 61f6            tst.l      _xflag
[00003470] 6718                      beq.s      _ptline_1
[00003472] 4ab9 0000 621e            tst.l      $0000B8CC
[00003478] 6610                      bne.s      _ptline_1
[0000347a] 4ab9 0000 61e6            tst.l      _lincl
[00003480] 660c                      bne.s      _ptline_2
[00003482] 4a79 0000 6204            tst.w      $0000B8B2
[00003488] 6704                      beq.s      _ptline_2
_ptline_1:
[0000348a] 4e5e                      unlk       a6
[0000348c] 4e75                      rts
_ptline_2:
[0000348e] 2eb9 0000 6234            move.l     $0000B8E2,(a7)
[00003494] 5097                      addq.l     #8,(a7)
[00003496] 4878 0014                 pea.l      ($00000014).w
[0000349a] 2f3c 0000 786c            move.l     #$0000CF1A,-(a7)
[000034a0] 4eb9 0000 19aa            jsr        _putcode
[000034a6] 508f                      addq.l     #8,a7
[000034a8] 60e0                      bra.s      _ptline_1

_scntab:
[000034aa] 4e56 fff6                 link       a6,#-10
[000034ae] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000034b2] 42ae fff8                 clr.l      -8(a6)
_scntab_6:
[000034b6] 2e2e fff8                 move.l     -8(a6),d7
[000034ba] beae 000c                 cmp.l      12(a6),d7
[000034be] 6448                      bcc.s      _scntab_1
[000034c0] 2e2e 000c                 move.l     12(a6),d7
[000034c4] deae fff8                 add.l      -8(a6),d7
[000034c8] e28f                      lsr.l      #1,d7
[000034ca] 2d47 fffc                 move.l     d7,-4(a6)
[000034ce] 2e2e fffc                 move.l     -4(a6),d7
[000034d2] e787                      asl.l      #3,d7
[000034d4] 2447                      movea.l    d7,a2
[000034d6] d5ee 0008                 adda.l     8(a6),a2
[000034da] 2852                      movea.l    (a2),a4
[000034dc] 4287                      clr.l      d7
[000034de] 1e1c                      move.b     (a4)+,d7
[000034e0] 9eae 0014                 sub.l      20(a6),d7
[000034e4] 3d47 fff6                 move.w     d7,-10(a6)
[000034e8] 6622                      bne.s      _scntab_2
[000034ea] 4285                      clr.l      d5
[000034ec] 2a6e 0010                 movea.l    16(a6),a5
_scntab_7:
[000034f0] baae 0014                 cmp.l      20(a6),d5
[000034f4] 6416                      bcc.s      _scntab_2
[000034f6] 4287                      clr.l      d7
[000034f8] 1e1c                      move.b     (a4)+,d7
[000034fa] 4286                      clr.l      d6
[000034fc] 1c1d                      move.b     (a5)+,d6
[000034fe] 9e86                      sub.l      d6,d7
[00003500] 3d47 fff6                 move.w     d7,-10(a6)
[00003504] 6718                      beq.s      _scntab_3
[00003506] 6004                      bra.s      _scntab_2
_scntab_1:
[00003508] 4287                      clr.l      d7
[0000350a] 602c                      bra.s      _scntab_4
_scntab_2:
[0000350c] 4a6e fff6                 tst.w      -10(a6)
[00003510] 6c10                      bge.s      _scntab_5
[00003512] 2e2e fffc                 move.l     -4(a6),d7
[00003516] 5287                      addq.l     #1,d7
[00003518] 2d47 fff8                 move.l     d7,-8(a6)
[0000351c] 6098                      bra.s      _scntab_6
_scntab_3:
[0000351e] 5285                      addq.l     #1,d5
[00003520] 60ce                      bra.s      _scntab_7
_scntab_5:
[00003522] 4a6e fff6                 tst.w      -10(a6)
[00003526] 6618                      bne.s      _scntab_8
[00003528] 2e2e fffc                 move.l     -4(a6),d7
[0000352c] e787                      asl.l      #3,d7
[0000352e] 2447                      movea.l    d7,a2
[00003530] d5ee 0008                 adda.l     8(a6),a2
[00003534] 588a                      addq.l     #4,a2
[00003536] 2e12                      move.l     (a2),d7
_scntab_4:
[00003538] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000353c] 4e5e                      unlk       a6
[0000353e] 4e75                      rts
_scntab_8:
[00003540] 2d6e fffc 000c            move.l     -4(a6),12(a6)
[00003546] 6000 ff6e                 bra        _scntab_6

_stotl:
[0000354a] 4e56 fff8                 link       a6,#-8
[0000354e] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00003552] 2a6e 0008                 movea.l    8(a6),a5
[00003556] 4aae 000c                 tst.l      12(a6)
[0000355a] 660c                      bne.s      _stotl_1
[0000355c] 45ee fff8                 lea.l      -8(a6),a2
[00003560] 2d4a 000c                 move.l     a2,12(a6)
[00003564] 42ae fff8                 clr.l      -8(a6)
_stotl_1:
[00003568] 45ee fffc                 lea.l      -4(a6),a2
[0000356c] 264a                      movea.l    a2,a3
_stotl_47:
[0000356e] 4297                      clr.l      (a7)
[00003570] 42a7                      clr.l      -(a7)
[00003572] 4eba f650                 jsr        _buytl(pc)
[00003576] 588f                      addq.l     #4,a7
[00003578] 2847                      movea.l    d7,a4
[0000357a] 294d 0008                 move.l     a5,8(a4) q->white = s;
_stotl_7:
[0000357e] 4287                      clr.l      d7
[00003580] 1e15                      move.b     (a5),d7
[00003582] 0c47 000a                 cmpi.w     #$000A,d7
[00003586] 6716                      beq.s      _stotl_2
[00003588] 4287                      clr.l      d7        ISWHITE(*s)
[0000358a] 1e15                      move.b     (a5),d7
[0000358c] 0c47 0020                 cmpi.w     #$0020,d7
[00003590] 6336                      bls.s      _stotl_3
[00003592] 4287                      clr.l      d7
[00003594] 1e15                      move.b     (a5),d7
[00003596] 0c47 007f                 cmpi.w     #$007F,d7
[0000359a] 6530                      bcs.s      _stotl_4
[0000359c] 602a                      bra.s      _stotl_3
_stotl_2:
[0000359e] 2e0d                      move.l     a5,d7
[000035a0] 9eac 0008                 sub.l      8(a4),d7
[000035a4] 2947 000c                 move.l     d7,12(a4) q->nwhite = s - q->white;
[000035a8] 294d 0010                 move.l     a5,16(a4)  q->text = s;
[000035ac] 42ac 0014                 clr.l      20(a4)     q->ntext = 0
[000035b0] 4287                      clr.l      d7
[000035b2] 1e15                      move.b     (a5),d7
[000035b4] 0c47 000a                 cmpi.w     #$000A,d7
[000035b8] 6600 00fe                 bne        _stotl_5
[000035bc] 528d                      addq.l     #1,a5
[000035be] 7002                      moveq.l    #2,d0
[000035c0] 2940 0004                 move.l     d0,4(a4)  q->type = PEOL;
[000035c4] 6000 01cc                 bra        _stotl_6
_stotl_3:
[000035c8] 528d                      addq.l     #1,a5
[000035ca] 60b2                      bra.s      _stotl_7
_stotl_4:
[000035cc] 246e 000c                 movea.l    12(a6),a2
[000035d0] 4a92                      tst.l      (a2)
[000035d2] 661e                      bne.s      _stotl_8
[000035d4] 4ab9 0000 61ee            tst.l      _forpascal
[000035da] 6632                      bne.s      _stotl_9
[000035dc] 4287                      clr.l      d7
[000035de] 1e15                      move.b     (a5),d7
[000035e0] 0c47 002f                 cmpi.w     #$002F,d7 '/'
[000035e4] 6628                      bne.s      _stotl_9
[000035e6] 4287                      clr.l      d7
[000035e8] 1e2d 0001                 move.b     1(a5),d7
[000035ec] 0c47 002a                 cmpi.w     #$002A,d7
[000035f0] 661c                      bne.s      _stotl_9
_stotl_8:
[000035f2] 246e 000c                 movea.l    12(a6),a2
[000035f6] 4a92                      tst.l      (a2)
[000035f8] 6642                      bne.s      _stotl_10
[000035fa] 4287                      clr.l      d7
[000035fc] 1e15                      move.b     (a5),d7
[000035fe] 0c47 007b                 cmpi.w     #$007B,d7
[00003602] 6604                      bne.s      _stotl_11
[00003604] 7e01                      moveq.l    #1,d7
[00003606] 6002                      bra.s      _stotl_12
_stotl_11:
[00003608] 7e02                      moveq.l    #2,d7
_stotl_12:
[0000360a] dbc7                      adda.l     d7,a5
[0000360c] 602e                      bra.s      _stotl_10
_stotl_9:
[0000360e] 4ab9 0000 61ee            tst.l      _forpascal
[00003614] 6788                      beq.s      _stotl_2
[00003616] 4287                      clr.l      d7
[00003618] 1e15                      move.b     (a5),d7
[0000361a] 0c47 007b                 cmpi.w     #$007B,d7
[0000361e] 67d2                      beq.s      _stotl_8
[00003620] 4287                      clr.l      d7
[00003622] 1e15                      move.b     (a5),d7
[00003624] 0c47 0028                 cmpi.w     #$0028,d7
[00003628] 6600 ff74                 bne        _stotl_2
[0000362c] 4287                      clr.l      d7
[0000362e] 1e2d 0001                 move.b     1(a5),d7
[00003632] 0c47 002a                 cmpi.w     #$002A,d7
[00003636] 67ba                      beq.s      _stotl_8
[00003638] 6000 ff64                 bra        _stotl_2
_stotl_10:
[0000363c] 246e 000c                 movea.l    12(a6),a2
[00003640] 7001                      moveq.l    #1,d0
[00003642] 2480                      move.l     d0,(a2)
_stotl_15:
[00003644] 4287                      clr.l      d7
[00003646] 1e15                      move.b     (a5),d7
[00003648] 0c47 000a                 cmpi.w     #$000A,d7
[0000364c] 6700 ff30                 beq        _stotl_7
[00003650] 4ab9 0000 61ee            tst.l      _forpascal
[00003656] 661c                      bne.s      _stotl_13
[00003658] 4287                      clr.l      d7
[0000365a] 1e15                      move.b     (a5),d7
[0000365c] 0c47 002a                 cmpi.w     #$002A,d7
[00003660] 6612                      bne.s      _stotl_13
[00003662] 4287                      clr.l      d7
[00003664] 1e2d 0001                 move.b     1(a5),d7
[00003668] 0c47 002f                 cmpi.w     #$002F,d7
[0000366c] 672e                      beq.s      _stotl_14
[0000366e] 6004                      bra.s      _stotl_13
_stotl_16:
[00003670] 528d                      addq.l     #1,a5
[00003672] 60d0                      bra.s      _stotl_15
_stotl_13:
[00003674] 4ab9 0000 61ee            tst.l      _forpascal
[0000367a] 67f4                      beq.s      _stotl_16
[0000367c] 4287                      clr.l      d7
[0000367e] 1e15                      move.b     (a5),d7
[00003680] 0c47 007d                 cmpi.w     #$007D,d7
[00003684] 6716                      beq.s      _stotl_14
[00003686] 4287                      clr.l      d7
[00003688] 1e15                      move.b     (a5),d7
[0000368a] 0c47 002a                 cmpi.w     #$002A,d7
[0000368e] 66e0                      bne.s      _stotl_16
[00003690] 4287                      clr.l      d7
[00003692] 1e2d 0001                 move.b     1(a5),d7
[00003696] 0c47 0029                 cmpi.w     #$0029,d7
[0000369a] 66d4                      bne.s      _stotl_16
_stotl_14:
[0000369c] 246e 000c                 movea.l    12(a6),a2
[000036a0] 4292                      clr.l      (a2)
[000036a2] 4287                      clr.l      d7
[000036a4] 1e15                      move.b     (a5),d7
[000036a6] 0c47 007d                 cmpi.w     #$007D,d7
[000036aa] 6604                      bne.s      _stotl_17
[000036ac] 7e01                      moveq.l    #1,d7
[000036ae] 6002                      bra.s      _stotl_18
_stotl_17:
[000036b0] 7e02                      moveq.l    #2,d7
_stotl_18:
[000036b2] dbc7                      adda.l     d7,a5
[000036b4] 6000 fec8                 bra        _stotl_7
_stotl_5:
[000036b8] 4287                      clr.l      d7
[000036ba] 1e15                      move.b     (a5),d7
[000036bc] 0c47 0061                 cmpi.w     #$0061,d7
[000036c0] 650a                      bcs.s      _stotl_19
[000036c2] 4287                      clr.l      d7
[000036c4] 1e15                      move.b     (a5),d7
[000036c6] 0c47 007a                 cmpi.w     #$007A,d7
[000036ca] 6364                      bls.s      _stotl_20
_stotl_19:
[000036cc] 4287                      clr.l      d7
[000036ce] 1e15                      move.b     (a5),d7
[000036d0] 0c47 0041                 cmpi.w     #$0041,d7
[000036d4] 650a                      bcs.s      _stotl_21
[000036d6] 4287                      clr.l      d7
[000036d8] 1e15                      move.b     (a5),d7
[000036da] 0c47 005a                 cmpi.w     #$005A,d7
[000036de] 6350                      bls.s      _stotl_20
_stotl_21:
[000036e0] 4287                      clr.l      d7
[000036e2] 1e15                      move.b     (a5),d7
[000036e4] 0c47 005f                 cmpi.w     #$005F,d7
[000036e8] 6746                      beq.s      _stotl_20
[000036ea] 4ab9 0000 61f2            tst.l      _std
[000036f0] 660a                      bne.s      _stotl_22
[000036f2] 4287                      clr.l      d7
[000036f4] 1e15                      move.b     (a5),d7
[000036f6] 0c47 0024                 cmpi.w     #$0024,d7
[000036fa] 6734                      beq.s      _stotl_20
_stotl_22:
[000036fc] 4287                      clr.l      d7
[000036fe] 1e15                      move.b     (a5),d7
[00003700] 0c47 0030                 cmpi.w     #$0030,d7
[00003704] 6500 00a2                 bcs        _stotl_23
[00003708] 4287                      clr.l      d7
[0000370a] 1e15                      move.b     (a5),d7
[0000370c] 0c47 0039                 cmpi.w     #$0039,d7
[00003710] 6200 0096                 bhi        _stotl_23
_stotl_37:
[00003714] 4287                      clr.l      d7
[00003716] 1e15                      move.b     (a5),d7
[00003718] 0c47 0061                 cmpi.w     #$0061,d7
[0000371c] 6500 00a4                 bcs        _stotl_24
[00003720] 4287                      clr.l      d7
[00003722] 1e15                      move.b     (a5),d7
[00003724] 0c47 007a                 cmpi.w     #$007A,d7
[00003728] 6300 00d2                 bls        _stotl_25
[0000372c] 6000 0094                 bra        _stotl_24
_stotl_20:
[00003730] 4287                      clr.l      d7
[00003732] 1e15                      move.b     (a5),d7
[00003734] 0c47 0061                 cmpi.w     #$0061,d7
[00003738] 650a                      bcs.s      _stotl_26
[0000373a] 4287                      clr.l      d7
[0000373c] 1e15                      move.b     (a5),d7
[0000373e] 0c47 007a                 cmpi.w     #$007A,d7
[00003742] 6314                      bls.s      _stotl_27
_stotl_26:
[00003744] 4287                      clr.l      d7
[00003746] 1e15                      move.b     (a5),d7
[00003748] 0c47 0041                 cmpi.w     #$0041,d7
[0000374c] 650e                      bcs.s      _stotl_28
[0000374e] 4287                      clr.l      d7
[00003750] 1e15                      move.b     (a5),d7
[00003752] 0c47 005a                 cmpi.w     #$005A,d7
[00003756] 6204                      bhi.s      _stotl_28
_stotl_27:
[00003758] 528d                      addq.l     #1,a5
[0000375a] 60d4                      bra.s      _stotl_20
_stotl_28:
[0000375c] 4287                      clr.l      d7
[0000375e] 1e15                      move.b     (a5),d7
[00003760] 0c47 005f                 cmpi.w     #$005F,d7
[00003764] 67f2                      beq.s      _stotl_27
[00003766] 4ab9 0000 61f2            tst.l      _std
[0000376c] 660a                      bne.s      _stotl_29
[0000376e] 4287                      clr.l      d7
[00003770] 1e15                      move.b     (a5),d7
[00003772] 0c47 0024                 cmpi.w     #$0024,d7
[00003776] 67e0                      beq.s      _stotl_27
_stotl_29:
[00003778] 4287                      clr.l      d7
[0000377a] 1e15                      move.b     (a5),d7
[0000377c] 0c47 0030                 cmpi.w     #$0030,d7
[00003780] 650a                      bcs.s      _stotl_30
[00003782] 4287                      clr.l      d7
[00003784] 1e15                      move.b     (a5),d7
[00003786] 0c47 0039                 cmpi.w     #$0039,d7
[0000378a] 63cc                      bls.s      _stotl_27
_stotl_30:
[0000378c] 7003                      moveq.l    #3,d0
[0000378e] 2940 0004                 move.l     d0,4(a4)  q->type = PIDENT;
_stotl_6:
[00003792] 4aac 0014                 tst.l      20(a4)
[00003796] 6600 0178                 bne        _stotl_31
[0000379a] 2e0d                      move.l     a5,d7
[0000379c] 9eac 0010                 sub.l      16(a4),d7
[000037a0] 2947 0014                 move.l     d7,20(a4)
[000037a4] 6000 016a                 bra        _stotl_31
_stotl_23:
[000037a8] 4287                      clr.l      d7
[000037aa] 1e15                      move.b     (a5),d7
[000037ac] 0c47 0022                 cmpi.w     #$0022,d7
[000037b0] 6700 0096                 beq        _stotl_32
[000037b4] 4287                      clr.l      d7
[000037b6] 1e15                      move.b     (a5),d7
[000037b8] 0c47 0027                 cmpi.w     #$0027,d7
[000037bc] 664c                      bne.s      _stotl_33
[000037be] 6000 0088                 bra        _stotl_32
_stotl_24:
[000037c2] 4287                      clr.l      d7
[000037c4] 1e15                      move.b     (a5),d7
[000037c6] 0c47 0041                 cmpi.w     #$0041,d7
[000037ca] 650a                      bcs.s      _stotl_34
[000037cc] 4287                      clr.l      d7
[000037ce] 1e15                      move.b     (a5),d7
[000037d0] 0c47 005a                 cmpi.w     #$005A,d7
[000037d4] 6326                      bls.s      _stotl_25
_stotl_34:
[000037d6] 4287                      clr.l      d7
[000037d8] 1e15                      move.b     (a5),d7
[000037da] 0c47 0030                 cmpi.w     #$0030,d7
[000037de] 650a                      bcs.s      _stotl_35
[000037e0] 4287                      clr.l      d7
[000037e2] 1e15                      move.b     (a5),d7
[000037e4] 0c47 0039                 cmpi.w     #$0039,d7
[000037e8] 6312                      bls.s      _stotl_25
_stotl_35:
[000037ea] 4ab9 0000 61f2            tst.l      _std
[000037f0] 6610                      bne.s      _stotl_36
[000037f2] 4287                      clr.l      d7
[000037f4] 1e15                      move.b     (a5),d7
[000037f6] 0c47 005f                 cmpi.w     #$005F,d7
[000037fa] 6606                      bne.s      _stotl_36
_stotl_25:
[000037fc] 528d                      addq.l     #1,a5
[000037fe] 6000 ff14                 bra        _stotl_37
_stotl_36:
[00003802] 7004                      moveq.l    #4,d0
[00003804] 2940 0004                 move.l     d0,4(a4)  q->type = PNUM;
[00003808] 6088                      bra.s      _stotl_6
_stotl_33:
[0000380a] 4ab9 0000 61f6            tst.l      _xflag
[00003810] 6600 00f2                 bne        _stotl_38
[00003814] 4287                      clr.l      d7
[00003816] 1e15                      move.b     (a5),d7
[00003818] 0c47 005c                 cmpi.w     #$005C,d7
[0000381c] 6600 00e6                 bne        _stotl_38
[00003820] 4287                      clr.l      d7
[00003822] 1e2d 0001                 move.b     1(a5),d7
[00003826] 0c47 006e                 cmpi.w     #$006E,d7
[0000382a] 6600 00d8                 bne        _stotl_38
[0000382e] 548d                      addq.l     #2,a5
[00003830] 297c 0000 7870 0010       move.l     #$0000CF1E,16(a4)
[00003838] 7001                      moveq.l    #1,d0
[0000383a] 2940 0014                 move.l     d0,20(a4)
[0000383e] 7005                      moveq.l    #5,d0
[00003840] 2940 0004                 move.l     d0,4(a4)   q->type = PPUNCT
[00003844] 6000 ff4c                 bra        _stotl_6
_stotl_32:
[00003848] 528d                      addq.l     #1,a5
[0000384a] 4287                      clr.l      d7
[0000384c] 1e15                      move.b     (a5),d7
[0000384e] 246c 0010                 movea.l    16(a4),a2
[00003852] 4286                      clr.l      d6
[00003854] 1c12                      move.b     (a2),d6
[00003856] be86                      cmp.l      d6,d7
[00003858] 6724                      beq.s      _stotl_39
[0000385a] 4287                      clr.l      d7
[0000385c] 1e15                      move.b     (a5),d7
[0000385e] 0c47 000a                 cmpi.w     #$000A,d7
[00003862] 671a                      beq.s      _stotl_39
[00003864] 4287                      clr.l      d7
[00003866] 1e15                      move.b     (a5),d7
[00003868] 0c47 005c                 cmpi.w     #$005C,d7
[0000386c] 663e                      bne.s      _stotl_40
[0000386e] 4287                      clr.l      d7
[00003870] 1e2d 0001                 move.b     1(a5),d7
[00003874] 0c47 000a                 cmpi.w     #$000A,d7
[00003878] 6732                      beq.s      _stotl_40
[0000387a] 528d                      addq.l     #1,a5
[0000387c] 60ca                      bra.s      _stotl_32
_stotl_39:
[0000387e] 4287                      clr.l      d7
[00003880] 1e15                      move.b     (a5),d7
[00003882] 246c 0010                 movea.l    16(a4),a2
[00003886] 4286                      clr.l      d6
[00003888] 1c12                      move.b     (a2),d6
[0000388a] be86                      cmp.l      d6,d7
[0000388c] 662a                      bne.s      _stotl_41
[0000388e] 528d                      addq.l     #1,a5
[00003890] 246c 0010                 movea.l    16(a4),a2
[00003894] 4287                      clr.l      d7
[00003896] 1e12                      move.b     (a2),d7
[00003898] 0c47 0022                 cmpi.w     #$0022,d7
[0000389c] 6604                      bne.s      _stotl_42
[0000389e] 7e06                      moveq.l    #6,d7   q->type = PSTRCON
[000038a0] 6002                      bra.s      _stotl_43
_stotl_42:
[000038a2] 7e01                      moveq.l    #1,d7   q->type = PCHCON
_stotl_43:
[000038a4] 2947 0004                 move.l     d7,4(a4)
[000038a8] 6000 fee8                 bra        _stotl_6
_stotl_40:
[000038ac] 4287                      clr.l      d7
[000038ae] 1e15                      move.b     (a5),d7
[000038b0] 0c47 005c                 cmpi.w     #$005C,d7
[000038b4] 6692                      bne.s      _stotl_32
[000038b6] 60c6                      bra.s      _stotl_39
_stotl_41:
[000038b8] 4ab9 0000 61f6            tst.l      _xflag
[000038be] 6732                      beq.s      _stotl_44
[000038c0] 246c 0010                 movea.l    16(a4),a2
[000038c4] 4287                      clr.l      d7
[000038c6] 1e12                      move.b     (a2),d7
[000038c8] 0c47 0022                 cmpi.w     #$0022,d7
[000038cc] 6604                      bne.s      _stotl_45
[000038ce] 7e06                      moveq.l    #6,d7   q->type = PSTRCON
[000038d0] 6002                      bra.s      _stotl_46
_stotl_45:
[000038d2] 7e01                      moveq.l    #1,d7   q->type = PCHCON
_stotl_46:
[000038d4] 2947 0004                 move.l     d7,4(a4)
[000038d8] 246c 0010                 movea.l    16(a4),a2
[000038dc] 4287                      clr.l      d7
[000038de] 1e12                      move.b     (a2),d7
[000038e0] 2e87                      move.l     d7,(a7)
[000038e2] 2f3c 0000 7872            move.l     #$0000CF20,-(a7) "unbalanced %c"
[000038e8] 4eba f960                 jsr        _p0error(pc)
[000038ec] 588f                      addq.l     #4,a7
[000038ee] 6000 fea2                 bra        _stotl_6
_stotl_44:
[000038f2] 7005                      moveq.l    #5,d0
[000038f4] 2940 0004                 move.l     d0,4(a4)
[000038f8] 2e2c 0010                 move.l     16(a4),d7
[000038fc] 5287                      addq.l     #1,d7
[000038fe] 2a47                      movea.l    d7,a5
[00003900] 6000 fe90                 bra        _stotl_6
_stotl_38:
[00003904] 528d                      addq.l     #1,a5
[00003906] 7005                      moveq.l    #5,d0
[00003908] 2940 0004                 move.l     d0,4(a4)
[0000390c] 6000 fe84                 bra        _stotl_6
_stotl_31:
[00003910] 268c                      move.l     a4,(a3)
[00003912] 264c                      movea.l    a4,a3
[00003914] 0cac 0000 0002 0004       cmpi.l     #$00000002,4(a4)
[0000391c] 6600 fc50                 bne        _stotl_47
[00003920] 2e2e fffc                 move.l     -4(a6),d7
[00003924] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00003928] 4e5e                      unlk       a6
[0000392a] 4e75                      rts

_fclose:
[0000392c] 4e56 0000                 link       a6,#0
[00003930] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00003934] 2a6e 0008                 movea.l    8(a6),a5
[00003938] 2e0d                      move.l     a5,d7
[0000393a] 6610                      bne.s      _fclose_1
[0000393c] 2ebc 0000 7b0e            move.l     #$0000D1BC,(a7)
[00003942] 42a7                      clr.l      -(a7)
[00003944] 4eb9 0000 5462            jsr        __raise
[0000394a] 588f                      addq.l     #4,a7
_fclose_1:
[0000394c] 267c 0000 7ae6            movea.l    #$0000D194,a3
_fclose_6:
[00003952] 2853                      movea.l    (a3),a4
[00003954] 2e0c                      move.l     a4,d7
[00003956] 6708                      beq.s      _fclose_2
[00003958] b9cd                      cmpa.l     a5,a4
[0000395a] 661e                      bne.s      _fclose_3
[0000395c] 26ac 0006                 move.l     6(a4),(a3)
_fclose_2:
[00003960] 3e2d 0004                 move.w     4(a5),d7
[00003964] 48c7                      ext.l      d7
[00003966] 0c47 0001                 cmpi.w     #$0001,d7
[0000396a] 6716                      beq.s      _fclose_4
[0000396c] 3e2d 0004                 move.w     4(a5),d7
[00003970] 48c7                      ext.l      d7
[00003972] 0c47 ffff                 cmpi.w     #$FFFF,d7
[00003976] 6644                      bne.s      _fclose_5
[00003978] 6008                      bra.s      _fclose_4
_fclose_3:
[0000397a] 45ec 0006                 lea.l      6(a4),a2
[0000397e] 264a                      movea.l    a2,a3
[00003980] 60d0                      bra.s      _fclose_6
_fclose_4:
[00003982] 4a6d 0002                 tst.w      2(a5)
[00003986] 6734                      beq.s      _fclose_5
[00003988] 3e2d 0002                 move.w     2(a5),d7
[0000398c] 48c7                      ext.l      d7
[0000398e] 2e87                      move.l     d7,(a7)
[00003990] 486d 000a                 pea.l      10(a5)
[00003994] 3e15                      move.w     (a5),d7
[00003996] 48c7                      ext.l      d7
[00003998] 2f07                      move.l     d7,-(a7)
[0000399a] 4eb9 0000 56a6            jsr        _write
[000039a0] 508f                      addq.l     #8,a7
[000039a2] 3c2d 0002                 move.w     2(a5),d6
[000039a6] 48c6                      ext.l      d6
[000039a8] be86                      cmp.l      d6,d7
[000039aa] 6710                      beq.s      _fclose_5
[000039ac] 2ebc 0000 7b94            move.l     #$0000D242,(a7)
[000039b2] 42a7                      clr.l      -(a7)
[000039b4] 4eb9 0000 5462            jsr        __raise
[000039ba] 588f                      addq.l     #4,a7
_fclose_5:
[000039bc] 3e15                      move.w     (a5),d7
[000039be] 48c7                      ext.l      d7
[000039c0] 2e87                      move.l     d7,(a7)
[000039c2] 4eb9 0000 4e54            jsr        _close
[000039c8] 4a87                      tst.l      d7
[000039ca] 6d04                      blt.s      _fclose_7
[000039cc] 2e0d                      move.l     a5,d7
[000039ce] 6002                      bra.s      _fclose_8
_fclose_7:
[000039d0] 4287                      clr.l      d7
_fclose_8:
[000039d2] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000039d6] 4e5e                      unlk       a6
[000039d8] 4e75                      rts

_fread:
[000039da] 4e56 0000                 link       a6,#0
[000039de] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[000039e2] 4285                      clr.l      d5
_fread_3:
[000039e4] baae 0010                 cmp.l      16(a6),d5
[000039e8] 641c                      bcc.s      _fread_1
[000039ea] 2e2e 0010                 move.l     16(a6),d7
[000039ee] 9e85                      sub.l      d5,d7
[000039f0] 2e87                      move.l     d7,(a7)
[000039f2] 2f2e 000c                 move.l     12(a6),-(a7)
[000039f6] 2f2e 0008                 move.l     8(a6),-(a7)
[000039fa] 4eb9 0000 48aa            jsr        _read
[00003a00] 508f                      addq.l     #8,a7
[00003a02] 2807                      move.l     d7,d4
[00003a04] 6612                      bne.s      _fread_2
_fread_1:
[00003a06] 2e05                      move.l     d5,d7
[00003a08] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[00003a0c] 4e5e                      unlk       a6
[00003a0e] 4e75                      rts
_fread_4:
[00003a10] d9ae 000c                 add.l      d4,12(a6)
[00003a14] da84                      add.l      d4,d5
[00003a16] 60cc                      bra.s      _fread_3
_fread_2:
[00003a18] 4a84                      tst.l      d4
[00003a1a] 6cf4                      bge.s      _fread_4
[00003a1c] 2ebc 0000 7aee            move.l     #$0000D19C,(a7)
[00003a22] 42a7                      clr.l      -(a7)
[00003a24] 4eb9 0000 5462            jsr        __raise
[00003a2a] 588f                      addq.l     #4,a7
[00003a2c] 60e2                      bra.s      _fread_4

_frelst:
[00003a2e] 4e56 0000                 link       a6,#0
[00003a32] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00003a36] 2a6e 0008                 movea.l    8(a6),a5
[00003a3a] 286e 000c                 movea.l    12(a6),a4
_frelst_2:
[00003a3e] 2e0d                      move.l     a5,d7
[00003a40] 6714                      beq.s      _frelst_1
[00003a42] bbcc                      cmpa.l     a4,a5
[00003a44] 6710                      beq.s      _frelst_1
[00003a46] 2e95                      move.l     (a5),(a7)
[00003a48] 2f0d                      move.l     a5,-(a7)
[00003a4a] 4eb9 0000 4b5c            jsr        _free
[00003a50] 588f                      addq.l     #4,a7
[00003a52] 2a47                      movea.l    d7,a5
[00003a54] 60e8                      bra.s      _frelst_2
_frelst_1:
[00003a56] 2e0d                      move.l     a5,d7
[00003a58] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00003a5c] 4e5e                      unlk       a6
[00003a5e] 4e75                      rts

_getenv:
[00003a60] 4e56 0000                 link       a6,#0
[00003a64] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00003a68] 2a6e 0008                 movea.l    8(a6),a5
[00003a6c] 2e8d                      move.l     a5,(a7)
[00003a6e] 4eb9 0000 5450            jsr        _lenstr
[00003a74] 2a07                      move.l     d7,d5
[00003a76] 2879 0000 5720            movea.l    $0000ADCE,a4
_getenv_4:
[00003a7c] 2e0c                      move.l     a4,d7
[00003a7e] 672e                      beq.s      _getenv_1
[00003a80] 4a94                      tst.l      (a4)
[00003a82] 672a                      beq.s      _getenv_1
[00003a84] 2e85                      move.l     d5,(a7)
[00003a86] 2f14                      move.l     (a4),-(a7)
[00003a88] 2f0d                      move.l     a5,-(a7)
[00003a8a] 4eb9 0000 425a            jsr        _cmpbuf
[00003a90] 508f                      addq.l     #8,a7
[00003a92] 4a87                      tst.l      d7
[00003a94] 6722                      beq.s      _getenv_2
[00003a96] 2454                      movea.l    (a4),a2
[00003a98] d5c5                      adda.l     d5,a2
[00003a9a] 4287                      clr.l      d7
[00003a9c] 1e12                      move.b     (a2),d7
[00003a9e] 0c47 003d                 cmpi.w     #$003D,d7
[00003aa2] 6614                      bne.s      _getenv_2
[00003aa4] 2e14                      move.l     (a4),d7
[00003aa6] 2445                      movea.l    d5,a2
[00003aa8] 528a                      addq.l     #1,a2
[00003aaa] de8a                      add.l      a2,d7
[00003aac] 6002                      bra.s      _getenv_3
_getenv_1:
[00003aae] 4287                      clr.l      d7
_getenv_3:
[00003ab0] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00003ab4] 4e5e                      unlk       a6
[00003ab6] 4e75                      rts
_getenv_2:
[00003ab8] 588c                      addq.l     #4,a4
[00003aba] 60c0                      bra.s      _getenv_4
[00003abc] 2d00                      move.l     d0,-(a6)

_getfiles:
[00003abe] 4e56 0000                 link       a6,#0
[00003ac2] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00003ac6] 2a6e 0008                 movea.l    8(a6),a5
[00003aca] 286e 000c                 movea.l    12(a6),a4
[00003ace] 4a95                      tst.l      (a5)
[00003ad0] 6c04                      bge.s      _getfiles_1
[00003ad2] 7aff                      moveq.l    #-1,d5
[00003ad4] 601e                      bra.s      _getfiles_2
_getfiles_1:
[00003ad6] 4a95                      tst.l      (a5)
[00003ad8] 6716                      beq.s      _getfiles_3
[00003ada] 2ebc 0000 3abc            move.l     #$00003ABC,(a7)
[00003ae0] 2454                      movea.l    (a4),a2
[00003ae2] 2f12                      move.l     (a2),-(a7)
[00003ae4] 4eb9 0000 4282            jsr        _cmpstr
[00003aea] 588f                      addq.l     #4,a7
[00003aec] 4a87                      tst.l      d7
[00003aee] 6710                      beq.s      _getfiles_4
_getfiles_3:
[00003af0] 2a2e 0010                 move.l     16(a6),d5
_getfiles_2:
[00003af4] 5894                      addq.l     #4,(a4)
[00003af6] 5395                      subq.l     #1,(a5)
[00003af8] 6e20                      bgt.s      _getfiles_5
[00003afa] 70ff                      moveq.l    #-1,d0
[00003afc] 2a80                      move.l     d0,(a5)
[00003afe] 601a                      bra.s      _getfiles_5
_getfiles_4:
[00003b00] 4297                      clr.l      (a7)
[00003b02] 42a7                      clr.l      -(a7)
[00003b04] 2454                      movea.l    (a4),a2
[00003b06] 2f12                      move.l     (a2),-(a7)
[00003b08] 4eb9 0000 4708            jsr        _open
[00003b0e] 508f                      addq.l     #8,a7
[00003b10] 2a07                      move.l     d7,d5
[00003b12] 6ce0                      bge.s      _getfiles_2
[00003b14] 2a2e 0014                 move.l     20(a6),d5
[00003b18] 60da                      bra.s      _getfiles_2
_getfiles_5:
[00003b1a] 2e05                      move.l     d5,d7
[00003b1c] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00003b20] 4e5e                      unlk       a6
[00003b22] 4e75                      rts

x3b24:
[00003b24] 4e56 0000                 link       a6,#0
[00003b28] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00003b2c] 2a6e 0008                 movea.l    8(a6),a5
[00003b30] 286e 000c                 movea.l    12(a6),a4
[00003b34] 4297                      clr.l      (a7)
[00003b36] 4eb9 0000 41b0            jsr        _usage
[00003b3c] 2a07                      move.l     d7,d5
x3b24_7:
[00003b3e] 4a15                      tst.b      (a5)
[00003b40] 6720                      beq.s      x3b24_1
[00003b42] 4287                      clr.l      d7
[00003b44] 1e15                      move.b     (a5),d7
[00003b46] 0c47 0046                 cmpi.w     #$0046,d7
[00003b4a] 673e                      beq.s      x3b24_2
[00003b4c] 2e85                      move.l     d5,(a7)
[00003b4e] 2f0d                      move.l     a5,-(a7)
[00003b50] 4878 0002                 pea.l      ($00000002).w
[00003b54] 4eb9 0000 4034            jsr        $00004034
[00003b5a] 508f                      addq.l     #8,a7
[00003b5c] 2a07                      move.l     d7,d5
[00003b5e] 6000 0098                 bra        x3b24_3
x3b24_1:
[00003b62] 4878 0001                 pea.l      ($00000001).w
[00003b66] 2f3c 0000 7880            move.l     #$0000CF2E,-(a7)
[00003b6c] 4878 0002                 pea.l      ($00000002).w
[00003b70] 4eb9 0000 56a6            jsr        _write
[00003b76] 4fef 000c                 lea.l      12(a7),a7
[00003b7a] 4297                      clr.l      (a7)
[00003b7c] 4eb9 0000 0080            jsr        _exit
[00003b82] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00003b86] 4e5e                      unlk       a6
[00003b88] 4e75                      rts
x3b24_2:
[00003b8a] 4878 0002                 pea.l      ($00000002).w
[00003b8e] 2f3c 0000 788a            move.l     #$0000CF38,-(a7)
[00003b94] 4878 0002                 pea.l      ($00000002).w
[00003b98] 4eb9 0000 56a6            jsr        _write
[00003b9e] 4fef 000c                 lea.l      12(a7),a7
[00003ba2] da87                      add.l      d7,d5
x3b24_9:
[00003ba4] 4287                      clr.l      d7
[00003ba6] 1e14                      move.b     (a4),d7
[00003ba8] 0c47 003a                 cmpi.w     #$003A,d7
[00003bac] 6730                      beq.s      x3b24_4
[00003bae] 4287                      clr.l      d7
[00003bb0] 1e14                      move.b     (a4),d7
[00003bb2] 0c47 002c                 cmpi.w     #$002C,d7
[00003bb6] 6646                      bne.s      x3b24_5
[00003bb8] 4287                      clr.l      d7
[00003bba] 1e2c 0001                 move.b     1(a4),d7
[00003bbe] 0c47 003a                 cmpi.w     #$003A,d7
[00003bc2] 673a                      beq.s      x3b24_5
[00003bc4] 2e85                      move.l     d5,(a7)
[00003bc6] 2f3c 0000 7888            move.l     #$0000CF36,-(a7)
[00003bcc] 4878 0002                 pea.l      ($00000002).w
[00003bd0] 4eb9 0000 4034            jsr        $00004034
[00003bd6] 508f                      addq.l     #8,a7
[00003bd8] 2a07                      move.l     d7,d5
[00003bda] 6000 0080                 bra        x3b24_6 ; possibly optimized to short
x3b24_4:
[00003bde] 4878 0001                 pea.l      ($00000001).w
[00003be2] 2f3c 0000 7882            move.l     #$0000CF30,-(a7)
[00003be8] 4878 0002                 pea.l      ($00000002).w
[00003bec] 4eb9 0000 56a6            jsr        _write
[00003bf2] 4fef 000c                 lea.l      12(a7),a7
[00003bf6] da87                      add.l      d7,d5
x3b24_3:
[00003bf8] 528d                      addq.l     #1,a5
[00003bfa] 6000 ff42                 bra        x3b24_7
x3b24_5:
[00003bfe] 4287                      clr.l      d7
[00003c00] 1e14                      move.b     (a4),d7
[00003c02] 0c47 003e                 cmpi.w     #$003E,d7
[00003c06] 663e                      bne.s      x3b24_8
[00003c08] 4878 0001                 pea.l      ($00000001).w
[00003c0c] 2f3c 0000 7886            move.l     #$0000CF34,-(a7)
[00003c12] 4878 0002                 pea.l      ($00000002).w
[00003c16] 4eb9 0000 56a6            jsr        _write
[00003c1c] 4fef 000c                 lea.l      12(a7),a7
[00003c20] da87                      add.l      d7,d5
[00003c22] 4287                      clr.l      d7
[00003c24] 1e2c 0001                 move.b     1(a4),d7
[00003c28] 0c47 003a                 cmpi.w     #$003A,d7
[00003c2c] 672e                      beq.s      x3b24_6
[00003c2e] 2e85                      move.l     d5,(a7)
[00003c30] 2f3c 0000 7884            move.l     #$0000CF32,-(a7)
[00003c36] 4878 0002                 pea.l      ($00000002).w
[00003c3a] 4eb9 0000 4034            jsr        $00004034
[00003c40] 508f                      addq.l     #8,a7
[00003c42] 2a07                      move.l     d7,d5
[00003c44] 6016                      bra.s      x3b24_6
x3b24_8:
[00003c46] 4878 0001                 pea.l      ($00000001).w
[00003c4a] 2f0c                      move.l     a4,-(a7)
[00003c4c] 4878 0002                 pea.l      ($00000002).w
[00003c50] 4eb9 0000 56a6            jsr        _write
[00003c56] 4fef 000c                 lea.l      12(a7),a7
[00003c5a] da87                      add.l      d7,d5
x3b24_6:
[00003c5c] 528c                      addq.l     #1,a4
[00003c5e] 6000 ff44                 bra        x3b24_9

_getflags:
[00003c62] 4e56 ffe2                 link       a6,#-30
[00003c66] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00003c6a] 246e 000c                 movea.l    12(a6),a2
[00003c6e] 5892                      addq.l     #4,(a2)
_getflags_3:
[00003c70] 246e 0008                 movea.l    8(a6),a2
[00003c74] 4a92                      tst.l      (a2)
[00003c76] 6730                      beq.s      _getflags_1
[00003c78] 246e 0008                 movea.l    8(a6),a2
[00003c7c] 5392                      subq.l     #1,(a2)
[00003c7e] 6728                      beq.s      _getflags_1
[00003c80] 246e 000c                 movea.l    12(a6),a2
[00003c84] 2452                      movea.l    (a2),a2
[00003c86] 2852                      movea.l    (a2),a4
[00003c88] 2ebc 0000 78d5            move.l     #$0000CF83,(a7)
[00003c8e] 2f0c                      move.l     a4,-(a7)
[00003c90] 4eb9 0000 4282            jsr        _cmpstr
[00003c96] 588f                      addq.l     #4,a7
[00003c98] 4a87                      tst.l      d7
[00003c9a] 671e                      beq.s      _getflags_2
[00003c9c] 246e 0008                 movea.l    8(a6),a2
[00003ca0] 5392                      subq.l     #1,(a2)
[00003ca2] 246e 000c                 movea.l    12(a6),a2
[00003ca6] 5892                      addq.l     #4,(a2)
_getflags_1:
[00003ca8] 4287                      clr.l      d7
[00003caa] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00003cae] 4e5e                      unlk       a6
[00003cb0] 4e75                      rts
_getflags_10:
[00003cb2] 246e 000c                 movea.l    12(a6),a2
[00003cb6] 5892                      addq.l     #4,(a2)
[00003cb8] 60b6                      bra.s      _getflags_3
_getflags_2:
[00003cba] 2ebc 0000 78d3            move.l     #$0000CF81,(a7)
[00003cc0] 2f0c                      move.l     a4,-(a7)
[00003cc2] 4eb9 0000 4282            jsr        _cmpstr
[00003cc8] 588f                      addq.l     #4,a7
[00003cca] 4a87                      tst.l      d7
[00003ccc] 66da                      bne.s      _getflags_1
[00003cce] 4287                      clr.l      d7
[00003cd0] 1e14                      move.b     (a4),d7
[00003cd2] 0c47 002d                 cmpi.w     #$002D,d7
[00003cd6] 670a                      beq.s      _getflags_4
[00003cd8] 4287                      clr.l      d7
[00003cda] 1e14                      move.b     (a4),d7
[00003cdc] 0c47 002b                 cmpi.w     #$002B,d7
[00003ce0] 66c6                      bne.s      _getflags_1
_getflags_4:
[00003ce2] 4287                      clr.l      d7
[00003ce4] 1e14                      move.b     (a4),d7
[00003ce6] 0c47 002d                 cmpi.w     #$002D,d7
[00003cea] 6602                      bne.s      _getflags_5
[00003cec] 528c                      addq.l     #1,a4
_getflags_5:
[00003cee] 4878 0004                 pea.l      ($00000004).w
[00003cf2] 2f0c                      move.l     a4,-(a7)
[00003cf4] 2f3c 0000 78ce            move.l     #$0000CF7C,-(a7)
[00003cfa] 4eb9 0000 425a            jsr        _cmpbuf
[00003d00] 4fef 000c                 lea.l      12(a7),a7
[00003d04] 4a87                      tst.l      d7
[00003d06] 6768                      beq.s      _getflags_6
[00003d08] 4878 003a                 pea.l      ($0000003A).w
[00003d0c] 2f2e 0010                 move.l     16(a6),-(a7)
[00003d10] 4eb9 0000 48be            jsr        _scnstr
[00003d16] 508f                      addq.l     #8,a7
[00003d18] 3d47 fff2                 move.w     d7,-14(a6)
[00003d1c] 3e2e fff2                 move.w     -14(a6),d7
[00003d20] 48c7                      ext.l      d7
[00003d22] 2447                      movea.l    d7,a2
[00003d24] d5ee 0010                 adda.l     16(a6),a2
[00003d28] 4a12                      tst.b      (a2)
[00003d2a] 6616                      bne.s      _getflags_7
[00003d2c] 4287                      clr.l      d7
[00003d2e] 1e2c 0004                 move.b     4(a4),d7
[00003d32] 0c47 003a                 cmpi.w     #$003A,d7
[00003d36] 670a                      beq.s      _getflags_7
[00003d38] 2e0c                      move.l     a4,d7
[00003d3a] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00003d3e] 4e5e                      unlk       a6
[00003d40] 4e75                      rts
_getflags_7:
[00003d42] 2eae 0010                 move.l     16(a6),(a7)
[00003d46] 4287                      clr.l      d7
[00003d48] 1e2c 0004                 move.b     4(a4),d7
[00003d4c] 0c47 003a                 cmpi.w     #$003A,d7
[00003d50] 670e                      beq.s      _getflags_8
[00003d52] 2e2e 0010                 move.l     16(a6),d7
[00003d56] 3c2e fff2                 move.w     -14(a6),d6
[00003d5a] 48c6                      ext.l      d6
[00003d5c] de86                      add.l      d6,d7
[00003d5e] 6006                      bra.s      _getflags_9
_getflags_8:
[00003d60] 2e3c 0000 56ae            move.l     #$0000AD5C,d7
_getflags_9:
[00003d66] 2f07                      move.l     d7,-(a7)
[00003d68] 5297                      addq.l     #1,(a7)
[00003d6a] 4eba fdb8                 jsr        $00003B24(pc)
[00003d6e] 588f                      addq.l     #4,a7
_getflags_6:
[00003d70] 4a14                      tst.b      (a4)
[00003d72] 6700 ff3e                 beq        _getflags_10
[00003d76] 42ae fff4                 clr.l      -12(a6)
[00003d7a] 42ae fff8                 clr.l      -8(a6)
[00003d7e] 45ee 0014                 lea.l      20(a6),a2
[00003d82] 2d4a ffea                 move.l     a2,-22(a6)
[00003d86] 264c                      movea.l    a4,a3
[00003d88] 2a6e 0010                 movea.l    16(a6),a5
[00003d8c] 42ae fffc                 clr.l      -4(a6)
_getflags_18:
[00003d90] 4aae fffc                 tst.l      -4(a6)
[00003d94] 66da                      bne.s      _getflags_6
[00003d96] 4287                      clr.l      d7
[00003d98] 1e15                      move.b     (a5),d7
[00003d9a] 41f9 0000 788e            lea.l      $0000CF3C,a0
[00003da0] 4ef9 0000 48e0            jmp        a.switch
[00003da6] 7001                      moveq.l    #1,d0
[00003da8] 2d40 fff4                 move.l     d0,-12(a6)
[00003dac] 4a13                      tst.b      (a3)
[00003dae] 6704                      beq.s      _getflags_11
[00003db0] 2e0b                      move.l     a3,d7
[00003db2] 6016                      bra.s      _getflags_12
_getflags_11:
[00003db4] 246e 0008                 movea.l    8(a6),a2
[00003db8] 5392                      subq.l     #1,(a2)
[00003dba] 670c                      beq.s      _getflags_13
[00003dbc] 246e 000c                 movea.l    12(a6),a2
[00003dc0] 5892                      addq.l     #4,(a2)
[00003dc2] 2452                      movea.l    (a2),a2
[00003dc4] 2e12                      move.l     (a2),d7
[00003dc6] 6002                      bra.s      _getflags_12
_getflags_13:
[00003dc8] 2e0b                      move.l     a3,d7
_getflags_12:
[00003dca] 2d47 ffe2                 move.l     d7,-30(a6)
[00003dce] 266e ffe2                 movea.l    -30(a6),a3
[00003dd2] 2d4b ffe6                 move.l     a3,-26(a6)
_getflags_17:
[00003dd6] 246e ffe6                 movea.l    -26(a6),a2
[00003dda] 4a12                      tst.b      (a2)
[00003ddc] 672e                      beq.s      _getflags_14
[00003dde] 246e ffe6                 movea.l    -26(a6),a2
[00003de2] 4287                      clr.l      d7
[00003de4] 1e12                      move.b     (a2),d7
[00003de6] 0c47 005c                 cmpi.w     #$005C,d7
[00003dea] 6610                      bne.s      _getflags_15
[00003dec] 4297                      clr.l      (a7)
[00003dee] 486e ffe6                 pea.l      -26(a6)
[00003df2] 4eb9 0000 4342            jsr        _doesc
[00003df8] 588f                      addq.l     #4,a7
[00003dfa] 6008                      bra.s      _getflags_16
_getflags_15:
[00003dfc] 246e ffe6                 movea.l    -26(a6),a2
[00003e00] 4287                      clr.l      d7
[00003e02] 1e12                      move.b     (a2),d7
_getflags_16:
[00003e04] 16c7                      move.b     d7,(a3)+
[00003e06] 52ae ffe6                 addq.l     #1,-26(a6)
[00003e0a] 60ca                      bra.s      _getflags_17
_getflags_14:
[00003e0c] 4213                      clr.b      (a3)
_getflags_19:
[00003e0e] 528d                      addq.l     #1,a5
[00003e10] 6000 ff7e                 bra        _getflags_18
[00003e14] 60f8                      bra.s      _getflags_19
[00003e16] 7001                      moveq.l    #1,d0
[00003e18] 2d40 fff4                 move.l     d0,-12(a6)
[00003e1c] 4287                      clr.l      d7
[00003e1e] 1e13                      move.b     (a3),d7
[00003e20] 0c47 005c                 cmpi.w     #$005C,d7
[00003e24] 670a                      beq.s      _getflags_20
[00003e26] 4287                      clr.l      d7
[00003e28] 1e13                      move.b     (a3),d7
[00003e2a] 2d47 ffe2                 move.l     d7,-30(a6)
[00003e2e] 601a                      bra.s      _getflags_21
_getflags_20:
[00003e30] 2d4b ffe6                 move.l     a3,-26(a6)
[00003e34] 4297                      clr.l      (a7)
[00003e36] 486e ffe6                 pea.l      -26(a6)
[00003e3a] 4eb9 0000 4342            jsr        _doesc
[00003e40] 588f                      addq.l     #4,a7
[00003e42] 2d47 ffe2                 move.l     d7,-30(a6)
[00003e46] 266e ffe6                 movea.l    -26(a6),a3
_getflags_21:
[00003e4a] 4a13                      tst.b      (a3)
[00003e4c] 67c0                      beq.s      _getflags_19
[00003e4e] 528b                      addq.l     #1,a3
[00003e50] 60bc                      bra.s      _getflags_19
[00003e52] 4a13                      tst.b      (a3)
[00003e54] 6618                      bne.s      _getflags_22
[00003e56] 246e 0008                 movea.l    8(a6),a2
[00003e5a] 5392                      subq.l     #1,(a2)
[00003e5c] 670c                      beq.s      _getflags_23
[00003e5e] 246e 000c                 movea.l    12(a6),a2
[00003e62] 5892                      addq.l     #4,(a2)
[00003e64] 2452                      movea.l    (a2),a2
[00003e66] 2e12                      move.l     (a2),d7
[00003e68] 6002                      bra.s      _getflags_24
_getflags_23:
[00003e6a] 2e0b                      move.l     a3,d7
_getflags_24:
[00003e6c] 2647                      movea.l    d7,a3
_getflags_22:
[00003e6e] 4878 0001                 pea.l      ($00000001).w
[00003e72] 486e ffee                 pea.l      -18(a6)
[00003e76] 2f0b                      move.l     a3,-(a7)
[00003e78] 4eb9 0000 5450            jsr        _lenstr
[00003e7e] 588f                      addq.l     #4,a7
[00003e80] 2f07                      move.l     d7,-(a7)
[00003e82] 2f0b                      move.l     a3,-(a7)
[00003e84] 4eb9 0000 4c1e            jsr        _btol
[00003e8a] 4fef 0010                 lea.l      16(a7),a7
[00003e8e] d7c7                      adda.l     d7,a3
[00003e90] 4a13                      tst.b      (a3)
[00003e92] 6604                      bne.s      _getflags_25
[00003e94] 7e01                      moveq.l    #1,d7
[00003e96] 6002                      bra.s      _getflags_26
_getflags_25:
[00003e98] 4287                      clr.l      d7
_getflags_26:
[00003e9a] 2d47 fff4                 move.l     d7,-12(a6)
[00003e9e] 4aae fff4                 tst.l      -12(a6)
[00003ea2] 6616                      bne.s      _getflags_27
[00003ea4] 4878 003a                 pea.l      ($0000003A).w
[00003ea8] 2f0d                      move.l     a5,-(a7)
[00003eaa] 4eb9 0000 48be            jsr        _scnstr
[00003eb0] 508f                      addq.l     #8,a7
[00003eb2] 5387                      subq.l     #1,d7
[00003eb4] dbc7                      adda.l     d7,a5
[00003eb6] 6000 ff56                 bra        _getflags_19
_getflags_27:
[00003eba] 4287                      clr.l      d7
[00003ebc] 1e2d 0001                 move.b     1(a5),d7
[00003ec0] 0c47 0023                 cmpi.w     #$0023,d7
[00003ec4] 660c                      bne.s      _getflags_28
[00003ec6] 528d                      addq.l     #1,a5
[00003ec8] 7001                      moveq.l    #1,d0
[00003eca] 2d40 fff8                 move.l     d0,-8(a6)
[00003ece] 6000 ff3e                 bra        _getflags_19
_getflags_28:
[00003ed2] 2d6e ffee ffe2            move.l     -18(a6),-30(a6)
[00003ed8] 6000 ff34                 bra        _getflags_19
[00003edc] 4aae fff4                 tst.l      -12(a6)
[00003ee0] 6712                      beq.s      _getflags_29
[00003ee2] 4aae fff8                 tst.l      -8(a6)
[00003ee6] 671a                      beq.s      _getflags_30
[00003ee8] 246e ffea                 movea.l    -22(a6),a2
[00003eec] 2452                      movea.l    (a2),a2
[00003eee] 24ae ffee                 move.l     -18(a6),(a2)
[00003ef2] 6018                      bra.s      _getflags_31
_getflags_29:
[00003ef4] 4a15                      tst.b      (a5)
[00003ef6] 6620                      bne.s      _getflags_32
[00003ef8] 2e0c                      move.l     a4,d7
[00003efa] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00003efe] 4e5e                      unlk       a6
[00003f00] 4e75                      rts
_getflags_30:
[00003f02] 246e ffea                 movea.l    -22(a6),a2
[00003f06] 2452                      movea.l    (a2),a2
[00003f08] 24ae ffe2                 move.l     -30(a6),(a2)
_getflags_31:
[00003f0c] 284b                      movea.l    a3,a4
[00003f0e] 7001                      moveq.l    #1,d0
[00003f10] 2d40 fffc                 move.l     d0,-4(a6)
[00003f14] 6000 fef8                 bra        _getflags_19
_getflags_32:
[00003f18] 4287                      clr.l      d7
[00003f1a] 1e15                      move.b     (a5),d7
[00003f1c] 0c47 003a                 cmpi.w     #$003A,d7
[00003f20] 6612                      bne.s      _getflags_33
[00003f22] 2eae 0010                 move.l     16(a6),(a7)
[00003f26] 528d                      addq.l     #1,a5
[00003f28] 2f0d                      move.l     a5,-(a7)
[00003f2a] 4eba fbf8                 jsr        $00003B24(pc)
[00003f2e] 588f                      addq.l     #4,a7
[00003f30] 6000 fedc                 bra        _getflags_19
_getflags_33:
[00003f34] 58ae ffea                 addq.l     #4,-22(a6)
[00003f38] 264c                      movea.l    a4,a3
[00003f3a] 6000 fed2                 bra        _getflags_19
[00003f3e] 4aae fff4                 tst.l      -12(a6)
[00003f42] 660a                      bne.s      _getflags_34
[00003f44] 58ae ffea                 addq.l     #4,-22(a6)
[00003f48] 264c                      movea.l    a4,a3
[00003f4a] 6000 fec2                 bra        _getflags_19
_getflags_34:
[00003f4e] 246e ffea                 movea.l    -22(a6),a2
[00003f52] 2452                      movea.l    (a2),a2
[00003f54] 4a92                      tst.l      (a2)
[00003f56] 663c                      bne.s      _getflags_35
[00003f58] 4878 003a                 pea.l      ($0000003A).w
[00003f5c] 2f0d                      move.l     a5,-(a7)
[00003f5e] 4eb9 0000 48be            jsr        _scnstr
[00003f64] 508f                      addq.l     #8,a7
[00003f66] 3d47 fff2                 move.w     d7,-14(a6)
[00003f6a] 3e2e fff2                 move.w     -14(a6),d7
[00003f6e] 48c7                      ext.l      d7
[00003f70] 2447                      movea.l    d7,a2
[00003f72] d5cd                      adda.l     a5,a2
[00003f74] 4a12                      tst.b      (a2)
[00003f76] 673e                      beq.s      _getflags_36
[00003f78] 2eae 0010                 move.l     16(a6),(a7)
[00003f7c] 3e2e fff2                 move.w     -14(a6),d7
[00003f80] 48c7                      ext.l      d7
[00003f82] 45ed 0001                 lea.l      1(a5),a2
[00003f86] de8a                      add.l      a2,d7
[00003f88] 2f07                      move.l     d7,-(a7)
[00003f8a] 4eba fb98                 jsr        $00003B24(pc)
[00003f8e] 588f                      addq.l     #4,a7
[00003f90] 6000 fe7c                 bra        _getflags_19
_getflags_35:
[00003f94] 4aae fff8                 tst.l      -8(a6)
[00003f98] 6726                      beq.s      _getflags_37
[00003f9a] 246e ffea                 movea.l    -22(a6),a2
[00003f9e] 2452                      movea.l    (a2),a2
[00003fa0] 5392                      subq.l     #1,(a2)
[00003fa2] 2e12                      move.l     (a2),d7
[00003fa4] e587                      asl.l      #2,d7
[00003fa6] 246e ffea                 movea.l    -22(a6),a2
[00003faa] 2452                      movea.l    (a2),a2
[00003fac] 588a                      addq.l     #4,a2
[00003fae] d5c7                      adda.l     d7,a2
[00003fb0] 24ae ffee                 move.l     -18(a6),(a2)
[00003fb4] 6024                      bra.s      _getflags_38
_getflags_36:
[00003fb6] 2e0c                      move.l     a4,d7
[00003fb8] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00003fbc] 4e5e                      unlk       a6
[00003fbe] 4e75                      rts
_getflags_37:
[00003fc0] 246e ffea                 movea.l    -22(a6),a2
[00003fc4] 2452                      movea.l    (a2),a2
[00003fc6] 5392                      subq.l     #1,(a2)
[00003fc8] 2e12                      move.l     (a2),d7
[00003fca] e587                      asl.l      #2,d7
[00003fcc] 246e ffea                 movea.l    -22(a6),a2
[00003fd0] 2452                      movea.l    (a2),a2
[00003fd2] 588a                      addq.l     #4,a2
[00003fd4] d5c7                      adda.l     d7,a2
[00003fd6] 24ae ffe2                 move.l     -30(a6),(a2)
_getflags_38:
[00003fda] 284b                      movea.l    a3,a4
[00003fdc] 7001                      moveq.l    #1,d0
[00003fde] 2d40 fffc                 move.l     d0,-4(a6)
[00003fe2] 6000 fe2a                 bra        _getflags_19
[00003fe6] 4287                      clr.l      d7
[00003fe8] 1e15                      move.b     (a5),d7
[00003fea] 4286                      clr.l      d6
[00003fec] 1c13                      move.b     (a3),d6
[00003fee] be86                      cmp.l      d6,d7
[00003ff0] 6612                      bne.s      _getflags_39
[00003ff2] 7001                      moveq.l    #1,d0
[00003ff4] 2d40 fff4                 move.l     d0,-12(a6)
[00003ff8] 7001                      moveq.l    #1,d0
[00003ffa] 2d40 ffe2                 move.l     d0,-30(a6)
[00003ffe] 528b                      addq.l     #1,a3
[00004000] 6000 fe0c                 bra        _getflags_19
_getflags_39:
[00004004] 42ae fff4                 clr.l      -12(a6)
_getflags_41:
[00004008] 4a15                      tst.b      (a5)
[0000400a] 6722                      beq.s      _getflags_40
[0000400c] 4287                      clr.l      d7
[0000400e] 1e15                      move.b     (a5),d7
[00004010] 0c47 002c                 cmpi.w     #$002C,d7
[00004014] 6718                      beq.s      _getflags_40
[00004016] 4287                      clr.l      d7
[00004018] 1e15                      move.b     (a5),d7
[0000401a] 0c47 003e                 cmpi.w     #$003E,d7
[0000401e] 670e                      beq.s      _getflags_40
[00004020] 4287                      clr.l      d7
[00004022] 1e15                      move.b     (a5),d7
[00004024] 0c47 003a                 cmpi.w     #$003A,d7
[00004028] 6704                      beq.s      _getflags_40
[0000402a] 528d                      addq.l     #1,a5
[0000402c] 60da                      bra.s      _getflags_41
_getflags_40:
[0000402e] 538d                      subq.l     #1,a5
[00004030] 6000 fddc                 bra        _getflags_19
[00004034] 4e56 0000                 link       a6,#0
[00004038] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[0000403c] 2a2e 0008                 move.l     8(a6),d5
[00004040] 2a6e 000c                 movea.l    12(a6),a5
[00004044] 282e 0010                 move.l     16(a6),d4
[00004048] 0c84 0000 003c            cmpi.l     #$0000003C,d4
[0000404e] 6f14                      ble.s      _getflags_42
[00004050] 4287                      clr.l      d7
[00004052] 1e15                      move.b     (a5),d7
[00004054] 0c47 0020                 cmpi.w     #$0020,d7
[00004058] 6724                      beq.s      _getflags_43
[0000405a] 4287                      clr.l      d7
[0000405c] 1e15                      move.b     (a5),d7
[0000405e] 0c47 0009                 cmpi.w     #$0009,d7
[00004062] 671a                      beq.s      _getflags_43
_getflags_42:
[00004064] 4878 0001                 pea.l      ($00000001).w
[00004068] 2f0d                      move.l     a5,-(a7)
[0000406a] 2f05                      move.l     d5,-(a7)
[0000406c] 4eb9 0000 56a6            jsr        _write
[00004072] 4fef 000c                 lea.l      12(a7),a7
[00004076] 2444                      movea.l    d4,a2
[00004078] 528a                      addq.l     #1,a2
[0000407a] 2e0a                      move.l     a2,d7
[0000407c] 6018                      bra.s      _getflags_44
_getflags_43:
[0000407e] 4878 0002                 pea.l      ($00000002).w
[00004082] 2f3c 0000 78d8            move.l     #$0000CF86,-(a7)
[00004088] 2f05                      move.l     d5,-(a7)
[0000408a] 4eb9 0000 56a6            jsr        _write
[00004090] 4fef 000c                 lea.l      12(a7),a7
[00004094] 7e04                      moveq.l    #4,d7
_getflags_44:
[00004096] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[0000409a] 4e5e                      unlk       a6
[0000409c] 4e75                      rts

_inbuf:
[0000409e] 4e56 0000                 link       a6,#0
[000040a2] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000040a6] 2a2e 000c                 move.l     12(a6),d5
[000040aa] 2a6e 0008                 movea.l    8(a6),a5
_inbuf_5:
[000040ae] 4a85                      tst.l      d5
[000040b0] 6718                      beq.s      _inbuf_1
[000040b2] 286e 0010                 movea.l    16(a6),a4
_inbuf_4:
[000040b6] 4287                      clr.l      d7
[000040b8] 1e15                      move.b     (a5),d7
[000040ba] 4286                      clr.l      d6
[000040bc] 1c14                      move.b     (a4),d6
[000040be] be86                      cmp.l      d6,d7
[000040c0] 6616                      bne.s      _inbuf_2
[000040c2] 2e0d                      move.l     a5,d7
[000040c4] 9eae 0008                 sub.l      8(a6),d7
[000040c8] 6006                      bra.s      _inbuf_3
_inbuf_1:
[000040ca] 2e0d                      move.l     a5,d7
[000040cc] 9eae 0008                 sub.l      8(a6),d7
_inbuf_3:
[000040d0] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000040d4] 4e5e                      unlk       a6
[000040d6] 4e75                      rts
_inbuf_2:
[000040d8] 528c                      addq.l     #1,a4
[000040da] 4a14                      tst.b      (a4)
[000040dc] 66d8                      bne.s      _inbuf_4
[000040de] 5385                      subq.l     #1,d5
[000040e0] 528d                      addq.l     #1,a5
[000040e2] 60ca                      bra.s      _inbuf_5

_itob:
[000040e4] 4e56 0000                 link       a6,#0
[000040e8] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000040ec] 2a6e 0008                 movea.l    8(a6),a5
[000040f0] 284d                      movea.l    a5,a4
[000040f2] 4aae 000c                 tst.l      12(a6)
[000040f6] 6c14                      bge.s      _itob_1
[000040f8] 4aae 0010                 tst.l      16(a6)
[000040fc] 6e0e                      bgt.s      _itob_1
[000040fe] 2e2e 000c                 move.l     12(a6),d7
[00004102] 4487                      neg.l      d7
[00004104] 2a07                      move.l     d7,d5
[00004106] 18fc 002d                 move.b     #$2D,(a4)+
[0000410a] 6004                      bra.s      _itob_2
_itob_1:
[0000410c] 2a2e 000c                 move.l     12(a6),d5
_itob_2:
[00004110] 4aae 0010                 tst.l      16(a6)
[00004114] 6608                      bne.s      _itob_3
[00004116] 700a                      moveq.l    #10,d0
[00004118] 2d40 0010                 move.l     d0,16(a6)
[0000411c] 6010                      bra.s      _itob_4
_itob_3:
[0000411e] 4aae 0010                 tst.l      16(a6)
[00004122] 6c0a                      bge.s      _itob_4
[00004124] 2e2e 0010                 move.l     16(a6),d7
[00004128] 4487                      neg.l      d7
[0000412a] 2d47 0010                 move.l     d7,16(a6)
_itob_4:
[0000412e] 2e2e 0010                 move.l     16(a6),d7
[00004132] be85                      cmp.l      d5,d7
[00004134] 621a                      bhi.s      _itob_5
[00004136] 2eae 0010                 move.l     16(a6),(a7)
[0000413a] 2f05                      move.l     d5,-(a7)
[0000413c] 2f2e 0010                 move.l     16(a6),-(a7)
[00004140] 4eb9 0000 48fa            jsr        a.uldiv
[00004146] 2f0c                      move.l     a4,-(a7)
[00004148] 4eba ff9a                 jsr        _itob(pc)
[0000414c] 508f                      addq.l     #8,a7
[0000414e] d9c7                      adda.l     d7,a4
_itob_5:
[00004150] 7e30                      moveq.l    #48,d7
[00004152] 2e85                      move.l     d5,(a7)
[00004154] 2f2e 0010                 move.l     16(a6),-(a7)
[00004158] 4eb9 0000 48f2            jsr        a.ulmod
[0000415e] de97                      add.l      (a7),d7
[00004160] 1887                      move.b     d7,(a4)
[00004162] 4287                      clr.l      d7
[00004164] 1e14                      move.b     (a4),d7
[00004166] 0c47 0039                 cmpi.w     #$0039,d7
[0000416a] 6304                      bls.s      _itob_6
[0000416c] 0614 0027                 addi.b     #$27,(a4)
_itob_6:
[00004170] 2e0c                      move.l     a4,d7
[00004172] 9e8d                      sub.l      a5,d7
[00004174] 5287                      addq.l     #1,d7
[00004176] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000417a] 4e5e                      unlk       a6
[0000417c] 4e75                      rts

_putlin:
[0000417e] 4e56 0000                 link       a6,#0
[00004182] 48e7 8004                 movem.l    d0/a5,-(a7)
[00004186] 2a6e 0008                 movea.l    8(a6),a5
[0000418a] 2eae 000c                 move.l     12(a6),(a7)
[0000418e] 2f0d                      move.l     a5,-(a7)
[00004190] 2f3c 0000 78dc            move.l     #$0000CF8A,-(a7)
[00004196] 4eb9 0000 47c8            jsr        _putl
[0000419c] 508f                      addq.l     #8,a7
[0000419e] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000041a2] 4e5e                      unlk       a6
[000041a4] 4e75                      rts

x41a6:
[000041a6] 2000                      move.l     d0,d0
[000041a8] 7573                      ???
[000041aa] 6167                      bsr.s      $00004213 ; ; branch to odd address
[000041ac] 653a                      bcs.s      x41a6_1
[000041ae] 2000                      move.l     d0,d0
x41a6_1: ; not found: 000041e8

_usage:
[000041b0] 4e56 0000                 link       a6,#0
[000041b4] 48e7 8400                 movem.l    d0/d5,-(a7)
[000041b8] 4285                      clr.l      d5
[000041ba] 4297                      clr.l      (a7)
[000041bc] 2f2e 0008                 move.l     8(a6),-(a7)
[000041c0] 2f3c 0000 41a6            move.l     #$000041A6,-(a7)
[000041c6] 2f39 0000 6216            move.l     $0000B8C4,-(a7)
[000041cc] 2f3c 0000 41a8            move.l     #$000041A8,-(a7)
[000041d2] 4878 0002                 pea.l      ($00000002).w
[000041d6] 4eb9 0000 5188            jsr        _putstr
[000041dc] 4fef 0014                 lea.l      20(a7),a7
[000041e0] 4aae 0008                 tst.l      8(a6)
[000041e4] 6726                      beq.s      _usage_1
[000041e6] 2eae 0008                 move.l     8(a6),(a7)
[000041ea] 4eb9 0000 5450            jsr        _lenstr
[000041f0] 2a07                      move.l     d7,d5
[000041f2] 2445                      movea.l    d5,a2
[000041f4] 538a                      subq.l     #1,a2
[000041f6] d5ee 0008                 adda.l     8(a6),a2
[000041fa] 4287                      clr.l      d7
[000041fc] 1e12                      move.b     (a2),d7
[000041fe] 0c47 000a                 cmpi.w     #$000A,d7
[00004202] 6608                      bne.s      _usage_1
[00004204] 4297                      clr.l      (a7)
[00004206] 4eb9 0000 0080            jsr        _exit
_usage_1:
[0000420c] 2eb9 0000 6216            move.l     $0000B8C4,(a7)
[00004212] 4eb9 0000 5450            jsr        _lenstr
[00004218] 2445                      movea.l    d5,a2
[0000421a] 508a                      addq.l     #8,a2
[0000421c] de8a                      add.l      a2,d7
[0000421e] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00004222] 4e5e                      unlk       a6
[00004224] 4e75                      rts

_buybuf:
[00004226] 4e56 0000                 link       a6,#0
[0000422a] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[0000422e] 2a6e 0008                 movea.l    8(a6),a5
[00004232] 2a2e 000c                 move.l     12(a6),d5
[00004236] 4297                      clr.l      (a7)
[00004238] 2f05                      move.l     d5,-(a7)
[0000423a] 4eb9 0000 49de            jsr        _alloc
[00004240] 588f                      addq.l     #4,a7
[00004242] 2647                      movea.l    d7,a3
[00004244] 284b                      movea.l    a3,a4
_buybuf_2:
[00004246] 4a85                      tst.l      d5
[00004248] 6706                      beq.s      _buybuf_1
[0000424a] 18dd                      move.b     (a5)+,(a4)+
[0000424c] 5385                      subq.l     #1,d5
[0000424e] 60f6                      bra.s      _buybuf_2
_buybuf_1:
[00004250] 2e0b                      move.l     a3,d7
[00004252] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[00004256] 4e5e                      unlk       a6
[00004258] 4e75                      rts

_cmpbuf:
[0000425a] 202f 000c                 move.l     12(a7),d0
[0000425e] 671a                      beq.s      _cmpbuf_1
[00004260] 2200                      move.l     d0,d1
[00004262] 4840                      swap       d0
[00004264] 5341                      subq.w     #1,d1
[00004266] 206f 0004                 movea.l    4(a7),a0
[0000426a] 226f 0008                 movea.l    8(a7),a1
_cmpbuf_2:
[0000426e] b308                      cmpm.b     (a0)+,(a1)+
[00004270] 56c9 fffc                 dbne       d1,_cmpbuf_2
[00004274] 56c8 fff8                 dbne       d0,_cmpbuf_2
[00004278] 6604                      bne.s      _cmpbuf_3
_cmpbuf_1:
[0000427a] 7e01                      moveq.l    #1,d7
[0000427c] 4e75                      rts
_cmpbuf_3:
[0000427e] 7e00                      moveq.l    #0,d7
[00004280] 4e75                      rts

_cmpstr:
[00004282] 206f 0004                 movea.l    4(a7),a0
[00004286] 226f 0008                 movea.l    8(a7),a1
_cmpstr_2:
[0000428a] 1019                      move.b     (a1)+,d0
[0000428c] b018                      cmp.b      (a0)+,d0
[0000428e] 6608                      bne.s      _cmpstr_1
[00004290] 4a00                      tst.b      d0
[00004292] 66f6                      bne.s      _cmpstr_2
[00004294] 7e01                      moveq.l    #1,d7
[00004296] 4e75                      rts
_cmpstr_1:
[00004298] 7e00                      moveq.l    #0,d7
[0000429a] 4e75                      rts

_cpystr:
[0000429c] 2f0a                      move.l     a2,-(a7)
[0000429e] 206f 0008                 movea.l    8(a7),a0
[000042a2] 45ef 000c                 lea.l      12(a7),a2
_cpystr_2:
[000042a6] 225a                      movea.l    (a2)+,a1
[000042a8] 2009                      move.l     a1,d0
[000042aa] 6606                      bne.s      _cpystr_1
[000042ac] 2e08                      move.l     a0,d7
[000042ae] 245f                      movea.l    (a7)+,a2
[000042b0] 4e75                      rts
_cpystr_1:
[000042b2] 10d9                      move.b     (a1)+,(a0)+
[000042b4] 66fc                      bne.s      _cpystr_1
[000042b6] 5388                      subq.l     #1,a0
[000042b8] 60ec                      bra.s      _cpystr_2

_create:
[000042ba] 4e56 0000                 link       a6,#0
[000042be] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000042c2] 4eb9 0000 4936            jsr        _uname
[000042c8] 2a47                      movea.l    d7,a5
[000042ca] 286e 0008                 movea.l    8(a6),a4
_create_2:
[000042ce] 4a15                      tst.b      (a5)
[000042d0] 6710                      beq.s      _create_1
[000042d2] 4287                      clr.l      d7
[000042d4] 1e1c                      move.b     (a4)+,d7
[000042d6] 4286                      clr.l      d6
[000042d8] 1c15                      move.b     (a5),d6
[000042da] be86                      cmp.l      d6,d7
[000042dc] 6604                      bne.s      _create_1
[000042de] 528d                      addq.l     #1,a5
[000042e0] 60ec                      bra.s      _create_2
_create_1:
[000042e2] 4a15                      tst.b      (a5)
[000042e4] 6708                      beq.s      _create_3
[000042e6] 2e3c 0000 01b6            move.l     #$000001B6,d7
[000042ec] 6006                      bra.s      _create_4
_create_3:
[000042ee] 2e3c 0000 0180            move.l     #$00000180,d7
_create_4:
[000042f4] 2e87                      move.l     d7,(a7)
[000042f6] 2f2e 0008                 move.l     8(a6),-(a7)
[000042fa] 4eb9 0000 4e7e            jsr        _creat
[00004300] 588f                      addq.l     #4,a7
[00004302] 2a07                      move.l     d7,d5
[00004304] 6d0a                      blt.s      _create_5
[00004306] 0cae 0000 0001 000c       cmpi.l     #$00000001,12(a6)
[0000430e] 6604                      bne.s      _create_6
_create_5:
[00004310] 2e05                      move.l     d5,d7
[00004312] 6018                      bra.s      _create_7
_create_6:
[00004314] 2e85                      move.l     d5,(a7)
[00004316] 4eb9 0000 4e54            jsr        _close
[0000431c] 2eae 000c                 move.l     12(a6),(a7)
[00004320] 2f2e 0008                 move.l     8(a6),-(a7)
[00004324] 4eb9 0000 4708            jsr        _open
[0000432a] 588f                      addq.l     #4,a7
_create_7:
[0000432c] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00004330] 4e5e                      unlk       a6
[00004332] 4e75                      rts

x4334:
[00004334] 080c 0a0d                 btst       #2573,a4
[00004338] 090b 0062                 movep.w    98(a3),d4
[0000433c] 666e                      bne.s      x4334_1
[0000433e] 7274                      moveq.l    #116,d1
[00004340] 7600                      moveq.l    #0,d3
x4334_1: ; not found: 000043ac

_doesc:
[00004342] 4e56 0000                 link       a6,#0
[00004346] 48e7 9c0c                 movem.l    d0/d3-d5/a4-a5,-(a7)
[0000434a] 246e 0008                 movea.l    8(a6),a2
[0000434e] 2e12                      move.l     (a2),d7
[00004350] 5287                      addq.l     #1,d7
[00004352] 2a47                      movea.l    d7,a5
[00004354] 4a15                      tst.b      (a5)
[00004356] 6612                      bne.s      _doesc_1
[00004358] 246e 0008                 movea.l    8(a6),a2
[0000435c] 2452                      movea.l    (a2),a2
[0000435e] 4287                      clr.l      d7
[00004360] 1e12                      move.b     (a2),d7
[00004362] 4cdf 3039                 movem.l    (a7)+,d0/d3-d5/a4-a5
[00004366] 4e5e                      unlk       a6
[00004368] 4e75                      rts
_doesc_1:
[0000436a] 4287                      clr.l      d7
[0000436c] 1e15                      move.b     (a5),d7
[0000436e] 0c47 0030                 cmpi.w     #$0030,d7
[00004372] 6540                      bcs.s      _doesc_2
[00004374] 4287                      clr.l      d7
[00004376] 1e15                      move.b     (a5),d7
[00004378] 0c47 0039                 cmpi.w     #$0039,d7
[0000437c] 6236                      bhi.s      _doesc_2
[0000437e] 4285                      clr.l      d5
[00004380] 7801                      moveq.l    #1,d4
_doesc_4:
[00004382] 4287                      clr.l      d7
[00004384] 1e15                      move.b     (a5),d7
[00004386] 0c47 0030                 cmpi.w     #$0030,d7
[0000438a] 6578                      bcs.s      _doesc_3
[0000438c] 4287                      clr.l      d7
[0000438e] 1e15                      move.b     (a5),d7
[00004390] 0c47 0039                 cmpi.w     #$0039,d7
[00004394] 626e                      bhi.s      _doesc_3
[00004396] 0c84 0000 0003            cmpi.l     #$00000003,d4
[0000439c] 6e66                      bgt.s      _doesc_3
[0000439e] 7ed0                      moveq.l    #-48,d7
[000043a0] 2c05                      move.l     d5,d6
[000043a2] e786                      asl.l      #3,d6
[000043a4] 4283                      clr.l      d3
[000043a6] 1615                      move.b     (a5),d3
[000043a8] dc83                      add.l      d3,d6
[000043aa] de86                      add.l      d6,d7
[000043ac] 2a07                      move.l     d7,d5
[000043ae] 528d                      addq.l     #1,a5
[000043b0] 5284                      addq.l     #1,d4
[000043b2] 60ce                      bra.s      _doesc_4
_doesc_2:
[000043b4] 4287                      clr.l      d7
[000043b6] 1e15                      move.b     (a5),d7
[000043b8] 0c47 0041                 cmpi.w     #$0041,d7
[000043bc] 6514                      bcs.s      _doesc_5
[000043be] 4287                      clr.l      d7
[000043c0] 1e15                      move.b     (a5),d7
[000043c2] 0c47 005a                 cmpi.w     #$005A,d7
[000043c6] 620a                      bhi.s      _doesc_5
[000043c8] 7e20                      moveq.l    #32,d7
[000043ca] 4286                      clr.l      d6
[000043cc] 1c15                      move.b     (a5),d6
[000043ce] de86                      add.l      d6,d7
[000043d0] 6004                      bra.s      _doesc_6
_doesc_5:
[000043d2] 4287                      clr.l      d7
[000043d4] 1e15                      move.b     (a5),d7
_doesc_6:
[000043d6] 2e87                      move.l     d7,(a7)
[000043d8] 2f3c 0000 433b            move.l     #$0000433B,-(a7)
[000043de] 4eb9 0000 48be            jsr        _scnstr
[000043e4] 588f                      addq.l     #4,a7
[000043e6] 2a07                      move.l     d7,d5
[000043e8] 0c85 0000 0005            cmpi.l     #$00000005,d5
[000043ee] 6c28                      bge.s      _doesc_7
[000043f0] 246e 0008                 movea.l    8(a6),a2
[000043f4] 248d                      move.l     a5,(a2)
[000043f6] 2445                      movea.l    d5,a2
[000043f8] d5fc 0000 4334            adda.l     #$00004334,a2
[000043fe] 4287                      clr.l      d7
[00004400] 1e12                      move.b     (a2),d7
[00004402] 600c                      bra.s      _doesc_8
_doesc_3:
[00004404] 246e 0008                 movea.l    8(a6),a2
[00004408] 49ed ffff                 lea.l      -1(a5),a4
[0000440c] 248c                      move.l     a4,(a2)
[0000440e] 2e05                      move.l     d5,d7
_doesc_8:
[00004410] 4cdf 3039                 movem.l    (a7)+,d0/d3-d5/a4-a5
[00004414] 4e5e                      unlk       a6
[00004416] 4e75                      rts
_doesc_7:
[00004418] 4aae 000c                 tst.l      12(a6)
[0000441c] 672a                      beq.s      _doesc_9
[0000441e] 4287                      clr.l      d7
[00004420] 1e15                      move.b     (a5),d7
[00004422] 2e87                      move.l     d7,(a7)
[00004424] 2f2e 000c                 move.l     12(a6),-(a7)
[00004428] 4eb9 0000 48be            jsr        _scnstr
[0000442e] 588f                      addq.l     #4,a7
[00004430] 2a07                      move.l     d7,d5
[00004432] 2445                      movea.l    d5,a2
[00004434] d5ee 000c                 adda.l     12(a6),a2
[00004438] 4a12                      tst.b      (a2)
[0000443a] 670c                      beq.s      _doesc_9
[0000443c] 246e 0008                 movea.l    8(a6),a2
[00004440] 248d                      move.l     a5,(a2)
[00004442] 7eff                      moveq.l    #-1,d7
[00004444] 9e85                      sub.l      d5,d7
[00004446] 60c8                      bra.s      _doesc_8
_doesc_9:
[00004448] 246e 0008                 movea.l    8(a6),a2
[0000444c] 248d                      move.l     a5,(a2)
[0000444e] 4287                      clr.l      d7
[00004450] 1e15                      move.b     (a5),d7
[00004452] 60bc                      bra.s      _doesc_8
[00004454] 4e56 0000                 link       a6,#0
[00004458] 48e7 8004                 movem.l    d0/a5,-(a7)
[0000445c] 2a79 0000 7ae6            movea.l    $0000D194,a5
_doesc_12:
[00004462] 2e0d                      move.l     a5,d7
[00004464] 6722                      beq.s      _doesc_10
[00004466] 4a6d 0002                 tst.w      2(a5)
[0000446a] 6f2a                      ble.s      _doesc_11
[0000446c] 3e2d 0002                 move.w     2(a5),d7
[00004470] 48c7                      ext.l      d7
[00004472] 2e87                      move.l     d7,(a7)
[00004474] 486d 000a                 pea.l      10(a5)
[00004478] 3e15                      move.w     (a5),d7
[0000447a] 48c7                      ext.l      d7
[0000447c] 2f07                      move.l     d7,-(a7)
[0000447e] 4eb9 0000 56a6            jsr        _write
[00004484] 508f                      addq.l     #8,a7
[00004486] 600e                      bra.s      _doesc_11
_doesc_10:
[00004488] 2e39 0000 7aea            move.l     $0000D198,d7
[0000448e] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00004492] 4e5e                      unlk       a6
[00004494] 4e75                      rts
_doesc_11:
[00004496] 2a6d 0006                 movea.l    6(a5),a5
[0000449a] 60c6                      bra.s      _doesc_12

_finit:
[0000449c] 4e56 0000                 link       a6,#0
[000044a0] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[000044a4] 2a6e 0008                 movea.l    8(a6),a5
[000044a8] 2a2e 0010                 move.l     16(a6),d5
[000044ac] 2e0d                      move.l     a5,d7
[000044ae] 6610                      bne.s      _finit_1
[000044b0] 2ebc 0000 7b0e            move.l     #$0000D1BC,(a7)
[000044b6] 42a7                      clr.l      -(a7)
[000044b8] 4eb9 0000 5462            jsr        __raise
[000044be] 588f                      addq.l     #4,a7
_finit_1:
[000044c0] 3aae 000e                 move.w     14(a6),(a5)
[000044c4] 426d 0002                 clr.w      2(a5)
[000044c8] 0c85 0000 0001            cmpi.l     #$00000001,d5
[000044ce] 661c                      bne.s      _finit_2
[000044d0] 4878 0001                 pea.l      ($00000001).w
[000044d4] 42a7                      clr.l      -(a7)
[000044d6] 2f2e 000c                 move.l     12(a6),-(a7)
[000044da] 4eb9 0000 468e            jsr        _lseek
[000044e0] 4fef 000c                 lea.l      12(a7),a7
[000044e4] 4a87                      tst.l      d7
[000044e6] 6d04                      blt.s      _finit_2
[000044e8] 7eff                      moveq.l    #-1,d7
[000044ea] 6002                      bra.s      _finit_3
_finit_2:
[000044ec] 2e05                      move.l     d5,d7
_finit_3:
[000044ee] 3b47 0004                 move.w     d7,4(a5)
[000044f2] 0c85 0000 0001            cmpi.l     #$00000001,d5
[000044f8] 6708                      beq.s      _finit_4
[000044fa] 0c85 ffff ffff            cmpi.l     #$FFFFFFFF,d5
[00004500] 6628                      bne.s      _finit_5
_finit_4:
[00004502] 2b79 0000 7ae6 0006       move.l     $0000D194,6(a5)
[0000450a] 23cd 0000 7ae6            move.l     a5,$0000D194
[00004510] 4ab9 0000 7aea            tst.l      $0000D198
[00004516] 6612                      bne.s      _finit_5
[00004518] 2ebc 0000 4454            move.l     #$00004454,(a7)
[0000451e] 4eb9 0000 00aa            jsr        _onexit
[00004524] 23c7 0000 7aea            move.l     d7,$0000D198
_finit_5:
[0000452a] 2e0d                      move.l     a5,d7
[0000452c] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00004530] 4e5e                      unlk       a6
[00004532] 4e75                      rts

_getl:
[00004534] 4e56 0000                 link       a6,#0
[00004538] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000453c] 2a6e 0008                 movea.l    8(a6),a5
[00004540] 286e 000c                 movea.l    12(a6),a4
[00004544] 2e0d                      move.l     a5,d7
[00004546] 6610                      bne.s      _getl_1
[00004548] 2ebc 0000 7b0e            move.l     #$0000D1BC,(a7)
[0000454e] 42a7                      clr.l      -(a7)
[00004550] 4eb9 0000 5462            jsr        __raise
[00004556] 588f                      addq.l     #4,a7
_getl_1:
[00004558] 4285                      clr.l      d5
_getl_7:
[0000455a] 4a6d 0002                 tst.w      2(a5)
[0000455e] 663a                      bne.s      _getl_2
[00004560] 2ebc 0000 0200            move.l     #$00000200,(a7)
[00004566] 45ed 000a                 lea.l      10(a5),a2
[0000456a] 2b4a 0006                 move.l     a2,6(a5)
[0000456e] 2f2d 0006                 move.l     6(a5),-(a7)
[00004572] 3e15                      move.w     (a5),d7
[00004574] 48c7                      ext.l      d7
[00004576] 2f07                      move.l     d7,-(a7)
[00004578] 4eb9 0000 48aa            jsr        _read
[0000457e] 508f                      addq.l     #8,a7
[00004580] 3b47 0002                 move.w     d7,2(a5)
[00004584] 4a6d 0002                 tst.w      2(a5)
[00004588] 6c10                      bge.s      _getl_2
[0000458a] 2ebc 0000 7aee            move.l     #$0000D19C,(a7)
[00004590] 42a7                      clr.l      -(a7)
[00004592] 4eb9 0000 5462            jsr        __raise
[00004598] 588f                      addq.l     #4,a7
_getl_2:
[0000459a] 4a6d 0002                 tst.w      2(a5)
[0000459e] 6e0a                      bgt.s      _getl_3
[000045a0] 3b7c ffff 0002            move.w     #$FFFF,2(a5)
[000045a6] 2e05                      move.l     d5,d7
[000045a8] 6028                      bra.s      _getl_4
_getl_3:
[000045aa] baae 0010                 cmp.l      16(a6),d5
[000045ae] 642a                      bcc.s      _getl_5
[000045b0] 4a6d 0002                 tst.w      2(a5)
[000045b4] 6f24                      ble.s      _getl_5
[000045b6] 5285                      addq.l     #1,d5
[000045b8] 536d 0002                 subq.w     #1,2(a5)
[000045bc] 246d 0006                 movea.l    6(a5),a2
[000045c0] 52ad 0006                 addq.l     #1,6(a5)
[000045c4] 1892                      move.b     (a2),(a4)
[000045c6] 4287                      clr.l      d7
[000045c8] 1e14                      move.b     (a4),d7
[000045ca] 0c47 000a                 cmpi.w     #$000A,d7
[000045ce] 6618                      bne.s      _getl_6
[000045d0] 2e05                      move.l     d5,d7
_getl_4:
[000045d2] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000045d6] 4e5e                      unlk       a6
[000045d8] 4e75                      rts
_getl_5:
[000045da] 2e2e 0010                 move.l     16(a6),d7
[000045de] be85                      cmp.l      d5,d7
[000045e0] 6200 ff78                 bhi        _getl_7
[000045e4] 2e05                      move.l     d5,d7
[000045e6] 60ea                      bra.s      _getl_4
_getl_6:
[000045e8] 528c                      addq.l     #1,a4
[000045ea] 60be                      bra.s      _getl_3

_instr:
[000045ec] 4e56 0000                 link       a6,#0
[000045f0] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000045f4] 2a6e 0008                 movea.l    8(a6),a5
_instr_5:
[000045f8] 4a15                      tst.b      (a5)
[000045fa] 671c                      beq.s      _instr_1
[000045fc] 286e 000c                 movea.l    12(a6),a4
_instr_6:
[00004600] 4a14                      tst.b      (a4)
[00004602] 6722                      beq.s      _instr_2
[00004604] 4287                      clr.l      d7
[00004606] 1e15                      move.b     (a5),d7
[00004608] 4286                      clr.l      d6
[0000460a] 1c14                      move.b     (a4),d6
[0000460c] be86                      cmp.l      d6,d7
[0000460e] 661a                      bne.s      _instr_3
[00004610] 2e0d                      move.l     a5,d7
[00004612] 9eae 0008                 sub.l      8(a6),d7
[00004616] 6006                      bra.s      _instr_4
_instr_1:
[00004618] 2e0d                      move.l     a5,d7
[0000461a] 9eae 0008                 sub.l      8(a6),d7
_instr_4:
[0000461e] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00004622] 4e5e                      unlk       a6
[00004624] 4e75                      rts
_instr_2:
[00004626] 528d                      addq.l     #1,a5
[00004628] 60ce                      bra.s      _instr_5
_instr_3:
[0000462a] 528c                      addq.l     #1,a4
[0000462c] 60d2                      bra.s      _instr_6

a.lmod:
[0000462e] 48e7 7c00                 movem.l    d1-d5,-(a7)
[00004632] 3a3c ff00                 move.w     #$FF00,d5
[00004636] 282f 0018                 move.l     24(a7),d4
[0000463a] 6c14                      bge.s      a.lmod_1
[0000463c] 4484                      neg.l      d4
[0000463e] 6010                      bra.s      a.lmod_1
a.lmod_1: ; not found: 00004650

a.ldiv:
[00004640] 48e7 7c00                 movem.l    d1-d5,-(a7)
[00004644] 4245                      clr.w      d5
[00004646] 282f 0018                 move.l     24(a7),d4
[0000464a] 6c04                      bge.s      a.ldiv_1
[0000464c] 4484                      neg.l      d4
[0000464e] 4605                      not.b      d5
a.ldiv_1:
[00004650] 262f 001c                 move.l     28(a7),d3
[00004654] 6c04                      bge.s      a.ldiv_2
[00004656] 4483                      neg.l      d3
[00004658] 4605                      not.b      d5
a.ldiv_2:
[0000465a] 4282                      clr.l      d2
[0000465c] 721f                      moveq.l    #31,d1
[0000465e] 4280                      clr.l      d0
a.ldiv_4:
[00004660] e38a                      lsl.l      #1,d2
[00004662] e38b                      lsl.l      #1,d3
[00004664] d580                      addx.l     d0,d2
[00004666] b484                      cmp.l      d4,d2
[00004668] 6504                      bcs.s      a.ldiv_3
[0000466a] 9484                      sub.l      d4,d2
[0000466c] 5283                      addq.l     #1,d3
a.ldiv_3:
[0000466e] 51c9 fff0                 dbf        d1,a.ldiv_4
[00004672] 4a45                      tst.w      d5
[00004674] 6c04                      bge.s      a.ldiv_5
[00004676] 2002                      move.l     d2,d0
[00004678] 6002                      bra.s      a.ldiv_6
a.ldiv_5:
[0000467a] 2003                      move.l     d3,d0
a.ldiv_6:
[0000467c] 4a05                      tst.b      d5
[0000467e] 6702                      beq.s      a.ldiv_7
[00004680] 4480                      neg.l      d0
a.ldiv_7:
[00004682] 4cdf 003e                 movem.l    (a7)+,d1-d5
[00004686] 2e9f                      move.l     (a7)+,(a7)
[00004688] 2f40 0004                 move.l     d0,4(a7)
[0000468c] 4e75                      rts

_lseek:
[0000468e] 4e56 ffda                 link       a6,#-38
[00004692] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[00004696] 2a2e 0008                 move.l     8(a6),d5
[0000469a] 4aae 000c                 tst.l      12(a6)
[0000469e] 660a                      bne.s      _lseek_1
[000046a0] 0cae 0000 0001 0010       cmpi.l     #$00000001,16(a6)
[000046a8] 6720                      beq.s      _lseek_2
_lseek_1:
[000046aa] 2eae 0010                 move.l     16(a6),(a7)
[000046ae] 2f2e 000c                 move.l     12(a6),-(a7)
[000046b2] 2f05                      move.l     d5,-(a7)
[000046b4] 4eb9 0000 48d8            jsr        _seek
[000046ba] 508f                      addq.l     #8,a7
[000046bc] 2807                      move.l     d7,d4
[000046be] 4a84                      tst.l      d4
[000046c0] 6c04                      bge.s      _lseek_3
[000046c2] 2e04                      move.l     d4,d7
[000046c4] 6002                      bra.s      _lseek_4
_lseek_3:
[000046c6] 2e05                      move.l     d5,d7
_lseek_4:
[000046c8] 6014                      bra.s      _lseek_5
_lseek_2:
[000046ca] 486e ffda                 pea.l      -38(a6)
[000046ce] 2f05                      move.l     d5,-(a7)
[000046d0] 4eb9 0000 5114            jsr        _fstat
[000046d6] 508f                      addq.l     #8,a7
[000046d8] 2807                      move.l     d7,d4
[000046da] 6c0a                      bge.s      _lseek_6
[000046dc] 2e04                      move.l     d4,d7
_lseek_5:
[000046de] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[000046e2] 4e5e                      unlk       a6
[000046e4] 4e75                      rts
_lseek_6:
[000046e6] 4287                      clr.l      d7
[000046e8] 3e2e ffde                 move.w     -34(a6),d7
[000046ec] 0287 0000 6000            andi.l     #$00006000,d7
[000046f2] 0c87 0000 2000            cmpi.l     #$00002000,d7
[000046f8] 6706                      beq.s      _lseek_7
[000046fa] 4a2e ffe0                 tst.b      -32(a6)
[000046fe] 6604                      bne.s      _lseek_8
_lseek_7:
[00004700] 7ee3                      moveq.l    #-29,d7
[00004702] 60da                      bra.s      _lseek_5
_lseek_8:
[00004704] 2e05                      move.l     d5,d7
[00004706] 60d6                      bra.s      _lseek_5

_open:
[00004708] 205f                      movea.l    (a7)+,a0
[0000470a] 7e05                      moveq.l    #5,d7
[0000470c] 4e41                      trap       #1
[0000470e] 4ed0                      jmp        (a0)

_putc:
[00004710] 4e56 0000                 link       a6,#0
[00004714] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00004718] 2a6e 0008                 movea.l    8(a6),a5
[0000471c] 2a2e 000c                 move.l     12(a6),d5
[00004720] 2e0d                      move.l     a5,d7
[00004722] 6610                      bne.s      _putc_1
[00004724] 2ebc 0000 7b0e            move.l     #$0000D1BC,(a7)
[0000472a] 42a7                      clr.l      -(a7)
[0000472c] 4eb9 0000 5462            jsr        __raise
[00004732] 588f                      addq.l     #4,a7
_putc_1:
[00004734] 4a85                      tst.l      d5
[00004736] 6d22                      blt.s      _putc_2
[00004738] 3e2d 0002                 move.w     2(a5),d7
[0000473c] 48c7                      ext.l      d7
[0000473e] 0c47 0200                 cmpi.w     #$0200,d7
[00004742] 6c20                      bge.s      _putc_3
[00004744] 3e2d 0002                 move.w     2(a5),d7
[00004748] 48c7                      ext.l      d7
[0000474a] 2447                      movea.l    d7,a2
[0000474c] 526d 0002                 addq.w     #1,2(a5)
[00004750] 49ed 000a                 lea.l      10(a5),a4
[00004754] d5cc                      adda.l     a4,a2
[00004756] 1485                      move.b     d5,(a2)
[00004758] 602e                      bra.s      _putc_4
_putc_2:
[0000475a] 4a6d 0002                 tst.w      2(a5)
[0000475e] 6e46                      bgt.s      _putc_5
[00004760] 2e05                      move.l     d5,d7
[00004762] 603a                      bra.s      _putc_6
_putc_3:
[00004764] 3e2d 0002                 move.w     2(a5),d7
[00004768] 48c7                      ext.l      d7
[0000476a] 2e87                      move.l     d7,(a7)
[0000476c] 486d 000a                 pea.l      10(a5)
[00004770] 3e15                      move.w     (a5),d7
[00004772] 48c7                      ext.l      d7
[00004774] 2f07                      move.l     d7,-(a7)
[00004776] 4eb9 0000 5416            jsr        _fwrite
[0000477c] 508f                      addq.l     #8,a7
[0000477e] 3b7c 0001 0002            move.w     #$0001,2(a5)
[00004784] 1b45 000a                 move.b     d5,10(a5)
_putc_4:
[00004788] 0c85 0000 000a            cmpi.l     #$0000000A,d5
[0000478e] 660c                      bne.s      _putc_7
[00004790] 3e2d 0004                 move.w     4(a5),d7
[00004794] 48c7                      ext.l      d7
[00004796] 0c47 ffff                 cmpi.w     #$FFFF,d7
[0000479a] 66be                      bne.s      _putc_2
_putc_7:
[0000479c] 2e05                      move.l     d5,d7
_putc_6:
[0000479e] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000047a2] 4e5e                      unlk       a6
[000047a4] 4e75                      rts
_putc_5:
[000047a6] 3e2d 0002                 move.w     2(a5),d7
[000047aa] 48c7                      ext.l      d7
[000047ac] 2e87                      move.l     d7,(a7)
[000047ae] 486d 000a                 pea.l      10(a5)
[000047b2] 3e15                      move.w     (a5),d7
[000047b4] 48c7                      ext.l      d7
[000047b6] 2f07                      move.l     d7,-(a7)
[000047b8] 4eb9 0000 5416            jsr        _fwrite
[000047be] 508f                      addq.l     #8,a7
[000047c0] 426d 0002                 clr.w      2(a5)
[000047c4] 2e05                      move.l     d5,d7
[000047c6] 60d6                      bra.s      _putc_6

_putl:
[000047c8] 4e56 fffc                 link       a6,#-4
[000047cc] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[000047d0] 2a6e 0008                 movea.l    8(a6),a5
[000047d4] 286e 000c                 movea.l    12(a6),a4
[000047d8] 2e0d                      move.l     a5,d7
[000047da] 6618                      bne.s      _putl_1
[000047dc] 2ebc 0000 7b0e            move.l     #$0000D1BC,(a7)
[000047e2] 42a7                      clr.l      -(a7)
[000047e4] 4eb9 0000 5462            jsr        __raise
[000047ea] 588f                      addq.l     #4,a7
[000047ec] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[000047f0] 4e5e                      unlk       a6
[000047f2] 4e75                      rts
_putl_1:
[000047f4] 2a2e 0010                 move.l     16(a6),d5
_putl_6:
[000047f8] 4a85                      tst.l      d5
[000047fa] 6f32                      ble.s      _putl_2
[000047fc] 45ed 000a                 lea.l      10(a5),a2
[00004800] 3e2d 0002                 move.w     2(a5),d7
[00004804] 48c7                      ext.l      d7
[00004806] d5c7                      adda.l     d7,a2
[00004808] 2d4a fffc                 move.l     a2,-4(a6)
_putl_4:
[0000480c] 4a85                      tst.l      d5
[0000480e] 6f68                      ble.s      _putl_3
[00004810] 3e2d 0002                 move.w     2(a5),d7
[00004814] 48c7                      ext.l      d7
[00004816] 0c47 0200                 cmpi.w     #$0200,d7
[0000481a] 6c5c                      bge.s      _putl_3
[0000481c] 246e fffc                 movea.l    -4(a6),a2
[00004820] 52ae fffc                 addq.l     #1,-4(a6)
[00004824] 149c                      move.b     (a4)+,(a2)
[00004826] 5385                      subq.l     #1,d5
[00004828] 526d 0002                 addq.w     #1,2(a5)
[0000482c] 60de                      bra.s      _putl_4
_putl_2:
[0000482e] 3e2d 0004                 move.w     4(a5),d7
[00004832] 48c7                      ext.l      d7
[00004834] 0c47 ffff                 cmpi.w     #$FFFF,d7
[00004838] 6764                      beq.s      _putl_5
[0000483a] 4a6d 0002                 tst.w      2(a5)
[0000483e] 675e                      beq.s      _putl_5
[00004840] 3e2d 0002                 move.w     2(a5),d7
[00004844] 48c7                      ext.l      d7
[00004846] 2447                      movea.l    d7,a2
[00004848] 47ed 0009                 lea.l      9(a5),a3
[0000484c] d5cb                      adda.l     a3,a2
[0000484e] 4287                      clr.l      d7
[00004850] 1e12                      move.b     (a2),d7
[00004852] 0c47 000a                 cmpi.w     #$000A,d7
[00004856] 6646                      bne.s      _putl_5
[00004858] 3e2d 0002                 move.w     2(a5),d7
[0000485c] 48c7                      ext.l      d7
[0000485e] 2e87                      move.l     d7,(a7)
[00004860] 486d 000a                 pea.l      10(a5)
[00004864] 3e15                      move.w     (a5),d7
[00004866] 48c7                      ext.l      d7
[00004868] 2f07                      move.l     d7,-(a7)
[0000486a] 4eb9 0000 5416            jsr        _fwrite
[00004870] 508f                      addq.l     #8,a7
[00004872] 426d 0002                 clr.w      2(a5)
[00004876] 6026                      bra.s      _putl_5
_putl_3:
[00004878] 4a85                      tst.l      d5
[0000487a] 6f00 ff7c                 ble        _putl_6
[0000487e] 2ebc 0000 0200            move.l     #$00000200,(a7)
[00004884] 486d 000a                 pea.l      10(a5)
[00004888] 3e15                      move.w     (a5),d7
[0000488a] 48c7                      ext.l      d7
[0000488c] 2f07                      move.l     d7,-(a7)
[0000488e] 4eb9 0000 5416            jsr        _fwrite
[00004894] 508f                      addq.l     #8,a7
[00004896] 426d 0002                 clr.w      2(a5)
[0000489a] 6000 ff5c                 bra        _putl_6
_putl_5:
[0000489e] 2e2e 0010                 move.l     16(a6),d7
[000048a2] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[000048a6] 4e5e                      unlk       a6
[000048a8] 4e75                      rts

_read:
[000048aa] 205f                      movea.l    (a7)+,a0
[000048ac] 7e03                      moveq.l    #3,d7
[000048ae] 4e41                      trap       #1
[000048b0] 4ed0                      jmp        (a0)
[000048b2] 7265                      moveq.l    #101,d1
[000048b4] 6164                      bsr.s      $0000491A
[000048b6] 2065                      movea.l    -(a5),a0
[000048b8] 7272                      moveq.l    #114,d1
[000048ba] 6f72                      ble.s      _read_1
[000048bc] 0000                      dc.w       $0000
_read_1: ; not found: 0000492e

_scnstr:
[000048be] 206f 0004                 movea.l    4(a7),a0
[000048c2] 1e2f 000b                 move.b     11(a7),d7
_scnstr_2:
[000048c6] be10                      cmp.b      (a0),d7
[000048c8] 6706                      beq.s      _scnstr_1
[000048ca] 4a18                      tst.b      (a0)+
[000048cc] 66f8                      bne.s      _scnstr_2
[000048ce] 5388                      subq.l     #1,a0
_scnstr_1:
[000048d0] 2e08                      move.l     a0,d7
[000048d2] 9eaf 0004                 sub.l      4(a7),d7
[000048d6] 4e75                      rts

_seek:
[000048d8] 205f                      movea.l    (a7)+,a0
[000048da] 7e13                      moveq.l    #19,d7
[000048dc] 4e41                      trap       #1
[000048de] 4ed0                      jmp        (a0)

a.switch:
[000048e0] 4a98                      tst.l      (a0)+
[000048e2] 670a                      beq.s      a.switch_1
[000048e4] be98                      cmp.l      (a0)+,d7
[000048e6] 66f8                      bne.s      a.switch
[000048e8] 2068 fff8                 movea.l    -8(a0),a0
[000048ec] 4ed0                      jmp        (a0)
a.switch_1:
[000048ee] 2050                      movea.l    (a0),a0
[000048f0] 4ed0                      jmp        (a0)

a.ulmod:
[000048f2] 48e7 7c00                 movem.l    d1-d5,-(a7)
[000048f6] 7aff                      moveq.l    #-1,d5
[000048f8] 6006                      bra.s      a.ulmod_1
a.ulmod_1: ; not found: 00004900

a.uldiv:
[000048fa] 48e7 7c00                 movem.l    d1-d5,-(a7)
[000048fe] 4205                      clr.b      d5
[00004900] 282f 0018                 move.l     24(a7),d4
[00004904] 262f 001c                 move.l     28(a7),d3
[00004908] 4282                      clr.l      d2
[0000490a] 721f                      moveq.l    #31,d1
[0000490c] 4280                      clr.l      d0
a.uldiv_2:
[0000490e] e38a                      lsl.l      #1,d2
[00004910] e38b                      lsl.l      #1,d3
[00004912] d580                      addx.l     d0,d2
[00004914] b484                      cmp.l      d4,d2
[00004916] 6504                      bcs.s      a.uldiv_1
[00004918] 9484                      sub.l      d4,d2
[0000491a] 5283                      addq.l     #1,d3
a.uldiv_1:
[0000491c] 51c9 fff0                 dbf        d1,a.uldiv_2
[00004920] 4a05                      tst.b      d5
[00004922] 6c04                      bge.s      a.uldiv_3
[00004924] 2002                      move.l     d2,d0
[00004926] 6002                      bra.s      a.uldiv_4
a.uldiv_3:
[00004928] 2003                      move.l     d3,d0
a.uldiv_4:
[0000492a] 4cdf 003e                 movem.l    (a7)+,d1-d5
[0000492e] 2e9f                      move.l     (a7)+,(a7)
[00004930] 2f40 0004                 move.l     d0,4(a7)
[00004934] 4e75                      rts

_uname:
[00004936] 4e56 0000                 link       a6,#0
[0000493a] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[0000493e] 4a39 0000 7af8            tst.b      $0000D1A6
[00004944] 662a                      bne.s      _uname_1
[00004946] 4eb9 0000 511c            jsr        _getpid
[0000494c] 2807                      move.l     d7,d4
[0000494e] 7a0b                      moveq.l    #11,d5
_uname_2:
[00004950] 5385                      subq.l     #1,d5
[00004952] 0c85 0000 0006            cmpi.l     #$00000006,d5
[00004958] 6d16                      blt.s      _uname_1
[0000495a] 2445                      movea.l    d5,a2
[0000495c] d5fc 0000 7af2            adda.l     #$0000D1A0,a2
[00004962] 7e30                      moveq.l    #48,d7
[00004964] 7c07                      moveq.l    #7,d6
[00004966] cc84                      and.l      d4,d6
[00004968] de86                      add.l      d6,d7
[0000496a] 1487                      move.b     d7,(a2)
[0000496c] e684                      asr.l      #3,d4
[0000496e] 60e0                      bra.s      _uname_2
_uname_1:
[00004970] 2e3c 0000 7af2            move.l     #$0000D1A0,d7
[00004976] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[0000497a] 4e5e                      unlk       a6
[0000497c] 4e75                      rts

x497e:
[0000497e] 4e56 0000                 link       a6,#0
[00004982] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00004986] 2a6e 0008                 movea.l    8(a6),a5
[0000498a] 2a2e 000c                 move.l     12(a6),d5
[0000498e] 2e0d                      move.l     a5,d7
[00004990] de85                      add.l      d5,d7
[00004992] 2847                      movea.l    d7,a4
[00004994] 2e15                      move.l     (a5),d7
[00004996] 9e85                      sub.l      d5,d7
[00004998] 2887                      move.l     d7,(a4)
[0000499a] 296d 0004 0004            move.l     4(a5),4(a4)
[000049a0] 2445                      movea.l    d5,a2
[000049a2] 518a                      subq.l     #8,a2
[000049a4] 2a8a                      move.l     a2,(a5)
[000049a6] 2e0c                      move.l     a4,d7
[000049a8] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000049ac] 4e5e                      unlk       a6
[000049ae] 4e75                      rts

x49b0:
[000049b0] 4e56 0000                 link       a6,#0
[000049b4] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000049b8] 2a6e 0008                 movea.l    8(a6),a5
[000049bc] 286d 0004                 movea.l    4(a5),a4
[000049c0] 2e0d                      move.l     a5,d7
[000049c2] de95                      add.l      (a5),d7
[000049c4] 5087                      addq.l     #8,d7
[000049c6] be8c                      cmp.l      a4,d7
[000049c8] 660c                      bne.s      x49b0_1
[000049ca] 2e14                      move.l     (a4),d7
[000049cc] 5087                      addq.l     #8,d7
[000049ce] df95                      add.l      d7,(a5)
[000049d0] 2b6c 0004 0004            move.l     4(a4),4(a5)
x49b0_1:
[000049d6] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000049da] 4e5e                      unlk       a6
[000049dc] 4e75                      rts

_alloc:
[000049de] 4e56 0000                 link       a6,#0
[000049e2] 48e7 8004                 movem.l    d0/a5,-(a7)
[000049e6] 2eae 000c                 move.l     12(a6),(a7)
[000049ea] 2f2e 0008                 move.l     8(a6),-(a7)
[000049ee] 4eb9 0000 4a18            jsr        _nalloc
[000049f4] 588f                      addq.l     #4,a7
[000049f6] 2a47                      movea.l    d7,a5
[000049f8] 2e0d                      move.l     a5,d7
[000049fa] 6704                      beq.s      _alloc_1
[000049fc] 2e0d                      move.l     a5,d7
[000049fe] 6010                      bra.s      _alloc_2
_alloc_1:
[00004a00] 2ebc 0000 7b12            move.l     #$0000D1C0,(a7)
[00004a06] 42a7                      clr.l      -(a7)
[00004a08] 4eb9 0000 5462            jsr        __raise
[00004a0e] 588f                      addq.l     #4,a7
_alloc_2:
[00004a10] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00004a14] 4e5e                      unlk       a6
[00004a16] 4e75                      rts

_nalloc:
[00004a18] 4e56 fffc                 link       a6,#-4
[00004a1c] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[00004a20] 2a2e 0008                 move.l     8(a6),d5
[00004a24] 0c85 0000 0004            cmpi.l     #$00000004,d5
[00004a2a] 6404                      bcc.s      _nalloc_1
[00004a2c] 7e04                      moveq.l    #4,d7
[00004a2e] 6002                      bra.s      _nalloc_2
_nalloc_1:
[00004a30] 2e05                      move.l     d5,d7
_nalloc_2:
[00004a32] 5687                      addq.l     #3,d7
[00004a34] 7cfc                      moveq.l    #-4,d6
[00004a36] cc87                      and.l      d7,d6
[00004a38] 2e06                      move.l     d6,d7
[00004a3a] 5887                      addq.l     #4,d7
[00004a3c] 2a07                      move.l     d7,d5
_nalloc_18:
[00004a3e] 2a7c 0000 7b02            movea.l    #$0000D1B0,a5
_nalloc_9:
[00004a44] 2855                      movea.l    (a5),a4
[00004a46] 2e0c                      move.l     a4,d7
[00004a48] 6714                      beq.s      _nalloc_3
[00004a4a] 2e14                      move.l     (a4),d7
[00004a4c] 5087                      addq.l     #8,d7
[00004a4e] ba87                      cmp.l      d7,d5
[00004a50] 6220                      bhi.s      _nalloc_4
[00004a52] 2e14                      move.l     (a4),d7
[00004a54] be85                      cmp.l      d5,d7
[00004a56] 6422                      bcc.s      _nalloc_5
[00004a58] 2aac 0004                 move.l     4(a4),(a5)
[00004a5c] 6028                      bra.s      _nalloc_6
_nalloc_3:
[00004a5e] 4ab9 0000 7afe            tst.l      $0000D1AC
[00004a64] 662e                      bne.s      _nalloc_7
[00004a66] 23fc 0000 0200 0000 7afe  move.l     #$00000200,$0000D1AC
[00004a70] 603c                      bra.s      _nalloc_8
_nalloc_4:
[00004a72] 45ec 0004                 lea.l      4(a4),a2
[00004a76] 2a4a                      movea.l    a2,a5
[00004a78] 60ca                      bra.s      _nalloc_9
_nalloc_5:
[00004a7a] 2e85                      move.l     d5,(a7)
[00004a7c] 2f0c                      move.l     a4,-(a7)
[00004a7e] 4eba fefe                 jsr        $0000497E(pc)
[00004a82] 588f                      addq.l     #4,a7
[00004a84] 2a87                      move.l     d7,(a5)
_nalloc_6:
[00004a86] 296e 000c 0004            move.l     12(a6),4(a4)
[00004a8c] 45ec 0004                 lea.l      4(a4),a2
[00004a90] 2e0a                      move.l     a2,d7
[00004a92] 6066                      bra.s      _nalloc_10
_nalloc_7:
[00004a94] 0cb9 0000 0200 0000 7afe  cmpi.l     #$00000200,$0000D1AC
[00004a9e] 670e                      beq.s      _nalloc_8
[00004aa0] 2e39 0000 7afe            move.l     $0000D1AC,d7
[00004aa6] e28f                      lsr.l      #1,d7
[00004aa8] 23c7 0000 7afe            move.l     d7,$0000D1AC
_nalloc_8:
[00004aae] 97cb                      suba.l     a3,a3
_nalloc_12:
[00004ab0] bab9 0000 7afe            cmp.l      $0000D1AC,d5
[00004ab6] 6228                      bhi.s      _nalloc_11
[00004ab8] 2d79 0000 7afe fffc       move.l     $0000D1AC,-4(a6)
[00004ac0] 2eae fffc                 move.l     -4(a6),(a7)
[00004ac4] 4eb9 0000 51be            jsr        _sbreak
[00004aca] 2647                      movea.l    d7,a3
[00004acc] 2e0b                      move.l     a3,d7
[00004ace] 6610                      bne.s      _nalloc_11
[00004ad0] 2e39 0000 7afe            move.l     $0000D1AC,d7
[00004ad6] e28f                      lsr.l      #1,d7
[00004ad8] 23c7 0000 7afe            move.l     d7,$0000D1AC
[00004ade] 60d0                      bra.s      _nalloc_12
_nalloc_11:
[00004ae0] 2e0b                      move.l     a3,d7
[00004ae2] 6610                      bne.s      _nalloc_13
[00004ae4] 2d45 fffc                 move.l     d5,-4(a6)
[00004ae8] 2eae fffc                 move.l     -4(a6),(a7)
[00004aec] 4eb9 0000 51be            jsr        _sbreak
[00004af2] 2647                      movea.l    d7,a3
_nalloc_13:
[00004af4] 2e0b                      move.l     a3,d7
[00004af6] 660a                      bne.s      _nalloc_14
[00004af8] 4287                      clr.l      d7
_nalloc_10:
[00004afa] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[00004afe] 4e5e                      unlk       a6
[00004b00] 4e75                      rts
_nalloc_14:
[00004b02] 2e2e fffc                 move.l     -4(a6),d7
[00004b06] 5187                      subq.l     #8,d7
[00004b08] 2687                      move.l     d7,(a3)
[00004b0a] 4ab9 0000 7b06            tst.l      $0000D1B4
[00004b10] 6708                      beq.s      _nalloc_15
[00004b12] b7f9 0000 7b06            cmpa.l     $0000D1B4,a3
[00004b18] 6406                      bcc.s      _nalloc_16
_nalloc_15:
[00004b1a] 23cb 0000 7b06            move.l     a3,$0000D1B4
_nalloc_16:
[00004b20] 2e39 0000 7b0a            move.l     $0000D1B8,d7
[00004b26] 2c0b                      move.l     a3,d6
[00004b28] dcae fffc                 add.l      -4(a6),d6
[00004b2c] be86                      cmp.l      d6,d7
[00004b2e] 640c                      bcc.s      _nalloc_17
[00004b30] 2e0b                      move.l     a3,d7
[00004b32] deae fffc                 add.l      -4(a6),d7
[00004b36] 23c7 0000 7b0a            move.l     d7,$0000D1B8
_nalloc_17:
[00004b3c] 4297                      clr.l      (a7)
[00004b3e] 486b 0004                 pea.l      4(a3)
[00004b42] 4eb9 0000 4b5c            jsr        _free
[00004b48] 588f                      addq.l     #4,a7
[00004b4a] 6000 fef2                 bra        _nalloc_18
[00004b4e] 6261                      bhi.s      _nalloc_19 ; ; branch to odd address
[00004b50] 6420                      bcc.s      _nalloc_20
[00004b52] 6672                      bne.s      _nalloc_21
[00004b54] 6565                      bcs.s      _nalloc_22 ; ; branch to odd address
[00004b56] 2063                      movea.l    -(a3),a0
[00004b58] 616c                      bsr.s      $00004BC6
[00004b5a] 6c00 4e56                 bge        _nalloc_23
[00004b5e] 0000 48e7                 ori.b      #$E7,d0
[00004b62] 801c                      or.b       (a4)+,d0
[00004b64] 2e2e 0008                 move.l     8(a6),d7
[00004b68] 5987                      subq.l     #4,d7
[00004b6a] 2a47                      movea.l    d7,a5
[00004b6c] 4aae 0008                 tst.l      8(a6)
[00004b70] 672c                      beq.s      _nalloc_24
_nalloc_20:
[00004b72] bbf9 0000 7b06            cmpa.l     $0000D1B4,a5
[00004b78] 650a                      bcs.s      _nalloc_25
[00004b7a] 2e39 0000 7b0a            move.l     $0000D1B8,d7
[00004b80] be8d                      cmp.l      a5,d7
[00004b82] 6226                      bhi.s      _nalloc_26
_nalloc_25:
[00004b84] 23fc 0000 4b4e 0000 7b12  move.l     #$00004B4E,$0000D1C0
[00004b8e] 2ebc 0000 7b12            move.l     #$0000D1C0,(a7)
[00004b94] 42a7                      clr.l      -(a7)
[00004b96] 4eb9 0000 5462            jsr        __raise
[00004b9c] 588f                      addq.l     #4,a7
_nalloc_24:
[00004b9e] 2e2e 000c                 move.l     12(a6),d7
[00004ba2] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00004ba6] 4e5e                      unlk       a6
[00004ba8] 4e75                      rts
_nalloc_26:
[00004baa] 4ab9 0000 7b02            tst.l      $0000D1B0
[00004bb0] 660c                      bne.s      _nalloc_27
_nalloc_19:
[00004bb2] 42ad 0004                 clr.l      4(a5)
[00004bb6] 23cd 0000 7b02            move.l     a5,$0000D1B0
_nalloc_22:
[00004bbc] 60e0                      bra.s      _nalloc_24
_nalloc_27:
[00004bbe] bbf9 0000 7b02            cmpa.l     $0000D1B0,a5
[00004bc4] 6416                      bcc.s      _nalloc_28
_nalloc_21:
[00004bc6] 2b79 0000 7b02 0004       move.l     $0000D1B0,4(a5)
[00004bce] 23cd 0000 7b02            move.l     a5,$0000D1B0
[00004bd4] 2e8d                      move.l     a5,(a7)
[00004bd6] 4eba fdd8                 jsr        $000049B0(pc)
[00004bda] 60c2                      bra.s      _nalloc_24
_nalloc_28:
[00004bdc] 2879 0000 7b02            movea.l    $0000D1B0,a4
_nalloc_30:
[00004be2] 266c 0004                 movea.l    4(a4),a3
[00004be6] 2e0b                      move.l     a3,d7
[00004be8] 6708                      beq.s      _nalloc_29
[00004bea] b7cd                      cmpa.l     a5,a3
[00004bec] 6404                      bcc.s      _nalloc_29
[00004bee] 284b                      movea.l    a3,a4
[00004bf0] 60f0                      bra.s      _nalloc_30
_nalloc_29:
[00004bf2] 2e0b                      move.l     a3,d7
[00004bf4] 6716                      beq.s      _nalloc_31
[00004bf6] 2b4b 0004                 move.l     a3,4(a5)
[00004bfa] 294d 0004                 move.l     a5,4(a4)
[00004bfe] 2e8d                      move.l     a5,(a7)
[00004c00] 4eba fdae                 jsr        $000049B0(pc)
[00004c04] 2e8c                      move.l     a4,(a7)
[00004c06] 4eba fda8                 jsr        $000049B0(pc)
[00004c0a] 6092                      bra.s      _nalloc_24
_nalloc_31:
[00004c0c] 42ad 0004                 clr.l      4(a5)
[00004c10] 294d 0004                 move.l     a5,4(a4)
[00004c14] 2e8c                      move.l     a4,(a7)
[00004c16] 4eba fd98                 jsr        $000049B0(pc)
[00004c1a] 6000 ff82                 bra.w      _nalloc_24
_nalloc_23: ; not found: 000099b2

_btol:
[00004c1e] 4e56 fff4                 link       a6,#-12
[00004c22] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00004c26] 2a6e 0008                 movea.l    8(a6),a5
[00004c2a] 2a2e 000c                 move.l     12(a6),d5
[00004c2e] 42ae fff8                 clr.l      -8(a6)
[00004c32] 2d4d fff4                 move.l     a5,-12(a6)
[00004c36] 42ae fffc                 clr.l      -4(a6)
_btol_5:
[00004c3a] 4a85                      tst.l      d5
[00004c3c] 6714                      beq.s      _btol_1
[00004c3e] 4287                      clr.l      d7
[00004c40] 1e15                      move.b     (a5),d7
[00004c42] 0c47 0020                 cmpi.w     #$0020,d7
[00004c46] 6324                      bls.s      _btol_2
[00004c48] 4287                      clr.l      d7
[00004c4a] 1e15                      move.b     (a5),d7
[00004c4c] 0c47 007f                 cmpi.w     #$007F,d7
[00004c50] 641a                      bcc.s      _btol_2
_btol_1:
[00004c52] 4a85                      tst.l      d5
[00004c54] 671c                      beq.s      _btol_3
[00004c56] 4287                      clr.l      d7
[00004c58] 1e15                      move.b     (a5),d7
[00004c5a] 0c47 002d                 cmpi.w     #$002D,d7
[00004c5e] 661a                      bne.s      _btol_4
[00004c60] 7001                      moveq.l    #1,d0
[00004c62] 2d40 fffc                 move.l     d0,-4(a6)
[00004c66] 528d                      addq.l     #1,a5
[00004c68] 5385                      subq.l     #1,d5
[00004c6a] 6006                      bra.s      _btol_3
_btol_2:
[00004c6c] 5385                      subq.l     #1,d5
[00004c6e] 528d                      addq.l     #1,a5
[00004c70] 60c8                      bra.s      _btol_5
_btol_3:
[00004c72] 4a85                      tst.l      d5
[00004c74] 6614                      bne.s      _btol_6
[00004c76] 6000 00d6                 bra        _btol_7
_btol_4:
[00004c7a] 4287                      clr.l      d7
[00004c7c] 1e15                      move.b     (a5),d7
[00004c7e] 0c47 002b                 cmpi.w     #$002B,d7
[00004c82] 66ee                      bne.s      _btol_3
[00004c84] 528d                      addq.l     #1,a5
[00004c86] 5385                      subq.l     #1,d5
[00004c88] 60e8                      bra.s      _btol_3
_btol_6:
[00004c8a] 0cae 0000 0001 0014       cmpi.l     #$00000001,20(a6)
[00004c92] 6614                      bne.s      _btol_8
[00004c94] 4287                      clr.l      d7
[00004c96] 1e15                      move.b     (a5),d7
[00004c98] 0c47 0030                 cmpi.w     #$0030,d7
[00004c9c] 6764                      beq.s      _btol_9
[00004c9e] 700a                      moveq.l    #10,d0
[00004ca0] 2d40 0014                 move.l     d0,20(a6)
[00004ca4] 6000 00a8                 bra        _btol_7
_btol_8:
[00004ca8] 0cae 0000 0010 0014       cmpi.l     #$00000010,20(a6)
[00004cb0] 6600 009c                 bne        _btol_7
[00004cb4] 0c85 0000 0002            cmpi.l     #$00000002,d5
[00004cba] 6500 0092                 bcs        _btol_7
[00004cbe] 4287                      clr.l      d7
[00004cc0] 1e15                      move.b     (a5),d7
[00004cc2] 0c47 0030                 cmpi.w     #$0030,d7
[00004cc6] 6600 0086                 bne        _btol_7
[00004cca] 4287                      clr.l      d7
[00004ccc] 1e2d 0001                 move.b     1(a5),d7
[00004cd0] 0c47 0041                 cmpi.w     #$0041,d7
[00004cd4] 6518                      bcs.s      _btol_10
[00004cd6] 4287                      clr.l      d7
[00004cd8] 1e2d 0001                 move.b     1(a5),d7
[00004cdc] 0c47 005a                 cmpi.w     #$005A,d7
[00004ce0] 620c                      bhi.s      _btol_10
[00004ce2] 7e20                      moveq.l    #32,d7
[00004ce4] 4286                      clr.l      d6
[00004ce6] 1c2d 0001                 move.b     1(a5),d6
[00004cea] de86                      add.l      d6,d7
[00004cec] 6006                      bra.s      _btol_11
_btol_10:
[00004cee] 4287                      clr.l      d7
[00004cf0] 1e2d 0001                 move.b     1(a5),d7
_btol_11:
[00004cf4] 0c87 0000 0078            cmpi.l     #$00000078,d7
[00004cfa] 6652                      bne.s      _btol_7
[00004cfc] 548d                      addq.l     #2,a5
[00004cfe] 5585                      subq.l     #2,d5
[00004d00] 604c                      bra.s      _btol_7
_btol_9:
[00004d02] 0c85 0000 0001            cmpi.l     #$00000001,d5
[00004d08] 633e                      bls.s      _btol_12
[00004d0a] 4287                      clr.l      d7
[00004d0c] 1e2d 0001                 move.b     1(a5),d7
[00004d10] 0c47 0041                 cmpi.w     #$0041,d7
[00004d14] 6518                      bcs.s      _btol_13
[00004d16] 4287                      clr.l      d7
[00004d18] 1e2d 0001                 move.b     1(a5),d7
[00004d1c] 0c47 005a                 cmpi.w     #$005A,d7
[00004d20] 620c                      bhi.s      _btol_13
[00004d22] 7e20                      moveq.l    #32,d7
[00004d24] 4286                      clr.l      d6
[00004d26] 1c2d 0001                 move.b     1(a5),d6
[00004d2a] de86                      add.l      d6,d7
[00004d2c] 6006                      bra.s      _btol_14
_btol_13:
[00004d2e] 4287                      clr.l      d7
[00004d30] 1e2d 0001                 move.b     1(a5),d7
_btol_14:
[00004d34] 0c87 0000 0078            cmpi.l     #$00000078,d7
[00004d3a] 660c                      bne.s      _btol_12
[00004d3c] 7010                      moveq.l    #16,d0
[00004d3e] 2d40 0014                 move.l     d0,20(a6)
[00004d42] 548d                      addq.l     #2,a5
[00004d44] 5585                      subq.l     #2,d5
[00004d46] 6006                      bra.s      _btol_7
_btol_12:
[00004d48] 7008                      moveq.l    #8,d0
[00004d4a] 2d40 0014                 move.l     d0,20(a6)
_btol_7:
[00004d4e] 4a85                      tst.l      d5
[00004d50] 6720                      beq.s      _btol_15
[00004d52] 4287                      clr.l      d7
[00004d54] 1e15                      move.b     (a5),d7
[00004d56] 0c47 0030                 cmpi.w     #$0030,d7
[00004d5a] 656a                      bcs.s      _btol_16
[00004d5c] 4287                      clr.l      d7
[00004d5e] 1e15                      move.b     (a5),d7
[00004d60] 0c47 0039                 cmpi.w     #$0039,d7
[00004d64] 6260                      bhi.s      _btol_16
[00004d66] 7ed0                      moveq.l    #-48,d7
[00004d68] 4286                      clr.l      d6
[00004d6a] 1c15                      move.b     (a5),d6
[00004d6c] de86                      add.l      d6,d7
[00004d6e] 2807                      move.l     d7,d4
[00004d70] 606a                      bra.s      _btol_17
_btol_15:
[00004d72] 246e 0010                 movea.l    16(a6),a2
[00004d76] 2e8a                      move.l     a2,(a7)
[00004d78] 4aae fffc                 tst.l      -4(a6)
[00004d7c] 6708                      beq.s      _btol_18
[00004d7e] 2e2e fff8                 move.l     -8(a6),d7
[00004d82] 4487                      neg.l      d7
[00004d84] 6004                      bra.s      _btol_19
_btol_18:
[00004d86] 2e2e fff8                 move.l     -8(a6),d7
_btol_19:
[00004d8a] 2257                      movea.l    (a7),a1
[00004d8c] 2287                      move.l     d7,(a1)
[00004d8e] 4a85                      tst.l      d5
[00004d90] 6700 00b4                 beq        _btol_20
[00004d94] 4287                      clr.l      d7
[00004d96] 1e15                      move.b     (a5),d7
[00004d98] 0c47 0041                 cmpi.w     #$0041,d7
[00004d9c] 6514                      bcs.s      _btol_21
[00004d9e] 4287                      clr.l      d7
[00004da0] 1e15                      move.b     (a5),d7
[00004da2] 0c47 005a                 cmpi.w     #$005A,d7
[00004da6] 620a                      bhi.s      _btol_21
[00004da8] 7e20                      moveq.l    #32,d7
[00004daa] 4286                      clr.l      d6
[00004dac] 1c15                      move.b     (a5),d6
[00004dae] de86                      add.l      d6,d7
[00004db0] 6004                      bra.s      _btol_22
_btol_21:
[00004db2] 4287                      clr.l      d7
[00004db4] 1e15                      move.b     (a5),d7
_btol_22:
[00004db6] 0c87 0000 006c            cmpi.l     #$0000006C,d7
[00004dbc] 6600 0088                 bne        _btol_20
[00004dc0] 528d                      addq.l     #1,a5
[00004dc2] 6000 0082                 bra        _btol_20
_btol_16:
[00004dc6] 4287                      clr.l      d7
[00004dc8] 1e15                      move.b     (a5),d7
[00004dca] 0c47 0061                 cmpi.w     #$0061,d7
[00004dce] 652a                      bcs.s      _btol_23
[00004dd0] 4287                      clr.l      d7
[00004dd2] 1e15                      move.b     (a5),d7
[00004dd4] 0c47 007a                 cmpi.w     #$007A,d7
[00004dd8] 6338                      bls.s      _btol_24
[00004dda] 601e                      bra.s      _btol_23
_btol_17:
[00004ddc] 2eae fff8                 move.l     -8(a6),(a7)
[00004de0] 2f2e 0014                 move.l     20(a6),-(a7)
[00004de4] 4eb9 0000 5122            jsr        a.lmul
[00004dea] 2e17                      move.l     (a7),d7
[00004dec] de84                      add.l      d4,d7
[00004dee] 2d47 fff8                 move.l     d7,-8(a6)
[00004df2] 5385                      subq.l     #1,d5
[00004df4] 528d                      addq.l     #1,a5
[00004df6] 6000 ff56                 bra        _btol_7
_btol_23:
[00004dfa] 4287                      clr.l      d7
[00004dfc] 1e15                      move.b     (a5),d7
[00004dfe] 0c47 0041                 cmpi.w     #$0041,d7
[00004e02] 6500 ff6e                 bcs        _btol_15
[00004e06] 4287                      clr.l      d7
[00004e08] 1e15                      move.b     (a5),d7
[00004e0a] 0c47 005a                 cmpi.w     #$005A,d7
[00004e0e] 6200 ff62                 bhi        _btol_15
_btol_24:
[00004e12] 4287                      clr.l      d7
[00004e14] 1e15                      move.b     (a5),d7
[00004e16] 0c47 0041                 cmpi.w     #$0041,d7
[00004e1a] 6514                      bcs.s      _btol_25
[00004e1c] 4287                      clr.l      d7
[00004e1e] 1e15                      move.b     (a5),d7
[00004e20] 0c47 005a                 cmpi.w     #$005A,d7
[00004e24] 620a                      bhi.s      _btol_25
[00004e26] 7e20                      moveq.l    #32,d7
[00004e28] 4286                      clr.l      d6
[00004e2a] 1c15                      move.b     (a5),d6
[00004e2c] de86                      add.l      d6,d7
[00004e2e] 6004                      bra.s      _btol_26
_btol_25:
[00004e30] 4287                      clr.l      d7
[00004e32] 1e15                      move.b     (a5),d7
_btol_26:
[00004e34] 7ca9                      moveq.l    #-87,d6
[00004e36] dc87                      add.l      d7,d6
[00004e38] 2806                      move.l     d6,d4
[00004e3a] 2e2e 0014                 move.l     20(a6),d7
[00004e3e] be84                      cmp.l      d4,d7
[00004e40] 6e9a                      bgt.s      _btol_17
[00004e42] 6000 ff2e                 bra        _btol_15
_btol_20:
[00004e46] 2e0d                      move.l     a5,d7
[00004e48] 9eae fff4                 sub.l      -12(a6),d7
[00004e4c] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00004e50] 4e5e                      unlk       a6
[00004e52] 4e75                      rts

_close:
[00004e54] 205f                      movea.l    (a7)+,a0
[00004e56] 7e06                      moveq.l    #6,d7
[00004e58] 4e41                      trap       #1
[00004e5a] 4ed0                      jmp        (a0)

_cpybuf:
[00004e5c] 2e2f 000c                 move.l     12(a7),d7
[00004e60] 671a                      beq.s      _cpybuf_1
[00004e62] 2007                      move.l     d7,d0
[00004e64] 2200                      move.l     d0,d1
[00004e66] 4840                      swap       d0
[00004e68] 5341                      subq.w     #1,d1
[00004e6a] 206f 0004                 movea.l    4(a7),a0
[00004e6e] 226f 0008                 movea.l    8(a7),a1
_cpybuf_2:
[00004e72] 10d9                      move.b     (a1)+,(a0)+
[00004e74] 51c9 fffc                 dbf        d1,_cpybuf_2
[00004e78] 51c8 fff8                 dbf        d0,_cpybuf_2
_cpybuf_1:
[00004e7c] 4e75                      rts

_creat:
[00004e7e] 205f                      movea.l    (a7)+,a0
[00004e80] 7e08                      moveq.l    #8,d7
[00004e82] 4e41                      trap       #1
[00004e84] 4ed0                      jmp        (a0)

a.1sub:
[00004e86] 4e56 ffdc                 link       a6,#-36
[00004e8a] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[00004e8e] 43d7                      lea.l      (a7),a1
[00004e90] 2008                      move.l     a0,d0
[00004e92] 6618                      bne.s      a.1sub_1
[00004e94] 41ef 0008                 lea.l      8(a7),a0
[00004e98] 6012                      bra.s      a.1sub_1
a.1sub_1: ; not found: 00004eac

a.6sub:
[00004e9a] 4e56 ffdc                 link       a6,#-36
[00004e9e] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[00004ea2] 43ef 0008                 lea.l      8(a7),a1
[00004ea6] 2008                      move.l     a0,d0
[00004ea8] 6602                      bne.s      a.6sub_1
[00004eaa] 41d7                      lea.l      (a7),a0
a.6sub_1:
[00004eac] 2d50 ffdc                 move.l     (a0),-36(a6)
[00004eb0] 6738                      beq.s      a.6sub_2
[00004eb2] 086e 0007 ffdc            bchg       #7,-36(a6)
[00004eb8] 2d68 0004 ffe0            move.l     4(a0),-32(a6)
[00004ebe] 41ee ffdc                 lea.l      -36(a6),a0
[00004ec2] 6026                      bra.s      a.6sub_2
a.6sub_2: ; not found: 00004eea

a.1add:
[00004ec4] 4e56 ffe4                 link       a6,#-28
[00004ec8] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[00004ecc] 43d7                      lea.l      (a7),a1
[00004ece] 2008                      move.l     a0,d0
[00004ed0] 6618                      bne.s      a.1add_1
[00004ed2] 41ef 0008                 lea.l      8(a7),a0
[00004ed6] 6012                      bra.s      a.1add_1
a.1add_1: ; not found: 00004eea

a.6add:
[00004ed8] 4e56 ffe4                 link       a6,#-28
[00004edc] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[00004ee0] 43ef 0008                 lea.l      8(a7),a1
[00004ee4] 2008                      move.l     a0,d0
[00004ee6] 6602                      bne.s      a.6add_1
[00004ee8] 41d7                      lea.l      (a7),a0
a.6add_1:
[00004eea] 2d49 fffc                 move.l     a1,-4(a6)
[00004eee] 2d48 fff8                 move.l     a0,-8(a6)
[00004ef2] 4850                      pea.l      (a0)
[00004ef4] 486e ffe4                 pea.l      -28(a6)
[00004ef8] 4eb9 0000 55d8            jsr        a.unpk
[00004efe] 508f                      addq.l     #8,a7
[00004f00] 2d47 fff4                 move.l     d7,-12(a6)
[00004f04] 6778                      beq.s      a.6add_2
[00004f06] 2f2e fffc                 move.l     -4(a6),-(a7)
[00004f0a] 486e ffec                 pea.l      -20(a6)
[00004f0e] 4eb9 0000 55d8            jsr        a.unpk
[00004f14] 508f                      addq.l     #8,a7
[00004f16] 4a87                      tst.l      d7
[00004f18] 6606                      bne.s      a.6add_3
[00004f1a] 206e fff8                 movea.l    -8(a6),a0
[00004f1e] 6054                      bra.s      a.6add_4
a.6add_3:
[00004f20] 9eae fff4                 sub.l      -12(a6),d7
[00004f24] 672e                      beq.s      a.6add_5
[00004f26] 6e08                      bgt.s      a.6add_6
[00004f28] 4487                      neg.l      d7
[00004f2a] 41ee ffec                 lea.l      -20(a6),a0
[00004f2e] 6008                      bra.s      a.6add_7
a.6add_6:
[00004f30] dfae fff4                 add.l      d7,-12(a6)
[00004f34] 41ee ffe4                 lea.l      -28(a6),a0
a.6add_7:
[00004f38] 2218                      move.l     (a0)+,d1
[00004f3a] 2410                      move.l     (a0),d2
a.6add_10:
[00004f3c] e28a                      lsr.l      #1,d2
[00004f3e] 6404                      bcc.s      a.6add_8
[00004f40] 08c2 0000                 bset       #0,d2
a.6add_8:
[00004f44] e281                      asr.l      #1,d1
[00004f46] 6404                      bcc.s      a.6add_9
[00004f48] 08c2 001f                 bset       #31,d2
a.6add_9:
[00004f4c] 5387                      subq.l     #1,d7
[00004f4e] 6eec                      bgt.s      a.6add_10
[00004f50] 2082                      move.l     d2,(a0)
[00004f52] 2101                      move.l     d1,-(a0)
a.6add_5:
[00004f54] 41ee ffe8                 lea.l      -24(a6),a0
[00004f58] 43ee fff0                 lea.l      -16(a6),a1
[00004f5c] 2e10                      move.l     (a0),d7
[00004f5e] df91                      add.l      d7,(a1)
[00004f60] d388                      addx.l     -(a0),-(a1)
[00004f62] 2f2e fff4                 move.l     -12(a6),-(a7)
[00004f66] 4851                      pea.l      (a1)
[00004f68] 4eb9 0000 5544            jsr        a.repk
[00004f6e] 508f                      addq.l     #8,a7
[00004f70] 41ee ffec                 lea.l      -20(a6),a0
a.6add_4:
[00004f74] 226e fffc                 movea.l    -4(a6),a1
[00004f78] 22d8                      move.l     (a0)+,(a1)+
[00004f7a] 2290                      move.l     (a0),(a1)
[00004f7c] 4aa1                      tst.l      -(a1)
a.6add_2:
[00004f7e] 4cdf 06c6                 movem.l    (a7)+,d1-d2/d6-d7/a1-a2
[00004f82] 4e5e                      unlk       a6
[00004f84] 4e75                      rts

_dtento:
[00004f86] 4e56 0000                 link       a6,#0
[00004f8a] 48e7 9c00                 movem.l    d0/d3-d5,-(a7)
[00004f8e] 2a2e 0010                 move.l     16(a6),d5
[00004f92] 4a85                      tst.l      d5
[00004f94] 6c48                      bge.s      _dtento_1
[00004f96] 2e05                      move.l     d5,d7
[00004f98] 4487                      neg.l      d7
[00004f9a] 2807                      move.l     d7,d4
[00004f9c] 7601                      moveq.l    #1,d3
_dtento_7:
[00004f9e] 4a84                      tst.l      d4
[00004fa0] 6700 0090                 beq        _dtento_2
[00004fa4] 3e39 0000 7b76            move.w     $0000D224,d7
[00004faa] 48c7                      ext.l      d7
[00004fac] b687                      cmp.l      d7,d3
[00004fae] 6c00 0082                 bge        _dtento_2
[00004fb2] 0804 0000                 btst       #0,d4
[00004fb6] 6772                      beq.s      _dtento_3
[00004fb8] 2c2e 0008                 move.l     8(a6),d6
[00004fbc] 2e2e 000c                 move.l     12(a6),d7
[00004fc0] 2403                      move.l     d3,d2
[00004fc2] e782                      asl.l      #3,d2
[00004fc4] 2442                      movea.l    d2,a2
[00004fc6] d5fc 0000 7b1e            adda.l     #$0000D1CC,a2
[00004fcc] 41d2                      lea.l      (a2),a0
[00004fce] 4eb9 0000 5216            jsr        a.6div
[00004fd4] 2d46 0008                 move.l     d6,8(a6)
[00004fd8] 2d47 000c                 move.l     d7,12(a6)
[00004fdc] 604c                      bra.s      _dtento_3
_dtento_1:
[00004fde] 4a85                      tst.l      d5
[00004fe0] 6f00 00ac                 ble        _dtento_4
[00004fe4] 2805                      move.l     d5,d4
[00004fe6] 7601                      moveq.l    #1,d3
_dtento_8:
[00004fe8] 4a84                      tst.l      d4
[00004fea] 6700 00ba                 beq        _dtento_5
[00004fee] 3e39 0000 7b76            move.w     $0000D224,d7
[00004ff4] 48c7                      ext.l      d7
[00004ff6] b687                      cmp.l      d7,d3
[00004ff8] 6c00 00ac                 bge        _dtento_5
[00004ffc] 0804 0000                 btst       #0,d4
[00005000] 6700 009c                 beq        _dtento_6
[00005004] 2e03                      move.l     d3,d7
[00005006] e787                      asl.l      #3,d7
[00005008] 2447                      movea.l    d7,a2
[0000500a] d5fc 0000 7b1e            adda.l     #$0000D1CC,a2
[00005010] 2c12                      move.l     (a2),d6
[00005012] 2e2a 0004                 move.l     4(a2),d7
[00005016] 41ee 0008                 lea.l      8(a6),a0
[0000501a] 4eb9 0000 5336            jsr        a.6mul
[00005020] 2d46 0008                 move.l     d6,8(a6)
[00005024] 2d47 000c                 move.l     d7,12(a6)
[00005028] 6074                      bra.s      _dtento_6
_dtento_3:
[0000502a] e28c                      lsr.l      #1,d4
[0000502c] 5283                      addq.l     #1,d3
[0000502e] 6000 ff6e                 bra        _dtento_7
_dtento_2:
[00005032] 4a84                      tst.l      d4
[00005034] 6758                      beq.s      _dtento_4
[00005036] 2c2e 0008                 move.l     8(a6),d6
[0000503a] 2e2e 000c                 move.l     12(a6),d7
[0000503e] 3439 0000 7b76            move.w     $0000D224,d2
[00005044] 48c2                      ext.l      d2
[00005046] e782                      asl.l      #3,d2
[00005048] 2442                      movea.l    d2,a2
[0000504a] d5fc 0000 7b16            adda.l     #$0000D1C4,a2
[00005050] 41d2                      lea.l      (a2),a0
[00005052] 4eb9 0000 5216            jsr        a.6div
[00005058] 2d46 0008                 move.l     d6,8(a6)
[0000505c] 2d47 000c                 move.l     d7,12(a6)
[00005060] 2c2e 0008                 move.l     8(a6),d6
[00005064] 2e2e 000c                 move.l     12(a6),d7
[00005068] 3439 0000 7b76            move.w     $0000D224,d2
[0000506e] 48c2                      ext.l      d2
[00005070] e782                      asl.l      #3,d2
[00005072] 2442                      movea.l    d2,a2
[00005074] d5fc 0000 7b16            adda.l     #$0000D1C4,a2
[0000507a] 41d2                      lea.l      (a2),a0
[0000507c] 4eb9 0000 5216            jsr        a.6div
[00005082] 2d46 0008                 move.l     d6,8(a6)
[00005086] 2d47 000c                 move.l     d7,12(a6)
[0000508a] 5384                      subq.l     #1,d4
[0000508c] 60a4                      bra.s      _dtento_2
_dtento_4:
[0000508e] 2c2e 0008                 move.l     8(a6),d6
[00005092] 2e2e 000c                 move.l     12(a6),d7
[00005096] 4cdf 0039                 movem.l    (a7)+,d0/d3-d5
[0000509a] 4e5e                      unlk       a6
[0000509c] 4e75                      rts
_dtento_6:
[0000509e] e28c                      lsr.l      #1,d4
[000050a0] 5283                      addq.l     #1,d3
[000050a2] 6000 ff44                 bra        _dtento_8
_dtento_5:
[000050a6] 4a84                      tst.l      d4
[000050a8] 67e4                      beq.s      _dtento_4
[000050aa] 3e39 0000 7b76            move.w     $0000D224,d7
[000050b0] 48c7                      ext.l      d7
[000050b2] e787                      asl.l      #3,d7
[000050b4] 2447                      movea.l    d7,a2
[000050b6] d5fc 0000 7b16            adda.l     #$0000D1C4,a2
[000050bc] 2c12                      move.l     (a2),d6
[000050be] 2e2a 0004                 move.l     4(a2),d7
[000050c2] 41ee 0008                 lea.l      8(a6),a0
[000050c6] 4eb9 0000 5336            jsr        a.6mul
[000050cc] 2d46 0008                 move.l     d6,8(a6)
[000050d0] 2d47 000c                 move.l     d7,12(a6)
[000050d4] 3e39 0000 7b76            move.w     $0000D224,d7
[000050da] 48c7                      ext.l      d7
[000050dc] e787                      asl.l      #3,d7
[000050de] 2447                      movea.l    d7,a2
[000050e0] d5fc 0000 7b16            adda.l     #$0000D1C4,a2
[000050e6] 2c12                      move.l     (a2),d6
[000050e8] 2e2a 0004                 move.l     4(a2),d7
[000050ec] 41ee 0008                 lea.l      8(a6),a0
[000050f0] 4eb9 0000 5336            jsr        a.6mul
[000050f6] 2d46 0008                 move.l     d6,8(a6)
[000050fa] 2d47 000c                 move.l     d7,12(a6)
[000050fe] 5384                      subq.l     #1,d4
[00005100] 60a4                      bra.s      _dtento_5
[00005102] 4e55 4c4c                 link       a5,#19532
[00005106] 2046                      movea.l    d6,a0
[00005108] 494f                      lea.l      (b7),b4 ; apollo only
[0000510a] 2070 6f69 6e74            movea.l    ([$6E74,a0,zd6.l*8]),a0 ; 68020+ only
[00005110] 6572                      bcs.s      _dtento_9
[00005112] 0000                      dc.w       $0000
_dtento_9: ; not found: 00005184

_fstat:
[00005114] 205f                      movea.l    (a7)+,a0
[00005116] 7e1c                      moveq.l    #28,d7
[00005118] 4e41                      trap       #1
[0000511a] 4ed0                      jmp        (a0)

_getpid:
[0000511c] 7e14                      moveq.l    #20,d7
[0000511e] 4e41                      trap       #1
[00005120] 4e75                      rts

a.lmul:
[00005122] 302f 0008                 move.w     8(a7),d0
[00005126] c0ef 0006                 mulu.w     6(a7),d0
[0000512a] 3f40 0008                 move.w     d0,8(a7)
[0000512e] 302f 000a                 move.w     10(a7),d0
[00005132] c0ef 0004                 mulu.w     4(a7),d0
[00005136] d16f 0008                 add.w      d0,8(a7)
[0000513a] 302f 000a                 move.w     10(a7),d0
[0000513e] c0ef 0006                 mulu.w     6(a7),d0
[00005142] 426f 000a                 clr.w      10(a7)
[00005146] 2e9f                      move.l     (a7)+,(a7)
[00005148] d1af 0004                 add.l      d0,4(a7)
[0000514c] 4e75                      rts

a.1ltd:
[0000514e] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[00005152] 41d7                      lea.l      (a7),a0
[00005154] 6008                      bra.s      a.1ltd_1
a.1ltd_1: ; not found: 0000515e

a.6ltd:
[00005156] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[0000515a] 41ef 0008                 lea.l      8(a7),a0
[0000515e] 4290                      clr.l      (a0)
[00005160] 2140 0004                 move.l     d0,4(a0)
[00005164] 6c02                      bge.s      a.6ltd_1
[00005166] 5390                      subq.l     #1,(a0)
a.6ltd_1:
[00005168] 4878 0436                 pea.l      ($00000436).w
[0000516c] 4850                      pea.l      (a0)
[0000516e] 4eb9 0000 5544            jsr        a.repk
[00005174] 4fef 0008                 lea.l      8(a7),a7
[00005178] 4cdf 06c6                 movem.l    (a7)+,d1-d2/d6-d7/a1-a2
[0000517c] 4e75                      rts

x517e:
[0000517e] 6e6f                      bgt.s      x517e_1 ; ; branch to odd address
[00005180] 206d 656d                 movea.l    25965(a5),a0
[00005184] 6f72                      ble.s      x517e_2
[00005186] 7900                      ???
x517e_1: ; not found: 000051ef
x517e_2: ; not found: 000051f8

_putstr:
[00005188] 4e56 0000                 link       a6,#0
[0000518c] 48e7 8004                 movem.l    d0/a5,-(a7)
[00005190] 45ee 000c                 lea.l      12(a6),a2
[00005194] 2a4a                      movea.l    a2,a5
_putstr_2:
[00005196] 4a95                      tst.l      (a5)
[00005198] 671c                      beq.s      _putstr_1
[0000519a] 2e95                      move.l     (a5),(a7)
[0000519c] 4eb9 0000 5450            jsr        _lenstr
[000051a2] 2e87                      move.l     d7,(a7)
[000051a4] 2f15                      move.l     (a5),-(a7)
[000051a6] 2f2e 0008                 move.l     8(a6),-(a7)
[000051aa] 4eb9 0000 5416            jsr        _fwrite
[000051b0] 508f                      addq.l     #8,a7
[000051b2] 588d                      addq.l     #4,a5
[000051b4] 60e0                      bra.s      _putstr_2
_putstr_1:
[000051b6] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000051ba] 4e5e                      unlk       a6
[000051bc] 4e75                      rts

_sbreak:
[000051be] 205f                      movea.l    (a7)+,a0
[000051c0] 2e17                      move.l     (a7),d7
[000051c2] 5287                      addq.l     #1,d7
[000051c4] 0887 0000                 bclr       #0,d7
[000051c8] deb9 0000 7b16            add.l      $0000D1C4,d7
[000051ce] 2f07                      move.l     d7,-(a7)
[000051d0] 7e11                      moveq.l    #17,d7
[000051d2] 4e41                      trap       #1
[000051d4] 0c87 ffff ffff            cmpi.l     #$FFFFFFFF,d7
[000051da] 6606                      bne.s      _sbreak_1
[000051dc] 4a9f                      tst.l      (a7)+
[000051de] 4287                      clr.l      d7
[000051e0] 4ed0                      jmp        (a0)
_sbreak_1:
[000051e2] 2e39 0000 7b16            move.l     $0000D1C4,d7
[000051e8] 23df 0000 7b16            move.l     (a7)+,$0000D1C4
[000051ee] 4ab9 0000 7b1a            tst.l      $0000D1C8
[000051f4] 670a                      beq.s      _sbreak_2
[000051f6] 23f9 0000 7b16 0000 7b1a  move.l     $0000D1C4,$0000D1C8
_sbreak_2:
[00005200] 4ed0                      jmp        (a0)

a.1div:
[00005202] 4e56 ffde                 link       a6,#-34
[00005206] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[0000520a] 43d7                      lea.l      (a7),a1
[0000520c] 2008                      move.l     a0,d0
[0000520e] 6618                      bne.s      a.1div_1
[00005210] 41ef 0008                 lea.l      8(a7),a0
[00005214] 6012                      bra.s      a.1div_1
a.1div_1: ; not found: 00005228

a.6div:
[00005216] 4e56 ffda                 link       a6,#-38
[0000521a] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[0000521e] 43ef 0008                 lea.l      8(a7),a1
[00005222] 2008                      move.l     a0,d0
[00005224] 6602                      bne.s      a.6div_1
[00005226] 41d7                      lea.l      (a7),a0
a.6div_1:
[00005228] 2d49 fffc                 move.l     a1,-4(a6)
[0000522c] 422e ffdf                 clr.b      -33(a6)
[00005230] 4850                      pea.l      (a0)
[00005232] 486e ffe8                 pea.l      -24(a6)
[00005236] 4eb9 0000 55d8            jsr        a.unpk
[0000523c] 508f                      addq.l     #8,a7
[0000523e] 226e fffc                 movea.l    -4(a6),a1
[00005242] 2d47 fff8                 move.l     d7,-8(a6)
[00005246] 6618                      bne.s      a.6div_2
[00005248] 70ff                      moveq.l    #-1,d0
[0000524a] 2280                      move.l     d0,(a1)
[0000524c] 2340 0004                 move.l     d0,4(a1)
[00005250] 4a2e ffe8                 tst.b      -24(a6)
[00005254] 6d00 00c4                 blt        a.6div_3
[00005258] 0a11 0080                 eori.b     #$80,(a1)
[0000525c] 6000 00bc                 bra        a.6div_3
a.6div_2:
[00005260] 4a2e ffe8                 tst.b      -24(a6)
[00005264] 6c0c                      bge.s      a.6div_4
[00005266] 44ae ffec                 neg.l      -20(a6)
[0000526a] 40ae ffe8                 negx.l     -24(a6)
[0000526e] 462e ffdf                 not.b      -33(a6)
a.6div_4:
[00005272] 4a11                      tst.b      (a1)
[00005274] 6c08                      bge.s      a.6div_5
[00005276] 0891 0007                 bclr       #7,(a1)
[0000527a] 462e ffdf                 not.b      -33(a6)
a.6div_5:
[0000527e] 4851                      pea.l      (a1)
[00005280] 486e fff0                 pea.l      -16(a6)
[00005284] 4eb9 0000 55d8            jsr        a.unpk
[0000528a] 508f                      addq.l     #8,a7
[0000528c] 4a87                      tst.l      d7
[0000528e] 6700 008a                 beq        a.6div_3
[00005292] 9eae fff8                 sub.l      -8(a6),d7
[00005296] 0687 0000 03fe            addi.l     #$000003FE,d7
[0000529c] 2d47 fff8                 move.l     d7,-8(a6)
[000052a0] 42ae ffe0                 clr.l      -32(a6)
[000052a4] 42ae ffe4                 clr.l      -28(a6)
[000052a8] 7038                      moveq.l    #56,d0
[000052aa] 2c2e ffe8                 move.l     -24(a6),d6
[000052ae] 2e2e ffec                 move.l     -20(a6),d7
a.6div_9:
[000052b2] 41ee ffe4                 lea.l      -28(a6),a0
[000052b6] 2248                      movea.l    a0,a1
[000052b8] 2210                      move.l     (a0),d1
[000052ba] d391                      add.l      d1,(a1)
[000052bc] d388                      addx.l     -(a0),-(a1)
[000052be] bcae fff0                 cmp.l      -16(a6),d6
[000052c2] 6604                      bne.s      a.6div_6
[000052c4] beae fff4                 cmp.l      -12(a6),d7
a.6div_6:
[000052c8] 6212                      bhi.s      a.6div_7
[000052ca] 222e fff0                 move.l     -16(a6),d1
[000052ce] 9fae fff4                 sub.l      d7,-12(a6)
[000052d2] 9386                      subx.l     d6,d1
[000052d4] 2d41 fff0                 move.l     d1,-16(a6)
[000052d8] 522e ffe7                 addq.b     #1,-25(a6)
a.6div_7:
[000052dc] e28f                      lsr.l      #1,d7
[000052de] e28e                      lsr.l      #1,d6
[000052e0] 6404                      bcc.s      a.6div_8
[000052e2] 08c7 001f                 bset       #31,d7
a.6div_8:
[000052e6] 51c8 ffca                 dbf        d0,a.6div_9
[000052ea] 2f2e fff8                 move.l     -8(a6),-(a7)
[000052ee] 486e ffe0                 pea.l      -32(a6)
[000052f2] 4eb9 0000 5544            jsr        a.repk
[000052f8] 508f                      addq.l     #8,a7
[000052fa] 4aae ffe0                 tst.l      -32(a6)
[000052fe] 670c                      beq.s      a.6div_10
[00005300] 4a2e ffdf                 tst.b      -33(a6)
[00005304] 6706                      beq.s      a.6div_10
[00005306] 086e 0007 ffe0            bchg       #7,-32(a6)
a.6div_10:
[0000530c] 226e fffc                 movea.l    -4(a6),a1
[00005310] 22ee ffe0                 move.l     -32(a6),(a1)+
[00005314] 22ae ffe4                 move.l     -28(a6),(a1)
[00005318] 4aa1                      tst.l      -(a1)
a.6div_3:
[0000531a] 4cdf 06c6                 movem.l    (a7)+,d1-d2/d6-d7/a1-a2
[0000531e] 4e5e                      unlk       a6
[00005320] 4e75                      rts

a.1mul:
[00005322] 4e56 ffda                 link       a6,#-38
[00005326] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[0000532a] 43d7                      lea.l      (a7),a1
[0000532c] 2008                      move.l     a0,d0
[0000532e] 6618                      bne.s      a.1mul_1
[00005330] 41ef 0008                 lea.l      8(a7),a0
[00005334] 6012                      bra.s      a.1mul_1
a.1mul_1: ; not found: 00005348

a.6mul:
[00005336] 4e56 ffda                 link       a6,#-38
[0000533a] 48e7 6360                 movem.l    d1-d2/d6-d7/a1-a2,-(a7)
[0000533e] 43ef 0008                 lea.l      8(a7),a1
[00005342] 2008                      move.l     a0,d0
[00005344] 6602                      bne.s      a.6mul_1
[00005346] 41d7                      lea.l      (a7),a0
a.6mul_1:
[00005348] 2d49 fffc                 move.l     a1,-4(a6)
[0000534c] 2d48 fff8                 move.l     a0,-8(a6)
[00005350] 422e ffdb                 clr.b      -37(a6)
[00005354] 4a91                      tst.l      (a1)
[00005356] 6c08                      bge.s      a.6mul_2
[00005358] 0851 0007                 bchg       #7,(a1)
[0000535c] 462e ffdb                 not.b      -37(a6)
a.6mul_2:
[00005360] 4851                      pea.l      (a1)
[00005362] 486e ffec                 pea.l      -20(a6)
[00005366] 4eb9 0000 55d8            jsr        a.unpk
[0000536c] 508f                      addq.l     #8,a7
[0000536e] 2d47 fff4                 move.l     d7,-12(a6)
[00005372] 6700 009a                 beq        a.6mul_3
[00005376] 2f2e fff8                 move.l     -8(a6),-(a7)
[0000537a] 486e ffe4                 pea.l      -28(a6)
[0000537e] 4eb9 0000 55d8            jsr        a.unpk
[00005384] 508f                      addq.l     #8,a7
[00005386] 4a87                      tst.l      d7
[00005388] 660a                      bne.s      a.6mul_4
[0000538a] 206e fffc                 movea.l    -4(a6),a0
[0000538e] 4298                      clr.l      (a0)+
[00005390] 4290                      clr.l      (a0)
[00005392] 607a                      bra.s      a.6mul_3
a.6mul_4:
[00005394] 0487 0000 03fe            subi.l     #$000003FE,d7
[0000539a] dfae fff4                 add.l      d7,-12(a6)
[0000539e] 42ae ffdc                 clr.l      -36(a6)
[000053a2] 42ae ffe0                 clr.l      -32(a6)
[000053a6] 7037                      moveq.l    #55,d0
[000053a8] 2c2e ffe4                 move.l     -28(a6),d6
[000053ac] 2e2e ffe8                 move.l     -24(a6),d7
a.6mul_7:
[000053b0] e28f                      lsr.l      #1,d7
[000053b2] e286                      asr.l      #1,d6
[000053b4] 6404                      bcc.s      a.6mul_5
[000053b6] 08c7 001f                 bset       #31,d7
a.6mul_5:
[000053ba] 4a2e ffed                 tst.b      -19(a6)
[000053be] 6c0e                      bge.s      a.6mul_6
[000053c0] 222e ffdc                 move.l     -36(a6),d1
[000053c4] dfae ffe0                 add.l      d7,-32(a6)
[000053c8] d386                      addx.l     d6,d1
[000053ca] 2d41 ffdc                 move.l     d1,-36(a6)
a.6mul_6:
[000053ce] 41ee fff0                 lea.l      -16(a6),a0
[000053d2] 2248                      movea.l    a0,a1
[000053d4] 2210                      move.l     (a0),d1
[000053d6] d391                      add.l      d1,(a1)
[000053d8] d388                      addx.l     -(a0),-(a1)
[000053da] 51c8 ffd4                 dbf        d0,a.6mul_7
[000053de] 2f2e fff4                 move.l     -12(a6),-(a7)
[000053e2] 486e ffdc                 pea.l      -36(a6)
[000053e6] 4eb9 0000 5544            jsr        a.repk
[000053ec] 508f                      addq.l     #8,a7
[000053ee] 4a6e ffdc                 tst.w      -36(a6)
[000053f2] 670c                      beq.s      a.6mul_8
[000053f4] 4a2e ffdb                 tst.b      -37(a6)
[000053f8] 6706                      beq.s      a.6mul_8
[000053fa] 086e 0007 ffdc            bchg       #7,-36(a6)
a.6mul_8:
[00005400] 226e fffc                 movea.l    -4(a6),a1
[00005404] 22ee ffdc                 move.l     -36(a6),(a1)+
[00005408] 22ae ffe0                 move.l     -32(a6),(a1)
[0000540c] 4aa1                      tst.l      -(a1)
a.6mul_3:
[0000540e] 4cdf 06c6                 movem.l    (a7)+,d1-d2/d6-d7/a1-a2
[00005412] 4e5e                      unlk       a6
[00005414] 4e75                      rts

_fwrite:
[00005416] 4e56 0000                 link       a6,#0
[0000541a] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[0000541e] 2eae 0010                 move.l     16(a6),(a7)
[00005422] 2f2e 000c                 move.l     12(a6),-(a7)
[00005426] 2f2e 0008                 move.l     8(a6),-(a7)
[0000542a] 4eb9 0000 56a6            jsr        _write
[00005430] 508f                      addq.l     #8,a7
[00005432] beae 0010                 cmp.l      16(a6),d7
[00005436] 6710                      beq.s      _fwrite_1
[00005438] 2ebc 0000 7b94            move.l     #$0000D242,(a7)
[0000543e] 42a7                      clr.l      -(a7)
[00005440] 4eb9 0000 5462            jsr        __raise
[00005446] 588f                      addq.l     #4,a7
_fwrite_1:
[00005448] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[0000544c] 4e5e                      unlk       a6
[0000544e] 4e75                      rts

_lenstr:
[00005450] 206f 0004                 movea.l    4(a7),a0
_lenstr_1:
[00005454] 4a18                      tst.b      (a0)+
[00005456] 66fc                      bne.s      _lenstr_1
[00005458] 2e08                      move.l     a0,d7
[0000545a] 9eaf 0004                 sub.l      4(a7),d7
[0000545e] 5387                      subq.l     #1,d7
[00005460] 4e75                      rts

__raise:
[00005462] 246f 0004                 movea.l    4(a7),a2
[00005466] 262f 0008                 move.l     8(a7),d3
[0000546a] 2803                      move.l     d3,d4
[0000546c] 670c                      beq.s      __raise_1
[0000546e] 280a                      move.l     a2,d4
[00005470] 0c83 ffff ffff            cmpi.l     #$FFFFFFFF,d3
[00005476] 6602                      bne.s      __raise_1
[00005478] 4283                      clr.l      d3
__raise_1:
[0000547a] 200a                      move.l     a2,d0
[0000547c] 6708                      beq.s      __raise_2
[0000547e] b5fc ffff ffff            cmpa.l     #$FFFFFFFF,a2
[00005484] 660a                      bne.s      __raise_3
__raise_2:
[00005486] 2479 0000 7b78            movea.l    $0000D226,a2
[0000548c] 200a                      move.l     a2,d0
[0000548e] 674e                      beq.s      __raise_4
__raise_3:
[00005490] 4a83                      tst.l      d3
[00005492] 6626                      bne.s      __raise_5
[00005494] 4287                      clr.l      d7
__raise_12:
[00005496] 2e4a                      movea.l    a2,a7
[00005498] 4a84                      tst.l      d4
[0000549a] 6600 0096                 bne        __raise_6
[0000549e] 202a 0028                 move.l     40(a2),d0
[000054a2] 6704                      beq.s      __raise_7
[000054a4] 2040                      movea.l    d0,a0
[000054a6] 2083                      move.l     d3,(a0)
__raise_7:
[000054a8] 23df 0000 7b78            move.l     (a7)+,$0000D226
[000054ae] 4cdf 783a                 movem.l    (a7)+,d1/d3-d5/a3-a6
[000054b2] 4e75                      rts
__raise_8:
[000054b4] 2452                      movea.l    (a2),a2
[000054b6] 200a                      move.l     a2,d0
[000054b8] 6724                      beq.s      __raise_4
__raise_5:
[000054ba] 41ea 002c                 lea.l      44(a2),a0
[000054be] 2e08                      move.l     a0,d7
__raise_11:
[000054c0] 0c90 ffff ffff            cmpi.l     #$FFFFFFFF,(a0)
[000054c6] 67ec                      beq.s      __raise_8
[000054c8] 4a98                      tst.l      (a0)+
[000054ca] 6604                      bne.s      __raise_9
[000054cc] 4284                      clr.l      d4
[000054ce] 6006                      bra.s      __raise_10
__raise_9:
[000054d0] b6a8 fffc                 cmp.l      -4(a0),d3
[000054d4] 66ea                      bne.s      __raise_11
__raise_10:
[000054d6] 9e88                      sub.l      a0,d7
[000054d8] 4487                      neg.l      d7
[000054da] e487                      asr.l      #2,d7
[000054dc] 60b8                      bra.s      __raise_12
__raise_4:
[000054de] 42a7                      clr.l      -(a7)
[000054e0] 4a83                      tst.l      d3
[000054e2] 6706                      beq.s      __raise_13
[000054e4] 0803 0000                 btst       #0,d3
[000054e8] 6706                      beq.s      __raise_14
__raise_13:
[000054ea] 263c 0000 7b7c            move.l     #$0000D22A,d3
__raise_14:
[000054f0] 2043                      movea.l    d3,a0
[000054f2] 2f10                      move.l     (a0),-(a7)
[000054f4] 4eb9 0000 5668            jsr        _error
__raise_15:
[000054fa] 4e71                      nop
[000054fc] 60fc                      bra.s      __raise_15
__raise_6: ; not found: 00005532

__when:
[000054fe] 2039 0000 7b78            move.l     $0000D226,d0
[00005504] 720c                      moveq.l    #12,d1
[00005506] 48e7 dc1e                 movem.l    d0-d1/d3-d5/a3-a6,-(a7)
[0000550a] 244f                      movea.l    a7,a2
[0000550c] 202a 0028                 move.l     40(a2),d0
[00005510] 6704                      beq.s      __when_1
[00005512] 2040                      movea.l    d0,a0
[00005514] 208a                      move.l     a2,(a0)
__when_1:
[00005516] 41ea 002c                 lea.l      44(a2),a0
__when_3:
[0000551a] 4a90                      tst.l      (a0)
[0000551c] 6712                      beq.s      __when_2
[0000551e] 0c98 ffff ffff            cmpi.l     #$FFFFFFFF,(a0)+
[00005524] 670a                      beq.s      __when_2
[00005526] 06aa 0000 0004 0004       addi.l     #$00000004,4(a2)
[0000552e] 60ea                      bra.s      __when_3
__when_2:
[00005530] 7eff                      moveq.l    #-1,d7
[00005532] 23ca 0000 7b78            move.l     a2,$0000D226
[00005538] 206a 0024                 movea.l    36(a2),a0
[0000553c] 4cd2 783b                 movem.l    (a2),d0-d1/d3-d5/a3-a6
[00005540] 9fc1                      suba.l     d1,a7
[00005542] 4ed0                      jmp        (a0)

a.repk:
[00005544] 206f 0004                 movea.l    4(a7),a0
[00005548] 4280                      clr.l      d0
[0000554a] 2428 0004                 move.l     4(a0),d2
[0000554e] 2210                      move.l     (a0),d1
[00005550] 6c08                      bge.s      a.repk_1
[00005552] 08c0 001f                 bset       #31,d0
[00005556] 4482                      neg.l      d2
[00005558] 4081                      negx.l     d1
a.repk_1:
[0000555a] 6606                      bne.s      a.repk_2
[0000555c] 4a82                      tst.l      d2
[0000555e] 6602                      bne.s      a.repk_2
[00005560] 4e75                      rts
a.repk_2:
[00005562] 2e2f 0008                 move.l     8(a7),d7
[00005566] 5587                      subq.l     #2,d7
a.repk_4:
[00005568] 0c81 0040 0000            cmpi.l     #$00400000,d1
[0000556e] 650e                      bcs.s      a.repk_3
[00005570] 5287                      addq.l     #1,d7
[00005572] e28a                      lsr.l      #1,d2
[00005574] e281                      asr.l      #1,d1
[00005576] 64f0                      bcc.s      a.repk_4
[00005578] 08c2 001f                 bset       #31,d2
[0000557c] 60ea                      bra.s      a.repk_4
a.repk_3:
[0000557e] 0c81 0020 0000            cmpi.l     #$00200000,d1
[00005584] 640c                      bcc.s      a.repk_5
[00005586] 5387                      subq.l     #1,d7
[00005588] e389                      lsl.l      #1,d1
[0000558a] e38a                      lsl.l      #1,d2
[0000558c] 64f0                      bcc.s      a.repk_3
[0000558e] 5281                      addq.l     #1,d1
[00005590] 60ec                      bra.s      a.repk_3
a.repk_5:
[00005592] 0802 0000                 btst       #0,d2
[00005596] 6708                      beq.s      a.repk_6
[00005598] 5282                      addq.l     #1,d2
[0000559a] 6404                      bcc.s      a.repk_6
[0000559c] 5281                      addq.l     #1,d1
[0000559e] 60c8                      bra.s      a.repk_4
a.repk_6:
[000055a0] e28a                      lsr.l      #1,d2
[000055a2] e281                      asr.l      #1,d1
[000055a4] 6404                      bcc.s      a.repk_7
[000055a6] 08c2 001f                 bset       #31,d2
a.repk_7:
[000055aa] 4a87                      tst.l      d7
[000055ac] 6e06                      bgt.s      a.repk_8
[000055ae] 4298                      clr.l      (a0)+
[000055b0] 4290                      clr.l      (a0)
[000055b2] 4e75                      rts
a.repk_8:
[000055b4] 0c47 07ff                 cmpi.w     #$07FF,d7
[000055b8] 6f0c                      ble.s      a.repk_9
[000055ba] 72ff                      moveq.l    #-1,d1
[000055bc] 74ff                      moveq.l    #-1,d2
[000055be] 3e3c 07ff                 move.w     #$07FF,d7
[000055c2] 0881 001f                 bclr       #31,d1
a.repk_9:
[000055c6] 2081                      move.l     d1,(a0)
[000055c8] 0250 000f                 andi.w     #$000F,(a0)
[000055cc] e94f                      lsl.w      #4,d7
[000055ce] 8f50                      or.w       d7,(a0)
[000055d0] 2142 0004                 move.l     d2,4(a0)
[000055d4] 8190                      or.l       d0,(a0)
[000055d6] 4e75                      rts

a.unpk:
[000055d8] 4cd7 0301                 movem.l    (a7),d0/a0-a1
[000055dc] 3e11                      move.w     (a1),d7
[000055de] e88f                      lsr.l      #4,d7
[000055e0] 0287 0000 07ff            andi.l     #$000007FF,d7
[000055e6] 6606                      bne.s      a.unpk_1
[000055e8] 4298                      clr.l      (a0)+
[000055ea] 4290                      clr.l      (a0)
[000055ec] 4e75                      rts
a.unpk_1:
[000055ee] 2219                      move.l     (a1)+,d1
[000055f0] 2411                      move.l     (a1),d2
[000055f2] 0281 000f ffff            andi.l     #$000FFFFF,d1
[000055f8] 0081 0010 0000            ori.l      #$00100000,d1
[000055fe] 7002                      moveq.l    #2,d0
a.unpk_3:
[00005600] e389                      lsl.l      #1,d1
[00005602] e38a                      lsl.l      #1,d2
[00005604] 6402                      bcc.s      a.unpk_2
[00005606] 5281                      addq.l     #1,d1
a.unpk_2:
[00005608] 51c8 fff6                 dbf        d0,a.unpk_3
[0000560c] 4aa1                      tst.l      -(a1)
[0000560e] 6c04                      bge.s      a.unpk_4
[00005610] 4482                      neg.l      d2
[00005612] 4081                      negx.l     d1
a.unpk_4:
[00005614] 20c1                      move.l     d1,(a0)+
[00005616] 2082                      move.l     d2,(a0)
[00005618] 4e75                      rts

x561a:
[0000561a] 7772                      ???
[0000561c] 6974                      bvs.s      x561a_1
[0000561e] 6520                      bcs.s      x561a_2
[00005620] 6572                      bcs.s      x561a_3
[00005622] 726f                      moveq.l    #111,d1
[00005624] 7200                      moveq.l    #0,d1
[00005626] 4e56 0000                 link       a6,#0
[0000562a] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[0000562e] 2a6e 0008                 movea.l    8(a6),a5
[00005632] 2e0d                      move.l     a5,d7
[00005634] 670e                      beq.s      x561a_4
[00005636] 4a15                      tst.b      (a5)
[00005638] 670a                      beq.s      x561a_4
[0000563a] 284d                      movea.l    a5,a4
x561a_6:
[0000563c] 4a14                      tst.b      (a4)
[0000563e] 670c                      beq.s      x561a_5
x561a_2:
[00005640] 528c                      addq.l     #1,a4
[00005642] 60f8                      bra.s      x561a_6
x561a_4:
[00005644] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00005648] 4e5e                      unlk       a6
[0000564a] 4e75                      rts
x561a_5:
[0000564c] 2e0c                      move.l     a4,d7
[0000564e] 9e8d                      sub.l      a5,d7
[00005650] 2e87                      move.l     d7,(a7)
[00005652] 2f0d                      move.l     a5,-(a7)
[00005654] 4878 0002                 pea.l      ($00000002).w
[00005658] 4eb9 0000 56a6            jsr        _write
[0000565e] 508f                      addq.l     #8,a7
[00005660] 60e2                      bra.s      x561a_4
[00005662] 0a00 3a20                 eori.b     #$20,d0
[00005666] 0000                      dc.w       $0000
x561a_1: ; not found: 00005692
x561a_3: ; not found: 00005694

_error:
[00005668] 4e56 fffc                 link       a6,#-4
[0000566c] 2eb9 0000 6216            move.l     $0000B8C4,(a7)
[00005672] 4eba ffb2                 jsr        $00005626(pc)
[00005676] 2ebc 0000 5664            move.l     #$00005664,(a7)
[0000567c] 4eba ffa8                 jsr        $00005626(pc)
[00005680] 2eae 0008                 move.l     8(a6),(a7)
[00005684] 4eba ffa0                 jsr        $00005626(pc)
[00005688] 2eae 000c                 move.l     12(a6),(a7)
[0000568c] 4eba ff98                 jsr        $00005626(pc)
[00005690] 2ebc 0000 5662            move.l     #$00005662,(a7)
[00005696] 4eba ff8e                 jsr        $00005626(pc)
[0000569a] 4297                      clr.l      (a7)
[0000569c] 4eb9 0000 0080            jsr        _exit
[000056a2] 4e5e                      unlk       a6
[000056a4] 4e75                      rts

_write:
[000056a6] 205f                      movea.l    (a7)+,a0
[000056a8] 7e04                      moveq.l    #4,d7
[000056aa] 4e41                      trap       #1
[000056ac] 4ed0                      jmp        (a0)

	.data
[000056ae]                           dc.b $00
[000056af]                           dc.b 'idr68k Edition 3.2: Copyright (c) 1981,1983,1987 by Whitesmiths, Ltd. all rights reserved',0
[00005709]                           dc.b '|/bin/|/usr/bin/',0
[0000571a]                           dc.b 'PATH',0
[0000571f]                           dc.b $00
[00005720]                           dc.b $00
[00005721]                           dc.b $00
[00005722]                           dc.b $00
[00005723]                           dc.b $00
[00005724]                           dc.b $00
[00005725]                           dc.b $00
[00005726]                           dc.b $00
[00005727]                           dc.b $00
[00005728] 00005709                  dc.l $00005709 ; no symbol found
[0000572c] 000000aa                  dc.l _onexit
[00005730] 0000576d                  dc.l $0000576d ; no symbol found
[00005734]                           dc.b $00
[00005735]                           dc.b $00
[00005736]                           dc.b $00
[00005737]                           dc.b $1e
[00005738] 00005764                  dc.l $00005764 ; no symbol found
[0000573c]                           dc.b $00
[0000573d]                           dc.b $00
[0000573e]                           dc.b $00
[0000573f]                           dc.b $21
[00005740] 0000575a                  dc.l $0000575a ; no symbol found
[00005744]                           dc.b $00
[00005745]                           dc.b $00
[00005746]                           dc.b $00
[00005747]                           dc.b $1f
[00005748] 00005750                  dc.l $00005750 ; no symbol found
[0000574c]                           dc.b $00
[0000574d]                           dc.b $00
[0000574e]                           dc.b $00
[0000574f]                           dc.b $20
[00005750]                           dc.w $085f
[00005752]                           dc.b '_LINE__',0
[0000575a]                           dc.w $085f
[0000575c]                           dc.b '_FILE__',0
[00005764]                           dc.w $0764
[00005766]                           dc.b 'efined',0
[0000576d]                           dc.b $03
[0000576e]                           dc.b '$if',0
[00005772]                           dc.b $00
[00005773]                           dc.b $00
[00005774]                           dc.b $00
[00005775]                           dc.b $00
[00005776]                           dc.b $00
[00005777]                           dc.b $00
[00005778]                           dc.b $00
[00005779]                           dc.b $05
[0000577a]                           dc.b $00
[0000577b]                           dc.b $00
[0000577c]                           dc.b $00
[0000577d]                           dc.b $00
[0000577e]                           dc.b $00
[0000577f]                           dc.b $00
[00005780]                           dc.b $00
[00005781]                           dc.b $00
[00005782] 0000578a                  dc.l $0000578a ; no symbol found
[00005786]                           dc.b $00
[00005787]                           dc.b $00
[00005788]                           dc.b $00
[00005789]                           dc.b $01
[0000578a]                           dc.w $2c00
[0000578c]                           dc.b $00
[0000578d]                           dc.b $00
[0000578e]                           dc.b $00
[0000578f]                           dc.b $00
[00005790]                           dc.b $00
[00005791]                           dc.b $00
[00005792]                           dc.b $00
[00005793]                           dc.b $00
[00005794]                           dc.b $00
[00005795]                           dc.b $00
[00005796] 00000210                  dc.l $00000210 ; no symbol found
[0000579a]                           dc.b $00
[0000579b]                           dc.b $00
[0000579c]                           dc.b $00
[0000579d]                           dc.b $21
[0000579e] 000001da                  dc.l $000001da ; no symbol found
[000057a2]                           dc.b $00
[000057a3]                           dc.b $00
[000057a4]                           dc.b $00
[000057a5]                           dc.b $20
[000057a6] 0000019e                  dc.l $0000019e ; no symbol found
[000057aa]                           dc.b $00
[000057ab]                           dc.b $00
[000057ac]                           dc.b $00
[000057ad]                           dc.b $1f
[000057ae] 0000010e                  dc.l $0000010e ; no symbol found
[000057b2]                           dc.b $00
[000057b3]                           dc.b $00
[000057b4]                           dc.b $00
[000057b5]                           dc.b $1e
[000057b6]                           dc.b $00
[000057b7]                           dc.b $00
[000057b8]                           dc.b $00
[000057b9]                           dc.b $00
[000057ba] 00000194                  dc.l $00000194 ; no symbol found
[000057be]                           dc.w $3000
[000057c0]                           dc.w $3100
[000057c2]                           dc.b 'bad defined syntax',0
[000057d5]                           dc.b $30
[000057d6]                           dc.b $00
[000057d7]                           dc.b $31
[000057d8]                           dc.b $00
[000057d9]                           dc.b $00
[000057da]                           dc.b 'too many macro arguments',0
[000057f3]                           dc.b 'too few macro arguments',0
[0000580b]                           dc.b 'bad #define arguments',0
[00005821]                           dc.b $00
[00005822]                           dc.b 'bad $if(test)',0
[00005830]                           dc.b '$if expects arguments',0
[00005846]                           dc.b 'bad macro arguments',0
[0000585a]                           dc.w $e285
[0000585c]                           dc.w $99de
[0000585e]                           dc.w $d897
[00005860]                           dc.w $a095
[00005862]                           dc.w $968f
[00005864]                           dc.w $9094
[00005866]                           dc.w $9bc1
[00005868]                           dc.w $a39c
[0000586a]                           dc.w $829d
[0000586c]                           dc.w $9f00
[0000586e]                           dc.w $0e0e
[00005870]                           dc.w $0e0d
[00005872]                           dc.w $0d0c
[00005874]                           dc.w $0c0b
[00005876]                           dc.w $0b0b
[00005878]                           dc.w $0b0a
[0000587a]                           dc.w $0a09
[0000587c]                           dc.w $0807
[0000587e]                           dc.w $0605
[00005880]                           dc.w $0400
[00005882] 00005a92                  dc.l $00005a92 ; no symbol found
[00005886]                           dc.b $00
[00005887]                           dc.b $00
[00005888]                           dc.b $00
[00005889]                           dc.b $5a
[0000588a] 00005a8f                  dc.l $00005a8f ; no symbol found
[0000588e]                           dc.b $00
[0000588f]                           dc.b $00
[00005890]                           dc.b $00
[00005891]                           dc.b $99
[00005892] 00005a8c                  dc.l $00005a8c ; no symbol found
[00005896]                           dc.b $00
[00005897]                           dc.b $00
[00005898]                           dc.b $00
[00005899]                           dc.b $c1
[0000589a] 00005a89                  dc.l $00005a89 ; no symbol found
[0000589e]                           dc.b $00
[0000589f]                           dc.b $00
[000058a0]                           dc.b $00
[000058a1]                           dc.b $06
[000058a2] 00005a86                  dc.l $00005a86 ; no symbol found
[000058a6]                           dc.b $00
[000058a7]                           dc.b $00
[000058a8]                           dc.b $00
[000058a9]                           dc.b $0a
[000058aa] 00005a83                  dc.l $00005a83 ; no symbol found
[000058ae]                           dc.b $00
[000058af]                           dc.b $00
[000058b0]                           dc.b $00
[000058b1]                           dc.b $e2
[000058b2] 00005a80                  dc.l $00005a80 ; no symbol found
[000058b6]                           dc.b $00
[000058b7]                           dc.b $00
[000058b8]                           dc.b $00
[000058b9]                           dc.b $de
[000058ba] 00005a7d                  dc.l $00005a7d ; no symbol found
[000058be]                           dc.b $00
[000058bf]                           dc.b $00
[000058c0]                           dc.b $00
[000058c1]                           dc.b $02
[000058c2] 00005a7a                  dc.l $00005a7a ; no symbol found
[000058c6]                           dc.b $00
[000058c7]                           dc.b $00
[000058c8]                           dc.b $00
[000058c9]                           dc.b $d8
[000058ca] 00005a77                  dc.l $00005a77 ; no symbol found
[000058ce]                           dc.b $00
[000058cf]                           dc.b $00
[000058d0]                           dc.b $00
[000058d1]                           dc.b $03
[000058d2] 00005a74                  dc.l $00005a74 ; no symbol found
[000058d6]                           dc.b $00
[000058d7]                           dc.b $00
[000058d8]                           dc.b $00
[000058d9]                           dc.b $85
[000058da] 00005a71                  dc.l $00005a71 ; no symbol found
[000058de]                           dc.b $00
[000058df]                           dc.b $00
[000058e0]                           dc.b $00
[000058e1]                           dc.b $01
[000058e2] 00005a6e                  dc.l $00005a6e ; no symbol found
[000058e6]                           dc.b $00
[000058e7]                           dc.b $00
[000058e8]                           dc.b $00
[000058e9]                           dc.b $0b
[000058ea] 00005a6b                  dc.l $00005a6b ; no symbol found
[000058ee]                           dc.b $00
[000058ef]                           dc.b $00
[000058f0]                           dc.b $00
[000058f1]                           dc.b $95
[000058f2] 00005a68                  dc.l $00005a68 ; no symbol found
[000058f6]                           dc.b $00
[000058f7]                           dc.b $00
[000058f8]                           dc.b $00
[000058f9]                           dc.b $88
[000058fa] 00005a65                  dc.l $00005a65 ; no symbol found
[000058fe]                           dc.b $00
[000058ff]                           dc.b $00
[00005900]                           dc.b $00
[00005901]                           dc.b $8f
[00005902] 00005a62                  dc.l $00005a62 ; no symbol found
[00005906]                           dc.b $00
[00005907]                           dc.b $00
[00005908]                           dc.b $00
[00005909]                           dc.b $9f
[0000590a] 00005a5f                  dc.l $00005a5f ; no symbol found
[0000590e]                           dc.b $00
[0000590f]                           dc.b $00
[00005910]                           dc.b $00
[00005911]                           dc.b $04
[00005912] 00005a5c                  dc.l $00005a5c ; no symbol found
[00005916]                           dc.b $00
[00005917]                           dc.b $00
[00005918]                           dc.b $00
[00005919]                           dc.b $08
[0000591a] 00005a59                  dc.l $00005a59 ; no symbol found
[0000591e]                           dc.b $00
[0000591f]                           dc.b $00
[00005920]                           dc.b $00
[00005921]                           dc.b $a3
[00005922] 00005a56                  dc.l $00005a56 ; no symbol found
[00005926]                           dc.b $00
[00005927]                           dc.b $00
[00005928]                           dc.b $00
[00005929]                           dc.b $05
[0000592a] 00005a53                  dc.l $00005a53 ; no symbol found
[0000592e]                           dc.b $00
[0000592f]                           dc.b $00
[00005930]                           dc.b $00
[00005931]                           dc.b $9c
[00005932] 00005a50                  dc.l $00005a50 ; no symbol found
[00005936]                           dc.b $00
[00005937]                           dc.b $00
[00005938]                           dc.b $00
[00005939]                           dc.b $09
[0000593a] 00005a4d                  dc.l $00005a4d ; no symbol found
[0000593e]                           dc.b $00
[0000593f]                           dc.b $00
[00005940]                           dc.b $00
[00005941]                           dc.b $43
[00005942] 00005a49                  dc.l $00005a49 ; no symbol found
[00005946]                           dc.b $00
[00005947]                           dc.b $00
[00005948]                           dc.b $00
[00005949]                           dc.b $9b
[0000594a] 00005a45                  dc.l $00005a45 ; no symbol found
[0000594e]                           dc.b $00
[0000594f]                           dc.b $00
[00005950]                           dc.b $00
[00005951]                           dc.b $8c
[00005952] 00005a41                  dc.l $00005a41 ; no symbol found
[00005956]                           dc.b $00
[00005957]                           dc.b $00
[00005958]                           dc.b $00
[00005959]                           dc.b $82
[0000595a] 00005a3d                  dc.l $00005a3d ; no symbol found
[0000595e]                           dc.b $00
[0000595f]                           dc.b $00
[00005960]                           dc.b $00
[00005961]                           dc.b $86
[00005962] 00005a39                  dc.l $00005a39 ; no symbol found
[00005966]                           dc.b $00
[00005967]                           dc.b $00
[00005968]                           dc.b $00
[00005969]                           dc.b $91
[0000596a] 00005a35                  dc.l $00005a35 ; no symbol found
[0000596e]                           dc.b $00
[0000596f]                           dc.b $00
[00005970]                           dc.b $00
[00005971]                           dc.b $53
[00005972] 00005a31                  dc.l $00005a31 ; no symbol found
[00005976]                           dc.b $00
[00005977]                           dc.b $00
[00005978]                           dc.b $00
[00005979]                           dc.b $8e
[0000597a] 00005a2d                  dc.l $00005a2d ; no symbol found
[0000597e]                           dc.b $00
[0000597f]                           dc.b $00
[00005980]                           dc.b $00
[00005981]                           dc.b $44
[00005982] 00005a29                  dc.l $00005a29 ; no symbol found
[00005986]                           dc.b $00
[00005987]                           dc.b $00
[00005988]                           dc.b $00
[00005989]                           dc.b $8b
[0000598a] 00005a25                  dc.l $00005a25 ; no symbol found
[0000598e]                           dc.b $00
[0000598f]                           dc.b $00
[00005990]                           dc.b $00
[00005991]                           dc.b $07
[00005992] 00005a21                  dc.l $00005a21 ; no symbol found
[00005996]                           dc.b $00
[00005997]                           dc.b $00
[00005998]                           dc.b $00
[00005999]                           dc.b $87
[0000599a] 00005a1d                  dc.l $00005a1d ; no symbol found
[0000599e]                           dc.b $00
[0000599f]                           dc.b $00
[000059a0]                           dc.b $00
[000059a1]                           dc.b $97
[000059a2] 00005a19                  dc.l $00005a19 ; no symbol found
[000059a6]                           dc.b $00
[000059a7]                           dc.b $00
[000059a8]                           dc.b $00
[000059a9]                           dc.b $96
[000059aa] 00005a15                  dc.l $00005a15 ; no symbol found
[000059ae]                           dc.b $00
[000059af]                           dc.b $00
[000059b0]                           dc.b $00
[000059b1]                           dc.b $94
[000059b2] 00005a11                  dc.l $00005a11 ; no symbol found
[000059b6]                           dc.b $00
[000059b7]                           dc.b $00
[000059b8]                           dc.b $00
[000059b9]                           dc.b $90
[000059ba] 00005a0d                  dc.l $00005a0d ; no symbol found
[000059be]                           dc.b $00
[000059bf]                           dc.b $00
[000059c0]                           dc.b $00
[000059c1]                           dc.b $a0
[000059c2] 00005a09                  dc.l $00005a09 ; no symbol found
[000059c6]                           dc.b $00
[000059c7]                           dc.b $00
[000059c8]                           dc.b $00
[000059c9]                           dc.b $92
[000059ca] 00005a05                  dc.l $00005a05 ; no symbol found
[000059ce]                           dc.b $00
[000059cf]                           dc.b $00
[000059d0]                           dc.b $00
[000059d1]                           dc.b $8d
[000059d2] 00005a01                  dc.l $00005a01 ; no symbol found
[000059d6]                           dc.b $00
[000059d7]                           dc.b $00
[000059d8]                           dc.b $00
[000059d9]                           dc.b $9d
[000059da] 000059fc                  dc.l $000059fc ; no symbol found
[000059de]                           dc.b $00
[000059df]                           dc.b $00
[000059e0]                           dc.b $00
[000059e1]                           dc.b $0d
[000059e2] 000059f7                  dc.l $000059f7 ; no symbol found
[000059e6]                           dc.b $00
[000059e7]                           dc.b $00
[000059e8]                           dc.b $00
[000059e9]                           dc.b $89
[000059ea] 000059f2                  dc.l $000059f2 ; no symbol found
[000059ee]                           dc.b $00
[000059ef]                           dc.b $00
[000059f0]                           dc.b $00
[000059f1]                           dc.b $8a
[000059f2]                           dc.w $033e
[000059f4]                           dc.w $3e3d
[000059f6]                           dc.b $00
[000059f7]                           dc.b $03
[000059f8]                           dc.b '<<=',0
[000059fc]                           dc.w $032e
[000059fe]                           dc.w $2e2e
[00005a00]                           dc.b $00
[00005a01]                           dc.b $02
[00005a02]                           dc.w $7c7c
[00005a04]                           dc.b $00
[00005a05]                           dc.b $02
[00005a06]                           dc.w $7c3d
[00005a08]                           dc.b $00
[00005a09]                           dc.b $02
[00005a0a]                           dc.w $5e3d
[00005a0c]                           dc.b $00
[00005a0d]                           dc.b $02
[00005a0e]                           dc.w $3e3e
[00005a10]                           dc.b $00
[00005a11]                           dc.b $02
[00005a12]                           dc.w $3e3d
[00005a14]                           dc.b $00
[00005a15]                           dc.b $02
[00005a16]                           dc.w $3d3d
[00005a18]                           dc.b $00
[00005a19]                           dc.b $02
[00005a1a]                           dc.w $3c3d
[00005a1c]                           dc.b $00
[00005a1d]                           dc.b $02
[00005a1e]                           dc.w $3c3c
[00005a20]                           dc.b $00
[00005a21]                           dc.b $02
[00005a22]                           dc.w $2f3d
[00005a24]                           dc.b $00
[00005a25]                           dc.b $02
[00005a26]                           dc.w $2d3e
[00005a28]                           dc.b $00
[00005a29]                           dc.b $02
[00005a2a]                           dc.w $2d3d
[00005a2c]                           dc.b $00
[00005a2d]                           dc.b $02
[00005a2e]                           dc.w $2d2d
[00005a30]                           dc.b $00
[00005a31]                           dc.b $02
[00005a32]                           dc.w $2b3d
[00005a34]                           dc.b $00
[00005a35]                           dc.b $02
[00005a36]                           dc.w $2b2b
[00005a38]                           dc.b $00
[00005a39]                           dc.b $02
[00005a3a]                           dc.w $2a3d
[00005a3c]                           dc.b $00
[00005a3d]                           dc.b $02
[00005a3e]                           dc.w $263d
[00005a40]                           dc.b $00
[00005a41]                           dc.b $02
[00005a42]                           dc.w $2626
[00005a44]                           dc.b $00
[00005a45]                           dc.b $02
[00005a46]                           dc.w $253d
[00005a48]                           dc.b $00
[00005a49]                           dc.b $02
[00005a4a]                           dc.w $213d
[00005a4c]                           dc.b $00
[00005a4d]                           dc.b $01
[00005a4e]                           dc.w $7e00
[00005a50]                           dc.w $017d
[00005a52]                           dc.b $00
[00005a53]                           dc.b $01
[00005a54]                           dc.w $7c00
[00005a56]                           dc.w $017b
[00005a58]                           dc.b $00
[00005a59]                           dc.b $01
[00005a5a]                           dc.w $5e00
[00005a5c]                           dc.w $015d
[00005a5e]                           dc.b $00
[00005a5f]                           dc.b $01
[00005a60]                           dc.w $5b00
[00005a62]                           dc.w $013f
[00005a64]                           dc.b $00
[00005a65]                           dc.b $01
[00005a66]                           dc.w $3e00
[00005a68]                           dc.w $013d
[00005a6a]                           dc.b $00
[00005a6b]                           dc.b $01
[00005a6c]                           dc.w $3c00
[00005a6e]                           dc.w $013b
[00005a70]                           dc.b $00
[00005a71]                           dc.b $01
[00005a72]                           dc.w $3a00
[00005a74]                           dc.w $012f
[00005a76]                           dc.b $00
[00005a77]                           dc.b $01
[00005a78]                           dc.w $2e00
[00005a7a]                           dc.w $012d
[00005a7c]                           dc.b $00
[00005a7d]                           dc.b $01
[00005a7e]                           dc.w $2c00
[00005a80]                           dc.w $012b
[00005a82]                           dc.b $00
[00005a83]                           dc.b $01
[00005a84]                           dc.w $2a00
[00005a86]                           dc.w $0129
[00005a88]                           dc.b $00
[00005a89]                           dc.b $01
[00005a8a]                           dc.w $2800
[00005a8c]                           dc.w $0126
[00005a8e]                           dc.b $00
[00005a8f]                           dc.b $01
[00005a90]                           dc.w $2500
[00005a92]                           dc.w $0121
[00005a94]                           dc.b $00
[00005a95]                           dc.b $00
[00005a96] 00005b91                  dc.l $00005b91 ; no symbol found
[00005a9a]                           dc.b $00
[00005a9b]                           dc.b $00
[00005a9c]                           dc.b $00
[00005a9d]                           dc.b $0c
[00005a9e] 00005b8d                  dc.l $00005b8d ; no symbol found
[00005aa2]                           dc.b $00
[00005aa3]                           dc.b $00
[00005aa4]                           dc.b $00
[00005aa5]                           dc.b $05
[00005aa6] 00005b89                  dc.l $00005b89 ; no symbol found
[00005aaa]                           dc.b $00
[00005aab]                           dc.b $00
[00005aac]                           dc.b $00
[00005aad]                           dc.b $04
[00005aae] 00005b85                  dc.l $00005b85 ; no symbol found
[00005ab2]                           dc.b $00
[00005ab3]                           dc.b $00
[00005ab4]                           dc.b $00
[00005ab5]                           dc.b $0e
[00005ab6] 00005b81                  dc.l $00005b81 ; no symbol found
[00005aba]                           dc.b $00
[00005abb]                           dc.b $00
[00005abc]                           dc.b $00
[00005abd]                           dc.b $8c
[00005abe] 00005b7d                  dc.l $00005b7d ; no symbol found
[00005ac2]                           dc.b $00
[00005ac3]                           dc.b $00
[00005ac4]                           dc.b $00
[00005ac5]                           dc.b $86
[00005ac6] 00005b79                  dc.l $00005b79 ; no symbol found
[00005aca]                           dc.b $00
[00005acb]                           dc.b $00
[00005acc]                           dc.b $00
[00005acd]                           dc.b $91
[00005ace] 00005b75                  dc.l $00005b75 ; no symbol found
[00005ad2]                           dc.b $00
[00005ad3]                           dc.b $00
[00005ad4]                           dc.b $00
[00005ad5]                           dc.b $8e
[00005ad6] 00005b71                  dc.l $00005b71 ; no symbol found
[00005ada]                           dc.b $00
[00005adb]                           dc.b $00
[00005adc]                           dc.b $00
[00005add]                           dc.b $8b
[00005ade] 00005b6d                  dc.l $00005b6d ; no symbol found
[00005ae2]                           dc.b $00
[00005ae3]                           dc.b $00
[00005ae4]                           dc.b $00
[00005ae5]                           dc.b $87
[00005ae6] 00005b69                  dc.l $00005b69 ; no symbol found
[00005aea]                           dc.b $00
[00005aeb]                           dc.b $00
[00005aec]                           dc.b $00
[00005aed]                           dc.b $92
[00005aee] 00005b65                  dc.l $00005b65 ; no symbol found
[00005af2]                           dc.b $00
[00005af3]                           dc.b $00
[00005af4]                           dc.b $00
[00005af5]                           dc.b $8d
[00005af6] 00005b61                  dc.l $00005b61 ; no symbol found
[00005afa]                           dc.b $00
[00005afb]                           dc.b $00
[00005afc]                           dc.b $00
[00005afd]                           dc.b $09
[00005afe] 00005b5d                  dc.l $00005b5d ; no symbol found
[00005b02]                           dc.b $00
[00005b03]                           dc.b $00
[00005b04]                           dc.b $00
[00005b05]                           dc.b $9c
[00005b06] 00005b59                  dc.l $00005b59 ; no symbol found
[00005b0a]                           dc.b $00
[00005b0b]                           dc.b $00
[00005b0c]                           dc.b $00
[00005b0d]                           dc.b $05
[00005b0e] 00005b55                  dc.l $00005b55 ; no symbol found
[00005b12]                           dc.b $00
[00005b13]                           dc.b $00
[00005b14]                           dc.b $00
[00005b15]                           dc.b $09
[00005b16] 00005b51                  dc.l $00005b51 ; no symbol found
[00005b1a]                           dc.b $00
[00005b1b]                           dc.b $00
[00005b1c]                           dc.b $00
[00005b1d]                           dc.b $43
[00005b1e] 00005b4d                  dc.l $00005b4d ; no symbol found
[00005b22]                           dc.b $00
[00005b23]                           dc.b $00
[00005b24]                           dc.b $00
[00005b25]                           dc.b $08
[00005b26] 00005b48                  dc.l $00005b48 ; no symbol found
[00005b2a]                           dc.b $00
[00005b2b]                           dc.b $00
[00005b2c]                           dc.b $00
[00005b2d]                           dc.b $89
[00005b2e] 00005b43                  dc.l $00005b43 ; no symbol found
[00005b32]                           dc.b $00
[00005b33]                           dc.b $00
[00005b34]                           dc.b $00
[00005b35]                           dc.b $8a
[00005b36] 00005b3e                  dc.l $00005b3e ; no symbol found
[00005b3a]                           dc.b $00
[00005b3b]                           dc.b $00
[00005b3c]                           dc.b $00
[00005b3d]                           dc.b $9d
[00005b3e]                           dc.w $035c
[00005b40]                           dc.w $2121
[00005b42]                           dc.b $00
[00005b43]                           dc.b $03
[00005b44]                           dc.b '=>>',0
[00005b48]                           dc.w $033d
[00005b4a]                           dc.w $3c3c
[00005b4c]                           dc.b $00
[00005b4d]                           dc.b $02
[00005b4e]                           dc.w $7c29
[00005b50]                           dc.b $00
[00005b51]                           dc.b $02
[00005b52]                           dc.w $5c5e
[00005b54]                           dc.b $00
[00005b55]                           dc.b $02
[00005b56]                           dc.w $5c29
[00005b58]                           dc.b $00
[00005b59]                           dc.b $02
[00005b5a]                           dc.w $5c28
[00005b5c]                           dc.b $00
[00005b5d]                           dc.b $02
[00005b5e]                           dc.w $5c21
[00005b60]                           dc.b $00
[00005b61]                           dc.b $02
[00005b62]                           dc.w $3e29
[00005b64]                           dc.b $00
[00005b65]                           dc.b $02
[00005b66]                           dc.w $3d7c
[00005b68]                           dc.b $00
[00005b69]                           dc.b $02
[00005b6a]                           dc.w $3d5e
[00005b6c]                           dc.b $00
[00005b6d]                           dc.b $02
[00005b6e]                           dc.w $3d2f
[00005b70]                           dc.b $00
[00005b71]                           dc.b $02
[00005b72]                           dc.w $3d2d
[00005b74]                           dc.b $00
[00005b75]                           dc.b $02
[00005b76]                           dc.w $3d2b
[00005b78]                           dc.b $00
[00005b79]                           dc.b $02
[00005b7a]                           dc.w $3d2a
[00005b7c]                           dc.b $00
[00005b7d]                           dc.b $02
[00005b7e]                           dc.w $3d26
[00005b80]                           dc.b $00
[00005b81]                           dc.b $02
[00005b82]                           dc.w $3d25
[00005b84]                           dc.b $00
[00005b85]                           dc.b $02
[00005b86]                           dc.w $2e2e
[00005b88]                           dc.b $00
[00005b89]                           dc.b $02
[00005b8a]                           dc.w $287c
[00005b8c]                           dc.b $00
[00005b8d]                           dc.b $02
[00005b8e]                           dc.w $283c
[00005b90]                           dc.b $00
[00005b91]                           dc.b $01
[00005b92]                           dc.w $4000
[00005b94]                           dc.b $00
[00005b95]                           dc.b $01
[00005b96]                           dc.w $0203
[00005b98]                           dc.w $0405
[00005b9a]                           dc.w $0607
[00005b9c]                           dc.w $0809
[00005b9e]                           dc.w $0a0b
[00005ba0]                           dc.w $0c0d
[00005ba2]                           dc.w $0e0f
[00005ba4]                           dc.w $1011
[00005ba6]                           dc.w $1213
[00005ba8]                           dc.w $1415
[00005baa]                           dc.w $1617
[00005bac]                           dc.w $1819
[00005bae]                           dc.w $1a1b
[00005bb0]                           dc.w $1c1d
[00005bb2]                           dc.w $1e1f
[00005bb4]                           dc.b ' !"#$%&',$27,'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~'
[00005c13]                           dc.b $7f
[00005c14]                           dc.w $8081
[00005c16]                           dc.w $8283
[00005c18]                           dc.w $8485
[00005c1a]                           dc.w $8687
[00005c1c]                           dc.w $8889
[00005c1e]                           dc.w $8a8b
[00005c20]                           dc.w $8c8d
[00005c22]                           dc.w $8e8f
[00005c24]                           dc.w $9091
[00005c26]                           dc.w $9293
[00005c28]                           dc.w $9495
[00005c2a]                           dc.w $9697
[00005c2c]                           dc.w $9899
[00005c2e]                           dc.w $9a9b
[00005c30]                           dc.w $9c9d
[00005c32]                           dc.w $9e9f
[00005c34]                           dc.w $a0a1
[00005c36]                           dc.w $a2a3
[00005c38]                           dc.w $a4a5
[00005c3a]                           dc.w $a6a7
[00005c3c]                           dc.w $a8a9
[00005c3e]                           dc.w $aaab
[00005c40]                           dc.w $acad
[00005c42]                           dc.w $aeaf
[00005c44]                           dc.w $b0b1
[00005c46]                           dc.w $b2b3
[00005c48]                           dc.w $b4b5
[00005c4a]                           dc.w $b6b7
[00005c4c]                           dc.w $b8b9
[00005c4e]                           dc.w $babb
[00005c50]                           dc.w $bcbd
[00005c52]                           dc.w $bebf
[00005c54]                           dc.w $c0c1
[00005c56]                           dc.w $c2c3
[00005c58]                           dc.w $c4c5
[00005c5a]                           dc.w $c6c7
[00005c5c]                           dc.w $c8c9
[00005c5e]                           dc.w $cacb
[00005c60]                           dc.w $cccd
[00005c62]                           dc.w $cecf
[00005c64]                           dc.w $d0d1
[00005c66]                           dc.w $d2d3
[00005c68]                           dc.w $d4d5
[00005c6a]                           dc.w $d6d7
[00005c6c]                           dc.w $d8d9
[00005c6e]                           dc.w $dadb
[00005c70]                           dc.w $dcdd
[00005c72]                           dc.w $dedf
[00005c74]                           dc.w $e0e1
[00005c76]                           dc.w $e2e3
[00005c78]                           dc.w $e4e5
[00005c7a]                           dc.w $e6e7
[00005c7c]                           dc.w $e8e9
[00005c7e]                           dc.w $eaeb
[00005c80]                           dc.w $eced
[00005c82]                           dc.w $eeef
[00005c84]                           dc.w $f0f1
[00005c86]                           dc.w $f2f3
[00005c88]                           dc.w $f4f5
[00005c8a]                           dc.w $f6f7
[00005c8c]                           dc.w $f8f9
[00005c8e]                           dc.w $fafb
[00005c90]                           dc.w $fcfd
[00005c92]                           dc.w $feff
[00005c94]                           dc.b '0123456789abcdefABCDEF',0
[00005cab]                           dc.b $00
[00005cac]                           dc.w $0102
[00005cae]                           dc.w $0304
[00005cb0]                           dc.w $0506
[00005cb2]                           dc.w $0708
[00005cb4]                           dc.w $090a
[00005cb6]                           dc.w $0b0c
[00005cb8]                           dc.w $0d0e
[00005cba]                           dc.w $0f0a
[00005cbc]                           dc.w $0b0c
[00005cbe]                           dc.w $0d0e
[00005cc0]                           dc.w $0f00
[00005cc2]                           dc.b 'abnfrtv(!)^',0
[00005cce]                           dc.w $0708
[00005cd0]                           dc.w $0a0c
[00005cd2]                           dc.w $0d09
[00005cd4]                           dc.w $0b7b
[00005cd6]                           dc.b '|}~',0
[00005cda]                           dc.b 'illegal character: %c',0
[00005cf0]                           dc.b 'illegal #if expression',0
[00005d07]                           dc.b $00
[00005d08] 000010b6                  dc.l $000010b6 ; no symbol found
[00005d0c]                           dc.b $00
[00005d0d]                           dc.b $00
[00005d0e]                           dc.b $00
[00005d0f]                           dc.b $9f
[00005d10] 0000109c                  dc.l $0000109c ; no symbol found
[00005d14]                           dc.b $00
[00005d15]                           dc.b $00
[00005d16]                           dc.b $00
[00005d17]                           dc.b $9d
[00005d18] 00001082                  dc.l $00001082 ; no symbol found
[00005d1c]                           dc.b $00
[00005d1d]                           dc.b $00
[00005d1e]                           dc.b $00
[00005d1f]                           dc.b $82
[00005d20] 0000106e                  dc.l $0000106e ; no symbol found
[00005d24]                           dc.b $00
[00005d25]                           dc.b $00
[00005d26]                           dc.b $00
[00005d27]                           dc.b $90
[00005d28] 0000105a                  dc.l $0000105a ; no symbol found
[00005d2c]                           dc.b $00
[00005d2d]                           dc.b $00
[00005d2e]                           dc.b $00
[00005d2f]                           dc.b $9b
[00005d30] 00001046                  dc.l $00001046 ; no symbol found
[00005d34]                           dc.b $00
[00005d35]                           dc.b $00
[00005d36]                           dc.b $00
[00005d37]                           dc.b $96
[00005d38] 00001032                  dc.l $00001032 ; no symbol found
[00005d3c]                           dc.b $00
[00005d3d]                           dc.b $00
[00005d3e]                           dc.b $00
[00005d3f]                           dc.b $8f
[00005d40] 0000101e                  dc.l $0000101e ; no symbol found
[00005d44]                           dc.b $00
[00005d45]                           dc.b $00
[00005d46]                           dc.b $00
[00005d47]                           dc.b $94
[00005d48] 0000100a                  dc.l $0000100a ; no symbol found
[00005d4c]                           dc.b $00
[00005d4d]                           dc.b $00
[00005d4e]                           dc.b $00
[00005d4f]                           dc.b $95
[00005d50] 00000ff8                  dc.l $00000ff8 ; no symbol found
[00005d54]                           dc.b $00
[00005d55]                           dc.b $00
[00005d56]                           dc.b $00
[00005d57]                           dc.b $a0
[00005d58] 00000fe6                  dc.l $00000fe6 ; no symbol found
[00005d5c]                           dc.b $00
[00005d5d]                           dc.b $00
[00005d5e]                           dc.b $00
[00005d5f]                           dc.b $97
[00005d60] 00000fdc                  dc.l $00000fdc ; no symbol found
[00005d64]                           dc.b $00
[00005d65]                           dc.b $00
[00005d66]                           dc.b $00
[00005d67]                           dc.b $a3
[00005d68] 00000fd2                  dc.l $00000fd2 ; no symbol found
[00005d6c]                           dc.b $00
[00005d6d]                           dc.b $00
[00005d6e]                           dc.b $00
[00005d6f]                           dc.b $9c
[00005d70] 00000fc8                  dc.l $00000fc8 ; no symbol found
[00005d74]                           dc.b $00
[00005d75]                           dc.b $00
[00005d76]                           dc.b $00
[00005d77]                           dc.b $c1
[00005d78] 00000fb4                  dc.l $00000fb4 ; no symbol found
[00005d7c]                           dc.b $00
[00005d7d]                           dc.b $00
[00005d7e]                           dc.b $00
[00005d7f]                           dc.b $99
[00005d80] 00000fa0                  dc.l $00000fa0 ; no symbol found
[00005d84]                           dc.b $00
[00005d85]                           dc.b $00
[00005d86]                           dc.b $00
[00005d87]                           dc.b $85
[00005d88] 00000f8c                  dc.l $00000f8c ; no symbol found
[00005d8c]                           dc.b $00
[00005d8d]                           dc.b $00
[00005d8e]                           dc.b $00
[00005d8f]                           dc.b $e2
[00005d90] 00000f84                  dc.l $00000f84 ; no symbol found
[00005d94]                           dc.b $00
[00005d95]                           dc.b $00
[00005d96]                           dc.b $00
[00005d97]                           dc.b $d8
[00005d98] 00000f68                  dc.l $00000f68 ; no symbol found
[00005d9c]                           dc.b $00
[00005d9d]                           dc.b $00
[00005d9e]                           dc.b $00
[00005d9f]                           dc.b $de
[00005da0]                           dc.b $00
[00005da1]                           dc.b $00
[00005da2]                           dc.b $00
[00005da3]                           dc.b $00
[00005da4] 0000111a                  dc.l $0000111a ; no symbol found
[00005da8]                           dc.b 'illegal operator in #if',0
[00005dc0]                           dc.b 'illegal ? : in #if',0
[00005dd3]                           dc.b $00
[00005dd4]                           dc.b 'illegal unary op in #if',0
[00005dec]                           dc.b 'illegal #if syntax',0
[00005dff]                           dc.b 'missing ) in #if',0
[00005e10] 00006003                  dc.l $00006003 ; no symbol found
[00005e14]                           dc.b $00
[00005e15]                           dc.b $00
[00005e16]                           dc.b $00
[00005e17]                           dc.b $27
[00005e18] 00005fff                  dc.l $00005fff ; no symbol found
[00005e1c]                           dc.b $00
[00005e1d]                           dc.b $00
[00005e1e]                           dc.b $00
[00005e1f]                           dc.b $2e
[00005e20] 00005ffa                  dc.l $00005ffa ; no symbol found
[00005e24]                           dc.b $00
[00005e25]                           dc.b $00
[00005e26]                           dc.b $00
[00005e27]                           dc.b $2c
[00005e28] 00005ff5                  dc.l $00005ff5 ; no symbol found
[00005e2c]                           dc.b $00
[00005e2d]                           dc.b $00
[00005e2e]                           dc.b $00
[00005e2f]                           dc.b $2f
[00005e30] 00005fef                  dc.l $00005fef ; no symbol found
[00005e34]                           dc.b $00
[00005e35]                           dc.b $00
[00005e36]                           dc.b $00
[00005e37]                           dc.b $21
[00005e38] 00005fe9                  dc.l $00005fe9 ; no symbol found
[00005e3c]                           dc.b $00
[00005e3d]                           dc.b $00
[00005e3e]                           dc.b $00
[00005e3f]                           dc.b $23
[00005e40] 00005fe3                  dc.l $00005fe3 ; no symbol found
[00005e44]                           dc.b $00
[00005e45]                           dc.b $00
[00005e46]                           dc.b $00
[00005e47]                           dc.b $24
[00005e48] 00005fdd                  dc.l $00005fdd ; no symbol found
[00005e4c]                           dc.b $00
[00005e4d]                           dc.b $00
[00005e4e]                           dc.b $00
[00005e4f]                           dc.b $29
[00005e50] 00005fd7                  dc.l $00005fd7 ; no symbol found
[00005e54]                           dc.b $00
[00005e55]                           dc.b $00
[00005e56]                           dc.b $00
[00005e57]                           dc.b $3c
[00005e58] 00005fd1                  dc.l $00005fd1 ; no symbol found
[00005e5c]                           dc.b $00
[00005e5d]                           dc.b $00
[00005e5e]                           dc.b $00
[00005e5f]                           dc.b $2d
[00005e60] 00005fcb                  dc.l $00005fcb ; no symbol found
[00005e64]                           dc.b $00
[00005e65]                           dc.b $00
[00005e66]                           dc.b $00
[00005e67]                           dc.b $30
[00005e68] 00005fc5                  dc.l $00005fc5 ; no symbol found
[00005e6c]                           dc.b $00
[00005e6d]                           dc.b $00
[00005e6e]                           dc.b $00
[00005e6f]                           dc.b $3e
[00005e70] 00005fbe                  dc.l $00005fbe ; no symbol found
[00005e74]                           dc.b $00
[00005e75]                           dc.b $00
[00005e76]                           dc.b $00
[00005e77]                           dc.b $22
[00005e78] 00005fb7                  dc.l $00005fb7 ; no symbol found
[00005e7c]                           dc.b $00
[00005e7d]                           dc.b $00
[00005e7e]                           dc.b $00
[00005e7f]                           dc.b $3b
[00005e80] 00005fb0                  dc.l $00005fb0 ; no symbol found
[00005e84]                           dc.b $00
[00005e85]                           dc.b $00
[00005e86]                           dc.b $00
[00005e87]                           dc.b $2b
[00005e88] 00005fa9                  dc.l $00005fa9 ; no symbol found
[00005e8c]                           dc.b $00
[00005e8d]                           dc.b $00
[00005e8e]                           dc.b $00
[00005e8f]                           dc.b $33
[00005e90] 00005fa2                  dc.l $00005fa2 ; no symbol found
[00005e94]                           dc.b $00
[00005e95]                           dc.b $00
[00005e96]                           dc.b $00
[00005e97]                           dc.b $38
[00005e98] 00005f9b                  dc.l $00005f9b ; no symbol found
[00005e9c]                           dc.b $00
[00005e9d]                           dc.b $00
[00005e9e]                           dc.b $00
[00005e9f]                           dc.b $3a
[00005ea0] 00005f93                  dc.l $00005f93 ; no symbol found
[00005ea4]                           dc.b $00
[00005ea5]                           dc.b $00
[00005ea6]                           dc.b $00
[00005ea7]                           dc.b $28
[00005ea8] 00005f8b                  dc.l $00005f8b ; no symbol found
[00005eac]                           dc.b $00
[00005ead]                           dc.b $00
[00005eae]                           dc.b $00
[00005eaf]                           dc.b $2a
[00005eb0] 00005f83                  dc.l $00005f83 ; no symbol found
[00005eb4]                           dc.b $00
[00005eb5]                           dc.b $00
[00005eb6]                           dc.b $00
[00005eb7]                           dc.b $32
[00005eb8] 00005f7b                  dc.l $00005f7b ; no symbol found
[00005ebc]                           dc.b $00
[00005ebd]                           dc.b $00
[00005ebe]                           dc.b $00
[00005ebf]                           dc.b $3d
[00005ec0] 00005f73                  dc.l $00005f73 ; no symbol found
[00005ec4]                           dc.b $00
[00005ec5]                           dc.b $00
[00005ec6]                           dc.b $00
[00005ec7]                           dc.b $61
[00005ec8] 00005f6b                  dc.l $00005f6b ; no symbol found
[00005ecc]                           dc.b $00
[00005ecd]                           dc.b $00
[00005ece]                           dc.b $00
[00005ecf]                           dc.b $34
[00005ed0] 00005f63                  dc.l $00005f63 ; no symbol found
[00005ed4]                           dc.b $00
[00005ed5]                           dc.b $00
[00005ed6]                           dc.b $00
[00005ed7]                           dc.b $35
[00005ed8] 00005f5b                  dc.l $00005f5b ; no symbol found
[00005edc]                           dc.b $00
[00005edd]                           dc.b $00
[00005ede]                           dc.b $00
[00005edf]                           dc.b $36
[00005ee0] 00005f52                  dc.l $00005f52 ; no symbol found
[00005ee4]                           dc.b $00
[00005ee5]                           dc.b $00
[00005ee6]                           dc.b $00
[00005ee7]                           dc.b $60
[00005ee8] 00005f49                  dc.l $00005f49 ; no symbol found
[00005eec]                           dc.b $00
[00005eed]                           dc.b $00
[00005eee]                           dc.b $00
[00005eef]                           dc.b $26
[00005ef0] 00005f40                  dc.l $00005f40 ; no symbol found
[00005ef4]                           dc.b $00
[00005ef5]                           dc.b $00
[00005ef6]                           dc.b $00
[00005ef7]                           dc.b $37
[00005ef8] 00005f36                  dc.l $00005f36 ; no symbol found
[00005efc]                           dc.b $00
[00005efd]                           dc.b $00
[00005efe]                           dc.b $00
[00005eff]                           dc.b $25
[00005f00] 00005f2c                  dc.l $00005f2c ; no symbol found
[00005f04]                           dc.b $00
[00005f05]                           dc.b $00
[00005f06]                           dc.b $00
[00005f07]                           dc.b $31
[00005f08] 00005f22                  dc.l $00005f22 ; no symbol found
[00005f0c]                           dc.b $00
[00005f0d]                           dc.b $00
[00005f0e]                           dc.b $00
[00005f0f]                           dc.b $39
[00005f10] 00005f18                  dc.l $00005f18 ; no symbol found
[00005f14]                           dc.b $00
[00005f15]                           dc.b $00
[00005f16]                           dc.b $00
[00005f17]                           dc.b $3f
[00005f18]                           dc.w $0876
[00005f1a]                           dc.b 'olatile',0
[00005f22]                           dc.w $0875
[00005f24]                           dc.b 'nsigned',0
[00005f2c]                           dc.w $0872
[00005f2e]                           dc.b 'egister',0
[00005f36]                           dc.w $0863
[00005f38]                           dc.b 'ontinue',0
[00005f40]                           dc.w $0774
[00005f42]                           dc.b 'ypedef',0
[00005f49]                           dc.b $07
[00005f4a]                           dc.b 'default',0
[00005f52]                           dc.w $0724
[00005f54]                           dc.b 'noside',0
[00005f5b]                           dc.b $06
[00005f5c]                           dc.b 'switch',0
[00005f63]                           dc.b $06
[00005f64]                           dc.b 'struct',0
[00005f6b]                           dc.b $06
[00005f6c]                           dc.b 'static',0
[00005f73]                           dc.b $06
[00005f74]                           dc.b 'sizeof',0
[00005f7b]                           dc.b $06
[00005f7c]                           dc.b 'signed',0
[00005f83]                           dc.b $06
[00005f84]                           dc.b 'return',0
[00005f8b]                           dc.b $06
[00005f8c]                           dc.b 'extern',0
[00005f93]                           dc.b $06
[00005f94]                           dc.b 'double',0
[00005f9b]                           dc.b $05
[00005f9c]                           dc.b 'while',0
[00005fa2]                           dc.w $0575
[00005fa4]                           dc.b 'nion',0
[00005fa9]                           dc.b $05
[00005faa]                           dc.b 'short',0
[00005fb0]                           dc.w $0566
[00005fb2]                           dc.b 'loat',0
[00005fb7]                           dc.b $05
[00005fb8]                           dc.b 'const',0
[00005fbe]                           dc.w $0562
[00005fc0]                           dc.b 'reak',0
[00005fc5]                           dc.b $04
[00005fc6]                           dc.b 'void',0
[00005fcb]                           dc.b $04
[00005fcc]                           dc.b 'long',0
[00005fd1]                           dc.b $04
[00005fd2]                           dc.b 'goto',0
[00005fd7]                           dc.b $04
[00005fd8]                           dc.b 'enum',0
[00005fdd]                           dc.b $04
[00005fde]                           dc.b 'else',0
[00005fe3]                           dc.b $04
[00005fe4]                           dc.b 'char',0
[00005fe9]                           dc.b $04
[00005fea]                           dc.b 'case',0
[00005fef]                           dc.b $04
[00005ff0]                           dc.b 'auto',0
[00005ff5]                           dc.b $03
[00005ff6]                           dc.b 'int',0
[00005ffa]                           dc.w $0366
[00005ffc]                           dc.w $6f72
[00005ffe]                           dc.b $00
[00005fff]                           dc.b $02
[00006000]                           dc.w $6966
[00006002]                           dc.b $00
[00006003]                           dc.b $02
[00006004]                           dc.w $646f
[00006006]                           dc.b $00
[00006007]                           dc.b $20
[00006008]                           dc.b $00
[00006009]                           dc.b $00
[0000600a]                           dc.b 'illegal integer %b',0
[0000601d]                           dc.b $00
[0000601e]                           dc.w $6334
[00006020]                           dc.b $00
[00006021]                           dc.b $00
[00006022]                           dc.b 'illegal float constant',0
[00006039]                           dc.b $63
[0000603a]                           dc.w $3800
[0000603c]                           dc.b 'ccb',0
[00006040]                           dc.w $6300
[00006042]                           dc.w $6334
[00006044]                           dc.b $00
[00006045]                           dc.b $00
[00006046]                           dc.w $6300
[00006048]                           dc.b 'c2b',0
[0000604c]                           dc.b 'c2bb',0
[00006051]                           dc.b $00
[00006052]                           dc.b $00
[00006053]                           dc.b $00
[00006054]                           dc.b $00
[00006055]                           dc.b $00
[00006056]                           dc.b $00
[00006057]                           dc.b $00
[00006058]                           dc.b $00
[00006059]                           dc.b $00
[0000605a]                           dc.b $00
[0000605b]                           dc.b $00
[0000605c]                           dc.b $00
[0000605d]                           dc.b $00
[0000605e]                           dc.b $00
[0000605f]                           dc.b $00
[00006060]                           dc.b $00
[00006061]                           dc.b $00
[00006062]                           dc.b $00
[00006063]                           dc.b $00
[00006064]                           dc.b $00
[00006065]                           dc.b $00
[00006066]                           dc.b $00
[00006067]                           dc.b $00
[00006068]                           dc.b $00
[00006069]                           dc.b $00
[0000606a]                           dc.b $00
[0000606b]                           dc.b $00
[0000606c]                           dc.b $00
[0000606d]                           dc.b $00
[0000606e]                           dc.b $00
[0000606f]                           dc.b $00
[00006070]                           dc.b $00
[00006071]                           dc.b $00
[00006072]                           dc.b $00
[00006073]                           dc.b $00
[00006074]                           dc.b $00
[00006075]                           dc.b $00
[00006076]                           dc.b $00
[00006077]                           dc.b $00
[00006078]                           dc.b $00
[00006079]                           dc.b $00
[0000607a]                           dc.b $00
[0000607b]                           dc.b $00
[0000607c]                           dc.b $00
[0000607d]                           dc.b $00
[0000607e]                           dc.b $00
[0000607f]                           dc.b $00
[00006080]                           dc.b $00
[00006081]                           dc.b $00
[00006082]                           dc.b $00
[00006083]                           dc.b $00
[00006084]                           dc.b $00
[00006085]                           dc.b $00
[00006086]                           dc.b $00
[00006087]                           dc.b $00
[00006088]                           dc.b $00
[00006089]                           dc.b $00
[0000608a]                           dc.b $00
[0000608b]                           dc.b $00
[0000608c]                           dc.b $00
[0000608d]                           dc.b $00
[0000608e]                           dc.b $00
[0000608f]                           dc.b $00
[00006090]                           dc.b $00
[00006091]                           dc.b $00
[00006092]                           dc.b $00
[00006093]                           dc.b $00
[00006094]                           dc.b $00
[00006095]                           dc.b $00
[00006096]                           dc.b $00
[00006097]                           dc.b $00
[00006098]                           dc.b $00
[00006099]                           dc.b $00
[0000609a]                           dc.b $00
[0000609b]                           dc.b $00
[0000609c]                           dc.b $00
[0000609d]                           dc.b $00
[0000609e]                           dc.b $00
[0000609f]                           dc.b $00
[000060a0]                           dc.b $00
[000060a1]                           dc.b $00
[000060a2]                           dc.b $00
[000060a3]                           dc.b $00
[000060a4]                           dc.b $00
[000060a5]                           dc.b $00
[000060a6]                           dc.b $00
[000060a7]                           dc.b $00
[000060a8]                           dc.b $00
[000060a9]                           dc.b $00
[000060aa]                           dc.b $00
[000060ab]                           dc.b $00
[000060ac]                           dc.b $00
[000060ad]                           dc.b $00
[000060ae]                           dc.b $00
[000060af]                           dc.b $00
[000060b0]                           dc.b $00
[000060b1]                           dc.b $00
[000060b2]                           dc.b $00
[000060b3]                           dc.b $00
[000060b4]                           dc.b $00
[000060b5]                           dc.b $00
[000060b6]                           dc.b $00
[000060b7]                           dc.b $00
[000060b8]                           dc.b $00
[000060b9]                           dc.b $00
[000060ba]                           dc.b $00
[000060bb]                           dc.b $00
[000060bc]                           dc.b $00
[000060bd]                           dc.b $00
[000060be]                           dc.b $00
[000060bf]                           dc.b $00
[000060c0]                           dc.b $00
[000060c1]                           dc.b $00
[000060c2]                           dc.b $00
[000060c3]                           dc.b $00
[000060c4]                           dc.b $00
[000060c5]                           dc.b $00
[000060c6]                           dc.b $00
[000060c7]                           dc.b $00
[000060c8]                           dc.b $00
[000060c9]                           dc.b $00
[000060ca]                           dc.b $00
[000060cb]                           dc.b $00
[000060cc]                           dc.b $00
[000060cd]                           dc.b $00
[000060ce]                           dc.b $00
[000060cf]                           dc.b $00
[000060d0]                           dc.b $00
[000060d1]                           dc.b $00
[000060d2]                           dc.b $00
[000060d3]                           dc.b $00
[000060d4]                           dc.b $00
[000060d5]                           dc.b $00
[000060d6]                           dc.b $00
[000060d7]                           dc.b $00
[000060d8]                           dc.b $00
[000060d9]                           dc.b $00
[000060da]                           dc.b $00
[000060db]                           dc.b $00
[000060dc]                           dc.b $00
[000060dd]                           dc.b $00
[000060de]                           dc.b $00
[000060df]                           dc.b $00
[000060e0]                           dc.b $00
[000060e1]                           dc.b $00
[000060e2]                           dc.b $00
[000060e3]                           dc.b $00
[000060e4]                           dc.b $00
[000060e5]                           dc.b $00
[000060e6]                           dc.b $00
[000060e7]                           dc.b $00
[000060e8]                           dc.b $00
[000060e9]                           dc.b $00
[000060ea]                           dc.b $00
[000060eb]                           dc.b $00
[000060ec]                           dc.b $00
[000060ed]                           dc.b $00
[000060ee]                           dc.b $00
[000060ef]                           dc.b $00
[000060f0]                           dc.b $00
[000060f1]                           dc.b $00
[000060f2]                           dc.b $00
[000060f3]                           dc.b $00
[000060f4]                           dc.b $00
[000060f5]                           dc.b $00
[000060f6]                           dc.b $00
[000060f7]                           dc.b $00
[000060f8]                           dc.b $00
[000060f9]                           dc.b $00
[000060fa]                           dc.b $00
[000060fb]                           dc.b $00
[000060fc]                           dc.b $00
[000060fd]                           dc.b $00
[000060fe]                           dc.b $00
[000060ff]                           dc.b $00
[00006100]                           dc.b $00
[00006101]                           dc.b $00
[00006102]                           dc.b $00
[00006103]                           dc.b $00
[00006104]                           dc.b $00
[00006105]                           dc.b $00
[00006106]                           dc.b $00
[00006107]                           dc.b $00
[00006108]                           dc.b $00
[00006109]                           dc.b $00
[0000610a]                           dc.b $00
[0000610b]                           dc.b $00
[0000610c]                           dc.b $00
[0000610d]                           dc.b $00
[0000610e]                           dc.b $00
[0000610f]                           dc.b $00
[00006110]                           dc.b $00
[00006111]                           dc.b $00
[00006112]                           dc.b $00
[00006113]                           dc.b $00
[00006114]                           dc.b $00
[00006115]                           dc.b $00
[00006116]                           dc.b $00
[00006117]                           dc.b $00
[00006118]                           dc.b $00
[00006119]                           dc.b $00
[0000611a]                           dc.b $00
[0000611b]                           dc.b $00
[0000611c]                           dc.b $00
[0000611d]                           dc.b $00
[0000611e]                           dc.b $00
[0000611f]                           dc.b $00
[00006120]                           dc.b $00
[00006121]                           dc.b $00
[00006122]                           dc.b $00
[00006123]                           dc.b $00
[00006124]                           dc.b $00
[00006125]                           dc.b $00
[00006126]                           dc.b $00
[00006127]                           dc.b $00
[00006128]                           dc.b $00
[00006129]                           dc.b $00
[0000612a]                           dc.b $00
[0000612b]                           dc.b $00
[0000612c]                           dc.b $00
[0000612d]                           dc.b $00
[0000612e]                           dc.b $00
[0000612f]                           dc.b $00
[00006130]                           dc.b $00
[00006131]                           dc.b $00
[00006132]                           dc.b $00
[00006133]                           dc.b $00
[00006134]                           dc.b $00
[00006135]                           dc.b $00
[00006136]                           dc.b $00
[00006137]                           dc.b $00
[00006138]                           dc.b $00
[00006139]                           dc.b $00
[0000613a]                           dc.b $00
[0000613b]                           dc.b $00
[0000613c]                           dc.b $00
[0000613d]                           dc.b $00
[0000613e]                           dc.b $00
[0000613f]                           dc.b $00
[00006140]                           dc.b $00
[00006141]                           dc.b $00
[00006142]                           dc.b $00
[00006143]                           dc.b $00
[00006144]                           dc.b $00
[00006145]                           dc.b $00
[00006146]                           dc.b $00
[00006147]                           dc.b $00
[00006148]                           dc.b $00
[00006149]                           dc.b $00
[0000614a]                           dc.b $00
[0000614b]                           dc.b $00
[0000614c]                           dc.b $00
[0000614d]                           dc.b $00
[0000614e]                           dc.b $00
[0000614f]                           dc.b $00
[00006150]                           dc.b $00
[00006151]                           dc.b $00
[00006152]                           dc.b $00
[00006153]                           dc.b $00
[00006154]                           dc.b $00
[00006155]                           dc.b $00
[00006156]                           dc.b $00
[00006157]                           dc.b $00
[00006158]                           dc.b $00
[00006159]                           dc.b $00
[0000615a]                           dc.b $00
[0000615b]                           dc.b $00
[0000615c]                           dc.b $00
[0000615d]                           dc.b $00
[0000615e]                           dc.w $220a
[00006160]                           dc.b $00
[00006161]                           dc.b $20
[00006162]                           dc.w $2200
[00006164]                           dc.w $2320
[00006166]                           dc.b $00
[00006167]                           dc.b 'ccp',0
[0000616b]                           dc.b $63
[0000616c]                           dc.w $6300
[0000616e] 00001e1c                  dc.l $00001e1c ; no symbol found
[00006172]                           dc.b $00
[00006173]                           dc.b $00
[00006174]                           dc.b $00
[00006175]                           dc.b $07
[00006176] 00001d66                  dc.l $00001d66 ; no symbol found
[0000617a]                           dc.b $00
[0000617b]                           dc.b $00
[0000617c]                           dc.b $00
[0000617d]                           dc.b $04
[0000617e] 00001d5c                  dc.l $00001d5c ; no symbol found
[00006182]                           dc.b $00
[00006183]                           dc.b $00
[00006184]                           dc.b $00
[00006185]                           dc.b $01
[00006186] 00001d52                  dc.l $00001d52 ; no symbol found
[0000618a]                           dc.b $00
[0000618b]                           dc.b $00
[0000618c]                           dc.b $00
[0000618d]                           dc.b $08
[0000618e] 00001d48                  dc.l $00001d48 ; no symbol found
[00006192]                           dc.b $00
[00006193]                           dc.b $00
[00006194]                           dc.b $00
[00006195]                           dc.b $06
[00006196] 00001d3c                  dc.l $00001d3c ; no symbol found
[0000619a]                           dc.b $00
[0000619b]                           dc.b $00
[0000619c]                           dc.b $00
[0000619d]                           dc.b $03
[0000619e]                           dc.b $00
[0000619f]                           dc.b $00
[000061a0]                           dc.b $00
[000061a1]                           dc.b $00
[000061a2] 00001e22                  dc.l $00001e22 ; no symbol found
[000061a6]                           dc.b 'eExX',0
[000061ab]                           dc.b $22
[000061ac]                           dc.b $00
[000061ad]                           dc.b $00
_pdefs:
[000061ae]                           dc.b $00
[000061af]                           dc.b $00
[000061b0]                           dc.b $00
[000061b1]                           dc.b $0a
[000061b2]                           dc.b $00
[000061b3]                           dc.b $00
[000061b4]                           dc.b $00
[000061b5]                           dc.b $00
[000061b6]                           dc.b $00
[000061b7]                           dc.b $00
[000061b8]                           dc.b $00
[000061b9]                           dc.b $00
[000061ba]                           dc.b $00
[000061bb]                           dc.b $00
[000061bc]                           dc.b $00
[000061bd]                           dc.b $00
[000061be]                           dc.b $00
[000061bf]                           dc.b $00
[000061c0]                           dc.b $00
[000061c1]                           dc.b $00
[000061c2]                           dc.b $00
[000061c3]                           dc.b $00
[000061c4]                           dc.b $00
[000061c5]                           dc.b $00
[000061c6]                           dc.b $00
[000061c7]                           dc.b $00
[000061c8]                           dc.b $00
[000061c9]                           dc.b $00
[000061ca]                           dc.b $00
[000061cb]                           dc.b $00
[000061cc]                           dc.b $00
[000061cd]                           dc.b $00
[000061ce]                           dc.b $00
[000061cf]                           dc.b $00
[000061d0]                           dc.b $00
[000061d1]                           dc.b $00
[000061d2]                           dc.b $00
[000061d3]                           dc.b $00
[000061d4]                           dc.b $00
[000061d5]                           dc.b $00
[000061d6]                           dc.b $00
[000061d7]                           dc.b $00
[000061d8]                           dc.b $00
[000061d9]                           dc.b $00
_ofile:
[000061da]                           dc.b $00
[000061db]                           dc.b $00
[000061dc]                           dc.b $00
[000061dd]                           dc.b $00
[000061de]                           dc.b $00
[000061df]                           dc.b $00
[000061e0]                           dc.b $00
[000061e1]                           dc.b $00
[000061e2]                           dc.b $00
[000061e3]                           dc.b $00
[000061e4]                           dc.b $00
[000061e5]                           dc.b $00
_lincl:
[000061e6]                           dc.b $00
[000061e7]                           dc.b $00
[000061e8]                           dc.b $00
[000061e9]                           dc.b $00
_old:
[000061ea]                           dc.b $00
[000061eb]                           dc.b $00
[000061ec]                           dc.b $00
[000061ed]                           dc.b $00
_forpascal:
[000061ee]                           dc.b $00
[000061ef]                           dc.b $00
[000061f0]                           dc.b $00
[000061f1]                           dc.b $00
_std:
[000061f2]                           dc.b $00
[000061f3]                           dc.b $00
[000061f4]                           dc.b $00
[000061f5]                           dc.b $00
_cflag:
[000061f6]                           dc.b $00
[000061f7]                           dc.b $00
[000061f8]                           dc.b $00
[000061f9]                           dc.b $00
_pchar:
[000061fa]                           dc.b $00
[000061fb]                           dc.b $00
[000061fc]                           dc.b $00
[000061fd]                           dc.b $23
_schar:
[000061fe]                           dc.b $00
[000061ff]                           dc.b $00
[00006200]                           dc.b $00
[00006201]                           dc.b $00
[00006202]                           dc.b $00
[00006203]                           dc.b $00
[00006204]                           dc.b $00
[00006205]                           dc.b $00
[00006206]                           dc.w $0424
[00006208]                           dc.b 'esc',0
_iprefix:
[0000620c] 00006210                  dc.l $00006210 ; no symbol found
[00006210]                           dc.w $7c00
_mapfile:
[00006212]                           dc.b $00
[00006213]                           dc.b $00
[00006214]                           dc.b $00
[00006215]                           dc.b $00
[00006216] 0000621a                  dc.l $0000621a ; no symbol found
[0000621a]                           dc.w $7070
[0000621c]                           dc.b $00
[0000621d]                           dc.b $00
[0000621e]                           dc.b $00
[0000621f]                           dc.b $00
[00006220]                           dc.b $00
[00006221]                           dc.b $00
[00006222]                           dc.b $00
[00006223]                           dc.b $00
[00006224]                           dc.b $00
[00006225]                           dc.b $00
[00006226]                           dc.b $00
[00006227]                           dc.b $00
[00006228]                           dc.b $00
[00006229]                           dc.b $01
_argc:
[0000622a]                           dc.b $00
[0000622b]                           dc.b $00
[0000622c]                           dc.b $00
[0000622d]                           dc.b $00
[0000622e]                           dc.b $00
[0000622f]                           dc.b $00
[00006230]                           dc.b $00
[00006231]                           dc.b $00
[00006232]                           dc.b $00
[00006233]                           dc.b $02
[00006234]                           dc.b $00
[00006235]                           dc.b $00
[00006236]                           dc.b $00
[00006237]                           dc.b $00
_argv:
[00006238]                           dc.b $00
[00006239]                           dc.b $00
[0000623a]                           dc.b $00
[0000623b]                           dc.b $00
[0000623c]                           dc.b $00
[0000623d]                           dc.b $00
[0000623e]                           dc.b $00
[0000623f]                           dc.b $00
[00006240]                           dc.b $00
[00006241]                           dc.b $00
[00006242]                           dc.b $00
[00006243]                           dc.b $00
[00006244]                           dc.b $00
[00006245]                           dc.b $00
[00006246]                           dc.b $00
[00006247]                           dc.b $00
[00006248]                           dc.b $00
[00006249]                           dc.b $00
[0000624a]                           dc.b $00
[0000624b]                           dc.b $00
[0000624c]                           dc.b $00
[0000624d]                           dc.b $00
[0000624e]                           dc.b $00
[0000624f]                           dc.b $00
[00006250]                           dc.b $00
[00006251]                           dc.b $00
[00006252]                           dc.b $00
[00006253]                           dc.b $00
[00006254]                           dc.b $00
[00006255]                           dc.b $00
[00006256]                           dc.b $00
[00006257]                           dc.b $00
[00006258]                           dc.b $00
[00006259]                           dc.b $00
[0000625a]                           dc.b $00
[0000625b]                           dc.b $00
[0000625c]                           dc.b $00
[0000625d]                           dc.b $00
[0000625e]                           dc.b $00
[0000625f]                           dc.b $00
[00006260]                           dc.b $00
[00006261]                           dc.b $00
[00006262]                           dc.b $00
[00006263]                           dc.b $00
[00006264]                           dc.b $00
[00006265]                           dc.b $00
[00006266]                           dc.b $00
[00006267]                           dc.b $00
[00006268]                           dc.b $00
[00006269]                           dc.b $00
[0000626a]                           dc.b $00
[0000626b]                           dc.b $00
[0000626c]                           dc.b $00
[0000626d]                           dc.b $00
[0000626e]                           dc.b $00
[0000626f]                           dc.b $00
[00006270]                           dc.b $00
[00006271]                           dc.b $00
[00006272]                           dc.b $00
[00006273]                           dc.b $00
[00006274]                           dc.b $00
[00006275]                           dc.b $00
[00006276]                           dc.b $00
[00006277]                           dc.b $00
[00006278]                           dc.b $00
[00006279]                           dc.b $00
[0000627a]                           dc.b $00
[0000627b]                           dc.b $00
[0000627c]                           dc.b $00
[0000627d]                           dc.b $00
[0000627e]                           dc.b $00
[0000627f]                           dc.b $00
[00006280]                           dc.b $00
[00006281]                           dc.b $00
[00006282]                           dc.b $00
[00006283]                           dc.b $00
[00006284]                           dc.b $00
[00006285]                           dc.b $00
[00006286]                           dc.b $00
[00006287]                           dc.b $00
[00006288]                           dc.b $00
[00006289]                           dc.b $00
[0000628a]                           dc.b $00
[0000628b]                           dc.b $00
[0000628c]                           dc.b $00
[0000628d]                           dc.b $00
[0000628e]                           dc.b $00
[0000628f]                           dc.b $00
[00006290]                           dc.b $00
[00006291]                           dc.b $00
[00006292]                           dc.b $00
[00006293]                           dc.b $00
[00006294]                           dc.b $00
[00006295]                           dc.b $00
[00006296]                           dc.b $00
[00006297]                           dc.b $00
[00006298]                           dc.b $00
[00006299]                           dc.b $00
[0000629a]                           dc.b $00
[0000629b]                           dc.b $00
[0000629c]                           dc.b $00
[0000629d]                           dc.b $00
[0000629e]                           dc.b $00
[0000629f]                           dc.b $00
[000062a0]                           dc.b $00
[000062a1]                           dc.b $00
[000062a2]                           dc.b $00
[000062a3]                           dc.b $00
[000062a4]                           dc.b $00
[000062a5]                           dc.b $00
[000062a6]                           dc.b $00
[000062a7]                           dc.b $00
[000062a8]                           dc.b $00
[000062a9]                           dc.b $00
[000062aa]                           dc.b $00
[000062ab]                           dc.b $00
[000062ac]                           dc.b $00
[000062ad]                           dc.b $00
[000062ae]                           dc.b $00
[000062af]                           dc.b $00
[000062b0]                           dc.b $00
[000062b1]                           dc.b $00
[000062b2]                           dc.b $00
[000062b3]                           dc.b $00
[000062b4]                           dc.b $00
[000062b5]                           dc.b $00
[000062b6]                           dc.b $00
[000062b7]                           dc.b $00
[000062b8]                           dc.b $00
[000062b9]                           dc.b $00
[000062ba]                           dc.b $00
[000062bb]                           dc.b $00
[000062bc]                           dc.b $00
[000062bd]                           dc.b $00
[000062be]                           dc.b $00
[000062bf]                           dc.b $00
[000062c0] 00006422                  dc.l $00006422 ; no symbol found
[000062c4]                           dc.b $00
[000062c5]                           dc.b $00
[000062c6]                           dc.b $00
[000062c7]                           dc.b $0e
[000062c8] 0000641e                  dc.l $0000641e ; no symbol found
[000062cc]                           dc.b $00
[000062cd]                           dc.b $00
[000062ce]                           dc.b $00
[000062cf]                           dc.b $0e
[000062d0] 00006418                  dc.l $00006418 ; no symbol found
[000062d4]                           dc.b $00
[000062d5]                           dc.b $00
[000062d6]                           dc.b $00
[000062d7]                           dc.b $0b
[000062d8] 00006412                  dc.l $00006412 ; no symbol found
[000062dc]                           dc.b $00
[000062dd]                           dc.b $00
[000062de]                           dc.b $00
[000062df]                           dc.b $0c
[000062e0] 0000640c                  dc.l $0000640c ; no symbol found
[000062e4]                           dc.b $00
[000062e5]                           dc.b $00
[000062e6]                           dc.b $00
[000062e7]                           dc.b $12
[000062e8] 00006406                  dc.l $00006406 ; no symbol found
[000062ec]                           dc.b $00
[000062ed]                           dc.b $00
[000062ee]                           dc.b $00
[000062ef]                           dc.b $0b
[000062f0] 00006400                  dc.l $00006400 ; no symbol found
[000062f4]                           dc.b $00
[000062f5]                           dc.b $00
[000062f6]                           dc.b $00
[000062f7]                           dc.b $0c
[000062f8] 000063fa                  dc.l $000063fa ; no symbol found
[000062fc]                           dc.b $00
[000062fd]                           dc.b $00
[000062fe]                           dc.b $00
[000062ff]                           dc.b $12
[00006300] 000063f3                  dc.l $000063f3 ; no symbol found
[00006304]                           dc.b $00
[00006305]                           dc.b $00
[00006306]                           dc.b $00
[00006307]                           dc.b $0d
[00006308] 000063ec                  dc.l $000063ec ; no symbol found
[0000630c]                           dc.b $00
[0000630d]                           dc.b $00
[0000630e]                           dc.b $00
[0000630f]                           dc.b $16
[00006310] 000063e5                  dc.l $000063e5 ; no symbol found
[00006314]                           dc.b $00
[00006315]                           dc.b $00
[00006316]                           dc.b $00
[00006317]                           dc.b $0f
[00006318] 000063de                  dc.l $000063de ; no symbol found
[0000631c]                           dc.b $00
[0000631d]                           dc.b $00
[0000631e]                           dc.b $00
[0000631f]                           dc.b $15
[00006320] 000063d7                  dc.l $000063d7 ; no symbol found
[00006324]                           dc.b $00
[00006325]                           dc.b $00
[00006326]                           dc.b $00
[00006327]                           dc.b $0d
[00006328] 000063d0                  dc.l $000063d0 ; no symbol found
[0000632c]                           dc.b $00
[0000632d]                           dc.b $00
[0000632e]                           dc.b $00
[0000632f]                           dc.b $16
[00006330] 000063c9                  dc.l $000063c9 ; no symbol found
[00006334]                           dc.b $00
[00006335]                           dc.b $00
[00006336]                           dc.b $00
[00006337]                           dc.b $0f
[00006338] 000063c2                  dc.l $000063c2 ; no symbol found
[0000633c]                           dc.b $00
[0000633d]                           dc.b $00
[0000633e]                           dc.b $00
[0000633f]                           dc.b $15
[00006340] 000063ba                  dc.l $000063ba ; no symbol found
[00006344]                           dc.b $00
[00006345]                           dc.b $00
[00006346]                           dc.b $00
[00006347]                           dc.b $0a
[00006348] 000063b2                  dc.l $000063b2 ; no symbol found
[0000634c]                           dc.b $00
[0000634d]                           dc.b $00
[0000634e]                           dc.b $00
[0000634f]                           dc.b $10
[00006350] 000063aa                  dc.l $000063aa ; no symbol found
[00006354]                           dc.b $00
[00006355]                           dc.b $00
[00006356]                           dc.b $00
[00006357]                           dc.b $13
[00006358] 000063a2                  dc.l $000063a2 ; no symbol found
[0000635c]                           dc.b $00
[0000635d]                           dc.b $00
[0000635e]                           dc.b $00
[0000635f]                           dc.b $0a
[00006360] 0000639a                  dc.l $0000639a ; no symbol found
[00006364]                           dc.b $00
[00006365]                           dc.b $00
[00006366]                           dc.b $00
[00006367]                           dc.b $10
[00006368] 00006392                  dc.l $00006392 ; no symbol found
[0000636c]                           dc.b $00
[0000636d]                           dc.b $00
[0000636e]                           dc.b $00
[0000636f]                           dc.b $13
[00006370] 00006389                  dc.l $00006389 ; no symbol found
[00006374]                           dc.b $00
[00006375]                           dc.b $00
[00006376]                           dc.b $00
[00006377]                           dc.b $11
[00006378] 00006380                  dc.l $00006380 ; no symbol found
[0000637c]                           dc.b $00
[0000637d]                           dc.b $00
[0000637e]                           dc.b $00
[0000637f]                           dc.b $11
[00006380]                           dc.w $0769
[00006382]                           dc.b 'nclude',0
[00006389]                           dc.b $07
[0000638a]                           dc.b 'INCLUDE',0
[00006392]                           dc.w $0670
[00006394]                           dc.b 'ragma',0
[0000639a]                           dc.w $0669
[0000639c]                           dc.b 'fndef',0
[000063a2]                           dc.w $0664
[000063a4]                           dc.b 'efine',0
[000063aa]                           dc.w $0650
[000063ac]                           dc.b 'RAGMA',0
[000063b2]                           dc.w $0649
[000063b4]                           dc.b 'FNDEF',0
[000063ba]                           dc.w $0644
[000063bc]                           dc.b 'EFINE',0
[000063c2]                           dc.w $0575
[000063c4]                           dc.b 'ndef',0
[000063c9]                           dc.b $05
[000063ca]                           dc.b 'ifdef',0
[000063d0]                           dc.w $0565
[000063d2]                           dc.b 'rror',0
[000063d7]                           dc.b $05
[000063d8]                           dc.b 'endif',0
[000063de]                           dc.w $0555
[000063e0]                           dc.b 'NDEF',0
[000063e5]                           dc.b $05
[000063e6]                           dc.b 'IFDEF',0
[000063ec]                           dc.w $0545
[000063ee]                           dc.b 'RROR',0
[000063f3]                           dc.b $05
[000063f4]                           dc.b 'ENDIF',0
[000063fa]                           dc.w $046c
[000063fc]                           dc.b 'ine',0
[00006400]                           dc.w $0465
[00006402]                           dc.b 'lse',0
[00006406]                           dc.w $0465
[00006408]                           dc.b 'lif',0
[0000640c]                           dc.w $044c
[0000640e]                           dc.b 'INE',0
[00006412]                           dc.w $0445
[00006414]                           dc.b 'LSE',0
[00006418]                           dc.w $0445
[0000641a]                           dc.b 'LIF',0
[0000641e]                           dc.w $0269
[00006420]                           dc.w $6600
[00006422]                           dc.w $0249
[00006424]                           dc.w $4600
[00006426] 00001f68                  dc.l $00001f68 ; no symbol found
[0000642a]                           dc.b $00
[0000642b]                           dc.b $00
[0000642c]                           dc.b $00
[0000642d]                           dc.b $10
[0000642e] 00001f68                  dc.l $00001f68 ; no symbol found
[00006432]                           dc.b $00
[00006433]                           dc.b $00
[00006434]                           dc.b $00
[00006435]                           dc.b $0f
[00006436] 00001f4a                  dc.l $00001f4a ; no symbol found
[0000643a]                           dc.b $00
[0000643b]                           dc.b $00
[0000643c]                           dc.b $00
[0000643d]                           dc.b $0b
[0000643e] 00001f4a                  dc.l $00001f4a ; no symbol found
[00006442]                           dc.b $00
[00006443]                           dc.b $00
[00006444]                           dc.b $00
[00006445]                           dc.b $0e
[00006446] 00001f46                  dc.l $00001f46 ; no symbol found
[0000644a]                           dc.b $00
[0000644b]                           dc.b $00
[0000644c]                           dc.b $00
[0000644d]                           dc.b $14
[0000644e] 00001f42                  dc.l $00001f42 ; no symbol found
[00006452]                           dc.b $00
[00006453]                           dc.b $00
[00006454]                           dc.b $00
[00006455]                           dc.b $15
[00006456] 00001f3e                  dc.l $00001f3e ; no symbol found
[0000645a]                           dc.b $00
[0000645b]                           dc.b $00
[0000645c]                           dc.b $00
[0000645d]                           dc.b $0a
[0000645e] 00001f28                  dc.l $00001f28 ; no symbol found
[00006462]                           dc.b $00
[00006463]                           dc.b $00
[00006464]                           dc.b $00
[00006465]                           dc.b $11
[00006466]                           dc.b $00
[00006467]                           dc.b $00
[00006468]                           dc.b $00
[00006469]                           dc.b $00
[0000646a] 00001fea                  dc.l $00001fea ; no symbol found
[0000646e]                           dc.b 'bad #%b',0
[00006476]                           dc.b '#line inside macro',0
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
[000065a4]                           dc.b $00
[000065a5]                           dc.b $00
[000065a6]                           dc.b $00
[000065a7]                           dc.b $00
[000065a8]                           dc.b $00
[000065a9]                           dc.b $00
[000065aa]                           dc.b $00
[000065ab]                           dc.b $00
[000065ac]                           dc.b $00
[000065ad]                           dc.b $00
[000065ae]                           dc.b $00
[000065af]                           dc.b $00
[000065b0]                           dc.b $00
[000065b1]                           dc.b $00
[000065b2]                           dc.b $00
[000065b3]                           dc.b $00
[000065b4]                           dc.b $00
[000065b5]                           dc.b $00
[000065b6]                           dc.b $00
[000065b7]                           dc.b $00
[000065b8]                           dc.b $00
[000065b9]                           dc.b $00
[000065ba]                           dc.b $00
[000065bb]                           dc.b $00
[000065bc]                           dc.b $00
[000065bd]                           dc.b $00
[000065be]                           dc.b $00
[000065bf]                           dc.b $00
[000065c0]                           dc.b $00
[000065c1]                           dc.b $00
[000065c2]                           dc.b $00
[000065c3]                           dc.b $00
[000065c4]                           dc.b $00
[000065c5]                           dc.b $00
[000065c6]                           dc.b $00
[000065c7]                           dc.b $00
[000065c8]                           dc.b $00
[000065c9]                           dc.b $00
[000065ca]                           dc.b $00
[000065cb]                           dc.b $00
[000065cc]                           dc.b $00
[000065cd]                           dc.b $00
[000065ce]                           dc.b $00
[000065cf]                           dc.b $00
[000065d0]                           dc.b $00
[000065d1]                           dc.b $00
[000065d2]                           dc.b $00
[000065d3]                           dc.b $00
[000065d4]                           dc.b $00
[000065d5]                           dc.b $00
[000065d6]                           dc.b $00
[000065d7]                           dc.b $00
[000065d8]                           dc.b $00
[000065d9]                           dc.b $00
[000065da]                           dc.b $00
[000065db]                           dc.b $00
[000065dc]                           dc.b $00
[000065dd]                           dc.b $00
[000065de]                           dc.b $00
[000065df]                           dc.b $00
[000065e0]                           dc.b $00
[000065e1]                           dc.b $00
[000065e2]                           dc.b $00
[000065e3]                           dc.b $00
[000065e4]                           dc.b $00
[000065e5]                           dc.b $00
[000065e6]                           dc.b $00
[000065e7]                           dc.b $00
[000065e8]                           dc.b $00
[000065e9]                           dc.b $00
[000065ea]                           dc.b $00
[000065eb]                           dc.b $00
[000065ec]                           dc.b $00
[000065ed]                           dc.b $00
[000065ee]                           dc.b $00
[000065ef]                           dc.b $00
[000065f0]                           dc.b $00
[000065f1]                           dc.b $00
[000065f2]                           dc.b $00
[000065f3]                           dc.b $00
[000065f4]                           dc.b $00
[000065f5]                           dc.b $00
[000065f6]                           dc.b $00
[000065f7]                           dc.b $00
[000065f8]                           dc.b $00
[000065f9]                           dc.b $00
[000065fa]                           dc.b $00
[000065fb]                           dc.b $00
[000065fc]                           dc.b $00
[000065fd]                           dc.b $00
[000065fe]                           dc.b $00
[000065ff]                           dc.b $00
[00006600]                           dc.b $00
[00006601]                           dc.b $00
[00006602]                           dc.b $00
[00006603]                           dc.b $00
[00006604]                           dc.b $00
[00006605]                           dc.b $00
[00006606]                           dc.b $00
[00006607]                           dc.b $00
[00006608]                           dc.b $00
[00006609]                           dc.b $00
[0000660a]                           dc.b $00
[0000660b]                           dc.b $00
[0000660c]                           dc.b $00
[0000660d]                           dc.b $00
[0000660e]                           dc.b $00
[0000660f]                           dc.b $00
[00006610]                           dc.b $00
[00006611]                           dc.b $00
[00006612]                           dc.b $00
[00006613]                           dc.b $00
[00006614]                           dc.b $00
[00006615]                           dc.b $00
[00006616]                           dc.b $00
[00006617]                           dc.b $00
[00006618]                           dc.b $00
[00006619]                           dc.b $00
[0000661a]                           dc.b $00
[0000661b]                           dc.b $00
[0000661c]                           dc.b $00
[0000661d]                           dc.b $00
[0000661e]                           dc.b $00
[0000661f]                           dc.b $00
[00006620]                           dc.b $00
[00006621]                           dc.b $00
[00006622]                           dc.b $00
[00006623]                           dc.b $00
[00006624]                           dc.b $00
[00006625]                           dc.b $00
[00006626]                           dc.b $00
[00006627]                           dc.b $00
[00006628]                           dc.b $00
[00006629]                           dc.b $00
[0000662a]                           dc.b $00
[0000662b]                           dc.b $00
[0000662c]                           dc.b $00
[0000662d]                           dc.b $00
[0000662e]                           dc.b $00
[0000662f]                           dc.b $00
[00006630]                           dc.b $00
[00006631]                           dc.b $00
[00006632]                           dc.b $00
[00006633]                           dc.b $00
[00006634]                           dc.b $00
[00006635]                           dc.b $00
[00006636]                           dc.b $00
[00006637]                           dc.b $00
[00006638]                           dc.b $00
[00006639]                           dc.b $00
[0000663a]                           dc.b $00
[0000663b]                           dc.b $00
[0000663c]                           dc.b $00
[0000663d]                           dc.b $00
[0000663e]                           dc.b $00
[0000663f]                           dc.b $00
[00006640]                           dc.b $00
[00006641]                           dc.b $00
[00006642]                           dc.b $00
[00006643]                           dc.b $00
[00006644]                           dc.b $00
[00006645]                           dc.b $00
[00006646]                           dc.b $00
[00006647]                           dc.b $00
[00006648]                           dc.b $00
[00006649]                           dc.b $00
[0000664a]                           dc.b $00
[0000664b]                           dc.b $00
[0000664c]                           dc.b $00
[0000664d]                           dc.b $00
[0000664e]                           dc.b $00
[0000664f]                           dc.b $00
[00006650]                           dc.b $00
[00006651]                           dc.b $00
[00006652]                           dc.b $00
[00006653]                           dc.b $00
[00006654]                           dc.b $00
[00006655]                           dc.b $00
[00006656]                           dc.b $00
[00006657]                           dc.b $00
[00006658]                           dc.b $00
[00006659]                           dc.b $00
[0000665a]                           dc.b $00
[0000665b]                           dc.b $00
[0000665c]                           dc.b $00
[0000665d]                           dc.b $00
[0000665e]                           dc.b $00
[0000665f]                           dc.b $00
[00006660]                           dc.b $00
[00006661]                           dc.b $00
[00006662]                           dc.b $00
[00006663]                           dc.b $00
[00006664]                           dc.b $00
[00006665]                           dc.b $00
[00006666]                           dc.b $00
[00006667]                           dc.b $00
[00006668]                           dc.b $00
[00006669]                           dc.b $00
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
[0000686e]                           dc.b $00
[0000686f]                           dc.b $00
[00006870]                           dc.b $00
[00006871]                           dc.b $00
[00006872]                           dc.b $00
[00006873]                           dc.b $00
[00006874]                           dc.b $00
[00006875]                           dc.b $00
[00006876]                           dc.b $00
[00006877]                           dc.b $00
[00006878]                           dc.b $00
[00006879]                           dc.b $00
[0000687a]                           dc.b $00
[0000687b]                           dc.b $00
[0000687c]                           dc.b $00
[0000687d]                           dc.b $00
[0000687e]                           dc.b $00
[0000687f]                           dc.b $00
[00006880]                           dc.b $00
[00006881]                           dc.b $00
[00006882]                           dc.b $00
[00006883]                           dc.b $00
[00006884]                           dc.b $00
[00006885]                           dc.b $00
[00006886]                           dc.b $00
[00006887]                           dc.b $00
[00006888]                           dc.b $00
[00006889]                           dc.b $00
[0000688a]                           dc.b $00
[0000688b]                           dc.b $00
[0000688c]                           dc.b $00
[0000688d]                           dc.b $00
[0000688e]                           dc.b $00
[0000688f]                           dc.b $00
[00006890]                           dc.b $00
[00006891]                           dc.b $00
[00006892]                           dc.b $00
[00006893]                           dc.b $00
[00006894]                           dc.b $00
[00006895]                           dc.b $00
[00006896]                           dc.b $00
[00006897]                           dc.b $00
[00006898]                           dc.b $00
[00006899]                           dc.b $00
[0000689a]                           dc.b $00
[0000689b]                           dc.b $00
[0000689c]                           dc.b $00
[0000689d]                           dc.b $00
[0000689e]                           dc.b $00
[0000689f]                           dc.b $00
[000068a0]                           dc.b $00
[000068a1]                           dc.b $00
[000068a2]                           dc.b $00
[000068a3]                           dc.b $00
[000068a4]                           dc.b $00
[000068a5]                           dc.b $00
[000068a6]                           dc.b $00
[000068a7]                           dc.b $00
[000068a8]                           dc.b $00
[000068a9]                           dc.b $00
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
[000068ba]                           dc.b $00
[000068bb]                           dc.b $00
[000068bc]                           dc.b $00
[000068bd]                           dc.b $00
[000068be]                           dc.b $00
[000068bf]                           dc.b $00
[000068c0]                           dc.b $00
[000068c1]                           dc.b $00
[000068c2]                           dc.b $00
[000068c3]                           dc.b $00
[000068c4]                           dc.b $00
[000068c5]                           dc.b $00
[000068c6]                           dc.b $00
[000068c7]                           dc.b $00
[000068c8]                           dc.b $00
[000068c9]                           dc.b $00
[000068ca]                           dc.b $00
[000068cb]                           dc.b $00
[000068cc]                           dc.b $00
[000068cd]                           dc.b $00
[000068ce]                           dc.b $00
[000068cf]                           dc.b $00
[000068d0]                           dc.b $00
[000068d1]                           dc.b $00
[000068d2]                           dc.b $00
[000068d3]                           dc.b $00
[000068d4]                           dc.b $00
[000068d5]                           dc.b $00
[000068d6]                           dc.b $00
[000068d7]                           dc.b $00
[000068d8]                           dc.b $00
[000068d9]                           dc.b $00
[000068da]                           dc.b $00
[000068db]                           dc.b $00
[000068dc]                           dc.b $00
[000068dd]                           dc.b $00
[000068de]                           dc.b $00
[000068df]                           dc.b $00
[000068e0]                           dc.b $00
[000068e1]                           dc.b $00
[000068e2]                           dc.b $00
[000068e3]                           dc.b $00
[000068e4]                           dc.b $00
[000068e5]                           dc.b $00
[000068e6]                           dc.b $00
[000068e7]                           dc.b $00
[000068e8]                           dc.b $00
[000068e9]                           dc.b $00
[000068ea]                           dc.b $00
[000068eb]                           dc.b $00
[000068ec]                           dc.b $00
[000068ed]                           dc.b $00
[000068ee]                           dc.b $00
[000068ef]                           dc.b $00
[000068f0]                           dc.b $00
[000068f1]                           dc.b $00
[000068f2]                           dc.b $00
[000068f3]                           dc.b $00
[000068f4]                           dc.b $00
[000068f5]                           dc.b $00
[000068f6]                           dc.b $00
[000068f7]                           dc.b $00
[000068f8]                           dc.b $00
[000068f9]                           dc.b $00
[000068fa]                           dc.b $00
[000068fb]                           dc.b $00
[000068fc]                           dc.b $00
[000068fd]                           dc.b $00
[000068fe]                           dc.b $00
[000068ff]                           dc.b $00
[00006900]                           dc.b $00
[00006901]                           dc.b $00
[00006902]                           dc.b $00
[00006903]                           dc.b $00
[00006904]                           dc.b $00
[00006905]                           dc.b $00
[00006906]                           dc.b $00
[00006907]                           dc.b $00
[00006908]                           dc.b $00
[00006909]                           dc.b $00
[0000690a]                           dc.b $00
[0000690b]                           dc.b $00
[0000690c]                           dc.b $00
[0000690d]                           dc.b $00
[0000690e]                           dc.b $00
[0000690f]                           dc.b $00
[00006910]                           dc.b $00
[00006911]                           dc.b $00
[00006912]                           dc.b $00
[00006913]                           dc.b $00
[00006914]                           dc.b $00
[00006915]                           dc.b $00
[00006916]                           dc.b $00
[00006917]                           dc.b $00
[00006918]                           dc.b $00
[00006919]                           dc.b $00
[0000691a]                           dc.b $00
[0000691b]                           dc.b $00
[0000691c]                           dc.b $00
[0000691d]                           dc.b $00
[0000691e]                           dc.b $00
[0000691f]                           dc.b $00
[00006920]                           dc.b $00
[00006921]                           dc.b $00
[00006922]                           dc.b $00
[00006923]                           dc.b $00
[00006924]                           dc.b $00
[00006925]                           dc.b $00
[00006926]                           dc.b $00
[00006927]                           dc.b $00
[00006928]                           dc.b $00
[00006929]                           dc.b $00
[0000692a]                           dc.b $00
[0000692b]                           dc.b $00
[0000692c]                           dc.b $00
[0000692d]                           dc.b $00
[0000692e]                           dc.b $00
[0000692f]                           dc.b $00
[00006930]                           dc.b $00
[00006931]                           dc.b $00
[00006932]                           dc.b $00
[00006933]                           dc.b $00
[00006934]                           dc.b $00
[00006935]                           dc.b $00
[00006936]                           dc.b $00
[00006937]                           dc.b $00
[00006938]                           dc.b $00
[00006939]                           dc.b $00
[0000693a]                           dc.b $00
[0000693b]                           dc.b $00
[0000693c]                           dc.b $00
[0000693d]                           dc.b $00
[0000693e]                           dc.b $00
[0000693f]                           dc.b $00
[00006940]                           dc.b $00
[00006941]                           dc.b $00
[00006942]                           dc.b $00
[00006943]                           dc.b $00
[00006944]                           dc.b $00
[00006945]                           dc.b $00
[00006946]                           dc.b $00
[00006947]                           dc.b $00
[00006948]                           dc.b $00
[00006949]                           dc.b $00
[0000694a]                           dc.b $00
[0000694b]                           dc.b $00
[0000694c]                           dc.b $00
[0000694d]                           dc.b $00
[0000694e]                           dc.b $00
[0000694f]                           dc.b $00
[00006950]                           dc.b $00
[00006951]                           dc.b $00
[00006952]                           dc.b $00
[00006953]                           dc.b $00
[00006954]                           dc.b $00
[00006955]                           dc.b $00
[00006956]                           dc.b $00
[00006957]                           dc.b $00
[00006958]                           dc.b $00
[00006959]                           dc.b $00
[0000695a]                           dc.b $00
[0000695b]                           dc.b $00
[0000695c]                           dc.b $00
[0000695d]                           dc.b $00
[0000695e]                           dc.b $00
[0000695f]                           dc.b $00
[00006960]                           dc.b $00
[00006961]                           dc.b $00
[00006962]                           dc.b $00
[00006963]                           dc.b $00
[00006964]                           dc.b $00
[00006965]                           dc.b $00
[00006966]                           dc.b $00
[00006967]                           dc.b $00
[00006968]                           dc.b $00
[00006969]                           dc.b $00
[0000696a]                           dc.b $00
[0000696b]                           dc.b $00
[0000696c]                           dc.b $00
[0000696d]                           dc.b $00
[0000696e]                           dc.b $00
[0000696f]                           dc.b $00
[00006970]                           dc.b $00
[00006971]                           dc.b $00
[00006972]                           dc.b $00
[00006973]                           dc.b $00
[00006974]                           dc.b $00
[00006975]                           dc.b $00
[00006976]                           dc.b $00
[00006977]                           dc.b $00
[00006978]                           dc.b $00
[00006979]                           dc.b $00
[0000697a]                           dc.b $00
[0000697b]                           dc.b $00
[0000697c]                           dc.b $00
[0000697d]                           dc.b $00
[0000697e]                           dc.b $00
[0000697f]                           dc.b $00
[00006980]                           dc.b $00
[00006981]                           dc.b $00
[00006982]                           dc.b $00
[00006983]                           dc.b $00
[00006984]                           dc.b $00
[00006985]                           dc.b $00
[00006986]                           dc.b $00
[00006987]                           dc.b $00
[00006988]                           dc.b $00
[00006989]                           dc.b $00
[0000698a]                           dc.b $00
[0000698b]                           dc.b $00
[0000698c]                           dc.b $00
[0000698d]                           dc.b $00
[0000698e]                           dc.b $00
[0000698f]                           dc.b $00
[00006990]                           dc.b $00
[00006991]                           dc.b $00
[00006992]                           dc.b $00
[00006993]                           dc.b $00
[00006994]                           dc.b $00
[00006995]                           dc.b $00
[00006996]                           dc.b $00
[00006997]                           dc.b $00
[00006998]                           dc.b $00
[00006999]                           dc.b $00
[0000699a]                           dc.b $00
[0000699b]                           dc.b $00
[0000699c]                           dc.b $00
[0000699d]                           dc.b $00
[0000699e]                           dc.b $00
[0000699f]                           dc.b $00
[000069a0]                           dc.b $00
[000069a1]                           dc.b $00
[000069a2]                           dc.b $00
[000069a3]                           dc.b $00
[000069a4]                           dc.b $00
[000069a5]                           dc.b $00
[000069a6]                           dc.b $00
[000069a7]                           dc.b $00
[000069a8]                           dc.b $00
[000069a9]                           dc.b $00
[000069aa]                           dc.b $00
[000069ab]                           dc.b $00
[000069ac]                           dc.b $00
[000069ad]                           dc.b $00
[000069ae]                           dc.b $00
[000069af]                           dc.b $00
[000069b0]                           dc.b $00
[000069b1]                           dc.b $00
[000069b2]                           dc.b $00
[000069b3]                           dc.b $00
[000069b4]                           dc.b $00
[000069b5]                           dc.b $00
[000069b6]                           dc.b $00
[000069b7]                           dc.b $00
[000069b8]                           dc.b $00
[000069b9]                           dc.b $00
[000069ba]                           dc.b $00
[000069bb]                           dc.b $00
[000069bc]                           dc.b $00
[000069bd]                           dc.b $00
[000069be]                           dc.b $00
[000069bf]                           dc.b $00
[000069c0]                           dc.b $00
[000069c1]                           dc.b $00
[000069c2]                           dc.b $00
[000069c3]                           dc.b $00
[000069c4]                           dc.b $00
[000069c5]                           dc.b $00
[000069c6]                           dc.b $00
[000069c7]                           dc.b $00
[000069c8]                           dc.b $00
[000069c9]                           dc.b $00
[000069ca]                           dc.b $00
[000069cb]                           dc.b $00
[000069cc]                           dc.b $00
[000069cd]                           dc.b $00
[000069ce]                           dc.b $00
[000069cf]                           dc.b $00
[000069d0]                           dc.b $00
[000069d1]                           dc.b $00
[000069d2]                           dc.b $00
[000069d3]                           dc.b $00
[000069d4]                           dc.b $00
[000069d5]                           dc.b $00
[000069d6]                           dc.b $00
[000069d7]                           dc.b $00
[000069d8]                           dc.b $00
[000069d9]                           dc.b $00
[000069da]                           dc.b $00
[000069db]                           dc.b $00
[000069dc]                           dc.b $00
[000069dd]                           dc.b $00
[000069de]                           dc.b $00
[000069df]                           dc.b $00
[000069e0]                           dc.b $00
[000069e1]                           dc.b $00
[000069e2]                           dc.b $00
[000069e3]                           dc.b $00
[000069e4]                           dc.b $00
[000069e5]                           dc.b $00
[000069e6]                           dc.b $00
[000069e7]                           dc.b $00
[000069e8]                           dc.b $00
[000069e9]                           dc.b $00
[000069ea]                           dc.b $00
[000069eb]                           dc.b $00
[000069ec]                           dc.b $00
[000069ed]                           dc.b $00
[000069ee]                           dc.b $00
[000069ef]                           dc.b $00
[000069f0]                           dc.b $00
[000069f1]                           dc.b $00
[000069f2]                           dc.b $00
[000069f3]                           dc.b $00
[000069f4]                           dc.b $00
[000069f5]                           dc.b $00
[000069f6]                           dc.b $00
[000069f7]                           dc.b $00
[000069f8]                           dc.b $00
[000069f9]                           dc.b $00
[000069fa]                           dc.b $00
[000069fb]                           dc.b $00
[000069fc]                           dc.b $00
[000069fd]                           dc.b $00
[000069fe]                           dc.b $00
[000069ff]                           dc.b $00
[00006a00]                           dc.b $00
[00006a01]                           dc.b $00
[00006a02]                           dc.b $00
[00006a03]                           dc.b $00
[00006a04]                           dc.b $00
[00006a05]                           dc.b $00
[00006a06]                           dc.b $00
[00006a07]                           dc.b $00
[00006a08]                           dc.b $00
[00006a09]                           dc.b $00
[00006a0a]                           dc.b $00
[00006a0b]                           dc.b $00
[00006a0c]                           dc.b $00
[00006a0d]                           dc.b $00
[00006a0e]                           dc.b $00
[00006a0f]                           dc.b $00
[00006a10]                           dc.b $00
[00006a11]                           dc.b $00
[00006a12]                           dc.b $00
[00006a13]                           dc.b $00
[00006a14]                           dc.b $00
[00006a15]                           dc.b $00
[00006a16]                           dc.b $00
[00006a17]                           dc.b $00
[00006a18]                           dc.b $00
[00006a19]                           dc.b $00
[00006a1a]                           dc.b $00
[00006a1b]                           dc.b $00
[00006a1c]                           dc.b $00
[00006a1d]                           dc.b $00
[00006a1e]                           dc.b $00
[00006a1f]                           dc.b $00
[00006a20]                           dc.b $00
[00006a21]                           dc.b $00
[00006a22]                           dc.b $00
[00006a23]                           dc.b $00
[00006a24]                           dc.b $00
[00006a25]                           dc.b $00
[00006a26]                           dc.b $00
[00006a27]                           dc.b $00
[00006a28]                           dc.b $00
[00006a29]                           dc.b $00
[00006a2a]                           dc.b $00
[00006a2b]                           dc.b $00
[00006a2c]                           dc.b $00
[00006a2d]                           dc.b $00
[00006a2e]                           dc.b $00
[00006a2f]                           dc.b $00
[00006a30]                           dc.b $00
[00006a31]                           dc.b $00
[00006a32]                           dc.b $00
[00006a33]                           dc.b $00
[00006a34]                           dc.b $00
[00006a35]                           dc.b $00
[00006a36]                           dc.b $00
[00006a37]                           dc.b $00
[00006a38]                           dc.b $00
[00006a39]                           dc.b $00
[00006a3a]                           dc.b $00
[00006a3b]                           dc.b $00
[00006a3c]                           dc.b $00
[00006a3d]                           dc.b $00
[00006a3e]                           dc.b $00
[00006a3f]                           dc.b $00
[00006a40]                           dc.b $00
[00006a41]                           dc.b $00
[00006a42]                           dc.b $00
[00006a43]                           dc.b $00
[00006a44]                           dc.b $00
[00006a45]                           dc.b $00
[00006a46]                           dc.b $00
[00006a47]                           dc.b $00
[00006a48]                           dc.b $00
[00006a49]                           dc.b $00
[00006a4a]                           dc.b $00
[00006a4b]                           dc.b $00
[00006a4c]                           dc.b $00
[00006a4d]                           dc.b $00
[00006a4e]                           dc.b $00
[00006a4f]                           dc.b $00
[00006a50]                           dc.b $00
[00006a51]                           dc.b $00
[00006a52]                           dc.b $00
[00006a53]                           dc.b $00
[00006a54]                           dc.b $00
[00006a55]                           dc.b $00
[00006a56]                           dc.b $00
[00006a57]                           dc.b $00
[00006a58]                           dc.b $00
[00006a59]                           dc.b $00
[00006a5a]                           dc.b $00
[00006a5b]                           dc.b $00
[00006a5c]                           dc.b $00
[00006a5d]                           dc.b $00
[00006a5e]                           dc.b $00
[00006a5f]                           dc.b $00
[00006a60]                           dc.b $00
[00006a61]                           dc.b $00
[00006a62]                           dc.b $00
[00006a63]                           dc.b $00
[00006a64]                           dc.b $00
[00006a65]                           dc.b $00
[00006a66]                           dc.b $00
[00006a67]                           dc.b $00
[00006a68]                           dc.b $00
[00006a69]                           dc.b $00
[00006a6a]                           dc.b $00
[00006a6b]                           dc.b $00
[00006a6c]                           dc.b $00
[00006a6d]                           dc.b $00
[00006a6e]                           dc.b $00
[00006a6f]                           dc.b $00
[00006a70]                           dc.b $00
[00006a71]                           dc.b $00
[00006a72]                           dc.b $00
[00006a73]                           dc.b $00
[00006a74]                           dc.b $00
[00006a75]                           dc.b $00
[00006a76]                           dc.b $00
[00006a77]                           dc.b $00
[00006a78]                           dc.b $00
[00006a79]                           dc.b $00
[00006a7a]                           dc.b $00
[00006a7b]                           dc.b $00
[00006a7c]                           dc.b $00
[00006a7d]                           dc.b $00
[00006a7e]                           dc.b $00
[00006a7f]                           dc.b $00
[00006a80]                           dc.b $00
[00006a81]                           dc.b $00
[00006a82]                           dc.b $00
[00006a83]                           dc.b $00
[00006a84]                           dc.b $00
[00006a85]                           dc.b $00
[00006a86]                           dc.b $00
[00006a87]                           dc.b $00
[00006a88]                           dc.b $00
[00006a89]                           dc.b $00
[00006a8a]                           dc.b $00
[00006a8b]                           dc.b $00
[00006a8c]                           dc.b $00
[00006a8d]                           dc.b $00
[00006a8e]                           dc.b $00
[00006a8f]                           dc.b $00
[00006a90]                           dc.b $00
[00006a91]                           dc.b $00
[00006a92]                           dc.b $00
[00006a93]                           dc.b $00
[00006a94]                           dc.b $00
[00006a95]                           dc.b $00
[00006a96]                           dc.b $00
[00006a97]                           dc.b $00
[00006a98]                           dc.b $00
[00006a99]                           dc.b $00
[00006a9a]                           dc.b $00
[00006a9b]                           dc.b $00
[00006a9c]                           dc.b $00
[00006a9d]                           dc.b $00
[00006a9e]                           dc.b $00
[00006a9f]                           dc.b $00
[00006aa0]                           dc.b $00
[00006aa1]                           dc.b $00
[00006aa2]                           dc.b $00
[00006aa3]                           dc.b $00
[00006aa4]                           dc.b $00
[00006aa5]                           dc.b $00
[00006aa6]                           dc.b $00
[00006aa7]                           dc.b $00
[00006aa8]                           dc.b $00
[00006aa9]                           dc.b $00
[00006aaa]                           dc.b $00
[00006aab]                           dc.b $00
[00006aac]                           dc.b $00
[00006aad]                           dc.b $00
[00006aae]                           dc.b $00
[00006aaf]                           dc.b $00
[00006ab0]                           dc.b $00
[00006ab1]                           dc.b $00
[00006ab2]                           dc.b $00
[00006ab3]                           dc.b $00
[00006ab4]                           dc.b $00
[00006ab5]                           dc.b $00
[00006ab6]                           dc.b $00
[00006ab7]                           dc.b $00
[00006ab8]                           dc.b $00
[00006ab9]                           dc.b $00
[00006aba]                           dc.b $00
[00006abb]                           dc.b $00
[00006abc]                           dc.b $00
[00006abd]                           dc.b $00
[00006abe]                           dc.b $00
[00006abf]                           dc.b $00
[00006ac0]                           dc.b $00
[00006ac1]                           dc.b $00
[00006ac2]                           dc.b $00
[00006ac3]                           dc.b $00
[00006ac4]                           dc.b $00
[00006ac5]                           dc.b $00
[00006ac6]                           dc.b $00
[00006ac7]                           dc.b $00
[00006ac8]                           dc.b $00
[00006ac9]                           dc.b $00
[00006aca]                           dc.b $00
[00006acb]                           dc.b $00
[00006acc]                           dc.b $00
[00006acd]                           dc.b $00
[00006ace]                           dc.b $00
[00006acf]                           dc.b $00
[00006ad0]                           dc.b $00
[00006ad1]                           dc.b $00
[00006ad2]                           dc.b $00
[00006ad3]                           dc.b $00
[00006ad4]                           dc.b $00
[00006ad5]                           dc.b $00
[00006ad6]                           dc.b $00
[00006ad7]                           dc.b $00
[00006ad8]                           dc.b $00
[00006ad9]                           dc.b $00
[00006ada]                           dc.b $00
[00006adb]                           dc.b $00
[00006adc]                           dc.b $00
[00006add]                           dc.b $00
[00006ade]                           dc.b $00
[00006adf]                           dc.b $00
[00006ae0]                           dc.b $00
[00006ae1]                           dc.b $00
[00006ae2]                           dc.b $00
[00006ae3]                           dc.b $00
[00006ae4]                           dc.b $00
[00006ae5]                           dc.b $00
[00006ae6]                           dc.b $00
[00006ae7]                           dc.b $00
[00006ae8]                           dc.b $00
[00006ae9]                           dc.b $00
[00006aea]                           dc.b $00
[00006aeb]                           dc.b $00
[00006aec]                           dc.b $00
[00006aed]                           dc.b $00
[00006aee]                           dc.b $00
[00006aef]                           dc.b $00
[00006af0]                           dc.b $00
[00006af1]                           dc.b $00
[00006af2]                           dc.b $00
[00006af3]                           dc.b $00
[00006af4]                           dc.b $00
[00006af5]                           dc.b $00
[00006af6]                           dc.b $00
[00006af7]                           dc.b $00
[00006af8]                           dc.b $00
[00006af9]                           dc.b $00
[00006afa]                           dc.b $00
[00006afb]                           dc.b $00
[00006afc]                           dc.b $00
[00006afd]                           dc.b $00
[00006afe]                           dc.b $00
[00006aff]                           dc.b $00
[00006b00]                           dc.b $00
[00006b01]                           dc.b $00
[00006b02]                           dc.b $00
[00006b03]                           dc.b $00
[00006b04]                           dc.b $00
[00006b05]                           dc.b $00
[00006b06]                           dc.b $00
[00006b07]                           dc.b $00
[00006b08]                           dc.b $00
[00006b09]                           dc.b $00
[00006b0a]                           dc.b $00
[00006b0b]                           dc.b $00
[00006b0c]                           dc.b $00
[00006b0d]                           dc.b $00
[00006b0e]                           dc.b $00
[00006b0f]                           dc.b $00
[00006b10]                           dc.b $00
[00006b11]                           dc.b $00
[00006b12]                           dc.b $00
[00006b13]                           dc.b $00
[00006b14]                           dc.b $00
[00006b15]                           dc.b $00
[00006b16]                           dc.b $00
[00006b17]                           dc.b $00
[00006b18]                           dc.b $00
[00006b19]                           dc.b $00
[00006b1a]                           dc.b $00
[00006b1b]                           dc.b $00
[00006b1c]                           dc.b $00
[00006b1d]                           dc.b $00
[00006b1e]                           dc.b $00
[00006b1f]                           dc.b $00
[00006b20]                           dc.b $00
[00006b21]                           dc.b $00
[00006b22]                           dc.b $00
[00006b23]                           dc.b $00
[00006b24]                           dc.b $00
[00006b25]                           dc.b $00
[00006b26]                           dc.b $00
[00006b27]                           dc.b $00
[00006b28]                           dc.b $00
[00006b29]                           dc.b $00
[00006b2a]                           dc.b $00
[00006b2b]                           dc.b $00
[00006b2c]                           dc.b $00
[00006b2d]                           dc.b $00
[00006b2e]                           dc.b $00
[00006b2f]                           dc.b $00
[00006b30]                           dc.b $00
[00006b31]                           dc.b $00
[00006b32]                           dc.b $00
[00006b33]                           dc.b $00
[00006b34]                           dc.b $00
[00006b35]                           dc.b $00
[00006b36]                           dc.b $00
[00006b37]                           dc.b $00
[00006b38]                           dc.b $00
[00006b39]                           dc.b $00
[00006b3a]                           dc.b $00
[00006b3b]                           dc.b $00
[00006b3c]                           dc.b $00
[00006b3d]                           dc.b $00
[00006b3e]                           dc.b $00
[00006b3f]                           dc.b $00
[00006b40]                           dc.b $00
[00006b41]                           dc.b $00
[00006b42]                           dc.b $00
[00006b43]                           dc.b $00
[00006b44]                           dc.b $00
[00006b45]                           dc.b $00
[00006b46]                           dc.b $00
[00006b47]                           dc.b $00
[00006b48]                           dc.b $00
[00006b49]                           dc.b $00
[00006b4a]                           dc.b $00
[00006b4b]                           dc.b $00
[00006b4c]                           dc.b $00
[00006b4d]                           dc.b $00
[00006b4e]                           dc.b $00
[00006b4f]                           dc.b $00
[00006b50]                           dc.b $00
[00006b51]                           dc.b $00
[00006b52]                           dc.b $00
[00006b53]                           dc.b $00
[00006b54]                           dc.b $00
[00006b55]                           dc.b $00
[00006b56]                           dc.b $00
[00006b57]                           dc.b $00
[00006b58]                           dc.b $00
[00006b59]                           dc.b $00
[00006b5a]                           dc.b $00
[00006b5b]                           dc.b $00
[00006b5c]                           dc.b $00
[00006b5d]                           dc.b $00
[00006b5e]                           dc.b $00
[00006b5f]                           dc.b $00
[00006b60]                           dc.b $00
[00006b61]                           dc.b $00
[00006b62]                           dc.b $00
[00006b63]                           dc.b $00
[00006b64]                           dc.b $00
[00006b65]                           dc.b $00
[00006b66]                           dc.b $00
[00006b67]                           dc.b $00
[00006b68]                           dc.b $00
[00006b69]                           dc.b $00
[00006b6a]                           dc.b $00
[00006b6b]                           dc.b $00
[00006b6c]                           dc.b $00
[00006b6d]                           dc.b $00
[00006b6e]                           dc.b $00
[00006b6f]                           dc.b $00
[00006b70]                           dc.b $00
[00006b71]                           dc.b $00
[00006b72]                           dc.b $00
[00006b73]                           dc.b $00
[00006b74]                           dc.b $00
[00006b75]                           dc.b $00
[00006b76]                           dc.b $00
[00006b77]                           dc.b $00
[00006b78]                           dc.b $00
[00006b79]                           dc.b $00
[00006b7a]                           dc.b $00
[00006b7b]                           dc.b $00
[00006b7c]                           dc.b $00
[00006b7d]                           dc.b $00
[00006b7e]                           dc.b $00
[00006b7f]                           dc.b $00
[00006b80]                           dc.b $00
[00006b81]                           dc.b $00
[00006b82]                           dc.b $00
[00006b83]                           dc.b $00
[00006b84]                           dc.b $00
[00006b85]                           dc.b $00
[00006b86]                           dc.b $00
[00006b87]                           dc.b $00
[00006b88]                           dc.b $00
[00006b89]                           dc.b $00
[00006b8a]                           dc.b $00
[00006b8b]                           dc.b $00
[00006b8c]                           dc.b $00
[00006b8d]                           dc.b $00
[00006b8e]                           dc.b $00
[00006b8f]                           dc.b $00
[00006b90]                           dc.b $00
[00006b91]                           dc.b $00
[00006b92]                           dc.b $00
[00006b93]                           dc.b $00
[00006b94]                           dc.b $00
[00006b95]                           dc.b $00
[00006b96]                           dc.b $00
[00006b97]                           dc.b $00
[00006b98]                           dc.b $00
[00006b99]                           dc.b $00
[00006b9a]                           dc.b $00
[00006b9b]                           dc.b $00
[00006b9c]                           dc.b $00
[00006b9d]                           dc.b $00
[00006b9e]                           dc.b $00
[00006b9f]                           dc.b $00
[00006ba0]                           dc.b $00
[00006ba1]                           dc.b $00
[00006ba2]                           dc.b $00
[00006ba3]                           dc.b $00
[00006ba4]                           dc.b $00
[00006ba5]                           dc.b $00
[00006ba6]                           dc.b $00
[00006ba7]                           dc.b $00
[00006ba8]                           dc.b $00
[00006ba9]                           dc.b $00
[00006baa]                           dc.b $00
[00006bab]                           dc.b $00
[00006bac]                           dc.b $00
[00006bad]                           dc.b $00
[00006bae]                           dc.b $00
[00006baf]                           dc.b $00
[00006bb0]                           dc.b $00
[00006bb1]                           dc.b $00
[00006bb2]                           dc.b $00
[00006bb3]                           dc.b $00
[00006bb4]                           dc.b $00
[00006bb5]                           dc.b $00
[00006bb6]                           dc.b $00
[00006bb7]                           dc.b $00
[00006bb8]                           dc.b $00
[00006bb9]                           dc.b $00
[00006bba]                           dc.b $00
[00006bbb]                           dc.b $00
[00006bbc]                           dc.b $00
[00006bbd]                           dc.b $00
[00006bbe]                           dc.b $00
[00006bbf]                           dc.b $00
[00006bc0]                           dc.b $00
[00006bc1]                           dc.b $00
[00006bc2]                           dc.b $00
[00006bc3]                           dc.b $00
[00006bc4]                           dc.b $00
[00006bc5]                           dc.b $00
[00006bc6]                           dc.b $00
[00006bc7]                           dc.b $00
[00006bc8]                           dc.b $00
[00006bc9]                           dc.b $00
[00006bca]                           dc.b $00
[00006bcb]                           dc.b $00
[00006bcc]                           dc.b $00
[00006bcd]                           dc.b $00
[00006bce]                           dc.b $00
[00006bcf]                           dc.b $00
[00006bd0]                           dc.b $00
[00006bd1]                           dc.b $00
[00006bd2]                           dc.b $00
[00006bd3]                           dc.b $00
[00006bd4]                           dc.b $00
[00006bd5]                           dc.b $00
[00006bd6]                           dc.b $00
[00006bd7]                           dc.b $00
[00006bd8]                           dc.b $00
[00006bd9]                           dc.b $00
[00006bda]                           dc.b $00
[00006bdb]                           dc.b $00
[00006bdc]                           dc.b $00
[00006bdd]                           dc.b $00
[00006bde]                           dc.b $00
[00006bdf]                           dc.b $00
[00006be0]                           dc.b $00
[00006be1]                           dc.b $00
[00006be2]                           dc.b $00
[00006be3]                           dc.b $00
[00006be4]                           dc.b $00
[00006be5]                           dc.b $00
[00006be6]                           dc.b $00
[00006be7]                           dc.b $00
[00006be8]                           dc.b $00
[00006be9]                           dc.b $00
[00006bea]                           dc.b $00
[00006beb]                           dc.b $00
[00006bec]                           dc.b $00
[00006bed]                           dc.b $00
[00006bee]                           dc.b $00
[00006bef]                           dc.b $00
[00006bf0]                           dc.b $00
[00006bf1]                           dc.b $00
[00006bf2]                           dc.b $00
[00006bf3]                           dc.b $00
[00006bf4]                           dc.b $00
[00006bf5]                           dc.b $00
[00006bf6]                           dc.b $00
[00006bf7]                           dc.b $00
[00006bf8]                           dc.b $00
[00006bf9]                           dc.b $00
[00006bfa]                           dc.b $00
[00006bfb]                           dc.b $00
[00006bfc]                           dc.b $00
[00006bfd]                           dc.b $00
[00006bfe]                           dc.b $00
[00006bff]                           dc.b $00
[00006c00]                           dc.b $00
[00006c01]                           dc.b $00
[00006c02]                           dc.b $00
[00006c03]                           dc.b $00
[00006c04]                           dc.b $00
[00006c05]                           dc.b $00
[00006c06]                           dc.b $00
[00006c07]                           dc.b $00
[00006c08]                           dc.b $00
[00006c09]                           dc.b $00
[00006c0a]                           dc.b $00
[00006c0b]                           dc.b $00
[00006c0c]                           dc.b $00
[00006c0d]                           dc.b $00
[00006c0e]                           dc.b $00
[00006c0f]                           dc.b $00
[00006c10]                           dc.b $00
[00006c11]                           dc.b $00
[00006c12]                           dc.b $00
[00006c13]                           dc.b $00
[00006c14]                           dc.b $00
[00006c15]                           dc.b $00
[00006c16]                           dc.b $00
[00006c17]                           dc.b $00
[00006c18]                           dc.b $00
[00006c19]                           dc.b $00
[00006c1a]                           dc.b $00
[00006c1b]                           dc.b $00
[00006c1c]                           dc.b $00
[00006c1d]                           dc.b $00
[00006c1e]                           dc.b $00
[00006c1f]                           dc.b $00
[00006c20]                           dc.b $00
[00006c21]                           dc.b $00
[00006c22]                           dc.b $00
[00006c23]                           dc.b $00
[00006c24]                           dc.b $00
[00006c25]                           dc.b $00
[00006c26]                           dc.b $00
[00006c27]                           dc.b $00
[00006c28]                           dc.b $00
[00006c29]                           dc.b $00
[00006c2a]                           dc.b $00
[00006c2b]                           dc.b $00
[00006c2c]                           dc.b $00
[00006c2d]                           dc.b $00
[00006c2e]                           dc.b $00
[00006c2f]                           dc.b $00
[00006c30]                           dc.b $00
[00006c31]                           dc.b $00
[00006c32]                           dc.b $00
[00006c33]                           dc.b $00
[00006c34]                           dc.b $00
[00006c35]                           dc.b $00
[00006c36]                           dc.b $00
[00006c37]                           dc.b $00
[00006c38]                           dc.b $00
[00006c39]                           dc.b $00
[00006c3a]                           dc.b $00
[00006c3b]                           dc.b $00
[00006c3c]                           dc.b $00
[00006c3d]                           dc.b $00
[00006c3e]                           dc.b $00
[00006c3f]                           dc.b $00
[00006c40]                           dc.b $00
[00006c41]                           dc.b $00
[00006c42]                           dc.b $00
[00006c43]                           dc.b $00
[00006c44]                           dc.b $00
[00006c45]                           dc.b $00
[00006c46]                           dc.b $00
[00006c47]                           dc.b $00
[00006c48]                           dc.b $00
[00006c49]                           dc.b $00
[00006c4a]                           dc.b $00
[00006c4b]                           dc.b $00
[00006c4c]                           dc.b $00
[00006c4d]                           dc.b $00
[00006c4e]                           dc.b $00
[00006c4f]                           dc.b $00
[00006c50]                           dc.b $00
[00006c51]                           dc.b $00
[00006c52]                           dc.b $00
[00006c53]                           dc.b $00
[00006c54]                           dc.b $00
[00006c55]                           dc.b $00
[00006c56]                           dc.b $00
[00006c57]                           dc.b $00
[00006c58]                           dc.b $00
[00006c59]                           dc.b $00
[00006c5a]                           dc.b $00
[00006c5b]                           dc.b $00
[00006c5c]                           dc.b $00
[00006c5d]                           dc.b $00
[00006c5e]                           dc.b $00
[00006c5f]                           dc.b $00
[00006c60]                           dc.b $00
[00006c61]                           dc.b $00
[00006c62]                           dc.b $00
[00006c63]                           dc.b $00
[00006c64]                           dc.b $00
[00006c65]                           dc.b $00
[00006c66]                           dc.b $00
[00006c67]                           dc.b $00
[00006c68]                           dc.b $00
[00006c69]                           dc.b $00
[00006c6a]                           dc.b $00
[00006c6b]                           dc.b $00
[00006c6c]                           dc.b $00
[00006c6d]                           dc.b $00
[00006c6e]                           dc.b $00
[00006c6f]                           dc.b $00
[00006c70]                           dc.b $00
[00006c71]                           dc.b $00
[00006c72]                           dc.b $00
[00006c73]                           dc.b $00
[00006c74]                           dc.b $00
[00006c75]                           dc.b $00
[00006c76]                           dc.b $00
[00006c77]                           dc.b $00
[00006c78]                           dc.b $00
[00006c79]                           dc.b $00
[00006c7a]                           dc.b $00
[00006c7b]                           dc.b $00
[00006c7c]                           dc.b $00
[00006c7d]                           dc.b $00
[00006c7e]                           dc.b $00
[00006c7f]                           dc.b $00
[00006c80]                           dc.b $00
[00006c81]                           dc.b $00
[00006c82]                           dc.b $00
[00006c83]                           dc.b $00
[00006c84]                           dc.b $00
[00006c85]                           dc.b $00
[00006c86]                           dc.b $00
[00006c87]                           dc.b $00
[00006c88]                           dc.b $00
[00006c89]                           dc.b $00
[00006c8a]                           dc.b $00
[00006c8b]                           dc.b $00
[00006c8c]                           dc.b $00
[00006c8d]                           dc.b $00
[00006c8e]                           dc.b $00
[00006c8f]                           dc.b $00
[00006c90]                           dc.b $00
[00006c91]                           dc.b $00
[00006c92]                           dc.b $00
[00006c93]                           dc.b $00
[00006c94]                           dc.b $00
[00006c95]                           dc.b $00
[00006c96]                           dc.b $00
[00006c97]                           dc.b $00
[00006c98]                           dc.b $00
[00006c99]                           dc.b $00
[00006c9a]                           dc.b $00
[00006c9b]                           dc.b $00
[00006c9c]                           dc.b $00
[00006c9d]                           dc.b $00
[00006c9e]                           dc.b $00
[00006c9f]                           dc.b $00
[00006ca0]                           dc.b $00
[00006ca1]                           dc.b $00
[00006ca2]                           dc.b $00
[00006ca3]                           dc.b $00
[00006ca4]                           dc.b $00
[00006ca5]                           dc.b $00
[00006ca6]                           dc.b $00
[00006ca7]                           dc.b $00
[00006ca8]                           dc.b $00
[00006ca9]                           dc.b $00
[00006caa]                           dc.b $00
[00006cab]                           dc.b $00
[00006cac]                           dc.b $00
[00006cad]                           dc.b $00
[00006cae]                           dc.b $00
[00006caf]                           dc.b $00
[00006cb0]                           dc.b $00
[00006cb1]                           dc.b $00
[00006cb2]                           dc.b $00
[00006cb3]                           dc.b $00
[00006cb4]                           dc.b $00
[00006cb5]                           dc.b $00
[00006cb6]                           dc.b $00
[00006cb7]                           dc.b $00
[00006cb8]                           dc.b $00
[00006cb9]                           dc.b $00
[00006cba]                           dc.b $00
[00006cbb]                           dc.b $00
[00006cbc]                           dc.b $00
[00006cbd]                           dc.b $00
[00006cbe]                           dc.b $00
[00006cbf]                           dc.b $00
[00006cc0]                           dc.b $00
[00006cc1]                           dc.b $00
[00006cc2]                           dc.b $00
[00006cc3]                           dc.b $00
[00006cc4]                           dc.b $00
[00006cc5]                           dc.b $00
[00006cc6]                           dc.b $00
[00006cc7]                           dc.b $00
[00006cc8]                           dc.b $00
[00006cc9]                           dc.b $00
[00006cca]                           dc.b $00
[00006ccb]                           dc.b $00
[00006ccc]                           dc.b $00
[00006ccd]                           dc.b $00
[00006cce]                           dc.b $00
[00006ccf]                           dc.b $00
[00006cd0]                           dc.b $00
[00006cd1]                           dc.b $00
[00006cd2]                           dc.b $00
[00006cd3]                           dc.b $00
[00006cd4]                           dc.b $00
[00006cd5]                           dc.b $00
[00006cd6]                           dc.b $00
[00006cd7]                           dc.b $00
[00006cd8]                           dc.b $00
[00006cd9]                           dc.b $00
[00006cda]                           dc.b $00
[00006cdb]                           dc.b $00
[00006cdc]                           dc.b $00
[00006cdd]                           dc.b $00
[00006cde]                           dc.b $00
[00006cdf]                           dc.b $00
[00006ce0]                           dc.b $00
[00006ce1]                           dc.b $00
[00006ce2]                           dc.b $00
[00006ce3]                           dc.b $00
[00006ce4]                           dc.b $00
[00006ce5]                           dc.b $00
[00006ce6]                           dc.b $00
[00006ce7]                           dc.b $00
[00006ce8]                           dc.b $00
[00006ce9]                           dc.b $00
[00006cea]                           dc.b $00
[00006ceb]                           dc.b $00
[00006cec]                           dc.b $00
[00006ced]                           dc.b $00
[00006cee]                           dc.b $00
[00006cef]                           dc.b $00
[00006cf0]                           dc.b $00
[00006cf1]                           dc.b $00
[00006cf2]                           dc.b $00
[00006cf3]                           dc.b $00
[00006cf4]                           dc.b $00
[00006cf5]                           dc.b $00
[00006cf6]                           dc.b $00
[00006cf7]                           dc.b $00
[00006cf8]                           dc.b $00
[00006cf9]                           dc.b $00
[00006cfa]                           dc.b $00
[00006cfb]                           dc.b $00
[00006cfc]                           dc.b $00
[00006cfd]                           dc.b $00
[00006cfe]                           dc.b $00
[00006cff]                           dc.b $00
[00006d00]                           dc.b $00
[00006d01]                           dc.b $00
[00006d02]                           dc.b $00
[00006d03]                           dc.b $00
[00006d04]                           dc.b $00
[00006d05]                           dc.b $00
[00006d06]                           dc.b $00
[00006d07]                           dc.b $00
[00006d08]                           dc.b $00
[00006d09]                           dc.b $00
[00006d0a]                           dc.b $00
[00006d0b]                           dc.b $00
[00006d0c]                           dc.b $00
[00006d0d]                           dc.b $00
[00006d0e]                           dc.b $00
[00006d0f]                           dc.b $00
[00006d10]                           dc.b $00
[00006d11]                           dc.b $00
[00006d12]                           dc.b $00
[00006d13]                           dc.b $00
[00006d14]                           dc.b $00
[00006d15]                           dc.b $00
[00006d16]                           dc.b $00
[00006d17]                           dc.b $00
[00006d18]                           dc.b $00
[00006d19]                           dc.b $00
[00006d1a]                           dc.b $00
[00006d1b]                           dc.b $00
[00006d1c]                           dc.b $00
[00006d1d]                           dc.b $00
[00006d1e]                           dc.b $00
[00006d1f]                           dc.b $00
[00006d20]                           dc.b $00
[00006d21]                           dc.b $00
[00006d22]                           dc.b $00
[00006d23]                           dc.b $00
[00006d24]                           dc.b $00
[00006d25]                           dc.b $00
[00006d26]                           dc.b $00
[00006d27]                           dc.b $00
[00006d28]                           dc.b $00
[00006d29]                           dc.b $00
[00006d2a]                           dc.b $00
[00006d2b]                           dc.b $00
[00006d2c]                           dc.b $00
[00006d2d]                           dc.b $00
[00006d2e]                           dc.b $00
[00006d2f]                           dc.b $00
[00006d30]                           dc.b $00
[00006d31]                           dc.b $00
[00006d32]                           dc.b $00
[00006d33]                           dc.b $00
[00006d34]                           dc.b $00
[00006d35]                           dc.b $00
[00006d36]                           dc.b $00
[00006d37]                           dc.b $00
[00006d38]                           dc.b $00
[00006d39]                           dc.b $00
[00006d3a]                           dc.b $00
[00006d3b]                           dc.b $00
[00006d3c]                           dc.b $00
[00006d3d]                           dc.b $00
[00006d3e]                           dc.b $00
[00006d3f]                           dc.b $00
[00006d40]                           dc.b $00
[00006d41]                           dc.b $00
[00006d42]                           dc.b $00
[00006d43]                           dc.b $00
[00006d44]                           dc.b $00
[00006d45]                           dc.b $00
[00006d46]                           dc.b $00
[00006d47]                           dc.b $00
[00006d48]                           dc.b $00
[00006d49]                           dc.b $00
[00006d4a]                           dc.b $00
[00006d4b]                           dc.b $00
[00006d4c]                           dc.b $00
[00006d4d]                           dc.b $00
[00006d4e]                           dc.b $00
[00006d4f]                           dc.b $00
[00006d50]                           dc.b $00
[00006d51]                           dc.b $00
[00006d52]                           dc.b $00
[00006d53]                           dc.b $00
[00006d54]                           dc.b $00
[00006d55]                           dc.b $00
[00006d56]                           dc.b $00
[00006d57]                           dc.b $00
[00006d58]                           dc.b $00
[00006d59]                           dc.b $00
[00006d5a]                           dc.b $00
[00006d5b]                           dc.b $00
[00006d5c]                           dc.b $00
[00006d5d]                           dc.b $00
[00006d5e]                           dc.b $00
[00006d5f]                           dc.b $00
[00006d60]                           dc.b $00
[00006d61]                           dc.b $00
[00006d62]                           dc.b $00
[00006d63]                           dc.b $00
[00006d64]                           dc.b $00
[00006d65]                           dc.b $00
[00006d66]                           dc.b $00
[00006d67]                           dc.b $00
[00006d68]                           dc.b $00
[00006d69]                           dc.b $00
[00006d6a]                           dc.b $00
[00006d6b]                           dc.b $00
[00006d6c]                           dc.b $00
[00006d6d]                           dc.b $00
[00006d6e]                           dc.b $00
[00006d6f]                           dc.b $00
[00006d70]                           dc.b $00
[00006d71]                           dc.b $00
[00006d72]                           dc.b $00
[00006d73]                           dc.b $00
[00006d74]                           dc.b $00
[00006d75]                           dc.b $00
[00006d76]                           dc.b $00
[00006d77]                           dc.b $00
[00006d78]                           dc.b $00
[00006d79]                           dc.b $00
[00006d7a]                           dc.b $00
[00006d7b]                           dc.b $00
[00006d7c]                           dc.b $00
[00006d7d]                           dc.b $00
[00006d7e]                           dc.b $00
[00006d7f]                           dc.b $00
[00006d80]                           dc.b $00
[00006d81]                           dc.b $00
[00006d82]                           dc.b $00
[00006d83]                           dc.b $00
[00006d84]                           dc.b $00
[00006d85]                           dc.b $00
[00006d86]                           dc.b $00
[00006d87]                           dc.b $00
[00006d88]                           dc.b $00
[00006d89]                           dc.b $00
[00006d8a]                           dc.b $00
[00006d8b]                           dc.b $00
[00006d8c]                           dc.b $00
[00006d8d]                           dc.b $00
[00006d8e]                           dc.b $00
[00006d8f]                           dc.b $00
[00006d90]                           dc.b $00
[00006d91]                           dc.b $00
[00006d92]                           dc.b $00
[00006d93]                           dc.b $00
[00006d94]                           dc.b $00
[00006d95]                           dc.b $00
[00006d96]                           dc.b $00
[00006d97]                           dc.b $00
[00006d98]                           dc.b $00
[00006d99]                           dc.b $00
[00006d9a]                           dc.b $00
[00006d9b]                           dc.b $00
[00006d9c]                           dc.b $00
[00006d9d]                           dc.b $00
[00006d9e]                           dc.b $00
[00006d9f]                           dc.b $00
[00006da0]                           dc.b $00
[00006da1]                           dc.b $00
[00006da2]                           dc.b $00
[00006da3]                           dc.b $00
[00006da4]                           dc.b $00
[00006da5]                           dc.b $00
[00006da6]                           dc.b $00
[00006da7]                           dc.b $00
[00006da8]                           dc.b $00
[00006da9]                           dc.b $00
[00006daa]                           dc.b $00
[00006dab]                           dc.b $00
[00006dac]                           dc.b $00
[00006dad]                           dc.b $00
[00006dae]                           dc.b $00
[00006daf]                           dc.b $00
[00006db0]                           dc.b $00
[00006db1]                           dc.b $00
[00006db2]                           dc.b $00
[00006db3]                           dc.b $00
[00006db4]                           dc.b $00
[00006db5]                           dc.b $00
[00006db6]                           dc.b $00
[00006db7]                           dc.b $00
[00006db8]                           dc.b $00
[00006db9]                           dc.b $00
[00006dba]                           dc.b $00
[00006dbb]                           dc.b $00
[00006dbc]                           dc.b $00
[00006dbd]                           dc.b $00
[00006dbe]                           dc.b $00
[00006dbf]                           dc.b $00
[00006dc0]                           dc.b $00
[00006dc1]                           dc.b $00
[00006dc2]                           dc.b $00
[00006dc3]                           dc.b $00
[00006dc4]                           dc.b $00
[00006dc5]                           dc.b $00
[00006dc6]                           dc.b $00
[00006dc7]                           dc.b $00
[00006dc8]                           dc.b $00
[00006dc9]                           dc.b $00
[00006dca]                           dc.b $00
[00006dcb]                           dc.b $00
[00006dcc]                           dc.b $00
[00006dcd]                           dc.b $00
[00006dce]                           dc.b $00
[00006dcf]                           dc.b $00
[00006dd0]                           dc.b $00
[00006dd1]                           dc.b $00
[00006dd2]                           dc.b $00
[00006dd3]                           dc.b $00
[00006dd4]                           dc.b $00
[00006dd5]                           dc.b $00
[00006dd6]                           dc.b $00
[00006dd7]                           dc.b $00
[00006dd8]                           dc.b $00
[00006dd9]                           dc.b $00
[00006dda]                           dc.b $00
[00006ddb]                           dc.b $00
[00006ddc]                           dc.b $00
[00006ddd]                           dc.b $00
[00006dde]                           dc.b $00
[00006ddf]                           dc.b $00
[00006de0]                           dc.b $00
[00006de1]                           dc.b $00
[00006de2]                           dc.b $00
[00006de3]                           dc.b $00
[00006de4]                           dc.b $00
[00006de5]                           dc.b $00
[00006de6]                           dc.b $00
[00006de7]                           dc.b $00
[00006de8]                           dc.b $00
[00006de9]                           dc.b $00
[00006dea]                           dc.b $00
[00006deb]                           dc.b $00
[00006dec]                           dc.b $00
[00006ded]                           dc.b $00
[00006dee]                           dc.b $00
[00006def]                           dc.b $00
[00006df0]                           dc.b $00
[00006df1]                           dc.b $00
[00006df2]                           dc.b $00
[00006df3]                           dc.b $00
[00006df4]                           dc.b $00
[00006df5]                           dc.b $00
[00006df6]                           dc.b $00
[00006df7]                           dc.b $00
[00006df8]                           dc.b $00
[00006df9]                           dc.b $00
[00006dfa]                           dc.b $00
[00006dfb]                           dc.b $00
[00006dfc]                           dc.b $00
[00006dfd]                           dc.b $00
[00006dfe]                           dc.b $00
[00006dff]                           dc.b $00
[00006e00]                           dc.b $00
[00006e01]                           dc.b $00
[00006e02]                           dc.b $00
[00006e03]                           dc.b $00
[00006e04]                           dc.b $00
[00006e05]                           dc.b $00
[00006e06]                           dc.b $00
[00006e07]                           dc.b $00
[00006e08]                           dc.b $00
[00006e09]                           dc.b $00
[00006e0a]                           dc.b $00
[00006e0b]                           dc.b $00
[00006e0c]                           dc.b $00
[00006e0d]                           dc.b $00
[00006e0e]                           dc.b $00
[00006e0f]                           dc.b $00
[00006e10]                           dc.b $00
[00006e11]                           dc.b $00
[00006e12]                           dc.b $00
[00006e13]                           dc.b $00
[00006e14]                           dc.b $00
[00006e15]                           dc.b $00
[00006e16]                           dc.b $00
[00006e17]                           dc.b $00
[00006e18]                           dc.b $00
[00006e19]                           dc.b $00
[00006e1a]                           dc.b $00
[00006e1b]                           dc.b $00
[00006e1c]                           dc.b $00
[00006e1d]                           dc.b $00
[00006e1e]                           dc.b $00
[00006e1f]                           dc.b $00
[00006e20]                           dc.b $00
[00006e21]                           dc.b $00
[00006e22]                           dc.b $00
[00006e23]                           dc.b $00
[00006e24]                           dc.b $00
[00006e25]                           dc.b $00
[00006e26]                           dc.b $00
[00006e27]                           dc.b $00
[00006e28]                           dc.b $00
[00006e29]                           dc.b $00
[00006e2a]                           dc.b $00
[00006e2b]                           dc.b $00
[00006e2c]                           dc.b $00
[00006e2d]                           dc.b $00
[00006e2e]                           dc.b $00
[00006e2f]                           dc.b $00
[00006e30]                           dc.b $00
[00006e31]                           dc.b $00
[00006e32]                           dc.b $00
[00006e33]                           dc.b $00
[00006e34]                           dc.b $00
[00006e35]                           dc.b $00
[00006e36]                           dc.b $00
[00006e37]                           dc.b $00
[00006e38]                           dc.b $00
[00006e39]                           dc.b $00
[00006e3a]                           dc.b $00
[00006e3b]                           dc.b $00
[00006e3c]                           dc.b $00
[00006e3d]                           dc.b $00
[00006e3e]                           dc.b $00
[00006e3f]                           dc.b $00
[00006e40]                           dc.b $00
[00006e41]                           dc.b $00
[00006e42]                           dc.b $00
[00006e43]                           dc.b $00
[00006e44]                           dc.b $00
[00006e45]                           dc.b $00
[00006e46]                           dc.b $00
[00006e47]                           dc.b $00
[00006e48]                           dc.b $00
[00006e49]                           dc.b $00
[00006e4a]                           dc.b $00
[00006e4b]                           dc.b $00
[00006e4c]                           dc.b $00
[00006e4d]                           dc.b $00
[00006e4e]                           dc.b $00
[00006e4f]                           dc.b $00
[00006e50]                           dc.b $00
[00006e51]                           dc.b $00
[00006e52]                           dc.b $00
[00006e53]                           dc.b $00
[00006e54]                           dc.b $00
[00006e55]                           dc.b $00
[00006e56]                           dc.b $00
[00006e57]                           dc.b $00
[00006e58]                           dc.b $00
[00006e59]                           dc.b $00
[00006e5a]                           dc.b $00
[00006e5b]                           dc.b $00
[00006e5c]                           dc.b $00
[00006e5d]                           dc.b $00
[00006e5e]                           dc.b $00
[00006e5f]                           dc.b $00
[00006e60]                           dc.b $00
[00006e61]                           dc.b $00
[00006e62]                           dc.b $00
[00006e63]                           dc.b $00
[00006e64]                           dc.b $00
[00006e65]                           dc.b $00
[00006e66]                           dc.b $00
[00006e67]                           dc.b $00
[00006e68]                           dc.b $00
[00006e69]                           dc.b $00
[00006e6a]                           dc.b $00
[00006e6b]                           dc.b $00
[00006e6c]                           dc.b $00
[00006e6d]                           dc.b $00
[00006e6e]                           dc.b $00
[00006e6f]                           dc.b $00
[00006e70]                           dc.b $00
[00006e71]                           dc.b $00
[00006e72]                           dc.b $00
[00006e73]                           dc.b $00
[00006e74]                           dc.b $00
[00006e75]                           dc.b $00
[00006e76]                           dc.b $00
[00006e77]                           dc.b $00
[00006e78]                           dc.b $00
[00006e79]                           dc.b $00
[00006e7a]                           dc.b $00
[00006e7b]                           dc.b $00
[00006e7c]                           dc.b $00
[00006e7d]                           dc.b $00
[00006e7e]                           dc.b $00
[00006e7f]                           dc.b $00
[00006e80]                           dc.b $00
[00006e81]                           dc.b $00
[00006e82]                           dc.b $00
[00006e83]                           dc.b $00
[00006e84]                           dc.b $00
[00006e85]                           dc.b $00
[00006e86]                           dc.b $00
[00006e87]                           dc.b $00
[00006e88]                           dc.b $00
[00006e89]                           dc.b $00
[00006e8a]                           dc.b $00
[00006e8b]                           dc.b $00
[00006e8c]                           dc.b $00
[00006e8d]                           dc.b $00
[00006e8e]                           dc.b $00
[00006e8f]                           dc.b $00
[00006e90]                           dc.b $00
[00006e91]                           dc.b $00
[00006e92]                           dc.b $00
[00006e93]                           dc.b $00
[00006e94]                           dc.b $00
[00006e95]                           dc.b $00
[00006e96]                           dc.b $00
[00006e97]                           dc.b $00
[00006e98]                           dc.b $00
[00006e99]                           dc.b $00
[00006e9a]                           dc.b $00
[00006e9b]                           dc.b $00
[00006e9c]                           dc.b $00
[00006e9d]                           dc.b $00
[00006e9e]                           dc.b $00
[00006e9f]                           dc.b $00
[00006ea0]                           dc.b $00
[00006ea1]                           dc.b $00
[00006ea2]                           dc.b $00
[00006ea3]                           dc.b $00
[00006ea4]                           dc.b $00
[00006ea5]                           dc.b $00
[00006ea6]                           dc.b $00
[00006ea7]                           dc.b $00
[00006ea8]                           dc.b $00
[00006ea9]                           dc.b $00
[00006eaa]                           dc.b $00
[00006eab]                           dc.b $00
[00006eac]                           dc.b $00
[00006ead]                           dc.b $00
[00006eae]                           dc.b $00
[00006eaf]                           dc.b $00
[00006eb0]                           dc.b $00
[00006eb1]                           dc.b $00
[00006eb2]                           dc.b $00
[00006eb3]                           dc.b $00
[00006eb4]                           dc.b $00
[00006eb5]                           dc.b $00
[00006eb6]                           dc.b $00
[00006eb7]                           dc.b $00
[00006eb8]                           dc.b $00
[00006eb9]                           dc.b $00
[00006eba]                           dc.b $00
[00006ebb]                           dc.b $00
[00006ebc]                           dc.b $00
[00006ebd]                           dc.b $00
[00006ebe]                           dc.b $00
[00006ebf]                           dc.b $00
[00006ec0]                           dc.b $00
[00006ec1]                           dc.b $00
[00006ec2]                           dc.b $00
[00006ec3]                           dc.b $00
[00006ec4]                           dc.b $00
[00006ec5]                           dc.b $00
[00006ec6]                           dc.b $00
[00006ec7]                           dc.b $00
[00006ec8]                           dc.b $00
[00006ec9]                           dc.b $00
[00006eca]                           dc.b $00
[00006ecb]                           dc.b $00
[00006ecc]                           dc.b $00
[00006ecd]                           dc.b $00
[00006ece]                           dc.b $00
[00006ecf]                           dc.b $00
[00006ed0]                           dc.b $00
[00006ed1]                           dc.b $00
[00006ed2]                           dc.b $00
[00006ed3]                           dc.b $00
[00006ed4]                           dc.b $00
[00006ed5]                           dc.b $00
[00006ed6]                           dc.b $00
[00006ed7]                           dc.b $00
[00006ed8]                           dc.b $00
[00006ed9]                           dc.b $00
[00006eda]                           dc.b $00
[00006edb]                           dc.b $00
[00006edc]                           dc.b $00
[00006edd]                           dc.b $00
[00006ede]                           dc.b $00
[00006edf]                           dc.b $00
[00006ee0]                           dc.b $00
[00006ee1]                           dc.b $00
[00006ee2]                           dc.b $00
[00006ee3]                           dc.b $00
[00006ee4]                           dc.b $00
[00006ee5]                           dc.b $00
[00006ee6]                           dc.b $00
[00006ee7]                           dc.b $00
[00006ee8]                           dc.b $00
[00006ee9]                           dc.b $00
[00006eea]                           dc.b $00
[00006eeb]                           dc.b $00
[00006eec]                           dc.b $00
[00006eed]                           dc.b $00
[00006eee]                           dc.b $00
[00006eef]                           dc.b $00
[00006ef0]                           dc.b $00
[00006ef1]                           dc.b $00
[00006ef2]                           dc.b $00
[00006ef3]                           dc.b $00
[00006ef4]                           dc.b $00
[00006ef5]                           dc.b $00
[00006ef6]                           dc.b $00
[00006ef7]                           dc.b $00
[00006ef8]                           dc.b $00
[00006ef9]                           dc.b $00
[00006efa]                           dc.b $00
[00006efb]                           dc.b $00
[00006efc]                           dc.b $00
[00006efd]                           dc.b $00
[00006efe]                           dc.b $00
[00006eff]                           dc.b $00
[00006f00]                           dc.b $00
[00006f01]                           dc.b $00
[00006f02]                           dc.b $00
[00006f03]                           dc.b $00
[00006f04]                           dc.b $00
[00006f05]                           dc.b $00
[00006f06]                           dc.b $00
[00006f07]                           dc.b $00
[00006f08]                           dc.b $00
[00006f09]                           dc.b $00
[00006f0a]                           dc.b $00
[00006f0b]                           dc.b $00
[00006f0c]                           dc.b $00
[00006f0d]                           dc.b $00
[00006f0e]                           dc.b $00
[00006f0f]                           dc.b $00
[00006f10]                           dc.b $00
[00006f11]                           dc.b $00
[00006f12]                           dc.b $00
[00006f13]                           dc.b $00
[00006f14]                           dc.b $00
[00006f15]                           dc.b $00
[00006f16]                           dc.b $00
[00006f17]                           dc.b $00
[00006f18]                           dc.b $00
[00006f19]                           dc.b $00
[00006f1a]                           dc.b $00
[00006f1b]                           dc.b $00
[00006f1c]                           dc.b $00
[00006f1d]                           dc.b $00
[00006f1e]                           dc.b $00
[00006f1f]                           dc.b $00
[00006f20]                           dc.b $00
[00006f21]                           dc.b $00
[00006f22]                           dc.b $00
[00006f23]                           dc.b $00
[00006f24]                           dc.b $00
[00006f25]                           dc.b $00
[00006f26]                           dc.b $00
[00006f27]                           dc.b $00
[00006f28]                           dc.b $00
[00006f29]                           dc.b $00
[00006f2a]                           dc.b $00
[00006f2b]                           dc.b $00
[00006f2c]                           dc.b $00
[00006f2d]                           dc.b $00
[00006f2e]                           dc.b $00
[00006f2f]                           dc.b $00
[00006f30]                           dc.b $00
[00006f31]                           dc.b $00
[00006f32]                           dc.b $00
[00006f33]                           dc.b $00
[00006f34]                           dc.b $00
[00006f35]                           dc.b $00
[00006f36]                           dc.b $00
[00006f37]                           dc.b $00
[00006f38]                           dc.b $00
[00006f39]                           dc.b $00
[00006f3a]                           dc.b $00
[00006f3b]                           dc.b $00
[00006f3c]                           dc.b $00
[00006f3d]                           dc.b $00
[00006f3e]                           dc.b $00
[00006f3f]                           dc.b $00
[00006f40]                           dc.b $00
[00006f41]                           dc.b $00
[00006f42]                           dc.b $00
[00006f43]                           dc.b $00
[00006f44]                           dc.b $00
[00006f45]                           dc.b $00
[00006f46]                           dc.b $00
[00006f47]                           dc.b $00
[00006f48]                           dc.b $00
[00006f49]                           dc.b $00
[00006f4a]                           dc.b $00
[00006f4b]                           dc.b $00
[00006f4c]                           dc.b $00
[00006f4d]                           dc.b $00
[00006f4e]                           dc.b $00
[00006f4f]                           dc.b $00
[00006f50]                           dc.b $00
[00006f51]                           dc.b $00
[00006f52]                           dc.b $00
[00006f53]                           dc.b $00
[00006f54]                           dc.b $00
[00006f55]                           dc.b $00
[00006f56]                           dc.b $00
[00006f57]                           dc.b $00
[00006f58]                           dc.b $00
[00006f59]                           dc.b $00
[00006f5a]                           dc.b $00
[00006f5b]                           dc.b $00
[00006f5c]                           dc.b $00
[00006f5d]                           dc.b $00
[00006f5e]                           dc.b $00
[00006f5f]                           dc.b $00
[00006f60]                           dc.b $00
[00006f61]                           dc.b $00
[00006f62]                           dc.b $00
[00006f63]                           dc.b $00
[00006f64]                           dc.b $00
[00006f65]                           dc.b $00
[00006f66]                           dc.b $00
[00006f67]                           dc.b $00
[00006f68]                           dc.b $00
[00006f69]                           dc.b $00
[00006f6a]                           dc.b $00
[00006f6b]                           dc.b $00
[00006f6c]                           dc.b $00
[00006f6d]                           dc.b $00
[00006f6e]                           dc.b $00
[00006f6f]                           dc.b $00
[00006f70]                           dc.b $00
[00006f71]                           dc.b $00
[00006f72]                           dc.b $00
[00006f73]                           dc.b $00
[00006f74]                           dc.b $00
[00006f75]                           dc.b $00
[00006f76]                           dc.b $00
[00006f77]                           dc.b $00
[00006f78]                           dc.b $00
[00006f79]                           dc.b $00
[00006f7a]                           dc.b $00
[00006f7b]                           dc.b $00
[00006f7c]                           dc.b $00
[00006f7d]                           dc.b $00
[00006f7e]                           dc.b $00
[00006f7f]                           dc.b $00
[00006f80]                           dc.b $00
[00006f81]                           dc.b $00
[00006f82]                           dc.b $00
[00006f83]                           dc.b $00
[00006f84]                           dc.b $00
[00006f85]                           dc.b $00
[00006f86]                           dc.b $00
[00006f87]                           dc.b $00
[00006f88]                           dc.b $00
[00006f89]                           dc.b $00
[00006f8a]                           dc.b $00
[00006f8b]                           dc.b $00
[00006f8c]                           dc.b $00
[00006f8d]                           dc.b $00
[00006f8e]                           dc.b $00
[00006f8f]                           dc.b $00
[00006f90]                           dc.b $00
[00006f91]                           dc.b $00
[00006f92]                           dc.b $00
[00006f93]                           dc.b $00
[00006f94]                           dc.b $00
[00006f95]                           dc.b $00
[00006f96]                           dc.b $00
[00006f97]                           dc.b $00
[00006f98]                           dc.b $00
[00006f99]                           dc.b $00
[00006f9a]                           dc.b $00
[00006f9b]                           dc.b $00
[00006f9c]                           dc.b $00
[00006f9d]                           dc.b $00
[00006f9e]                           dc.b $00
[00006f9f]                           dc.b $00
[00006fa0]                           dc.b $00
[00006fa1]                           dc.b $00
[00006fa2]                           dc.b $00
[00006fa3]                           dc.b $00
[00006fa4]                           dc.b $00
[00006fa5]                           dc.b $00
[00006fa6]                           dc.b $00
[00006fa7]                           dc.b $00
[00006fa8]                           dc.b $00
[00006fa9]                           dc.b $00
[00006faa]                           dc.b $00
[00006fab]                           dc.b $00
[00006fac]                           dc.b $00
[00006fad]                           dc.b $00
[00006fae]                           dc.b $00
[00006faf]                           dc.b $00
[00006fb0]                           dc.b $00
[00006fb1]                           dc.b $00
[00006fb2]                           dc.b $00
[00006fb3]                           dc.b $00
[00006fb4]                           dc.b $00
[00006fb5]                           dc.b $00
[00006fb6]                           dc.b $00
[00006fb7]                           dc.b $00
[00006fb8]                           dc.b $00
[00006fb9]                           dc.b $00
[00006fba]                           dc.b $00
[00006fbb]                           dc.b $00
[00006fbc]                           dc.b $00
[00006fbd]                           dc.b $00
[00006fbe]                           dc.b $00
[00006fbf]                           dc.b $00
[00006fc0]                           dc.b $00
[00006fc1]                           dc.b $00
[00006fc2]                           dc.b $00
[00006fc3]                           dc.b $00
[00006fc4]                           dc.b $00
[00006fc5]                           dc.b $00
[00006fc6]                           dc.b $00
[00006fc7]                           dc.b $00
[00006fc8]                           dc.b $00
[00006fc9]                           dc.b $00
[00006fca]                           dc.b $00
[00006fcb]                           dc.b $00
[00006fcc]                           dc.b $00
[00006fcd]                           dc.b $00
[00006fce]                           dc.b $00
[00006fcf]                           dc.b $00
[00006fd0]                           dc.b $00
[00006fd1]                           dc.b $00
[00006fd2]                           dc.b $00
[00006fd3]                           dc.b $00
[00006fd4]                           dc.b $00
[00006fd5]                           dc.b $00
[00006fd6]                           dc.b $00
[00006fd7]                           dc.b $00
[00006fd8]                           dc.b $00
[00006fd9]                           dc.b $00
[00006fda]                           dc.b $00
[00006fdb]                           dc.b $00
[00006fdc]                           dc.b $00
[00006fdd]                           dc.b $00
[00006fde]                           dc.b $00
[00006fdf]                           dc.b $00
[00006fe0]                           dc.b $00
[00006fe1]                           dc.b $00
[00006fe2]                           dc.b $00
[00006fe3]                           dc.b $00
[00006fe4]                           dc.b $00
[00006fe5]                           dc.b $00
[00006fe6]                           dc.b $00
[00006fe7]                           dc.b $00
[00006fe8]                           dc.b $00
[00006fe9]                           dc.b $00
[00006fea]                           dc.b $00
[00006feb]                           dc.b $00
[00006fec]                           dc.b $00
[00006fed]                           dc.b $00
[00006fee]                           dc.b $00
[00006fef]                           dc.b $00
[00006ff0]                           dc.b $00
[00006ff1]                           dc.b $00
[00006ff2]                           dc.b $00
[00006ff3]                           dc.b $00
[00006ff4]                           dc.b $00
[00006ff5]                           dc.b $00
[00006ff6]                           dc.b $00
[00006ff7]                           dc.b $00
[00006ff8]                           dc.b $00
[00006ff9]                           dc.b $00
[00006ffa]                           dc.b $00
[00006ffb]                           dc.b $00
[00006ffc]                           dc.b $00
[00006ffd]                           dc.b $00
[00006ffe]                           dc.b $00
[00006fff]                           dc.b $00
[00007000]                           dc.b $00
[00007001]                           dc.b $00
[00007002]                           dc.b $00
[00007003]                           dc.b $00
[00007004]                           dc.b $00
[00007005]                           dc.b $00
[00007006]                           dc.b $00
[00007007]                           dc.b $00
[00007008]                           dc.b $00
[00007009]                           dc.b $00
[0000700a]                           dc.b $00
[0000700b]                           dc.b $00
[0000700c]                           dc.b $00
[0000700d]                           dc.b $00
[0000700e]                           dc.b $00
[0000700f]                           dc.b $00
[00007010]                           dc.b $00
[00007011]                           dc.b $00
[00007012]                           dc.b $00
[00007013]                           dc.b $00
[00007014]                           dc.b $00
[00007015]                           dc.b $00
[00007016]                           dc.b $00
[00007017]                           dc.b $00
[00007018]                           dc.b $00
[00007019]                           dc.b $00
[0000701a]                           dc.b $00
[0000701b]                           dc.b $00
[0000701c]                           dc.b $00
[0000701d]                           dc.b $00
[0000701e]                           dc.b $00
[0000701f]                           dc.b $00
[00007020]                           dc.b $00
[00007021]                           dc.b $00
[00007022]                           dc.b $00
[00007023]                           dc.b $00
[00007024]                           dc.b $00
[00007025]                           dc.b $00
[00007026]                           dc.b $00
[00007027]                           dc.b $00
[00007028]                           dc.b $00
[00007029]                           dc.b $00
[0000702a]                           dc.b $00
[0000702b]                           dc.b $00
[0000702c]                           dc.b $00
[0000702d]                           dc.b $00
[0000702e]                           dc.b $00
[0000702f]                           dc.b $00
[00007030]                           dc.b $00
[00007031]                           dc.b $00
[00007032]                           dc.b $00
[00007033]                           dc.b $00
[00007034]                           dc.b $00
[00007035]                           dc.b $00
[00007036]                           dc.b $00
[00007037]                           dc.b $00
[00007038]                           dc.b $00
[00007039]                           dc.b $00
[0000703a]                           dc.b $00
[0000703b]                           dc.b $00
[0000703c]                           dc.b $00
[0000703d]                           dc.b $00
[0000703e]                           dc.b $00
[0000703f]                           dc.b $00
[00007040]                           dc.b $00
[00007041]                           dc.b $00
[00007042]                           dc.b $00
[00007043]                           dc.b $00
[00007044]                           dc.b $00
[00007045]                           dc.b $00
[00007046]                           dc.b $00
[00007047]                           dc.b $00
[00007048]                           dc.b $00
[00007049]                           dc.b $00
[0000704a]                           dc.b $00
[0000704b]                           dc.b $00
[0000704c]                           dc.b $00
[0000704d]                           dc.b $00
[0000704e]                           dc.b $00
[0000704f]                           dc.b $00
[00007050]                           dc.b $00
[00007051]                           dc.b $00
[00007052]                           dc.b $00
[00007053]                           dc.b $00
[00007054]                           dc.b $00
[00007055]                           dc.b $00
[00007056]                           dc.b $00
[00007057]                           dc.b $00
[00007058]                           dc.b $00
[00007059]                           dc.b $00
[0000705a]                           dc.b $00
[0000705b]                           dc.b $00
[0000705c]                           dc.b $00
[0000705d]                           dc.b $00
[0000705e]                           dc.b $00
[0000705f]                           dc.b $00
[00007060]                           dc.b $00
[00007061]                           dc.b $00
[00007062]                           dc.b $00
[00007063]                           dc.b $00
[00007064]                           dc.b $00
[00007065]                           dc.b $00
[00007066]                           dc.b $00
[00007067]                           dc.b $00
[00007068]                           dc.b $00
[00007069]                           dc.b $00
[0000706a]                           dc.b $00
[0000706b]                           dc.b $00
[0000706c]                           dc.b $00
[0000706d]                           dc.b $00
[0000706e]                           dc.b $00
[0000706f]                           dc.b $00
[00007070]                           dc.b $00
[00007071]                           dc.b $00
[00007072]                           dc.b $00
[00007073]                           dc.b $00
[00007074]                           dc.b $00
[00007075]                           dc.b $00
[00007076]                           dc.b $00
[00007077]                           dc.b $00
[00007078]                           dc.b $00
[00007079]                           dc.b $00
[0000707a]                           dc.b $00
[0000707b]                           dc.b $00
[0000707c]                           dc.b $00
[0000707d]                           dc.b $00
[0000707e]                           dc.b $00
[0000707f]                           dc.b $00
[00007080]                           dc.b $00
[00007081]                           dc.b $00
[00007082]                           dc.b $00
[00007083]                           dc.b $00
[00007084]                           dc.b $00
[00007085]                           dc.b $00
[00007086]                           dc.b $00
[00007087]                           dc.b $00
[00007088]                           dc.b $00
[00007089]                           dc.b $00
[0000708a]                           dc.b $00
[0000708b]                           dc.b $00
[0000708c]                           dc.b $00
[0000708d]                           dc.b $00
[0000708e]                           dc.b $00
[0000708f]                           dc.b $00
[00007090]                           dc.b $00
[00007091]                           dc.b $00
[00007092]                           dc.b $00
[00007093]                           dc.b $00
[00007094]                           dc.b $00
[00007095]                           dc.b $00
[00007096]                           dc.b $00
[00007097]                           dc.b $00
[00007098]                           dc.b $00
[00007099]                           dc.b $00
[0000709a]                           dc.b $00
[0000709b]                           dc.b $00
[0000709c]                           dc.b $00
[0000709d]                           dc.b $00
[0000709e]                           dc.b $00
[0000709f]                           dc.b $00
[000070a0]                           dc.b $00
[000070a1]                           dc.b $00
[000070a2]                           dc.b $00
[000070a3]                           dc.b $00
[000070a4]                           dc.b $00
[000070a5]                           dc.b $00
[000070a6]                           dc.b $00
[000070a7]                           dc.b $00
[000070a8]                           dc.b $00
[000070a9]                           dc.b $00
[000070aa]                           dc.b $00
[000070ab]                           dc.b $00
[000070ac]                           dc.b $00
[000070ad]                           dc.b $00
[000070ae]                           dc.b $00
[000070af]                           dc.b $00
[000070b0]                           dc.b $00
[000070b1]                           dc.b $00
[000070b2]                           dc.b $00
[000070b3]                           dc.b $00
[000070b4]                           dc.b $00
[000070b5]                           dc.b $00
[000070b6]                           dc.b $00
[000070b7]                           dc.b $00
[000070b8]                           dc.b $00
[000070b9]                           dc.b $00
[000070ba]                           dc.b $00
[000070bb]                           dc.b $00
[000070bc]                           dc.b $00
[000070bd]                           dc.b $00
[000070be]                           dc.b $00
[000070bf]                           dc.b $00
[000070c0]                           dc.b $00
[000070c1]                           dc.b $00
[000070c2]                           dc.b $00
[000070c3]                           dc.b $00
[000070c4]                           dc.b $00
[000070c5]                           dc.b $00
[000070c6]                           dc.b $00
[000070c7]                           dc.b $00
[000070c8]                           dc.b $00
[000070c9]                           dc.b $00
[000070ca]                           dc.b $00
[000070cb]                           dc.b $00
[000070cc]                           dc.b $00
[000070cd]                           dc.b $00
[000070ce]                           dc.b $00
[000070cf]                           dc.b $00
[000070d0]                           dc.b $00
[000070d1]                           dc.b $00
[000070d2]                           dc.b $00
[000070d3]                           dc.b $00
[000070d4]                           dc.b $00
[000070d5]                           dc.b $00
[000070d6]                           dc.b $00
[000070d7]                           dc.b $00
[000070d8]                           dc.b $00
[000070d9]                           dc.b $00
[000070da]                           dc.b $00
[000070db]                           dc.b $00
[000070dc]                           dc.b $00
[000070dd]                           dc.b $00
[000070de]                           dc.b $00
[000070df]                           dc.b $00
[000070e0]                           dc.b $00
[000070e1]                           dc.b $00
[000070e2]                           dc.b $00
[000070e3]                           dc.b $00
[000070e4]                           dc.b $00
[000070e5]                           dc.b $00
[000070e6]                           dc.b $00
[000070e7]                           dc.b $00
[000070e8]                           dc.b $00
[000070e9]                           dc.b $00
[000070ea]                           dc.b $00
[000070eb]                           dc.b $00
[000070ec]                           dc.b $00
[000070ed]                           dc.b $00
[000070ee]                           dc.b $00
[000070ef]                           dc.b $00
[000070f0]                           dc.b $00
[000070f1]                           dc.b $00
[000070f2]                           dc.b $00
[000070f3]                           dc.b $00
[000070f4]                           dc.b $00
[000070f5]                           dc.b $00
[000070f6]                           dc.b $00
[000070f7]                           dc.b $00
[000070f8]                           dc.b $00
[000070f9]                           dc.b $00
[000070fa]                           dc.b $00
[000070fb]                           dc.b $00
[000070fc]                           dc.b $00
[000070fd]                           dc.b $00
[000070fe]                           dc.b $00
[000070ff]                           dc.b $00
[00007100]                           dc.b $00
[00007101]                           dc.b $00
[00007102]                           dc.b $00
[00007103]                           dc.b $00
[00007104]                           dc.b $00
[00007105]                           dc.b $00
[00007106]                           dc.b $00
[00007107]                           dc.b $00
[00007108]                           dc.b $00
[00007109]                           dc.b $00
[0000710a]                           dc.b $00
[0000710b]                           dc.b $00
[0000710c]                           dc.b $00
[0000710d]                           dc.b $00
[0000710e]                           dc.b $00
[0000710f]                           dc.b $00
[00007110]                           dc.b $00
[00007111]                           dc.b $00
[00007112]                           dc.b $00
[00007113]                           dc.b $00
[00007114]                           dc.b $00
[00007115]                           dc.b $00
[00007116]                           dc.b $00
[00007117]                           dc.b $00
[00007118]                           dc.b $00
[00007119]                           dc.b $00
[0000711a]                           dc.b $00
[0000711b]                           dc.b $00
[0000711c]                           dc.b $00
[0000711d]                           dc.b $00
[0000711e]                           dc.b $00
[0000711f]                           dc.b $00
[00007120]                           dc.b $00
[00007121]                           dc.b $00
[00007122]                           dc.b $00
[00007123]                           dc.b $00
[00007124]                           dc.b $00
[00007125]                           dc.b $00
[00007126]                           dc.b $00
[00007127]                           dc.b $00
[00007128]                           dc.b $00
[00007129]                           dc.b $00
[0000712a]                           dc.b $00
[0000712b]                           dc.b $00
[0000712c]                           dc.b $00
[0000712d]                           dc.b $00
[0000712e]                           dc.b $00
[0000712f]                           dc.b $00
[00007130]                           dc.b $00
[00007131]                           dc.b $00
[00007132]                           dc.b $00
[00007133]                           dc.b $00
[00007134]                           dc.b $00
[00007135]                           dc.b $00
[00007136]                           dc.b $00
[00007137]                           dc.b $00
[00007138]                           dc.b $00
[00007139]                           dc.b $00
[0000713a]                           dc.b $00
[0000713b]                           dc.b $00
[0000713c]                           dc.b $00
[0000713d]                           dc.b $00
[0000713e]                           dc.b $00
[0000713f]                           dc.b $00
[00007140]                           dc.b $00
[00007141]                           dc.b $00
[00007142]                           dc.b $00
[00007143]                           dc.b $00
[00007144]                           dc.b $00
[00007145]                           dc.b $00
[00007146]                           dc.b $00
[00007147]                           dc.b $00
[00007148]                           dc.b $00
[00007149]                           dc.b $00
[0000714a]                           dc.b $00
[0000714b]                           dc.b $00
[0000714c]                           dc.b $00
[0000714d]                           dc.b $00
[0000714e]                           dc.b $00
[0000714f]                           dc.b $00
[00007150]                           dc.b $00
[00007151]                           dc.b $00
[00007152]                           dc.b $00
[00007153]                           dc.b $00
[00007154]                           dc.b $00
[00007155]                           dc.b $00
[00007156]                           dc.b $00
[00007157]                           dc.b $00
[00007158]                           dc.b $00
[00007159]                           dc.b $00
[0000715a]                           dc.b $00
[0000715b]                           dc.b $00
[0000715c]                           dc.b $00
[0000715d]                           dc.b $00
[0000715e]                           dc.b $00
[0000715f]                           dc.b $00
[00007160]                           dc.b $00
[00007161]                           dc.b $00
[00007162]                           dc.b $00
[00007163]                           dc.b $00
[00007164]                           dc.b $00
[00007165]                           dc.b $00
[00007166]                           dc.b $00
[00007167]                           dc.b $00
[00007168]                           dc.b $00
[00007169]                           dc.b $00
[0000716a]                           dc.b $00
[0000716b]                           dc.b $00
[0000716c]                           dc.b $00
[0000716d]                           dc.b $00
[0000716e]                           dc.b $00
[0000716f]                           dc.b $00
[00007170]                           dc.b $00
[00007171]                           dc.b $00
[00007172]                           dc.b $00
[00007173]                           dc.b $00
[00007174]                           dc.b $00
[00007175]                           dc.b $00
[00007176]                           dc.b $00
[00007177]                           dc.b $00
[00007178]                           dc.b $00
[00007179]                           dc.b $00
[0000717a]                           dc.b $00
[0000717b]                           dc.b $00
[0000717c]                           dc.b $00
[0000717d]                           dc.b $00
[0000717e]                           dc.b $00
[0000717f]                           dc.b $00
[00007180]                           dc.b $00
[00007181]                           dc.b $00
[00007182]                           dc.b $00
[00007183]                           dc.b $00
[00007184]                           dc.b $00
[00007185]                           dc.b $00
[00007186]                           dc.b $00
[00007187]                           dc.b $00
[00007188]                           dc.b $00
[00007189]                           dc.b $00
[0000718a]                           dc.b $00
[0000718b]                           dc.b $00
[0000718c]                           dc.b $00
[0000718d]                           dc.b $00
[0000718e]                           dc.b $00
[0000718f]                           dc.b $00
[00007190]                           dc.b $00
[00007191]                           dc.b $00
[00007192]                           dc.b $00
[00007193]                           dc.b $00
[00007194]                           dc.b $00
[00007195]                           dc.b $00
[00007196]                           dc.b $00
[00007197]                           dc.b $00
[00007198]                           dc.b $00
[00007199]                           dc.b $00
[0000719a]                           dc.b $00
[0000719b]                           dc.b $00
[0000719c]                           dc.b $00
[0000719d]                           dc.b $00
[0000719e]                           dc.b $00
[0000719f]                           dc.b $00
[000071a0]                           dc.b $00
[000071a1]                           dc.b $00
[000071a2]                           dc.b $00
[000071a3]                           dc.b $00
[000071a4]                           dc.b $00
[000071a5]                           dc.b $00
[000071a6]                           dc.b $00
[000071a7]                           dc.b $00
[000071a8]                           dc.b $00
[000071a9]                           dc.b $00
[000071aa]                           dc.b $00
[000071ab]                           dc.b $00
[000071ac]                           dc.b $00
[000071ad]                           dc.b $00
[000071ae]                           dc.b $00
[000071af]                           dc.b $00
[000071b0]                           dc.b $00
[000071b1]                           dc.b $00
[000071b2]                           dc.b $00
[000071b3]                           dc.b $00
[000071b4]                           dc.b $00
[000071b5]                           dc.b $00
[000071b6]                           dc.b $00
[000071b7]                           dc.b $00
[000071b8]                           dc.b $00
[000071b9]                           dc.b $00
[000071ba]                           dc.b $00
[000071bb]                           dc.b $00
[000071bc]                           dc.b $00
[000071bd]                           dc.b $00
[000071be]                           dc.b $00
[000071bf]                           dc.b $00
[000071c0]                           dc.b $00
[000071c1]                           dc.b $00
[000071c2]                           dc.b $00
[000071c3]                           dc.b $00
[000071c4]                           dc.b $00
[000071c5]                           dc.b $00
[000071c6]                           dc.b $00
[000071c7]                           dc.b $00
[000071c8]                           dc.b $00
[000071c9]                           dc.b $00
[000071ca]                           dc.b $00
[000071cb]                           dc.b $00
[000071cc]                           dc.b $00
[000071cd]                           dc.b $00
[000071ce]                           dc.b $00
[000071cf]                           dc.b $00
[000071d0]                           dc.b $00
[000071d1]                           dc.b $00
[000071d2]                           dc.b $00
[000071d3]                           dc.b $00
[000071d4]                           dc.b $00
[000071d5]                           dc.b $00
[000071d6]                           dc.b $00
[000071d7]                           dc.b $00
[000071d8]                           dc.b $00
[000071d9]                           dc.b $00
[000071da]                           dc.b $00
[000071db]                           dc.b $00
[000071dc]                           dc.b $00
[000071dd]                           dc.b $00
[000071de]                           dc.b $00
[000071df]                           dc.b $00
[000071e0]                           dc.b $00
[000071e1]                           dc.b $00
[000071e2]                           dc.b $00
[000071e3]                           dc.b $00
[000071e4]                           dc.b $00
[000071e5]                           dc.b $00
[000071e6]                           dc.b $00
[000071e7]                           dc.b $00
[000071e8]                           dc.b $00
[000071e9]                           dc.b $00
[000071ea]                           dc.b $00
[000071eb]                           dc.b $00
[000071ec]                           dc.b $00
[000071ed]                           dc.b $00
[000071ee]                           dc.b $00
[000071ef]                           dc.b $00
[000071f0]                           dc.b $00
[000071f1]                           dc.b $00
[000071f2]                           dc.b $00
[000071f3]                           dc.b $00
[000071f4]                           dc.b $00
[000071f5]                           dc.b $00
[000071f6]                           dc.b $00
[000071f7]                           dc.b $00
[000071f8]                           dc.b $00
[000071f9]                           dc.b $00
[000071fa]                           dc.b $00
[000071fb]                           dc.b $00
[000071fc]                           dc.b $00
[000071fd]                           dc.b $00
[000071fe]                           dc.b $00
[000071ff]                           dc.b $00
[00007200]                           dc.b $00
[00007201]                           dc.b $00
[00007202]                           dc.b $00
[00007203]                           dc.b $00
[00007204]                           dc.b $00
[00007205]                           dc.b $00
[00007206]                           dc.b $00
[00007207]                           dc.b $00
[00007208]                           dc.b $00
[00007209]                           dc.b $00
[0000720a]                           dc.b $00
[0000720b]                           dc.b $00
[0000720c]                           dc.b $00
[0000720d]                           dc.b $00
[0000720e]                           dc.b $00
[0000720f]                           dc.b $00
[00007210]                           dc.b $00
[00007211]                           dc.b $00
[00007212]                           dc.b $00
[00007213]                           dc.b $00
[00007214]                           dc.b $00
[00007215]                           dc.b $00
[00007216]                           dc.b $00
[00007217]                           dc.b $00
[00007218]                           dc.b $00
[00007219]                           dc.b $00
[0000721a]                           dc.b $00
[0000721b]                           dc.b $00
[0000721c]                           dc.b $00
[0000721d]                           dc.b $00
[0000721e]                           dc.b $00
[0000721f]                           dc.b $00
[00007220]                           dc.b $00
[00007221]                           dc.b $00
[00007222]                           dc.b $00
[00007223]                           dc.b $00
[00007224]                           dc.b $00
[00007225]                           dc.b $00
[00007226]                           dc.b $00
[00007227]                           dc.b $00
[00007228]                           dc.b $00
[00007229]                           dc.b $00
[0000722a]                           dc.b $00
[0000722b]                           dc.b $00
[0000722c]                           dc.b $00
[0000722d]                           dc.b $00
[0000722e]                           dc.b $00
[0000722f]                           dc.b $00
[00007230]                           dc.b $00
[00007231]                           dc.b $00
[00007232]                           dc.b $00
[00007233]                           dc.b $00
[00007234]                           dc.b $00
[00007235]                           dc.b $00
[00007236]                           dc.b $00
[00007237]                           dc.b $00
[00007238]                           dc.b $00
[00007239]                           dc.b $00
[0000723a]                           dc.b $00
[0000723b]                           dc.b $00
[0000723c]                           dc.b $00
[0000723d]                           dc.b $00
[0000723e]                           dc.b $00
[0000723f]                           dc.b $00
[00007240]                           dc.b $00
[00007241]                           dc.b $00
[00007242]                           dc.b $00
[00007243]                           dc.b $00
[00007244]                           dc.b $00
[00007245]                           dc.b $00
[00007246]                           dc.b $00
[00007247]                           dc.b $00
[00007248]                           dc.b $00
[00007249]                           dc.b $00
[0000724a]                           dc.b $00
[0000724b]                           dc.b $00
[0000724c]                           dc.b $00
[0000724d]                           dc.b $00
[0000724e]                           dc.b $00
[0000724f]                           dc.b $00
[00007250]                           dc.b $00
[00007251]                           dc.b $00
[00007252]                           dc.b $00
[00007253]                           dc.b $00
[00007254]                           dc.b $00
[00007255]                           dc.b $00
[00007256]                           dc.b $00
[00007257]                           dc.b $00
[00007258]                           dc.b $00
[00007259]                           dc.b $00
[0000725a]                           dc.b $00
[0000725b]                           dc.b $00
[0000725c]                           dc.b $00
[0000725d]                           dc.b $00
[0000725e]                           dc.b $00
[0000725f]                           dc.b $00
[00007260]                           dc.b $00
[00007261]                           dc.b $00
[00007262]                           dc.b $00
[00007263]                           dc.b $00
[00007264]                           dc.b $00
[00007265]                           dc.b $00
[00007266]                           dc.b $00
[00007267]                           dc.b $00
[00007268]                           dc.b $00
[00007269]                           dc.b $00
[0000726a]                           dc.b $00
[0000726b]                           dc.b $00
[0000726c]                           dc.b $00
[0000726d]                           dc.b $00
[0000726e]                           dc.b $00
[0000726f]                           dc.b $00
[00007270]                           dc.b $00
[00007271]                           dc.b $00
[00007272]                           dc.b $00
[00007273]                           dc.b $00
[00007274]                           dc.b $00
[00007275]                           dc.b $00
[00007276]                           dc.b $00
[00007277]                           dc.b $00
[00007278]                           dc.b $00
[00007279]                           dc.b $00
[0000727a]                           dc.b $00
[0000727b]                           dc.b $00
[0000727c]                           dc.b $00
[0000727d]                           dc.b $00
[0000727e]                           dc.b $00
[0000727f]                           dc.b $00
[00007280]                           dc.b $00
[00007281]                           dc.b $00
[00007282]                           dc.b $00
[00007283]                           dc.b $00
[00007284]                           dc.b $00
[00007285]                           dc.b $00
[00007286]                           dc.b $00
[00007287]                           dc.b $00
[00007288]                           dc.b $00
[00007289]                           dc.b $00
[0000728a]                           dc.b $00
[0000728b]                           dc.b $00
[0000728c]                           dc.b $00
[0000728d]                           dc.b $00
[0000728e]                           dc.b $00
[0000728f]                           dc.b $00
[00007290]                           dc.b $00
[00007291]                           dc.b $00
[00007292]                           dc.b $00
[00007293]                           dc.b $00
[00007294]                           dc.b $00
[00007295]                           dc.b $00
[00007296]                           dc.b $00
[00007297]                           dc.b $00
[00007298]                           dc.b $00
[00007299]                           dc.b $00
[0000729a]                           dc.b $00
[0000729b]                           dc.b $00
[0000729c]                           dc.b $00
[0000729d]                           dc.b $00
[0000729e]                           dc.b $00
[0000729f]                           dc.b $00
[000072a0]                           dc.b $00
[000072a1]                           dc.b $00
[000072a2]                           dc.b $00
[000072a3]                           dc.b $00
[000072a4]                           dc.b $00
[000072a5]                           dc.b $00
[000072a6]                           dc.b $00
[000072a7]                           dc.b $00
[000072a8]                           dc.b $00
[000072a9]                           dc.b $00
[000072aa]                           dc.b $00
[000072ab]                           dc.b $00
[000072ac]                           dc.b $00
[000072ad]                           dc.b $00
[000072ae]                           dc.b $00
[000072af]                           dc.b $00
[000072b0]                           dc.b $00
[000072b1]                           dc.b $00
[000072b2]                           dc.b $00
[000072b3]                           dc.b $00
[000072b4]                           dc.b $00
[000072b5]                           dc.b $00
[000072b6]                           dc.b $00
[000072b7]                           dc.b $00
[000072b8]                           dc.b $00
[000072b9]                           dc.b $00
[000072ba]                           dc.b $00
[000072bb]                           dc.b $00
[000072bc]                           dc.b $00
[000072bd]                           dc.b $00
[000072be]                           dc.b $00
[000072bf]                           dc.b $00
[000072c0]                           dc.b $00
[000072c1]                           dc.b $00
[000072c2]                           dc.b $00
[000072c3]                           dc.b $00
[000072c4]                           dc.b $00
[000072c5]                           dc.b $00
[000072c6]                           dc.b $00
[000072c7]                           dc.b $00
[000072c8]                           dc.b $00
[000072c9]                           dc.b $00
[000072ca]                           dc.b $00
[000072cb]                           dc.b $00
[000072cc]                           dc.b $00
[000072cd]                           dc.b $00
[000072ce]                           dc.b $00
[000072cf]                           dc.b $00
[000072d0]                           dc.b $00
[000072d1]                           dc.b $00
[000072d2]                           dc.b $00
[000072d3]                           dc.b $00
[000072d4]                           dc.b $00
[000072d5]                           dc.b $00
[000072d6]                           dc.b $00
[000072d7]                           dc.b $00
[000072d8]                           dc.b $00
[000072d9]                           dc.b $00
[000072da]                           dc.b $00
[000072db]                           dc.b $00
[000072dc]                           dc.b $00
[000072dd]                           dc.b $00
[000072de]                           dc.b $00
[000072df]                           dc.b $00
[000072e0]                           dc.b $00
[000072e1]                           dc.b $00
[000072e2]                           dc.b $00
[000072e3]                           dc.b $00
[000072e4]                           dc.b $00
[000072e5]                           dc.b $00
[000072e6]                           dc.b $00
[000072e7]                           dc.b $00
[000072e8]                           dc.b $00
[000072e9]                           dc.b $00
[000072ea]                           dc.b $00
[000072eb]                           dc.b $00
[000072ec]                           dc.b $00
[000072ed]                           dc.b $00
[000072ee]                           dc.b $00
[000072ef]                           dc.b $00
[000072f0]                           dc.b $00
[000072f1]                           dc.b $00
[000072f2]                           dc.b $00
[000072f3]                           dc.b $00
[000072f4]                           dc.b $00
[000072f5]                           dc.b $00
[000072f6]                           dc.b $00
[000072f7]                           dc.b $00
[000072f8]                           dc.b $00
[000072f9]                           dc.b $00
[000072fa]                           dc.b $00
[000072fb]                           dc.b $00
[000072fc]                           dc.b $00
[000072fd]                           dc.b $00
[000072fe]                           dc.b $00
[000072ff]                           dc.b $00
[00007300]                           dc.b $00
[00007301]                           dc.b $00
[00007302]                           dc.b $00
[00007303]                           dc.b $00
[00007304]                           dc.b $00
[00007305]                           dc.b $00
[00007306]                           dc.b $00
[00007307]                           dc.b $00
[00007308]                           dc.b $00
[00007309]                           dc.b $00
[0000730a]                           dc.b $00
[0000730b]                           dc.b $00
[0000730c]                           dc.b $00
[0000730d]                           dc.b $00
[0000730e]                           dc.b $00
[0000730f]                           dc.b $00
[00007310]                           dc.b $00
[00007311]                           dc.b $00
[00007312]                           dc.b $00
[00007313]                           dc.b $00
[00007314]                           dc.b $00
[00007315]                           dc.b $00
[00007316]                           dc.b $00
[00007317]                           dc.b $00
[00007318]                           dc.b $00
[00007319]                           dc.b $00
[0000731a]                           dc.b $00
[0000731b]                           dc.b $00
[0000731c]                           dc.b $00
[0000731d]                           dc.b $00
[0000731e]                           dc.b $00
[0000731f]                           dc.b $00
[00007320]                           dc.b $00
[00007321]                           dc.b $00
[00007322]                           dc.b $00
[00007323]                           dc.b $00
[00007324]                           dc.b $00
[00007325]                           dc.b $00
[00007326]                           dc.b $00
[00007327]                           dc.b $00
[00007328]                           dc.b $00
[00007329]                           dc.b $00
[0000732a]                           dc.b $00
[0000732b]                           dc.b $00
[0000732c]                           dc.b $00
[0000732d]                           dc.b $00
[0000732e]                           dc.b $00
[0000732f]                           dc.b $00
[00007330]                           dc.b $00
[00007331]                           dc.b $00
[00007332]                           dc.b $00
[00007333]                           dc.b $00
[00007334]                           dc.b $00
[00007335]                           dc.b $00
[00007336]                           dc.b $00
[00007337]                           dc.b $00
[00007338]                           dc.b $00
[00007339]                           dc.b $00
[0000733a]                           dc.b $00
[0000733b]                           dc.b $00
[0000733c]                           dc.b $00
[0000733d]                           dc.b $00
[0000733e]                           dc.b $00
[0000733f]                           dc.b $00
[00007340]                           dc.b $00
[00007341]                           dc.b $00
[00007342]                           dc.b $00
[00007343]                           dc.b $00
[00007344]                           dc.b $00
[00007345]                           dc.b $00
[00007346]                           dc.b $00
[00007347]                           dc.b $00
[00007348]                           dc.b $00
[00007349]                           dc.b $00
[0000734a]                           dc.b $00
[0000734b]                           dc.b $00
[0000734c]                           dc.b $00
[0000734d]                           dc.b $00
[0000734e]                           dc.b $00
[0000734f]                           dc.b $00
[00007350]                           dc.b $00
[00007351]                           dc.b $00
[00007352]                           dc.b $00
[00007353]                           dc.b $00
[00007354]                           dc.b $00
[00007355]                           dc.b $00
[00007356]                           dc.b $00
[00007357]                           dc.b $00
[00007358]                           dc.b $00
[00007359]                           dc.b $00
[0000735a]                           dc.b $00
[0000735b]                           dc.b $00
[0000735c]                           dc.b $00
[0000735d]                           dc.b $00
[0000735e]                           dc.b $00
[0000735f]                           dc.b $00
[00007360]                           dc.b $00
[00007361]                           dc.b $00
[00007362]                           dc.b $00
[00007363]                           dc.b $00
[00007364]                           dc.b $00
[00007365]                           dc.b $00
[00007366]                           dc.b $00
[00007367]                           dc.b $00
[00007368]                           dc.b $00
[00007369]                           dc.b $00
[0000736a]                           dc.b $00
[0000736b]                           dc.b $00
[0000736c]                           dc.b $00
[0000736d]                           dc.b $00
[0000736e]                           dc.b $00
[0000736f]                           dc.b $00
[00007370]                           dc.b $00
[00007371]                           dc.b $00
[00007372]                           dc.b $00
[00007373]                           dc.b $00
[00007374]                           dc.b $00
[00007375]                           dc.b $00
[00007376]                           dc.b $00
[00007377]                           dc.b $00
[00007378]                           dc.b $00
[00007379]                           dc.b $00
[0000737a]                           dc.b $00
[0000737b]                           dc.b $00
[0000737c]                           dc.b $00
[0000737d]                           dc.b $00
[0000737e]                           dc.b $00
[0000737f]                           dc.b $00
[00007380]                           dc.b $00
[00007381]                           dc.b $00
[00007382]                           dc.b $00
[00007383]                           dc.b $00
[00007384]                           dc.b $00
[00007385]                           dc.b $00
[00007386]                           dc.b $00
[00007387]                           dc.b $00
[00007388]                           dc.b $00
[00007389]                           dc.b $00
[0000738a]                           dc.b $00
[0000738b]                           dc.b $00
[0000738c]                           dc.b $00
[0000738d]                           dc.b $00
[0000738e]                           dc.b $00
[0000738f]                           dc.b $00
[00007390]                           dc.b $00
[00007391]                           dc.b $00
[00007392]                           dc.b $00
[00007393]                           dc.b $00
[00007394]                           dc.b $00
[00007395]                           dc.b $00
[00007396]                           dc.b $00
[00007397]                           dc.b $00
[00007398]                           dc.b $00
[00007399]                           dc.b $00
[0000739a]                           dc.b $00
[0000739b]                           dc.b $00
[0000739c]                           dc.b $00
[0000739d]                           dc.b $00
[0000739e]                           dc.b $00
[0000739f]                           dc.b $00
[000073a0]                           dc.b $00
[000073a1]                           dc.b $00
[000073a2]                           dc.b $00
[000073a3]                           dc.b $00
[000073a4]                           dc.b $00
[000073a5]                           dc.b $00
[000073a6]                           dc.b $00
[000073a7]                           dc.b $00
[000073a8]                           dc.b $00
[000073a9]                           dc.b $00
[000073aa]                           dc.b $00
[000073ab]                           dc.b $00
[000073ac]                           dc.b $00
[000073ad]                           dc.b $00
[000073ae]                           dc.b $00
[000073af]                           dc.b $00
[000073b0]                           dc.b $00
[000073b1]                           dc.b $00
[000073b2]                           dc.b $00
[000073b3]                           dc.b $00
[000073b4]                           dc.b $00
[000073b5]                           dc.b $00
[000073b6]                           dc.b $00
[000073b7]                           dc.b $00
[000073b8]                           dc.b $00
[000073b9]                           dc.b $00
[000073ba]                           dc.b $00
[000073bb]                           dc.b $00
[000073bc]                           dc.b $00
[000073bd]                           dc.b $00
[000073be]                           dc.b $00
[000073bf]                           dc.b $00
[000073c0]                           dc.b $00
[000073c1]                           dc.b $00
[000073c2]                           dc.b $00
[000073c3]                           dc.b $00
[000073c4]                           dc.b $00
[000073c5]                           dc.b $00
[000073c6]                           dc.b $00
[000073c7]                           dc.b $00
[000073c8]                           dc.b $00
[000073c9]                           dc.b $00
[000073ca]                           dc.b $00
[000073cb]                           dc.b $00
[000073cc]                           dc.b $00
[000073cd]                           dc.b $00
[000073ce]                           dc.b $00
[000073cf]                           dc.b $00
[000073d0]                           dc.b $00
[000073d1]                           dc.b $00
[000073d2]                           dc.b $00
[000073d3]                           dc.b $00
[000073d4]                           dc.b $00
[000073d5]                           dc.b $00
[000073d6]                           dc.b $00
[000073d7]                           dc.b $00
[000073d8]                           dc.b $00
[000073d9]                           dc.b $00
[000073da]                           dc.b $00
[000073db]                           dc.b $00
[000073dc]                           dc.b $00
[000073dd]                           dc.b $00
[000073de]                           dc.b $00
[000073df]                           dc.b $00
[000073e0]                           dc.b $00
[000073e1]                           dc.b $00
[000073e2]                           dc.b $00
[000073e3]                           dc.b $00
[000073e4]                           dc.b $00
[000073e5]                           dc.b $00
[000073e6]                           dc.b $00
[000073e7]                           dc.b $00
[000073e8]                           dc.b $00
[000073e9]                           dc.b $00
[000073ea]                           dc.b $00
[000073eb]                           dc.b $00
[000073ec]                           dc.b $00
[000073ed]                           dc.b $00
[000073ee]                           dc.b $00
[000073ef]                           dc.b $00
[000073f0]                           dc.b $00
[000073f1]                           dc.b $00
[000073f2]                           dc.b $00
[000073f3]                           dc.b $00
[000073f4]                           dc.b $00
[000073f5]                           dc.b $00
[000073f6]                           dc.b $00
[000073f7]                           dc.b $00
[000073f8]                           dc.b $00
[000073f9]                           dc.b $00
[000073fa]                           dc.b $00
[000073fb]                           dc.b $00
[000073fc]                           dc.b $00
[000073fd]                           dc.b $00
[000073fe]                           dc.b $00
[000073ff]                           dc.b $00
[00007400]                           dc.b $00
[00007401]                           dc.b $00
[00007402]                           dc.b $00
[00007403]                           dc.b $00
[00007404]                           dc.b $00
[00007405]                           dc.b $00
[00007406]                           dc.b $00
[00007407]                           dc.b $00
[00007408]                           dc.b $00
[00007409]                           dc.b $00
[0000740a]                           dc.b $00
[0000740b]                           dc.b $00
[0000740c]                           dc.b $00
[0000740d]                           dc.b $00
[0000740e]                           dc.b $00
[0000740f]                           dc.b $00
[00007410]                           dc.b $00
[00007411]                           dc.b $00
[00007412]                           dc.b $00
[00007413]                           dc.b $00
[00007414]                           dc.b $00
[00007415]                           dc.b $00
[00007416]                           dc.b $00
[00007417]                           dc.b $00
[00007418]                           dc.b $00
[00007419]                           dc.b $00
[0000741a]                           dc.b $00
[0000741b]                           dc.b $00
[0000741c]                           dc.b $00
[0000741d]                           dc.b $00
[0000741e]                           dc.b $00
[0000741f]                           dc.b $00
[00007420]                           dc.b $00
[00007421]                           dc.b $00
[00007422]                           dc.b $00
[00007423]                           dc.b $00
[00007424]                           dc.b $00
[00007425]                           dc.b $00
[00007426]                           dc.b $00
[00007427]                           dc.b $00
[00007428]                           dc.b $00
[00007429]                           dc.b $00
[0000742a]                           dc.b $00
[0000742b]                           dc.b $00
[0000742c]                           dc.b $00
[0000742d]                           dc.b $00
[0000742e]                           dc.b $00
[0000742f]                           dc.b $00
[00007430]                           dc.b $00
[00007431]                           dc.b $00
[00007432]                           dc.b $00
[00007433]                           dc.b $00
[00007434]                           dc.b $00
[00007435]                           dc.b $00
[00007436]                           dc.b $00
[00007437]                           dc.b $00
[00007438]                           dc.b $00
[00007439]                           dc.b $00
[0000743a]                           dc.b $00
[0000743b]                           dc.b $00
[0000743c]                           dc.b $00
[0000743d]                           dc.b $00
[0000743e]                           dc.b $00
[0000743f]                           dc.b $00
[00007440]                           dc.b $00
[00007441]                           dc.b $00
[00007442]                           dc.b $00
[00007443]                           dc.b $00
[00007444]                           dc.b $00
[00007445]                           dc.b $00
[00007446]                           dc.b $00
[00007447]                           dc.b $00
[00007448]                           dc.b $00
[00007449]                           dc.b $00
[0000744a]                           dc.b $00
[0000744b]                           dc.b $00
[0000744c]                           dc.b $00
[0000744d]                           dc.b $00
[0000744e]                           dc.b $00
[0000744f]                           dc.b $00
[00007450]                           dc.b $00
[00007451]                           dc.b $00
[00007452]                           dc.b $00
[00007453]                           dc.b $00
[00007454]                           dc.b $00
[00007455]                           dc.b $00
[00007456]                           dc.b $00
[00007457]                           dc.b $00
[00007458]                           dc.b $00
[00007459]                           dc.b $00
[0000745a]                           dc.b $00
[0000745b]                           dc.b $00
[0000745c]                           dc.b $00
[0000745d]                           dc.b $00
[0000745e]                           dc.b $00
[0000745f]                           dc.b $00
[00007460]                           dc.b $00
[00007461]                           dc.b $00
[00007462]                           dc.b $00
[00007463]                           dc.b $00
[00007464]                           dc.b $00
[00007465]                           dc.b $00
[00007466]                           dc.b $00
[00007467]                           dc.b $00
[00007468]                           dc.b $00
[00007469]                           dc.b $00
[0000746a]                           dc.b $00
[0000746b]                           dc.b $00
[0000746c]                           dc.b $00
[0000746d]                           dc.b $00
[0000746e]                           dc.b $00
[0000746f]                           dc.b $00
[00007470]                           dc.b $00
[00007471]                           dc.b $00
[00007472]                           dc.b $00
[00007473]                           dc.b $00
[00007474]                           dc.b $00
[00007475]                           dc.b $00
[00007476]                           dc.b $00
[00007477]                           dc.b $00
[00007478]                           dc.b $00
[00007479]                           dc.b $00
[0000747a]                           dc.b $00
[0000747b]                           dc.b $00
[0000747c]                           dc.b $00
[0000747d]                           dc.b $00
[0000747e]                           dc.b $00
[0000747f]                           dc.b $00
[00007480]                           dc.b $00
[00007481]                           dc.b $00
[00007482]                           dc.b $00
[00007483]                           dc.b $00
[00007484]                           dc.b $00
[00007485]                           dc.b $00
[00007486]                           dc.b $00
[00007487]                           dc.b $00
[00007488]                           dc.b $00
[00007489]                           dc.b $00
[0000748a]                           dc.b $00
[0000748b]                           dc.b $00
[0000748c]                           dc.b $00
[0000748d]                           dc.b $00
[0000748e]                           dc.b $00
[0000748f]                           dc.b $00
[00007490]                           dc.b $00
[00007491]                           dc.b $00
[00007492]                           dc.w $0a00
[00007494]                           dc.b 'unbalanced comment in file',0
[000074af]                           dc.b $00
[000074b0]                           dc.b 'folded line',0
[000074bc]                           dc.b 'misplaced #%b',0
[000074ca]                           dc.b 'can',$27,'t read map file: %p',0
[000074e2]                           dc.b 'can',$27,'t open map file: %p',0
[000074fa]                           dc.b 'ccp',0
[000074fe]                           dc.w $6300
[00007500]                           dc.b 'can',$27,'t create ',0
[0000750e]                           dc.b '+cplus,d*>err,i*,+lincl,+map*,+old,o*,+pas,p?,+std,s?,x:F <files>',0
[00007550]                           dc.b 'missing #endif',0
[0000755f]                           dc.b $00
[00007560] 00002b9a                  dc.l $00002b9a ; no symbol found
[00007564]                           dc.b $00
[00007565]                           dc.b $00
[00007566]                           dc.b $00
[00007567]                           dc.b $14
[00007568] 00002b4e                  dc.l $00002b4e ; no symbol found
[0000756c]                           dc.b $00
[0000756d]                           dc.b $00
[0000756e]                           dc.b $00
[0000756f]                           dc.b $13
[00007570] 000028e2                  dc.l $000028e2 ; no symbol found
[00007574]                           dc.b $00
[00007575]                           dc.b $00
[00007576]                           dc.b $00
[00007577]                           dc.b $12
[00007578] 0000280e                  dc.l $0000280e ; no symbol found
[0000757c]                           dc.b $00
[0000757d]                           dc.b $00
[0000757e]                           dc.b $00
[0000757f]                           dc.b $11
[00007580] 000027d6                  dc.l $000027d6 ; no symbol found
[00007584]                           dc.b $00
[00007585]                           dc.b $00
[00007586]                           dc.b $00
[00007587]                           dc.b $15
[00007588] 000026e6                  dc.l $000026e6 ; no symbol found
[0000758c]                           dc.b $00
[0000758d]                           dc.b $00
[0000758e]                           dc.b $00
[0000758f]                           dc.b $0a
[00007590] 00002646                  dc.l $00002646 ; no symbol found
[00007594]                           dc.b $00
[00007595]                           dc.b $00
[00007596]                           dc.b $00
[00007597]                           dc.b $16
[00007598]                           dc.b $00
[00007599]                           dc.b $00
[0000759a]                           dc.b $00
[0000759b]                           dc.b $00
[0000759c] 00002bb8                  dc.l $00002bb8 ; no symbol found
[000075a0]                           dc.b 'bad #xxx',0
[000075a9]                           dc.b $63
[000075aa]                           dc.b $00
[000075ab]                           dc.b $63
[000075ac]                           dc.b $00
[000075ad]                           dc.b 'bad #line syntax',0
[000075be]                           dc.b 'bad #line',0
[000075c8]                           dc.b 'can',$27,'t open #include!',0
[000075dd]                           dc.b 'can',$27,'t #include %p',0
[000075ef]                           dc.b 'bad #undef',0
[000075fa]                           dc.b 'redefined %b',0
[00007607]                           dc.b 'bad #define',0
[00007613]                           dc.b $62
[00007614]                           dc.b $00
[00007615]                           dc.b $32
[00007616]                           dc.b $00
[00007617]                           dc.b $63
[00007618]                           dc.b $00
[00007619]                           dc.b $00
[0000761a]                           dc.b $00
[0000761b]                           dc.b $00
[0000761c]                           dc.b $00
[0000761d]                           dc.b $00
[0000761e]                           dc.b $00
[0000761f]                           dc.b $00
[00007620]                           dc.b $00
[00007621]                           dc.b $00
[00007622]                           dc.b $00
[00007623]                           dc.b $00
[00007624]                           dc.b $00
[00007625]                           dc.b $00
[00007626]                           dc.b $00
[00007627]                           dc.b $00
[00007628]                           dc.b $00
[00007629]                           dc.b $00
[0000762a]                           dc.b $00
[0000762b]                           dc.b $00
[0000762c]                           dc.b $00
[0000762d]                           dc.b $00
[0000762e]                           dc.b $00
[0000762f]                           dc.b $00
[00007630]                           dc.b $00
[00007631]                           dc.b $00
[00007632]                           dc.b $00
[00007633]                           dc.b $00
[00007634]                           dc.b $00
[00007635]                           dc.b $00
[00007636]                           dc.b $00
[00007637]                           dc.b $00
[00007638]                           dc.b $00
[00007639]                           dc.b $00
[0000763a]                           dc.b $00
[0000763b]                           dc.b $00
[0000763c]                           dc.b $00
[0000763d]                           dc.b $00
[0000763e]                           dc.b $00
[0000763f]                           dc.b $00
[00007640]                           dc.b $00
[00007641]                           dc.b $00
[00007642]                           dc.b $00
[00007643]                           dc.b $00
[00007644]                           dc.b $00
[00007645]                           dc.b $00
[00007646]                           dc.b $00
[00007647]                           dc.b $00
[00007648]                           dc.b $00
[00007649]                           dc.b $00
[0000764a]                           dc.b $00
[0000764b]                           dc.b $00
[0000764c]                           dc.b $00
[0000764d]                           dc.b $00
[0000764e]                           dc.b $00
[0000764f]                           dc.b $00
[00007650]                           dc.b $00
[00007651]                           dc.b $00
[00007652]                           dc.b $00
[00007653]                           dc.b $00
[00007654]                           dc.b $00
[00007655]                           dc.b $00
[00007656]                           dc.b $00
[00007657]                           dc.b $00
[00007658]                           dc.b $00
[00007659]                           dc.b $00
[0000765a]                           dc.b $00
[0000765b]                           dc.b $00
[0000765c]                           dc.b $00
[0000765d]                           dc.b $00
[0000765e]                           dc.b $00
[0000765f]                           dc.b $00
[00007660]                           dc.b $00
[00007661]                           dc.b $00
[00007662]                           dc.b $00
[00007663]                           dc.b $00
[00007664]                           dc.b $00
[00007665]                           dc.b $00
[00007666]                           dc.b $00
[00007667]                           dc.b $00
[00007668]                           dc.b $00
[00007669]                           dc.b $00
[0000766a]                           dc.b $00
[0000766b]                           dc.b $00
[0000766c]                           dc.b $00
[0000766d]                           dc.b $00
[0000766e]                           dc.b $00
[0000766f]                           dc.b $00
[00007670]                           dc.b $00
[00007671]                           dc.b $00
[00007672]                           dc.b $00
[00007673]                           dc.b $00
[00007674]                           dc.b $00
[00007675]                           dc.b $00
[00007676]                           dc.b $00
[00007677]                           dc.b $00
[00007678]                           dc.b $00
[00007679]                           dc.b $00
[0000767a]                           dc.b $00
[0000767b]                           dc.b $00
[0000767c]                           dc.b $00
[0000767d]                           dc.b $00
[0000767e]                           dc.b $00
[0000767f]                           dc.b $00
[00007680]                           dc.b $00
[00007681]                           dc.b $00
[00007682]                           dc.b $00
[00007683]                           dc.b $00
[00007684]                           dc.b $00
[00007685]                           dc.b $00
[00007686]                           dc.b $00
[00007687]                           dc.b $00
[00007688]                           dc.b $00
[00007689]                           dc.b $00
[0000768a]                           dc.b $00
[0000768b]                           dc.b $00
[0000768c]                           dc.b $00
[0000768d]                           dc.b $00
[0000768e]                           dc.b $00
[0000768f]                           dc.b $00
[00007690]                           dc.b $00
[00007691]                           dc.b $00
[00007692]                           dc.b $00
[00007693]                           dc.b $00
[00007694]                           dc.b $00
[00007695]                           dc.b $00
[00007696]                           dc.b $00
[00007697]                           dc.b $00
[00007698]                           dc.b $00
[00007699]                           dc.b $00
[0000769a]                           dc.b $00
[0000769b]                           dc.b $00
[0000769c]                           dc.b $00
[0000769d]                           dc.b $00
[0000769e]                           dc.b $00
[0000769f]                           dc.b $00
[000076a0]                           dc.b $00
[000076a1]                           dc.b $00
[000076a2]                           dc.b $00
[000076a3]                           dc.b $00
[000076a4]                           dc.b $00
[000076a5]                           dc.b $00
[000076a6]                           dc.b $00
[000076a7]                           dc.b $00
[000076a8]                           dc.b $00
[000076a9]                           dc.b $00
[000076aa]                           dc.b $00
[000076ab]                           dc.b $00
[000076ac]                           dc.b $00
[000076ad]                           dc.b $00
[000076ae]                           dc.b $00
[000076af]                           dc.b $00
[000076b0]                           dc.b $00
[000076b1]                           dc.b $00
[000076b2]                           dc.b $00
[000076b3]                           dc.b $00
[000076b4]                           dc.b $00
[000076b5]                           dc.b $00
[000076b6]                           dc.b $00
[000076b7]                           dc.b $00
[000076b8]                           dc.b $00
[000076b9]                           dc.b $00
[000076ba]                           dc.b $00
[000076bb]                           dc.b $00
[000076bc]                           dc.b $00
[000076bd]                           dc.b $00
[000076be]                           dc.b $00
[000076bf]                           dc.b $00
[000076c0]                           dc.b $00
[000076c1]                           dc.b $00
[000076c2]                           dc.b $00
[000076c3]                           dc.b $00
[000076c4]                           dc.b $00
[000076c5]                           dc.b $00
[000076c6]                           dc.b $00
[000076c7]                           dc.b $00
[000076c8]                           dc.b $00
[000076c9]                           dc.b $00
[000076ca]                           dc.b $00
[000076cb]                           dc.b $00
[000076cc]                           dc.b $00
[000076cd]                           dc.b $00
[000076ce]                           dc.b $00
[000076cf]                           dc.b $00
[000076d0]                           dc.b $00
[000076d1]                           dc.b $00
[000076d2]                           dc.b $00
[000076d3]                           dc.b $00
[000076d4]                           dc.b $00
[000076d5]                           dc.b $00
[000076d6]                           dc.b $00
[000076d7]                           dc.b $00
[000076d8]                           dc.b $00
[000076d9]                           dc.b $00
[000076da]                           dc.b $00
[000076db]                           dc.b $00
[000076dc]                           dc.b $00
[000076dd]                           dc.b $00
[000076de]                           dc.b $00
[000076df]                           dc.b $00
[000076e0]                           dc.b $00
[000076e1]                           dc.b $00
[000076e2]                           dc.b $00
[000076e3]                           dc.b $00
[000076e4]                           dc.b $00
[000076e5]                           dc.b $00
[000076e6]                           dc.b $00
[000076e7]                           dc.b $00
[000076e8]                           dc.b $00
[000076e9]                           dc.b $00
[000076ea]                           dc.b $00
[000076eb]                           dc.b $00
[000076ec]                           dc.b $00
[000076ed]                           dc.b $00
[000076ee]                           dc.b $00
[000076ef]                           dc.b $00
[000076f0]                           dc.b $00
[000076f1]                           dc.b $00
[000076f2]                           dc.b $00
[000076f3]                           dc.b $00
[000076f4]                           dc.b $00
[000076f5]                           dc.b $00
[000076f6]                           dc.b $00
[000076f7]                           dc.b $00
[000076f8]                           dc.b $00
[000076f9]                           dc.b $00
[000076fa]                           dc.b $00
[000076fb]                           dc.b $00
[000076fc]                           dc.b $00
[000076fd]                           dc.b $00
[000076fe]                           dc.b $00
[000076ff]                           dc.b $00
[00007700]                           dc.b $00
[00007701]                           dc.b $00
[00007702]                           dc.b $00
[00007703]                           dc.b $00
[00007704]                           dc.b $00
[00007705]                           dc.b $00
[00007706]                           dc.b $00
[00007707]                           dc.b $00
[00007708]                           dc.b $00
[00007709]                           dc.b $00
[0000770a]                           dc.b $00
[0000770b]                           dc.b $00
[0000770c]                           dc.b $00
[0000770d]                           dc.b $00
[0000770e]                           dc.b $00
[0000770f]                           dc.b $00
[00007710]                           dc.b $00
[00007711]                           dc.b $00
[00007712]                           dc.b $00
[00007713]                           dc.b $00
[00007714]                           dc.b $00
[00007715]                           dc.b $00
[00007716]                           dc.b $00
[00007717]                           dc.b $00
[00007718]                           dc.b $00
[00007719]                           dc.b $00
[0000771a]                           dc.b $00
[0000771b]                           dc.b $00
[0000771c]                           dc.b $00
[0000771d]                           dc.b $00
[0000771e]                           dc.b $00
[0000771f]                           dc.b $00
[00007720]                           dc.b $00
[00007721]                           dc.b $00
[00007722]                           dc.b $00
[00007723]                           dc.b $00
[00007724]                           dc.b $00
[00007725]                           dc.b $00
[00007726]                           dc.b $00
[00007727]                           dc.b $00
[00007728]                           dc.b $00
[00007729]                           dc.b $00
[0000772a]                           dc.b $00
[0000772b]                           dc.b $00
[0000772c]                           dc.b $00
[0000772d]                           dc.b $00
[0000772e]                           dc.b $00
[0000772f]                           dc.b $00
[00007730]                           dc.b $00
[00007731]                           dc.b $00
[00007732]                           dc.b $00
[00007733]                           dc.b $00
[00007734]                           dc.b $00
[00007735]                           dc.b $00
[00007736]                           dc.b $00
[00007737]                           dc.b $00
[00007738]                           dc.b $00
[00007739]                           dc.b $00
[0000773a]                           dc.b $00
[0000773b]                           dc.b $00
[0000773c]                           dc.b $00
[0000773d]                           dc.b $00
[0000773e]                           dc.b $00
[0000773f]                           dc.b $00
[00007740]                           dc.b $00
[00007741]                           dc.b $00
[00007742]                           dc.b $00
[00007743]                           dc.b $00
[00007744]                           dc.b $00
[00007745]                           dc.b $00
[00007746]                           dc.b $00
[00007747]                           dc.b $00
[00007748]                           dc.b $00
[00007749]                           dc.b $00
[0000774a]                           dc.b $00
[0000774b]                           dc.b $00
[0000774c]                           dc.b $00
[0000774d]                           dc.b $00
[0000774e]                           dc.b $00
[0000774f]                           dc.b $00
[00007750]                           dc.b $00
[00007751]                           dc.b $00
[00007752]                           dc.b $00
[00007753]                           dc.b $00
[00007754]                           dc.b $00
[00007755]                           dc.b $00
[00007756]                           dc.b $00
[00007757]                           dc.b $00
[00007758]                           dc.b $00
[00007759]                           dc.b $00
[0000775a]                           dc.b $00
[0000775b]                           dc.b $00
[0000775c]                           dc.b $00
[0000775d]                           dc.b $00
[0000775e]                           dc.b $00
[0000775f]                           dc.b $00
[00007760]                           dc.b $00
[00007761]                           dc.b $00
[00007762]                           dc.b $00
[00007763]                           dc.b $00
[00007764]                           dc.b $00
[00007765]                           dc.b $00
[00007766]                           dc.b $00
[00007767]                           dc.b $00
[00007768]                           dc.b $00
[00007769]                           dc.b $00
[0000776a]                           dc.b $00
[0000776b]                           dc.b $00
[0000776c]                           dc.b $00
[0000776d]                           dc.b $00
[0000776e]                           dc.b $00
[0000776f]                           dc.b $00
[00007770]                           dc.b $00
[00007771]                           dc.b $00
[00007772]                           dc.b $00
[00007773]                           dc.b $00
[00007774]                           dc.b $00
[00007775]                           dc.b $00
[00007776]                           dc.b $00
[00007777]                           dc.b $00
[00007778]                           dc.b $00
[00007779]                           dc.b $00
[0000777a]                           dc.b $00
[0000777b]                           dc.b $00
[0000777c]                           dc.b $00
[0000777d]                           dc.b $00
[0000777e]                           dc.b $00
[0000777f]                           dc.b $00
[00007780]                           dc.b $00
[00007781]                           dc.b $00
[00007782]                           dc.b $00
[00007783]                           dc.b $00
[00007784]                           dc.b $00
[00007785]                           dc.b $00
[00007786]                           dc.b $00
[00007787]                           dc.b $00
[00007788]                           dc.b $00
[00007789]                           dc.b $00
[0000778a]                           dc.b $00
[0000778b]                           dc.b $00
[0000778c]                           dc.b $00
[0000778d]                           dc.b $00
[0000778e]                           dc.b $00
[0000778f]                           dc.b $00
[00007790]                           dc.b $00
[00007791]                           dc.b $00
[00007792]                           dc.b $00
[00007793]                           dc.b $00
[00007794]                           dc.b $00
[00007795]                           dc.b $00
[00007796]                           dc.b $00
[00007797]                           dc.b $00
[00007798]                           dc.b $00
[00007799]                           dc.b $00
[0000779a]                           dc.b $00
[0000779b]                           dc.b $00
[0000779c]                           dc.b $00
[0000779d]                           dc.b $00
[0000779e]                           dc.b $00
[0000779f]                           dc.b $00
[000077a0]                           dc.b $00
[000077a1]                           dc.b $00
[000077a2]                           dc.b $00
[000077a3]                           dc.b $00
[000077a4]                           dc.b $00
[000077a5]                           dc.b $00
[000077a6]                           dc.b $00
[000077a7]                           dc.b $00
[000077a8]                           dc.b $00
[000077a9]                           dc.b $00
[000077aa]                           dc.b $00
[000077ab]                           dc.b $00
[000077ac]                           dc.b $00
[000077ad]                           dc.b $00
[000077ae]                           dc.b $00
[000077af]                           dc.b $00
[000077b0]                           dc.b $00
[000077b1]                           dc.b $00
[000077b2]                           dc.b $00
[000077b3]                           dc.b $00
[000077b4]                           dc.b $00
[000077b5]                           dc.b $00
[000077b6]                           dc.b $00
[000077b7]                           dc.b $00
[000077b8]                           dc.b $00
[000077b9]                           dc.b $00
[000077ba]                           dc.b $00
[000077bb]                           dc.b $00
[000077bc]                           dc.b $00
[000077bd]                           dc.b $00
[000077be]                           dc.b $00
[000077bf]                           dc.b $00
[000077c0]                           dc.b $00
[000077c1]                           dc.b $00
[000077c2]                           dc.b $00
[000077c3]                           dc.b $00
[000077c4]                           dc.b $00
[000077c5]                           dc.b $00
[000077c6]                           dc.b $00
[000077c7]                           dc.b $00
[000077c8]                           dc.b $00
[000077c9]                           dc.b $00
[000077ca]                           dc.b $00
[000077cb]                           dc.b $00
[000077cc]                           dc.b $00
[000077cd]                           dc.b $00
[000077ce]                           dc.b $00
[000077cf]                           dc.b $00
[000077d0]                           dc.b $00
[000077d1]                           dc.b $00
[000077d2]                           dc.b $00
[000077d3]                           dc.b $00
[000077d4]                           dc.b $00
[000077d5]                           dc.b $00
[000077d6]                           dc.b $00
[000077d7]                           dc.b $00
[000077d8]                           dc.b $00
[000077d9]                           dc.b $00
[000077da]                           dc.b $00
[000077db]                           dc.b $00
[000077dc]                           dc.b $00
[000077dd]                           dc.b $00
[000077de]                           dc.b $00
[000077df]                           dc.b $00
[000077e0]                           dc.b $00
[000077e1]                           dc.b $00
[000077e2]                           dc.b $00
[000077e3]                           dc.b $00
[000077e4]                           dc.b $00
[000077e5]                           dc.b $00
[000077e6]                           dc.b $00
[000077e7]                           dc.b $00
[000077e8]                           dc.b $00
[000077e9]                           dc.b $00
[000077ea]                           dc.b $00
[000077eb]                           dc.b $00
[000077ec]                           dc.b $00
[000077ed]                           dc.b $00
[000077ee]                           dc.b $00
[000077ef]                           dc.b $00
[000077f0]                           dc.b $00
[000077f1]                           dc.b $00
[000077f2]                           dc.b $00
[000077f3]                           dc.b $00
[000077f4]                           dc.b $00
[000077f5]                           dc.b $00
[000077f6]                           dc.b $00
[000077f7]                           dc.b $00
[000077f8]                           dc.b $00
[000077f9]                           dc.b $00
[000077fa]                           dc.b $00
[000077fb]                           dc.b $00
[000077fc]                           dc.b $00
[000077fd]                           dc.b $00
[000077fe]                           dc.b $00
[000077ff]                           dc.b $00
[00007800]                           dc.b $00
[00007801]                           dc.b $00
[00007802]                           dc.b $00
[00007803]                           dc.b $00
[00007804]                           dc.b $00
[00007805]                           dc.b $00
[00007806]                           dc.b $00
[00007807]                           dc.b $00
[00007808]                           dc.b $00
[00007809]                           dc.b $00
[0000780a]                           dc.b $00
[0000780b]                           dc.b $00
[0000780c]                           dc.b $00
[0000780d]                           dc.b $00
[0000780e]                           dc.b $00
[0000780f]                           dc.b $00
[00007810]                           dc.b $00
[00007811]                           dc.b $00
[00007812]                           dc.b $00
[00007813]                           dc.b $00
[00007814]                           dc.b $00
[00007815]                           dc.b $00
[00007816]                           dc.b $00
[00007817]                           dc.b $00
[00007818]                           dc.b $00
[00007819]                           dc.b $00
[0000781a]                           dc.b $00
[0000781b]                           dc.b $00
[0000781c]                           dc.b $00
[0000781d]                           dc.b $00
[0000781e]                           dc.b 'can',$27,'t open %p',0
[0000782c]                           dc.w $6362
[0000782e]                           dc.b $00
[0000782f]                           dc.b $0a
[00007830]                           dc.b $00
[00007831]                           dc.b $09
[00007832]                           dc.b $00
[00007833]                           dc.b $3a
[00007834]                           dc.b $00
[00007835]                           dc.b $20
[00007836]                           dc.b $00
[00007837]                           dc.b '#error ',0
[0000783f]                           dc.b '%p%p%p%p%p%s%p',0
[0000784e]                           dc.b 'EOF: ',0
[00007854]                           dc.b '-d %b redefined',0
[00007864]                           dc.b ' 1',$0a,0
[00007868]                           dc.w $283d
[0000786a]                           dc.b $00
[0000786b]                           dc.b $00
[0000786c]                           dc.w $6332
[0000786e]                           dc.b $00
[0000786f]                           dc.b $00
[00007870]                           dc.w $0a00
[00007872]                           dc.b 'unbalanced %c',0
[00007880]                           dc.w $0a00
[00007882]                           dc.w $5d00
[00007884]                           dc.w $2000
[00007886]                           dc.w $5e00
[00007888]                           dc.w $2000
[0000788a]                           dc.w $2d5b
[0000788c]                           dc.b $00
[0000788d]                           dc.b $00
[0000788e] 00003f3e                  dc.l $00003f3e ; no symbol found
[00007892]                           dc.b $00
[00007893]                           dc.b $00
[00007894]                           dc.b $00
[00007895]                           dc.b $3e
[00007896] 00003edc                  dc.l $00003edc ; no symbol found
[0000789a]                           dc.b $00
[0000789b]                           dc.b $00
[0000789c]                           dc.b $00
[0000789d]                           dc.b $00
[0000789e] 00003edc                  dc.l $00003edc ; no symbol found
[000078a2]                           dc.b $00
[000078a3]                           dc.b $00
[000078a4]                           dc.b $00
[000078a5]                           dc.b $3a
[000078a6] 00003edc                  dc.l $00003edc ; no symbol found
[000078aa]                           dc.b $00
[000078ab]                           dc.b $00
[000078ac]                           dc.b $00
[000078ad]                           dc.b $2c
[000078ae] 00003e52                  dc.l $00003e52 ; no symbol found
[000078b2]                           dc.b $00
[000078b3]                           dc.b $00
[000078b4]                           dc.b $00
[000078b5]                           dc.b $23
[000078b6] 00003e16                  dc.l $00003e16 ; no symbol found
[000078ba]                           dc.b $00
[000078bb]                           dc.b $00
[000078bc]                           dc.b $00
[000078bd]                           dc.b $3f
[000078be] 00003da6                  dc.l $00003da6 ; no symbol found
[000078c2]                           dc.b $00
[000078c3]                           dc.b $00
[000078c4]                           dc.b $00
[000078c5]                           dc.b $2a
[000078c6]                           dc.b $00
[000078c7]                           dc.b $00
[000078c8]                           dc.b $00
[000078c9]                           dc.b $00
[000078ca] 00003fe6                  dc.l $00003fe6 ; no symbol found
[000078ce]                           dc.b 'help',0
[000078d3]                           dc.b $2d
[000078d4]                           dc.b $00
[000078d5]                           dc.b $2d
[000078d6]                           dc.w $2d00
[000078d8]                           dc.w $0a09
[000078da]                           dc.b $00
[000078db]                           dc.b $00
[000078dc]                           dc.b $00
[000078dd]                           dc.b $01
[000078de]                           dc.b $00
[000078df]                           dc.b $00
[000078e0]                           dc.b $00
[000078e1]                           dc.b $01
[000078e2]                           dc.b $00
[000078e3]                           dc.b $00
[000078e4]                           dc.b $00
[000078e5]                           dc.b $00
[000078e6]                           dc.b $00
[000078e7]                           dc.b $00
[000078e8]                           dc.b $00
[000078e9]                           dc.b $00
[000078ea]                           dc.b $00
[000078eb]                           dc.b $00
[000078ec]                           dc.b $00
[000078ed]                           dc.b $00
[000078ee]                           dc.b $00
[000078ef]                           dc.b $00
[000078f0]                           dc.b $00
[000078f1]                           dc.b $00
[000078f2]                           dc.b $00
[000078f3]                           dc.b $00
[000078f4]                           dc.b $00
[000078f5]                           dc.b $00
[000078f6]                           dc.b $00
[000078f7]                           dc.b $00
[000078f8]                           dc.b $00
[000078f9]                           dc.b $00
[000078fa]                           dc.b $00
[000078fb]                           dc.b $00
[000078fc]                           dc.b $00
[000078fd]                           dc.b $00
[000078fe]                           dc.b $00
[000078ff]                           dc.b $00
[00007900]                           dc.b $00
[00007901]                           dc.b $00
[00007902]                           dc.b $00
[00007903]                           dc.b $00
[00007904]                           dc.b $00
[00007905]                           dc.b $00
[00007906]                           dc.b $00
[00007907]                           dc.b $00
[00007908]                           dc.b $00
[00007909]                           dc.b $00
[0000790a]                           dc.b $00
[0000790b]                           dc.b $00
[0000790c]                           dc.b $00
[0000790d]                           dc.b $00
[0000790e]                           dc.b $00
[0000790f]                           dc.b $00
[00007910]                           dc.b $00
[00007911]                           dc.b $00
[00007912]                           dc.b $00
[00007913]                           dc.b $00
[00007914]                           dc.b $00
[00007915]                           dc.b $00
[00007916]                           dc.b $00
[00007917]                           dc.b $00
[00007918]                           dc.b $00
[00007919]                           dc.b $00
[0000791a]                           dc.b $00
[0000791b]                           dc.b $00
[0000791c]                           dc.b $00
[0000791d]                           dc.b $00
[0000791e]                           dc.b $00
[0000791f]                           dc.b $00
[00007920]                           dc.b $00
[00007921]                           dc.b $00
[00007922]                           dc.b $00
[00007923]                           dc.b $00
[00007924]                           dc.b $00
[00007925]                           dc.b $00
[00007926]                           dc.b $00
[00007927]                           dc.b $00
[00007928]                           dc.b $00
[00007929]                           dc.b $00
[0000792a]                           dc.b $00
[0000792b]                           dc.b $00
[0000792c]                           dc.b $00
[0000792d]                           dc.b $00
[0000792e]                           dc.b $00
[0000792f]                           dc.b $00
[00007930]                           dc.b $00
[00007931]                           dc.b $00
[00007932]                           dc.b $00
[00007933]                           dc.b $00
[00007934]                           dc.b $00
[00007935]                           dc.b $00
[00007936]                           dc.b $00
[00007937]                           dc.b $00
[00007938]                           dc.b $00
[00007939]                           dc.b $00
[0000793a]                           dc.b $00
[0000793b]                           dc.b $00
[0000793c]                           dc.b $00
[0000793d]                           dc.b $00
[0000793e]                           dc.b $00
[0000793f]                           dc.b $00
[00007940]                           dc.b $00
[00007941]                           dc.b $00
[00007942]                           dc.b $00
[00007943]                           dc.b $00
[00007944]                           dc.b $00
[00007945]                           dc.b $00
[00007946]                           dc.b $00
[00007947]                           dc.b $00
[00007948]                           dc.b $00
[00007949]                           dc.b $00
[0000794a]                           dc.b $00
[0000794b]                           dc.b $00
[0000794c]                           dc.b $00
[0000794d]                           dc.b $00
[0000794e]                           dc.b $00
[0000794f]                           dc.b $00
[00007950]                           dc.b $00
[00007951]                           dc.b $00
[00007952]                           dc.b $00
[00007953]                           dc.b $00
[00007954]                           dc.b $00
[00007955]                           dc.b $00
[00007956]                           dc.b $00
[00007957]                           dc.b $00
[00007958]                           dc.b $00
[00007959]                           dc.b $00
[0000795a]                           dc.b $00
[0000795b]                           dc.b $00
[0000795c]                           dc.b $00
[0000795d]                           dc.b $00
[0000795e]                           dc.b $00
[0000795f]                           dc.b $00
[00007960]                           dc.b $00
[00007961]                           dc.b $00
[00007962]                           dc.b $00
[00007963]                           dc.b $00
[00007964]                           dc.b $00
[00007965]                           dc.b $00
[00007966]                           dc.b $00
[00007967]                           dc.b $00
[00007968]                           dc.b $00
[00007969]                           dc.b $00
[0000796a]                           dc.b $00
[0000796b]                           dc.b $00
[0000796c]                           dc.b $00
[0000796d]                           dc.b $00
[0000796e]                           dc.b $00
[0000796f]                           dc.b $00
[00007970]                           dc.b $00
[00007971]                           dc.b $00
[00007972]                           dc.b $00
[00007973]                           dc.b $00
[00007974]                           dc.b $00
[00007975]                           dc.b $00
[00007976]                           dc.b $00
[00007977]                           dc.b $00
[00007978]                           dc.b $00
[00007979]                           dc.b $00
[0000797a]                           dc.b $00
[0000797b]                           dc.b $00
[0000797c]                           dc.b $00
[0000797d]                           dc.b $00
[0000797e]                           dc.b $00
[0000797f]                           dc.b $00
[00007980]                           dc.b $00
[00007981]                           dc.b $00
[00007982]                           dc.b $00
[00007983]                           dc.b $00
[00007984]                           dc.b $00
[00007985]                           dc.b $00
[00007986]                           dc.b $00
[00007987]                           dc.b $00
[00007988]                           dc.b $00
[00007989]                           dc.b $00
[0000798a]                           dc.b $00
[0000798b]                           dc.b $00
[0000798c]                           dc.b $00
[0000798d]                           dc.b $00
[0000798e]                           dc.b $00
[0000798f]                           dc.b $00
[00007990]                           dc.b $00
[00007991]                           dc.b $00
[00007992]                           dc.b $00
[00007993]                           dc.b $00
[00007994]                           dc.b $00
[00007995]                           dc.b $00
[00007996]                           dc.b $00
[00007997]                           dc.b $00
[00007998]                           dc.b $00
[00007999]                           dc.b $00
[0000799a]                           dc.b $00
[0000799b]                           dc.b $00
[0000799c]                           dc.b $00
[0000799d]                           dc.b $00
[0000799e]                           dc.b $00
[0000799f]                           dc.b $00
[000079a0]                           dc.b $00
[000079a1]                           dc.b $00
[000079a2]                           dc.b $00
[000079a3]                           dc.b $00
[000079a4]                           dc.b $00
[000079a5]                           dc.b $00
[000079a6]                           dc.b $00
[000079a7]                           dc.b $00
[000079a8]                           dc.b $00
[000079a9]                           dc.b $00
[000079aa]                           dc.b $00
[000079ab]                           dc.b $00
[000079ac]                           dc.b $00
[000079ad]                           dc.b $00
[000079ae]                           dc.b $00
[000079af]                           dc.b $00
[000079b0]                           dc.b $00
[000079b1]                           dc.b $00
[000079b2]                           dc.b $00
[000079b3]                           dc.b $00
[000079b4]                           dc.b $00
[000079b5]                           dc.b $00
[000079b6]                           dc.b $00
[000079b7]                           dc.b $00
[000079b8]                           dc.b $00
[000079b9]                           dc.b $00
[000079ba]                           dc.b $00
[000079bb]                           dc.b $00
[000079bc]                           dc.b $00
[000079bd]                           dc.b $00
[000079be]                           dc.b $00
[000079bf]                           dc.b $00
[000079c0]                           dc.b $00
[000079c1]                           dc.b $00
[000079c2]                           dc.b $00
[000079c3]                           dc.b $00
[000079c4]                           dc.b $00
[000079c5]                           dc.b $00
[000079c6]                           dc.b $00
[000079c7]                           dc.b $00
[000079c8]                           dc.b $00
[000079c9]                           dc.b $00
[000079ca]                           dc.b $00
[000079cb]                           dc.b $00
[000079cc]                           dc.b $00
[000079cd]                           dc.b $00
[000079ce]                           dc.b $00
[000079cf]                           dc.b $00
[000079d0]                           dc.b $00
[000079d1]                           dc.b $00
[000079d2]                           dc.b $00
[000079d3]                           dc.b $00
[000079d4]                           dc.b $00
[000079d5]                           dc.b $00
[000079d6]                           dc.b $00
[000079d7]                           dc.b $00
[000079d8]                           dc.b $00
[000079d9]                           dc.b $00
[000079da]                           dc.b $00
[000079db]                           dc.b $00
[000079dc]                           dc.b $00
[000079dd]                           dc.b $00
[000079de]                           dc.b $00
[000079df]                           dc.b $00
[000079e0]                           dc.b $00
[000079e1]                           dc.b $00
[000079e2]                           dc.b $00
[000079e3]                           dc.b $00
[000079e4]                           dc.b $00
[000079e5]                           dc.b $00
[000079e6]                           dc.b $00
[000079e7]                           dc.b $00
[000079e8]                           dc.b $00
[000079e9]                           dc.b $00
[000079ea]                           dc.b $00
[000079eb]                           dc.b $00
[000079ec]                           dc.b $00
[000079ed]                           dc.b $00
[000079ee]                           dc.b $00
[000079ef]                           dc.b $00
[000079f0]                           dc.b $00
[000079f1]                           dc.b $00
[000079f2]                           dc.b $00
[000079f3]                           dc.b $00
[000079f4]                           dc.b $00
[000079f5]                           dc.b $00
[000079f6]                           dc.b $00
[000079f7]                           dc.b $00
[000079f8]                           dc.b $00
[000079f9]                           dc.b $00
[000079fa]                           dc.b $00
[000079fb]                           dc.b $00
[000079fc]                           dc.b $00
[000079fd]                           dc.b $00
[000079fe]                           dc.b $00
[000079ff]                           dc.b $00
[00007a00]                           dc.b $00
[00007a01]                           dc.b $00
[00007a02]                           dc.b $00
[00007a03]                           dc.b $00
[00007a04]                           dc.b $00
[00007a05]                           dc.b $00
[00007a06]                           dc.b $00
[00007a07]                           dc.b $00
[00007a08]                           dc.b $00
[00007a09]                           dc.b $00
[00007a0a]                           dc.b $00
[00007a0b]                           dc.b $00
[00007a0c]                           dc.b $00
[00007a0d]                           dc.b $00
[00007a0e]                           dc.b $00
[00007a0f]                           dc.b $00
[00007a10]                           dc.b $00
[00007a11]                           dc.b $00
[00007a12]                           dc.b $00
[00007a13]                           dc.b $00
[00007a14]                           dc.b $00
[00007a15]                           dc.b $00
[00007a16]                           dc.b $00
[00007a17]                           dc.b $00
[00007a18]                           dc.b $00
[00007a19]                           dc.b $00
[00007a1a]                           dc.b $00
[00007a1b]                           dc.b $00
[00007a1c]                           dc.b $00
[00007a1d]                           dc.b $00
[00007a1e]                           dc.b $00
[00007a1f]                           dc.b $00
[00007a20]                           dc.b $00
[00007a21]                           dc.b $00
[00007a22]                           dc.b $00
[00007a23]                           dc.b $00
[00007a24]                           dc.b $00
[00007a25]                           dc.b $00
[00007a26]                           dc.b $00
[00007a27]                           dc.b $00
[00007a28]                           dc.b $00
[00007a29]                           dc.b $00
[00007a2a]                           dc.b $00
[00007a2b]                           dc.b $00
[00007a2c]                           dc.b $00
[00007a2d]                           dc.b $00
[00007a2e]                           dc.b $00
[00007a2f]                           dc.b $00
[00007a30]                           dc.b $00
[00007a31]                           dc.b $00
[00007a32]                           dc.b $00
[00007a33]                           dc.b $00
[00007a34]                           dc.b $00
[00007a35]                           dc.b $00
[00007a36]                           dc.b $00
[00007a37]                           dc.b $00
[00007a38]                           dc.b $00
[00007a39]                           dc.b $00
[00007a3a]                           dc.b $00
[00007a3b]                           dc.b $00
[00007a3c]                           dc.b $00
[00007a3d]                           dc.b $00
[00007a3e]                           dc.b $00
[00007a3f]                           dc.b $00
[00007a40]                           dc.b $00
[00007a41]                           dc.b $00
[00007a42]                           dc.b $00
[00007a43]                           dc.b $00
[00007a44]                           dc.b $00
[00007a45]                           dc.b $00
[00007a46]                           dc.b $00
[00007a47]                           dc.b $00
[00007a48]                           dc.b $00
[00007a49]                           dc.b $00
[00007a4a]                           dc.b $00
[00007a4b]                           dc.b $00
[00007a4c]                           dc.b $00
[00007a4d]                           dc.b $00
[00007a4e]                           dc.b $00
[00007a4f]                           dc.b $00
[00007a50]                           dc.b $00
[00007a51]                           dc.b $00
[00007a52]                           dc.b $00
[00007a53]                           dc.b $00
[00007a54]                           dc.b $00
[00007a55]                           dc.b $00
[00007a56]                           dc.b $00
[00007a57]                           dc.b $00
[00007a58]                           dc.b $00
[00007a59]                           dc.b $00
[00007a5a]                           dc.b $00
[00007a5b]                           dc.b $00
[00007a5c]                           dc.b $00
[00007a5d]                           dc.b $00
[00007a5e]                           dc.b $00
[00007a5f]                           dc.b $00
[00007a60]                           dc.b $00
[00007a61]                           dc.b $00
[00007a62]                           dc.b $00
[00007a63]                           dc.b $00
[00007a64]                           dc.b $00
[00007a65]                           dc.b $00
[00007a66]                           dc.b $00
[00007a67]                           dc.b $00
[00007a68]                           dc.b $00
[00007a69]                           dc.b $00
[00007a6a]                           dc.b $00
[00007a6b]                           dc.b $00
[00007a6c]                           dc.b $00
[00007a6d]                           dc.b $00
[00007a6e]                           dc.b $00
[00007a6f]                           dc.b $00
[00007a70]                           dc.b $00
[00007a71]                           dc.b $00
[00007a72]                           dc.b $00
[00007a73]                           dc.b $00
[00007a74]                           dc.b $00
[00007a75]                           dc.b $00
[00007a76]                           dc.b $00
[00007a77]                           dc.b $00
[00007a78]                           dc.b $00
[00007a79]                           dc.b $00
[00007a7a]                           dc.b $00
[00007a7b]                           dc.b $00
[00007a7c]                           dc.b $00
[00007a7d]                           dc.b $00
[00007a7e]                           dc.b $00
[00007a7f]                           dc.b $00
[00007a80]                           dc.b $00
[00007a81]                           dc.b $00
[00007a82]                           dc.b $00
[00007a83]                           dc.b $00
[00007a84]                           dc.b $00
[00007a85]                           dc.b $00
[00007a86]                           dc.b $00
[00007a87]                           dc.b $00
[00007a88]                           dc.b $00
[00007a89]                           dc.b $00
[00007a8a]                           dc.b $00
[00007a8b]                           dc.b $00
[00007a8c]                           dc.b $00
[00007a8d]                           dc.b $00
[00007a8e]                           dc.b $00
[00007a8f]                           dc.b $00
[00007a90]                           dc.b $00
[00007a91]                           dc.b $00
[00007a92]                           dc.b $00
[00007a93]                           dc.b $00
[00007a94]                           dc.b $00
[00007a95]                           dc.b $00
[00007a96]                           dc.b $00
[00007a97]                           dc.b $00
[00007a98]                           dc.b $00
[00007a99]                           dc.b $00
[00007a9a]                           dc.b $00
[00007a9b]                           dc.b $00
[00007a9c]                           dc.b $00
[00007a9d]                           dc.b $00
[00007a9e]                           dc.b $00
[00007a9f]                           dc.b $00
[00007aa0]                           dc.b $00
[00007aa1]                           dc.b $00
[00007aa2]                           dc.b $00
[00007aa3]                           dc.b $00
[00007aa4]                           dc.b $00
[00007aa5]                           dc.b $00
[00007aa6]                           dc.b $00
[00007aa7]                           dc.b $00
[00007aa8]                           dc.b $00
[00007aa9]                           dc.b $00
[00007aaa]                           dc.b $00
[00007aab]                           dc.b $00
[00007aac]                           dc.b $00
[00007aad]                           dc.b $00
[00007aae]                           dc.b $00
[00007aaf]                           dc.b $00
[00007ab0]                           dc.b $00
[00007ab1]                           dc.b $00
[00007ab2]                           dc.b $00
[00007ab3]                           dc.b $00
[00007ab4]                           dc.b $00
[00007ab5]                           dc.b $00
[00007ab6]                           dc.b $00
[00007ab7]                           dc.b $00
[00007ab8]                           dc.b $00
[00007ab9]                           dc.b $00
[00007aba]                           dc.b $00
[00007abb]                           dc.b $00
[00007abc]                           dc.b $00
[00007abd]                           dc.b $00
[00007abe]                           dc.b $00
[00007abf]                           dc.b $00
[00007ac0]                           dc.b $00
[00007ac1]                           dc.b $00
[00007ac2]                           dc.b $00
[00007ac3]                           dc.b $00
[00007ac4]                           dc.b $00
[00007ac5]                           dc.b $00
[00007ac6]                           dc.b $00
[00007ac7]                           dc.b $00
[00007ac8]                           dc.b $00
[00007ac9]                           dc.b $00
[00007aca]                           dc.b $00
[00007acb]                           dc.b $00
[00007acc]                           dc.b $00
[00007acd]                           dc.b $00
[00007ace]                           dc.b $00
[00007acf]                           dc.b $00
[00007ad0]                           dc.b $00
[00007ad1]                           dc.b $00
[00007ad2]                           dc.b $00
[00007ad3]                           dc.b $00
[00007ad4]                           dc.b $00
[00007ad5]                           dc.b $00
[00007ad6]                           dc.b $00
[00007ad7]                           dc.b $00
[00007ad8]                           dc.b $00
[00007ad9]                           dc.b $00
[00007ada]                           dc.b $00
[00007adb]                           dc.b $00
[00007adc]                           dc.b $00
[00007add]                           dc.b $00
[00007ade]                           dc.b $00
[00007adf]                           dc.b $00
[00007ae0]                           dc.b $00
[00007ae1]                           dc.b $00
[00007ae2]                           dc.b $00
[00007ae3]                           dc.b $00
[00007ae4]                           dc.b $00
[00007ae5]                           dc.b $00
[00007ae6]                           dc.b $00
[00007ae7]                           dc.b $00
[00007ae8]                           dc.b $00
[00007ae9]                           dc.b $00
[00007aea]                           dc.b $00
[00007aeb]                           dc.b $00
[00007aec]                           dc.b $00
[00007aed]                           dc.b $00
[00007aee] 000048b2                  dc.l $000048b2 ; no symbol found
[00007af2]                           dc.b '/tmp/t',0
[00007af9]                           dc.b 'pppp',0
[00007afe]                           dc.b $00
[00007aff]                           dc.b $00
[00007b00]                           dc.b $00
[00007b01]                           dc.b $00
[00007b02]                           dc.b $00
[00007b03]                           dc.b $00
[00007b04]                           dc.b $00
[00007b05]                           dc.b $00
[00007b06]                           dc.b $00
[00007b07]                           dc.b $00
[00007b08]                           dc.b $00
[00007b09]                           dc.b $00
[00007b0a]                           dc.b $00
[00007b0b]                           dc.b $00
[00007b0c]                           dc.b $00
[00007b0d]                           dc.b $00
[00007b0e] 00005102                  dc.l $00005102 ; no symbol found
[00007b12] 0000517e                  dc.l $0000517e ; no symbol found
[00007b16] 00007b98                  dc.l _end
[00007b1a]                           dc.b $00
[00007b1b]                           dc.b $00
[00007b1c]                           dc.b $00
[00007b1d]                           dc.b $01
[00007b1e]                           dc.w $3ff0
[00007b20]                           dc.b $00
[00007b21]                           dc.b $00
[00007b22]                           dc.b $00
[00007b23]                           dc.b $00
[00007b24]                           dc.b $00
[00007b25]                           dc.b $00
[00007b26]                           dc.w $4024
[00007b28]                           dc.b $00
[00007b29]                           dc.b $00
[00007b2a]                           dc.b $00
[00007b2b]                           dc.b $00
[00007b2c]                           dc.b $00
[00007b2d]                           dc.b $00
[00007b2e]                           dc.w $4059
[00007b30]                           dc.b $00
[00007b31]                           dc.b $00
[00007b32]                           dc.b $00
[00007b33]                           dc.b $00
[00007b34]                           dc.b $00
[00007b35]                           dc.b $00
[00007b36]                           dc.w $40c3
[00007b38]                           dc.w $8800
[00007b3a]                           dc.b $00
[00007b3b]                           dc.b $00
[00007b3c]                           dc.b $00
[00007b3d]                           dc.b $00
[00007b3e]                           dc.w $4197
[00007b40]                           dc.w $d784
[00007b42]                           dc.b $00
[00007b43]                           dc.b $00
[00007b44]                           dc.b $00
[00007b45]                           dc.b $00
[00007b46]                           dc.w $4341
[00007b48]                           dc.w $c379
[00007b4a]                           dc.w $37e0
[00007b4c]                           dc.w $8000
[00007b4e]                           dc.w $4693
[00007b50]                           dc.w $b8b5
[00007b52]                           dc.w $b505
[00007b54]                           dc.w $6e17
[00007b56]                           dc.w $4d38
[00007b58]                           dc.w $4f03
[00007b5a]                           dc.w $e93f
[00007b5c]                           dc.w $f9f5
[00007b5e]                           dc.w $5a82
[00007b60]                           dc.w $7748
[00007b62]                           dc.w $f930
[00007b64]                           dc.w $1d32
[00007b66]                           dc.w $7515
[00007b68]                           dc.w $4fdd
[00007b6a]                           dc.w $7f73
[00007b6c]                           dc.w $bf3c
[00007b6e]                           dc.b $00
[00007b6f]                           dc.b $00
[00007b70]                           dc.b $00
[00007b71]                           dc.b $00
[00007b72]                           dc.b $00
[00007b73]                           dc.b $00
[00007b74]                           dc.b $00
[00007b75]                           dc.b $00
[00007b76]                           dc.b $00
[00007b77]                           dc.b $0a
[00007b78]                           dc.b $00
[00007b79]                           dc.b $00
[00007b7a]                           dc.b $00
[00007b7b]                           dc.b $00
[00007b7c] 00007b80                  dc.l $00007b80 ; no symbol found
[00007b80]                           dc.b 'unchecked condition',0
[00007b94] 0000561a                  dc.l $0000561a ; no symbol found
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
00001c34 T _putls
00001e68 T _getex
00002004 T _getinl
00002134 T _getln
000021d8 T _main
0000243e T _putgr
0000262a T _putns
00002bc4 T _buytl
00002c3c T _fatal
00002c5c T _fretlist
00002c92 T _getfincl
00002f16 T _hash
00002f5e T _install
00002fc6 T _lookup
0000303a T _nxtfile
000030f6 T _perrfmt
0000324a T _p0error
00003372 T _predef
0000345e T _ptline
000034aa T _scntab
0000354a T _stotl
0000392c T _fclose
000039da T _fread
00003a2e T _frelst
00003a60 T _getenv
00003abe T _getfiles
00003c62 T _getflags
0000409e T _inbuf
000040e4 T _itob
0000417e T _putlin
000041b0 T _usage
00004226 T _buybuf
0000425a T _cmpbuf
00004282 T _cmpstr
0000429c T _cpystr
000042ba T _create
00004342 T _doesc
0000449c T _finit
00004534 T _getl
000045ec T _instr
0000462e T a.lmod
00004640 T a.ldiv
0000468e T _lseek
00004708 T _open
00004710 T _putc
000047c8 T _putl
000048aa T _read
000048be T _scnstr
000048d8 T _seek
000048e0 T a.switch
000048f2 T a.ulmod
000048fa T a.uldiv
00004936 T _uname
000049de T _alloc
00004a18 T _nalloc
00004b5c T _free
00004c1e T _btol
00004e54 T _close
00004e5c T _cpybuf
00004e7e T _creat
00004e86 T a.1sub
00004e9a T a.6sub
00004ec4 T a.1add
00004ed8 T a.6add
00004f86 T _dtento
00005114 T _fstat
0000511c T _getpid
00005122 T a.lmul
0000514e T a.1ltd
00005156 T a.6ltd
00005188 T _putstr
000051be T _sbreak
00005202 T a.1div
00005216 T a.6div
00005322 T a.1mul
00005336 T a.6mul
00005416 T _fwrite
00005450 T _lenstr
00005462 T __raise
000054fe T __when
00005544 T a.repk
000055d8 T a.unpk
00005668 T _error
000056a6 T _write

00000000 D __data
00000072 D _environ
00000076 D _errno
0000007a D __paths
00000082 D _bltintab
000004e6 D _cmap
000005e6 D _digfr
000005fd D _digto
0000095a D _lastln
00000b30 D _cplusfla
00000b34 D _errflag
00000b38 D _liflag
00000b3c D _oldflag
00000b40 D _pasflag
00000b44 D _stdflag
00000b48 D _xflag
00000b4c D _pchar
00000b50 D _schar
00000b54 D _inif
00000b56 D _inincl
00000b58 D _escname
00000b5e D _iprefix
00000b64 D _mapfile
00000b68 D __pname
00000b70 D _pasline
00000b74 D _failincl
00000b78 D _pflag
00000b7c D _argc
00000b80 D _lineno
00000b82 D _nerrors
00000b84 D _errfd
00000b86 D _pincl
00000b8a D _argv
00000b8e D _perr
00000b92 D _errbuf
0000222e D _stdout
00002438 D __pfio
00002440 D _readerr
00002460 D _fioerr
00002464 D __memerr
0000246c D __stop
00002470 D __dtens
000024c0 D __dzero
000024c8 D __ntens
000024e6 D _writerr

00007b98 B _end
;
; a.out Relocations:
00000016: 000056ae
00000026: 000056ae
00000040: 000056ae
00000046: 000056ae
0000004c: 00000000
00000058: 000056ae
00000062: 000056ae
0000006a: 00007b98
0000006e: 000056ae
00000074: 00000000
0000007c: 00000000
00000082: 000056ae
00000088: 00000000
000000ac: 000056ae
000000b4: 000056ae
000000be: 000056ae
000000e4: 000056ae
000000ea: 00000000
00000104: 000056ae
0000010a: 00000000
0000013e: 00000000
00000154: 00000000
0000017e: 00000000
0000018c: 00000000
000001a4: 000056ae
000001b0: 000056ae
000001ba: 00000000
000001ce: 000056ae
000001e0: 000056ae
000001ee: 000056ae
000001f4: 00000000
00000208: 000056ae
00000212: 000056ae
00000246: 00000000
00000252: 000056ae
0000025a: 000056ae
0000026a: 00000000
000002dc: 000056ae
000002e2: 00000000
0000030e: 00000000
0000031a: 000056ae
00000322: 000056ae
00000336: 00000000
000003e8: 000056ae
000003ee: 00000000
000003fe: 000056ae
00000474: 000056ae
0000049c: 000056ae
000004a2: 00000000
000004ec: 000056ae
000004f2: 00000000
00000504: 00000000
0000054e: 00000000
0000060a: 000056ae
00000610: 00000000
0000062e: 00000000
00000664: 00000000
000006ec: 00000000
00000746: 00000000
0000079a: 00000000
000007be: 00000000
0000080e: 00000000
0000081c: 00000000
00000860: 000056ae
00000866: 00000000
0000087a: 00000000
0000088c: 000056ae
00000892: 00000000
000008c8: 00000000
000008e4: 000056ae
000008ea: 00000000
00000940: 00000000
000009ec: 00000000
00000a28: 000056ae
00000a4a: 000056ae
00000a58: 000056ae
00000a5e: 00000000
00000a9e: 00000000
00000ac2: 00000000
00000ad8: 00000000
00000ae4: 00000000
00000b5e: 000056ae
00000b7c: 000056ae
00000b82: 00000000
00000b96: 000056ae
00000ba0: 000056ae
00000bba: 000056ae
00000bec: 000056ae
00000bf2: 00000000
00000c02: 000056ae
00000c14: 000056ae
00000c4e: 000056ae
00000c54: 00000000
00000c94: 000056ae
00000cfa: 000056ae
00000d00: 00000000
00000d10: 000056ae
00000d22: 000056ae
00000d28: 00000000
00000d46: 000056ae
00000d4c: 00000000
00000d94: 00000000
00000db0: 000056ae
00000db6: 00000000
00000e24: 00000000
00000e5c: 00000000
00000e84: 000056ae
00000e8a: 00000000
00000e96: 000056ae
00000ea6: 000056ae
00000ee2: 00000000
00000f5e: 000056ae
00000f64: 00000000
00000f96: 00000000
00000faa: 00000000
00000fbe: 00000000
000010f2: 000056ae
000010f8: 00000000
0000111c: 000056ae
00001122: 00000000
00001154: 00000000
0000121c: 000056ae
00001222: 00000000
00001250: 000056ae
00001256: 00000000
000012ce: 000056ae
000012d4: 00000000
00001344: 000056ae
0000134a: 00000000
0000135e: 000056ae
00001368: 000056ae
0000139a: 00000000
000013f0: 000056ae
000013f6: 00000000
00001494: 000056ae
0000149a: 00000000
000014aa: 00000000
000014b2: 00000000
000014e6: 00000000
0000153a: 000056ae
00001540: 00000000
0000158c: 00000000
000015a8: 00000000
000015da: 00000000
00001608: 00000000
0000163c: 00000000
00001664: 00000000
0000169a: 00000000
000016b0: 00000000
000016e4: 000056ae
000016ea: 00000000
000016f4: 000056ae
00001766: 000056ae
0000176c: 00000000
00001786: 000056ae
000017aa: 000056ae
000017e6: 000056ae
000017f2: 000056ae
000017fc: 00000000
00001828: 000056ae
0000182e: 00000000
00001840: 000056ae
00001846: 00000000
0000185c: 000056ae
00001862: 00000000
000018ce: 000056ae
000018d4: 00000000
000018f0: 00000000
000018fa: 000056ae
00001900: 00000000
00001928: 00000000
00001948: 000056ae
0000194e: 00000000
00001992: 000056ae
00001998: 00000000
000019cc: 000056ae
000019da: 000056ae
000019e4: 000056ae
000019ea: 000056ae
00001a0a: 000056ae
00001a10: 00000000
00001a48: 00000000
00001a62: 000056ae
00001a70: 000056ae
00001a7a: 000056ae
00001a80: 000056ae
00001aa4: 000056ae
00001aaa: 00000000
00001abc: 000056ae
00001ac4: 000056ae
00001acc: 000056ae
00001ad4: 000056ae
00001ade: 000056ae
00001ae8: 000056ae
00001af2: 000056ae
00001afc: 000056ae
00001b06: 000056ae
00001b10: 000056ae
00001b16: 000056ae
00001b28: 000056ae
00001b34: 000056ae
00001b42: 000056ae
00001b52: 000056ae
00001b58: 00000000
00001b64: 000056ae
00001b6e: 000056ae
00001b74: 000056ae
00001b7e: 000056ae
00001b84: 000056ae
00001b8a: 000056ae
00001b90: 000056ae
00001b96: 00000000
00001ba0: 000056ae
00001ba6: 00000000
00001bae: 000056ae
00001bb4: 00000000
00001bbe: 000056ae
00001bc8: 000056ae
00001bce: 000056ae
00001be0: 000056ae
00001bee: 000056ae
00001bf8: 000056ae
00001c02: 00000000
00001c10: 000056ae
00001c26: 000056ae
00001c2e: 000056ae
00001c42: 000056ae
00001c4a: 000056ae
00001c52: 000056ae
00001c5c: 000056ae
00001c64: 000056ae
00001c76: 000056ae
00001c94: 000056ae
00001c9c: 000056ae
00001ce0: 000056ae
00001ce6: 00000000
00001cf6: 00000000
00001d06: 00000000
00001d1e: 00000000
00001d32: 000056ae
00001d38: 00000000
00001dc8: 000056ae
00001dd6: 00000000
00001e76: 00000000
00001e94: 000056ae
00001eba: 000056ae
00001ec8: 000056ae
00001ece: 00000000
00001eda: 000056ae
00001ee0: 00000000
00001efa: 000056ae
00001f00: 00000000
00001f12: 00000000
00001f2e: 00000000
00001f4c: 000056ae
00001f56: 00000000
00001f60: 000056ae
00001f7e: 000056ae
00001f84: 00000000
00001fa2: 00000000
00001fc4: 000056ae
00001fca: 00000000
00001fde: 00000000
00001ff8: 00000000
00002010: 000056ae
00002016: 000056ae
0000201e: 00000000
00002024: 000056ae
0000202a: 00000000
00002030: 000056ae
00002044: 000056ae
0000204c: 000056ae
00002052: 000056ae
0000205a: 000056ae
00002060: 00000000
00002072: 000056ae
00002078: 000056ae
0000207e: 000056ae
0000208a: 000056ae
00002090: 00000000
0000209c: 000056ae
000020a4: 000056ae
000020aa: 00000000
000020b0: 000056ae
000020b8: 000056ae
000020be: 00000000
000020ca: 000056ae
000020d4: 00000000
000020dc: 000056ae
000020e4: 00000000
000020ec: 000056ae
000020f6: 00000000
000020fe: 000056ae
00002106: 000056ae
0000210c: 00000000
00002114: 000056ae
0000211c: 000056ae
00002122: 000056ae
0000212c: 000056ae
0000215e: 00000000
00002178: 000056ae
000021b6: 000056ae
000021bc: 00000000
000021e4: 000056ae
000021ec: 000056ae
000021f2: 000056ae
000021f8: 000056ae
000021fe: 000056ae
00002204: 000056ae
0000220a: 000056ae
00002210: 000056ae
00002216: 000056ae
0000221c: 000056ae
00002222: 000056ae
00002228: 000056ae
0000222e: 000056ae
00002234: 000056ae
0000223a: 000056ae
00002240: 000056ae
00002246: 000056ae
0000224c: 000056ae
00002252: 00000000
0000225c: 000056ae
0000226c: 000056ae
00002280: 000056ae
00002286: 00000000
00002294: 000056ae
0000229a: 000056ae
000022a0: 00000000
000022ac: 000056ae
000022be: 000056ae
000022c4: 00000000
000022ce: 000056ae
000022d6: 000056ae
000022e4: 000056ae
000022ea: 00000000
000022f2: 000056ae
000022fe: 000056ae
00002306: 000056ae
00002312: 000056ae
0000231a: 00000000
00002328: 000056ae
0000232e: 00000000
00002338: 00000000
0000233e: 000056ae
00002344: 00000000
0000234a: 000056ae
00002350: 00000000
00002356: 000056ae
00002364: 000056ae
0000236a: 00000000
0000237a: 000056ae
00002380: 000056ae
00002386: 00000000
00002396: 000056ae
000023a4: 00000000
000023b4: 000056ae
000023ba: 000056ae
000023c0: 00000000
000023d2: 00000000
000023e4: 00000000
000023fa: 000056ae
00002400: 00000000
0000240c: 00000000
00002416: 000056ae
0000241c: 00000000
00002422: 000056ae
0000242a: 000056ae
00002498: 00000000
000024c0: 00000000
000024cc: 00000000
00002506: 00000000
0000254e: 00000000
0000255a: 00000000
00002598: 00000000
000025c8: 00000000
00002608: 00000000
0000261c: 000056ae
00002622: 00000000
0000263c: 000056ae
00002642: 00000000
00002664: 000056ae
0000266e: 00000000
00002676: 000056ae
00002684: 000056ae
0000268a: 00000000
000026aa: 000056ae
000026b0: 00000000
000026c6: 000056ae
000026cc: 00000000
000026d8: 00000000
000026f4: 000056ae
000026fa: 00000000
00002738: 000056ae
00002752: 00000000
00002770: 00000000
0000278a: 00000000
000027a8: 00000000
000027c6: 000056ae
000027cc: 00000000
000027e4: 000056ae
000027ea: 00000000
00002804: 00000000
00002812: 00000000
0000281a: 000056ae
00002824: 000056ae
0000282a: 00000000
00002832: 000056ae
00002842: 00000000
00002850: 000056ae
0000285e: 00000000
0000286a: 00000000
00002872: 000056ae
00002878: 000056ae
0000287e: 00000000
00002884: 000056ae
0000288e: 00000000
00002896: 000056ae
0000289c: 000056ae
000028a6: 000056ae
000028bc: 000056ae
000028c4: 00000000
000028ce: 000056ae
000028d4: 000056ae
000028da: 00000000
00002904: 000056ae
00002916: 00000000
0000292e: 000056ae
00002934: 00000000
00002990: 000056ae
000029b8: 00000000
000029e2: 000056ae
000029e8: 000056ae
000029f6: 000056ae
00002a00: 00000000
00002a1a: 00000000
00002a26: 000056ae
00002a32: 000056ae
00002a38: 00000000
00002a40: 000056ae
00002a4a: 000056ae
00002a56: 00000000
00002a64: 00000000
00002a70: 000056ae
00002ab8: 00000000
00002ad8: 000056ae
00002ade: 000056ae
00002aec: 000056ae
00002af6: 00000000
00002b0e: 000056ae
00002b14: 00000000
00002b1c: 000056ae
00002b32: 000056ae
00002b46: 00000000
00002b50: 000056ae
00002b62: 00000000
00002b70: 000056ae
00002b76: 00000000
00002b80: 00000000
00002b8a: 000056ae
00002b90: 00000000
00002baa: 000056ae
00002bb0: 00000000
00002bbc: 00000000
00002bd6: 000056ae
00002bde: 000056ae
00002be4: 000056ae
00002bf4: 00000000
00002c4a: 00000000
00002c54: 00000000
00002c7c: 000056ae
00002c84: 000056ae
00002cc4: 000056ae
00002d02: 00000000
00002d30: 00000000
00002d66: 00000000
00002d7a: 00000000
00002dac: 00000000
00002dd4: 000056ae
00002dfa: 00000000
00002e10: 00000000
00002e2c: 000056ae
00002e3e: 00000000
00002e5a: 00000000
00002e74: 00000000
00002e94: 00000000
00002ea4: 00000000
00002eba: 00000000
00002ec8: 00000000
00002ed4: 000056ae
00002eec: 00000000
00002f48: 00000000
00002f52: 000056ae
00002f94: 00000000
00002fae: 00000000
0000300e: 00000000
0000304a: 000056ae
00003050: 000056ae
00003056: 00000000
0000306a: 000056ae
00003070: 000056ae
0000307a: 000056ae
00003094: 00000000
000030a8: 000056ae
000030b2: 00000000
000030bc: 000056ae
000030c6: 00000000
000030d4: 000056ae
000030e6: 00000000
0000311e: 000056ae
00003128: 00000000
00003132: 000056ae
00003138: 000056ae
00003166: 000056ae
00003170: 00000000
0000317a: 000056ae
00003180: 000056ae
000031a2: 00000000
000031c2: 000056ae
000031cc: 00000000
000031dc: 000056ae
000031e2: 00000000
000031ea: 000056ae
0000320a: 00000000
0000321a: 000056ae
00003224: 00000000
00003232: 000056ae
00003238: 00000000
00003240: 000056ae
00003250: 000056ae
00003254: 000056ae
0000325a: 000056ae
00003266: 000056ae
00003270: 000056ae
0000327c: 000056ae
00003282: 000056ae
0000328a: 000056ae
0000329a: 000056ae
000032a2: 000056ae
000032a8: 000056ae
000032b0: 000056ae
000032bc: 000056ae
000032c8: 000056ae
000032d2: 000056ae
000032d8: 000056ae
000032de: 000056ae
000032e4: 000056ae
00003304: 000056ae
0000330e: 000056ae
00003314: 000056ae
0000331c: 000056ae
00003322: 000056ae
00003336: 000056ae
0000333c: 00000000
0000334a: 000056ae
00003356: 000056ae
00003360: 000056ae
00003366: 00000000
000033aa: 000056ae
000033b2: 00000000
000033c8: 000056ae
000033ee: 00000000
0000342a: 000056ae
00003444: 00000000
00003464: 000056ae
0000346c: 000056ae
00003474: 000056ae
0000347c: 000056ae
00003484: 000056ae
00003490: 000056ae
0000349c: 000056ae
000034a2: 00000000
000035d6: 000056ae
00003610: 000056ae
00003652: 000056ae
00003676: 000056ae
000036ec: 000056ae
00003768: 000056ae
000037ec: 000056ae
0000380c: 000056ae
00003832: 000056ae
000038ba: 000056ae
000038e4: 000056ae
0000393e: 000056ae
00003946: 00000000
0000394e: 000056ae
0000399c: 00000000
000039ae: 000056ae
000039b6: 00000000
000039c4: 00000000
000039fc: 00000000
00003a1e: 000056ae
00003a26: 00000000
00003a4c: 00000000
00003a70: 00000000
00003a78: 000056ae
00003a8c: 00000000
00003adc: 00000000
00003ae6: 00000000
00003b0a: 00000000
00003b38: 00000000
00003b56: 00000000
00003b68: 000056ae
00003b72: 00000000
00003b7e: 00000000
00003b90: 000056ae
00003b9a: 00000000
00003bc8: 000056ae
00003bd2: 00000000
00003be4: 000056ae
00003bee: 00000000
00003c0e: 000056ae
00003c18: 00000000
00003c32: 000056ae
00003c3c: 00000000
00003c52: 00000000
00003c8a: 000056ae
00003c92: 00000000
00003cbc: 000056ae
00003cc4: 00000000
00003cf6: 000056ae
00003cfc: 00000000
00003d12: 00000000
00003d62: 000056ae
00003d9c: 000056ae
00003da2: 00000000
00003df4: 00000000
00003e3c: 00000000
00003e7a: 00000000
00003e86: 00000000
00003eac: 00000000
00003f60: 00000000
0000406e: 00000000
00004084: 000056ae
0000408c: 00000000
00004142: 00000000
0000415a: 00000000
00004192: 000056ae
00004198: 00000000
000041c2: 00000000
000041c8: 000056ae
000041ce: 00000000
000041d8: 00000000
000041ec: 00000000
00004208: 00000000
0000420e: 000056ae
00004214: 00000000
0000423c: 00000000
000042c4: 00000000
000042fc: 00000000
00004318: 00000000
00004326: 00000000
000043da: 00000000
000043e0: 00000000
000043fa: 00000000
0000442a: 00000000
0000445e: 000056ae
00004480: 00000000
0000448a: 000056ae
000044b2: 000056ae
000044ba: 00000000
000044dc: 00000000
00004504: 000056ae
0000450c: 000056ae
00004512: 000056ae
0000451a: 00000000
00004520: 00000000
00004526: 000056ae
0000454a: 000056ae
00004552: 00000000
0000457a: 00000000
0000458c: 000056ae
00004594: 00000000
000046b6: 00000000
000046d2: 00000000
00004726: 000056ae
0000472e: 00000000
00004778: 00000000
000047ba: 00000000
000047de: 000056ae
000047e6: 00000000
0000486c: 00000000
00004890: 00000000
00004940: 000056ae
00004948: 00000000
0000495e: 000056ae
00004972: 000056ae
000049f0: 00000000
00004a02: 000056ae
00004a0a: 00000000
00004a40: 000056ae
00004a60: 000056ae
00004a6c: 000056ae
00004a9a: 000056ae
00004aa2: 000056ae
00004aaa: 000056ae
00004ab2: 000056ae
00004aba: 000056ae
00004ac6: 00000000
00004ad2: 000056ae
00004ada: 000056ae
00004aee: 00000000
00004b0c: 000056ae
00004b14: 000056ae
00004b1c: 000056ae
00004b22: 000056ae
00004b38: 000056ae
00004b44: 00000000
00004b74: 000056ae
00004b7c: 000056ae
00004b86: 00000000
00004b8a: 000056ae
00004b90: 000056ae
00004b98: 00000000
00004bac: 000056ae
00004bb8: 000056ae
00004bc0: 000056ae
00004bc8: 000056ae
00004bd0: 000056ae
00004bde: 000056ae
00004de6: 00000000
00004efa: 00000000
00004f10: 00000000
00004f6a: 00000000
00004fa6: 000056ae
00004fc8: 000056ae
00004fd0: 00000000
00004ff0: 000056ae
0000500c: 000056ae
0000501c: 00000000
00005040: 000056ae
0000504c: 000056ae
00005054: 00000000
0000506a: 000056ae
00005076: 000056ae
0000507e: 00000000
000050ac: 000056ae
000050b8: 000056ae
000050c8: 00000000
000050d6: 000056ae
000050e2: 000056ae
000050f2: 00000000
00005170: 00000000
0000519e: 00000000
000051ac: 00000000
000051ca: 000056ae
000051e4: 000056ae
000051ea: 000056ae
000051f0: 000056ae
000051f8: 000056ae
000051fc: 000056ae
00005238: 00000000
00005286: 00000000
000052f4: 00000000
00005368: 00000000
00005380: 00000000
000053e8: 00000000
0000542c: 00000000
0000543a: 000056ae
00005442: 00000000
00005488: 000056ae
000054aa: 000056ae
000054ec: 000056ae
000054f6: 00000000
00005500: 000056ae
00005534: 000056ae
0000565a: 00000000
0000566e: 000056ae
00005678: 00000000
00005692: 00000000
0000569e: 00000000
00005728: 000056ae
0000572c: 00000000
00005730: 000056ae
00005738: 000056ae
00005740: 000056ae
00005748: 000056ae
00005782: 000056ae
00005796: 00000000
0000579e: 00000000
000057a6: 00000000
000057ae: 00000000
000057ba: 00000000
00005882: 000056ae
0000588a: 000056ae
00005892: 000056ae
0000589a: 000056ae
000058a2: 000056ae
000058aa: 000056ae
000058b2: 000056ae
000058ba: 000056ae
000058c2: 000056ae
000058ca: 000056ae
000058d2: 000056ae
000058da: 000056ae
000058e2: 000056ae
000058ea: 000056ae
000058f2: 000056ae
000058fa: 000056ae
00005902: 000056ae
0000590a: 000056ae
00005912: 000056ae
0000591a: 000056ae
00005922: 000056ae
0000592a: 000056ae
00005932: 000056ae
0000593a: 000056ae
00005942: 000056ae
0000594a: 000056ae
00005952: 000056ae
0000595a: 000056ae
00005962: 000056ae
0000596a: 000056ae
00005972: 000056ae
0000597a: 000056ae
00005982: 000056ae
0000598a: 000056ae
00005992: 000056ae
0000599a: 000056ae
000059a2: 000056ae
000059aa: 000056ae
000059b2: 000056ae
000059ba: 000056ae
000059c2: 000056ae
000059ca: 000056ae
000059d2: 000056ae
000059da: 000056ae
000059e2: 000056ae
000059ea: 000056ae
00005a96: 000056ae
00005a9e: 000056ae
00005aa6: 000056ae
00005aae: 000056ae
00005ab6: 000056ae
00005abe: 000056ae
00005ac6: 000056ae
00005ace: 000056ae
00005ad6: 000056ae
00005ade: 000056ae
00005ae6: 000056ae
00005aee: 000056ae
00005af6: 000056ae
00005afe: 000056ae
00005b06: 000056ae
00005b0e: 000056ae
00005b16: 000056ae
00005b1e: 000056ae
00005b26: 000056ae
00005b2e: 000056ae
00005b36: 000056ae
00005d08: 00000000
00005d10: 00000000
00005d18: 00000000
00005d20: 00000000
00005d28: 00000000
00005d30: 00000000
00005d38: 00000000
00005d40: 00000000
00005d48: 00000000
00005d50: 00000000
00005d58: 00000000
00005d60: 00000000
00005d68: 00000000
00005d70: 00000000
00005d78: 00000000
00005d80: 00000000
00005d88: 00000000
00005d90: 00000000
00005d98: 00000000
00005da4: 00000000
00005e10: 000056ae
00005e18: 000056ae
00005e20: 000056ae
00005e28: 000056ae
00005e30: 000056ae
00005e38: 000056ae
00005e40: 000056ae
00005e48: 000056ae
00005e50: 000056ae
00005e58: 000056ae
00005e60: 000056ae
00005e68: 000056ae
00005e70: 000056ae
00005e78: 000056ae
00005e80: 000056ae
00005e88: 000056ae
00005e90: 000056ae
00005e98: 000056ae
00005ea0: 000056ae
00005ea8: 000056ae
00005eb0: 000056ae
00005eb8: 000056ae
00005ec0: 000056ae
00005ec8: 000056ae
00005ed0: 000056ae
00005ed8: 000056ae
00005ee0: 000056ae
00005ee8: 000056ae
00005ef0: 000056ae
00005ef8: 000056ae
00005f00: 000056ae
00005f08: 000056ae
00005f10: 000056ae
0000616e: 00000000
00006176: 00000000
0000617e: 00000000
00006186: 00000000
0000618e: 00000000
00006196: 00000000
000061a2: 00000000
0000620c: 000056ae
00006216: 000056ae
000062c0: 000056ae
000062c8: 000056ae
000062d0: 000056ae
000062d8: 000056ae
000062e0: 000056ae
000062e8: 000056ae
000062f0: 000056ae
000062f8: 000056ae
00006300: 000056ae
00006308: 000056ae
00006310: 000056ae
00006318: 000056ae
00006320: 000056ae
00006328: 000056ae
00006330: 000056ae
00006338: 000056ae
00006340: 000056ae
00006348: 000056ae
00006350: 000056ae
00006358: 000056ae
00006360: 000056ae
00006368: 000056ae
00006370: 000056ae
00006378: 000056ae
00006426: 00000000
0000642e: 00000000
00006436: 00000000
0000643e: 00000000
00006446: 00000000
0000644e: 00000000
00006456: 00000000
0000645e: 00000000
0000646a: 00000000
00007560: 00000000
00007568: 00000000
00007570: 00000000
00007578: 00000000
00007580: 00000000
00007588: 00000000
00007590: 00000000
0000759c: 00000000
0000788e: 00000000
00007896: 00000000
0000789e: 00000000
000078a6: 00000000
000078ae: 00000000
000078b6: 00000000
000078be: 00000000
000078ca: 00000000
00007aee: 00000000
00007b0e: 00000000
00007b12: 00000000
00007b16: 00007b98
00007b7c: 000056ae
00007b94: 00000000

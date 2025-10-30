; a_magic   = 0x992d
; a_text    = 0x000027b2
; a_data    = 0x00000900
; a_bss     = 0x00000000
; a_syms    = 0x00000000
; a_heap    = 0x00001200
; a_textoff = 0x00000000
; a_dataoff = 0x00020000
; a_relocs  = 0x00000378@0x000030ce


x0:
[00000000] 201f                      move.l     (a7)+,d0
[00000002] 204f                      movea.l    a7,a0
[00000004] 2f08                      move.l     a0,-(a7)
[00000006] 2f08                      move.l     a0,-(a7)
[00000008] 2f00                      move.l     d0,-(a7)
[0000000a] e598                      rol.l      #2,d0
[0000000c] 5880                      addq.l     #4,d0
[0000000e] d1af 0008                 add.l      d0,8(a7)
[00000012] 23ef 0008 0002 0072       move.l     8(a7),$00022824
[0000001a] 4a97                      tst.l      (a7)
[0000001c] 6726                      beq.s      x0_1
[0000001e] 206f 0004                 movea.l    4(a7),a0
[00000022] 2050                      movea.l    (a0),a0
[00000024] 23c8 0002 08f6            move.l     a0,$000230A8
x0_3:
[0000002a] 0c10 003a                 cmpi.b     #$3A,(a0)
[0000002e] 670c                      beq.s      x0_2
[00000030] 0c10 007c                 cmpi.b     #$7C,(a0)
[00000034] 6706                      beq.s      x0_2
[00000036] 4a18                      tst.b      (a0)+
[00000038] 66f0                      bne.s      x0_3
[0000003a] 6008                      bra.s      x0_1
x0_2:
[0000003c] 4218                      clr.b      (a0)+
[0000003e] 23c8 0002 007a            move.l     a0,$0002282C
x0_1:
[00000044] 4879 0002 006c            pea.l      $0002281E
[0000004a] 4eb9 0000 131c            jsr        $0000131C
[00000050] 4a9f                      tst.l      (a7)+
[00000052] 4a87                      tst.l      d7
[00000054] 6706                      beq.s      x0_4
[00000056] 23c7 0002 007a            move.l     d7,$0002282C
x0_4:
[0000005c] 0cb9 0000 0001 0002 08dc  cmpi.l     #$00000001,$0002308E
[00000066] 660a                      bne.s      x0_5
[00000068] 23fc 0002 0900 0002 08dc  move.l     #$000239B2,$0002308E
x0_5:
[00000072] 4eb9 0000 020a            jsr        _main
[00000078] 2e87                      move.l     d7,(a7)
[0000007a] 4eb9 0000 0080            jsr        _exit

_exit:
[00000080] 2e39 0002 007e            move.l     $00022830,d7
x0_7:
[00000086] 0c87 0000 00aa            cmpi.l     #_onexit,d7
[0000008c] 670a                      beq.s      x0_6
[0000008e] 4a87                      tst.l      d7
[00000090] 6706                      beq.s      x0_6
[00000092] 2047                      movea.l    d7,a0
[00000094] 4e90                      jsr        (a0)
[00000096] 60ee                      bra.s      x0_7
x0_6:
[00000098] 4aaf 0004                 tst.l      4(a7)
[0000009c] 6604                      bne.s      x0_8
[0000009e] 7e01                      moveq.l    #1,d7
[000000a0] 6002                      bra.s      x0_9
x0_8:
[000000a2] 4287                      clr.l      d7
x0_9:
[000000a4] 2f07                      move.l     d7,-(a7)
[000000a6] 7e01                      moveq.l    #1,d7
[000000a8] 4e41                      trap       #1
_onexit:
[000000aa] 2e39 0002 007e            move.l     $00022830,d7
[000000b0] 23ef 0004 0002 007e       move.l     4(a7),$00022830
[000000b8] 4e75                      rts

seterr:
[000000ba] 4487                      neg.l      d7
[000000bc] 23c7 0002 0076            move.l     d7,_errno
[000000c2] 7eff                      moveq.l    #-1,d7
[000000c4] 4ed0                      jmp        (a0)

_devname:
[000000c6] 4e56 fff8                 link       a6,#-8
[000000ca] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[000000ce] 2a2e 000c                 move.l     12(a6),d5
[000000d2] 282e 0010                 move.l     16(a6),d4
[000000d6] 4a84                      tst.l      d4
[000000d8] 6708                      beq.s      _devname_1
[000000da] 2e3c 0002 00f0            move.l     #$000228A2,d7 "/dev/cnames"
[000000e0] 6006                      bra.s      _devname_2
_devname_1:
[000000e2] 2e3c 0002 00e4            move.l     #$00022896,d7 "/dev/bnames"
_devname_2:
[000000e8] 2d47 fffc                 move.l     d7,-4(a6)
[000000ec] 4a84                      tst.l      d4
[000000ee] 673c                      beq.s      _devname_3
[000000f0] 4ab9 0002 0100            tst.l      $000228B2
[000000f6] 6708                      beq.s      _devname_4
[000000f8] 2e39 0002 0100            move.l     $000228B2,d7
[000000fe] 6020                      bra.s      _devname_5
_devname_4:
[00000100] 4297                      clr.l      (a7)
[00000102] 2f2e fffc                 move.l     -4(a6),-(a7)
[00000106] 2f3c 0002 00e0            move.l     #$00022892,-(a7)
[0000010c] 4eb9 0000 08ec            jsr        _readfill
[00000112] 508f                      addq.l     #8,a7
[00000114] 23c7 0002 0100            move.l     d7,$000228B2
[0000011a] 2e39 0002 0100            move.l     $000228B2,d7
_devname_5:
[00000120] 2d47 fff8                 move.l     d7,-8(a6)
[00000124] 2639 0002 00e0            move.l     $00022892,d3
[0000012a] 603a                      bra.s      _devname_6
_devname_3:
[0000012c] 4ab9 0002 0104            tst.l      $000228B6
[00000132] 6708                      beq.s      _devname_7
[00000134] 2e39 0002 0104            move.l     $000228B6,d7
[0000013a] 6020                      bra.s      _devname_8
_devname_7:
[0000013c] 4297                      clr.l      (a7)
[0000013e] 2f2e fffc                 move.l     -4(a6),-(a7)
[00000142] 2f3c 0002 00fc            move.l     #$000228AE,-(a7)
[00000148] 4eb9 0000 08ec            jsr        _readfill
[0000014e] 508f                      addq.l     #8,a7
[00000150] 23c7 0002 0104            move.l     d7,$000228B6
[00000156] 2e39 0002 0104            move.l     $000228B6,d7
_devname_8:
[0000015c] 2d47 fff8                 move.l     d7,-8(a6)
[00000160] 2639 0002 00fc            move.l     $000228AE,d3
_devname_6:
[00000166] 246e 0008                 movea.l    8(a6),a2
[0000016a] 4212                      clr.b      (a2)
[0000016c] 4aae fff8                 tst.l      -8(a6)
[00000170] 6604                      bne.s      _devname_9
[00000172] 4287                      clr.l      d7
[00000174] 6054                      bra.s      _devname_10
_devname_9:
[00000176] 9bcd                      suba.l     a5,a5
[00000178] 99cc                      suba.l     a4,a4
_devname_15:
[0000017a] 4a83                      tst.l      d3
[0000017c] 674a                      beq.s      _devname_11
[0000017e] 2e05                      move.l     d5,d7
[00000180] e087                      asr.l      #8,d7
[00000182] be8d                      cmp.l      a5,d7
[00000184] 6654                      bne.s      _devname_12
[00000186] 2e05                      move.l     d5,d7
[00000188] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000018e] be8c                      cmp.l      a4,d7
[00000190] 6648                      bne.s      _devname_12
_devname_14:
[00000192] 4a83                      tst.l      d3
[00000194] 6758                      beq.s      _devname_13
[00000196] 246e fff8                 movea.l    -8(a6),a2
[0000019a] 4287                      clr.l      d7
[0000019c] 1e12                      move.b     (a2),d7
[0000019e] 0c47 000a                 cmpi.w     #$000A,d7
[000001a2] 674a                      beq.s      _devname_13
[000001a4] 246e fff8                 movea.l    -8(a6),a2
[000001a8] 4287                      clr.l      d7
[000001aa] 1e12                      move.b     (a2),d7
[000001ac] 0c47 0020                 cmpi.w     #$0020,d7
[000001b0] 673c                      beq.s      _devname_13
[000001b2] 246e 0008                 movea.l    8(a6),a2
[000001b6] 52ae 0008                 addq.l     #1,8(a6)
[000001ba] 266e fff8                 movea.l    -8(a6),a3
[000001be] 1493                      move.b     (a3),(a2)
[000001c0] 5383                      subq.l     #1,d3
[000001c2] 52ae fff8                 addq.l     #1,-8(a6)
[000001c6] 60ca                      bra.s      _devname_14
_devname_11:
[000001c8] 4287                      clr.l      d7
_devname_10:
[000001ca] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[000001ce] 4e5e                      unlk       a6
[000001d0] 4e75                      rts
_devname_17:
[000001d2] 5383                      subq.l     #1,d3
[000001d4] 52ae fff8                 addq.l     #1,-8(a6)
[000001d8] 60a0                      bra.s      _devname_15
_devname_12:
[000001da] 246e fff8                 movea.l    -8(a6),a2
[000001de] 4287                      clr.l      d7
[000001e0] 1e12                      move.b     (a2),d7
[000001e2] 0c47 000a                 cmpi.w     #$000A,d7
[000001e6] 6610                      bne.s      _devname_16
[000001e8] 528d                      addq.l     #1,a5
[000001ea] 99cc                      suba.l     a4,a4
[000001ec] 60e4                      bra.s      _devname_17
_devname_13:
[000001ee] 246e 0008                 movea.l    8(a6),a2
[000001f2] 4212                      clr.b      (a2)
[000001f4] 7e01                      moveq.l    #1,d7
[000001f6] 60d2                      bra.s      _devname_10
_devname_16:
[000001f8] 246e fff8                 movea.l    -8(a6),a2
[000001fc] 4287                      clr.l      d7
[000001fe] 1e12                      move.b     (a2),d7
[00000200] 0c47 0020                 cmpi.w     #$0020,d7
[00000204] 66cc                      bne.s      _devname_17
[00000206] 528c                      addq.l     #1,a4
[00000208] 60c8                      bra.s      _devname_17

_main:
[0000020a] 4e56 fffc                 link       a6,#-4
[0000020e] 2ebc 0002 009e            move.l     #_tflag,(a7)
[00000214] 2f3c 0002 009a            move.l     #_slp,-(a7)
[0000021a] 2f3c 0002 0096            move.l     #_rflag,-(a7)
[00000220] 2f3c 0002 0092            move.l     #_pflag,-(a7)
[00000226] 2f3c 0002 008e            move.l     #_lflag,-(a7)
[0000022c] 2f3c 0002 008a            move.l     #_iflag,-(a7)
[00000232] 2f3c 0002 0086            move.l     #_fflag,-(a7)
[00000238] 2f3c 0002 0082            move.l     #_aflag,-(a7)
[0000023e] 2f3c 0002 011f            move.l     #$000228D1,-(a7) "a,f,i,l,p,r,s#,t:F"
[00000244] 486e 000c                 pea.l      12(a6)
[00000248] 486e 0008                 pea.l      8(a6)
[0000024c] 4eb9 0000 14b6            jsr        _getflags
[00000252] 4fef 0028                 lea.l      40(a7),a7
[00000256] 4ab9 0002 0092            tst.l      _pflag
[0000025c] 661c                      bne.s      main_18
[0000025e] 2e39 0002 0082            move.l     _aflag,d7
[00000264] deb9 0002 008a            add.l      _iflag,d7
[0000026a] deb9 0002 009e            add.l      _tflag,d7
[00000270] 6608                      bne.s      main_18
[00000272] 7001                      moveq.l    #1,d0
[00000274] 23c0 0002 0092            move.l     d0,_pflag
main_18:
[0000027a] 4aae 0008                 tst.l      8(a6)
[0000027e] 670c                      beq.s      main_19
[00000280] 2ebc 0002 010a            move.l     #$000228BC,(a7) "-[a f i l p r s# t]\n"
[00000286] 4eb9 0000 1914            jsr        _usage
main_19:
[0000028c] 4ab9 0002 0082            tst.l      _aflag
[00000292] 6608                      bne.s      main_20
[00000294] 4ab9 0002 009e            tst.l      _tflag
[0000029a] 671e                      beq.s      main_21
main_20:
[0000029c] 4ab9 0002 0082            tst.l      _aflag
[000002a2] 6604                      bne.s      main_22
[000002a4] 7e01                      moveq.l    #1,d7
[000002a6] 6002                      bra.s      main_23
main_22:
[000002a8] 4287                      clr.l      d7
main_23:
[000002aa] 2e87                      move.l     d7,(a7)
[000002ac] 2f39 0002 00d4            move.l     _tps,-(a7)
[000002b2] 4eb9 0000 0486            jsr        _pps
[000002b8] 588f                      addq.l     #4,a7
main_21:
[000002ba] 4ab9 0002 0092            tst.l      _pflag
[000002c0] 6710                      beq.s      main_24
[000002c2] 4297                      clr.l      (a7)
[000002c4] 2f39 0002 00c6            move.l     _tmyps,-(a7)
[000002ca] 4eb9 0000 0486            jsr        _pps
[000002d0] 588f                      addq.l     #4,a7
main_24:
[000002d2] 4ab9 0002 008a            tst.l      _iflag
[000002d8] 670c                      beq.s      main_25
[000002da] 2eb9 0002 00a6            move.l     _tinode,(a7)
[000002e0] 4eb9 0000 0310            jsr        _pinode
main_25:
[000002e6] 4ab9 0002 009a            tst.l      _slp
[000002ec] 6606                      bne.s      main_26
[000002ee] 7e01                      moveq.l    #1,d7
[000002f0] 4e5e                      unlk       a6
[000002f2] 4e75                      rts
main_26:
[000002f4] 2eb9 0002 009a            move.l     _slp,(a7)
[000002fa] 4eb9 0000 18fa            jsr        _sleep
[00000300] 2ebc 0002 0108            move.l     #$000228BA,(a7) "\n"
[00000306] 4eb9 0000 0bca            jsr        _putfmt
[0000030c] 6000 ff7e                 bra        main_19

_pinode:
[00000310] 4e56 ffea                 link       a6,#-22
[00000314] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00000318] 2ebc 0002 0193            move.l     #$00022945,(a7) "inodes:\n"
[0000031e] 4eb9 0000 0bca            jsr        _putfmt
[00000324] 4297                      clr.l      (a7)
[00000326] 2f2e 0008                 move.l     8(a6),-(a7)
[0000032a] 486e fffc                 pea.l      -4(a6)
[0000032e] 4eb9 0000 08ec            jsr        _readfill
[00000334] 508f                      addq.l     #8,a7
[00000336] 2847                      movea.l    d7,a4
[00000338] 2e0c                      move.l     a4,d7
[0000033a] 6608                      bne.s      _pinode_27
[0000033c] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00000340] 4e5e                      unlk       a6
[00000342] 4e75                      rts
_pinode_27:
[00000344] 2ebc 0002 0160            move.l     #$00022912,(a7) "FLG REF LAST  DEV   INUM    MODE  LNK  SIZE ADDRS\n"
[0000034a] 4eb9 0000 0bca            jsr        _putfmt
[00000350] 2a4c                      movea.l    a4,a5
_pinode_31:
[00000352] 2e0c                      move.l     a4,d7
[00000354] deae fffc                 add.l      -4(a6),d7
[00000358] bbc7                      cmpa.l     d7,a5
[0000035a] 6400 00cc                 bcc        _pinode_28
[0000035e] 4297                      clr.l      (a7)
[00000360] 4287                      clr.l      d7
[00000362] 3e2d 0016                 move.w     22(a5),d7
[00000366] 2f07                      move.l     d7,-(a7)
[00000368] 486e ffeb                 pea.l      -21(a6)
[0000036c] 4eba fd58                 jsr        _devname(pc)
[00000370] 508f                      addq.l     #8,a7
[00000372] 4287                      clr.l      d7
[00000374] 3e2d 0018                 move.w     24(a5),d7
[00000378] 2e87                      move.l     d7,(a7)
[0000037a] 486e ffeb                 pea.l      -21(a6)
[0000037e] 4287                      clr.l      d7
[00000380] 3e2d 0014                 move.w     20(a5),d7
[00000384] 2f07                      move.l     d7,-(a7)
[00000386] 4287                      clr.l      d7
[00000388] 3e2d 000e                 move.w     14(a5),d7
[0000038c] 2f07                      move.l     d7,-(a7)
[0000038e] 4287                      clr.l      d7
[00000390] 3e2d 000c                 move.w     12(a5),d7
[00000394] 2f07                      move.l     d7,-(a7)
[00000396] 2f3c 0002 0148            move.l     #$000228FA,-(a7) " %+07o %3i %6l"
[0000039c] 4eb9 0000 0bca            jsr        _putfmt
[000003a2] 4fef 0014                 lea.l      20(a7),a7
[000003a6] 4287                      clr.l      d7
[000003a8] 1e2d 001f                 move.b     31(a5),d7
[000003ac] 7c10                      moveq.l    #16,d6
[000003ae] eda7                      asl.l      d6,d7
[000003b0] 4286                      clr.l      d6
[000003b2] 3c2d 0020                 move.w     32(a5),d6
[000003b6] de86                      add.l      d6,d7
[000003b8] 2e87                      move.l     d7,(a7)
[000003ba] 4287                      clr.l      d7
[000003bc] 1e2d 001c                 move.b     28(a5),d7
[000003c0] 2f07                      move.l     d7,-(a7)
[000003c2] 4287                      clr.l      d7
[000003c4] 3e2d 001a                 move.w     26(a5),d7
[000003c8] 2f07                      move.l     d7,-(a7)
[000003ca] 2f3c 0002 0139            move.l     #$000228EB,-(a7) " %+07o %3i %6l"
[000003d0] 4eb9 0000 0bca            jsr        _putfmt
[000003d6] 4fef 000c                 lea.l      12(a7),a7
[000003da] 426e fffa                 clr.w      -6(a6)
_pinode_30:
[000003de] 3e2e fffa                 move.w     -6(a6),d7
[000003e2] 48c7                      ext.l      d7
[000003e4] 0c47 0008                 cmpi.w     #$0008,d7
[000003e8] 6c5c                      bge.s      _pinode_29
[000003ea] 3e2e fffa                 move.w     -6(a6),d7
[000003ee] 48c7                      ext.l      d7
[000003f0] e387                      asl.l      #1,d7
[000003f2] 2447                      movea.l    d7,a2
[000003f4] 47ed 0022                 lea.l      34(a5),a3
[000003f8] d5cb                      adda.l     a3,a2
[000003fa] 4a52                      tst.w      (a2)
[000003fc] 6748                      beq.s      _pinode_29
[000003fe] 3e2e fffa                 move.w     -6(a6),d7
[00000402] 48c7                      ext.l      d7
[00000404] e387                      asl.l      #1,d7
[00000406] 2447                      movea.l    d7,a2
[00000408] 47ed 0022                 lea.l      34(a5),a3
[0000040c] d5cb                      adda.l     a3,a2
[0000040e] 4287                      clr.l      d7
[00000410] 3e12                      move.w     (a2),d7
[00000412] 2e87                      move.l     d7,(a7)
[00000414] 2f3c 0002 0134            move.l     #$000228E6,-(a7) " %5i"
[0000041a] 4eb9 0000 0bca            jsr        _putfmt
[00000420] 588f                      addq.l     #4,a7
[00000422] 526e fffa                 addq.w     #1,-6(a6)
[00000426] 60b6                      bra.s      _pinode_30
_pinode_28:
[00000428] 4297                      clr.l      (a7)
[0000042a] 2f0c                      move.l     a4,-(a7)
[0000042c] 4eb9 0000 227a            jsr        $0000227A
[00000432] 588f                      addq.l     #4,a7
[00000434] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00000438] 4e5e                      unlk       a6
[0000043a] 4e75                      rts
_pinode_32:
[0000043c] dbfc 0000 0032            adda.l     #$00000032,a5
[00000442] 6000 ff0e                 bra        _pinode_31
_pinode_29:
[00000446] 2ebc 0002 0132            move.l     #$000228E4,(a7) "\n"
[0000044c] 4eb9 0000 0bca            jsr        _putfmt
[00000452] 4a95                      tst.l      (a5)
[00000454] 66e6                      bne.s      _pinode_32
[00000456] 60d0                      bra.s      _pinode_28

_pnm:
[00000458] 4e56 0000                 link       a6,#0
[0000045c] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00000460] 2a6e 0008                 movea.l    8(a6),a5
[00000464] 287c 0002 019c            movea.l    #$0002294E,a4
_pnm_34:
[0000046a] b9fc 0002 01a4            cmpa.l     #$00022956,a4
[00000470] 6404                      bcc.s      _pnm_33
[00000472] 18dd                      move.b     (a5)+,(a4)+
[00000474] 60f4                      bra.s      _pnm_34
_pnm_33:
[00000476] 4214                      clr.b      (a4)
[00000478] 2e3c 0002 019c            move.l     #$0002294E,d7
[0000047e] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00000482] 4e5e                      unlk       a6
[00000484] 4e75                      rts

_pps:
[00000486] 4e56 ffe2                 link       a6,#-30
[0000048a] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000048e] 4297                      clr.l      (a7)
[00000490] 2f2e 0008                 move.l     8(a6),-(a7)
[00000494] 486e fffc                 pea.l      -4(a6)
[00000498] 4eb9 0000 08ec            jsr        _readfill
[0000049e] 508f                      addq.l     #8,a7
[000004a0] 2847                      movea.l    d7,a4
[000004a2] 2e0c                      move.l     a4,d7
[000004a4] 6608                      bne.s      _pps_1
[000004a6] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000004aa] 4e5e                      unlk       a6
[000004ac] 4e75                      rts
_pps_1:
[000004ae] 4ab9 0002 008e            tst.l      _lflag
[000004b4] 670c                      beq.s      _pps_2
[000004b6] 2ebc 0002 0318            move.l     #$00022ACA,(a7) "  PID STAT NAME     PRI  PPID  PGRP  BASE  SIZE  FLAGS    CHANNEL DEV\n"
[000004bc] 4eb9 0000 0bca            jsr        _putfmt
_pps_2:
[000004c2] 2a4c                      movea.l    a4,a5
_pps_40:
[000004c4] 2e0c                      move.l     a4,d7
[000004c6] deae fffc                 add.l      -4(a6),d7
[000004ca] bbc7                      cmpa.l     d7,a5
[000004cc] 6456                      bcc.s      _pps_3
[000004ce] 426e fffa                 clr.w      -6(a6)
_pps_7:
[000004d2] 3e2e fffa                 move.w     -6(a6),d7
[000004d6] 48c7                      ext.l      d7
[000004d8] 0c47 0008                 cmpi.w     #$0008,d7
[000004dc] 6c5a                      bge.s      _pps_4
[000004de] 45ee ffe3                 lea.l      -29(a6),a2 flagbuf
[000004e2] 3e2e fffa                 move.w     -6(a6),d7
[000004e6] 48c7                      ext.l      d7
[000004e8] d5c7                      adda.l     d7,a2
[000004ea] 2e8a                      move.l     a2,(a7)
[000004ec] 2e3c 0000 0080            move.l     #$00000080,d7
[000004f2] 3c2e fffa                 move.w     -6(a6),d6
[000004f6] 48c6                      ext.l      d6
[000004f8] eca7                      asr.l      d6,d7
[000004fa] 4286                      clr.l      d6
[000004fc] 1c2d 0010                 move.b     16(a5),d6
[00000500] ce86                      and.l      d6,d7
[00000502] 6714                      beq.s      _pps_5
[00000504] 247c 0002 030f            movea.l    #$00022AC1,a2 "WIOALMFX"
[0000050a] 3e2e fffa                 move.w     -6(a6),d7
[0000050e] 48c7                      ext.l      d7
[00000510] d5c7                      adda.l     d7,a2
[00000512] 4287                      clr.l      d7
[00000514] 1e12                      move.b     (a2),d7
[00000516] 6002                      bra.s      _pps_6
_pps_5:
[00000518] 7e20                      moveq.l    #32,d7
_pps_6:
[0000051a] 2257                      movea.l    (a7),a1
[0000051c] 1287                      move.b     d7,(a1)
[0000051e] 526e fffa                 addq.w     #1,-6(a6)
[00000522] 60ae                      bra.s      _pps_7
_pps_3:
[00000524] 4297                      clr.l      (a7)
[00000526] 2f0c                      move.l     a4,-(a7)
[00000528] 4eb9 0000 227a            jsr        $0000227A
[0000052e] 588f                      addq.l     #4,a7
[00000530] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00000534] 4e5e                      unlk       a6
[00000536] 4e75                      rts
_pps_4:
[00000538] 4ab9 0002 009e            tst.l      _tflag
[0000053e] 6720                      beq.s      _pps_8
[00000540] 4287                      clr.l      d7
[00000542] 1e2d 0011                 move.b     17(a5),d7
[00000546] 0c47 0005                 cmpi.w     #$0005,d7
[0000054a] 6614                      bne.s      _pps_8
[0000054c] 4287                      clr.l      d7
[0000054e] 1e2e ffe9                 move.b     -23(a6),d7
[00000552] 0c47 0046                 cmpi.w     #$0046,d7
[00000556] 661e                      bne.s      _pps_9
[00000558] 1d7c 0053 ffe9            move.b     #$53,-23(a6)
[0000055e] 6016                      bra.s      _pps_9
_pps_8:
[00000560] 4aae 000c                 tst.l      12(a6)
[00000564] 6670                      bne.s      _pps_10
[00000566] 4287                      clr.l      d7
[00000568] 1e2d 0011                 move.b     17(a5),d7
[0000056c] 0c47 0005                 cmpi.w     #$0005,d7
[00000570] 6600 0110                 bne        _pps_11
[00000574] 6060                      bra.s      _pps_10
_pps_9:
[00000576] 4878 0008                 pea.l      ($00000008).w
[0000057a] 486e ffe3                 pea.l      -29(a6) flagbuf
[0000057e] 4287                      clr.l      d7
[00000580] 3e2d 000a                 move.w     10(a5),d7
[00000584] 2f07                      move.l     d7,-(a7)
[00000586] 4287                      clr.l      d7
[00000588] 3e2d 0008                 move.w     8(a5),d7
[0000058c] 2f07                      move.l     d7,-(a7)
[0000058e] 486d 0014                 pea.l      20(a5)
[00000592] 4eba fec4                 jsr        _pnm(pc)
[00000596] 588f                      addq.l     #4,a7
[00000598] 2f07                      move.l     d7,-(a7)
[0000059a] 4287                      clr.l      d7
[0000059c] 1e2d 0011                 move.b     17(a5),d7
[000005a0] e587                      asl.l      #2,d7
[000005a2] 2447                      movea.l    d7,a2
[000005a4] d5fc 0002 01a6            adda.l     #stat_names,a2
[000005aa] 2f12                      move.l     (a2),-(a7)
[000005ac] 3e2d 001c                 move.w     28(a5),d7
[000005b0] 48c7                      ext.l      d7
[000005b2] 2f07                      move.l     d7,-(a7)
[000005b4] 4ab9 0002 008e            tst.l      _lflag
[000005ba] 6708                      beq.s      _pps_12
[000005bc] 2e3c 0002 02f2            move.l     #$00022AA4,d7 "%5us %p %- 25p%5us %5us %8b\n"
[000005c2] 6006                      bra.s      _pps_13
_pps_12:
[000005c4] 2e3c 0002 02e6            move.l     #$00022A98,d7 "%5us %p %p\n"
_pps_13:
[000005ca] 2f07                      move.l     d7,-(a7)
[000005cc] 4eb9 0000 0bca            jsr        _putfmt
[000005d2] 4fef 0020                 lea.l      32(a7),a7
_pps_10:
[000005d6] 4287                      clr.l      d7
[000005d8] 1e2d 0011                 move.b     17(a5),d7
[000005dc] 0c47 0005                 cmpi.w     #$0005,d7
[000005e0] 670e                      beq.s      _pps_14
[000005e2] 4aad 0026                 tst.l      38(a5)
[000005e6] 6708                      beq.s      _pps_14
[000005e8] 45ed 0044                 lea.l      68(a5),a2
[000005ec] 2e0a                      move.l     a2,d7
[000005ee] 6002                      bra.s      _pps_15
_pps_14:
[000005f0] 4287                      clr.l      d7
_pps_15:
[000005f2] 2647                      movea.l    d7,a3
_pps_35:
[000005f4] 2e0b                      move.l     a3,d7
[000005f6] 6700 0276                 beq        _pps_16
[000005fa] 4ab9 0002 0096            tst.l      _rflag
[00000600] 6600 027e                 bne        _pps_17
[00000604] 4aae 000c                 tst.l      12(a6)
[00000608] 6600 0276                 bne        _pps_17
[0000060c] 486b 0014                 pea.l      20(a3)
[00000610] 4eba fe46                 jsr        _pnm(pc)
[00000614] 588f                      addq.l     #4,a7
[00000616] 2e87                      move.l     d7,(a7)
[00000618] 3e2b 0012                 move.w     18(a3),d7
[0000061c] 48c7                      ext.l      d7
[0000061e] 2f07                      move.l     d7,-(a7)
[00000620] 2f3c 0002 023d            move.l     #$000229EF,-(a7) "        zombie %i %- 8p"
[00000626] 4eb9 0000 0bca            jsr        _putfmt
[0000062c] 508f                      addq.l     #8,a7
[0000062e] 2eab 000c                 move.l     12(a3),(a7)
[00000632] 2f3c 0002 0234            move.l     #$000229E6,-(a7) " free=%i"
[00000638] 4eb9 0000 0bca            jsr        _putfmt
[0000063e] 588f                      addq.l     #4,a7
[00000640] 3e2b 0010                 move.w     16(a3),d7
[00000644] 48c7                      ext.l      d7
[00000646] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000064c] 6600 0238                 bne        _pps_18
[00000650] 4a6b 0010                 tst.w      16(a3)
[00000654] 6708                      beq.s      _pps_19
[00000656] 2e3c 0002 0217            move.l     #$000229C9,d7 "(failure)"
[0000065c] 6006                      bra.s      _pps_20
_pps_19:
[0000065e] 2e3c 0002 020d            move.l     #$000229BF,d7 "(success)"
_pps_20:
[00000664] 2e87                      move.l     d7,(a7)
[00000666] 3e2b 0010                 move.w     16(a3),d7
[0000066a] 48c7                      ext.l      d7
[0000066c] e087                      asr.l      #8,d7
[0000066e] 2f07                      move.l     d7,-(a7)
[00000670] 2f3c 0002 0221            move.l     #$000229D3,-(a7) " exit status %i %p"
[00000676] 4eb9 0000 0bca            jsr        _putfmt
[0000067c] 508f                      addq.l     #8,a7
[0000067e] 6000 0246                 bra        _pps_21
_pps_11:
[00000682] 4ab9 0002 0096            tst.l      _rflag
[00000688] 670e                      beq.s      _pps_22
[0000068a] 4287                      clr.l      d7
[0000068c] 1e2d 0011                 move.b     17(a5),d7
[00000690] 0c47 0003                 cmpi.w     #$0003,d7
[00000694] 6600 ff40                 bne        _pps_10
_pps_22:
[00000698] 486d 0014                 pea.l      20(a5)
[0000069c] 4eba fdba                 jsr        _pnm(pc)
[000006a0] 588f                      addq.l     #4,a7
[000006a2] 2e87                      move.l     d7,(a7)
[000006a4] 4287                      clr.l      d7
[000006a6] 1e2d 0011                 move.b     17(a5),d7
[000006aa] e587                      asl.l      #2,d7
[000006ac] 2447                      movea.l    d7,a2
[000006ae] d5fc 0002 01a6            adda.l     #stat_names,a2
[000006b4] 2f12                      move.l     (a2),-(a7)
[000006b6] 3e2d 001c                 move.w     28(a5),d7
[000006ba] 48c7                      ext.l      d7
[000006bc] 2f07                      move.l     d7,-(a7)
[000006be] 4ab9 0002 008e            tst.l      _lflag
[000006c4] 6708                      beq.s      _pps_23
[000006c6] 2e3c 0002 02d8            move.l     #$00022A8A,d7 "%5us %p %- 8p"
[000006cc] 6006                      bra.s      _pps_24
_pps_23:
[000006ce] 2e3c 0002 02cd            move.l     #$00022A7F,d7 "%5us %p %p"
_pps_24:
[000006d4] 2f07                      move.l     d7,-(a7)
[000006d6] 4eb9 0000 0bca            jsr        _putfmt
[000006dc] 4fef 000c                 lea.l      12(a7),a7
[000006e0] 4ab9 0002 008e            tst.l      _lflag
[000006e6] 671c                      beq.s      _pps_25
[000006e8] 4a6d 0020                 tst.w      32(a5)
[000006ec] 6678                      bne.s      _pps_26
[000006ee] 4297                      clr.l      (a7)
[000006f0] 2f3c 0002 02c8            move.l     #$00022A7A,-(a7) "none"
[000006f6] 486e ffeb                 pea.l      -21(a6)
[000006fa] 4eb9 0000 1a20            jsr        $00001A20
[00000700] 508f                      addq.l     #8,a7
[00000702] 607a                      bra.s      _pps_27
_pps_25:
[00000704] 2ebc 0002 02a1            move.l     #$00022A53,(a7) "\n"
[0000070a] 4eb9 0000 0bca            jsr        _putfmt
[00000710] 4ab9 0002 0086            tst.l      _fflag
[00000716] 6700 febe                 beq        _pps_10
[0000071a] 4287                      clr.l      d7
[0000071c] 1e2d 0040                 move.b     64(a5),d7
[00000720] 2e87                      move.l     d7,(a7)
[00000722] 4eb9 0000 0abc            jsr        _usernm
[00000728] 2e87                      move.l     d7,(a7)
[0000072a] 2f3c 0002 0290            move.l     #$00022A42,-(a7) "        user=%p "
[00000730] 4eb9 0000 0bca            jsr        _putfmt
[00000736] 588f                      addq.l     #4,a7
[00000738] 2ead 0036                 move.l     54(a5),(a7)
[0000073c] 2f3c 0002 0287            move.l     #$00022A39,-(a7) "free=%i "
[00000742] 4eb9 0000 0bca            jsr        _putfmt
[00000748] 588f                      addq.l     #4,a7
[0000074a] 4287                      clr.l      d7
[0000074c] 1e2d 0011                 move.b     17(a5),d7
[00000750] 0c47 0004                 cmpi.w     #$0004,d7
[00000754] 6776                      beq.s      _pps_28
[00000756] 4287                      clr.l      d7
[00000758] 1e2d 0011                 move.b     17(a5),d7
[0000075c] 0c47 0001                 cmpi.w     #$0001,d7
[00000760] 6600 00a0                 bne        _pps_29
[00000764] 6066                      bra.s      _pps_28
_pps_26:
[00000766] 4878 0001                 pea.l      ($00000001).w
[0000076a] 4287                      clr.l      d7
[0000076c] 3e2d 0020                 move.w     32(a5),d7
[00000770] 2f07                      move.l     d7,-(a7)
[00000772] 486e ffeb                 pea.l      -21(a6)
[00000776] 4eba f94e                 jsr        _devname(pc)
[0000077a] 4fef 000c                 lea.l      12(a7),a7
_pps_27:
[0000077e] 486e ffeb                 pea.l      -21(a6)
[00000782] 2f2d 0004                 move.l     4(a5),-(a7)
[00000786] 4878 0008                 pea.l      ($00000008).w
[0000078a] 486e ffe3                 pea.l      -29(a6) flagbuf
[0000078e] 4287                      clr.l      d7
[00000790] 3e2d 000a                 move.w     10(a5),d7
[00000794] 2f07                      move.l     d7,-(a7)
[00000796] 4287                      clr.l      d7
[00000798] 3e2d 0008                 move.w     8(a5),d7
[0000079c] 2f07                      move.l     d7,-(a7)
[0000079e] 3e2d 001e                 move.w     30(a5),d7
[000007a2] 48c7                      ext.l      d7
[000007a4] 2f07                      move.l     d7,-(a7)
[000007a6] 3e2d 003e                 move.w     62(a5),d7
[000007aa] 48c7                      ext.l      d7
[000007ac] 2f07                      move.l     d7,-(a7)
[000007ae] 1e2d 0012                 move.b     18(a5),d7
[000007b2] 4887                      ext.w      d7
[000007b4] 48c7                      ext.l      d7
[000007b6] 2f07                      move.l     d7,-(a7)
[000007b8] 2f3c 0002 02a3            move.l     #$00022A55,-(a7) " %3i %5us %5us %5us %5us %8b %8hi %p"
[000007be] 4eb9 0000 0bca            jsr        _putfmt
[000007c4] 4fef 0028                 lea.l      40(a7),a7
[000007c8] 6000 ff3a                 bra        _pps_25
_pps_28:
[000007cc] 1e2d 0013                 move.b     19(a5),d7
[000007d0] 4887                      ext.w      d7
[000007d2] 48c7                      ext.l      d7
[000007d4] 2e87                      move.l     d7,(a7)
[000007d6] 2f3c 0002 027c            move.l     #$00022A2E,-(a7) "runpri=%i "
[000007dc] 4eb9 0000 0bca            jsr        _putfmt
[000007e2] 588f                      addq.l     #4,a7
_pps_31:
[000007e4] 4a2d 0041                 tst.b      65(a5)
[000007e8] 6738                      beq.s      _pps_30
[000007ea] 4287                      clr.l      d7
[000007ec] 1e2d 0041                 move.b     65(a5),d7
[000007f0] 2e87                      move.l     d7,(a7)
[000007f2] 2f3c 0002 0269            move.l     #$00022A1B,-(a7) "slice=%i "
[000007f8] 4eb9 0000 0bca            jsr        _putfmt
[000007fe] 588f                      addq.l     #4,a7
[00000800] 6020                      bra.s      _pps_30
_pps_29:
[00000802] 4a2d 0013                 tst.b      19(a5)
[00000806] 67dc                      beq.s      _pps_31
[00000808] 1e2d 0013                 move.b     19(a5),d7
[0000080c] 4887                      ext.w      d7
[0000080e] 48c7                      ext.l      d7
[00000810] 2e87                      move.l     d7,(a7)
[00000812] 2f3c 0002 0273            move.l     #$00022A25,-(a7) "bias=%i "
[00000818] 4eb9 0000 0bca            jsr        _putfmt
[0000081e] 588f                      addq.l     #4,a7
[00000820] 60c2                      bra.s      _pps_31
_pps_30:
[00000822] 4a2d 0042                 tst.b      66(a5)
[00000826] 671e                      beq.s      _pps_32
[00000828] 4287                      clr.l      d7
[0000082a] 1e2d 0042                 move.b     66(a5),d7
[0000082e] 2e87                      move.l     d7,(a7)
[00000830] 4eb9 0000 09c8            jsr        _sigstr
[00000836] 2e87                      move.l     d7,(a7)
[00000838] 2f3c 0002 0261            move.l     #$00022A13,-(a7) "sig=%p "
[0000083e] 4eb9 0000 0bca            jsr        _putfmt
[00000844] 588f                      addq.l     #4,a7
_pps_32:
[00000846] 4aad 0032                 tst.l      50(a5)
[0000084a] 6712                      beq.s      _pps_33
[0000084c] 2ead 0032                 move.l     50(a5),(a7)
[00000850] 2f3c 0002 0257            move.l     #$00022A09,-(a7) "alarm=%i "
[00000856] 4eb9 0000 0bca            jsr        _putfmt
[0000085c] 588f                      addq.l     #4,a7
_pps_33:
[0000085e] 2ebc 0002 0255            move.l     #$00022A07,(a7) "\n"
[00000864] 4eb9 0000 0bca            jsr        _putfmt
[0000086a] 6000 fd6a                 bra        _pps_10
_pps_16:
[0000086e] 4a95                      tst.l      (a5)
[00000870] 6662                      bne.s      _pps_34
[00000872] 6000 fcb0                 bra        _pps_3
_pps_36:
[00000876] d7fc 0000 001c            adda.l     #$0000001C,a3
[0000087c] 6000 fd76                 bra        _pps_35
_pps_17:
[00000880] 4a93                      tst.l      (a3)
[00000882] 66f2                      bne.s      _pps_36
[00000884] 60e8                      bra.s      _pps_16
_pps_18:
[00000886] 3e2b 0010                 move.w     16(a3),d7
[0000088a] 48c7                      ext.l      d7
[0000088c] 0807 0007                 btst       #7,d7
[00000890] 6708                      beq.s      _pps_37
[00000892] 2e3c 0002 01f0            move.l     #$000229A2,d7 " -- core dumped"
[00000898] 6006                      bra.s      _pps_38
_pps_37:
[0000089a] 2e3c 0002 01ef            move.l     #$000229A1,d7 ""
_pps_38:
[000008a0] 2e87                      move.l     d7,(a7)
[000008a2] 7e7f                      moveq.l    #127,d7
[000008a4] 3c2b 0010                 move.w     16(a3),d6
[000008a8] 48c6                      ext.l      d6
[000008aa] ce86                      and.l      d6,d7
[000008ac] 2f07                      move.l     d7,-(a7)
[000008ae] 4eb9 0000 09c8            jsr        _sigstr
[000008b4] 588f                      addq.l     #4,a7
[000008b6] 2f07                      move.l     d7,-(a7)
[000008b8] 2f3c 0002 0200            move.l     #$000229B2,-(a7) " signal %p%p"
[000008be] 4eb9 0000 0bca            jsr        _putfmt
[000008c4] 508f                      addq.l     #8,a7
_pps_21:
[000008c6] 2ebc 0002 01ed            move.l     #$0002299F,(a7) "\n"
[000008cc] 4eb9 0000 0bca            jsr        _putfmt
[000008d2] 60ac                      bra.s      _pps_17
_pps_34:
[000008d4] 2e0b                      move.l     a3,d7
[000008d6] 670a                      beq.s      _pps_39
[000008d8] 45eb 001c                 lea.l      28(a3),a2
[000008dc] 2a4a                      movea.l    a2,a5
[000008de] 6000 fbe4                 bra        _pps_40
_pps_39:
[000008e2] dbfc 0000 0044            adda.l     #$00000044,a5
[000008e8] 6000 fbda                 bra        _pps_40

_readfill:
[000008ec] 4e56 0000                 link       a6,#0
[000008f0] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[000008f4] 4aae 000c                 tst.l      12(a6)
[000008f8] 6736                      beq.s      _readfill_41
[000008fa] 4878 0001                 pea.l      ($00000001).w
[000008fe] 42a7                      clr.l      -(a7)
[00000900] 2f2e 000c                 move.l     12(a6),-(a7)
[00000904] 4eb9 0000 1e5e            jsr        $00001E5E
[0000090a] 4fef 000c                 lea.l      12(a7),a7
[0000090e] 2d47 0010                 move.l     d7,16(a6)
[00000912] 6c1c                      bge.s      _readfill_41
[00000914] 2eae 000c                 move.l     12(a6),(a7)
[00000918] 2f3c 0002 036c            move.l     #$00022B1E,-(a7) "can',$27,'t open: "
[0000091e] 4eb9 0000 18c0            jsr        $000018C0
[00000924] 588f                      addq.l     #4,a7
[00000926] 4287                      clr.l      d7
[00000928] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[0000092c] 4e5e                      unlk       a6
[0000092e] 4e75                      rts
_readfill_41:
[00000930] 3a3c 0200                 move.w     #$0200,d5
[00000934] 48c5                      ext.l      d5
_readfill_46:
[00000936] 4297                      clr.l      (a7)
[00000938] 2f05                      move.l     d5,-(a7)
[0000093a] 4eb9 0000 210a            jsr        $0000210A
[00000940] 588f                      addq.l     #4,a7
[00000942] 2a47                      movea.l    d7,a5
[00000944] 2e85                      move.l     d5,(a7)
[00000946] 2f0d                      move.l     a5,-(a7)
[00000948] 2f2e 0010                 move.l     16(a6),-(a7)
[0000094c] 4eb9 0000 1f7e            jsr        $00001F7E
[00000952] 508f                      addq.l     #8,a7
[00000954] 2807                      move.l     d7,d4
[00000956] 6c24                      bge.s      _readfill_42
[00000958] 2eae 000c                 move.l     12(a6),(a7)
[0000095c] 2f3c 0002 0360            move.l     #$00022B12,-(a7) "
[00000962] 4eb9 0000 18c0            jsr        $000018C0
[00000968] 588f                      addq.l     #4,a7
[0000096a] 4297                      clr.l      (a7)
[0000096c] 2f0d                      move.l     a5,-(a7)
[0000096e] 4eb9 0000 227a            jsr        $0000227A
[00000974] 588f                      addq.l     #4,a7
[00000976] 4284                      clr.l      d4
[00000978] 2a44                      movea.l    d4,a5
[0000097a] 6014                      bra.s      _readfill_43
_readfill_42:
[0000097c] 4297                      clr.l      (a7)
[0000097e] 42a7                      clr.l      -(a7)
[00000980] 2f2e 0010                 move.l     16(a6),-(a7)
[00000984] 4eb9 0000 1d3c            jsr        $00001D3C
[0000098a] 508f                      addq.l     #8,a7
[0000098c] b885                      cmp.l      d5,d4
[0000098e] 6418                      bcc.s      _readfill_44
_readfill_43:
[00000990] 246e 0008                 movea.l    8(a6),a2
[00000994] 2484                      move.l     d4,(a2)
[00000996] 4aae 000c                 tst.l      12(a6)
[0000099a] 6722                      beq.s      _readfill_45
[0000099c] 2eae 0010                 move.l     16(a6),(a7)
[000009a0] 4eb9 0000 2572            jsr        $00002572
[000009a6] 6016                      bra.s      _readfill_45
_readfill_44:
[000009a8] 4297                      clr.l      (a7)
[000009aa] 2f0d                      move.l     a5,-(a7)
[000009ac] 4eb9 0000 227a            jsr        $0000227A
[000009b2] 588f                      addq.l     #4,a7
[000009b4] 0685 0000 0200            addi.l     #$00000200,d5
[000009ba] 6000 ff7a                 bra        _readfill_46
_readfill_45:
[000009be] 2e0d                      move.l     a5,d7
[000009c0] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[000009c4] 4e5e                      unlk       a6
[000009c6] 4e75                      rts

_sigstr:
[000009c8] 4e56 fffc                 link       a6,#-4
[000009cc] 2e2e 0008                 move.l     8(a6),d7
[000009d0] 41f9 0002 038e            lea.l      $00022B40,a0
[000009d6] 4ef9 0000 1902            jmp        a~jtab
case 1:
[000009dc] 2e3c 0002 050e            move.l     #$00022CC0,d7 "hangup"
[000009e2] 4e5e                      unlk       a6
[000009e4] 4e75                      rts
case 2:
[000009e6] 2e3c 0002 0504            move.l     #$00022CB6,d7 "interrupt"
[000009ec] 4e5e                      unlk       a6
[000009ee] 4e75                      rts
case 3:
[000009f0] 2e3c 0002 04ff            move.l     #$00022CB1,d7 "quit"
[000009f6] 4e5e                      unlk       a6
[000009f8] 4e75                      rts
case 4:
[000009fa] 2e3c 0002 04eb            move.l     #$00022C9D,d7 "illegal instruction"
[00000a00] 4e5e                      unlk       a6
[00000a02] 4e75                      rts
case 5:
[00000a04] 2e3c 0002 04e0            move.l     #$00022C92,d7 "trace trap"
[00000a0a] 4e5e                      unlk       a6
[00000a0c] 4e75                      rts
case 6:
[00000a0e] 2e3c 0002 04d4            move.l     #$00022C86,d7 "range error"
[00000a14] 4e5e                      unlk       a6
[00000a16] 4e75                      rts
case 7:
[00000a18] 2e3c 0002 04c7            move.l     #$00022C79,d7 "domain error"
[00000a1e] 4e5e                      unlk       a6
[00000a20] 4e75                      rts
case 8:
[00000a22] 2e3c 0002 04a7            move.l     #$00022C59,d7 "floating point/ aritmetic fault"
[00000a28] 4e5e                      unlk       a6
[00000a2a] 4e75                      rts
case 9:
[00000a2c] 2e3c 0002 04a2            move.l     #$00022C54,d7 "kill"
[00000a32] 4e5e                      unlk       a6
[00000a34] 4e75                      rts
case 10:
[00000a36] 2e3c 0002 0498            move.l     #$00022C4A,d7 "bus error"
[00000a3c] 4e5e                      unlk       a6
[00000a3e] 4e75                      rts
case 11::
[00000a40] 2e3c 0002 0476            move.l     #$00022C28,d7 "segementation (bad address) error"
[00000a46] 4e5e                      unlk       a6
[00000a48] 4e75                      rts
case 12::
[00000a4a] 2e3c 0002 0466            move.l     #$00022C18,d7 "bad system call"
[00000a50] 4e5e                      unlk       a6
[00000a52] 4e75                      rts
case 13::
[00000a54] 2e3c 0002 045a            move.l     #$00022C0C,d7 "broken pipe"
[00000a5a] 4e5e                      unlk       a6
[00000a5c] 4e75                      rts
case 14:
[00000a5e] 2e3c 0002 0454            move.l     #$00022C06,d7 "alarm"
[00000a64] 4e5e                      unlk       a6
[00000a66] 4e75                      rts
case 15:
[00000a68] 2e3c 0002 044a            move.l     #$00022BFC,d7 "terminate"
[00000a6e] 4e5e                      unlk       a6
[00000a70] 4e75                      rts
case 16:
[00000a72] 2e3c 0002 0434            move.l     #$00022BE6,d7 "system call intercept"
[00000a78] 4e5e                      unlk       a6
[00000a7a] 4e75                      rts
case 17:
[00000a7c] 2e3c 0002 0428            move.l     #$00022BDA,d7 "user signal"
[00000a82] 4e5e                      unlk       a6
[00000a84] 4e75                      rts
default:
[00000a86] 2eae 0008                 move.l     8(a6),(a7)
[00000a8a] 2f3c 0002 041e            move.l     #$00022BD0,-(a7) "signal#%i"
[00000a90] 4878 0013                 pea.l      ($00000013).w
[00000a94] 2f3c 0002 037a            move.l     #$00022B2C,-(a7)
[00000a9a] 4eb9 0000 0b92            jsr        _decode
[00000aa0] 4fef 000c                 lea.l      12(a7),a7
[00000aa4] 2447                      movea.l    d7,a2
[00000aa6] d5fc 0002 037a            adda.l     #$00022B2C,a2
[00000aac] 4212                      clr.b      (a2)
[00000aae] 2e3c 0002 037a            move.l     #$00022B2C,d7
[00000ab4] 4e5e                      unlk       a6
[00000ab6] 4e75                      rts

xab8:
[00000ab8] 4e5e                      unlk       a6
[00000aba] 4e75                      rts

_usernm:
[00000abc] 4e56 fffc                 link       a6,#-4
[00000ac0] 48e7 8400                 movem.l    d0/d5,-(a7)
[00000ac4] 2a2e 0008                 move.l     8(a6),d5
[00000ac8] 2e85                      move.l     d5,(a7)
[00000aca] 2f3c 0002 052d            move.l     #$00022CDF,-(a7) "%i"
[00000ad0] 4878 0013                 pea.l      ($00000013).w
[00000ad4] 2f3c 0002 0516            move.l     #$00022CC8,-(a7)
[00000ada] 4eb9 0000 0b92            jsr        _decode
[00000ae0] 4fef 000c                 lea.l      12(a7),a7
[00000ae4] 2447                      movea.l    d7,a2
[00000ae6] d5fc 0002 0516            adda.l     #$00022CC8,a2
[00000aec] 4212                      clr.b      (a2)
[00000aee] 4297                      clr.l      (a7)
[00000af0] 4878 0002                 pea.l      ($00000002).w
[00000af4] 2f3c 0002 0516            move.l     #$00022CC8,-(a7)
[00000afa] 4eb9 0000 105c            jsr        _getpw
[00000b00] 508f                      addq.l     #8,a7
[00000b02] 2d47 fffc                 move.l     d7,-4(a6)
[00000b06] 6740                      beq.s      _usernm_1
[00000b08] 2ebc 0002 052a            move.l     #$00022CDC,(a7) ":\n"
[00000b0e] 2f2e fffc                 move.l     -4(a6),-(a7)
[00000b12] 4eb9 0000 1cfa            jsr        _instr
[00000b18] 588f                      addq.l     #4,a7
[00000b1a] 2a07                      move.l     d7,d5
[00000b1c] 0c85 0000 0013            cmpi.l     #$00000013,d5
[00000b22] 6f04                      ble.s      _usernm_2
[00000b24] 7e13                      moveq.l    #19,d7
[00000b26] 6002                      bra.s      _usernm_3
_usernm_2:
[00000b28] 2e05                      move.l     d5,d7
_usernm_3:
[00000b2a] 2e87                      move.l     d7,(a7)
[00000b2c] 2f2e fffc                 move.l     -4(a6),-(a7)
[00000b30] 2f3c 0002 0516            move.l     #$00022CC8,-(a7)
[00000b36] 4eb9 0000 19f6            jsr        _cpybuf
[00000b3c] 508f                      addq.l     #8,a7
[00000b3e] 2445                      movea.l    d5,a2
[00000b40] d5fc 0002 0516            adda.l     #$00022CC8,a2
[00000b46] 4212                      clr.b      (a2)
_usernm_1:
[00000b48] 2e3c 0002 0516            move.l     #$00022CC8,d7
[00000b4e] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00000b52] 4e5e                      unlk       a6
[00000b54] 4e75                      rts

xb56:
[00000b56] 4e56 0000                 link       a6,#0
[00000b5a] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00000b5e] 2a6e 0008                 movea.l    8(a6),a5
[00000b62] 286e 000c                 movea.l    12(a6),a4
[00000b66] 2a2e 0010                 move.l     16(a6),d5
xb56_2:
[00000b6a] 4a85                      tst.l      d5
[00000b6c] 6f18                      ble.s      xb56_1
[00000b6e] 2e2d 0008                 move.l     8(a5),d7
[00000b72] bead 0004                 cmp.l      4(a5),d7
[00000b76] 640e                      bcc.s      xb56_1
[00000b78] 2455                      movea.l    (a5),a2
[00000b7a] 5295                      addq.l     #1,(a5)
[00000b7c] 149c                      move.b     (a4)+,(a2)
[00000b7e] 52ad 0008                 addq.l     #1,8(a5)
[00000b82] 5385                      subq.l     #1,d5
[00000b84] 60e4                      bra.s      xb56_2
xb56_1:
[00000b86] 2e2e 0010                 move.l     16(a6),d7
[00000b8a] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00000b8e] 4e5e                      unlk       a6
[00000b90] 4e75                      rts

xb92:
[00000b92] 4e56 fff4                 link       a6,#-12
[00000b96] 2d6e 0008 fff4            move.l     8(a6),-12(a6)
[00000b9c] 2d6e 000c fff8            move.l     12(a6),-8(a6)
[00000ba2] 42ae fffc                 clr.l      -4(a6)
[00000ba6] 486e 0014                 pea.l      20(a6)
[00000baa] 2f2e 0010                 move.l     16(a6),-(a7)
[00000bae] 486e fff4                 pea.l      -12(a6)
[00000bb2] 2f3c 0000 0b56            move.l     #$00000B56,-(a7)
[00000bb8] 4eb9 0000 0c64            jsr        $00000C64
[00000bbe] 4fef 0010                 lea.l      16(a7),a7
[00000bc2] 2e2e fffc                 move.l     -4(a6),d7
[00000bc6] 4e5e                      unlk       a6
[00000bc8] 4e75                      rts

xbca:
[00000bca] 4e56 0000                 link       a6,#0
[00000bce] 486e 000c                 pea.l      12(a6)
[00000bd2] 2f2e 0008                 move.l     8(a6),-(a7)
[00000bd6] 2f3c 0002 0640            move.l     #$00022DF2,-(a7)
[00000bdc] 2f3c 0000 1e66            move.l     #$00001E66,-(a7)
[00000be2] 4eb9 0000 0c64            jsr        $00000C64
[00000be8] 4fef 0010                 lea.l      16(a7),a7
[00000bec] 4e5e                      unlk       a6
[00000bee] 4e75                      rts

xbf0:
[00000bf0] 4e56 0000                 link       a6,#0
[00000bf4] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[00000bf8] 2a6e 0008                 movea.l    8(a6),a5
[00000bfc] 286e 000c                 movea.l    12(a6),a4
[00000c00] 266e 0010                 movea.l    16(a6),a3
[00000c04] 4287                      clr.l      d7
[00000c06] 1e15                      move.b     (a5),d7
[00000c08] 0c47 006e                 cmpi.w     #$006E,d7
[00000c0c] 670a                      beq.s      xbf0_1
[00000c0e] 4287                      clr.l      d7
[00000c10] 1e15                      move.b     (a5),d7
[00000c12] 0c47 004e                 cmpi.w     #$004E,d7
[00000c16] 6614                      bne.s      xbf0_2
xbf0_1:
[00000c18] 528d                      addq.l     #1,a5
[00000c1a] 2453                      movea.l    (a3),a2
[00000c1c] 5893                      addq.l     #4,(a3)
[00000c1e] 38aa 0002                 move.w     2(a2),(a4)
xbf0_3:
[00000c22] 2e0d                      move.l     a5,d7
[00000c24] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[00000c28] 4e5e                      unlk       a6
[00000c2a] 4e75                      rts
xbf0_2:
[00000c2c] 4254                      clr.w      (a4)
xbf0_4:
[00000c2e] 4287                      clr.l      d7
[00000c30] 1e15                      move.b     (a5),d7
[00000c32] 0c47 0030                 cmpi.w     #$0030,d7
[00000c36] 65ea                      bcs.s      xbf0_3
[00000c38] 4287                      clr.l      d7
[00000c3a] 1e15                      move.b     (a5),d7
[00000c3c] 0c47 0039                 cmpi.w     #$0039,d7
[00000c40] 62e0                      bhi.s      xbf0_3
[00000c42] 7ed0                      moveq.l    #-48,d7
[00000c44] 3c14                      move.w     (a4),d6
[00000c46] 48c6                      ext.l      d6
[00000c48] 2e86                      move.l     d6,(a7)
[00000c4a] 4878 000a                 pea.l      ($0000000A).w
[00000c4e] 4eb9 0000 25de            jsr        $000025DE
[00000c54] 2c17                      move.l     (a7),d6
[00000c56] 4285                      clr.l      d5
[00000c58] 1a15                      move.b     (a5),d5
[00000c5a] dc85                      add.l      d5,d6
[00000c5c] de86                      add.l      d6,d7
[00000c5e] 3887                      move.w     d7,(a4)
[00000c60] 528d                      addq.l     #1,a5
[00000c62] 60ca                      bra.s      xbf0_4

[00000c64] 4e56 ffd4                 link       a6,#-44
[00000c68] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00000c6c] 2a6e 0010                 movea.l    16(a6),a5
xbf0_7:
[00000c70] 284d                      movea.l    a5,a4
xbf0_6:
[00000c72] 4a14                      tst.b      (a4)
[00000c74] 6716                      beq.s      xbf0_5
[00000c76] 4287                      clr.l      d7
[00000c78] 1e14                      move.b     (a4),d7
[00000c7a] 0c47 0025                 cmpi.w     #$0025,d7
[00000c7e] 670c                      beq.s      xbf0_5
[00000c80] 528c                      addq.l     #1,a4
[00000c82] 60ee                      bra.s      xbf0_6
xbf0_44:
[00000c84] 45ec 0001                 lea.l      1(a4),a2
[00000c88] 2a4a                      movea.l    a2,a5
[00000c8a] 60e4                      bra.s      xbf0_7
xbf0_5:
[00000c8c] bbcc                      cmpa.l     a4,a5
[00000c8e] 6414                      bcc.s      xbf0_8
[00000c90] 2e0c                      move.l     a4,d7
[00000c92] 9e8d                      sub.l      a5,d7
[00000c94] 2e87                      move.l     d7,(a7)
[00000c96] 2f0d                      move.l     a5,-(a7)
[00000c98] 2f2e 000c                 move.l     12(a6),-(a7)
[00000c9c] 246e 0008                 movea.l    8(a6),a2
[00000ca0] 4e92                      jsr        (a2)
[00000ca2] 508f                      addq.l     #8,a7
xbf0_8:
[00000ca4] 4a1c                      tst.b      (a4)+
[00000ca6] 6608                      bne.s      xbf0_9
[00000ca8] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00000cac] 4e5e                      unlk       a6
[00000cae] 4e75                      rts
xbf0_9:
[00000cb0] 7001                      moveq.l    #1,d0
[00000cb2] 2d40 fffc                 move.l     d0,-4(a6)
[00000cb6] 1d7c 0020 ffd9            move.b     #$20,-39(a6)
[00000cbc] 4287                      clr.l      d7
[00000cbe] 1e14                      move.b     (a4),d7
[00000cc0] 0c47 002d                 cmpi.w     #$002D,d7
[00000cc4] 660e                      bne.s      xbf0_10
[00000cc6] 42ae fffc                 clr.l      -4(a6)
[00000cca] 528c                      addq.l     #1,a4
[00000ccc] 1d54 ffd9                 move.b     (a4),-39(a6)
[00000cd0] 528c                      addq.l     #1,a4
[00000cd2] 6012                      bra.s      xbf0_11
xbf0_10:
[00000cd4] 4287                      clr.l      d7
[00000cd6] 1e14                      move.b     (a4),d7
[00000cd8] 0c47 002b                 cmpi.w     #$002B,d7
[00000cdc] 6608                      bne.s      xbf0_11
[00000cde] 528c                      addq.l     #1,a4
[00000ce0] 1d54 ffd9                 move.b     (a4),-39(a6)
[00000ce4] 528c                      addq.l     #1,a4
xbf0_11:
[00000ce6] 486e 0014                 pea.l      20(a6)
[00000cea] 486e fff6                 pea.l      -10(a6)
[00000cee] 2f0c                      move.l     a4,-(a7)
[00000cf0] 4eba fefe                 jsr        $00000BF0(pc)
[00000cf4] 4fef 000c                 lea.l      12(a7),a7
[00000cf8] 2847                      movea.l    d7,a4
[00000cfa] 426e fff8                 clr.w      -8(a6)
[00000cfe] 4287                      clr.l      d7
[00000d00] 1e14                      move.b     (a4),d7
[00000d02] 0c47 002e                 cmpi.w     #$002E,d7
[00000d06] 6616                      bne.s      xbf0_12
[00000d08] 486e 0014                 pea.l      20(a6)
[00000d0c] 486e fff8                 pea.l      -8(a6)
[00000d10] 486c 0001                 pea.l      1(a4)
[00000d14] 4eba feda                 jsr        $00000BF0(pc)
[00000d18] 4fef 000c                 lea.l      12(a7),a7
[00000d1c] 2847                      movea.l    d7,a4
xbf0_12:
[00000d1e] 4287                      clr.l      d7
[00000d20] 1e14                      move.b     (a4),d7
[00000d22] 0c47 0061                 cmpi.w     #$0061,d7
[00000d26] 671e                      beq.s      xbf0_13
[00000d28] 4287                      clr.l      d7
[00000d2a] 1e14                      move.b     (a4),d7
[00000d2c] 0c47 0068                 cmpi.w     #$0068,d7
[00000d30] 6714                      beq.s      xbf0_13
[00000d32] 4287                      clr.l      d7
[00000d34] 1e14                      move.b     (a4),d7
[00000d36] 0c47 006f                 cmpi.w     #$006F,d7
[00000d3a] 670a                      beq.s      xbf0_13
[00000d3c] 4287                      clr.l      d7
[00000d3e] 1e14                      move.b     (a4),d7
[00000d40] 0c47 0075                 cmpi.w     #$0075,d7
[00000d44] 6614                      bne.s      xbf0_14
xbf0_13:
[00000d46] 1d5c ffd8                 move.b     (a4)+,-40(a6)
xbf0_17:
[00000d4a] 4287                      clr.l      d7
[00000d4c] 1e2e ffd8                 move.b     -40(a6),d7
[00000d50] 0c47 0068                 cmpi.w     #$0068,d7
[00000d54] 660a                      bne.s      xbf0_15
[00000d56] 7a10                      moveq.l    #16,d5
[00000d58] 6028                      bra.s      xbf0_16
xbf0_14:
[00000d5a] 422e ffd8                 clr.b      -40(a6)
[00000d5e] 60ea                      bra.s      xbf0_17
xbf0_15:
[00000d60] 4287                      clr.l      d7
[00000d62] 1e2e ffd8                 move.b     -40(a6),d7
[00000d66] 0c47 006f                 cmpi.w     #$006F,d7
[00000d6a] 6604                      bne.s      xbf0_18
[00000d6c] 7a08                      moveq.l    #8,d5
[00000d6e] 6012                      bra.s      xbf0_16
xbf0_18:
[00000d70] 4287                      clr.l      d7
[00000d72] 1e2e ffd8                 move.b     -40(a6),d7
[00000d76] 0c47 0075                 cmpi.w     #$0075,d7
[00000d7a] 6604                      bne.s      xbf0_19
[00000d7c] 7a0a                      moveq.l    #10,d5
[00000d7e] 6002                      bra.s      xbf0_16
xbf0_19:
[00000d80] 7af6                      moveq.l    #-10,d5
xbf0_16:
[00000d82] 4287                      clr.l      d7
[00000d84] 1e14                      move.b     (a4),d7
[00000d86] 0c47 0078                 cmpi.w     #$0078,d7
[00000d8a] 6608                      bne.s      xbf0_20
[00000d8c] 426e fffa                 clr.w      -6(a6)
[00000d90] 6000 01aa                 bra        xbf0_21
xbf0_20:
[00000d94] 4287                      clr.l      d7
[00000d96] 1e14                      move.b     (a4),d7
[00000d98] 0c47 0062                 cmpi.w     #$0062,d7
[00000d9c] 6648                      bne.s      xbf0_22
[00000d9e] 246e 0014                 movea.l    20(a6),a2
[00000da2] 58ae 0014                 addq.l     #4,20(a6)
[00000da6] 2d52 ffd4                 move.l     (a2),-44(a6)
[00000daa] 246e 0014                 movea.l    20(a6),a2
[00000dae] 58ae 0014                 addq.l     #4,20(a6)
[00000db2] 3d6a 0002 fffa            move.w     2(a2),-6(a6)
[00000db8] 4a6e fff8                 tst.w      -8(a6)
[00000dbc] 6700 017e                 beq        xbf0_21
[00000dc0] 3e2e fffa                 move.w     -6(a6),d7
[00000dc4] 48c7                      ext.l      d7
[00000dc6] 3c2e fff8                 move.w     -8(a6),d6
[00000dca] 48c6                      ext.l      d6
[00000dcc] be86                      cmp.l      d6,d7
[00000dce] 6c08                      bge.s      xbf0_23
[00000dd0] 3e2e fffa                 move.w     -6(a6),d7
[00000dd4] 48c7                      ext.l      d7
[00000dd6] 6006                      bra.s      xbf0_24
xbf0_23:
[00000dd8] 3e2e fff8                 move.w     -8(a6),d7
[00000ddc] 48c7                      ext.l      d7
xbf0_24:
[00000dde] 3d47 fffa                 move.w     d7,-6(a6)
[00000de2] 6000 0158                 bra        xbf0_21
xbf0_22:
[00000de6] 4287                      clr.l      d7
[00000de8] 1e14                      move.b     (a4),d7
[00000dea] 0c47 0070                 cmpi.w     #$0070,d7
[00000dee] 6648                      bne.s      xbf0_25
[00000df0] 246e 0014                 movea.l    20(a6),a2
[00000df4] 58ae 0014                 addq.l     #4,20(a6)
[00000df8] 2d52 ffd4                 move.l     (a2),-44(a6)
[00000dfc] 2eae ffd4                 move.l     -44(a6),(a7)
[00000e00] 4eb9 0000 25bc            jsr        $000025BC
[00000e06] 3d47 fffa                 move.w     d7,-6(a6)
[00000e0a] 4a6e fff8                 tst.w      -8(a6)
[00000e0e] 6700 012c                 beq        xbf0_21
[00000e12] 3e2e fffa                 move.w     -6(a6),d7
[00000e16] 48c7                      ext.l      d7
[00000e18] 3c2e fff8                 move.w     -8(a6),d6
[00000e1c] 48c6                      ext.l      d6
[00000e1e] be86                      cmp.l      d6,d7
[00000e20] 6c08                      bge.s      xbf0_26
[00000e22] 3e2e fffa                 move.w     -6(a6),d7
[00000e26] 48c7                      ext.l      d7
[00000e28] 6006                      bra.s      xbf0_27
xbf0_26:
[00000e2a] 3e2e fff8                 move.w     -8(a6),d7
[00000e2e] 48c7                      ext.l      d7
xbf0_27:
[00000e30] 3d47 fffa                 move.w     d7,-6(a6)
[00000e34] 6000 0106                 bra        xbf0_21
xbf0_25:
[00000e38] 4287                      clr.l      d7
[00000e3a] 1e14                      move.b     (a4),d7
[00000e3c] 0c47 0063                 cmpi.w     #$0063,d7
[00000e40] 6724                      beq.s      xbf0_28
[00000e42] 4287                      clr.l      d7
[00000e44] 1e14                      move.b     (a4),d7
[00000e46] 0c47 0073                 cmpi.w     #$0073,d7
[00000e4a] 671a                      beq.s      xbf0_28
[00000e4c] 4287                      clr.l      d7
[00000e4e] 1e14                      move.b     (a4),d7
[00000e50] 0c47 0069                 cmpi.w     #$0069,d7
[00000e54] 6710                      beq.s      xbf0_28
[00000e56] 4287                      clr.l      d7
[00000e58] 1e14                      move.b     (a4),d7
[00000e5a] 0c47 006c                 cmpi.w     #$006C,d7
[00000e5e] 6706                      beq.s      xbf0_28
[00000e60] 4a2e ffd8                 tst.b      -40(a6)
[00000e64] 6720                      beq.s      xbf0_29
xbf0_28:
[00000e66] 4287                      clr.l      d7
[00000e68] 1e14                      move.b     (a4),d7
[00000e6a] 0c47 006c                 cmpi.w     #$006C,d7
[00000e6e] 6724                      beq.s      xbf0_30
[00000e70] 4287                      clr.l      d7
[00000e72] 1e14                      move.b     (a4),d7
[00000e74] 0c47 0063                 cmpi.w     #$0063,d7
[00000e78] 6758                      beq.s      xbf0_31
[00000e7a] 4287                      clr.l      d7
[00000e7c] 1e14                      move.b     (a4),d7
[00000e7e] 0c47 0073                 cmpi.w     #$0073,d7
[00000e82] 674e                      beq.s      xbf0_31
[00000e84] 600e                      bra.s      xbf0_30
xbf0_29:
[00000e86] 2d4c ffd4                 move.l     a4,-44(a6)
[00000e8a] 3d7c 0001 fffa            move.w     #$0001,-6(a6)
[00000e90] 6000 00aa                 bra        xbf0_21
xbf0_30:
[00000e94] 4287                      clr.l      d7
[00000e96] 1e2e ffd8                 move.b     -40(a6),d7
[00000e9a] 0c47 0061                 cmpi.w     #$0061,d7
[00000e9e] 6672                      bne.s      xbf0_32
[00000ea0] 246e 0014                 movea.l    20(a6),a2
[00000ea4] 2d52 fff2                 move.l     (a2),-14(a6)
[00000ea8] 3d7c 0004 fffa            move.w     #$0004,-6(a6)
xbf0_34:
[00000eae] 536e fffa                 subq.w     #1,-6(a6)
[00000eb2] 6d00 00be                 blt        xbf0_33
[00000eb6] 45ee ffda                 lea.l      -38(a6),a2
[00000eba] 3e2e fffa                 move.w     -6(a6),d7
[00000ebe] 48c7                      ext.l      d7
[00000ec0] d5c7                      adda.l     d7,a2
[00000ec2] 14ae fff5                 move.b     -11(a6),(a2)
[00000ec6] 2e2e fff2                 move.l     -14(a6),d7
[00000eca] e087                      asr.l      #8,d7
[00000ecc] 2d47 fff2                 move.l     d7,-14(a6)
[00000ed0] 60dc                      bra.s      xbf0_34
xbf0_31:
[00000ed2] 45ee ffda                 lea.l      -38(a6),a2
[00000ed6] 2d4a ffd4                 move.l     a2,-44(a6)
[00000eda] 246e 0014                 movea.l    20(a6),a2
[00000ede] 58ae 0014                 addq.l     #4,20(a6)
[00000ee2] 3d6a 0002 fffa            move.w     2(a2),-6(a6)
[00000ee8] 4287                      clr.l      d7
[00000eea] 1e2e ffd8                 move.b     -40(a6),d7
[00000eee] 0c47 0061                 cmpi.w     #$0061,d7
[00000ef2] 6600 0098                 bne        xbf0_35
[00000ef6] 4287                      clr.l      d7
[00000ef8] 1e14                      move.b     (a4),d7
[00000efa] 0c47 0063                 cmpi.w     #$0063,d7
[00000efe] 6600 0092                 bne        xbf0_36
[00000f02] 1d6e fffb ffda            move.b     -5(a6),-38(a6)
[00000f08] 3d7c 0001 fffa            move.w     #$0001,-6(a6)
[00000f0e] 6000 00ce                 bra        xbf0_37
xbf0_32:
[00000f12] 45ee ffda                 lea.l      -38(a6),a2
[00000f16] 2d4a ffd4                 move.l     a2,-44(a6)
[00000f1a] 2e85                      move.l     d5,(a7)
[00000f1c] 246e 0014                 movea.l    20(a6),a2
[00000f20] 2f12                      move.l     (a2),-(a7)
[00000f22] 486e ffda                 pea.l      -38(a6)
[00000f26] 4eb9 0000 1db6            jsr        $00001DB6
[00000f2c] 508f                      addq.l     #8,a7
[00000f2e] 3d47 fffa                 move.w     d7,-6(a6)
[00000f32] 2e2e 0014                 move.l     20(a6),d7
[00000f36] 5887                      addq.l     #4,d7
[00000f38] 2d47 0014                 move.l     d7,20(a6)
xbf0_21:
[00000f3c] 4aae fffc                 tst.l      -4(a6)
[00000f40] 6700 00c6                 beq        xbf0_38
xbf0_39:
[00000f44] 3e2e fffa                 move.w     -6(a6),d7
[00000f48] 48c7                      ext.l      d7
[00000f4a] 3c2e fff6                 move.w     -10(a6),d6
[00000f4e] 48c6                      ext.l      d6
[00000f50] be86                      cmp.l      d6,d7
[00000f52] 6c00 00b4                 bge        xbf0_38
[00000f56] 4878 0001                 pea.l      ($00000001).w
[00000f5a] 486e ffd9                 pea.l      -39(a6)
[00000f5e] 2f2e 000c                 move.l     12(a6),-(a7)
[00000f62] 246e 0008                 movea.l    8(a6),a2
[00000f66] 4e92                      jsr        (a2)
[00000f68] 4fef 000c                 lea.l      12(a7),a7
[00000f6c] 536e fff6                 subq.w     #1,-10(a6)
[00000f70] 60d2                      bra.s      xbf0_39
xbf0_33:
[00000f72] 45ee ffda                 lea.l      -38(a6),a2
[00000f76] 2d4a ffd4                 move.l     a2,-44(a6)
[00000f7a] 3d7c 0004 fffa            move.w     #$0004,-6(a6)
[00000f80] 2e2e 0014                 move.l     20(a6),d7
[00000f84] 5887                      addq.l     #4,d7
[00000f86] 2d47 0014                 move.l     d7,20(a6)
[00000f8a] 60b0                      bra.s      xbf0_21
xbf0_35:
[00000f8c] 4a85                      tst.l      d5
[00000f8e] 6c1c                      bge.s      xbf0_40
[00000f90] 6032                      bra.s      xbf0_41
xbf0_36:
[00000f92] 3e2e fffa                 move.w     -6(a6),d7
[00000f96] 48c7                      ext.l      d7
[00000f98] e087                      asr.l      #8,d7
[00000f9a] 1d47 ffda                 move.b     d7,-38(a6)
[00000f9e] 1d6e fffb ffdb            move.b     -5(a6),-37(a6)
[00000fa4] 3d7c 0002 fffa            move.w     #$0002,-6(a6)
[00000faa] 6032                      bra.s      xbf0_37
xbf0_40:
[00000fac] 4287                      clr.l      d7
[00000fae] 1e14                      move.b     (a4),d7
[00000fb0] 0c47 0063                 cmpi.w     #$0063,d7
[00000fb4] 6608                      bne.s      xbf0_42
[00000fb6] 026e 00ff fffa            andi.w     #$00FF,-6(a6)
[00000fbc] 6006                      bra.s      xbf0_41
xbf0_42:
[00000fbe] 026e ffff fffa            andi.w     #$FFFF,-6(a6)
xbf0_41:
[00000fc4] 2e85                      move.l     d5,(a7)
[00000fc6] 3e2e fffa                 move.w     -6(a6),d7
[00000fca] 48c7                      ext.l      d7
[00000fcc] 2f07                      move.l     d7,-(a7)
[00000fce] 486e ffda                 pea.l      -38(a6)
[00000fd2] 4eb9 0000 1fc4            jsr        $00001FC4
[00000fd8] 508f                      addq.l     #8,a7
[00000fda] 3d47 fffa                 move.w     d7,-6(a6)
xbf0_37:
[00000fde] 4287                      clr.l      d7
[00000fe0] 1e14                      move.b     (a4),d7
[00000fe2] 0c47 0063                 cmpi.w     #$0063,d7
[00000fe6] 6700 ff54                 beq        xbf0_21
[00000fea] 4287                      clr.l      d7
[00000fec] 1e14                      move.b     (a4),d7
[00000fee] 0c47 0073                 cmpi.w     #$0073,d7
[00000ff2] 6700 ff48                 beq        xbf0_21
[00000ff6] 4287                      clr.l      d7
[00000ff8] 1e14                      move.b     (a4),d7
[00000ffa] 0c47 0069                 cmpi.w     #$0069,d7
[00000ffe] 6700 ff3c                 beq        xbf0_21
[00001002] 538c                      subq.l     #1,a4
[00001004] 6000 ff36                 bra        xbf0_21
xbf0_38:
[00001008] 4a6e fffa                 tst.w      -6(a6)
[0000100c] 6f18                      ble.s      xbf0_43
[0000100e] 3e2e fffa                 move.w     -6(a6),d7
[00001012] 48c7                      ext.l      d7
[00001014] 2e87                      move.l     d7,(a7)
[00001016] 2f2e ffd4                 move.l     -44(a6),-(a7)
[0000101a] 2f2e 000c                 move.l     12(a6),-(a7)
[0000101e] 246e 0008                 movea.l    8(a6),a2
[00001022] 4e92                      jsr        (a2)
[00001024] 508f                      addq.l     #8,a7
xbf0_43:
[00001026] 4aae fffc                 tst.l      -4(a6)
[0000102a] 6600 fc58                 bne        xbf0_44
xbf0_45:
[0000102e] 3e2e fffa                 move.w     -6(a6),d7
[00001032] 48c7                      ext.l      d7
[00001034] 3c2e fff6                 move.w     -10(a6),d6
[00001038] 48c6                      ext.l      d6
[0000103a] be86                      cmp.l      d6,d7
[0000103c] 6c00 fc46                 bge        xbf0_44
[00001040] 4878 0001                 pea.l      ($00000001).w
[00001044] 486e ffd9                 pea.l      -39(a6)
[00001048] 2f2e 000c                 move.l     12(a6),-(a7)
[0000104c] 246e 0008                 movea.l    8(a6),a2
[00001050] 4e92                      jsr        (a2)
[00001052] 4fef 000c                 lea.l      12(a7),a7
[00001056] 536e fff6                 subq.w     #1,-10(a6)
[0000105a] 60d2                      bra.s      xbf0_45

_getpw:
[0000105c] 4e56 fffc                 link       a6,#-4
[00001060] 2eae 0010                 move.l     16(a6),(a7)
[00001064] 2f2e 000c                 move.l     12(a6),-(a7)
[00001068] 2f2e 0008                 move.l     8(a6),-(a7)
[0000106c] 4eb9 0000 10ca            jsr        $000010CA
[00001072] 508f                      addq.l     #8,a7
[00001074] 4e5e                      unlk       a6
[00001076] 4e75                      rts

x1078:
[00001078] 4e56 fffc                 link       a6,#-4
[0000107c] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00001080] 2a6e 0008                 movea.l    8(a6),a5
[00001084] 2a2e 000c                 move.l     12(a6),d5
x1078_2:
[00001088] 2e05                      move.l     d5,d7
[0000108a] 5385                      subq.l     #1,d5
[0000108c] 4a87                      tst.l      d7
[0000108e] 6730                      beq.s      x1078_1
[00001090] 4287                      clr.l      d7
[00001092] 1e15                      move.b     (a5),d7
[00001094] 0c47 000a                 cmpi.w     #$000A,d7
[00001098] 6726                      beq.s      x1078_1
[0000109a] 2ebc 0002 0530            move.l     #$00022CE2,(a7)
[000010a0] 2f0d                      move.l     a5,-(a7)
[000010a2] 4eb9 0000 1cfa            jsr        _instr
[000010a8] 588f                      addq.l     #4,a7
[000010aa] 2d47 fffc                 move.l     d7,-4(a6)
[000010ae] dbee fffc                 adda.l     -4(a6),a5
[000010b2] 4287                      clr.l      d7
[000010b4] 1e15                      move.b     (a5),d7
[000010b6] 0c47 003a                 cmpi.w     #$003A,d7
[000010ba] 66cc                      bne.s      x1078_2
[000010bc] 528d                      addq.l     #1,a5
[000010be] 60c8                      bra.s      x1078_2
x1078_1:
[000010c0] 2e0d                      move.l     a5,d7
[000010c2] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[000010c6] 4e5e                      unlk       a6
[000010c8] 4e75                      rts

x10ca:
[000010ca] 4e56 fdf2                 link       a6,#-526
[000010ce] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000010d2] 2eae 0008                 move.l     8(a6),(a7)
[000010d6] 4eb9 0000 25bc            jsr        $000025BC
[000010dc] 2d47 fffc                 move.l     d7,-4(a6)
[000010e0] 4a39 0002 0534            tst.b      $00022CE6
[000010e6] 6760                      beq.s      x10ca_1
[000010e8] 2e2e 000c                 move.l     12(a6),d7
[000010ec] 4286                      clr.l      d6
[000010ee] 1c39 0002 05b4            move.b     $00022D66,d6
[000010f4] be86                      cmp.l      d6,d7
[000010f6] 6650                      bne.s      x10ca_1
[000010f8] 2eae fffc                 move.l     -4(a6),(a7)
[000010fc] 2f2e 000c                 move.l     12(a6),-(a7)
[00001100] 2f3c 0002 0534            move.l     #$00022CE6,-(a7)
[00001106] 4eba ff70                 jsr        $00001078(pc)
[0000110a] 508f                      addq.l     #8,a7
[0000110c] 2847                      movea.l    d7,a4
[0000110e] 2f0c                      move.l     a4,-(a7)
[00001110] 2f2e 0008                 move.l     8(a6),-(a7)
[00001114] 4eb9 0000 198a            jsr        $0000198A
[0000111a] 508f                      addq.l     #8,a7
[0000111c] 4a87                      tst.l      d7
[0000111e] 6728                      beq.s      x10ca_1
[00001120] 2ebc 0002 05df            move.l     #$00022D91,(a7)
[00001126] 2f0c                      move.l     a4,-(a7)
[00001128] 4eb9 0000 1cfa            jsr        _instr
[0000112e] 588f                      addq.l     #4,a7
[00001130] beae fffc                 cmp.l      -4(a6),d7
[00001134] 6612                      bne.s      x10ca_1
[00001136] 2eae 0010                 move.l     16(a6),(a7)
[0000113a] 2f3c 0002 0534            move.l     #$00022CE6,-(a7)
[00001140] 4eba ff36                 jsr        $00001078(pc)
[00001144] 588f                      addq.l     #4,a7
[00001146] 601a                      bra.s      x10ca_2
x10ca_1:
[00001148] 4297                      clr.l      (a7)
[0000114a] 2f3c 0002 05d3            move.l     #$00022D85,-(a7)
[00001150] 486e fdf2                 pea.l      -526(a6)
[00001154] 4eb9 0000 12d0            jsr        $000012D0
[0000115a] 508f                      addq.l     #8,a7
[0000115c] 4a87                      tst.l      d7
[0000115e] 660a                      bne.s      x10ca_3
[00001160] 4287                      clr.l      d7
x10ca_2:
[00001162] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00001166] 4e5e                      unlk       a6
[00001168] 4e75                      rts
x10ca_3:
[0000116a] 9bcd                      suba.l     a5,a5
x10ca_5:
[0000116c] 2ebc 0000 0080            move.l     #$00000080,(a7)
[00001172] 2f3c 0002 0534            move.l     #$00022CE6,-(a7)
[00001178] 486e fdf2                 pea.l      -526(a6)
[0000117c] 4eb9 0000 1c42            jsr        $00001C42
[00001182] 508f                      addq.l     #8,a7
[00001184] 2a07                      move.l     d7,d5
[00001186] 6758                      beq.s      x10ca_4
[00001188] 0c85 0000 0080            cmpi.l     #$00000080,d5
[0000118e] 6450                      bcc.s      x10ca_4
[00001190] 2eae fffc                 move.l     -4(a6),(a7)
[00001194] 2f2e 000c                 move.l     12(a6),-(a7)
[00001198] 2f3c 0002 0534            move.l     #$00022CE6,-(a7)
[0000119e] 4eba fed8                 jsr        $00001078(pc)
[000011a2] 508f                      addq.l     #8,a7
[000011a4] 2847                      movea.l    d7,a4
[000011a6] 2f0c                      move.l     a4,-(a7)
[000011a8] 2f2e 0008                 move.l     8(a6),-(a7)
[000011ac] 4eb9 0000 198a            jsr        $0000198A
[000011b2] 508f                      addq.l     #8,a7
[000011b4] 4a87                      tst.l      d7
[000011b6] 67b4                      beq.s      x10ca_5
[000011b8] 2ebc 0002 05d0            move.l     #$00022D82,(a7)
[000011be] 2f0c                      move.l     a4,-(a7)
[000011c0] 4eb9 0000 1cfa            jsr        _instr
[000011c6] 588f                      addq.l     #4,a7
[000011c8] beae fffc                 cmp.l      -4(a6),d7
[000011cc] 669e                      bne.s      x10ca_5
[000011ce] 2eae 0010                 move.l     16(a6),(a7)
[000011d2] 2f3c 0002 0534            move.l     #$00022CE6,-(a7)
[000011d8] 4eba fe9e                 jsr        $00001078(pc)
[000011dc] 588f                      addq.l     #4,a7
[000011de] 2a47                      movea.l    d7,a5
x10ca_4:
[000011e0] 0c85 0000 0080            cmpi.l     #$00000080,d5
[000011e6] 6614                      bne.s      x10ca_6
[000011e8] 4297                      clr.l      (a7)
[000011ea] 2f3c 0002 05b5            move.l     #$00022D67,-(a7)
[000011f0] 4878 0002                 pea.l      ($00000002).w
[000011f4] 4eb9 0000 1f48            jsr        $00001F48
[000011fa] 508f                      addq.l     #8,a7
x10ca_6:
[000011fc] 486e fdf2                 pea.l      -526(a6)
[00001200] 4eb9 0000 1222            jsr        $00001222
[00001206] 588f                      addq.l     #4,a7
[00001208] 2e0d                      move.l     a5,d7
[0000120a] 6706                      beq.s      x10ca_7
[0000120c] 2e2e 000c                 move.l     12(a6),d7
[00001210] 6002                      bra.s      x10ca_8
x10ca_7:
[00001212] 7eff                      moveq.l    #-1,d7
x10ca_8:
[00001214] 2d47 000c                 move.l     d7,12(a6)
[00001218] 2e0d                      move.l     a5,d7
[0000121a] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000121e] 4e5e                      unlk       a6
[00001220] 4e75                      rts

x1222:
[00001222] 4e56 0000                 link       a6,#0
[00001226] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000122a] 2a6e 0008                 movea.l    8(a6),a5
[0000122e] 2e0d                      move.l     a5,d7
[00001230] 6610                      bne.s      x1222_1
[00001232] 2ebc 0002 0898            move.l     #$0002304A,(a7)
[00001238] 42a7                      clr.l      -(a7)
[0000123a] 4eb9 0000 260a            jsr        $0000260A
[00001240] 588f                      addq.l     #4,a7
x1222_1:
[00001242] 267c 0002 0862            movea.l    #$00023014,a3
x1222_6:
[00001248] 2853                      movea.l    (a3),a4
[0000124a] 2e0c                      move.l     a4,d7
[0000124c] 6708                      beq.s      x1222_2
[0000124e] b9cd                      cmpa.l     a5,a4
[00001250] 661e                      bne.s      x1222_3
[00001252] 26ac 0006                 move.l     6(a4),(a3)
x1222_2:
[00001256] 3e2d 0004                 move.w     4(a5),d7
[0000125a] 48c7                      ext.l      d7
[0000125c] 0c47 0001                 cmpi.w     #$0001,d7
[00001260] 6716                      beq.s      x1222_4
[00001262] 3e2d 0004                 move.w     4(a5),d7
[00001266] 48c7                      ext.l      d7
[00001268] 0c47 ffff                 cmpi.w     #$FFFF,d7
[0000126c] 6644                      bne.s      x1222_5
[0000126e] 6008                      bra.s      x1222_4
x1222_3:
[00001270] 45ec 0006                 lea.l      6(a4),a2
[00001274] 264a                      movea.l    a2,a3
[00001276] 60d0                      bra.s      x1222_6
x1222_4:
[00001278] 4a6d 0002                 tst.w      2(a5)
[0000127c] 6734                      beq.s      x1222_5
[0000127e] 3e2d 0002                 move.w     2(a5),d7
[00001282] 48c7                      ext.l      d7
[00001284] 2e87                      move.l     d7,(a7)
[00001286] 486d 000a                 pea.l      10(a5)
[0000128a] 3e15                      move.w     (a5),d7
[0000128c] 48c7                      ext.l      d7
[0000128e] 2f07                      move.l     d7,-(a7)
[00001290] 4eb9 0000 27aa            jsr        $000027AA
[00001296] 508f                      addq.l     #8,a7
[00001298] 3c2d 0002                 move.w     2(a5),d6
[0000129c] 48c6                      ext.l      d6
[0000129e] be86                      cmp.l      d6,d7
[000012a0] 6710                      beq.s      x1222_5
[000012a2] 2ebc 0002 08e0            move.l     #$00023092,(a7)
[000012a8] 42a7                      clr.l      -(a7)
[000012aa] 4eb9 0000 260a            jsr        $0000260A
[000012b0] 588f                      addq.l     #4,a7
x1222_5:
[000012b2] 3e15                      move.w     (a5),d7
[000012b4] 48c7                      ext.l      d7
[000012b6] 2e87                      move.l     d7,(a7)
[000012b8] 4eb9 0000 2572            jsr        $00002572
[000012be] 4a87                      tst.l      d7
[000012c0] 6d04                      blt.s      x1222_7
[000012c2] 2e0d                      move.l     a5,d7
[000012c4] 6002                      bra.s      x1222_8
x1222_7:
[000012c6] 4287                      clr.l      d7
x1222_8:
[000012c8] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000012cc] 4e5e                      unlk       a6
[000012ce] 4e75                      rts

x12d0:
[000012d0] 4e56 0000                 link       a6,#0
[000012d4] 48e7 8400                 movem.l    d0/d5,-(a7)
[000012d8] 4297                      clr.l      (a7)
[000012da] 0cae ffff ffff 0010       cmpi.l     #$FFFFFFFF,16(a6)
[000012e2] 6604                      bne.s      x12d0_1
[000012e4] 7e01                      moveq.l    #1,d7
[000012e6] 6004                      bra.s      x12d0_2
x12d0_1:
[000012e8] 2e2e 0010                 move.l     16(a6),d7
x12d0_2:
[000012ec] 2f07                      move.l     d7,-(a7)
[000012ee] 2f2e 000c                 move.l     12(a6),-(a7)
[000012f2] 4eb9 0000 1e5e            jsr        $00001E5E
[000012f8] 508f                      addq.l     #8,a7
[000012fa] 2a07                      move.l     d7,d5
[000012fc] 6d14                      blt.s      x12d0_3
[000012fe] 2eae 0010                 move.l     16(a6),(a7)
[00001302] 2f05                      move.l     d5,-(a7)
[00001304] 2f2e 0008                 move.l     8(a6),-(a7)
[00001308] 4eb9 0000 1baa            jsr        $00001BAA
[0000130e] 508f                      addq.l     #8,a7
[00001310] 6002                      bra.s      x12d0_4
x12d0_3:
[00001312] 4287                      clr.l      d7
x12d0_4:
[00001314] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00001318] 4e5e                      unlk       a6
[0000131a] 4e75                      rts

x131c:
[0000131c] 4e56 0000                 link       a6,#0
[00001320] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00001324] 2a6e 0008                 movea.l    8(a6),a5
[00001328] 2e8d                      move.l     a5,(a7)
[0000132a] 4eb9 0000 25bc            jsr        $000025BC
[00001330] 2a07                      move.l     d7,d5
[00001332] 2879 0002 0072            movea.l    $00022824,a4
x131c_4:
[00001338] 2e0c                      move.l     a4,d7
[0000133a] 672e                      beq.s      x131c_1
[0000133c] 4a94                      tst.l      (a4)
[0000133e] 672a                      beq.s      x131c_1
[00001340] 2e85                      move.l     d5,(a7)
[00001342] 2f14                      move.l     (a4),-(a7)
[00001344] 2f0d                      move.l     a5,-(a7)
[00001346] 4eb9 0000 198a            jsr        $0000198A
[0000134c] 508f                      addq.l     #8,a7
[0000134e] 4a87                      tst.l      d7
[00001350] 6722                      beq.s      x131c_2
[00001352] 2454                      movea.l    (a4),a2
[00001354] d5c5                      adda.l     d5,a2
[00001356] 4287                      clr.l      d7
[00001358] 1e12                      move.b     (a2),d7
[0000135a] 0c47 003d                 cmpi.w     #$003D,d7
[0000135e] 6614                      bne.s      x131c_2
[00001360] 2e14                      move.l     (a4),d7
[00001362] 2445                      movea.l    d5,a2
[00001364] 528a                      addq.l     #1,a2
[00001366] de8a                      add.l      a2,d7
[00001368] 6002                      bra.s      x131c_3
x131c_1:
[0000136a] 4287                      clr.l      d7
x131c_3:
[0000136c] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00001370] 4e5e                      unlk       a6
[00001372] 4e75                      rts
x131c_2:
[00001374] 588c                      addq.l     #4,a4
[00001376] 60c0                      bra.s      x131c_4

[00001378] 4e56 0000                 link       a6,#0
[0000137c] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00001380] 2a6e 0008                 movea.l    8(a6),a5
[00001384] 286e 000c                 movea.l    12(a6),a4
[00001388] 4297                      clr.l      (a7)
[0000138a] 4eb9 0000 1914            jsr        _usage
[00001390] 2a07                      move.l     d7,d5
x131c_11:
[00001392] 4a15                      tst.b      (a5)
[00001394] 6720                      beq.s      x131c_5
[00001396] 4287                      clr.l      d7
[00001398] 1e15                      move.b     (a5),d7
[0000139a] 0c47 0046                 cmpi.w     #$0046,d7
[0000139e] 673e                      beq.s      x131c_6
[000013a0] 2e85                      move.l     d5,(a7)
[000013a2] 2f0d                      move.l     a5,-(a7)
[000013a4] 4878 0002                 pea.l      ($00000002).w
[000013a8] 4eb9 0000 1856            jsr        $00001856
[000013ae] 508f                      addq.l     #8,a7
[000013b0] 2a07                      move.l     d7,d5
[000013b2] 6000 0098                 bra        x131c_7
x131c_5:
[000013b6] 4878 0001                 pea.l      ($00000001).w
[000013ba] 2f3c 0002 05e2            move.l     #$00022D94,-(a7)
[000013c0] 4878 0002                 pea.l      ($00000002).w
[000013c4] 4eb9 0000 27aa            jsr        $000027AA
[000013ca] 4fef 000c                 lea.l      12(a7),a7
[000013ce] 4297                      clr.l      (a7)
[000013d0] 4eb9 0000 0080            jsr        $00000080
[000013d6] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000013da] 4e5e                      unlk       a6
[000013dc] 4e75                      rts
x131c_6:
[000013de] 4878 0002                 pea.l      ($00000002).w
[000013e2] 2f3c 0002 05ec            move.l     #$00022D9E,-(a7)
[000013e8] 4878 0002                 pea.l      ($00000002).w
[000013ec] 4eb9 0000 27aa            jsr        $000027AA
[000013f2] 4fef 000c                 lea.l      12(a7),a7
[000013f6] da87                      add.l      d7,d5
x131c_13:
[000013f8] 4287                      clr.l      d7
[000013fa] 1e14                      move.b     (a4),d7
[000013fc] 0c47 003a                 cmpi.w     #$003A,d7
[00001400] 6730                      beq.s      x131c_8
[00001402] 4287                      clr.l      d7
[00001404] 1e14                      move.b     (a4),d7
[00001406] 0c47 002c                 cmpi.w     #$002C,d7
[0000140a] 6646                      bne.s      x131c_9
[0000140c] 4287                      clr.l      d7
[0000140e] 1e2c 0001                 move.b     1(a4),d7
[00001412] 0c47 003a                 cmpi.w     #$003A,d7
[00001416] 673a                      beq.s      x131c_9
[00001418] 2e85                      move.l     d5,(a7)
[0000141a] 2f3c 0002 05ea            move.l     #$00022D9C,-(a7)
[00001420] 4878 0002                 pea.l      ($00000002).w
[00001424] 4eb9 0000 1856            jsr        $00001856
[0000142a] 508f                      addq.l     #8,a7
[0000142c] 2a07                      move.l     d7,d5
[0000142e] 6000 0080                 bra        x131c_10 ; possibly optimized to short
x131c_8:
[00001432] 4878 0001                 pea.l      ($00000001).w
[00001436] 2f3c 0002 05e4            move.l     #$00022D96,-(a7)
[0000143c] 4878 0002                 pea.l      ($00000002).w
[00001440] 4eb9 0000 27aa            jsr        $000027AA
[00001446] 4fef 000c                 lea.l      12(a7),a7
[0000144a] da87                      add.l      d7,d5
x131c_7:
[0000144c] 528d                      addq.l     #1,a5
[0000144e] 6000 ff42                 bra        x131c_11
x131c_9:
[00001452] 4287                      clr.l      d7
[00001454] 1e14                      move.b     (a4),d7
[00001456] 0c47 003e                 cmpi.w     #$003E,d7
[0000145a] 663e                      bne.s      x131c_12
[0000145c] 4878 0001                 pea.l      ($00000001).w
[00001460] 2f3c 0002 05e8            move.l     #$00022D9A,-(a7)
[00001466] 4878 0002                 pea.l      ($00000002).w
[0000146a] 4eb9 0000 27aa            jsr        $000027AA
[00001470] 4fef 000c                 lea.l      12(a7),a7
[00001474] da87                      add.l      d7,d5
[00001476] 4287                      clr.l      d7
[00001478] 1e2c 0001                 move.b     1(a4),d7
[0000147c] 0c47 003a                 cmpi.w     #$003A,d7
[00001480] 672e                      beq.s      x131c_10
[00001482] 2e85                      move.l     d5,(a7)
[00001484] 2f3c 0002 05e6            move.l     #$00022D98,-(a7)
[0000148a] 4878 0002                 pea.l      ($00000002).w
[0000148e] 4eb9 0000 1856            jsr        $00001856
[00001494] 508f                      addq.l     #8,a7
[00001496] 2a07                      move.l     d7,d5
[00001498] 6016                      bra.s      x131c_10
x131c_12:
[0000149a] 4878 0001                 pea.l      ($00000001).w
[0000149e] 2f0c                      move.l     a4,-(a7)
[000014a0] 4878 0002                 pea.l      ($00000002).w
[000014a4] 4eb9 0000 27aa            jsr        $000027AA
[000014aa] 4fef 000c                 lea.l      12(a7),a7
[000014ae] da87                      add.l      d7,d5
x131c_10:
[000014b0] 528c                      addq.l     #1,a4
[000014b2] 6000 ff44                 bra        x131c_13

_getflags:
[000014b6] 4e56 ffe2                 link       a6,#-30
[000014ba] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[000014be] 246e 000c                 movea.l    12(a6),a2
[000014c2] 5892                      addq.l     #4,(a2)
x131c_16:
[000014c4] 246e 0008                 movea.l    8(a6),a2
[000014c8] 4a92                      tst.l      (a2)
[000014ca] 6730                      beq.s      x131c_14
[000014cc] 246e 0008                 movea.l    8(a6),a2
[000014d0] 5392                      subq.l     #1,(a2)
[000014d2] 6728                      beq.s      x131c_14
[000014d4] 246e 000c                 movea.l    12(a6),a2
[000014d8] 2452                      movea.l    (a2),a2
[000014da] 2852                      movea.l    (a2),a4
[000014dc] 2ebc 0002 0637            move.l     #$00022DE9,(a7)
[000014e2] 2f0c                      move.l     a4,-(a7)
[000014e4] 4eb9 0000 19c0            jsr        $000019C0
[000014ea] 588f                      addq.l     #4,a7
[000014ec] 4a87                      tst.l      d7
[000014ee] 671e                      beq.s      x131c_15
[000014f0] 246e 0008                 movea.l    8(a6),a2
[000014f4] 5392                      subq.l     #1,(a2)
[000014f6] 246e 000c                 movea.l    12(a6),a2
[000014fa] 5892                      addq.l     #4,(a2)
x131c_14:
[000014fc] 4287                      clr.l      d7
[000014fe] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00001502] 4e5e                      unlk       a6
[00001504] 4e75                      rts
x131c_22:
[00001506] 246e 000c                 movea.l    12(a6),a2
[0000150a] 5892                      addq.l     #4,(a2)
[0000150c] 60b6                      bra.s      x131c_16
x131c_15:
[0000150e] 2ebc 0002 0635            move.l     #$00022DE7,(a7)
[00001514] 2f0c                      move.l     a4,-(a7)
[00001516] 4eb9 0000 19c0            jsr        $000019C0
[0000151c] 588f                      addq.l     #4,a7
[0000151e] 4a87                      tst.l      d7
[00001520] 66da                      bne.s      x131c_14
[00001522] 4287                      clr.l      d7
[00001524] 1e14                      move.b     (a4),d7
[00001526] 0c47 002d                 cmpi.w     #$002D,d7
[0000152a] 670a                      beq.s      x131c_17
[0000152c] 4287                      clr.l      d7
[0000152e] 1e14                      move.b     (a4),d7
[00001530] 0c47 002b                 cmpi.w     #$002B,d7
[00001534] 66c6                      bne.s      x131c_14
x131c_17:
[00001536] 4287                      clr.l      d7
[00001538] 1e14                      move.b     (a4),d7
[0000153a] 0c47 002d                 cmpi.w     #$002D,d7
[0000153e] 6602                      bne.s      x131c_18
[00001540] 528c                      addq.l     #1,a4
x131c_18:
[00001542] 4878 0004                 pea.l      ($00000004).w
[00001546] 2f0c                      move.l     a4,-(a7)
[00001548] 2f3c 0002 0630            move.l     #$00022DE2,-(a7)
[0000154e] 4eb9 0000 198a            jsr        $0000198A
[00001554] 4fef 000c                 lea.l      12(a7),a7
[00001558] 4a87                      tst.l      d7
[0000155a] 6736                      beq.s      x131c_19
[0000155c] 2eae 0010                 move.l     16(a6),(a7)
[00001560] 4287                      clr.l      d7
[00001562] 1e2c 0004                 move.b     4(a4),d7
[00001566] 0c47 003a                 cmpi.w     #$003A,d7
[0000156a] 6716                      beq.s      x131c_20
[0000156c] 4878 003a                 pea.l      ($0000003A).w
[00001570] 2f2e 0010                 move.l     16(a6),-(a7)
[00001574] 4eb9 0000 1f86            jsr        $00001F86
[0000157a] 508f                      addq.l     #8,a7
[0000157c] deae 0010                 add.l      16(a6),d7
[00001580] 6006                      bra.s      x131c_21
x131c_20:
[00001582] 2e3c 0002 0000            move.l     #$000227B2,d7
x131c_21:
[00001588] 2f07                      move.l     d7,-(a7)
[0000158a] 5297                      addq.l     #1,(a7)
[0000158c] 4eba fdea                 jsr        $00001378(pc)
[00001590] 588f                      addq.l     #4,a7
x131c_19:
[00001592] 4a14                      tst.b      (a4)
[00001594] 6700 ff70                 beq        x131c_22
[00001598] 42ae fff4                 clr.l      -12(a6)
[0000159c] 42ae fff8                 clr.l      -8(a6)
[000015a0] 45ee 0014                 lea.l      20(a6),a2
[000015a4] 2d4a ffea                 move.l     a2,-22(a6)
[000015a8] 264c                      movea.l    a4,a3
[000015aa] 2a6e 0010                 movea.l    16(a6),a5
[000015ae] 42ae fffc                 clr.l      -4(a6)
x131c_30:
[000015b2] 4aae fffc                 tst.l      -4(a6)
[000015b6] 66da                      bne.s      x131c_19
[000015b8] 4287                      clr.l      d7
[000015ba] 1e15                      move.b     (a5),d7
[000015bc] 41f9 0002 05f0            lea.l      $00022DA2,a0
[000015c2] 4ef9 0000 1902            jmp        a~jtab
[000015c8] 7001                      moveq.l    #1,d0
[000015ca] 2d40 fff4                 move.l     d0,-12(a6)
[000015ce] 4a13                      tst.b      (a3)
[000015d0] 6704                      beq.s      x131c_23
[000015d2] 2e0b                      move.l     a3,d7
[000015d4] 6016                      bra.s      x131c_24
x131c_23:
[000015d6] 246e 0008                 movea.l    8(a6),a2
[000015da] 5392                      subq.l     #1,(a2)
[000015dc] 670c                      beq.s      x131c_25
[000015de] 246e 000c                 movea.l    12(a6),a2
[000015e2] 5892                      addq.l     #4,(a2)
[000015e4] 2452                      movea.l    (a2),a2
[000015e6] 2e12                      move.l     (a2),d7
[000015e8] 6002                      bra.s      x131c_24
x131c_25:
[000015ea] 2e0b                      move.l     a3,d7
x131c_24:
[000015ec] 2d47 ffe2                 move.l     d7,-30(a6)
[000015f0] 266e ffe2                 movea.l    -30(a6),a3
[000015f4] 2d4b ffe6                 move.l     a3,-26(a6)
x131c_29:
[000015f8] 246e ffe6                 movea.l    -26(a6),a2
[000015fc] 4a12                      tst.b      (a2)
[000015fe] 672e                      beq.s      x131c_26
[00001600] 246e ffe6                 movea.l    -26(a6),a2
[00001604] 4287                      clr.l      d7
[00001606] 1e12                      move.b     (a2),d7
[00001608] 0c47 005c                 cmpi.w     #$005C,d7
[0000160c] 6610                      bne.s      x131c_27
[0000160e] 4297                      clr.l      (a7)
[00001610] 486e ffe6                 pea.l      -26(a6)
[00001614] 4eb9 0000 1a50            jsr        $00001A50
[0000161a] 588f                      addq.l     #4,a7
[0000161c] 6008                      bra.s      x131c_28
x131c_27:
[0000161e] 246e ffe6                 movea.l    -26(a6),a2
[00001622] 4287                      clr.l      d7
[00001624] 1e12                      move.b     (a2),d7
x131c_28:
[00001626] 16c7                      move.b     d7,(a3)+
[00001628] 52ae ffe6                 addq.l     #1,-26(a6)
[0000162c] 60ca                      bra.s      x131c_29
x131c_26:
[0000162e] 4213                      clr.b      (a3)
x131c_31:
[00001630] 528d                      addq.l     #1,a5
[00001632] 6000 ff7e                 bra        x131c_30
[00001636] 60f8                      bra.s      x131c_31
[00001638] 7001                      moveq.l    #1,d0
[0000163a] 2d40 fff4                 move.l     d0,-12(a6)
[0000163e] 4287                      clr.l      d7
[00001640] 1e13                      move.b     (a3),d7
[00001642] 0c47 005c                 cmpi.w     #$005C,d7
[00001646] 670a                      beq.s      x131c_32
[00001648] 4287                      clr.l      d7
[0000164a] 1e13                      move.b     (a3),d7
[0000164c] 2d47 ffe2                 move.l     d7,-30(a6)
[00001650] 601a                      bra.s      x131c_33
x131c_32:
[00001652] 2d4b ffe6                 move.l     a3,-26(a6)
[00001656] 4297                      clr.l      (a7)
[00001658] 486e ffe6                 pea.l      -26(a6)
[0000165c] 4eb9 0000 1a50            jsr        $00001A50
[00001662] 588f                      addq.l     #4,a7
[00001664] 2d47 ffe2                 move.l     d7,-30(a6)
[00001668] 266e ffe6                 movea.l    -26(a6),a3
x131c_33:
[0000166c] 4a13                      tst.b      (a3)
[0000166e] 67c0                      beq.s      x131c_31
[00001670] 528b                      addq.l     #1,a3
[00001672] 60bc                      bra.s      x131c_31
[00001674] 4a13                      tst.b      (a3)
[00001676] 6618                      bne.s      x131c_34
[00001678] 246e 0008                 movea.l    8(a6),a2
[0000167c] 5392                      subq.l     #1,(a2)
[0000167e] 670c                      beq.s      x131c_35
[00001680] 246e 000c                 movea.l    12(a6),a2
[00001684] 5892                      addq.l     #4,(a2)
[00001686] 2452                      movea.l    (a2),a2
[00001688] 2e12                      move.l     (a2),d7
[0000168a] 6002                      bra.s      x131c_36
x131c_35:
[0000168c] 2e0b                      move.l     a3,d7
x131c_36:
[0000168e] 2647                      movea.l    d7,a3
x131c_34:
[00001690] 4878 0001                 pea.l      ($00000001).w
[00001694] 486e ffee                 pea.l      -18(a6)
[00001698] 2f0b                      move.l     a3,-(a7)
[0000169a] 4eb9 0000 25bc            jsr        $000025BC
[000016a0] 588f                      addq.l     #4,a7
[000016a2] 2f07                      move.l     d7,-(a7)
[000016a4] 2f0b                      move.l     a3,-(a7)
[000016a6] 4eb9 0000 233c            jsr        $0000233C
[000016ac] 4fef 0010                 lea.l      16(a7),a7
[000016b0] d7c7                      adda.l     d7,a3
[000016b2] 4a13                      tst.b      (a3)
[000016b4] 6604                      bne.s      x131c_37
[000016b6] 7e01                      moveq.l    #1,d7
[000016b8] 6002                      bra.s      x131c_38
x131c_37:
[000016ba] 4287                      clr.l      d7
x131c_38:
[000016bc] 2d47 fff4                 move.l     d7,-12(a6)
[000016c0] 4aae fff4                 tst.l      -12(a6)
[000016c4] 6616                      bne.s      x131c_39
[000016c6] 4878 003a                 pea.l      ($0000003A).w
[000016ca] 2f0d                      move.l     a5,-(a7)
[000016cc] 4eb9 0000 1f86            jsr        $00001F86
[000016d2] 508f                      addq.l     #8,a7
[000016d4] 5387                      subq.l     #1,d7
[000016d6] dbc7                      adda.l     d7,a5
[000016d8] 6000 ff56                 bra        x131c_31
x131c_39:
[000016dc] 4287                      clr.l      d7
[000016de] 1e2d 0001                 move.b     1(a5),d7
[000016e2] 0c47 0023                 cmpi.w     #$0023,d7
[000016e6] 660c                      bne.s      x131c_40
[000016e8] 528d                      addq.l     #1,a5
[000016ea] 7001                      moveq.l    #1,d0
[000016ec] 2d40 fff8                 move.l     d0,-8(a6)
[000016f0] 6000 ff3e                 bra        x131c_31
x131c_40:
[000016f4] 2d6e ffee ffe2            move.l     -18(a6),-30(a6)
[000016fa] 6000 ff34                 bra        x131c_31
[000016fe] 4aae fff4                 tst.l      -12(a6)
[00001702] 6712                      beq.s      x131c_41
[00001704] 4aae fff8                 tst.l      -8(a6)
[00001708] 671a                      beq.s      x131c_42
[0000170a] 246e ffea                 movea.l    -22(a6),a2
[0000170e] 2452                      movea.l    (a2),a2
[00001710] 24ae ffee                 move.l     -18(a6),(a2)
[00001714] 6018                      bra.s      x131c_43
x131c_41:
[00001716] 4a15                      tst.b      (a5)
[00001718] 6620                      bne.s      x131c_44
[0000171a] 2e0c                      move.l     a4,d7
[0000171c] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00001720] 4e5e                      unlk       a6
[00001722] 4e75                      rts
x131c_42:
[00001724] 246e ffea                 movea.l    -22(a6),a2
[00001728] 2452                      movea.l    (a2),a2
[0000172a] 24ae ffe2                 move.l     -30(a6),(a2)
x131c_43:
[0000172e] 284b                      movea.l    a3,a4
[00001730] 7001                      moveq.l    #1,d0
[00001732] 2d40 fffc                 move.l     d0,-4(a6)
[00001736] 6000 fef8                 bra        x131c_31
x131c_44:
[0000173a] 4287                      clr.l      d7
[0000173c] 1e15                      move.b     (a5),d7
[0000173e] 0c47 003a                 cmpi.w     #$003A,d7
[00001742] 6612                      bne.s      x131c_45
[00001744] 2eae 0010                 move.l     16(a6),(a7)
[00001748] 528d                      addq.l     #1,a5
[0000174a] 2f0d                      move.l     a5,-(a7)
[0000174c] 4eba fc2a                 jsr        $00001378(pc)
[00001750] 588f                      addq.l     #4,a7
[00001752] 6000 fedc                 bra        x131c_31
x131c_45:
[00001756] 58ae ffea                 addq.l     #4,-22(a6)
[0000175a] 264c                      movea.l    a4,a3
[0000175c] 6000 fed2                 bra        x131c_31
[00001760] 4aae fff4                 tst.l      -12(a6)
[00001764] 660a                      bne.s      x131c_46
[00001766] 58ae ffea                 addq.l     #4,-22(a6)
[0000176a] 264c                      movea.l    a4,a3
[0000176c] 6000 fec2                 bra        x131c_31
x131c_46:
[00001770] 246e ffea                 movea.l    -22(a6),a2
[00001774] 2452                      movea.l    (a2),a2
[00001776] 4a92                      tst.l      (a2)
[00001778] 663c                      bne.s      x131c_47
[0000177a] 4878 003a                 pea.l      ($0000003A).w
[0000177e] 2f0d                      move.l     a5,-(a7)
[00001780] 4eb9 0000 1f86            jsr        $00001F86
[00001786] 508f                      addq.l     #8,a7
[00001788] 3d47 fff2                 move.w     d7,-14(a6)
[0000178c] 3e2e fff2                 move.w     -14(a6),d7
[00001790] 48c7                      ext.l      d7
[00001792] 2447                      movea.l    d7,a2
[00001794] d5cd                      adda.l     a5,a2
[00001796] 4a12                      tst.b      (a2)
[00001798] 673e                      beq.s      x131c_48
[0000179a] 2eae 0010                 move.l     16(a6),(a7)
[0000179e] 3e2e fff2                 move.w     -14(a6),d7
[000017a2] 48c7                      ext.l      d7
[000017a4] 45ed 0001                 lea.l      1(a5),a2
[000017a8] de8a                      add.l      a2,d7
[000017aa] 2f07                      move.l     d7,-(a7)
[000017ac] 4eba fbca                 jsr        $00001378(pc)
[000017b0] 588f                      addq.l     #4,a7
[000017b2] 6000 fe7c                 bra        x131c_31
x131c_47:
[000017b6] 4aae fff8                 tst.l      -8(a6)
[000017ba] 6726                      beq.s      x131c_49
[000017bc] 246e ffea                 movea.l    -22(a6),a2
[000017c0] 2452                      movea.l    (a2),a2
[000017c2] 5392                      subq.l     #1,(a2)
[000017c4] 2e12                      move.l     (a2),d7
[000017c6] e587                      asl.l      #2,d7
[000017c8] 246e ffea                 movea.l    -22(a6),a2
[000017cc] 2452                      movea.l    (a2),a2
[000017ce] 588a                      addq.l     #4,a2
[000017d0] d5c7                      adda.l     d7,a2
[000017d2] 24ae ffee                 move.l     -18(a6),(a2)
[000017d6] 6024                      bra.s      x131c_50
x131c_48:
[000017d8] 2e0c                      move.l     a4,d7
[000017da] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000017de] 4e5e                      unlk       a6
[000017e0] 4e75                      rts
x131c_49:
[000017e2] 246e ffea                 movea.l    -22(a6),a2
[000017e6] 2452                      movea.l    (a2),a2
[000017e8] 5392                      subq.l     #1,(a2)
[000017ea] 2e12                      move.l     (a2),d7
[000017ec] e587                      asl.l      #2,d7
[000017ee] 246e ffea                 movea.l    -22(a6),a2
[000017f2] 2452                      movea.l    (a2),a2
[000017f4] 588a                      addq.l     #4,a2
[000017f6] d5c7                      adda.l     d7,a2
[000017f8] 24ae ffe2                 move.l     -30(a6),(a2)
x131c_50:
[000017fc] 284b                      movea.l    a3,a4
[000017fe] 7001                      moveq.l    #1,d0
[00001800] 2d40 fffc                 move.l     d0,-4(a6)
[00001804] 6000 fe2a                 bra        x131c_31
[00001808] 4287                      clr.l      d7
[0000180a] 1e15                      move.b     (a5),d7
[0000180c] 4286                      clr.l      d6
[0000180e] 1c13                      move.b     (a3),d6
[00001810] be86                      cmp.l      d6,d7
[00001812] 6612                      bne.s      x131c_51
[00001814] 7001                      moveq.l    #1,d0
[00001816] 2d40 fff4                 move.l     d0,-12(a6)
[0000181a] 7001                      moveq.l    #1,d0
[0000181c] 2d40 ffe2                 move.l     d0,-30(a6)
[00001820] 528b                      addq.l     #1,a3
[00001822] 6000 fe0c                 bra        x131c_31
x131c_51:
[00001826] 42ae fff4                 clr.l      -12(a6)
x131c_53:
[0000182a] 4a15                      tst.b      (a5)
[0000182c] 6722                      beq.s      x131c_52
[0000182e] 4287                      clr.l      d7
[00001830] 1e15                      move.b     (a5),d7
[00001832] 0c47 002c                 cmpi.w     #$002C,d7
[00001836] 6718                      beq.s      x131c_52
[00001838] 4287                      clr.l      d7
[0000183a] 1e15                      move.b     (a5),d7
[0000183c] 0c47 003e                 cmpi.w     #$003E,d7
[00001840] 670e                      beq.s      x131c_52
[00001842] 4287                      clr.l      d7
[00001844] 1e15                      move.b     (a5),d7
[00001846] 0c47 003a                 cmpi.w     #$003A,d7
[0000184a] 6704                      beq.s      x131c_52
[0000184c] 528d                      addq.l     #1,a5
[0000184e] 60da                      bra.s      x131c_53
x131c_52:
[00001850] 538d                      subq.l     #1,a5
[00001852] 6000 fddc                 bra        x131c_31
[00001856] 4e56 0000                 link       a6,#0
[0000185a] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[0000185e] 2a2e 0008                 move.l     8(a6),d5
[00001862] 2a6e 000c                 movea.l    12(a6),a5
[00001866] 282e 0010                 move.l     16(a6),d4
[0000186a] 0c84 0000 003c            cmpi.l     #$0000003C,d4
[00001870] 6f14                      ble.s      x131c_54
[00001872] 4287                      clr.l      d7
[00001874] 1e15                      move.b     (a5),d7
[00001876] 0c47 0020                 cmpi.w     #$0020,d7
[0000187a] 6724                      beq.s      x131c_55
[0000187c] 4287                      clr.l      d7
[0000187e] 1e15                      move.b     (a5),d7
[00001880] 0c47 0009                 cmpi.w     #$0009,d7
[00001884] 671a                      beq.s      x131c_55
x131c_54:
[00001886] 4878 0001                 pea.l      ($00000001).w
[0000188a] 2f0d                      move.l     a5,-(a7)
[0000188c] 2f05                      move.l     d5,-(a7)
[0000188e] 4eb9 0000 27aa            jsr        $000027AA
[00001894] 4fef 000c                 lea.l      12(a7),a7
[00001898] 2444                      movea.l    d4,a2
[0000189a] 528a                      addq.l     #1,a2
[0000189c] 2e0a                      move.l     a2,d7
[0000189e] 6018                      bra.s      x131c_56
x131c_55:
[000018a0] 4878 0002                 pea.l      ($00000002).w
[000018a4] 2f3c 0002 063a            move.l     #$00022DEC,-(a7)
[000018aa] 2f05                      move.l     d5,-(a7)
[000018ac] 4eb9 0000 27aa            jsr        $000027AA
[000018b2] 4fef 000c                 lea.l      12(a7),a7
[000018b6] 7e04                      moveq.l    #4,d7
x131c_56:
[000018b8] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[000018bc] 4e5e                      unlk       a6
[000018be] 4e75                      rts

x18c0:
[000018c0] 4e56 fffc                 link       a6,#-4
[000018c4] 4297                      clr.l      (a7)
[000018c6] 2f2e 000c                 move.l     12(a6),-(a7)
[000018ca] 2f2e 0008                 move.l     8(a6),-(a7)
[000018ce] 4878 0002                 pea.l      ($00000002).w
[000018d2] 4eb9 0000 1f48            jsr        $00001F48
[000018d8] 4fef 000c                 lea.l      12(a7),a7
[000018dc] 4878 0001                 pea.l      ($00000001).w
[000018e0] 2f3c 0002 063e            move.l     #$00022DF0,-(a7)
[000018e6] 4878 0002                 pea.l      ($00000002).w
[000018ea] 4eb9 0000 27aa            jsr        $000027AA
[000018f0] 4fef 000c                 lea.l      12(a7),a7
[000018f4] 4287                      clr.l      d7
[000018f6] 4e5e                      unlk       a6
[000018f8] 4e75                      rts

x18fa:
[000018fa] 205f                      movea.l    (a7)+,a0
[000018fc] 7e23                      moveq.l    #35,d7
[000018fe] 4e41                      trap       #1
[00001900] 4ed0                      jmp        (a0)

x18fa_2:
a~jtab:
[00001902] 4a98                      tst.l      (a0)+
[00001904] 670a                      beq.s      x18fa_1
[00001906] be98                      cmp.l      (a0)+,d7
[00001908] 66f8                      bne.s      a~jtab
[0000190a] 2068 fff8                 movea.l    -8(a0),a0
[0000190e] 4ed0                      jmp        (a0)
x18fa_1:
[00001910] 2050                      movea.l    (a0),a0
[00001912] 4ed0                      jmp        (a0)

_usage:
[00001914] 4e56 0000                 link       a6,#0
[00001918] 48e7 8400                 movem.l    d0/d5,-(a7)
[0000191c] 4285                      clr.l      d5
[0000191e] 4297                      clr.l      (a7)
[00001920] 2f2e 0008                 move.l     8(a6),-(a7)
[00001924] 2f3c 0002 084a            move.l     #$00022FFC,-(a7)
[0000192a] 2f39 0002 08f6            move.l     $000230A8,-(a7)
[00001930] 2f3c 0002 084c            move.l     #$00022FFE,-(a7)
[00001936] 4878 0002                 pea.l      ($00000002).w
[0000193a] 4eb9 0000 1f48            jsr        $00001F48
[00001940] 4fef 0014                 lea.l      20(a7),a7
[00001944] 4aae 0008                 tst.l      8(a6)
[00001948] 6726                      beq.s      x18fa_3
[0000194a] 2eae 0008                 move.l     8(a6),(a7)
[0000194e] 4eb9 0000 25bc            jsr        $000025BC
[00001954] 2a07                      move.l     d7,d5
[00001956] 2445                      movea.l    d5,a2
[00001958] 538a                      subq.l     #1,a2
[0000195a] d5ee 0008                 adda.l     8(a6),a2
[0000195e] 4287                      clr.l      d7
[00001960] 1e12                      move.b     (a2),d7
[00001962] 0c47 000a                 cmpi.w     #$000A,d7
[00001966] 6608                      bne.s      x18fa_3
[00001968] 4297                      clr.l      (a7)
[0000196a] 4eb9 0000 0080            jsr        $00000080
x18fa_3:
[00001970] 2eb9 0002 08f6            move.l     $000230A8,(a7)
[00001976] 4eb9 0000 25bc            jsr        $000025BC
[0000197c] 2445                      movea.l    d5,a2
[0000197e] 508a                      addq.l     #8,a2
[00001980] de8a                      add.l      a2,d7
[00001982] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00001986] 4e5e                      unlk       a6
[00001988] 4e75                      rts

x198a:
[0000198a] 4e56 0000                 link       a6,#0
[0000198e] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00001992] 2a6e 0008                 movea.l    8(a6),a5
[00001996] 286e 000c                 movea.l    12(a6),a4
[0000199a] 2a2e 0010                 move.l     16(a6),d5
x198a_4:
[0000199e] 4a85                      tst.l      d5
[000019a0] 6710                      beq.s      x198a_1
[000019a2] 4287                      clr.l      d7
[000019a4] 1e1d                      move.b     (a5)+,d7
[000019a6] 4286                      clr.l      d6
[000019a8] 1c1c                      move.b     (a4)+,d6
[000019aa] be86                      cmp.l      d6,d7
[000019ac] 670e                      beq.s      x198a_2
[000019ae] 4287                      clr.l      d7
[000019b0] 6002                      bra.s      x198a_3
x198a_1:
[000019b2] 7e01                      moveq.l    #1,d7
x198a_3:
[000019b4] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000019b8] 4e5e                      unlk       a6
[000019ba] 4e75                      rts
x198a_2:
[000019bc] 5385                      subq.l     #1,d5
[000019be] 60de                      bra.s      x198a_4
[000019c0] 4e56 0000                 link       a6,#0
[000019c4] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000019c8] 2a6e 0008                 movea.l    8(a6),a5
[000019cc] 286e 000c                 movea.l    12(a6),a4
x198a_6:
[000019d0] 4a14                      tst.b      (a4)
[000019d2] 6710                      beq.s      x198a_5
[000019d4] 4287                      clr.l      d7
[000019d6] 1e1d                      move.b     (a5)+,d7
[000019d8] 4286                      clr.l      d6
[000019da] 1c1c                      move.b     (a4)+,d6
[000019dc] be86                      cmp.l      d6,d7
[000019de] 67f0                      beq.s      x198a_6
[000019e0] 4287                      clr.l      d7
[000019e2] 600a                      bra.s      x198a_7
x198a_5:
[000019e4] 4a15                      tst.b      (a5)
[000019e6] 6604                      bne.s      x198a_8
[000019e8] 7e01                      moveq.l    #1,d7
[000019ea] 6002                      bra.s      x198a_7
x198a_8:
[000019ec] 4287                      clr.l      d7
x198a_7:
[000019ee] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000019f2] 4e5e                      unlk       a6
[000019f4] 4e75                      rts

x19f6:
[000019f6] 4e56 0000                 link       a6,#0
[000019fa] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000019fe] 2a6e 0008                 movea.l    8(a6),a5
[00001a02] 286e 000c                 movea.l    12(a6),a4
[00001a06] 2a2e 0010                 move.l     16(a6),d5
x19f6_2:
[00001a0a] 4a85                      tst.l      d5
[00001a0c] 6706                      beq.s      x19f6_1
[00001a0e] 1adc                      move.b     (a4)+,(a5)+
[00001a10] 5385                      subq.l     #1,d5
[00001a12] 60f6                      bra.s      x19f6_2
x19f6_1:
[00001a14] 2e2e 0010                 move.l     16(a6),d7
[00001a18] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00001a1c] 4e5e                      unlk       a6
[00001a1e] 4e75                      rts

x1a20:
[00001a20] 4e56 0000                 link       a6,#0
[00001a24] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00001a28] 286e 0008                 movea.l    8(a6),a4
[00001a2c] 45ee 000c                 lea.l      12(a6),a2
[00001a30] 2a4a                      movea.l    a2,a5
x1a20_4:
[00001a32] 2655                      movea.l    (a5),a3
[00001a34] 2e0b                      move.l     a3,d7
[00001a36] 6708                      beq.s      x1a20_1
x1a20_3:
[00001a38] 4a13                      tst.b      (a3)
[00001a3a] 6710                      beq.s      x1a20_2
[00001a3c] 18db                      move.b     (a3)+,(a4)+
[00001a3e] 60f8                      bra.s      x1a20_3
x1a20_1:
[00001a40] 4214                      clr.b      (a4)
[00001a42] 2e0c                      move.l     a4,d7
[00001a44] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00001a48] 4e5e                      unlk       a6
[00001a4a] 4e75                      rts
x1a20_2:
[00001a4c] 588d                      addq.l     #4,a5
[00001a4e] 60e2                      bra.s      x1a20_4
[00001a50] 4e56 0000                 link       a6,#0
[00001a54] 48e7 9c0c                 movem.l    d0/d3-d5/a4-a5,-(a7)
[00001a58] 246e 0008                 movea.l    8(a6),a2
[00001a5c] 2e12                      move.l     (a2),d7
[00001a5e] 5287                      addq.l     #1,d7
[00001a60] 2a47                      movea.l    d7,a5
[00001a62] 4a15                      tst.b      (a5)
[00001a64] 6612                      bne.s      x1a20_5
[00001a66] 246e 0008                 movea.l    8(a6),a2
[00001a6a] 2452                      movea.l    (a2),a2
[00001a6c] 4287                      clr.l      d7
[00001a6e] 1e12                      move.b     (a2),d7
[00001a70] 4cdf 3039                 movem.l    (a7)+,d0/d3-d5/a4-a5
[00001a74] 4e5e                      unlk       a6
[00001a76] 4e75                      rts
x1a20_5:
[00001a78] 4287                      clr.l      d7
[00001a7a] 1e15                      move.b     (a5),d7
[00001a7c] 0c47 0030                 cmpi.w     #$0030,d7
[00001a80] 6540                      bcs.s      x1a20_6
[00001a82] 4287                      clr.l      d7
[00001a84] 1e15                      move.b     (a5),d7
[00001a86] 0c47 0039                 cmpi.w     #$0039,d7
[00001a8a] 6236                      bhi.s      x1a20_6
[00001a8c] 4285                      clr.l      d5
[00001a8e] 7801                      moveq.l    #1,d4
x1a20_8:
[00001a90] 4287                      clr.l      d7
[00001a92] 1e15                      move.b     (a5),d7
[00001a94] 0c47 0030                 cmpi.w     #$0030,d7
[00001a98] 6578                      bcs.s      x1a20_7
[00001a9a] 4287                      clr.l      d7
[00001a9c] 1e15                      move.b     (a5),d7
[00001a9e] 0c47 0039                 cmpi.w     #$0039,d7
[00001aa2] 626e                      bhi.s      x1a20_7
[00001aa4] 0c84 0000 0003            cmpi.l     #$00000003,d4
[00001aaa] 6e66                      bgt.s      x1a20_7
[00001aac] 7ed0                      moveq.l    #-48,d7
[00001aae] 2c05                      move.l     d5,d6
[00001ab0] e786                      asl.l      #3,d6
[00001ab2] 4283                      clr.l      d3
[00001ab4] 1615                      move.b     (a5),d3
[00001ab6] dc83                      add.l      d3,d6
[00001ab8] de86                      add.l      d6,d7
[00001aba] 2a07                      move.l     d7,d5
[00001abc] 528d                      addq.l     #1,a5
[00001abe] 5284                      addq.l     #1,d4
[00001ac0] 60ce                      bra.s      x1a20_8
x1a20_6:
[00001ac2] 4287                      clr.l      d7
[00001ac4] 1e15                      move.b     (a5),d7
[00001ac6] 0c47 0041                 cmpi.w     #$0041,d7
[00001aca] 6514                      bcs.s      x1a20_9
[00001acc] 4287                      clr.l      d7
[00001ace] 1e15                      move.b     (a5),d7
[00001ad0] 0c47 005a                 cmpi.w     #$005A,d7
[00001ad4] 620a                      bhi.s      x1a20_9
[00001ad6] 7e20                      moveq.l    #32,d7
[00001ad8] 4286                      clr.l      d6
[00001ada] 1c15                      move.b     (a5),d6
[00001adc] de86                      add.l      d6,d7
[00001ade] 6004                      bra.s      x1a20_10
x1a20_9:
[00001ae0] 4287                      clr.l      d7
[00001ae2] 1e15                      move.b     (a5),d7
x1a20_10:
[00001ae4] 2e87                      move.l     d7,(a7)
[00001ae6] 2f3c 0002 085b            move.l     #$0002300D,-(a7)
[00001aec] 4eb9 0000 1f86            jsr        $00001F86
[00001af2] 588f                      addq.l     #4,a7
[00001af4] 2a07                      move.l     d7,d5
[00001af6] 0c85 0000 0005            cmpi.l     #$00000005,d5
[00001afc] 6c28                      bge.s      x1a20_11
[00001afe] 246e 0008                 movea.l    8(a6),a2
[00001b02] 248d                      move.l     a5,(a2)
[00001b04] 2445                      movea.l    d5,a2
[00001b06] d5fc 0002 0854            adda.l     #$00023006,a2
[00001b0c] 4287                      clr.l      d7
[00001b0e] 1e12                      move.b     (a2),d7
[00001b10] 600c                      bra.s      x1a20_12
x1a20_7:
[00001b12] 246e 0008                 movea.l    8(a6),a2
[00001b16] 49ed ffff                 lea.l      -1(a5),a4
[00001b1a] 248c                      move.l     a4,(a2)
[00001b1c] 2e05                      move.l     d5,d7
x1a20_12:
[00001b1e] 4cdf 3039                 movem.l    (a7)+,d0/d3-d5/a4-a5
[00001b22] 4e5e                      unlk       a6
[00001b24] 4e75                      rts
x1a20_11:
[00001b26] 4aae 000c                 tst.l      12(a6)
[00001b2a] 672a                      beq.s      x1a20_13
[00001b2c] 4287                      clr.l      d7
[00001b2e] 1e15                      move.b     (a5),d7
[00001b30] 2e87                      move.l     d7,(a7)
[00001b32] 2f2e 000c                 move.l     12(a6),-(a7)
[00001b36] 4eb9 0000 1f86            jsr        $00001F86
[00001b3c] 588f                      addq.l     #4,a7
[00001b3e] 2a07                      move.l     d7,d5
[00001b40] 2445                      movea.l    d5,a2
[00001b42] d5ee 000c                 adda.l     12(a6),a2
[00001b46] 4a12                      tst.b      (a2)
[00001b48] 670c                      beq.s      x1a20_13
[00001b4a] 246e 0008                 movea.l    8(a6),a2
[00001b4e] 248d                      move.l     a5,(a2)
[00001b50] 7eff                      moveq.l    #-1,d7
[00001b52] 9e85                      sub.l      d5,d7
[00001b54] 60c8                      bra.s      x1a20_12
x1a20_13:
[00001b56] 246e 0008                 movea.l    8(a6),a2
[00001b5a] 248d                      move.l     a5,(a2)
[00001b5c] 4287                      clr.l      d7
[00001b5e] 1e15                      move.b     (a5),d7
[00001b60] 60bc                      bra.s      x1a20_12
[00001b62] 4e56 0000                 link       a6,#0
[00001b66] 48e7 8004                 movem.l    d0/a5,-(a7)
[00001b6a] 2a79 0002 0862            movea.l    $00023014,a5
x1a20_16:
[00001b70] 2e0d                      move.l     a5,d7
[00001b72] 6722                      beq.s      x1a20_14
[00001b74] 4a6d 0002                 tst.w      2(a5)
[00001b78] 6f2a                      ble.s      x1a20_15
[00001b7a] 3e2d 0002                 move.w     2(a5),d7
[00001b7e] 48c7                      ext.l      d7
[00001b80] 2e87                      move.l     d7,(a7)
[00001b82] 486d 000a                 pea.l      10(a5)
[00001b86] 3e15                      move.w     (a5),d7
[00001b88] 48c7                      ext.l      d7
[00001b8a] 2f07                      move.l     d7,-(a7)
[00001b8c] 4eb9 0000 27aa            jsr        $000027AA
[00001b92] 508f                      addq.l     #8,a7
[00001b94] 600e                      bra.s      x1a20_15
x1a20_14:
[00001b96] 2e39 0002 0866            move.l     $00023018,d7
[00001b9c] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00001ba0] 4e5e                      unlk       a6
[00001ba2] 4e75                      rts
x1a20_15:
[00001ba4] 2a6d 0006                 movea.l    6(a5),a5
[00001ba8] 60c6                      bra.s      x1a20_16
[00001baa] 4e56 0000                 link       a6,#0
[00001bae] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00001bb2] 2a6e 0008                 movea.l    8(a6),a5
[00001bb6] 2a2e 0010                 move.l     16(a6),d5
[00001bba] 2e0d                      move.l     a5,d7
[00001bbc] 6610                      bne.s      x1a20_17
[00001bbe] 2ebc 0002 0898            move.l     #$0002304A,(a7)
[00001bc4] 42a7                      clr.l      -(a7)
[00001bc6] 4eb9 0000 260a            jsr        $0000260A
[00001bcc] 588f                      addq.l     #4,a7
x1a20_17:
[00001bce] 3aae 000e                 move.w     14(a6),(a5)
[00001bd2] 426d 0002                 clr.w      2(a5)
[00001bd6] 0c85 0000 0001            cmpi.l     #$00000001,d5
[00001bdc] 661c                      bne.s      x1a20_18
[00001bde] 4878 0001                 pea.l      ($00000001).w
[00001be2] 42a7                      clr.l      -(a7)
[00001be4] 2f2e 000c                 move.l     12(a6),-(a7)
[00001be8] 4eb9 0000 1d3c            jsr        $00001D3C
[00001bee] 4fef 000c                 lea.l      12(a7),a7
[00001bf2] 4a87                      tst.l      d7
[00001bf4] 6d04                      blt.s      x1a20_18
[00001bf6] 7eff                      moveq.l    #-1,d7
[00001bf8] 6002                      bra.s      x1a20_19
x1a20_18:
[00001bfa] 2e05                      move.l     d5,d7
x1a20_19:
[00001bfc] 3b47 0004                 move.w     d7,4(a5)
[00001c00] 0c85 0000 0001            cmpi.l     #$00000001,d5
[00001c06] 6708                      beq.s      x1a20_20
[00001c08] 0c85 ffff ffff            cmpi.l     #$FFFFFFFF,d5
[00001c0e] 6628                      bne.s      x1a20_21
x1a20_20:
[00001c10] 2b79 0002 0862 0006       move.l     $00023014,6(a5)
[00001c18] 23cd 0002 0862            move.l     a5,$00023014
[00001c1e] 4ab9 0002 0866            tst.l      $00023018
[00001c24] 6612                      bne.s      x1a20_21
[00001c26] 2ebc 0000 1b62            move.l     #$00001B62,(a7)
[00001c2c] 4eb9 0000 00aa            jsr        $000000AA
[00001c32] 23c7 0002 0866            move.l     d7,$00023018
x1a20_21:
[00001c38] 2e0d                      move.l     a5,d7
[00001c3a] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00001c3e] 4e5e                      unlk       a6
[00001c40] 4e75                      rts

x1c42:
[00001c42] 4e56 0000                 link       a6,#0
[00001c46] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00001c4a] 2a6e 0008                 movea.l    8(a6),a5
[00001c4e] 286e 000c                 movea.l    12(a6),a4
[00001c52] 2e0d                      move.l     a5,d7
[00001c54] 6610                      bne.s      x1c42_1
[00001c56] 2ebc 0002 0898            move.l     #$0002304A,(a7)
[00001c5c] 42a7                      clr.l      -(a7)
[00001c5e] 4eb9 0000 260a            jsr        $0000260A
[00001c64] 588f                      addq.l     #4,a7
x1c42_1:
[00001c66] 4285                      clr.l      d5
x1c42_7:
[00001c68] 4a6d 0002                 tst.w      2(a5)
[00001c6c] 663a                      bne.s      x1c42_2
[00001c6e] 2ebc 0000 0200            move.l     #$00000200,(a7)
[00001c74] 45ed 000a                 lea.l      10(a5),a2
[00001c78] 2b4a 0006                 move.l     a2,6(a5)
[00001c7c] 2f2d 0006                 move.l     6(a5),-(a7)
[00001c80] 3e15                      move.w     (a5),d7
[00001c82] 48c7                      ext.l      d7
[00001c84] 2f07                      move.l     d7,-(a7)
[00001c86] 4eb9 0000 1f7e            jsr        $00001F7E
[00001c8c] 508f                      addq.l     #8,a7
[00001c8e] 3b47 0002                 move.w     d7,2(a5)
[00001c92] 4a6d 0002                 tst.w      2(a5)
[00001c96] 6c10                      bge.s      x1c42_2
[00001c98] 2ebc 0002 086a            move.l     #$0002301C,(a7)
[00001c9e] 42a7                      clr.l      -(a7)
[00001ca0] 4eb9 0000 260a            jsr        $0000260A
[00001ca6] 588f                      addq.l     #4,a7
x1c42_2:
[00001ca8] 4a6d 0002                 tst.w      2(a5)
[00001cac] 6e0a                      bgt.s      x1c42_3
[00001cae] 3b7c ffff 0002            move.w     #$FFFF,2(a5)
[00001cb4] 2e05                      move.l     d5,d7
[00001cb6] 6028                      bra.s      x1c42_4
x1c42_3:
[00001cb8] baae 0010                 cmp.l      16(a6),d5
[00001cbc] 642a                      bcc.s      x1c42_5
[00001cbe] 4a6d 0002                 tst.w      2(a5)
[00001cc2] 6f24                      ble.s      x1c42_5
[00001cc4] 5285                      addq.l     #1,d5
[00001cc6] 536d 0002                 subq.w     #1,2(a5)
[00001cca] 246d 0006                 movea.l    6(a5),a2
[00001cce] 52ad 0006                 addq.l     #1,6(a5)
[00001cd2] 1892                      move.b     (a2),(a4)
[00001cd4] 4287                      clr.l      d7
[00001cd6] 1e14                      move.b     (a4),d7
[00001cd8] 0c47 000a                 cmpi.w     #$000A,d7
[00001cdc] 6618                      bne.s      x1c42_6
[00001cde] 2e05                      move.l     d5,d7
x1c42_4:
[00001ce0] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00001ce4] 4e5e                      unlk       a6
[00001ce6] 4e75                      rts
x1c42_5:
[00001ce8] 2e2e 0010                 move.l     16(a6),d7
[00001cec] be85                      cmp.l      d5,d7
[00001cee] 6200 ff78                 bhi        x1c42_7
[00001cf2] 2e05                      move.l     d5,d7
[00001cf4] 60ea                      bra.s      x1c42_4
x1c42_6:
[00001cf6] 528c                      addq.l     #1,a4
[00001cf8] 60be                      bra.s      x1c42_3

_instr:
[00001cfa] 4e56 0000                 link       a6,#0
[00001cfe] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00001d02] 2a6e 0008                 movea.l    8(a6),a5
x1c42_12:
[00001d06] 4a15                      tst.b      (a5)
[00001d08] 671c                      beq.s      x1c42_8
[00001d0a] 286e 000c                 movea.l    12(a6),a4
x1c42_13:
[00001d0e] 4a14                      tst.b      (a4)
[00001d10] 6722                      beq.s      x1c42_9
[00001d12] 4287                      clr.l      d7
[00001d14] 1e15                      move.b     (a5),d7
[00001d16] 4286                      clr.l      d6
[00001d18] 1c14                      move.b     (a4),d6
[00001d1a] be86                      cmp.l      d6,d7
[00001d1c] 661a                      bne.s      x1c42_10
[00001d1e] 2e0d                      move.l     a5,d7
[00001d20] 9eae 0008                 sub.l      8(a6),d7
[00001d24] 6006                      bra.s      x1c42_11
x1c42_8:
[00001d26] 2e0d                      move.l     a5,d7
[00001d28] 9eae 0008                 sub.l      8(a6),d7
x1c42_11:
[00001d2c] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00001d30] 4e5e                      unlk       a6
[00001d32] 4e75                      rts
x1c42_9:
[00001d34] 528d                      addq.l     #1,a5
[00001d36] 60ce                      bra.s      x1c42_12
x1c42_10:
[00001d38] 528c                      addq.l     #1,a4
[00001d3a] 60d2                      bra.s      x1c42_13
[00001d3c] 4e56 ffda                 link       a6,#-38
[00001d40] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[00001d44] 2a2e 0008                 move.l     8(a6),d5
[00001d48] 4aae 000c                 tst.l      12(a6)
[00001d4c] 660a                      bne.s      x1c42_14
[00001d4e] 0cae 0000 0001 0010       cmpi.l     #$00000001,16(a6)
[00001d56] 6720                      beq.s      x1c42_15
x1c42_14:
[00001d58] 2eae 0010                 move.l     16(a6),(a7)
[00001d5c] 2f2e 000c                 move.l     12(a6),-(a7)
[00001d60] 2f05                      move.l     d5,-(a7)
[00001d62] 4eb9 0000 1fbc            jsr        $00001FBC
[00001d68] 508f                      addq.l     #8,a7
[00001d6a] 2807                      move.l     d7,d4
[00001d6c] 4a84                      tst.l      d4
[00001d6e] 6c04                      bge.s      x1c42_16
[00001d70] 2e04                      move.l     d4,d7
[00001d72] 6002                      bra.s      x1c42_17
x1c42_16:
[00001d74] 2e05                      move.l     d5,d7
x1c42_17:
[00001d76] 6014                      bra.s      x1c42_18
x1c42_15:
[00001d78] 486e ffda                 pea.l      -38(a6)
[00001d7c] 2f05                      move.l     d5,-(a7)
[00001d7e] 4eb9 0000 257a            jsr        $0000257A
[00001d84] 508f                      addq.l     #8,a7
[00001d86] 2807                      move.l     d7,d4
[00001d88] 6c0a                      bge.s      x1c42_19
[00001d8a] 2e04                      move.l     d4,d7
x1c42_18:
[00001d8c] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[00001d90] 4e5e                      unlk       a6
[00001d92] 4e75                      rts
x1c42_19:
[00001d94] 4287                      clr.l      d7
[00001d96] 3e2e ffde                 move.w     -34(a6),d7
[00001d9a] 0287 0000 6000            andi.l     #$00006000,d7
[00001da0] 0c87 0000 2000            cmpi.l     #$00002000,d7
[00001da6] 6706                      beq.s      x1c42_20
[00001da8] 4a2e ffe0                 tst.b      -32(a6)
[00001dac] 6604                      bne.s      x1c42_21
x1c42_20:
[00001dae] 7ee3                      moveq.l    #-29,d7
[00001db0] 60da                      bra.s      x1c42_18
x1c42_21:
[00001db2] 2e05                      move.l     d5,d7
[00001db4] 60d6                      bra.s      x1c42_18
[00001db6] 4e56 fffc                 link       a6,#-4
[00001dba] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00001dbe] 2a6e 0008                 movea.l    8(a6),a5
[00001dc2] 284d                      movea.l    a5,a4
[00001dc4] 4aae 000c                 tst.l      12(a6)
[00001dc8] 6c14                      bge.s      x1c42_22
[00001dca] 4aae 0010                 tst.l      16(a6)
[00001dce] 6e0e                      bgt.s      x1c42_22
[00001dd0] 2e2e 000c                 move.l     12(a6),d7
[00001dd4] 4487                      neg.l      d7
[00001dd6] 2d47 000c                 move.l     d7,12(a6)
[00001dda] 18fc 002d                 move.b     #$2D,(a4)+
x1c42_22:
[00001dde] 4aae 0010                 tst.l      16(a6)
[00001de2] 6608                      bne.s      x1c42_23
[00001de4] 700a                      moveq.l    #10,d0
[00001de6] 2d40 0010                 move.l     d0,16(a6)
[00001dea] 6010                      bra.s      x1c42_24
x1c42_23:
[00001dec] 4aae 0010                 tst.l      16(a6)
[00001df0] 6c0a                      bge.s      x1c42_24
[00001df2] 2e2e 0010                 move.l     16(a6),d7
[00001df6] 4487                      neg.l      d7
[00001df8] 2d47 0010                 move.l     d7,16(a6)
x1c42_24:
[00001dfc] 2d6e 0010 fffc            move.l     16(a6),-4(a6)
[00001e02] 4aae 000c                 tst.l      12(a6)
[00001e06] 6d0a                      blt.s      x1c42_25
[00001e08] 2e2e fffc                 move.l     -4(a6),d7
[00001e0c] beae 000c                 cmp.l      12(a6),d7
[00001e10] 6e1c                      bgt.s      x1c42_26
x1c42_25:
[00001e12] 2eae 0010                 move.l     16(a6),(a7)
[00001e16] 2f2e 000c                 move.l     12(a6),-(a7)
[00001e1a] 2f2e fffc                 move.l     -4(a6),-(a7)
[00001e1e] 4eb9 0000 206e            jsr        $0000206E
[00001e24] 2f0c                      move.l     a4,-(a7)
[00001e26] 4eba ff8e                 jsr        $00001DB6(pc)
[00001e2a] 508f                      addq.l     #8,a7
[00001e2c] d9c7                      adda.l     d7,a4
x1c42_26:
[00001e2e] 7e30                      moveq.l    #48,d7
[00001e30] 2eae 000c                 move.l     12(a6),(a7)
[00001e34] 2f2e fffc                 move.l     -4(a6),-(a7)
[00001e38] 4eb9 0000 2066            jsr        $00002066
[00001e3e] de97                      add.l      (a7),d7
[00001e40] 1887                      move.b     d7,(a4)
[00001e42] 4287                      clr.l      d7
[00001e44] 1e14                      move.b     (a4),d7
[00001e46] 0c47 0039                 cmpi.w     #$0039,d7
[00001e4a] 6304                      bls.s      x1c42_27
[00001e4c] 0614 0027                 addi.b     #$27,(a4)
x1c42_27:
[00001e50] 2e0c                      move.l     a4,d7
[00001e52] 9e8d                      sub.l      a5,d7
[00001e54] 5287                      addq.l     #1,d7
[00001e56] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00001e5a] 4e5e                      unlk       a6
[00001e5c] 4e75                      rts

x1e5e:
[00001e5e] 205f                      movea.l    (a7)+,a0
[00001e60] 7e05                      moveq.l    #5,d7
[00001e62] 4e41                      trap       #1
[00001e64] 4ed0                      jmp        (a0)
[00001e66] 4e56 fffc                 link       a6,#-4
[00001e6a] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[00001e6e] 2a6e 0008                 movea.l    8(a6),a5
[00001e72] 286e 000c                 movea.l    12(a6),a4
[00001e76] 2e0d                      move.l     a5,d7
[00001e78] 6618                      bne.s      x1e5e_1
[00001e7a] 2ebc 0002 0898            move.l     #$0002304A,(a7)
[00001e80] 42a7                      clr.l      -(a7)
[00001e82] 4eb9 0000 260a            jsr        $0000260A
[00001e88] 588f                      addq.l     #4,a7
[00001e8a] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[00001e8e] 4e5e                      unlk       a6
[00001e90] 4e75                      rts
x1e5e_1:
[00001e92] 2a2e 0010                 move.l     16(a6),d5
x1e5e_6:
[00001e96] 4a85                      tst.l      d5
[00001e98] 6f32                      ble.s      x1e5e_2
[00001e9a] 45ed 000a                 lea.l      10(a5),a2
[00001e9e] 3e2d 0002                 move.w     2(a5),d7
[00001ea2] 48c7                      ext.l      d7
[00001ea4] d5c7                      adda.l     d7,a2
[00001ea6] 2d4a fffc                 move.l     a2,-4(a6)
x1e5e_4:
[00001eaa] 4a85                      tst.l      d5
[00001eac] 6f68                      ble.s      x1e5e_3
[00001eae] 3e2d 0002                 move.w     2(a5),d7
[00001eb2] 48c7                      ext.l      d7
[00001eb4] 0c47 0200                 cmpi.w     #$0200,d7
[00001eb8] 6c5c                      bge.s      x1e5e_3
[00001eba] 246e fffc                 movea.l    -4(a6),a2
[00001ebe] 52ae fffc                 addq.l     #1,-4(a6)
[00001ec2] 149c                      move.b     (a4)+,(a2)
[00001ec4] 5385                      subq.l     #1,d5
[00001ec6] 526d 0002                 addq.w     #1,2(a5)
[00001eca] 60de                      bra.s      x1e5e_4
x1e5e_2:
[00001ecc] 3e2d 0004                 move.w     4(a5),d7
[00001ed0] 48c7                      ext.l      d7
[00001ed2] 0c47 ffff                 cmpi.w     #$FFFF,d7
[00001ed6] 6764                      beq.s      x1e5e_5
[00001ed8] 4a6d 0002                 tst.w      2(a5)
[00001edc] 675e                      beq.s      x1e5e_5
[00001ede] 3e2d 0002                 move.w     2(a5),d7
[00001ee2] 48c7                      ext.l      d7
[00001ee4] 2447                      movea.l    d7,a2
[00001ee6] 47ed 0009                 lea.l      9(a5),a3
[00001eea] d5cb                      adda.l     a3,a2
[00001eec] 4287                      clr.l      d7
[00001eee] 1e12                      move.b     (a2),d7
[00001ef0] 0c47 000a                 cmpi.w     #$000A,d7
[00001ef4] 6646                      bne.s      x1e5e_5
[00001ef6] 3e2d 0002                 move.w     2(a5),d7
[00001efa] 48c7                      ext.l      d7
[00001efc] 2e87                      move.l     d7,(a7)
[00001efe] 486d 000a                 pea.l      10(a5)
[00001f02] 3e15                      move.w     (a5),d7
[00001f04] 48c7                      ext.l      d7
[00001f06] 2f07                      move.l     d7,-(a7)
[00001f08] 4eb9 0000 2582            jsr        $00002582
[00001f0e] 508f                      addq.l     #8,a7
[00001f10] 426d 0002                 clr.w      2(a5)
[00001f14] 6026                      bra.s      x1e5e_5
x1e5e_3:
[00001f16] 4a85                      tst.l      d5
[00001f18] 6f00 ff7c                 ble        x1e5e_6
[00001f1c] 2ebc 0000 0200            move.l     #$00000200,(a7)
[00001f22] 486d 000a                 pea.l      10(a5)
[00001f26] 3e15                      move.w     (a5),d7
[00001f28] 48c7                      ext.l      d7
[00001f2a] 2f07                      move.l     d7,-(a7)
[00001f2c] 4eb9 0000 2582            jsr        $00002582
[00001f32] 508f                      addq.l     #8,a7
[00001f34] 426d 0002                 clr.w      2(a5)
[00001f38] 6000 ff5c                 bra        x1e5e_6
x1e5e_5:
[00001f3c] 2e2e 0010                 move.l     16(a6),d7
[00001f40] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[00001f44] 4e5e                      unlk       a6
[00001f46] 4e75                      rts

x1f48:
[00001f48] 4e56 0000                 link       a6,#0
[00001f4c] 48e7 8004                 movem.l    d0/a5,-(a7)
[00001f50] 45ee 000c                 lea.l      12(a6),a2
[00001f54] 2a4a                      movea.l    a2,a5
x1f48_2:
[00001f56] 4a95                      tst.l      (a5)
[00001f58] 671c                      beq.s      x1f48_1
[00001f5a] 2e95                      move.l     (a5),(a7)
[00001f5c] 4eb9 0000 25bc            jsr        $000025BC
[00001f62] 2e87                      move.l     d7,(a7)
[00001f64] 2f15                      move.l     (a5),-(a7)
[00001f66] 2f2e 0008                 move.l     8(a6),-(a7)
[00001f6a] 4eb9 0000 2582            jsr        $00002582
[00001f70] 508f                      addq.l     #8,a7
[00001f72] 588d                      addq.l     #4,a5
[00001f74] 60e0                      bra.s      x1f48_2
x1f48_1:
[00001f76] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00001f7a] 4e5e                      unlk       a6
[00001f7c] 4e75                      rts

x1f7e:
[00001f7e] 205f                      movea.l    (a7)+,a0
[00001f80] 7e03                      moveq.l    #3,d7
[00001f82] 4e41                      trap       #1
[00001f84] 4ed0                      jmp        (a0)
[00001f86] 4e56 fffe                 link       a6,#-2
[00001f8a] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00001f8e] 2a6e 0008                 movea.l    8(a6),a5
[00001f92] 1d6e 000f ffff            move.b     15(a6),-1(a6)
[00001f98] 284d                      movea.l    a5,a4
x1f7e_3:
[00001f9a] 4a14                      tst.b      (a4)
[00001f9c] 670e                      beq.s      x1f7e_1
[00001f9e] 4287                      clr.l      d7
[00001fa0] 1e14                      move.b     (a4),d7
[00001fa2] 4286                      clr.l      d6
[00001fa4] 1c2e ffff                 move.b     -1(a6),d6
[00001fa8] be86                      cmp.l      d6,d7
[00001faa] 660c                      bne.s      x1f7e_2
x1f7e_1:
[00001fac] 2e0c                      move.l     a4,d7
[00001fae] 9e8d                      sub.l      a5,d7
[00001fb0] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00001fb4] 4e5e                      unlk       a6
[00001fb6] 4e75                      rts
x1f7e_2:
[00001fb8] 528c                      addq.l     #1,a4
[00001fba] 60de                      bra.s      x1f7e_3
[00001fbc] 205f                      movea.l    (a7)+,a0
[00001fbe] 7e13                      moveq.l    #19,d7
[00001fc0] 4e41                      trap       #1
[00001fc2] 4ed0                      jmp        (a0)
[00001fc4] 4e56 0000                 link       a6,#0
[00001fc8] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00001fcc] 2a6e 0008                 movea.l    8(a6),a5
[00001fd0] 284d                      movea.l    a5,a4
[00001fd2] 4aae 000c                 tst.l      12(a6)
[00001fd6] 6c14                      bge.s      x1f7e_4
[00001fd8] 4aae 0010                 tst.l      16(a6)
[00001fdc] 6e0e                      bgt.s      x1f7e_4
[00001fde] 2e2e 000c                 move.l     12(a6),d7
[00001fe2] 4487                      neg.l      d7
[00001fe4] 2d47 000c                 move.l     d7,12(a6)
[00001fe8] 18fc 002d                 move.b     #$2D,(a4)+
x1f7e_4:
[00001fec] 2e2e 000c                 move.l     12(a6),d7
[00001ff0] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00001ff6] 2a07                      move.l     d7,d5
[00001ff8] 4aae 0010                 tst.l      16(a6)
[00001ffc] 6608                      bne.s      x1f7e_5
[00001ffe] 700a                      moveq.l    #10,d0
[00002000] 2d40 0010                 move.l     d0,16(a6)
[00002004] 6010                      bra.s      x1f7e_6
x1f7e_5:
[00002006] 4aae 0010                 tst.l      16(a6)
[0000200a] 6c0a                      bge.s      x1f7e_6
[0000200c] 2e2e 0010                 move.l     16(a6),d7
[00002010] 4487                      neg.l      d7
[00002012] 2d47 0010                 move.l     d7,16(a6)
x1f7e_6:
[00002016] 2e2e 0010                 move.l     16(a6),d7
[0000201a] be85                      cmp.l      d5,d7
[0000201c] 621a                      bhi.s      x1f7e_7
[0000201e] 2eae 0010                 move.l     16(a6),(a7)
[00002022] 2f05                      move.l     d5,-(a7)
[00002024] 2f2e 0010                 move.l     16(a6),-(a7)
[00002028] 4eb9 0000 206e            jsr        $0000206E
[0000202e] 2f0c                      move.l     a4,-(a7)
[00002030] 4eba ff92                 jsr        $00001FC4(pc)
[00002034] 508f                      addq.l     #8,a7
[00002036] d9c7                      adda.l     d7,a4
x1f7e_7:
[00002038] 7e30                      moveq.l    #48,d7
[0000203a] 2e85                      move.l     d5,(a7)
[0000203c] 2f2e 0010                 move.l     16(a6),-(a7)
[00002040] 4eb9 0000 2066            jsr        $00002066
[00002046] de97                      add.l      (a7),d7
[00002048] 1887                      move.b     d7,(a4)
[0000204a] 4287                      clr.l      d7
[0000204c] 1e14                      move.b     (a4),d7
[0000204e] 0c47 0039                 cmpi.w     #$0039,d7
[00002052] 6304                      bls.s      x1f7e_8
[00002054] 0614 0027                 addi.b     #$27,(a4)
x1f7e_8:
[00002058] 2e0c                      move.l     a4,d7
[0000205a] 9e8d                      sub.l      a5,d7
[0000205c] 5287                      addq.l     #1,d7
[0000205e] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00002062] 4e5e                      unlk       a6
[00002064] 4e75                      rts

x2066:
[00002066] 48e7 7c00                 movem.l    d1-d5,-(a7)
[0000206a] 7aff                      moveq.l    #-1,d5
[0000206c] 6006                      bra.s      x2066_1
[0000206e] 48e7 7c00                 movem.l    d1-d5,-(a7)
[00002072] 4205                      clr.b      d5
x2066_1:
[00002074] 282f 0018                 move.l     24(a7),d4
[00002078] 262f 001c                 move.l     28(a7),d3
[0000207c] 4282                      clr.l      d2
[0000207e] 721f                      moveq.l    #31,d1
[00002080] 4280                      clr.l      d0
x2066_3:
[00002082] e38a                      lsl.l      #1,d2
[00002084] e38b                      lsl.l      #1,d3
[00002086] d580                      addx.l     d0,d2
[00002088] b484                      cmp.l      d4,d2
[0000208a] 6504                      bcs.s      x2066_2
[0000208c] 9484                      sub.l      d4,d2
[0000208e] 5283                      addq.l     #1,d3
x2066_2:
[00002090] 51c9 fff0                 dbf        d1,x2066_3
[00002094] 4a05                      tst.b      d5
[00002096] 6c04                      bge.s      x2066_4
[00002098] 2002                      move.l     d2,d0
[0000209a] 6002                      bra.s      x2066_5
x2066_4:
[0000209c] 2003                      move.l     d3,d0
x2066_5:
[0000209e] 4cdf 003e                 movem.l    (a7)+,d1-d5
[000020a2] 2e9f                      move.l     (a7)+,(a7)
[000020a4] 2f40 0004                 move.l     d0,4(a7)
[000020a8] 4e75                      rts

x20aa:
[000020aa] 4e56 0000                 link       a6,#0
[000020ae] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000020b2] 2a6e 0008                 movea.l    8(a6),a5
[000020b6] 2a2e 000c                 move.l     12(a6),d5
[000020ba] 2e0d                      move.l     a5,d7
[000020bc] de85                      add.l      d5,d7
[000020be] 2847                      movea.l    d7,a4
[000020c0] 2e15                      move.l     (a5),d7
[000020c2] 9e85                      sub.l      d5,d7
[000020c4] 2887                      move.l     d7,(a4)
[000020c6] 296d 0004 0004            move.l     4(a5),4(a4)
[000020cc] 2445                      movea.l    d5,a2
[000020ce] 518a                      subq.l     #8,a2
[000020d0] 2a8a                      move.l     a2,(a5)
[000020d2] 2e0c                      move.l     a4,d7
[000020d4] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000020d8] 4e5e                      unlk       a6
[000020da] 4e75                      rts

x20dc:
[000020dc] 4e56 0000                 link       a6,#0
[000020e0] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000020e4] 2a6e 0008                 movea.l    8(a6),a5
[000020e8] 286d 0004                 movea.l    4(a5),a4
[000020ec] 2e0d                      move.l     a5,d7
[000020ee] de95                      add.l      (a5),d7
[000020f0] 5087                      addq.l     #8,d7
[000020f2] be8c                      cmp.l      a4,d7
[000020f4] 660c                      bne.s      x20dc_1
[000020f6] 2e14                      move.l     (a4),d7
[000020f8] 5087                      addq.l     #8,d7
[000020fa] df95                      add.l      d7,(a5)
[000020fc] 2b6c 0004 0004            move.l     4(a4),4(a5)
x20dc_1:
[00002102] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00002106] 4e5e                      unlk       a6
[00002108] 4e75                      rts

x210a:
[0000210a] 4e56 0000                 link       a6,#0
[0000210e] 48e7 8004                 movem.l    d0/a5,-(a7)
[00002112] 2eae 000c                 move.l     12(a6),(a7)
[00002116] 2f2e 0008                 move.l     8(a6),-(a7)
[0000211a] 4eb9 0000 2144            jsr        $00002144
[00002120] 588f                      addq.l     #4,a7
[00002122] 2a47                      movea.l    d7,a5
[00002124] 2e0d                      move.l     a5,d7
[00002126] 6704                      beq.s      x210a_1
[00002128] 2e0d                      move.l     a5,d7
[0000212a] 6010                      bra.s      x210a_2
x210a_1:
[0000212c] 2ebc 0002 08ae            move.l     #$00023060,(a7)
[00002132] 42a7                      clr.l      -(a7)
[00002134] 4eb9 0000 260a            jsr        $0000260A
[0000213a] 588f                      addq.l     #4,a7
x210a_2:
[0000213c] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00002140] 4e5e                      unlk       a6
[00002142] 4e75                      rts

x2144:
[00002144] 4e56 fffc                 link       a6,#-4
[00002148] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[0000214c] 2a2e 0008                 move.l     8(a6),d5
[00002150] 0c85 0000 0004            cmpi.l     #$00000004,d5
[00002156] 6404                      bcc.s      x2144_1
[00002158] 7e04                      moveq.l    #4,d7
[0000215a] 6002                      bra.s      x2144_2
x2144_1:
[0000215c] 2e05                      move.l     d5,d7
x2144_2:
[0000215e] 5687                      addq.l     #3,d7
[00002160] 7cfc                      moveq.l    #-4,d6
[00002162] cc87                      and.l      d7,d6
[00002164] 2e06                      move.l     d6,d7
[00002166] 5887                      addq.l     #4,d7
[00002168] 2a07                      move.l     d7,d5
x2144_18:
[0000216a] 2a7c 0002 087e            movea.l    #$00023030,a5
x2144_9:
[00002170] 2855                      movea.l    (a5),a4
[00002172] 2e0c                      move.l     a4,d7
[00002174] 6714                      beq.s      x2144_3
[00002176] 2e14                      move.l     (a4),d7
[00002178] 5087                      addq.l     #8,d7
[0000217a] ba87                      cmp.l      d7,d5
[0000217c] 6220                      bhi.s      x2144_4
[0000217e] 2e14                      move.l     (a4),d7
[00002180] be85                      cmp.l      d5,d7
[00002182] 6422                      bcc.s      x2144_5
[00002184] 2aac 0004                 move.l     4(a4),(a5)
[00002188] 6028                      bra.s      x2144_6
x2144_3:
[0000218a] 4ab9 0002 087a            tst.l      $0002302C
[00002190] 662e                      bne.s      x2144_7
[00002192] 23fc 0000 0200 0002 087a  move.l     #$00000200,$0002302C
[0000219c] 603c                      bra.s      x2144_8
x2144_4:
[0000219e] 45ec 0004                 lea.l      4(a4),a2
[000021a2] 2a4a                      movea.l    a2,a5
[000021a4] 60ca                      bra.s      x2144_9
x2144_5:
[000021a6] 2e85                      move.l     d5,(a7)
[000021a8] 2f0c                      move.l     a4,-(a7)
[000021aa] 4eba fefe                 jsr        $000020AA(pc)
[000021ae] 588f                      addq.l     #4,a7
[000021b0] 2a87                      move.l     d7,(a5)
x2144_6:
[000021b2] 296e 000c 0004            move.l     12(a6),4(a4)
[000021b8] 45ec 0004                 lea.l      4(a4),a2
[000021bc] 2e0a                      move.l     a2,d7
[000021be] 6066                      bra.s      x2144_10
x2144_7:
[000021c0] 0cb9 0000 0200 0002 087a  cmpi.l     #$00000200,$0002302C
[000021ca] 670e                      beq.s      x2144_8
[000021cc] 2e39 0002 087a            move.l     $0002302C,d7
[000021d2] e28f                      lsr.l      #1,d7
[000021d4] 23c7 0002 087a            move.l     d7,$0002302C
x2144_8:
[000021da] 97cb                      suba.l     a3,a3
x2144_12:
[000021dc] bab9 0002 087a            cmp.l      $0002302C,d5
[000021e2] 6228                      bhi.s      x2144_11
[000021e4] 2d79 0002 087a fffc       move.l     $0002302C,-4(a6)
[000021ec] 2eae fffc                 move.l     -4(a6),(a7)
[000021f0] 4eb9 0000 26ec            jsr        $000026EC
[000021f6] 2647                      movea.l    d7,a3
[000021f8] 2e0b                      move.l     a3,d7
[000021fa] 6610                      bne.s      x2144_11
[000021fc] 2e39 0002 087a            move.l     $0002302C,d7
[00002202] e28f                      lsr.l      #1,d7
[00002204] 23c7 0002 087a            move.l     d7,$0002302C
[0000220a] 60d0                      bra.s      x2144_12
x2144_11:
[0000220c] 2e0b                      move.l     a3,d7
[0000220e] 6610                      bne.s      x2144_13
[00002210] 2d45 fffc                 move.l     d5,-4(a6)
[00002214] 2eae fffc                 move.l     -4(a6),(a7)
[00002218] 4eb9 0000 26ec            jsr        $000026EC
[0000221e] 2647                      movea.l    d7,a3
x2144_13:
[00002220] 2e0b                      move.l     a3,d7
[00002222] 660a                      bne.s      x2144_14
[00002224] 4287                      clr.l      d7
x2144_10:
[00002226] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[0000222a] 4e5e                      unlk       a6
[0000222c] 4e75                      rts
x2144_14:
[0000222e] 2e2e fffc                 move.l     -4(a6),d7
[00002232] 5187                      subq.l     #8,d7
[00002234] 2687                      move.l     d7,(a3)
[00002236] 4ab9 0002 0882            tst.l      $00023034
[0000223c] 6708                      beq.s      x2144_15
[0000223e] b7f9 0002 0882            cmpa.l     $00023034,a3
[00002244] 6406                      bcc.s      x2144_16
x2144_15:
[00002246] 23cb 0002 0882            move.l     a3,$00023034
x2144_16:
[0000224c] 2e39 0002 0886            move.l     $00023038,d7
[00002252] 2c0b                      move.l     a3,d6
[00002254] dcae fffc                 add.l      -4(a6),d6
[00002258] be86                      cmp.l      d6,d7
[0000225a] 640c                      bcc.s      x2144_17
[0000225c] 2e0b                      move.l     a3,d7
[0000225e] deae fffc                 add.l      -4(a6),d7
[00002262] 23c7 0002 0886            move.l     d7,$00023038
x2144_17:
[00002268] 4297                      clr.l      (a7)
[0000226a] 486b 0004                 pea.l      4(a3)
[0000226e] 4eb9 0000 227a            jsr        $0000227A
[00002274] 588f                      addq.l     #4,a7
[00002276] 6000 fef2                 bra        x2144_18
[0000227a] 4e56 0000                 link       a6,#0
[0000227e] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00002282] 2e2e 0008                 move.l     8(a6),d7
[00002286] 5987                      subq.l     #4,d7
[00002288] 2a47                      movea.l    d7,a5
[0000228a] 4aae 0008                 tst.l      8(a6)
[0000228e] 672c                      beq.s      x2144_19
[00002290] bbf9 0002 0882            cmpa.l     $00023034,a5
[00002296] 650a                      bcs.s      x2144_20
[00002298] 2e39 0002 0886            move.l     $00023038,d7
[0000229e] be8d                      cmp.l      a5,d7
[000022a0] 6226                      bhi.s      x2144_21
x2144_20:
[000022a2] 23fc 0002 088a 0002 08ae  move.l     #$0002303C,$00023060
[000022ac] 2ebc 0002 08ae            move.l     #$00023060,(a7)
[000022b2] 42a7                      clr.l      -(a7)
[000022b4] 4eb9 0000 260a            jsr        $0000260A
[000022ba] 588f                      addq.l     #4,a7
x2144_19:
[000022bc] 2e2e 000c                 move.l     12(a6),d7
[000022c0] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000022c4] 4e5e                      unlk       a6
[000022c6] 4e75                      rts
x2144_21:
[000022c8] 4ab9 0002 087e            tst.l      $00023030
[000022ce] 660c                      bne.s      x2144_22
[000022d0] 42ad 0004                 clr.l      4(a5)
[000022d4] 23cd 0002 087e            move.l     a5,$00023030
[000022da] 60e0                      bra.s      x2144_19
x2144_22:
[000022dc] bbf9 0002 087e            cmpa.l     $00023030,a5
[000022e2] 6416                      bcc.s      x2144_23
[000022e4] 2b79 0002 087e 0004       move.l     $00023030,4(a5)
[000022ec] 23cd 0002 087e            move.l     a5,$00023030
[000022f2] 2e8d                      move.l     a5,(a7)
[000022f4] 4eba fde6                 jsr        $000020DC(pc)
[000022f8] 60c2                      bra.s      x2144_19
x2144_23:
[000022fa] 2879 0002 087e            movea.l    $00023030,a4
x2144_25:
[00002300] 266c 0004                 movea.l    4(a4),a3
[00002304] 2e0b                      move.l     a3,d7
[00002306] 6708                      beq.s      x2144_24
[00002308] b7cd                      cmpa.l     a5,a3
[0000230a] 6404                      bcc.s      x2144_24
[0000230c] 284b                      movea.l    a3,a4
[0000230e] 60f0                      bra.s      x2144_25
x2144_24:
[00002310] 2e0b                      move.l     a3,d7
[00002312] 6716                      beq.s      x2144_26
[00002314] 2b4b 0004                 move.l     a3,4(a5)
[00002318] 294d 0004                 move.l     a5,4(a4)
[0000231c] 2e8d                      move.l     a5,(a7)
[0000231e] 4eba fdbc                 jsr        $000020DC(pc)
[00002322] 2e8c                      move.l     a4,(a7)
[00002324] 4eba fdb6                 jsr        $000020DC(pc)
[00002328] 6092                      bra.s      x2144_19
x2144_26:
[0000232a] 42ad 0004                 clr.l      4(a5)
[0000232e] 294d 0004                 move.l     a5,4(a4)
[00002332] 2e8c                      move.l     a4,(a7)
[00002334] 4eba fda6                 jsr        $000020DC(pc)
[00002338] 6000 ff82                 bra.w      x2144_19
[0000233c] 4e56 fff4                 link       a6,#-12
[00002340] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00002344] 2a6e 0008                 movea.l    8(a6),a5
[00002348] 2a2e 000c                 move.l     12(a6),d5
[0000234c] 42ae fff8                 clr.l      -8(a6)
[00002350] 2d4d fff4                 move.l     a5,-12(a6)
[00002354] 42ae fffc                 clr.l      -4(a6)
x2144_31:
[00002358] 4a85                      tst.l      d5
[0000235a] 6714                      beq.s      x2144_27
[0000235c] 4287                      clr.l      d7
[0000235e] 1e15                      move.b     (a5),d7
[00002360] 0c47 0020                 cmpi.w     #$0020,d7
[00002364] 6324                      bls.s      x2144_28
[00002366] 4287                      clr.l      d7
[00002368] 1e15                      move.b     (a5),d7
[0000236a] 0c47 007f                 cmpi.w     #$007F,d7
[0000236e] 641a                      bcc.s      x2144_28
x2144_27:
[00002370] 4a85                      tst.l      d5
[00002372] 671c                      beq.s      x2144_29
[00002374] 4287                      clr.l      d7
[00002376] 1e15                      move.b     (a5),d7
[00002378] 0c47 002d                 cmpi.w     #$002D,d7
[0000237c] 661a                      bne.s      x2144_30
[0000237e] 7001                      moveq.l    #1,d0
[00002380] 2d40 fffc                 move.l     d0,-4(a6)
[00002384] 528d                      addq.l     #1,a5
[00002386] 5385                      subq.l     #1,d5
[00002388] 6006                      bra.s      x2144_29
x2144_28:
[0000238a] 5385                      subq.l     #1,d5
[0000238c] 528d                      addq.l     #1,a5
[0000238e] 60c8                      bra.s      x2144_31
x2144_29:
[00002390] 4a85                      tst.l      d5
[00002392] 6614                      bne.s      x2144_32
[00002394] 6000 00d6                 bra        x2144_33
x2144_30:
[00002398] 4287                      clr.l      d7
[0000239a] 1e15                      move.b     (a5),d7
[0000239c] 0c47 002b                 cmpi.w     #$002B,d7
[000023a0] 66ee                      bne.s      x2144_29
[000023a2] 528d                      addq.l     #1,a5
[000023a4] 5385                      subq.l     #1,d5
[000023a6] 60e8                      bra.s      x2144_29
x2144_32:
[000023a8] 0cae 0000 0001 0014       cmpi.l     #$00000001,20(a6)
[000023b0] 6614                      bne.s      x2144_34
[000023b2] 4287                      clr.l      d7
[000023b4] 1e15                      move.b     (a5),d7
[000023b6] 0c47 0030                 cmpi.w     #$0030,d7
[000023ba] 6764                      beq.s      x2144_35
[000023bc] 700a                      moveq.l    #10,d0
[000023be] 2d40 0014                 move.l     d0,20(a6)
[000023c2] 6000 00a8                 bra        x2144_33
x2144_34:
[000023c6] 0cae 0000 0010 0014       cmpi.l     #$00000010,20(a6)
[000023ce] 6600 009c                 bne        x2144_33
[000023d2] 0c85 0000 0002            cmpi.l     #$00000002,d5
[000023d8] 6500 0092                 bcs        x2144_33
[000023dc] 4287                      clr.l      d7
[000023de] 1e15                      move.b     (a5),d7
[000023e0] 0c47 0030                 cmpi.w     #$0030,d7
[000023e4] 6600 0086                 bne        x2144_33
[000023e8] 4287                      clr.l      d7
[000023ea] 1e2d 0001                 move.b     1(a5),d7
[000023ee] 0c47 0041                 cmpi.w     #$0041,d7
[000023f2] 6518                      bcs.s      x2144_36
[000023f4] 4287                      clr.l      d7
[000023f6] 1e2d 0001                 move.b     1(a5),d7
[000023fa] 0c47 005a                 cmpi.w     #$005A,d7
[000023fe] 620c                      bhi.s      x2144_36
[00002400] 7e20                      moveq.l    #32,d7
[00002402] 4286                      clr.l      d6
[00002404] 1c2d 0001                 move.b     1(a5),d6
[00002408] de86                      add.l      d6,d7
[0000240a] 6006                      bra.s      x2144_37
x2144_36:
[0000240c] 4287                      clr.l      d7
[0000240e] 1e2d 0001                 move.b     1(a5),d7
x2144_37:
[00002412] 0c87 0000 0078            cmpi.l     #$00000078,d7
[00002418] 6652                      bne.s      x2144_33
[0000241a] 548d                      addq.l     #2,a5
[0000241c] 5585                      subq.l     #2,d5
[0000241e] 604c                      bra.s      x2144_33
x2144_35:
[00002420] 0c85 0000 0001            cmpi.l     #$00000001,d5
[00002426] 633e                      bls.s      x2144_38
[00002428] 4287                      clr.l      d7
[0000242a] 1e2d 0001                 move.b     1(a5),d7
[0000242e] 0c47 0041                 cmpi.w     #$0041,d7
[00002432] 6518                      bcs.s      x2144_39
[00002434] 4287                      clr.l      d7
[00002436] 1e2d 0001                 move.b     1(a5),d7
[0000243a] 0c47 005a                 cmpi.w     #$005A,d7
[0000243e] 620c                      bhi.s      x2144_39
[00002440] 7e20                      moveq.l    #32,d7
[00002442] 4286                      clr.l      d6
[00002444] 1c2d 0001                 move.b     1(a5),d6
[00002448] de86                      add.l      d6,d7
[0000244a] 6006                      bra.s      x2144_40
x2144_39:
[0000244c] 4287                      clr.l      d7
[0000244e] 1e2d 0001                 move.b     1(a5),d7
x2144_40:
[00002452] 0c87 0000 0078            cmpi.l     #$00000078,d7
[00002458] 660c                      bne.s      x2144_38
[0000245a] 7010                      moveq.l    #16,d0
[0000245c] 2d40 0014                 move.l     d0,20(a6)
[00002460] 548d                      addq.l     #2,a5
[00002462] 5585                      subq.l     #2,d5
[00002464] 6006                      bra.s      x2144_33
x2144_38:
[00002466] 7008                      moveq.l    #8,d0
[00002468] 2d40 0014                 move.l     d0,20(a6)
x2144_33:
[0000246c] 4a85                      tst.l      d5
[0000246e] 6720                      beq.s      x2144_41
[00002470] 4287                      clr.l      d7
[00002472] 1e15                      move.b     (a5),d7
[00002474] 0c47 0030                 cmpi.w     #$0030,d7
[00002478] 656a                      bcs.s      x2144_42
[0000247a] 4287                      clr.l      d7
[0000247c] 1e15                      move.b     (a5),d7
[0000247e] 0c47 0039                 cmpi.w     #$0039,d7
[00002482] 6260                      bhi.s      x2144_42
[00002484] 7ed0                      moveq.l    #-48,d7
[00002486] 4286                      clr.l      d6
[00002488] 1c15                      move.b     (a5),d6
[0000248a] de86                      add.l      d6,d7
[0000248c] 2807                      move.l     d7,d4
[0000248e] 606a                      bra.s      x2144_43
x2144_41:
[00002490] 246e 0010                 movea.l    16(a6),a2
[00002494] 2e8a                      move.l     a2,(a7)
[00002496] 4aae fffc                 tst.l      -4(a6)
[0000249a] 6708                      beq.s      x2144_44
[0000249c] 2e2e fff8                 move.l     -8(a6),d7
[000024a0] 4487                      neg.l      d7
[000024a2] 6004                      bra.s      x2144_45
x2144_44:
[000024a4] 2e2e fff8                 move.l     -8(a6),d7
x2144_45:
[000024a8] 2257                      movea.l    (a7),a1
[000024aa] 2287                      move.l     d7,(a1)
[000024ac] 4a85                      tst.l      d5
[000024ae] 6700 00b4                 beq        x2144_46
[000024b2] 4287                      clr.l      d7
[000024b4] 1e15                      move.b     (a5),d7
[000024b6] 0c47 0041                 cmpi.w     #$0041,d7
[000024ba] 6514                      bcs.s      x2144_47
[000024bc] 4287                      clr.l      d7
[000024be] 1e15                      move.b     (a5),d7
[000024c0] 0c47 005a                 cmpi.w     #$005A,d7
[000024c4] 620a                      bhi.s      x2144_47
[000024c6] 7e20                      moveq.l    #32,d7
[000024c8] 4286                      clr.l      d6
[000024ca] 1c15                      move.b     (a5),d6
[000024cc] de86                      add.l      d6,d7
[000024ce] 6004                      bra.s      x2144_48
x2144_47:
[000024d0] 4287                      clr.l      d7
[000024d2] 1e15                      move.b     (a5),d7
x2144_48:
[000024d4] 0c87 0000 006c            cmpi.l     #$0000006C,d7
[000024da] 6600 0088                 bne        x2144_46
[000024de] 528d                      addq.l     #1,a5
[000024e0] 6000 0082                 bra        x2144_46
x2144_42:
[000024e4] 4287                      clr.l      d7
[000024e6] 1e15                      move.b     (a5),d7
[000024e8] 0c47 0061                 cmpi.w     #$0061,d7
[000024ec] 652a                      bcs.s      x2144_49
[000024ee] 4287                      clr.l      d7
[000024f0] 1e15                      move.b     (a5),d7
[000024f2] 0c47 007a                 cmpi.w     #$007A,d7
[000024f6] 6338                      bls.s      x2144_50
[000024f8] 601e                      bra.s      x2144_49
x2144_43:
[000024fa] 2eae fff8                 move.l     -8(a6),(a7)
[000024fe] 2f2e 0014                 move.l     20(a6),-(a7)
[00002502] 4eb9 0000 25de            jsr        $000025DE
[00002508] 2e17                      move.l     (a7),d7
[0000250a] de84                      add.l      d4,d7
[0000250c] 2d47 fff8                 move.l     d7,-8(a6)
[00002510] 5385                      subq.l     #1,d5
[00002512] 528d                      addq.l     #1,a5
[00002514] 6000 ff56                 bra        x2144_33
x2144_49:
[00002518] 4287                      clr.l      d7
[0000251a] 1e15                      move.b     (a5),d7
[0000251c] 0c47 0041                 cmpi.w     #$0041,d7
[00002520] 6500 ff6e                 bcs        x2144_41
[00002524] 4287                      clr.l      d7
[00002526] 1e15                      move.b     (a5),d7
[00002528] 0c47 005a                 cmpi.w     #$005A,d7
[0000252c] 6200 ff62                 bhi        x2144_41
x2144_50:
[00002530] 4287                      clr.l      d7
[00002532] 1e15                      move.b     (a5),d7
[00002534] 0c47 0041                 cmpi.w     #$0041,d7
[00002538] 6514                      bcs.s      x2144_51
[0000253a] 4287                      clr.l      d7
[0000253c] 1e15                      move.b     (a5),d7
[0000253e] 0c47 005a                 cmpi.w     #$005A,d7
[00002542] 620a                      bhi.s      x2144_51
[00002544] 7e20                      moveq.l    #32,d7
[00002546] 4286                      clr.l      d6
[00002548] 1c15                      move.b     (a5),d6
[0000254a] de86                      add.l      d6,d7
[0000254c] 6004                      bra.s      x2144_52
x2144_51:
[0000254e] 4287                      clr.l      d7
[00002550] 1e15                      move.b     (a5),d7
x2144_52:
[00002552] 7ca9                      moveq.l    #-87,d6
[00002554] dc87                      add.l      d7,d6
[00002556] 2806                      move.l     d6,d4
[00002558] 2e2e 0014                 move.l     20(a6),d7
[0000255c] be84                      cmp.l      d4,d7
[0000255e] 6e9a                      bgt.s      x2144_43
[00002560] 6000 ff2e                 bra        x2144_41
x2144_46:
[00002564] 2e0d                      move.l     a5,d7
[00002566] 9eae fff4                 sub.l      -12(a6),d7
[0000256a] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[0000256e] 4e5e                      unlk       a6
[00002570] 4e75                      rts

x2572:
[00002572] 205f                      movea.l    (a7)+,a0
[00002574] 7e06                      moveq.l    #6,d7
[00002576] 4e41                      trap       #1
[00002578] 4ed0                      jmp        (a0)
[0000257a] 205f                      movea.l    (a7)+,a0
[0000257c] 7e1c                      moveq.l    #28,d7
[0000257e] 4e41                      trap       #1
[00002580] 4ed0                      jmp        (a0)
[00002582] 4e56 0000                 link       a6,#0
[00002586] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[0000258a] 2eae 0010                 move.l     16(a6),(a7)
[0000258e] 2f2e 000c                 move.l     12(a6),-(a7)
[00002592] 2f2e 0008                 move.l     8(a6),-(a7)
[00002596] 4eb9 0000 27aa            jsr        $000027AA
[0000259c] 508f                      addq.l     #8,a7
[0000259e] beae 0010                 cmp.l      16(a6),d7
[000025a2] 6710                      beq.s      x2572_1
[000025a4] 2ebc 0002 08e0            move.l     #$00023092,(a7)
[000025aa] 42a7                      clr.l      -(a7)
[000025ac] 4eb9 0000 260a            jsr        $0000260A
[000025b2] 588f                      addq.l     #4,a7
x2572_1:
[000025b4] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[000025b8] 4e5e                      unlk       a6
[000025ba] 4e75                      rts

x25bc:
[000025bc] 4e56 0000                 link       a6,#0
[000025c0] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000025c4] 2a6e 0008                 movea.l    8(a6),a5
[000025c8] 284d                      movea.l    a5,a4
x25bc_2:
[000025ca] 4a14                      tst.b      (a4)
[000025cc] 6704                      beq.s      x25bc_1
[000025ce] 528c                      addq.l     #1,a4
[000025d0] 60f8                      bra.s      x25bc_2
x25bc_1:
[000025d2] 2e0c                      move.l     a4,d7
[000025d4] 9e8d                      sub.l      a5,d7
[000025d6] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000025da] 4e5e                      unlk       a6
[000025dc] 4e75                      rts

x25de:
[000025de] 302f 0008                 move.w     8(a7),d0
[000025e2] c0ef 0006                 mulu.w     6(a7),d0
[000025e6] 3f40 0008                 move.w     d0,8(a7)
[000025ea] 302f 000a                 move.w     10(a7),d0
[000025ee] c0ef 0004                 mulu.w     4(a7),d0
[000025f2] d16f 0008                 add.w      d0,8(a7)
[000025f6] 302f 000a                 move.w     10(a7),d0
[000025fa] c0ef 0006                 mulu.w     6(a7),d0
[000025fe] 426f 000a                 clr.w      10(a7)
[00002602] 2e9f                      move.l     (a7)+,(a7)
[00002604] d1af 0004                 add.l      d0,4(a7)
[00002608] 4e75                      rts

x260a:
[0000260a] 246f 0004                 movea.l    4(a7),a2
[0000260e] 262f 0008                 move.l     8(a7),d3
[00002612] 2803                      move.l     d3,d4
[00002614] 670c                      beq.s      x260a_1
[00002616] 280a                      move.l     a2,d4
[00002618] 0c83 ffff ffff            cmpi.l     #$FFFFFFFF,d3
[0000261e] 6602                      bne.s      x260a_1
[00002620] 4283                      clr.l      d3
x260a_1:
[00002622] 200a                      move.l     a2,d0
[00002624] 6708                      beq.s      x260a_2
[00002626] b5fc ffff ffff            cmpa.l     #$FFFFFFFF,a2
[0000262c] 660a                      bne.s      x260a_3
x260a_2:
[0000262e] 2479 0002 08bc            movea.l    $0002306E,a2
[00002634] 200a                      move.l     a2,d0
[00002636] 674e                      beq.s      x260a_4
x260a_3:
[00002638] 4a83                      tst.l      d3
[0000263a] 6626                      bne.s      x260a_5
[0000263c] 4287                      clr.l      d7
x260a_12:
[0000263e] 2e4a                      movea.l    a2,a7
[00002640] 4a84                      tst.l      d4
[00002642] 6600 0096                 bne        x260a_6
[00002646] 202a 0028                 move.l     40(a2),d0
[0000264a] 6704                      beq.s      x260a_7
[0000264c] 2040                      movea.l    d0,a0
[0000264e] 2083                      move.l     d3,(a0)
x260a_7:
[00002650] 23df 0002 08bc            move.l     (a7)+,$0002306E
[00002656] 4cdf 783a                 movem.l    (a7)+,d1/d3-d5/a3-a6
[0000265a] 4e75                      rts
x260a_8:
[0000265c] 2452                      movea.l    (a2),a2
[0000265e] 200a                      move.l     a2,d0
[00002660] 6724                      beq.s      x260a_4
x260a_5:
[00002662] 41ea 002c                 lea.l      44(a2),a0
[00002666] 2e08                      move.l     a0,d7
x260a_11:
[00002668] 0c90 ffff ffff            cmpi.l     #$FFFFFFFF,(a0)
[0000266e] 67ec                      beq.s      x260a_8
[00002670] 4a98                      tst.l      (a0)+
[00002672] 6604                      bne.s      x260a_9
[00002674] 4284                      clr.l      d4
[00002676] 6006                      bra.s      x260a_10
x260a_9:
[00002678] b6a8 fffc                 cmp.l      -4(a0),d3
[0000267c] 66ea                      bne.s      x260a_11
x260a_10:
[0000267e] 9e88                      sub.l      a0,d7
[00002680] 4487                      neg.l      d7
[00002682] e487                      asr.l      #2,d7
[00002684] 60b8                      bra.s      x260a_12
x260a_4:
[00002686] 42a7                      clr.l      -(a7)
[00002688] 4a83                      tst.l      d3
[0000268a] 6706                      beq.s      x260a_13
[0000268c] 0803 0000                 btst       #0,d3
[00002690] 6706                      beq.s      x260a_14
x260a_13:
[00002692] 263c 0002 08c0            move.l     #$00023072,d3
x260a_14:
[00002698] 2043                      movea.l    d3,a0
[0000269a] 2f10                      move.l     (a0),-(a7)
[0000269c] 4eb9 0000 276c            jsr        $0000276C
x260a_15:
[000026a2] 4e71                      nop
[000026a4] 60fc                      bra.s      x260a_15
[000026a6] 2039 0002 08bc            move.l     $0002306E,d0
[000026ac] 720c                      moveq.l    #12,d1
[000026ae] 48e7 dc1e                 movem.l    d0-d1/d3-d5/a3-a6,-(a7)
[000026b2] 244f                      movea.l    a7,a2
[000026b4] 202a 0028                 move.l     40(a2),d0
[000026b8] 6704                      beq.s      x260a_16
[000026ba] 2040                      movea.l    d0,a0
[000026bc] 208a                      move.l     a2,(a0)
x260a_16:
[000026be] 41ea 002c                 lea.l      44(a2),a0
x260a_18:
[000026c2] 4a90                      tst.l      (a0)
[000026c4] 6712                      beq.s      x260a_17
[000026c6] 0c98 ffff ffff            cmpi.l     #$FFFFFFFF,(a0)+
[000026cc] 670a                      beq.s      x260a_17
[000026ce] 06aa 0000 0004 0004       addi.l     #$00000004,4(a2)
[000026d6] 60ea                      bra.s      x260a_18
x260a_17:
[000026d8] 7eff                      moveq.l    #-1,d7
x260a_6:
[000026da] 23ca 0002 08bc            move.l     a2,$0002306E
[000026e0] 206a 0024                 movea.l    36(a2),a0
[000026e4] 4cd2 783b                 movem.l    (a2),d0-d1/d3-d5/a3-a6
[000026e8] 9fc1                      suba.l     d1,a7
[000026ea] 4ed0                      jmp        (a0)
[000026ec] 205f                      movea.l    (a7)+,a0
[000026ee] 2e17                      move.l     (a7),d7
[000026f0] 5287                      addq.l     #1,d7
[000026f2] 0887 0000                 bclr       #0,d7
[000026f6] deb9 0002 08d8            add.l      $0002308A,d7
[000026fc] 2f07                      move.l     d7,-(a7)
[000026fe] 7e11                      moveq.l    #17,d7
[00002700] 4e41                      trap       #1
[00002702] 0c87 ffff ffff            cmpi.l     #$FFFFFFFF,d7
[00002708] 6606                      bne.s      x260a_19
[0000270a] 4a9f                      tst.l      (a7)+
[0000270c] 4287                      clr.l      d7
[0000270e] 4ed0                      jmp        (a0)
x260a_19:
[00002710] 2e39 0002 08d8            move.l     $0002308A,d7
[00002716] 23df 0002 08d8            move.l     (a7)+,$0002308A
[0000271c] 4ab9 0002 08dc            tst.l      $0002308E
[00002722] 670a                      beq.s      x260a_20
[00002724] 23f9 0002 08d8 0002 08dc  move.l     $0002308A,$0002308E
x260a_20:
[0000272e] 4ed0                      jmp        (a0)
[00002730] 4e56 0000                 link       a6,#0
[00002734] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00002738] 2a6e 0008                 movea.l    8(a6),a5
[0000273c] 2e0d                      move.l     a5,d7
[0000273e] 670e                      beq.s      x260a_21
[00002740] 4a15                      tst.b      (a5)
[00002742] 670a                      beq.s      x260a_21
[00002744] 284d                      movea.l    a5,a4
x260a_23:
[00002746] 4a14                      tst.b      (a4)
[00002748] 670c                      beq.s      x260a_22
[0000274a] 528c                      addq.l     #1,a4
[0000274c] 60f8                      bra.s      x260a_23
x260a_21:
[0000274e] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00002752] 4e5e                      unlk       a6
[00002754] 4e75                      rts
x260a_22:
[00002756] 2e0c                      move.l     a4,d7
[00002758] 9e8d                      sub.l      a5,d7
[0000275a] 2e87                      move.l     d7,(a7)
[0000275c] 2f0d                      move.l     a5,-(a7)
[0000275e] 4878 0002                 pea.l      ($00000002).w
[00002762] 4eb9 0000 27aa            jsr        $000027AA
[00002768] 508f                      addq.l     #8,a7
[0000276a] 60e2                      bra.s      x260a_21
[0000276c] 4e56 fffc                 link       a6,#-4
[00002770] 2eb9 0002 08f6            move.l     $000230A8,(a7)
[00002776] 4eba ffb8                 jsr        $00002730(pc)
[0000277a] 2ebc 0002 08f2            move.l     #$000230A4,(a7)
[00002780] 4eba ffae                 jsr        $00002730(pc)
[00002784] 2eae 0008                 move.l     8(a6),(a7)
[00002788] 4eba ffa6                 jsr        $00002730(pc)
[0000278c] 2eae 000c                 move.l     12(a6),(a7)
[00002790] 4eba ff9e                 jsr        $00002730(pc)
[00002794] 2ebc 0002 08f0            move.l     #$000230A2,(a7)
[0000279a] 4eba ff94                 jsr        $00002730(pc)
[0000279e] 4297                      clr.l      (a7)
[000027a0] 4eb9 0000 0080            jsr        $00000080
[000027a6] 4e5e                      unlk       a6
[000027a8] 4e75                      rts

x27aa:
[000027aa] 205f                      movea.l    (a7)+,a0
[000027ac] 7e04                      moveq.l    #4,d7
[000027ae] 4e41                      trap       #1
[000027b0] 4ed0                      jmp        (a0)

	.data
[000027b2]                           dc.b $00
[000027b3]                           dc.b 'idr68k Edition 3.0: Copyright (c) 1981,1983,1985 by Whitesmiths, Ltd. all rights reserved',0
[0000280d]                           dc.b '|/bin/|/usr/bin/',0
[0000281e]                           dc.b 'PATH',0
[00002823]                           dc.b $00
[00002824]                           dc.b $00
[00002825]                           dc.b $00
[00002826]                           dc.b $00
[00002827]                           dc.b $00
[00002828]                           dc.b $00
[00002829]                           dc.b $00
[0000282a]                           dc.b $00
[0000282b]                           dc.b $00
[0000282c] 0002005b                  dc.l $0002005b ; no symbol found
[00002830] 000000aa                  dc.l $000000aa ; no symbol found
_aflag:
[00002834]                           dc.l 0
_fflag:
[00002838]                           dc.l 0
_iflag:
[0000283c]                           dc.l 0
_lflag:
[00002840]                           dc.l 0
_pflag:
[00002844]                           dc.l 0
_rflag:
[00002848]                           dc.l 0
_slp:
[0000284c]                           dc.l 0
_tflag:
[00002850]                           dc.l 0
_pu:
[00002854]                           dc.l 0
_tinode:
[00002858] 000200aa                  dc.l $000200aa ; no symbol found
[0000285c]                           dc.b '/dev/inode',0
[00002867]                           dc.b $00
_tmount:
[00002868] 000200ba                  dc.l $000200ba ; no symbol found
[0000286c]                           dc.b '/dev/mount',0
[00002877]                           dc.b $00
_tmyps:
[00002878] 000200ca                  dc.l $000200ca ; no symbol found
[0000287c]                           dc.b '/dev/myps',0
_tps:
[00002886] 000200d8                  dc.l $000200d8 ; no symbol found
[0000288a]                           dc.b '/dev/ps',0
[00002892]                           dc.b $00
[00002893]                           dc.b $00
[00002894]                           dc.b $00
[00002895]                           dc.b $00
[00002896]                           dc.b '/dev/bnames',0
[000028a2]                           dc.b '/dev/cnames',0
[000028ae]                           dc.b $00
[000028af]                           dc.b $00
[000028b0]                           dc.b $00
[000028b1]                           dc.b $00
[000028b2]                           dc.b $00
[000028b3]                           dc.b $00
[000028b4]                           dc.b $00
[000028b5]                           dc.b $00
[000028b6]                           dc.b $00
[000028b7]                           dc.b $00
[000028b8]                           dc.b $00
[000028b9]                           dc.b $00
[000028ba]                           dc.w $0a00
[000028bc]                           dc.b '-[a f i l p r s# t]\n',0
[000028d1]                           dc.b 'a,f,i,l,p,r,s#,t:F',0
[000028e4]                           dc.w $0a00
[000028e6]                           dc.b ' %5i',0
[000028eb]                           dc.b ' %+07o %3i %6l',0
[000028fa]                           dc.b '%+03o %2i %4s %- 7p %4i',0
[00002912]                           dc.b 'FLG REF LAST  DEV   INUM    MODE  LNK  SIZE ADDRS\n',0
[00002945]                           dc.b 'inodes:\n',0
[0000294e]                           dc.b $00
[0000294f]                           dc.b $00
[00002950]                           dc.b $00
[00002951]                           dc.b $00
[00002952]                           dc.b $00
[00002953]                           dc.b $00
[00002954]                           dc.b $00
[00002955]                           dc.b $00
[00002956]                           dc.b $00
[00002957]                           dc.b $00
stat_names:
[00002958] 000201e9                  dc.l $000201e9 ; no symbol found
[0000295c] 000201e4                  dc.l $000201e4 ; no symbol found
[00002960] 000201df                  dc.l $000201df ; no symbol found
[00002964] 000201da                  dc.l $000201da ; no symbol found
[00002968] 000201d5                  dc.l $000201d5 ; no symbol found
[0000296c] 000201d0                  dc.l $000201d0 ; no symbol found
[00002970] 000201cb                  dc.l $000201cb ; no symbol found
[00002974] 000201c6                  dc.l $000201c6 ; no symbol found
[00002978]                           dc.b 'move',0
[0000297d]                           dc.b 'exit',0
[00002982]                           dc.b 'shr ',0
[00002987]                           dc.b 'wait',0
[0000298c]                           dc.b 'run ',0
[00002991]                           dc.b 'exec',0
[00002996]                           dc.b 'doze',0
[0000299b]                           dc.b '?  ',0
[0000299f]                           dc.b $0a
[000029a0]                           dc.b $00
[000029a1]                           dc.b $00
[000029a2]                           dc.b ' -- core dumped',0
[000029b2]                           dc.b ' signal %p%p',0
[000029bf]                           dc.b '(success)',0
[000029c9]                           dc.b '(failure)',0
[000029d3]                           dc.b ' exit status %i %p',0
[000029e6]                           dc.b ' free=%i',0
[000029ef]                           dc.b '        zombie %i %- 8p',0
[00002a07]                           dc.b $0a
[00002a08]                           dc.b $00
[00002a09]                           dc.b 'alarm=%i ',0
[00002a13]                           dc.b 'sig=%p ',0
[00002a1b]                           dc.b 'slice=%i ',0
[00002a25]                           dc.b 'bias=%i ',0
[00002a2e]                           dc.b 'runpri=%i ',0
[00002a39]                           dc.b 'free=%i ',0
[00002a42]                           dc.b '        user=%p ',0
[00002a53]                           dc.b $0a
[00002a54]                           dc.b $00
[00002a55]                           dc.b ' %3i %5us %5us %5us %5us %8b %8hi %p',0
[00002a7a]                           dc.b 'none',0
[00002a7f]                           dc.b '%5us %p %p',0
[00002a8a]                           dc.b '%5us %p %- 8p',0
[00002a98]                           dc.b '%5us %p %p\n',0
[00002aa4]                           dc.b '%5us %p %- 25p%5us %5us %8b\n',0
[00002ac1]                           dc.b 'WIOALMFX',0
[00002aca]                           dc.b '  PID STAT NAME     PRI  PPID  PGRP  BASE  SIZE  FLAGS    CHANNEL DEV\n',0
[00002b11]                           dc.b $00
[00002b12]                           dc.b 'device err ',0
[00002b1e]                           dc.b 'can',$27,'t open: ',0
[00002b2b]                           dc.b $00
[00002b2c]                           dc.b $00
[00002b2d]                           dc.b $00
[00002b2e]                           dc.b $00
[00002b2f]                           dc.b $00
[00002b30]                           dc.b $00
[00002b31]                           dc.b $00
[00002b32]                           dc.b $00
[00002b33]                           dc.b $00
[00002b34]                           dc.b $00
[00002b35]                           dc.b $00
[00002b36]                           dc.b $00
[00002b37]                           dc.b $00
[00002b38]                           dc.b $00
[00002b39]                           dc.b $00
[00002b3a]                           dc.b $00
[00002b3b]                           dc.b $00
[00002b3c]                           dc.b $00
[00002b3d]                           dc.b $00
[00002b3e]                           dc.b $00
[00002b3f]                           dc.b $00
[00002b40] 00000a7c                  dc.l $00000a7c ; no symbol found
[00002b44]                           dc.l $11
[00002b48] 00000a72                  dc.l $00000a72 ; no symbol found
[00002b4c]                           dc.l $0010
[00002b50] 00000a68                  dc.l $00000a68 ; no symbol found
[00002b54]                           dc.b $000f
[00002b58] 00000a5e                  dc.l $00000a5e ; no symbol found
[00002b5c]                           dc.b $000e
[00002b60] 00000a54                  dc.l $00000a54 ; no symbol found
[00002b64]                           dc.b $000d
[00002b68] 00000a4a                  dc.l $00000a4a ; no symbol found
[00002b6c]                           dc.b $000c
[00002b70] 00000a40                  dc.l $00000a40 ; no symbol found
[00002b74]                           dc.b $000b
[00002b78] 00000a36                  dc.l $00000a36 ; no symbol found
[00002b7c]                           dc.b $000a
[00002b80] 00000a2c                  dc.l $00000a2c ; no symbol found
[00002b84]                           dc.b $0009
[00002b88] 00000a22                  dc.l $00000a22 ; no symbol found
[00002b8c]                           dc.b $0008
[00002b90] 00000a18                  dc.l $00000a18 ; no symbol found
[00002b94]                           dc.b $0007
[00002b98] 00000a0e                  dc.l $00000a0e ; no symbol found
[00002b9c]                           dc.b $0006
[00002ba0] 00000a04                  dc.l $00000a04 ; no symbol found
[00002ba4]                           dc.b $0005
[00002ba8] 000009fa                  dc.l $000009fa ; no symbol found
[00002bac]                           dc.b $0004
[00002bb0] 000009f0                  dc.l $000009f0 ; no symbol found
[00002bb4]                           dc.b $0003
[00002bb8] 000009e6                  dc.l $000009e6 ; no symbol found
[00002bbc]                           dc.b $0002
[00002bc0] 000009dc                  dc.l $000009dc ; no symbol found
[00002bc4]                           dc.b $0001
[00002bc8]                           dc.b $00
[00002bc9]                           dc.b $00
[00002bca]                           dc.b $00
[00002bcb]                           dc.b $00
[00002bcc] 00000a86                  dc.l $00000a86 ; no symbol found
[00002bd0]                           dc.b 'signal#%i',0
[00002bda]                           dc.b 'user signal',0
[00002be6]                           dc.b 'system call intercept',0
[00002bfc]                           dc.b 'terminate',0
[00002c06]                           dc.b 'alarm',0
[00002c0c]                           dc.b 'broken pipe',0
[00002c18]                           dc.b 'bad system call',0
[00002c28]                           dc.b 'segementation (bad address) error',0
[00002c4a]                           dc.b 'bus error',0
[00002c54]                           dc.b 'kill',0
[00002c59]                           dc.b 'floating point/ aritmetic fault',0
[00002c79]                           dc.b 'domain error',0
[00002c86]                           dc.b 'range error',0
[00002c92]                           dc.b 'trace trap',0
[00002c9d]                           dc.b 'illegal instruction',0
[00002cb1]                           dc.b 'quit',0
[00002cb6]                           dc.b 'interrupt',0
[00002cc0]                           dc.b 'hangup',0
[00002cc7]                           dc.b $00
[00002cc8]                           dc.b $00
[00002cc9]                           dc.b $00
[00002cca]                           dc.b $00
[00002ccb]                           dc.b $00
[00002ccc]                           dc.b $00
[00002ccd]                           dc.b $00
[00002cce]                           dc.b $00
[00002ccf]                           dc.b $00
[00002cd0]                           dc.b $00
[00002cd1]                           dc.b $00
[00002cd2]                           dc.b $00
[00002cd3]                           dc.b $00
[00002cd4]                           dc.b $00
[00002cd5]                           dc.b $00
[00002cd6]                           dc.b $00
[00002cd7]                           dc.b $00
[00002cd8]                           dc.b $00
[00002cd9]                           dc.b $00
[00002cda]                           dc.b $00
[00002cdb]                           dc.b $00
[00002cdc]                           dc.w $3a0a
[00002cde]                           dc.b $00
[00002cdf]                           dc.b $25
[00002ce0]                           dc.w $6900
[00002ce2]                           dc.w $3a0a
[00002ce4]                           dc.b $00
[00002ce5]                           dc.b $00
[00002ce6]                           dc.b $00
[00002ce7]                           dc.b $00
[00002ce8]                           dc.b $00
[00002ce9]                           dc.b $00
[00002cea]                           dc.b $00
[00002ceb]                           dc.b $00
[00002cec]                           dc.b $00
[00002ced]                           dc.b $00
[00002cee]                           dc.b $00
[00002cef]                           dc.b $00
[00002cf0]                           dc.b $00
[00002cf1]                           dc.b $00
[00002cf2]                           dc.b $00
[00002cf3]                           dc.b $00
[00002cf4]                           dc.b $00
[00002cf5]                           dc.b $00
[00002cf6]                           dc.b $00
[00002cf7]                           dc.b $00
[00002cf8]                           dc.b $00
[00002cf9]                           dc.b $00
[00002cfa]                           dc.b $00
[00002cfb]                           dc.b $00
[00002cfc]                           dc.b $00
[00002cfd]                           dc.b $00
[00002cfe]                           dc.b $00
[00002cff]                           dc.b $00
[00002d00]                           dc.b $00
[00002d01]                           dc.b $00
[00002d02]                           dc.b $00
[00002d03]                           dc.b $00
[00002d04]                           dc.b $00
[00002d05]                           dc.b $00
[00002d06]                           dc.b $00
[00002d07]                           dc.b $00
[00002d08]                           dc.b $00
[00002d09]                           dc.b $00
[00002d0a]                           dc.b $00
[00002d0b]                           dc.b $00
[00002d0c]                           dc.b $00
[00002d0d]                           dc.b $00
[00002d0e]                           dc.b $00
[00002d0f]                           dc.b $00
[00002d10]                           dc.b $00
[00002d11]                           dc.b $00
[00002d12]                           dc.b $00
[00002d13]                           dc.b $00
[00002d14]                           dc.b $00
[00002d15]                           dc.b $00
[00002d16]                           dc.b $00
[00002d17]                           dc.b $00
[00002d18]                           dc.b $00
[00002d19]                           dc.b $00
[00002d1a]                           dc.b $00
[00002d1b]                           dc.b $00
[00002d1c]                           dc.b $00
[00002d1d]                           dc.b $00
[00002d1e]                           dc.b $00
[00002d1f]                           dc.b $00
[00002d20]                           dc.b $00
[00002d21]                           dc.b $00
[00002d22]                           dc.b $00
[00002d23]                           dc.b $00
[00002d24]                           dc.b $00
[00002d25]                           dc.b $00
[00002d26]                           dc.b $00
[00002d27]                           dc.b $00
[00002d28]                           dc.b $00
[00002d29]                           dc.b $00
[00002d2a]                           dc.b $00
[00002d2b]                           dc.b $00
[00002d2c]                           dc.b $00
[00002d2d]                           dc.b $00
[00002d2e]                           dc.b $00
[00002d2f]                           dc.b $00
[00002d30]                           dc.b $00
[00002d31]                           dc.b $00
[00002d32]                           dc.b $00
[00002d33]                           dc.b $00
[00002d34]                           dc.b $00
[00002d35]                           dc.b $00
[00002d36]                           dc.b $00
[00002d37]                           dc.b $00
[00002d38]                           dc.b $00
[00002d39]                           dc.b $00
[00002d3a]                           dc.b $00
[00002d3b]                           dc.b $00
[00002d3c]                           dc.b $00
[00002d3d]                           dc.b $00
[00002d3e]                           dc.b $00
[00002d3f]                           dc.b $00
[00002d40]                           dc.b $00
[00002d41]                           dc.b $00
[00002d42]                           dc.b $00
[00002d43]                           dc.b $00
[00002d44]                           dc.b $00
[00002d45]                           dc.b $00
[00002d46]                           dc.b $00
[00002d47]                           dc.b $00
[00002d48]                           dc.b $00
[00002d49]                           dc.b $00
[00002d4a]                           dc.b $00
[00002d4b]                           dc.b $00
[00002d4c]                           dc.b $00
[00002d4d]                           dc.b $00
[00002d4e]                           dc.b $00
[00002d4f]                           dc.b $00
[00002d50]                           dc.b $00
[00002d51]                           dc.b $00
[00002d52]                           dc.b $00
[00002d53]                           dc.b $00
[00002d54]                           dc.b $00
[00002d55]                           dc.b $00
[00002d56]                           dc.b $00
[00002d57]                           dc.b $00
[00002d58]                           dc.b $00
[00002d59]                           dc.b $00
[00002d5a]                           dc.b $00
[00002d5b]                           dc.b $00
[00002d5c]                           dc.b $00
[00002d5d]                           dc.b $00
[00002d5e]                           dc.b $00
[00002d5f]                           dc.b $00
[00002d60]                           dc.b $00
[00002d61]                           dc.b $00
[00002d62]                           dc.b $00
[00002d63]                           dc.b $00
[00002d64]                           dc.b $00
[00002d65]                           dc.b $00
[00002d66]                           dc.b $ff
[00002d67]                           dc.b 'bad record in /adm/passwd\n',0
[00002d82]                           dc.w $3a0a
[00002d84]                           dc.b $00
[00002d85]                           dc.b '/adm/passwd',0
[00002d91]                           dc.b $3a
[00002d92]                           dc.w $0a00
[00002d94]                           dc.w $0a00
[00002d96]                           dc.w $5d00
[00002d98]                           dc.w $2000
[00002d9a]                           dc.w $5e00
[00002d9c]                           dc.w $2000
[00002d9e]                           dc.w $2d5b
[00002da0]                           dc.b $00
[00002da1]                           dc.b $00
[00002da2] 00001760                  dc.l $00001760 ; no symbol found
[00002da6]                           dc.b $00
[00002da7]                           dc.b $00
[00002da8]                           dc.b $00
[00002da9]                           dc.b $3e
[00002daa] 000016fe                  dc.l $000016fe ; no symbol found
[00002dae]                           dc.b $00
[00002daf]                           dc.b $00
[00002db0]                           dc.b $00
[00002db1]                           dc.b $00
[00002db2] 000016fe                  dc.l $000016fe ; no symbol found
[00002db6]                           dc.b $00
[00002db7]                           dc.b $00
[00002db8]                           dc.b $00
[00002db9]                           dc.b $3a
[00002dba] 000016fe                  dc.l $000016fe ; no symbol found
[00002dbe]                           dc.b $00
[00002dbf]                           dc.b $00
[00002dc0]                           dc.b $00
[00002dc1]                           dc.b $2c
[00002dc2] 00001674                  dc.l $00001674 ; no symbol found
[00002dc6]                           dc.b $00
[00002dc7]                           dc.b $00
[00002dc8]                           dc.b $00
[00002dc9]                           dc.b $23
[00002dca] 00001638                  dc.l $00001638 ; no symbol found
[00002dce]                           dc.b $00
[00002dcf]                           dc.b $00
[00002dd0]                           dc.b $00
[00002dd1]                           dc.b $3f
[00002dd2] 000015c8                  dc.l $000015c8 ; no symbol found
[00002dd6]                           dc.b $00
[00002dd7]                           dc.b $00
[00002dd8]                           dc.b $00
[00002dd9]                           dc.b $2a
[00002dda]                           dc.b $00
[00002ddb]                           dc.b $00
[00002ddc]                           dc.b $00
[00002ddd]                           dc.b $00
[00002dde] 00001808                  dc.l $00001808 ; no symbol found
[00002de2]                           dc.b 'help',0
[00002de7]                           dc.b $2d
[00002de8]                           dc.b $00
[00002de9]                           dc.b $2d
[00002dea]                           dc.w $2d00
[00002dec]                           dc.w $0a09
[00002dee]                           dc.b $00
[00002def]                           dc.b $00
[00002df0]                           dc.w $0a00
[00002df2]                           dc.b $00
[00002df3]                           dc.b $01
[00002df4]                           dc.b $00
[00002df5]                           dc.b $00
[00002df6]                           dc.b $00
[00002df7]                           dc.b $01
[00002df8]                           dc.b $00
[00002df9]                           dc.b $00
[00002dfa]                           dc.b $00
[00002dfb]                           dc.b $00
[00002dfc]                           dc.b $00
[00002dfd]                           dc.b $00
[00002dfe]                           dc.b $00
[00002dff]                           dc.b $00
[00002e00]                           dc.b $00
[00002e01]                           dc.b $00
[00002e02]                           dc.b $00
[00002e03]                           dc.b $00
[00002e04]                           dc.b $00
[00002e05]                           dc.b $00
[00002e06]                           dc.b $00
[00002e07]                           dc.b $00
[00002e08]                           dc.b $00
[00002e09]                           dc.b $00
[00002e0a]                           dc.b $00
[00002e0b]                           dc.b $00
[00002e0c]                           dc.b $00
[00002e0d]                           dc.b $00
[00002e0e]                           dc.b $00
[00002e0f]                           dc.b $00
[00002e10]                           dc.b $00
[00002e11]                           dc.b $00
[00002e12]                           dc.b $00
[00002e13]                           dc.b $00
[00002e14]                           dc.b $00
[00002e15]                           dc.b $00
[00002e16]                           dc.b $00
[00002e17]                           dc.b $00
[00002e18]                           dc.b $00
[00002e19]                           dc.b $00
[00002e1a]                           dc.b $00
[00002e1b]                           dc.b $00
[00002e1c]                           dc.b $00
[00002e1d]                           dc.b $00
[00002e1e]                           dc.b $00
[00002e1f]                           dc.b $00
[00002e20]                           dc.b $00
[00002e21]                           dc.b $00
[00002e22]                           dc.b $00
[00002e23]                           dc.b $00
[00002e24]                           dc.b $00
[00002e25]                           dc.b $00
[00002e26]                           dc.b $00
[00002e27]                           dc.b $00
[00002e28]                           dc.b $00
[00002e29]                           dc.b $00
[00002e2a]                           dc.b $00
[00002e2b]                           dc.b $00
[00002e2c]                           dc.b $00
[00002e2d]                           dc.b $00
[00002e2e]                           dc.b $00
[00002e2f]                           dc.b $00
[00002e30]                           dc.b $00
[00002e31]                           dc.b $00
[00002e32]                           dc.b $00
[00002e33]                           dc.b $00
[00002e34]                           dc.b $00
[00002e35]                           dc.b $00
[00002e36]                           dc.b $00
[00002e37]                           dc.b $00
[00002e38]                           dc.b $00
[00002e39]                           dc.b $00
[00002e3a]                           dc.b $00
[00002e3b]                           dc.b $00
[00002e3c]                           dc.b $00
[00002e3d]                           dc.b $00
[00002e3e]                           dc.b $00
[00002e3f]                           dc.b $00
[00002e40]                           dc.b $00
[00002e41]                           dc.b $00
[00002e42]                           dc.b $00
[00002e43]                           dc.b $00
[00002e44]                           dc.b $00
[00002e45]                           dc.b $00
[00002e46]                           dc.b $00
[00002e47]                           dc.b $00
[00002e48]                           dc.b $00
[00002e49]                           dc.b $00
[00002e4a]                           dc.b $00
[00002e4b]                           dc.b $00
[00002e4c]                           dc.b $00
[00002e4d]                           dc.b $00
[00002e4e]                           dc.b $00
[00002e4f]                           dc.b $00
[00002e50]                           dc.b $00
[00002e51]                           dc.b $00
[00002e52]                           dc.b $00
[00002e53]                           dc.b $00
[00002e54]                           dc.b $00
[00002e55]                           dc.b $00
[00002e56]                           dc.b $00
[00002e57]                           dc.b $00
[00002e58]                           dc.b $00
[00002e59]                           dc.b $00
[00002e5a]                           dc.b $00
[00002e5b]                           dc.b $00
[00002e5c]                           dc.b $00
[00002e5d]                           dc.b $00
[00002e5e]                           dc.b $00
[00002e5f]                           dc.b $00
[00002e60]                           dc.b $00
[00002e61]                           dc.b $00
[00002e62]                           dc.b $00
[00002e63]                           dc.b $00
[00002e64]                           dc.b $00
[00002e65]                           dc.b $00
[00002e66]                           dc.b $00
[00002e67]                           dc.b $00
[00002e68]                           dc.b $00
[00002e69]                           dc.b $00
[00002e6a]                           dc.b $00
[00002e6b]                           dc.b $00
[00002e6c]                           dc.b $00
[00002e6d]                           dc.b $00
[00002e6e]                           dc.b $00
[00002e6f]                           dc.b $00
[00002e70]                           dc.b $00
[00002e71]                           dc.b $00
[00002e72]                           dc.b $00
[00002e73]                           dc.b $00
[00002e74]                           dc.b $00
[00002e75]                           dc.b $00
[00002e76]                           dc.b $00
[00002e77]                           dc.b $00
[00002e78]                           dc.b $00
[00002e79]                           dc.b $00
[00002e7a]                           dc.b $00
[00002e7b]                           dc.b $00
[00002e7c]                           dc.b $00
[00002e7d]                           dc.b $00
[00002e7e]                           dc.b $00
[00002e7f]                           dc.b $00
[00002e80]                           dc.b $00
[00002e81]                           dc.b $00
[00002e82]                           dc.b $00
[00002e83]                           dc.b $00
[00002e84]                           dc.b $00
[00002e85]                           dc.b $00
[00002e86]                           dc.b $00
[00002e87]                           dc.b $00
[00002e88]                           dc.b $00
[00002e89]                           dc.b $00
[00002e8a]                           dc.b $00
[00002e8b]                           dc.b $00
[00002e8c]                           dc.b $00
[00002e8d]                           dc.b $00
[00002e8e]                           dc.b $00
[00002e8f]                           dc.b $00
[00002e90]                           dc.b $00
[00002e91]                           dc.b $00
[00002e92]                           dc.b $00
[00002e93]                           dc.b $00
[00002e94]                           dc.b $00
[00002e95]                           dc.b $00
[00002e96]                           dc.b $00
[00002e97]                           dc.b $00
[00002e98]                           dc.b $00
[00002e99]                           dc.b $00
[00002e9a]                           dc.b $00
[00002e9b]                           dc.b $00
[00002e9c]                           dc.b $00
[00002e9d]                           dc.b $00
[00002e9e]                           dc.b $00
[00002e9f]                           dc.b $00
[00002ea0]                           dc.b $00
[00002ea1]                           dc.b $00
[00002ea2]                           dc.b $00
[00002ea3]                           dc.b $00
[00002ea4]                           dc.b $00
[00002ea5]                           dc.b $00
[00002ea6]                           dc.b $00
[00002ea7]                           dc.b $00
[00002ea8]                           dc.b $00
[00002ea9]                           dc.b $00
[00002eaa]                           dc.b $00
[00002eab]                           dc.b $00
[00002eac]                           dc.b $00
[00002ead]                           dc.b $00
[00002eae]                           dc.b $00
[00002eaf]                           dc.b $00
[00002eb0]                           dc.b $00
[00002eb1]                           dc.b $00
[00002eb2]                           dc.b $00
[00002eb3]                           dc.b $00
[00002eb4]                           dc.b $00
[00002eb5]                           dc.b $00
[00002eb6]                           dc.b $00
[00002eb7]                           dc.b $00
[00002eb8]                           dc.b $00
[00002eb9]                           dc.b $00
[00002eba]                           dc.b $00
[00002ebb]                           dc.b $00
[00002ebc]                           dc.b $00
[00002ebd]                           dc.b $00
[00002ebe]                           dc.b $00
[00002ebf]                           dc.b $00
[00002ec0]                           dc.b $00
[00002ec1]                           dc.b $00
[00002ec2]                           dc.b $00
[00002ec3]                           dc.b $00
[00002ec4]                           dc.b $00
[00002ec5]                           dc.b $00
[00002ec6]                           dc.b $00
[00002ec7]                           dc.b $00
[00002ec8]                           dc.b $00
[00002ec9]                           dc.b $00
[00002eca]                           dc.b $00
[00002ecb]                           dc.b $00
[00002ecc]                           dc.b $00
[00002ecd]                           dc.b $00
[00002ece]                           dc.b $00
[00002ecf]                           dc.b $00
[00002ed0]                           dc.b $00
[00002ed1]                           dc.b $00
[00002ed2]                           dc.b $00
[00002ed3]                           dc.b $00
[00002ed4]                           dc.b $00
[00002ed5]                           dc.b $00
[00002ed6]                           dc.b $00
[00002ed7]                           dc.b $00
[00002ed8]                           dc.b $00
[00002ed9]                           dc.b $00
[00002eda]                           dc.b $00
[00002edb]                           dc.b $00
[00002edc]                           dc.b $00
[00002edd]                           dc.b $00
[00002ede]                           dc.b $00
[00002edf]                           dc.b $00
[00002ee0]                           dc.b $00
[00002ee1]                           dc.b $00
[00002ee2]                           dc.b $00
[00002ee3]                           dc.b $00
[00002ee4]                           dc.b $00
[00002ee5]                           dc.b $00
[00002ee6]                           dc.b $00
[00002ee7]                           dc.b $00
[00002ee8]                           dc.b $00
[00002ee9]                           dc.b $00
[00002eea]                           dc.b $00
[00002eeb]                           dc.b $00
[00002eec]                           dc.b $00
[00002eed]                           dc.b $00
[00002eee]                           dc.b $00
[00002eef]                           dc.b $00
[00002ef0]                           dc.b $00
[00002ef1]                           dc.b $00
[00002ef2]                           dc.b $00
[00002ef3]                           dc.b $00
[00002ef4]                           dc.b $00
[00002ef5]                           dc.b $00
[00002ef6]                           dc.b $00
[00002ef7]                           dc.b $00
[00002ef8]                           dc.b $00
[00002ef9]                           dc.b $00
[00002efa]                           dc.b $00
[00002efb]                           dc.b $00
[00002efc]                           dc.b $00
[00002efd]                           dc.b $00
[00002efe]                           dc.b $00
[00002eff]                           dc.b $00
[00002f00]                           dc.b $00
[00002f01]                           dc.b $00
[00002f02]                           dc.b $00
[00002f03]                           dc.b $00
[00002f04]                           dc.b $00
[00002f05]                           dc.b $00
[00002f06]                           dc.b $00
[00002f07]                           dc.b $00
[00002f08]                           dc.b $00
[00002f09]                           dc.b $00
[00002f0a]                           dc.b $00
[00002f0b]                           dc.b $00
[00002f0c]                           dc.b $00
[00002f0d]                           dc.b $00
[00002f0e]                           dc.b $00
[00002f0f]                           dc.b $00
[00002f10]                           dc.b $00
[00002f11]                           dc.b $00
[00002f12]                           dc.b $00
[00002f13]                           dc.b $00
[00002f14]                           dc.b $00
[00002f15]                           dc.b $00
[00002f16]                           dc.b $00
[00002f17]                           dc.b $00
[00002f18]                           dc.b $00
[00002f19]                           dc.b $00
[00002f1a]                           dc.b $00
[00002f1b]                           dc.b $00
[00002f1c]                           dc.b $00
[00002f1d]                           dc.b $00
[00002f1e]                           dc.b $00
[00002f1f]                           dc.b $00
[00002f20]                           dc.b $00
[00002f21]                           dc.b $00
[00002f22]                           dc.b $00
[00002f23]                           dc.b $00
[00002f24]                           dc.b $00
[00002f25]                           dc.b $00
[00002f26]                           dc.b $00
[00002f27]                           dc.b $00
[00002f28]                           dc.b $00
[00002f29]                           dc.b $00
[00002f2a]                           dc.b $00
[00002f2b]                           dc.b $00
[00002f2c]                           dc.b $00
[00002f2d]                           dc.b $00
[00002f2e]                           dc.b $00
[00002f2f]                           dc.b $00
[00002f30]                           dc.b $00
[00002f31]                           dc.b $00
[00002f32]                           dc.b $00
[00002f33]                           dc.b $00
[00002f34]                           dc.b $00
[00002f35]                           dc.b $00
[00002f36]                           dc.b $00
[00002f37]                           dc.b $00
[00002f38]                           dc.b $00
[00002f39]                           dc.b $00
[00002f3a]                           dc.b $00
[00002f3b]                           dc.b $00
[00002f3c]                           dc.b $00
[00002f3d]                           dc.b $00
[00002f3e]                           dc.b $00
[00002f3f]                           dc.b $00
[00002f40]                           dc.b $00
[00002f41]                           dc.b $00
[00002f42]                           dc.b $00
[00002f43]                           dc.b $00
[00002f44]                           dc.b $00
[00002f45]                           dc.b $00
[00002f46]                           dc.b $00
[00002f47]                           dc.b $00
[00002f48]                           dc.b $00
[00002f49]                           dc.b $00
[00002f4a]                           dc.b $00
[00002f4b]                           dc.b $00
[00002f4c]                           dc.b $00
[00002f4d]                           dc.b $00
[00002f4e]                           dc.b $00
[00002f4f]                           dc.b $00
[00002f50]                           dc.b $00
[00002f51]                           dc.b $00
[00002f52]                           dc.b $00
[00002f53]                           dc.b $00
[00002f54]                           dc.b $00
[00002f55]                           dc.b $00
[00002f56]                           dc.b $00
[00002f57]                           dc.b $00
[00002f58]                           dc.b $00
[00002f59]                           dc.b $00
[00002f5a]                           dc.b $00
[00002f5b]                           dc.b $00
[00002f5c]                           dc.b $00
[00002f5d]                           dc.b $00
[00002f5e]                           dc.b $00
[00002f5f]                           dc.b $00
[00002f60]                           dc.b $00
[00002f61]                           dc.b $00
[00002f62]                           dc.b $00
[00002f63]                           dc.b $00
[00002f64]                           dc.b $00
[00002f65]                           dc.b $00
[00002f66]                           dc.b $00
[00002f67]                           dc.b $00
[00002f68]                           dc.b $00
[00002f69]                           dc.b $00
[00002f6a]                           dc.b $00
[00002f6b]                           dc.b $00
[00002f6c]                           dc.b $00
[00002f6d]                           dc.b $00
[00002f6e]                           dc.b $00
[00002f6f]                           dc.b $00
[00002f70]                           dc.b $00
[00002f71]                           dc.b $00
[00002f72]                           dc.b $00
[00002f73]                           dc.b $00
[00002f74]                           dc.b $00
[00002f75]                           dc.b $00
[00002f76]                           dc.b $00
[00002f77]                           dc.b $00
[00002f78]                           dc.b $00
[00002f79]                           dc.b $00
[00002f7a]                           dc.b $00
[00002f7b]                           dc.b $00
[00002f7c]                           dc.b $00
[00002f7d]                           dc.b $00
[00002f7e]                           dc.b $00
[00002f7f]                           dc.b $00
[00002f80]                           dc.b $00
[00002f81]                           dc.b $00
[00002f82]                           dc.b $00
[00002f83]                           dc.b $00
[00002f84]                           dc.b $00
[00002f85]                           dc.b $00
[00002f86]                           dc.b $00
[00002f87]                           dc.b $00
[00002f88]                           dc.b $00
[00002f89]                           dc.b $00
[00002f8a]                           dc.b $00
[00002f8b]                           dc.b $00
[00002f8c]                           dc.b $00
[00002f8d]                           dc.b $00
[00002f8e]                           dc.b $00
[00002f8f]                           dc.b $00
[00002f90]                           dc.b $00
[00002f91]                           dc.b $00
[00002f92]                           dc.b $00
[00002f93]                           dc.b $00
[00002f94]                           dc.b $00
[00002f95]                           dc.b $00
[00002f96]                           dc.b $00
[00002f97]                           dc.b $00
[00002f98]                           dc.b $00
[00002f99]                           dc.b $00
[00002f9a]                           dc.b $00
[00002f9b]                           dc.b $00
[00002f9c]                           dc.b $00
[00002f9d]                           dc.b $00
[00002f9e]                           dc.b $00
[00002f9f]                           dc.b $00
[00002fa0]                           dc.b $00
[00002fa1]                           dc.b $00
[00002fa2]                           dc.b $00
[00002fa3]                           dc.b $00
[00002fa4]                           dc.b $00
[00002fa5]                           dc.b $00
[00002fa6]                           dc.b $00
[00002fa7]                           dc.b $00
[00002fa8]                           dc.b $00
[00002fa9]                           dc.b $00
[00002faa]                           dc.b $00
[00002fab]                           dc.b $00
[00002fac]                           dc.b $00
[00002fad]                           dc.b $00
[00002fae]                           dc.b $00
[00002faf]                           dc.b $00
[00002fb0]                           dc.b $00
[00002fb1]                           dc.b $00
[00002fb2]                           dc.b $00
[00002fb3]                           dc.b $00
[00002fb4]                           dc.b $00
[00002fb5]                           dc.b $00
[00002fb6]                           dc.b $00
[00002fb7]                           dc.b $00
[00002fb8]                           dc.b $00
[00002fb9]                           dc.b $00
[00002fba]                           dc.b $00
[00002fbb]                           dc.b $00
[00002fbc]                           dc.b $00
[00002fbd]                           dc.b $00
[00002fbe]                           dc.b $00
[00002fbf]                           dc.b $00
[00002fc0]                           dc.b $00
[00002fc1]                           dc.b $00
[00002fc2]                           dc.b $00
[00002fc3]                           dc.b $00
[00002fc4]                           dc.b $00
[00002fc5]                           dc.b $00
[00002fc6]                           dc.b $00
[00002fc7]                           dc.b $00
[00002fc8]                           dc.b $00
[00002fc9]                           dc.b $00
[00002fca]                           dc.b $00
[00002fcb]                           dc.b $00
[00002fcc]                           dc.b $00
[00002fcd]                           dc.b $00
[00002fce]                           dc.b $00
[00002fcf]                           dc.b $00
[00002fd0]                           dc.b $00
[00002fd1]                           dc.b $00
[00002fd2]                           dc.b $00
[00002fd3]                           dc.b $00
[00002fd4]                           dc.b $00
[00002fd5]                           dc.b $00
[00002fd6]                           dc.b $00
[00002fd7]                           dc.b $00
[00002fd8]                           dc.b $00
[00002fd9]                           dc.b $00
[00002fda]                           dc.b $00
[00002fdb]                           dc.b $00
[00002fdc]                           dc.b $00
[00002fdd]                           dc.b $00
[00002fde]                           dc.b $00
[00002fdf]                           dc.b $00
[00002fe0]                           dc.b $00
[00002fe1]                           dc.b $00
[00002fe2]                           dc.b $00
[00002fe3]                           dc.b $00
[00002fe4]                           dc.b $00
[00002fe5]                           dc.b $00
[00002fe6]                           dc.b $00
[00002fe7]                           dc.b $00
[00002fe8]                           dc.b $00
[00002fe9]                           dc.b $00
[00002fea]                           dc.b $00
[00002feb]                           dc.b $00
[00002fec]                           dc.b $00
[00002fed]                           dc.b $00
[00002fee]                           dc.b $00
[00002fef]                           dc.b $00
[00002ff0]                           dc.b $00
[00002ff1]                           dc.b $00
[00002ff2]                           dc.b $00
[00002ff3]                           dc.b $00
[00002ff4]                           dc.b $00
[00002ff5]                           dc.b $00
[00002ff6]                           dc.b $00
[00002ff7]                           dc.b $00
[00002ff8]                           dc.b $00
[00002ff9]                           dc.b $00
[00002ffa]                           dc.b $00
[00002ffb]                           dc.b $00
[00002ffc]                           dc.w $2000
[00002ffe]                           dc.b 'usage: ',0
[00003006]                           dc.w $080c
[00003008]                           dc.w $0a0d
[0000300a]                           dc.w $090b
[0000300c]                           dc.b $00
[0000300d]                           dc.b 'bfnrtv',0
[00003014]                           dc.b $00
[00003015]                           dc.b $00
[00003016]                           dc.b $00
[00003017]                           dc.b $00
[00003018]                           dc.b $00
[00003019]                           dc.b $00
[0000301a]                           dc.b $00
[0000301b]                           dc.b $00
[0000301c] 0002086e                  dc.l $0002086e ; no symbol found
[00003020]                           dc.b 'read error',0
[0000302b]                           dc.b $00
[0000302c]                           dc.b $00
[0000302d]                           dc.b $00
[0000302e]                           dc.b $00
[0000302f]                           dc.b $00
[00003030]                           dc.b $00
[00003031]                           dc.b $00
[00003032]                           dc.b $00
[00003033]                           dc.b $00
[00003034]                           dc.b $00
[00003035]                           dc.b $00
[00003036]                           dc.b $00
[00003037]                           dc.b $00
[00003038]                           dc.b $00
[00003039]                           dc.b $00
[0000303a]                           dc.b $00
[0000303b]                           dc.b $00
[0000303c]                           dc.b 'bad free call',0
[0000304a] 0002089c                  dc.l $0002089c ; no symbol found
[0000304e]                           dc.b 'NULL FIO pointer',0
[0000305f]                           dc.b $00
[00003060] 000208b2                  dc.l $000208b2 ; no symbol found
[00003064]                           dc.b 'no memory',0
[0000306e]                           dc.b $00
[0000306f]                           dc.b $00
[00003070]                           dc.b $00
[00003071]                           dc.b $00
[00003072] 000208c4                  dc.l $000208c4 ; no symbol found
[00003076]                           dc.b 'unchecked condition',0
[0000308a] 00020900                  dc.l $00020900 ; no symbol found
[0000308e]                           dc.b $00
[0000308f]                           dc.b $00
[00003090]                           dc.b $00
[00003091]                           dc.b $01
[00003092] 000208e4                  dc.l $000208e4 ; no symbol found
[00003096]                           dc.b 'write error',0
[000030a2]                           dc.w $0a00
[000030a4]                           dc.w $3a20
[000030a6]                           dc.b $00
[000030a7]                           dc.b $00
[000030a8] 000208fa                  dc.l $000208fa ; no symbol found
[000030ac]                           dc.b 'error',0
; a.out Relocations:
00000016: 000027b2
00000026: 000027b2
00000040: 000027b2
00000046: 000027b2
0000004c: 00000000
00000058: 000027b2
00000062: 000027b2
0000006a: 000030b2
0000006e: 000027b2
00000074: 00000000
0000007c: 00000000
00000082: 000027b2
00000088: 00000000
000000ac: 000027b2
000000b4: 000027b2
000000be: 000027b2
000000dc: 000027b2
000000e4: 000027b2
000000f2: 000027b2
000000fa: 000027b2
00000108: 000027b2
0000010e: 00000000
00000116: 000027b2
0000011c: 000027b2
00000126: 000027b2
0000012e: 000027b2
00000136: 000027b2
00000144: 000027b2
0000014a: 00000000
00000152: 000027b2
00000158: 000027b2
00000162: 000027b2
00000210: 000027b2
00000216: 000027b2
0000021c: 000027b2
00000222: 000027b2
00000228: 000027b2
0000022e: 000027b2
00000234: 000027b2
0000023a: 000027b2
00000240: 000027b2
0000024e: 00000000
00000258: 000027b2
00000260: 000027b2
00000266: 000027b2
0000026c: 000027b2
00000276: 000027b2
00000282: 000027b2
00000288: 00000000
0000028e: 000027b2
00000296: 000027b2
0000029e: 000027b2
000002ae: 000027b2
000002b4: 00000000
000002bc: 000027b2
000002c6: 000027b2
000002cc: 00000000
000002d4: 000027b2
000002dc: 000027b2
000002e2: 00000000
000002e8: 000027b2
000002f6: 000027b2
000002fc: 00000000
00000302: 000027b2
00000308: 00000000
0000031a: 000027b2
00000320: 00000000
00000330: 00000000
00000346: 000027b2
0000034c: 00000000
00000398: 000027b2
0000039e: 00000000
000003cc: 000027b2
000003d2: 00000000
00000416: 000027b2
0000041c: 00000000
0000042e: 00000000
00000448: 000027b2
0000044e: 00000000
00000466: 000027b2
0000046c: 000027b2
0000047a: 000027b2
0000049a: 00000000
000004b0: 000027b2
000004b8: 000027b2
000004be: 00000000
00000506: 000027b2
0000052a: 00000000
0000053a: 000027b2
000005a6: 000027b2
000005b6: 000027b2
000005be: 000027b2
000005c6: 000027b2
000005ce: 00000000
000005fc: 000027b2
00000622: 000027b2
00000628: 00000000
00000634: 000027b2
0000063a: 00000000
00000658: 000027b2
00000660: 000027b2
00000672: 000027b2
00000678: 00000000
00000684: 000027b2
000006b0: 000027b2
000006c0: 000027b2
000006c8: 000027b2
000006d0: 000027b2
000006d8: 00000000
000006e2: 000027b2
000006f2: 000027b2
000006fc: 00000000
00000706: 000027b2
0000070c: 00000000
00000712: 000027b2
00000724: 00000000
0000072c: 000027b2
00000732: 00000000
0000073e: 000027b2
00000744: 00000000
000007ba: 000027b2
000007c0: 00000000
000007d8: 000027b2
000007de: 00000000
000007f4: 000027b2
000007fa: 00000000
00000814: 000027b2
0000081a: 00000000
00000832: 00000000
0000083a: 000027b2
00000840: 00000000
00000852: 000027b2
00000858: 00000000
00000860: 000027b2
00000866: 00000000
00000894: 000027b2
0000089c: 000027b2
000008b0: 00000000
000008ba: 000027b2
000008c0: 00000000
000008c8: 000027b2
000008ce: 00000000
00000906: 00000000
0000091a: 000027b2
00000920: 00000000
0000093c: 00000000
0000094e: 00000000
0000095e: 000027b2
00000964: 00000000
00000970: 00000000
00000986: 00000000
000009a2: 00000000
000009ae: 00000000
000009d2: 000027b2
000009d8: 00000000
000009de: 000027b2
000009e8: 000027b2
000009f2: 000027b2
000009fc: 000027b2
00000a06: 000027b2
00000a10: 000027b2
00000a1a: 000027b2
00000a24: 000027b2
00000a2e: 000027b2
00000a38: 000027b2
00000a42: 000027b2
00000a4c: 000027b2
00000a56: 000027b2
00000a60: 000027b2
00000a6a: 000027b2
00000a74: 000027b2
00000a7e: 000027b2
00000a8c: 000027b2
00000a96: 000027b2
00000a9c: 00000000
00000aa8: 000027b2
00000ab0: 000027b2
00000acc: 000027b2
00000ad6: 000027b2
00000adc: 00000000
00000ae8: 000027b2
00000af6: 000027b2
00000afc: 00000000
00000b0a: 000027b2
00000b14: 00000000
00000b32: 000027b2
00000b38: 00000000
00000b42: 000027b2
00000b4a: 000027b2
00000bb4: 00000000
00000bba: 00000000
00000bd8: 000027b2
00000bde: 00000000
00000be4: 00000000
00000c50: 00000000
00000e02: 00000000
00000f28: 00000000
00000fd4: 00000000
0000106e: 00000000
0000109c: 000027b2
000010a4: 00000000
000010d8: 00000000
000010e2: 000027b2
000010f0: 000027b2
00001102: 000027b2
00001116: 00000000
00001122: 000027b2
0000112a: 00000000
0000113c: 000027b2
0000114c: 000027b2
00001156: 00000000
00001174: 000027b2
0000117e: 00000000
0000119a: 000027b2
000011ae: 00000000
000011ba: 000027b2
000011c2: 00000000
000011d4: 000027b2
000011ec: 000027b2
000011f6: 00000000
00001202: 00000000
00001234: 000027b2
0000123c: 00000000
00001244: 000027b2
00001292: 00000000
000012a4: 000027b2
000012ac: 00000000
000012ba: 00000000
000012f4: 00000000
0000130a: 00000000
0000132c: 00000000
00001334: 000027b2
00001348: 00000000
0000138c: 00000000
000013aa: 00000000
000013bc: 000027b2
000013c6: 00000000
000013d2: 00000000
000013e4: 000027b2
000013ee: 00000000
0000141c: 000027b2
00001426: 00000000
00001438: 000027b2
00001442: 00000000
00001462: 000027b2
0000146c: 00000000
00001486: 000027b2
00001490: 00000000
000014a6: 00000000
000014de: 000027b2
000014e6: 00000000
00001510: 000027b2
00001518: 00000000
0000154a: 000027b2
00001550: 00000000
00001576: 00000000
00001584: 000027b2
000015be: 000027b2
000015c4: 00000000
00001616: 00000000
0000165e: 00000000
0000169c: 00000000
000016a8: 00000000
000016ce: 00000000
00001782: 00000000
00001890: 00000000
000018a6: 000027b2
000018ae: 00000000
000018d4: 00000000
000018e2: 000027b2
000018ec: 00000000
00001926: 000027b2
0000192c: 000027b2
00001932: 000027b2
0000193c: 00000000
00001950: 00000000
0000196c: 00000000
00001972: 000027b2
00001978: 00000000
00001ae8: 000027b2
00001aee: 00000000
00001b08: 000027b2
00001b38: 00000000
00001b6c: 000027b2
00001b8e: 00000000
00001b98: 000027b2
00001bc0: 000027b2
00001bc8: 00000000
00001bea: 00000000
00001c12: 000027b2
00001c1a: 000027b2
00001c20: 000027b2
00001c28: 00000000
00001c2e: 00000000
00001c34: 000027b2
00001c58: 000027b2
00001c60: 00000000
00001c88: 00000000
00001c9a: 000027b2
00001ca2: 00000000
00001d64: 00000000
00001d80: 00000000
00001e20: 00000000
00001e3a: 00000000
00001e7c: 000027b2
00001e84: 00000000
00001f0a: 00000000
00001f2e: 00000000
00001f5e: 00000000
00001f6c: 00000000
0000202a: 00000000
00002042: 00000000
0000211c: 00000000
0000212e: 000027b2
00002136: 00000000
0000216c: 000027b2
0000218c: 000027b2
00002198: 000027b2
000021c6: 000027b2
000021ce: 000027b2
000021d6: 000027b2
000021de: 000027b2
000021e6: 000027b2
000021f2: 00000000
000021fe: 000027b2
00002206: 000027b2
0000221a: 00000000
00002238: 000027b2
00002240: 000027b2
00002248: 000027b2
0000224e: 000027b2
00002264: 000027b2
00002270: 00000000
00002292: 000027b2
0000229a: 000027b2
000022a4: 000027b2
000022a8: 000027b2
000022ae: 000027b2
000022b6: 00000000
000022ca: 000027b2
000022d6: 000027b2
000022de: 000027b2
000022e6: 000027b2
000022ee: 000027b2
000022fc: 000027b2
00002504: 00000000
00002598: 00000000
000025a6: 000027b2
000025ae: 00000000
00002630: 000027b2
00002652: 000027b2
00002694: 000027b2
0000269e: 00000000
000026a8: 000027b2
000026dc: 000027b2
000026f8: 000027b2
00002712: 000027b2
00002718: 000027b2
0000271e: 000027b2
00002726: 000027b2
0000272a: 000027b2
00002764: 00000000
00002772: 000027b2
0000277c: 000027b2
00002796: 000027b2
000027a2: 00000000
0000282c: 000027b2
00002830: 00000000
00002858: 000027b2
00002868: 000027b2
00002878: 000027b2
00002886: 000027b2
00002958: 000027b2
0000295c: 000027b2
00002960: 000027b2
00002964: 000027b2
00002968: 000027b2
0000296c: 000027b2
00002970: 000027b2
00002974: 000027b2
00002b40: 00000000
00002b48: 00000000
00002b50: 00000000
00002b58: 00000000
00002b60: 00000000
00002b68: 00000000
00002b70: 00000000
00002b78: 00000000
00002b80: 00000000
00002b88: 00000000
00002b90: 00000000
00002b98: 00000000
00002ba0: 00000000
00002ba8: 00000000
00002bb0: 00000000
00002bb8: 00000000
00002bc0: 00000000
00002bcc: 00000000
00002da2: 00000000
00002daa: 00000000
00002db2: 00000000
00002dba: 00000000
00002dc2: 00000000
00002dca: 00000000
00002dd2: 00000000
00002dde: 00000000
0000301c: 000027b2
0000304a: 000027b2
00003060: 000027b2
00003072: 000027b2
0000308a: 000030b2
00003092: 000027b2
000030a8: 000027b2

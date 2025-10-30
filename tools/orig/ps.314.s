; a_magic   = 0x9928
; a_text    = 0x00004c14
; a_data    = 0x00000ac4
; a_bss     = 0x00000224
; a_syms    = 0x0000115d
; a_heap    = 0x00000000
; a_textoff = 0x00000000
; a_dataoff = 0x00020000
; a_relocs  = 0x000005e4@0x00006851


start:
[00000000] 0cb9 0000 0001 0002 0c72  cmpi.l     #$00000001,$00025886
[0000000a] 660a                      bne.s      start_1
[0000000c] 23fc 0002 0ce8 0002 0c72  move.l     #$00020CE8,$00025886
start_1:
[00000016] 4eb9 0000 43ec            jsr        __lstat
[0000001c] 4eb9 0000 193a            jsr        __astat
[00000022] 4eb9 0000 149c            jsr        __cstat
[00000028] 4879 0000 0078            pea.l      sigerr
[0000002e] 2f3c ffff ffff            move.l     #$FFFFFFFF,-(a7)
[00000034] 4eb9 0000 3dcc            jsr        __signal
[0000003a] 508f                      addq.l     #8,a7
[0000003c] 4eb9 0000 26fe            jsr        __main
[00000042] 2e87                      move.l     d7,(a7)
[00000044] 4eb9 0000 004a            jsr        _exit

_exit:
[0000004a] 2e39 0002 0068            move.l     $00024C7C,d7
_exit_1:
[00000050] 0c87 0000 0068            cmpi.l     #_onexit,d7
[00000056] 670a                      beq.s      __exit
[00000058] 4a87                      tst.l      d7
[0000005a] 6706                      beq.s      __exit
[0000005c] 2047                      movea.l    d7,a0
[0000005e] 4e90                      jsr        (a0)
[00000060] 60ee                      bra.s      _exit_1

__exit:
[00000062] 4a9f                      tst.l      (a7)+
[00000064] 7e01                      moveq.l    #1,d7
[00000066] 4e41                      trap       #1

_onexit:
[00000068] 2e39 0002 0068            move.l     $00024C7C,d7
[0000006e] 23ef 0004 0002 0068       move.l     4(a7),$00024C7C
[00000076] 4e75                      rts

sigerr:
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
[0000009c] 23c7 0002 0064            move.l     d7,_errno
[000000a2] 7eff                      moveq.l    #-1,d7
[000000a4] 4ed0                      jmp        (a0)

_devname:
[000000a6] 4e56 fff8                 link       a6,#-8
[000000aa] 48e7 9c0c                 movem.l    d0/d3-d5/a4-a5,-(a7)
[000000ae] 2a2e 000c                 move.l     12(a6),d5
[000000b2] 282e 0010                 move.l     16(a6),d4
[000000b6] 4a84                      tst.l      d4
[000000b8] 6708                      beq.s      _devname_1
[000000ba] 2e3c 0002 00d6            move.l     #$00024CEA,d7 "/dev/cnames"
[000000c0] 6006                      bra.s      _devname_2
_devname_1:
[000000c2] 2e3c 0002 00ca            move.l     #$00024CDE,d7 "/dev/bnames"
_devname_2:
[000000c8] 2d47 fffc                 move.l     d7,-4(a6)
[000000cc] 4a84                      tst.l      d4
[000000ce] 673c                      beq.s      _devname_3
[000000d0] 4ab9 0002 00ea            tst.l      cnames_buf
[000000d6] 6708                      beq.s      _devname_4
[000000d8] 2e39 0002 00ea            move.l     cnames_buf,d7
[000000de] 6020                      bra.s      _devname_5
_devname_4:
[000000e0] 4297                      clr.l      (a7)
[000000e2] 2f2e fffc                 move.l     -4(a6),-(a7)
[000000e6] 2f3c 0002 00e2            move.l     #cnames_size,-(a7)
[000000ec] 4eb9 0000 0928            jsr        _readfill
[000000f2] 508f                      addq.l     #8,a7
[000000f4] 23c7 0002 00ea            move.l     d7,cnames_buf
[000000fa] 2e39 0002 00ea            move.l     cnames_buf,d7
_devname_5:
[00000100] 2d47 fff8                 move.l     d7,-8(a6)
[00000104] 2639 0002 00e2            move.l     cnames_size,d3
[0000010a] 603a                      bra.s      _devname_6
_devname_3:
[0000010c] 4ab9 0002 00ee            tst.l      bnames_buf
[00000112] 6708                      beq.s      _devname_7
[00000114] 2e39 0002 00ee            move.l     bnames_buf,d7
[0000011a] 6020                      bra.s      _devname_8
_devname_7:
[0000011c] 4297                      clr.l      (a7)
[0000011e] 2f2e fffc                 move.l     -4(a6),-(a7)
[00000122] 2f3c 0002 00e6            move.l     #bnames_size,-(a7)
[00000128] 4eb9 0000 0928            jsr        _readfill
[0000012e] 508f                      addq.l     #8,a7
[00000130] 23c7 0002 00ee            move.l     d7,bnames_buf
[00000136] 2e39 0002 00ee            move.l     bnames_buf,d7
_devname_8:
[0000013c] 2d47 fff8                 move.l     d7,-8(a6)
[00000140] 2639 0002 00e6            move.l     bnames_size,d3
_devname_6:
[00000146] 226e 0008                 movea.l    8(a6),a1
[0000014a] 4211                      clr.b      (a1)
[0000014c] 4aae fff8                 tst.l      -8(a6)
[00000150] 6604                      bne.s      _devname_9
[00000152] 7e00                      moveq.l    #0,d7
[00000154] 6062                      bra.s      _devname_10
_devname_9:
[00000156] 9bcd                      suba.l     a5,a5
[00000158] 99cc                      suba.l     a4,a4
_devname_15:
[0000015a] 4a83                      tst.l      d3
[0000015c] 6700 0080                 beq        _devname_11 ; possibly optimized to short
[00000160] 3e05                      move.w     d5,d7
[00000162] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00000168] e087                      asr.l      #8,d7
[0000016a] be8d                      cmp.l      a5,d7
[0000016c] 6652                      bne.s      _devname_12
[0000016e] 2e05                      move.l     d5,d7
[00000170] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000176] be8c                      cmp.l      a4,d7
[00000178] 6646                      bne.s      _devname_12
_devname_14:
[0000017a] 4a83                      tst.l      d3
[0000017c] 6732                      beq.s      _devname_13
[0000017e] 226e fff8                 movea.l    -8(a6),a1
[00000182] 0c11 000a                 cmpi.b     #$0A,(a1)
[00000186] 6728                      beq.s      _devname_13
[00000188] 226e fff8                 movea.l    -8(a6),a1
[0000018c] 0c11 0020                 cmpi.b     #$20,(a1)
[00000190] 671e                      beq.s      _devname_13
[00000192] 226e 0008                 movea.l    8(a6),a1
[00000196] 52ae 0008                 addq.l     #1,8(a6)
[0000019a] 246e fff8                 movea.l    -8(a6),a2
[0000019e] 1292                      move.b     (a2),(a1)
[000001a0] 5383                      subq.l     #1,d3
[000001a2] 52ae fff8                 addq.l     #1,-8(a6)
[000001a6] 60d2                      bra.s      _devname_14
_devname_17:
[000001a8] 5383                      subq.l     #1,d3
[000001aa] 52ae fff8                 addq.l     #1,-8(a6)
[000001ae] 60aa                      bra.s      _devname_15
_devname_13:
[000001b0] 226e 0008                 movea.l    8(a6),a1
[000001b4] 4211                      clr.b      (a1)
[000001b6] 7e01                      moveq.l    #1,d7
_devname_10:
[000001b8] 4cdf 3039                 movem.l    (a7)+,d0/d3-d5/a4-a5
[000001bc] 4e5e                      unlk       a6
[000001be] 4e75                      rts
_devname_12:
[000001c0] 226e fff8                 movea.l    -8(a6),a1
[000001c4] 0c11 000a                 cmpi.b     #$0A,(a1)
[000001c8] 6606                      bne.s      _devname_16
[000001ca] 528d                      addq.l     #1,a5
[000001cc] 99cc                      suba.l     a4,a4
[000001ce] 60d8                      bra.s      _devname_17
_devname_16:
[000001d0] 226e fff8                 movea.l    -8(a6),a1
[000001d4] 0c11 0020                 cmpi.b     #$20,(a1)
[000001d8] 66ce                      bne.s      _devname_17
[000001da] 528c                      addq.l     #1,a4
[000001dc] 60ca                      bra.s      _devname_17
_devname_11:
[000001de] 7e00                      moveq.l    #0,d7
[000001e0] 60d6                      bra.s      _devname_10

_main:
[000001e2] 4e56 fffc                 link       a6,#-4
[000001e6] 2ebc 0002 0088            move.l     #_tflag,(a7)
[000001ec] 2f3c 0002 0084            move.l     #_slp,-(a7)
[000001f2] 2f3c 0002 0080            move.l     #_rflag,-(a7)
[000001f8] 2f3c 0002 007c            move.l     #_pflag,-(a7)
[000001fe] 2f3c 0002 0078            move.l     #_lflag,-(a7)
[00000204] 2f3c 0002 0074            move.l     #_iflag,-(a7)
[0000020a] 2f3c 0002 0070            move.l     #_fflag,-(a7)
[00000210] 2f3c 0002 006c            move.l     #_aflag,-(a7)
[00000216] 2f3c 0002 00f2            move.l     #$00024D06,-(a7) "a,f,i,l,p,r,s#,t:F"
[0000021c] 486e 000c                 pea.l      12(a6)
[00000220] 486e 0008                 pea.l      8(a6)
[00000224] 4eb9 0000 0f86            jsr        _getflags
[0000022a] 4fef 0028                 lea.l      40(a7),a7
[0000022e] 4ab9 0002 007c            tst.l      _pflag
[00000234] 661c                      bne.s      _main_1
[00000236] 2e39 0002 006c            move.l     _aflag,d7
[0000023c] deb9 0002 0074            add.l      _iflag,d7
[00000242] deb9 0002 0088            add.l      _tflag,d7
[00000248] 6608                      bne.s      _main_1
[0000024a] 7001                      moveq.l    #1,d0
[0000024c] 23c0 0002 007c            move.l     d0,_pflag
_main_1:
[00000252] 4aae 0008                 tst.l      8(a6)
[00000256] 670c                      beq.s      _main_2
[00000258] 2ebc 0002 0105            move.l     #$00024D19,(a7) "-[a f i l p r s# t]\n"
[0000025e] 4eb9 0000 1406            jsr        _usage
_main_2:
[00000264] 4ab9 0002 006c            tst.l      _aflag
[0000026a] 6608                      bne.s      _main_3
[0000026c] 4ab9 0002 0088            tst.l      _tflag
[00000272] 671e                      beq.s      _main_4
_main_3:
[00000274] 4ab9 0002 006c            tst.l      _aflag
[0000027a] 6604                      bne.s      _main_5
[0000027c] 7e01                      moveq.l    #1,d7
[0000027e] 6002                      bra.s      _main_6
_main_5:
[00000280] 7e00                      moveq.l    #0,d7
_main_6:
[00000282] 2e87                      move.l     d7,(a7)
[00000284] 2f39 0002 00be            move.l     _tps,-(a7)
[0000028a] 4eb9 0000 048c            jsr        _pps
[00000290] 588f                      addq.l     #4,a7
_main_4:
[00000292] 4ab9 0002 007c            tst.l      _pflag
[00000298] 6710                      beq.s      _main_7
[0000029a] 4297                      clr.l      (a7)
[0000029c] 2f39 0002 00b0            move.l     _tmyps,-(a7)
[000002a2] 4eb9 0000 048c            jsr        _pps
[000002a8] 588f                      addq.l     #4,a7
_main_7:
[000002aa] 4ab9 0002 0074            tst.l      _iflag
[000002b0] 670c                      beq.s      _main_8
[000002b2] 2eb9 0002 0090            move.l     _tinode,(a7)
[000002b8] 4eb9 0000 02e8            jsr        _pinode
_main_8:
[000002be] 4ab9 0002 0084            tst.l      _slp
[000002c4] 6606                      bne.s      _main_9
[000002c6] 7e01                      moveq.l    #1,d7
[000002c8] 4e5e                      unlk       a6
[000002ca] 4e75                      rts
_main_9:
[000002cc] 2eb9 0002 0084            move.l     _slp,(a7)
[000002d2] 4eb9 0000 0d2c            jsr        _sleep
[000002d8] 2ebc 0002 011a            move.l     #$00024D2E,(a7) "\n"
[000002de] 4eb9 0000 1394            jsr        _putfmt
[000002e4] 6000 ff7e                 bra        _main_2

_pinode:
[000002e8] 4e56 ffea                 link       a6,#-22
[000002ec] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000002f0] 2ebc 0002 011c            move.l     #$00024D30,(a7) "inodes:\n"
[000002f6] 4eb9 0000 1394            jsr        _putfmt
[000002fc] 4297                      clr.l      (a7)
[000002fe] 2f2e 0008                 move.l     8(a6),-(a7)
[00000302] 486e fffc                 pea.l      -4(a6)
[00000306] 4eb9 0000 0928            jsr        _readfill
[0000030c] 508f                      addq.l     #8,a7
[0000030e] 2847                      movea.l    d7,a4
[00000310] 2e0c                      move.l     a4,d7
[00000312] 6608                      bne.s      _pinode_1
[00000314] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00000318] 4e5e                      unlk       a6
[0000031a] 4e75                      rts
_pinode_1:
[0000031c] 2ebc 0002 0125            move.l     #$00024D39,(a7) "FLG REF LAST  DEV   INUM    MODE  LNK  SIZE ADDRS\n"
[00000322] 4eb9 0000 1394            jsr        _putfmt
[00000328] 2a4c                      movea.l    a4,a5
_pinode_4:
[0000032a] 2e0c                      move.l     a4,d7
[0000032c] deae fffc                 add.l      -4(a6),d7
[00000330] bbc7                      cmpa.l     d7,a5
[00000332] 6400 011a                 bcc        _pinode_2
[00000336] 4297                      clr.l      (a7)
[00000338] 7e00                      moveq.l    #0,d7
[0000033a] 3e2d 0016                 move.w     22(a5),d7
[0000033e] 2f07                      move.l     d7,-(a7)
[00000340] 486e ffeb                 pea.l      -21(a6)
[00000344] 4eba fd60                 jsr        _devname(pc)
[00000348] 508f                      addq.l     #8,a7
[0000034a] 4a2e ffeb                 tst.b      -21(a6)
[0000034e] 663a                      bne.s      _pinode_3
[00000350] 7e00                      moveq.l    #0,d7
[00000352] 3e2d 0016                 move.w     22(a5),d7
[00000356] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000035c] 2e87                      move.l     d7,(a7)
[0000035e] 7e00                      moveq.l    #0,d7
[00000360] 3e2d 0016                 move.w     22(a5),d7
[00000364] e087                      asr.l      #8,d7
[00000366] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000036c] 2f07                      move.l     d7,-(a7)
[0000036e] 2f3c 0002 0158            move.l     #$00024D6C,-(a7) "%2d/%2d"
[00000374] 486e ffeb                 pea.l      -21(a6)
[00000378] 4eb9 0000 1a94            jsr        _sprintf
[0000037e] 4fef 000c                 lea.l      12(a7),a7
[00000382] 6006                      bra.s      _pinode_3
_pinode_7:
[00000384] 4bed 0032                 lea.l      50(a5),a5
[00000388] 60a0                      bra.s      _pinode_4
_pinode_3:
[0000038a] 7e00                      moveq.l    #0,d7
[0000038c] 3e2d 0018                 move.w     24(a5),d7
[00000390] 2e87                      move.l     d7,(a7)
[00000392] 486e ffeb                 pea.l      -21(a6)
[00000396] 7e00                      moveq.l    #0,d7
[00000398] 3e2d 0014                 move.w     20(a5),d7
[0000039c] 2f07                      move.l     d7,-(a7)
[0000039e] 7e00                      moveq.l    #0,d7
[000003a0] 3e2d 000e                 move.w     14(a5),d7
[000003a4] 2f07                      move.l     d7,-(a7)
[000003a6] 7e00                      moveq.l    #0,d7
[000003a8] 3e2d 000c                 move.w     12(a5),d7
[000003ac] 2f07                      move.l     d7,-(a7)
[000003ae] 2f3c 0002 0160            move.l     #$00024D74,-(a7) "%+03o %3i %4s %- 7p %4i"
[000003b4] 4eb9 0000 1394            jsr        _putfmt
[000003ba] 4fef 0014                 lea.l      20(a7),a7

[000003be] 7e00                      moveq.l    #0,d7
[000003c0] 1e2d 001f                 move.b     31(a5),d7
[000003c4] 7c10                      moveq.l    #16,d6
[000003c6] eda7                      asl.l      d6,d7
[000003c8] 7c00                      moveq.l    #0,d6
[000003ca] 3c2d 0020                 move.w     32(a5),d6
[000003ce] de86                      add.l      d6,d7
[000003d0] 2e87                      move.l     d7,(a7)
[000003d2] 7e00                      moveq.l    #0,d7
[000003d4] 1e2d 001c                 move.b     28(a5),d7
[000003d8] 2f07                      move.l     d7,-(a7)
[000003da] 7e00                      moveq.l    #0,d7
[000003dc] 3e2d 001a                 move.w     26(a5),d7
[000003e0] 2f07                      move.l     d7,-(a7)
[000003e2] 2f3c 0002 0178            move.l     #$00024D8C,-(a7) " %+07o %3i %6l"
[000003e8] 4eb9 0000 1394            jsr        _putfmt
[000003ee] 4fef 000c                 lea.l      12(a7),a7
[000003f2] 426e fffa                 clr.w      -6(a6)
_pinode_6:
[000003f6] 0c6e 0008 fffa            cmpi.w     #$0008,-6(a6)
[000003fc] 6c3e                      bge.s      _pinode_5
[000003fe] 3e2e fffa                 move.w     -6(a6),d7
[00000402] 48c7                      ext.l      d7
[00000404] e387                      asl.l      #1,d7
[00000406] 2247                      movea.l    d7,a1
[00000408] 45ed 0022                 lea.l      34(a5),a2
[0000040c] 4a71 a800                 tst.w      0(a1,a2.l)
[00000410] 672a                      beq.s      _pinode_5
[00000412] 3e2e fffa                 move.w     -6(a6),d7
[00000416] 48c7                      ext.l      d7
[00000418] e387                      asl.l      #1,d7
[0000041a] 2247                      movea.l    d7,a1
[0000041c] 45ed 0022                 lea.l      34(a5),a2
[00000420] 7e00                      moveq.l    #0,d7
[00000422] 3e31 a800                 move.w     0(a1,a2.l),d7
[00000426] 2e87                      move.l     d7,(a7)
[00000428] 2f3c 0002 0187            move.l     #$00024D9B,-(a7) " %5i"
[0000042e] 4eb9 0000 1394            jsr        _putfmt
[00000434] 588f                      addq.l     #4,a7
[00000436] 526e fffa                 addq.w     #1,-6(a6)
[0000043a] 60ba                      bra.s      _pinode_6
_pinode_5:
[0000043c] 2ebc 0002 018c            move.l     #$00024DA0,(a7) "\n"
[00000442] 4eb9 0000 1394            jsr        _putfmt
[00000448] 4a95                      tst.l      (a5)
[0000044a] 6600 ff38                 bne        _pinode_7
_pinode_2:
[0000044e] 2e8c                      move.l     a4,(a7)
[00000450] 4eb9 0000 1902            jsr        _free
[00000456] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[0000045a] 4e5e                      unlk       a6
[0000045c] 4e75                      rts

_pnm:
[0000045e] 4e56 0000                 link       a6,#0
[00000462] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00000466] 2a6e 0008                 movea.l    8(a6),a5
[0000046a] 287c 0002 018e            movea.l    #$00024DA2,a4
_pnm_2:
[00000470] b9fc 0002 0196            cmpa.l     #$00024DAA,a4
[00000476] 6404                      bcc.s      _pnm_1
[00000478] 18dd                      move.b     (a5)+,(a4)+
[0000047a] 60f4                      bra.s      _pnm_2
_pnm_1:
[0000047c] 4214                      clr.b      (a4)
[0000047e] 2e3c 0002 018e            move.l     #$00024DA2,d7
[00000484] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00000488] 4e5e                      unlk       a6
[0000048a] 4e75                      rts

_pps:
[0000048c] 4e56 fffa                 link       a6,#-6
[00000490] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00000494] 4297                      clr.l      (a7)
[00000496] 2f2e 0008                 move.l     8(a6),-(a7)
[0000049a] 486e fffc                 pea.l      -4(a6)
[0000049e] 4eb9 0000 0928            jsr        _readfill
[000004a4] 508f                      addq.l     #8,a7
[000004a6] 2847                      movea.l    d7,a4
[000004a8] 2e0c                      move.l     a4,d7
[000004aa] 6608                      bne.s      _pps_1
[000004ac] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000004b0] 4e5e                      unlk       a6
[000004b2] 4e75                      rts
_pps_1:
[000004b4] 4ab9 0002 0078            tst.l      _lflag
[000004ba] 6608                      bne.s      _pps_2
[000004bc] 2e3c 0002 0256            move.l     #$00024E6A,d7 "  PID  PPID STAT NAME    \n"
[000004c2] 6006                      bra.s      _pps_3
_pps_2:
[000004c4] 2e3c 0002 0209            move.l     #$00024E1D,d7 "  PID  PPID STAT NAME      PRI   NI  BASE WBASE  SIZE   FLAGS   CHANNEL DEV\n"
_pps_3:
[000004ca] 2e87                      move.l     d7,(a7)
[000004cc] 4eb9 0000 1394            jsr        _putfmt
[000004d2] 2a4c                      movea.l    a4,a5
_pps_37:
[000004d4] 2e0c                      move.l     a4,d7
[000004d6] deae fffc                 add.l      -4(a6),d7
[000004da] bbc7                      cmpa.l     d7,a5
[000004dc] 6400 043a                 bcc        _pps_4
[000004e0] 426e fffa                 clr.w      -6(a6)
_pps_8:
[000004e4] 0c6e 0008 fffa            cmpi.w     #$0008,-6(a6)
[000004ea] 6c42                      bge.s      _pps_5
[000004ec] 2e3c 0000 0080            move.l     #$00000080,d7
[000004f2] 3c2e fffa                 move.w     -6(a6),d6
[000004f6] eca7                      asr.l      d6,d7
[000004f8] 7c00                      moveq.l    #0,d6
[000004fa] 1c2d 0012                 move.b     18(a5),d6 p_flag
[000004fe] ce86                      and.l      d6,d7
[00000500] 6716                      beq.s      _pps_6
[00000502] 227c 0002 0271            movea.l    #$00024E85,a1 "WIOALMFX"
[00000508] 3e2e fffa                 move.w     -6(a6),d7
[0000050c] 1e31 7000                 move.b     0(a1,d7.w),d7
[00000510] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000516] 6002                      bra.s      _pps_7
_pps_6:
[00000518] 7e20                      moveq.l    #32,d7
_pps_7:
[0000051a] 227c 0002 01b0            movea.l    #flagbuf,a1
[00000520] 3c2e fffa                 move.w     -6(a6),d6
[00000524] 1387 6000                 move.b     d7,0(a1,d6.w)
[00000528] 526e fffa                 addq.w     #1,-6(a6)
[0000052c] 60b6                      bra.s      _pps_8
_pps_5:
[0000052e] 4ab9 0002 0088            tst.l      _tflag
[00000534] 6700 00e8                 beq        _pps_9
[00000538] 0c2d 0005 0013            cmpi.b     #$05,19(a5) p_stat
[0000053e] 6600 00de                 bne        _pps_9
[00000542] 0c39 0046 0002 01b6       cmpi.b     #$46,flagbuf+6
[0000054a] 6608                      bne.s      _pps_10
[0000054c] 13fc 0053 0002 01b6       move.b     #$53,flagbuf+6
_pps_10:
[00000554] 4297                      clr.l      (a7)
[00000556] 7e00                      moveq.l    #0,d7
[00000558] 3e2d 0024                 move.w     36(a5),d7 v.t.idev
[0000055c] 2f07                      move.l     d7,-(a7)
[0000055e] 2f3c 0002 0197            move.l     #device_name,-(a7)
[00000564] 4eba fb40                 jsr        _devname(pc)
[00000568] 508f                      addq.l     #8,a7
[0000056a] 4a39 0002 0197            tst.b      device_name
[00000570] 6634                      bne.s      _pps_11
[00000572] 7e00                      moveq.l    #0,d7
[00000574] 3e2d 0024                 move.w     36(a5),d7 v.t.idev
[00000578] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000057e] 2e87                      move.l     d7,(a7)
[00000580] 7e00                      moveq.l    #0,d7
[00000582] 3e2d 0024                 move.w     36(a5),d7 v.t.idev
[00000586] e087                      asr.l      #8,d7
[00000588] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000058e] 2f07                      move.l     d7,-(a7)
[00000590] 2f3c 0002 027a            move.l     #$00024E8E,-(a7) "%d/%d"
[00000596] 2f3c 0002 0197            move.l     #device_name,-(a7)
[0000059c] 4eb9 0000 1a94            jsr        _sprintf
[000005a2] 4fef 000c                 lea.l      12(a7),a7
_pps_11:
[000005a6] 2ebc 0002 0197            move.l     #device_name,(a7)
[000005ac] 2f3c 0002 01b0            move.l     #flagbuf,-(a7)
[000005b2] 7e00                      moveq.l    #0,d7
[000005b4] 3e2d 000c                 move.w     12(a5),d7 p_size
[000005b8] 2f07                      move.l     d7,-(a7)
[000005ba] 7e00                      moveq.l    #0,d7
[000005bc] 3e2d 000a                 move.w     10(a5),d7 p_wbase
[000005c0] 2f07                      move.l     d7,-(a7)
[000005c2] 7e00                      moveq.l    #0,d7
[000005c4] 3e2d 0008                 move.w     8(a5),d7 p_base
[000005c8] 2f07                      move.l     d7,-(a7)
[000005ca] 486d 0016                 pea.l      22(a5)
[000005ce] 4eba fe8e                 jsr        _pnm(pc)
[000005d2] 588f                      addq.l     #4,a7
[000005d4] 2f07                      move.l     d7,-(a7)
[000005d6] 4878 0008                 pea.l      ($00000008).w
[000005da] 7e07                      moveq.l    #7,d7
[000005dc] 7c00                      moveq.l    #0,d6
[000005de] 1c2d 0013                 move.b     19(a5),d6
[000005e2] ce86                      and.l      d6,d7
[000005e4] e587                      asl.l      #2,d7
[000005e6] 2247                      movea.l    d7,a1
[000005e8] d3fc 0002 01c2            adda.l     #stat_names,a1
[000005ee] 2f11                      move.l     (a1),-(a7)
[000005f0] 3e2d 001e                 move.w     30(a5),d7 p_pid
[000005f4] 48c7                      ext.l      d7
[000005f6] 2f07                      move.l     d7,-(a7)
[000005f8] 4ab9 0002 0078            tst.l      _lflag
[000005fe] 6608                      bne.s      _pps_12
[00000600] 2e3c 0002 02b5            move.l     #$00024EC9,d7 "%5us %5x %4p %- np\n"
[00000606] 6006                      bra.s      _pps_13
_pps_12:
                                                       "  PID  PPID STAT NAME      PRI   NI  BASE WBASE  SIZE   FLAGS   CHANNEL DEV\n"
[00000608] 2e3c 0002 0280            move.l     #$00024E94,d7 "%5us %5x %4p %- np %4x %4x %5u %5u %5u %- 8p %8x %p\n"
_pps_13:
[0000060e] 2f07                      move.l     d7,-(a7)
[00000610] 4eb9 0000 1394            jsr        _putfmt
[00000616] 4fef 0024                 lea.l      36(a7),a7
[0000061a] 6000 01e2                 bra        _pps_14

_pps_9:
[0000061e] 4aae 000c                 tst.l      12(a6)
[00000622] 6600 01da                 bne        _pps_14
[00000626] 0c2d 0005 0013            cmpi.b     #$05,19(a5)
[0000062c] 6700 01d0                 beq        _pps_14
[00000630] 4ab9 0002 0080            tst.l      _rflag
[00000636] 670a                      beq.s      _pps_15
[00000638] 0c2d 0003 0013            cmpi.b     #$03,19(a5)
[0000063e] 6600 01be                 bne        _pps_14
_pps_15:
[00000642] 4a6d 0022                 tst.w      34(a5)
[00000646] 6618                      bne.s      _pps_16
[00000648] 4297                      clr.l      (a7)
[0000064a] 2f3c 0002 02c9            move.l     #$00024EDD,-(a7) "none"
[00000650] 2f3c 0002 0197            move.l     #device_name,-(a7)
[00000656] 4eb9 0000 0dd6            jsr        _cpystr
[0000065c] 508f                      addq.l     #8,a7
[0000065e] 601a                      bra.s      _pps_17
_pps_16:
[00000660] 4878 0001                 pea.l      ($00000001).w
[00000664] 7e00                      moveq.l    #0,d7
[00000666] 3e2d 0022                 move.w     34(a5),d7
[0000066a] 2f07                      move.l     d7,-(a7)
[0000066c] 2f3c 0002 0197            move.l     #device_name,-(a7)
[00000672] 4eba fa32                 jsr        _devname(pc)
[00000676] 4fef 000c                 lea.l      12(a7),a7
_pps_17:
[0000067a] 4a39 0002 0197            tst.b      device_name
[00000680] 6634                      bne.s      _pps_18
[00000682] 7e00                      moveq.l    #0,d7
[00000684] 3e2d 0022                 move.w     34(a5),d7
[00000688] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000068e] 2e87                      move.l     d7,(a7)
[00000690] 7e00                      moveq.l    #0,d7
[00000692] 3e2d 0022                 move.w     34(a5),d7
[00000696] e087                      asr.l      #8,d7
[00000698] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000069e] 2f07                      move.l     d7,-(a7)
[000006a0] 2f3c 0002 02ce            move.l     #$00024EE2,-(a7) "%d/%d"
[000006a6] 2f3c 0002 0197            move.l     #device_name,-(a7)
[000006ac] 4eb9 0000 1a94            jsr        _sprintf
[000006b2] 4fef 000c                 lea.l      12(a7),a7
_pps_18:
[000006b6] 2ebc 0002 0197            move.l     #device_name,(a7)
[000006bc] 2f2d 0004                 move.l     4(a5),-(a7) p_chan
[000006c0] 2f3c 0002 01b0            move.l     #flagbuf,-(a7)
[000006c6] 7e00                      moveq.l    #0,d7
[000006c8] 3e2d 000c                 move.w     12(a5),d7 p_size
[000006cc] 2f07                      move.l     d7,-(a7)
[000006ce] 7e00                      moveq.l    #0,d7
[000006d0] 3e2d 000a                 move.w     10(a5),d7 p_wbase
[000006d4] 2f07                      move.l     d7,-(a7)
[000006d6] 7e00                      moveq.l    #0,d7
[000006d8] 3e2d 0008                 move.w     8(a5),d7 p_base
[000006dc] 2f07                      move.l     d7,-(a7)
[000006de] 1e2d 0015                 move.b     21(a5),d7 p_bias
[000006e2] 4887                      ext.w      d7
[000006e4] 48c7                      ext.l      d7
[000006e6] 2f07                      move.l     d7,-(a7)
[000006e8] 1e2d 0014                 move.b     20(a5),d7 p_pri
[000006ec] 4887                      ext.w      d7
[000006ee] 48c7                      ext.l      d7
[000006f0] 2f07                      move.l     d7,-(a7)
[000006f2] 486d 0016                 pea.l      22(a5) p_name
[000006f6] 4eba fd66                 jsr        _pnm(pc)
[000006fa] 588f                      addq.l     #4,a7
[000006fc] 2f07                      move.l     d7,-(a7)
[000006fe] 4878 0008                 pea.l      ($00000008).w
[00000702] 7e07                      moveq.l    #7,d7
[00000704] 7c00                      moveq.l    #0,d6
[00000706] 1c2d 0013                 move.b     19(a5),d6
[0000070a] ce86                      and.l      d6,d7
[0000070c] e587                      asl.l      #2,d7
[0000070e] 2247                      movea.l    d7,a1
[00000710] d3fc 0002 01c2            adda.l     #stat_names,a1
[00000716] 2f11                      move.l     (a1),-(a7)
[00000718] 3e2d 0040                 move.w     64(a5),d7  v.p.ppid
[0000071c] 48c7                      ext.l      d7
[0000071e] 2f07                      move.l     d7,-(a7)
[00000720] 3e2d 001e                 move.w     30(a5),d7 p_pid
[00000724] 48c7                      ext.l      d7
[00000726] 2f07                      move.l     d7,-(a7)
[00000728] 4ab9 0002 0078            tst.l      _lflag
[0000072e] 6608                      bne.s      _pps_19
[00000730] 2e3c 0002 030d            move.l     #$00024F21,d7 "%5us %5us %4p %- np\n"
[00000736] 6006                      bra.s      _pps_20
_pps_19:
[00000738] 2e3c 0002 02d4            move.l     #$00024EE8,d7 "%5us %5us %4p %- np %4c %4c %5us %5us %5us %- 8p %8h %p\n"
_pps_20:
[0000073e] 2f07                      move.l     d7,-(a7)
[00000740] 4eb9 0000 1394            jsr        _putfmt
[00000746] 4fef 0034                 lea.l      52(a7),a7
[0000074a] 4ab9 0002 0070            tst.l      _fflag
[00000750] 6700 00ac                 beq        _pps_14
[00000754] 7e00                      moveq.l    #0,d7
[00000756] 1e2d 0042                 move.b     66(a5),d7 v.p.ruid
[0000075a] 2e87                      move.l     d7,(a7)
[0000075c] 4eb9 0000 0aea            jsr        _usernm
[00000762] 2e87                      move.l     d7,(a7)
[00000764] 2f3c 0002 0322            move.l     #$00024F36,-(a7) "        user=%p "
[0000076a] 4eb9 0000 1394            jsr        _putfmt
[00000770] 588f                      addq.l     #4,a7
[00000772] 3e2d 0020                 move.w     32(a5),d7 p->p_pgrp
[00000776] 48c7                      ext.l      d7
[00000778] 2e87                      move.l     d7,(a7)
[0000077a] 2f3c 0002 0333            move.l     #$00024F47,-(a7) " pgroup=%i"
[00000780] 4eb9 0000 1394            jsr        _putfmt
[00000786] 588f                      addq.l     #4,a7
[00000788] 2ead 0038                 move.l     56(a5),(a7) v.p.freeheap
[0000078c] 2f3c 0002 033e            move.l     #$00024F52,-(a7) " free=%i"
[00000792] 4eb9 0000 1394            jsr        _putfmt
[00000798] 588f                      addq.l     #4,a7
[0000079a] 4a2d 0043                 tst.b      67(a5) v.p.slice
[0000079e] 6716                      beq.s      _pps_21
[000007a0] 7e00                      moveq.l    #0,d7
[000007a2] 1e2d 0043                 move.b     67(a5),d7
[000007a6] 2e87                      move.l     d7,(a7)
[000007a8] 2f3c 0002 0347            move.l     #$00024F5B,-(a7) " slice=%i"
[000007ae] 4eb9 0000 1394            jsr        _putfmt
[000007b4] 588f                      addq.l     #4,a7
_pps_21:
[000007b6] 4a2d 0044                 tst.b      68(a5)
[000007ba] 671e                      beq.s      _pps_22
[000007bc] 7e00                      moveq.l    #0,d7
[000007be] 1e2d 0044                 move.b     68(a5),d7
[000007c2] 2e87                      move.l     d7,(a7)
[000007c4] 4eb9 0000 09f6            jsr        _sigstr
[000007ca] 2e87                      move.l     d7,(a7)
[000007cc] 2f3c 0002 0351            move.l     #$00024F65,-(a7) " sig=%p"
[000007d2] 4eb9 0000 1394            jsr        _putfmt
[000007d8] 588f                      addq.l     #4,a7
_pps_22:
[000007da] 4aad 0034                 tst.l      52(a5) v.p.alarm
[000007de] 6712                      beq.s      _pps_23
[000007e0] 2ead 0034                 move.l     52(a5),(a7) v.p.alarm
[000007e4] 2f3c 0002 0359            move.l     #$00024F6D,-(a7) " alarm=%i"
[000007ea] 4eb9 0000 1394            jsr        _putfmt
[000007f0] 588f                      addq.l     #4,a7
_pps_23:
[000007f2] 2ebc 0002 0363            move.l     #$00024F77,(a7) "\n"
[000007f8] 4eb9 0000 1394            jsr        _putfmt

_pps_14:
[000007fe] 0c2d 0005 0013            cmpi.b     #$05,19(a5)
[00000804] 670e                      beq.s      _pps_24
[00000806] 4aad 0028                 tst.l      40(a5)
[0000080a] 6708                      beq.s      _pps_24
[0000080c] 43ed 0046                 lea.l      70(a5),a1
[00000810] 2e09                      move.l     a1,d7
[00000812] 6002                      bra.s      _pps_25
_pps_24:
[00000814] 7e00                      moveq.l    #0,d7
_pps_25:
[00000816] 2647                      movea.l    d7,a3
_pps_32:
[00000818] 2e0b                      move.l     a3,d7
[0000081a] 6700 00e2                 beq        _pps_26
[0000081e] 4ab9 0002 0080            tst.l      _rflag
[00000824] 6600 00d4                 bne        _pps_27
[00000828] 4aae 000c                 tst.l      12(a6)
[0000082c] 6600 00cc                 bne        _pps_27
[00000830] 486b 0014                 pea.l      20(a3)
[00000834] 4eba fc28                 jsr        _pnm(pc)
[00000838] 588f                      addq.l     #4,a7
[0000083a] 2e87                      move.l     d7,(a7)
[0000083c] 3e2b 0012                 move.w     18(a3),d7
[00000840] 48c7                      ext.l      d7
[00000842] 2f07                      move.l     d7,-(a7)
[00000844] 4878 0008                 pea.l      ($00000008).w
[00000848] 2f3c 0002 0365            move.l     #$00024F79,-(a7) "        zombie %i %- np"
[0000084e] 4eb9 0000 1394            jsr        _putfmt
[00000854] 4fef 000c                 lea.l      12(a7),a7
[00000858] 2eab 000c                 move.l     12(a3),(a7)
[0000085c] 2f3c 0002 037d            move.l     #$00024F91,-(a7) " free=%i"
[00000862] 4eb9 0000 1394            jsr        _putfmt
[00000868] 588f                      addq.l     #4,a7
[0000086a] 3e2b 0010                 move.w     16(a3),d7
[0000086e] 0247 00ff                 andi.w     #$00FF,d7
[00000872] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00000878] 6638                      bne.s      _pps_28
[0000087a] 4a6b 0010                 tst.w      16(a3)
[0000087e] 6708                      beq.s      _pps_29
[00000880] 2e3c 0002 0390            move.l     #$00024FA4,d7 "(failure)"
[00000886] 6006                      bra.s      _pps_30
_pps_29:
[00000888] 2e3c 0002 0386            move.l     #$00024F9A,d7 "(success)"
_pps_30:
[0000088e] 2e87                      move.l     d7,(a7)
[00000890] 3e2b 0010                 move.w     16(a3),d7
[00000894] 48c7                      ext.l      d7
[00000896] e087                      asr.l      #8,d7
[00000898] 2f07                      move.l     d7,-(a7)
[0000089a] 2f3c 0002 039a            move.l     #$00024FAE,-(a7) " exit status %i %p"
[000008a0] 4eb9 0000 1394            jsr        _putfmt
[000008a6] 508f                      addq.l     #8,a7
[000008a8] 6044                      bra.s      _pps_31
_pps_35:
[000008aa] 47eb 001c                 lea.l      28(a3),a3
[000008ae] 6000 ff68                 bra        _pps_32
_pps_28:
[000008b2] 082b 0007 0011            btst       #7,17(a3)
[000008b8] 6708                      beq.s      _pps_33
[000008ba] 2e3c 0002 03ae            move.l     #$00024FC2,d7 " -- core dumped"
[000008c0] 6006                      bra.s      _pps_34
_pps_33:
[000008c2] 2e3c 0002 03ad            move.l     #$00024FC1,d7 ""
_pps_34:
[000008c8] 2e87                      move.l     d7,(a7)
[000008ca] 7e7f                      moveq.l    #127,d7
[000008cc] 3c2b 0010                 move.w     16(a3),d6
[000008d0] 48c6                      ext.l      d6
[000008d2] ce86                      and.l      d6,d7
[000008d4] 2f07                      move.l     d7,-(a7)
[000008d6] 4eb9 0000 09f6            jsr        _sigstr
[000008dc] 588f                      addq.l     #4,a7
[000008de] 2f07                      move.l     d7,-(a7)
[000008e0] 2f3c 0002 03be            move.l     #$00024FD2,-(a7) " signal %p%p"
[000008e6] 4eb9 0000 1394            jsr        _putfmt
[000008ec] 508f                      addq.l     #8,a7
_pps_31:
[000008ee] 2ebc 0002 03cb            move.l     #$00024FDF,(a7) "\n"
[000008f4] 4eb9 0000 1394            jsr        _putfmt
_pps_27:
[000008fa] 4a93                      tst.l      (a3)
[000008fc] 66ac                      bne.s      _pps_35
_pps_26:
[000008fe] 4a95                      tst.l      (a5)
[00000900] 6716                      beq.s      _pps_4
[00000902] 2e0b                      move.l     a3,d7
[00000904] 670a                      beq.s      _pps_36
[00000906] 43eb 001c                 lea.l      28(a3),a1
[0000090a] 2a49                      movea.l    a1,a5
[0000090c] 6000 fbc6                 bra        _pps_37
_pps_36:
[00000910] 4bed 0046                 lea.l      70(a5),a5
[00000914] 6000 fbbe                 bra        _pps_37
_pps_4:
[00000918] 2e8c                      move.l     a4,(a7)
[0000091a] 4eb9 0000 1902            jsr        _free
[00000920] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00000924] 4e5e                      unlk       a6
[00000926] 4e75                      rts

_readfill:
[00000928] 4e56 0000                 link       a6,#0
[0000092c] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00000930] 4aae 000c                 tst.l      12(a6)
[00000934] 6732                      beq.s      _readfill_1
[00000936] 4297                      clr.l      (a7)
[00000938] 42a7                      clr.l      -(a7)
[0000093a] 2f2e 000c                 move.l     12(a6),-(a7)
[0000093e] 4eb9 0000 0d3e            jsr        _open
[00000944] 508f                      addq.l     #8,a7
[00000946] 2d47 0010                 move.l     d7,16(a6)
[0000094a] 6c1c                      bge.s      _readfill_1
[0000094c] 2eae 000c                 move.l     12(a6),(a7)
[00000950] 2f3c 0002 03cd            move.l     #$00024FE1,-(a7) "can',$27,'t open: "
[00000956] 4eb9 0000 13ee            jsr        _remark
[0000095c] 588f                      addq.l     #4,a7
[0000095e] 7e00                      moveq.l    #0,d7
[00000960] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00000964] 4e5e                      unlk       a6
[00000966] 4e75                      rts
_readfill_1:
[00000968] 3a3c 0200                 move.w     #$0200,d5
[0000096c] 48c5                      ext.l      d5

_readfill_6:
[0000096e] 4297                      clr.l      (a7)
[00000970] 2f05                      move.l     d5,-(a7)
[00000972] 4eb9 0000 0d74            jsr        _alloc
[00000978] 588f                      addq.l     #4,a7
[0000097a] 2a47                      movea.l    d7,a5
[0000097c] 2e85                      move.l     d5,(a7)
[0000097e] 2f0d                      move.l     a5,-(a7)
[00000980] 2f2e 0010                 move.l     16(a6),-(a7)
[00000984] 4eb9 0000 0d50            jsr        _read
[0000098a] 508f                      addq.l     #8,a7
[0000098c] 2807                      move.l     d7,d4
[0000098e] 6c20                      bge.s      _readfill_2
[00000990] 2eae 000c                 move.l     12(a6),(a7)
[00000994] 2f3c 0002 03da            move.l     #$00024FEE,-(a7) "device err "
[0000099a] 4eb9 0000 13ee            jsr        _remark
[000009a0] 588f                      addq.l     #4,a7
[000009a2] 2e8d                      move.l     a5,(a7)
[000009a4] 4eb9 0000 1902            jsr        _free
[000009aa] 7800                      moveq.l    #0,d4
[000009ac] 2a44                      movea.l    d4,a5
[000009ae] 6014                      bra.s      _readfill_3
_readfill_2:
[000009b0] 4297                      clr.l      (a7)
[000009b2] 42a7                      clr.l      -(a7)
[000009b4] 2f2e 0010                 move.l     16(a6),-(a7)
[000009b8] 4eb9 0000 0d1a            jsr        _lseek
[000009be] 508f                      addq.l     #8,a7
[000009c0] b885                      cmp.l      d5,d4
[000009c2] 6418                      bcc.s      _readfill_4
_readfill_3:
[000009c4] 226e 0008                 movea.l    8(a6),a1
[000009c8] 2284                      move.l     d4,(a1)
[000009ca] 4aae 000c                 tst.l      12(a6)
[000009ce] 671c                      beq.s      _readfill_5
[000009d0] 2eae 0010                 move.l     16(a6),(a7)
[000009d4] 4eb9 0000 0d62            jsr        _close
[000009da] 6010                      bra.s      _readfill_5
_readfill_4:
[000009dc] 2e8d                      move.l     a5,(a7)
[000009de] 4eb9 0000 1902            jsr        _free
[000009e4] 0685 0000 0200            addi.l     #$00000200,d5
[000009ea] 6082                      bra.s      _readfill_6

_readfill_5:
[000009ec] 2e0d                      move.l     a5,d7
[000009ee] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[000009f2] 4e5e                      unlk       a6
[000009f4] 4e75                      rts

_sigstr:
[000009f6] 4e56 fffc                 link       a6,#-4
[000009fa] 2e2e 0008                 move.l     8(a6),d7
[000009fe] 41f9 0002 04f2            lea.l      $00025106,a0
[00000a04] 4ef9 0000 4a06            jmp        a~jtab
case 1:
[00000a0a] 2e3c 0002 03fa            move.l     #$0002500E,d7 "hangup"
[00000a10] 4e5e                      unlk       a6
[00000a12] 4e75                      rts
case 2:
[00000a14] 2e3c 0002 0401            move.l     #$00025015,d7 "interrupt"
[00000a1a] 4e5e                      unlk       a6
[00000a1c] 4e75                      rts
case 3:
[00000a1e] 2e3c 0002 040b            move.l     #$0002501F,d7 "quit"
[00000a24] 4e5e                      unlk       a6
[00000a26] 4e75                      rts
case 4:
[00000a28] 2e3c 0002 0410            move.l     #$00025024,d7 "illegal instruction"
[00000a2e] 4e5e                      unlk       a6
[00000a30] 4e75                      rts
case 5:
[00000a32] 2e3c 0002 0424            move.l     #$00025038,d7 "trace trap"
[00000a38] 4e5e                      unlk       a6
[00000a3a] 4e75                      rts
case 6:
[00000a3c] 2e3c 0002 042f            move.l     #$00025043,d7 "range error"
[00000a42] 4e5e                      unlk       a6
[00000a44] 4e75                      rts
case 7:
[00000a46] 2e3c 0002 043b            move.l     #$0002504F,d7 "domain error"
[00000a4c] 4e5e                      unlk       a6
[00000a4e] 4e75                      rts
case 8:
[00000a50] 2e3c 0002 0448            move.l     #$0002505C,d7 "floating point/ aritmetic fault"
[00000a56] 4e5e                      unlk       a6
[00000a58] 4e75                      rts
case 9:
[00000a5a] 2e3c 0002 0468            move.l     #$0002507C,d7 "kill"
[00000a60] 4e5e                      unlk       a6
[00000a62] 4e75                      rts
case 10:
[00000a64] 2e3c 0002 046d            move.l     #$00025081,d7 "bus error"
[00000a6a] 4e5e                      unlk       a6
[00000a6c] 4e75                      rts
case 11:
[00000a6e] 2e3c 0002 0477            move.l     #$0002508B,d7 "segementation (bad address) error"
[00000a74] 4e5e                      unlk       a6
[00000a76] 4e75                      rts
case 12:
[00000a78] 2e3c 0002 0499            move.l     #$000250AD,d7 "bad system call"
[00000a7e] 4e5e                      unlk       a6
[00000a80] 4e75                      rts
case 13:
[00000a82] 2e3c 0002 04a9            move.l     #$000250BD,d7 "broken pipe"
[00000a88] 4e5e                      unlk       a6
[00000a8a] 4e75                      rts
case 14:
[00000a8c] 2e3c 0002 04b5            move.l     #$000250C9,d7 "alarm"
[00000a92] 4e5e                      unlk       a6
[00000a94] 4e75                      rts
case 15:
[00000a96] 2e3c 0002 04bb            move.l     #$000250CF,d7 "terminate"
[00000a9c] 4e5e                      unlk       a6
[00000a9e] 4e75                      rts
case 16:
[00000aa0] 2e3c 0002 04c5            move.l     #$000250D9,d7 "system call intercept"
[00000aa6] 4e5e                      unlk       a6
[00000aa8] 4e75                      rts
case 17:
[00000aaa] 2e3c 0002 04db            move.l     #$000250EF,d7 "user signal"
[00000ab0] 4e5e                      unlk       a6
[00000ab2] 4e75                      rts
default:
[00000ab4] 2eae 0008                 move.l     8(a6),(a7)
[00000ab8] 2f3c 0002 04e7            move.l     #$000250FB,-(a7) "signal#%i"
[00000abe] 4878 0013                 pea.l      ($00000013).w
[00000ac2] 2f3c 0002 03e6            move.l     #$00024FFA,-(a7)
[00000ac8] 4eb9 0000 0e34            jsr        _decode
[00000ace] 4fef 000c                 lea.l      12(a7),a7
[00000ad2] 2247                      movea.l    d7,a1
[00000ad4] d3fc 0002 03e6            adda.l     #$00024FFA,a1
[00000ada] 4211                      clr.b      (a1)
[00000adc] 2e3c 0002 03e6            move.l     #$00024FFA,d7
[00000ae2] 4e5e                      unlk       a6
[00000ae4] 4e75                      rts
xae6:
[00000ae6] 4e5e                      unlk       a6
[00000ae8] 4e75                      rts

_usernm:
[00000aea] 4e56 fffc                 link       a6,#-4
[00000aee] 48e7 8400                 movem.l    d0/d5,-(a7)
[00000af2] 2a2e 0008                 move.l     8(a6),d5
[00000af6] 2e85                      move.l     d5,(a7)
[00000af8] 2f3c 0002 055e            move.l     #$00025172,-(a7) "%i"
[00000afe] 4878 0013                 pea.l      ($00000013).w
[00000b02] 2f3c 0002 054a            move.l     #$0002515E,-(a7)
[00000b08] 4eb9 0000 0e34            jsr        _decode
[00000b0e] 4fef 000c                 lea.l      12(a7),a7
[00000b12] 2247                      movea.l    d7,a1
[00000b14] d3fc 0002 054a            adda.l     #$0002515E,a1
[00000b1a] 4211                      clr.b      (a1)
[00000b1c] 4297                      clr.l      (a7)
[00000b1e] 4878 0002                 pea.l      ($00000002).w
[00000b22] 2f3c 0002 054a            move.l     #$0002515E,-(a7)
[00000b28] 4eb9 0000 0bca            jsr        _getpw
[00000b2e] 508f                      addq.l     #8,a7
[00000b30] 2d47 fffc                 move.l     d7,-4(a6)
[00000b34] 6740                      beq.s      _usernm_1
[00000b36] 2ebc 0002 0561            move.l     #$00025175,(a7) ":\n"
[00000b3c] 2f2e fffc                 move.l     -4(a6),-(a7)
[00000b40] 4eb9 0000 175e            jsr        _instr
[00000b46] 588f                      addq.l     #4,a7
[00000b48] 2a07                      move.l     d7,d5
[00000b4a] 0c85 0000 0013            cmpi.l     #$00000013,d5
[00000b50] 6f04                      ble.s      _usernm_2
[00000b52] 7e13                      moveq.l    #19,d7
[00000b54] 6002                      bra.s      _usernm_3
_usernm_2:
[00000b56] 2e05                      move.l     d5,d7
_usernm_3:
[00000b58] 2e87                      move.l     d7,(a7)
[00000b5a] 2f2e fffc                 move.l     -4(a6),-(a7)
[00000b5e] 2f3c 0002 054a            move.l     #$0002515E,-(a7)
[00000b64] 4eb9 0000 0dba            jsr        _cpybuf
[00000b6a] 508f                      addq.l     #8,a7
[00000b6c] 227c 0002 054a            movea.l    #$0002515E,a1
[00000b72] 4231 5800                 clr.b      0(a1,d5.l)
_usernm_1:
[00000b76] 2e3c 0002 054a            move.l     #$0002515E,d7
[00000b7c] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00000b80] 4e5e                      unlk       a6
[00000b82] 4e75                      rts

xb84:
[00000b84] 4e56 fffc                 link       a6,#-4
[00000b88] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00000b8c] 2a6e 0008                 movea.l    8(a6),a5
[00000b90] 2a2e 000c                 move.l     12(a6),d5
xb84_2:
[00000b94] 2e05                      move.l     d5,d7
[00000b96] 5385                      subq.l     #1,d5
[00000b98] 4a87                      tst.l      d7
[00000b9a] 6724                      beq.s      xb84_1
[00000b9c] 0c15 000a                 cmpi.b     #$0A,(a5)
[00000ba0] 671e                      beq.s      xb84_1
[00000ba2] 2ebc 0002 0564            move.l     #$00025178,(a7) ":\n"
[00000ba8] 2f0d                      move.l     a5,-(a7)
[00000baa] 4eb9 0000 175e            jsr        _instr
[00000bb0] 588f                      addq.l     #4,a7
[00000bb2] 2807                      move.l     d7,d4
[00000bb4] dbc4                      adda.l     d4,a5
[00000bb6] 0c15 003a                 cmpi.b     #$3A,(a5)
[00000bba] 66d8                      bne.s      xb84_2
[00000bbc] 528d                      addq.l     #1,a5
[00000bbe] 60d4                      bra.s      xb84_2
xb84_1:
[00000bc0] 2e0d                      move.l     a5,d7
[00000bc2] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00000bc6] 4e5e                      unlk       a6
[00000bc8] 4e75                      rts

_getpw:
[00000bca] 4e56 fff8                 link       a6,#-8
[00000bce] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[00000bd2] 262e 000c                 move.l     12(a6),d3
[00000bd6] 2eae 0008                 move.l     8(a6),(a7)
[00000bda] 4eb9 0000 1382            jsr        _lenstr
[00000be0] 2807                      move.l     d7,d4
[00000be2] 4a39 0002 0ac4            tst.b      $000256D8
[00000be8] 6756                      beq.s      _getpw_1
[00000bea] 7e00                      moveq.l    #0,d7
[00000bec] 1e39 0002 0567            move.b     $0002517B,d7
[00000bf2] b687                      cmp.l      d7,d3
[00000bf4] 664a                      bne.s      _getpw_1
[00000bf6] 2e84                      move.l     d4,(a7)
[00000bf8] 2f03                      move.l     d3,-(a7)
[00000bfa] 2f3c 0002 0ac4            move.l     #$000256D8,-(a7)
[00000c00] 4eba ff82                 jsr        $00000B84(pc)
[00000c04] 508f                      addq.l     #8,a7
[00000c06] 2847                      movea.l    d7,a4
[00000c08] 2f0c                      move.l     a4,-(a7)
[00000c0a] 2f2e 0008                 move.l     8(a6),-(a7)
[00000c0e] 4eb9 0000 1474            jsr        _cmpbuf
[00000c14] 508f                      addq.l     #8,a7
[00000c16] 4a87                      tst.l      d7
[00000c18] 6726                      beq.s      _getpw_1
[00000c1a] 2ebc 0002 0568            move.l     #$0002517C,(a7) ":\n"
[00000c20] 2f0c                      move.l     a4,-(a7)
[00000c22] 4eb9 0000 175e            jsr        _instr
[00000c28] 588f                      addq.l     #4,a7
[00000c2a] be84                      cmp.l      d4,d7
[00000c2c] 6612                      bne.s      _getpw_1
[00000c2e] 2eae 0010                 move.l     16(a6),(a7)
[00000c32] 2f3c 0002 0ac4            move.l     #$000256D8,-(a7)
[00000c38] 4eba ff4a                 jsr        $00000B84(pc)
[00000c3c] 588f                      addq.l     #4,a7
[00000c3e] 601c                      bra.s      _getpw_2
_getpw_1:
[00000c40] 2ebc 0002 056b            move.l     #$0002517F,(a7) "r"
[00000c46] 2f3c 0002 056d            move.l     #$00025181,-(a7) "/adm/passwd"
[00000c4c] 4eb9 0000 195a            jsr        _fopen
[00000c52] 588f                      addq.l     #4,a7
[00000c54] 2647                      movea.l    d7,a3
[00000c56] 2e0b                      move.l     a3,d7
[00000c58] 660a                      bne.s      _getpw_3
[00000c5a] 7e00                      moveq.l    #0,d7
_getpw_2:
[00000c5c] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00000c60] 4e5e                      unlk       a6
[00000c62] 4e75                      rts
_getpw_3:
[00000c64] 9bcd                      suba.l     a5,a5
_getpw_5:
[00000c66] 4878 0080                 pea.l      ($00000080).w
[00000c6a] 2f3c 0002 0ac4            move.l     #$000256D8,-(a7)
[00000c70] 2f0b                      move.l     a3,-(a7)
[00000c72] 4eb9 0000 1644            jsr        _getl
[00000c78] 4fef 000c                 lea.l      12(a7),a7
[00000c7c] 2a07                      move.l     d7,d5
[00000c7e] 6752                      beq.s      _getpw_4
[00000c80] 0c85 0000 0080            cmpi.l     #$00000080,d5
[00000c86] 644a                      bcc.s      _getpw_4
[00000c88] 2e84                      move.l     d4,(a7)
[00000c8a] 2f03                      move.l     d3,-(a7)
[00000c8c] 2f3c 0002 0ac4            move.l     #$000256D8,-(a7)
[00000c92] 4eba fef0                 jsr        $00000B84(pc)
[00000c96] 508f                      addq.l     #8,a7
[00000c98] 2847                      movea.l    d7,a4
[00000c9a] 2f0c                      move.l     a4,-(a7)
[00000c9c] 2f2e 0008                 move.l     8(a6),-(a7)
[00000ca0] 4eb9 0000 1474            jsr        _cmpbuf
[00000ca6] 508f                      addq.l     #8,a7
[00000ca8] 4a87                      tst.l      d7
[00000caa] 67ba                      beq.s      _getpw_5
[00000cac] 2ebc 0002 0579            move.l     #$0002518D,(a7) ":\n"
[00000cb2] 2f0c                      move.l     a4,-(a7)
[00000cb4] 4eb9 0000 175e            jsr        _instr
[00000cba] 588f                      addq.l     #4,a7
[00000cbc] be84                      cmp.l      d4,d7
[00000cbe] 66a6                      bne.s      _getpw_5
[00000cc0] 2eae 0010                 move.l     16(a6),(a7)
[00000cc4] 2f3c 0002 0ac4            move.l     #$000256D8,-(a7)
[00000cca] 4eba feb8                 jsr        $00000B84(pc)
[00000cce] 588f                      addq.l     #4,a7
[00000cd0] 2a47                      movea.l    d7,a5
_getpw_4:
[00000cd2] 0c85 0000 0080            cmpi.l     #$00000080,d5
[00000cd8] 6622                      bne.s      _getpw_6
[00000cda] 4297                      clr.l      (a7)
[00000cdc] 2f3c 0002 057c            move.l     #$00025190,-(a7) "\n"
[00000ce2] 2f3c 0002 057e            move.l     #$00025192,-(a7) "/adm/passwd"
[00000ce8] 2f3c 0002 058a            move.l     #$0002519E,-(a7) "bad record in "
[00000cee] 4878 0002                 pea.l      ($00000002).w
[00000cf2] 4eb9 0000 13ba            jsr        _putstr
[00000cf8] 4fef 0010                 lea.l      16(a7),a7
_getpw_6:
[00000cfc] 2e8b                      move.l     a3,(a7)
[00000cfe] 4eb9 0000 18d0            jsr        _fclose
[00000d04] 2e0d                      move.l     a5,d7
[00000d06] 6704                      beq.s      _getpw_7
[00000d08] 2e03                      move.l     d3,d7
[00000d0a] 6002                      bra.s      _getpw_8
_getpw_7:
[00000d0c] 7eff                      moveq.l    #-1,d7
_getpw_8:
[00000d0e] 2607                      move.l     d7,d3
[00000d10] 2e0d                      move.l     a5,d7
[00000d12] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00000d16] 4e5e                      unlk       a6
[00000d18] 4e75                      rts

_lseek:
[00000d1a] 205f                      movea.l    (a7)+,a0
[00000d1c] 7e28                      moveq.l    #40,d7
[00000d1e] 4e41                      trap       #1
[00000d20] 6400 0008                 bcc.w      _lseek_1
[00000d24] 4ef9 0000 009a            jmp        seterr
_lseek_1:
[00000d2a] 4ed0                      jmp        (a0)

_sleep:
[00000d2c] 205f                      movea.l    (a7)+,a0
[00000d2e] 7e23                      moveq.l    #35,d7
[00000d30] 4e41                      trap       #1
[00000d32] 6400 0008                 bcc.w      _sleep_1
[00000d36] 4ef9 0000 009a            jmp        seterr
_sleep_1:
[00000d3c] 4ed0                      jmp        (a0)

_open:
[00000d3e] 205f                      movea.l    (a7)+,a0
[00000d40] 7e05                      moveq.l    #5,d7
[00000d42] 4e41                      trap       #1
[00000d44] 6400 0008                 bcc.w      _open_1
[00000d48] 4ef9 0000 009a            jmp        seterr
_open_1:
[00000d4e] 4ed0                      jmp        (a0)

_read:
[00000d50] 205f                      movea.l    (a7)+,a0
[00000d52] 7e03                      moveq.l    #3,d7
[00000d54] 4e41                      trap       #1
[00000d56] 6400 0008                 bcc.w      _read_1
[00000d5a] 4ef9 0000 009a            jmp        seterr
_read_1:
[00000d60] 4ed0                      jmp        (a0)

_close:
[00000d62] 205f                      movea.l    (a7)+,a0
[00000d64] 7e06                      moveq.l    #6,d7
[00000d66] 4e41                      trap       #1
[00000d68] 6400 0008                 bcc.w      _close_1
[00000d6c] 4ef9 0000 009a            jmp        seterr
_close_1:
[00000d72] 4ed0                      jmp        (a0)

_alloc:
[00000d74] 4e56 fffc                 link       a6,#-4
[00000d78] 2eae 000c                 move.l     12(a6),(a7)
[00000d7c] 2f2e 0008                 move.l     8(a6),-(a7)
[00000d80] 4eb9 0000 374e            jsr        __alloc
[00000d86] 588f                      addq.l     #4,a7
[00000d88] 4e5e                      unlk       a6
[00000d8a] 4e75                      rts

_lfree:
[00000d8c] 4e56 fffc                 link       a6,#-4
[00000d90] 2eae 0008                 move.l     8(a6),(a7)
[00000d94] 4eb9 0000 1902            jsr        _free
[00000d9a] 2e2e 000c                 move.l     12(a6),d7
[00000d9e] 4e5e                      unlk       a6
[00000da0] 4e75                      rts

_nalloc:
[00000da2] 4e56 fffc                 link       a6,#-4
[00000da6] 2eae 000c                 move.l     12(a6),(a7)
[00000daa] 2f2e 0008                 move.l     8(a6),-(a7)
[00000dae] 4eb9 0000 386e            jsr        __nalloc
[00000db4] 588f                      addq.l     #4,a7
[00000db6] 4e5e                      unlk       a6
[00000db8] 4e75                      rts

_cpybuf:
[00000dba] 4e56 fffc                 link       a6,#-4
[00000dbe] 2eae 0010                 move.l     16(a6),(a7)
[00000dc2] 2f2e 000c                 move.l     12(a6),-(a7)
[00000dc6] 2f2e 0008                 move.l     8(a6),-(a7)
[00000dca] 4eb9 0000 3ffc            jsr        __cpybuf
[00000dd0] 508f                      addq.l     #8,a7
[00000dd2] 4e5e                      unlk       a6
[00000dd4] 4e75                      rts

_cpystr:
[00000dd6] 48e7 0030                 movem.l    a2-a3,-(a7)
[00000dda] 206f 000c                 movea.l    12(a7),a0
[00000dde] 45ef 0010                 lea.l      16(a7),a2
_cpystr_2:
[00000de2] 265a                      movea.l    (a2)+,a3
[00000de4] 200b                      move.l     a3,d0
[00000de6] 6608                      bne.s      _cpystr_1
[00000de8] 2e08                      move.l     a0,d7
[00000dea] 4cdf 0c00                 movem.l    (a7)+,a2-a3
[00000dee] 4e75                      rts
_cpystr_1:
[00000df0] 10db                      move.b     (a3)+,(a0)+
[00000df2] 66fc                      bne.s      _cpystr_1
[00000df4] 5388                      subq.l     #1,a0
[00000df6] 60ea                      bra.s      _cpystr_2
[00000df8] 4e56 0000                 link       a6,#0
[00000dfc] 48e7 040c                 movem.l    d5/a4-a5,-(a7)
[00000e00] 2a6e 0008                 movea.l    8(a6),a5
[00000e04] 286e 000c                 movea.l    12(a6),a4
[00000e08] 2a2e 0010                 move.l     16(a6),d5
_cpystr_4:
[00000e0c] 4a85                      tst.l      d5
[00000e0e] 6f18                      ble.s      _cpystr_3
[00000e10] 2e2d 0008                 move.l     8(a5),d7
[00000e14] bead 0004                 cmp.l      4(a5),d7
[00000e18] 640e                      bcc.s      _cpystr_3
[00000e1a] 2255                      movea.l    (a5),a1
[00000e1c] 5295                      addq.l     #1,(a5)
[00000e1e] 129c                      move.b     (a4)+,(a1)
[00000e20] 52ad 0008                 addq.l     #1,8(a5)
[00000e24] 5385                      subq.l     #1,d5
[00000e26] 60e4                      bra.s      _cpystr_4
_cpystr_3:
[00000e28] 2e2e 0010                 move.l     16(a6),d7
[00000e2c] 4cdf 3020                 movem.l    (a7)+,d5/a4-a5
[00000e30] 4e5e                      unlk       a6
[00000e32] 4e75                      rts

_decode:
[00000e34] 4e56 fff4                 link       a6,#-12
[00000e38] 2d6e 0008 fff4            move.l     8(a6),-12(a6)
[00000e3e] 2d6e 000c fff8            move.l     12(a6),-8(a6)
[00000e44] 42ae fffc                 clr.l      -4(a6)
[00000e48] 486e 0014                 pea.l      20(a6)
[00000e4c] 2f2e 0010                 move.l     16(a6),-(a7)
[00000e50] 486e fff4                 pea.l      -12(a6)
[00000e54] 2f3c 0000 0df8            move.l     #$00000DF8,-(a7)
[00000e5a] 4eb9 0000 27f2            jsr        __putf
[00000e60] 4fef 0010                 lea.l      16(a7),a7
[00000e64] 2e2e fffc                 move.l     -4(a6),d7
[00000e68] 4e5e                      unlk       a6
[00000e6a] 4e75                      rts

xe6c:
[00000e6c] 4e56 0000                 link       a6,#0
[00000e70] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[00000e74] 267c 0000 4632            movea.l    #__write,a3
[00000e7a] 2a6e 0008                 movea.l    8(a6),a5
[00000e7e] 286e 000c                 movea.l    12(a6),a4
[00000e82] 4297                      clr.l      (a7)
[00000e84] 4eb9 0000 1406            jsr        _usage
[00000e8a] 2a07                      move.l     d7,d5
xe6c_9:
[00000e8c] 4a15                      tst.b      (a5)
[00000e8e] 6700 00ce                 beq        xe6c_1
[00000e92] 0c15 0046                 cmpi.b     #$46,(a5)
[00000e96] 6716                      beq.s      xe6c_2
[00000e98] 2e85                      move.l     d5,(a7)
[00000e9a] 2f0d                      move.l     a5,-(a7)
[00000e9c] 4878 0002                 pea.l      ($00000002).w
[00000ea0] 4eb9 0000 1320            jsr        $00001320
[00000ea6] 508f                      addq.l     #8,a7
[00000ea8] 2a07                      move.l     d7,d5
[00000eaa] 6000 00ac                 bra        xe6c_3
xe6c_2:
[00000eae] 4878 0002                 pea.l      ($00000002).w
[00000eb2] 2f3c 0002 059a            move.l     #$000251AE,-(a7) "-["
[00000eb8] 4878 0002                 pea.l      ($00000002).w
[00000ebc] 4e93                      jsr        (a3)
[00000ebe] 4fef 000c                 lea.l      12(a7),a7
[00000ec2] da87                      add.l      d7,d5
xe6c_8:
[00000ec4] 0c14 003a                 cmpi.b     #$3A,(a4)
[00000ec8] 6778                      beq.s      xe6c_4
[00000eca] 0c14 002c                 cmpi.b     #$2C,(a4)
[00000ece] 6620                      bne.s      xe6c_5
[00000ed0] 0c2c 003a 0001            cmpi.b     #$3A,1(a4)
[00000ed6] 6718                      beq.s      xe6c_5
[00000ed8] 2e85                      move.l     d5,(a7)
[00000eda] 2f3c 0002 059d            move.l     #$000251B1,-(a7) " "
[00000ee0] 4878 0002                 pea.l      ($00000002).w
[00000ee4] 4eb9 0000 1320            jsr        $00001320
[00000eea] 508f                      addq.l     #8,a7
[00000eec] 2a07                      move.l     d7,d5
[00000eee] 604e                      bra.s      xe6c_6
xe6c_5:
[00000ef0] 0c14 003e                 cmpi.b     #$3E,(a4)
[00000ef4] 6636                      bne.s      xe6c_7
[00000ef6] 4878 0001                 pea.l      ($00000001).w
[00000efa] 2f3c 0002 059f            move.l     #$000251B3,-(a7) "^"
[00000f00] 4878 0002                 pea.l      ($00000002).w
[00000f04] 4e93                      jsr        (a3)
[00000f06] 4fef 000c                 lea.l      12(a7),a7
[00000f0a] da87                      add.l      d7,d5
[00000f0c] 0c2c 003a 0001            cmpi.b     #$3A,1(a4)
[00000f12] 672a                      beq.s      xe6c_6
[00000f14] 2e85                      move.l     d5,(a7)
[00000f16] 2f3c 0002 05a1            move.l     #$000251B5,-(a7) " "
[00000f1c] 4878 0002                 pea.l      ($00000002).w
[00000f20] 4eb9 0000 1320            jsr        $00001320
[00000f26] 508f                      addq.l     #8,a7
[00000f28] 2a07                      move.l     d7,d5
[00000f2a] 6012                      bra.s      xe6c_6
xe6c_7:
[00000f2c] 4878 0001                 pea.l      ($00000001).w
[00000f30] 2f0c                      move.l     a4,-(a7)
[00000f32] 4878 0002                 pea.l      ($00000002).w
[00000f36] 4e93                      jsr        (a3)
[00000f38] 4fef 000c                 lea.l      12(a7),a7
[00000f3c] da87                      add.l      d7,d5
xe6c_6:
[00000f3e] 528c                      addq.l     #1,a4
[00000f40] 6082                      bra.s      xe6c_8
xe6c_4:
[00000f42] 4878 0001                 pea.l      ($00000001).w
[00000f46] 2f3c 0002 05a3            move.l     #$000251B7,-(a7) "]"
[00000f4c] 4878 0002                 pea.l      ($00000002).w
[00000f50] 4e93                      jsr        (a3)
[00000f52] 4fef 000c                 lea.l      12(a7),a7
[00000f56] da87                      add.l      d7,d5
xe6c_3:
[00000f58] 528d                      addq.l     #1,a5
[00000f5a] 6000 ff30                 bra        xe6c_9
xe6c_1:
[00000f5e] 4878 0001                 pea.l      ($00000001).w
[00000f62] 2f3c 0002 05a5            move.l     #$000251B9,-(a7) "\n"
[00000f68] 4878 0002                 pea.l      ($00000002).w
[00000f6c] 4e93                      jsr        (a3)
[00000f6e] 4fef 000c                 lea.l      12(a7),a7
[00000f72] 4878 0001                 pea.l      ($00000001).w
[00000f76] 4eb9 0000 004a            jsr        _exit
[00000f7c] 588f                      addq.l     #4,a7
[00000f7e] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[00000f82] 4e5e                      unlk       a6
[00000f84] 4e75                      rts

_getflags:
[00000f86] 4e56 ffe4                 link       a6,#-28
[00000f8a] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[00000f8e] 262e 0010                 move.l     16(a6),d3
[00000f92] 226e 000c                 movea.l    12(a6),a1
[00000f96] 5891                      addq.l     #4,(a1)
_getflags_3:
[00000f98] 226e 0008                 movea.l    8(a6),a1
[00000f9c] 4a91                      tst.l      (a1)
[00000f9e] 6700 0376                 beq        _getflags_1
[00000fa2] 226e 0008                 movea.l    8(a6),a1
[00000fa6] 5391                      subq.l     #1,(a1)
[00000fa8] 6700 036c                 beq        _getflags_1
[00000fac] 226e 000c                 movea.l    12(a6),a1
[00000fb0] 2251                      movea.l    (a1),a1
[00000fb2] 2851                      movea.l    (a1),a4
[00000fb4] 2ebc 0002 05a7            move.l     #$000251BB,(a7) "--"
[00000fba] 2f0c                      move.l     a4,-(a7)
[00000fbc] 4eb9 0000 2776            jsr        __cmpstr
[00000fc2] 588f                      addq.l     #4,a7
[00000fc4] 4a87                      tst.l      d7
[00000fc6] 6718                      beq.s      _getflags_2
[00000fc8] 226e 0008                 movea.l    8(a6),a1
[00000fcc] 5391                      subq.l     #1,(a1)
[00000fce] 226e 000c                 movea.l    12(a6),a1
[00000fd2] 5891                      addq.l     #4,(a1)
[00000fd4] 6000 0340                 bra        _getflags_1
_getflags_10:
[00000fd8] 226e 000c                 movea.l    12(a6),a1
[00000fdc] 5891                      addq.l     #4,(a1)
[00000fde] 60b8                      bra.s      _getflags_3
_getflags_2:
[00000fe0] 2ebc 0002 05aa            move.l     #$000251BE,(a7) "-"
[00000fe6] 2f0c                      move.l     a4,-(a7)
[00000fe8] 4eb9 0000 2776            jsr        __cmpstr
[00000fee] 588f                      addq.l     #4,a7
[00000ff0] 4a87                      tst.l      d7
[00000ff2] 6600 0322                 bne        _getflags_1
[00000ff6] 0c14 002d                 cmpi.b     #$2D,(a4)
[00000ffa] 6708                      beq.s      _getflags_4
[00000ffc] 0c14 002b                 cmpi.b     #$2B,(a4)
[00001000] 6600 0314                 bne        _getflags_1
_getflags_4:
[00001004] 0c14 002d                 cmpi.b     #$2D,(a4)
[00001008] 6602                      bne.s      _getflags_5
[0000100a] 528c                      addq.l     #1,a4
_getflags_5:
[0000100c] 4878 0004                 pea.l      ($00000004).w
[00001010] 2f0c                      move.l     a4,-(a7)
[00001012] 2f3c 0002 05ac            move.l     #$000251C0,-(a7)
[00001018] 4eb9 0000 1474            jsr        _cmpbuf
[0000101e] 4fef 000c                 lea.l      12(a7),a7
[00001022] 4a87                      tst.l      d7
[00001024] 675a                      beq.s      _getflags_6
[00001026] 4878 003a                 pea.l      ($0000003A).w
[0000102a] 2f03                      move.l     d3,-(a7)
[0000102c] 4eb9 0000 4284            jsr        __scnstr
[00001032] 508f                      addq.l     #8,a7
[00001034] 3d47 fff8                 move.w     d7,-8(a6)
[00001038] 3e2e fff8                 move.w     -8(a6),d7
[0000103c] 48c7                      ext.l      d7
[0000103e] 2247                      movea.l    d7,a1
[00001040] 4a31 3800                 tst.b      0(a1,d3.l)
[00001044] 6612                      bne.s      _getflags_7
[00001046] 0c2c 003a 0004            cmpi.b     #$3A,4(a4)
[0000104c] 670a                      beq.s      _getflags_7
[0000104e] 2e0c                      move.l     a4,d7
[00001050] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00001054] 4e5e                      unlk       a6
[00001056] 4e75                      rts
_getflags_7:
[00001058] 2e83                      move.l     d3,(a7)
[0000105a] 0c2c 003a 0004            cmpi.b     #$3A,4(a4)
[00001060] 670c                      beq.s      _getflags_8
[00001062] 2e03                      move.l     d3,d7
[00001064] 3c2e fff8                 move.w     -8(a6),d6
[00001068] 48c6                      ext.l      d6
[0000106a] de86                      add.l      d6,d7
[0000106c] 6006                      bra.s      _getflags_9
_getflags_8:
[0000106e] 2e3c 0002 0000            move.l     #$00024C14,d7
_getflags_9:
[00001074] 2247                      movea.l    d7,a1
[00001076] 4869 0001                 pea.l      1(a1)
[0000107a] 4eba fdf0                 jsr        $00000E6C(pc)
[0000107e] 588f                      addq.l     #4,a7
_getflags_6:
[00001080] 4a14                      tst.b      (a4)
[00001082] 6700 ff54                 beq        _getflags_10
[00001086] 4244                      clr.w      d4
[00001088] 2a0e                      move.l     a6,d5
[0000108a] 0685 0000 0014            addi.l     #$00000014,d5
[00001090] 264c                      movea.l    a4,a3
[00001092] 2a43                      movea.l    d3,a5
[00001094] 42ae fffc                 clr.l      -4(a6)
_getflags_18:
[00001098] 4aae fffc                 tst.l      -4(a6)
[0000109c] 66e2                      bne.s      _getflags_6
[0000109e] 7e00                      moveq.l    #0,d7
[000010a0] 1e15                      move.b     (a5),d7
[000010a2] 41f9 0002 05fa            lea.l      $0002520E,a0
[000010a8] 4ef9 0000 4a06            jmp        a~jtab
[000010ae] 7803                      moveq.l    #3,d4
[000010b0] 4a13                      tst.b      (a3)
[000010b2] 6704                      beq.s      _getflags_11
[000010b4] 2e0b                      move.l     a3,d7
[000010b6] 6016                      bra.s      _getflags_12
_getflags_11:
[000010b8] 226e 0008                 movea.l    8(a6),a1
[000010bc] 5391                      subq.l     #1,(a1)
[000010be] 670c                      beq.s      _getflags_13
[000010c0] 226e 000c                 movea.l    12(a6),a1
[000010c4] 5891                      addq.l     #4,(a1)
[000010c6] 2251                      movea.l    (a1),a1
[000010c8] 2e11                      move.l     (a1),d7
[000010ca] 6002                      bra.s      _getflags_12
_getflags_13:
[000010cc] 2e0b                      move.l     a3,d7
_getflags_12:
[000010ce] 2d47 ffec                 move.l     d7,-20(a6)
[000010d2] 266e ffec                 movea.l    -20(a6),a3
[000010d6] 2d4b ffe4                 move.l     a3,-28(a6)
_getflags_17:
[000010da] 226e ffe4                 movea.l    -28(a6),a1
[000010de] 4a11                      tst.b      (a1)
[000010e0] 672a                      beq.s      _getflags_14
[000010e2] 226e ffe4                 movea.l    -28(a6),a1
[000010e6] 0c11 005c                 cmpi.b     #$5C,(a1)
[000010ea] 6610                      bne.s      _getflags_15
[000010ec] 4297                      clr.l      (a7)
[000010ee] 486e ffe4                 pea.l      -28(a6)
[000010f2] 4eb9 0000 14da            jsr        _doesc
[000010f8] 588f                      addq.l     #4,a7
[000010fa] 6008                      bra.s      _getflags_16
_getflags_15:
[000010fc] 226e ffe4                 movea.l    -28(a6),a1
[00001100] 7e00                      moveq.l    #0,d7
[00001102] 1e11                      move.b     (a1),d7
_getflags_16:
[00001104] 16c7                      move.b     d7,(a3)+
[00001106] 52ae ffe4                 addq.l     #1,-28(a6)
[0000110a] 60ce                      bra.s      _getflags_17
_getflags_14:
[0000110c] 4213                      clr.b      (a3)
_getflags_21:
[0000110e] 528d                      addq.l     #1,a5
[00001110] 6086                      bra.s      _getflags_18
[00001112] 7801                      moveq.l    #1,d4
[00001114] 0c13 005c                 cmpi.b     #$5C,(a3)
[00001118] 670a                      beq.s      _getflags_19
[0000111a] 7e00                      moveq.l    #0,d7
[0000111c] 1e13                      move.b     (a3),d7
[0000111e] 2d47 ffec                 move.l     d7,-20(a6)
[00001122] 601a                      bra.s      _getflags_20
_getflags_19:
[00001124] 2d4b ffe4                 move.l     a3,-28(a6)
[00001128] 4297                      clr.l      (a7)
[0000112a] 486e ffe4                 pea.l      -28(a6)
[0000112e] 4eb9 0000 14da            jsr        _doesc
[00001134] 588f                      addq.l     #4,a7
[00001136] 2d47 ffec                 move.l     d7,-20(a6)
[0000113a] 266e ffe4                 movea.l    -28(a6),a3
_getflags_20:
[0000113e] 02ae 0000 00ff ffec       andi.l     #$000000FF,-20(a6)
[00001146] 4a13                      tst.b      (a3)
[00001148] 67c4                      beq.s      _getflags_21
[0000114a] 528b                      addq.l     #1,a3
[0000114c] 60c0                      bra.s      _getflags_21
[0000114e] 4a13                      tst.b      (a3)
[00001150] 6618                      bne.s      _getflags_22
[00001152] 226e 0008                 movea.l    8(a6),a1
[00001156] 5391                      subq.l     #1,(a1)
[00001158] 670c                      beq.s      _getflags_23
[0000115a] 226e 000c                 movea.l    12(a6),a1
[0000115e] 5891                      addq.l     #4,(a1)
[00001160] 2251                      movea.l    (a1),a1
[00001162] 2e11                      move.l     (a1),d7
[00001164] 6002                      bra.s      _getflags_24
_getflags_23:
[00001166] 2e0b                      move.l     a3,d7
_getflags_24:
[00001168] 2647                      movea.l    d7,a3
_getflags_22:
[0000116a] 4878 0001                 pea.l      ($00000001).w
[0000116e] 486e ffe8                 pea.l      -24(a6)
[00001172] 2f0b                      move.l     a3,-(a7)
[00001174] 4eb9 0000 4272            jsr        __lenstr
[0000117a] 588f                      addq.l     #4,a7
[0000117c] 2f07                      move.l     d7,-(a7)
[0000117e] 2f0b                      move.l     a3,-(a7)
[00001180] 4eb9 0000 3df0            jsr        __btol
[00001186] 4fef 0010                 lea.l      16(a7),a7
[0000118a] d7c7                      adda.l     d7,a3
[0000118c] 4a13                      tst.b      (a3)
[0000118e] 6718                      beq.s      _getflags_25
[00001190] 4878 003a                 pea.l      ($0000003A).w
[00001194] 2f0d                      move.l     a5,-(a7)
[00001196] 4eb9 0000 4284            jsr        __scnstr
[0000119c] 508f                      addq.l     #8,a7
[0000119e] 5387                      subq.l     #1,d7
[000011a0] dbc7                      adda.l     d7,a5
[000011a2] 4244                      clr.w      d4
[000011a4] 6000 ff68                 bra        _getflags_21
_getflags_25:
[000011a8] 0c2d 0023 0001            cmpi.b     #$23,1(a5)
[000011ae] 660e                      bne.s      _getflags_26
[000011b0] 528d                      addq.l     #1,a5
[000011b2] 2d6e ffe8 ffec            move.l     -24(a6),-20(a6)
[000011b8] 7802                      moveq.l    #2,d4
[000011ba] 6000 ff52                 bra        _getflags_21
_getflags_26:
[000011be] 2d6e ffe8 ffec            move.l     -24(a6),-20(a6)
[000011c4] 7801                      moveq.l    #1,d4
[000011c6] 6000 ff46                 bra        _getflags_21
[000011ca] 4a44                      tst.w      d4
[000011cc] 6738                      beq.s      _getflags_27
[000011ce] 3e04                      move.w     d4,d7
[000011d0] 48c7                      ext.l      d7
[000011d2] 41f9 0002 05b2            lea.l      $000251C6,a0
[000011d8] 4ef9 0000 4a06            jmp        a~jtab
[000011de] 2245                      movea.l    d5,a1
[000011e0] 2251                      movea.l    (a1),a1
[000011e2] 22ae ffec                 move.l     -20(a6),(a1)
[000011e6] 6012                      bra.s      _getflags_28
[000011e8] 2245                      movea.l    d5,a1
[000011ea] 2251                      movea.l    (a1),a1
[000011ec] 22ae ffec                 move.l     -20(a6),(a1)
[000011f0] 6008                      bra.s      _getflags_28
[000011f2] 2245                      movea.l    d5,a1
[000011f4] 2251                      movea.l    (a1),a1
[000011f6] 22ae ffec                 move.l     -20(a6),(a1)
_getflags_28:
[000011fa] 284b                      movea.l    a3,a4
[000011fc] 7001                      moveq.l    #1,d0
[000011fe] 2d40 fffc                 move.l     d0,-4(a6)
[00001202] 6000 ff0a                 bra        _getflags_21
_getflags_27:
[00001206] 4a15                      tst.b      (a5)
[00001208] 6604                      bne.s      _getflags_29
[0000120a] 2e0c                      move.l     a4,d7
[0000120c] 6064                      bra.s      _getflags_30
_getflags_29:
[0000120e] 0c15 003a                 cmpi.b     #$3A,(a5)
[00001212] 6610                      bne.s      _getflags_31
[00001214] 2e83                      move.l     d3,(a7)
[00001216] 528d                      addq.l     #1,a5
[00001218] 2f0d                      move.l     a5,-(a7)
[0000121a] 4eba fc50                 jsr        $00000E6C(pc)
[0000121e] 588f                      addq.l     #4,a7
[00001220] 6000 feec                 bra        _getflags_21
_getflags_31:
[00001224] 5885                      addq.l     #4,d5
[00001226] 264c                      movea.l    a4,a3
[00001228] 6000 fee4                 bra        _getflags_21
[0000122c] 4a44                      tst.w      d4
[0000122e] 6608                      bne.s      _getflags_32
[00001230] 5885                      addq.l     #4,d5
[00001232] 264c                      movea.l    a4,a3
[00001234] 6000 fed8                 bra        _getflags_21
_getflags_32:
[00001238] 2245                      movea.l    d5,a1
[0000123a] 2251                      movea.l    (a1),a1
[0000123c] 4a91                      tst.l      (a1)
[0000123e] 663a                      bne.s      _getflags_33
[00001240] 4878 003a                 pea.l      ($0000003A).w
[00001244] 2f0d                      move.l     a5,-(a7)
[00001246] 4eb9 0000 4284            jsr        __scnstr
[0000124c] 508f                      addq.l     #8,a7
[0000124e] 3d47 fff8                 move.w     d7,-8(a6)
[00001252] 3e2e fff8                 move.w     -8(a6),d7
[00001256] 4a35 7000                 tst.b      0(a5,d7.w)
[0000125a] 6714                      beq.s      _getflags_34
[0000125c] 2e83                      move.l     d3,(a7)
[0000125e] 3e2e fff8                 move.w     -8(a6),d7
[00001262] 4875 7001                 pea.l      1(a5,d7.w)
[00001266] 4eba fc04                 jsr        $00000E6C(pc)
[0000126a] 588f                      addq.l     #4,a7
[0000126c] 6000 fea0                 bra        _getflags_21
_getflags_34:
[00001270] 2e0c                      move.l     a4,d7
_getflags_30:
[00001272] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00001276] 4e5e                      unlk       a6
[00001278] 4e75                      rts
_getflags_33:
[0000127a] 3e04                      move.w     d4,d7
[0000127c] 48c7                      ext.l      d7
[0000127e] 41f9 0002 05d6            lea.l      $000251EA,a0
[00001284] 4ef9 0000 4a06            jmp        a~jtab
[0000128a] 2245                      movea.l    d5,a1
[0000128c] 2251                      movea.l    (a1),a1
[0000128e] 5889                      addq.l     #4,a1
[00001290] 2445                      movea.l    d5,a2
[00001292] 2452                      movea.l    (a2),a2
[00001294] 5392                      subq.l     #1,(a2)
[00001296] 2e12                      move.l     (a2),d7
[00001298] e587                      asl.l      #2,d7
[0000129a] 23ae ffec 7800            move.l     -20(a6),0(a1,d7.l)
[000012a0] 602e                      bra.s      _getflags_35
[000012a2] 2245                      movea.l    d5,a1
[000012a4] 2251                      movea.l    (a1),a1
[000012a6] 5889                      addq.l     #4,a1
[000012a8] 2445                      movea.l    d5,a2
[000012aa] 2452                      movea.l    (a2),a2
[000012ac] 5392                      subq.l     #1,(a2)
[000012ae] 2e12                      move.l     (a2),d7
[000012b0] e587                      asl.l      #2,d7
[000012b2] 23ae ffec 7800            move.l     -20(a6),0(a1,d7.l)
[000012b8] 6016                      bra.s      _getflags_35
[000012ba] 2245                      movea.l    d5,a1
[000012bc] 2251                      movea.l    (a1),a1
[000012be] 5889                      addq.l     #4,a1
[000012c0] 2445                      movea.l    d5,a2
[000012c2] 2452                      movea.l    (a2),a2
[000012c4] 5392                      subq.l     #1,(a2)
[000012c6] 2e12                      move.l     (a2),d7
[000012c8] e587                      asl.l      #2,d7
[000012ca] 23ae ffec 7800            move.l     -20(a6),0(a1,d7.l)
_getflags_35:
[000012d0] 284b                      movea.l    a3,a4
[000012d2] 7001                      moveq.l    #1,d0
[000012d4] 2d40 fffc                 move.l     d0,-4(a6)
[000012d8] 6000 fe34                 bra        _getflags_21
[000012dc] 1e15                      move.b     (a5),d7
[000012de] be13                      cmp.b      (a3),d7
[000012e0] 660e                      bne.s      _getflags_36
[000012e2] 7801                      moveq.l    #1,d4
[000012e4] 7001                      moveq.l    #1,d0
[000012e6] 2d40 ffec                 move.l     d0,-20(a6)
[000012ea] 528b                      addq.l     #1,a3
[000012ec] 6000 fe20                 bra        _getflags_21
_getflags_36:
[000012f0] 4244                      clr.w      d4
_getflags_38:
[000012f2] 4a15                      tst.b      (a5)
[000012f4] 6716                      beq.s      _getflags_37
[000012f6] 0c15 002c                 cmpi.b     #$2C,(a5)
[000012fa] 6710                      beq.s      _getflags_37
[000012fc] 0c15 003e                 cmpi.b     #$3E,(a5)
[00001300] 670a                      beq.s      _getflags_37
[00001302] 0c15 003a                 cmpi.b     #$3A,(a5)
[00001306] 6704                      beq.s      _getflags_37
[00001308] 528d                      addq.l     #1,a5
[0000130a] 60e6                      bra.s      _getflags_38
_getflags_37:
[0000130c] 538d                      subq.l     #1,a5
[0000130e] 6000 fdfe                 bra        _getflags_21
[00001312] 6000 fdfa                 bra        _getflags_21
_getflags_1:
[00001316] 7e00                      moveq.l    #0,d7
[00001318] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[0000131c] 4e5e                      unlk       a6
[0000131e] 4e75                      rts

x1320:
[00001320] 4e56 0000                 link       a6,#0
[00001324] 48e7 0c04                 movem.l    d4-d5/a5,-(a7)
[00001328] 2a2e 0008                 move.l     8(a6),d5
[0000132c] 2a6e 000c                 movea.l    12(a6),a5
[00001330] 282e 0010                 move.l     16(a6),d4
[00001334] 0c84 0000 003c            cmpi.l     #$0000003C,d4
[0000133a] 6f26                      ble.s      x1320_1
[0000133c] 0c15 0020                 cmpi.b     #$20,(a5)
[00001340] 6706                      beq.s      x1320_2
[00001342] 0c15 0009                 cmpi.b     #$09,(a5)
[00001346] 661a                      bne.s      x1320_1
x1320_2:
[00001348] 4878 0002                 pea.l      ($00000002).w
[0000134c] 2f3c 0002 063e            move.l     #$00025252,-(a7)
[00001352] 2f05                      move.l     d5,-(a7)
[00001354] 4eb9 0000 4632            jsr        __write
[0000135a] 4fef 000c                 lea.l      12(a7),a7
[0000135e] 7e04                      moveq.l    #4,d7
[00001360] 6018                      bra.s      x1320_3
x1320_1:
[00001362] 4878 0001                 pea.l      ($00000001).w
[00001366] 2f0d                      move.l     a5,-(a7)
[00001368] 2f05                      move.l     d5,-(a7)
[0000136a] 4eb9 0000 4632            jsr        __write
[00001370] 4fef 000c                 lea.l      12(a7),a7
[00001374] 2244                      movea.l    d4,a1
[00001376] 5289                      addq.l     #1,a1
[00001378] 2e09                      move.l     a1,d7
x1320_3:
[0000137a] 4cdf 2030                 movem.l    (a7)+,d4-d5/a5
[0000137e] 4e5e                      unlk       a6
[00001380] 4e75                      rts

_lenstr:
[00001382] 4e56 fffc                 link       a6,#-4
[00001386] 2eae 0008                 move.l     8(a6),(a7)
[0000138a] 4eb9 0000 4272            jsr        __lenstr
[00001390] 4e5e                      unlk       a6
[00001392] 4e75                      rts

_putfmt:
[00001394] 4e56 0000                 link       a6,#0
[00001398] 486e 000c                 pea.l      12(a6)
[0000139c] 2f2e 0008                 move.l     8(a6),-(a7)
[000013a0] 2f3c 0002 0cba            move.l     #$000258CE,-(a7)
[000013a6] 2f3c 0000 1798            move.l     #_putl,-(a7)
[000013ac] 4eb9 0000 27f2            jsr        __putf
[000013b2] 4fef 0010                 lea.l      16(a7),a7
[000013b6] 4e5e                      unlk       a6
[000013b8] 4e75                      rts

_putstr:
[000013ba] 4e56 0000                 link       a6,#0
[000013be] 48e7 8004                 movem.l    d0/a5,-(a7)
[000013c2] 4bee 000c                 lea.l      12(a6),a5
_putstr_2:
[000013c6] 4a95                      tst.l      (a5)
[000013c8] 671c                      beq.s      _putstr_1
[000013ca] 2e95                      move.l     (a5),(a7)
[000013cc] 4eb9 0000 4272            jsr        __lenstr
[000013d2] 2e87                      move.l     d7,(a7)
[000013d4] 2f15                      move.l     (a5),-(a7)
[000013d6] 2f2e 0008                 move.l     8(a6),-(a7)
[000013da] 4eb9 0000 3d34            jsr        __fwrite
[000013e0] 508f                      addq.l     #8,a7
[000013e2] 588d                      addq.l     #4,a5
[000013e4] 60e0                      bra.s      _putstr_2
_putstr_1:
[000013e6] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000013ea] 4e5e                      unlk       a6
[000013ec] 4e75                      rts

_remark:
[000013ee] 4e56 fffc                 link       a6,#-4
[000013f2] 2eae 000c                 move.l     12(a6),(a7)
[000013f6] 2f2e 0008                 move.l     8(a6),-(a7)
[000013fa] 4eb9 0000 43b4            jsr        __remark
[00001400] 588f                      addq.l     #4,a7
[00001402] 4e5e                      unlk       a6
[00001404] 4e75                      rts

_usage:
[00001406] 4e56 0000                 link       a6,#0
[0000140a] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[0000140e] 2a6e 0008                 movea.l    8(a6),a5
[00001412] 7a00                      moveq.l    #0,d5
[00001414] 4297                      clr.l      (a7)
[00001416] 2f0d                      move.l     a5,-(a7)
[00001418] 2f3c 0002 0642            move.l     #$00025256,-(a7)
[0000141e] 2f39 0002 0aba            move.l     _pname,-(a7)
[00001424] 2f3c 0002 0644            move.l     #$00025258,-(a7)
[0000142a] 4878 0002                 pea.l      ($00000002).w
[0000142e] 4eb9 0000 33ac            jsr        __putstr
[00001434] 4fef 0014                 lea.l      20(a7),a7
[00001438] 2e0d                      move.l     a5,d7
[0000143a] 6720                      beq.s      _usage_1
[0000143c] 2e8d                      move.l     a5,(a7)
[0000143e] 4eb9 0000 4272            jsr        __lenstr
[00001444] 2a07                      move.l     d7,d5
[00001446] 2e05                      move.l     d5,d7
[00001448] 0c35 000a 78ff            cmpi.b     #$0A,-1(a5,d7.l)
[0000144e] 660c                      bne.s      _usage_1
[00001450] 4878 0001                 pea.l      ($00000001).w
[00001454] 4eb9 0000 004a            jsr        _exit
[0000145a] 588f                      addq.l     #4,a7
_usage_1:
[0000145c] 2eb9 0002 0aba            move.l     _pname,(a7)
[00001462] 4eb9 0000 4272            jsr        __lenstr
[00001468] de85                      add.l      d5,d7
[0000146a] 5087                      addq.l     #8,d7
[0000146c] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00001470] 4e5e                      unlk       a6
[00001472] 4e75                      rts

_cmpbuf:
[00001474] 202f 000c                 move.l     12(a7),d0
[00001478] 671e                      beq.s      _cmpbuf_1
[0000147a] 2200                      move.l     d0,d1
[0000147c] 4840                      swap       d0
[0000147e] 5341                      subq.w     #1,d1
[00001480] 206f 0004                 movea.l    4(a7),a0
[00001484] 246f 0008                 movea.l    8(a7),a2
_cmpbuf_2:
[00001488] b508                      cmpm.b     (a0)+,(a2)+
[0000148a] 56c9 fffc                 dbne       d1,_cmpbuf_2
[0000148e] 56c8 fff8                 dbne       d0,_cmpbuf_2
[00001492] 6704                      beq.s      _cmpbuf_1
[00001494] 7e00                      moveq.l    #0,d7
[00001496] 4e75                      rts
_cmpbuf_1:
[00001498] 7e01                      moveq.l    #1,d7
[0000149a] 4e75                      rts

__cstat:
[0000149c] 33fc 000a 0002 0b48       move.w     #$000A,$0002575C
[000014a4] 42b9 0002 0c10            clr.l      $00025824
[000014aa] 42b9 0002 0c14            clr.l      $00025828
[000014b0] 13fc 0061 0002 0c18       move.b     #$61,$0002582C
[000014b8] 4239 0002 0c19            clr.b      $0002582D
[000014be] 4279 0002 0c1a            clr.w      $0002582E
[000014c4] 4279 0002 0c1c            clr.w      $00025830
[000014ca] 4279 0002 0c1e            clr.w      $00025832
[000014d0] 33fc ffff 0002 0c20       move.w     #$FFFF,$00025834
[000014d8] 4e75                      rts

_doesc:
[000014da] 4e56 fffe                 link       a6,#-2
[000014de] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[000014e2] 286e 0008                 movea.l    8(a6),a4
[000014e6] 267c 0002 08c0            movea.l    #_ctasc,a3
[000014ec] 262e 000c                 move.l     12(a6),d3
[000014f0] 2254                      movea.l    (a4),a1
[000014f2] 4be9 0001                 lea.l      1(a1),a5
[000014f6] 4a15                      tst.b      (a5)
[000014f8] 6608                      bne.s      _doesc_1
[000014fa] 2254                      movea.l    (a4),a1
[000014fc] 7e00                      moveq.l    #0,d7
[000014fe] 1e11                      move.b     (a1),d7
[00001500] 6034                      bra.s      _doesc_2
_doesc_1:
[00001502] 7e00                      moveq.l    #0,d7
[00001504] 1e15                      move.b     (a5),d7
[00001506] 2e87                      move.l     d7,(a7)
[00001508] 4eb9 0000 1918            jsr        _tolower
[0000150e] 2e87                      move.l     d7,(a7)
[00001510] 2f3c 0002 067a            move.l     #$0002528E,-(a7)
[00001516] 4eb9 0000 4284            jsr        __scnstr
[0000151c] 588f                      addq.l     #4,a7
[0000151e] 2a07                      move.l     d7,d5
[00001520] 0c85 0000 0006            cmpi.l     #$00000006,d5
[00001526] 6c16                      bge.s      _doesc_3
[00001528] 288d                      move.l     a5,(a4)
[0000152a] 2245                      movea.l    d5,a1
[0000152c] d3fc 0002 0682            adda.l     #$00025296,a1
[00001532] 7e00                      moveq.l    #0,d7
[00001534] 1e11                      move.b     (a1),d7
_doesc_2:
[00001536] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[0000153a] 4e5e                      unlk       a6
[0000153c] 4e75                      rts
_doesc_3:
[0000153e] 0c15 0078                 cmpi.b     #$78,(a5)
[00001542] 667a                      bne.s      _doesc_4
[00001544] 528d                      addq.l     #1,a5
[00001546] 7800                      moveq.l    #0,d4
[00001548] 2a04                      move.l     d4,d5
_doesc_7:
[0000154a] 4247                      clr.w      d7
[0000154c] 1e15                      move.b     (a5),d7
[0000154e] 1e33 7001                 move.b     1(a3,d7.w),d7
[00001552] 0207 0044                 andi.b     #$44,d7
[00001556] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000155c] 6756                      beq.s      _doesc_5
[0000155e] 0c84 0000 0003            cmpi.l     #$00000003,d4
[00001564] 6c4e                      bge.s      _doesc_5
[00001566] 7e00                      moveq.l    #0,d7
[00001568] 1e15                      move.b     (a5),d7
[0000156a] 2e87                      move.l     d7,(a7)
[0000156c] 2f3c 0002 064c            move.l     #$00025260,-(a7)
[00001572] 4eb9 0000 4284            jsr        __scnstr
[00001578] 588f                      addq.l     #4,a7
[0000157a] 3d47 fffe                 move.w     d7,-2(a6)
[0000157e] 3e2e fffe                 move.w     -2(a6),d7
[00001582] 48c7                      ext.l      d7
[00001584] 2247                      movea.l    d7,a1
[00001586] d3fc 0002 064c            adda.l     #$00025260,a1
[0000158c] 4a11                      tst.b      (a1)
[0000158e] 671e                      beq.s      _doesc_6
[00001590] 2e05                      move.l     d5,d7
[00001592] e987                      asl.l      #4,d7
[00001594] 227c 0002 0663            movea.l    #$00025277,a1
[0000159a] 3c2e fffe                 move.w     -2(a6),d6
[0000159e] 48c6                      ext.l      d6
[000015a0] 1c31 6800                 move.b     0(a1,d6.l),d6
[000015a4] 0286 0000 00ff            andi.l     #$000000FF,d6
[000015aa] 8e86                      or.l       d6,d7
[000015ac] 2a07                      move.l     d7,d5
_doesc_6:
[000015ae] 528d                      addq.l     #1,a5
[000015b0] 5284                      addq.l     #1,d4
[000015b2] 6096                      bra.s      _doesc_7
_doesc_5:
[000015b4] 43ed ffff                 lea.l      -1(a5),a1
[000015b8] 2889                      move.l     a1,(a4)
[000015ba] 2e05                      move.l     d5,d7
[000015bc] 6050                      bra.s      _doesc_8
_doesc_4:
[000015be] 4247                      clr.w      d7
[000015c0] 1e15                      move.b     (a5),d7
[000015c2] 0833 0002 7001            btst       #2,1(a3,d7.w)
[000015c8] 674c                      beq.s      _doesc_9
[000015ca] 7800                      moveq.l    #0,d4
[000015cc] 2a04                      move.l     d4,d5
_doesc_12:
[000015ce] 4247                      clr.w      d7
[000015d0] 1e15                      move.b     (a5),d7
[000015d2] 0833 0002 7001            btst       #2,1(a3,d7.w)
[000015d8] 672c                      beq.s      _doesc_10
[000015da] 0c84 0000 0003            cmpi.l     #$00000003,d4
[000015e0] 6c24                      bge.s      _doesc_10
[000015e2] 0c15 0038                 cmpi.b     #$38,(a5)
[000015e6] 6416                      bcc.s      _doesc_11
[000015e8] 2e05                      move.l     d5,d7
[000015ea] e787                      asl.l      #3,d7
[000015ec] 7cd0                      moveq.l    #-48,d6
[000015ee] 7400                      moveq.l    #0,d2
[000015f0] 1415                      move.b     (a5),d2
[000015f2] dc82                      add.l      d2,d6
[000015f4] 8e86                      or.l       d6,d7
[000015f6] 2a07                      move.l     d7,d5
[000015f8] 528d                      addq.l     #1,a5
[000015fa] 5284                      addq.l     #1,d4
[000015fc] 60d0                      bra.s      _doesc_12
_doesc_11:
[000015fe] 4a84                      tst.l      d4
[00001600] 6604                      bne.s      _doesc_10
[00001602] 7a00                      moveq.l    #0,d5
[00001604] 1a15                      move.b     (a5),d5
_doesc_10:
[00001606] 43ed ffff                 lea.l      -1(a5),a1
[0000160a] 2889                      move.l     a1,(a4)
[0000160c] 2e05                      move.l     d5,d7
_doesc_8:
[0000160e] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00001612] 4e5e                      unlk       a6
[00001614] 4e75                      rts
_doesc_9:
[00001616] 4a83                      tst.l      d3
[00001618] 6722                      beq.s      _doesc_13
[0000161a] 7e00                      moveq.l    #0,d7
[0000161c] 1e15                      move.b     (a5),d7
[0000161e] 2e87                      move.l     d7,(a7)
[00001620] 2f03                      move.l     d3,-(a7)
[00001622] 4eb9 0000 4284            jsr        __scnstr
[00001628] 588f                      addq.l     #4,a7
[0000162a] 2a07                      move.l     d7,d5
[0000162c] 2245                      movea.l    d5,a1
[0000162e] 4a31 3800                 tst.b      0(a1,d3.l)
[00001632] 6708                      beq.s      _doesc_13
[00001634] 288d                      move.l     a5,(a4)
[00001636] 7eff                      moveq.l    #-1,d7
[00001638] 9e85                      sub.l      d5,d7
[0000163a] 60d2                      bra.s      _doesc_8
_doesc_13:
[0000163c] 288d                      move.l     a5,(a4)
[0000163e] 7e00                      moveq.l    #0,d7
[00001640] 1e15                      move.b     (a5),d7
[00001642] 60ca                      bra.s      _doesc_8

_getl:
[00001644] 4e56 fffa                 link       a6,#-6
[00001648] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[0000164c] 267c 0000 44d4            movea.l    #__raise,a3
[00001652] 263c 0002 07f2            move.l     #_reaerr,d3
[00001658] 2a6e 0008                 movea.l    8(a6),a5
[0000165c] 286e 000c                 movea.l    12(a6),a4
[00001660] 2e0d                      move.l     a5,d7
[00001662] 660e                      bne.s      _getl_1
[00001664] 2ebc 0002 0760            move.l     #_fioerr,(a7)
[0000166a] 42a7                      clr.l      -(a7)
[0000166c] 4e93                      jsr        (a3)
[0000166e] 588f                      addq.l     #4,a7
[00001670] 6020                      bra.s      _getl_2
_getl_1:
[00001672] 082d 0004 0007            btst       #4,7(a5)
[00001678] 6618                      bne.s      _getl_2
[0000167a] 4297                      clr.l      (a7)
[0000167c] 2f0d                      move.l     a5,-(a7)
[0000167e] 4eb9 0000 259c            jsr        __chkio
[00001684] 588f                      addq.l     #4,a7
[00001686] 4a87                      tst.l      d7
[00001688] 6608                      bne.s      _getl_2
[0000168a] 2e83                      move.l     d3,(a7)
[0000168c] 42a7                      clr.l      -(a7)
[0000168e] 4e93                      jsr        (a3)
[00001690] 588f                      addq.l     #4,a7
_getl_2:
[00001692] 082d 0001 0006            btst       #1,6(a5)
[00001698] 6740                      beq.s      _getl_3
[0000169a] 7a00                      moveq.l    #0,d5
_getl_6:
[0000169c] baae 0010                 cmp.l      16(a6),d5
[000016a0] 6434                      bcc.s      _getl_4
[000016a2] 4878 0001                 pea.l      ($00000001).w
[000016a6] 486e fffb                 pea.l      -5(a6)
[000016aa] 2f0d                      move.l     a5,-(a7)
[000016ac] 4eb9 0000 2c66            jsr        __doread
[000016b2] 4fef 000c                 lea.l      12(a7),a7
[000016b6] 2807                      move.l     d7,d4
[000016b8] 6c0a                      bge.s      _getl_5
[000016ba] 2e83                      move.l     d3,(a7)
[000016bc] 42a7                      clr.l      -(a7)
[000016be] 4e93                      jsr        (a3)
[000016c0] 588f                      addq.l     #4,a7
[000016c2] 60d8                      bra.s      _getl_6
_getl_5:
[000016c4] 4a84                      tst.l      d4
[000016c6] 670e                      beq.s      _getl_4
[000016c8] 18ee fffb                 move.b     -5(a6),(a4)+
[000016cc] 5285                      addq.l     #1,d5
[000016ce] 0c2e 000a fffb            cmpi.b     #$0A,-5(a6)
[000016d4] 66c6                      bne.s      _getl_6
_getl_4:
[000016d6] 2e05                      move.l     d5,d7
[000016d8] 6046                      bra.s      _getl_7
_getl_3:
[000016da] 7a00                      moveq.l    #0,d5
_getl_12:
[000016dc] 4aad 0008                 tst.l      8(a5)
[000016e0] 662a                      bne.s      _getl_8
[000016e2] 2ead 000c                 move.l     12(a5),(a7)
[000016e6] 2b6d 0018 0014            move.l     24(a5),20(a5)
[000016ec] 2f2d 0014                 move.l     20(a5),-(a7)
[000016f0] 2f0d                      move.l     a5,-(a7)
[000016f2] 4eb9 0000 2c66            jsr        __doread
[000016f8] 508f                      addq.l     #8,a7
[000016fa] 2b47 0008                 move.l     d7,8(a5)
[000016fe] 4aad 0008                 tst.l      8(a5)
[00001702] 6c08                      bge.s      _getl_8
[00001704] 2e83                      move.l     d3,(a7)
[00001706] 42a7                      clr.l      -(a7)
[00001708] 4e93                      jsr        (a3)
[0000170a] 588f                      addq.l     #4,a7
_getl_8:
[0000170c] 4aad 0008                 tst.l      8(a5)
[00001710] 6e16                      bgt.s      _getl_9
[00001712] 70ff                      moveq.l    #-1,d0
[00001714] 2b40 0008                 move.l     d0,8(a5)
[00001718] 08ed 0000 0007            bset       #0,7(a5)
[0000171e] 7e00                      moveq.l    #0,d7
_getl_7:
[00001720] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00001724] 4e5e                      unlk       a6
[00001726] 4e75                      rts
_getl_9:
[00001728] baae 0010                 cmp.l      16(a6),d5
[0000172c] 6424                      bcc.s      _getl_10
[0000172e] 4aad 0008                 tst.l      8(a5)
[00001732] 6f1e                      ble.s      _getl_10
[00001734] 5285                      addq.l     #1,d5
[00001736] 53ad 0008                 subq.l     #1,8(a5)
[0000173a] 226d 0014                 movea.l    20(a5),a1
[0000173e] 52ad 0014                 addq.l     #1,20(a5)
[00001742] 1891                      move.b     (a1),(a4)
[00001744] 0c14 000a                 cmpi.b     #$0A,(a4)
[00001748] 6604                      bne.s      _getl_11
[0000174a] 2e05                      move.l     d5,d7
[0000174c] 60d2                      bra.s      _getl_7
_getl_11:
[0000174e] 528c                      addq.l     #1,a4
[00001750] 60d6                      bra.s      _getl_9
_getl_10:
[00001752] 2e2e 0010                 move.l     16(a6),d7
[00001756] be85                      cmp.l      d5,d7
[00001758] 6282                      bhi.s      _getl_12
[0000175a] 2e05                      move.l     d5,d7
[0000175c] 60c2                      bra.s      _getl_7

_instr:
[0000175e] 4e56 0000                 link       a6,#0
[00001762] 48e7 001c                 movem.l    a3-a5,-(a7)
[00001766] 266e 0008                 movea.l    8(a6),a3
[0000176a] 2a4b                      movea.l    a3,a5
_instr_5:
[0000176c] 4a15                      tst.b      (a5)
[0000176e] 671c                      beq.s      _instr_1
[00001770] 286e 000c                 movea.l    12(a6),a4
_instr_6:
[00001774] 4a14                      tst.b      (a4)
[00001776] 670c                      beq.s      _instr_2
[00001778] 1e15                      move.b     (a5),d7
[0000177a] be14                      cmp.b      (a4),d7
[0000177c] 660a                      bne.s      _instr_3
[0000177e] 2e0d                      move.l     a5,d7
[00001780] 9e8b                      sub.l      a3,d7
[00001782] 600c                      bra.s      _instr_4
_instr_2:
[00001784] 528d                      addq.l     #1,a5
[00001786] 60e4                      bra.s      _instr_5
_instr_3:
[00001788] 528c                      addq.l     #1,a4
[0000178a] 60e8                      bra.s      _instr_6
_instr_1:
[0000178c] 2e0d                      move.l     a5,d7
[0000178e] 9e8b                      sub.l      a3,d7
_instr_4:
[00001790] 4cdf 3800                 movem.l    (a7)+,a3-a5
[00001794] 4e5e                      unlk       a6
[00001796] 4e75                      rts

_putl:
[00001798] 4e56 fffc                 link       a6,#-4
[0000179c] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[000017a0] 283c 0000 44d4            move.l     #__raise,d4
[000017a6] 263c 0002 0854            move.l     #_wrierr,d3
[000017ac] 2a6e 0008                 movea.l    8(a6),a5
[000017b0] 286e 000c                 movea.l    12(a6),a4
[000017b4] 2e0d                      move.l     a5,d7
[000017b6] 6610                      bne.s      _putl_1
[000017b8] 2ebc 0002 0760            move.l     #_fioerr,(a7)
[000017be] 42a7                      clr.l      -(a7)
[000017c0] 2244                      movea.l    d4,a1
[000017c2] 4e91                      jsr        (a1)
[000017c4] 588f                      addq.l     #4,a7
[000017c6] 6024                      bra.s      _putl_2
_putl_1:
[000017c8] 082d 0005 0007            btst       #5,7(a5)
[000017ce] 661c                      bne.s      _putl_2
[000017d0] 4878 0001                 pea.l      ($00000001).w
[000017d4] 2f0d                      move.l     a5,-(a7)
[000017d6] 4eb9 0000 259c            jsr        __chkio
[000017dc] 508f                      addq.l     #8,a7
[000017de] 4a87                      tst.l      d7
[000017e0] 660a                      bne.s      _putl_2
[000017e2] 2e83                      move.l     d3,(a7)
[000017e4] 42a7                      clr.l      -(a7)
[000017e6] 2244                      movea.l    d4,a1
[000017e8] 4e91                      jsr        (a1)
[000017ea] 588f                      addq.l     #4,a7
_putl_2:
[000017ec] 082d 0001 0006            btst       #1,6(a5)
[000017f2] 6730                      beq.s      _putl_3
[000017f4] 4878 0001                 pea.l      ($00000001).w
[000017f8] 2f2e 0010                 move.l     16(a6),-(a7)
[000017fc] 2f0c                      move.l     a4,-(a7)
[000017fe] 2f0d                      move.l     a5,-(a7)
[00001800] 4eb9 0000 2cec            jsr        __dowrite
[00001806] 4fef 0010                 lea.l      16(a7),a7
[0000180a] 4a87                      tst.l      d7
[0000180c] 660a                      bne.s      _putl_4
[0000180e] 2e83                      move.l     d3,(a7)
[00001810] 42a7                      clr.l      -(a7)
[00001812] 2244                      movea.l    d4,a1
[00001814] 4e91                      jsr        (a1)
[00001816] 588f                      addq.l     #4,a7
_putl_4:
[00001818] 2e2e 0010                 move.l     16(a6),d7
[0000181c] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00001820] 4e5e                      unlk       a6
[00001822] 4e75                      rts
_putl_3:
[00001824] 2a2e 0010                 move.l     16(a6),d5
_putl_8:
[00001828] 4a85                      tst.l      d5
[0000182a] 6750                      beq.s      _putl_5
[0000182c] 2e2d 0018                 move.l     24(a5),d7
[00001830] dead 0008                 add.l      8(a5),d7
[00001834] 2647                      movea.l    d7,a3
_putl_7:
[00001836] 4a85                      tst.l      d5
[00001838] 6714                      beq.s      _putl_6
[0000183a] 2e2d 0008                 move.l     8(a5),d7
[0000183e] bead 000c                 cmp.l      12(a5),d7
[00001842] 6c0a                      bge.s      _putl_6
[00001844] 16dc                      move.b     (a4)+,(a3)+
[00001846] 5385                      subq.l     #1,d5
[00001848] 52ad 0008                 addq.l     #1,8(a5)
[0000184c] 60e8                      bra.s      _putl_7
_putl_6:
[0000184e] 4a85                      tst.l      d5
[00001850] 67d6                      beq.s      _putl_8
[00001852] 4297                      clr.l      (a7)
[00001854] 2f2d 000c                 move.l     12(a5),-(a7)
[00001858] 2f2d 0018                 move.l     24(a5),-(a7)
[0000185c] 2f0d                      move.l     a5,-(a7)
[0000185e] 4eb9 0000 2cec            jsr        __dowrite
[00001864] 4fef 000c                 lea.l      12(a7),a7
[00001868] 4a87                      tst.l      d7
[0000186a] 660a                      bne.s      _putl_9
[0000186c] 2e83                      move.l     d3,(a7)
[0000186e] 42a7                      clr.l      -(a7)
[00001870] 2244                      movea.l    d4,a1
[00001872] 4e91                      jsr        (a1)
[00001874] 588f                      addq.l     #4,a7
_putl_9:
[00001876] 42ad 0008                 clr.l      8(a5)
[0000187a] 60ac                      bra.s      _putl_8
_putl_5:
[0000187c] 082d 0000 0006            btst       #0,6(a5)
[00001882] 6640                      bne.s      _putl_10
[00001884] 4aad 0008                 tst.l      8(a5)
[00001888] 673a                      beq.s      _putl_10
[0000188a] 226d 0018                 movea.l    24(a5),a1
[0000188e] 2e2d 0008                 move.l     8(a5),d7
[00001892] 0c31 000a 78ff            cmpi.b     #$0A,-1(a1,d7.l)
[00001898] 662a                      bne.s      _putl_10
[0000189a] 4878 0001                 pea.l      ($00000001).w
[0000189e] 2f2d 0008                 move.l     8(a5),-(a7)
[000018a2] 2f2d 0018                 move.l     24(a5),-(a7)
[000018a6] 2f0d                      move.l     a5,-(a7)
[000018a8] 4eb9 0000 2cec            jsr        __dowrite
[000018ae] 4fef 0010                 lea.l      16(a7),a7
[000018b2] 4a87                      tst.l      d7
[000018b4] 660a                      bne.s      _putl_11
[000018b6] 2e83                      move.l     d3,(a7)
[000018b8] 42a7                      clr.l      -(a7)
[000018ba] 2244                      movea.l    d4,a1
[000018bc] 4e91                      jsr        (a1)
[000018be] 588f                      addq.l     #4,a7
_putl_11:
[000018c0] 42ad 0008                 clr.l      8(a5)
_putl_10:
[000018c4] 2e2e 0010                 move.l     16(a6),d7
[000018c8] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[000018cc] 4e5e                      unlk       a6
[000018ce] 4e75                      rts

_fclose:
[000018d0] 4e56 fffc                 link       a6,#-4
[000018d4] 4aae 0008                 tst.l      8(a6)
[000018d8] 6614                      bne.s      _fclose_1
[000018da] 2ebc 0002 074a            move.l     #_filerr,(a7)
[000018e0] 42a7                      clr.l      -(a7)
[000018e2] 4eb9 0000 44d4            jsr        __raise
[000018e8] 588f                      addq.l     #4,a7
[000018ea] 4e5e                      unlk       a6
[000018ec] 4e75                      rts
_fclose_1:
[000018ee] 4878 0001                 pea.l      ($00000001).w
[000018f2] 2f2e 0008                 move.l     8(a6),-(a7)
[000018f6] 4eb9 0000 2bb0            jsr        __doclose
[000018fc] 508f                      addq.l     #8,a7
[000018fe] 4e5e                      unlk       a6
[00001900] 4e75                      rts

_free:
[00001902] 4e56 fffc                 link       a6,#-4
[00001906] 4297                      clr.l      (a7)
[00001908] 2f2e 0008                 move.l     8(a6),-(a7)
[0000190c] 4eb9 0000 37ac            jsr        __free
[00001912] 588f                      addq.l     #4,a7
[00001914] 4e5e                      unlk       a6
[00001916] 4e75                      rts

_tolower:
[00001918] 4e56 fffc                 link       a6,#-4
[0000191c] 2eae 0008                 move.l     8(a6),(a7)
[00001920] 4eb9 0000 1a38            jsr        _isupper
[00001926] 4a87                      tst.l      d7
[00001928] 6708                      beq.s      _tolower_1
[0000192a] 7e20                      moveq.l    #32,d7
[0000192c] deae 0008                 add.l      8(a6),d7
[00001930] 6004                      bra.s      _tolower_2
_tolower_1:
[00001932] 2e2e 0008                 move.l     8(a6),d7
_tolower_2:
[00001936] 4e5e                      unlk       a6
[00001938] 4e75                      rts

__astat:
[0000193a] 23fc 0002 0c82 0002 0c22  move.l     #$00025896,$00025836
[00001944] 23fc 0002 0c9e 0002 0c26  move.l     #$000258B2,$0002583A
[0000194e] 23fc 0002 0cba 0002 0c2a  move.l     #$000258CE,$0002583E
[00001958] 4e75                      rts

_fopen:
[0000195a] 4e56 fffc                 link       a6,#-4
[0000195e] 4297                      clr.l      (a7)
[00001960] 2f2e 000c                 move.l     12(a6),-(a7)
[00001964] 2f2e 0008                 move.l     8(a6),-(a7)
[00001968] 4eb9 0000 1974            jsr        _freopen
[0000196e] 508f                      addq.l     #8,a7
[00001970] 4e5e                      unlk       a6
[00001972] 4e75                      rts

_freopen:
[00001974] 4e56 fffa                 link       a6,#-6
[00001978] 48e7 9c0c                 movem.l    d0/d3-d5/a4-a5,-(a7)
[0000197c] 286e 0010                 movea.l    16(a6),a4
[00001980] 2e0c                      move.l     a4,d7
[00001982] 670c                      beq.s      _freopen_1
[00001984] 4297                      clr.l      (a7)
[00001986] 2f0c                      move.l     a4,-(a7)
[00001988] 4eb9 0000 2bb0            jsr        __doclose
[0000198e] 588f                      addq.l     #4,a7
_freopen_1:
[00001990] 2eae 000c                 move.l     12(a6),(a7)
[00001994] 4eb9 0000 330a            jsr        __parstype
[0000199a] 2607                      move.l     d7,d3
[0000199c] 0c83 ffff ffff            cmpi.l     #$FFFFFFFF,d3
[000019a2] 6604                      bne.s      _freopen_2
[000019a4] 7e00                      moveq.l    #0,d7
[000019a6] 6064                      bra.s      _freopen_3
_freopen_2:
[000019a8] 3803                      move.w     d3,d4
[000019aa] 4878 002c                 pea.l      ($0000002C).w
[000019ae] 2f2e 000c                 move.l     12(a6),-(a7)
[000019b2] 4eb9 0000 24f4            jsr        _strchr
[000019b8] 508f                      addq.l     #8,a7
[000019ba] 2a47                      movea.l    d7,a5
[000019bc] 2e0d                      move.l     a5,d7
[000019be] 6706                      beq.s      _freopen_4
[000019c0] 08c4 000c                 bset       #12,d4
[000019c4] 528d                      addq.l     #1,a5
_freopen_4:
[000019c6] 2e0d                      move.l     a5,d7
[000019c8] 671e                      beq.s      _freopen_5
[000019ca] 2e8d                      move.l     a5,(a7)
[000019cc] 4878 01b6                 pea.l      ($000001B6).w
[000019d0] 7e00                      moveq.l    #0,d7
[000019d2] 3e04                      move.w     d4,d7
[000019d4] 2f07                      move.l     d7,-(a7)
[000019d6] 2f2e 0008                 move.l     8(a6),-(a7)
[000019da] 4eb9 0000 32f8            jsr        __open
[000019e0] 4fef 000c                 lea.l      12(a7),a7
[000019e4] 2a07                      move.l     d7,d5
[000019e6] 601e                      bra.s      _freopen_6
_freopen_5:
[000019e8] 0884 000c                 bclr       #12,d4
[000019ec] 4878 01b6                 pea.l      ($000001B6).w
[000019f0] 7e00                      moveq.l    #0,d7
[000019f2] 3e04                      move.w     d4,d7
[000019f4] 2f07                      move.l     d7,-(a7)
[000019f6] 2f2e 0008                 move.l     8(a6),-(a7)
[000019fa] 4eb9 0000 32f8            jsr        __open
[00001a00] 4fef 000c                 lea.l      12(a7),a7
[00001a04] 2a07                      move.l     d7,d5
_freopen_6:
[00001a06] 4a85                      tst.l      d5
[00001a08] 6c0a                      bge.s      _freopen_7
[00001a0a] 7e00                      moveq.l    #0,d7
_freopen_3:
[00001a0c] 4cdf 3039                 movem.l    (a7)+,d0/d3-d5/a4-a5
[00001a10] 4e5e                      unlk       a6
[00001a12] 4e75                      rts
_freopen_7:
[00001a14] 2e0c                      move.l     a4,d7
[00001a16] 6708                      beq.s      _freopen_8
[00001a18] 2e3c 0000 4000            move.l     #$00004000,d7
[00001a1e] 6002                      bra.s      _freopen_9
_freopen_8:
[00001a20] 7e00                      moveq.l    #0,d7
_freopen_9:
[00001a22] 7c00                      moveq.l    #0,d6
[00001a24] 3c04                      move.w     d4,d6
[00001a26] 8e86                      or.l       d6,d7
[00001a28] 2e87                      move.l     d7,(a7)
[00001a2a] 2f05                      move.l     d5,-(a7)
[00001a2c] 2f0c                      move.l     a4,-(a7)
[00001a2e] 4eb9 0000 2ffa            jsr        __finit
[00001a34] 508f                      addq.l     #8,a7
[00001a36] 60d4                      bra.s      _freopen_3

_isupper:
[00001a38] 4e56 0000                 link       a6,#0
[00001a3c] 4aae 0008                 tst.l      8(a6)
[00001a40] 6c04                      bge.s      _isupper_1
[00001a42] 7e00                      moveq.l    #0,d7
[00001a44] 601c                      bra.s      _isupper_2
_isupper_1:
[00001a46] 1e2e 000b                 move.b     11(a6),d7
[00001a4a] 0287 0000 00ff            andi.l     #$000000FF,d7
[00001a50] 2247                      movea.l    d7,a1
[00001a52] d3fc 0002 08c1            adda.l     #$000254D5,a1
[00001a58] 7e00                      moveq.l    #0,d7
[00001a5a] 1e11                      move.b     (a1),d7
[00001a5c] 7c01                      moveq.l    #1,d6
[00001a5e] cc87                      and.l      d7,d6
[00001a60] 2e06                      move.l     d6,d7
_isupper_2:
[00001a62] 4e5e                      unlk       a6
[00001a64] 4e75                      rts

__cache:
[00001a66] 4e56 0000                 link       a6,#0
[00001a6a] 48e7 040c                 movem.l    d5/a4-a5,-(a7)
[00001a6e] 2a6e 0008                 movea.l    8(a6),a5
[00001a72] 2a2e 000c                 move.l     12(a6),d5
[00001a76] 286e 0010                 movea.l    16(a6),a4
__cache_2:
[00001a7a] 5385                      subq.l     #1,d5
[00001a7c] 6d08                      blt.s      __cache_1
[00001a7e] 2254                      movea.l    (a4),a1
[00001a80] 5294                      addq.l     #1,(a4)
[00001a82] 129d                      move.b     (a5)+,(a1)
[00001a84] 60f4                      bra.s      __cache_2
__cache_1:
[00001a86] 2254                      movea.l    (a4),a1
[00001a88] 4211                      clr.b      (a1)
[00001a8a] 7e01                      moveq.l    #1,d7
[00001a8c] 4cdf 3020                 movem.l    (a7)+,d5/a4-a5
[00001a90] 4e5e                      unlk       a6
[00001a92] 4e75                      rts

_sprintf:
[00001a94] 4e56 fffc                 link       a6,#-4
[00001a98] 2d6e 0008 fffc            move.l     8(a6),-4(a6)
[00001a9e] 486e 0010                 pea.l      16(a6)
[00001aa2] 2f2e 000c                 move.l     12(a6),-(a7)
[00001aa6] 486e fffc                 pea.l      -4(a6)
[00001aaa] 2f3c 0000 1a66            move.l     #__cache,-(a7)
[00001ab0] 4eb9 0000 1bee            jsr        __print
[00001ab6] 4fef 0010                 lea.l      16(a7),a7
[00001aba] 4e5e                      unlk       a6
[00001abc] 4e75                      rts

x1abe:
[00001abe] 4e56 0000                 link       a6,#0
[00001ac2] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00001ac6] 2a6e 0008                 movea.l    8(a6),a5
[00001aca] 2a2e 000c                 move.l     12(a6),d5
x1abe_2:
[00001ace] 4a15                      tst.b      (a5)
[00001ad0] 6718                      beq.s      x1abe_1
[00001ad2] 4a85                      tst.l      d5
[00001ad4] 6714                      beq.s      x1abe_1
[00001ad6] 7e00                      moveq.l    #0,d7
[00001ad8] 1e15                      move.b     (a5),d7
[00001ada] 2e87                      move.l     d7,(a7)
[00001adc] 4eb9 0000 254c            jsr        _toupper
[00001ae2] 1a87                      move.b     d7,(a5)
[00001ae4] 528d                      addq.l     #1,a5
[00001ae6] 5385                      subq.l     #1,d5
[00001ae8] 60e4                      bra.s      x1abe_2
x1abe_1:
[00001aea] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00001aee] 4e5e                      unlk       a6
[00001af0] 4e75                      rts

x1af2:
[00001af2] 4e56 fffc                 link       a6,#-4
[00001af6] 48e7 1c1c                 movem.l    d3-d5/a3-a5,-(a7)
[00001afa] 262e 0018                 move.l     24(a6),d3
[00001afe] 2a6e 0008                 movea.l    8(a6),a5
[00001b02] 286e 000c                 movea.l    12(a6),a4
[00001b06] 266e 0010                 movea.l    16(a6),a3
[00001b0a] 2a2e 0014                 move.l     20(a6),d5
[00001b0e] 7800                      moveq.l    #0,d4
[00001b10] 2255                      movea.l    (a5),a1
[00001b12] 0c11 002d                 cmpi.b     #$2D,(a1)
[00001b16] 6604                      bne.s      x1af2_1
[00001b18] 7801                      moveq.l    #1,d4
[00001b1a] 5295                      addq.l     #1,(a5)
x1af2_1:
[00001b1c] 4a85                      tst.l      d5
[00001b1e] 6718                      beq.s      x1af2_2
[00001b20] 2255                      movea.l    (a5),a1
[00001b22] 0c11 0030                 cmpi.b     #$30,(a1)
[00001b26] 660a                      bne.s      x1af2_3
[00001b28] 2245                      movea.l    d5,a1
[00001b2a] 12bc 0030                 move.b     #$30,(a1)
[00001b2e] 5295                      addq.l     #1,(a5)
[00001b30] 6006                      bra.s      x1af2_2
x1af2_3:
[00001b32] 2245                      movea.l    d5,a1
[00001b34] 12bc 0020                 move.b     #$20,(a1)
x1af2_2:
[00001b38] 2255                      movea.l    (a5),a1
[00001b3a] 0c11 002a                 cmpi.b     #$2A,(a1)
[00001b3e] 6628                      bne.s      x1af2_4
[00001b40] 5295                      addq.l     #1,(a5)
[00001b42] 2253                      movea.l    (a3),a1
[00001b44] 38a9 0002                 move.w     2(a1),(a4)
[00001b48] 2253                      movea.l    (a3),a1
[00001b4a] 5889                      addq.l     #4,a1
[00001b4c] 2689                      move.l     a1,(a3)
[00001b4e] 4a54                      tst.w      (a4)
[00001b50] 6c0a                      bge.s      x1af2_5
[00001b52] 7801                      moveq.l    #1,d4
[00001b54] 3e14                      move.w     (a4),d7
[00001b56] 48c7                      ext.l      d7
[00001b58] 4487                      neg.l      d7
[00001b5a] 3887                      move.w     d7,(a4)
x1af2_5:
[00001b5c] 4a83                      tst.l      d3
[00001b5e] 6758                      beq.s      x1af2_6
[00001b60] 2243                      movea.l    d3,a1
[00001b62] 7001                      moveq.l    #1,d0
[00001b64] 2280                      move.l     d0,(a1)
[00001b66] 6050                      bra.s      x1af2_6
x1af2_4:
[00001b68] 4a83                      tst.l      d3
[00001b6a] 671e                      beq.s      x1af2_7
[00001b6c] 2255                      movea.l    (a5),a1
[00001b6e] 7e00                      moveq.l    #0,d7
[00001b70] 1e11                      move.b     (a1),d7
[00001b72] 2247                      movea.l    d7,a1
[00001b74] d3fc 0002 08c1            adda.l     #$000254D5,a1
[00001b7a] 0811 0002                 btst       #2,(a1)
[00001b7e] 6704                      beq.s      x1af2_8
[00001b80] 7e01                      moveq.l    #1,d7
[00001b82] 6002                      bra.s      x1af2_9
x1af2_8:
[00001b84] 7e00                      moveq.l    #0,d7
x1af2_9:
[00001b86] 2243                      movea.l    d3,a1
[00001b88] 2287                      move.l     d7,(a1)
x1af2_7:
[00001b8a] 4254                      clr.w      (a4)
x1af2_10:
[00001b8c] 2255                      movea.l    (a5),a1
[00001b8e] 7e00                      moveq.l    #0,d7
[00001b90] 1e11                      move.b     (a1),d7
[00001b92] 2247                      movea.l    d7,a1
[00001b94] d3fc 0002 08c1            adda.l     #$000254D5,a1
[00001b9a] 0811 0002                 btst       #2,(a1)
[00001b9e] 6718                      beq.s      x1af2_6
[00001ba0] 7e0a                      moveq.l    #10,d7
[00001ba2] 3c14                      move.w     (a4),d6
[00001ba4] cec6                      mulu.w     d6,d7
[00001ba6] 2255                      movea.l    (a5),a1
[00001ba8] 7c00                      moveq.l    #0,d6
[00001baa] 1c11                      move.b     (a1),d6
[00001bac] de86                      add.l      d6,d7
[00001bae] 7cd0                      moveq.l    #-48,d6
[00001bb0] dc87                      add.l      d7,d6
[00001bb2] 3886                      move.w     d6,(a4)
[00001bb4] 5295                      addq.l     #1,(a5)
[00001bb6] 60d4                      bra.s      x1af2_10
x1af2_6:
[00001bb8] 2e04                      move.l     d4,d7
[00001bba] 4cdf 3838                 movem.l    (a7)+,d3-d5/a3-a5
[00001bbe] 4e5e                      unlk       a6
[00001bc0] 4e75                      rts

x1bc2:
[00001bc2] 4e56 0000                 link       a6,#0
[00001bc6] 48e7 040c                 movem.l    d5/a4-a5,-(a7)
[00001bca] 2a6e 0008                 movea.l    8(a6),a5
[00001bce] 2a2e 000c                 move.l     12(a6),d5
[00001bd2] 284d                      movea.l    a5,a4
x1bc2_2:
[00001bd4] 4a14                      tst.b      (a4)
[00001bd6] 670a                      beq.s      x1bc2_1
[00001bd8] 4a85                      tst.l      d5
[00001bda] 6706                      beq.s      x1bc2_1
[00001bdc] 528c                      addq.l     #1,a4
[00001bde] 5385                      subq.l     #1,d5
[00001be0] 60f2                      bra.s      x1bc2_2
x1bc2_1:
[00001be2] 2e0c                      move.l     a4,d7
[00001be4] 9e8d                      sub.l      a5,d7
[00001be6] 4cdf 3020                 movem.l    (a7)+,d5/a4-a5
[00001bea] 4e5e                      unlk       a6
[00001bec] 4e75                      rts

__print:
[00001bee] 4e56 fdbc                 link       a6,#-580
[00001bf2] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[00001bf6] 2a6e 0010                 movea.l    16(a6),a5
[00001bfa] 7600                      moveq.l    #0,d3
[00001bfc] 42ae fff0                 clr.l      -16(a6)
__print_89:
[00001c00] 284d                      movea.l    a5,a4
__print_2:
[00001c02] 4a14                      tst.b      (a4)
[00001c04] 670a                      beq.s      __print_1
[00001c06] 0c14 0025                 cmpi.b     #$25,(a4)
[00001c0a] 6704                      beq.s      __print_1
[00001c0c] 528c                      addq.l     #1,a4
[00001c0e] 60f2                      bra.s      __print_2
__print_1:
[00001c10] bbcc                      cmpa.l     a4,a5
[00001c12] 6426                      bcc.s      __print_3
[00001c14] 2eae 000c                 move.l     12(a6),(a7)
[00001c18] 2e0c                      move.l     a4,d7
[00001c1a] 9e8d                      sub.l      a5,d7
[00001c1c] 2f07                      move.l     d7,-(a7)
[00001c1e] 2f0d                      move.l     a5,-(a7)
[00001c20] 226e 0008                 movea.l    8(a6),a1
[00001c24] 4e91                      jsr        (a1)
[00001c26] 508f                      addq.l     #8,a7
[00001c28] 4a87                      tst.l      d7
[00001c2a] 6608                      bne.s      __print_4
[00001c2c] 7001                      moveq.l    #1,d0
[00001c2e] 2d40 fff0                 move.l     d0,-16(a6)
[00001c32] 6006                      bra.s      __print_3
__print_4:
[00001c34] 2e0c                      move.l     a4,d7
[00001c36] 9e8d                      sub.l      a5,d7
[00001c38] d687                      add.l      d7,d3
__print_3:
[00001c3a] 4a1c                      tst.b      (a4)+
[00001c3c] 6614                      bne.s      __print_5
[00001c3e] 4aae fff0                 tst.l      -16(a6)
[00001c42] 6704                      beq.s      __print_6
[00001c44] 7eff                      moveq.l    #-1,d7
[00001c46] 6002                      bra.s      __print_7
__print_6:
[00001c48] 2e03                      move.l     d3,d7
__print_7:
[00001c4a] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00001c4e] 4e5e                      unlk       a6
[00001c50] 4e75                      rts
__print_5:
[00001c52] 42ae ffe0                 clr.l      -32(a6)
[00001c56] 2d6e ffe0 fff8            move.l     -32(a6),-8(a6)
[00001c5c] 2d6e fff8 fffc            move.l     -8(a6),-4(a6)
[00001c62] 7001                      moveq.l    #1,d0
[00001c64] 2d40 ffec                 move.l     d0,-20(a6)
[00001c68] 2d6e ffec fff4            move.l     -20(a6),-12(a6)
[00001c6e] 4244                      clr.w      d4
[00001c70] 47ee fdc6                 lea.l      -570(a6),a3
[00001c74] 426e ffd4                 clr.w      -44(a6)
[00001c78] 42ae ffe4                 clr.l      -28(a6)
__print_9:
[00001c7c] 0c14 002d                 cmpi.b     #$2D,(a4)
[00001c80] 6608                      bne.s      __print_8
[00001c82] 42ae ffec                 clr.l      -20(a6)
[00001c86] 528c                      addq.l     #1,a4
[00001c88] 60f2                      bra.s      __print_9
__print_8:
[00001c8a] 0c14 002b                 cmpi.b     #$2B,(a4)
[00001c8e] 660a                      bne.s      __print_10
[00001c90] 7001                      moveq.l    #1,d0
[00001c92] 2d40 ffe0                 move.l     d0,-32(a6)
[00001c96] 528c                      addq.l     #1,a4
[00001c98] 60e2                      bra.s      __print_9
__print_10:
[00001c9a] 0c14 0020                 cmpi.b     #$20,(a4)
[00001c9e] 660a                      bne.s      __print_11
[00001ca0] 7001                      moveq.l    #1,d0
[00001ca2] 2d40 fff8                 move.l     d0,-8(a6)
[00001ca6] 528c                      addq.l     #1,a4
[00001ca8] 60d2                      bra.s      __print_9
__print_11:
[00001caa] 0c14 0023                 cmpi.b     #$23,(a4)
[00001cae] 660a                      bne.s      __print_12
[00001cb0] 7001                      moveq.l    #1,d0
[00001cb2] 2d40 fffc                 move.l     d0,-4(a6)
[00001cb6] 528c                      addq.l     #1,a4
[00001cb8] 60c2                      bra.s      __print_9
__print_12:
[00001cba] 2d4c fdbc                 move.l     a4,-580(a6)
[00001cbe] 4297                      clr.l      (a7)
[00001cc0] 486e fdc5                 pea.l      -571(a6)
[00001cc4] 486e 0014                 pea.l      20(a6)
[00001cc8] 486e ffd0                 pea.l      -48(a6)
[00001ccc] 486e fdbc                 pea.l      -580(a6)
[00001cd0] 4eba fe20                 jsr        $00001AF2(pc)
[00001cd4] 4fef 0010                 lea.l      16(a7),a7
[00001cd8] 4a87                      tst.l      d7
[00001cda] 6704                      beq.s      __print_13
[00001cdc] 42ae ffec                 clr.l      -20(a6)
__print_13:
[00001ce0] 226e fdbc                 movea.l    -580(a6),a1
[00001ce4] 0c11 002e                 cmpi.b     #$2E,(a1)
[00001ce8] 662a                      bne.s      __print_14
[00001cea] 42ae fff4                 clr.l      -12(a6)
[00001cee] 52ae fdbc                 addq.l     #1,-580(a6)
[00001cf2] 486e ffe4                 pea.l      -28(a6)
[00001cf6] 42a7                      clr.l      -(a7)
[00001cf8] 486e 0014                 pea.l      20(a6)
[00001cfc] 486e ffd4                 pea.l      -44(a6)
[00001d00] 486e fdbc                 pea.l      -580(a6)
[00001d04] 4eba fdec                 jsr        $00001AF2(pc)
[00001d08] 4fef 0014                 lea.l      20(a7),a7
[00001d0c] 4a87                      tst.l      d7
[00001d0e] 6704                      beq.s      __print_14
[00001d10] 426e ffd4                 clr.w      -44(a6)
__print_14:
[00001d14] 286e fdbc                 movea.l    -580(a6),a4
[00001d18] 0c14 006c                 cmpi.b     #$6C,(a4)
[00001d1c] 6706                      beq.s      __print_15
[00001d1e] 0c14 004c                 cmpi.b     #$4C,(a4)
[00001d22] 6618                      bne.s      __print_16
__print_15:
[00001d24] 7001                      moveq.l    #1,d0
[00001d26] 2d40 ffc6                 move.l     d0,-58(a6)
[00001d2a] 528c                      addq.l     #1,a4
__print_18:
[00001d2c] 7e00                      moveq.l    #0,d7
[00001d2e] 1e14                      move.b     (a4),d7
[00001d30] 41f9 0002 069e            lea.l      $000252B2,a0
[00001d36] 4ef9 0000 4a06            jmp        a~jtab
__print_16:
[00001d3c] 0c14 0068                 cmpi.b     #$68,(a4)
[00001d40] 660a                      bne.s      __print_17
[00001d42] 7002                      moveq.l    #2,d0
[00001d44] 2d40 ffc6                 move.l     d0,-58(a6)
[00001d48] 528c                      addq.l     #1,a4
[00001d4a] 60e0                      bra.s      __print_18
__print_17:
[00001d4c] 42ae ffc6                 clr.l      -58(a6)
[00001d50] 60da                      bra.s      __print_18
[00001d52] 226e 0014                 movea.l    20(a6),a1
[00001d56] 16a9 0003                 move.b     3(a1),(a3)
[00001d5a] 7a01                      moveq.l    #1,d5
[00001d5c] 6000 0322                 bra        __print_19
[00001d60] 7e00                      moveq.l    #0,d7
[00001d62] 1e14                      move.b     (a4),d7
[00001d64] 2e87                      move.l     d7,(a7)
[00001d66] 2f3c 0002 0696            move.l     #$000252AA,-(a7)
[00001d6c] 4eb9 0000 24f4            jsr        _strchr
[00001d72] 588f                      addq.l     #4,a7
[00001d74] 2d47 fdbc                 move.l     d7,-580(a6)
[00001d78] 2e2e fdbc                 move.l     -580(a6),d7
[00001d7c] 0487 0002 0696            subi.l     #$000252AA,d7
[00001d82] de87                      add.l      d7,d7
[00001d84] 2247                      movea.l    d7,a1
[00001d86] d3fc 0002 068a            adda.l     #$0002529E,a1
[00001d8c] 3d51 ffda                 move.w     (a1),-38(a6)
[00001d90] 0cae 0000 0001 ffc6       cmpi.l     #$00000001,-58(a6)
[00001d98] 661e                      bne.s      __print_20
[00001d9a] 3e2e ffda                 move.w     -38(a6),d7
[00001d9e] 48c7                      ext.l      d7
[00001da0] 2e87                      move.l     d7,(a7)
[00001da2] 226e 0014                 movea.l    20(a6),a1
[00001da6] 2f11                      move.l     (a1),-(a7)
[00001da8] 2f0b                      move.l     a3,-(a7)
[00001daa] 4eb9 0000 31dc            jsr        __ltob
[00001db0] 508f                      addq.l     #8,a7
[00001db2] 3a07                      move.w     d7,d5
[00001db4] 7801                      moveq.l    #1,d4
[00001db6] 6054                      bra.s      __print_21
__print_20:
[00001db8] 0cae 0000 0002 ffc6       cmpi.l     #$00000002,-58(a6)
[00001dc0] 6630                      bne.s      __print_22
[00001dc2] 226e 0014                 movea.l    20(a6),a1
[00001dc6] 3d69 0002 ffce            move.w     2(a1),-50(a6)
[00001dcc] 226e 0014                 movea.l    20(a6),a1
[00001dd0] 3e2e ffce                 move.w     -50(a6),d7
[00001dd4] 48c7                      ext.l      d7
[00001dd6] 2287                      move.l     d7,(a1)
[00001dd8] 4a6e ffda                 tst.w      -38(a6)
[00001ddc] 6f04                      ble.s      __print_23
[00001dde] 7e01                      moveq.l    #1,d7
[00001de0] 6002                      bra.s      __print_24
__print_23:
[00001de2] 7e00                      moveq.l    #0,d7
__print_24:
[00001de4] 4a87                      tst.l      d7
[00001de6] 670a                      beq.s      __print_22
[00001de8] 226e 0014                 movea.l    20(a6),a1
[00001dec] 0291 0000 ffff            andi.l     #$0000FFFF,(a1)
__print_22:
[00001df2] 3e2e ffda                 move.w     -38(a6),d7
[00001df6] 48c7                      ext.l      d7
[00001df8] 2e87                      move.l     d7,(a7)
[00001dfa] 226e 0014                 movea.l    20(a6),a1
[00001dfe] 2f11                      move.l     (a1),-(a7)
[00001e00] 2f0b                      move.l     a3,-(a7)
[00001e02] 4eb9 0000 30e4            jsr        __itob
[00001e08] 508f                      addq.l     #8,a7
[00001e0a] 3a07                      move.w     d7,d5
__print_21:
[00001e0c] 0c14 0058                 cmpi.b     #$58,(a4)
[00001e10] 6600 026e                 bne        __print_19
[00001e14] 3e05                      move.w     d5,d7
[00001e16] 48c7                      ext.l      d7
[00001e18] 2e87                      move.l     d7,(a7)
[00001e1a] 2f0b                      move.l     a3,-(a7)
[00001e1c] 4eba fca0                 jsr        $00001ABE(pc)
[00001e20] 588f                      addq.l     #4,a7
[00001e22] 6000 025c                 bra        __print_19
[00001e26] 2e2e 0014                 move.l     20(a6),d7
[00001e2a] 7c01                      moveq.l    #1,d6
[00001e2c] cc87                      and.l      d7,d6
[00001e2e] 7e02                      moveq.l    #2,d7
[00001e30] 9e86                      sub.l      d6,d7
[00001e32] 7c01                      moveq.l    #1,d6
[00001e34] cc87                      and.l      d7,d6
[00001e36] dcae 0014                 add.l      20(a6),d6
[00001e3a] 2d46 0014                 move.l     d6,20(a6)
[00001e3e] 4aae fff4                 tst.l      -12(a6)
[00001e42] 6704                      beq.s      __print_25
[00001e44] 7e06                      moveq.l    #6,d7
[00001e46] 6016                      bra.s      __print_26
__print_25:
[00001e48] 0c6e 01f9 ffd4            cmpi.w     #$01F9,-44(a6)
[00001e4e] 6f08                      ble.s      __print_27
[00001e50] 2e3c 0000 01f9            move.l     #$000001F9,d7
[00001e56] 6006                      bra.s      __print_26
__print_27:
[00001e58] 3e2e ffd4                 move.w     -44(a6),d7
[00001e5c] 48c7                      ext.l      d7
__print_26:
[00001e5e] 3d47 ffd8                 move.w     d7,-40(a6)
[00001e62] 3e2e ffd8                 move.w     -40(a6),d7
[00001e66] 48c7                      ext.l      d7
[00001e68] 2e87                      move.l     d7,(a7)
[00001e6a] 4878 0001                 pea.l      ($00000001).w
[00001e6e] 226e 0014                 movea.l    20(a6),a1
[00001e72] 2f29 0004                 move.l     4(a1),-(a7)
[00001e76] 2f11                      move.l     (a1),-(a7)
[00001e78] 2f0b                      move.l     a3,-(a7)
[00001e7a] 4eb9 0000 2d5e            jsr        __dtoe
[00001e80] 4fef 0010                 lea.l      16(a7),a7
[00001e84] 3a07                      move.w     d7,d5
[00001e86] 0c14 0045                 cmpi.b     #$45,(a4)
[00001e8a] 660e                      bne.s      __print_28
[00001e8c] 3e05                      move.w     d5,d7
[00001e8e] 48c7                      ext.l      d7
[00001e90] 2e87                      move.l     d7,(a7)
[00001e92] 2f0b                      move.l     a3,-(a7)
[00001e94] 4eba fc28                 jsr        $00001ABE(pc)
[00001e98] 588f                      addq.l     #4,a7
__print_28:
[00001e9a] 7802                      moveq.l    #2,d4
[00001e9c] 6000 01e2                 bra        __print_19
[00001ea0] 2e2e 0014                 move.l     20(a6),d7
[00001ea4] 7c01                      moveq.l    #1,d6
[00001ea6] cc87                      and.l      d7,d6
[00001ea8] 7e02                      moveq.l    #2,d7
[00001eaa] 9e86                      sub.l      d6,d7
[00001eac] 7c01                      moveq.l    #1,d6
[00001eae] cc87                      and.l      d7,d6
[00001eb0] dcae 0014                 add.l      20(a6),d6
[00001eb4] 2d46 0014                 move.l     d6,20(a6)
[00001eb8] 4aae fff4                 tst.l      -12(a6)
[00001ebc] 6704                      beq.s      __print_29
[00001ebe] 7e06                      moveq.l    #6,d7
[00001ec0] 6016                      bra.s      __print_30
__print_29:
[00001ec2] 0c6e 01fe ffd4            cmpi.w     #$01FE,-44(a6)
[00001ec8] 6f08                      ble.s      __print_31
[00001eca] 2e3c 0000 01fe            move.l     #$000001FE,d7
[00001ed0] 6006                      bra.s      __print_30
__print_31:
[00001ed2] 3e2e ffd4                 move.w     -44(a6),d7
[00001ed6] 48c7                      ext.l      d7
__print_30:
[00001ed8] 3d47 ffd8                 move.w     d7,-40(a6)
[00001edc] 3e2e ffd8                 move.w     -40(a6),d7
[00001ee0] 48c7                      ext.l      d7
[00001ee2] 2e87                      move.l     d7,(a7)
[00001ee4] 2e3c 0000 01fe            move.l     #$000001FE,d7
[00001eea] 3c2e ffd8                 move.w     -40(a6),d6
[00001eee] 48c6                      ext.l      d6
[00001ef0] 9e86                      sub.l      d6,d7
[00001ef2] 2f07                      move.l     d7,-(a7)
[00001ef4] 226e 0014                 movea.l    20(a6),a1
[00001ef8] 2f29 0004                 move.l     4(a1),-(a7)
[00001efc] 2f11                      move.l     (a1),-(a7)
[00001efe] 2f0b                      move.l     a3,-(a7)
[00001f00] 4eb9 0000 2ed4            jsr        __dtof
[00001f06] 4fef 0010                 lea.l      16(a7),a7
[00001f0a] 3a07                      move.w     d7,d5
[00001f0c] 7802                      moveq.l    #2,d4
[00001f0e] 6000 0170                 bra        __print_19
[00001f12] 2e2e 0014                 move.l     20(a6),d7
[00001f16] 7c01                      moveq.l    #1,d6
[00001f18] cc87                      and.l      d7,d6
[00001f1a] 7e02                      moveq.l    #2,d7
[00001f1c] 9e86                      sub.l      d6,d7
[00001f1e] 7c01                      moveq.l    #1,d6
[00001f20] cc87                      and.l      d7,d6
[00001f22] dcae 0014                 add.l      20(a6),d6
[00001f26] 2d46 0014                 move.l     d6,20(a6)
[00001f2a] 4aae fff4                 tst.l      -12(a6)
[00001f2e] 6704                      beq.s      __print_32
[00001f30] 7e06                      moveq.l    #6,d7
[00001f32] 6016                      bra.s      __print_33
__print_32:
[00001f34] 0c6e 01f9 ffd4            cmpi.w     #$01F9,-44(a6)
[00001f3a] 6f08                      ble.s      __print_34
[00001f3c] 2e3c 0000 01f9            move.l     #$000001F9,d7
[00001f42] 6006                      bra.s      __print_33
__print_34:
[00001f44] 3e2e ffd4                 move.w     -44(a6),d7
[00001f48] 48c7                      ext.l      d7
__print_33:
[00001f4a] 3d47 ffd8                 move.w     d7,-40(a6)
[00001f4e] 4aae fffc                 tst.l      -4(a6)
[00001f52] 6704                      beq.s      __print_35
[00001f54] 7e00                      moveq.l    #0,d7
[00001f56] 6002                      bra.s      __print_36
__print_35:
[00001f58] 7e01                      moveq.l    #1,d7
__print_36:
[00001f5a] 2e87                      move.l     d7,(a7)
[00001f5c] 3e2e ffd8                 move.w     -40(a6),d7
[00001f60] 48c7                      ext.l      d7
[00001f62] 2f07                      move.l     d7,-(a7)
[00001f64] 2e3c 0000 01fe            move.l     #$000001FE,d7
[00001f6a] 3c2e ffd8                 move.w     -40(a6),d6
[00001f6e] 48c6                      ext.l      d6
[00001f70] 9e86                      sub.l      d6,d7
[00001f72] 2f07                      move.l     d7,-(a7)
[00001f74] 226e 0014                 movea.l    20(a6),a1
[00001f78] 2f29 0004                 move.l     4(a1),-(a7)
[00001f7c] 2f11                      move.l     (a1),-(a7)
[00001f7e] 2f0b                      move.l     a3,-(a7)
[00001f80] 4eb9 0000 23d2            jsr        __dtog
[00001f86] 4fef 0014                 lea.l      20(a7),a7
[00001f8a] 3a07                      move.w     d7,d5
[00001f8c] ba6e ffd4                 cmp.w      -44(a6),d5
[00001f90] 6c04                      bge.s      __print_37
[00001f92] 3d45 ffd4                 move.w     d5,-44(a6)
__print_37:
[00001f96] 0c14 0047                 cmpi.b     #$47,(a4)
[00001f9a] 660e                      bne.s      __print_38
[00001f9c] 3e05                      move.w     d5,d7
[00001f9e] 48c7                      ext.l      d7
[00001fa0] 2e87                      move.l     d7,(a7)
[00001fa2] 2f0b                      move.l     a3,-(a7)
[00001fa4] 4eba fb18                 jsr        $00001ABE(pc)
[00001fa8] 588f                      addq.l     #4,a7
__print_38:
[00001faa] 7802                      moveq.l    #2,d4
[00001fac] 6000 00d2                 bra        __print_19
[00001fb0] 226e 0014                 movea.l    20(a6),a1
[00001fb4] 2251                      movea.l    (a1),a1
[00001fb6] 2283                      move.l     d3,(a1)
[00001fb8] 426e ffd4                 clr.w      -44(a6)
[00001fbc] 3d6e ffd4 ffd0            move.w     -44(a6),-48(a6)
[00001fc2] 3a2e ffd0                 move.w     -48(a6),d5
[00001fc6] 7804                      moveq.l    #4,d4
[00001fc8] 6000 00b6                 bra        __print_19
[00001fcc] 3d7c 0010 ffda            move.w     #$0010,-38(a6)
[00001fd2] 4aae fffc                 tst.l      -4(a6)
[00001fd6] 6708                      beq.s      __print_39
[00001fd8] 16fc 0030                 move.b     #$30,(a3)+
[00001fdc] 16fc 0058                 move.b     #$58,(a3)+
__print_39:
[00001fe0] 7001                      moveq.l    #1,d0
[00001fe2] 2d40 ffec                 move.l     d0,-20(a6)
[00001fe6] 0cae 0000 0001 ffc6       cmpi.l     #$00000001,-58(a6)
[00001fee] 6604                      bne.s      __print_40
[00001ff0] 7e01                      moveq.l    #1,d7
[00001ff2] 6002                      bra.s      __print_41
__print_40:
[00001ff4] 7e00                      moveq.l    #0,d7
__print_41:
[00001ff6] 4a87                      tst.l      d7
[00001ff8] 671e                      beq.s      __print_42
[00001ffa] 7801                      moveq.l    #1,d4
[00001ffc] 3e2e ffda                 move.w     -38(a6),d7
[00002000] 48c7                      ext.l      d7
[00002002] 2e87                      move.l     d7,(a7)
[00002004] 226e 0014                 movea.l    20(a6),a1
[00002008] 2f11                      move.l     (a1),-(a7)
[0000200a] 2f0b                      move.l     a3,-(a7)
[0000200c] 4eb9 0000 31dc            jsr        __ltob
[00002012] 508f                      addq.l     #8,a7
[00002014] 3a07                      move.w     d7,d5
[00002016] 6068                      bra.s      __print_19
__print_42:
[00002018] 3e2e ffda                 move.w     -38(a6),d7
[0000201c] 48c7                      ext.l      d7
[0000201e] 2e87                      move.l     d7,(a7)
[00002020] 226e 0014                 movea.l    20(a6),a1
[00002024] 2f11                      move.l     (a1),-(a7)
[00002026] 2f0b                      move.l     a3,-(a7)
[00002028] 4eb9 0000 30e4            jsr        __itob
[0000202e] 508f                      addq.l     #8,a7
[00002030] 3a07                      move.w     d7,d5
[00002032] 604c                      bra.s      __print_19
[00002034] 226e 0014                 movea.l    20(a6),a1
[00002038] 2651                      movea.l    (a1),a3
[0000203a] 4aae ffe4                 tst.l      -28(a6)
[0000203e] 672c                      beq.s      __print_43
[00002040] 3e2e ffd4                 move.w     -44(a6),d7
[00002044] 48c7                      ext.l      d7
[00002046] 2e87                      move.l     d7,(a7)
[00002048] 2f0b                      move.l     a3,-(a7)
[0000204a] 4eba fb76                 jsr        $00001BC2(pc)
[0000204e] 588f                      addq.l     #4,a7
[00002050] 3a07                      move.w     d7,d5
[00002052] ba6e ffd4                 cmp.w      -44(a6),d5
[00002056] 6c06                      bge.s      __print_44
[00002058] 3e05                      move.w     d5,d7
[0000205a] 48c7                      ext.l      d7
[0000205c] 6006                      bra.s      __print_45
__print_44:
[0000205e] 3e2e ffd4                 move.w     -44(a6),d7
[00002062] 48c7                      ext.l      d7
__print_45:
[00002064] 3a07                      move.w     d7,d5
[00002066] 3d45 ffd4                 move.w     d5,-44(a6)
[0000206a] 600a                      bra.s      __print_46
__print_43:
[0000206c] 2e8b                      move.l     a3,(a7)
[0000206e] 4eb9 0000 252a            jsr        _strlen
[00002074] 3a07                      move.w     d7,d5
__print_46:
[00002076] 7804                      moveq.l    #4,d4
[00002078] 6006                      bra.s      __print_19
[0000207a] 264c                      movea.l    a4,a3
[0000207c] 7a01                      moveq.l    #1,d5
[0000207e] 7805                      moveq.l    #5,d4
__print_19:
[00002080] 4a45                      tst.w      d5
[00002082] 6d00 02be                 blt        __print_47
[00002086] 42ae ffe8                 clr.l      -24(a6)
[0000208a] 4aae ffe0                 tst.l      -32(a6)
[0000208e] 6608                      bne.s      __print_48
[00002090] 4aae fff8                 tst.l      -8(a6)
[00002094] 6700 009e                 beq        __print_49
__print_48:
[00002098] 0c14 0064                 cmpi.b     #$64,(a4)
[0000209c] 670e                      beq.s      __print_50
[0000209e] 0c14 0069                 cmpi.b     #$69,(a4)
[000020a2] 6708                      beq.s      __print_50
[000020a4] 0c44 0002                 cmpi.w     #$0002,d4
[000020a8] 6600 008a                 bne        __print_49
__print_50:
[000020ac] 0c13 002b                 cmpi.b     #$2B,(a3)
[000020b0] 6700 0082                 beq        __print_49
[000020b4] 0c13 002d                 cmpi.b     #$2D,(a3)
[000020b8] 677a                      beq.s      __print_49
[000020ba] 7001                      moveq.l    #1,d0
[000020bc] 2d40 ffe8                 move.l     d0,-24(a6)
[000020c0] 536e ffd0                 subq.w     #1,-48(a6)
[000020c4] 4aae ffec                 tst.l      -20(a6)
[000020c8] 6738                      beq.s      __print_51
__print_53:
[000020ca] ba6e ffd0                 cmp.w      -48(a6),d5
[000020ce] 6c32                      bge.s      __print_51
[000020d0] 3e2e ffd4                 move.w     -44(a6),d7
[000020d4] be6e ffd0                 cmp.w      -48(a6),d7
[000020d8] 6c28                      bge.s      __print_51
[000020da] 2eae 000c                 move.l     12(a6),(a7)
[000020de] 4878 0001                 pea.l      ($00000001).w
[000020e2] 486e fdc5                 pea.l      -571(a6)
[000020e6] 226e 0008                 movea.l    8(a6),a1
[000020ea] 4e91                      jsr        (a1)
[000020ec] 508f                      addq.l     #8,a7
[000020ee] 4a87                      tst.l      d7
[000020f0] 6608                      bne.s      __print_52
[000020f2] 7001                      moveq.l    #1,d0
[000020f4] 2d40 fff0                 move.l     d0,-16(a6)
[000020f8] 6008                      bra.s      __print_51
__print_52:
[000020fa] 536e ffd0                 subq.w     #1,-48(a6)
[000020fe] 5283                      addq.l     #1,d3
[00002100] 60c8                      bra.s      __print_53
__print_51:
[00002102] 4aae ffe0                 tst.l      -32(a6)
[00002106] 6704                      beq.s      __print_54
[00002108] 7e2b                      moveq.l    #43,d7
[0000210a] 6002                      bra.s      __print_55
__print_54:
[0000210c] 7e20                      moveq.l    #32,d7
__print_55:
[0000210e] 1d47 fdc5                 move.b     d7,-571(a6)
[00002112] 2eae 000c                 move.l     12(a6),(a7)
[00002116] 4878 0001                 pea.l      ($00000001).w
[0000211a] 486e fdc5                 pea.l      -571(a6)
[0000211e] 226e 0008                 movea.l    8(a6),a1
[00002122] 4e91                      jsr        (a1)
[00002124] 508f                      addq.l     #8,a7
[00002126] 4a87                      tst.l      d7
[00002128] 6608                      bne.s      __print_56
[0000212a] 7001                      moveq.l    #1,d0
[0000212c] 2d40 fff0                 move.l     d0,-16(a6)
[00002130] 6002                      bra.s      __print_49
__print_56:
[00002132] 5283                      addq.l     #1,d3
__print_49:
[00002134] 4aae fffc                 tst.l      -4(a6)
[00002138] 6700 0140                 beq        __print_57
[0000213c] 0c14 006f                 cmpi.b     #$6F,(a4)
[00002140] 6714                      beq.s      __print_58
[00002142] 0c14 0078                 cmpi.b     #$78,(a4)
[00002146] 670e                      beq.s      __print_58
[00002148] 0c14 0058                 cmpi.b     #$58,(a4)
[0000214c] 6708                      beq.s      __print_58
[0000214e] 0c14 0070                 cmpi.b     #$70,(a4)
[00002152] 6600 0126                 bne        __print_57
__print_58:
[00002156] 0c14 006f                 cmpi.b     #$6F,(a4)
[0000215a] 6678                      bne.s      __print_59
[0000215c] 0c13 0030                 cmpi.b     #$30,(a3)
[00002160] 6772                      beq.s      __print_59
[00002162] 7001                      moveq.l    #1,d0
[00002164] 2d40 ffe8                 move.l     d0,-24(a6)
[00002168] 536e ffd0                 subq.w     #1,-48(a6)
[0000216c] 4aae ffec                 tst.l      -20(a6)
[00002170] 6738                      beq.s      __print_60
__print_62:
[00002172] ba6e ffd0                 cmp.w      -48(a6),d5
[00002176] 6c32                      bge.s      __print_60
[00002178] 3e2e ffd4                 move.w     -44(a6),d7
[0000217c] be6e ffd0                 cmp.w      -48(a6),d7
[00002180] 6c28                      bge.s      __print_60
[00002182] 2eae 000c                 move.l     12(a6),(a7)
[00002186] 4878 0001                 pea.l      ($00000001).w
[0000218a] 486e fdc5                 pea.l      -571(a6)
[0000218e] 226e 0008                 movea.l    8(a6),a1
[00002192] 4e91                      jsr        (a1)
[00002194] 508f                      addq.l     #8,a7
[00002196] 4a87                      tst.l      d7
[00002198] 6608                      bne.s      __print_61
[0000219a] 7001                      moveq.l    #1,d0
[0000219c] 2d40 fff0                 move.l     d0,-16(a6)
[000021a0] 6008                      bra.s      __print_60
__print_61:
[000021a2] 536e ffd0                 subq.w     #1,-48(a6)
[000021a6] 5283                      addq.l     #1,d3
[000021a8] 60c8                      bra.s      __print_62
__print_60:
[000021aa] 2eae 000c                 move.l     12(a6),(a7)
[000021ae] 4878 0001                 pea.l      ($00000001).w
[000021b2] 2f3c 0002 0722            move.l     #$00025336,-(a7)
[000021b8] 226e 0008                 movea.l    8(a6),a1
[000021bc] 4e91                      jsr        (a1)
[000021be] 508f                      addq.l     #8,a7
[000021c0] 4a87                      tst.l      d7
[000021c2] 660a                      bne.s      __print_63
[000021c4] 7001                      moveq.l    #1,d0
[000021c6] 2d40 fff0                 move.l     d0,-16(a6)
[000021ca] 6000 00ae                 bra        __print_57
__print_63:
[000021ce] 5283                      addq.l     #1,d3
[000021d0] 6000 00a8                 bra        __print_57
__print_59:
[000021d4] 0c14 0078                 cmpi.b     #$78,(a4)
[000021d8] 670e                      beq.s      __print_64
[000021da] 0c14 0058                 cmpi.b     #$58,(a4)
[000021de] 6708                      beq.s      __print_64
[000021e0] 0c14 0070                 cmpi.b     #$70,(a4)
[000021e4] 6600 0094                 bne        __print_57
__print_64:
[000021e8] 7001                      moveq.l    #1,d0
[000021ea] 2d40 ffe8                 move.l     d0,-24(a6)
[000021ee] 556e ffd0                 subq.w     #2,-48(a6)
[000021f2] 4aae ffec                 tst.l      -20(a6)
[000021f6] 6738                      beq.s      __print_65
__print_67:
[000021f8] ba6e ffd0                 cmp.w      -48(a6),d5
[000021fc] 6c32                      bge.s      __print_65
[000021fe] 3e2e ffd4                 move.w     -44(a6),d7
[00002202] be6e ffd0                 cmp.w      -48(a6),d7
[00002206] 6c28                      bge.s      __print_65
[00002208] 2eae 000c                 move.l     12(a6),(a7)
[0000220c] 4878 0001                 pea.l      ($00000001).w
[00002210] 486e fdc5                 pea.l      -571(a6)
[00002214] 226e 0008                 movea.l    8(a6),a1
[00002218] 4e91                      jsr        (a1)
[0000221a] 508f                      addq.l     #8,a7
[0000221c] 4a87                      tst.l      d7
[0000221e] 6608                      bne.s      __print_66
[00002220] 7001                      moveq.l    #1,d0
[00002222] 2d40 fff0                 move.l     d0,-16(a6)
[00002226] 6008                      bra.s      __print_65
__print_66:
[00002228] 536e ffd0                 subq.w     #1,-48(a6)
[0000222c] 5283                      addq.l     #1,d3
[0000222e] 60c8                      bra.s      __print_67
__print_65:
[00002230] 2eae 000c                 move.l     12(a6),(a7)
[00002234] 4878 0001                 pea.l      ($00000001).w
[00002238] 2f3c 0002 0726            move.l     #$0002533A,-(a7)
[0000223e] 226e 0008                 movea.l    8(a6),a1
[00002242] 4e91                      jsr        (a1)
[00002244] 508f                      addq.l     #8,a7
[00002246] 4a87                      tst.l      d7
[00002248] 6726                      beq.s      __print_68
[0000224a] 2eae 000c                 move.l     12(a6),(a7)
[0000224e] 4878 0001                 pea.l      ($00000001).w
[00002252] 0c14 0070                 cmpi.b     #$70,(a4)
[00002256] 6608                      bne.s      __print_69
[00002258] 2e3c 0002 0724            move.l     #$00025338,d7
[0000225e] 6002                      bra.s      __print_70
__print_69:
[00002260] 2e0c                      move.l     a4,d7
__print_70:
[00002262] 2f07                      move.l     d7,-(a7)
[00002264] 226e 0008                 movea.l    8(a6),a1
[00002268] 4e91                      jsr        (a1)
[0000226a] 508f                      addq.l     #8,a7
[0000226c] 4a87                      tst.l      d7
[0000226e] 6608                      bne.s      __print_71
__print_68:
[00002270] 7001                      moveq.l    #1,d0
[00002272] 2d40 fff0                 move.l     d0,-16(a6)
[00002276] 6002                      bra.s      __print_57
__print_71:
[00002278] 5483                      addq.l     #2,d3
__print_57:
[0000227a] 4aae ffec                 tst.l      -20(a6)
[0000227e] 673e                      beq.s      __print_72
[00002280] 4aae ffe8                 tst.l      -24(a6)
[00002284] 6638                      bne.s      __print_72
__print_74:
[00002286] ba6e ffd0                 cmp.w      -48(a6),d5
[0000228a] 6c32                      bge.s      __print_72
[0000228c] 3e2e ffd4                 move.w     -44(a6),d7
[00002290] be6e ffd0                 cmp.w      -48(a6),d7
[00002294] 6c28                      bge.s      __print_72
[00002296] 2eae 000c                 move.l     12(a6),(a7)
[0000229a] 4878 0001                 pea.l      ($00000001).w
[0000229e] 486e fdc5                 pea.l      -571(a6)
[000022a2] 226e 0008                 movea.l    8(a6),a1
[000022a6] 4e91                      jsr        (a1)
[000022a8] 508f                      addq.l     #8,a7
[000022aa] 4a87                      tst.l      d7
[000022ac] 6608                      bne.s      __print_73
[000022ae] 7001                      moveq.l    #1,d0
[000022b0] 2d40 fff0                 move.l     d0,-16(a6)
[000022b4] 6008                      bra.s      __print_72
__print_73:
[000022b6] 536e ffd0                 subq.w     #1,-48(a6)
[000022ba] 5283                      addq.l     #1,d3
[000022bc] 60c8                      bra.s      __print_74
__print_72:
[000022be] 1d6e fdc5 fdc4            move.b     -571(a6),-572(a6)
[000022c4] 0c44 0004                 cmpi.w     #$0004,d4
[000022c8] 6606                      bne.s      __print_75
[000022ca] 0c14 0070                 cmpi.b     #$70,(a4)
[000022ce] 6706                      beq.s      __print_76
__print_75:
[000022d0] 1d7c 0030 fdc5            move.b     #$30,-571(a6)
__print_76:
[000022d6] 0c14 0067                 cmpi.b     #$67,(a4)
[000022da] 673c                      beq.s      __print_77
[000022dc] 0c14 0047                 cmpi.b     #$47,(a4)
[000022e0] 6736                      beq.s      __print_77
[000022e2] 3d45 ffd8                 move.w     d5,-40(a6)
__print_79:
[000022e6] 3e2e ffd8                 move.w     -40(a6),d7
[000022ea] be6e ffd4                 cmp.w      -44(a6),d7
[000022ee] 6c28                      bge.s      __print_77
[000022f0] 2eae 000c                 move.l     12(a6),(a7)
[000022f4] 4878 0001                 pea.l      ($00000001).w
[000022f8] 486e fdc5                 pea.l      -571(a6)
[000022fc] 226e 0008                 movea.l    8(a6),a1
[00002300] 4e91                      jsr        (a1)
[00002302] 508f                      addq.l     #8,a7
[00002304] 4a87                      tst.l      d7
[00002306] 6608                      bne.s      __print_78
[00002308] 7001                      moveq.l    #1,d0
[0000230a] 2d40 fff0                 move.l     d0,-16(a6)
[0000230e] 6008                      bra.s      __print_77
__print_78:
[00002310] 526e ffd8                 addq.w     #1,-40(a6)
[00002314] 5283                      addq.l     #1,d3
[00002316] 60ce                      bra.s      __print_79
__print_77:
[00002318] 4a45                      tst.w      d5
[0000231a] 6f26                      ble.s      __print_47
[0000231c] 2eae 000c                 move.l     12(a6),(a7)
[00002320] 3e05                      move.w     d5,d7
[00002322] 48c7                      ext.l      d7
[00002324] 2f07                      move.l     d7,-(a7)
[00002326] 2f0b                      move.l     a3,-(a7)
[00002328] 226e 0008                 movea.l    8(a6),a1
[0000232c] 4e91                      jsr        (a1)
[0000232e] 508f                      addq.l     #8,a7
[00002330] 4a87                      tst.l      d7
[00002332] 6608                      bne.s      __print_80
[00002334] 7001                      moveq.l    #1,d0
[00002336] 2d40 fff0                 move.l     d0,-16(a6)
[0000233a] 6006                      bra.s      __print_47
__print_80:
[0000233c] 3e05                      move.w     d5,d7
[0000233e] 48c7                      ext.l      d7
[00002340] d687                      add.l      d7,d3
__print_47:
[00002342] 4aae ffec                 tst.l      -20(a6)
[00002346] 663e                      bne.s      __print_81
[00002348] 1d6e fdc4 fdc5            move.b     -572(a6),-571(a6)
__print_83:
[0000234e] ba6e ffd0                 cmp.w      -48(a6),d5
[00002352] 6c32                      bge.s      __print_81
[00002354] 3e2e ffd4                 move.w     -44(a6),d7
[00002358] be6e ffd0                 cmp.w      -48(a6),d7
[0000235c] 6c28                      bge.s      __print_81
[0000235e] 2eae 000c                 move.l     12(a6),(a7)
[00002362] 4878 0001                 pea.l      ($00000001).w
[00002366] 486e fdc5                 pea.l      -571(a6)
[0000236a] 226e 0008                 movea.l    8(a6),a1
[0000236e] 4e91                      jsr        (a1)
[00002370] 508f                      addq.l     #8,a7
[00002372] 4a87                      tst.l      d7
[00002374] 6608                      bne.s      __print_82
[00002376] 7001                      moveq.l    #1,d0
[00002378] 2d40 fff0                 move.l     d0,-16(a6)
[0000237c] 6008                      bra.s      __print_81
__print_82:
[0000237e] 536e ffd0                 subq.w     #1,-48(a6)
[00002382] 5283                      addq.l     #1,d3
[00002384] 60c8                      bra.s      __print_83
__print_81:
[00002386] 4a44                      tst.w      d4
[00002388] 660c                      bne.s      __print_84
[0000238a] 226e 0014                 movea.l    20(a6),a1
[0000238e] 5889                      addq.l     #4,a1
[00002390] 2d49 0014                 move.l     a1,20(a6)
[00002394] 6034                      bra.s      __print_85
__print_84:
[00002396] 0c44 0004                 cmpi.w     #$0004,d4
[0000239a] 6606                      bne.s      __print_86
[0000239c] 58ae 0014                 addq.l     #4,20(a6)
[000023a0] 6028                      bra.s      __print_85
__print_86:
[000023a2] 0c44 0001                 cmpi.w     #$0001,d4
[000023a6] 660c                      bne.s      __print_87
[000023a8] 226e 0014                 movea.l    20(a6),a1
[000023ac] 5889                      addq.l     #4,a1
[000023ae] 2d49 0014                 move.l     a1,20(a6)
[000023b2] 6016                      bra.s      __print_85
__print_87:
[000023b4] 0c44 0002                 cmpi.w     #$0002,d4
[000023b8] 6706                      beq.s      __print_88
[000023ba] 0c44 0006                 cmpi.w     #$0006,d4
[000023be] 660a                      bne.s      __print_85
__print_88:
[000023c0] 226e 0014                 movea.l    20(a6),a1
[000023c4] 5089                      addq.l     #8,a1
[000023c6] 2d49 0014                 move.l     a1,20(a6)
__print_85:
[000023ca] 4bec 0001                 lea.l      1(a4),a5
[000023ce] 6000 f830                 bra        __print_89

__dtog:
[000023d2] 4e56 ffe6                 link       a6,#-26
[000023d6] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[000023da] 282e 0008                 move.l     8(a6),d4
[000023de] 4878 0012                 pea.l      ($00000012).w
[000023e2] 2f2e 0010                 move.l     16(a6),-(a7)
[000023e6] 2f2e 000c                 move.l     12(a6),-(a7)
[000023ea] 486e ffea                 pea.l      -22(a6)
[000023ee] 4eb9 0000 3b46            jsr        __norm
[000023f4] 4fef 0010                 lea.l      16(a7),a7
[000023f8] 3607                      move.w     d7,d3
[000023fa] 3e2e 001a                 move.w     26(a6),d7
[000023fe] be43                      cmp.w      d3,d7
[00002400] 6d08                      blt.s      __dtog_1
[00002402] 0c43 fffd                 cmpi.w     #$FFFD,d3
[00002406] 6c00 0088                 bge        __dtog_2
__dtog_1:
[0000240a] 2eae 0018                 move.l     24(a6),(a7)
[0000240e] 4878 0001                 pea.l      ($00000001).w
[00002412] 2f2e 0010                 move.l     16(a6),-(a7)
[00002416] 2f2e 000c                 move.l     12(a6),-(a7)
[0000241a] 2f04                      move.l     d4,-(a7)
[0000241c] 4eb9 0000 2d5e            jsr        __dtoe
[00002422] 4fef 0010                 lea.l      16(a7),a7
[00002426] 2a07                      move.l     d7,d5
[00002428] 4aae 001c                 tst.l      28(a6)
[0000242c] 6604                      bne.s      __dtog_3
[0000242e] 2e05                      move.l     d5,d7
[00002430] 603c                      bra.s      __dtog_4
__dtog_3:
[00002432] 2244                      movea.l    d4,a1
[00002434] 47f1 5800                 lea.l      0(a1,d5.l),a3
[00002438] 4878 0065                 pea.l      ($00000065).w
[0000243c] 2f05                      move.l     d5,-(a7)
[0000243e] 2f04                      move.l     d4,-(a7)
[00002440] 4eb9 0000 34b8            jsr        __scnbuf
[00002446] 4fef 000c                 lea.l      12(a7),a7
[0000244a] 3d47 fffc                 move.w     d7,-4(a6)
[0000244e] 2844                      movea.l    d4,a4
[00002450] 3e2e fffc                 move.w     -4(a6),d7
[00002454] 48c7                      ext.l      d7
[00002456] d9c7                      adda.l     d7,a4
[00002458] 2a4c                      movea.l    a4,a5
[0000245a] 538d                      subq.l     #1,a5
__dtog_6:
[0000245c] 0c15 0030                 cmpi.b     #$30,(a5)
[00002460] 6604                      bne.s      __dtog_5
[00002462] 538d                      subq.l     #1,a5
[00002464] 60f6                      bra.s      __dtog_6
__dtog_5:
[00002466] 528d                      addq.l     #1,a5
[00002468] bbcc                      cmpa.l     a4,a5
[0000246a] 660a                      bne.s      __dtog_7
[0000246c] 2e05                      move.l     d5,d7
__dtog_4:
[0000246e] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00002472] 4e5e                      unlk       a6
[00002474] 4e75                      rts
__dtog_7:
[00002476] 0c2d 002e ffff            cmpi.b     #$2E,-1(a5)
[0000247c] 6602                      bne.s      __dtog_8
[0000247e] 538d                      subq.l     #1,a5
__dtog_8:
[00002480] b9cb                      cmpa.l     a3,a4
[00002482] 6204                      bhi.s      __dtog_9
[00002484] 1adc                      move.b     (a4)+,(a5)+
[00002486] 60f8                      bra.s      __dtog_8
__dtog_9:
[00002488] 538d                      subq.l     #1,a5
[0000248a] 2e0d                      move.l     a5,d7
[0000248c] 9e84                      sub.l      d4,d7
[0000248e] 60de                      bra.s      __dtog_4
__dtog_2:
[00002490] 2eae 0018                 move.l     24(a6),(a7)
[00002494] 2f2e 0014                 move.l     20(a6),-(a7)
[00002498] 2f2e 0010                 move.l     16(a6),-(a7)
[0000249c] 2f2e 000c                 move.l     12(a6),-(a7)
[000024a0] 2f04                      move.l     d4,-(a7)
[000024a2] 4eb9 0000 2ed4            jsr        __dtof
[000024a8] 4fef 0010                 lea.l      16(a7),a7
[000024ac] 2a07                      move.l     d7,d5
[000024ae] 4aae 001c                 tst.l      28(a6)
[000024b2] 6604                      bne.s      __dtog_10
[000024b4] 2e05                      move.l     d5,d7
[000024b6] 60b6                      bra.s      __dtog_4
__dtog_10:
[000024b8] 2244                      movea.l    d4,a1
[000024ba] 47f1 5800                 lea.l      0(a1,d5.l),a3
[000024be] 538b                      subq.l     #1,a3
__dtog_12:
[000024c0] 4a85                      tst.l      d5
[000024c2] 6726                      beq.s      __dtog_11
[000024c4] 4a13                      tst.b      (a3)
[000024c6] 6722                      beq.s      __dtog_11
[000024c8] 7e00                      moveq.l    #0,d7
[000024ca] 1e13                      move.b     (a3),d7
[000024cc] 41f9 0002 0728            lea.l      $0002533C,a0
[000024d2] 4ef9 0000 4a06            jmp        a~jtab
[000024d8] 4213                      clr.b      (a3)
__dtog_14:
[000024da] 538b                      subq.l     #1,a3
[000024dc] 5385                      subq.l     #1,d5
[000024de] 60e0                      bra.s      __dtog_12
[000024e0] 4213                      clr.b      (a3)
[000024e2] 5385                      subq.l     #1,d5
[000024e4] 2e05                      move.l     d5,d7
[000024e6] 6004                      bra.s      __dtog_13
[000024e8] 60f0                      bra.s      __dtog_14
__dtog_11:
[000024ea] 2e05                      move.l     d5,d7
__dtog_13:
[000024ec] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[000024f0] 4e5e                      unlk       a6
[000024f2] 4e75                      rts

_strchr:
[000024f4] 4e56 0000                 link       a6,#0
[000024f8] 48e7 0404                 movem.l    d5/a5,-(a7)
[000024fc] 2a6e 0008                 movea.l    8(a6),a5
[00002500] 2a2e 000c                 move.l     12(a6),d5
_strchr_2:
[00002504] 4a15                      tst.b      (a5)
[00002506] 670c                      beq.s      _strchr_1
[00002508] 7e00                      moveq.l    #0,d7
[0000250a] 1e15                      move.b     (a5),d7
[0000250c] be85                      cmp.l      d5,d7
[0000250e] 6704                      beq.s      _strchr_1
[00002510] 528d                      addq.l     #1,a5
[00002512] 60f0                      bra.s      _strchr_2
_strchr_1:
[00002514] 7e00                      moveq.l    #0,d7
[00002516] 1e15                      move.b     (a5),d7
[00002518] be85                      cmp.l      d5,d7
[0000251a] 6604                      bne.s      _strchr_3
[0000251c] 2e0d                      move.l     a5,d7
[0000251e] 6002                      bra.s      _strchr_4
_strchr_3:
[00002520] 7e00                      moveq.l    #0,d7
_strchr_4:
[00002522] 4cdf 2020                 movem.l    (a7)+,d5/a5
[00002526] 4e5e                      unlk       a6
[00002528] 4e75                      rts

_strlen:
[0000252a] 4e56 0000                 link       a6,#0
[0000252e] 48e7 000c                 movem.l    a4-a5,-(a7)
[00002532] 2a6e 0008                 movea.l    8(a6),a5
[00002536] 284d                      movea.l    a5,a4
_strlen_2:
[00002538] 4a14                      tst.b      (a4)
[0000253a] 6704                      beq.s      _strlen_1
[0000253c] 528c                      addq.l     #1,a4
[0000253e] 60f8                      bra.s      _strlen_2
_strlen_1:
[00002540] 2e0c                      move.l     a4,d7
[00002542] 9e8d                      sub.l      a5,d7
[00002544] 4cdf 3000                 movem.l    (a7)+,a4-a5
[00002548] 4e5e                      unlk       a6
[0000254a] 4e75                      rts

_toupper:
[0000254c] 4e56 fffc                 link       a6,#-4
[00002550] 2eae 0008                 move.l     8(a6),(a7)
[00002554] 4eb9 0000 256e            jsr        _islower
[0000255a] 4a87                      tst.l      d7
[0000255c] 6708                      beq.s      _toupper_1
[0000255e] 7ee0                      moveq.l    #-32,d7
[00002560] deae 0008                 add.l      8(a6),d7
[00002564] 6004                      bra.s      _toupper_2
_toupper_1:
[00002566] 2e2e 0008                 move.l     8(a6),d7
_toupper_2:
[0000256a] 4e5e                      unlk       a6
[0000256c] 4e75                      rts

_islower:
[0000256e] 4e56 0000                 link       a6,#0
[00002572] 4aae 0008                 tst.l      8(a6)
[00002576] 6c04                      bge.s      _islower_1
[00002578] 7e00                      moveq.l    #0,d7
[0000257a] 601c                      bra.s      _islower_2
_islower_1:
[0000257c] 1e2e 000b                 move.b     11(a6),d7
[00002580] 0287 0000 00ff            andi.l     #$000000FF,d7
[00002586] 2247                      movea.l    d7,a1
[00002588] d3fc 0002 08c1            adda.l     #$000254D5,a1
[0000258e] 7e00                      moveq.l    #0,d7
[00002590] 1e11                      move.b     (a1),d7
[00002592] 7c02                      moveq.l    #2,d6
[00002594] cc87                      and.l      d7,d6
[00002596] 2e06                      move.l     d6,d7
_islower_2:
[00002598] 4e5e                      unlk       a6
[0000259a] 4e75                      rts

__chkio:
[0000259c] 4e56 0000                 link       a6,#0
[000025a0] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[000025a4] 2a6e 0008                 movea.l    8(a6),a5
[000025a8] 2e0d                      move.l     a5,d7
[000025aa] 6610                      bne.s      __chkio_1
[000025ac] 2ebc 0002 074a            move.l     #_filerr,(a7)
[000025b2] 42a7                      clr.l      -(a7)
[000025b4] 4eb9 0000 44d4            jsr        __raise
[000025ba] 588f                      addq.l     #4,a7
__chkio_1:
[000025bc] 4ab9 0002 0c7a            tst.l      $0002588E
[000025c2] 6612                      bne.s      __chkio_2
[000025c4] 2ebc 0000 2684            move.l     #__doflush,(a7)
[000025ca] 4eb9 0000 0068            jsr        _onexit
[000025d0] 23c7 0002 0c7a            move.l     d7,$0002588E
__chkio_2:
[000025d6] 4aae 000c                 tst.l      12(a6)
[000025da] 6704                      beq.s      __chkio_3
[000025dc] 7e20                      moveq.l    #32,d7
[000025de] 6002                      bra.s      __chkio_4
__chkio_3:
[000025e0] 7e10                      moveq.l    #16,d7
__chkio_4:
[000025e2] 2a07                      move.l     d7,d5
[000025e4] 0c85 0000 0020            cmpi.l     #$00000020,d5
[000025ea] 6612                      bne.s      __chkio_5
[000025ec] 7e18                      moveq.l    #24,d7
[000025ee] 7c00                      moveq.l    #0,d6
[000025f0] 3c2d 0006                 move.w     6(a5),d6
[000025f4] ce86                      and.l      d6,d7
[000025f6] 0c87 0000 0008            cmpi.l     #$00000008,d7
[000025fc] 661a                      bne.s      __chkio_6
__chkio_5:
[000025fe] 0c85 0000 0010            cmpi.l     #$00000010,d5
[00002604] 661c                      bne.s      __chkio_7
[00002606] 7e24                      moveq.l    #36,d7
[00002608] 7c00                      moveq.l    #0,d6
[0000260a] 3c2d 0006                 move.w     6(a5),d6
[0000260e] ce86                      and.l      d6,d7
[00002610] 0c87 0000 0004            cmpi.l     #$00000004,d7
[00002616] 670a                      beq.s      __chkio_7
__chkio_6:
[00002618] 08ed 0001 0007            bset       #1,7(a5)
[0000261e] 7e00                      moveq.l    #0,d7
[00002620] 6032                      bra.s      __chkio_8
__chkio_7:
[00002622] 4aad 0018                 tst.l      24(a5)
[00002626] 6634                      bne.s      __chkio_9
[00002628] 082d 0001 0006            btst       #1,6(a5)
[0000262e] 662c                      bne.s      __chkio_9
[00002630] 4297                      clr.l      (a7)
[00002632] 2f2d 000c                 move.l     12(a5),-(a7)
[00002636] 4eb9 0000 374e            jsr        __alloc
[0000263c] 588f                      addq.l     #4,a7
[0000263e] 2b47 0018                 move.l     d7,24(a5)
[00002642] 6708                      beq.s      __chkio_10
[00002644] 08ed 0006 0007            bset       #6,7(a5)
[0000264a] 6010                      bra.s      __chkio_9
__chkio_10:
[0000264c] 08ed 0001 0007            bset       #1,7(a5)
[00002652] 7e00                      moveq.l    #0,d7
__chkio_8:
[00002654] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00002658] 4e5e                      unlk       a6
[0000265a] 4e75                      rts
__chkio_9:
[0000265c] 3e2d 0006                 move.w     6(a5),d7
[00002660] 0247 0030                 andi.w     #$0030,d7
[00002664] 4847                      swap       d7
[00002666] 4247                      clr.w      d7
[00002668] 4847                      swap       d7
[0000266a] 6604                      bne.s      __chkio_11
[0000266c] 42ad 0008                 clr.l      8(a5)
__chkio_11:
[00002670] 7ecf                      moveq.l    #-49,d7
[00002672] 7c00                      moveq.l    #0,d6
[00002674] 3c2d 0006                 move.w     6(a5),d6
[00002678] ce86                      and.l      d6,d7
[0000267a] 8e85                      or.l       d5,d7
[0000267c] 3b47 0006                 move.w     d7,6(a5)
[00002680] 7e01                      moveq.l    #1,d7
[00002682] 60d0                      bra.s      __chkio_8

__doflush:
[00002684] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00002688] 2a79 0002 0c76            movea.l    $0002588A,a5
__doflush_3:
[0000268e] 2e0d                      move.l     a5,d7
[00002690] 672a                      beq.s      __doflush_1
[00002692] 082d 0005 0007            btst       #5,7(a5)
[00002698] 671e                      beq.s      __doflush_2
[0000269a] 4aad 0008                 tst.l      8(a5)
[0000269e] 6f18                      ble.s      __doflush_2
[000026a0] 4878 0001                 pea.l      ($00000001).w
[000026a4] 2f2d 0008                 move.l     8(a5),-(a7)
[000026a8] 2f2d 0018                 move.l     24(a5),-(a7)
[000026ac] 2f0d                      move.l     a5,-(a7)
[000026ae] 4eb9 0000 2cec            jsr        __dowrite
[000026b4] 4fef 0010                 lea.l      16(a7),a7
__doflush_2:
[000026b8] 2a55                      movea.l    (a5),a5
[000026ba] 60d2                      bra.s      __doflush_3
__doflush_1:
[000026bc] 2879 0002 0c7e            movea.l    $00025892,a4
__doflush_5:
[000026c2] 2e0c                      move.l     a4,d7
[000026c4] 672c                      beq.s      __doflush_4
[000026c6] 4878 0001                 pea.l      ($00000001).w
[000026ca] 2f2c 0012                 move.l     18(a4),-(a7)
[000026ce] 4eb9 0000 2bb0            jsr        __doclose
[000026d4] 508f                      addq.l     #8,a7
[000026d6] 486c 0004                 pea.l      4(a4)
[000026da] 4eb9 0000 33f2            jsr        __remove
[000026e0] 588f                      addq.l     #4,a7
[000026e2] 2e94                      move.l     (a4),(a7)
[000026e4] 2f0c                      move.l     a4,-(a7)
[000026e6] 4eb9 0000 37ac            jsr        __free
[000026ec] 588f                      addq.l     #4,a7
[000026ee] 2847                      movea.l    d7,a4
[000026f0] 60d0                      bra.s      __doflush_5
__doflush_4:
[000026f2] 2e39 0002 0c7a            move.l     $0002588E,d7
[000026f8] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000026fc] 4e75                      rts

__main:
[000026fe] 4e56 0000                 link       a6,#0
[00002702] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00002706] 2a2e 0008                 move.l     8(a6),d5
[0000270a] 2e05                      move.l     d5,d7
[0000270c] 5287                      addq.l     #1,d7
[0000270e] e587                      asl.l      #2,d7
[00002710] 49f6 780c                 lea.l      12(a6,d7.l),a4
[00002714] 23cc 0002 0c2e            move.l     a4,$00025842
[0000271a] 4a85                      tst.l      d5
[0000271c] 6728                      beq.s      __main_1
[0000271e] 23ee 000c 0002 0aba       move.l     12(a6),_pname
[00002726] 2a6e 000c                 movea.l    12(a6),a5
__main_3:
[0000272a] 4a15                      tst.b      (a5)
[0000272c] 6718                      beq.s      __main_1
[0000272e] 0c15 003a                 cmpi.b     #$3A,(a5)
[00002732] 670a                      beq.s      __main_2
[00002734] 0c15 007c                 cmpi.b     #$7C,(a5)
[00002738] 6704                      beq.s      __main_2
[0000273a] 528d                      addq.l     #1,a5
[0000273c] 60ec                      bra.s      __main_3
__main_2:
[0000273e] 421d                      clr.b      (a5)+
[00002740] 23cd 0002 09d6            move.l     a5,_paths
__main_1:
[00002746] 2ebc 0002 0744            move.l     #$00025358,(a7)
[0000274c] 4eb9 0000 421a            jsr        __getenv
[00002752] 2a47                      movea.l    d7,a5
[00002754] 2e0d                      move.l     a5,d7
[00002756] 6706                      beq.s      __main_4
[00002758] 23cd 0002 09d6            move.l     a5,_paths
__main_4:
[0000275e] 2e8c                      move.l     a4,(a7)
[00002760] 486e 000c                 pea.l      12(a6)
[00002764] 2f05                      move.l     d5,-(a7)
[00002766] 4eb9 0000 01e2            jsr        _main
[0000276c] 508f                      addq.l     #8,a7
[0000276e] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00002772] 4e5e                      unlk       a6
[00002774] 4e75                      rts

__cmpstr:
[00002776] 206f 0004                 movea.l    4(a7),a0
[0000277a] 246f 0008                 movea.l    8(a7),a2
__cmpstr_2:
[0000277e] 101a                      move.b     (a2)+,d0
[00002780] b018                      cmp.b      (a0)+,d0
[00002782] 6608                      bne.s      __cmpstr_1
[00002784] 4a00                      tst.b      d0
[00002786] 66f6                      bne.s      __cmpstr_2
[00002788] 7e01                      moveq.l    #1,d7
[0000278a] 4e75                      rts
__cmpstr_1:
[0000278c] 7e00                      moveq.l    #0,d7
[0000278e] 4e75                      rts

x2790:
[00002790] 4e56 0000                 link       a6,#0
[00002794] 48e7 001c                 movem.l    a3-a5,-(a7)
[00002798] 2a6e 0008                 movea.l    8(a6),a5
[0000279c] 286e 000c                 movea.l    12(a6),a4
[000027a0] 266e 0010                 movea.l    16(a6),a3
[000027a4] 0c15 006e                 cmpi.b     #$6E,(a5)
[000027a8] 6706                      beq.s      x2790_1
[000027aa] 0c15 004e                 cmpi.b     #$4E,(a5)
[000027ae] 6618                      bne.s      x2790_2
x2790_1:
[000027b0] 528d                      addq.l     #1,a5
[000027b2] 2253                      movea.l    (a3),a1
[000027b4] 38a9 0002                 move.w     2(a1),(a4)
[000027b8] 2253                      movea.l    (a3),a1
[000027ba] 5889                      addq.l     #4,a1
[000027bc] 2689                      move.l     a1,(a3)
x2790_3:
[000027be] 2e0d                      move.l     a5,d7
[000027c0] 4cdf 3800                 movem.l    (a7)+,a3-a5
[000027c4] 4e5e                      unlk       a6
[000027c6] 4e75                      rts
x2790_2:
[000027c8] 4254                      clr.w      (a4)
x2790_4:
[000027ca] 227c 0002 08c1            movea.l    #$000254D5,a1
[000027d0] 7e00                      moveq.l    #0,d7
[000027d2] 1e15                      move.b     (a5),d7
[000027d4] 0831 0002 7800            btst       #2,0(a1,d7.l)
[000027da] 67e2                      beq.s      x2790_3
[000027dc] 7e0a                      moveq.l    #10,d7
[000027de] 3c14                      move.w     (a4),d6
[000027e0] cec6                      mulu.w     d6,d7
[000027e2] 7c00                      moveq.l    #0,d6
[000027e4] 1c15                      move.b     (a5),d6
[000027e6] de86                      add.l      d6,d7
[000027e8] 7cd0                      moveq.l    #-48,d6
[000027ea] dc87                      add.l      d7,d6
[000027ec] 3886                      move.w     d6,(a4)
[000027ee] 528d                      addq.l     #1,a5
[000027f0] 60d8                      bra.s      x2790_4

__putf:
[000027f2] 4e56 ffd4                 link       a6,#-44
[000027f6] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[000027fa] 2a6e 0010                 movea.l    16(a6),a5
__putf_3:
[000027fe] 284d                      movea.l    a5,a4
__putf_2:
[00002800] 4a14                      tst.b      (a4)
[00002802] 6710                      beq.s      __putf_1
[00002804] 0c14 0025                 cmpi.b     #$25,(a4)
[00002808] 670a                      beq.s      __putf_1
[0000280a] 528c                      addq.l     #1,a4
[0000280c] 60f2                      bra.s      __putf_2
__putf_45:
[0000280e] 4bec 0001                 lea.l      1(a4),a5
[00002812] 60ea                      bra.s      __putf_3
__putf_1:
[00002814] bbcc                      cmpa.l     a4,a5
[00002816] 6414                      bcc.s      __putf_4
[00002818] 2e0c                      move.l     a4,d7
[0000281a] 9e8d                      sub.l      a5,d7
[0000281c] 2e87                      move.l     d7,(a7)
[0000281e] 2f0d                      move.l     a5,-(a7)
[00002820] 2f2e 000c                 move.l     12(a6),-(a7)
[00002824] 226e 0008                 movea.l    8(a6),a1
[00002828] 4e91                      jsr        (a1)
[0000282a] 508f                      addq.l     #8,a7
__putf_4:
[0000282c] 4a1c                      tst.b      (a4)+
[0000282e] 6608                      bne.s      __putf_5
[00002830] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00002834] 4e5e                      unlk       a6
[00002836] 4e75                      rts
__putf_5:
[00002838] 7001                      moveq.l    #1,d0
[0000283a] 2d40 fffc                 move.l     d0,-4(a6)
[0000283e] 1d7c 0020 ffd9            move.b     #$20,-39(a6)
[00002844] 0c14 002d                 cmpi.b     #$2D,(a4)
[00002848] 660e                      bne.s      __putf_6
[0000284a] 42ae fffc                 clr.l      -4(a6)
[0000284e] 528c                      addq.l     #1,a4
[00002850] 1d54 ffd9                 move.b     (a4),-39(a6)
[00002854] 528c                      addq.l     #1,a4
[00002856] 600e                      bra.s      __putf_7
__putf_6:
[00002858] 0c14 002b                 cmpi.b     #$2B,(a4)
[0000285c] 6608                      bne.s      __putf_7
[0000285e] 528c                      addq.l     #1,a4
[00002860] 1d54 ffd9                 move.b     (a4),-39(a6)
[00002864] 528c                      addq.l     #1,a4
__putf_7:
[00002866] 486e 0014                 pea.l      20(a6)
[0000286a] 486e fff6                 pea.l      -10(a6)
[0000286e] 2f0c                      move.l     a4,-(a7)
[00002870] 4eba ff1e                 jsr        $00002790(pc)
[00002874] 4fef 000c                 lea.l      12(a7),a7
[00002878] 2847                      movea.l    d7,a4
[0000287a] 426e fff8                 clr.w      -8(a6)
[0000287e] 0c14 002e                 cmpi.b     #$2E,(a4)
[00002882] 6616                      bne.s      __putf_8
[00002884] 486e 0014                 pea.l      20(a6)
[00002888] 486e fff8                 pea.l      -8(a6)
[0000288c] 486c 0001                 pea.l      1(a4)
[00002890] 4eba fefe                 jsr        $00002790(pc)
[00002894] 4fef 000c                 lea.l      12(a7),a7
[00002898] 2847                      movea.l    d7,a4
__putf_8:
[0000289a] 0c14 0061                 cmpi.b     #$61,(a4)
[0000289e] 6718                      beq.s      __putf_9
[000028a0] 0c14 0068                 cmpi.b     #$68,(a4)
[000028a4] 6712                      beq.s      __putf_9
[000028a6] 0c14 006f                 cmpi.b     #$6F,(a4)
[000028aa] 670c                      beq.s      __putf_9
[000028ac] 0c14 0074                 cmpi.b     #$74,(a4)
[000028b0] 6706                      beq.s      __putf_9
[000028b2] 0c14 0075                 cmpi.b     #$75,(a4)
[000028b6] 660c                      bne.s      __putf_10
__putf_9:
[000028b8] 161c                      move.b     (a4)+,d3
__putf_13:
[000028ba] 0c03 0068                 cmpi.b     #$68,d3
[000028be] 6608                      bne.s      __putf_11
[000028c0] 7a10                      moveq.l    #16,d5
[000028c2] 6024                      bra.s      __putf_12
__putf_10:
[000028c4] 4203                      clr.b      d3
[000028c6] 60f2                      bra.s      __putf_13
__putf_11:
[000028c8] 0c03 006f                 cmpi.b     #$6F,d3
[000028cc] 6604                      bne.s      __putf_14
[000028ce] 7a08                      moveq.l    #8,d5
[000028d0] 6016                      bra.s      __putf_12
__putf_14:
[000028d2] 0c03 0074                 cmpi.b     #$74,d3
[000028d6] 6604                      bne.s      __putf_15
[000028d8] 7a02                      moveq.l    #2,d5
[000028da] 600c                      bra.s      __putf_12
__putf_15:
[000028dc] 0c03 0075                 cmpi.b     #$75,d3
[000028e0] 6604                      bne.s      __putf_16
[000028e2] 7a0a                      moveq.l    #10,d5
[000028e4] 6002                      bra.s      __putf_12
__putf_16:
[000028e6] 7af6                      moveq.l    #-10,d5
__putf_12:
[000028e8] 0c14 0078                 cmpi.b     #$78,(a4)
[000028ec] 6606                      bne.s      __putf_17
[000028ee] 4244                      clr.w      d4
[000028f0] 6000 01dc                 bra        __putf_18
__putf_17:
[000028f4] 0c14 0062                 cmpi.b     #$62,(a4)
[000028f8] 663c                      bne.s      __putf_19
[000028fa] 226e 0014                 movea.l    20(a6),a1
[000028fe] 2651                      movea.l    (a1),a3
[00002900] 58ae 0014                 addq.l     #4,20(a6)
[00002904] 226e 0014                 movea.l    20(a6),a1
[00002908] 3829 0002                 move.w     2(a1),d4
[0000290c] 226e 0014                 movea.l    20(a6),a1
[00002910] 5889                      addq.l     #4,a1
[00002912] 2d49 0014                 move.l     a1,20(a6)
[00002916] 4a6e fff8                 tst.w      -8(a6)
[0000291a] 6700 01b2                 beq        __putf_18
[0000291e] b86e fff8                 cmp.w      -8(a6),d4
[00002922] 6c06                      bge.s      __putf_20
[00002924] 3e04                      move.w     d4,d7
[00002926] 48c7                      ext.l      d7
[00002928] 6006                      bra.s      __putf_21
__putf_20:
[0000292a] 3e2e fff8                 move.w     -8(a6),d7
[0000292e] 48c7                      ext.l      d7
__putf_21:
[00002930] 3807                      move.w     d7,d4
[00002932] 6000 019a                 bra        __putf_18
__putf_19:
[00002936] 0c14 0070                 cmpi.b     #$70,(a4)
[0000293a] 6634                      bne.s      __putf_22
[0000293c] 226e 0014                 movea.l    20(a6),a1
[00002940] 2651                      movea.l    (a1),a3
[00002942] 58ae 0014                 addq.l     #4,20(a6)
[00002946] 2e8b                      move.l     a3,(a7)
[00002948] 4eb9 0000 4272            jsr        __lenstr
[0000294e] 3807                      move.w     d7,d4
[00002950] 4a6e fff8                 tst.w      -8(a6)
[00002954] 6700 0178                 beq        __putf_18
[00002958] b86e fff8                 cmp.w      -8(a6),d4
[0000295c] 6c06                      bge.s      __putf_23
[0000295e] 3e04                      move.w     d4,d7
[00002960] 48c7                      ext.l      d7
[00002962] 6006                      bra.s      __putf_24
__putf_23:
[00002964] 3e2e fff8                 move.w     -8(a6),d7
[00002968] 48c7                      ext.l      d7
__putf_24:
[0000296a] 3807                      move.w     d7,d4
[0000296c] 6000 0160                 bra        __putf_18
__putf_22:
[00002970] 0c14 0066                 cmpi.b     #$66,(a4)
[00002974] 6658                      bne.s      __putf_25
[00002976] 2e2e 0014                 move.l     20(a6),d7
[0000297a] 7c01                      moveq.l    #1,d6
[0000297c] cc87                      and.l      d7,d6
[0000297e] 7e02                      moveq.l    #2,d7
[00002980] 9e86                      sub.l      d6,d7
[00002982] 7c01                      moveq.l    #1,d6
[00002984] cc87                      and.l      d7,d6
[00002986] dcae 0014                 add.l      20(a6),d6
[0000298a] 2d46 0014                 move.l     d6,20(a6)
[0000298e] 47ee ffda                 lea.l      -38(a6),a3
[00002992] 3e2e fff8                 move.w     -8(a6),d7
[00002996] 48c7                      ext.l      d7
[00002998] 2e87                      move.l     d7,(a7)
[0000299a] 7e16                      moveq.l    #22,d7
[0000299c] 3c2e fff8                 move.w     -8(a6),d6
[000029a0] 48c6                      ext.l      d6
[000029a2] 9e86                      sub.l      d6,d7
[000029a4] 2f07                      move.l     d7,-(a7)
[000029a6] 226e 0014                 movea.l    20(a6),a1
[000029aa] 2f29 0004                 move.l     4(a1),-(a7)
[000029ae] 2f11                      move.l     (a1),-(a7)
[000029b0] 486e ffda                 pea.l      -38(a6)
[000029b4] 4eb9 0000 2ed4            jsr        __dtof
[000029ba] 4fef 0010                 lea.l      16(a7),a7
[000029be] 3807                      move.w     d7,d4
[000029c0] 226e 0014                 movea.l    20(a6),a1
[000029c4] 5089                      addq.l     #8,a1
[000029c6] 2d49 0014                 move.l     a1,20(a6)
[000029ca] 6000 0102                 bra        __putf_18
__putf_25:
[000029ce] 0c14 0064                 cmpi.b     #$64,(a4)
[000029d2] 665c                      bne.s      __putf_26
[000029d4] 2e2e 0014                 move.l     20(a6),d7
[000029d8] 7c01                      moveq.l    #1,d6
[000029da] cc87                      and.l      d7,d6
[000029dc] 7e02                      moveq.l    #2,d7
[000029de] 9e86                      sub.l      d6,d7
[000029e0] 7c01                      moveq.l    #1,d6
[000029e2] cc87                      and.l      d7,d6
[000029e4] dcae 0014                 add.l      20(a6),d6
[000029e8] 2d46 0014                 move.l     d6,20(a6)
[000029ec] 47ee ffda                 lea.l      -38(a6),a3
[000029f0] 0c6e 0011 fff8            cmpi.w     #$0011,-8(a6)
[000029f6] 6f04                      ble.s      __putf_27
[000029f8] 7e11                      moveq.l    #17,d7
[000029fa] 6006                      bra.s      __putf_28
__putf_27:
[000029fc] 3e2e fff8                 move.w     -8(a6),d7
[00002a00] 48c7                      ext.l      d7
__putf_28:
[00002a02] 2e87                      move.l     d7,(a7)
[00002a04] 4878 0001                 pea.l      ($00000001).w
[00002a08] 226e 0014                 movea.l    20(a6),a1
[00002a0c] 2f29 0004                 move.l     4(a1),-(a7)
[00002a10] 2f11                      move.l     (a1),-(a7)
[00002a12] 486e ffda                 pea.l      -38(a6)
[00002a16] 4eb9 0000 2d5e            jsr        __dtoe
[00002a1c] 4fef 0010                 lea.l      16(a7),a7
[00002a20] 3807                      move.w     d7,d4
[00002a22] 226e 0014                 movea.l    20(a6),a1
[00002a26] 5089                      addq.l     #8,a1
[00002a28] 2d49 0014                 move.l     a1,20(a6)
[00002a2c] 6000 00a0                 bra        __putf_18
__putf_26:
[00002a30] 0c14 0063                 cmpi.b     #$63,(a4)
[00002a34] 671e                      beq.s      __putf_29
[00002a36] 0c14 0073                 cmpi.b     #$73,(a4)
[00002a3a] 6718                      beq.s      __putf_29
[00002a3c] 0c14 0069                 cmpi.b     #$69,(a4)
[00002a40] 6712                      beq.s      __putf_29
[00002a42] 0c14 006c                 cmpi.b     #$6C,(a4)
[00002a46] 670c                      beq.s      __putf_29
[00002a48] 4a03                      tst.b      d3
[00002a4a] 6700 0118                 beq        __putf_30
[00002a4e] 4a24                      tst.b      -(a4)
[00002a50] 6700 0112                 beq        __putf_30
__putf_29:
[00002a54] 0c14 006c                 cmpi.b     #$6C,(a4)
[00002a58] 6718                      beq.s      __putf_31
[00002a5a] 0c14 0063                 cmpi.b     #$63,(a4)
[00002a5e] 670a                      beq.s      __putf_32
[00002a60] 0c14 0073                 cmpi.b     #$73,(a4)
[00002a64] 6704                      beq.s      __putf_32
[00002a66] 7e01                      moveq.l    #1,d7
[00002a68] 6002                      bra.s      __putf_33
__putf_32:
[00002a6a] 7e00                      moveq.l    #0,d7
__putf_33:
[00002a6c] 4a87                      tst.l      d7
[00002a6e] 6700 008a                 beq        __putf_34
__putf_31:
[00002a72] 0c03 0061                 cmpi.b     #$61,d3
[00002a76] 6632                      bne.s      __putf_35
[00002a78] 226e 0014                 movea.l    20(a6),a1
[00002a7c] 2d51 fff2                 move.l     (a1),-14(a6)
[00002a80] 7804                      moveq.l    #4,d4
__putf_37:
[00002a82] 5344                      subq.w     #1,d4
[00002a84] 6d12                      blt.s      __putf_36
[00002a86] 1dae fff5 40da            move.b     -11(a6),-38(a6,d4.w)
[00002a8c] 2e2e fff2                 move.l     -14(a6),d7
[00002a90] e087                      asr.l      #8,d7
[00002a92] 2d47 fff2                 move.l     d7,-14(a6)
[00002a96] 60ea                      bra.s      __putf_37
__putf_36:
[00002a98] 47ee ffda                 lea.l      -38(a6),a3
[00002a9c] 7804                      moveq.l    #4,d4
[00002a9e] 226e 0014                 movea.l    20(a6),a1
[00002aa2] 5889                      addq.l     #4,a1
[00002aa4] 2d49 0014                 move.l     a1,20(a6)
[00002aa8] 6024                      bra.s      __putf_18
__putf_35:
[00002aaa] 47ee ffda                 lea.l      -38(a6),a3
[00002aae] 2e85                      move.l     d5,(a7)
[00002ab0] 226e 0014                 movea.l    20(a6),a1
[00002ab4] 2f11                      move.l     (a1),-(a7)
[00002ab6] 486e ffda                 pea.l      -38(a6)
[00002aba] 4eb9 0000 31dc            jsr        __ltob
[00002ac0] 508f                      addq.l     #8,a7
[00002ac2] 3807                      move.w     d7,d4
[00002ac4] 226e 0014                 movea.l    20(a6),a1
[00002ac8] 5889                      addq.l     #4,a1
[00002aca] 2d49 0014                 move.l     a1,20(a6)
__putf_18:
[00002ace] 4aae fffc                 tst.l      -4(a6)
[00002ad2] 6700 0098                 beq        __putf_38
__putf_39:
[00002ad6] b86e fff6                 cmp.w      -10(a6),d4
[00002ada] 6c00 0090                 bge        __putf_38
[00002ade] 4878 0001                 pea.l      ($00000001).w
[00002ae2] 486e ffd9                 pea.l      -39(a6)
[00002ae6] 2f2e 000c                 move.l     12(a6),-(a7)
[00002aea] 226e 0008                 movea.l    8(a6),a1
[00002aee] 4e91                      jsr        (a1)
[00002af0] 4fef 000c                 lea.l      12(a7),a7
[00002af4] 536e fff6                 subq.w     #1,-10(a6)
[00002af8] 60dc                      bra.s      __putf_39
__putf_34:
[00002afa] 47ee ffda                 lea.l      -38(a6),a3
[00002afe] 226e 0014                 movea.l    20(a6),a1
[00002b02] 3829 0002                 move.w     2(a1),d4
[00002b06] 226e 0014                 movea.l    20(a6),a1
[00002b0a] 5889                      addq.l     #4,a1
[00002b0c] 2d49 0014                 move.l     a1,20(a6)
[00002b10] 0c03 0061                 cmpi.b     #$61,d3
[00002b14] 6620                      bne.s      __putf_40
[00002b16] 0c14 0063                 cmpi.b     #$63,(a4)
[00002b1a] 6608                      bne.s      __putf_41
[00002b1c] 1d44 ffda                 move.b     d4,-38(a6)
[00002b20] 7801                      moveq.l    #1,d4
[00002b22] 60aa                      bra.s      __putf_18
__putf_41:
[00002b24] 3e04                      move.w     d4,d7
[00002b26] 48c7                      ext.l      d7
[00002b28] e087                      asr.l      #8,d7
[00002b2a] 1d47 ffda                 move.b     d7,-38(a6)
[00002b2e] 1d44 ffdb                 move.b     d4,-37(a6)
[00002b32] 7802                      moveq.l    #2,d4
[00002b34] 6098                      bra.s      __putf_18
__putf_40:
[00002b36] 4a85                      tst.l      d5
[00002b38] 6d10                      blt.s      __putf_42
[00002b3a] 0c14 0063                 cmpi.b     #$63,(a4)
[00002b3e] 6606                      bne.s      __putf_43
[00002b40] 0244 00ff                 andi.w     #$00FF,d4
[00002b44] 6004                      bra.s      __putf_42
__putf_43:
[00002b46] 0244 ffff                 andi.w     #$FFFF,d4
__putf_42:
[00002b4a] 2e85                      move.l     d5,(a7)
[00002b4c] 3e04                      move.w     d4,d7
[00002b4e] 48c7                      ext.l      d7
[00002b50] 2f07                      move.l     d7,-(a7)
[00002b52] 486e ffda                 pea.l      -38(a6)
[00002b56] 4eb9 0000 34e4            jsr        __stob
[00002b5c] 508f                      addq.l     #8,a7
[00002b5e] 3807                      move.w     d7,d4
[00002b60] 6000 ff6c                 bra        __putf_18
__putf_30:
[00002b64] 264c                      movea.l    a4,a3
[00002b66] 7801                      moveq.l    #1,d4
[00002b68] 6000 ff64                 bra        __putf_18
__putf_38:
[00002b6c] 4a44                      tst.w      d4
[00002b6e] 6f14                      ble.s      __putf_44
[00002b70] 3e04                      move.w     d4,d7
[00002b72] 48c7                      ext.l      d7
[00002b74] 2e87                      move.l     d7,(a7)
[00002b76] 2f0b                      move.l     a3,-(a7)
[00002b78] 2f2e 000c                 move.l     12(a6),-(a7)
[00002b7c] 226e 0008                 movea.l    8(a6),a1
[00002b80] 4e91                      jsr        (a1)
[00002b82] 508f                      addq.l     #8,a7
__putf_44:
[00002b84] 4aae fffc                 tst.l      -4(a6)
[00002b88] 6600 fc84                 bne        __putf_45
__putf_46:
[00002b8c] b86e fff6                 cmp.w      -10(a6),d4
[00002b90] 6c00 fc7c                 bge        __putf_45
[00002b94] 4878 0001                 pea.l      ($00000001).w
[00002b98] 486e ffd9                 pea.l      -39(a6)
[00002b9c] 2f2e 000c                 move.l     12(a6),-(a7)
[00002ba0] 226e 0008                 movea.l    8(a6),a1
[00002ba4] 4e91                      jsr        (a1)
[00002ba6] 4fef 000c                 lea.l      12(a7),a7
[00002baa] 536e fff6                 subq.w     #1,-10(a6)
[00002bae] 60dc                      bra.s      __putf_46

__doclose:
[00002bb0] 4e56 fffc                 link       a6,#-4
[00002bb4] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00002bb8] 2a6e 0008                 movea.l    8(a6),a5
[00002bbc] 2e0d                      move.l     a5,d7
[00002bbe] 6610                      bne.s      __doclose_1
[00002bc0] 2ebc 0002 074a            move.l     #_filerr,(a7)
[00002bc6] 42a7                      clr.l      -(a7)
[00002bc8] 4eb9 0000 44d4            jsr        __raise
[00002bce] 588f                      addq.l     #4,a7
__doclose_1:
[00002bd0] 2ebc 0002 0c76            move.l     #$0002588A,(a7)
[00002bd6] 2f0d                      move.l     a5,-(a7)
[00002bd8] 4eb9 0000 32cc            jsr        __onlist
[00002bde] 588f                      addq.l     #4,a7
[00002be0] 2847                      movea.l    d7,a4
[00002be2] 2e0c                      move.l     a4,d7
[00002be4] 6702                      beq.s      __doclose_2
[00002be6] 2895                      move.l     (a5),(a4)
__doclose_2:
[00002be8] 082d 0005 0007            btst       #5,7(a5)
[00002bee] 671e                      beq.s      __doclose_3
[00002bf0] 4aad 0008                 tst.l      8(a5)
[00002bf4] 6f18                      ble.s      __doclose_3
[00002bf6] 4878 0001                 pea.l      ($00000001).w
[00002bfa] 2f2d 0008                 move.l     8(a5),-(a7)
[00002bfe] 2f2d 0018                 move.l     24(a5),-(a7)
[00002c02] 2f0d                      move.l     a5,-(a7)
[00002c04] 4eb9 0000 2cec            jsr        __dowrite
[00002c0a] 4fef 0010                 lea.l      16(a7),a7
__doclose_3:
[00002c0e] 3e2d 0004                 move.w     4(a5),d7
[00002c12] 48c7                      ext.l      d7
[00002c14] 2e87                      move.l     d7,(a7)
[00002c16] 4eb9 0000 3b34            jsr        __close
[00002c1c] 4a87                      tst.l      d7
[00002c1e] 6c04                      bge.s      __doclose_4
[00002c20] 7eff                      moveq.l    #-1,d7
[00002c22] 6002                      bra.s      __doclose_5
__doclose_4:
[00002c24] 7e00                      moveq.l    #0,d7
__doclose_5:
[00002c26] 2a07                      move.l     d7,d5
[00002c28] 082d 0006 0007            btst       #6,7(a5)
[00002c2e] 670e                      beq.s      __doclose_6
[00002c30] 4297                      clr.l      (a7)
[00002c32] 2f2d 0018                 move.l     24(a5),-(a7)
[00002c36] 4eb9 0000 37ac            jsr        __free
[00002c3c] 588f                      addq.l     #4,a7
__doclose_6:
[00002c3e] 082d 0007 0007            btst       #7,7(a5)
[00002c44] 6712                      beq.s      __doclose_7
[00002c46] 4aae 000c                 tst.l      12(a6)
[00002c4a] 670c                      beq.s      __doclose_7
[00002c4c] 4297                      clr.l      (a7)
[00002c4e] 2f0d                      move.l     a5,-(a7)
[00002c50] 4eb9 0000 37ac            jsr        __free
[00002c56] 588f                      addq.l     #4,a7
__doclose_7:
[00002c58] 426d 0006                 clr.w      6(a5)
[00002c5c] 2e05                      move.l     d5,d7
[00002c5e] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00002c62] 4e5e                      unlk       a6
[00002c64] 4e75                      rts

__doread:
[00002c66] 4e56 0000                 link       a6,#0
[00002c6a] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00002c6e] 2a6e 0008                 movea.l    8(a6),a5
[00002c72] 286e 000c                 movea.l    12(a6),a4
[00002c76] 2e0d                      move.l     a5,d7
[00002c78] 6610                      bne.s      __doread_1
[00002c7a] 2ebc 0002 074a            move.l     #_filerr,(a7)
[00002c80] 42a7                      clr.l      -(a7)
[00002c82] 4eb9 0000 44d4            jsr        __raise
[00002c88] 588f                      addq.l     #4,a7
__doread_1:
[00002c8a] 082d 0002 0006            btst       #2,6(a5)
[00002c90] 671c                      beq.s      __doread_2
[00002c92] 4878 0001                 pea.l      ($00000001).w
[00002c96] 42a7                      clr.l      -(a7)
[00002c98] 3e2d 0004                 move.w     4(a5),d7
[00002c9c] 48c7                      ext.l      d7
[00002c9e] 2f07                      move.l     d7,-(a7)
[00002ca0] 4eb9 0000 31ca            jsr        __lseek
[00002ca6] 4fef 000c                 lea.l      12(a7),a7
[00002caa] 2b47 0010                 move.l     d7,16(a5)
__doread_2:
[00002cae] 2e2e 0010                 move.l     16(a6),d7
[00002cb2] 2e87                      move.l     d7,(a7)
[00002cb4] 2f0c                      move.l     a4,-(a7)
[00002cb6] 3e2d 0004                 move.w     4(a5),d7
[00002cba] 48c7                      ext.l      d7
[00002cbc] 2f07                      move.l     d7,-(a7)
[00002cbe] 4eb9 0000 33e0            jsr        __read
[00002cc4] 508f                      addq.l     #8,a7
[00002cc6] 2a07                      move.l     d7,d5
[00002cc8] 6c08                      bge.s      __doread_3
[00002cca] 08ed 0001 0007            bset       #1,7(a5)
[00002cd0] 6010                      bra.s      __doread_4
__doread_3:
[00002cd2] 4a85                      tst.l      d5
[00002cd4] 660c                      bne.s      __doread_4
[00002cd6] 08ed 0000 0007            bset       #0,7(a5)
[00002cdc] 08ad 0004 0007            bclr       #4,7(a5)
__doread_4:
[00002ce2] 2e05                      move.l     d5,d7
[00002ce4] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00002ce8] 4e5e                      unlk       a6
[00002cea] 4e75                      rts

__dowrite:
[00002cec] 4e56 0000                 link       a6,#0
[00002cf0] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00002cf4] 2a6e 0008                 movea.l    8(a6),a5
[00002cf8] 286e 000c                 movea.l    12(a6),a4
[00002cfc] 2a2e 0010                 move.l     16(a6),d5
[00002d00] 2e0d                      move.l     a5,d7
[00002d02] 6610                      bne.s      __dowrite_1
[00002d04] 2ebc 0002 074a            move.l     #_filerr,(a7)
[00002d0a] 42a7                      clr.l      -(a7)
[00002d0c] 4eb9 0000 44d4            jsr        __raise
[00002d12] 588f                      addq.l     #4,a7
__dowrite_1:
[00002d14] 2e05                      move.l     d5,d7
[00002d16] 2e87                      move.l     d7,(a7)
[00002d18] 2f0c                      move.l     a4,-(a7)
[00002d1a] 3e2d 0004                 move.w     4(a5),d7
[00002d1e] 48c7                      ext.l      d7
[00002d20] 2f07                      move.l     d7,-(a7)
[00002d22] 4eb9 0000 4632            jsr        __write
[00002d28] 508f                      addq.l     #8,a7
[00002d2a] be85                      cmp.l      d5,d7
[00002d2c] 6618                      bne.s      __dowrite_2
[00002d2e] 4aae 0014                 tst.l      20(a6)
[00002d32] 6720                      beq.s      __dowrite_3
[00002d34] 3e2d 0004                 move.w     4(a5),d7
[00002d38] 48c7                      ext.l      d7
[00002d3a] 2e87                      move.l     d7,(a7)
[00002d3c] 4eb9 0000 30e0            jsr        __flush
[00002d42] 4a87                      tst.l      d7
[00002d44] 660e                      bne.s      __dowrite_3
__dowrite_2:
[00002d46] 08ed 0001 0007            bset       #1,7(a5)
[00002d4c] 42ad 0008                 clr.l      8(a5)
[00002d50] 7e00                      moveq.l    #0,d7
[00002d52] 6002                      bra.s      __dowrite_4
__dowrite_3:
[00002d54] 7e01                      moveq.l    #1,d7
__dowrite_4:
[00002d56] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00002d5a] 4e5e                      unlk       a6
[00002d5c] 4e75                      rts

__dtoe:
[00002d5e] 4e56 ffd6                 link       a6,#-42
[00002d62] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[00002d66] 2a6e 0008                 movea.l    8(a6),a5
[00002d6a] 0c79 0024 0002 0a46       cmpi.w     #$0024,_maxprec
[00002d72] 6c0a                      bge.s      __dtoe_1
[00002d74] 3e39 0002 0a46            move.w     _maxprec,d7
[00002d7a] 48c7                      ext.l      d7
[00002d7c] 6002                      bra.s      __dtoe_2
__dtoe_1:
[00002d7e] 7e24                      moveq.l    #36,d7
__dtoe_2:
[00002d80] 3647                      movea.w    d7,a3
[00002d82] 4aae 000c                 tst.l      12(a6)
[00002d86] 6c1c                      bge.s      __dtoe_3
[00002d88] 2c2e 000c                 move.l     12(a6),d6
[00002d8c] 2e2e 0010                 move.l     16(a6),d7
[00002d90] 4a86                      tst.l      d6
[00002d92] 6704                      beq.s      __dtoe_4
[00002d94] 0846 001f                 bchg       #31,d6
__dtoe_4:
[00002d98] 2d46 000c                 move.l     d6,12(a6)
[00002d9c] 2d47 0010                 move.l     d7,16(a6)
[00002da0] 1afc 002d                 move.b     #$2D,(a5)+
__dtoe_3:
[00002da4] 286e 0014                 movea.l    20(a6),a4
[00002da8] d9ee 0018                 adda.l     24(a6),a4
[00002dac] 384c                      movea.w    a4,a4
[00002dae] 3e0b                      move.w     a3,d7
[00002db0] 3c0c                      move.w     a4,d6
[00002db2] be46                      cmp.w      d6,d7
[00002db4] 6c02                      bge.s      __dtoe_5
[00002db6] 384b                      movea.w    a3,a4
__dtoe_5:
[00002db8] 3e0c                      move.w     a4,d7
[00002dba] 48c7                      ext.l      d7
[00002dbc] 2e87                      move.l     d7,(a7)
[00002dbe] 5297                      addq.l     #1,(a7)
[00002dc0] 2f2e 0010                 move.l     16(a6),-(a7)
[00002dc4] 2f2e 000c                 move.l     12(a6),-(a7)
[00002dc8] 486e ffd6                 pea.l      -42(a6)
[00002dcc] 4eb9 0000 3b46            jsr        __norm
[00002dd2] 4fef 000c                 lea.l      12(a7),a7
[00002dd6] 3607                      move.w     d7,d3
[00002dd8] 3e0c                      move.w     a4,d7
[00002dda] 48c7                      ext.l      d7
[00002ddc] 2e87                      move.l     d7,(a7)
[00002dde] 3e0c                      move.w     a4,d7
[00002de0] 48c7                      ext.l      d7
[00002de2] 2f07                      move.l     d7,-(a7)
[00002de4] 5297                      addq.l     #1,(a7)
[00002de6] 486e ffd6                 pea.l      -42(a6)
[00002dea] 4eb9 0000 3450            jsr        __round
[00002df0] 508f                      addq.l     #8,a7
[00002df2] d647                      add.w      d7,d3
[00002df4] 7a00                      moveq.l    #0,d5
__dtoe_7:
[00002df6] 3e0c                      move.w     a4,d7
[00002df8] 48c7                      ext.l      d7
[00002dfa] ba87                      cmp.l      d7,d5
[00002dfc] 6c10                      bge.s      __dtoe_6
[00002dfe] baae 0014                 cmp.l      20(a6),d5
[00002e02] 6c0a                      bge.s      __dtoe_6
[00002e04] 1af6 58d6                 move.b     -42(a6,d5.l),(a5)+
[00002e08] 5285                      addq.l     #1,d5
[00002e0a] 5343                      subq.w     #1,d3
[00002e0c] 60e8                      bra.s      __dtoe_7
__dtoe_6:
[00002e0e] baae 0014                 cmp.l      20(a6),d5
[00002e12] 6c0a                      bge.s      __dtoe_8
[00002e14] 1afc 0030                 move.b     #$30,(a5)+
[00002e18] 5285                      addq.l     #1,d5
[00002e1a] 5343                      subq.w     #1,d3
[00002e1c] 60f0                      bra.s      __dtoe_6
__dtoe_8:
[00002e1e] 4aae 0018                 tst.l      24(a6)
[00002e22] 6f2c                      ble.s      __dtoe_9
[00002e24] 1afc 002e                 move.b     #$2E,(a5)+
[00002e28] 7800                      moveq.l    #0,d4
__dtoe_11:
[00002e2a] b8ae 0018                 cmp.l      24(a6),d4
[00002e2e] 6c12                      bge.s      __dtoe_10
[00002e30] 3e0c                      move.w     a4,d7
[00002e32] 48c7                      ext.l      d7
[00002e34] ba87                      cmp.l      d7,d5
[00002e36] 6c0a                      bge.s      __dtoe_10
[00002e38] 1af6 58d6                 move.b     -42(a6,d5.l),(a5)+
[00002e3c] 5285                      addq.l     #1,d5
[00002e3e] 5284                      addq.l     #1,d4
[00002e40] 60e8                      bra.s      __dtoe_11
__dtoe_10:
[00002e42] b8ae 0018                 cmp.l      24(a6),d4
[00002e46] 6c08                      bge.s      __dtoe_9
[00002e48] 1afc 0030                 move.b     #$30,(a5)+
[00002e4c] 5284                      addq.l     #1,d4
[00002e4e] 60f2                      bra.s      __dtoe_10
__dtoe_9:
[00002e50] 1afc 0065                 move.b     #$65,(a5)+
[00002e54] 4aae 000c                 tst.l      12(a6)
[00002e58] 6602                      bne.s      __dtoe_12
[00002e5a] 4243                      clr.w      d3
__dtoe_12:
[00002e5c] 4a43                      tst.w      d3
[00002e5e] 6c0e                      bge.s      __dtoe_13
[00002e60] 1afc 002d                 move.b     #$2D,(a5)+
[00002e64] 3e03                      move.w     d3,d7
[00002e66] 48c7                      ext.l      d7
[00002e68] 4487                      neg.l      d7
[00002e6a] 3607                      move.w     d7,d3
[00002e6c] 6004                      bra.s      __dtoe_14
__dtoe_13:
[00002e6e] 1afc 002b                 move.b     #$2B,(a5)+
__dtoe_14:
[00002e72] 0c43 0064                 cmpi.w     #$0064,d3
[00002e76] 6d22                      blt.s      __dtoe_15
[00002e78] 3e03                      move.w     d3,d7
[00002e7a] 48c7                      ext.l      d7
[00002e7c] 2e87                      move.l     d7,(a7)
[00002e7e] 4878 0064                 pea.l      ($00000064).w
[00002e82] 4eb9 0000 4a82            jsr        a~ldiv
[00002e88] 7e30                      moveq.l    #48,d7
[00002e8a] de97                      add.l      (a7),d7
[00002e8c] 1ac7                      move.b     d7,(a5)+
[00002e8e] 3003                      move.w     d3,d0
[00002e90] 48c0                      ext.l      d0
[00002e92] 81fc 0064                 divs.w     #$0064,d0
[00002e96] 4840                      swap       d0
[00002e98] 3600                      move.w     d0,d3
__dtoe_15:
[00002e9a] 3e03                      move.w     d3,d7
[00002e9c] 48c7                      ext.l      d7
[00002e9e] 2e87                      move.l     d7,(a7)
[00002ea0] 4878 000a                 pea.l      ($0000000A).w
[00002ea4] 4eb9 0000 4a82            jsr        a~ldiv
[00002eaa] 7e30                      moveq.l    #48,d7
[00002eac] de97                      add.l      (a7),d7
[00002eae] 1ac7                      move.b     d7,(a5)+
[00002eb0] 3e03                      move.w     d3,d7
[00002eb2] 48c7                      ext.l      d7
[00002eb4] 2e87                      move.l     d7,(a7)
[00002eb6] 4878 000a                 pea.l      ($0000000A).w
[00002eba] 4eb9 0000 4a70            jsr        a~lmod
[00002ec0] 7e30                      moveq.l    #48,d7
[00002ec2] de97                      add.l      (a7),d7
[00002ec4] 1ac7                      move.b     d7,(a5)+
[00002ec6] 2e0d                      move.l     a5,d7
[00002ec8] 9eae 0008                 sub.l      8(a6),d7
[00002ecc] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00002ed0] 4e5e                      unlk       a6
[00002ed2] 4e75                      rts

__dtof:
[00002ed4] 4e56 ffd6                 link       a6,#-42
[00002ed8] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[00002edc] 2a2e 0018                 move.l     24(a6),d5
[00002ee0] 286e 0008                 movea.l    8(a6),a4
[00002ee4] 0c79 0024 0002 0a46       cmpi.w     #$0024,_maxprec
[00002eec] 6c0a                      bge.s      __dtof_1
[00002eee] 3e39 0002 0a46            move.w     _maxprec,d7
[00002ef4] 48c7                      ext.l      d7
[00002ef6] 6002                      bra.s      __dtof_2
__dtof_1:
[00002ef8] 7e24                      moveq.l    #36,d7
__dtof_2:
[00002efa] 3607                      move.w     d7,d3
[00002efc] 4aae 000c                 tst.l      12(a6)
[00002f00] 6c1c                      bge.s      __dtof_3
[00002f02] 18fc 002d                 move.b     #$2D,(a4)+
[00002f06] 2c2e 000c                 move.l     12(a6),d6
[00002f0a] 2e2e 0010                 move.l     16(a6),d7
[00002f0e] 4a86                      tst.l      d6
[00002f10] 6704                      beq.s      __dtof_4
[00002f12] 0846 001f                 bchg       #31,d6
__dtof_4:
[00002f16] 2d46 000c                 move.l     d6,12(a6)
[00002f1a] 2d47 0010                 move.l     d7,16(a6)
__dtof_3:
[00002f1e] 4bee ffd6                 lea.l      -42(a6),a5
[00002f22] 3e03                      move.w     d3,d7
[00002f24] 48c7                      ext.l      d7
[00002f26] 2e87                      move.l     d7,(a7)
[00002f28] 5297                      addq.l     #1,(a7)
[00002f2a] 2f2e 0010                 move.l     16(a6),-(a7)
[00002f2e] 2f2e 000c                 move.l     12(a6),-(a7)
[00002f32] 2f0d                      move.l     a5,-(a7)
[00002f34] 4eb9 0000 3b46            jsr        __norm
[00002f3a] 4fef 000c                 lea.l      12(a7),a7
[00002f3e] 3807                      move.w     d7,d4
[00002f40] 3644                      movea.w    d4,a3
[00002f42] d7c5                      adda.l     d5,a3
[00002f44] 364b                      movea.w    a3,a3
[00002f46] 3e0b                      move.w     a3,d7
[00002f48] b647                      cmp.w      d7,d3
[00002f4a] 6c02                      bge.s      __dtof_5
[00002f4c] 3643                      movea.w    d3,a3
__dtof_5:
[00002f4e] 3e0b                      move.w     a3,d7
[00002f50] 48c7                      ext.l      d7
[00002f52] 2e87                      move.l     d7,(a7)
[00002f54] 3e03                      move.w     d3,d7
[00002f56] 48c7                      ext.l      d7
[00002f58] 2f07                      move.l     d7,-(a7)
[00002f5a] 5297                      addq.l     #1,(a7)
[00002f5c] 486e ffd6                 pea.l      -42(a6)
[00002f60] 4eb9 0000 3450            jsr        __round
[00002f66] 508f                      addq.l     #8,a7
[00002f68] d847                      add.w      d7,d4
[00002f6a] 2e2e 0014                 move.l     20(a6),d7
[00002f6e] 3c04                      move.w     d4,d6
[00002f70] 48c6                      ext.l      d6
[00002f72] be86                      cmp.l      d6,d7
[00002f74] 6c0e                      bge.s      __dtof_6
[00002f76] 3e04                      move.w     d4,d7
[00002f78] 48c7                      ext.l      d7
[00002f7a] 9eae 0014                 sub.l      20(a6),d7
[00002f7e] dbc7                      adda.l     d7,a5
[00002f80] 382e 0016                 move.w     22(a6),d4
__dtof_6:
[00002f84] 4a44                      tst.w      d4
[00002f86] 6e06                      bgt.s      __dtof_7
[00002f88] 18fc 0030                 move.b     #$30,(a4)+
[00002f8c] 6022                      bra.s      __dtof_8
__dtof_7:
[00002f8e] 4a44                      tst.w      d4
[00002f90] 6f1e                      ble.s      __dtof_8
[00002f92] 2e0d                      move.l     a5,d7
[00002f94] 43ee ffd6                 lea.l      -42(a6),a1
[00002f98] 9e89                      sub.l      a1,d7
[00002f9a] 3c03                      move.w     d3,d6
[00002f9c] 48c6                      ext.l      d6
[00002f9e] be86                      cmp.l      d6,d7
[00002fa0] 6c06                      bge.s      __dtof_9
[00002fa2] 7e00                      moveq.l    #0,d7
[00002fa4] 1e1d                      move.b     (a5)+,d7
[00002fa6] 6002                      bra.s      __dtof_10
__dtof_9:
[00002fa8] 7e30                      moveq.l    #48,d7
__dtof_10:
[00002faa] 18c7                      move.b     d7,(a4)+
[00002fac] 5344                      subq.w     #1,d4
[00002fae] 60de                      bra.s      __dtof_7
__dtof_8:
[00002fb0] 4a85                      tst.l      d5
[00002fb2] 6f04                      ble.s      __dtof_11
[00002fb4] 18fc 002e                 move.b     #$2E,(a4)+
__dtof_11:
[00002fb8] 4a44                      tst.w      d4
[00002fba] 6c0e                      bge.s      __dtof_12
[00002fbc] 4a85                      tst.l      d5
[00002fbe] 6f0a                      ble.s      __dtof_12
[00002fc0] 18fc 0030                 move.b     #$30,(a4)+
[00002fc4] 5244                      addq.w     #1,d4
[00002fc6] 5385                      subq.l     #1,d5
[00002fc8] 60ee                      bra.s      __dtof_11
__dtof_12:
[00002fca] 4a85                      tst.l      d5
[00002fcc] 6f1e                      ble.s      __dtof_13
[00002fce] 2e0d                      move.l     a5,d7
[00002fd0] 43ee ffd6                 lea.l      -42(a6),a1
[00002fd4] 9e89                      sub.l      a1,d7
[00002fd6] 3c03                      move.w     d3,d6
[00002fd8] 48c6                      ext.l      d6
[00002fda] be86                      cmp.l      d6,d7
[00002fdc] 6c06                      bge.s      __dtof_14
[00002fde] 7e00                      moveq.l    #0,d7
[00002fe0] 1e1d                      move.b     (a5)+,d7
[00002fe2] 6002                      bra.s      __dtof_15
__dtof_14:
[00002fe4] 7e30                      moveq.l    #48,d7
__dtof_15:
[00002fe6] 18c7                      move.b     d7,(a4)+
[00002fe8] 5385                      subq.l     #1,d5
[00002fea] 60de                      bra.s      __dtof_12
__dtof_13:
[00002fec] 2e0c                      move.l     a4,d7
[00002fee] 9eae 0008                 sub.l      8(a6),d7
[00002ff2] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00002ff6] 4e5e                      unlk       a6
[00002ff8] 4e75                      rts

__finit:
[00002ffa] 4e56 fffe                 link       a6,#-2
[00002ffe] 48e7 8c0c                 movem.l    d0/d4-d5/a4-a5,-(a7)
[00003002] 282e 0010                 move.l     16(a6),d4
[00003006] 287c 0002 0c76            movea.l    #$0002588A,a4
[0000300c] 2a6e 0008                 movea.l    8(a6),a5
[00003010] 2e0d                      move.l     a5,d7
[00003012] 662a                      bne.s      __finit_1
[00003014] 3a3c 0080                 move.w     #$0080,d5
[00003018] 4297                      clr.l      (a7)
[0000301a] 4878 001c                 pea.l      ($0000001C).w
[0000301e] 4eb9 0000 386e            jsr        __nalloc
[00003024] 588f                      addq.l     #4,a7
[00003026] 2a47                      movea.l    d7,a5
[00003028] 2e0d                      move.l     a5,d7
[0000302a] 6628                      bne.s      __finit_2
[0000302c] 2ebc 0002 0c6a            move.l     #$0002587E,(a7)
[00003032] 42a7                      clr.l      -(a7)
[00003034] 4eb9 0000 44d4            jsr        __raise
[0000303a] 588f                      addq.l     #4,a7
[0000303c] 6016                      bra.s      __finit_2
__finit_1:
[0000303e] 0804 000e                 btst       #14,d4
[00003042] 670e                      beq.s      __finit_3
[00003044] 7a00                      moveq.l    #0,d5
[00003046] 3a2d 0006                 move.w     6(a5),d5
[0000304a] 0285 0000 0080            andi.l     #$00000080,d5
[00003050] 6002                      bra.s      __finit_2
__finit_3:
[00003052] 4245                      clr.w      d5
__finit_2:
[00003054] 4295                      clr.l      (a5)
[00003056] 3b6e 000e 0004            move.w     14(a6),4(a5)
[0000305c] 42ad 0008                 clr.l      8(a5)
[00003060] 2b7c 0000 0200 000c       move.l     #$00000200,12(a5)
[00003068] 42ad 0014                 clr.l      20(a5)
[0000306c] 42ad 0018                 clr.l      24(a5)
[00003070] 3b45 0006                 move.w     d5,6(a5)
[00003074] 7e03                      moveq.l    #3,d7
[00003076] ce84                      and.l      d4,d7
[00003078] 0c87 0000 0001            cmpi.l     #$00000001,d7
[0000307e] 6706                      beq.s      __finit_4
[00003080] 08ed 0002 0007            bset       #2,7(a5)
__finit_4:
[00003086] 7e03                      moveq.l    #3,d7
[00003088] ce04                      and.b      d4,d7
[0000308a] 0287 0000 00ff            andi.l     #$000000FF,d7
[00003090] 6706                      beq.s      __finit_5
[00003092] 08ed 0003 0007            bset       #3,7(a5)
__finit_5:
[00003098] 0804 000d                 btst       #13,d4
[0000309c] 6606                      bne.s      __finit_6
[0000309e] 0804 000f                 btst       #15,d4
[000030a2] 6706                      beq.s      __finit_7
__finit_6:
[000030a4] 08ed 0000 0006            bset       #0,6(a5)
__finit_7:
[000030aa] 082d 0003 0007            btst       #3,7(a5)
[000030b0] 6724                      beq.s      __finit_8
[000030b2] 082d 0000 0006            btst       #0,6(a5)
[000030b8] 6608                      bne.s      __finit_9
[000030ba] 082d 0001 0006            btst       #1,6(a5)
[000030c0] 6614                      bne.s      __finit_8
__finit_9:
[000030c2] 2e8c                      move.l     a4,(a7)
[000030c4] 2f0d                      move.l     a5,-(a7)
[000030c6] 4eb9 0000 32cc            jsr        __onlist
[000030cc] 588f                      addq.l     #4,a7
[000030ce] 4a87                      tst.l      d7
[000030d0] 6604                      bne.s      __finit_8
[000030d2] 2a94                      move.l     (a4),(a5)
[000030d4] 288d                      move.l     a5,(a4)
__finit_8:
[000030d6] 2e0d                      move.l     a5,d7
[000030d8] 4cdf 3031                 movem.l    (a7)+,d0/d4-d5/a4-a5
[000030dc] 4e5e                      unlk       a6
[000030de] 4e75                      rts

__flush:
[000030e0] 7e01                      moveq.l    #1,d7
[000030e2] 4e75                      rts

__itob:
[000030e4] 4e56 fffa                 link       a6,#-6
[000030e8] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[000030ec] 282e 000c                 move.l     12(a6),d4
[000030f0] 287c 0002 0776            movea.l    #$0002538A,a4
[000030f6] 262e 0010                 move.l     16(a6),d3
[000030fa] 0c83 ffff ffdc            cmpi.l     #$FFFFFFDC,d3
[00003100] 6d08                      blt.s      __itob_1
[00003102] 0c83 0000 0024            cmpi.l     #$00000024,d3
[00003108] 6f16                      ble.s      __itob_2
__itob_1:
[0000310a] 2ebc 0002 079b            move.l     #$000253AF,(a7)
[00003110] 4eb9 0000 3cf4            jsr        __domain
[00003116] 7e00                      moveq.l    #0,d7
[00003118] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[0000311c] 4e5e                      unlk       a6
[0000311e] 4e75                      rts
__itob_2:
[00003120] 4a83                      tst.l      d3
[00003122] 6c06                      bge.s      __itob_3
[00003124] 2e03                      move.l     d3,d7
[00003126] 4487                      neg.l      d7
[00003128] 6002                      bra.s      __itob_4
__itob_3:
[0000312a] 2e03                      move.l     d3,d7
__itob_4:
[0000312c] 3a07                      move.w     d7,d5
[0000312e] 0c45 0001                 cmpi.w     #$0001,d5
[00003132] 6e02                      bgt.s      __itob_5
[00003134] 7a0a                      moveq.l    #10,d5
__itob_5:
[00003136] 2a6e 0008                 movea.l    8(a6),a5
[0000313a] 4a84                      tst.l      d4
[0000313c] 6c42                      bge.s      __itob_6
[0000313e] 4a83                      tst.l      d3
[00003140] 6e0a                      bgt.s      __itob_7
[00003142] 2e04                      move.l     d4,d7
[00003144] 4487                      neg.l      d7
[00003146] 2807                      move.l     d7,d4
[00003148] 1afc 002d                 move.b     #$2D,(a5)+
__itob_7:
[0000314c] 4a84                      tst.l      d4
[0000314e] 6c30                      bge.s      __itob_6
[00003150] 2644                      movea.l    d4,a3
[00003152] 3e05                      move.w     d5,d7
[00003154] 48c7                      ext.l      d7
[00003156] 2e87                      move.l     d7,(a7)
[00003158] 2f0b                      move.l     a3,-(a7)
[0000315a] 3e05                      move.w     d5,d7
[0000315c] 48c7                      ext.l      d7
[0000315e] 2f07                      move.l     d7,-(a7)
[00003160] 4eb9 0000 4ad2            jsr        a~uldiv
[00003166] 2f0d                      move.l     a5,-(a7)
[00003168] 4eba ff7a                 jsr        __itob(pc)
[0000316c] 508f                      addq.l     #8,a7
[0000316e] dbc7                      adda.l     d7,a5
[00003170] 2e8b                      move.l     a3,(a7)
[00003172] 3e05                      move.w     d5,d7
[00003174] 48c7                      ext.l      d7
[00003176] 2f07                      move.l     d7,-(a7)
[00003178] 4eb9 0000 4ab6            jsr        a~ulmod
[0000317e] 2817                      move.l     (a7),d4
__itob_6:
[00003180] 3e05                      move.w     d5,d7
[00003182] 48c7                      ext.l      d7
[00003184] be84                      cmp.l      d4,d7
[00003186] 6e2e                      bgt.s      __itob_8
[00003188] 3e05                      move.w     d5,d7
[0000318a] 48c7                      ext.l      d7
[0000318c] 2e87                      move.l     d7,(a7)
[0000318e] 2f04                      move.l     d4,-(a7)
[00003190] 3e05                      move.w     d5,d7
[00003192] 48c7                      ext.l      d7
[00003194] 2f07                      move.l     d7,-(a7)
[00003196] 4eb9 0000 4a82            jsr        a~ldiv
[0000319c] 2f0d                      move.l     a5,-(a7)
[0000319e] 4eba ff44                 jsr        __itob(pc)
[000031a2] 508f                      addq.l     #8,a7
[000031a4] dbc7                      adda.l     d7,a5
[000031a6] 2e84                      move.l     d4,(a7)
[000031a8] 3e05                      move.w     d5,d7
[000031aa] 48c7                      ext.l      d7
[000031ac] 2f07                      move.l     d7,-(a7)
[000031ae] 4eb9 0000 4a70            jsr        a~lmod
[000031b4] 2817                      move.l     (a7),d4
__itob_8:
[000031b6] 1ab4 4800                 move.b     0(a4,d4.l),(a5)
[000031ba] 2e0d                      move.l     a5,d7
[000031bc] 9eae 0008                 sub.l      8(a6),d7
[000031c0] 5287                      addq.l     #1,d7
[000031c2] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[000031c6] 4e5e                      unlk       a6
[000031c8] 4e75                      rts

__lseek:
[000031ca] 205f                      movea.l    (a7)+,a0
[000031cc] 7e28                      moveq.l    #40,d7
[000031ce] 4e41                      trap       #1
[000031d0] 6400 0008                 bcc.w      __lseek_1
[000031d4] 4ef9 0000 009a            jmp        seterr
__lseek_1:
[000031da] 4ed0                      jmp        (a0)

__ltob:
[000031dc] 4e56 fffa                 link       a6,#-6
[000031e0] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[000031e4] 282e 000c                 move.l     12(a6),d4
[000031e8] 286e 0010                 movea.l    16(a6),a4
[000031ec] 267c 0002 07ac            movea.l    #$000253C0,a3
[000031f2] 2e0c                      move.l     a4,d7
[000031f4] 0c87 ffff ffdc            cmpi.l     #$FFFFFFDC,d7
[000031fa] 6d0a                      blt.s      __ltob_1
[000031fc] 2e0c                      move.l     a4,d7
[000031fe] 0c87 0000 0024            cmpi.l     #$00000024,d7
[00003204] 6f16                      ble.s      __ltob_2
__ltob_1:
[00003206] 2ebc 0002 07d1            move.l     #$000253E5,(a7)
[0000320c] 4eb9 0000 3cf4            jsr        __domain
[00003212] 7e00                      moveq.l    #0,d7
[00003214] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00003218] 4e5e                      unlk       a6
[0000321a] 4e75                      rts
__ltob_2:
[0000321c] 2e0c                      move.l     a4,d7
[0000321e] 6c06                      bge.s      __ltob_3
[00003220] 2e0c                      move.l     a4,d7
[00003222] 4487                      neg.l      d7
[00003224] 6002                      bra.s      __ltob_4
__ltob_3:
[00003226] 2e0c                      move.l     a4,d7
__ltob_4:
[00003228] 3a07                      move.w     d7,d5
[0000322a] 0c45 0001                 cmpi.w     #$0001,d5
[0000322e] 6e02                      bgt.s      __ltob_5
[00003230] 7a0a                      moveq.l    #10,d5
__ltob_5:
[00003232] 2a6e 0008                 movea.l    8(a6),a5
[00003236] 4a84                      tst.l      d4
[00003238] 6c46                      bge.s      __ltob_6
[0000323a] 2e0c                      move.l     a4,d7
[0000323c] 6f04                      ble.s      __ltob_7
[0000323e] 2604                      move.l     d4,d3
[00003240] 6008                      bra.s      __ltob_8
__ltob_7:
[00003242] 2604                      move.l     d4,d3
[00003244] 4483                      neg.l      d3
[00003246] 1afc 002d                 move.b     #$2D,(a5)+
__ltob_8:
[0000324a] 2e03                      move.l     d3,d7
[0000324c] 6d04                      blt.s      __ltob_9
[0000324e] 2803                      move.l     d3,d4
[00003250] 602e                      bra.s      __ltob_6
__ltob_9:
[00003252] 3e05                      move.w     d5,d7
[00003254] 48c7                      ext.l      d7
[00003256] 2e87                      move.l     d7,(a7)
[00003258] 2f03                      move.l     d3,-(a7)
[0000325a] 3e05                      move.w     d5,d7
[0000325c] 48c7                      ext.l      d7
[0000325e] 2f07                      move.l     d7,-(a7)
[00003260] 4eb9 0000 4ad2            jsr        a~uldiv
[00003266] 2f0d                      move.l     a5,-(a7)
[00003268] 4eba ff72                 jsr        __ltob(pc)
[0000326c] 508f                      addq.l     #8,a7
[0000326e] dbc7                      adda.l     d7,a5
[00003270] 2e83                      move.l     d3,(a7)
[00003272] 3e05                      move.w     d5,d7
[00003274] 48c7                      ext.l      d7
[00003276] 2f07                      move.l     d7,-(a7)
[00003278] 4eb9 0000 4ab6            jsr        a~ulmod
[0000327e] 2817                      move.l     (a7),d4
__ltob_6:
[00003280] 3e05                      move.w     d5,d7
[00003282] 48c7                      ext.l      d7
[00003284] be84                      cmp.l      d4,d7
[00003286] 6e2e                      bgt.s      __ltob_10
[00003288] 3e05                      move.w     d5,d7
[0000328a] 48c7                      ext.l      d7
[0000328c] 2e87                      move.l     d7,(a7)
[0000328e] 2f04                      move.l     d4,-(a7)
[00003290] 3e05                      move.w     d5,d7
[00003292] 48c7                      ext.l      d7
[00003294] 2f07                      move.l     d7,-(a7)
[00003296] 4eb9 0000 4a82            jsr        a~ldiv
[0000329c] 2f0d                      move.l     a5,-(a7)
[0000329e] 4eba ff3c                 jsr        __ltob(pc)
[000032a2] 508f                      addq.l     #8,a7
[000032a4] dbc7                      adda.l     d7,a5
[000032a6] 2e84                      move.l     d4,(a7)
[000032a8] 3e05                      move.w     d5,d7
[000032aa] 48c7                      ext.l      d7
[000032ac] 2f07                      move.l     d7,-(a7)
[000032ae] 4eb9 0000 4a70            jsr        a~lmod
[000032b4] 2817                      move.l     (a7),d4
__ltob_10:
[000032b6] 2e04                      move.l     d4,d7
[000032b8] 1ab3 7800                 move.b     0(a3,d7.l),(a5)
[000032bc] 2e0d                      move.l     a5,d7
[000032be] 9eae 0008                 sub.l      8(a6),d7
[000032c2] 5287                      addq.l     #1,d7
[000032c4] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[000032c8] 4e5e                      unlk       a6
[000032ca] 4e75                      rts

__onlist:
[000032cc] 4e56 0000                 link       a6,#0
[000032d0] 48e7 001c                 movem.l    a3-a5,-(a7)
[000032d4] 266e 0008                 movea.l    8(a6),a3
[000032d8] 2a6e 000c                 movea.l    12(a6),a5
__onlist_4:
[000032dc] 2855                      movea.l    (a5),a4
[000032de] 2e0c                      move.l     a4,d7
[000032e0] 670c                      beq.s      __onlist_1
[000032e2] b9cb                      cmpa.l     a3,a4
[000032e4] 6604                      bne.s      __onlist_2
[000032e6] 2e0d                      move.l     a5,d7
[000032e8] 6006                      bra.s      __onlist_3
__onlist_2:
[000032ea] 2a4c                      movea.l    a4,a5
[000032ec] 60ee                      bra.s      __onlist_4
__onlist_1:
[000032ee] 7e00                      moveq.l    #0,d7
__onlist_3:
[000032f0] 4cdf 3800                 movem.l    (a7)+,a3-a5
[000032f4] 4e5e                      unlk       a6
[000032f6] 4e75                      rts

__open:
[000032f8] 205f                      movea.l    (a7)+,a0
[000032fa] 7e05                      moveq.l    #5,d7
[000032fc] 4e41                      trap       #1
[000032fe] 6400 0008                 bcc.w      __open_1
[00003302] 4ef9 0000 009a            jmp        seterr
__open_1:
[00003308] 4ed0                      jmp        (a0)

__parstype:
[0000330a] 4e56 fffe                 link       a6,#-2
[0000330e] 48e7 1c04                 movem.l    d3-d5/a5,-(a7)
[00003312] 2a6e 0008                 movea.l    8(a6),a5
[00003316] 7800                      moveq.l    #0,d4
__parstype_2:
[00003318] 0c84 0000 0003            cmpi.l     #$00000003,d4
[0000331e] 6c12                      bge.s      __parstype_1
[00003320] 2244                      movea.l    d4,a1
[00003322] d3fc 0002 07ee            adda.l     #$00025402,a1
[00003328] 1e11                      move.b     (a1),d7
[0000332a] be15                      cmp.b      (a5),d7
[0000332c] 6704                      beq.s      __parstype_1
[0000332e] 5284                      addq.l     #1,d4
[00003330] 60e6                      bra.s      __parstype_2
__parstype_1:
[00003332] 0c84 0000 0003            cmpi.l     #$00000003,d4
[00003338] 6604                      bne.s      __parstype_3
[0000333a] 7eff                      moveq.l    #-1,d7
[0000333c] 6066                      bra.s      __parstype_4
__parstype_3:
[0000333e] 528d                      addq.l     #1,a5
[00003340] 0c15 002b                 cmpi.b     #$2B,(a5)
[00003344] 6604                      bne.s      __parstype_5
[00003346] 7e01                      moveq.l    #1,d7
[00003348] 6002                      bra.s      __parstype_6
__parstype_5:
[0000334a] 7e00                      moveq.l    #0,d7
__parstype_6:
[0000334c] 3607                      move.w     d7,d3
[0000334e] 4a43                      tst.w      d3
[00003350] 6702                      beq.s      __parstype_7
[00003352] 528d                      addq.l     #1,a5
__parstype_7:
[00003354] 7e06                      moveq.l    #6,d7
[00003356] cec3                      mulu.w     d3,d7
[00003358] 2247                      movea.l    d7,a1
[0000335a] d3fc 0002 07e2            adda.l     #$000253F6,a1
[00003360] 2e04                      move.l     d4,d7
[00003362] de87                      add.l      d7,d7
[00003364] 7a00                      moveq.l    #0,d5
[00003366] 3a31 7800                 move.w     0(a1,d7.l),d5
[0000336a] 0c15 0062                 cmpi.b     #$62,(a5)
[0000336e] 6606                      bne.s      __parstype_8
[00003370] 08c5 000f                 bset       #15,d5
[00003374] 528d                      addq.l     #1,a5
__parstype_8:
[00003376] 227c 0002 08c1            movea.l    #$000254D5,a1
[0000337c] 7e00                      moveq.l    #0,d7
[0000337e] 1e15                      move.b     (a5),d7
[00003380] 1e31 7800                 move.b     0(a1,d7.l),d7
[00003384] 0207 0088                 andi.b     #$88,d7
[00003388] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000338e] 6704                      beq.s      __parstype_9
[00003390] 528d                      addq.l     #1,a5
[00003392] 60e2                      bra.s      __parstype_8
__parstype_9:
[00003394] 4a15                      tst.b      (a5)
[00003396] 670a                      beq.s      __parstype_10
[00003398] 0c15 002c                 cmpi.b     #$2C,(a5)
[0000339c] 6704                      beq.s      __parstype_10
[0000339e] 7eff                      moveq.l    #-1,d7
[000033a0] 6002                      bra.s      __parstype_4
__parstype_10:
[000033a2] 2e05                      move.l     d5,d7
__parstype_4:
[000033a4] 4cdf 2038                 movem.l    (a7)+,d3-d5/a5
[000033a8] 4e5e                      unlk       a6
[000033aa] 4e75                      rts

__putstr:
[000033ac] 4e56 0000                 link       a6,#0
[000033b0] 48e7 8004                 movem.l    d0/a5,-(a7)
[000033b4] 4bee 000c                 lea.l      12(a6),a5
__putstr_2:
[000033b8] 4a95                      tst.l      (a5)
[000033ba] 671c                      beq.s      __putstr_1
[000033bc] 2e95                      move.l     (a5),(a7)
[000033be] 4eb9 0000 4272            jsr        __lenstr
[000033c4] 2e87                      move.l     d7,(a7)
[000033c6] 2f15                      move.l     (a5),-(a7)
[000033c8] 2f2e 0008                 move.l     8(a6),-(a7)
[000033cc] 4eb9 0000 3d34            jsr        __fwrite
[000033d2] 508f                      addq.l     #8,a7
[000033d4] 588d                      addq.l     #4,a5
[000033d6] 60e0                      bra.s      __putstr_2
__putstr_1:
[000033d8] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000033dc] 4e5e                      unlk       a6
[000033de] 4e75                      rts

__read:
[000033e0] 205f                      movea.l    (a7)+,a0
[000033e2] 7e03                      moveq.l    #3,d7
[000033e4] 4e41                      trap       #1
[000033e6] 6400 0008                 bcc.w      __read_1
[000033ea] 4ef9 0000 009a            jmp        seterr
__read_1:
[000033f0] 4ed0                      jmp        (a0)

__remove:
[000033f2] 4e56 0000                 link       a6,#0
[000033f6] 48e7 8400                 movem.l    d0/d5,-(a7)
[000033fa] 2eae 0008                 move.l     8(a6),(a7)
[000033fe] 4eb9 0000 3d66            jsr        __getmod
[00003404] 2a07                      move.l     d7,d5
[00003406] 6610                      bne.s      __remove_1
[00003408] 7002                      moveq.l    #2,d0
[0000340a] 23c0 0002 0064            move.l     d0,_errno
[00003410] 2e3c ffff ffff            move.l     #$FFFFFFFF,d7
[00003416] 6024                      bra.s      __remove_2
__remove_1:
[00003418] 3e05                      move.w     d5,d7
[0000341a] 4847                      swap       d7
[0000341c] 4247                      clr.w      d7
[0000341e] 4847                      swap       d7
[00003420] 0287 0000 6000            andi.l     #$00006000,d7
[00003426] 0c87 0000 4000            cmpi.l     #$00004000,d7
[0000342c] 6616                      bne.s      __remove_3
[0000342e] 7015                      moveq.l    #21,d0
[00003430] 23c0 0002 0064            move.l     d0,_errno
[00003436] 2e3c ffff ffff            move.l     #$FFFFFFFF,d7
__remove_2:
[0000343c] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00003440] 4e5e                      unlk       a6
[00003442] 4e75                      rts
__remove_3:
[00003444] 2eae 0008                 move.l     8(a6),(a7)
[00003448] 4eb9 0000 35d4            jsr        __unlink
[0000344e] 60ec                      bra.s      __remove_2

__round:
[00003450] 4e56 0000                 link       a6,#0
[00003454] 48e7 0c04                 movem.l    d4-d5/a5,-(a7)
[00003458] 282e 0010                 move.l     16(a6),d4
[0000345c] 2a6e 0008                 movea.l    8(a6),a5
[00003460] 4a84                      tst.l      d4
[00003462] 6d4a                      blt.s      __round_1
[00003464] 2e2e 000c                 move.l     12(a6),d7
[00003468] be84                      cmp.l      d4,d7
[0000346a] 6f42                      ble.s      __round_1
[0000346c] 0c35 0035 4800            cmpi.b     #$35,0(a5,d4.l)
[00003472] 653a                      bcs.s      __round_1
[00003474] 2a04                      move.l     d4,d5
[00003476] 5385                      subq.l     #1,d5
__round_4:
[00003478] 4a85                      tst.l      d5
[0000347a] 6d16                      blt.s      __round_2
[0000347c] 0c35 0039 5800            cmpi.b     #$39,0(a5,d5.l)
[00003482] 660a                      bne.s      __round_3
[00003484] 1bbc 0030 5800            move.b     #$30,0(a5,d5.l)
[0000348a] 5385                      subq.l     #1,d5
[0000348c] 60ea                      bra.s      __round_4
__round_3:
[0000348e] 5235 5800                 addq.b     #1,0(a5,d5.l)
__round_2:
[00003492] 4a85                      tst.l      d5
[00003494] 6c18                      bge.s      __round_1
[00003496] 1abc 0031                 move.b     #$31,(a5)
[0000349a] 2a04                      move.l     d4,d5
__round_6:
[0000349c] 4a85                      tst.l      d5
[0000349e] 6f0a                      ble.s      __round_5
[000034a0] 1bbc 0030 5800            move.b     #$30,0(a5,d5.l)
[000034a6] 5385                      subq.l     #1,d5
[000034a8] 60f2                      bra.s      __round_6
__round_5:
[000034aa] 7e01                      moveq.l    #1,d7
[000034ac] 6002                      bra.s      __round_7
__round_1:
[000034ae] 7e00                      moveq.l    #0,d7
__round_7:
[000034b0] 4cdf 2030                 movem.l    (a7)+,d4-d5/a5
[000034b4] 4e5e                      unlk       a6
[000034b6] 4e75                      rts

__scnbuf:
[000034b8] 7e00                      moveq.l    #0,d7
[000034ba] 202f 0008                 move.l     8(a7),d0
[000034be] 6722                      beq.s      __scnbuf_1
[000034c0] 2200                      move.l     d0,d1
[000034c2] 4840                      swap       d0
[000034c4] 5341                      subq.w     #1,d1
[000034c6] 206f 0004                 movea.l    4(a7),a0
[000034ca] 1e2f 000f                 move.b     15(a7),d7
__scnbuf_2:
[000034ce] be18                      cmp.b      (a0)+,d7
[000034d0] 57c9 fffc                 dbeq       d1,__scnbuf_2
[000034d4] 57c8 fff8                 dbeq       d0,__scnbuf_2
[000034d8] 6602                      bne.s      __scnbuf_3
[000034da] 5388                      subq.l     #1,a0
__scnbuf_3:
[000034dc] 2e08                      move.l     a0,d7
[000034de] 9eaf 0004                 sub.l      4(a7),d7
__scnbuf_1:
[000034e2] 4e75                      rts

__stob:
[000034e4] 4e56 fffa                 link       a6,#-6
[000034e8] 48e7 9c0c                 movem.l    d0/d3-d5/a4-a5,-(a7)
[000034ec] 287c 0002 0802            movea.l    #$00025416,a4
[000034f2] 262e 0010                 move.l     16(a6),d3
[000034f6] 0c83 ffff ffdc            cmpi.l     #$FFFFFFDC,d3
[000034fc] 6d08                      blt.s      __stob_1
[000034fe] 0c83 0000 0024            cmpi.l     #$00000024,d3
[00003504] 6f16                      ble.s      __stob_2
__stob_1:
[00003506] 2ebc 0002 0827            move.l     #$0002543B,(a7)
[0000350c] 4eb9 0000 3cf4            jsr        __domain
[00003512] 7e00                      moveq.l    #0,d7
[00003514] 4cdf 3039                 movem.l    (a7)+,d0/d3-d5/a4-a5
[00003518] 4e5e                      unlk       a6
[0000351a] 4e75                      rts
__stob_2:
[0000351c] 4a83                      tst.l      d3
[0000351e] 6c06                      bge.s      __stob_3
[00003520] 2e03                      move.l     d3,d7
[00003522] 4487                      neg.l      d7
[00003524] 6002                      bra.s      __stob_4
__stob_3:
[00003526] 2e03                      move.l     d3,d7
__stob_4:
[00003528] 3807                      move.w     d7,d4
[0000352a] 0c44 0001                 cmpi.w     #$0001,d4
[0000352e] 6e02                      bgt.s      __stob_5
[00003530] 780a                      moveq.l    #10,d4
__stob_5:
[00003532] 2a6e 0008                 movea.l    8(a6),a5
[00003536] 3a2e 000e                 move.w     14(a6),d5
[0000353a] 4a45                      tst.w      d5
[0000353c] 6c52                      bge.s      __stob_6
[0000353e] 4a83                      tst.l      d3
[00003540] 6e0c                      bgt.s      __stob_7
[00003542] 3e05                      move.w     d5,d7
[00003544] 48c7                      ext.l      d7
[00003546] 4487                      neg.l      d7
[00003548] 3a07                      move.w     d7,d5
[0000354a] 1afc 002d                 move.b     #$2D,(a5)+
__stob_7:
[0000354e] 4a45                      tst.w      d5
[00003550] 6c3e                      bge.s      __stob_6
[00003552] 3d45 fffa                 move.w     d5,-6(a6)
[00003556] 3e04                      move.w     d4,d7
[00003558] 48c7                      ext.l      d7
[0000355a] 2e87                      move.l     d7,(a7)
[0000355c] 7e00                      moveq.l    #0,d7
[0000355e] 3e2e fffa                 move.w     -6(a6),d7
[00003562] 2f07                      move.l     d7,-(a7)
[00003564] 3e04                      move.w     d4,d7
[00003566] 48c7                      ext.l      d7
[00003568] 2f07                      move.l     d7,-(a7)
[0000356a] 4eb9 0000 4a82            jsr        a~ldiv
[00003570] 2f0d                      move.l     a5,-(a7)
[00003572] 4eba ff70                 jsr        __stob(pc)
[00003576] 508f                      addq.l     #8,a7
[00003578] dbc7                      adda.l     d7,a5
[0000357a] 7e00                      moveq.l    #0,d7
[0000357c] 3e2e fffa                 move.w     -6(a6),d7
[00003580] 2e87                      move.l     d7,(a7)
[00003582] 3e04                      move.w     d4,d7
[00003584] 48c7                      ext.l      d7
[00003586] 2f07                      move.l     d7,-(a7)
[00003588] 4eb9 0000 4a70            jsr        a~lmod
[0000358e] 2a17                      move.l     (a7),d5
__stob_6:
[00003590] b845                      cmp.w      d5,d4
[00003592] 6e2c                      bgt.s      __stob_8
[00003594] 3e04                      move.w     d4,d7
[00003596] 48c7                      ext.l      d7
[00003598] 2e87                      move.l     d7,(a7)
[0000359a] 3e05                      move.w     d5,d7
[0000359c] 48c7                      ext.l      d7
[0000359e] 2f07                      move.l     d7,-(a7)
[000035a0] 3e04                      move.w     d4,d7
[000035a2] 48c7                      ext.l      d7
[000035a4] 2f07                      move.l     d7,-(a7)
[000035a6] 4eb9 0000 4a82            jsr        a~ldiv
[000035ac] 2f0d                      move.l     a5,-(a7)
[000035ae] 4eba ff34                 jsr        __stob(pc)
[000035b2] 508f                      addq.l     #8,a7
[000035b4] dbc7                      adda.l     d7,a5
[000035b6] 3005                      move.w     d5,d0
[000035b8] 48c0                      ext.l      d0
[000035ba] 81c4                      divs.w     d4,d0
[000035bc] 4840                      swap       d0
[000035be] 3a00                      move.w     d0,d5
__stob_8:
[000035c0] 1ab4 5000                 move.b     0(a4,d5.w),(a5)
[000035c4] 2e0d                      move.l     a5,d7
[000035c6] 9eae 0008                 sub.l      8(a6),d7
[000035ca] 5287                      addq.l     #1,d7
[000035cc] 4cdf 3039                 movem.l    (a7)+,d0/d3-d5/a4-a5
[000035d0] 4e5e                      unlk       a6
[000035d2] 4e75                      rts

__unlink:
[000035d4] 205f                      movea.l    (a7)+,a0
[000035d6] 7e0a                      moveq.l    #10,d7
[000035d8] 4e41                      trap       #1
[000035da] 6400 0008                 bcc.w      __unlink_1
[000035de] 4ef9 0000 009a            jmp        seterr
__unlink_1:
[000035e4] 4ed0                      jmp        (a0)
[000035e6] 4e56 fffc                 link       a6,#-4
[000035ea] 48e7 001c                 movem.l    a3-a5,-(a7)
[000035ee] 2a6e 0008                 movea.l    8(a6),a5
[000035f2] 2e15                      move.l     (a5),d7
[000035f4] 43f5 7808                 lea.l      8(a5,d7.l),a1
[000035f8] 2a49                      movea.l    a1,a5
[000035fa] 267c 0002 0c5e            movea.l    #$00025872,a3
__unlink_5:
[00003600] 2853                      movea.l    (a3),a4
[00003602] 2e0c                      move.l     a4,d7
[00003604] 670e                      beq.s      __unlink_2
[00003606] bbcc                      cmpa.l     a4,a5
[00003608] 6604                      bne.s      __unlink_3
[0000360a] 2e0b                      move.l     a3,d7
[0000360c] 6008                      bra.s      __unlink_4
__unlink_3:
[0000360e] 47ec 0004                 lea.l      4(a4),a3
[00003612] 60ec                      bra.s      __unlink_5
__unlink_2:
[00003614] 7e00                      moveq.l    #0,d7
__unlink_4:
[00003616] 4cdf 3800                 movem.l    (a7)+,a3-a5
[0000361a] 4e5e                      unlk       a6
[0000361c] 4e75                      rts

x361e:
[0000361e] 4e56 fffc                 link       a6,#-4
[00003622] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00003626] 2a2e 000c                 move.l     12(a6),d5
[0000362a] 287c 0002 0c5a            movea.l    #$0002586E,a4
[00003630] 0c85 0000 0008            cmpi.l     #$00000008,d5
[00003636] 6542                      bcs.s      x361e_1
[00003638] dbb9 0002 0c4e            add.l      d5,$00025862
[0000363e] 2a6e 0008                 movea.l    8(a6),a5
[00003642] 2245                      movea.l    d5,a1
[00003644] 5189                      subq.l     #8,a1
[00003646] 2a89                      move.l     a1,(a5)
[00003648] 4a94                      tst.l      (a4)
[0000364a] 6704                      beq.s      x361e_2
[0000364c] bbd4                      cmpa.l     (a4),a5
[0000364e] 6402                      bcc.s      x361e_3
x361e_2:
[00003650] 288d                      move.l     a5,(a4)
x361e_3:
[00003652] 43f5 5800                 lea.l      0(a5,d5.l),a1
[00003656] 2e39 0002 0c62            move.l     $00025876,d7
[0000365c] be89                      cmp.l      a1,d7
[0000365e] 640a                      bcc.s      x361e_4
[00003660] 43f5 5800                 lea.l      0(a5,d5.l),a1
[00003664] 23c9 0002 0c62            move.l     a1,$00025876
x361e_4:
[0000366a] 4297                      clr.l      (a7)
[0000366c] 43ed 0004                 lea.l      4(a5),a1
[00003670] 2f09                      move.l     a1,-(a7)
[00003672] 4eb9 0000 37ac            jsr        __free
[00003678] 588f                      addq.l     #4,a7
x361e_1:
[0000367a] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000367e] 4e5e                      unlk       a6
[00003680] 4e75                      rts

x3682:
[00003682] 4e56 fffc                 link       a6,#-4
[00003686] 48e7 001c                 movem.l    a3-a5,-(a7)
[0000368a] 226e 0008                 movea.l    8(a6),a1
[0000368e] 49e9 fff8                 lea.l      -8(a1),a4
[00003692] 267c 0002 0c5e            movea.l    #$00025872,a3
x3682_4:
[00003698] 2a53                      movea.l    (a3),a5
[0000369a] 2e0d                      move.l     a5,d7
[0000369c] 6714                      beq.s      x3682_1
[0000369e] 2e15                      move.l     (a5),d7
[000036a0] 43f5 7800                 lea.l      0(a5,d7.l),a1
[000036a4] b3cc                      cmpa.l     a4,a1
[000036a6] 6604                      bne.s      x3682_2
[000036a8] 2e0b                      move.l     a3,d7
[000036aa] 6008                      bra.s      x3682_3
x3682_2:
[000036ac] 47ed 0004                 lea.l      4(a5),a3
[000036b0] 60e6                      bra.s      x3682_4
x3682_1:
[000036b2] 7e00                      moveq.l    #0,d7
x3682_3:
[000036b4] 4cdf 3800                 movem.l    (a7)+,a3-a5
[000036b8] 4e5e                      unlk       a6
[000036ba] 4e75                      rts

x36bc:
[000036bc] 4e56 0000                 link       a6,#0
[000036c0] 48e7 040c                 movem.l    d5/a4-a5,-(a7)
[000036c4] 2a6e 0008                 movea.l    8(a6),a5
[000036c8] 2a2e 000c                 move.l     12(a6),d5
[000036cc] 43f5 5800                 lea.l      0(a5,d5.l),a1
[000036d0] 2849                      movea.l    a1,a4
[000036d2] 2e15                      move.l     (a5),d7
[000036d4] 9e85                      sub.l      d5,d7
[000036d6] 2887                      move.l     d7,(a4)
[000036d8] 296d 0004 0004            move.l     4(a5),4(a4)
[000036de] 2245                      movea.l    d5,a1
[000036e0] 5189                      subq.l     #8,a1
[000036e2] 2a89                      move.l     a1,(a5)
[000036e4] 2e0c                      move.l     a4,d7
[000036e6] 4cdf 3020                 movem.l    (a7)+,d5/a4-a5
[000036ea] 4e5e                      unlk       a6
[000036ec] 4e75                      rts

x36ee:
[000036ee] 4e56 0000                 link       a6,#0
[000036f2] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[000036f6] 2a6e 0008                 movea.l    8(a6),a5
[000036fa] 286e 000c                 movea.l    12(a6),a4
[000036fe] 2e15                      move.l     (a5),d7
[00003700] 43f5 7808                 lea.l      8(a5,d7.l),a1
[00003704] 2649                      movea.l    a1,a3
[00003706] b9cb                      cmpa.l     a3,a4
[00003708] 6424                      bcc.s      x36ee_1
[0000370a] 2e14                      move.l     (a4),d7
[0000370c] 43f4 7808                 lea.l      8(a4,d7.l),a1
[00003710] bbc9                      cmpa.l     a1,a5
[00003712] 641a                      bcc.s      x36ee_1
[00003714] 23fc 0002 0838 0002 0c6a  move.l     #$0002544C,$0002587E
[0000371e] 2ebc 0002 0c6a            move.l     #$0002587E,(a7)
[00003724] 42a7                      clr.l      -(a7)
[00003726] 4eb9 0000 44d4            jsr        __raise
[0000372c] 588f                      addq.l     #4,a7
x36ee_1:
[0000372e] b7cc                      cmpa.l     a4,a3
[00003730] 660e                      bne.s      x36ee_2
[00003732] 2e14                      move.l     (a4),d7
[00003734] 5087                      addq.l     #8,d7
[00003736] df95                      add.l      d7,(a5)
[00003738] 2b6c 0004 0004            move.l     4(a4),4(a5)
[0000373e] 6004                      bra.s      x36ee_3
x36ee_2:
[00003740] 2b4c 0004                 move.l     a4,4(a5)
x36ee_3:
[00003744] 7e01                      moveq.l    #1,d7
[00003746] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000374a] 4e5e                      unlk       a6
[0000374c] 4e75                      rts

__alloc:
[0000374e] 4e56 0000                 link       a6,#0
[00003752] 48e7 8004                 movem.l    d0/a5,-(a7)
[00003756] 2eae 000c                 move.l     12(a6),(a7)
[0000375a] 2f2e 0008                 move.l     8(a6),-(a7)
[0000375e] 4eb9 0000 386e            jsr        __nalloc
[00003764] 588f                      addq.l     #4,a7
[00003766] 2a47                      movea.l    d7,a5
[00003768] 2e0d                      move.l     a5,d7
[0000376a] 6704                      beq.s      __alloc_1
[0000376c] 2e0d                      move.l     a5,d7
[0000376e] 6010                      bra.s      __alloc_2
__alloc_1:
[00003770] 2ebc 0002 0c6a            move.l     #$0002587E,(a7)
[00003776] 42a7                      clr.l      -(a7)
[00003778] 4eb9 0000 44d4            jsr        __raise
[0000377e] 588f                      addq.l     #4,a7
__alloc_2:
[00003780] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00003784] 4e5e                      unlk       a6
[00003786] 4e75                      rts

__balheap:
[00003788] 4e56 fffc                 link       a6,#-4
[0000378c] 48e7 8004                 movem.l    d0/a5,-(a7)
[00003790] 4297                      clr.l      (a7)
[00003792] 4eb9 0000 380e            jsr        __lstheap
[00003798] 2a47                      movea.l    d7,a5
[0000379a] 2e15                      move.l     (a5),d7
[0000379c] 9ead 0004                 sub.l      4(a5),d7
[000037a0] 9ead 0008                 sub.l      8(a5),d7
[000037a4] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000037a8] 4e5e                      unlk       a6
[000037aa] 4e75                      rts

__free:
[000037ac] 4e56 0000                 link       a6,#0
[000037b0] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[000037b4] 286e 0008                 movea.l    8(a6),a4
[000037b8] 266e 000c                 movea.l    12(a6),a3
[000037bc] 2e0c                      move.l     a4,d7
[000037be] 6604                      bne.s      __free_1
[000037c0] 2e0b                      move.l     a3,d7
[000037c2] 6034                      bra.s      __free_2
__free_1:
[000037c4] 43ec fffc                 lea.l      -4(a4),a1
[000037c8] 2a49                      movea.l    a1,a5
[000037ca] bbf9 0002 0c5a            cmpa.l     $0002586E,a5
[000037d0] 650a                      bcs.s      __free_3
[000037d2] 2e39 0002 0c62            move.l     $00025876,d7
[000037d8] be8d                      cmp.l      a5,d7
[000037da] 6224                      bhi.s      __free_4
__free_3:
[000037dc] 23fc 0002 0846 0002 0c6a  move.l     #$0002545A,$0002587E
[000037e6] 2ebc 0002 0c6a            move.l     #$0002587E,(a7)
[000037ec] 42a7                      clr.l      -(a7)
[000037ee] 4eb9 0000 44d4            jsr        __raise
[000037f4] 588f                      addq.l     #4,a7
__free_5:
[000037f6] 2e0b                      move.l     a3,d7
__free_2:
[000037f8] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000037fc] 4e5e                      unlk       a6
[000037fe] 4e75                      rts
__free_4:
[00003800] 2e8b                      move.l     a3,(a7)
[00003802] 2f0c                      move.l     a4,-(a7)
[00003804] 4eb9 0000 3956            jsr        __nfree
[0000380a] 588f                      addq.l     #4,a7
[0000380c] 60e8                      bra.s      __free_5

__lstheap:
[0000380e] 4e56 0000                 link       a6,#0
[00003812] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00003816] 42b9 0002 0c52            clr.l      $00025866
[0000381c] 23f9 0002 0c52 0002 0c56  move.l     $00025866,$0002586A
[00003826] 287c 0002 0c5e            movea.l    #$00025872,a4
__lstheap_3:
[0000382c] 2a54                      movea.l    (a4),a5
[0000382e] 2e0d                      move.l     a5,d7
[00003830] 672e                      beq.s      __lstheap_1
[00003832] 2e15                      move.l     (a5),d7
[00003834] 5887                      addq.l     #4,d7
[00003836] dfb9 0002 0c52            add.l      d7,$00025866
[0000383c] 58b9 0002 0c56            addq.l     #4,$0002586A
[00003842] 4aae 0008                 tst.l      8(a6)
[00003846] 6712                      beq.s      __lstheap_2
[00003848] 2ead 0004                 move.l     4(a5),(a7)
[0000384c] 2f15                      move.l     (a5),-(a7)
[0000384e] 5897                      addq.l     #4,(a7)
[00003850] 2f0d                      move.l     a5,-(a7)
[00003852] 226e 0008                 movea.l    8(a6),a1
[00003856] 4e91                      jsr        (a1)
[00003858] 508f                      addq.l     #8,a7
__lstheap_2:
[0000385a] 49ed 0004                 lea.l      4(a5),a4
[0000385e] 60cc                      bra.s      __lstheap_3
__lstheap_1:
[00003860] 2e3c 0002 0c4e            move.l     #$00025862,d7
[00003866] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[0000386a] 4e5e                      unlk       a6
[0000386c] 4e75                      rts

__nalloc:
[0000386e] 4e56 fffc                 link       a6,#-4
[00003872] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[00003876] 263c 0002 0c4a            move.l     #$0002585E,d3
[0000387c] 2a2e 0008                 move.l     8(a6),d5
[00003880] 0c85 0000 0004            cmpi.l     #$00000004,d5
[00003886] 6404                      bcc.s      __nalloc_1
[00003888] 7e04                      moveq.l    #4,d7
[0000388a] 6002                      bra.s      __nalloc_2
__nalloc_1:
[0000388c] 2e05                      move.l     d5,d7
__nalloc_2:
[0000388e] 2807                      move.l     d7,d4
[00003890] 5684                      addq.l     #3,d4
[00003892] 7efc                      moveq.l    #-4,d7
[00003894] ce84                      and.l      d4,d7
[00003896] 2807                      move.l     d7,d4
[00003898] 5884                      addq.l     #4,d4
[0000389a] b885                      cmp.l      d5,d4
[0000389c] 6204                      bhi.s      __nalloc_3
[0000389e] 7e00                      moveq.l    #0,d7
[000038a0] 6040                      bra.s      __nalloc_4
__nalloc_3:
[000038a2] 2a04                      move.l     d4,d5
__nalloc_16:
[000038a4] 2a7c 0002 0c5e            movea.l    #$00025872,a5
__nalloc_9:
[000038aa] 2855                      movea.l    (a5),a4
[000038ac] 2e0c                      move.l     a4,d7
[000038ae] 673a                      beq.s      __nalloc_5
[000038b0] 2e14                      move.l     (a4),d7
[000038b2] 5087                      addq.l     #8,d7
[000038b4] ba87                      cmp.l      d7,d5
[000038b6] 620c                      bhi.s      __nalloc_6
[000038b8] 2e14                      move.l     (a4),d7
[000038ba] be85                      cmp.l      d5,d7
[000038bc] 640c                      bcc.s      __nalloc_7
[000038be] 2aac 0004                 move.l     4(a4),(a5)
[000038c2] 6014                      bra.s      __nalloc_8
__nalloc_6:
[000038c4] 4bec 0004                 lea.l      4(a4),a5
[000038c8] 60e0                      bra.s      __nalloc_9
__nalloc_7:
[000038ca] 2e05                      move.l     d5,d7
[000038cc] 2e87                      move.l     d7,(a7)
[000038ce] 2f0c                      move.l     a4,-(a7)
[000038d0] 4eba fdea                 jsr        $000036BC(pc)
[000038d4] 588f                      addq.l     #4,a7
[000038d6] 2a87                      move.l     d7,(a5)
__nalloc_8:
[000038d8] 296e 000c 0004            move.l     12(a6),4(a4)
[000038de] 2e0c                      move.l     a4,d7
[000038e0] 5887                      addq.l     #4,d7
__nalloc_4:
[000038e2] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[000038e6] 4e5e                      unlk       a6
[000038e8] 4e75                      rts
__nalloc_5:
[000038ea] 2243                      movea.l    d3,a1
[000038ec] 4a91                      tst.l      (a1)
[000038ee] 660a                      bne.s      __nalloc_10
[000038f0] 2243                      movea.l    d3,a1
[000038f2] 22bc 0000 0200            move.l     #$00000200,(a1)
[000038f8] 6012                      bra.s      __nalloc_11
__nalloc_10:
[000038fa] 2243                      movea.l    d3,a1
[000038fc] 0c91 0000 0200            cmpi.l     #$00000200,(a1)
[00003902] 6708                      beq.s      __nalloc_11
[00003904] 2243                      movea.l    d3,a1
[00003906] 2e11                      move.l     (a1),d7
[00003908] e28f                      lsr.l      #1,d7
[0000390a] 2287                      move.l     d7,(a1)
__nalloc_11:
[0000390c] 97cb                      suba.l     a3,a3
__nalloc_13:
[0000390e] 2243                      movea.l    d3,a1
[00003910] ba91                      cmp.l      (a1),d5
[00003912] 621c                      bhi.s      __nalloc_12
[00003914] 2243                      movea.l    d3,a1
[00003916] 2811                      move.l     (a1),d4
[00003918] 2e84                      move.l     d4,(a7)
[0000391a] 4eb9 0000 3d8c            jsr        __sbreak
[00003920] 2647                      movea.l    d7,a3
[00003922] 2e0b                      move.l     a3,d7
[00003924] 660a                      bne.s      __nalloc_12
[00003926] 2243                      movea.l    d3,a1
[00003928] 2e11                      move.l     (a1),d7
[0000392a] e28f                      lsr.l      #1,d7
[0000392c] 2287                      move.l     d7,(a1)
[0000392e] 60de                      bra.s      __nalloc_13
__nalloc_12:
[00003930] 2e0b                      move.l     a3,d7
[00003932] 660c                      bne.s      __nalloc_14
[00003934] 2805                      move.l     d5,d4
[00003936] 2e84                      move.l     d4,(a7)
[00003938] 4eb9 0000 3d8c            jsr        __sbreak
[0000393e] 2647                      movea.l    d7,a3
__nalloc_14:
[00003940] 2e0b                      move.l     a3,d7
[00003942] 6604                      bne.s      __nalloc_15
[00003944] 7e00                      moveq.l    #0,d7
[00003946] 609a                      bra.s      __nalloc_4
__nalloc_15:
[00003948] 2e84                      move.l     d4,(a7)
[0000394a] 2f0b                      move.l     a3,-(a7)
[0000394c] 4eba fcd0                 jsr        $0000361E(pc)
[00003950] 588f                      addq.l     #4,a7
[00003952] 6000 ff50                 bra        __nalloc_16

__nfree:
[00003956] 4e56 0000                 link       a6,#0
[0000395a] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[0000395e] 2a3c 0002 0c5e            move.l     #$00025872,d5
[00003964] 4aae 0008                 tst.l      8(a6)
[00003968] 660c                      bne.s      __nfree_1
[0000396a] 2e2e 000c                 move.l     12(a6),d7
[0000396e] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[00003972] 4e5e                      unlk       a6
[00003974] 4e75                      rts
__nfree_1:
[00003976] 226e 0008                 movea.l    8(a6),a1
[0000397a] 5989                      subq.l     #4,a1
[0000397c] 2849                      movea.l    a1,a4
[0000397e] 2245                      movea.l    d5,a1
[00003980] 4a91                      tst.l      (a1)
[00003982] 660a                      bne.s      __nfree_2
[00003984] 42ac 0004                 clr.l      4(a4)
[00003988] 2245                      movea.l    d5,a1
[0000398a] 228c                      move.l     a4,(a1)
[0000398c] 605c                      bra.s      __nfree_3
__nfree_2:
[0000398e] 2245                      movea.l    d5,a1
[00003990] b9d1                      cmpa.l     (a1),a4
[00003992] 6416                      bcc.s      __nfree_4
[00003994] 2245                      movea.l    d5,a1
[00003996] 2e91                      move.l     (a1),(a7)
[00003998] 2f0c                      move.l     a4,-(a7)
[0000399a] 4eba fd52                 jsr        $000036EE(pc)
[0000399e] 588f                      addq.l     #4,a7
[000039a0] 4a87                      tst.l      d7
[000039a2] 6746                      beq.s      __nfree_3
[000039a4] 2245                      movea.l    d5,a1
[000039a6] 228c                      move.l     a4,(a1)
[000039a8] 6040                      bra.s      __nfree_3
__nfree_4:
[000039aa] 2245                      movea.l    d5,a1
[000039ac] 2a51                      movea.l    (a1),a5
__nfree_6:
[000039ae] 266d 0004                 movea.l    4(a5),a3
[000039b2] 2e0b                      move.l     a3,d7
[000039b4] 6708                      beq.s      __nfree_5
[000039b6] b7cc                      cmpa.l     a4,a3
[000039b8] 6404                      bcc.s      __nfree_5
[000039ba] 2a4b                      movea.l    a3,a5
[000039bc] 60f0                      bra.s      __nfree_6
__nfree_5:
[000039be] 2e0b                      move.l     a3,d7
[000039c0] 671a                      beq.s      __nfree_7
[000039c2] 2e8b                      move.l     a3,(a7)
[000039c4] 2f0c                      move.l     a4,-(a7)
[000039c6] 4eba fd26                 jsr        $000036EE(pc)
[000039ca] 588f                      addq.l     #4,a7
[000039cc] 4a87                      tst.l      d7
[000039ce] 671a                      beq.s      __nfree_3
[000039d0] 2e8c                      move.l     a4,(a7)
[000039d2] 2f0d                      move.l     a5,-(a7)
[000039d4] 4eba fd18                 jsr        $000036EE(pc)
[000039d8] 588f                      addq.l     #4,a7
[000039da] 600e                      bra.s      __nfree_3
__nfree_7:
[000039dc] 42ac 0004                 clr.l      4(a4)
[000039e0] 2e8c                      move.l     a4,(a7)
[000039e2] 2f0d                      move.l     a5,-(a7)
[000039e4] 4eba fd08                 jsr        $000036EE(pc)
[000039e8] 588f                      addq.l     #4,a7
__nfree_3:
[000039ea] 2e2e 000c                 move.l     12(a6),d7
[000039ee] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[000039f2] 4e5e                      unlk       a6
[000039f4] 4e75                      rts

__realloc:
[000039f6] 4e56 fff8                 link       a6,#-8
[000039fa] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[000039fe] 262e 000c                 move.l     12(a6),d3
[00003a02] 4aae 0008                 tst.l      8(a6)
[00003a06] 660c                      bne.s      __realloc_1
[00003a08] 4297                      clr.l      (a7)
[00003a0a] 2f03                      move.l     d3,-(a7)
[00003a0c] 4eba fe60                 jsr        __nalloc(pc)
[00003a10] 588f                      addq.l     #4,a7
[00003a12] 6010                      bra.s      __realloc_2
__realloc_1:
[00003a14] 4a83                      tst.l      d3
[00003a16] 6614                      bne.s      __realloc_3
[00003a18] 4297                      clr.l      (a7)
[00003a1a] 2f2e 0008                 move.l     8(a6),-(a7)
[00003a1e] 4eba fd8c                 jsr        __free(pc)
[00003a22] 588f                      addq.l     #4,a7
__realloc_2:
[00003a24] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00003a28] 4e5e                      unlk       a6
[00003a2a] 4e75                      rts
__realloc_3:
[00003a2c] 226e 0008                 movea.l    8(a6),a1
[00003a30] 5989                      subq.l     #4,a1
[00003a32] 2a49                      movea.l    a1,a5
[00003a34] 0c83 0000 0004            cmpi.l     #$00000004,d3
[00003a3a] 6404                      bcc.s      __realloc_4
[00003a3c] 7e04                      moveq.l    #4,d7
[00003a3e] 6002                      bra.s      __realloc_5
__realloc_4:
[00003a40] 2e03                      move.l     d3,d7
__realloc_5:
[00003a42] 2a07                      move.l     d7,d5
[00003a44] 5685                      addq.l     #3,d5
[00003a46] 7efc                      moveq.l    #-4,d7
[00003a48] ce85                      and.l      d5,d7
[00003a4a] 2a07                      move.l     d7,d5
[00003a4c] 2245                      movea.l    d5,a1
[00003a4e] 5089                      addq.l     #8,a1
[00003a50] b3c3                      cmpa.l     d3,a1
[00003a52] 6204                      bhi.s      __realloc_6
[00003a54] 7e00                      moveq.l    #0,d7
[00003a56] 60cc                      bra.s      __realloc_2
__realloc_6:
[00003a58] 2e15                      move.l     (a5),d7
[00003a5a] 5887                      addq.l     #4,d7
[00003a5c] 2245                      movea.l    d5,a1
[00003a5e] 5089                      addq.l     #8,a1
[00003a60] b3c7                      cmpa.l     d7,a1
[00003a62] 6420                      bcc.s      __realloc_7
[00003a64] 2f05                      move.l     d5,-(a7)
[00003a66] 5897                      addq.l     #4,(a7)
[00003a68] 2f0d                      move.l     a5,-(a7)
[00003a6a] 4eba fc50                 jsr        $000036BC(pc)
[00003a6e] 508f                      addq.l     #8,a7
[00003a70] 2847                      movea.l    d7,a4
[00003a72] 4297                      clr.l      (a7)
[00003a74] 486c 0004                 pea.l      4(a4)
[00003a78] 4eba fd32                 jsr        __free(pc)
[00003a7c] 588f                      addq.l     #4,a7
[00003a7e] 2e0d                      move.l     a5,d7
[00003a80] 5887                      addq.l     #4,d7
[00003a82] 60a0                      bra.s      __realloc_2
__realloc_7:
[00003a84] 2e15                      move.l     (a5),d7
[00003a86] 5887                      addq.l     #4,d7
[00003a88] ba87                      cmp.l      d7,d5
[00003a8a] 6206                      bhi.s      __realloc_8
[00003a8c] 2e0d                      move.l     a5,d7
[00003a8e] 5887                      addq.l     #4,d7
[00003a90] 6092                      bra.s      __realloc_2
__realloc_8:
[00003a92] 2e8d                      move.l     a5,(a7)
[00003a94] 4eba fb50                 jsr        $000035E6(pc)
[00003a98] 2647                      movea.l    d7,a3
[00003a9a] 2e0b                      move.l     a3,d7
[00003a9c] 671c                      beq.s      __realloc_9
[00003a9e] 2e15                      move.l     (a5),d7
[00003aa0] 5887                      addq.l     #4,d7
[00003aa2] 2253                      movea.l    (a3),a1
[00003aa4] de91                      add.l      (a1),d7
[00003aa6] 5087                      addq.l     #8,d7
[00003aa8] ba87                      cmp.l      d7,d5
[00003aaa] 620e                      bhi.s      __realloc_9
[00003aac] 2853                      movea.l    (a3),a4
[00003aae] 26ac 0004                 move.l     4(a4),(a3)
[00003ab2] 2e14                      move.l     (a4),d7
[00003ab4] 5087                      addq.l     #8,d7
[00003ab6] df95                      add.l      d7,(a5)
[00003ab8] 609e                      bra.s      __realloc_6
__realloc_9:
[00003aba] 2e8d                      move.l     a5,(a7)
[00003abc] 4eba fbc4                 jsr        $00003682(pc)
[00003ac0] 2647                      movea.l    d7,a3
[00003ac2] 2e0b                      move.l     a3,d7
[00003ac4] 6734                      beq.s      __realloc_10
[00003ac6] 2e15                      move.l     (a5),d7
[00003ac8] 5887                      addq.l     #4,d7
[00003aca] 2253                      movea.l    (a3),a1
[00003acc] de91                      add.l      (a1),d7
[00003ace] 5087                      addq.l     #8,d7
[00003ad0] ba87                      cmp.l      d7,d5
[00003ad2] 6226                      bhi.s      __realloc_10
[00003ad4] 2853                      movea.l    (a3),a4
[00003ad6] 26ac 0004                 move.l     4(a4),(a3)
[00003ada] 2e15                      move.l     (a5),d7
[00003adc] 5087                      addq.l     #8,d7
[00003ade] df94                      add.l      d7,(a4)
[00003ae0] 2e95                      move.l     (a5),(a7)
[00003ae2] 5897                      addq.l     #4,(a7)
[00003ae4] 486d 0004                 pea.l      4(a5)
[00003ae8] 486c 0004                 pea.l      4(a4)
[00003aec] 4eb9 0000 3ffc            jsr        __cpybuf
[00003af2] 508f                      addq.l     #8,a7
[00003af4] 2a4c                      movea.l    a4,a5
[00003af6] 6000 ff60                 bra        __realloc_6
__realloc_10:
[00003afa] 4297                      clr.l      (a7)
[00003afc] 2f05                      move.l     d5,-(a7)
[00003afe] 4eba fd6e                 jsr        __nalloc(pc)
[00003b02] 588f                      addq.l     #4,a7
[00003b04] 2807                      move.l     d7,d4
[00003b06] 6604                      bne.s      __realloc_11
[00003b08] 7e00                      moveq.l    #0,d7
[00003b0a] 6020                      bra.s      __realloc_12
__realloc_11:
[00003b0c] 2e95                      move.l     (a5),(a7)
[00003b0e] 5897                      addq.l     #4,(a7)
[00003b10] 486d 0004                 pea.l      4(a5)
[00003b14] 2f04                      move.l     d4,-(a7)
[00003b16] 4eb9 0000 3ffc            jsr        __cpybuf
[00003b1c] 508f                      addq.l     #8,a7
[00003b1e] 4297                      clr.l      (a7)
[00003b20] 486d 0004                 pea.l      4(a5)
[00003b24] 4eba fc86                 jsr        __free(pc)
[00003b28] 588f                      addq.l     #4,a7
[00003b2a] 2e04                      move.l     d4,d7
__realloc_12:
[00003b2c] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00003b30] 4e5e                      unlk       a6
[00003b32] 4e75                      rts

__close:
[00003b34] 205f                      movea.l    (a7)+,a0
[00003b36] 7e06                      moveq.l    #6,d7
[00003b38] 4e41                      trap       #1
[00003b3a] 6400 0008                 bcc.w      __close_1
[00003b3e] 4ef9 0000 009a            jmp        seterr
__close_1:
[00003b44] 4ed0                      jmp        (a0)

__norm:
[00003b46] 4e56 ffe6                 link       a6,#-26
[00003b4a] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[00003b4e] 287c 0002 09f6            movea.l    #_dtens,a4
[00003b54] 2a6e 0008                 movea.l    8(a6),a5
[00003b58] 7a00                      moveq.l    #0,d5
[00003b5a] 7800                      moveq.l    #0,d4
[00003b5c] 4aae 000c                 tst.l      12(a6)
[00003b60] 6700 017a                 beq        __norm_1
[00003b64] 4aae 000c                 tst.l      12(a6)
[00003b68] 6c18                      bge.s      __norm_2
[00003b6a] 2c2e 000c                 move.l     12(a6),d6
[00003b6e] 2e2e 0010                 move.l     16(a6),d7
[00003b72] 4a86                      tst.l      d6
[00003b74] 6704                      beq.s      __norm_3
[00003b76] 0846 001f                 bchg       #31,d6
__norm_3:
[00003b7a] 2d46 000c                 move.l     d6,12(a6)
[00003b7e] 2d47 0010                 move.l     d7,16(a6)
__norm_2:
[00003b82] 2c2e 000c                 move.l     12(a6),d6
[00003b86] 2e2e 0010                 move.l     16(a6),d7
[00003b8a] 41d4                      lea.l      (a4),a0
[00003b8c] 4eb9 0000 478e            jsr        a~6cmp
[00003b92] 6d14                      blt.s      __norm_4
[00003b94] 2c2c 0020                 move.l     32(a4),d6
[00003b98] 2e2c 0024                 move.l     36(a4),d7
[00003b9c] 41ee 000c                 lea.l      12(a6),a0
[00003ba0] 4eb9 0000 478e            jsr        a~6cmp
[00003ba6] 6c6a                      bge.s      __norm_5
__norm_4:
[00003ba8] 2d6e 000c ffee            move.l     12(a6),-18(a6)
[00003bae] 2d6e 0010 fff2            move.l     16(a6),-14(a6)
[00003bb4] 486e ffee                 pea.l      -18(a6)
[00003bb8] 4eb9 0000 429e            jsr        __unpack
[00003bbe] 588f                      addq.l     #4,a7
[00003bc0] 2c3c 0000 7597            move.l     #$00007597,d6
[00003bc6] 4847                      swap       d7
[00003bc8] 3007                      move.w     d7,d0
[00003bca] c0c6                      mulu.w     d6,d0
[00003bcc] 3e00                      move.w     d0,d7
[00003bce] 4847                      swap       d7
[00003bd0] 2006                      move.l     d6,d0
[00003bd2] 4840                      swap       d0
[00003bd4] c0c7                      mulu.w     d7,d0
[00003bd6] 4847                      swap       d7
[00003bd8] de40                      add.w      d0,d7
[00003bda] 4847                      swap       d7
[00003bdc] 3007                      move.w     d7,d0
[00003bde] c0c6                      mulu.w     d6,d0
[00003be0] 4247                      clr.w      d7
[00003be2] de80                      add.l      d0,d7
[00003be4] 2e87                      move.l     d7,(a7)
[00003be6] 2f3c 0001 86a0            move.l     #$000186A0,-(a7)
[00003bec] 4eb9 0000 4a82            jsr        a~ldiv
[00003bf2] 2a17                      move.l     (a7),d5
[00003bf4] 2e05                      move.l     d5,d7
[00003bf6] 4487                      neg.l      d7
[00003bf8] 2e87                      move.l     d7,(a7)
[00003bfa] 2f2e 0010                 move.l     16(a6),-(a7)
[00003bfe] 2f2e 000c                 move.l     12(a6),-(a7)
[00003c02] 4eb9 0000 401e            jsr        __dtento
[00003c08] 508f                      addq.l     #8,a7
[00003c0a] 2d46 000c                 move.l     d6,12(a6)
[00003c0e] 2d47 0010                 move.l     d7,16(a6)
__norm_5:
[00003c12] 5085                      addq.l     #8,d5
__norm_13:
[00003c14] b8ae 0014                 cmp.l      20(a6),d4
[00003c18] 6400 00c2                 bcc        __norm_1
[00003c1c] 4aae 000c                 tst.l      12(a6)
[00003c20] 6700 00ba                 beq        __norm_1
[00003c24] 222e 000c                 move.l     12(a6),d1
[00003c28] 242e 0010                 move.l     16(a6),d2
[00003c2c] 4eb9 0000 49ae            jsr        a~1dtl
[00003c32] 2e00                      move.l     d0,d7
[00003c34] 2d47 fffc                 move.l     d7,-4(a6)
[00003c38] 266e fffc                 movea.l    -4(a6),a3
[00003c3c] 7608                      moveq.l    #8,d3
__norm_7:
[00003c3e] 5343                      subq.w     #1,d3
[00003c40] 6d22                      blt.s      __norm_6
[00003c42] 2e8b                      move.l     a3,(a7)
[00003c44] 4878 000a                 pea.l      ($0000000A).w
[00003c48] 4eb9 0000 4a70            jsr        a~lmod
[00003c4e] 2e17                      move.l     (a7),d7
[00003c50] 1d87 30e6                 move.b     d7,-26(a6,d3.w)
[00003c54] 2e8b                      move.l     a3,(a7)
[00003c56] 4878 000a                 pea.l      ($0000000A).w
[00003c5a] 4eb9 0000 4a82            jsr        a~ldiv
[00003c60] 2657                      movea.l    (a7),a3
[00003c62] 60da                      bra.s      __norm_7
__norm_6:
[00003c64] 2e0b                      move.l     a3,d7
[00003c66] 670e                      beq.s      __norm_8
[00003c68] 2e0b                      move.l     a3,d7
[00003c6a] 0687 0000 0030            addi.l     #$00000030,d7
[00003c70] 1ac7                      move.b     d7,(a5)+
[00003c72] 5284                      addq.l     #1,d4
[00003c74] 5285                      addq.l     #1,d5
__norm_8:
[00003c76] 4243                      clr.w      d3
__norm_12:
[00003c78] b8ae 0014                 cmp.l      20(a6),d4
[00003c7c] 6426                      bcc.s      __norm_9
[00003c7e] 0c43 0008                 cmpi.w     #$0008,d3
[00003c82] 6c20                      bge.s      __norm_9
[00003c84] 4a84                      tst.l      d4
[00003c86] 660a                      bne.s      __norm_10
[00003c88] 4a36 30e6                 tst.b      -26(a6,d3.w)
[00003c8c] 6604                      bne.s      __norm_10
[00003c8e] 5385                      subq.l     #1,d5
[00003c90] 600e                      bra.s      __norm_11
__norm_10:
[00003c92] 7e00                      moveq.l    #0,d7
[00003c94] 1e36 30e6                 move.b     -26(a6,d3.w),d7
[00003c98] 7c30                      moveq.l    #48,d6
[00003c9a] dc87                      add.l      d7,d6
[00003c9c] 1ac6                      move.b     d6,(a5)+
[00003c9e] 5284                      addq.l     #1,d4
__norm_11:
[00003ca0] 5243                      addq.w     #1,d3
[00003ca2] 60d4                      bra.s      __norm_12
__norm_9:
[00003ca4] b8ae 0014                 cmp.l      20(a6),d4
[00003ca8] 6400 ff6a                 bcc        __norm_13
[00003cac] 202e fffc                 move.l     -4(a6),d0
[00003cb0] 4eb9 0000 4b6c            jsr        a~6ltd
[00003cb6] 222e 000c                 move.l     12(a6),d1
[00003cba] 242e 0010                 move.l     16(a6),d2
[00003cbe] 91c8                      suba.l     a0,a0
[00003cc0] 4eb9 0000 4644            jsr        a~1sub
[00003cc6] 41ec 0020                 lea.l      32(a4),a0
[00003cca] 4eb9 0000 48aa            jsr        a~1mul
[00003cd0] 2d41 000c                 move.l     d1,12(a6)
[00003cd4] 2d42 0010                 move.l     d2,16(a6)
[00003cd8] 6000 ff3a                 bra        __norm_13
__norm_1:
[00003cdc] b8ae 0014                 cmp.l      20(a6),d4
[00003ce0] 6408                      bcc.s      __norm_14
[00003ce2] 1afc 0030                 move.b     #$30,(a5)+
[00003ce6] 5284                      addq.l     #1,d4
[00003ce8] 60f2                      bra.s      __norm_1
__norm_14:
[00003cea] 2e05                      move.l     d5,d7
[00003cec] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00003cf0] 4e5e                      unlk       a6
[00003cf2] 4e75                      rts

__domain:
[00003cf4] 4e56 fffc                 link       a6,#-4
[00003cf8] 4ab9 0002 0c66            tst.l      $0002587A
[00003cfe] 6718                      beq.s      __domain_1
[00003d00] 7021                      moveq.l    #33,d0
[00003d02] 23c0 0002 0064            move.l     d0,_errno
[00003d08] 4297                      clr.l      (a7)
[00003d0a] 2f2e 0008                 move.l     8(a6),-(a7)
[00003d0e] 4eb9 0000 43b4            jsr        __remark
[00003d14] 588f                      addq.l     #4,a7
[00003d16] 6018                      bra.s      __domain_2
__domain_1:
[00003d18] 23ee 0008 0002 0c66       move.l     8(a6),$0002587A
[00003d20] 2ebc 0002 0c66            move.l     #$0002587A,(a7)
[00003d26] 42a7                      clr.l      -(a7)
[00003d28] 4eb9 0000 44d4            jsr        __raise
[00003d2e] 588f                      addq.l     #4,a7
__domain_2:
[00003d30] 4e5e                      unlk       a6
[00003d32] 4e75                      rts

__fwrite:
[00003d34] 4e56 fffc                 link       a6,#-4
[00003d38] 2eae 0010                 move.l     16(a6),(a7)
[00003d3c] 2f2e 000c                 move.l     12(a6),-(a7)
[00003d40] 2f2e 0008                 move.l     8(a6),-(a7)
[00003d44] 4eb9 0000 4632            jsr        __write
[00003d4a] 508f                      addq.l     #8,a7
[00003d4c] beae 0010                 cmp.l      16(a6),d7
[00003d50] 6710                      beq.s      __fwrite_1
[00003d52] 2ebc 0002 0854            move.l     #_wrierr,(a7)
[00003d58] 42a7                      clr.l      -(a7)
[00003d5a] 4eb9 0000 44d4            jsr        __raise
[00003d60] 588f                      addq.l     #4,a7
__fwrite_1:
[00003d62] 4e5e                      unlk       a6
[00003d64] 4e75                      rts

__getmod:
[00003d66] 4e56 ffdc                 link       a6,#-36
[00003d6a] 486e ffdc                 pea.l      -36(a6)
[00003d6e] 2f2e 0008                 move.l     8(a6),-(a7)
[00003d72] 4eb9 0000 3dde            jsr        __stat
[00003d78] 508f                      addq.l     #8,a7
[00003d7a] 4a87                      tst.l      d7
[00003d7c] 6c04                      bge.s      __getmod_1
[00003d7e] 7e00                      moveq.l    #0,d7
[00003d80] 6006                      bra.s      __getmod_2
__getmod_1:
[00003d82] 7e00                      moveq.l    #0,d7
[00003d84] 3e2e ffe0                 move.w     -32(a6),d7
__getmod_2:
[00003d88] 4e5e                      unlk       a6
[00003d8a] 4e75                      rts

__sbreak:
[00003d8c] 7000                      moveq.l    #0,d0
[00003d8e] 6002                      bra.s      __sbreak_1
__sbreak_1: ; not found: 00003d92

__sbrk:
[00003d90] 7001                      moveq.l    #1,d0
[00003d92] 4878 ffff                 pea.l      ($FFFFFFFF).w
[00003d96] 7e11                      moveq.l    #17,d7
[00003d98] 4e41                      trap       #1
[00003d9a] 2c07                      move.l     d7,d6
[00003d9c] deaf 0008                 add.l      8(a7),d7
[00003da0] 5287                      addq.l     #1,d7
[00003da2] 0887 0000                 bclr       #0,d7
[00003da6] 2e87                      move.l     d7,(a7)
[00003da8] 7e11                      moveq.l    #17,d7
[00003daa] 4e41                      trap       #1
[00003dac] 4a9f                      tst.l      (a7)+
[00003dae] 0c87 ffff ffff            cmpi.l     #$FFFFFFFF,d7
[00003db4] 6612                      bne.s      __sbrk_1
[00003db6] 23fc 0000 000c 0002 0064  move.l     #$0000000C,_errno
[00003dc0] 4a80                      tst.l      d0
[00003dc2] 6602                      bne.s      __sbrk_2
[00003dc4] 7e00                      moveq.l    #0,d7
__sbrk_2:
[00003dc6] 4e75                      rts
__sbrk_1:
[00003dc8] 2e06                      move.l     d6,d7
[00003dca] 4e75                      rts

__signal:
[00003dcc] 205f                      movea.l    (a7)+,a0
[00003dce] 7e30                      moveq.l    #48,d7
[00003dd0] 4e41                      trap       #1
[00003dd2] 6400 0008                 bcc.w      __signal_1
[00003dd6] 4ef9 0000 009a            jmp        seterr
__signal_1:
[00003ddc] 4ed0                      jmp        (a0)

__stat:
[00003dde] 205f                      movea.l    (a7)+,a0
[00003de0] 7e12                      moveq.l    #18,d7
[00003de2] 4e41                      trap       #1
[00003de4] 6400 0008                 bcc.w      __stat_1
[00003de8] 4ef9 0000 009a            jmp        seterr
__stat_1:
[00003dee] 4ed0                      jmp        (a0)

__btol:
[00003df0] 4e56 ffe8                 link       a6,#-24
[00003df4] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[00003df8] 262e 0014                 move.l     20(a6),d3
[00003dfc] 2a2e 000c                 move.l     12(a6),d5
[00003e00] 2a6e 0008                 movea.l    8(a6),a5
__btol_2:
[00003e04] 4a85                      tst.l      d5
[00003e06] 6720                      beq.s      __btol_1
[00003e08] 227c 0002 08c1            movea.l    #$000254D5,a1
[00003e0e] 7e00                      moveq.l    #0,d7
[00003e10] 1e15                      move.b     (a5),d7
[00003e12] 1e31 7800                 move.b     0(a1,d7.l),d7
[00003e16] 0207 0088                 andi.b     #$88,d7
[00003e1a] 0287 0000 00ff            andi.l     #$000000FF,d7
[00003e20] 6706                      beq.s      __btol_1
[00003e22] 528d                      addq.l     #1,a5
[00003e24] 5385                      subq.l     #1,d5
[00003e26] 60dc                      bra.s      __btol_2
__btol_1:
[00003e28] 42ae fffc                 clr.l      -4(a6)
[00003e2c] 4a85                      tst.l      d5
[00003e2e] 671c                      beq.s      __btol_3
[00003e30] 0c15 002b                 cmpi.b     #$2B,(a5)
[00003e34] 6606                      bne.s      __btol_4
[00003e36] 528d                      addq.l     #1,a5
[00003e38] 5385                      subq.l     #1,d5
[00003e3a] 6010                      bra.s      __btol_3
__btol_4:
[00003e3c] 0c15 002d                 cmpi.b     #$2D,(a5)
[00003e40] 660a                      bne.s      __btol_3
[00003e42] 528d                      addq.l     #1,a5
[00003e44] 5385                      subq.l     #1,d5
[00003e46] 7001                      moveq.l    #1,d0
[00003e48] 2d40 fffc                 move.l     d0,-4(a6)
__btol_3:
[00003e4c] 4a85                      tst.l      d5
[00003e4e] 6604                      bne.s      __btol_5
[00003e50] 7601                      moveq.l    #1,d3
[00003e52] 6060                      bra.s      __btol_6
__btol_5:
[00003e54] 0c83 0000 0001            cmpi.l     #$00000001,d3
[00003e5a] 6e2e                      bgt.s      __btol_7
[00003e5c] 0c15 0030                 cmpi.b     #$30,(a5)
[00003e60] 6704                      beq.s      __btol_8
[00003e62] 760a                      moveq.l    #10,d3
[00003e64] 604e                      bra.s      __btol_6
__btol_8:
[00003e66] 0c85 0000 0001            cmpi.l     #$00000001,d5
[00003e6c] 6318                      bls.s      __btol_9
[00003e6e] 0c2d 0078 0001            cmpi.b     #$78,1(a5)
[00003e74] 6708                      beq.s      __btol_10
[00003e76] 0c2d 0058 0001            cmpi.b     #$58,1(a5)
[00003e7c] 6608                      bne.s      __btol_9
__btol_10:
[00003e7e] 548d                      addq.l     #2,a5
[00003e80] 5585                      subq.l     #2,d5
[00003e82] 7610                      moveq.l    #16,d3
[00003e84] 602e                      bra.s      __btol_6
__btol_9:
[00003e86] 7608                      moveq.l    #8,d3
[00003e88] 602a                      bra.s      __btol_6
__btol_7:
[00003e8a] 0c83 0000 0010            cmpi.l     #$00000010,d3
[00003e90] 6622                      bne.s      __btol_6
[00003e92] 0c85 0000 0002            cmpi.l     #$00000002,d5
[00003e98] 651a                      bcs.s      __btol_6
[00003e9a] 0c15 0030                 cmpi.b     #$30,(a5)
[00003e9e] 6614                      bne.s      __btol_6
[00003ea0] 0c2d 0078 0001            cmpi.b     #$78,1(a5)
[00003ea6] 6708                      beq.s      __btol_11
[00003ea8] 0c2d 0058 0001            cmpi.b     #$58,1(a5)
[00003eae] 6604                      bne.s      __btol_6
__btol_11:
[00003eb0] 548d                      addq.l     #2,a5
[00003eb2] 5585                      subq.l     #2,d5
__btol_6:
[00003eb4] 42ae ffe8                 clr.l      -24(a6)
[00003eb8] 99cc                      suba.l     a4,a4
[00003eba] 4878 ffff                 pea.l      ($FFFFFFFF).w
[00003ebe] 2f03                      move.l     d3,-(a7)
[00003ec0] 4eb9 0000 4ad2            jsr        a~uldiv
[00003ec6] 2d5f fff0                 move.l     (a7)+,-16(a6)
[00003eca] 97cb                      suba.l     a3,a3
__btol_18:
[00003ecc] 4a85                      tst.l      d5
[00003ece] 6700 00a0                 beq        __btol_12
[00003ed2] 227c 0002 08c1            movea.l    #$000254D5,a1
[00003ed8] 7e00                      moveq.l    #0,d7
[00003eda] 1e15                      move.b     (a5),d7
[00003edc] 0831 0002 7800            btst       #2,0(a1,d7.l)
[00003ee2] 670a                      beq.s      __btol_13
[00003ee4] 78d0                      moveq.l    #-48,d4
[00003ee6] 7e00                      moveq.l    #0,d7
[00003ee8] 1e15                      move.b     (a5),d7
[00003eea] d887                      add.l      d7,d4
[00003eec] 6038                      bra.s      __btol_14
__btol_13:
[00003eee] 7e00                      moveq.l    #0,d7
[00003ef0] 1e15                      move.b     (a5),d7
[00003ef2] 2e87                      move.l     d7,(a7)
[00003ef4] 2f3c 0002 0864            move.l     #$00025478,-(a7)
[00003efa] 4eb9 0000 4284            jsr        __scnstr
[00003f00] 588f                      addq.l     #4,a7
[00003f02] 2807                      move.l     d7,d4
[00003f04] 2244                      movea.l    d4,a1
[00003f06] d3fc 0002 0864            adda.l     #$00025478,a1
[00003f0c] 4a11                      tst.b      (a1)
[00003f0e] 6760                      beq.s      __btol_12
[00003f10] 0c84 0000 001a            cmpi.l     #$0000001A,d4
[00003f16] 6c08                      bge.s      __btol_15
[00003f18] 0684 0000 000a            addi.l     #$0000000A,d4
[00003f1e] 6006                      bra.s      __btol_14
__btol_15:
[00003f20] 0684 ffff fff0            addi.l     #$FFFFFFF0,d4
__btol_14:
[00003f26] b684                      cmp.l      d4,d3
[00003f28] 6f46                      ble.s      __btol_12
[00003f2a] 2e2e fff0                 move.l     -16(a6),d7
[00003f2e] be8c                      cmp.l      a4,d7
[00003f30] 6404                      bcc.s      __btol_16
[00003f32] 47f8 0001                 lea.l      ($00000001).w,a3
__btol_16:
[00003f36] 2e0c                      move.l     a4,d7
[00003f38] 4847                      swap       d7
[00003f3a] 3007                      move.w     d7,d0
[00003f3c] c0c3                      mulu.w     d3,d0
[00003f3e] 3e00                      move.w     d0,d7
[00003f40] 4847                      swap       d7
[00003f42] 2003                      move.l     d3,d0
[00003f44] 4840                      swap       d0
[00003f46] c0c7                      mulu.w     d7,d0
[00003f48] 4847                      swap       d7
[00003f4a] de40                      add.w      d0,d7
[00003f4c] 4847                      swap       d7
[00003f4e] 3007                      move.w     d7,d0
[00003f50] c0c3                      mulu.w     d3,d0
[00003f52] 4247                      clr.w      d7
[00003f54] de80                      add.l      d0,d7
[00003f56] de84                      add.l      d4,d7
[00003f58] 2847                      movea.l    d7,a4
[00003f5a] b9ee ffe8                 cmpa.l     -24(a6),a4
[00003f5e] 6404                      bcc.s      __btol_17
[00003f60] 47f8 0001                 lea.l      ($00000001).w,a3
__btol_17:
[00003f64] 2d4c ffe8                 move.l     a4,-24(a6)
[00003f68] 5385                      subq.l     #1,d5
[00003f6a] 528d                      addq.l     #1,a5
[00003f6c] 6000 ff5e                 bra        __btol_18
__btol_12:
[00003f70] 7800                      moveq.l    #0,d4
__btol_22:
[00003f72] 4a85                      tst.l      d5
[00003f74] 6734                      beq.s      __btol_19
[00003f76] 0c15 006c                 cmpi.b     #$6C,(a5)
[00003f7a] 6706                      beq.s      __btol_20
[00003f7c] 0c15 004c                 cmpi.b     #$4C,(a5)
[00003f80] 6610                      bne.s      __btol_21
__btol_20:
[00003f82] 0804 0001                 btst       #1,d4
[00003f86] 6622                      bne.s      __btol_19
[00003f88] 08c4 0001                 bset       #1,d4
__btol_24:
[00003f8c] 528d                      addq.l     #1,a5
[00003f8e] 5385                      subq.l     #1,d5
[00003f90] 60e0                      bra.s      __btol_22
__btol_21:
[00003f92] 0c15 0075                 cmpi.b     #$75,(a5)
[00003f96] 6706                      beq.s      __btol_23
[00003f98] 0c15 0055                 cmpi.b     #$55,(a5)
[00003f9c] 660c                      bne.s      __btol_19
__btol_23:
[00003f9e] 0804 0000                 btst       #0,d4
[00003fa2] 6606                      bne.s      __btol_19
[00003fa4] 08c4 0000                 bset       #0,d4
[00003fa8] 60e2                      bra.s      __btol_24
__btol_19:
[00003faa] 4aae fffc                 tst.l      -4(a6)
[00003fae] 6716                      beq.s      __btol_25
[00003fb0] 2e2e ffe8                 move.l     -24(a6),d7
[00003fb4] 4487                      neg.l      d7
[00003fb6] 2d47 fff4                 move.l     d7,-12(a6)
[00003fba] 4aae fff4                 tst.l      -12(a6)
[00003fbe] 6f16                      ble.s      __btol_26
[00003fc0] 47f8 0001                 lea.l      ($00000001).w,a3
[00003fc4] 6010                      bra.s      __btol_26
__btol_25:
[00003fc6] 2d6e ffe8 fff4            move.l     -24(a6),-12(a6)
[00003fcc] 4aae fff4                 tst.l      -12(a6)
[00003fd0] 6c04                      bge.s      __btol_26
[00003fd2] 47f8 0001                 lea.l      ($00000001).w,a3
__btol_26:
[00003fd6] 226e 0010                 movea.l    16(a6),a1
[00003fda] 22ae fff4                 move.l     -12(a6),(a1)
[00003fde] 2e0b                      move.l     a3,d7
[00003fe0] 670c                      beq.s      __btol_27
[00003fe2] 2ebc 0002 0899            move.l     #$000254AD,(a7)
[00003fe8] 4eb9 0000 432c            jsr        __range
__btol_27:
[00003fee] 2e0d                      move.l     a5,d7
[00003ff0] 9eae 0008                 sub.l      8(a6),d7
[00003ff4] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00003ff8] 4e5e                      unlk       a6
[00003ffa] 4e75                      rts

__cpybuf:
[00003ffc] 2e2f 000c                 move.l     12(a7),d7
[00004000] 671a                      beq.s      __cpybuf_1
[00004002] 2007                      move.l     d7,d0
[00004004] 2200                      move.l     d0,d1
[00004006] 4840                      swap       d0
[00004008] 5341                      subq.w     #1,d1
[0000400a] 206f 0004                 movea.l    4(a7),a0
[0000400e] 246f 0008                 movea.l    8(a7),a2
__cpybuf_2:
[00004012] 10da                      move.b     (a2)+,(a0)+
[00004014] 51c9 fffc                 dbf        d1,__cpybuf_2
[00004018] 51c8 fff8                 dbf        d0,__cpybuf_2
__cpybuf_1:
[0000401c] 4e75                      rts

__dtento:
[0000401e] 4e56 fffa                 link       a6,#-6
[00004022] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[00004026] 2a7c 0002 09f6            movea.l    #_dtens,a5
[0000402c] 2a2e 0010                 move.l     16(a6),d5
[00004030] 3e39 0002 0a48            move.w     _ntens,d7
[00004036] 48c7                      ext.l      d7
[00004038] 2847                      movea.l    d7,a4
[0000403a] 538c                      subq.l     #1,a4
[0000403c] 384c                      movea.w    a4,a4
[0000403e] 4aae 0008                 tst.l      8(a6)
[00004042] 660c                      bne.s      __dtento_1
[00004044] 4286                      clr.l      d6
[00004046] 4287                      clr.l      d7
[00004048] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[0000404c] 4e5e                      unlk       a6
[0000404e] 4e75                      rts
__dtento_1:
[00004050] 486e 0008                 pea.l      8(a6)
[00004054] 4eb9 0000 429e            jsr        __unpack
[0000405a] 588f                      addq.l     #4,a7
[0000405c] 3647                      movea.w    d7,a3
[0000405e] 4a85                      tst.l      d5
[00004060] 6c00 00cc                 bge        __dtento_2
[00004064] 2805                      move.l     d5,d4
[00004066] 4484                      neg.l      d4
[00004068] 7601                      moveq.l    #1,d3
__dtento_5:
[0000406a] 4a84                      tst.l      d4
[0000406c] 6732                      beq.s      __dtento_3
[0000406e] 3e0c                      move.w     a4,d7
[00004070] 48c7                      ext.l      d7
[00004072] b687                      cmp.l      d7,d3
[00004074] 6c2a                      bge.s      __dtento_3
[00004076] 0804 0000                 btst       #0,d4
[0000407a] 671e                      beq.s      __dtento_4
[0000407c] 2e03                      move.l     d3,d7
[0000407e] e787                      asl.l      #3,d7
[00004080] 222e 0008                 move.l     8(a6),d1
[00004084] 242e 000c                 move.l     12(a6),d2
[00004088] 41f5 7800                 lea.l      0(a5,d7.l),a0
[0000408c] 4eb9 0000 47d6            jsr        a~1div
[00004092] 2d41 0008                 move.l     d1,8(a6)
[00004096] 2d42 000c                 move.l     d2,12(a6)
__dtento_4:
[0000409a] e28c                      lsr.l      #1,d4
[0000409c] 5283                      addq.l     #1,d3
[0000409e] 60ca                      bra.s      __dtento_5
__dtento_3:
[000040a0] 4a84                      tst.l      d4
[000040a2] 6700 0150                 beq        __dtento_6
[000040a6] 7e01                      moveq.l    #1,d7
[000040a8] 3c0c                      move.w     a4,d6
[000040aa] eda7                      asl.l      d6,d7
[000040ac] 2c3c 0001 86a0            move.l     #$000186A0,d6
[000040b2] 4847                      swap       d7
[000040b4] 3007                      move.w     d7,d0
[000040b6] c0c6                      mulu.w     d6,d0
[000040b8] 3e00                      move.w     d0,d7
[000040ba] 4847                      swap       d7
[000040bc] 2006                      move.l     d6,d0
[000040be] 4840                      swap       d0
[000040c0] c0c7                      mulu.w     d7,d0
[000040c2] 4847                      swap       d7
[000040c4] de40                      add.w      d0,d7
[000040c6] 4847                      swap       d7
[000040c8] 3007                      move.w     d7,d0
[000040ca] c0c6                      mulu.w     d6,d0
[000040cc] 4247                      clr.w      d7
[000040ce] de80                      add.l      d0,d7
[000040d0] 2e87                      move.l     d7,(a7)
[000040d2] 4878 7597                 pea.l      ($00007597).w
[000040d6] 4eb9 0000 4a82            jsr        a~ldiv
[000040dc] 2e17                      move.l     (a7),d7
[000040de] 4487                      neg.l      d7
[000040e0] 3d47 fffc                 move.w     d7,-4(a6)
__dtento_7:
[000040e4] 4a84                      tst.l      d4
[000040e6] 6700 010c                 beq        __dtento_6
[000040ea] 3e2e fffc                 move.w     -4(a6),d7
[000040ee] 3c0b                      move.w     a3,d6
[000040f0] be46                      cmp.w      d6,d7
[000040f2] 6c00 0100                 bge        __dtento_6
[000040f6] 486e 0008                 pea.l      8(a6)
[000040fa] 4eb9 0000 429e            jsr        __unpack
[00004100] 588f                      addq.l     #4,a7
[00004102] 3c0b                      move.w     a3,d6
[00004104] 48c6                      ext.l      d6
[00004106] dc87                      add.l      d7,d6
[00004108] 3646                      movea.w    d6,a3
[0000410a] 3e0c                      move.w     a4,d7
[0000410c] 48c7                      ext.l      d7
[0000410e] e787                      asl.l      #3,d7
[00004110] 222e 0008                 move.l     8(a6),d1
[00004114] 242e 000c                 move.l     12(a6),d2
[00004118] 41f5 7800                 lea.l      0(a5,d7.l),a0
[0000411c] 4eb9 0000 47d6            jsr        a~1div
[00004122] 2d41 0008                 move.l     d1,8(a6)
[00004126] 2d42 000c                 move.l     d2,12(a6)
[0000412a] 5384                      subq.l     #1,d4
[0000412c] 60b6                      bra.s      __dtento_7
__dtento_2:
[0000412e] 4a85                      tst.l      d5
[00004130] 6f00 00c2                 ble        __dtento_6
[00004134] 2805                      move.l     d5,d4
[00004136] 7601                      moveq.l    #1,d3
__dtento_10:
[00004138] 4a84                      tst.l      d4
[0000413a] 6732                      beq.s      __dtento_8
[0000413c] 3e0c                      move.w     a4,d7
[0000413e] 48c7                      ext.l      d7
[00004140] b687                      cmp.l      d7,d3
[00004142] 6c2a                      bge.s      __dtento_8
[00004144] 0804 0000                 btst       #0,d4
[00004148] 671e                      beq.s      __dtento_9
[0000414a] 2e03                      move.l     d3,d7
[0000414c] e787                      asl.l      #3,d7
[0000414e] 222e 0008                 move.l     8(a6),d1
[00004152] 242e 000c                 move.l     12(a6),d2
[00004156] 41f5 7800                 lea.l      0(a5,d7.l),a0
[0000415a] 4eb9 0000 48aa            jsr        a~1mul
[00004160] 2d41 0008                 move.l     d1,8(a6)
[00004164] 2d42 000c                 move.l     d2,12(a6)
__dtento_9:
[00004168] e28c                      lsr.l      #1,d4
[0000416a] 5283                      addq.l     #1,d3
[0000416c] 60ca                      bra.s      __dtento_10
__dtento_8:
[0000416e] 4a84                      tst.l      d4
[00004170] 6700 0082                 beq        __dtento_6
[00004174] 7e01                      moveq.l    #1,d7
[00004176] 3c0c                      move.w     a4,d6
[00004178] eda7                      asl.l      d6,d7
[0000417a] 2c3c 0001 86a0            move.l     #$000186A0,d6
[00004180] 4847                      swap       d7
[00004182] 3007                      move.w     d7,d0
[00004184] c0c6                      mulu.w     d6,d0
[00004186] 3e00                      move.w     d0,d7
[00004188] 4847                      swap       d7
[0000418a] 2006                      move.l     d6,d0
[0000418c] 4840                      swap       d0
[0000418e] c0c7                      mulu.w     d7,d0
[00004190] 4847                      swap       d7
[00004192] de40                      add.w      d0,d7
[00004194] 4847                      swap       d7
[00004196] 3007                      move.w     d7,d0
[00004198] c0c6                      mulu.w     d6,d0
[0000419a] 4247                      clr.w      d7
[0000419c] de80                      add.l      d0,d7
[0000419e] 2e87                      move.l     d7,(a7)
[000041a0] 4878 7597                 pea.l      ($00007597).w
[000041a4] 4eb9 0000 4a82            jsr        a~ldiv
[000041aa] 2e17                      move.l     (a7),d7
[000041ac] 3d47 fffc                 move.w     d7,-4(a6)
__dtento_11:
[000041b0] 4a84                      tst.l      d4
[000041b2] 6740                      beq.s      __dtento_6
[000041b4] 3e0b                      move.w     a3,d7
[000041b6] be6e fffc                 cmp.w      -4(a6),d7
[000041ba] 6c38                      bge.s      __dtento_6
[000041bc] 486e 0008                 pea.l      8(a6)
[000041c0] 4eb9 0000 429e            jsr        __unpack
[000041c6] 588f                      addq.l     #4,a7
[000041c8] 3c0b                      move.w     a3,d6
[000041ca] 48c6                      ext.l      d6
[000041cc] dc87                      add.l      d7,d6
[000041ce] 3646                      movea.w    d6,a3
[000041d0] 3e0c                      move.w     a4,d7
[000041d2] 48c7                      ext.l      d7
[000041d4] e787                      asl.l      #3,d7
[000041d6] 222e 0008                 move.l     8(a6),d1
[000041da] 242e 000c                 move.l     12(a6),d2
[000041de] 41f5 7800                 lea.l      0(a5,d7.l),a0
[000041e2] 4eb9 0000 48aa            jsr        a~1mul
[000041e8] 2d41 0008                 move.l     d1,8(a6)
[000041ec] 2d42 000c                 move.l     d2,12(a6)
[000041f0] 5384                      subq.l     #1,d4
[000041f2] 60bc                      bra.s      __dtento_11
__dtento_6:
[000041f4] 2ebc 0002 09c2            move.l     #$000255D6,(a7)
[000041fa] 3e0b                      move.w     a3,d7
[000041fc] 48c7                      ext.l      d7
[000041fe] 2f07                      move.l     d7,-(a7)
[00004200] 2f2e 000c                 move.l     12(a6),-(a7)
[00004204] 2f2e 0008                 move.l     8(a6),-(a7)
[00004208] 4eb9 0000 42be            jsr        __addexp
[0000420e] 4fef 000c                 lea.l      12(a7),a7
[00004212] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00004216] 4e5e                      unlk       a6
[00004218] 4e75                      rts

__getenv:
[0000421a] 4e56 0000                 link       a6,#0
[0000421e] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00004222] 2a6e 0008                 movea.l    8(a6),a5
[00004226] 2e8d                      move.l     a5,(a7)
[00004228] 4eb9 0000 4272            jsr        __lenstr
[0000422e] 2a07                      move.l     d7,d5
[00004230] 2879 0002 0c2e            movea.l    $00025842,a4
__getenv_4:
[00004236] 2e0c                      move.l     a4,d7
[00004238] 672e                      beq.s      __getenv_1
[0000423a] 4a94                      tst.l      (a4)
[0000423c] 672a                      beq.s      __getenv_1
[0000423e] 2e85                      move.l     d5,(a7)
[00004240] 2f14                      move.l     (a4),-(a7)
[00004242] 2f0d                      move.l     a5,-(a7)
[00004244] 4eb9 0000 4304            jsr        __cmpbuf
[0000424a] 508f                      addq.l     #8,a7
[0000424c] 4a87                      tst.l      d7
[0000424e] 6714                      beq.s      __getenv_2
[00004250] 2254                      movea.l    (a4),a1
[00004252] 0c31 003d 5800            cmpi.b     #$3D,0(a1,d5.l)
[00004258] 660a                      bne.s      __getenv_2
[0000425a] 2254                      movea.l    (a4),a1
[0000425c] 2e05                      move.l     d5,d7
[0000425e] de89                      add.l      a1,d7
[00004260] 5287                      addq.l     #1,d7
[00004262] 6006                      bra.s      __getenv_3
__getenv_2:
[00004264] 588c                      addq.l     #4,a4
[00004266] 60ce                      bra.s      __getenv_4
__getenv_1:
[00004268] 7e00                      moveq.l    #0,d7
__getenv_3:
[0000426a] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000426e] 4e5e                      unlk       a6
[00004270] 4e75                      rts

__lenstr:
[00004272] 206f 0004                 movea.l    4(a7),a0
__lenstr_1:
[00004276] 4a18                      tst.b      (a0)+
[00004278] 66fc                      bne.s      __lenstr_1
[0000427a] 2e08                      move.l     a0,d7
[0000427c] 9eaf 0004                 sub.l      4(a7),d7
[00004280] 5387                      subq.l     #1,d7
[00004282] 4e75                      rts

__scnstr:
[00004284] 206f 0004                 movea.l    4(a7),a0
[00004288] 1e2f 000b                 move.b     11(a7),d7
__scnstr_2:
[0000428c] be10                      cmp.b      (a0),d7
[0000428e] 6706                      beq.s      __scnstr_1
[00004290] 4a18                      tst.b      (a0)+
[00004292] 66f8                      bne.s      __scnstr_2
[00004294] 5388                      subq.l     #1,a0
__scnstr_1:
[00004296] 2e08                      move.l     a0,d7
[00004298] 9eaf 0004                 sub.l      4(a7),d7
[0000429c] 4e75                      rts

__unpack:
[0000429e] 206f 0004                 movea.l    4(a7),a0
[000042a2] 4287                      clr.l      d7
[000042a4] 3e10                      move.w     (a0),d7
[000042a6] 6714                      beq.s      __unpack_1
[000042a8] e847                      asr.w      #4,d7
[000042aa] 0247 07ff                 andi.w     #$07FF,d7
[000042ae] 0487 0000 03fe            subi.l     #$000003FE,d7
[000042b4] 0250 800f                 andi.w     #$800F,(a0)
[000042b8] 0050 3fe0                 ori.w      #$3FE0,(a0)
__unpack_1:
[000042bc] 4e75                      rts

__addexp:
[000042be] 3c2f 0004                 move.w     4(a7),d6
[000042c2] 6736                      beq.s      __addexp_1
[000042c4] e846                      asr.w      #4,d6
[000042c6] 0286 0000 07ff            andi.l     #$000007FF,d6
[000042cc] dcaf 000c                 add.l      12(a7),d6
[000042d0] 6e06                      bgt.s      __addexp_2
[000042d2] 4286                      clr.l      d6
[000042d4] 4287                      clr.l      d7
[000042d6] 4e75                      rts
__addexp_2:
[000042d8] 0c86 0000 07ff            cmpi.l     #$000007FF,d6
[000042de] 6d0e                      blt.s      __addexp_3
[000042e0] 2f2f 0010                 move.l     16(a7),-(a7)
[000042e4] 4eb9 0000 432c            jsr        __range
[000042ea] 588f                      addq.l     #4,a7
[000042ec] 4e75                      rts
__addexp_3:
[000042ee] e946                      asl.w      #4,d6
[000042f0] 026f 800f 0004            andi.w     #$800F,4(a7)
[000042f6] 8d6f 0004                 or.w       d6,4(a7)
__addexp_1:
[000042fa] 2c2f 0004                 move.l     4(a7),d6
[000042fe] 2e2f 0008                 move.l     8(a7),d7
[00004302] 4e75                      rts

__cmpbuf:
[00004304] 202f 000c                 move.l     12(a7),d0
[00004308] 671a                      beq.s      __cmpbuf_1
[0000430a] 2200                      move.l     d0,d1
[0000430c] 4840                      swap       d0
[0000430e] 5341                      subq.w     #1,d1
[00004310] 206f 0004                 movea.l    4(a7),a0
[00004314] 246f 0008                 movea.l    8(a7),a2
__cmpbuf_2:
[00004318] b508                      cmpm.b     (a0)+,(a2)+
[0000431a] 56c9 fffc                 dbne       d1,__cmpbuf_2
[0000431e] 56c8 fff8                 dbne       d0,__cmpbuf_2
[00004322] 6604                      bne.s      __cmpbuf_3
__cmpbuf_1:
[00004324] 7e01                      moveq.l    #1,d7
[00004326] 4e75                      rts
__cmpbuf_3:
[00004328] 7e00                      moveq.l    #0,d7
[0000432a] 4e75                      rts

__range:
[0000432c] 4e56 fffc                 link       a6,#-4
[00004330] 4ab9 0002 0c6e            tst.l      $00025882
[00004336] 6726                      beq.s      __range_1
[00004338] 7022                      moveq.l    #34,d0
[0000433a] 23c0 0002 0064            move.l     d0,_errno
[00004340] 4297                      clr.l      (a7)
[00004342] 2f2e 0008                 move.l     8(a6),-(a7)
[00004346] 4eb9 0000 43b4            jsr        __remark
[0000434c] 588f                      addq.l     #4,a7
[0000434e] 2c39 0002 0a50            move.l     _huge,d6
[00004354] 2e39 0002 0a54            move.l     $00025668,d7
[0000435a] 4e5e                      unlk       a6
[0000435c] 4e75                      rts
__range_1:
[0000435e] 23ee 0008 0002 0c6e       move.l     8(a6),$00025882
[00004366] 2ebc 0002 0c6e            move.l     #$00025882,(a7)
[0000436c] 42a7                      clr.l      -(a7)
[0000436e] 4eb9 0000 44d4            jsr        __raise
[00004374] 588f                      addq.l     #4,a7
[00004376] 4e5e                      unlk       a6
[00004378] 4e75                      rts

x437a:
[0000437a] 4e56 0000                 link       a6,#0
[0000437e] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00004382] 2a6e 0008                 movea.l    8(a6),a5
[00004386] 2e0d                      move.l     a5,d7
[00004388] 6722                      beq.s      x437a_1
[0000438a] 4a15                      tst.b      (a5)
[0000438c] 671e                      beq.s      x437a_1
[0000438e] 284d                      movea.l    a5,a4
x437a_3:
[00004390] 4a14                      tst.b      (a4)
[00004392] 6704                      beq.s      x437a_2
[00004394] 528c                      addq.l     #1,a4
[00004396] 60f8                      bra.s      x437a_3
x437a_2:
[00004398] 2e0c                      move.l     a4,d7
[0000439a] 9e8d                      sub.l      a5,d7
[0000439c] 2e87                      move.l     d7,(a7)
[0000439e] 2f0d                      move.l     a5,-(a7)
[000043a0] 4878 0002                 pea.l      ($00000002).w
[000043a4] 4eb9 0000 4632            jsr        __write
[000043aa] 508f                      addq.l     #8,a7
x437a_1:
[000043ac] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000043b0] 4e5e                      unlk       a6
[000043b2] 4e75                      rts

__remark:
[000043b4] 4e56 fffc                 link       a6,#-4
[000043b8] 2eb9 0002 0aba            move.l     _pname,(a7)
[000043be] 4eba ffba                 jsr        $0000437A(pc)
[000043c2] 2ebc 0002 0a4a            move.l     #$0002565E,(a7)
[000043c8] 4eba ffb0                 jsr        $0000437A(pc)
[000043cc] 2eae 0008                 move.l     8(a6),(a7)
[000043d0] 4eba ffa8                 jsr        $0000437A(pc)
[000043d4] 2eae 000c                 move.l     12(a6),(a7)
[000043d8] 4eba ffa0                 jsr        $0000437A(pc)
[000043dc] 2ebc 0002 0a4d            move.l     #$00025661,(a7)
[000043e2] 4eba ff96                 jsr        $0000437A(pc)
[000043e6] 7e00                      moveq.l    #0,d7
[000043e8] 4e5e                      unlk       a6
[000043ea] 4e75                      rts

__lstat:
[000043ec] 7005                      moveq.l    #5,d0
[000043ee] 23c0 0002 0c42            move.l     d0,$00025856 _timezone
[000043f4] 7001                      moveq.l    #1,d0
[000043f6] 23c0 0002 0c3a            move.l     d0,$0002584E
[000043fc] 23fc 0002 0a74 0002 0c66  move.l     #$00025688,$0002587A
[00004406] 23fc 0002 0a81 0002 0c6a  move.l     #$00025695,$0002587E
[00004410] 23fc 0002 0a8b 0002 0c6e  move.l     #$0002569F,$00025882
[0000441a] 7001                      moveq.l    #1,d0
[0000441c] 23c0 0002 0c72            move.l     d0,$00025886
[00004422] 23fc 0002 0cba 0002 0c76  move.l     #$000258CE,$0002588A
[0000442c] 42b9 0002 0c82            clr.l      $00025896
[00004432] 33fc 0002 0002 0c86       move.w     #$0002,$0002589A
[0000443a] 33fc 0208 0002 0c88       move.w     #$0208,$0002589C
[00004442] 42b9 0002 0c8a            clr.l      $0002589E
[00004448] 23fc 0000 0200 0002 0c8e  move.l     #$00000200,$000258A2
[00004452] 42b9 0002 0c92            clr.l      $000258A6
[00004458] 42b9 0002 0c96            clr.l      $000258AA
[0000445e] 42b9 0002 0c9a            clr.l      $000258AE
[00004464] 42b9 0002 0c9e            clr.l      $000258B2
[0000446a] 4279 0002 0ca2            clr.w      $000258B6
[00004470] 33fc 0004 0002 0ca4       move.w     #$0004,$000258B8
[00004478] 42b9 0002 0ca6            clr.l      $000258BA
[0000447e] 23fc 0000 0200 0002 0caa  move.l     #$00000200,$000258BE
[00004488] 42b9 0002 0cae            clr.l      $000258C2
[0000448e] 42b9 0002 0cb2            clr.l      $000258C6
[00004494] 42b9 0002 0cb6            clr.l      $000258CA
[0000449a] 42b9 0002 0cba            clr.l      $000258CE
[000044a0] 33fc 0001 0002 0cbe       move.w     #$0001,$000258D2
[000044a8] 33fc 0008 0002 0cc0       move.w     #$0008,$000258D4
[000044b0] 42b9 0002 0cc2            clr.l      $000258D6
[000044b6] 23fc 0000 0200 0002 0cc6  move.l     #$00000200,$000258DA
[000044c0] 42b9 0002 0cca            clr.l      $000258DE
[000044c6] 42b9 0002 0cce            clr.l      $000258E2
[000044cc] 42b9 0002 0cd2            clr.l      $000258E6
[000044d2] 4e75                      rts

__raise:
[000044d4] 246f 0004                 movea.l    4(a7),a2
[000044d8] 262f 0008                 move.l     8(a7),d3
[000044dc] 2803                      move.l     d3,d4
[000044de] 670c                      beq.s      __raise_1
[000044e0] 280a                      move.l     a2,d4
[000044e2] 0c83 ffff ffff            cmpi.l     #$FFFFFFFF,d3
[000044e8] 6602                      bne.s      __raise_1
[000044ea] 4283                      clr.l      d3
__raise_1:
[000044ec] 200a                      move.l     a2,d0
[000044ee] 6708                      beq.s      __raise_2
[000044f0] b5fc ffff ffff            cmpa.l     #$FFFFFFFF,a2
[000044f6] 660a                      bne.s      __raise_3
__raise_2:
[000044f8] 2479 0002 0a98            movea.l    $000256AC,a2
[000044fe] 200a                      move.l     a2,d0
[00004500] 674e                      beq.s      __raise_4
__raise_3:
[00004502] 4a83                      tst.l      d3
[00004504] 6626                      bne.s      __raise_5
[00004506] 4287                      clr.l      d7
__raise_12:
[00004508] 2e4a                      movea.l    a2,a7
[0000450a] 4a84                      tst.l      d4
[0000450c] 6600 0096                 bne        __raise_6
[00004510] 202a 0028                 move.l     40(a2),d0
[00004514] 6704                      beq.s      __raise_7
[00004516] 2040                      movea.l    d0,a0
[00004518] 2083                      move.l     d3,(a0)
__raise_7:
[0000451a] 23df 0002 0a98            move.l     (a7)+,$000256AC
[00004520] 4cdf 783a                 movem.l    (a7)+,d1/d3-d5/a3-a6
[00004524] 4e75                      rts
__raise_8:
[00004526] 2452                      movea.l    (a2),a2
[00004528] 200a                      move.l     a2,d0
[0000452a] 6724                      beq.s      __raise_4
__raise_5:
[0000452c] 41ea 002c                 lea.l      44(a2),a0
[00004530] 2e08                      move.l     a0,d7
__raise_11:
[00004532] 0c90 ffff ffff            cmpi.l     #$FFFFFFFF,(a0)
[00004538] 67ec                      beq.s      __raise_8
[0000453a] 4a98                      tst.l      (a0)+
[0000453c] 6604                      bne.s      __raise_9
[0000453e] 4284                      clr.l      d4
[00004540] 6006                      bra.s      __raise_10
__raise_9:
[00004542] b6a8 fffc                 cmp.l      -4(a0),d3
[00004546] 66ea                      bne.s      __raise_11
__raise_10:
[00004548] 9e88                      sub.l      a0,d7
[0000454a] 4487                      neg.l      d7
[0000454c] e487                      asr.l      #2,d7
[0000454e] 60b8                      bra.s      __raise_12
__raise_4:
[00004550] 42a7                      clr.l      -(a7)
[00004552] 4a83                      tst.l      d3
[00004554] 6706                      beq.s      __raise_13
[00004556] 0803 0000                 btst       #0,d3
[0000455a] 6706                      beq.s      __raise_14
__raise_13:
[0000455c] 263c 0002 0a9c            move.l     #$000256B0,d3
__raise_14:
[00004562] 2043                      movea.l    d3,a0
[00004564] 2f10                      move.l     (a0),-(a7)
[00004566] 4eb9 0000 45f0            jsr        __error
__raise_15:
[0000456c] 4e71                      nop
[0000456e] 60fc                      bra.s      __raise_15
__raise_6: ; not found: 000045a4

__when:
[00004570] 2039 0002 0a98            move.l     $000256AC,d0
[00004576] 720c                      moveq.l    #12,d1
[00004578] 48e7 dc1e                 movem.l    d0-d1/d3-d5/a3-a6,-(a7)
[0000457c] 244f                      movea.l    a7,a2
[0000457e] 202a 0028                 move.l     40(a2),d0
[00004582] 6704                      beq.s      __when_1
[00004584] 2040                      movea.l    d0,a0
[00004586] 208a                      move.l     a2,(a0)
__when_1:
[00004588] 41ea 002c                 lea.l      44(a2),a0
__when_3:
[0000458c] 4a90                      tst.l      (a0)
[0000458e] 6712                      beq.s      __when_2
[00004590] 0c98 ffff ffff            cmpi.l     #$FFFFFFFF,(a0)+
[00004596] 670a                      beq.s      __when_2
[00004598] 06aa 0000 0004 0004       addi.l     #$00000004,4(a2)
[000045a0] 60ea                      bra.s      __when_3
__when_2:
[000045a2] 7eff                      moveq.l    #-1,d7
[000045a4] 23ca 0002 0a98            move.l     a2,$000256AC
[000045aa] 206a 0024                 movea.l    36(a2),a0
[000045ae] 4cd2 783b                 movem.l    (a2),d0-d1/d3-d5/a3-a6
[000045b2] 9fc1                      suba.l     d1,a7
[000045b4] 4ed0                      jmp        (a0)
[000045b6] 4e56 0000                 link       a6,#0
[000045ba] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000045be] 2a6e 0008                 movea.l    8(a6),a5
[000045c2] 2e0d                      move.l     a5,d7
[000045c4] 6722                      beq.s      __when_4
[000045c6] 4a15                      tst.b      (a5)
[000045c8] 671e                      beq.s      __when_4
[000045ca] 284d                      movea.l    a5,a4
__when_6:
[000045cc] 4a14                      tst.b      (a4)
[000045ce] 6704                      beq.s      __when_5
[000045d0] 528c                      addq.l     #1,a4
[000045d2] 60f8                      bra.s      __when_6
__when_5:
[000045d4] 2e0c                      move.l     a4,d7
[000045d6] 9e8d                      sub.l      a5,d7
[000045d8] 2e87                      move.l     d7,(a7)
[000045da] 2f0d                      move.l     a5,-(a7)
[000045dc] 4878 0002                 pea.l      ($00000002).w
[000045e0] 4eb9 0000 4632            jsr        __write
[000045e6] 508f                      addq.l     #8,a7
__when_4:
[000045e8] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000045ec] 4e5e                      unlk       a6
[000045ee] 4e75                      rts

__error:
[000045f0] 4e56 fffc                 link       a6,#-4
[000045f4] 2eb9 0002 0aba            move.l     _pname,(a7)
[000045fa] 4eba ffba                 jsr        $000045B6(pc)
[000045fe] 2ebc 0002 0ab4            move.l     #$000256C8,(a7)
[00004604] 4eba ffb0                 jsr        $000045B6(pc)
[00004608] 2eae 0008                 move.l     8(a6),(a7)
[0000460c] 4eba ffa8                 jsr        $000045B6(pc)
[00004610] 2eae 000c                 move.l     12(a6),(a7)
[00004614] 4eba ffa0                 jsr        $000045B6(pc)
[00004618] 2ebc 0002 0ab7            move.l     #$000256CB,(a7)
[0000461e] 4eba ff96                 jsr        $000045B6(pc)
[00004622] 4878 0001                 pea.l      ($00000001).w
[00004626] 4eb9 0000 004a            jsr        _exit
[0000462c] 588f                      addq.l     #4,a7
[0000462e] 4e5e                      unlk       a6
[00004630] 4e75                      rts

__write:
[00004632] 205f                      movea.l    (a7)+,a0
[00004634] 7e04                      moveq.l    #4,d7
[00004636] 4e41                      trap       #1
[00004638] 6400 0008                 bcc.w      __write_1
[0000463c] 4ef9 0000 009a            jmp        seterr
__write_1:
[00004642] 4ed0                      jmp        (a0)

a~1sub:
[00004644] 4e56 fff0                 link       a6,#-16
[00004648] 48e7 6310                 movem.l    d1-d2/d6-d7/a3,-(a7)
[0000464c] 47d7                      lea.l      (a7),a3
[0000464e] 2008                      move.l     a0,d0
[00004650] 661e                      bne.s      a~1sub_1
[00004652] 222f 0008                 move.l     8(a7),d1
[00004656] 242f 000c                 move.l     12(a7),d2
[0000465a] 0841 001f                 bchg       #31,d1
[0000465e] 604a                      bra.s      a~1sub_2
a~1sub_1: ; not found: 00004670
a~1sub_2: ; not found: 000046aa

a~6sub_1:
a~6sub:
[00004660] 4e56 fff0                 link       a6,#-16
[00004664] 48e7 6310                 movem.l    d1-d2/d6-d7/a3,-(a7)
[00004668] 47ef 0008                 lea.l      8(a7),a3
[0000466c] 2008                      move.l     a0,d0
[0000466e] 67ea                      beq.s      a~6sub_1
[00004670] 2210                      move.l     (a0),d1
[00004672] 2428 0004                 move.l     4(a0),d2
[00004676] 0841 001f                 bchg       #31,d1
[0000467a] 602e                      bra.s      a~6sub_2
a~6sub_2: ; not found: 000046aa

a~1add:
[0000467c] 4e56 fff0                 link       a6,#-16
[00004680] 48e7 6310                 movem.l    d1-d2/d6-d7/a3,-(a7)
[00004684] 47d7                      lea.l      (a7),a3
[00004686] 2008                      move.l     a0,d0
[00004688] 661a                      bne.s      a~1add_1
[0000468a] 222f 0008                 move.l     8(a7),d1
[0000468e] 242f 000c                 move.l     12(a7),d2
[00004692] 6016                      bra.s      a~1add_2
a~1add_1: ; not found: 000046a4
a~1add_2: ; not found: 000046aa

a~6add:
[00004694] 4e56 fff0                 link       a6,#-16
[00004698] 48e7 6310                 movem.l    d1-d2/d6-d7/a3,-(a7)
[0000469c] 47ef 0008                 lea.l      8(a7),a3
[000046a0] 2008                      move.l     a0,d0
[000046a2] 6706                      beq.s      a~6add_1
[000046a4] 2210                      move.l     (a0),d1
[000046a6] 2428 0004                 move.l     4(a0),d2
a~6add_1:
[000046aa] 2d41 fff0                 move.l     d1,-16(a6)
[000046ae] 4eb9 0000 4b46            jsr        a~unpk
[000046b4] 6700 00c0                 beq        a~6add_2
[000046b8] d482                      add.l      d2,d2
[000046ba] d381                      addx.l     d1,d1
[000046bc] d482                      add.l      d2,d2
[000046be] d381                      addx.l     d1,d1
[000046c0] 5547                      subq.w     #2,d7
[000046c2] 3d47 fffc                 move.w     d7,-4(a6)
[000046c6] 2d41 fff4                 move.l     d1,-12(a6)
[000046ca] 2d42 fff8                 move.l     d2,-8(a6)
[000046ce] 2213                      move.l     (a3),d1
[000046d0] 242b 0004                 move.l     4(a3),d2
[000046d4] 4eb9 0000 4b46            jsr        a~unpk
[000046da] 660a                      bne.s      a~6add_3
a~6add_9:
[000046dc] 222e fff4                 move.l     -12(a6),d1
[000046e0] 242e fff8                 move.l     -8(a6),d2
[000046e4] 607c                      bra.s      a~6add_4
a~6add_3:
[000046e6] d482                      add.l      d2,d2
[000046e8] d381                      addx.l     d1,d1
[000046ea] d482                      add.l      d2,d2
[000046ec] d381                      addx.l     d1,d1
[000046ee] 5547                      subq.w     #2,d7
[000046f0] 2013                      move.l     (a3),d0
[000046f2] 2c2e fff0                 move.l     -16(a6),d6
[000046f6] b186                      eor.l      d0,d6
[000046f8] 6c0e                      bge.s      a~6add_5
[000046fa] 44ae fff8                 neg.l      -8(a6)
[000046fe] 40ae fff4                 negx.l     -12(a6)
[00004702] 086e 0007 fff0            bchg       #7,-16(a6)
a~6add_5:
[00004708] 9e6e fffc                 sub.w      -4(a6),d7
[0000470c] 674a                      beq.s      a~6add_6
[0000470e] 6e04                      bgt.s      a~6add_7
[00004710] 4447                      neg.w      d7
[00004712] 601a                      bra.s      a~6add_8
a~6add_7:
[00004714] df6e fffc                 add.w      d7,-4(a6)
[00004718] 48e7 e000                 movem.l    d0-d2,-(a7)
[0000471c] 4cee 0007 fff0            movem.l    -16(a6),d0-d2
[00004722] 2d5f fff0                 move.l     (a7)+,-16(a6)
[00004726] 2d5f fff4                 move.l     (a7)+,-12(a6)
[0000472a] 2d5f fff8                 move.l     (a7)+,-8(a6)
a~6add_8:
[0000472e] 0c47 0038                 cmpi.w     #$0038,d7
[00004732] 6ca8                      bge.s      a~6add_9
[00004734] 0c47 0020                 cmpi.w     #$0020,d7
[00004738] 6d0e                      blt.s      a~6add_10
[0000473a] 2401                      move.l     d1,d2
[0000473c] d281                      add.l      d1,d1
[0000473e] 9381                      subx.l     d1,d1
[00004740] 0447 0020                 subi.w     #$0020,d7
[00004744] eea2                      asr.l      d7,d2
[00004746] 6010                      bra.s      a~6add_6
a~6add_10:
[00004748] 7cff                      moveq.l    #-1,d6
[0000474a] efae                      lsl.l      d7,d6
[0000474c] c486                      and.l      d6,d2
[0000474e] 4686                      not.l      d6
[00004750] cc81                      and.l      d1,d6
[00004752] d486                      add.l      d6,d2
[00004754] eea1                      asr.l      d7,d1
[00004756] eeba                      ror.l      d7,d2
a~6add_6:
[00004758] 202e fff4                 move.l     -12(a6),d0
[0000475c] d4ae fff8                 add.l      -8(a6),d2
[00004760] d380                      addx.l     d0,d1
a~6add_4:
[00004762] 202e fff0                 move.l     -16(a6),d0
[00004766] 3e2e fffc                 move.w     -4(a6),d7
[0000476a] 4eb9 0000 4b92            jsr        a~repk
[00004770] 2742 0004                 move.l     d2,4(a3)
[00004774] 2681                      move.l     d1,(a3)
a~6add_2:
[00004776] 4cdf 08c6                 movem.l    (a7)+,d1-d2/d6-d7/a3
[0000477a] 4e5e                      unlk       a6
[0000477c] 4e75                      rts

a~1cmp:
[0000477e] 48e7 6310                 movem.l    d1-d2/d6-d7/a3,-(a7)
[00004782] 47d7                      lea.l      (a7),a3
[00004784] 2008                      move.l     a0,d0
[00004786] 6614                      bne.s      a~1cmp_1
[00004788] 41ef 0008                 lea.l      8(a7),a0
[0000478c] 600e                      bra.s      a~1cmp_1
a~1cmp_1: ; not found: 0000479c

a~6cmp:
[0000478e] 48e7 6310                 movem.l    d1-d2/d6-d7/a3,-(a7)
[00004792] 47ef 0008                 lea.l      8(a7),a3
[00004796] 2008                      move.l     a0,d0
[00004798] 6602                      bne.s      a~6cmp_1
[0000479a] 41d7                      lea.l      (a7),a0
a~6cmp_1:
[0000479c] 2018                      move.l     (a0)+,d0
[0000479e] 6c06                      bge.s      a~6cmp_2
[000047a0] 4480                      neg.l      d0
[000047a2] 0840 001f                 bchg       #31,d0
a~6cmp_2:
[000047a6] 221b                      move.l     (a3)+,d1
[000047a8] 6c06                      bge.s      a~6cmp_3
[000047aa] 4481                      neg.l      d1
[000047ac] 0841 001f                 bchg       #31,d1
a~6cmp_3:
[000047b0] b280                      cmp.l      d0,d1
[000047b2] 6618                      bne.s      a~6cmp_4
[000047b4] 4a80                      tst.l      d0
[000047b6] 6c08                      bge.s      a~6cmp_5
[000047b8] b788                      cmpm.l     (a0)+,(a3)+
[000047ba] 6710                      beq.s      a~6cmp_4
[000047bc] 6508                      bcs.s      a~6cmp_6
[000047be] 600a                      bra.s      a~6cmp_7
a~6cmp_5:
[000047c0] b788                      cmpm.l     (a0)+,(a3)+
[000047c2] 6708                      beq.s      a~6cmp_4
[000047c4] 6504                      bcs.s      a~6cmp_7
a~6cmp_6:
[000047c6] 7001                      moveq.l    #1,d0
[000047c8] 6002                      bra.s      a~6cmp_4
a~6cmp_7:
[000047ca] 70ff                      moveq.l    #-1,d0
a~6cmp_4:
[000047cc] 4fef 0010                 lea.l      16(a7),a7
[000047d0] 4cdf 0800                 movem.l    (a7)+,a3
[000047d4] 4e75                      rts

a~1div:
[000047d6] 4e56 fff8                 link       a6,#-8
[000047da] 48e7 7b10                 movem.l    d1-d4/d6-d7/a3,-(a7)
[000047de] 47d7                      lea.l      (a7),a3
[000047e0] 2008                      move.l     a0,d0
[000047e2] 661a                      bne.s      a~1div_1
[000047e4] 222f 0010                 move.l     16(a7),d1
[000047e8] 242f 0014                 move.l     20(a7),d2
[000047ec] 6016                      bra.s      a~1div_2
a~1div_1: ; not found: 000047fe
a~1div_2: ; not found: 00004804

a~6div:
[000047ee] 4e56 fff8                 link       a6,#-8
[000047f2] 48e7 7b10                 movem.l    d1-d4/d6-d7/a3,-(a7)
[000047f6] 47ef 0010                 lea.l      16(a7),a3
[000047fa] 2008                      move.l     a0,d0
[000047fc] 6706                      beq.s      a~6div_1
[000047fe] 2210                      move.l     (a0),d1
[00004800] 2428 0004                 move.l     4(a0),d2
a~6div_1:
[00004804] 2d41 fff8                 move.l     d1,-8(a6)
[00004808] 4eb9 0000 4b46            jsr        a~unpk
[0000480e] 6618                      bne.s      a~6div_2
[00004810] 70ff                      moveq.l    #-1,d0
[00004812] 2680                      move.l     d0,(a3)
[00004814] 2740 0004                 move.l     d0,4(a3)
[00004818] 4a2e fff8                 tst.b      -8(a6)
[0000481c] 6d00 0084                 blt        a~6div_3
[00004820] 0a13 0080                 eori.b     #$80,(a3)
[00004824] 6000 007c                 bra.w      a~6div_3
a~6div_2:
[00004828] 2601                      move.l     d1,d3
[0000482a] 2802                      move.l     d2,d4
[0000482c] 3d47 fffc                 move.w     d7,-4(a6)
[00004830] 2213                      move.l     (a3),d1
[00004832] 242b 0004                 move.l     4(a3),d2
[00004836] 022e 0080 fff8            andi.b     #$80,-8(a6)
[0000483c] d3ae fff8                 add.l      d1,-8(a6)
[00004840] 4eb9 0000 4b46            jsr        a~unpk
[00004846] 6700 005a                 beq.w      a~6div_3
[0000484a] 9e6e fffc                 sub.w      -4(a6),d7
[0000484e] 0647 03fe                 addi.w     #$03FE,d7
[00004852] 3d47 fffc                 move.w     d7,-4(a6)
[00004856] 2c01                      move.l     d1,d6
[00004858] 2e02                      move.l     d2,d7
[0000485a] 7200                      moveq.l    #0,d1
[0000485c] 7400                      moveq.l    #0,d2
[0000485e] 7015                      moveq.l    #21,d0
a~6div_6:
[00004860] 9e84                      sub.l      d4,d7
[00004862] 9d83                      subx.l     d3,d6
[00004864] 6406                      bcc.s      a~6div_4
[00004866] de84                      add.l      d4,d7
[00004868] dd83                      addx.l     d3,d6
[0000486a] 6002                      bra.s      a~6div_5
a~6div_4:
[0000486c] 01c1                      bset       d0,d1
a~6div_5:
[0000486e] de87                      add.l      d7,d7
[00004870] dd86                      addx.l     d6,d6
[00004872] 51c8 ffec                 dbf        d0,a~6div_6
[00004876] 701f                      moveq.l    #31,d0
a~6div_9:
[00004878] 9e84                      sub.l      d4,d7
[0000487a] 9d83                      subx.l     d3,d6
[0000487c] 6406                      bcc.s      a~6div_7
[0000487e] de84                      add.l      d4,d7
[00004880] dd83                      addx.l     d3,d6
[00004882] 6002                      bra.s      a~6div_8
a~6div_7:
[00004884] 01c2                      bset       d0,d2
a~6div_8:
[00004886] de87                      add.l      d7,d7
[00004888] dd86                      addx.l     d6,d6
[0000488a] 51c8 ffec                 dbf        d0,a~6div_9
[0000488e] 202e fff8                 move.l     -8(a6),d0
[00004892] 3e2e fffc                 move.w     -4(a6),d7
[00004896] 4eb9 0000 4b92            jsr        a~repk
[0000489c] 2742 0004                 move.l     d2,4(a3)
[000048a0] 2681                      move.l     d1,(a3)
a~6div_3:
[000048a2] 4cdf 08de                 movem.l    (a7)+,d1-d4/d6-d7/a3
[000048a6] 4e5e                      unlk       a6
[000048a8] 4e75                      rts

a~1mul:
[000048aa] 4e56 ffe8                 link       a6,#-24
[000048ae] 48e7 7f30                 movem.l    d1-d7/a2-a3,-(a7)
[000048b2] 47d7                      lea.l      (a7),a3
[000048b4] 2008                      move.l     a0,d0
[000048b6] 661a                      bne.s      a~1mul_1
[000048b8] 222f 0014                 move.l     20(a7),d1
[000048bc] 242f 0018                 move.l     24(a7),d2
[000048c0] 6016                      bra.s      a~1mul_2
a~1mul_1: ; not found: 000048d2
a~1mul_2: ; not found: 000048d8

a~6mul:
[000048c2] 4e56 ffe8                 link       a6,#-24
[000048c6] 48e7 7f30                 movem.l    d1-d7/a2-a3,-(a7)
[000048ca] 47ef 0014                 lea.l      20(a7),a3
[000048ce] 2008                      move.l     a0,d0
[000048d0] 6706                      beq.s      a~6mul_1
[000048d2] 2210                      move.l     (a0),d1
[000048d4] 2428 0004                 move.l     4(a0),d2
a~6mul_1:
[000048d8] 2d41 ffe8                 move.l     d1,-24(a6)
[000048dc] 4eb9 0000 4b46            jsr        a~unpk
[000048e2] 6608                      bne.s      a~6mul_2
[000048e4] 429b                      clr.l      (a3)+
[000048e6] 4293                      clr.l      (a3)
[000048e8] 6000 0094                 bra        a~6mul_3
a~6mul_2:
[000048ec] 2d41 fff0                 move.l     d1,-16(a6)
[000048f0] 2d42 fff4                 move.l     d2,-12(a6)
[000048f4] 3d47 ffec                 move.w     d7,-20(a6)
[000048f8] 2213                      move.l     (a3),d1
[000048fa] 242b 0004                 move.l     4(a3),d2
[000048fe] 022e 0080 ffe8            andi.b     #$80,-24(a6)
[00004904] d3ae ffe8                 add.l      d1,-24(a6)
[00004908] 4eb9 0000 4b46            jsr        a~unpk
[0000490e] 676e                      beq.s      a~6mul_3
[00004910] 2d41 fff8                 move.l     d1,-8(a6)
[00004914] 2d42 fffc                 move.l     d2,-4(a6)
[00004918] 0447 0403                 subi.w     #$0403,d7
[0000491c] df6e ffec                 add.w      d7,-20(a6)
[00004920] 7600                      moveq.l    #0,d3
[00004922] 41ee fff4                 lea.l      -12(a6),a0
[00004926] 45ee fffc                 lea.l      -4(a6),a2
[0000492a] 615a                      bsr.s      $00004986
[0000492c] 2006                      move.l     d6,d0
[0000492e] 7400                      moveq.l    #0,d2
[00004930] 7200                      moveq.l    #0,d1
[00004932] 41ee fff4                 lea.l      -12(a6),a0
[00004936] 45ee fff8                 lea.l      -8(a6),a2
[0000493a] 614a                      bsr.s      $00004986
[0000493c] d087                      add.l      d7,d0
[0000493e] d586                      addx.l     d6,d2
[00004940] d383                      addx.l     d3,d1
[00004942] 41ee fff0                 lea.l      -16(a6),a0
[00004946] 45ee fffc                 lea.l      -4(a6),a2
[0000494a] 613a                      bsr.s      $00004986
[0000494c] d087                      add.l      d7,d0
[0000494e] d586                      addx.l     d6,d2
[00004950] d383                      addx.l     d3,d1
[00004952] 41ee fff0                 lea.l      -16(a6),a0
[00004956] 45ee fff8                 lea.l      -8(a6),a2
[0000495a] 612a                      bsr.s      $00004986
[0000495c] d487                      add.l      d7,d2
[0000495e] d386                      addx.l     d6,d1
[00004960] 4840                      swap       d0
[00004962] 4842                      swap       d2
[00004964] 4841                      swap       d1
[00004966] 3202                      move.w     d2,d1
[00004968] 3400                      move.w     d0,d2
[0000496a] 202e ffe8                 move.l     -24(a6),d0
[0000496e] 3e2e ffec                 move.w     -20(a6),d7
[00004972] 4eb9 0000 4b92            jsr        a~repk
[00004978] 2742 0004                 move.l     d2,4(a3)
[0000497c] 2681                      move.l     d1,(a3)
a~6mul_3:
[0000497e] 4cdf 0cfe                 movem.l    (a7)+,d1-d7/a2-a3
[00004982] 4e5e                      unlk       a6
[00004984] 4e75                      rts

x4986:
[00004986] 3e2a 0002                 move.w     2(a2),d7
[0000498a] ced0                      mulu.w     (a0),d7
[0000498c] 3c12                      move.w     (a2),d6
[0000498e] cce8 0002                 mulu.w     2(a0),d6
[00004992] de86                      add.l      d6,d7
[00004994] 7c00                      moveq.l    #0,d6
[00004996] dd46                      addx.w     d6,d6
[00004998] 4846                      swap       d6
[0000499a] 4847                      swap       d7
[0000499c] 3c07                      move.w     d7,d6
[0000499e] 4247                      clr.w      d7
[000049a0] 381a                      move.w     (a2)+,d4
[000049a2] c8d8                      mulu.w     (a0)+,d4
[000049a4] 3a12                      move.w     (a2),d5
[000049a6] cad0                      mulu.w     (a0),d5
[000049a8] de85                      add.l      d5,d7
[000049aa] dd84                      addx.l     d4,d6
[000049ac] 4e75                      rts

a~1dtl:
[000049ae] 48e7 7300                 movem.l    d1-d3/d6-d7,-(a7)
[000049b2] 6008                      bra.s      a~1dtl_1
a~1dtl_1: ; not found: 000049bc

a~6dtl:
[000049b4] 48e7 7300                 movem.l    d1-d3/d6-d7,-(a7)
[000049b8] 2206                      move.l     d6,d1
[000049ba] 2407                      move.l     d7,d2
[000049bc] 2601                      move.l     d1,d3
[000049be] 4eb9 0000 4b46            jsr        a~unpk
[000049c4] 0c47 03fe                 cmpi.w     #$03FE,d7
[000049c8] 6e04                      bgt.s      a~6dtl_1
a~6dtl_5:
[000049ca] 7000                      moveq.l    #0,d0
[000049cc] 6030                      bra.s      a~6dtl_2
a~6dtl_1:
[000049ce] 2001                      move.l     d1,d0
[000049d0] 0c47 0413                 cmpi.w     #$0413,d7
[000049d4] 6e0a                      bgt.s      a~6dtl_3
[000049d6] 4447                      neg.w      d7
[000049d8] 0647 0413                 addi.w     #$0413,d7
[000049dc] eea8                      lsr.l      d7,d0
[000049de] 6018                      bra.s      a~6dtl_4
a~6dtl_3:
[000049e0] 0c47 0433                 cmpi.w     #$0433,d7
[000049e4] 6ee4                      bgt.s      a~6dtl_5
[000049e6] 0447 0413                 subi.w     #$0413,d7
[000049ea] 7cff                      moveq.l    #-1,d6
[000049ec] eeae                      lsr.l      d7,d6
[000049ee] c086                      and.l      d6,d0
[000049f0] 4686                      not.l      d6
[000049f2] cc82                      and.l      d2,d6
[000049f4] d086                      add.l      d6,d0
[000049f6] efb8                      rol.l      d7,d0
a~6dtl_4:
[000049f8] 4a83                      tst.l      d3
[000049fa] 6c02                      bge.s      a~6dtl_2
[000049fc] 4480                      neg.l      d0
a~6dtl_2:
[000049fe] 4a80                      tst.l      d0
[00004a00] 4cdf 00ce                 movem.l    (a7)+,d1-d3/d6-d7
[00004a04] 4e75                      rts

a~jtab:
[00004a06] 2018                      move.l     (a0)+,d0
[00004a08] 6718                      beq.s      a~jtab_1
[00004a0a] 2218                      move.l     (a0)+,d1
[00004a0c] 9e81                      sub.l      d1,d7
[00004a0e] b087                      cmp.l      d7,d0
[00004a10] 6208                      bhi.s      a~jtab_2
[00004a12] de81                      add.l      d1,d7
[00004a14] e588                      lsl.l      #2,d0
[00004a16] d1c0                      adda.l     d0,a0
[00004a18] 60ec                      bra.s      a~jtab
a~jtab_2:
[00004a1a] e58f                      lsl.l      #2,d7
[00004a1c] d1c7                      adda.l     d7,a0
[00004a1e] 2050                      movea.l    (a0),a0
[00004a20] 4ed0                      jmp        (a0)
a~jtab_1:
[00004a22] 2010                      move.l     (a0),d0
[00004a24] 6716                      beq.s      a~jtab_3
[00004a26] 0c80 0000 0009            cmpi.l     #$00000009,d0
[00004a2c] 6414                      bcc.s      a~jtab_4
[00004a2e] 5380                      subq.l     #1,d0
a~jtab_5:
[00004a30] bea8 0008                 cmp.l      8(a0),d7
[00004a34] 6706                      beq.s      a~jtab_3
[00004a36] 5088                      addq.l     #8,a0
[00004a38] 51c8 fff6                 dbf        d0,a~jtab_5
a~jtab_3:
[00004a3c] 2068 0004                 movea.l    4(a0),a0
[00004a40] 4ed0                      jmp        (a0)
a~jtab_4:
[00004a42] 5888                      addq.l     #4,a0
[00004a44] 2200                      move.l     d0,d1
[00004a46] e789                      lsl.l      #3,d1
[00004a48] 45f0 1800                 lea.l      0(a0,d1.l),a2
a~jtab_8:
[00004a4c] 2200                      move.l     d0,d1
[00004a4e] 0201 00fe                 andi.b     #$FE,d1
[00004a52] e589                      lsl.l      #2,d1
[00004a54] beb0 1804                 cmp.l      4(a0,d1.l),d7
[00004a58] 650e                      bcs.s      a~jtab_6
[00004a5a] 6206                      bhi.s      a~jtab_7
[00004a5c] 2070 1800                 movea.l    0(a0,d1.l),a0
[00004a60] 4ed0                      jmp        (a0)
a~jtab_7:
[00004a62] 41f0 1808                 lea.l      8(a0,d1.l),a0
[00004a66] 5380                      subq.l     #1,d0
a~jtab_6:
[00004a68] e288                      lsr.l      #1,d0
[00004a6a] 6ee0                      bgt.s      a~jtab_8
[00004a6c] 2052                      movea.l    (a2),a0
[00004a6e] 4ed0                      jmp        (a0)

a~lmod:
[00004a70] 48e7 7800                 movem.l    d1-d4,-(a7)
[00004a74] 383c ff00                 move.w     #$FF00,d4
[00004a78] 222f 0014                 move.l     20(a7),d1
[00004a7c] 6c14                      bge.s      a~lmod_1
[00004a7e] 4481                      neg.l      d1
[00004a80] 6010                      bra.s      a~lmod_1
a~lmod_1: ; not found: 00004a92

a~ldiv:
[00004a82] 48e7 7800                 movem.l    d1-d4,-(a7)
[00004a86] 4244                      clr.w      d4
[00004a88] 222f 0014                 move.l     20(a7),d1
[00004a8c] 6c04                      bge.s      a~ldiv_1
[00004a8e] 4481                      neg.l      d1
[00004a90] 4604                      not.b      d4
a~ldiv_1:
[00004a92] 202f 0018                 move.l     24(a7),d0
[00004a96] 6c04                      bge.s      a~ldiv_2
[00004a98] 4480                      neg.l      d0
[00004a9a] 4604                      not.b      d4
a~ldiv_2:
[00004a9c] 614e                      bsr.s      $00004AEC
[00004a9e] 4a44                      tst.w      d4
[00004aa0] 6c02                      bge.s      a~ldiv_3
[00004aa2] 2002                      move.l     d2,d0
a~ldiv_3:
[00004aa4] 4a04                      tst.b      d4
[00004aa6] 6702                      beq.s      a~ldiv_4
[00004aa8] 4480                      neg.l      d0
a~ldiv_4:
[00004aaa] 4cdf 001e                 movem.l    (a7)+,d1-d4
[00004aae] 2e9f                      move.l     (a7)+,(a7)
[00004ab0] 2f40 0004                 move.l     d0,4(a7)
[00004ab4] 4e75                      rts

a~ulmod:
[00004ab6] 48e7 7800                 movem.l    d1-d4,-(a7)
[00004aba] 222f 0014                 move.l     20(a7),d1
[00004abe] 202f 0018                 move.l     24(a7),d0
[00004ac2] 6128                      bsr.s      $00004AEC
[00004ac4] 2002                      move.l     d2,d0
[00004ac6] 4cdf 001e                 movem.l    (a7)+,d1-d4
[00004aca] 2e9f                      move.l     (a7)+,(a7)
[00004acc] 2f40 0004                 move.l     d0,4(a7)
[00004ad0] 4e75                      rts

a~uldiv:
[00004ad2] 48e7 7800                 movem.l    d1-d4,-(a7)
[00004ad6] 222f 0014                 move.l     20(a7),d1
[00004ada] 202f 0018                 move.l     24(a7),d0
[00004ade] 610c                      bsr.s      $00004AEC
[00004ae0] 4cdf 001e                 movem.l    (a7)+,d1-d4
[00004ae4] 2e9f                      move.l     (a7)+,(a7)
[00004ae6] 2f40 0004                 move.l     d0,4(a7)
[00004aea] 4e75                      rts

x4aec:
[00004aec] 7400                      moveq.l    #0,d2
[00004aee] 4841                      swap       d1
[00004af0] 6608                      bne.s      x4aec_1
[00004af2] 70ff                      moveq.l    #-1,d0
[00004af4] 74ff                      moveq.l    #-1,d2
[00004af6] 7800                      moveq.l    #0,d4
[00004af8] 4e75                      rts
x4aec_1:
[00004afa] 4a41                      tst.w      d1
[00004afc] 662a                      bne.s      x4aec_2
[00004afe] b081                      cmp.l      d1,d0
[00004b00] 640e                      bcc.s      x4aec_3
[00004b02] 4841                      swap       d1
[00004b04] 80c1                      divu.w     d1,d0
[00004b06] 4840                      swap       d0
[00004b08] 3400                      move.w     d0,d2
[00004b0a] 4240                      clr.w      d0
[00004b0c] 4840                      swap       d0
[00004b0e] 4e75                      rts
x4aec_3:
[00004b10] 4841                      swap       d1
[00004b12] 4840                      swap       d0
[00004b14] 3400                      move.w     d0,d2
[00004b16] 84c1                      divu.w     d1,d2
[00004b18] 3002                      move.w     d2,d0
[00004b1a] 4840                      swap       d0
[00004b1c] 3400                      move.w     d0,d2
[00004b1e] 84c1                      divu.w     d1,d2
[00004b20] 3002                      move.w     d2,d0
[00004b22] 4242                      clr.w      d2
[00004b24] 4842                      swap       d2
[00004b26] 4e75                      rts
x4aec_2:
[00004b28] 4841                      swap       d1
[00004b2a] 4840                      swap       d0
[00004b2c] 3400                      move.w     d0,d2
[00004b2e] 4240                      clr.w      d0
[00004b30] 4840                      swap       d0
[00004b32] 760f                      moveq.l    #15,d3
x4aec_5:
[00004b34] d040                      add.w      d0,d0
[00004b36] d582                      addx.l     d2,d2
[00004b38] b481                      cmp.l      d1,d2
[00004b3a] 6504                      bcs.s      x4aec_4
[00004b3c] 9481                      sub.l      d1,d2
[00004b3e] 5240                      addq.w     #1,d0
x4aec_4:
[00004b40] 51cb fff2                 dbf        d3,x4aec_5
[00004b44] 4e75                      rts

a~unpk:
[00004b46] 2e01                      move.l     d1,d7
[00004b48] 0281 000f ffff            andi.l     #$000FFFFF,d1
[00004b4e] 08c1 0014                 bset       #20,d1
[00004b52] 4847                      swap       d7
[00004b54] e84f                      lsr.w      #4,d7
[00004b56] 0287 0000 07ff            andi.l     #$000007FF,d7
[00004b5c] 6604                      bne.s      a~unpk_1
[00004b5e] 7200                      moveq.l    #0,d1
[00004b60] 7400                      moveq.l    #0,d2
a~unpk_1:
[00004b62] 4e75                      rts

a~1ltd:
[00004b64] 48e7 6310                 movem.l    d1-d2/d6-d7/a3,-(a7)
[00004b68] 47d7                      lea.l      (a7),a3
[00004b6a] 6008                      bra.s      a~1ltd_1
a~1ltd_1: ; not found: 00004b74

a~6ltd:
[00004b6c] 48e7 6310                 movem.l    d1-d2/d6-d7/a3,-(a7)
[00004b70] 47ef 0008                 lea.l      8(a7),a3
[00004b74] 7200                      moveq.l    #0,d1
[00004b76] 2400                      move.l     d0,d2
[00004b78] 6c02                      bge.s      a~6ltd_1
[00004b7a] 4482                      neg.l      d2
a~6ltd_1:
[00004b7c] 3e3c 0433                 move.w     #$0433,d7
[00004b80] 4eb9 0000 4b92            jsr        a~repk
[00004b86] 2742 0004                 move.l     d2,4(a3)
[00004b8a] 2681                      move.l     d1,(a3)
[00004b8c] 4cdf 08c6                 movem.l    (a7)+,d1-d2/d6-d7/a3
[00004b90] 4e75                      rts

a~repk:
[00004b92] 4a81                      tst.l      d1
[00004b94] 6c08                      bge.s      a~repk_1
[00004b96] 0840 001f                 bchg       #31,d0
[00004b9a] 4482                      neg.l      d2
[00004b9c] 4081                      negx.l     d1
a~repk_1:
[00004b9e] 6606                      bne.s      a~repk_2
[00004ba0] 4a82                      tst.l      d2
[00004ba2] 6602                      bne.s      a~repk_2
[00004ba4] 4e75                      rts
a~repk_2:
[00004ba6] 5247                      addq.w     #1,d7
a~repk_6:
[00004ba8] 7c40                      moveq.l    #64,d6
[00004baa] 4846                      swap       d6
a~repk_4:
[00004bac] b286                      cmp.l      d6,d1
[00004bae] 6508                      bcs.s      a~repk_3
[00004bb0] 5247                      addq.w     #1,d7
[00004bb2] e289                      lsr.l      #1,d1
[00004bb4] e292                      roxr.l     #1,d2
[00004bb6] 60f4                      bra.s      a~repk_4
a~repk_3:
[00004bb8] 0c81 0000 1000            cmpi.l     #$00001000,d1
[00004bbe] 640e                      bcc.s      a~repk_5
[00004bc0] 0447 0010                 subi.w     #$0010,d7
[00004bc4] 4841                      swap       d1
[00004bc6] 4842                      swap       d2
[00004bc8] 3202                      move.w     d2,d1
[00004bca] 4242                      clr.w      d2
[00004bcc] 60da                      bra.s      a~repk_6
a~repk_5:
[00004bce] 7c20                      moveq.l    #32,d6
[00004bd0] 4846                      swap       d6
a~repk_8:
[00004bd2] b286                      cmp.l      d6,d1
[00004bd4] 6408                      bcc.s      a~repk_7
[00004bd6] 5347                      subq.w     #1,d7
[00004bd8] d482                      add.l      d2,d2
[00004bda] d381                      addx.l     d1,d1
[00004bdc] 60f4                      bra.s      a~repk_8
a~repk_7:
[00004bde] 5282                      addq.l     #1,d2
[00004be0] 6404                      bcc.s      a~repk_9
[00004be2] 5281                      addq.l     #1,d1
[00004be4] 60c2                      bra.s      a~repk_6
a~repk_9:
[00004be6] 4a47                      tst.w      d7
[00004be8] 6e06                      bgt.s      a~repk_10
[00004bea] 7200                      moveq.l    #0,d1
[00004bec] 7400                      moveq.l    #0,d2
[00004bee] 4e75                      rts
a~repk_10:
[00004bf0] 0c47 07ff                 cmpi.w     #$07FF,d7
[00004bf4] 6d08                      blt.s      a~repk_11
[00004bf6] 72ff                      moveq.l    #-1,d1
[00004bf8] 74ff                      moveq.l    #-1,d2
[00004bfa] 3e3c 07ff                 move.w     #$07FF,d7
a~repk_11:
[00004bfe] d080                      add.l      d0,d0
[00004c00] e291                      roxr.l     #1,d1
[00004c02] e292                      roxr.l     #1,d2
[00004c04] 4841                      swap       d1
[00004c06] 0241 800f                 andi.w     #$800F,d1
[00004c0a] e94f                      lsl.w      #4,d7
[00004c0c] 8247                      or.w       d7,d1
[00004c0e] 4841                      swap       d1
[00004c10] 4e75                      rts

a~tpad:
[00004c12] 4afc                      illegal

	.data
__data:
[00004c14]                           dc.b $00
[00004c15]                           dc.b 'IDR68K Edition 3.2: Copyright (c) 1981, 1983, 1986, 1987 by Whitesmiths, Ltd. all rights reserved',0
[00004c77]                           dc.b $00
__errno:
[00004c78]                           dc.l 0
[00004c7c] 00000068                  dc.l _onexit
_aflag:
[00004c80]                           dc.l 0
_fflag:
[00004c84]                           dc.l 0
_iflag:
[00004c88]                           dc.l 0
_lflag:
[00004c8c]                           dc.l 0
_pflag:
[00004c90]                           dc.l 0
_rflag:
[00004c94]                           dc.l 0
_slp:
[00004c98]                           dc.l 0
_tflag:
[00004c9c]                           dc.l 0
_pu:
[00004ca0]                           dc.l 0
_tinode:
[00004ca4] 00020094                  dc.l $00004ca8 ; no symbol found
[00004ca8]                           dc.b '/dev/inode',0
[00004cb3]                           dc.b $00
_tmount:
[00004cb4] 000200a4                  dc.l $00004cb8 ; no symbol found
[00004cb8]                           dc.b '/dev/mount',0
[00004cc3]                           dc.b $00
_tmyps:
[00004cc4] 000200b4                  dc.l $00004cc8 ; no symbol found
[00004cc8]                           dc.b '/dev/myps',0
_tps:
[00004cd2] 000200c2                  dc.l $00004cd6 ; no symbol found
[00004cd6]                           dc.b '/dev/ps',0
[00004cde]                           dc.b '/dev/bnames',0
[00004cea]                           dc.b '/dev/cnames',0
[00004cf6]                           dc.l 0
[00004cfa]                           dc.l 0
[00004cfe]                           dc.l 0
[00004d02]                           dc.b $00
[00004d03]                           dc.b $00
[00004d04]                           dc.b $00
[00004d05]                           dc.b $00
[00004d06]                           dc.b 'a,f,i,l,p,r,s#,t:F',0
[00004d19]                           dc.b '-[a f i l p r s# t]\n',0
[00004d2e]                           dc.w $0a00
[00004d30]                           dc.b 'inodes:\n',0
[00004d39]                           dc.b 'FLG REF LAST  DEV   INUM    MODE  LNK  SIZE ADDRS\n',0
[00004d6c]                           dc.b '%2d/%2d',0
[00004d74]                           dc.b '%+03o %3i %4s %- 7p %4i',0
[00004d8c]                           dc.b ' %+07o %3i %6l',0
[00004d9b]                           dc.b ' %5i',0
[00004da0]                           dc.w $0a00
device_name:
[00004dab]                           ds.b 25
[00004dc4]                           ds.b 18
stat_names:
[00004dd6] 00020205                  dc.l $00004e19 ; no symbol found
[00004dda] 00020200                  dc.l $00004e14 ; no symbol found
[00004dde] 000201fb                  dc.l $00004e0f ; no symbol found
[00004de2] 000201f6                  dc.l $00004e0a ; no symbol found
[00004de6] 000201f1                  dc.l $00004e05 ; no symbol found
[00004dea] 000201ec                  dc.l $00004e00 ; no symbol found
[00004dee] 000201e7                  dc.l $00004dfb ; no symbol found
[00004df2] 000201e2                  dc.l $00004df6 ; no symbol found
[00004df6]                           dc.b '7   ',0
[00004dfb]                           dc.b 'exit',0
[00004e00]                           dc.b 'shr ',0
[00004e05]                           dc.b 'wait',0
[00004e0a]                           dc.b 'run ',0
[00004e0f]                           dc.b 'exec',0
[00004e14]                           dc.b 'doze',0
[00004e19]                           dc.b '?  ',0
[00004e1d]                           dc.b '  PID  PPID STAT NAME      PRI   NI  BASE WBASE  SIZE   FLAGS   CHANNEL DEV\n',0
[00004e6a]                           dc.b '  PID  PPID STAT NAME    \n',0
[00004e85]                           dc.b 'WIOALMFX',0
[00004e8e]                           dc.b '%d/%d',0
[00004e94]                           dc.b '%5us %5x %4p %- np %4x %4x %5u %5u %5u %- 8p %8x %p\n',0
[00004ec9]                           dc.b '%5us %5x %4p %- np\n',0
[00004edd]                           dc.b 'none',0
[00004ee2]                           dc.b '%d/%d',0
[00004ee8]                           dc.b '%5us %5us %4p %- np %4c %4c %5us %5us %5us %- 8p %8h %p\n',0
[00004f21]                           dc.b '%5us %5us %4p %- np\n',0
[00004f36]                           dc.b '        user=%p ',0
[00004f47]                           dc.b ' pgroup=%i',0
[00004f52]                           dc.b ' free=%i',0
[00004f5b]                           dc.b ' slice=%i',0
[00004f65]                           dc.b ' sig=%p',0
[00004f6d]                           dc.b ' alarm=%i',0
[00004f77]                           dc.b $0a
[00004f78]                           dc.b $00
[00004f79]                           dc.b '        zombie %i %- np',0
[00004f91]                           dc.b ' free=%i',0
[00004f9a]                           dc.b '(success)',0
[00004fa4]                           dc.b '(failure)',0
[00004fae]                           dc.b ' exit status %i %p',0
[00004fc1]                           dc.b $00
[00004fc2]                           dc.b ' -- core dumped',0
[00004fd2]                           dc.b ' signal %p%p',0
[00004fdf]                           dc.b $0a
[00004fe0]                           dc.b $00
[00004fe1]                           dc.b 'can',$27,'t open: ',0
[00004fee]                           dc.b 'device err ',0
[00004ffa]                           dc.b $00
[00004ffb]                           dc.b $00
[00004ffc]                           dc.b $00
[00004ffd]                           dc.b $00
[00004ffe]                           dc.b $00
[00004fff]                           dc.b $00
[00005000]                           dc.b $00
[00005001]                           dc.b $00
[00005002]                           dc.b $00
[00005003]                           dc.b $00
[00005004]                           dc.b $00
[00005005]                           dc.b $00
[00005006]                           dc.b $00
[00005007]                           dc.b $00
[00005008]                           dc.b $00
[00005009]                           dc.b $00
[0000500a]                           dc.b $00
[0000500b]                           dc.b $00
[0000500c]                           dc.b $00
[0000500d]                           dc.b $00
[0000500e]                           dc.b 'hangup',0
[00005015]                           dc.b 'interrupt',0
[0000501f]                           dc.b 'quit',0
[00005024]                           dc.b 'illegal instruction',0
[00005038]                           dc.b 'trace trap',0
[00005043]                           dc.b 'range error',0
[0000504f]                           dc.b 'domain error',0
[0000505c]                           dc.b 'floating point/ aritmetic fault',0
[0000507c]                           dc.b 'kill',0
[00005081]                           dc.b 'bus error',0
[0000508b]                           dc.b 'segementation (bad address) error',0
[000050ad]                           dc.b 'bad system call',0
[000050bd]                           dc.b 'broken pipe',0
[000050c9]                           dc.b 'alarm',0
[000050cf]                           dc.b 'terminate',0
[000050d9]                           dc.b 'system call intercept',0
[000050ef]                           dc.b 'user signal',0
[000050fb]                           dc.b 'signal#%i',0
[00005105]                           dc.b $00
[00005106]                           dc.b $0011
[0000510a]                           dc.b $0001
[0000510e] 00000a0a                  dc.l $00000a0a ; no symbol found
[00005112] 00000a14                  dc.l $00000a14 ; no symbol found
[00005116] 00000a1e                  dc.l $00000a1e ; no symbol found
[0000511a] 00000a28                  dc.l $00000a28 ; no symbol found
[0000511e] 00000a32                  dc.l $00000a32 ; no symbol found
[00005122] 00000a3c                  dc.l $00000a3c ; no symbol found
[00005126] 00000a46                  dc.l $00000a46 ; no symbol found
[0000512a] 00000a50                  dc.l $00000a50 ; no symbol found
[0000512e] 00000a5a                  dc.l $00000a5a ; no symbol found
[00005132] 00000a64                  dc.l $00000a64 ; no symbol found
[00005136] 00000a6e                  dc.l $00000a6e ; no symbol found
[0000513a] 00000a78                  dc.l $00000a78 ; no symbol found
[0000513e] 00000a82                  dc.l $00000a82 ; no symbol found
[00005142] 00000a8c                  dc.l $00000a8c ; no symbol found
[00005146] 00000a96                  dc.l $00000a96 ; no symbol found
[0000514a] 00000aa0                  dc.l $00000aa0 ; no symbol found
[0000514e] 00000aaa                  dc.l $00000aaa ; no symbol found
[00005152]                           dc.l $0000
[00005156]                           dc.l $0000
[0000515a] 00000ab4                  dc.l $00000ab4 ; no symbol found
[0000515e]                           dc.b $00
[0000515f]                           dc.b $00
[00005160]                           dc.b $00
[00005161]                           dc.b $00
[00005162]                           dc.b $00
[00005163]                           dc.b $00
[00005164]                           dc.b $00
[00005165]                           dc.b $00
[00005166]                           dc.b $00
[00005167]                           dc.b $00
[00005168]                           dc.b $00
[00005169]                           dc.b $00
[0000516a]                           dc.b $00
[0000516b]                           dc.b $00
[0000516c]                           dc.b $00
[0000516d]                           dc.b $00
[0000516e]                           dc.b $00
[0000516f]                           dc.b $00
[00005170]                           dc.b $00
[00005171]                           dc.b $00
[00005172]                           dc.w $2569 %i
[00005174]                           dc.b $00
[00005175]                           dc.b $3a
[00005176]                           dc.w $0a00
[00005178]                           dc.w $3a0a
[0000517a]                           dc.b $00
[0000517b]                           dc.b $ff
[0000517c]                           dc.w $3a0a
[0000517e]                           dc.b $00
[0000517f]                           dc.b $72
[00005180]                           dc.b $00
[00005181]                           dc.b '/adm/passwd',0
[0000518d]                           dc.b $3a
[0000518e]                           dc.w $0a00
[00005190]                           dc.w $0a00
[00005192]                           dc.b '/adm/passwd',0
[0000519e]                           dc.b 'bad record in ',0
[000051ad]                           dc.b $00
[000051ae]                           dc.w $2d5b
[000051b0]                           dc.b $00
[000051b1]                           dc.b $20
[000051b2]                           dc.b $00
[000051b3]                           dc.b $5e
[000051b4]                           dc.b $00
[000051b5]                           dc.b $20
[000051b6]                           dc.b $00
[000051b7]                           dc.b $5d
[000051b8]                           dc.b $00
[000051b9]                           dc.b $0a
[000051ba]                           dc.b $00
[000051bb]                           dc.b $2d
[000051bc]                           dc.w $2d00
[000051be]                           dc.w $2d00
[000051c0]                           dc.b 'help',0
[000051c5]                           dc.b $00
[000051c6]                           dc.b $00
[000051c7]                           dc.b $00
[000051c8]                           dc.b $00
[000051c9]                           dc.b $00
[000051ca]                           dc.b $00
[000051cb]                           dc.b $00
[000051cc]                           dc.b $00
[000051cd]                           dc.b $03
[000051ce] 000011de                  dc.l $000011de ; no symbol found
[000051d2]                           dc.b $00
[000051d3]                           dc.b $00
[000051d4]                           dc.b $00
[000051d5]                           dc.b $01
[000051d6] 000011e8                  dc.l $000011e8 ; no symbol found
[000051da]                           dc.b $00
[000051db]                           dc.b $00
[000051dc]                           dc.b $00
[000051dd]                           dc.b $02
[000051de] 000011f2                  dc.l $000011f2 ; no symbol found
[000051e2]                           dc.b $00
[000051e3]                           dc.b $00
[000051e4]                           dc.b $00
[000051e5]                           dc.b $03
[000051e6] 000011fa                  dc.l $000011fa ; no symbol found
[000051ea]                           dc.b $00
[000051eb]                           dc.b $00
[000051ec]                           dc.b $00
[000051ed]                           dc.b $00
[000051ee]                           dc.b $00
[000051ef]                           dc.b $00
[000051f0]                           dc.b $00
[000051f1]                           dc.b $03
[000051f2] 0000128a                  dc.l $0000128a ; no symbol found
[000051f6]                           dc.b $00
[000051f7]                           dc.b $00
[000051f8]                           dc.b $00
[000051f9]                           dc.b $01
[000051fa] 000012a2                  dc.l $000012a2 ; no symbol found
[000051fe]                           dc.b $00
[000051ff]                           dc.b $00
[00005200]                           dc.b $00
[00005201]                           dc.b $02
[00005202] 000012ba                  dc.l $000012ba ; no symbol found
[00005206]                           dc.b $00
[00005207]                           dc.b $00
[00005208]                           dc.b $00
[00005209]                           dc.b $03
[0000520a] 000012d0                  dc.l $000012d0 ; no symbol found
[0000520e]                           dc.b $00
[0000520f]                           dc.b $00
[00005210]                           dc.b $00
[00005211]                           dc.b $00
[00005212]                           dc.b $00
[00005213]                           dc.b $00
[00005214]                           dc.b $00
[00005215]                           dc.b $07
[00005216] 000011ca                  dc.l $000011ca ; no symbol found
[0000521a]                           dc.b $00
[0000521b]                           dc.b $00
[0000521c]                           dc.b $00
[0000521d]                           dc.b $00
[0000521e] 0000114e                  dc.l $0000114e ; no symbol found
[00005222]                           dc.b $00
[00005223]                           dc.b $00
[00005224]                           dc.b $00
[00005225]                           dc.b $23
[00005226] 000010ae                  dc.l $000010ae ; no symbol found
[0000522a]                           dc.b $00
[0000522b]                           dc.b $00
[0000522c]                           dc.b $00
[0000522d]                           dc.b $2a
[0000522e] 000011ca                  dc.l $000011ca ; no symbol found
[00005232]                           dc.b $00
[00005233]                           dc.b $00
[00005234]                           dc.b $00
[00005235]                           dc.b $2c
[00005236] 000011ca                  dc.l $000011ca ; no symbol found
[0000523a]                           dc.b $00
[0000523b]                           dc.b $00
[0000523c]                           dc.b $00
[0000523d]                           dc.b $3a
[0000523e] 0000122c                  dc.l $0000122c ; no symbol found
[00005242]                           dc.b $00
[00005243]                           dc.b $00
[00005244]                           dc.b $00
[00005245]                           dc.b $3e
[00005246] 00001112                  dc.l $00001112 ; no symbol found
[0000524a]                           dc.b $00
[0000524b]                           dc.b $00
[0000524c]                           dc.b $00
[0000524d]                           dc.b $3f
[0000524e] 000012dc                  dc.l $000012dc ; no symbol found
[00005252]                           dc.w $0a09
[00005254]                           dc.b $00
[00005255]                           dc.b $00
[00005256]                           dc.w $2000
[00005258]                           dc.b 'usage: ',0
[00005260]                           dc.b '0123456789abcdefABCDEF',0
[00005277]                           dc.b $00
[00005278]                           dc.w $0102
[0000527a]                           dc.w $0304
[0000527c]                           dc.w $0506
[0000527e]                           dc.w $0708
[00005280]                           dc.w $090a
[00005282]                           dc.w $0b0c
[00005284]                           dc.w $0d0e
[00005286]                           dc.w $0f0a
[00005288]                           dc.w $0b0c
[0000528a]                           dc.w $0d0e
[0000528c]                           dc.w $0f00
[0000528e]                           dc.b 'abfnrtv',0
[00005296]                           dc.w $0708
[00005298]                           dc.w $0c0a
[0000529a]                           dc.w $0d09
[0000529c]                           dc.w $0b00
[0000529e]                           dc.w $fff6
[000052a0]                           dc.w $fff6
[000052a2]                           dc.b $00
[000052a3]                           dc.b $0a
[000052a4]                           dc.b $00
[000052a5]                           dc.b $08
[000052a6]                           dc.b $00
[000052a7]                           dc.b $10
[000052a8]                           dc.b $00
[000052a9]                           dc.b $10
[000052aa]                           dc.b 'diuoxX',0
[000052b1]                           dc.b $00
[000052b2]                           dc.b $00
[000052b3]                           dc.b $00
[000052b4]                           dc.b $00
[000052b5]                           dc.b $16
[000052b6]                           dc.b $00
[000052b7]                           dc.b $00
[000052b8]                           dc.b $00
[000052b9]                           dc.b $63
[000052ba] 00001d52                  dc.l $00001d52 ; no symbol found
[000052be] 00001d60                  dc.l $00001d60 ; no symbol found
[000052c2] 00001e26                  dc.l $00001e26 ; no symbol found
[000052c6] 00001ea0                  dc.l $00001ea0 ; no symbol found
[000052ca] 00001f12                  dc.l $00001f12 ; no symbol found
[000052ce] 0000207a                  dc.l $0000207a ; no symbol found
[000052d2] 00001d60                  dc.l $00001d60 ; no symbol found
[000052d6] 0000207a                  dc.l $0000207a ; no symbol found
[000052da] 0000207a                  dc.l $0000207a ; no symbol found
[000052de] 0000207a                  dc.l $0000207a ; no symbol found
[000052e2] 0000207a                  dc.l $0000207a ; no symbol found
[000052e6] 00001fb0                  dc.l $00001fb0 ; no symbol found
[000052ea] 00001d60                  dc.l $00001d60 ; no symbol found
[000052ee] 00001fcc                  dc.l $00001fcc ; no symbol found
[000052f2] 0000207a                  dc.l $0000207a ; no symbol found
[000052f6] 0000207a                  dc.l $0000207a ; no symbol found
[000052fa] 00002034                  dc.l $00002034 ; no symbol found
[000052fe] 0000207a                  dc.l $0000207a ; no symbol found
[00005302] 00001d60                  dc.l $00001d60 ; no symbol found
[00005306] 0000207a                  dc.l $0000207a ; no symbol found
[0000530a] 0000207a                  dc.l $0000207a ; no symbol found
[0000530e] 00001d60                  dc.l $00001d60 ; no symbol found
[00005312]                           dc.b $00
[00005313]                           dc.b $00
[00005314]                           dc.b $00
[00005315]                           dc.b $00
[00005316]                           dc.b $00
[00005317]                           dc.b $00
[00005318]                           dc.b $00
[00005319]                           dc.b $03
[0000531a] 00001e26                  dc.l $00001e26 ; no symbol found
[0000531e]                           dc.b $00
[0000531f]                           dc.b $00
[00005320]                           dc.b $00
[00005321]                           dc.b $45
[00005322] 00001f12                  dc.l $00001f12 ; no symbol found
[00005326]                           dc.b $00
[00005327]                           dc.b $00
[00005328]                           dc.b $00
[00005329]                           dc.b $47
[0000532a] 00001d60                  dc.l $00001d60 ; no symbol found
[0000532e]                           dc.b $00
[0000532f]                           dc.b $00
[00005330]                           dc.b $00
[00005331]                           dc.b $58
[00005332] 0000207a                  dc.l $0000207a ; no symbol found
[00005336]                           dc.w $3000
[00005338]                           dc.w $7800
[0000533a]                           dc.w $3000
[0000533c]                           dc.b $00
[0000533d]                           dc.b $00
[0000533e]                           dc.b $00
[0000533f]                           dc.b $00
[00005340]                           dc.b $00
[00005341]                           dc.b $00
[00005342]                           dc.b $00
[00005343]                           dc.b $02
[00005344] 000024e0                  dc.l $000024e0 ; no symbol found
[00005348]                           dc.b $00
[00005349]                           dc.b $00
[0000534a]                           dc.b $00
[0000534b]                           dc.b $2e
[0000534c] 000024d8                  dc.l $000024d8 ; no symbol found
[00005350]                           dc.b $00
[00005351]                           dc.b $00
[00005352]                           dc.b $00
[00005353]                           dc.b $30
[00005354] 000024e4                  dc.l $000024e4 ; no symbol found
[00005358]                           dc.b 'PATH',0
[0000535d]                           dc.b $00
__filerr:
[0000535e] 0002074e                  dc.l $00005362 ; no symbol found
[00005362]                           dc.b 'NULL FILE pointer',0
__fioerr:
[00005374] 00020764                  dc.l $00005378 ; no symbol found
[00005378]                           dc.b 'NULL FILE pointer',0
[0000538a]                           dc.b '0123456789abcdefghijklmnopqrstuvwxyz',0
[000053af]                           dc.b 'itob base error',0
[000053bf]                           dc.b $00
[000053c0]                           dc.b '0123456789abcdefghijklmnopqrstuvwxyz',0
[000053e5]                           dc.b 'ltob base error',0
[000053f5]                           dc.b $00
[000053f6]                           dc.b $00
[000053f7]                           dc.b $00
[000053f8]                           dc.w $0301
[000053fa]                           dc.w $0109
[000053fc]                           dc.b $00
[000053fd]                           dc.b $02
[000053fe]                           dc.w $0302
[00005400]                           dc.w $010a
[00005402]                           dc.b 'rwa',0
__reaerr:
[00005406] 000207f6                  dc.l $0000540a ; no symbol found
[0000540a]                           dc.b 'read error',0
[00005415]                           dc.b $00
[00005416]                           dc.b '0123456789abcdefghijklmnopqrstuvwxyz',0
[0000543b]                           dc.b 'stob base error',0
[0000544b]                           dc.b $00
[0000544c]                           dc.b 'bad free call',0
[0000545a]                           dc.b 'bad free call',0
__wrierr:
[00005468] 00020858                  dc.l $0000546c ; no symbol found
[0000546c]                           dc.b 'write error',0
[00005478]                           dc.b 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',0
[000054ad]                           dc.b 'text to long integer conversion error',0
[000054d3]                           dc.b $00
__ctasc:
[000054d4]                           dc.b $00
[000054d5]                           dc.b '         (((((                  '
[000054f5]                           dc.b $80
[000054f6]                           dc.w $1010
[000054f8]                           dc.w $1010
[000054fa]                           dc.w $1010
[000054fc]                           dc.w $1010
[000054fe]                           dc.w $1010
[00005500]                           dc.w $1010
[00005502]                           dc.w $1010
[00005504]                           dc.w $1004
[00005506]                           dc.w $0404
[00005508]                           dc.w $0404
[0000550a]                           dc.w $0404
[0000550c]                           dc.w $0404
[0000550e]                           dc.w $0410
[00005510]                           dc.w $1010
[00005512]                           dc.w $1010
[00005514]                           dc.w $1010
[00005516]                           dc.b 'AAAAAA'
[0000551c]                           dc.w $0101
[0000551e]                           dc.w $0101
[00005520]                           dc.w $0101
[00005522]                           dc.w $0101
[00005524]                           dc.w $0101
[00005526]                           dc.w $0101
[00005528]                           dc.w $0101
[0000552a]                           dc.w $0101
[0000552c]                           dc.w $0101
[0000552e]                           dc.w $0101
[00005530]                           dc.w $1010
[00005532]                           dc.w $1010
[00005534]                           dc.w $1010
[00005536]                           dc.b 'BBBBBB'
[0000553c]                           dc.w $0202
[0000553e]                           dc.w $0202
[00005540]                           dc.w $0202
[00005542]                           dc.w $0202
[00005544]                           dc.w $0202
[00005546]                           dc.w $0202
[00005548]                           dc.w $0202
[0000554a]                           dc.w $0202
[0000554c]                           dc.w $0202
[0000554e]                           dc.w $0202
[00005550]                           dc.w $1010
[00005552]                           dc.w $1010
[00005554]                           dc.w $2000
[00005556]                           dc.b $00
[00005557]                           dc.b $00
[00005558]                           dc.b $00
[00005559]                           dc.b $00
[0000555a]                           dc.b $00
[0000555b]                           dc.b $00
[0000555c]                           dc.b $00
[0000555d]                           dc.b $00
[0000555e]                           dc.b $00
[0000555f]                           dc.b $00
[00005560]                           dc.b $00
[00005561]                           dc.b $00
[00005562]                           dc.b $00
[00005563]                           dc.b $00
[00005564]                           dc.b $00
[00005565]                           dc.b $00
[00005566]                           dc.b $00
[00005567]                           dc.b $00
[00005568]                           dc.b $00
[00005569]                           dc.b $00
[0000556a]                           dc.b $00
[0000556b]                           dc.b $00
[0000556c]                           dc.b $00
[0000556d]                           dc.b $00
[0000556e]                           dc.b $00
[0000556f]                           dc.b $00
[00005570]                           dc.b $00
[00005571]                           dc.b $00
[00005572]                           dc.b $00
[00005573]                           dc.b $00
[00005574]                           dc.b $00
[00005575]                           dc.b $00
[00005576]                           dc.b $00
[00005577]                           dc.b $00
[00005578]                           dc.b $00
[00005579]                           dc.b $00
[0000557a]                           dc.b $00
[0000557b]                           dc.b $00
[0000557c]                           dc.b $00
[0000557d]                           dc.b $00
[0000557e]                           dc.b $00
[0000557f]                           dc.b $00
[00005580]                           dc.b $00
[00005581]                           dc.b $00
[00005582]                           dc.b $00
[00005583]                           dc.b $00
[00005584]                           dc.b $00
[00005585]                           dc.b $00
[00005586]                           dc.b $00
[00005587]                           dc.b $00
[00005588]                           dc.b $00
[00005589]                           dc.b $00
[0000558a]                           dc.b $00
[0000558b]                           dc.b $00
[0000558c]                           dc.b $00
[0000558d]                           dc.b $00
[0000558e]                           dc.b $00
[0000558f]                           dc.b $00
[00005590]                           dc.b $00
[00005591]                           dc.b $00
[00005592]                           dc.b $00
[00005593]                           dc.b $00
[00005594]                           dc.b $00
[00005595]                           dc.b $00
[00005596]                           dc.b $00
[00005597]                           dc.b $00
[00005598]                           dc.b $00
[00005599]                           dc.b $00
[0000559a]                           dc.b $00
[0000559b]                           dc.b $00
[0000559c]                           dc.b $00
[0000559d]                           dc.b $00
[0000559e]                           dc.b $00
[0000559f]                           dc.b $00
[000055a0]                           dc.b $00
[000055a1]                           dc.b $00
[000055a2]                           dc.b $00
[000055a3]                           dc.b $00
[000055a4]                           dc.b $00
[000055a5]                           dc.b $00
[000055a6]                           dc.b $00
[000055a7]                           dc.b $00
[000055a8]                           dc.b $00
[000055a9]                           dc.b $00
[000055aa]                           dc.b $00
[000055ab]                           dc.b $00
[000055ac]                           dc.b $00
[000055ad]                           dc.b $00
[000055ae]                           dc.b $00
[000055af]                           dc.b $00
[000055b0]                           dc.b $00
[000055b1]                           dc.b $00
[000055b2]                           dc.b $00
[000055b3]                           dc.b $00
[000055b4]                           dc.b $00
[000055b5]                           dc.b $00
[000055b6]                           dc.b $00
[000055b7]                           dc.b $00
[000055b8]                           dc.b $00
[000055b9]                           dc.b $00
[000055ba]                           dc.b $00
[000055bb]                           dc.b $00
[000055bc]                           dc.b $00
[000055bd]                           dc.b $00
[000055be]                           dc.b $00
[000055bf]                           dc.b $00
[000055c0]                           dc.b $00
[000055c1]                           dc.b $00
[000055c2]                           dc.b $00
[000055c3]                           dc.b $00
[000055c4]                           dc.b $00
[000055c5]                           dc.b $00
[000055c6]                           dc.b $00
[000055c7]                           dc.b $00
[000055c8]                           dc.b $00
[000055c9]                           dc.b $00
[000055ca]                           dc.b $00
[000055cb]                           dc.b $00
[000055cc]                           dc.b $00
[000055cd]                           dc.b $00
[000055ce]                           dc.b $00
[000055cf]                           dc.b $00
[000055d0]                           dc.b $00
[000055d1]                           dc.b $00
[000055d2]                           dc.b $00
[000055d3]                           dc.b $00
[000055d4]                           dc.b $00
[000055d5]                           dc.b $00
[000055d6]                           dc.b 'dtento range error',0
[000055e9]                           dc.b $00
__paths:
[000055ea] 000209da                  dc.l $000055ee ; no symbol found
[000055ee]                           dc.b '|/bin/|/usr/bin/|/etc/bin/',0
[00005609]                           dc.b $00
__dtens:
[0000560a]                           dc.w $3ff0
[0000560c]                           dc.b $00
[0000560d]                           dc.b $00
[0000560e]                           dc.b $00
[0000560f]                           dc.b $00
[00005610]                           dc.b $00
[00005611]                           dc.b $00
[00005612]                           dc.w $4024
[00005614]                           dc.b $00
[00005615]                           dc.b $00
[00005616]                           dc.b $00
[00005617]                           dc.b $00
[00005618]                           dc.b $00
[00005619]                           dc.b $00
[0000561a]                           dc.w $4059
[0000561c]                           dc.b $00
[0000561d]                           dc.b $00
[0000561e]                           dc.b $00
[0000561f]                           dc.b $00
[00005620]                           dc.b $00
[00005621]                           dc.b $00
[00005622]                           dc.w $40c3
[00005624]                           dc.w $8800
[00005626]                           dc.b $00
[00005627]                           dc.b $00
[00005628]                           dc.b $00
[00005629]                           dc.b $00
[0000562a]                           dc.w $4197
[0000562c]                           dc.w $d784
[0000562e]                           dc.b $00
[0000562f]                           dc.b $00
[00005630]                           dc.b $00
[00005631]                           dc.b $00
[00005632]                           dc.w $4341
[00005634]                           dc.w $c379
[00005636]                           dc.w $37e0
[00005638]                           dc.w $8000
[0000563a]                           dc.w $4693
[0000563c]                           dc.w $b8b5
[0000563e]                           dc.w $b505
[00005640]                           dc.w $6e17
[00005642]                           dc.w $4d38
[00005644]                           dc.w $4f03
[00005646]                           dc.w $e93f
[00005648]                           dc.w $f9f5
[0000564a]                           dc.w $5a82
[0000564c]                           dc.w $7748
[0000564e]                           dc.w $f930
[00005650]                           dc.w $1d32
[00005652]                           dc.w $7515
[00005654]                           dc.w $4fdd
[00005656]                           dc.w $7f73
[00005658]                           dc.w $bf3c
__maxprec:
[0000565a]                           dc.b $00
[0000565b]                           dc.b $11
__ntens:
[0000565c]                           dc.b $00
[0000565d]                           dc.b $0a,': ',0
[00005661]                           dc.b $0a
[00005662]                           dc.b $00
[00005663]                           dc.b $00
__huge:
[00005664]                           dc.w $7fef
[00005666]                           dc.w $ffff
[00005668]                           dc.w $ffff
[0000566a]                           dc.w $ffff
__tiny:
[0000566c]                           dc.b $00
[0000566d]                           dc.b $20
[0000566e]                           dc.b $00
[0000566f]                           dc.b $00
[00005670]                           dc.b $00
[00005671]                           dc.b $00
[00005672]                           dc.b $00
[00005673]                           dc.b $00
__savtime:
[00005674]                           dc.b 'EDT',0
__stdtime:
[00005678]                           dc.b 'EST',0
__zone:
[0000567c]                           dc.w $545a
[0000567e]                           dc.b $00
[0000567f]                           dc.b $00
__edt:
[00005680] 00020a60                  dc.l $00005674 ; no symbol found
__est:
[00005684] 00020a64                  dc.l $00005678 ; no symbol found
[00005688]                           dc.b 'domain error',0
[00005695]                           dc.b 'no memory',0
[0000569f]                           dc.b 'range error',0
[000056ab]                           dc.b $00
[000056ac]                           dc.b $00
[000056ad]                           dc.b $00
[000056ae]                           dc.b $00
[000056af]                           dc.b $00
[000056b0] 00020aa0                  dc.l $000056b4 ; no symbol found
[000056b4]                           dc.b 'unchecked condition',0
[000056c8]                           dc.w $3a20
[000056ca]                           dc.b $00
[000056cb]                           dc.b $0a
[000056cc]                           dc.b $00
[000056cd]                           dc.b $00
__pname:
[000056ce] 00020abe                  dc.l $000056d2 ; no symbol found
[000056d2]                           dc.b 'error',0
;
00000000 T start
0000004a T _exit
0000004a T __terminate
00000062 T __exit
00000068 T _onexit
00000068 T __onexit
00000098 T pseterr
0000009a T seterr
000000a6 T _devname
000001e2 T _main
000002e8 T _pinode
0000045e T _pnm
0000048c T _pps
00000928 T _readfill
000009f6 T _sigstr
00000aea T _usernm
00000bca T _getpw
00000d1a T _lseek
00000d2c T _sleep
00000d3e T _open
00000d50 T _read
00000d62 T _close
00000d74 T _alloc
00000d8c T _lfree
00000da2 T _nalloc
00000dba T _cpybuf
00000dd6 T _cpystr
00000e34 T _decode
00000f86 T _getflags
00001382 T _lenstr
00001394 T _putfmt
000013ba T _putstr
000013ee T _remark
00001406 T _usage
00001474 T _cmpbuf
0000149c T __cstat
000014da T _doesc
00001644 T _getl
0000175e T _instr
00001798 T _putl
000018d0 T _fclose
00001902 T _free
00001918 T _tolower
0000193a T __astat
0000195a T _fopen
00001974 T _freopen
00001a38 T _isupper
00001a66 T __cache
00001a94 T _sprintf
00001bee T __print
000023d2 T __dtog
000024f4 T _strchr
0000252a T _strlen
0000254c T _toupper
0000256e T _islower
0000259c T __chkio
00002684 T __doflush
000026fe T __main
00002776 T __cmpstr
000027f2 T __putf
00002bb0 T __doclose
00002c66 T __doread
00002cec T __dowrite
00002d5e T __dtoe
00002ed4 T __dtof
00002ffa T __finit
000030e0 T __flush
000030e4 T __itob
000031ca T __lseek
000031dc T __ltob
000032cc T __onlist
000032f8 T __open
0000330a T __parstype
000033ac T __putstr
000033e0 T __read
000033f2 T __remove
00003450 T __round
000034b8 T __scnbuf
000034e4 T __stob
000035d4 T __unlink
0000374e T __alloc
00003788 T __balheap
000037ac T __free
0000380e T __lstheap
0000386e T __nalloc
00003956 T __nfree
000039f6 T __realloc
00003b34 T __close
00003b46 T __norm
00003cf4 T __domain
00003d34 T __fwrite
00003d66 T __getmod
00003d8c T __sbreak
00003d90 T __sbrk
00003dcc T __signal
00003dde T __stat
00003df0 T __btol
00003ffc T __cpybuf
0000401e T __dtento
0000421a T __getenv
00004272 T __lenstr
00004284 T __scnstr
0000429e T __unpack
000042be T __addexp
00004304 T __cmpbuf
0000432c T __range
000043b4 T __remark
000043ec T __lstat
000044d4 T __raise
00004570 T __when
000045f0 T __error
00004632 T __write
00004644 T a~1sub
00004660 T a~6sub
0000467c T a~1add
00004694 T a~6add
0000477e T a~1cmp
0000478e T a~6cmp
000047d6 T a~1div
000047ee T a~6div
000048aa T a~1mul
000048c2 T a~6mul
000049ae T a~1dtl
000049b4 T a~6dtl
00004a06 T a~jtab
00004a70 T a~lmod
00004a82 T a~ldiv
00004ab6 T a~ulmod
00004ad2 T a~uldiv
00004b46 T a~unpk
00004b64 T a~1ltd
00004b6c T a~6ltd
00004b92 T a~repk
00004c12 T a~tpad

00004c14 00024c14 D __data
00004c78 00024c78 D __errno
00004c78 00024c78 D _errno
00004c80 00024c80 D _aflag
00004c84 00024c84 D _fflag
00004c88 00024c88 D _iflag
00004c8c 00024c8c D _lflag
00004c90 00024c90 D _pflag
00004c94 00024c94 D _rflag
00004c98 00024c98 D _slp
00004c9c 00024c9c D _tflag
00004ca0 00024ca0 D _pu
00004ca4 00024ca4 D _tinode
00004cb4 00024cb4 D _tmount
00004cc4 00024cc4 D _tmyps
00004cd2 00024cd2 D _tps
0000535e 0002535e D __filerr
00005374 00025374 D __fioerr
00005406 00025406 D __reaerr
00005468 00025468 D __wrierr
000054d4 000254d4 D __ctasc
000055ea 000255ea D __paths
0000560a 0002560a D __dtens
0000565a 0002565a D __maxprec
0000565c 0002565c D __ntens
00005664 00025664 D __huge
0000566c 0002566c D __tiny
00005674 00025674 D __savtime
00005678 00025678 D __stdtime
0000567c 0002567c D __zone
00005680 00025680 D __edt
00005684 00025684 D __est
000056ce 000256ce D __pname

         00024cf6 B cnames_size
         00024cfa B bnames_size
         00024cfe B cnames_buf
         00024d02 B bnames_buf
         
00000b44 00025758 B _entval
00000b48 0002575c B _firstkey
00000b4a 0002575e B _key
00000c10 00025824 B _defsort
00000c22 00025836 B _stderr
00000c26 0002583a B _stdin
00000c2a 0002583e B _stdout
00000c2e 00025842 B _environ
00000c32 00025846 B __dzero
00000c3a 0002584e B __dst
00000c3e 00025852 B __tzinit
00000c42 00025856 B __timezone
00000c46 0002585a B __tzmins
00000c4a 0002585e B __hunk
00000c4e 00025862 B __hinf
00000c5a 0002586e B __hbot
00000c5e 00025872 B __heap
00000c62 00025876 B __htop
00000c66 0002587a B __domerr
00000c6a 0002587e B __memerr
00000c6e 00025882 B __ranerr
00000c72 00025886 B __stop
00000c76 0002588a B __pfile
00000c7a 0002588e B __fnext
00000c7e 00025892 B __tfile
00000c82 00025896 B __stderr
00000c9e 000258b2 B __stdin
00000cba 000258ce B __stdout
00000cd6 000258ea B __rbuf
;
; a.out Relocations:
00000006: 00004c14
00000012: 00004c14
00000018: 00000000
0000001e: 00000000
00000024: 00000000
0000002a: 00000000
00000036: 00000000
0000003e: 00000000
00000046: 00000000
0000004c: 00004c14
00000052: 00000000
0000006a: 00004c14
00000072: 00004c14
0000009e: 00004c14
000000bc: 00004c14
000000c4: 00004c14
000000d2: 00004c14
000000da: 00004c14
000000e8: 00004c14
000000ee: 00000000
000000f6: 00004c14
000000fc: 00004c14
00000106: 00004c14
0000010e: 00004c14
00000116: 00004c14
00000124: 00004c14
0000012a: 00000000
00000132: 00004c14
00000138: 00004c14
00000142: 00004c14
000001e8: 00004c14
000001ee: 00004c14
000001f4: 00004c14
000001fa: 00004c14
00000200: 00004c14
00000206: 00004c14
0000020c: 00004c14
00000212: 00004c14
00000218: 00004c14
00000226: 00000000
00000230: 00004c14
00000238: 00004c14
0000023e: 00004c14
00000244: 00004c14
0000024e: 00004c14
0000025a: 00004c14
00000260: 00000000
00000266: 00004c14
0000026e: 00004c14
00000276: 00004c14
00000286: 00004c14
0000028c: 00000000
00000294: 00004c14
0000029e: 00004c14
000002a4: 00000000
000002ac: 00004c14
000002b4: 00004c14
000002ba: 00000000
000002c0: 00004c14
000002ce: 00004c14
000002d4: 00000000
000002da: 00004c14
000002e0: 00000000
000002f2: 00004c14
000002f8: 00000000
00000308: 00000000
0000031e: 00004c14
00000324: 00000000
00000370: 00004c14
0000037a: 00000000
000003b0: 00004c14
000003b6: 00000000
000003e4: 00004c14
000003ea: 00000000
0000042a: 00004c14
00000430: 00000000
0000043e: 00004c14
00000444: 00000000
00000452: 00000000
0000046c: 00004c14
00000472: 00004c14
00000480: 00004c14
000004a0: 00000000
000004b6: 00004c14
000004be: 00004c14
000004c6: 00004c14
000004ce: 00000000
00000504: 00004c14
0000051c: 00004c14
00000530: 00004c14
00000546: 00004c14
00000550: 00004c14
00000560: 00004c14
0000056c: 00004c14
00000592: 00004c14
00000598: 00004c14
0000059e: 00000000
000005a8: 00004c14
000005ae: 00004c14
000005ea: 00004c14
000005fa: 00004c14
00000602: 00004c14
0000060a: 00004c14
00000612: 00000000
00000632: 00004c14
0000064c: 00004c14
00000652: 00004c14
00000658: 00000000
0000066e: 00004c14
0000067c: 00004c14
000006a2: 00004c14
000006a8: 00004c14
000006ae: 00000000
000006b8: 00004c14
000006c2: 00004c14
00000712: 00004c14
0000072a: 00004c14
00000732: 00004c14
0000073a: 00004c14
00000742: 00000000
0000074c: 00004c14
0000075e: 00000000
00000766: 00004c14
0000076c: 00000000
0000077c: 00004c14
00000782: 00000000
0000078e: 00004c14
00000794: 00000000
000007aa: 00004c14
000007b0: 00000000
000007c6: 00000000
000007ce: 00004c14
000007d4: 00000000
000007e6: 00004c14
000007ec: 00000000
000007f4: 00004c14
000007fa: 00000000
00000820: 00004c14
0000084a: 00004c14
00000850: 00000000
0000085e: 00004c14
00000864: 00000000
00000882: 00004c14
0000088a: 00004c14
0000089c: 00004c14
000008a2: 00000000
000008bc: 00004c14
000008c4: 00004c14
000008d8: 00000000
000008e2: 00004c14
000008e8: 00000000
000008f0: 00004c14
000008f6: 00000000
0000091c: 00000000
00000940: 00000000
00000952: 00004c14
00000958: 00000000
00000974: 00000000
00000986: 00000000
00000996: 00004c14
0000099c: 00000000
000009a6: 00000000
000009ba: 00000000
000009d6: 00000000
000009e0: 00000000
00000a00: 00004c14
00000a06: 00000000
00000a0c: 00004c14
00000a16: 00004c14
00000a20: 00004c14
00000a2a: 00004c14
00000a34: 00004c14
00000a3e: 00004c14
00000a48: 00004c14
00000a52: 00004c14
00000a5c: 00004c14
00000a66: 00004c14
00000a70: 00004c14
00000a7a: 00004c14
00000a84: 00004c14
00000a8e: 00004c14
00000a98: 00004c14
00000aa2: 00004c14
00000aac: 00004c14
00000aba: 00004c14
00000ac4: 00004c14
00000aca: 00000000
00000ad6: 00004c14
00000ade: 00004c14
00000afa: 00004c14
00000b04: 00004c14
00000b0a: 00000000
00000b16: 00004c14
00000b24: 00004c14
00000b2a: 00000000
00000b38: 00004c14
00000b42: 00000000
00000b60: 00004c14
00000b66: 00000000
00000b6e: 00004c14
00000b78: 00004c14
00000ba4: 00004c14
00000bac: 00000000
00000bdc: 00000000
00000be4: 00004c14
00000bee: 00004c14
00000bfc: 00004c14
00000c10: 00000000
00000c1c: 00004c14
00000c24: 00000000
00000c34: 00004c14
00000c42: 00004c14
00000c48: 00004c14
00000c4e: 00000000
00000c6c: 00004c14
00000c74: 00000000
00000c8e: 00004c14
00000ca2: 00000000
00000cae: 00004c14
00000cb6: 00000000
00000cc6: 00004c14
00000cde: 00004c14
00000ce4: 00004c14
00000cea: 00004c14
00000cf4: 00000000
00000d00: 00000000
00000d26: 00000000
00000d38: 00000000
00000d4a: 00000000
00000d5c: 00000000
00000d6e: 00000000
00000d82: 00000000
00000d96: 00000000
00000db0: 00000000
00000dcc: 00000000
00000e56: 00000000
00000e5c: 00000000
00000e76: 00000000
00000e86: 00000000
00000ea2: 00000000
00000eb4: 00004c14
00000edc: 00004c14
00000ee6: 00000000
00000efc: 00004c14
00000f18: 00004c14
00000f22: 00000000
00000f48: 00004c14
00000f64: 00004c14
00000f78: 00000000
00000fb6: 00004c14
00000fbe: 00000000
00000fe2: 00004c14
00000fea: 00000000
00001014: 00004c14
0000101a: 00000000
0000102e: 00000000
00001070: 00004c14
000010a4: 00004c14
000010aa: 00000000
000010f4: 00000000
00001130: 00000000
00001176: 00000000
00001182: 00000000
00001198: 00000000
000011d4: 00004c14
000011da: 00000000
00001248: 00000000
00001280: 00004c14
00001286: 00000000
0000134e: 00004c14
00001356: 00000000
0000136c: 00000000
0000138c: 00000000
000013a2: 00004c14
000013a8: 00000000
000013ae: 00000000
000013ce: 00000000
000013dc: 00000000
000013fc: 00000000
0000141a: 00004c14
00001420: 00004c14
00001426: 00004c14
00001430: 00000000
00001440: 00000000
00001456: 00000000
0000145e: 00004c14
00001464: 00000000
000014a0: 00004c14
000014a6: 00004c14
000014ac: 00004c14
000014b4: 00004c14
000014ba: 00004c14
000014c0: 00004c14
000014c6: 00004c14
000014cc: 00004c14
000014d4: 00004c14
000014e8: 00004c14
0000150a: 00000000
00001512: 00004c14
00001518: 00000000
0000152e: 00004c14
0000156e: 00004c14
00001574: 00000000
00001588: 00004c14
00001596: 00004c14
00001624: 00000000
0000164e: 00000000
00001654: 00004c14
00001666: 00004c14
00001680: 00000000
000016ae: 00000000
000016f4: 00000000
000017a2: 00000000
000017a8: 00004c14
000017ba: 00004c14
000017d8: 00000000
00001802: 00000000
00001860: 00000000
000018aa: 00000000
000018dc: 00004c14
000018e4: 00000000
000018f8: 00000000
0000190e: 00000000
00001922: 00000000
0000193c: 00004c14
00001940: 00004c14
00001946: 00004c14
0000194a: 00004c14
00001950: 00004c14
00001954: 00004c14
0000196a: 00000000
0000198a: 00000000
00001996: 00000000
000019b4: 00000000
000019dc: 00000000
000019fc: 00000000
00001a30: 00000000
00001a54: 00004c14
00001aac: 00000000
00001ab2: 00000000
00001ade: 00000000
00001b76: 00004c14
00001b96: 00004c14
00001d32: 00004c14
00001d38: 00000000
00001d68: 00004c14
00001d6e: 00000000
00001d7e: 00004c14
00001d88: 00004c14
00001dac: 00000000
00001e04: 00000000
00001e7c: 00000000
00001f02: 00000000
00001f82: 00000000
0000200e: 00000000
0000202a: 00000000
00002070: 00000000
000021b4: 00004c14
0000223a: 00004c14
0000225a: 00004c14
000023f0: 00000000
0000241e: 00000000
00002442: 00000000
000024a4: 00000000
000024ce: 00004c14
000024d4: 00000000
00002556: 00000000
0000258a: 00004c14
000025ae: 00004c14
000025b6: 00000000
000025be: 00004c14
000025c6: 00000000
000025cc: 00000000
000025d2: 00004c14
00002638: 00000000
0000268a: 00004c14
000026b0: 00000000
000026be: 00004c14
000026d0: 00000000
000026dc: 00000000
000026e8: 00000000
000026f4: 00004c14
00002716: 00004c14
00002722: 00004c14
00002742: 00004c14
00002748: 00004c14
0000274e: 00000000
0000275a: 00004c14
00002768: 00000000
000027cc: 00004c14
0000294a: 00000000
000029b6: 00000000
00002a18: 00000000
00002abc: 00000000
00002b58: 00000000
00002bc2: 00004c14
00002bca: 00000000
00002bd2: 00004c14
00002bda: 00000000
00002c06: 00000000
00002c18: 00000000
00002c38: 00000000
00002c52: 00000000
00002c7c: 00004c14
00002c84: 00000000
00002ca2: 00000000
00002cc0: 00000000
00002d06: 00004c14
00002d0e: 00000000
00002d24: 00000000
00002d3e: 00000000
00002d6e: 00004c14
00002d76: 00004c14
00002dce: 00000000
00002dec: 00000000
00002e84: 00000000
00002ea6: 00000000
00002ebc: 00000000
00002ee8: 00004c14
00002ef0: 00004c14
00002f36: 00000000
00002f62: 00000000
00003008: 00004c14
00003020: 00000000
0000302e: 00004c14
00003036: 00000000
000030c8: 00000000
000030f2: 00004c14
0000310c: 00004c14
00003112: 00000000
00003162: 00000000
0000317a: 00000000
00003198: 00000000
000031b0: 00000000
000031d6: 00000000
000031ee: 00004c14
00003208: 00004c14
0000320e: 00000000
00003262: 00000000
0000327a: 00000000
00003298: 00000000
000032b0: 00000000
00003304: 00000000
00003324: 00004c14
0000335c: 00004c14
00003378: 00004c14
000033c0: 00000000
000033ce: 00000000
000033ec: 00000000
00003400: 00000000
0000340c: 00004c14
00003432: 00004c14
0000344a: 00000000
000034ee: 00004c14
00003508: 00004c14
0000350e: 00000000
0000356c: 00000000
0000358a: 00000000
000035a8: 00000000
000035e0: 00000000
000035fc: 00004c14
0000362c: 00004c14
0000363a: 00004c14
00003658: 00004c14
00003666: 00004c14
00003674: 00000000
00003694: 00004c14
00003716: 00004c14
0000371a: 00004c14
00003720: 00004c14
00003728: 00000000
00003760: 00000000
00003772: 00004c14
0000377a: 00000000
00003794: 00000000
000037cc: 00004c14
000037d4: 00004c14
000037de: 00004c14
000037e2: 00004c14
000037e8: 00004c14
000037f0: 00000000
00003806: 00000000
00003818: 00004c14
0000381e: 00004c14
00003822: 00004c14
00003828: 00004c14
00003838: 00004c14
0000383e: 00004c14
00003862: 00004c14
00003878: 00004c14
000038a6: 00004c14
0000391c: 00000000
0000393a: 00000000
00003960: 00004c14
00003aee: 00000000
00003b18: 00000000
00003b40: 00000000
00003b50: 00004c14
00003b8e: 00000000
00003ba2: 00000000
00003bba: 00000000
00003bee: 00000000
00003c04: 00000000
00003c2e: 00000000
00003c4a: 00000000
00003c5c: 00000000
00003cb2: 00000000
00003cc2: 00000000
00003ccc: 00000000
00003cfa: 00004c14
00003d04: 00004c14
00003d10: 00000000
00003d1c: 00004c14
00003d22: 00004c14
00003d2a: 00000000
00003d46: 00000000
00003d54: 00004c14
00003d5c: 00000000
00003d74: 00000000
00003dbc: 00004c14
00003dd8: 00000000
00003dea: 00000000
00003e0a: 00004c14
00003ec2: 00000000
00003ed4: 00004c14
00003ef6: 00004c14
00003efc: 00000000
00003f08: 00004c14
00003fe4: 00004c14
00003fea: 00000000
00004028: 00004c14
00004032: 00004c14
00004056: 00000000
0000408e: 00000000
000040d8: 00000000
000040fc: 00000000
0000411e: 00000000
0000415c: 00000000
000041a6: 00000000
000041c2: 00000000
000041e4: 00000000
000041f6: 00004c14
0000420a: 00000000
0000422a: 00000000
00004232: 00004c14
00004246: 00000000
000042e6: 00000000
00004332: 00004c14
0000433c: 00004c14
00004348: 00000000
00004350: 00004c14
00004356: 00004c14
00004362: 00004c14
00004368: 00004c14
00004370: 00000000
000043a6: 00000000
000043ba: 00004c14
000043c4: 00004c14
000043de: 00004c14
000043f0: 00004c14
000043f8: 00004c14
000043fe: 00004c14
00004402: 00004c14
00004408: 00004c14
0000440c: 00004c14
00004412: 00004c14
00004416: 00004c14
0000441e: 00004c14
00004424: 00004c14
00004428: 00004c14
0000442e: 00004c14
00004436: 00004c14
0000443e: 00004c14
00004444: 00004c14
0000444e: 00004c14
00004454: 00004c14
0000445a: 00004c14
00004460: 00004c14
00004466: 00004c14
0000446c: 00004c14
00004474: 00004c14
0000447a: 00004c14
00004484: 00004c14
0000448a: 00004c14
00004490: 00004c14
00004496: 00004c14
0000449c: 00004c14
000044a4: 00004c14
000044ac: 00004c14
000044b2: 00004c14
000044bc: 00004c14
000044c2: 00004c14
000044c8: 00004c14
000044ce: 00004c14
000044fa: 00004c14
0000451c: 00004c14
0000455e: 00004c14
00004568: 00000000
00004572: 00004c14
000045a6: 00004c14
000045e2: 00000000
000045f6: 00004c14
00004600: 00004c14
0000461a: 00004c14
00004628: 00000000
0000463e: 00000000
000046b0: 00000000
000046d6: 00000000
0000476c: 00000000
0000480a: 00000000
00004842: 00000000
00004898: 00000000
000048de: 00000000
0000490a: 00000000
00004974: 00000000
000049c0: 00000000
00004b82: 00000000
00004c7c: 00000000
00004ca4: 00004c14
00004cb4: 00004c14
00004cc4: 00004c14
00004cd2: 00004c14
00004dd6: 00004c14
00004dda: 00004c14
00004dde: 00004c14
00004de2: 00004c14
00004de6: 00004c14
00004dea: 00004c14
00004dee: 00004c14
00004df2: 00004c14
0000510e: 00000000
00005112: 00000000
00005116: 00000000
0000511a: 00000000
0000511e: 00000000
00005122: 00000000
00005126: 00000000
0000512a: 00000000
0000512e: 00000000
00005132: 00000000
00005136: 00000000
0000513a: 00000000
0000513e: 00000000
00005142: 00000000
00005146: 00000000
0000514a: 00000000
0000514e: 00000000
0000515a: 00000000
000051ce: 00000000
000051d6: 00000000
000051de: 00000000
000051e6: 00000000
000051f2: 00000000
000051fa: 00000000
00005202: 00000000
0000520a: 00000000
00005216: 00000000
0000521e: 00000000
00005226: 00000000
0000522e: 00000000
00005236: 00000000
0000523e: 00000000
00005246: 00000000
0000524e: 00000000
000052ba: 00000000
000052be: 00000000
000052c2: 00000000
000052c6: 00000000
000052ca: 00000000
000052ce: 00000000
000052d2: 00000000
000052d6: 00000000
000052da: 00000000
000052de: 00000000
000052e2: 00000000
000052e6: 00000000
000052ea: 00000000
000052ee: 00000000
000052f2: 00000000
000052f6: 00000000
000052fa: 00000000
000052fe: 00000000
00005302: 00000000
00005306: 00000000
0000530a: 00000000
0000530e: 00000000
0000531a: 00000000
00005322: 00000000
0000532a: 00000000
00005332: 00000000
00005344: 00000000
0000534c: 00000000
00005354: 00000000
0000535e: 00004c14
00005374: 00004c14
00005406: 00004c14
00005468: 00004c14
000055ea: 00004c14
00005680: 00004c14
00005684: 00004c14
000056b0: 00004c14
000056ce: 00004c14

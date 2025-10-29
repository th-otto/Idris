; a_magic   = 0x9928
; a_text    = 0x00001218
; a_data    = 0x00000706
; a_bss     = 0x000001ec
; a_syms    = 0x00000000
; a_heap    = 0x00000000
; a_textoff = 0x00000000
; a_dataoff = 0x00001218
; a_relocs  = 0x000002d5@0x0000193a


x0:
[00000000] 0cb9 0000 0001 0000 1a94  cmpi.l     #$00000001,__stop
[0000000a] 660a                      bne.s      x0_1
[0000000c] 23fc 0002 08f2 0000 1a94  move.l     #e__bss__,__stop
x0_1:
[00000016] 4eb9 0000 10a2            jsr        __lstat
[0000001c] 4eb9 0000 0f00            jsr        __astat
[00000022] 4eb9 0000 0e90            jsr        __cstat
[00000028] 4879 0000 0078            pea.l      $00000078
[0000002e] 2f3c ffff ffff            move.l     #$FFFFFFFF,-(a7)
[00000034] 4eb9 0000 0fe8            jsr        __signal
[0000003a] 508f                      addq.l     #8,a7
[0000003c] 4eb9 0000 0f68            jsr        __main
[00000042] 2e87                      move.l     d7,(a7)
[00000044] 4eb9 0000 004a            jsr        _exit

_exit:
[0000004a] 2e39 0000 1280            move.l     $00002498,d7
x0_3:
[00000050] 0c87 0000 0068            cmpi.l     #$00000068,d7
[00000056] 670a                      beq.s      x0_2
[00000058] 4a87                      tst.l      d7
[0000005a] 6706                      beq.s      x0_2
[0000005c] 2047                      movea.l    d7,a0
[0000005e] 4e90                      jsr        (a0)
[00000060] 60ee                      bra.s      x0_3
x0_2:
[00000062] 4a9f                      tst.l      (a7)+
[00000064] 7e01                      moveq.l    #1,d7
[00000066] 4e41                      trap       #1
__onexit:
[00000068] 2e39 0000 1280            move.l     $00002498,d7
[0000006e] 23ef 0004 0000 1280       move.l     4(a7),$00002498
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
[0000009c] 23c7 0000 127c            move.l     d7,_errno
[000000a2] 7eff                      moveq.l    #-1,d7
[000000a4] 4ed0                      jmp        (a0)

_main:
[000000a6] 4e56 fe00                 link       a6,#-512
[000000aa] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[000000ae] 2ebc 0000 1460            move.l     #$00002678,(a7) "\n"
[000000b4] 4eb9 0000 0d6e            jsr        print_str

[000000ba] 0cae 0000 0001 0008       cmpi.l     #$00000001,8(a6)
[000000c2] 6744                      beq.s      _main_1
[000000c4] 0cae 0000 0003 0008       cmpi.l     #$00000003,8(a6)
[000000cc] 673a                      beq.s      _main_1
[000000ce] 0cae 0000 0004 0008       cmpi.l     #$00000004,8(a6)
[000000d6] 6730                      beq.s      _main_1
[000000d8] 2ebc 0000 1462            move.l     #$0000267A,(a7)
[000000de] 4eb9 0000 0d6e            jsr        print_str "usage: "
[000000e4] 226e 000c                 movea.l    12(a6),a1
[000000e8] 2e91                      move.l     (a1),(a7)
[000000ea] 4eb9 0000 0d6e            jsr        print_str
[000000f0] 2ebc 0000 146a            move.l     #$00002682,(a7) " [partition name [reserved]]\n"
[000000f6] 4eb9 0000 0d6e            jsr        print_str
[000000fc] 4878 0001                 pea.l      ($00000001).w
[00000100] 4eb9 0000 004a            jsr        _exit
[00000106] 588f                      addq.l     #4,a7
_main_1:
[00000108] 7a00                      moveq.l    #0,d5
[0000010a] 0cae 0000 0003 0008       cmpi.l     #$00000003,8(a6)
[00000112] 6d00 0112                 blt        _main_2
[00000116] 226e 000c                 movea.l    12(a6),a1
[0000011a] 2ea9 0004                 move.l     4(a1),(a7)
[0000011e] 4eb9 0000 0f46            jsr        _strlen
[00000124] 0c87 0000 0001            cmpi.l     #$00000001,d7
[0000012a] 6704                      beq.s      _main_3
[0000012c] 5285                      addq.l     #1,d5
[0000012e] 601e                      bra.s      _main_4
_main_3:
[00000130] 226e 000c                 movea.l    12(a6),a1
[00000134] 2269 0004                 movea.l    4(a1),a1
[00000138] 0c11 0030                 cmpi.b     #$30,(a1)
[0000013c] 650e                      bcs.s      _main_5
[0000013e] 226e 000c                 movea.l    12(a6),a1
[00000142] 2269 0004                 movea.l    4(a1),a1
[00000146] 0c11 0033                 cmpi.b     #$33,(a1)
[0000014a] 6302                      bls.s      _main_4
_main_5:
[0000014c] 5285                      addq.l     #1,d5
_main_4:
[0000014e] 226e 000c                 movea.l    12(a6),a1
[00000152] 2ea9 0008                 move.l     8(a1),(a7)
[00000156] 4eb9 0000 0f46            jsr        _strlen
[0000015c] 0c87 0000 0003            cmpi.l     #$00000003,d7
[00000162] 6704                      beq.s      _main_6
[00000164] 5285                      addq.l     #1,d5
[00000166] 6062                      bra.s      _main_7
_main_6:
[00000168] 226e 000c                 movea.l    12(a6),a1
[0000016c] 2269 0008                 movea.l    8(a1),a1
[00000170] 0c11 0041                 cmpi.b     #$41,(a1)
[00000174] 650e                      bcs.s      _main_8
[00000176] 226e 000c                 movea.l    12(a6),a1
[0000017a] 2269 0008                 movea.l    8(a1),a1
[0000017e] 0c11 005a                 cmpi.b     #$5A,(a1)
[00000182] 6302                      bls.s      _main_9
_main_8:
[00000184] 5285                      addq.l     #1,d5
_main_9:
[00000186] 226e 000c                 movea.l    12(a6),a1
[0000018a] 2269 0008                 movea.l    8(a1),a1
[0000018e] 0c29 0041 0001            cmpi.b     #$41,1(a1)
[00000194] 6510                      bcs.s      _main_10
[00000196] 226e 000c                 movea.l    12(a6),a1
[0000019a] 2269 0008                 movea.l    8(a1),a1
[0000019e] 0c29 005a 0001            cmpi.b     #$5A,1(a1)
[000001a4] 6302                      bls.s      _main_11
_main_10:
[000001a6] 5285                      addq.l     #1,d5
_main_11:
[000001a8] 226e 000c                 movea.l    12(a6),a1
[000001ac] 2269 0008                 movea.l    8(a1),a1
[000001b0] 0c29 0041 0002            cmpi.b     #$41,2(a1)
[000001b6] 6510                      bcs.s      _main_12
[000001b8] 226e 000c                 movea.l    12(a6),a1
[000001bc] 2269 0008                 movea.l    8(a1),a1
[000001c0] 0c29 005a 0002            cmpi.b     #$5A,2(a1)
[000001c6] 6302                      bls.s      _main_7
_main_12:
[000001c8] 5285                      addq.l     #1,d5
_main_7:
[000001ca] 226e 000c                 movea.l    12(a6),a1
[000001ce] 2269 0004                 movea.l    4(a1),a1
[000001d2] 7e00                      moveq.l    #0,d7
[000001d4] 1e11                      move.b     (a1),d7
[000001d6] 7cd0                      moveq.l    #-48,d6
[000001d8] dc87                      add.l      d7,d6
[000001da] 2806                      move.l     d6,d4
[000001dc] 226e 000c                 movea.l    12(a6),a1
[000001e0] 2869 0008                 movea.l    8(a1),a4
[000001e4] 0cae 0000 0004 0008       cmpi.l     #$00000004,8(a6)
[000001ec] 661c                      bne.s      _main_13
[000001ee] 226e 000c                 movea.l    12(a6),a1
[000001f2] 2ea9 000c                 move.l     12(a1),(a7)
[000001f6] 4eb9 0000 0e00            jsr        myatol
[000001fc] 2a47                      movea.l    d7,a5
[000001fe] 2e0d                      move.l     a5,d7
[00000200] 0c87 0000 0001            cmpi.l     #$00000001,d7
[00000206] 6c02                      bge.s      _main_13
[00000208] 5285                      addq.l     #1,d5
_main_13:
[0000020a] 4a85                      tst.l      d5
[0000020c] 6718                      beq.s      _main_2
[0000020e] 2ebc 0000 1488            move.l     #$000026A0,(a7) "invalid arguments specified!\n"
[00000214] 4eb9 0000 0d6e            jsr        print_str
[0000021a] 4878 0001                 pea.l      ($00000001).w
[0000021e] 4eb9 0000 004a            jsr        _exit
[00000224] 588f                      addq.l     #4,a7

_main_2:
[00000226] 486e fe00                 pea.l      -512(a6)
[0000022a] 2f39 0000 1452            move.l     $0000266A,-(a7) root_device
[00000230] 4eb9 0000 0374            jsr        read_block0
[00000236] 508f                      addq.l     #8,a7
[00000238] 7600                      moveq.l    #0,d3
_main_15:
[0000023a] 0c83 0000 0004            cmpi.l     #$00000004,d3
[00000240] 6c66                      bge.s      _main_14
[00000242] 2e83                      move.l     d3,(a7)
[00000244] 4878 000c                 pea.l      ($0000000C).w
[00000248] 4eb9 0000 11ea            jsr        a~lmul
[0000024e] 2e17                      move.l     (a7),d7
[00000250] 43ee ffc6                 lea.l      -58(a6),a1
[00000254] 43f1 7800                 lea.l      0(a1,d7.l),a1
[00000258] 2649                      movea.l    a1,a3
[0000025a] 2e8b                      move.l     a3,(a7)
[0000025c] 4eb9 0000 0a04            jsr        fetch_uint8
[00000262] 2c03                      move.l     d3,d6
[00000264] e586                      asl.l      #2,d6
[00000266] 2246                      movea.l    d6,a1
[00000268] d3fc 0000 195e            adda.l     #active_flag,a1
[0000026e] 2287                      move.l     d7,(a1)
[00000270] 486b 0004                 pea.l      4(a3)
[00000274] 4eb9 0000 0a1a            jsr        fetch_uint32
[0000027a] 588f                      addq.l     #4,a7
[0000027c] 2c03                      move.l     d3,d6
[0000027e] e586                      asl.l      #2,d6
[00000280] 2246                      movea.l    d6,a1
[00000282] d3fc 0000 194e            adda.l     #start_sec,a1
[00000288] 2287                      move.l     d7,(a1)
[0000028a] 486b 0008                 pea.l      8(a3)
[0000028e] 4eb9 0000 0a1a            jsr        fetch_uint32
[00000294] 588f                      addq.l     #4,a7
[00000296] 2c03                      move.l     d3,d6
[00000298] e586                      asl.l      #2,d6
[0000029a] 2246                      movea.l    d6,a1
[0000029c] d3fc 0000 193e            adda.l     #part_size,a1
[000002a2] 2287                      move.l     d7,(a1)
[000002a4] 5283                      addq.l     #1,d3
[000002a6] 6092                      bra.s      _main_15
_main_14:
[000002a8] 0cae 0000 0003 0008       cmpi.l     #$00000003,8(a6)
[000002b0] 6d00 0090                 blt        _main_16
[000002b4] 2e04                      move.l     d4,d7
[000002b6] e587                      asl.l      #2,d7
[000002b8] 2247                      movea.l    d7,a1
[000002ba] d3fc 0000 195e            adda.l     #active_flag,a1
[000002c0] 4a91                      tst.l      (a1)
[000002c2] 6618                      bne.s      _main_17
[000002c4] 2ebc 0000 14a6            move.l     #$000026BE,(a7) "inactive partition specified!\n"
[000002ca] 4eb9 0000 0d6e            jsr        print_str
[000002d0] 4878 0001                 pea.l      ($00000001).w
[000002d4] 4eb9 0000 004a            jsr        _exit
[000002da] 588f                      addq.l     #4,a7
_main_17:
[000002dc] 0cae 0000 0004 0008       cmpi.l     #$00000004,8(a6)
[000002e4] 6628                      bne.s      _main_18
[000002e6] 2e04                      move.l     d4,d7
[000002e8] e587                      asl.l      #2,d7
[000002ea] 2247                      movea.l    d7,a1
[000002ec] d3fc 0000 193e            adda.l     #part_size,a1
[000002f2] bbd1                      cmpa.l     (a1),a5
[000002f4] 6518                      bcs.s      _main_18
[000002f6] 2ebc 0000 14c5            move.l     #$000026DD,(a7) "specified offset too large!\n"
[000002fc] 4eb9 0000 0d6e            jsr        print_str
[00000302] 4878 0001                 pea.l      ($00000001).w
[00000306] 4eb9 0000 004a            jsr        _exit
[0000030c] 588f                      addq.l     #4,a7
_main_18:
[0000030e] 486e fe00                 pea.l      -512(a6)
[00000312] 2f0c                      move.l     a4,-(a7)
[00000314] 2f04                      move.l     d4,-(a7)
[00000316] 4eb9 0000 096c            jsr        set_partid
[0000031c] 4fef 000c                 lea.l      12(a7),a7
[00000320] 0cae 0000 0004 0008       cmpi.l     #$00000004,8(a6)
[00000328] 6618                      bne.s      _main_16
[0000032a] 2e8d                      move.l     a5,(a7)
[0000032c] 2e04                      move.l     d4,d7
[0000032e] e587                      asl.l      #2,d7
[00000330] 2247                      movea.l    d7,a1
[00000332] d3fc 0000 140a            adda.l     #partition_names,a1
[00000338] 2f11                      move.l     (a1),-(a7)
[0000033a] 4eb9 0000 09c2            jsr        set_reserved_sectors
[00000340] 588f                      addq.l     #4,a7
_main_16:
[00000342] 486e fe00                 pea.l      -512(a6)
[00000346] 4eb9 0000 04ba            jsr        show_info
[0000034c] 588f                      addq.l     #4,a7
[0000034e] 0cae 0000 0003 0008       cmpi.l     #$00000003,8(a6)
[00000356] 6d0c                      blt.s      _main_19
[00000358] 2eb9 0000 13ba            move.l     $000025D2,(a7) reboot_msg
[0000035e] 4eb9 0000 0d6e            jsr        print_str
_main_19:
[00000364] 4297                      clr.l      (a7)
[00000366] 4eb9 0000 004a            jsr        _exit
[0000036c] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00000370] 4e5e                      unlk       a6
[00000372] 4e75                      rts

void read_block0(const char *devname, unsigned char *buffer)
[00000374] 4e56 0000                 link       a6,#0
[00000378] 48e7 8400                 movem.l    d0/d5,-(a7)
[0000037c] 4297                      clr.l      (a7)
[0000037e] 2f2e 0008                 move.l     8(a6),-(a7)
[00000382] 4eb9 0000 0e5a            jsr        _open
[00000388] 588f                      addq.l     #4,a7
[0000038a] 2a07                      move.l     d7,d5
[0000038c] 6c2e                      bge.s      x374_1
[0000038e] 2ebc 0000 14e2            move.l     #$000026FA,(a7)
[00000394] 4eb9 0000 0d6e            jsr        print_str "Unable to open <"
[0000039a] 2eae 0008                 move.l     8(a6),(a7)
[0000039e] 4eb9 0000 0d6e            jsr        print_str
[000003a4] 2ebc 0000 14f3            move.l     #$0000270B,(a7) "> for reading!\n"
[000003aa] 4eb9 0000 0d6e            jsr        print_str
[000003b0] 4878 0001                 pea.l      ($00000001).w
[000003b4] 4eb9 0000 004a            jsr        _exit
[000003ba] 588f                      addq.l     #4,a7
x374_1:
[000003bc] 4878 0200                 pea.l      ($00000200).w
[000003c0] 2f2e 000c                 move.l     12(a6),-(a7)
[000003c4] 2f05                      move.l     d5,-(a7)
[000003c6] 4eb9 0000 0e6c            jsr        _read
[000003cc] 4fef 000c                 lea.l      12(a7),a7
[000003d0] 0c87 0000 0200            cmpi.l     #$00000200,d7
[000003d6] 672e                      beq.s      x374_2
[000003d8] 2ebc 0000 1503            move.l     #$0000271B,(a7) "Error reading block <0> of <"
[000003de] 4eb9 0000 0d6e            jsr        print_str
[000003e4] 2eae 0008                 move.l     8(a6),(a7)
[000003e8] 4eb9 0000 0d6e            jsr        print_str
[000003ee] 2ebc 0000 1520            move.l     #$00002738,(a7) ">!\n"
[000003f4] 4eb9 0000 0d6e            jsr        print_str
[000003fa] 4878 0001                 pea.l      ($00000001).w
[000003fe] 4eb9 0000 004a            jsr        _exit
[00000404] 588f                      addq.l     #4,a7
x374_2:
[00000406] 2e85                      move.l     d5,(a7)
[00000408] 4eb9 0000 0e7e            jsr        _close
[0000040e] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00000412] 4e5e                      unlk       a6
[00000414] 4e75                      rts

write_block0:
[00000416] 4e56 0000                 link       a6,#0
[0000041a] 48e7 8400                 movem.l    d0/d5,-(a7)
[0000041e] 4878 0002                 pea.l      ($00000002).w
[00000422] 2f2e 0008                 move.l     8(a6),-(a7)
[00000426] 4eb9 0000 0e5a            jsr        _open
[0000042c] 508f                      addq.l     #8,a7
[0000042e] 2a07                      move.l     d7,d5
[00000430] 6c2e                      bge.s      x416_1
[00000432] 2ebc 0000 1524            move.l     #$0000273C,(a7)
[00000438] 4eb9 0000 0d6e            jsr        print_str "Unable to open <"
[0000043e] 2eae 0008                 move.l     8(a6),(a7)
[00000442] 4eb9 0000 0d6e            jsr        print_str
[00000448] 2ebc 0000 1535            move.l     #$0000274D,(a7) "> for writing!\n"
[0000044e] 4eb9 0000 0d6e            jsr        print_str
[00000454] 4878 0001                 pea.l      ($00000001).w
[00000458] 4eb9 0000 004a            jsr        _exit
[0000045e] 588f                      addq.l     #4,a7
x416_1:
[00000460] 4878 0200                 pea.l      ($00000200).w
[00000464] 2f2e 000c                 move.l     12(a6),-(a7)
[00000468] 2f05                      move.l     d5,-(a7)
[0000046a] 4eb9 0000 0e48            jsr        _write
[00000470] 4fef 000c                 lea.l      12(a7),a7
[00000474] 0c87 0000 0200            cmpi.l     #$00000200,d7
[0000047a] 672e                      beq.s      x416_2
[0000047c] 2ebc 0000 1545            move.l     #$0000275D,(a7) "Error writing block <0> of <"
[00000482] 4eb9 0000 0d6e            jsr        print_str
[00000488] 2eae 0008                 move.l     8(a6),(a7)
[0000048c] 4eb9 0000 0d6e            jsr        print_str
[00000492] 2ebc 0000 1562            move.l     #$0000277A,(a7) ">!\n"
[00000498] 4eb9 0000 0d6e            jsr        print_str
[0000049e] 4878 0001                 pea.l      ($00000001).w
[00000492] 4eb9 0000 004a            jsr        _exit
[000004a8] 588f                      addq.l     #4,a7
x416_2:
[000004aa] 2e85                      move.l     d5,(a7)
[000004ac] 4eb9 0000 0e7e            jsr        _close
[000004b2] 4cdf 0021                 movem.l    (a7)+,d0/d5
[000004b6] 4e5e                      unlk       a6
[000004b8] 4e75                      rts

void show_info(struct rootsector *sector)
[000004ba] 4e56 ffec                 link       a6,#-20
[000004be] 2ebc 0000 15b5            move.l     #$000027CD,(a7)
[000004c4] 4eb9 0000 0d6e            jsr        print_str "\n+--------------------------------+------------+-------------------------+\n"
[000004ca] 2e2e 0008                 move.l     8(a6),d7
[000004ce] 2f07                      move.l     d7,-(a7)
[000004d0] 0697 0000 01b6            addi.l     #$000001B6,(a7)
[000004d6] 2f3c 0000 1601            move.l     #$00002819,-(a7) "*Number of cylinders"
[000004dc] 4eb9 0000 0b30            jsr        print_uint16
[000004e2] 508f                      addq.l     #8,a7
[000004e4] 2e2e 0008                 move.l     8(a6),d7
[000004e8] 2f07                      move.l     d7,-(a7)
[000004ea] 0697 0000 01b8            addi.l     #$000001B8,(a7)
[000004f0] 2f3c 0000 1616            move.l     #$0000282E,-(a7) "+Number of heads"
[000004f6] 4eb9 0000 0b12            jsr        print_uint8
[000004fc] 508f                      addq.l     #8,a7
[000004fe] 2eb9 0000 12fa            move.l     $00002512,(a7) version_str3
[00000504] 4eb9 0000 0d6e            jsr        print_str
[0000050a] 2e2e 0008                 move.l     8(a6),d7
[0000050e] 2f07                      move.l     d7,-(a7)
[00000510] 0697 0000 01b9            addi.l     #$000001B9,(a7)
[00000516] 2f3c 0000 1627            move.l     #$0000283F,-(a7) "*(unused)"
[0000051c] 4eb9 0000 0b12            jsr        print_uint8
[00000522] 508f                      addq.l     #8,a7
[00000524] 2e2e 0008                 move.l     8(a6),d7
[00000528] 2f07                      move.l     d7,-(a7)
[0000052a] 0697 0000 01ba            addi.l     #$000001BA,(a7)
[00000530] 2f3c 0000 1631            move.l     #$00002849,-(a7) "+Reduced write current cylinder"
[00000536] 4eb9 0000 0b30            jsr        print_uint16
[0000053c] 508f                      addq.l     #8,a7
[0000053e] 2eb9 0000 131a            move.l     $00002532,(a7) date_str
[00000544] 4eb9 0000 0d6e            jsr        print_str
[0000054a] 2e2e 0008                 move.l     8(a6),d7
[0000054e] 2f07                      move.l     d7,-(a7)
[00000550] 0697 0000 01bc            addi.l     #$000001BC,(a7)
[00000556] 2f3c 0000 1651            move.l     #$00002869,-(a7) "*Write-precompensation cylinder"
[0000055c] 4eb9 0000 0b30            jsr        print_uint16
[00000562] 508f                      addq.l     #8,a7
[00000564] 2e2e 0008                 move.l     8(a6),d7
[00000568] 2f07                      move.l     d7,-(a7)
[0000056a] 0697 0000 01be            addi.l     #$000001BE,(a7)
[00000570] 2f3c 0000 1671            move.l     #$00002889,-(a7) "+Landing zone"
[00000576] 4eb9 0000 0b12            jsr        print_uint8
[0000057c] 508f                      addq.l     #8,a7
[0000057e] 2eb9 0000 133a            move.l     $00002552,(a7) copyright_str
[00000584] 4eb9 0000 0d6e            jsr        print_str
[0000058a] 2e2e 0008                 move.l     8(a6),d7
[0000058e] 2f07                      move.l     d7,-(a7)
[00000590] 0697 0000 01bf            addi.l     #$000001BF,(a7)
[00000596] 2f3c 0000 167f            move.l     #$00002897,-(a7) "*Seek rate code"
[0000059c] 4eb9 0000 0b12            jsr        print_uint8
[000005a2] 508f                      addq.l     #8,a7
[000005a4] 2e2e 0008                 move.l     8(a6),d7
[000005a8] 2f07                      move.l     d7,-(a7)
[000005aa] 0697 0000 01c0            addi.l     #$000001C0,(a7)
[000005b0] 2f3c 0000 168f            move.l     #$000028A7,-(a7) "+Interleave factor"
[000005b6] 4eb9 0000 0b12            jsr        print_uint8
[000005bc] 508f                      addq.l     #8,a7
[000005be] 2eb9 0000 135a            move.l     $00002572,(a7) cti_str1
[000005c4] 4eb9 0000 0d6e            jsr        print_str
[000005ca] 2e2e 0008                 move.l     8(a6),d7
[000005ce] 2f07                      move.l     d7,-(a7)
[000005d0] 0697 0000 01c1            addi.l     #$000001C1,(a7)
[000005d6] 2f3c 0000 16a2            move.l     #$000028BA,-(a7) "*Number of sectors per track"
[000005dc] 4eb9 0000 0b12            jsr        print_uint8
[000005e2] 508f                      addq.l     #8,a7
[000005e4] 2e2e 0008                 move.l     8(a6),d7
[000005e8] 2f07                      move.l     d7,-(a7)
[000005ea] 0697 0000 01c2            addi.l     #$000001C2,(a7)
[000005f0] 2f3c 0000 16bf            move.l     #$000028D7,-(a7) "+Total 512-byte blocks"
[000005f6] 4eb9 0000 0b78            jsr        print_uint32
[000005fc] 508f                      addq.l     #8,a7
[000005fe] 2eb9 0000 137a            move.l     $00002592,(a7) cti_str2
[00000604] 4eb9 0000 0d6e            jsr        print_str
[0000060a] 2e2e 0008                 move.l     8(a6),d7
[0000060e] 2f07                      move.l     d7,-(a7)
[00000610] 0697 0000 01f6            addi.l     #$000001F6,(a7)
[00000616] 2f3c 0000 16d6            move.l     #$000028EE,-(a7) "*Start of bad-sector list"
[0000061c] 4eb9 0000 0b78            jsr        print_uint32
[00000622] 508f                      addq.l     #8,a7
[00000624] 2e2e 0008                 move.l     8(a6),d7
[00000628] 2f07                      move.l     d7,-(a7)
[0000062a] 0697 0000 01fa            addi.l     #$000001FA,(a7)
[00000630] 2f3c 0000 16f0            move.l     #$00002908,-(a7) "+Number of bad-sectors"
[00000636] 4eb9 0000 0b78            jsr        print_uint32
[0000063c] 508f                      addq.l     #8,a7
[0000063e] 2eb9 0000 139a            move.l     $000025B2,(a7) cti_str3
[00000644] 4eb9 0000 0d6e            jsr        print_str
[0000064a] 2e2e 0008                 move.l     8(a6),d7
[0000064e] 2f07                      move.l     d7,-(a7)
[00000650] 0697 0000 01fe            addi.l     #$000001FE,(a7)
[00000656] 2f3c 0000 1707            move.l     #$0000291F,-(a7) "*Block checksum"
[0000065c] 4eb9 0000 0b30            jsr        print_uint16
[00000662] 508f                      addq.l     #8,a7

[00000664] 2eb9 0000 1566            move.l     $0000277E,(a7) header_line
[0000066a] 4eb9 0000 0d6e            jsr        print_str
[00000670] 2ebc 0000 1717            move.l     #$0000292F,(a7) "| Partition number  |  (hdp3)  0 |  (hdp4)  1 |  (hdp5)  2 |  (hdp6)  3 |\n"
[00000676] 4eb9 0000 0d6e            jsr        print_str
[0000067c] 2ebc 0000 1762            move.l     #$0000297A,(a7) "| Flag byte         |"
[00000682] 4eb9 0000 0d6e            jsr        print_str
[00000688] 2eb9 0000 195e            move.l     active_flag[0],(a7)
[0000068e] 2f3c 0000 1778            move.l     #$00002990,-(a7) " "
[00000694] 4eb9 0000 0b96            jsr        print_val
[0000069a] 588f                      addq.l     #4,a7
[0000069c] 2eb9 0000 1962            move.l     active_flag[1],(a7)
[000006a2] 2f3c 0000 177a            move.l     #$00002992,-(a7) " | "
[000006a8] 4eb9 0000 0b96            jsr        print_val
[000006ae] 588f                      addq.l     #4,a7
[000006b0] 2eb9 0000 1966            move.l     active_flag[2],(a7)
[000006b6] 2f3c 0000 177e            move.l     #$00002996,-(a7) " | "
[000006bc] 4eb9 0000 0b96            jsr        print_val
[000006c2] 588f                      addq.l     #4,a7
[000006c4] 2eb9 0000 196a            move.l     active_flag[3],(a7)
[000006ca] 2f3c 0000 1782            move.l     #$0000299A,-(a7) " | "
[000006d0] 4eb9 0000 0b96            jsr        print_val
[000006d6] 588f                      addq.l     #4,a7
[000006d8] 2ebc 0000 1786            move.l     #$0000299E,(a7) " |\n"
[000006de] 4eb9 0000 0d6e            jsr        print_str
[000006e4] 2ebc 0000 178a            move.l     #$000029A2,(a7) "| Id string         |"
[000006ea] 4eb9 0000 0d6e            jsr        print_str
[000006f0] 2e2e 0008                 move.l     8(a6),d7
[000006f4] 2f07                      move.l     d7,-(a7)
[000006f6] 0697 0000 01c7            addi.l     #$000001C7,(a7)
[000006fc] 2f3c 0000 17a0            move.l     #$000029B8,-(a7) " "
[00000702] 4eb9 0000 0c8e            jsr        print_id
[00000708] 508f                      addq.l     #8,a7
[0000070a] 2e2e 0008                 move.l     8(a6),d7
[0000070e] 2f07                      move.l     d7,-(a7)
[00000710] 0697 0000 01d3            addi.l     #$000001D3,(a7)
[00000716] 2f3c 0000 17a2            move.l     #$000029BA,-(a7) " | "
[0000071c] 4eb9 0000 0c8e            jsr        print_id
[00000722] 508f                      addq.l     #8,a7
[00000724] 2e2e 0008                 move.l     8(a6),d7
[00000728] 2f07                      move.l     d7,-(a7)
[0000072a] 0697 0000 01df            addi.l     #$000001DF,(a7)
[00000730] 2f3c 0000 17a6            move.l     #$000029BE,-(a7) " | "
[00000736] 4eb9 0000 0c8e            jsr        print_id
[0000073c] 508f                      addq.l     #8,a7
[0000073e] 2e2e 0008                 move.l     8(a6),d7
[00000742] 2f07                      move.l     d7,-(a7)
[00000744] 0697 0000 01eb            addi.l     #$000001EB,(a7)
[0000074a] 2f3c 0000 17aa            move.l     #$000029C2,-(a7) " | "
[00000750] 4eb9 0000 0c8e            jsr        print_id
[00000756] 508f                      addq.l     #8,a7
[00000758] 2ebc 0000 17ae            move.l     #$000029C6,(a7) " |\n"
[0000075e] 4eb9 0000 0d6e            jsr        print_str
[00000764] 2ebc 0000 17b2            move.l     #$000029CA,(a7) "| Starting block    |"
[0000076a] 4eb9 0000 0d6e            jsr        print_str
[00000770] 2eb9 0000 194e            move.l     start_sec[0],(a7)
[00000776] 2f3c 0000 17c8            move.l     #$000029E0,-(a7) " "
[0000077c] 4eb9 0000 0b96            jsr        print_val
[00000782] 588f                      addq.l     #4,a7
[00000784] 2eb9 0000 1952            move.l     start_sec[1],(a7)
[0000078a] 2f3c 0000 17ca            move.l     #$000029E2,-(a7) " | "
[00000790] 4eb9 0000 0b96            jsr        print_val
[00000796] 588f                      addq.l     #4,a7
[00000798] 2eb9 0000 1956            move.l     start_sec[2],(a7)
[0000079e] 2f3c 0000 17ce            move.l     #$000029E6,-(a7) " | "
[000007a4] 4eb9 0000 0b96            jsr        print_val
[000007aa] 588f                      addq.l     #4,a7
[000007ac] 2eb9 0000 195a            move.l     start_sec[3],(a7)
[000007b2] 2f3c 0000 17d2            move.l     #$000029EA,-(a7) " | "
[000007b8] 4eb9 0000 0b96            jsr        print_val
[000007be] 588f                      addq.l     #4,a7
[000007c0] 2ebc 0000 17d6            move.l     #$000029EE,(a7) " |\n"
[000007c6] 4eb9 0000 0d6e            jsr        print_str

[000007cc] 2ebc 0000 17da            move.l     #$000029F2,(a7) "| Partition size    |"
[000007d2] 4eb9 0000 0d6e            jsr        print_str
[000007d8] 2eb9 0000 193e            move.l     part_size[0],(a7)
[000007de] 2f3c 0000 17f0            move.l     #$00002A08,-(a7) " "
[000007e4] 4eb9 0000 0b96            jsr        print_val
[000007ea] 588f                      addq.l     #4,a7
[000007ec] 2eb9 0000 1942            move.l     part_size[1],(a7)
[000007f2] 2f3c 0000 17f2            move.l     #$00002A0A,-(a7) " | "
[000007f8] 4eb9 0000 0b96            jsr        print_val
[000007fe] 588f                      addq.l     #4,a7
[00000800] 2eb9 0000 1946            move.l     part_size[2],(a7)
[00000806] 2f3c 0000 17f6            move.l     #$00002A0E,-(a7) " | "
[0000080c] 4eb9 0000 0b96            jsr        print_val
[00000812] 588f                      addq.l     #4,a7
[00000814] 2eb9 0000 194a            move.l     part_size[3],(a7)
[0000081a] 2f3c 0000 17fa            move.l     #$00002A12,-(a7) " | "
[00000820] 4eb9 0000 0b96            jsr        print_val
[00000826] 588f                      addq.l     #4,a7
[00000828] 2ebc 0000 17fe            move.l     #$00002A16,(a7) " |\n"
[0000082e] 4eb9 0000 0d6e            jsr        print_str

[00000834] 2ebc 0000 1802            move.l     #$00002A1A,(a7) "| Reserved blocks   |"
[0000083a] 4eb9 0000 0d6e            jsr        print_str
[00000840] 2eb9 0000 140a            move.l     partition_names[0],(a7)
[00000846] 2f39 0000 195e            move.l     active_flag[0],-(a7)
[0000084c] 2f3c 0000 1818            move.l     #$00002A30,-(a7) " "
[00000852] 4eb9 0000 0a8a            jsr        print_reserved
[00000858] 508f                      addq.l     #8,a7
[0000085a] 2d47 fffc                 move.l     d7,-4(a6)
[0000085e] 2eb9 0000 140e            move.l     partition_names[1],(a7)
[00000864] 2f39 0000 1962            move.l     active_flag[1],-(a7)
[0000086a] 2f3c 0000 181a            move.l     #$00002A32,-(a7) " | "
[00000870] 4eb9 0000 0a8a            jsr        print_reserved
[00000876] 508f                      addq.l     #8,a7
[00000878] 2d47 fff8                 move.l     d7,-8(a6)
[0000087c] 2eb9 0000 1412            move.l     partition_names[2],(a7)
[00000882] 2f39 0000 1966            move.l     active_flag[2],-(a7)
[00000888] 2f3c 0000 181e            move.l     #$00002A36,-(a7) " | "
[0000088e] 4eb9 0000 0a8a            jsr        print_reserved
[00000894] 508f                      addq.l     #8,a7
[00000896] 2d47 fff4                 move.l     d7,-12(a6)
[0000089a] 2eb9 0000 1416            move.l     partition_names[3],(a7)
[000008a0] 2f39 0000 196a            move.l     active_flag[3],-(a7)
[000008a6] 2f3c 0000 1822            move.l     #$00002A3A,-(a7) " | "
[000008ac] 4eb9 0000 0a8a            jsr        print_reserved
[000008b2] 508f                      addq.l     #8,a7
[000008b4] 2d47 fff0                 move.l     d7,-16(a6)
[000008b8] 2ebc 0000 1826            move.l     #$00002A3E,(a7) " |\n"
[000008be] 4eb9 0000 0d6e            jsr        print_str

[000008c4] 2ebc 0000 182a            move.l     #$00002A42,(a7) "| Size for 'mkfs'   |"
[000008ca] 4eb9 0000 0d6e            jsr        print_str
[000008d0] 2eae fffc                 move.l     -4(a6),(a7)
[000008d4] 2f39 0000 193e            move.l     part_size[0],-(a7)
[000008da] 2f39 0000 195e            move.l     active_flag[0],-(a7)
[000008e0] 2f3c 0000 1840            move.l     #$00002A58,-(a7) " "
[000008e6] 4eb9 0000 0ae0            jsr        print_mkfs
[000008ec] 4fef 000c                 lea.l      12(a7),a7
[000008f0] 2eae fff8                 move.l     -8(a6),(a7)
[000008f4] 2f39 0000 1942            move.l     part_size[1],-(a7)
[000008fa] 2f39 0000 1962            move.l     active_flag[1],-(a7)
[00000900] 2f3c 0000 1842            move.l     #$00002A5A,-(a7) " | "
[00000906] 4eb9 0000 0ae0            jsr        print_mkfs
[0000090c] 4fef 000c                 lea.l      12(a7),a7
[00000910] 2eae fff4                 move.l     -12(a6),(a7)
[00000914] 2f39 0000 1946            move.l     part_size[2],-(a7)
[0000091a] 2f39 0000 1966            move.l     active_flag[2],-(a7)
[00000920] 2f3c 0000 1846            move.l     #$00002A5E,-(a7) " | "
[00000926] 4eb9 0000 0ae0            jsr        print_mkfs
[0000092c] 4fef 000c                 lea.l      12(a7),a7
[00000930] 2eae fff0                 move.l     -16(a6),(a7)
[00000934] 2f39 0000 194a            move.l     part_size[3],-(a7)
[0000093a] 2f39 0000 196a            move.l     active_flag[3],-(a7)
[00000940] 2f3c 0000 184a            move.l     #$00002A62,-(a7) " | "
[00000946] 4eb9 0000 0ae0            jsr        print_mkfs
[0000094c] 4fef 000c                 lea.l      12(a7),a7
[00000950] 2ebc 0000 184e            move.l     #$00002A66,(a7) " |\n"
[00000956] 4eb9 0000 0d6e            jsr        print_str
[0000095c] 2eb9 0000 1566            move.l     $0000277E,(a7) header_line
[00000962] 4eb9 0000 0d6e            jsr        print_str
[00000968] 4e5e                      unlk       a6
[0000096a] 4e75                      rts

set_partid:
[0000096c] 4e56 0000                 link       a6,#0
[00000970] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000974] 2eae 0008                 move.l     8(a6),(a7)
[00000978] 4878 000c                 pea.l      ($0000000C).w
[0000097c] 4eb9 0000 11ea            jsr        a~lmul
[00000982] 2e17                      move.l     (a7),d7
[00000984] 0687 0000 01c7            addi.l     #$000001C7,d7
[0000098a] deae 0010                 add.l      16(a6),d7
[0000098e] 2a47                      movea.l    d7,a5
[00000990] 226e 000c                 movea.l    12(a6),a1
[00000994] 52ae 000c                 addq.l     #1,12(a6)
[00000998] 1ad1                      move.b     (a1),(a5)+
[0000099a] 226e 000c                 movea.l    12(a6),a1
[0000099e] 52ae 000c                 addq.l     #1,12(a6)
[000009a2] 1ad1                      move.b     (a1),(a5)+
[000009a4] 226e 000c                 movea.l    12(a6),a1
[000009a8] 1a91                      move.b     (a1),(a5)
[000009aa] 2eae 0010                 move.l     16(a6),(a7)
[000009ae] 2f39 0000 1452            move.l     $0000266A,-(a7) root_device
[000009b4] 4eba fa60                 jsr        write_block0(pc)
[000009b8] 588f                      addq.l     #4,a7
[000009ba] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000009be] 4e5e                      unlk       a6
[000009c0] 4e75                      rts

void set_reserved_sectors(const char *device_name, unsigned int count):
[000009c2] 4e56 fe00                 link       a6,#-512
[000009c6] 486e fe00                 pea.l      -512(a6)
[000009ca] 2f2e 0008                 move.l     8(a6),-(a7)
[000009ce] 4eba f9a4                 jsr        read_block0(pc)
[000009d2] 508f                      addq.l     #8,a7
[000009d4] 2e2e 000c                 move.l     12(a6),d7
[000009d8] 0287 0000 00ff            andi.l     #$000000FF,d7
[000009de] 1d47 fe0e                 move.b     d7,-498(a6) buf.res[0]
[000009e2] 2e2e 000c                 move.l     12(a6),d7
[000009e6] e087                      asr.l      #8,d7
[000009e8] 0287 0000 00ff            andi.l     #$000000FF,d7
[000009ee] 1d47 fe0f                 move.b     d7,-497(a6) buf.res[1]
[000009f2] 486e fe00                 pea.l      -512(a6)
[000009f6] 2f2e 0008                 move.l     8(a6),-(a7)
[000009fa] 4eba fa1a                 jsr        write_block0(pc)
[000009fe] 508f                      addq.l     #8,a7
[00000a00] 4e5e                      unlk       a6
[00000a02] 4e75                      rts

fetch_uint8:
[00000a04] 4e56 0000                 link       a6,#0
[00000a08] 226e 0008                 movea.l    8(a6),a1
[00000a0c] 7e00                      moveq.l    #0,d7
[00000a0e] 1e11                      move.b     (a1),d7
[00000a10] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000a16] 4e5e                      unlk       a6
[00000a18] 4e75                      rts

uint32_t fetch_uint32(const uint8_t *p):
[00000a1a] 4e56 0000                 link       a6,#0
[00000a1e] 48e7 8400                 movem.l    d0/d5,-(a7)
[00000a22] 226e 0008                 movea.l    8(a6),a1
[00000a26] 52ae 0008                 addq.l     #1,8(a6)
[00000a2a] 7e00                      moveq.l    #0,d7
[00000a2c] 1e11                      move.b     (a1),d7
[00000a2e] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000a34] 2a07                      move.l     d7,d5
[00000a36] 2e05                      move.l     d5,d7
[00000a38] e187                      asl.l      #8,d7
[00000a3a] 226e 0008                 movea.l    8(a6),a1
[00000a3e] 52ae 0008                 addq.l     #1,8(a6)
[00000a42] 7c00                      moveq.l    #0,d6
[00000a44] 1c11                      move.b     (a1),d6
[00000a46] 0286 0000 00ff            andi.l     #$000000FF,d6
[00000a4c] 8e86                      or.l       d6,d7
[00000a4e] 2a07                      move.l     d7,d5
[00000a50] 2e05                      move.l     d5,d7
[00000a52] e187                      asl.l      #8,d7
[00000a54] 226e 0008                 movea.l    8(a6),a1
[00000a58] 52ae 0008                 addq.l     #1,8(a6)
[00000a5c] 7c00                      moveq.l    #0,d6
[00000a5e] 1c11                      move.b     (a1),d6
[00000a60] 0286 0000 00ff            andi.l     #$000000FF,d6
[00000a66] 8e86                      or.l       d6,d7
[00000a68] 2a07                      move.l     d7,d5
[00000a6a] 2e05                      move.l     d5,d7
[00000a6c] e187                      asl.l      #8,d7
[00000a6e] 226e 0008                 movea.l    8(a6),a1
[00000a72] 7c00                      moveq.l    #0,d6
[00000a74] 1c11                      move.b     (a1),d6
[00000a76] 0286 0000 00ff            andi.l     #$000000FF,d6
[00000a7c] 8e86                      or.l       d6,d7
[00000a7e] 2a07                      move.l     d7,d5
[00000a80] 2e05                      move.l     d5,d7
[00000a82] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00000a86] 4e5e                      unlk       a6
[00000a88] 4e75                      rts

unsigned int print_reserved(const char *prefix, const uint8_t *active, const char *device_name):
[00000a8a] 4e56 fe00                 link       a6,#-512
[00000a8e] 48e7 8400                 movem.l    d0/d5,-(a7)
[00000a92] 4aae 000c                 tst.l      12(a6)
[00000a96] 6604                      bne.s      xa8a_1
[00000a98] 7a00                      moveq.l    #0,d5
[00000a9a] 602c                      bra.s      xa8a_2
xa8a_1:
[00000a9c] 486e fe00                 pea.l      -512(a6)
[00000aa0] 2f2e 0010                 move.l     16(a6),-(a7)
[00000aa4] 4eba f8ce                 jsr        read_block0(pc)
[00000aa8] 508f                      addq.l     #8,a7
[00000aaa] 7e00                      moveq.l    #0,d7
[00000aac] 1e2e fe0e                 move.b     -498(a6),d7
[00000ab0] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000ab6] 7c00                      moveq.l    #0,d6
[00000ab8] 1c2e fe0f                 move.b     -497(a6),d6
[00000abc] e186                      asl.l      #8,d6
[00000abe] 0286 0000 ff00            andi.l     #$0000FF00,d6
[00000ac4] 8e86                      or.l       d6,d7
[00000ac6] 2a07                      move.l     d7,d5
xa8a_2:
[00000ac8] 2e85                      move.l     d5,(a7)
[00000aca] 2f2e 0008                 move.l     8(a6),-(a7)
[00000ace] 4eb9 0000 0b96            jsr        print_val
[00000ad4] 588f                      addq.l     #4,a7
[00000ad6] 2e05                      move.l     d5,d7
[00000ad8] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00000adc] 4e5e                      unlk       a6
[00000ade] 4e75                      rts

void print_mkfs(const char *prefix, unsigned int active, uint32_t size, unsigned int reserved)
[00000ae0] 4e56 0000                 link       a6,#0
[00000ae4] 48e7 8400                 movem.l    d0/d5,-(a7)
[00000ae8] 4aae 000c                 tst.l      12(a6)
[00000aec] 6604                      bne.s      xae0_1
[00000aee] 7a00                      moveq.l    #0,d5
[00000af0] 600a                      bra.s      xae0_2
xae0_1:
[00000af2] 2e2e 0010                 move.l     16(a6),d7
[00000af6] 9eae 0014                 sub.l      20(a6),d7
[00000afa] 2a07                      move.l     d7,d5
xae0_2:
[00000afc] 2e85                      move.l     d5,(a7)
[00000afe] 2f2e 0008                 move.l     8(a6),-(a7)
[00000b02] 4eb9 0000 0b96            jsr        print_val
[00000b08] 588f                      addq.l     #4,a7
[00000b0a] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00000b0e] 4e5e                      unlk       a6
[00000b10] 4e75                      rts

print_uint8(const char *prefix, const uint8_t *val)::
[00000b12] 4e56 fffc                 link       a6,#-4
[00000b16] 2eae 000c                 move.l     12(a6),(a7)
[00000b1a] 4eba fee8                 jsr        fetch_uint8(pc)
[00000b1e] 2e87                      move.l     d7,(a7)
[00000b20] 2f2e 0008                 move.l     8(a6),-(a7)
[00000b24] 4eb9 0000 0b96            jsr        print_val
[00000b2a] 588f                      addq.l     #4,a7
[00000b2c] 4e5e                      unlk       a6
[00000b2e] 4e75                      rts

print_uint16(const char *prefix, const uint8_t *val)::
[00000b30] 4e56 0000                 link       a6,#0
[00000b34] 48e7 8400                 movem.l    d0/d5,-(a7)
[00000b38] 226e 000c                 movea.l    12(a6),a1
[00000b3c] 52ae 000c                 addq.l     #1,12(a6)
[00000b40] 7e00                      moveq.l    #0,d7
[00000b42] 1e11                      move.b     (a1),d7
[00000b44] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000b4a] 2a07                      move.l     d7,d5
[00000b4c] 2e05                      move.l     d5,d7
[00000b4e] e187                      asl.l      #8,d7
[00000b50] 226e 000c                 movea.l    12(a6),a1
[00000b54] 7c00                      moveq.l    #0,d6
[00000b56] 1c11                      move.b     (a1),d6
[00000b58] 0286 0000 00ff            andi.l     #$000000FF,d6
[00000b5e] 8e86                      or.l       d6,d7
[00000b60] 2a07                      move.l     d7,d5
[00000b62] 2e85                      move.l     d5,(a7)
[00000b64] 2f2e 0008                 move.l     8(a6),-(a7)
[00000b68] 4eb9 0000 0b96            jsr        print_val
[00000b6e] 588f                      addq.l     #4,a7
[00000b70] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00000b74] 4e5e                      unlk       a6
[00000b76] 4e75                      rts

void print_uint32(const char *prefix, const uint8_t *val):
[00000b78] 4e56 fffc                 link       a6,#-4
[00000b7c] 2eae 000c                 move.l     12(a6),(a7)
[00000b80] 4eba fe98                 jsr        fetch_uint32(pc)
[00000b84] 2e87                      move.l     d7,(a7)
[00000b86] 2f2e 0008                 move.l     8(a6),-(a7)
[00000b8a] 4eb9 0000 0b96            jsr        print_val
[00000b90] 588f                      addq.l     #4,a7
[00000b92] 4e5e                      unlk       a6
[00000b94] 4e75                      rts

void print_val(const char *prefix, uint32_t val)
[00000b96] 4e56 ff00                 link       a6,#-256
[00000b9a] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000b9e] 2eae 000c                 move.l     12(a6),(a7)
[00000ba2] 4eb9 0000 0d92            jsr        ltoa
[00000ba8] 2a47                      movea.l    d7,a5
[00000baa] 2eb9 0000 1852            move.l     $00002A6A,(a7) spaces
[00000bb0] 486e ff00                 pea.l      -256(a6)
[00000bb4] 4eb9 0000 0f20            jsr        _strcpy
[00000bba] 588f                      addq.l     #4,a7
[00000bbc] 2e8d                      move.l     a5,(a7)
[00000bbe] 2f0d                      move.l     a5,-(a7)
[00000bc0] 4eb9 0000 0f46            jsr        _strlen
[00000bc6] 588f                      addq.l     #4,a7
[00000bc8] 7c0a                      moveq.l    #10,d6
[00000bca] 9c87                      sub.l      d7,d6
[00000bcc] 43ee ff00                 lea.l      -256(a6),a1
[00000bd0] 4871 6800                 pea.l      0(a1,d6.l)
[00000bd4] 4eb9 0000 0f20            jsr        _strcpy
[00000bda] 588f                      addq.l     #4,a7
[00000bdc] 226e 0008                 movea.l    8(a6),a1
[00000be0] 0c11 002a                 cmpi.b     #$2A,(a1)
[00000be4] 670c                      beq.s      xb96_1
[00000be6] 226e 0008                 movea.l    8(a6),a1
[00000bea] 0c11 002b                 cmpi.b     #$2B,(a1)
[00000bee] 6600 0080                 bne        xb96_2 ; possibly optimized to short
xb96_1:
[00000bf2] 2e2e 0008                 move.l     8(a6),d7
[00000bf6] 2f07                      move.l     d7,-(a7)
[00000bf8] 5297                      addq.l     #1,(a7)
[00000bfa] 486e ff80                 pea.l      -128(a6)
[00000bfe] 4eb9 0000 0f20            jsr        _strcpy
[00000c04] 508f                      addq.l     #8,a7
[00000c06] 2eb9 0000 1852            move.l     $00002A6A,(a7) spaces
[00000c0c] 486e ff80                 pea.l      -128(a6)
[00000c10] 4eb9 0000 0ece            jsr        _strcat
[00000c16] 588f                      addq.l     #4,a7
[00000c18] 422e ff9f                 clr.b      -97(a6)
[00000c1c] 2ebc 0000 187e            move.l     #$00002A96,(a7) "| "
[00000c22] 4eb9 0000 0d6e            jsr        print_str
[00000c28] 486e ff80                 pea.l      -128(a6)
[00000c2c] 4eb9 0000 0d6e            jsr        print_str
[00000c32] 588f                      addq.l     #4,a7
[00000c34] 2ebc 0000 1881            move.l     #$00002A99,(a7) "| "
[00000c3a] 4eb9 0000 0d6e            jsr        print_str
[00000c40] 486e ff00                 pea.l      -256(a6)
[00000c44] 4eb9 0000 0d6e            jsr        print_str
[00000c4a] 588f                      addq.l     #4,a7
[00000c4c] 2ebc 0000 1884            move.l     #$00002A9C,(a7) " |"
[00000c52] 4eb9 0000 0d6e            jsr        print_str
[00000c58] 226e 0008                 movea.l    8(a6),a1
[00000c5c] 0c11 002a                 cmpi.b     #$2A,(a1)
[00000c60] 6624                      bne.s      xb96_3
[00000c62] 2ebc 0000 1887            move.l     #$00002A9F,(a7) "                         |\n"
[00000c68] 4eb9 0000 0d6e            jsr        print_str
[00000c6e] 6016                      bra.s      xb96_3
xb96_2:
[00000c70] 2eae 0008                 move.l     8(a6),(a7)
[00000c74] 4eb9 0000 0d6e            jsr        print_str
[00000c7a] 486e ff00                 pea.l      -256(a6)
[00000c7e] 4eb9 0000 0d6e            jsr        print_str
[00000c84] 588f                      addq.l     #4,a7
xb96_3:
[00000c86] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000c8a] 4e5e                      unlk       a6
[00000c8c] 4e75                      rts

print_id:
[00000c8e] 4e56 fff4                 link       a6,#-12
[00000c92] 2eae 0008                 move.l     8(a6),(a7)
[00000c96] 4eb9 0000 0d6e            jsr        print_str
[00000c9c] 226e 000c                 movea.l    12(a6),a1
[00000ca0] 52ae 000c                 addq.l     #1,12(a6)
[00000ca4] 7e00                      moveq.l    #0,d7
[00000ca6] 1e11                      move.b     (a1),d7
[00000ca8] 7c7f                      moveq.l    #127,d6
[00000caa] cc87                      and.l      d7,d6
[00000cac] 1d46 ffff                 move.b     d6,-1(a6)
[00000cb0] 0c2e 0020 ffff            cmpi.b     #$20,-1(a6)
[00000cb6] 6508                      bcs.s      xc8e_1
[00000cb8] 0c2e 007f ffff            cmpi.b     #$7F,-1(a6)
[00000cbe] 6606                      bne.s      xc8e_2
xc8e_1:
[00000cc0] 1d7c 0020 ffff            move.b     #$20,-1(a6)
xc8e_2:
[00000cc6] 226e 000c                 movea.l    12(a6),a1
[00000cca] 52ae 000c                 addq.l     #1,12(a6)
[00000cce] 7e00                      moveq.l    #0,d7
[00000cd0] 1e11                      move.b     (a1),d7
[00000cd2] 7c7f                      moveq.l    #127,d6
[00000cd4] cc87                      and.l      d7,d6
[00000cd6] 1d46 fffe                 move.b     d6,-2(a6)
[00000cda] 0c2e 0020 fffe            cmpi.b     #$20,-2(a6)
[00000ce0] 6508                      bcs.s      xc8e_3
[00000ce2] 0c2e 007f fffe            cmpi.b     #$7F,-2(a6)
[00000ce8] 6606                      bne.s      xc8e_4
xc8e_3:
[00000cea] 1d7c 0020 fffe            move.b     #$20,-2(a6)
xc8e_4:
[00000cf0] 226e 000c                 movea.l    12(a6),a1
[00000cf4] 7e00                      moveq.l    #0,d7
[00000cf6] 1e11                      move.b     (a1),d7
[00000cf8] 7c7f                      moveq.l    #127,d6
[00000cfa] cc87                      and.l      d7,d6
[00000cfc] 1d46 fffd                 move.b     d6,-3(a6)
[00000d00] 0c2e 0020 fffd            cmpi.b     #$20,-3(a6)
[00000d06] 6508                      bcs.s      xc8e_5
[00000d08] 0c2e 007f fffd            cmpi.b     #$7F,-3(a6)
[00000d0e] 6606                      bne.s      xc8e_6
xc8e_5:
[00000d10] 1d7c 0020 fffd            move.b     #$20,-3(a6)
xc8e_6:
[00000d16] 0c2e 0020 ffff            cmpi.b     #$20,-1(a6)
[00000d1c] 661e                      bne.s      xc8e_7
[00000d1e] 0c2e 0020 fffe            cmpi.b     #$20,-2(a6)
[00000d24] 6616                      bne.s      xc8e_7
[00000d26] 0c2e 0020 fffd            cmpi.b     #$20,-3(a6)
[00000d2c] 660e                      bne.s      xc8e_7
[00000d2e] 2ebc 0000 18a3            move.l     #$00002ABB,(a7) "    (none)"
[00000d34] 4eb9 0000 0d6e            jsr        print_str
[00000d3a] 602e                      bra.s      xc8e_8
xc8e_7:
[00000d3c] 1d6e ffff fff9            move.b     -1(a6),-7(a6)
[00000d42] 1d6e fffe fffa            move.b     -2(a6),-6(a6)
[00000d48] 1d6e fffd fffb            move.b     -3(a6),-5(a6)
[00000d4e] 422e fffc                 clr.b      -4(a6)
[00000d52] 2ebc 0000 18ae            move.l     #$00002AC6,(a7) "       "
[00000d58] 4eb9 0000 0d6e            jsr        print_str
[00000d5e] 486e fff9                 pea.l      -7(a6)
[00000d62] 4eb9 0000 0d6e            jsr        print_str
[00000d68] 588f                      addq.l     #4,a7
xc8e_8:
[00000d6a] 4e5e                      unlk       a6
[00000d6c] 4e75                      rts

print_str:
[00000d6e] 4e56 fffc                 link       a6,#-4
[00000d72] 2eae 0008                 move.l     8(a6),(a7)
[00000d76] 4eb9 0000 0f46            jsr        _strlen
[00000d7c] 2e87                      move.l     d7,(a7)
[00000d7e] 2f2e 0008                 move.l     8(a6),-(a7)
[00000d82] 4878 0001                 pea.l      ($00000001).w
[00000d86] 4eb9 0000 0e48            jsr        _write
[00000d8c] 508f                      addq.l     #8,a7
[00000d8e] 4e5e                      unlk       a6
[00000d90] 4e75                      rts

ltoa:
[00000d92] 4e56 fffc                 link       a6,#-4
[00000d96] 2ebc 0000 191e            move.l     #$00002B36,(a7)
[00000d9c] 2f2e 0008                 move.l     8(a6),-(a7)
[00000da0] 4eb9 0000 0db2            jsr        ltoa_r
[00000da6] 588f                      addq.l     #4,a7
[00000da8] 2e3c 0000 191e            move.l     #$00002B36,d7
[00000dae] 4e5e                      unlk       a6
[00000db0] 4e75                      rts

ltoa_r:
[00000db2] 4e56 0000                 link       a6,#0
[00000db6] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00000dba] 2a2e 0008                 move.l     8(a6),d5
[00000dbe] 2a6e 000c                 movea.l    12(a6),a5
[00000dc2] 2e85                      move.l     d5,(a7)
[00000dc4] 4878 000a                 pea.l      ($0000000A).w
[00000dc8] 4eb9 0000 119c            jsr        a~ldiv
[00000dce] 2e17                      move.l     (a7),d7
[00000dd0] 2807                      move.l     d7,d4
[00000dd2] 670c                      beq.s      xdb2_1
[00000dd4] 2e8d                      move.l     a5,(a7)
[00000dd6] 2f04                      move.l     d4,-(a7)
[00000dd8] 4eba ffd8                 jsr        $00000DB2(pc)
[00000ddc] 588f                      addq.l     #4,a7
[00000dde] 2a47                      movea.l    d7,a5
xdb2_1:
[00000de0] 2e85                      move.l     d5,(a7)
[00000de2] 4878 000a                 pea.l      ($0000000A).w
[00000de6] 4eb9 0000 118a            jsr        a~lmod
[00000dec] 2e17                      move.l     (a7),d7
[00000dee] 7c30                      moveq.l    #48,d6
[00000df0] dc87                      add.l      d7,d6
[00000df2] 1ac6                      move.b     d6,(a5)+
[00000df4] 4215                      clr.b      (a5)
[00000df6] 2e0d                      move.l     a5,d7
[00000df8] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00000dfc] 4e5e                      unlk       a6
[00000dfe] 4e75                      rts

myatol:
[00000e00] 4e56 0000                 link       a6,#0
[00000e04] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00000e08] 2a6e 0008                 movea.l    8(a6),a5
[00000e0c] 7a00                      moveq.l    #0,d5
xe00_5:
[00000e0e] 4a15                      tst.b      (a5)
[00000e10] 672c                      beq.s      xe00_1
[00000e12] 0c15 0030                 cmpi.b     #$30,(a5)
[00000e16] 6506                      bcs.s      xe00_2
[00000e18] 0c15 0039                 cmpi.b     #$39,(a5)
[00000e1c] 6304                      bls.s      xe00_3
xe00_2:
[00000e1e] 7eff                      moveq.l    #-1,d7
[00000e20] 601e                      bra.s      xe00_4
xe00_3:
[00000e22] 2e85                      move.l     d5,(a7)
[00000e24] 4878 000a                 pea.l      ($0000000A).w
[00000e28] 4eb9 0000 11ea            jsr        a~lmul
[00000e2e] 2e17                      move.l     (a7),d7
[00000e30] 7c00                      moveq.l    #0,d6
[00000e32] 1c1d                      move.b     (a5)+,d6
[00000e34] 78d0                      moveq.l    #-48,d4
[00000e36] d886                      add.l      d6,d4
[00000e38] de84                      add.l      d4,d7
[00000e3a] 2a07                      move.l     d7,d5
[00000e3c] 60d0                      bra.s      xe00_5
xe00_1:
[00000e3e] 2e05                      move.l     d5,d7
xe00_4:
[00000e40] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00000e44] 4e5e                      unlk       a6
[00000e46] 4e75                      rts

_write:
[00000e48] 205f                      movea.l    (a7)+,a0
[00000e4a] 7e04                      moveq.l    #4,d7
[00000e4c] 4e41                      trap       #1
[00000e4e] 6400 0008                 bcc.w      xe48_1
[00000e52] 4ef9 0000 009a            jmp        $0000009A
xe48_1:
[00000e58] 4ed0                      jmp        (a0)

_open:
[00000e5a] 205f                      movea.l    (a7)+,a0
[00000e5c] 7e05                      moveq.l    #5,d7
[00000e5e] 4e41                      trap       #1
[00000e60] 6400 0008                 bcc.w      xe48_2
[00000e64] 4ef9 0000 009a            jmp        $0000009A
xe48_2:
[00000e6a] 4ed0                      jmp        (a0)

_read:
[00000e6c] 205f                      movea.l    (a7)+,a0
[00000e6e] 7e03                      moveq.l    #3,d7
[00000e70] 4e41                      trap       #1
[00000e72] 6400 0008                 bcc.w      xe48_3
[00000e76] 4ef9 0000 009a            jmp        $0000009A
xe48_3:
[00000e7c] 4ed0                      jmp        (a0)

_close:
[00000e7e] 205f                      movea.l    (a7)+,a0
[00000e80] 7e06                      moveq.l    #6,d7
[00000e82] 4e41                      trap       #1
[00000e84] 6400 0008                 bcc.w      xe48_4
[00000e88] 4ef9 0000 009a            jmp        $0000009A
xe48_4:
[00000e8e] 4ed0                      jmp        (a0)

__cstat:
[00000e90] 33fc 000a 0000 1972       move.w     #$000A,$00002B8A
[00000e98] 42b9 0000 1a3a            clr.l      $00002C52
[00000e9e] 42b9 0000 1a3e            clr.l      $00002C56
[00000ea4] 13fc 0061 0000 1a42       move.b     #$61,$00002C5A
[00000eac] 4239 0000 1a43            clr.b      $00002C5B
[00000eb2] 4279 0000 1a44            clr.w      $00002C5C
[00000eb8] 4279 0000 1a46            clr.w      $00002C5E
[00000ebe] 4279 0000 1a48            clr.w      $00002C60
[00000ec4] 33fc ffff 0000 1a4a       move.w     #$FFFF,$00002C62
[00000ecc] 4e75                      rts

_strcat:
[00000ece] 4e56 fffc                 link       a6,#-4
[00000ed2] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00000ed6] 2a6e 0008                 movea.l    8(a6),a5
[00000eda] 286e 000c                 movea.l    12(a6),a4
[00000ede] 2d4d fffc                 move.l     a5,-4(a6)
xece_2:
[00000ee2] 4a15                      tst.b      (a5)
[00000ee4] 6704                      beq.s      xece_1
[00000ee6] 528d                      addq.l     #1,a5
[00000ee8] 60f8                      bra.s      xece_2
xece_1:
[00000eea] 4a14                      tst.b      (a4)
[00000eec] 6704                      beq.s      xece_3
[00000eee] 1adc                      move.b     (a4)+,(a5)+
[00000ef0] 60f8                      bra.s      xece_1
xece_3:
[00000ef2] 4215                      clr.b      (a5)
[00000ef4] 2e2e fffc                 move.l     -4(a6),d7
[00000ef8] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00000efc] 4e5e                      unlk       a6
[00000efe] 4e75                      rts

__astat:
[00000f00] 23fc 0000 1aa4 0000 1a4c  move.l     #__stderr,_stderr
[00000f0a] 23fc 0000 1ac0 0000 1a50  move.l     #__stdin,_stdin
[00000f14] 23fc 0000 1adc 0000 1a54  move.l     #__stdout,_stdout
[00000f1e] 4e75                      rts

_strcpy:
[00000f20] 4e56 0000                 link       a6,#0
[00000f24] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00000f28] 2a6e 0008                 movea.l    8(a6),a5
[00000f2c] 286e 000c                 movea.l    12(a6),a4
[00000f30] 264d                      movea.l    a5,a3
xf20_2:
[00000f32] 4a14                      tst.b      (a4)
[00000f34] 6704                      beq.s      xf20_1
[00000f36] 1adc                      move.b     (a4)+,(a5)+
[00000f38] 60f8                      bra.s      xf20_2
xf20_1:
[00000f3a] 4215                      clr.b      (a5)
[00000f3c] 2e0b                      move.l     a3,d7
[00000f3e] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00000f42] 4e5e                      unlk       a6
[00000f44] 4e75                      rts

_strlen:
[00000f46] 4e56 0000                 link       a6,#0
[00000f4a] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00000f4e] 2a6e 0008                 movea.l    8(a6),a5
[00000f52] 284d                      movea.l    a5,a4
xf46_2:
[00000f54] 4a14                      tst.b      (a4)
[00000f56] 6704                      beq.s      xf46_1
[00000f58] 528c                      addq.l     #1,a4
[00000f5a] 60f8                      bra.s      xf46_2
xf46_1:
[00000f5c] 2e0c                      move.l     a4,d7
[00000f5e] 9e8d                      sub.l      a5,d7
[00000f60] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00000f64] 4e5e                      unlk       a6
[00000f66] 4e75                      rts

__main:
[00000f68] 4e56 0000                 link       a6,#0
[00000f6c] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00000f70] 2e2e 0008                 move.l     8(a6),d7
[00000f74] 5287                      addq.l     #1,d7
[00000f76] e587                      asl.l      #2,d7
[00000f78] 43ee 000c                 lea.l      12(a6),a1
[00000f7c] 43f1 7800                 lea.l      0(a1,d7.l),a1
[00000f80] 2849                      movea.l    a1,a4
[00000f82] 23cc 0000 1a58            move.l     a4,$00002C70
[00000f88] 4aae 0008                 tst.l      8(a6)
[00000f8c] 6728                      beq.s      xf68_1
[00000f8e] 23ee 000c 0000 1914       move.l     12(a6),$00002B2C
[00000f96] 2a6e 000c                 movea.l    12(a6),a5
xf68_3:
[00000f9a] 4a15                      tst.b      (a5)
[00000f9c] 6718                      beq.s      xf68_1
[00000f9e] 0c15 003a                 cmpi.b     #$3A,(a5)
[00000fa2] 670a                      beq.s      xf68_2
[00000fa4] 0c15 007c                 cmpi.b     #$7C,(a5)
[00000fa8] 6704                      beq.s      xf68_2
[00000faa] 528d                      addq.l     #1,a5
[00000fac] 60ec                      bra.s      xf68_3
xf68_2:
[00000fae] 421d                      clr.b      (a5)+
[00000fb0] 23cd 0000 18bc            move.l     a5,$00002AD4
xf68_1:
[00000fb6] 2ebc 0000 18b6            move.l     #$00002ACE,(a7)
[00000fbc] 4eb9 0000 0ffa            jsr        $00000FFA
[00000fc2] 2a47                      movea.l    d7,a5
[00000fc4] 2e0d                      move.l     a5,d7
[00000fc6] 6706                      beq.s      xf68_4
[00000fc8] 23cd 0000 18bc            move.l     a5,$00002AD4
xf68_4:
[00000fce] 2e8c                      move.l     a4,(a7)
[00000fd0] 486e 000c                 pea.l      12(a6)
[00000fd4] 2f2e 0008                 move.l     8(a6),-(a7)
[00000fd8] 4eb9 0000 00a6            jsr        $000000A6
[00000fde] 508f                      addq.l     #8,a7
[00000fe0] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00000fe4] 4e5e                      unlk       a6
[00000fe6] 4e75                      rts

__signal:
[00000fe8] 205f                      movea.l    (a7)+,a0
[00000fea] 7e30                      moveq.l    #48,d7
[00000fec] 4e41                      trap       #1
[00000fee] 6400 0008                 bcc.w      xfe8_1
[00000ff2] 4ef9 0000 009a            jmp        $0000009A
xfe8_1:
[00000ff8] 4ed0                      jmp        (a0)
[00000ffa] 4e56 0000                 link       a6,#0
[00000ffe] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00001002] 2a6e 0008                 movea.l    8(a6),a5
[00001006] 2e8d                      move.l     a5,(a7)
[00001008] 4eb9 0000 1050            jsr        $00001050
[0000100e] 2a07                      move.l     d7,d5
[00001010] 2879 0000 1a58            movea.l    $00002C70,a4
xfe8_5:
[00001016] 2e0c                      move.l     a4,d7
[00001018] 672c                      beq.s      xfe8_2
[0000101a] 4a94                      tst.l      (a4)
[0000101c] 6728                      beq.s      xfe8_2
[0000101e] 2e85                      move.l     d5,(a7)
[00001020] 2f14                      move.l     (a4),-(a7)
[00001022] 2f0d                      move.l     a5,-(a7)
[00001024] 4eb9 0000 1072            jsr        $00001072
[0000102a] 508f                      addq.l     #8,a7
[0000102c] 4a87                      tst.l      d7
[0000102e] 6712                      beq.s      xfe8_3
[00001030] 2254                      movea.l    (a4),a1
[00001032] 0c31 003d 5800            cmpi.b     #$3D,0(a1,d5.l)
[00001038] 6608                      bne.s      xfe8_3
[0000103a] 2e05                      move.l     d5,d7
[0000103c] 5287                      addq.l     #1,d7
[0000103e] de94                      add.l      (a4),d7
[00001040] 6006                      bra.s      xfe8_4
xfe8_3:
[00001042] 588c                      addq.l     #4,a4
[00001044] 60d0                      bra.s      xfe8_5
xfe8_2:
[00001046] 7e00                      moveq.l    #0,d7
xfe8_4:
[00001048] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000104c] 4e5e                      unlk       a6
[0000104e] 4e75                      rts

x1050:
[00001050] 4e56 0000                 link       a6,#0
[00001054] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00001058] 2a6e 0008                 movea.l    8(a6),a5
[0000105c] 284d                      movea.l    a5,a4
x1050_2:
[0000105e] 4a14                      tst.b      (a4)
[00001060] 6704                      beq.s      x1050_1
[00001062] 528c                      addq.l     #1,a4
[00001064] 60f8                      bra.s      x1050_2
x1050_1:
[00001066] 2e0c                      move.l     a4,d7
[00001068] 9e8d                      sub.l      a5,d7
[0000106a] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[0000106e] 4e5e                      unlk       a6
[00001070] 4e75                      rts

x1072:
[00001072] 4e56 0000                 link       a6,#0
[00001076] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000107a] 2a6e 0008                 movea.l    8(a6),a5
[0000107e] 286e 000c                 movea.l    12(a6),a4
[00001082] 2a2e 0010                 move.l     16(a6),d5
x1072_4:
[00001086] 4a85                      tst.l      d5
[00001088] 670e                      beq.s      x1072_1
[0000108a] 1e1d                      move.b     (a5)+,d7
[0000108c] be1c                      cmp.b      (a4)+,d7
[0000108e] 6704                      beq.s      x1072_2
[00001090] 7e00                      moveq.l    #0,d7
[00001092] 6006                      bra.s      x1072_3
x1072_2:
[00001094] 5385                      subq.l     #1,d5
[00001096] 60ee                      bra.s      x1072_4
x1072_1:
[00001098] 7e01                      moveq.l    #1,d7
x1072_3:
[0000109a] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000109e] 4e5e                      unlk       a6
[000010a0] 4e75                      rts

__lstat:
[000010a2] 7005                      moveq.l    #5,d0
[000010a4] 23c0 0000 1a64            move.l     d0,__timezone
[000010aa] 7001                      moveq.l    #1,d0
[000010ac] 23c0 0000 1a5c            move.l     d0,__dst
[000010b2] 23fc 0000 18f0 0000 1a88  move.l     #$00002B08,__domerr
[000010bc] 23fc 0000 18fd 0000 1a8c  move.l     #$00002B15,__memerr
[000010c6] 23fc 0000 1907 0000 1a90  move.l     #$00002B1F,__ranerr
[000010d0] 7e01                      moveq.l    #1,d7
[000010d2] 23c7 0000 1a94            move.l     d7,__stop
[000010d8] 23fc 0000 1adc 0000 1a98  move.l     #__stdout,__pfile
[000010e2] 42b9 0000 1aa4            clr.l      $00002CBC
[000010e8] 33fc 0002 0000 1aa8       move.w     #$0002,$00002CC0
[000010f0] 33fc 0208 0000 1aaa       move.w     #$0208,$00002CC2
[000010f8] 42b9 0000 1aac            clr.l      $00002CC4
[000010fe] 23fc 0000 0200 0000 1ab0  move.l     #$00000200,$00002CC8
[00001108] 42b9 0000 1ab4            clr.l      $00002CCC
[0000110e] 42b9 0000 1ab8            clr.l      $00002CD0
[00001114] 42b9 0000 1abc            clr.l      $00002CD4
[0000111a] 42b9 0000 1ac0            clr.l      $00002CD8
[00001120] 4279 0000 1ac4            clr.w      $00002CDC
[00001126] 33fc 0004 0000 1ac6       move.w     #$0004,$00002CDE
[0000112e] 42b9 0000 1ac8            clr.l      $00002CE0
[00001134] 23fc 0000 0200 0000 1acc  move.l     #$00000200,$00002CE4
[0000113e] 42b9 0000 1ad0            clr.l      $00002CE8
[00001144] 42b9 0000 1ad4            clr.l      $00002CEC
[0000114a] 42b9 0000 1ad8            clr.l      $00002CF0
[00001150] 42b9 0000 1adc            clr.l      __stdout
[00001156] 33fc 0001 0000 1ae0       move.w     #$0001,$00002CF8
[0000115e] 33fc 0008 0000 1ae2       move.w     #$0008,$00002CFA
[00001166] 42b9 0000 1ae4            clr.l      $00002CFC
[0000116c] 23fc 0000 0200 0000 1ae8  move.l     #$00000200,$00002D00
[00001176] 42b9 0000 1aec            clr.l      $00002D04
[0000117c] 42b9 0000 1af0            clr.l      $00002D08
[00001182] 42b9 0000 1af4            clr.l      $00002D0C
[00001188] 4e75                      rts

a~lmod:
[0000118a] 48e7 7c00                 movem.l    d1-d5,-(a7)
[0000118e] 3a3c ff00                 move.w     #$FF00,d5
[00001192] 282f 0018                 move.l     24(a7),d4
[00001196] 6c14                      bge.s      x118a_1
[00001198] 4484                      neg.l      d4
[0000119a] 6010                      bra.s      x118a_1
a~ldiv:
[0000119c] 48e7 7c00                 movem.l    d1-d5,-(a7)
[000011a0] 4245                      clr.w      d5
[000011a2] 282f 0018                 move.l     24(a7),d4
[000011a6] 6c04                      bge.s      x118a_1
[000011a8] 4484                      neg.l      d4
[000011aa] 4605                      not.b      d5
x118a_1:
[000011ac] 262f 001c                 move.l     28(a7),d3
[000011b0] 6c04                      bge.s      x118a_2
[000011b2] 4483                      neg.l      d3
[000011b4] 4605                      not.b      d5
x118a_2:
[000011b6] 4282                      clr.l      d2
[000011b8] 721f                      moveq.l    #31,d1
[000011ba] 4280                      clr.l      d0
x118a_4:
[000011bc] e38a                      lsl.l      #1,d2
[000011be] e38b                      lsl.l      #1,d3
[000011c0] d580                      addx.l     d0,d2
[000011c2] b484                      cmp.l      d4,d2
[000011c4] 6504                      bcs.s      x118a_3
[000011c6] 9484                      sub.l      d4,d2
[000011c8] 5283                      addq.l     #1,d3
x118a_3:
[000011ca] 51c9 fff0                 dbf        d1,x118a_4
[000011ce] 4a45                      tst.w      d5
[000011d0] 6c04                      bge.s      x118a_5
[000011d2] 2002                      move.l     d2,d0
[000011d4] 6002                      bra.s      x118a_6
x118a_5:
[000011d6] 2003                      move.l     d3,d0
x118a_6:
[000011d8] 4a05                      tst.b      d5
[000011da] 6702                      beq.s      x118a_7
[000011dc] 4480                      neg.l      d0
x118a_7:
[000011de] 4cdf 003e                 movem.l    (a7)+,d1-d5
[000011e2] 2e9f                      move.l     (a7)+,(a7)
[000011e4] 2f40 0004                 move.l     d0,4(a7)
[000011e8] 4e75                      rts

a~lmul:
[000011ea] 302f 0008                 move.w     8(a7),d0
[000011ee] c0ef 0006                 mulu.w     6(a7),d0
[000011f2] 3f40 0008                 move.w     d0,8(a7)
[000011f6] 302f 000a                 move.w     10(a7),d0
[000011fa] c0ef 0004                 mulu.w     4(a7),d0
[000011fe] d16f 0008                 add.w      d0,8(a7)
[00001202] 302f 000a                 move.w     10(a7),d0
[00001206] c0ef 0006                 mulu.w     6(a7),d0
[0000120a] 426f 000a                 clr.w      10(a7)
[0000120e] 2e9f                      move.l     (a7)+,(a7)
[00001210] d1af 0004                 add.l      d0,4(a7)
[00001214] 4e75                      rts

x1216:
[00001216] 4afc                      illegal

	.data
[00001218] [00002430]                           dc.b $00
[00001219] [00002431]                           dc.b 'IDR68K Edition 3.1: Copyright (c) 1981, 1983, 1986, 1987 by Whitesmiths, Ltd. all rights reserved',0
[0000127b] [00002493]                           dc.b $00
[0000127c] [00002494]                           dc.b $00
[0000127d] [00002495]                           dc.b $00
[0000127e] [00002496]                           dc.b $00
[0000127f] [00002497]                           dc.b $00
[00001280] [00002498] 00000068                  dc.l $00000068
version_str1:
[00001284] [0000249c] 00001288                  dc.l $000024a0
[00001288] [000024a0]                           dc.b '<<show0.c: Version 1.00 December 4, 1987>>',0
[000012b3] [000024cb]                           dc.b $00
version_str2:
[000012b4] [000024cc] 000012b8                  dc.l $000024d0
[000012b8] [000024d0]                           dc.b '<<Copyright (C) 1986-1987 by Computer Tools International Inc.>>',0
[000012f9] [00002511]                           dc.b $00
version_str3:
[000012fa] [00002512] 000012fe                  dc.l $00002516
[000012fe] [00002516]                           dc.b '    show0: Version 1.00  |',$0a,0
date_str
[0000131a] [00002532] 0000131e                  dc.l $00002536
[0000131e] [00002536]                           dc.b '     December 4, 1987    |',$0a,0
copyright_str
[0000133a] [00002552] 0000133e                  dc.l $00002556
[0000133e] [00002556]                           dc.b '  Copyright (C) 1987 by  |',$0a,0
cti_str1
[0000135a] [00002572] 0000135e                  dc.l $00002576
[0000135e] [00002576]                           dc.b '   (C)omputer            |',$0a,0
cti_str2
[0000137a] [00002592] 0000137e                  dc.l $00002596
[0000137e] [00002596]                           dc.b '     (T)ools             |',$0a,0
cti_str3
[0000139a] [000025b2] 0000139e                  dc.l $000025b6
[0000139e] [000025b6]                           dc.b '       (I)nternational   |',$0a,0
reboot_msg:
[000013ba] [000025d2] 000013be                  dc.l $000025d6
[000013be] [000025d6]                           dc.b '<<-- the system must be rebooted for the changes to have any effect! -->>',$0a,0
[00001409] [00002621]                           dc.b $00
partition_names:
[0000140a] [00002622] 00001444                  dc.l $0000265c
[0000140e] [00002626] 00001436                  dc.l $0000264e
[00001412] [0000262a] 00001428                  dc.l $00002640
[00001416] [0000262e] 0000141a                  dc.l $00002632
[0000141a] [00002632]                           dc.b '/dev/hdp6_all',0
[00001428] [00002640]                           dc.b '/dev/hdp5_all',0
[00001436] [0000264e]                           dc.b '/dev/hdp4_all',0
[00001444] [0000265c]                           dc.b '/dev/hdp3_all',0
root_device:
[00001452] [0000266a] 00001456                  dc.l $0000266e
[00001456] [0000266e]                           dc.b '/dev/hdp7',0
[00001460] [00002678]                           dc.w $0a00
[00001462] [0000267a]                           dc.b 'usage: ',0
[0000146a] [00002682]                           dc.b ' [partition name [reserved]]',$0a,0
[00001488] [000026a0]                           dc.b 'invalid arguments specified!',$0a,0
[000014a6] [000026be]                           dc.b 'inactive partition specified!',$0a,0
[000014c5] [000026dd]                           dc.b 'specified offset too large!',$0a,0
[000014e2] [000026fa]                           dc.b 'Unable to open <',0
[000014f3] [0000270b]                           dc.b '> for reading!',$0a,0
[00001503] [0000271b]                           dc.b 'Error reading block <0> of <',0
[00001520] [00002738]                           dc.b '>!',$0a,0
[00001524] [0000273c]                           dc.b 'Unable to open <',0
[00001535] [0000274d]                           dc.b '> for writing!',$0a,0
[00001545] [0000275d]                           dc.b 'Error writing block <0> of <',0
[00001562] [0000277a]                           dc.b '>!',$0a,0
header_line:
[00001566] [0000277e] 0000156a                  dc.l $00002782
[0000156a] [00002782]                           dc.b     '+-------------------+------------+------------+------------+------------+',$0a,0
[000015b5] [000027cd]                           dc.b $0a,'+--------------------------------+------------+-------------------------+',$0a,0
[00001601] [00002819]                           dc.b '*Number of cylinders',0
[00001616] [0000282e]                           dc.b '+Number of heads',0
[00001627] [0000283f]                           dc.b '*(unused)',0
[00001631] [00002849]                           dc.b '+Reduced write current cylinder',0
[00001651] [00002869]                           dc.b '*Write-precompensation cylinder',0
[00001671] [00002889]                           dc.b '+Landing zone',0
[0000167f] [00002897]                           dc.b '*Seek rate code',0
[0000168f] [000028a7]                           dc.b '+Interleave factor',0
[000016a2] [000028ba]                           dc.b '*Number of sectors per track',0
[000016bf] [000028d7]                           dc.b '+Total 512-byte blocks',0
[000016d6] [000028ee]                           dc.b '*Start of bad-sector list',0
[000016f0] [00002908]                           dc.b '+Number of bad-sectors',0
[00001707] [0000291f]                           dc.b '*Block checksum',0
[00001717] [0000292f]                           dc.b '| Partition number  |  (hdp3)  0 |  (hdp4)  1 |  (hdp5)  2 |  (hdp6)  3 |',$0a,0
[00001762] [0000297a]                           dc.b '| Flag byte         |',0
[00001778] [00002990]                           dc.w $2000
[0000177a] [00002992]                           dc.b ' | ',0
[0000177e] [00002996]                           dc.b ' | ',0
[00001782] [0000299a]                           dc.b ' | ',0
[00001786] [0000299e]                           dc.b ' |',$0a,0
[0000178a] [000029a2]                           dc.b '| Id string         |',0
[000017a0] [000029b8]                           dc.w $2000
[000017a2] [000029ba]                           dc.b ' | ',0
[000017a6] [000029be]                           dc.b ' | ',0
[000017aa] [000029c2]                           dc.b ' | ',0
[000017ae] [000029c6]                           dc.b ' |',$0a,0
[000017b2] [000029ca]                           dc.b '| Starting block    |',0
[000017c8] [000029e0]                           dc.w $2000
[000017ca] [000029e2]                           dc.b ' | ',0
[000017ce] [000029e6]                           dc.b ' | ',0
[000017d2] [000029ea]                           dc.b ' | ',0
[000017d6] [000029ee]                           dc.b ' |',$0a,0
[000017da] [000029f2]                           dc.b '| Partition size    |',0
[000017f0] [00002a08]                           dc.w $2000
[000017f2] [00002a0a]                           dc.b ' | ',0
[000017f6] [00002a0e]                           dc.b ' | ',0
[000017fa] [00002a12]                           dc.b ' | ',0
[000017fe] [00002a16]                           dc.b ' |',$0a,0
[00001802] [00002a1a]                           dc.b '| Reserved blocks   |',0
[00001818] [00002a30]                           dc.w $2000
[0000181a] [00002a32]                           dc.b ' | ',0
[0000181e] [00002a36]                           dc.b ' | ',0
[00001822] [00002a3a]                           dc.b ' | ',0
[00001826] [00002a3e]                           dc.b ' |',$0a,0
[0000182a] [00002a42]                           dc.b '| Size for ',$27,'mkfs',$27,'   |',0
[00001840] [00002a58]                           dc.w $2000
[00001842] [00002a5a]                           dc.b ' | ',0
[00001846] [00002a5e]                           dc.b ' | ',0
[0000184a] [00002a62]                           dc.b ' | ',0
[0000184e] [00002a66]                           dc.b ' |',$0a,0
[00001852] [00002a6a] 00001856                  dc.l $00002a6e
[00001856] [00002a6e]                           dc.b '                                       ',0
[0000187e] [00002a96]                           dc.w $7c20
[00001880] [00002a98]                           dc.b $00
[00001881] [00002a99]                           dc.b $7c
[00001882] [00002a9a]                           dc.w $2000
[00001884] [00002a9c]                           dc.w $207c
[00001886] [00002a9e]                           dc.b $00
[00001887] [00002a9f]                           dc.b '                         |',$0a,0
[000018a3] [00002abb]                           dc.b '    (none)',0
[000018ae] [00002ac6]                           dc.b '       ',0
[000018b6] [00002ace]                           dc.b 'PATH',0
[000018bb] [00002ad3]                           dc.b $00
[000018bc] [00002ad4] 000018c0                  dc.l $00002ad8
[000018c0] [00002ad8]                           dc.b '|/bin/|/usr/bin/|/etc/bin/',0
[000018db] [00002af3]                           dc.b $00
[000018dc] [00002af4]                           dc.b 'EDT',0
[000018e0] [00002af8]                           dc.b 'EST',0
[000018e4] [00002afc]                           dc.w $545a
[000018e6] [00002afe]                           dc.b $00
[000018e7] [00002aff]                           dc.b $00
[000018e8] [00002b00] 000018dc                  dc.l $00002af4
[000018ec] [00002b04] 000018e0                  dc.l $00002af8
[000018f0] [00002b08]                           dc.b 'domain error',0
[000018fd] [00002b15]                           dc.b 'no memory',0
[00001907] [00002b1f]                           dc.b 'range error',0
[00001913] [00002b2b]                           dc.b $00
[00001914] [00002b2c] 00001918                  dc.l $00002b30
[00001918] [00002b30]                           dc.b 'error',0

2b56 part_size[4]
2b66 start_sec[4]
2b76 active_flag[4]
2c64 _stderr
2c68 _stdin
2c6c _stdout
2c74 __dst
2c7c __timezone
2ca0 __domerr
2ca4 __memerr
2ca8 __ranerr
2cac __stop
2cb0 __pfile
2cbc __stderr
2cd8 __stdin
2cf4 __stdout

; a.out Relocations:
00000006: 00001218
00000012: 00001218
00000018: 00000000
0000001e: 00000000
00000024: 00000000
0000002a: 00000000
00000036: 00000000
0000003e: 00000000
00000046: 00000000
0000004c: 00001218
00000052: 00000000
0000006a: 00001218
00000072: 00001218
0000009e: 00001218
000000b0: 00001218
000000b6: 00000000
000000da: 00001218
000000e0: 00000000
000000ec: 00000000
000000f2: 00001218
000000f8: 00000000
00000102: 00000000
00000120: 00000000
00000158: 00000000
000001f8: 00000000
00000210: 00001218
00000216: 00000000
00000220: 00000000
0000022c: 00001218
00000232: 00000000
0000024a: 00000000
0000025e: 00000000
0000026a: 00001218
00000276: 00000000
00000284: 00001218
00000290: 00000000
0000029e: 00001218
000002bc: 00001218
000002c6: 00001218
000002cc: 00000000
000002d6: 00000000
000002ee: 00001218
000002f8: 00001218
000002fe: 00000000
00000308: 00000000
00000318: 00000000
00000334: 00001218
0000033c: 00000000
00000348: 00000000
0000035a: 00001218
00000360: 00000000
00000368: 00000000
00000384: 00000000
00000390: 00001218
00000396: 00000000
000003a0: 00000000
000003a6: 00001218
000003ac: 00000000
000003b6: 00000000
000003c8: 00000000
000003da: 00001218
000003e0: 00000000
000003ea: 00000000
000003f0: 00001218
000003f6: 00000000
00000400: 00000000
0000040a: 00000000
00000428: 00000000
00000434: 00001218
0000043a: 00000000
00000444: 00000000
0000044a: 00001218
00000450: 00000000
0000045a: 00000000
0000046c: 00000000
0000047e: 00001218
00000484: 00000000
0000048e: 00000000
00000494: 00001218
0000049a: 00000000
000004a4: 00000000
000004ae: 00000000
000004c0: 00001218
000004c6: 00000000
000004d8: 00001218
000004de: 00000000
000004f2: 00001218
000004f8: 00000000
00000500: 00001218
00000506: 00000000
00000518: 00001218
0000051e: 00000000
00000532: 00001218
00000538: 00000000
00000540: 00001218
00000546: 00000000
00000558: 00001218
0000055e: 00000000
00000572: 00001218
00000578: 00000000
00000580: 00001218
00000586: 00000000
00000598: 00001218
0000059e: 00000000
000005b2: 00001218
000005b8: 00000000
000005c0: 00001218
000005c6: 00000000
000005d8: 00001218
000005de: 00000000
000005f2: 00001218
000005f8: 00000000
00000600: 00001218
00000606: 00000000
00000618: 00001218
0000061e: 00000000
00000632: 00001218
00000638: 00000000
00000640: 00001218
00000646: 00000000
00000658: 00001218
0000065e: 00000000
00000666: 00001218
0000066c: 00000000
00000672: 00001218
00000678: 00000000
0000067e: 00001218
00000684: 00000000
0000068a: 00001218
00000690: 00001218
00000696: 00000000
0000069e: 00001218
000006a4: 00001218
000006aa: 00000000
000006b2: 00001218
000006b8: 00001218
000006be: 00000000
000006c6: 00001218
000006cc: 00001218
000006d2: 00000000
000006da: 00001218
000006e0: 00000000
000006e6: 00001218
000006ec: 00000000
000006fe: 00001218
00000704: 00000000
00000718: 00001218
0000071e: 00000000
00000732: 00001218
00000738: 00000000
0000074c: 00001218
00000752: 00000000
0000075a: 00001218
00000760: 00000000
00000766: 00001218
0000076c: 00000000
00000772: 00001218
00000778: 00001218
0000077e: 00000000
00000786: 00001218
0000078c: 00001218
00000792: 00000000
0000079a: 00001218
000007a0: 00001218
000007a6: 00000000
000007ae: 00001218
000007b4: 00001218
000007ba: 00000000
000007c2: 00001218
000007c8: 00000000
000007ce: 00001218
000007d4: 00000000
000007da: 00001218
000007e0: 00001218
000007e6: 00000000
000007ee: 00001218
000007f4: 00001218
000007fa: 00000000
00000802: 00001218
00000808: 00001218
0000080e: 00000000
00000816: 00001218
0000081c: 00001218
00000822: 00000000
0000082a: 00001218
00000830: 00000000
00000836: 00001218
0000083c: 00000000
00000842: 00001218
00000848: 00001218
0000084e: 00001218
00000854: 00000000
00000860: 00001218
00000866: 00001218
0000086c: 00001218
00000872: 00000000
0000087e: 00001218
00000884: 00001218
0000088a: 00001218
00000890: 00000000
0000089c: 00001218
000008a2: 00001218
000008a8: 00001218
000008ae: 00000000
000008ba: 00001218
000008c0: 00000000
000008c6: 00001218
000008cc: 00000000
000008d6: 00001218
000008dc: 00001218
000008e2: 00001218
000008e8: 00000000
000008f6: 00001218
000008fc: 00001218
00000902: 00001218
00000908: 00000000
00000916: 00001218
0000091c: 00001218
00000922: 00001218
00000928: 00000000
00000936: 00001218
0000093c: 00001218
00000942: 00001218
00000948: 00000000
00000952: 00001218
00000958: 00000000
0000095e: 00001218
00000964: 00000000
0000097e: 00000000
000009b0: 00001218
00000ad0: 00000000
00000b04: 00000000
00000b26: 00000000
00000b6a: 00000000
00000b8c: 00000000
00000ba4: 00000000
00000bac: 00001218
00000bb6: 00000000
00000bc2: 00000000
00000bd6: 00000000
00000c00: 00000000
00000c08: 00001218
00000c12: 00000000
00000c1e: 00001218
00000c24: 00000000
00000c2e: 00000000
00000c36: 00001218
00000c3c: 00000000
00000c46: 00000000
00000c4e: 00001218
00000c54: 00000000
00000c64: 00001218
00000c6a: 00000000
00000c76: 00000000
00000c80: 00000000
00000c98: 00000000
00000d30: 00001218
00000d36: 00000000
00000d54: 00001218
00000d5a: 00000000
00000d64: 00000000
00000d78: 00000000
00000d88: 00000000
00000d98: 00001218
00000da2: 00000000
00000daa: 00001218
00000dca: 00000000
00000de8: 00000000
00000e2a: 00000000
00000e54: 00000000
00000e66: 00000000
00000e78: 00000000
00000e8a: 00000000
00000e94: 00001218
00000e9a: 00001218
00000ea0: 00001218
00000ea8: 00001218
00000eae: 00001218
00000eb4: 00001218
00000eba: 00001218
00000ec0: 00001218
00000ec8: 00001218
00000f02: 00001218
00000f06: 00001218
00000f0c: 00001218
00000f10: 00001218
00000f16: 00001218
00000f1a: 00001218
00000f84: 00001218
00000f92: 00001218
00000fb2: 00001218
00000fb8: 00001218
00000fbe: 00000000
00000fca: 00001218
00000fda: 00000000
00000ff4: 00000000
0000100a: 00000000
00001012: 00001218
00001026: 00000000
000010a6: 00001218
000010ae: 00001218
000010b4: 00001218
000010b8: 00001218
000010be: 00001218
000010c2: 00001218
000010c8: 00001218
000010cc: 00001218
000010d4: 00001218
000010da: 00001218
000010de: 00001218
000010e4: 00001218
000010ec: 00001218
000010f4: 00001218
000010fa: 00001218
00001104: 00001218
0000110a: 00001218
00001110: 00001218
00001116: 00001218
0000111c: 00001218
00001122: 00001218
0000112a: 00001218
00001130: 00001218
0000113a: 00001218
00001140: 00001218
00001146: 00001218
0000114c: 00001218
00001152: 00001218
0000115a: 00001218
00001162: 00001218
00001168: 00001218
00001172: 00001218
00001178: 00001218
0000117e: 00001218
00001184: 00001218
00001280: 00000000
00001284: 00001218
000012b4: 00001218
000012fa: 00001218
0000131a: 00001218
0000133a: 00001218
0000135a: 00001218
0000137a: 00001218
0000139a: 00001218
000013ba: 00001218
0000140a: 00001218
0000140e: 00001218
00001412: 00001218
00001416: 00001218
00001452: 00001218
00001566: 00001218
00001852: 00001218
000018bc: 00001218
000018e8: 00001218
000018ec: 00001218
00001914: 00001218

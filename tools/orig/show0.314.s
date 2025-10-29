; a_magic   = 0x9928
; a_text    = 0x0000118e
; a_data    = 0x00000752
; a_bss     = 0x000001ec
; a_syms    = 0x00000000
; a_heap    = 0x00000000
; a_textoff = 0x00000000
; a_dataoff = 0x0000118e
; a_relocs  = 0x0000026e@0x000018fc


x0:
[00000000] 0cb9 0000 0001 0000 1a56  cmpi.l     #$00000001,$00002BE4
[0000000a] 660a                      bne.s      x0_1
[0000000c] 23fc 0002 093e 0000 1a56  move.l     #$0002093E,$00002BE4
x0_1:
[00000016] 4eb9 0000 0fce            jsr        __lstat
[0000001c] 4eb9 0000 0e4a            jsr        __astat
[00000022] 4eb9 0000 0dcc            jsr        __cstat
[00000028] 4879 0000 0078            pea.l      $00000078
[0000002e] 2f3c ffff ffff            move.l     #$FFFFFFFF,-(a7)
[00000034] 4eb9 0000 0f2a            jsr        $00000F2A
[0000003a] 508f                      addq.l     #8,a7
[0000003c] 4eb9 0000 0eb2            jsr        $00000EB2
[00000042] 2e87                      move.l     d7,(a7)
[00000044] 4eb9 0000 004a            jsr        _exit
[0000004a] 2e39 0000 11f6            move.l     $00002384,d7
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
[00000068] 2e39 0000 11f6            move.l     $00002384,d7
[0000006e] 23ef 0004 0000 11f6       move.l     4(a7),$00002384
[00000076] 4e75                      rts

x78:
[00000078] 48e7 ffff                 movem.l    d0-d7/a0-a7,-(a7)
[0000007c] 486f 0048                 pea.l      72(a7)
[00000080] 2f2f 0048                 move.l     72(a7),-(a7)
[00000084] 206f 0048                 movea.l    72(a7),a0
[00000088] 4e90                      jsr        (a0)
[0000008a] 508f                      addq.l     #8,a7
[0000008c] 4cdf 7fff                 movem.l    (a7)+,d0-d7/a0-a6
[00000090] dffc 0000 000c            adda.l     #$0000000C,a7
[00000096] 4e73                      rte
[00000098] 4a9f                      tst.l      (a7)+
[0000009a] 4487                      neg.l      d7
[0000009c] 23c7 0000 11f2            move.l     d7,$00002380
[000000a2] 7eff                      moveq.l    #-1,d7
[000000a4] 4ed0                      jmp        (a0)

_main:
[000000a6] 4e56 fdfa                 link       a6,#-518
[000000aa] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[000000ae] 0cae 0000 0001 0008       cmpi.l     #$00000001,8(a6)
[000000b6] 6744                      beq.s      _main_1
[000000b8] 0cae 0000 0003 0008       cmpi.l     #$00000003,8(a6)
[000000c0] 673a                      beq.s      _main_1
[000000c2] 0cae 0000 0004 0008       cmpi.l     #$00000004,8(a6)
[000000ca] 6730                      beq.s      _main_1
[000000cc] 2ebc 0000 143d            move.l     #$000025CB,(a7)
[000000d2] 4eb9 0000 0cb2            jsr        print_str
[000000d8] 226e 000c                 movea.l    12(a6),a1
[000000dc] 2e91                      move.l     (a1),(a7)
[000000de] 4eb9 0000 0cb2            jsr        print_str
[000000e4] 2ebc 0000 1445            move.l     #$000025D3,(a7)
[000000ea] 4eb9 0000 0cb2            jsr        print_str
[000000f0] 4878 0001                 pea.l      ($00000001).w
[000000f4] 4eb9 0000 004a            jsr        _exit
[000000fa] 588f                      addq.l     #4,a7
_main_1:
[000000fc] 7a00                      moveq.l    #0,d5
[000000fe] 0cae 0000 0003 0008       cmpi.l     #$00000003,8(a6)
[00000106] 6d00 0112                 blt        _main_2
[0000010a] 226e 000c                 movea.l    12(a6),a1
[0000010e] 2ea9 0004                 move.l     4(a1),(a7)
[00000112] 4eb9 0000 0e90            jsr        _strlen
[00000118] 0c87 0000 0001            cmpi.l     #$00000001,d7
[0000011e] 6704                      beq.s      _main_3
[00000120] 5285                      addq.l     #1,d5
[00000122] 601e                      bra.s      _main_4
_main_3:
[00000124] 226e 000c                 movea.l    12(a6),a1
[00000128] 2269 0004                 movea.l    4(a1),a1
[0000012c] 0c11 0030                 cmpi.b     #$30,(a1)
[00000130] 650e                      bcs.s      _main_5
[00000132] 226e 000c                 movea.l    12(a6),a1
[00000136] 2269 0004                 movea.l    4(a1),a1
[0000013a] 0c11 0033                 cmpi.b     #$33,(a1)
[0000013e] 6302                      bls.s      _main_4
_main_5:
[00000140] 5285                      addq.l     #1,d5
_main_4:
[00000142] 226e 000c                 movea.l    12(a6),a1
[00000146] 2ea9 0008                 move.l     8(a1),(a7)
[0000014a] 4eb9 0000 0e90            jsr        _strlen
[00000150] 0c87 0000 0003            cmpi.l     #$00000003,d7
[00000156] 6704                      beq.s      _main_6
[00000158] 5285                      addq.l     #1,d5
[0000015a] 6062                      bra.s      _main_7
_main_6:
[0000015c] 226e 000c                 movea.l    12(a6),a1
[00000160] 2269 0008                 movea.l    8(a1),a1
[00000164] 0c11 0041                 cmpi.b     #$41,(a1)
[00000168] 650e                      bcs.s      _main_8
[0000016a] 226e 000c                 movea.l    12(a6),a1
[0000016e] 2269 0008                 movea.l    8(a1),a1
[00000172] 0c11 005a                 cmpi.b     #$5A,(a1)
[00000176] 6302                      bls.s      _main_9
_main_8:
[00000178] 5285                      addq.l     #1,d5
_main_9:
[0000017a] 226e 000c                 movea.l    12(a6),a1
[0000017e] 2269 0008                 movea.l    8(a1),a1
[00000182] 0c29 0041 0001            cmpi.b     #$41,1(a1)
[00000188] 6510                      bcs.s      _main_10
[0000018a] 226e 000c                 movea.l    12(a6),a1
[0000018e] 2269 0008                 movea.l    8(a1),a1
[00000192] 0c29 005a 0001            cmpi.b     #$5A,1(a1)
[00000198] 6302                      bls.s      _main_11
_main_10:
[0000019a] 5285                      addq.l     #1,d5
_main_11:
[0000019c] 226e 000c                 movea.l    12(a6),a1
[000001a0] 2269 0008                 movea.l    8(a1),a1
[000001a4] 0c29 0041 0002            cmpi.b     #$41,2(a1)
[000001aa] 6510                      bcs.s      _main_12
[000001ac] 226e 000c                 movea.l    12(a6),a1
[000001b0] 2269 0008                 movea.l    8(a1),a1
[000001b4] 0c29 005a 0002            cmpi.b     #$5A,2(a1)
[000001ba] 6302                      bls.s      _main_7
_main_12:
[000001bc] 5285                      addq.l     #1,d5
_main_7:
[000001be] 226e 000c                 movea.l    12(a6),a1
[000001c2] 2269 0004                 movea.l    4(a1),a1
[000001c6] 7800                      moveq.l    #0,d4
[000001c8] 1811                      move.b     (a1),d4
[000001ca] 7ed0                      moveq.l    #-48,d7
[000001cc] de84                      add.l      d4,d7
[000001ce] 2807                      move.l     d7,d4

[000001d0] 286e 000c                 movea.l    12(a6),a4
[000001d4] 286c 0008                 movea.l    8(a4),a4
[000001d8] 0cae 0000 0004 0008       cmpi.l     #$00000004,8(a6)
[000001e0] 661c                      bne.s      _main_13
[000001e2] 2a6e 000c                 movea.l    12(a6),a5
[000001e6] 2ead 000c                 move.l     12(a5),(a7)
[000001ea] 4eb9 0000 0d40            jsr        myatol
[000001f0] 2a47                      movea.l    d7,a5
[000001f2] 2e0d                      move.l     a5,d7
[000001f4] 0c87 0000 0001            cmpi.l     #$00000001,d7
[000001fa] 6c02                      bge.s      _main_13
[000001fc] 5285                      addq.l     #1,d5
_main_13:
[000001fe] 4a85                      tst.l      d5
[00000200] 6718                      beq.s      _main_2
[00000202] 2ebc 0000 1463            move.l     #$000025F1,(a7)
[00000208] 4eb9 0000 0cb2            jsr        print_str
[0000020e] 4878 0001                 pea.l      ($00000001).w
[00000212] 4eb9 0000 004a            jsr        _exit
[00000218] 588f                      addq.l     #4,a7
_main_2:
[0000021a] 2ebc 0000 1481            move.l     #$0000260F,(a7)
[00000220] 4eb9 0000 0e0a            jsr        __getenv
[00000226] 2647                      movea.l    d7,a3
[00000228] 2e0b                      move.l     a3,d7
[0000022a] 6700 00d6                 beq        _main_14
[0000022e] 0c13 0030                 cmpi.b     #$30,(a3)
[00000232] 651c                      bcs.s      _main_15
[00000234] 0c13 0033                 cmpi.b     #$33,(a3)
[00000238] 6216                      bhi.s      _main_15
[0000023a] 0c2b 0030 0001            cmpi.b     #$30,1(a3)
[00000240] 650e                      bcs.s      _main_15
[00000242] 0c2b 0031 0001            cmpi.b     #$31,1(a3)
[00000248] 6206                      bhi.s      _main_15
[0000024a] 4a2b 0002                 tst.b      2(a3)
[0000024e] 6718                      beq.s      _main_16
_main_15:
[00000250] 2ebc 0000 148b            move.l     #$00002619,(a7) "Invalid 'HARDDRIVE' in environment!\n"
[00000256] 4eb9 0000 0cb2            jsr        print_str
[0000025c] 4878 0001                 pea.l      ($00000001).w
[00000260] 4eb9 0000 004a            jsr        _exit
[00000266] 588f                      addq.l     #4,a7
_main_16:
[00000268] 1d53 fdfb                 move.b     (a3),-517(a6)
[0000026c] 1d6b 0001 fdfa            move.b     1(a3),-518(a6)
[00000272] 13ee fdfb 0000 138a       move.b     -517(a6),$00002518
[0000027a] 13ee fdfa 0000 138b       move.b     -518(a6),$00002519
[00000282] 13ee fdfb 0000 139f       move.b     -517(a6),$0000252D
[0000028a] 13ee fdfa 0000 13a0       move.b     -518(a6),$0000252E
[00000292] 13ee fdfb 0000 13b4       move.b     -517(a6),$00002542
[0000029a] 13ee fdfa 0000 13b5       move.b     -518(a6),$00002543
[000002a2] 13ee fdfb 0000 13c9       move.b     -517(a6),$00002557
[000002aa] 13ee fdfa 0000 13ca       move.b     -518(a6),$00002558
[000002b2] 13ee fdfb 0000 13de       move.b     -517(a6),$0000256C
[000002ba] 13ee fdfa 0000 13df       move.b     -518(a6),$0000256D
[000002c2] 13ee fdfb 0000 140b       move.b     -517(a6),$00002599
[000002ca] 13ee fdfa 0000 140c       move.b     -518(a6),$0000259A
[000002d2] 13ee fdfb 0000 1418       move.b     -517(a6),$000025A6
[000002da] 13ee fdfa 0000 1419       move.b     -518(a6),$000025A7
[000002e2] 13ee fdfb 0000 1425       move.b     -517(a6),$000025B3
[000002ea] 13ee fdfa 0000 1426       move.b     -518(a6),$000025B4
[000002f2] 13ee fdfb 0000 1432       move.b     -517(a6),$000025C0
[000002fa] 13ee fdfa 0000 1433       move.b     -518(a6),$000025C1
_main_14:
[00000302] 2ebc 0000 14b0            move.l     #$0000263E,(a7)
[00000308] 4eb9 0000 0cb2            jsr        print_str
[0000030e] 486e fdfc                 pea.l      -516(a6)
[00000312] 2f3c 0000 13d1            move.l     #$0000255F,-(a7) root_device
[00000318] 4eb9 0000 0460            jsr        read_block0
[0000031e] 508f                      addq.l     #8,a7
[00000320] 7600                      moveq.l    #0,d3
_main_18:
[00000322] 0c83 0000 0004            cmpi.l     #$00000004,d3
[00000328] 6c6a                      bge.s      _main_17
[0000032a] 2e03                      move.l     d3,d7
[0000032c] 2007                      move.l     d7,d0
[0000032e] e587                      asl.l      #2,d7
[00000330] 9e80                      sub.l      d0,d7
[00000332] e587                      asl.l      #2,d7
[00000334] 43f6 78c2                 lea.l      -62(a6,d7.l),a1
[00000338] 2d49 fffc                 move.l     a1,-4(a6)
[0000033c] 2eae fffc                 move.l     -4(a6),(a7)
[00000340] 4eb9 0000 09c6            jsr        fetch_uint8
[00000346] 2c03                      move.l     d3,d6
[00000348] e586                      asl.l      #2,d6
[0000034a] 2246                      movea.l    d6,a1
[0000034c] d3fc 0000 1920            adda.l     #active_flag,a1
[00000352] 2287                      move.l     d7,(a1)
[00000354] 226e fffc                 movea.l    -4(a6),a1
[00000358] 4869 0004                 pea.l      4(a1)
[0000035c] 4eb9 0000 09dc            jsr        fetch_uint32
[00000362] 588f                      addq.l     #4,a7
[00000364] 2c03                      move.l     d3,d6
[00000366] e586                      asl.l      #2,d6
[00000368] 2246                      movea.l    d6,a1
[0000036a] d3fc 0000 1910            adda.l     #start_sec,a1
[00000370] 2287                      move.l     d7,(a1)
[00000372] 226e fffc                 movea.l    -4(a6),a1
[00000376] 4869 0008                 pea.l      8(a1)
[0000037a] 4eb9 0000 09dc            jsr        fetch_uint32
[00000380] 588f                      addq.l     #4,a7
[00000382] 2c03                      move.l     d3,d6
[00000384] e586                      asl.l      #2,d6
[00000386] 2246                      movea.l    d6,a1
[00000388] d3fc 0000 1900            adda.l     #part_size,a1
[0000038e] 2287                      move.l     d7,(a1)
[00000390] 5283                      addq.l     #1,d3
[00000392] 608e                      bra.s      _main_18
_main_17:
[00000394] 0cae 0000 0003 0008       cmpi.l     #$00000003,8(a6)
[0000039c] 6d00 0090                 blt        _main_19
[000003a0] 2e04                      move.l     d4,d7
[000003a2] e587                      asl.l      #2,d7
[000003a4] 2247                      movea.l    d7,a1
[000003a6] d3fc 0000 1920            adda.l     #active_flag,a1
[000003ac] 4a91                      tst.l      (a1)
[000003ae] 6618                      bne.s      _main_20
[000003b0] 2ebc 0000 14b2            move.l     #$00002640,(a7) "inactive partition specified!\n"
[000003b6] 4eb9 0000 0cb2            jsr        print_str
[000003bc] 4878 0001                 pea.l      ($00000001).w
[000003c0] 4eb9 0000 004a            jsr        _exit
[000003c6] 588f                      addq.l     #4,a7
_main_20:
[000003c8] 0cae 0000 0004 0008       cmpi.l     #$00000004,8(a6)
[000003d0] 6628                      bne.s      _main_21
[000003d2] 2e04                      move.l     d4,d7
[000003d4] e587                      asl.l      #2,d7
[000003d6] 2247                      movea.l    d7,a1
[000003d8] d3fc 0000 1900            adda.l     #part_size,a1
[000003de] bbd1                      cmpa.l     (a1),a5
[000003e0] 6518                      bcs.s      _main_21
[000003e2] 2ebc 0000 14d1            move.l     #$0000265F,(a7) "specified offset too large!\n"
[000003e8] 4eb9 0000 0cb2            jsr        print_str
[000003ee] 4878 0001                 pea.l      ($00000001).w
[000003f2] 4eb9 0000 004a            jsr        _exit
[000003f8] 588f                      addq.l     #4,a7
_main_21:
[000003fa] 486e fdfc                 pea.l      -516(a6)
[000003fe] 2f0c                      move.l     a4,-(a7)
[00000400] 2f04                      move.l     d4,-(a7)
[00000402] 4eb9 0000 0944            jsr        set_partid
[00000408] 4fef 000c                 lea.l      12(a7),a7
[0000040c] 0cae 0000 0004 0008       cmpi.l     #$00000004,8(a6)
[00000414] 6618                      bne.s      _main_19
[00000416] 2e8d                      move.l     a5,(a7)
[00000418] 2e04                      move.l     d4,d7
[0000041a] e587                      asl.l      #2,d7
[0000041c] 2247                      movea.l    d7,a1
[0000041e] d3fc 0000 13e2            adda.l     #partition_names,a1
[00000424] 2f11                      move.l     (a1),-(a7)
[00000426] 4eb9 0000 0984            jsr        set_reserved_sectors
[0000042c] 588f                      addq.l     #4,a7
_main_19:
[0000042e] 486e fdfc                 pea.l      -516(a6)
[00000432] 4eb9 0000 057e            jsr        show_info
[00000438] 588f                      addq.l     #4,a7
[0000043a] 0cae 0000 0003 0008       cmpi.l     #$00000003,8(a6)
[00000442] 6d0c                      blt.s      _main_22
[00000444] 2eb9 0000 132e            move.l     $000024BC,(a7) reboot_msg
[0000044a] 4eb9 0000 0cb2            jsr        print_str
_main_22:
[00000450] 4297                      clr.l      (a7)
[00000452] 4eb9 0000 004a            jsr        _exit
[00000458] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[0000045c] 4e5e                      unlk       a6
[0000045e] 4e75                      rts

read_block0:
[00000460] 4e56 0000                 link       a6,#0
[00000464] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00000468] 2a7c 0000 0cb2            movea.l    #print_str,a5
[0000046e] 286e 0008                 movea.l    8(a6),a4
[00000472] 4297                      clr.l      (a7)
[00000474] 2f0c                      move.l     a4,-(a7)
[00000476] 4eb9 0000 0d96            jsr        _open
[0000047c] 588f                      addq.l     #4,a7
[0000047e] 2a07                      move.l     d7,d5
[00000480] 6c20                      bge.s      x460_1
[00000482] 2ebc 0000 14ee            move.l     #$0000267C,(a7)
[00000488] 4e95                      jsr        (a5)
[0000048a] 2e8c                      move.l     a4,(a7)
[0000048c] 4e95                      jsr        (a5)
[0000048e] 2ebc 0000 14ff            move.l     #$0000268D,(a7)
[00000494] 4e95                      jsr        (a5)
[00000496] 4878 0001                 pea.l      ($00000001).w
[0000049a] 4eb9 0000 004a            jsr        _exit
[000004a0] 588f                      addq.l     #4,a7
x460_1:
[000004a2] 4878 0200                 pea.l      ($00000200).w
[000004a6] 2f2e 000c                 move.l     12(a6),-(a7)
[000004aa] 2f05                      move.l     d5,-(a7)
[000004ac] 4eb9 0000 0da8            jsr        _read
[000004b2] 4fef 000c                 lea.l      12(a7),a7
[000004b6] 0c87 0000 0200            cmpi.l     #$00000200,d7
[000004bc] 6720                      beq.s      x460_2
[000004be] 2ebc 0000 150f            move.l     #$0000269D,(a7)
[000004c4] 4e95                      jsr        (a5)
[000004c6] 2e8c                      move.l     a4,(a7)
[000004c8] 4e95                      jsr        (a5)
[000004ca] 2ebc 0000 152c            move.l     #$000026BA,(a7)
[000004d0] 4e95                      jsr        (a5)
[000004d2] 4878 0001                 pea.l      ($00000001).w
[000004d6] 4eb9 0000 004a            jsr        _exit
[000004dc] 588f                      addq.l     #4,a7
x460_2:
[000004de] 2e85                      move.l     d5,(a7)
[000004e0] 4eb9 0000 0dba            jsr        _close
[000004e6] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000004ea] 4e5e                      unlk       a6
[000004ec] 4e75                      rts

write_block0:
[000004ee] 4e56 0000                 link       a6,#0
[000004f2] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000004f6] 2a7c 0000 0cb2            movea.l    #print_str,a5
[000004fc] 286e 0008                 movea.l    8(a6),a4
[00000500] 4878 0002                 pea.l      ($00000002).w
[00000504] 2f0c                      move.l     a4,-(a7)
[00000506] 4eb9 0000 0d96            jsr        _open
[0000050c] 508f                      addq.l     #8,a7
[0000050e] 2a07                      move.l     d7,d5
[00000510] 6c20                      bge.s      x4ee_1
[00000512] 2ebc 0000 1530            move.l     #$000026BE,(a7)
[00000518] 4e95                      jsr        (a5)
[0000051a] 2e8c                      move.l     a4,(a7)
[0000051c] 4e95                      jsr        (a5)
[0000051e] 2ebc 0000 1541            move.l     #$000026CF,(a7)
[00000524] 4e95                      jsr        (a5)
[00000526] 4878 0001                 pea.l      ($00000001).w
[0000052a] 4eb9 0000 004a            jsr        _exit
[00000530] 588f                      addq.l     #4,a7
x4ee_1:
[00000532] 4878 0200                 pea.l      ($00000200).w
[00000536] 2f2e 000c                 move.l     12(a6),-(a7)
[0000053a] 2f05                      move.l     d5,-(a7)
[0000053c] 4eb9 0000 0d84            jsr        _write
[00000542] 4fef 000c                 lea.l      12(a7),a7
[00000546] 0c87 0000 0200            cmpi.l     #$00000200,d7
[0000054c] 6720                      beq.s      x4ee_2
[0000054e] 2ebc 0000 1551            move.l     #$000026DF,(a7)
[00000554] 4e95                      jsr        (a5)
[00000556] 2e8c                      move.l     a4,(a7)
[00000558] 4e95                      jsr        (a5)
[0000055a] 2ebc 0000 156e            move.l     #$000026FC,(a7)
[00000560] 4e95                      jsr        (a5)
[00000562] 4878 0001                 pea.l      ($00000001).w
[00000566] 4eb9 0000 004a            jsr        _exit
[0000056c] 588f                      addq.l     #4,a7
x4ee_2:
[0000056e] 2e85                      move.l     d5,(a7)
[00000570] 4eb9 0000 0dba            jsr        _close
[00000576] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000057a] 4e5e                      unlk       a6
[0000057c] 4e75                      rts

show_info:
[0000057e] 4e56 fff0                 link       a6,#-16
[00000582] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[00000586] 2a7c 0000 0cb2            movea.l    #print_str,a5
[0000058c] 286e 0008                 movea.l    8(a6),a4
[00000590] 267c 0000 1920            movea.l    #active_flag,a3
[00000596] 2a3c 0000 0b38            move.l     #print_val,d5
[0000059c] 283c 0000 1900            move.l     #part_size,d4
[000005a2] 263c 0000 1910            move.l     #start_sec,d3
[000005a8] 2ebc 0000 15c1            move.l     #$0000274F,(a7) "\n+--------------------------------+------------+-------------------------+\n"
[000005ae] 4e95                      jsr        (a5)
[000005b0] 486c 01b6                 pea.l      438(a4)
[000005b4] 2f3c 0000 160d            move.l     #$0000279B,-(a7) "*Number of cylinders"
[000005ba] 4eb9 0000 0ad4            jsr        print_uint16
[000005c0] 508f                      addq.l     #8,a7
[000005c2] 486c 01b8                 pea.l      440(a4)
[000005c6] 2f3c 0000 1622            move.l     #$000027B0,-(a7) "+Number of heads"
[000005cc] 4eb9 0000 0ab6            jsr        print_uint8
[000005d2] 508f                      addq.l     #8,a7
[000005d4] 2eb9 0000 126e            move.l     $000023FC,(a7) version_str3
[000005da] 4e95                      jsr        (a5)
[000005dc] 486c 01b9                 pea.l      441(a4)
[000005e0] 2f3c 0000 1633            move.l     #$000027C1,-(a7) "*(unused)"
[000005e6] 4eb9 0000 0ab6            jsr        print_uint8
[000005ec] 508f                      addq.l     #8,a7
[000005ee] 486c 01ba                 pea.l      442(a4)
[000005f2] 2f3c 0000 163d            move.l     #$000027CB,-(a7) "+Reduced write current cylinder"
[000005f8] 4eb9 0000 0ad4            jsr        print_uint16
[000005fe] 508f                      addq.l     #8,a7
[00000600] 2eb9 0000 128e            move.l     $0000241C,(a7) date_str
[00000606] 4e95                      jsr        (a5)
[00000608] 486c 01bc                 pea.l      444(a4)
[0000060c] 2f3c 0000 165d            move.l     #$000027EB,-(a7) "*Write-precompensation cylinder"
[00000612] 4eb9 0000 0ad4            jsr        print_uint16
[00000618] 508f                      addq.l     #8,a7
[0000061a] 486c 01be                 pea.l      446(a4)
[0000061e] 2f3c 0000 167d            move.l     #$0000280B,-(a7) "+Landing zone"
[00000624] 4eb9 0000 0ab6            jsr        print_uint8
[0000062a] 508f                      addq.l     #8,a7
[0000062c] 2eb9 0000 12ae            move.l     $0000243C,(a7) copyright_str
[00000632] 4e95                      jsr        (a5)
[00000634] 486c 01bf                 pea.l      447(a4)
[00000638] 2f3c 0000 168b            move.l     #$00002819,-(a7)
[0000063e] 4eb9 0000 0ab6            jsr        print_uint8
[00000644] 508f                      addq.l     #8,a7
[00000646] 486c 01c0                 pea.l      448(a4)
[0000064a] 2f3c 0000 169b            move.l     #$00002829,-(a7) "+Interleave factor"
[00000650] 4eb9 0000 0ab6            jsr        print_uint8
[00000656] 508f                      addq.l     #8,a7
[00000658] 2eb9 0000 12ce            move.l     $0000245C,(a7) cti_str1
[0000065e] 4e95                      jsr        (a5)
[00000660] 486c 01c1                 pea.l      449(a4)
[00000664] 2f3c 0000 16ae            move.l     #$0000283C,-(a7) "*Number of sectors per track"
[0000066a] 4eb9 0000 0ab6            jsr        print_uint8
[00000670] 508f                      addq.l     #8,a7
[00000672] 486c 01c2                 pea.l      450(a4)
[00000676] 2f3c 0000 16cb            move.l     #$00002859,-(a7) "+Total 512-byte blocks"
[0000067c] 4eb9 0000 0b1a            jsr        print_uint32
[00000682] 508f                      addq.l     #8,a7
[00000684] 2eb9 0000 12ee            move.l     $0000247C,(a7) cti_str2
[0000068a] 4e95                      jsr        (a5)
[0000068c] 486c 01f6                 pea.l      502(a4)
[00000690] 2f3c 0000 16e2            move.l     #$00002870,-(a7) "*Start of bad-sector list"
[00000696] 4eb9 0000 0b1a            jsr        print_uint32
[0000069c] 508f                      addq.l     #8,a7
[0000069e] 486c 01fa                 pea.l      506(a4)
[000006a2] 2f3c 0000 16fc            move.l     #$0000288A,-(a7) "+Number of bad-sectors"
[000006a8] 4eb9 0000 0b1a            jsr        print_uint32
[000006ae] 508f                      addq.l     #8,a7
[000006b0] 2eb9 0000 130e            move.l     $0000249C,(a7) cti_str3
[000006b6] 4e95                      jsr        (a5)
[000006b8] 486c 01fe                 pea.l      510(a4)
[000006bc] 2f3c 0000 1713            move.l     #$000028A1,-(a7) "*Block checksum"
[000006c2] 4eb9 0000 0ad4            jsr        print_uint16
[000006c8] 508f                      addq.l     #8,a7
[000006ca] 2eb9 0000 1572            move.l     $00002700,(a7) header_line
[000006d0] 4e95                      jsr        (a5)
[000006d2] 2ebc 0000 13f2            move.l     #$00002580,(a7) partition_line
[000006d8] 4e95                      jsr        (a5)
[000006da] 2ebc 0000 1723            move.l     #$000028B1,(a7) "| Flag byte         |"
[000006e0] 4e95                      jsr        (a5)
[000006e2] 2e93                      move.l     (a3),(a7) active_flag[0]
[000006e4] 2f3c 0000 1739            move.l     #$000028C7,-(a7) " "
[000006ea] 2245                      movea.l    d5,a1
[000006ec] 4e91                      jsr        (a1)
[000006ee] 588f                      addq.l     #4,a7
[000006f0] 2eab 0004                 move.l     4(a3),(a7) active_flag[1]
[000006f4] 2f3c 0000 173b            move.l     #$000028C9,-(a7) " | "
[000006fa] 2245                      movea.l    d5,a1
[000006fc] 4e91                      jsr        (a1)
[000006fe] 588f                      addq.l     #4,a7
[00000700] 2eab 0008                 move.l     8(a3),(a7) active_flag[2]
[00000704] 2f3c 0000 173f            move.l     #$000028CD,-(a7) " | "
[0000070a] 2245                      movea.l    d5,a1
[0000070c] 4e91                      jsr        (a1)
[0000070e] 588f                      addq.l     #4,a7
[00000710] 2eab 000c                 move.l     12(a3),(a7) active_flag[3]
[00000714] 2f3c 0000 1743            move.l     #$000028D1,-(a7) " | "
[0000071a] 2245                      movea.l    d5,a1
[0000071c] 4e91                      jsr        (a1)
[0000071e] 588f                      addq.l     #4,a7
[00000720] 2ebc 0000 1747            move.l     #$000028D5,(a7) " |\n"
[00000726] 4e95                      jsr        (a5)
[00000728] 2ebc 0000 174b            move.l     #$000028D9,(a7) "| Id string         |"
[0000072e] 4e95                      jsr        (a5)
[00000730] 486c 01c7                 pea.l      455(a4)
[00000734] 2f3c 0000 1761            move.l     #$000028EF,-(a7) " "
[0000073a] 4eb9 0000 0c04            jsr        print_id
[00000740] 508f                      addq.l     #8,a7
[00000742] 486c 01d3                 pea.l      467(a4)
[00000746] 2f3c 0000 1763            move.l     #$000028F1,-(a7) " | "
[0000074c] 4eb9 0000 0c04            jsr        print_id
[00000752] 508f                      addq.l     #8,a7
[00000754] 486c 01df                 pea.l      479(a4)
[00000758] 2f3c 0000 1767            move.l     #$000028F5,-(a7) " | "
[0000075e] 4eb9 0000 0c04            jsr        print_id
[00000764] 508f                      addq.l     #8,a7
[00000766] 486c 01eb                 pea.l      491(a4)
[0000076a] 2f3c 0000 176b            move.l     #$000028F9,-(a7) " | "
[00000770] 4eb9 0000 0c04            jsr        print_id
[00000776] 508f                      addq.l     #8,a7
[00000778] 2ebc 0000 176f            move.l     #$000028FD,(a7) " |\n"
[0000077e] 4e95                      jsr        (a5)
[00000780] 2ebc 0000 1773            move.l     #$00002901,(a7) "| Starting block    |"
[00000786] 4e95                      jsr        (a5)
[00000788] 2243                      movea.l    d3,a1
[0000078a] 2e91                      move.l     (a1),(a7) start_sec[0]
[0000078c] 2f3c 0000 1789            move.l     #$00002917,-(a7) " "
[00000792] 2245                      movea.l    d5,a1
[00000794] 4e91                      jsr        (a1)
[00000796] 588f                      addq.l     #4,a7
[00000798] 2243                      movea.l    d3,a1
[0000079a] 5889                      addq.l     #4,a1
[0000079c] 2e91                      move.l     (a1),(a7) start_sec[1]
[0000079e] 2f3c 0000 178b            move.l     #$00002919,-(a7) " | "
[000007a4] 2245                      movea.l    d5,a1
[000007a6] 4e91                      jsr        (a1)
[000007a8] 588f                      addq.l     #4,a7
[000007aa] 2243                      movea.l    d3,a1
[000007ac] 5089                      addq.l     #8,a1
[000007ae] 2e91                      move.l     (a1),(a7) start_sec[2]
[000007b0] 2f3c 0000 178f            move.l     #$0000291D,-(a7) " | "
[000007b6] 2245                      movea.l    d5,a1
[000007b8] 4e91                      jsr        (a1)
[000007ba] 588f                      addq.l     #4,a7
[000007bc] 2243                      movea.l    d3,a1
[000007be] 43e9 000c                 lea.l      12(a1),a1
[000007c2] 2e91                      move.l     (a1),(a7) start_sec[3]
[000007c4] 2f3c 0000 1793            move.l     #$00002921,-(a7) " | "
[000007ca] 2245                      movea.l    d5,a1
[000007cc] 4e91                      jsr        (a1)
[000007ce] 588f                      addq.l     #4,a7
[000007d0] 2ebc 0000 1797            move.l     #$00002925,(a7) " |\n"
[000007d6] 4e95                      jsr        (a5)
[000007d8] 2ebc 0000 179b            move.l     #$00002929,(a7) "| Partition size    |"
[000007de] 4e95                      jsr        (a5)
[000007e0] 2244                      movea.l    d4,a1
[000007e2] 2e91                      move.l     (a1),(a7) part_size[0]
[000007e4] 2f3c 0000 17b1            move.l     #$0000293F,-(a7) " "
[000007ea] 2245                      movea.l    d5,a1
[000007ec] 4e91                      jsr        (a1)
[000007ee] 588f                      addq.l     #4,a7
[000007f0] 2244                      movea.l    d4,a1
[000007f2] 5889                      addq.l     #4,a1
[000007f4] 2e91                      move.l     (a1),(a7) part_size[1]
[000007f6] 2f3c 0000 17b3            move.l     #$00002941,-(a7) " | "
[000007fc] 2245                      movea.l    d5,a1
[000007fe] 4e91                      jsr        (a1)
[00000800] 588f                      addq.l     #4,a7
[00000802] 2244                      movea.l    d4,a1
[00000804] 5089                      addq.l     #8,a1
[00000806] 2e91                      move.l     (a1),(a7) part_size[2]
[00000808] 2f3c 0000 17b7            move.l     #$00002945,-(a7) " | "
[0000080e] 2245                      movea.l    d5,a1
[00000810] 4e91                      jsr        (a1)
[00000812] 588f                      addq.l     #4,a7
[00000814] 2244                      movea.l    d4,a1
[00000816] 43e9 000c                 lea.l      12(a1),a1
[0000081a] 2e91                      move.l     (a1),(a7) part_size[3]
[0000081c] 2f3c 0000 17bb            move.l     #$00002949,-(a7) " | "
[00000822] 2245                      movea.l    d5,a1
[00000824] 4e91                      jsr        (a1)
[00000826] 588f                      addq.l     #4,a7
[00000828] 2ebc 0000 17bf            move.l     #$0000294D,(a7) " |\n"
[0000082e] 4e95                      jsr        (a5)
[00000830] 2ebc 0000 17c3            move.l     #$00002951,(a7) "| Reserved blocks   |"
[00000836] 4e95                      jsr        (a5)
[00000838] 2eb9 0000 13e2            move.l     partition_names[0],(a7)
[0000083e] 2f13                      move.l     (a3),-(a7) active_flag[0]
[00000840] 2f3c 0000 17d9            move.l     #$00002967,-(a7) " "
[00000846] 4eb9 0000 0a32            jsr        print_reserved
[0000084c] 508f                      addq.l     #8,a7
[0000084e] 2d47 fffc                 move.l     d7,-4(a6)
[00000852] 2eb9 0000 13e6            move.l     partition_names[1],(a7)
[00000858] 2f2b 0004                 move.l     4(a3),-(a7) active_flag[1]
[0000085c] 2f3c 0000 17db            move.l     #$00002969,-(a7) " | "
[00000862] 4eb9 0000 0a32            jsr        print_reserved
[00000868] 508f                      addq.l     #8,a7
[0000086a] 2d47 fff8                 move.l     d7,-8(a6)
[0000086e] 2eb9 0000 13ea            move.l     partition_names[2],(a7)
[00000874] 2f2b 0008                 move.l     8(a3),-(a7) active_flag[2]
[00000878] 2f3c 0000 17df            move.l     #$0000296D,-(a7) " | "
[0000087e] 4eb9 0000 0a32            jsr        print_reserved
[00000884] 508f                      addq.l     #8,a7
[00000886] 2d47 fff4                 move.l     d7,-12(a6)
[0000088a] 2eb9 0000 13ee            move.l     partition_names[3],(a7)
[00000890] 2f2b 000c                 move.l     12(a3),-(a7) active_flag[3]
[00000894] 2f3c 0000 17e3            move.l     #$00002971,-(a7) " | "
[0000089a] 4eb9 0000 0a32            jsr        print_reserved
[000008a0] 508f                      addq.l     #8,a7
[000008a2] 2d47 fff0                 move.l     d7,-16(a6)
[000008a6] 2ebc 0000 17e7            move.l     #$00002975,(a7) " |\n"
[000008ac] 4e95                      jsr        (a5)
[000008ae] 2ebc 0000 17eb            move.l     #$00002979,(a7) "| Size for 'mkfs'   |"
[000008b4] 4e95                      jsr        (a5)
[000008b6] 2eae fffc                 move.l     -4(a6),(a7)
[000008ba] 2244                      movea.l    d4,a1
[000008bc] 2f11                      move.l     (a1),-(a7) part_size[0]
[000008be] 2f13                      move.l     (a3),-(a7) active_flag[0]
[000008c0] 2f3c 0000 1801            move.l     #$0000298F,-(a7) " "
[000008c6] 4eb9 0000 0a86            jsr        print_mkfs
[000008cc] 4fef 000c                 lea.l      12(a7),a7
[000008d0] 2eae fff8                 move.l     -8(a6),(a7)
[000008d4] 2244                      movea.l    d4,a1
[000008d6] 5889                      addq.l     #4,a1
[000008d8] 2f11                      move.l     (a1),-(a7) part_size[1]
[000008da] 2f2b 0004                 move.l     4(a3),-(a7) active_flag[1]
[000008de] 2f3c 0000 1803            move.l     #$00002991,-(a7) " | "
[000008e4] 4eb9 0000 0a86            jsr        print_mkfs
[000008ea] 4fef 000c                 lea.l      12(a7),a7
[000008ee] 2eae fff4                 move.l     -12(a6),(a7)
[000008f2] 2244                      movea.l    d4,a1
[000008f4] 5089                      addq.l     #8,a1
[000008f6] 2f11                      move.l     (a1),-(a7) part_size[2]
[000008f8] 2f2b 0008                 move.l     8(a3),-(a7) active_flag[2]
[000008fc] 2f3c 0000 1807            move.l     #$00002995,-(a7) " | "
[00000902] 4eb9 0000 0a86            jsr        print_mkfs
[00000908] 4fef 000c                 lea.l      12(a7),a7
[0000090c] 2eae fff0                 move.l     -16(a6),(a7)
[00000910] 2244                      movea.l    d4,a1
[00000912] 43e9 000c                 lea.l      12(a1),a1
[00000916] 2f11                      move.l     (a1),-(a7) part_size[3]
[00000918] 2f2b 000c                 move.l     12(a3),-(a7) active_flag[3]
[0000091c] 2f3c 0000 180b            move.l     #$00002999,-(a7) " | "
[00000922] 4eb9 0000 0a86            jsr        print_mkfs
[00000928] 4fef 000c                 lea.l      12(a7),a7
[0000092c] 2ebc 0000 180f            move.l     #$0000299D,(a7) " |\"
[00000932] 4e95                      jsr        (a5)
[00000934] 2eb9 0000 1572            move.l     $00002700,(a7) header_line
[0000093a] 4e95                      jsr        (a5)
[0000093c] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00000940] 4e5e                      unlk       a6
[00000942] 4e75                      rts

set_partid:
[00000944] 4e56 0000                 link       a6,#0
[00000948] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[0000094c] 286e 000c                 movea.l    12(a6),a4
[00000950] 2a6e 0010                 movea.l    16(a6),a5
[00000954] 2e2e 0008                 move.l     8(a6),d7
[00000958] 2007                      move.l     d7,d0
[0000095a] e587                      asl.l      #2,d7
[0000095c] 9e80                      sub.l      d0,d7
[0000095e] e587                      asl.l      #2,d7
[00000960] dbc7                      adda.l     d7,a5
[00000962] 4bed 01c7                 lea.l      455(a5),a5
[00000966] 1adc                      move.b     (a4)+,(a5)+
[00000968] 1adc                      move.b     (a4)+,(a5)+
[0000096a] 1a94                      move.b     (a4),(a5)
[0000096c] 2eae 0010                 move.l     16(a6),(a7)
[00000970] 2f3c 0000 13d1            move.l     #$0000255F,-(a7) root_device
[00000976] 4eba fb76                 jsr        write_block0(pc)
[0000097a] 588f                      addq.l     #4,a7
[0000097c] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00000980] 4e5e                      unlk       a6
[00000982] 4e75                      rts

set_reserved_sectors:
[00000984] 4e56 fe00                 link       a6,#-512
[00000988] 486e fe00                 pea.l      -512(a6)
[0000098c] 2f2e 0008                 move.l     8(a6),-(a7)
[00000990] 4eba face                 jsr        read_block0(pc)
[00000994] 508f                      addq.l     #8,a7
[00000996] 2e2e 000c                 move.l     12(a6),d7
[0000099a] 0287 0000 00ff            andi.l     #$000000FF,d7
[000009a0] 1d47 fe0e                 move.b     d7,-498(a6)
[000009a4] 2e2e 000c                 move.l     12(a6),d7
[000009a8] e087                      asr.l      #8,d7
[000009aa] 0287 0000 00ff            andi.l     #$000000FF,d7
[000009b0] 1d47 fe0f                 move.b     d7,-497(a6)
[000009b4] 486e fe00                 pea.l      -512(a6)
[000009b8] 2f2e 0008                 move.l     8(a6),-(a7)
[000009bc] 4eba fb30                 jsr        write_block0(pc)
[000009c0] 508f                      addq.l     #8,a7
[000009c2] 4e5e                      unlk       a6
[000009c4] 4e75                      rts

fetch_uint8:
[000009c6] 4e56 0000                 link       a6,#0
[000009ca] 226e 0008                 movea.l    8(a6),a1
[000009ce] 7e00                      moveq.l    #0,d7
[000009d0] 1e11                      move.b     (a1),d7
[000009d2] 0287 0000 00ff            andi.l     #$000000FF,d7
[000009d8] 4e5e                      unlk       a6
[000009da] 4e75                      rts

fetch_uint32:
[000009dc] 4e56 0000                 link       a6,#0
[000009e0] 48e7 0404                 movem.l    d5/a5,-(a7)
[000009e4] 2a6e 0008                 movea.l    8(a6),a5
[000009e8] 7a00                      moveq.l    #0,d5
[000009ea] 1a1d                      move.b     (a5)+,d5
[000009ec] 0285 0000 00ff            andi.l     #$000000FF,d5
[000009f2] 2e05                      move.l     d5,d7
[000009f4] e187                      asl.l      #8,d7
[000009f6] 7c00                      moveq.l    #0,d6
[000009f8] 1c1d                      move.b     (a5)+,d6
[000009fa] 0286 0000 00ff            andi.l     #$000000FF,d6
[00000a00] 8e86                      or.l       d6,d7
[00000a02] 2a07                      move.l     d7,d5
[00000a04] 2e05                      move.l     d5,d7
[00000a06] e187                      asl.l      #8,d7
[00000a08] 7c00                      moveq.l    #0,d6
[00000a0a] 1c1d                      move.b     (a5)+,d6
[00000a0c] 0286 0000 00ff            andi.l     #$000000FF,d6
[00000a12] 8e86                      or.l       d6,d7
[00000a14] 2a07                      move.l     d7,d5
[00000a16] 2e05                      move.l     d5,d7
[00000a18] e187                      asl.l      #8,d7
[00000a1a] 7c00                      moveq.l    #0,d6
[00000a1c] 1c15                      move.b     (a5),d6
[00000a1e] 0286 0000 00ff            andi.l     #$000000FF,d6
[00000a24] 8e86                      or.l       d6,d7
[00000a26] 2a07                      move.l     d7,d5
[00000a28] 2e05                      move.l     d5,d7
[00000a2a] 4cdf 2020                 movem.l    (a7)+,d5/a5
[00000a2e] 4e5e                      unlk       a6
[00000a30] 4e75                      rts

print_reserved:
[00000a32] 4e56 fe00                 link       a6,#-512
[00000a36] 48e7 8400                 movem.l    d0/d5,-(a7)
[00000a3a] 4aae 000c                 tst.l      12(a6)
[00000a3e] 6604                      bne.s      xa32_1
[00000a40] 7a00                      moveq.l    #0,d5
[00000a42] 602a                      bra.s      xa32_2
xa32_1:
[00000a44] 486e fe00                 pea.l      -512(a6)
[00000a48] 2f2e 0010                 move.l     16(a6),-(a7)
[00000a4c] 4eba fa12                 jsr        read_block0(pc)
[00000a50] 508f                      addq.l     #8,a7
[00000a52] 7a00                      moveq.l    #0,d5
[00000a54] 1a2e fe0e                 move.b     -498(a6),d5
[00000a58] 0285 0000 00ff            andi.l     #$000000FF,d5
[00000a5e] 7e00                      moveq.l    #0,d7
[00000a60] 1e2e fe0f                 move.b     -497(a6),d7
[00000a64] e187                      asl.l      #8,d7
[00000a66] 0287 0000 ff00            andi.l     #$0000FF00,d7
[00000a6c] 8a87                      or.l       d7,d5
xa32_2:
[00000a6e] 2e85                      move.l     d5,(a7)
[00000a70] 2f2e 0008                 move.l     8(a6),-(a7)
[00000a74] 4eb9 0000 0b38            jsr        print_val
[00000a7a] 588f                      addq.l     #4,a7
[00000a7c] 2e05                      move.l     d5,d7
[00000a7e] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00000a82] 4e5e                      unlk       a6
[00000a84] 4e75                      rts

print_mkfs:
[00000a86] 4e56 0000                 link       a6,#0
[00000a8a] 48e7 8400                 movem.l    d0/d5,-(a7)
[00000a8e] 4aae 000c                 tst.l      12(a6)
[00000a92] 6604                      bne.s      xa86_1
[00000a94] 7a00                      moveq.l    #0,d5
[00000a96] 6008                      bra.s      xa86_2
xa86_1:
[00000a98] 2a2e 0010                 move.l     16(a6),d5
[00000a9c] 9aae 0014                 sub.l      20(a6),d5
xa86_2:
[00000aa0] 2e85                      move.l     d5,(a7)
[00000aa2] 2f2e 0008                 move.l     8(a6),-(a7)
[00000aa6] 4eb9 0000 0b38            jsr        print_val
[00000aac] 588f                      addq.l     #4,a7
[00000aae] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00000ab2] 4e5e                      unlk       a6
[00000ab4] 4e75                      rts

print_uint8:
[00000ab6] 4e56 fffc                 link       a6,#-4
[00000aba] 2eae 000c                 move.l     12(a6),(a7)
[00000abe] 4eba ff06                 jsr        fetch_uint8(pc)
[00000ac2] 2e87                      move.l     d7,(a7)
[00000ac4] 2f2e 0008                 move.l     8(a6),-(a7)
[00000ac8] 4eb9 0000 0b38            jsr        print_val
[00000ace] 588f                      addq.l     #4,a7
[00000ad0] 4e5e                      unlk       a6
[00000ad2] 4e75                      rts

print_uint16:
[00000ad4] 4e56 0000                 link       a6,#0
[00000ad8] 48e7 8400                 movem.l    d0/d5,-(a7)
[00000adc] 226e 000c                 movea.l    12(a6),a1
[00000ae0] 52ae 000c                 addq.l     #1,12(a6)
[00000ae4] 7a00                      moveq.l    #0,d5
[00000ae6] 1a11                      move.b     (a1),d5
[00000ae8] 0285 0000 00ff            andi.l     #$000000FF,d5
[00000aee] 2e05                      move.l     d5,d7
[00000af0] e187                      asl.l      #8,d7
[00000af2] 226e 000c                 movea.l    12(a6),a1
[00000af6] 7c00                      moveq.l    #0,d6
[00000af8] 1c11                      move.b     (a1),d6
[00000afa] 0286 0000 00ff            andi.l     #$000000FF,d6
[00000b00] 8e86                      or.l       d6,d7
[00000b02] 2a07                      move.l     d7,d5
[00000b04] 2e85                      move.l     d5,(a7)
[00000b06] 2f2e 0008                 move.l     8(a6),-(a7)
[00000b0a] 4eb9 0000 0b38            jsr        print_val
[00000b10] 588f                      addq.l     #4,a7
[00000b12] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00000b16] 4e5e                      unlk       a6
[00000b18] 4e75                      rts

print_uint32:
[00000b1a] 4e56 fffc                 link       a6,#-4
[00000b1e] 2eae 000c                 move.l     12(a6),(a7)
[00000b22] 4eba feb8                 jsr        fetch_uint32(pc)
[00000b26] 2e87                      move.l     d7,(a7)
[00000b28] 2f2e 0008                 move.l     8(a6),-(a7)
[00000b2c] 4eb9 0000 0b38            jsr        print_val
[00000b32] 588f                      addq.l     #4,a7
[00000b34] 4e5e                      unlk       a6
[00000b36] 4e75                      rts

print_val:
[00000b38] 4e56 ff00                 link       a6,#-256
[00000b3c] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[00000b40] 287c 0000 0cb2            movea.l    #print_str,a4
[00000b46] 266e 0008                 movea.l    8(a6),a3
[00000b4a] 2a3c 0000 0e6a            move.l     #_strcpy,d5
[00000b50] 2eae 000c                 move.l     12(a6),(a7)
[00000b54] 4eb9 0000 0cd6            jsr        ltoa
[00000b5a] 2a47                      movea.l    d7,a5
[00000b5c] 2eb9 0000 1814            move.l     $000029A2,(a7) spaces
[00000b62] 486e ff00                 pea.l      -256(a6)
[00000b66] 2245                      movea.l    d5,a1
[00000b68] 4e91                      jsr        (a1)
[00000b6a] 588f                      addq.l     #4,a7
[00000b6c] 2e8d                      move.l     a5,(a7)
[00000b6e] 2f0d                      move.l     a5,-(a7)
[00000b70] 4eb9 0000 0e90            jsr        _strlen
[00000b76] 588f                      addq.l     #4,a7
[00000b78] 7c0a                      moveq.l    #10,d6
[00000b7a] 9c87                      sub.l      d7,d6
[00000b7c] 486e ff00                 pea.l      -256(a6)
[00000b80] dd97                      add.l      d6,(a7)
[00000b82] 2245                      movea.l    d5,a1
[00000b84] 4e91                      jsr        (a1)
[00000b86] 588f                      addq.l     #4,a7
[00000b88] 0c13 002a                 cmpi.b     #$2A,(a3)
[00000b8c] 6706                      beq.s      xb38_1
[00000b8e] 0c13 002b                 cmpi.b     #$2B,(a3)
[00000b92] 665c                      bne.s      xb38_2
xb38_1:
[00000b94] 486b 0001                 pea.l      1(a3)
[00000b98] 486e ff80                 pea.l      -128(a6)
[00000b9c] 2245                      movea.l    d5,a1
[00000b9e] 4e91                      jsr        (a1)
[00000ba0] 508f                      addq.l     #8,a7
[00000ba2] 2eb9 0000 1814            move.l     $000029A2,(a7) spaces
[00000ba8] 486e ff80                 pea.l      -128(a6) "| "
[00000bac] 4eb9 0000 0e1c            jsr        _strcat
[00000bb2] 588f                      addq.l     #4,a7
[00000bb4] 422e ff9f                 clr.b      -97(a6)
[00000bb8] 2ebc 0000 1840            move.l     #$000029CE,(a7) "| "
[00000bbe] 4e94                      jsr        (a4)
[00000bc0] 486e ff80                 pea.l      -128(a6)
[00000bc4] 4e94                      jsr        (a4)
[00000bc6] 588f                      addq.l     #4,a7
[00000bc8] 2ebc 0000 1843            move.l     #$000029D1,(a7) "| "
[00000bce] 4e94                      jsr        (a4)
[00000bd0] 486e ff00                 pea.l      -256(a6)
[00000bd4] 4e94                      jsr        (a4)
[00000bd6] 588f                      addq.l     #4,a7
[00000bd8] 2ebc 0000 1846            move.l     #$000029D4,(a7) " |"
[00000bde] 4e94                      jsr        (a4)
[00000be0] 0c13 002a                 cmpi.b     #$2A,(a3)
[00000be4] 6616                      bne.s      xb38_3
[00000be6] 2ebc 0000 1849            move.l     #$000029D7,(a7) "                         |\n"
[00000bec] 4e94                      jsr        (a4)
[00000bee] 600c                      bra.s      xb38_3
xb38_2:
[00000bf0] 2e8b                      move.l     a3,(a7)
[00000bf2] 4e94                      jsr        (a4)
[00000bf4] 486e ff00                 pea.l      -256(a6)
[00000bf8] 4e94                      jsr        (a4)
[00000bfa] 588f                      addq.l     #4,a7
xb38_3:
[00000bfc] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[00000c00] 4e5e                      unlk       a6
[00000c02] 4e75                      rts

print_id:
[00000c04] 4e56 fff8                 link       a6,#-8
[00000c08] 48e7 9c04                 movem.l    d0/d3-d5/a5,-(a7)
[00000c0c] 2a6e 000c                 movea.l    12(a6),a5
[00000c10] 2eae 0008                 move.l     8(a6),(a7)
[00000c14] 4eb9 0000 0cb2            jsr        print_str
[00000c1a] 7600                      moveq.l    #0,d3
[00000c1c] 161d                      move.b     (a5)+,d3
[00000c1e] 7e7f                      moveq.l    #127,d7
[00000c20] ce83                      and.l      d3,d7
[00000c22] 1607                      move.b     d7,d3
[00000c24] 0c03 0020                 cmpi.b     #$20,d3
[00000c28] 6506                      bcs.s      xc04_1
[00000c2a] 0c03 007f                 cmpi.b     #$7F,d3
[00000c2e] 6602                      bne.s      xc04_2
xc04_1:
[00000c30] 7620                      moveq.l    #32,d3
xc04_2:
[00000c32] 7800                      moveq.l    #0,d4
[00000c34] 181d                      move.b     (a5)+,d4
[00000c36] 7e7f                      moveq.l    #127,d7
[00000c38] ce84                      and.l      d4,d7
[00000c3a] 1807                      move.b     d7,d4
[00000c3c] 0c04 0020                 cmpi.b     #$20,d4
[00000c40] 6506                      bcs.s      xc04_3
[00000c42] 0c04 007f                 cmpi.b     #$7F,d4
[00000c46] 6602                      bne.s      xc04_4
xc04_3:
[00000c48] 7820                      moveq.l    #32,d4
xc04_4:
[00000c4a] 7a00                      moveq.l    #0,d5
[00000c4c] 1a15                      move.b     (a5),d5
[00000c4e] 7e7f                      moveq.l    #127,d7
[00000c50] ce85                      and.l      d5,d7
[00000c52] 1a07                      move.b     d7,d5
[00000c54] 0c05 0020                 cmpi.b     #$20,d5
[00000c58] 6506                      bcs.s      xc04_5
[00000c5a] 0c05 007f                 cmpi.b     #$7F,d5
[00000c5e] 6602                      bne.s      xc04_6
xc04_5:
[00000c60] 7a20                      moveq.l    #32,d5
xc04_6:
[00000c62] 0c03 0020                 cmpi.b     #$20,d3
[00000c66] 661a                      bne.s      xc04_7
[00000c68] 0c04 0020                 cmpi.b     #$20,d4
[00000c6c] 6614                      bne.s      xc04_7
[00000c6e] 0c05 0020                 cmpi.b     #$20,d5
[00000c72] 660e                      bne.s      xc04_7
[00000c74] 2ebc 0000 1865            move.l     #$000029F3,(a7) "    (none)"
[00000c7a] 4eb9 0000 0cb2            jsr        print_str
[00000c80] 6028                      bra.s      xc04_8
xc04_7:
[00000c82] 1d43 fff9                 move.b     d3,-7(a6)
[00000c86] 1d44 fffa                 move.b     d4,-6(a6)
[00000c8a] 1d45 fffb                 move.b     d5,-5(a6)
[00000c8e] 422e fffc                 clr.b      -4(a6)
[00000c92] 2ebc 0000 1870            move.l     #$000029FE,(a7) "       "
[00000c98] 4eb9 0000 0cb2            jsr        print_str
[00000c9e] 486e fff9                 pea.l      -7(a6)
[00000ca2] 4eb9 0000 0cb2            jsr        print_str
[00000ca8] 588f                      addq.l     #4,a7
xc04_8:
[00000caa] 4cdf 2039                 movem.l    (a7)+,d0/d3-d5/a5
[00000cae] 4e5e                      unlk       a6
[00000cb0] 4e75                      rts

print_str:
[00000cb2] 4e56 fffc                 link       a6,#-4
[00000cb6] 2eae 0008                 move.l     8(a6),(a7)
[00000cba] 4eb9 0000 0e90            jsr        _strlen
[00000cc0] 2e87                      move.l     d7,(a7)
[00000cc2] 2f2e 0008                 move.l     8(a6),-(a7)
[00000cc6] 4878 0001                 pea.l      ($00000001).w
[00000cca] 4eb9 0000 0d84            jsr        _write
[00000cd0] 508f                      addq.l     #8,a7
[00000cd2] 4e5e                      unlk       a6
[00000cd4] 4e75                      rts

ltoa:
[00000cd6] 4e56 fffc                 link       a6,#-4
[00000cda] 2ebc 0000 18e0            move.l     #$00002A6E,(a7)
[00000ce0] 2f2e 0008                 move.l     8(a6),-(a7)
[00000ce4] 4eb9 0000 0cf6            jsr        ltoa_r
[00000cea] 588f                      addq.l     #4,a7
[00000cec] 2e3c 0000 18e0            move.l     #$00002A6E,d7
[00000cf2] 4e5e                      unlk       a6
[00000cf4] 4e75                      rts

ltoa_r:
[00000cf6] 4e56 0000                 link       a6,#0
[00000cfa] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00000cfe] 2a2e 0008                 move.l     8(a6),d5
[00000d02] 2a6e 000c                 movea.l    12(a6),a5
[00000d06] 2e85                      move.l     d5,(a7)
[00000d08] 4878 000a                 pea.l      ($0000000A).w
[00000d0c] 4eb9 0000 10c8            jsr        $000010C8
[00000d12] 2817                      move.l     (a7),d4
[00000d14] 670c                      beq.s      xcf6_1
[00000d16] 2e8d                      move.l     a5,(a7)
[00000d18] 2f04                      move.l     d4,-(a7)
[00000d1a] 4eba ffda                 jsr        ltoa_r(pc)
[00000d1e] 588f                      addq.l     #4,a7
[00000d20] 2a47                      movea.l    d7,a5
xcf6_1:
[00000d22] 2e85                      move.l     d5,(a7)
[00000d24] 4878 000a                 pea.l      ($0000000A).w
[00000d28] 4eb9 0000 10b6            jsr        a~lmod
[00000d2e] 7e30                      moveq.l    #48,d7
[00000d30] de97                      add.l      (a7),d7
[00000d32] 1ac7                      move.b     d7,(a5)+
[00000d34] 4215                      clr.b      (a5)
[00000d36] 2e0d                      move.l     a5,d7
[00000d38] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00000d3c] 4e5e                      unlk       a6
[00000d3e] 4e75                      rts

myatol:
[00000d40] 4e56 0000                 link       a6,#0
[00000d44] 48e7 0c04                 movem.l    d4-d5/a5,-(a7)
[00000d48] 2a6e 0008                 movea.l    8(a6),a5
[00000d4c] 7a00                      moveq.l    #0,d5
xd40_5:
[00000d4e] 4a15                      tst.b      (a5)
[00000d50] 6728                      beq.s      xd40_1
[00000d52] 0c15 0030                 cmpi.b     #$30,(a5)
[00000d56] 6506                      bcs.s      xd40_2
[00000d58] 0c15 0039                 cmpi.b     #$39,(a5)
[00000d5c] 6304                      bls.s      xd40_3
xd40_2:
[00000d5e] 7eff                      moveq.l    #-1,d7
[00000d60] 601a                      bra.s      xd40_4
xd40_3:
[00000d62] 2e05                      move.l     d5,d7
[00000d64] 2007                      move.l     d7,d0
[00000d66] e587                      asl.l      #2,d7
[00000d68] de80                      add.l      d0,d7
[00000d6a] de87                      add.l      d7,d7
[00000d6c] 7c00                      moveq.l    #0,d6
[00000d6e] 1c1d                      move.b     (a5)+,d6
[00000d70] 78d0                      moveq.l    #-48,d4
[00000d72] d886                      add.l      d6,d4
[00000d74] de84                      add.l      d4,d7
[00000d76] 2a07                      move.l     d7,d5
[00000d78] 60d4                      bra.s      xd40_5
xd40_1:
[00000d7a] 2e05                      move.l     d5,d7
xd40_4:
[00000d7c] 4cdf 2030                 movem.l    (a7)+,d4-d5/a5
[00000d80] 4e5e                      unlk       a6
[00000d82] 4e75                      rts

_write:
[00000d84] 205f                      movea.l    (a7)+,a0
[00000d86] 7e04                      moveq.l    #4,d7
[00000d88] 4e41                      trap       #1
[00000d8a] 6400 0008                 bcc.w      xd84_1
[00000d8e] 4ef9 0000 009a            jmp        $0000009A
xd84_1:
[00000d94] 4ed0                      jmp        (a0)

_open:
[00000d96] 205f                      movea.l    (a7)+,a0
[00000d98] 7e05                      moveq.l    #5,d7
[00000d9a] 4e41                      trap       #1
[00000d9c] 6400 0008                 bcc.w      xd84_2
[00000da0] 4ef9 0000 009a            jmp        $0000009A
xd84_2:
[00000da6] 4ed0                      jmp        (a0)

_read:
[00000da8] 205f                      movea.l    (a7)+,a0
[00000daa] 7e03                      moveq.l    #3,d7
[00000dac] 4e41                      trap       #1
[00000dae] 6400 0008                 bcc.w      xd84_3
[00000db2] 4ef9 0000 009a            jmp        $0000009A
xd84_3:
[00000db8] 4ed0                      jmp        (a0)

_close
[00000dba] 205f                      movea.l    (a7)+,a0
[00000dbc] 7e06                      moveq.l    #6,d7
[00000dbe] 4e41                      trap       #1
[00000dc0] 6400 0008                 bcc.w      xd84_4
[00000dc4] 4ef9 0000 009a            jmp        $0000009A
xd84_4:
[00000dca] 4ed0                      jmp        (a0)

__cstat:
[00000dcc] 33fc 000a 0000 1934       move.w     #$000A,$00002AC2
[00000dd4] 42b9 0000 19fc            clr.l      $00002B8A
[00000dda] 42b9 0000 1a00            clr.l      $00002B8E
[00000de0] 13fc 0061 0000 1a04       move.b     #$61,$00002B92
[00000de8] 4239 0000 1a05            clr.b      $00002B93
[00000dee] 4279 0000 1a06            clr.w      $00002B94
[00000df4] 4279 0000 1a08            clr.w      $00002B96
[00000dfa] 4279 0000 1a0a            clr.w      $00002B98
[00000e00] 33fc ffff 0000 1a0c       move.w     #$FFFF,$00002B9A
[00000e08] 4e75                      rts

__getenv:
[00000e0a] 4e56 fffc                 link       a6,#-4
[00000e0e] 2eae 0008                 move.l     8(a6),(a7)
[00000e12] 4eb9 0000 0f3c            jsr        _getenv
[00000e18] 4e5e                      unlk       a6
[00000e1a] 4e75                      rts

_strcat:
[00000e1c] 4e56 fffc                 link       a6,#-4
[00000e20] 48e7 001c                 movem.l    a3-a5,-(a7)
[00000e24] 2a6e 0008                 movea.l    8(a6),a5
[00000e28] 286e 000c                 movea.l    12(a6),a4
[00000e2c] 264d                      movea.l    a5,a3
xe1c_2:
[00000e2e] 4a15                      tst.b      (a5)
[00000e30] 6704                      beq.s      xe1c_1
[00000e32] 528d                      addq.l     #1,a5
[00000e34] 60f8                      bra.s      xe1c_2
xe1c_1:
[00000e36] 4a14                      tst.b      (a4)
[00000e38] 6704                      beq.s      xe1c_3
[00000e3a] 1adc                      move.b     (a4)+,(a5)+
[00000e3c] 60f8                      bra.s      xe1c_1
xe1c_3:
[00000e3e] 4215                      clr.b      (a5)
[00000e40] 2e0b                      move.l     a3,d7
[00000e42] 4cdf 3800                 movem.l    (a7)+,a3-a5
[00000e46] 4e5e                      unlk       a6
[00000e48] 4e75                      rts

__astat:
[00000e4a] 23fc 0000 1a66 0000 1a0e  move.l     #$00002BF4,$00002B9C
[00000e54] 23fc 0000 1a82 0000 1a12  move.l     #$00002C10,$00002BA0
[00000e5e] 23fc 0000 1a9e 0000 1a16  move.l     #$00002C2C,$00002BA4
[00000e68] 4e75                      rts

_strcpy:
[00000e6a] 4e56 0000                 link       a6,#0
[00000e6e] 48e7 001c                 movem.l    a3-a5,-(a7)
[00000e72] 2a6e 0008                 movea.l    8(a6),a5
[00000e76] 286e 000c                 movea.l    12(a6),a4
[00000e7a] 264d                      movea.l    a5,a3
xe6a_2:
[00000e7c] 4a14                      tst.b      (a4)
[00000e7e] 6704                      beq.s      xe6a_1
[00000e80] 1adc                      move.b     (a4)+,(a5)+
[00000e82] 60f8                      bra.s      xe6a_2
xe6a_1:
[00000e84] 4215                      clr.b      (a5)
[00000e86] 2e0b                      move.l     a3,d7
[00000e88] 4cdf 3800                 movem.l    (a7)+,a3-a5
[00000e8c] 4e5e                      unlk       a6
[00000e8e] 4e75                      rts

_strlen:
[00000e90] 4e56 0000                 link       a6,#0
[00000e94] 48e7 000c                 movem.l    a4-a5,-(a7)
[00000e98] 2a6e 0008                 movea.l    8(a6),a5
[00000e9c] 284d                      movea.l    a5,a4
xe90_2:
[00000e9e] 4a14                      tst.b      (a4)
[00000ea0] 6704                      beq.s      xe90_1
[00000ea2] 528c                      addq.l     #1,a4
[00000ea4] 60f8                      bra.s      xe90_2
xe90_1:
[00000ea6] 2e0c                      move.l     a4,d7
[00000ea8] 9e8d                      sub.l      a5,d7
[00000eaa] 4cdf 3000                 movem.l    (a7)+,a4-a5
[00000eae] 4e5e                      unlk       a6
[00000eb0] 4e75                      rts

__main:
[00000eb2] 4e56 0000                 link       a6,#0
[00000eb6] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00000eba] 2a2e 0008                 move.l     8(a6),d5
[00000ebe] 2e05                      move.l     d5,d7
[00000ec0] 5287                      addq.l     #1,d7
[00000ec2] e587                      asl.l      #2,d7
[00000ec4] 49f6 780c                 lea.l      12(a6,d7.l),a4
[00000ec8] 23cc 0000 1a1a            move.l     a4,$00002BA8
[00000ece] 4a85                      tst.l      d5
[00000ed0] 6728                      beq.s      xeb2_1
[00000ed2] 23ee 000c 0000 18d6       move.l     12(a6),$00002A64
[00000eda] 2a6e 000c                 movea.l    12(a6),a5
xeb2_3:
[00000ede] 4a15                      tst.b      (a5)
[00000ee0] 6718                      beq.s      xeb2_1
[00000ee2] 0c15 003a                 cmpi.b     #$3A,(a5)
[00000ee6] 670a                      beq.s      xeb2_2
[00000ee8] 0c15 007c                 cmpi.b     #$7C,(a5)
[00000eec] 6704                      beq.s      xeb2_2
[00000eee] 528d                      addq.l     #1,a5
[00000ef0] 60ec                      bra.s      xeb2_3
xeb2_2:
[00000ef2] 421d                      clr.b      (a5)+
[00000ef4] 23cd 0000 187e            move.l     a5,$00002A0C
xeb2_1:
[00000efa] 2ebc 0000 1878            move.l     #$00002A06,(a7)
[00000f00] 4eb9 0000 0f3c            jsr        _getenv
[00000f06] 2a47                      movea.l    d7,a5
[00000f08] 2e0d                      move.l     a5,d7
[00000f0a] 6706                      beq.s      xeb2_4
[00000f0c] 23cd 0000 187e            move.l     a5,$00002A0C
xeb2_4:
[00000f12] 2e8c                      move.l     a4,(a7)
[00000f14] 486e 000c                 pea.l      12(a6)
[00000f18] 2f05                      move.l     d5,-(a7)
[00000f1a] 4eb9 0000 00a6            jsr        $000000A6
[00000f20] 508f                      addq.l     #8,a7
[00000f22] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00000f26] 4e5e                      unlk       a6
[00000f28] 4e75                      rts

xf2a:
[00000f2a] 205f                      movea.l    (a7)+,a0
[00000f2c] 7e30                      moveq.l    #48,d7
[00000f2e] 4e41                      trap       #1
[00000f30] 6400 0008                 bcc.w      xf2a_1
[00000f34] 4ef9 0000 009a            jmp        $0000009A
xf2a_1:
[00000f3a] 4ed0                      jmp        (a0)

_getenv:
[00000f3c] 4e56 0000                 link       a6,#0
[00000f40] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00000f44] 2a6e 0008                 movea.l    8(a6),a5
[00000f48] 2e8d                      move.l     a5,(a7)
[00000f4a] 4eb9 0000 0f94            jsr        $00000F94
[00000f50] 2a07                      move.l     d7,d5
[00000f52] 2879 0000 1a1a            movea.l    $00002BA8,a4
xf2a_5:
[00000f58] 2e0c                      move.l     a4,d7
[00000f5a] 672e                      beq.s      xf2a_2
[00000f5c] 4a94                      tst.l      (a4)
[00000f5e] 672a                      beq.s      xf2a_2
[00000f60] 2e85                      move.l     d5,(a7)
[00000f62] 2f14                      move.l     (a4),-(a7)
[00000f64] 2f0d                      move.l     a5,-(a7)
[00000f66] 4eb9 0000 0fa6            jsr        $00000FA6
[00000f6c] 508f                      addq.l     #8,a7
[00000f6e] 4a87                      tst.l      d7
[00000f70] 6714                      beq.s      xf2a_3
[00000f72] 2254                      movea.l    (a4),a1
[00000f74] 0c31 003d 5800            cmpi.b     #$3D,0(a1,d5.l)
[00000f7a] 660a                      bne.s      xf2a_3
[00000f7c] 2254                      movea.l    (a4),a1
[00000f7e] d3c5                      adda.l     d5,a1
[00000f80] 5289                      addq.l     #1,a1
[00000f82] 2e09                      move.l     a1,d7
[00000f84] 6006                      bra.s      xf2a_4
xf2a_3:
[00000f86] 588c                      addq.l     #4,a4
[00000f88] 60ce                      bra.s      xf2a_5
xf2a_2:
[00000f8a] 7e00                      moveq.l    #0,d7
xf2a_4:
[00000f8c] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00000f90] 4e5e                      unlk       a6
[00000f92] 4e75                      rts

xf94:
[00000f94] 206f 0004                 movea.l    4(a7),a0
xf94_1:
[00000f98] 4a18                      tst.b      (a0)+
[00000f9a] 66fc                      bne.s      xf94_1
[00000f9c] 2e08                      move.l     a0,d7
[00000f9e] 9eaf 0004                 sub.l      4(a7),d7
[00000fa2] 5387                      subq.l     #1,d7
[00000fa4] 4e75                      rts

xfa6:
[00000fa6] 202f 000c                 move.l     12(a7),d0
[00000faa] 671a                      beq.s      xfa6_1
[00000fac] 2200                      move.l     d0,d1
[00000fae] 4840                      swap       d0
[00000fb0] 5341                      subq.w     #1,d1
[00000fb2] 206f 0004                 movea.l    4(a7),a0
[00000fb6] 246f 0008                 movea.l    8(a7),a2
xfa6_2:
[00000fba] b508                      cmpm.b     (a0)+,(a2)+
[00000fbc] 56c9 fffc                 dbne       d1,xfa6_2
[00000fc0] 56c8 fff8                 dbne       d0,xfa6_2
[00000fc4] 6604                      bne.s      xfa6_3
xfa6_1:
[00000fc6] 7e01                      moveq.l    #1,d7
[00000fc8] 4e75                      rts
xfa6_3:
[00000fca] 7e00                      moveq.l    #0,d7
[00000fcc] 4e75                      rts

__lstat:
[00000fce] 7005                      moveq.l    #5,d0
[00000fd0] 23c0 0000 1a26            move.l     d0,$00002BB4
[00000fd6] 7001                      moveq.l    #1,d0
[00000fd8] 23c0 0000 1a1e            move.l     d0,$00002BAC
[00000fde] 23fc 0000 18b2 0000 1a4a  move.l     #$00002A40,$00002BD8
[00000fe8] 23fc 0000 18bf 0000 1a4e  move.l     #$00002A4D,$00002BDC
[00000ff2] 23fc 0000 18c9 0000 1a52  move.l     #$00002A57,$00002BE0
[00000ffc] 7001                      moveq.l    #1,d0
[00000ffe] 23c0 0000 1a56            move.l     d0,$00002BE4
[00001004] 23fc 0000 1a9e 0000 1a5a  move.l     #$00002C2C,$00002BE8
[0000100e] 42b9 0000 1a66            clr.l      $00002BF4
[00001014] 33fc 0002 0000 1a6a       move.w     #$0002,$00002BF8
[0000101c] 33fc 0208 0000 1a6c       move.w     #$0208,$00002BFA
[00001024] 42b9 0000 1a6e            clr.l      $00002BFC
[0000102a] 23fc 0000 0200 0000 1a72  move.l     #$00000200,$00002C00
[00001034] 42b9 0000 1a76            clr.l      $00002C04
[0000103a] 42b9 0000 1a7a            clr.l      $00002C08
[00001040] 42b9 0000 1a7e            clr.l      $00002C0C
[00001046] 42b9 0000 1a82            clr.l      $00002C10
[0000104c] 4279 0000 1a86            clr.w      $00002C14
[00001052] 33fc 0004 0000 1a88       move.w     #$0004,$00002C16
[0000105a] 42b9 0000 1a8a            clr.l      $00002C18
[00001060] 23fc 0000 0200 0000 1a8e  move.l     #$00000200,$00002C1C
[0000106a] 42b9 0000 1a92            clr.l      $00002C20
[00001070] 42b9 0000 1a96            clr.l      $00002C24
[00001076] 42b9 0000 1a9a            clr.l      $00002C28
[0000107c] 42b9 0000 1a9e            clr.l      $00002C2C
[00001082] 33fc 0001 0000 1aa2       move.w     #$0001,$00002C30
[0000108a] 33fc 0008 0000 1aa4       move.w     #$0008,$00002C32
[00001092] 42b9 0000 1aa6            clr.l      $00002C34
[00001098] 23fc 0000 0200 0000 1aaa  move.l     #$00000200,$00002C38
[000010a2] 42b9 0000 1aae            clr.l      $00002C3C
[000010a8] 42b9 0000 1ab2            clr.l      $00002C40
[000010ae] 42b9 0000 1ab6            clr.l      $00002C44
[000010b4] 4e75                      rts

a~lmod:
[000010b6] 48e7 7800                 movem.l    d1-d4,-(a7)
[000010ba] 383c ff00                 move.w     #$FF00,d4
[000010be] 222f 0014                 move.l     20(a7),d1
[000010c2] 6c14                      bge.s      x10b6_1
[000010c4] 4481                      neg.l      d1
[000010c6] 6010                      bra.s      x10b6_1

a~ldiv:
[000010c8] 48e7 7800                 movem.l    d1-d4,-(a7)
[000010cc] 4244                      clr.w      d4
[000010ce] 222f 0014                 move.l     20(a7),d1
[000010d2] 6c04                      bge.s      x10b6_1
[000010d4] 4481                      neg.l      d1
[000010d6] 4604                      not.b      d4
x10b6_1:
[000010d8] 202f 0018                 move.l     24(a7),d0
[000010dc] 6c04                      bge.s      x10b6_2
[000010de] 4480                      neg.l      d0
[000010e0] 4604                      not.b      d4
x10b6_2:
[000010e2] 614e                      bsr.s      $00001132
[000010e4] 4a44                      tst.w      d4
[000010e6] 6c02                      bge.s      x10b6_3
[000010e8] 2002                      move.l     d2,d0
x10b6_3:
[000010ea] 4a04                      tst.b      d4
[000010ec] 6702                      beq.s      x10b6_4
[000010ee] 4480                      neg.l      d0
x10b6_4:
[000010f0] 4cdf 001e                 movem.l    (a7)+,d1-d4
[000010f4] 2e9f                      move.l     (a7)+,(a7)
[000010f6] 2f40 0004                 move.l     d0,4(a7)
[000010fa] 4e75                      rts

x10fc:
[000010fc] 48e7 7800                 movem.l    d1-d4,-(a7)
[00001100] 222f 0014                 move.l     20(a7),d1
[00001104] 202f 0018                 move.l     24(a7),d0
[00001108] 6128                      bsr.s      $00001132
[0000110a] 2002                      move.l     d2,d0
[0000110c] 4cdf 001e                 movem.l    (a7)+,d1-d4
[00001110] 2e9f                      move.l     (a7)+,(a7)
[00001112] 2f40 0004                 move.l     d0,4(a7)
[00001116] 4e75                      rts

x1118:
[00001118] 48e7 7800                 movem.l    d1-d4,-(a7)
[0000111c] 222f 0014                 move.l     20(a7),d1
[00001120] 202f 0018                 move.l     24(a7),d0
[00001124] 610c                      bsr.s      $00001132
[00001126] 4cdf 001e                 movem.l    (a7)+,d1-d4
[0000112a] 2e9f                      move.l     (a7)+,(a7)
[0000112c] 2f40 0004                 move.l     d0,4(a7)
[00001130] 4e75                      rts

x1132:
[00001132] 7400                      moveq.l    #0,d2
[00001134] 4841                      swap       d1
[00001136] 6608                      bne.s      x1132_1
[00001138] 70ff                      moveq.l    #-1,d0
[0000113a] 74ff                      moveq.l    #-1,d2
[0000113c] 7800                      moveq.l    #0,d4
[0000113e] 4e75                      rts
x1132_1:
[00001140] 4a41                      tst.w      d1
[00001142] 662a                      bne.s      x1132_2
[00001144] b081                      cmp.l      d1,d0
[00001146] 640e                      bcc.s      x1132_3
[00001148] 4841                      swap       d1
[0000114a] 80c1                      divu.w     d1,d0
[0000114c] 4840                      swap       d0
[0000114e] 3400                      move.w     d0,d2
[00001150] 4240                      clr.w      d0
[00001152] 4840                      swap       d0
[00001154] 4e75                      rts
x1132_3:
[00001156] 4841                      swap       d1
[00001158] 4840                      swap       d0
[0000115a] 3400                      move.w     d0,d2
[0000115c] 84c1                      divu.w     d1,d2
[0000115e] 3002                      move.w     d2,d0
[00001160] 4840                      swap       d0
[00001162] 3400                      move.w     d0,d2
[00001164] 84c1                      divu.w     d1,d2
[00001166] 3002                      move.w     d2,d0
[00001168] 4242                      clr.w      d2
[0000116a] 4842                      swap       d2
[0000116c] 4e75                      rts
x1132_2:
[0000116e] 4841                      swap       d1
[00001170] 4840                      swap       d0
[00001172] 3400                      move.w     d0,d2
[00001174] 4240                      clr.w      d0
[00001176] 4840                      swap       d0
[00001178] 760f                      moveq.l    #15,d3
x1132_5:
[0000117a] d040                      add.w      d0,d0
[0000117c] d582                      addx.l     d2,d2
[0000117e] b481                      cmp.l      d1,d2
[00001180] 6504                      bcs.s      x1132_4
[00001182] 9481                      sub.l      d1,d2
[00001184] 5240                      addq.w     #1,d0
x1132_4:
[00001186] 51cb fff2                 dbf        d3,x1132_5
[0000118a] 4e75                      rts

x118c:
[0000118c] 4afc                      illegal

	.data
[0000118e] [0000231c]                           dc.b $00
[0000118f] [0000231d]                           dc.b 'IDR68K Edition 3.2: Copyright (c) 1981, 1983, 1986, 1987 by Whitesmiths, Ltd. all rights reserved',0
[000011f1] [0000237f]                           dc.b $00
[000011f2] [00002380]                           dc.b $00
[000011f3] [00002381]                           dc.b $00
[000011f4] [00002382]                           dc.b $00
[000011f5] [00002383]                           dc.b $00
[000011f6] [00002384] 00000068                  dc.l $00000068
[000011fa] [00002388] 000011fe                  dc.l $0000238c
[000011fe] [0000238c]                           dc.b '<<show0.c: Version 1.01 March 20, 1988>>',0
[00001227] [000023b5]                           dc.b $00
[00001228] [000023b6] 0000122c                  dc.l $000023ba
[0000122c] [000023ba]                           dc.b '<<Copyright (C) 1986-1988 by Computer Tools International Inc.>>',0
[0000126d] [000023fb]                           dc.b $00
[0000126e] [000023fc] 00001272                  dc.l $00002400
[00001272] [00002400]                           dc.b '    show0: Version 1.01  |',$0a,0
[0000128e] [0000241c] 00001292                  dc.l $00002420
[00001292] [00002420]                           dc.b '       March 20, 1988    |',$0a,0
[000012ae] [0000243c] 000012b2                  dc.l $00002440
[000012b2] [00002440]                           dc.b '  Copyright (C) 1987 by  |',$0a,0
[000012ce] [0000245c] 000012d2                  dc.l $00002460
[000012d2] [00002460]                           dc.b '   (C)omputer            |',$0a,0
[000012ee] [0000247c] 000012f2                  dc.l $00002480
[000012f2] [00002480]                           dc.b '     (T)ools             |',$0a,0
[0000130e] [0000249c] 00001312                  dc.l $000024a0
[00001312] [000024a0]                           dc.b '       (I)nternational   |',$0a,0
reboot_msg:
[0000132e] [000024bc] 00001332                  dc.l $000024c0
[00001332] [000024c0]                           dc.b '<<-- the system must be rebooted for the changes to have any effect! -->>',$0a,0
[0000137d] [0000250b]                           dc.b '/dev/hdisk/hd003_all',0
[00001392] [00002520]                           dc.b '/dev/hdisk/hd004_all',0
[000013a7] [00002535]                           dc.b '/dev/hdisk/hd005_all',0
[000013bc] [0000254a]                           dc.b '/dev/hdisk/hd006_all',0
root_device:
[000013d1] [0000255f]                           dc.b '/dev/hdisk/hd007',0
partition_names:
[000013e2] [00002570] 0000137d                  dc.l $0000250b
[000013e6] [00002574] 00001392                  dc.l $00002520
[000013ea] [00002578] 000013a7                  dc.l $00002535
[000013ee] [0000257c] 000013bc                  dc.l $0000254a
[000013f2] [00002580]                           dc.b '| Partition number  | (hd003)  0 | (hd004)  1 | (hd005)  2 | (hd006)  3 |',$0a,0
[0000143d] [000025cb]                           dc.b 'usage: ',0
[00001445] [000025d3]                           dc.b ' [partition name [reserved]]',$0a,0
[00001463] [000025f1]                           dc.b 'Invalid arguments specified!',$0a,0
[00001481] [0000260f]                           dc.b 'HARDDRIVE',0
[0000148b] [00002619]                           dc.b 'Invalid ',$27,'HARDDRIVE',$27,' in environment!',$0a,0
[000014b0] [0000263e]                           dc.w $0a00
[000014b2] [00002640]                           dc.b 'inactive partition specified!',$0a,0
[000014d1] [0000265f]                           dc.b 'specified offset too large!',$0a,0
[000014ee] [0000267c]                           dc.b 'Unable to open <',0
[000014ff] [0000268d]                           dc.b '> for reading!',$0a,0
[0000150f] [0000269d]                           dc.b 'Error reading block <0> of <',0
[0000152c] [000026ba]                           dc.b '>!',$0a,0
[00001530] [000026be]                           dc.b 'Unable to open <',0
[00001541] [000026cf]                           dc.b '> for writing!',$0a,0
[00001551] [000026df]                           dc.b 'Error writing block <0> of <',0
[0000156e] [000026fc]                           dc.b '>!',$0a,0
header_line:
[00001572] [00002700] 00001576                  dc.l $00002704
[00001576] [00002704]                           dc.b '+-------------------+------------+------------+------------+------------+',$0a,0
[000015c1] [0000274f]                           dc.b $0a,'+--------------------------------+------------+-------------------------+',$0a,0
[0000160d] [0000279b]                           dc.b '*Number of cylinders',0
[00001622] [000027b0]                           dc.b '+Number of heads',0
[00001633] [000027c1]                           dc.b '*(unused)',0
[0000163d] [000027cb]                           dc.b '+Reduced write current cylinder',0
[0000165d] [000027eb]                           dc.b '*Write-precompensation cylinder',0
[0000167d] [0000280b]                           dc.b '+Landing zone',0
[0000168b] [00002819]                           dc.b '*Seek rate code',0
[0000169b] [00002829]                           dc.b '+Interleave factor',0
[000016ae] [0000283c]                           dc.b '*Number of sectors per track',0
[000016cb] [00002859]                           dc.b '+Total 512-byte blocks',0
[000016e2] [00002870]                           dc.b '*Start of bad-sector list',0
[000016fc] [0000288a]                           dc.b '+Number of bad-sectors',0
[00001713] [000028a1]                           dc.b '*Block checksum',0
[00001723] [000028b1]                           dc.b '| Flag byte         |',0
[00001739] [000028c7]                           dc.b $20
[0000173a] [000028c8]                           dc.b $00
[0000173b] [000028c9]                           dc.b ' | ',0
[0000173f] [000028cd]                           dc.b ' | ',0
[00001743] [000028d1]                           dc.b ' | ',0
[00001747] [000028d5]                           dc.b ' |',$0a,0
[0000174b] [000028d9]                           dc.b '| Id string         |',0
[00001761] [000028ef]                           dc.b $20
[00001762] [000028f0]                           dc.b $00
[00001763] [000028f1]                           dc.b ' | ',0
[00001767] [000028f5]                           dc.b ' | ',0
[0000176b] [000028f9]                           dc.b ' | ',0
[0000176f] [000028fd]                           dc.b ' |',$0a,0
[00001773] [00002901]                           dc.b '| Starting block    |',0
[00001789] [00002917]                           dc.b $20
[0000178a] [00002918]                           dc.b $00
[0000178b] [00002919]                           dc.b ' | ',0
[0000178f] [0000291d]                           dc.b ' | ',0
[00001793] [00002921]                           dc.b ' | ',0
[00001797] [00002925]                           dc.b ' |',$0a,0
[0000179b] [00002929]                           dc.b '| Partition size    |',0
[000017b1] [0000293f]                           dc.b $20
[000017b2] [00002940]                           dc.b $00
[000017b3] [00002941]                           dc.b ' | ',0
[000017b7] [00002945]                           dc.b ' | ',0
[000017bb] [00002949]                           dc.b ' | ',0
[000017bf] [0000294d]                           dc.b ' |',$0a,0
[000017c3] [00002951]                           dc.b '| Reserved blocks   |',0
[000017d9] [00002967]                           dc.b $20
[000017da] [00002968]                           dc.b $00
[000017db] [00002969]                           dc.b ' | ',0
[000017df] [0000296d]                           dc.b ' | ',0
[000017e3] [00002971]                           dc.b ' | ',0
[000017e7] [00002975]                           dc.b ' |',$0a,0
[000017eb] [00002979]                           dc.b '| Size for ',$27,'mkfs',$27,'   |',0
[00001801] [0000298f]                           dc.b $20
[00001802] [00002990]                           dc.b $00
[00001803] [00002991]                           dc.b ' | ',0
[00001807] [00002995]                           dc.b ' | ',0
[0000180b] [00002999]                           dc.b ' | ',0
[0000180f] [0000299d]                           dc.b ' |',$0a,0
[00001813] [000029a1]                           dc.b $00
[00001814] [000029a2] 00001818                  dc.l $000029a6
[00001818] [000029a6]                           dc.b '                                       ',0
[00001840] [000029ce]                           dc.w $7c20
[00001842] [000029d0]                           dc.b $00
[00001843] [000029d1]                           dc.b $7c
[00001844] [000029d2]                           dc.w $2000
[00001846] [000029d4]                           dc.w $207c
[00001848] [000029d6]                           dc.b $00
[00001849] [000029d7]                           dc.b '                         |',$0a,0
[00001865] [000029f3]                           dc.b '    (none)',0
[00001870] [000029fe]                           dc.b '       ',0
[00001878] [00002a06]                           dc.b 'PATH',0
[0000187d] [00002a0b]                           dc.b $00
[0000187e] [00002a0c] 00001882                  dc.l $00002a10
[00001882] [00002a10]                           dc.b '|/bin/|/usr/bin/|/etc/bin/',0
[0000189d] [00002a2b]                           dc.b $00
[0000189e] [00002a2c]                           dc.b 'EDT',0
[000018a2] [00002a30]                           dc.b 'EST',0
[000018a6] [00002a34]                           dc.w $545a
[000018a8] [00002a36]                           dc.b $00
[000018a9] [00002a37]                           dc.b $00
[000018aa] [00002a38] 0000189e                  dc.l $00002a2c
[000018ae] [00002a3c] 000018a2                  dc.l $00002a30
[000018b2] [00002a40]                           dc.b 'domain error',0
[000018bf] [00002a4d]                           dc.b 'no memory',0
[000018c9] [00002a57]                           dc.b 'range error',0
[000018d5] [00002a63]                           dc.b $00
[000018d6] [00002a64] 000018da                  dc.l $00002a68
[000018da] [00002a68]                           dc.b 'error',0

2a8e part_size[4]
2a9e start_sec[4]
2aae active_flag[4]

; a.out Relocations:
00000006: 0000118e
00000012: 0000118e
00000018: 00000000
0000001e: 00000000
00000024: 00000000
0000002a: 00000000
00000036: 00000000
0000003e: 00000000
00000046: 00000000
0000004c: 0000118e
00000052: 00000000
0000006a: 0000118e
00000072: 0000118e
0000009e: 0000118e
000000ce: 0000118e
000000d4: 00000000
000000e0: 00000000
000000e6: 0000118e
000000ec: 00000000
000000f6: 00000000
00000114: 00000000
0000014c: 00000000
000001ec: 00000000
00000204: 0000118e
0000020a: 00000000
00000214: 00000000
0000021c: 0000118e
00000222: 00000000
00000252: 0000118e
00000258: 00000000
00000262: 00000000
00000276: 0000118e
0000027e: 0000118e
00000286: 0000118e
0000028e: 0000118e
00000296: 0000118e
0000029e: 0000118e
000002a6: 0000118e
000002ae: 0000118e
000002b6: 0000118e
000002be: 0000118e
000002c6: 0000118e
000002ce: 0000118e
000002d6: 0000118e
000002de: 0000118e
000002e6: 0000118e
000002ee: 0000118e
000002f6: 0000118e
000002fe: 0000118e
00000304: 0000118e
0000030a: 00000000
00000314: 0000118e
0000031a: 00000000
00000342: 00000000
0000034e: 0000118e
0000035e: 00000000
0000036c: 0000118e
0000037c: 00000000
0000038a: 0000118e
000003a8: 0000118e
000003b2: 0000118e
000003b8: 00000000
000003c2: 00000000
000003da: 0000118e
000003e4: 0000118e
000003ea: 00000000
000003f4: 00000000
00000404: 00000000
00000420: 0000118e
00000428: 00000000
00000434: 00000000
00000446: 0000118e
0000044c: 00000000
00000454: 00000000
0000046a: 00000000
00000478: 00000000
00000484: 0000118e
00000490: 0000118e
0000049c: 00000000
000004ae: 00000000
000004c0: 0000118e
000004cc: 0000118e
000004d8: 00000000
000004e2: 00000000
000004f8: 00000000
00000508: 00000000
00000514: 0000118e
00000520: 0000118e
0000052c: 00000000
0000053e: 00000000
00000550: 0000118e
0000055c: 0000118e
00000568: 00000000
00000572: 00000000
00000588: 00000000
00000592: 0000118e
00000598: 00000000
0000059e: 0000118e
000005a4: 0000118e
000005aa: 0000118e
000005b6: 0000118e
000005bc: 00000000
000005c8: 0000118e
000005ce: 00000000
000005d6: 0000118e
000005e2: 0000118e
000005e8: 00000000
000005f4: 0000118e
000005fa: 00000000
00000602: 0000118e
0000060e: 0000118e
00000614: 00000000
00000620: 0000118e
00000626: 00000000
0000062e: 0000118e
0000063a: 0000118e
00000640: 00000000
0000064c: 0000118e
00000652: 00000000
0000065a: 0000118e
00000666: 0000118e
0000066c: 00000000
00000678: 0000118e
0000067e: 00000000
00000686: 0000118e
00000692: 0000118e
00000698: 00000000
000006a4: 0000118e
000006aa: 00000000
000006b2: 0000118e
000006be: 0000118e
000006c4: 00000000
000006cc: 0000118e
000006d4: 0000118e
000006dc: 0000118e
000006e6: 0000118e
000006f6: 0000118e
00000706: 0000118e
00000716: 0000118e
00000722: 0000118e
0000072a: 0000118e
00000736: 0000118e
0000073c: 00000000
00000748: 0000118e
0000074e: 00000000
0000075a: 0000118e
00000760: 00000000
0000076c: 0000118e
00000772: 00000000
0000077a: 0000118e
00000782: 0000118e
0000078e: 0000118e
000007a0: 0000118e
000007b2: 0000118e
000007c6: 0000118e
000007d2: 0000118e
000007da: 0000118e
000007e6: 0000118e
000007f8: 0000118e
0000080a: 0000118e
0000081e: 0000118e
0000082a: 0000118e
00000832: 0000118e
0000083a: 0000118e
00000842: 0000118e
00000848: 00000000
00000854: 0000118e
0000085e: 0000118e
00000864: 00000000
00000870: 0000118e
0000087a: 0000118e
00000880: 00000000
0000088c: 0000118e
00000896: 0000118e
0000089c: 00000000
000008a8: 0000118e
000008b0: 0000118e
000008c2: 0000118e
000008c8: 00000000
000008e0: 0000118e
000008e6: 00000000
000008fe: 0000118e
00000904: 00000000
0000091e: 0000118e
00000924: 00000000
0000092e: 0000118e
00000936: 0000118e
00000972: 0000118e
00000a76: 00000000
00000aa8: 00000000
00000aca: 00000000
00000b0c: 00000000
00000b2e: 00000000
00000b42: 00000000
00000b4c: 00000000
00000b56: 00000000
00000b5e: 0000118e
00000b72: 00000000
00000ba4: 0000118e
00000bae: 00000000
00000bba: 0000118e
00000bca: 0000118e
00000bda: 0000118e
00000be8: 0000118e
00000c16: 00000000
00000c76: 0000118e
00000c7c: 00000000
00000c94: 0000118e
00000c9a: 00000000
00000ca4: 00000000
00000cbc: 00000000
00000ccc: 00000000
00000cdc: 0000118e
00000ce6: 00000000
00000cee: 0000118e
00000d0e: 00000000
00000d2a: 00000000
00000d90: 00000000
00000da2: 00000000
00000db4: 00000000
00000dc6: 00000000
00000dd0: 0000118e
00000dd6: 0000118e
00000ddc: 0000118e
00000de4: 0000118e
00000dea: 0000118e
00000df0: 0000118e
00000df6: 0000118e
00000dfc: 0000118e
00000e04: 0000118e
00000e14: 00000000
00000e4c: 0000118e
00000e50: 0000118e
00000e56: 0000118e
00000e5a: 0000118e
00000e60: 0000118e
00000e64: 0000118e
00000eca: 0000118e
00000ed6: 0000118e
00000ef6: 0000118e
00000efc: 0000118e
00000f02: 00000000
00000f0e: 0000118e
00000f1c: 00000000
00000f36: 00000000
00000f4c: 00000000
00000f54: 0000118e
00000f68: 00000000
00000fd2: 0000118e
00000fda: 0000118e
00000fe0: 0000118e
00000fe4: 0000118e
00000fea: 0000118e
00000fee: 0000118e
00000ff4: 0000118e
00000ff8: 0000118e
00001000: 0000118e
00001006: 0000118e
0000100a: 0000118e
00001010: 0000118e
00001018: 0000118e
00001020: 0000118e
00001026: 0000118e
00001030: 0000118e
00001036: 0000118e
0000103c: 0000118e
00001042: 0000118e
00001048: 0000118e
0000104e: 0000118e
00001056: 0000118e
0000105c: 0000118e
00001066: 0000118e
0000106c: 0000118e
00001072: 0000118e
00001078: 0000118e
0000107e: 0000118e
00001086: 0000118e
0000108e: 0000118e
00001094: 0000118e
0000109e: 0000118e
000010a4: 0000118e
000010aa: 0000118e
000010b0: 0000118e
000011f6: 00000000
000011fa: 0000118e
00001228: 0000118e
0000126e: 0000118e
0000128e: 0000118e
000012ae: 0000118e
000012ce: 0000118e
000012ee: 0000118e
0000130e: 0000118e
0000132e: 0000118e
000013e2: 0000118e
000013e6: 0000118e
000013ea: 0000118e
000013ee: 0000118e
00001572: 0000118e
00001814: 0000118e
0000187e: 0000118e
000018aa: 0000118e
000018ae: 0000118e
000018d6: 0000118e
